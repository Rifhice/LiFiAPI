var express = require('express');
const router = express.Router();
var mysql = require('mysql');
const db = require('./dbConnection');
const auth = require('./checkAuth');

router.get('/', function(req, res) {
  db.con.query("SELECT * FROM Department", function(err, result, fields) {
    if (err) throw err;
    res.send(result);
  });
})

router.get('/:id', function(req, res) {
  db.con.query("SELECT * FROM Department WHERE idDepartment = " + req.params.id,
    function(err, result, fields) {
      if (err) throw err;
      res.send(result);
    });
})

router.get('/:id/Products', function(req, res) {
  db.con.query("SELECT p.idProduct, p.name, p.description, p.price, p.brand FROM Department d, Product p WHERE d.idDepartment = p.idDepartment AND d.idDepartment = " + req.params.id, function(err, result, fields) {
    if (err) throw err;
    res.send(result);
  });
})


router.post('/', function(req, res) {
  auth.checkAuth(req.token, function() {
    db.con.query("INSERT INTO Department(Name) VALUES ('" + req.body.name.replace("\'", "\\'") + "')", function(err, result, fields) {
      if (err) throw err;
      res.send(JSON.stringify({
        insertId: result.insertId,
        code: 200
      }))
    });
  }, function() {
    res.send(JSON.stringify({
      code: 401
    }))
  })
})

router.delete('/:id', function(req, res) {
  auth.checkAuth(req.token, function() {
    db.con.query("DELETE FROM Department WHERE idDepartment = " + req.params.id, function(err, result, fields) {
      if (err) throw err;
      res.send(JSON.stringify({
        affectedRows: result.affectedRows,
        code: 200
      }))
    });
  }, function() {
    res.send(JSON.stringify({
      code: 401
    }))
  })
})

router.put('/:id', function(req, res) {
  auth.checkAuth(req.token, function() {
    db.con.query("UPDATE Department SET name='" + req.body.name.replace("\'", "\\'") + "' WHERE idDepartment = '" + req.params.id + "'", function(err, result, fields) {
      if (err) throw err;
      res.send(JSON.stringify({
        affectedRows: result.affectedRows,
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
