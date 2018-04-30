<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL | E_STRICT);
require_once("Connection.php");
$result = "";

$value = explode('/',$_SERVER['REQUEST_URI']);
var_dump($value);
if($_SERVER['REQUEST_METHOD'] === "GET"){ //GET DEPARTMENT
  if(count($value) === 3){
    $stmt = $pdo->prepare("SELECT * FROM Discount d");
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_OBJ);
  }
}
else if($_SERVER['REQUEST_METHOD'] === "DELETE" && count($value) === 4){
  $stmt = $pdo->prepare("DELETE FROM `Discount`
                          WHERE idDiscount = :idd");
  $stmt->bindParam(':idd', $value[3], PDO::PARAM_INT);
  $stmt->execute();
}
else if($_SERVER['REQUEST_METHOD'] === "POST"  && count($value) === 3){

  $data = json_decode(file_get_contents('php://input'), true);
  $stmt = $pdo->prepare("INSERT INTO Discount(fkProduct) VALUES (:fkProduct)");
  $stmt->bindValue(':fkProduct', $data["fkProduct"], PDO::PARAM_INT);
  $stmt->execute();

}
else if($_SERVER['REQUEST_METHOD'] === "PUT" && count($value) === 4){
  $data = json_decode(file_get_contents('php://input'), true);
  $stmt = $pdo->prepare("UPDATE `Discount` SET `fkProduct`=:fkProduct WHERE idDiscount = :idd");
  $stmt->bindParam(':idd', $value[3], PDO::PARAM_INT);
  $stmt->bindValue(':fkProduct', $data["fkProduct"], PDO::PARAM_INT);
  $stmt->execute();
}


echo json_encode($result,JSON_UNESCAPED_UNICODE);

$pdo=null;

?>
