document.addEventListener('DOMContentLoaded', function () {
    let _selectPendiente = null;
    let _valorAnterior   = null;

    const modal      = new bootstrap.Modal(document.getElementById('modalConfirmarRol'));
    const txtConfirm = document.getElementById('txtConfirmarRol');
    const btnConfirm = document.getElementById('btnConfirmarRol');
    const btnCancelar = document.getElementById('btnCancelarRol');

    document.querySelectorAll('.select-rol').forEach(function (select) {
        select.addEventListener('change', function () {
            _selectPendiente = this;
            _valorAnterior   = this.getAttribute('data-actual');
            const nuevoTexto = this.options[this.selectedIndex].text;
            txtConfirm.textContent = '¿Deseas cambiar el rol de este usuario a "' + nuevoTexto + '"?';
            modal.show();
        });
    });

    btnCancelar.addEventListener('click', function () {
        if (_selectPendiente && _valorAnterior !== null) {
            _selectPendiente.value = _valorAnterior;
        }
    });

    btnConfirm.addEventListener('click', function () {
        if (!_selectPendiente) return;

        const idUsuario = _selectPendiente.getAttribute('data-id');
        const idRol     = _selectPendiente.value;

        $.ajax({
            url: '/PowerZone/Controllers/SeguridadController.php',
            method: 'POST',
            dataType: 'json',
            data: { btnActualizarRol: true, idUsuario: idUsuario, idRol: idRol },
            success: function (resp) {
                if (resp.ok) {
                    _selectPendiente.setAttribute('data-actual', idRol);
                    modal.hide();
                } else {
                    _selectPendiente.value = _valorAnterior;
                    modal.hide();
                }
            },
            error: function () {
                _selectPendiente.value = _valorAnterior;
                modal.hide();
            }
        });
    });

    let _badgePendiente = null;

    const modalEstado    = new bootstrap.Modal(document.getElementById('modalConfirmarEstado'));
    const txtEstado      = document.getElementById('txtConfirmarEstado');
    const btnEstado      = document.getElementById('btnConfirmarEstado');
    const btnCancelarEst = document.getElementById('btnCancelarEstado');

    btnCancelarEst.addEventListener('click', function () {
        modalEstado.hide();
    });

    document.querySelectorAll('.badge-estado').forEach(function (badge) {
        badge.addEventListener('click', function () {
            _badgePendiente = this;
            const estadoActual = this.getAttribute('data-estado');
            const nuevoEstado  = estadoActual === 'activo' ? 'inactivo' : 'activo';
            txtEstado.textContent = '¿Deseas cambiar el estado de este usuario a "' + nuevoEstado + '"?';
            modalEstado.show();
        });
    });

    btnEstado.addEventListener('click', function () {
        if (!_badgePendiente) return;

        const idUsuario    = _badgePendiente.getAttribute('data-id');
        const estadoActual = _badgePendiente.getAttribute('data-estado');
        const nuevoEstado  = estadoActual === 'activo' ? 'inactivo' : 'activo';

        $.ajax({
            url: '/PowerZone/Controllers/SeguridadController.php',
            method: 'POST',
            dataType: 'json',
            data: { btnActualizarEstado: true, idUsuario: idUsuario, estado: nuevoEstado },
            success: function (resp) {
                if (resp.ok) {
                    _badgePendiente.setAttribute('data-estado', nuevoEstado);
                    _badgePendiente.textContent = nuevoEstado === 'activo' ? 'Activo' : 'Inactivo';
                    _badgePendiente.className   = 'badge badge-estado ' + (nuevoEstado === 'activo' ? 'bg-success' : 'bg-secondary');
                    _badgePendiente.style.cursor = 'pointer';
                }
                modalEstado.hide();
            },
            error: function () {
                modalEstado.hide();
            }
        });
    });
});
