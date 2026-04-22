<?php
if (php_sapi_name() === 'cli') return;

if (session_status() == PHP_SESSION_NONE) session_start();

$uri = $_SERVER['REQUEST_URI'] ?? '';
$uri = parse_url($uri, PHP_URL_PATH);

$publicPrefixes = [
    '/PowerZone/Views/Home/inicio.php',
    '/PowerZone/Views/Home/registro.php',
    '/PowerZone/Views/Home/recuperarAcceso.php',
    '/PowerZone/index.php',
];

$publicContains = [
    '/assets/',
    '/Controllers/',
];

$allowedExt = ['css','js','png','jpg','jpeg','gif','svg','ico','woff','woff2','ttf','map'];

foreach ($publicPrefixes as $p) {
    if (strpos($uri, $p) === 0) return;
}

foreach ($publicContains as $c) {
    if (strpos($uri, $c) !== false) return;
}

$ext = pathinfo($uri, PATHINFO_EXTENSION);
if ($ext && in_array(strtolower($ext), $allowedExt, true)) return;

if (!empty($_SESSION['usuario_logueado'])) return;

header('Location: /PowerZone/Views/Home/inicio.php?error=must_login');
exit;
