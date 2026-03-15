<?php
include_once $_SERVER["DOCUMENT_ROOT"] . "/G4_AMBIENTEWEB/Models/UtilitarioModel.php";

function RegistrarUsuario($Nombre, $Correo, $Contrasena)
{
    $context = OpenDatabase();

    try {
        $sp = "CALL sp_Registrar('$Nombre', '$Correo', '$Contrasena')";
        $result = $context->query($sp);

        CloseDatabase($context);
        return true;

    } catch (mysqli_sql_exception $e) {
        CloseDatabase($context);

        // Detecta si es error de duplicado
        if (strpos($e->getMessage(), "Duplicate entry") !== false) {
            return "El correo '$Correo' ya está registrado.";
        } else {
            return "Error al registrar usuario: " . $e->getMessage();
        }
    }
}