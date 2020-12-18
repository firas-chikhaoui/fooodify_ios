/*
RESTFul Services by NodeJS
*/
var crypto = require('crypto');
var uuid = require('uuid');
 var express = require('express');
 var mysql = require ('mysql');
 var bodyParser = require('body-parser'); 
 
 
//Connect to mysQL 
var con = mysql.createConnection({
 host: 'localhost', // Replace your HOST IP 
 user: 'root', 
 password:'', 
 database: 'projet_android'
}); 


// PASSWORD ULTIL
var genRandomString = function(length){
    return crypto.randomBytes(Math.ceil(length/2))
    .toString('hex') /* convert to hexa format*/
    .slice(0,length);/* return required number of characters*/
};


var sha512 =  function (password,salt){
    var hash = crypto.createHmac('sha512',salt); //Use SHA512
    hash.update(password);
    var value = hash.digest('hex');
    
    return {
        salt:salt,
        passwordHash:value
    };
    
    
};


function saltHashPassword (userPassword){
    var salt = genRandomString(16);
    var passwordData = sha512(userPassword,salt );
    return passwordData;
}



var app= express();
 app.use(bodyParser.json()); // Accept JSON Params 
 app.use(bodyParser.urlencoded({extended: true})); // Accept URL Encoded params 
 
 
 app.post('/register/',(req,res,next)=>{
    
    var post_data = req.body; //Get POST params
    var uid = uuid.v4();
    var plaint_password = post_data.password;
    
    var hash_data = saltHashPassword(plaint_password);
    var password = hash_data.passwordHash;
    
    var salt = hash_data.salt;
    var name = post_data.name;
    var email = post_data.email;
    
    con.query ('SELECT * FROM user where email=?' , [email],function (err,result,fields){
        con.on('error',function(err){
            console.log('[MySQL ERROR]',err);
        });

    if(result && result.length)
    res.json('user already exists');

    else{

    
    con.query('INSERT INTO `user`(`unique_id`, `name`, `email`, `encrypted_password`, `salt`, `created_at`, `updated_at`) VALUES (?,?,?,?,?,NOW(),NOW())',[uid,name,email,password,salt], function(err,result,fields)
        {
            con.on('error',function(err){
                console.log('[MySQL ERROR]',err);
                res.json('Resgiter error: ', err);
            });
            res.json('Register successful');
        });
    }
    });

    
    
})

app.post('/checkNameEmail', function (req, res, next) {
    var data = [req.body.name,req.body.email];
    var query = 'SELECT * FROM users WHERE name = ? OR email = ? LIMIT 1';
    con.query(query, data, function (err, result) {
        if (err) {
            res.status(200).send(err)
        } else if (result && result.length && result[0]) {
            res.status(200).send(result[0])
        } else {
            res.status(404).send('not found')
        }
    })
});

app.post('/login/',(req,res,next)=>{
    
    var post_data = req.body; //Get POST params
    
    var user_password = post_data.password;
    var email = post_data.email;

    con.query ('SELECT * FROM user where email=?' , [email],function (err,result,fields){
        con.on('error',function(err){
            console.log('[MySQL ERROR]',err);
        });


        if(result && result.length)
    {
        var salt = result[0].salt;
        var encrypted_password = result[0].encrypted_password;

        var hashed_password = checkHashPassword(user_password,salt).passwordHash;

        if (encrypted_password == hashed_password)
            res.end(JSON.stringify(result[0]))
            else
            res.end(JSON.stringify('Wrong password'));
    }
    

    else
    {
        res.json('user not exists');

    }

    
    });

    
    
    
})



app.post('/login1/',(req,res,next)=>{
    
    var post_data = req.body; //Get POST params
    
    var password = post_data.password;
    var email = post_data.email;

    con.query ('SELECT * FROM t_user WHERE nickname = ? AND password = ?', [email, password],function (err,result,fields){
        con.on('error',function(err){
            console.log('[MySQL ERROR]',err);
        });

            res.end(JSON.stringify(result[0]))
    });
    
})

app.post('/register1/',(req,res,next)=>{
    
    var post_data = req.body; //Get POST params
    var name = post_data.name;
    var email = post_data.email;
    var password = post_data.password;
    
    con.query('INSERT INTO `users`(`name`, `email`, `password`) VALUES (?,?,?)',[name,email,password], function(err,result,fields)
        {
            con.on('error',function(err){
                console.log('[MySQL ERROR]',err);
                res.json('Resgiter error: ', err);
            });
            var jsonStr = [{STATE:"success"}];
            res.json(jsonStr);
        });
    });

    app.post('/register33/', function (req, res, next) {
        
        var data = [[req.body.name, req.body.email, req.body.password]];
        var query = 'INSERT INTO users (name,email,password) VALUES ?';
        con.query(query, [data], function (err, result) {
            if (err) {
                res.status(404).send(err)
            } else {
                res.status(200).send(result)
            }
        })
    });

    app.post('/login33/', function (req, res, next) {
        var data = [req.body.name, req.body.password];
        var query = 'SELECT * FROM users WHERE name = ? AND password = ? LIMIT 1';
        con.query(query, data, function (err, result) {
            if (err) {
                res.status(500).send(err)
            } else if (result && result.length && result[0]) {
                res.status(200).send(result[0])
            } else {
                res.status(404).send('not found')
            }
        })
    });


// Get all getAllCat
app.get('/getAllCat/', (req, res) => {
    con.query ('SELECT id,nom FROM categorie',function (err,result,fields){
        /*con.on('error',function(err){
            console.log('[MySQL ERROR]',err);
        });*/
        if (err)
        {
            res.json(err)
        }
        //res.json(result);
        else
        res.json(result)
    });
});

app.get('/getAllusers/', (req, res) => {
    con.query ('SELECT id,name FROM users',function (err,result,fields){
        /*con.on('error',function(err){
            console.log('[MySQL ERROR]',err);
        });*/
        if (err)
        {
            res.json(err)
        }
        //res.json(result);
        else
        res.json(result)
    });
});


// Get all getAllRest
app.get('/getAllRest/:userfavoris', (req, res) => {
    var userfavoris = req.params.userfavoris;
    con.query ('SELECT restaurant.id,nom,adresse,ifnull(avg(restau_rating.note),0) as rating,delivery,COUNT(DISTINCT(Select id_user from restau_fav WHERE restau_fav.id_restau=restaurant.id AND restau_fav.id_user=(SELECT id from t_user WHERE nickname= ?))) as favoris FROM restaurant left join restau_rating on restau_rating.id_restau=restaurant.id group by restaurant.id,nom,adresse,delivery',[userfavoris],function (err,result,fields){
        con.on('error',function(err){
            console.log('[MySQL ERROR]',err);
        });
        res.json(result);
    });
});


// Get all getAllRest_cat
app.get('/getAllRestwithCat/:value/:userfavoris', (req, res) => {
    var value = req.params.value;
    var userfavoris = req.params.userfavoris;
    con.query ('SELECT restaurant.id,nom,adresse,ifnull(avg(restau_rating.note),0) as rating ,delivery,COUNT(DISTINCT(Select id_user from restau_fav WHERE restau_fav.id_restau=restaurant.id AND restau_fav.id_user=(SELECT id from t_user WHERE nickname= ?))) as favoris FROM restaurant left join restau_rating on restau_rating.id_restau=restaurant.id WHERE restaurant.id IN ( SELECT id_restau FROM restau_cat WHERE id_cat IN ( SELECT id FROM categorie WHERE nom = ? )) group by  restaurant.id,nom,adresse,delivery', [userfavoris,value],function (err,result,fields){
        con.on('error',function(err){
            console.log('[MySQL ERROR]',err);
        });
        res.json(result);
    });
});

// Get all getAllRestWithId
app.get('/getRestwithId/:id/:user', (req, res) => {
    var id = req.params.id;
    var user = req.params.user;
    con.query ('SELECT restaurant.id,nom,adresse,ifnull(avg(restau_rating.note),0) as rating,delivery,COUNT(DISTINCT(Select id_user from restau_fav WHERE restau_fav.id_restau=restaurant.id AND restau_fav.id_user=(SELECT id from t_user WHERE nickname= ?))) as favoris FROM restaurant left join restau_rating on restau_rating.id_restau=restaurant.id WHERE restaurant.id=? group by restaurant.id,nom,adresse,delivery', [user,id],function (err,result,fields){
        con.on('error',function(err){
            console.log('[MySQL ERROR]',err);
        });
        res.json(result);
    });
});


// Get all getCountAvisWithId
app.get('/getCountAvisWithId/:id', (req, res) => {
    var id = req.params.id;
    con.query ('SELECT count(*) as total,id_restau as id FROM restau_rating WHERE id_restau=?', [id],function (err,result,fields){
        con.on('error',function(err){
            console.log('[MySQL ERROR]',err);
        });
        res.json(result);
    });
});

// Get all getAllRest_User
app.get('/getRestwithUser/:user', (req, res) => {
    var user = req.params.user;
    con.query ('SELECT restaurant.id,nom,adresse,ifnull(avg(restau_rating.note),0) as rating,delivery,COUNT(DISTINCT(Select id_user from restau_fav WHERE restau_fav.id_restau=restaurant.id AND restau_fav.id_user=(SELECT id from t_user WHERE nickname= ?))) as favoris FROM restaurant left join restau_rating on restau_rating.id_restau=restaurant.id WHERE restaurant.id IN ( SELECT id_restau FROM restau_fav WHERE id_user IN ( SELECT id FROM t_user WHERE nickname = ? )) group by  restaurant.id,nom,adresse,delivery', [user,user],function (err,result,fields){
        con.on('error',function(err){
            console.log('[MySQL ERROR]',err);
        });
        res.json(result);
    });
});


// Get all getAllRepas
app.get('/getAllRepaswithId/:id', (req, res) => {
    var id = req.params.id;
    con.query ('SELECT id,nom,description,prix,id_restau FROM repas WHERE id_restau = ?',[id],function (err,result,fields){
        con.on('error',function(err){
            console.log('[MySQL ERROR]',err);
        });
        res.json(result);
    });
});


// Get all getAllRepas
app.get('/getAllExtra/', (req, res) => {
    con.query ('SELECT id,nom,prix FROM extra',function (err,result,fields){
        con.on('error',function(err){
            console.log('[MySQL ERROR]',err);
        });
        res.json(result);
    });
});



// Get all getAllRepas_User
app.get('/getRepaswithUser/:user', (req, res) => {
    var user = req.params.user;
    con.query ('SELECT repas.id, repas.nom, repas.prix, restaurant.nom AS restaurant FROM repas JOIN restaurant ON repas.id_restau = restaurant.id WHERE repas.id IN ( SELECT id_repas FROM repas_fav WHERE id_user IN ( SELECT id FROM t_user WHERE nickname = ? ))', [user],function (err,result,fields){
        con.on('error',function(err){
            console.log('[MySQL ERROR]',err);
        });
        res.json(result);
    });
});



// Set all setRating_User_Restau
app.get('/setRatingUserRestau/:restau/:note/:user',(req,res,next)=>{
    
    var user = req.params.user;
    var restau = req.params.restau;
    var note = req.params.note;
    
    con.query('INSERT INTO `restau_rating`(`id_user`, `id_restau`, `note`) SELECT  t_user.id ,?,? FROM t_user where nickname=?',[restau,note,user], function(err,result,fields)
    {
        con.on('error',function(err){
            console.log('[MySQL ERROR]',err);
        });
        res.json(result);
    });
});

// Get all getAllInfoUser
app.get('/getAllInfoUser/:user', (req, res) => {
    var user = req.params.user;
    con.query ('SELECT phoneNum,password,nickname FROM t_user Where nickname = ?',[user],function (err,result,fields){
        con.on('error',function(err){
            console.log('[MySQL ERROR]',err);
        });
        res.json(result);
    });
});


    // Set all setFavorite_User_Restau
app.get('/setFavoriteUserRestau/:restau/:user',(req,res,next)=>{
    
    var user = req.params.user;
    var restau = req.params.restau;
    
    con.query('INSERT INTO `restau_fav`(`id_user`, `id_restau`) SELECT  t_user.id , ? FROM t_user where nickname= ?',[restau,user], function(err,result,fields)
        {
            con.on('error',function(err){
                console.log('[MySQL ERROR]',err);
            });
            res.json(result);
        });
    });


// Delete Favorite_User_Restau
app.get('/deleteFavoriteUserRestau/:restau/:user',(req,res,next)=>{
    
    var user = req.params.user;
    var restau = req.params.restau;
    
    con.query('DELETE FROM `restau_fav` WHERE id_user = (SELECT id FROM t_user where nickname= ?) and id_restau = ? ',[user,restau], function(err,result,fields)
    {
        con.on('error',function(err){
            console.log('[MySQL ERROR]',err);
        });
        res.json(result);
    });
    });


    // PUT Edit_Profil
    app.post('/putEditProfil/',(req,res,next)=>{
        
        var post_data = req.body; //Get POST params
        var user = post_data.user;
        var nickname = post_data.name;
        var password = post_data.password;
        var phoneNum = post_data.telephone;
        
        con.query('UPDATE t_user SET phoneNum =?,password =? WHERE nickname =?',[phoneNum,password,user], function(err,result,fields)
            {
                con.on('error',function(err){
                    console.log('[MySQL ERROR]',err);
                    res.json('Profil error: ', err);
                });
                var jsonStr = [{STATE:"success"}];
                res.json(jsonStr);
            });
        });


// Get all gethisSearchAllRest
app.get('/gethisSearchAllRest/:userfavoris', (req, res) => {
    var userfavoris = req.params.userfavoris;
    con.query ('SELECT historique_search FROM t_user Where nickname = ?',[userfavoris],function (err,result,fields){
        con.on('error',function(err){
            console.log('[MySQL ERROR]',err);
        });
        res.json(result);
    });
});

// Set all sethisuser
app.get('/sethisuser/:valeur/:user', (req, res) => {
    var valeur = req.params.valeur;
    var user = req.params.user;
    con.query ('UPDATE t_user set historique_search=? Where nickname = ?',[valeur,user],function (err,result,fields){
        con.on('error',function(err){
            console.log('[MySQL ERROR]',err);
        });
        res.json(result);
    });
});


// Get all getSearchAllRest
app.get('/getSearchAllRest/:userfavoris', (req, res) => {
    var userfavoris = req.params.userfavoris;
    con.query ('SELECT restaurant.id,restaurant.nom,adresse,ifnull(avg(restau_rating.note),0) as rating,delivery,COUNT(DISTINCT(Select id_user from restau_fav WHERE restau_fav.id_restau=restaurant.id AND restau_fav.id_user=(SELECT id from t_user WHERE nickname= ?))) as favoris FROM restaurant left join restau_rating on restau_rating.id_restau=restaurant.id LEFT JOIN repas on repas.id_restau=restaurant.id WHERE repas.nom  LIKE CONCAT("%",'+"(SELECT historique_search from t_user where t_user.nickname=?)"+',"%") group by restaurant.id,restaurant.nom,adresse,delivery',[userfavoris,userfavoris],function (err,result,fields){
        con.on('error',function(err){
            console.log('[MySQL ERROR]',err);
        });
        res.json(result);
    });
});


app.listen(4000, () => console.log('Express server is runnig at port no : 4000'));