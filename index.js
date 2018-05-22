const express = require("express");
const app = express()
var bodyParser = require('body-parser')
require('dotenv').config()
const bearerToken = require('express-bearer-token');

app.use(bearerToken())
app.use(bodyParser.json())
app.use(
  "/api",
  require("./router.js")
);

var server = app.listen(1337, function() {
  var host = server.address().address
  var port = server.address().port

  console.log("Example app listening at http://%s:%s", host, port)
})
