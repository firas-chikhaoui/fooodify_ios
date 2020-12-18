var express = require('express');
var router = express.Router();
var connection = require('../config/db');

router.get('/select_all', function (req, res, next) {
    var query = 'SELECT * FROM team';
    connection.query(query, function (err, result) {
        if (err) {
            res.status(200).send(err)
        } else {
            res.status(200).send(result)
        }
    })
});

router.post('/add_team', function (req, res, next) {
    var data = [
        [
            req.body.user_id,
            req.body.name,
            req.body.owner,
            req.body.def_num,
            req.body.mid_num,
            req.body.fwd_num,
            req.body.goal_id,
            req.body.player1_id,
            req.body.player2_id,
            req.body.player3_id,
            req.body.player4_id,
            req.body.player5_id,
            req.body.player6_id,
            req.body.player7_id,
            req.body.player8_id,
            req.body.player9_id,
            req.body.player10_id,
            req.body.sub_goal_id,
            req.body.sub_player1_id,
            req.body.sub_player2_id,
            req.body.sub_player3_id,
            req.body.sub_player4_id,
        ]];
    var query = 'INSERT INTO team ' +
        '(user_id, name, owner, def_num, mid_num, fwd_num, ' +
        'goal_id, player1_id, player2_id, player3_id, player4_id, player5_id, ' +
        'player6_id, player7_id, player8_id, player9_id, player10_id, sub_goal_id, ' +
        'sub_player1_id, sub_player2_id, sub_player3_id, sub_player4_id) VALUES ?';
    connection.query(query, [data], function (err, result) {
        if (err) {
            res.status(200).send(err)
        } else {
            res.status(200).send('success')
        }
    })
});


router.post('/serchteambyuser', function(req, res, next) {
    

           var owner = req.body.owner;
        
  var query = 'SELECT * FROM `team` WHERE `owner` = ?';
  connection.query(query,[owner], function (err, result) {
    if (err) {
      res.status(200).send(err)
    }
    else {
      res.status(200).send(result)
    }
  })
});

router.post('/affecteteamauuser', function(req, res, next) {
    
         var id =   req.body.team_id;
           var user_id = req.body.user_id;
        
  var query = 'UPDATE `users` SET`team_id`= ? WHERE id = ?';
  connection.query(query,[id,user_id], function (err, result) {
    if (err) {
      res.status(200).send(err)
    }
    else {
      res.status(200).send(result)
    }
  })
});

router.get('/last_id', function(req, res, next) {
  var query = 'SELECT id FROM team ORDER BY id DESC LIMIT 0, 1';
  connection.query(query, function (err, result) {
    if (err) {
      res.status(200).send(err)
    }
    else {
      res.status(200).send(result)
    }
  })
});

router.put('/:id', function (req, res, next) {
    var data = [
        req.body.user_id,
        req.body.name,
        req.body.owner,
        req.body.def_num,
        req.body.mid_num,
        req.body.fwd_num,
        req.body.goal_id,
        req.body.player1_id,
        req.body.player2_id,
        req.body.player3_id,
        req.body.player4_id,
        req.body.player5_id,
        req.body.player6_id,
        req.body.player7_id,
        req.body.player8_id,
        req.body.player9_id,
        req.body.player10_id,
        req.body.sub_goal_id,
        req.body.sub_player1_id,
        req.body.sub_player2_id,
        req.body.sub_player3_id,
        req.body.sub_player4_id,
        req.params.id
    ];
    var query = 'UPDATE team ' +
        'SET name =?, owner =?, def_num =?, mid_num =?, fwd_num =?, ' +
        'goal_id =?, player1_id =?, player2_id =?, player3_id =?, player4_id =?, player5_id =?, ' +
        'player6_id =?, player7_id =?, player8_id =?, player9_id =?, player10_id =?, sub_goal_id =?, ' +
        'sub_player1_id =?, sub_player2_id =?, sub_player3_id =?, sub_player4_id =? ' +
        'WHERE id = ?';
    connection.query(query, data, function (err, result) {
        if (err) {
            res.status(200).send(err)
        } else {
            res.status(200).send('success')
        }
    })
});

module.exports = router;
