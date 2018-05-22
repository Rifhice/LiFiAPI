var express = require('express');
const router = express.Router();
var mysql = require('mysql');
const db = require('./dbConnection');
var crypto = require('crypto');
const auth = require('./checkAuth');

var md5sum = crypto.createHash('md5');

router.post('/', function(req, res) {
  password = req.body.password
  hashed = crypto.createHash('md5').update(password).digest('hex')
  db.con.query("SELECT * FROM User", function(err, result, fields) {
    if (err) throw err;
    if (hashed == result[0].password) {
      res.send(JSON.stringify({
        token: hashed,
        code: 200
      }))
    } else {
      res.send(JSON.stringify({
        code: 401
      }))
    }
  });
})

router.put('/', function(req, res) {
  auth.checkAuth(req.token, function() {
    password = req.body.password
    hashed = crypto.createHash('md5').update(password).digest('hex')
    db.con.query("UPDATE User SET password='" + hashed + "' WHERE id = 1", function(err, result, fields) {
      if (err) throw err;
      console.log(hashed)
      res.send(JSON.stringify({
        affectedRows: result.affectedRows,
        token: hashed,
        code: 200
      }))
    });
  }, function() {
    res.send(JSON.stringify({
      code: 401
    }))
  })
})


module.exports = router;
