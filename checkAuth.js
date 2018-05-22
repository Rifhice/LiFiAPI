var mysql = require('mysql');
const db = require('./dbConnection');
module.exports.checkAuth = function(token, success, error) {
  db.con.query("SELECT * FROM User", function(err, result, fields) {
    if (err) throw err;
    if (token == result[0].password) {
      success()
    } else {
      error()
    }
  })
}
