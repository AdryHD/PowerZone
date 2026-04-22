<?php
include_once $_SERVER["DOCUMENT_ROOT"] . "/PowerZone/Views/layoutExterno.php";
include_once $_SERVER["DOCUMENT_ROOT"] . "/PowerZone/Controllers/HomeController.php";
?>

<!DOCTYPE html>
<html lang="es">

<?php MostrarCSS(); ?>

<body>

    <div id="preloader">
        <div class="spinner"></div>
    </div>

    <div class="overlay"></div>
    <main class="main-wrapper" style="margin-left: 0;">

        <?php MostrarHeader(); ?>

        <section class="section min-vh-100 d-flex align-items-center">
            <div class="container-fluid">
                <div class="row justify-content-center pt-50">
                    <div class="col-md-5">
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <h4 class="text-center mb-4">Inicio de Sesión</h4>

                                <?php
                                if (!empty($_SESSION['mensaje'])) {
                                    $msg  = $_SESSION['mensaje'];
                                    $type = $_SESSION['tipo_mensaje'] ?? 'info';
                                    echo '<div class="alert alert-' . $type . ' alert-dismissible fade show" role="alert">'
                                        . htmlspecialchars($msg)
                                        . '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>';
                                    unset($_SESSION['mensaje'], $_SESSION['tipo_mensaje']);
                                }
                                $error = $_GET['error'] ?? '';
                                if ($error) {
                                    $msg  = '';
                                    $type = 'danger';
                                    switch ($error) {
                                        case 'must_login':
                                            $msg  = 'Debes iniciar sesión para acceder a esa página.';
                                            $type = 'info';
                                            break;
                                        default:
                                            $msg = 'Ocurrió un error. Inténtalo de nuevo.';
                                    }
                                    echo '<div class="alert alert-' . $type . ' alert-dismissible fade show" role="alert">'
                                        . htmlspecialchars($msg)
                                        . '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>';
                                }
                                if (isset($_POST["Mensaje"])) {
                                    echo '<div class="alert alert-' . htmlspecialchars($_POST["TipoMensaje"] ?? 'danger') . ' alert-dismissible fade show" role="alert">'
                                        . htmlspecialchars($_POST["Mensaje"])
                                        . '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>';
                                }
                                ?>

                                <form id="formLogin" action="" method="POST" novalidate>
                                    <div class="mb-3">
                                        <label for="CorreoElectronico" class="form-label">Correo Electrónico</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="lni lni-envelope"></i></span>
                                            <input type="email" class="form-control" id="CorreoElectronico" name="CorreoElectronico"
                                                placeholder="correo@ejemplo.com" required>
                                        </div>
                                        <div class="invalid-feedback">Ingrese un correo electrónico válido.</div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="Contrasenna" class="form-label">Contraseña</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="lni lni-lock"></i></span>
                                            <input type="password" class="form-control" id="Contrasenna" name="Contrasenna"
                                                placeholder="Ingrese su contraseña" required>
                                        </div>
                                        <div class="invalid-feedback">Campo obligatorio.</div>
                                    </div>
                                    <div class="d-grid">
                                        <button type="submit" name="btnIniciarSesion" class="btn btn-success btn-lg" style="background:#2ecc71;border:none;">
                                            <i class="lni lni-enter me-2"></i>Ingresar
                                        </button>
                                    </div>
                                </form>

                                <div class="text-center mt-3">
                                    <p class="mb-1">¿No tienes cuenta? <a href="registro.php" class="text-primary fw-bold">Regístrate aquí</a></p>
                                    <p class="mb-0"><a href="recuperarAcceso.php" class="text-muted small">¿Olvidaste tu contraseña?</a></p>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <?php MostrarFooter(); ?>

    </main>

    <?php MostrarJS(); ?>
    <script src="../funciones/login.js"></script>

</body>
</html>
