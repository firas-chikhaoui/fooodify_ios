var mysql = require('mysql');

var dbUser = process.env.DATABASE_USER;
var dbPassword = process.env.DATABASE_PASSWORD;
var dbName = process.env.DATABASE_NAME;
var dbHost = process.env.DATABASE_HOST;
var dbPort = process.env.DATABASE_PORT;

module.exports = mysql.createConnection({
    user: dbUser,
    password: dbPassword,
    host: dbHost,
    database: dbName,
    port: parseInt(dbPort)
});
