var express = require('express');
const router = express.Router();
var mysql = require('mysql');
const db = require('./dbConnection');
const auth = require('./checkAuth');

router.get('/', function(req, res) {
  db.con.query("SELECT * FROM Product", function(err, result, fields) {
    if (err) throw err;
    res.send(result);
  });
})

router.get('/:id', function(req, res) {
  db.con.query("SELECT p.idProduct, p.name AS nameProduct, p.description AS descriptionProduct, p.price AS priceProduct, p.brand AS brandProduct, p.idDepartment, d.name AS nameDepartment FROM Product p LEFT OUTER JOIN Department d ON p.idDepartment = d.idDepartment WHERE p.idProduct = " + req.params.id, function(err, result, fields) {
    if (err) throw err;
    res.send(result);
  });
})

router.get('/:id/Discounts', function(req, res) {
  db.con.query("SELECT * FROM Discount d, PercentagePriceDiscount p1, Product p WHERE d.fkProduct = p.idProduct AND p1.fkDiscount = d.idDiscount AND p.idProduct = " + req.params.id, function(err, result, fields) {
    if (err) throw err;
    resu = result
    db.con.query("SELECT * FROM Discount d, QuantityDiscount q, Product p WHERE d.fkProduct = p.idProduct AND q.fkDiscount = d.idDiscount AND p.idProduct = " + req.params.id, function(err, result, fields) {
      if (err) throw err;
      res.send(resu.concat(result));
    });
  });
})


router.post('/', function(req, res) {
  auth.checkAuth(req.token, function() {
    db.con.query("INSERT INTO Product(Name,description,price,brand,idDepartment) VALUES ('" + req.body.name.replace("\'", "\\'") + "','" + req.body.description.replace("\'", "\\'") + "','" + req.body.price + "','" + req.body.brand.replace("\'", "\\'") + "','" + req.body.idDepartment + "' )", function(err, result, fields) {
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
    db.con.query("DELETE FROM Product WHERE idProduct = " + req.params.id, function(err, result, fields) {
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
    db.con.query("UPDATE Product SET name='" + req.body.name.replace("\'", "\\'") + "', description='" + req.body.description.replace("\'", "\\'") + "', price='" + req.body.price + "', brand='" + req.body.brand.replace("\'", "\\'") + "', idDepartment='" + req.body.idDepartment + "' WHERE idProduct = '" + req.params.id + "'", function(err, result, fields) {
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
