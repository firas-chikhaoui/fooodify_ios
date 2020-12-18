var express = require('express');
var router = express.Router();
var connection = require('../config/db');

router.post('/login', function (req, res, next) {
    var data = [req.body.name, req.body.password];
    var query = 'SELECT * FROM users WHERE name = ? AND password = ? LIMIT 1';
    connection.query(query, data, function (err, result) {
        if (err) {
            res.status(500).send(err)
        } else if (result && result.length && result[0]) {
            res.status(200).send(result[0])
        } else {
            res.status(302).send('not found')
        }
    })
});

router.post('/login_2', function (req, res, next) {
    var data = [req.body.name];
    var query = 'SELECT * FROM users WHERE name = ? LIMIT 1';
    connection.query(query, data, function (err, result) {
        if (err) {
            res.status(200).send(err)
        } else if (result && result.length && result[0]) {
            res.status(200).send(result[0])
        } else {
            res.status(404).send('not found')
        }
    })
});

router.post('/checkNameEmail', function (req, res, next) {
    var data = [req.body.name,req.body.email];
    var query = 'SELECT * FROM users WHERE name = ? OR email = ? LIMIT 1';
    connection.query(query, data, function (err, result) {
        if (err) {
            res.status(200).send(err)
        } else if (result && result.length && result[0]) {
            res.status(200).send(result[0])
        } else {
            res.status(404).send('not found')
        }
    })
});

router.post('/register', function (req, res, next) {
    var data = [[req.body.name, req.body.email, req.body.password]];
    var query = 'INSERT INTO users (name,email,password) VALUES ?';
    connection.query(query, [data], function (err, result) {
        if (err) {
            res.status(404).send(err)
        } else {
            res.status(200).send(result)
        }
    })
});

module.exports = router;
