var express = require('express');
var app = express();
var mysql = require('mysql');

const router = express.Router();

router.use('/Lamp', require("./lamp"));
router.use('/Product', require("./product"));
router.use('/Discount', require("./discount"));
router.use('/Department', require("./department"));
router.use('/Auth', require("./auth"));

module.exports = router;
