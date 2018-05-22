var express = require('express');
const router = express.Router();
var mysql = require('mysql');
const db = require('./dbConnection');
const auth = require('./checkAuth');

router.get('/', function(req, res) {
  db.con.query("SELECT l.idLamp, l.name AS nameLamp, l.idDepartment, d.name AS nameDepartment FROM Lamp l LEFT OUTER JOIN Department d ON l.idDepartment = d.idDepartment", function(err, result, fields) {
    if (err) throw err;
    res.send(result);
  });
})

router.get('/:id', function(req, res) {
  db.con.query("SELECT l.idLamp, l.name AS nameLamp, l.idDepartment, d.name AS nameDepartment FROM Lamp l LEFT OUTER JOIN Department d ON l.idDepartment = d.idDepartment WHERE l.idLamp = " + req.params.id, function(err, result, fields) {
    if (err) throw err;
    res.send(result);
  });
})

router.post('/', function(req, res) {
  auth.checkAuth(req.token, function() {
    db.con.query("INSERT INTO Lamp(idLamp,name,idDepartment) VALUES (" + req.body.idLamp + ",'" + req.body.name.replace("\'", "\\'") + "','" + req.body.idDepartment + "')", function(err, result, fields) {
      if (err) throw err;
      res.send(JSON.stringify({
        insertId: req.body.idLamp,
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
    db.con.query("DELETE FROM Lamp WHERE idLamp = " + req.params.id, function(err, result, fields) {
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
      db.con.query("UPDATE Lamp SET name='" + req.body.name.replace("\'", "\\'") + "', idDepartment='" + req.body.idDepartment + "' WHERE idLamp = '" + req.params.id + "'", function(err, result, fields) {
        if (err) throw err;
        res.send(JSON.stringify({
          affectedRows: result.affectedRows,
          code: 200
        }))
      });
    },
    function() {
      res.send(JSON.stringify({
        code: 401
      }))
    })
})

module.exports = router;
