<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL | E_STRICT);
require_once("Connection.php");
$result = "";

$value = explode('/',$_SERVER['REQUEST_URI']);
var_dump($value);
if($_SERVER['REQUEST_METHOD'] === "GET"){ //GET DEPARTMENT
  if(count($value) > 4 && $value[4] === "Discounts"){
    $stmt = $pdo->prepare("SELECT d.idDiscount FROM Discount d, Product p WHERE d.fkProduct = p.idProduct AND p.idProduct = :idp");
    $stmt->bindParam(':idp', $value[3], PDO::PARAM_INT);
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_OBJ);
  }
  else if(count($value) === 3){
    $stmt = $pdo->prepare("SELECT * FROM Product p");
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_OBJ);
  }
}
else if($_SERVER['REQUEST_METHOD'] === "DELETE" && count($value) === 4){
  $stmt = $pdo->prepare("DELETE FROM `Product`
                          WHERE idProduct = :idp");
  $stmt->bindParam(':idp', $value[3], PDO::PARAM_INT);
  $stmt->execute();
}
else if($_SERVER['REQUEST_METHOD'] === "POST"  && count($value) === 3){

  $data = json_decode(file_get_contents('php://input'), true);
  $stmt = $pdo->prepare("INSERT INTO Product(Name,description,price,brand,idDepartment) VALUES (:name,:description,:price,:brand,:idDepartment)");
  $stmt->bindValue(':name', $data["name"], PDO::PARAM_INT);
  $stmt->bindValue(':description', $data["description"], PDO::PARAM_INT);
  $stmt->bindValue(':brand', $data["brand"], PDO::PARAM_INT);
  $stmt->bindValue(':price', $data["price"], PDO::PARAM_INT);
  $stmt->bindValue(':idDepartment', $data["idDepartment"], PDO::PARAM_INT);
  $stmt->execute();

}
else if($_SERVER['REQUEST_METHOD'] === "PUT" && count($value) === 4){
  $data = json_decode(file_get_contents('php://input'), true);
  $stmt = $pdo->prepare("UPDATE `Product` SET `name`=:name, description=:description, price=:price, brand=:brand, idDepartment=:idDepartment WHERE idProduct = :idp");
  $stmt->bindParam(':idp', $value[3], PDO::PARAM_INT);
  $stmt->bindValue(':name', $data["name"], PDO::PARAM_INT);
  $stmt->bindValue(':description', $data["description"], PDO::PARAM_INT);
  $stmt->bindValue(':brand', $data["brand"], PDO::PARAM_INT);
  $stmt->bindValue(':price', $data["price"], PDO::PARAM_INT);
  $stmt->bindValue(':idDepartment', $data["idDepartment"], PDO::PARAM_INT);
  $stmt->execute();
}


echo json_encode($result,JSON_UNESCAPED_UNICODE);

$pdo=null;

?>
