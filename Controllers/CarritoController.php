<?php
include_once $_SERVER["DOCUMENT_ROOT"] . "/PowerZone/Controllers/UtilitarioController.php";
include_once $_SERVER["DOCUMENT_ROOT"] . "/PowerZone/Models/CarritoModel.php";

if (session_status() === PHP_SESSION_NONE) {
	session_start();
}

function AgregarAlCarrito()
{
	$idUsuario  = $_SESSION["usuario_id"] ?? null;
	$idProducto = isset($_POST["id_producto"]) ? (int)$_POST["id_producto"] : null;
	$cantidad   = isset($_POST["cantidad"]) ? (int)$_POST["cantidad"] : 1;

	if (!$idUsuario || !$idProducto) {
		http_response_code(400);
		return ["error" => "Parámetros inválidos o usuario no autenticado."];
	}

	$result = AgregarAlCarritoModel($idUsuario, $idProducto, $cantidad);

	if (isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest') {
		header('Content-Type: application/json');
		echo json_encode($result);
		exit;
	}

	if ($result) {
		header("Location: /PowerZone/Views/Producto/tienda.php?msg=agregado");
		exit;
	}

	$_POST["Mensaje"]     = "No se pudo agregar el producto al carrito.";
	$_POST["TipoMensaje"] = "danger";
	return null;
}

function ObtenerCarrito()
{
	$idUsuario = $_SESSION["usuario_id"] ?? null;
	if (!$idUsuario) return null;
	return ObtenerCarritoModel($idUsuario);
}

function ActualizarCantidad()
{
	$idUsuario  = $_SESSION["usuario_id"] ?? null;
	$idDetalle  = isset($_POST["id_detalle"]) ? (int)$_POST["id_detalle"] : null;
	$cantidad   = isset($_POST["cantidad"]) ? (int)$_POST["cantidad"] : null;

	if (!$idUsuario || !$idDetalle || $cantidad === null) {
		http_response_code(400);
		return ["error" => "Parámetros inválidos."];
	}

	$result = ActualizarCantidadModel($idDetalle, $idUsuario, $cantidad);

	header('Content-Type: application/json');
	echo json_encode($result);
	exit;
}

function EliminarDelCarrito()
{
	$idUsuario = $_SESSION["usuario_id"] ?? null;
	$idDetalle = isset($_POST["id_detalle"]) ? (int)$_POST["id_detalle"] : null;

	if (!$idUsuario || !$idDetalle) {
		http_response_code(400);
		return ["error" => "Parámetros inválidos."];
	}

	$result = EliminarDelCarritoModel($idDetalle, $idUsuario);
	header('Content-Type: application/json');
	echo json_encode($result);
	exit;
}

function VaciarCarrito()
{
	$idUsuario = $_SESSION["usuario_id"] ?? null;
	if (!$idUsuario) {
		http_response_code(400);
		return ["error" => "Usuario no autenticado."];
	}

	$result = VaciarCarritoModel($idUsuario);
	header('Content-Type: application/json');
	echo json_encode($result);
	exit;
}

function CancelarCarrito()
{
	$idUsuario = $_SESSION["usuario_id"] ?? null;
	if (!$idUsuario) {
		http_response_code(400);
		return ["error" => "Usuario no autenticado."];
	}

	$result = CancelarCarritoModel($idUsuario);
	header('Content-Type: application/json');
	echo json_encode($result);
	exit;
}

function FinalizarCarrito()
{
    $idUsuario    = $_SESSION["usuario_id"] ?? null;
    $direccion      = $_POST["direccion"] ?? '';
    $telefono       = $_POST["telefono"] ?? '';
    $metodoPago     = $_POST["metodo_pago"] ?? '';
    $observaciones  = $_POST["observaciones"] ?? '';
    $numComprobante = $_POST["num_comprobante"] ?? '';

    if (!$idUsuario) {
        header('Content-Type: application/json');
        http_response_code(401); 
        echo json_encode(["error" => "Sesión expirada"]);
        exit;
    }

    $result = FinalizarCarritoModel($idUsuario, $direccion, $telefono, $metodoPago, $observaciones, $numComprobante);

    if ($result && isset($result["id_pedido"])) {
        if ($metodoPago === 'transferencia') {
            $_SESSION["mensaje"] = "¡Pedido #" . $result["id_pedido"] . " recibido! Tu transferencia está pendiente de verificación por un administrador.";
        } else {
            $_SESSION["mensaje"] = "¡Pedido #" . $result["id_pedido"] . " confirmado con éxito! Pronto recibirás un correo de confirmación.";
        }
        $_SESSION["tipo_mensaje"] = "success";
        $plantilla    = file_get_contents($_SERVER["DOCUMENT_ROOT"] . "/PowerZone/Views/emails/confirmacionPedido.html");
        $cuerpoCorreo = str_replace(
            ["{{NOMBRE}}", "{{ID_PEDIDO}}", "{{TOTAL}}", "{{METODO_PAGO}}", "{{DIRECCION}}"],
            [
                $_SESSION["usuario_nombre"] ?? "",
                $result["id_pedido"],
                number_format($result["total"], 2),
                $metodoPago,
                $direccion
            ],
            $plantilla
        );
        EnviarCorreo("Confirmación de Pedido #" . $result["id_pedido"] . " - PowerZone", $cuerpoCorreo, $_SESSION["usuario_email"] ?? "");
    }

    header('Content-Type: application/json');
    echo json_encode($result);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
	$action = $_POST['action'] ?? null;
	switch ($action) {
		case 'agregar': AgregarAlCarrito(); break;
		case 'contar':
			$userId = $_SESSION['usuario_id'] ?? null;
			header('Content-Type: application/json');
			if (!$userId) {
				echo json_encode(['error' => 'Usuario no autenticado']);
				exit;
			}
			$items = ObtenerCarritoModel($userId);
			$total = 0;
			if (is_array($items)) {
				foreach ($items as $it) {
					$total += isset($it['cantidad']) ? (int)$it['cantidad'] : 0;
				}
			}
			echo json_encode(['total' => $total]);
			exit;
			break;
		case 'actualizar': ActualizarCantidad(); break;
		case 'eliminar': EliminarDelCarrito(); break;
		case 'vaciar': VaciarCarrito(); break;
		case 'cancelar': CancelarCarrito(); break;
		case 'finalizar': FinalizarCarrito(); break;
	}
}
?>

