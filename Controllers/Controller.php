<?php
include_once $_SERVER["DOCUMENT_ROOT"] . "/G4_AMBIENTEWEB/Models/Model.php";

if (isset($_POST["btnRegistrar"])) {

    $Nombre = $_POST["nombre"];
    $Correo = $_POST["correo"];
    $Contrasena = $_POST["contrasena"];

    $ContrasenaHash = password_hash($Contrasena, PASSWORD_BCRYPT);

    $result = RegistrarUsuario($Nombre, $Correo, $ContrasenaHash);

   if ($result === true) {
    $_POST["Mensaje"] = "Usuario registrado correctamente.";
        $_POST["TipoMensaje"] = "success"; 
    } else {
        $_POST["Mensaje"] = $result;
        $_POST["TipoMensaje"] = "danger";   
    }
}

