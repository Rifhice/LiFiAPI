var express = require('express');
const router = express.Router();
var mysql = require('mysql');
const db = require('./dbConnection');
const moment = require('./moments');
const auth = require('./checkAuth');

router.get('/', function(req, res) {
  db.con.query("SELECT * FROM Discount d, PercentagePriceDiscount p, Product p1 WHERE p.fkDiscount = d.idDiscount AND d.fkProduct = p1.idProduct", function(err, result, fields) {
    if (err) throw err;
    for (i = 0; i < result.length; i++) {
      result[i].date_start = moment(result[i].date_start).add(2, 'hours')
      result[i].date_end = moment(result[i].date_end).add(2, 'hours')
      result[i].date_update = moment(result[i].date_update).add(2, 'hours')
    }
    percentage = result
    db.con.query("SELECT * FROM Discount d, QuantityDiscount q, Product p1 WHERE q.fkDiscount = d.idDiscount AND d.fkProduct = p1.idProduct", function(err, result, fields) {
      if (err) throw err;
      res.send(result.concat(percentage));
    });
  });
})

router.get('/:id', function(req, res) {
  db.con.query("SELECT idDiscount, fkProduct, date_start, date_end, date_update, fkDiscount, percentage, fidelity, idProduct, p1.name, description, price, brand, d1.idDepartment, d1.name AS nameDepartment FROM Discount d, PercentagePriceDiscount p, Product p1, Department d1 WHERE p.fkDiscount = d.idDiscount AND d.fkProduct = p1.idProduct AND d1.idDepartment = p1.idDepartment AND p.fkDiscount = " + req.params.id, function(err, result, fields) {
    if (err) throw err;
    if (result.length != 0) {
      for (i = 0; i < result.length; i++) {
        result[i].date_start = moment(result[i].date_start).add(2, 'hours')
        result[i].date_end = moment(result[i].date_end).add(2, 'hours')
        result[i].date_update = moment(result[i].date_update).add(2, 'hours')
      }
      res.send(result);
    } else {
      db.con.query("SELECT idDiscount, fkProduct, date_start, date_end, date_update, fkDiscount, bought, free, fidelity, idProduct, p1.name, description, price, brand, d1.idDepartment, d1.name AS nameDepartment FROM Discount d, QuantityDiscount q, Product p1, Department d1 WHERE q.fkDiscount = d.idDiscount AND d.fkProduct = p1.idProduct AND d1.idDepartment = p1.idDepartment AND q.fkDiscount = " + req.params.id, function(err, result, fields) {
        if (err) throw err;
        for (i = 0; i < result.length; i++) {
          result[i].date_start = moment(result[i].date_start).add(2, 'hours')
          result[i].date_end = moment(result[i].date_end).add(2, 'hours')
          result[i].date_update = moment(result[i].date_update).add(2, 'hours')
        }
        res.send(result);
      });
    }
  });
})

router.post('/Quantity', function(req, res) {
  auth.checkAuth(req.token, function() {
      db.con.query("INSERT INTO Discount(fkProduct, date_start, date_end ) VALUES (" + req.body.fkProduct + " , '" + req.body.date_start + "' , '" + req.body.date_end + "')", function(err, result, fields) {
        if (err) {
          res.send(JSON.stringify({
            code: 500
          }))
          throw err
        }
        discountId = result.insertId
        db.con.query("INSERT INTO QuantityDiscount(Bought,Free,fkDiscount,fidelity) VALUES (" + req.body.bought + " , '" + req.body.free + "' , " + discountId + " , " + req.body.fidelity + ")", function(err, result, fields) {
          if (err) {
            res.send(JSON.stringify({
              code: 500
            }))
            throw err
          }
          res.send(JSON.stringify({
            insertId: discountId,
            code: 200
          }))
        });
      })
    },
    function() {
      res.send(JSON.stringify({
        code: 401
      }))
    })
})

router.post('/Percentage', function(req, res) {
  auth.checkAuth(req.token, function() {
      db.con.query("INSERT INTO Discount(fkProduct, date_start, date_end ) VALUES (" + req.body.fkProduct + " , '" + req.body.date_start + "' , '" + req.body.date_end + "')", function(err, result, fields) {
        if (err) {
          res.send(JSON.stringify({
            code: 500
          }))
          throw err
        }
        discountId = result.insertId
        db.con.query("INSERT INTO PercentagePriceDiscount(fkDiscount, Percentage, fidelity) VALUES (" + discountId + " , " + req.body.percentage + " , " + req.body.fidelity + ")", function(err, result, fields) {
          if (err) {
            res.send(JSON.stringify({
              code: 500
            }))
            throw err
          }
          res.send(JSON.stringify({
            insertId: discountId,
            code: 200
          }))
        });
      })
    },
    function() {
      res.send(JSON.stringify({
        code: 401
      }))
    })
})

router.delete('/:id', function(req, res) {
  auth.checkAuth(req.token, function() {
    db.con.query("DELETE FROM Discount WHERE idDiscount = " + req.params.id, function(err, result, fields) {
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


router.put('/Quantity/:id', function(req, res) {
  auth.checkAuth(req.token, function() {
      db.con.query("UPDATE Discount SET fkProduct=" + req.body.fkProduct + ", date_start='" + req.body.date_start + "', date_end='" + req.body.date_end + "' WHERE idDiscount = " + req.params.id, function(err, result, fields) {
        if (err) {
          res.send(JSON.stringify({
            code: 500
          }))
          throw err
        }
        db.con.query("UPDATE QuantityDiscount SET bought=" + req.body.bought + ", free=" + req.body.free + ", fidelity=" + req.body.fidelity + " WHERE fkDiscount = " + req.params.id, function(err, result, fields) {
          if (err) {
            res.send(JSON.stringify({
              code: 500
            }))
            throw err
          }
          res.send(JSON.stringify({
            affectedRows: result.affectedRows,
            code: 200
          }))
        });
      })
    },
    function() {
      res.send(JSON.stringify({
        code: 401
      }))
    })
})

router.put('/Percentage/:id', function(req, res) {
  auth.checkAuth(req.token, function() {
      db.con.query("UPDATE Discount SET fkProduct=" + req.body.fkProduct + ", date_start='" + req.body.date_start + "', date_end='" + req.body.date_end + "' WHERE idDiscount = " + req.params.id, function(err, result, fields) {
        if (err) {
          res.send(JSON.stringify({
            code: 500
          }))
          throw err
        }
        db.con.query("UPDATE PercentagePriceDiscount SET percentage=" + req.body.percentage + ", fidelity=" + req.body.fidelity + " WHERE fkDiscount = " + req.params.id, function(err, result, fields) {
          if (err) {
            res.send(JSON.stringify({
              code: 500
            }))
            throw err
          }
          res.send(JSON.stringify({
            affectedRows: result.affectedRows,
            code: 200
          }))
        });
      })
    },
    function() {
      res.send(JSON.stringify({
        code: 401
      }))
    })
})

module.exports = router;
