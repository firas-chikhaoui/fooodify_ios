var express = require('express');
var router = express.Router();
var connection = require('../config/db');

router.get('/', function(req, res, next) {
  var query = 'SELECT * FROM player';
  connection.query(query, function (err, result) {
    if (err) {
      res.status(200).send(err)
    }
    else {
      res.status(200).send(result)
    }
  })
});


module.exports = router;
