<?php
include_once $_SERVER["DOCUMENT_ROOT"] . "/G4_AmbienteWeb/Models/UtilitarioModel.php";

function ConsultarPedidoModel($idPedido)
{
    $context = OpenDatabase();

    $param = ($idPedido === null) ? "NULL" : $idPedido;
    
    $sp = "CALL sp_ConsultarPedido($param)";
    $result = $context->query($sp);

    $datos = [];
    if($result) {
        while ($fila = $result->fetch_assoc()) {
            $datos[] = $fila;
        }
    }
    CloseDatabase($context);
    return $datos;
}

function ActualizarEstadoPedidoModel($idPedido, $nuevoEstado)
{
    $context = OpenDatabase();
    $sql = "CALL sp_ActualizarEstadoPedido($idPedido, '$nuevoEstado')";
    
    $resultado = $context->query($sql);
    
    CloseDatabase($context);
    return $resultado;
}