<?php
$servername = "localhost";
$username = "root";
$password = "raspberry1302";
$myDB = "LiFi";
$path = "LiFiAPI/";

try {
    $pdo = new PDO("mysql:host=$servername;dbname=$myDB", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->exec("SET CHARACTER SET utf8");
  }
catch(PDOException $e){
    echo "Connection failed: " . $e->getMessage();
  }
?>
