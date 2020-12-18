var async = require("async");
var request = require("request");

var rapidApiHost = process.env.RAPID_API_HOST;
var rapidApiKey = process.env.RAPID_API_KEY;
var rapidApiUrl = process.env.RAPID_API_URL;
var leagueId = process.env.LEAGUE_ID;
var leagueSeason = process.env.LEAGUE_SEASON;
var leagueName = process.env.LEAGUE_NAME;

var headers = {
    "x-rapidapi-host": rapidApiHost,
    "x-rapidapi-key": rapidApiKey
}

exports.getAllPlayers = function (cb) {
    var teamsId = [];
    var players = [];
    async.waterfall([
        function (callback) {
            var url = rapidApiUrl + 'teams/league/' + leagueId;
            request({
                headers: headers,
                uri: url,
                method: 'GET'
            }, function (err, response, body) {
                if (err) {
                    callback(err);
                } else {
                    var res = body;
                    res = JSON.parse(body);
                    if (!res || !res.api || !res.api.teams) {
                        callback('bad data');
                    } else {
                        var teams = res.api.teams;
                        teamsId = teams.map(function (value) {
                            return value.team_id;
                        })
                        callback();
                    }
                }
            });
        },
        function (callback) {
            async.eachSeries(teamsId, function updateObject(o, done) {
                var url = rapidApiUrl + 'players/team/' + o + '/' + leagueSeason;
                request({
                    headers: headers,
                    uri: url,
                    method: 'GET'
                }, function (err, response, body) {
                    if (err) {
                        done(err);
                    } else {
                        var res = body;
                        res = JSON.parse(body);
                        if (!res || !res.api || !res.api.players) {
                            done('bad data');
                        } else {
                            var p = res.api.players.filter(function (value) {
                                return value && value.league === leagueName
                            })
                            players = players.concat(p);
                            done();
                        }
                    }
                });
            }, function allDone(err) {
                if (err) callback(err);
                else {
                    callback();
                }
            });
        },
    ], function (error) {
        if (error) cb(error);
        else cb(null, players);
    });
};
