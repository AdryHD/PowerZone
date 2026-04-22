<?php
include_once $_SERVER["DOCUMENT_ROOT"] . "/PowerZone/Controllers/UtilitarioController.php";
include_once $_SERVER["DOCUMENT_ROOT"] . "/PowerZone/Models/HomeModel.php";
include_once $_SERVER["DOCUMENT_ROOT"] . "/PowerZone/Models/SeguridadModel.php";

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

if (isset($_POST["btnRegistrar"])) {

    $identificacion    = $_POST["Identificacion"];
    $nombre            = $_POST["Nombre"];
    $correoElectronico = $_POST["CorreoElectronico"];
    $contrasenna       = $_POST["Contrasenna"];

    $result = RegistrarModel($identificacion, $nombre, $contrasenna, $correoElectronico);

    if ($result) {
        $plantillaBienvenida = file_get_contents($_SERVER["DOCUMENT_ROOT"] . "/PowerZone/Views/emails/bienvenida.html");
        $cuerpoCorreo        = str_replace("{{NOMBRE}}", $nombre, $plantillaBienvenida);
        EnviarCorreo("Bienvenido/a a PowerZone", $cuerpoCorreo, $correoElectronico);

        $_SESSION["mensaje"]      = "Usuario registrado correctamente.";
        $_SESSION["tipo_mensaje"] = "success";
        header("Location: /PowerZone/Views/Home/inicio.php");
        exit;
    } else {
        $_POST["Mensaje"]     = "Su información no fue registrada correctamente.";
        $_POST["TipoMensaje"] = "danger";
    }
}

if (isset($_POST["btnIniciarSesion"])) {

    $correoElectronico = $_POST["CorreoElectronico"];
    $contrasenna       = $_POST["Contrasenna"];

    $result = IniciarSesionModel($correoElectronico, $contrasenna);

    if ($result) {
        $_SESSION["usuario_logueado"]    = true;
        $_SESSION["usuario_id"]          = $result["id_usuario"];
        $_SESSION["usuario_nombre"]      = $result["nombre"];
        $_SESSION["usuario_email"]       = $result["correo"];
        $_SESSION["usuario_rol"]         = $result["id_rol"];
        $_SESSION["usuario_nombre_rol"]  = $result["nombre_rol"];
        header("Location: /PowerZone/Views/Home/home.php");
        exit;
    } else {
        $_POST["Mensaje"]     = "Su información no fue autenticada correctamente.";
        $_POST["TipoMensaje"] = "danger";
    }
}

if (isset($_POST["btnRecuperarAcceso"])) {

    $correo = $_POST["CorreoElectronico"];

    $result = ValidarCorreoModel($correo);

    if ($result) {

        $nuevaContrasena = GenerarContrasena();
        $actualizacion   = ActualizarContrasenaModel($nuevaContrasena, $result["id_usuario"]);

        if ($actualizacion) {

            $plantilla    = file_get_contents($_SERVER["DOCUMENT_ROOT"] . "/PowerZone/Views/emails/recuperarAcceso.html");
            $cuerpoCorreo = str_replace(
                ["{{NOMBRE}}", "{{CONTRASENA}}"],
                [$result["nombre"], $nuevaContrasena],
                $plantilla
            );

            EnviarCorreo("Recuperar Acceso - PowerZone", $cuerpoCorreo, $result["correo"]);

            header("Location: /PowerZone/Views/Home/inicio.php");
            exit;
        }
    }

    $_POST["Mensaje"] = "El correo ingresado no está registrado.";
}

if (isset($_POST["btnCerrarSesion"])) {
    session_unset();
    session_destroy();
    echo json_encode("OK");
}
