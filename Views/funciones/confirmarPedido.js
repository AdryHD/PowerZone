document.addEventListener('DOMContentLoaded', function() {
    const datos = JSON.parse(localStorage.getItem('datos_envio'));

    if (!datos) {
        alert('No hay información del pedido.');
        window.location.href = 'carrito.php';
        return;
    }

    document.getElementById('dispDireccion').innerText = datos.direccion;
    document.getElementById('dispTelefono').innerText = datos.telefono;
    document.getElementById('dispMetodo').innerText = datos.metodo_pago;
    document.getElementById('dispNotas').innerText = datos.observaciones || 'Ninguna';

    document.getElementById('btnPasoFinal').addEventListener('click', function() {
        if (datos.metodo_pago === 'Tarjeta') {
            window.location.href = '/PowerZone/Views/Producto/pagoSimulado.php';
        } else {
            window.location.href = '/PowerZone/Views/Producto/transferencia.php';
        }
    });
});
