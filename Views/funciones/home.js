history.pushState(null, '', location.href);
window.addEventListener('popstate', function() {
    history.pushState(null, '', location.href);
});

function _updateCartBadge() {
    fetch('/PowerZone/Controllers/CarritoController.php', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: new URLSearchParams({action: 'contar'})
    })
    .then(r => r.json())
    .then(data => {
        if (data && typeof data.total !== 'undefined') {
            const badge = document.getElementById('cart-badge');
            if (badge) badge.textContent = data.total;
        }
    })
    .catch(() => {});
}

function agregarAlCarrito(idProducto, nombre, btn) {
    const original = btn.innerHTML;
    btn.disabled = true;
    btn.innerHTML = '<i class="lni lni-checkmark-circle me-1"></i>Agregado';
    btn.style.background = 'linear-gradient(135deg,#27a654,#1a7a3f)';

    fetch('/PowerZone/Controllers/CarritoController.php', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest'},
        body: new URLSearchParams({action: 'agregar', id_producto: idProducto, cantidad: 1})
    })
    .then(r => r.json())
    .then(() => {
        _updateCartBadge();
        setTimeout(() => location.reload(), 700);
    })
    .catch(() => {})
    .finally(() => {
        setTimeout(() => {
            btn.disabled = false;
            btn.innerHTML = original;
            btn.style.background = '#111';
        }, 900);
    });
}
