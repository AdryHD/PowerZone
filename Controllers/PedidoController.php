<?php
include_once $_SERVER["DOCUMENT_ROOT"] . "/PowerZone/Models/PedidoModel.php";
include_once $_SERVER["DOCUMENT_ROOT"] . "/PowerZone/Controllers/UtilitarioController.php";

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

if (isset($_POST["btnCambiarEstado"])) {
    $idPedido    = (int)$_POST["idPedido"];
    $nuevoEstado = $_POST["nuevoEstado"];

    if (!empty($idPedido) && !empty($nuevoEstado)) {
        $resultado = ActualizarEstadoPedidoModel($idPedido, $nuevoEstado);

        if ($resultado) {
            $datosPedido = ConsultarPedidoModel($idPedido);
            if (!empty($datosPedido)) {
                $fila          = $datosPedido[0];
                $nombreCliente = $fila["Nombre_Cliente"] ?? "";
                $correoCliente = $fila["Correo_Cliente"] ?? "";
                $plantilla     = file_get_contents($_SERVER["DOCUMENT_ROOT"] . "/PowerZone/Views/emails/actualizacionPedido.html");
                $plantilla     = str_replace("{{NOMBRE}}", htmlspecialchars($nombreCliente), $plantilla);
                $plantilla     = str_replace("{{ID_PEDIDO}}", $idPedido, $plantilla);
                $plantilla     = str_replace("{{NUEVO_ESTADO}}", htmlspecialchars($nuevoEstado), $plantilla);
                EnviarCorreo("Actualización de su pedido #" . $idPedido, $plantilla, $correoCliente);
            }
            header("Location: /PowerZone/Views/Producto/consultarPedido.php?id=" . $idPedido);
            exit;
        }
    }
}

function ConsultarPedido($idPedido = null)
{
    if ($idPedido !== null) {
        $idPedido = filter_var($idPedido, FILTER_VALIDATE_INT);
        if ($idPedido === false) {
            return [];
        }
    }

    $resultado = ConsultarPedidoModel($idPedido);

    if (empty($resultado)) {
        return [];
    }

    return $resultado;
}