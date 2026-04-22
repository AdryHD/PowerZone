document.addEventListener('DOMContentLoaded', function () {
    var btn = document.getElementById('btnConfirmarCerrarSesion');
    if (!btn) return;
    btn.addEventListener('click', function () {
        $.ajax({
            url: '/PowerZone/Controllers/HomeController.php',
            method: 'POST',
            dataType: 'json',
            data: { btnCerrarSesion: true },
            success: function () {
                window.location.href = '/PowerZone/Views/Home/inicio.php';
            }
        });
    });
});
