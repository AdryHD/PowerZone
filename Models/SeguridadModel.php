<?php
include_once $_SERVER["DOCUMENT_ROOT"] . "/PowerZone/Models/UtilitarioModel.php";

function ConsultarUsuarioModel($id_usuario)
{
    try
    {
        $context = OpenDatabase();

        $sp = "CALL sp_ConsultarUsuario('$id_usuario')";
        $result = $context->query($sp);

        $datos = null;
        while ($fila = $result->fetch_assoc())
        {
            $datos = $fila;
        }

        CloseDatabase($context);
        return $datos;
    }
    catch (Exception $e)
    {
        return null;
    }
}

function ActualizarPerfilModel($nombre, $correo, $cedula, $id_usuario)
{
    try
    {
        $context = OpenDatabase();

        $sp = "CALL sp_ActualizarPerfil('$nombre', '$correo', '$cedula', '$id_usuario')";

        $result = $context->query($sp);

        CloseDatabase($context);
        return $result;
    }
    catch (Exception $e)
    {
        return false;
    }
}

function ActualizarContrasenaModel($nuevaContrasena, $id_usuario)
{
    try
    {
        $context = OpenDatabase();

        $sp = "CALL sp_ActualizarContrasena('$nuevaContrasena', '$id_usuario')";
        $result = $context->query($sp);

        CloseDatabase($context);
        return $result;
    }
    catch (Exception $e)
    {
        return false;
    }
}

function ConsultarUsuariosModel()
{
    try
    {
        $context = OpenDatabase();
        $result  = $context->query("CALL sp_ConsultarUsuarios()");
        $datos   = [];
        while ($fila = $result->fetch_assoc())
        {
            $datos[] = $fila;
        }
        CloseDatabase($context);
        return $datos;
    }
    catch (Exception $e)
    {
        return [];
    }
}

function ActualizarRolModel($idUsuario, $idRol)
{
    try
    {
        $context = OpenDatabase();
        $result  = $context->query("CALL sp_ActualizarRol('$idUsuario', '$idRol')");
        CloseDatabase($context);
        return $result;
    }
    catch (Exception $e)
    {
        return false;
    }
}

function ActualizarEstadoUsuarioModel($idUsuario, $estado)
{
    try
    {
        $context = OpenDatabase();
        $result  = $context->query("CALL sp_ActualizarEstadoUsuario('$idUsuario', '$estado')");
        CloseDatabase($context);
        return $result;
    }
    catch (Exception $e)
    {
        return false;
    }
}
