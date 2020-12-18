var cron = require('node-cron');
var connection = require('../config/db');
var rapidApi = require('./rapidApi');

cron.schedule('13 20 * * *', function () {
    rapidApi.getAllPlayers(function (err, players) {
        var data = players.map(function (o) {
            return [
                o.firstname,
                o.lastname,
                o.position,
                o.goals.total,
                o.goals.assists,
                o.games.appearences,
                o.goals.conceded,
                o.cards.red,
                o.cards.yellow,
                o.team_id
            ]
        })

        let sql = 'DELETE FROM player ';
        connection.query(sql, (error, results, fields) => {
            if (error)
              return console.error(error.message);
           
            console.log('Deleted Row(s):', results.affectedRows);
          });
        
        
        var query = 'INSERT INTO player (first_name,last_name,position,goals,assists,appearences,clean_sheets,red_cards,yellow_cards,image) VALUES ?';
        connection.query(query, [data], function (err, result) {
            if (err) {
                console.log(err)
            }
        })
    })
});
