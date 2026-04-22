<?php
include_once $_SERVER["DOCUMENT_ROOT"] . "/PowerZone/Controllers/UtilitarioController.php";
include_once $_SERVER["DOCUMENT_ROOT"] . "/PowerZone/Models/SeguridadModel.php";

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

if (isset($_POST["btnCambiarAcceso"])) {

    $nuevaContrasena  = $_POST["NuevaContrasena"];
    $id_usuario       = $_SESSION["usuario_id"];
    $correo           = $_SESSION["usuario_email"];
    $nombre           = $_SESSION["usuario_nombre"];

    $result = ActualizarContrasenaModel($nuevaContrasena, $id_usuario);

    if ($result) {
        session_unset();
        session_destroy();
        session_start();

        $plantilla    = file_get_contents($_SERVER["DOCUMENT_ROOT"] . "/PowerZone/Views/emails/cambioAcceso.html");
        $cuerpoCorreo = str_replace(
            ["{{NOMBRE}}", "{{FECHA}}"],
            [$nombre, date("d/m/Y H:i")],
            $plantilla
        );

        EnviarCorreo("Cambio de Contraseña - PowerZone", $cuerpoCorreo, $correo);

        $_SESSION["mensaje"]      = "Contraseña actualizada correctamente. Inicia sesión con tu nueva contraseña.";
        $_SESSION["tipo_mensaje"] = "success";
        header("Location: /PowerZone/Views/Home/inicio.php");
        exit;
    } else {
        $_POST["Mensaje"] = "Su contraseña no pudo ser actualizada.";
    }
}

if (isset($_POST["btnCambiarPerfil"])) {

    $nombre     = $_POST["Nombre"];
    $correo     = $_POST["CorreoElectronico"];
    $cedula     = $_POST["Cedula"] ?? '';
    $id_usuario = $_SESSION["usuario_id"];

    $result = ActualizarPerfilModel($nombre, $correo, $cedula, $id_usuario);

    if ($result) {
        $_SESSION["usuario_nombre"] = $nombre;
        $_SESSION["usuario_email"]  = $correo;
        $_POST["Mensaje"]      = "Cambios realizados con éxito.";
        $_POST["TipoMensaje"]  = "success";
    } else {
        $_POST["Mensaje"]      = "Sus datos no pudieron ser actualizados.";
        $_POST["TipoMensaje"]  = "danger";
    }
}

function ConsultarUsuario()
{
    $id_usuario = $_SESSION["usuario_id"];
    return ConsultarUsuarioModel($id_usuario);
}

function ConsultarUsuarios()
{
    return ConsultarUsuariosModel();
}

if (isset($_POST["btnActualizarRol"])) {
    header('Content-Type: application/json');

    $idUsuario  = (int)($_POST["idUsuario"] ?? 0);
    $idRol      = (int)($_POST["idRol"] ?? 0);
    $idSesion   = (int)($_SESSION["usuario_id"] ?? 0);

    if ($idUsuario === $idSesion) {
        echo json_encode(["error" => "No puedes cambiar tu propio rol."]);
        exit;
    }

    if (!$idUsuario || !$idRol) {
        echo json_encode(["error" => "Parámetros inválidos."]);
        exit;
    }

    $resultado = ActualizarRolModel($idUsuario, $idRol);
    echo json_encode(["ok" => (bool)$resultado]);
    exit;
}

if (isset($_POST["btnActualizarEstado"])) {
    header('Content-Type: application/json');

    $idUsuario = (int)($_POST["idUsuario"] ?? 0);
    $estado    = $_POST["estado"] ?? '';
    $idSesion  = (int)($_SESSION["usuario_id"] ?? 0);

    if ($idUsuario === $idSesion) {
        echo json_encode(["error" => "No puedes cambiar tu propio estado."]);
        exit;
    }

    if (!$idUsuario || !in_array($estado, ['activo', 'inactivo'], true)) {
        echo json_encode(["error" => "Parámetros inválidos."]);
        exit;
    }

    $resultado = ActualizarEstadoUsuarioModel($idUsuario, $estado);
    echo json_encode(["ok" => (bool)$resultado]);
    exit;
}
