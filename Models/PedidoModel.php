<?php
include_once $_SERVER["DOCUMENT_ROOT"] . "/PowerZone/Models/UtilitarioModel.php";

function ConsultarPedidoModel($idPedido)
{
    try
    {
        $context = OpenDatabase();
        $param = ($idPedido === null) ? "NULL" : $idPedido;
        $sp = "CALL sp_ConsultarPedido($param)";
        $result = $context->query($sp);
        $datos = [];
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

function ActualizarEstadoPedidoModel($idPedido, $nuevoEstado)
{
    try
    {
        $context = OpenDatabase();
        $sp = "CALL sp_ActualizarEstadoPedido('$idPedido', '$nuevoEstado')";
        $result = $context->query($sp);
        CloseDatabase($context);
        return $result;
    }
    catch (Exception $e)
    {
        return false;
    }
}