function postAction(data) {
    return fetch('/PowerZone/Controllers/CarritoController.php', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: new URLSearchParams(data)
    }).then(r => r.json());
}

document.querySelectorAll('.btn-update').forEach(btn => {
    btn.addEventListener('click', function() {
        const tr = this.closest('tr');
        const id_det = tr.getAttribute('data-id');
        const qty = tr.querySelector('.qty-input').value;
        if (!id_det) return;
        postAction({action: 'actualizar', id_detalle: id_det, cantidad: qty})
            .then(() => { location.reload(); })
            .catch(() => { alert('Error al actualizar'); });
    });
});

let _idDetalleEliminar = null;

document.querySelectorAll('.btn-remove').forEach(btn => {
    btn.addEventListener('click', function() {
        const tr = this.closest('tr');
        _idDetalleEliminar = tr.getAttribute('data-id');
        new bootstrap.Modal(document.getElementById('modalEliminarItem')).show();
    });
});

document.getElementById('btnConfirmarEliminarItem').addEventListener('click', function() {
    if (!_idDetalleEliminar) return;
    postAction({action: 'eliminar', id_detalle: _idDetalleEliminar})
        .then(() => { location.reload(); })
        .catch(() => {});
});

document.getElementById('btnVaciar').addEventListener('click', function() {
    new bootstrap.Modal(document.getElementById('modalVaciarCarrito')).show();
});

document.getElementById('btnConfirmarVaciar').addEventListener('click', function() {
    postAction({action: 'vaciar'})
        .then(() => { location.reload(); })
        .catch(() => {});
});

document.getElementById('btnCancelar').addEventListener('click', function() {
    new bootstrap.Modal(document.getElementById('modalCancelarCarrito')).show();
});

document.getElementById('btnConfirmarCancelar').addEventListener('click', function() {
    postAction({action: 'cancelar'})
        .then(() => { location.reload(); })
        .catch(() => {});
});

document.getElementById('formFinalizar').addEventListener('submit', function(e) {
    e.preventDefault();
    const formData = new FormData(this);
    const infoEnvio = {};
    formData.forEach((value, key) => { infoEnvio[key] = value; });
    localStorage.setItem('datos_envio', JSON.stringify(infoEnvio));
    window.location.href = '/PowerZone/Views/Producto/confirmarPedido.php';
});
