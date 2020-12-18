var express = require('express');
var router = express.Router();

var rapidApi = require('../service/rapidApi');

router.get('/', function (req, res, next) {
    res.send('fantasy league')
});

module.exports = router;
