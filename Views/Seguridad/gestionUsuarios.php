<?php
include_once $_SERVER["DOCUMENT_ROOT"] . "/PowerZone/Views/layout.php";
include_once $_SERVER["DOCUMENT_ROOT"] . "/PowerZone/Controllers/SeguridadController.php";

if (!isset($_SESSION["usuario_rol"]) || $_SESSION["usuario_rol"] != 1) {
    header("Location: /PowerZone/Views/Home/home.php");
    exit;
}

$usuarios = ConsultarUsuarios();
?>
<!DOCTYPE html>
<html lang="es">
<?php MostrarCSS(); ?>
<body>
<?php MostrarNav(); ?>

<main class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-11">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h3 class="mb-0"><i class="lni lni-users me-2"></i>Gestión de Usuarios</h3>
                    <p class="text-muted mb-0">Administre los roles y estados de los usuarios del sistema</p>
                </div>
            </div>

            <div class="card border-0 shadow-sm">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0" id="tUsuarios">
                            <thead style="background: linear-gradient(135deg,#1A1A1A,#000); color:#fff;">
                                <tr>
                                    <th class="px-4 py-3">ID</th>
                                    <th class="px-4 py-3">Cédula</th>
                                    <th class="px-4 py-3">Nombre</th>
                                    <th class="px-4 py-3">Correo</th>
                                    <th class="px-4 py-3">Estado</th>
                                    <th class="px-4 py-3">Fecha Registro</th>
                                    <th class="px-4 py-3 text-center">Rol</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($usuarios as $u): ?>
                                <tr>
                                    <td class="px-4"><?php echo (int)$u['id_usuario']; ?></td>
                                    <td class="px-4"><?php echo htmlspecialchars($u['cedula'] ?? '-'); ?></td>
                                    <td class="px-4 fw-semibold"><?php echo htmlspecialchars($u['nombre']); ?></td>
                                    <td class="px-4"><?php echo htmlspecialchars($u['correo']); ?></td>
                                    <td class="px-4">
                                        <?php if ((int)$u['id_usuario'] === (int)$_SESSION['usuario_id']): ?>
                                            <span class="badge bg-success">Activo</span>
                                        <?php else: ?>
                                            <span class="badge <?php echo $u['estado'] === 'activo' ? 'bg-success' : 'bg-secondary'; ?> badge-estado" style="cursor:pointer;"
                                                data-id="<?php echo (int)$u['id_usuario']; ?>"
                                                data-estado="<?php echo htmlspecialchars($u['estado']); ?>"
                                                title="Clic para cambiar estado">
                                                <?php echo $u['estado'] === 'activo' ? 'Activo' : 'Inactivo'; ?>
                                            </span>
                                        <?php endif; ?>
                                    </td>
                                    <td class="px-4"><?php echo htmlspecialchars($u['fecha_registro']); ?></td>
                                    <td class="px-4 text-center">
                                        <?php if ((int)$u['id_usuario'] === (int)$_SESSION['usuario_id']): ?>
                                            <span class="badge" style="background:#2ECC71;"><?php echo htmlspecialchars($u['nombre_rol']); ?></span>
                                        <?php else: ?>
                                            <select class="form-select form-select-sm select-rol" style="max-width:150px; margin:0 auto;"
                                                data-id="<?php echo (int)$u['id_usuario']; ?>"
                                                data-actual="<?php echo (int)$u['id_rol']; ?>">
                                                <option value="1" <?php echo $u['id_rol'] == 1 ? 'selected' : ''; ?>>Administrador</option>
                                                <option value="2" <?php echo $u['id_rol'] == 2 ? 'selected' : ''; ?>>Cliente</option>
                                            </select>
                                        <?php endif; ?>
                                    </td>
                                </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<div class="modal fade" id="modalConfirmarEstado" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" style="max-width:420px;">
    <div class="modal-content border-0 shadow">
      <div class="modal-header" style="background:linear-gradient(135deg,#2ECC71 0%,#1A8A4A 100%);">
        <h5 class="modal-title text-white fw-bold"><i class="lni lni-users me-2"></i>Cambiar Estado</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body text-center py-4">
        <i class="lni lni-question-circle" style="font-size:3rem;color:#2ECC71;"></i>
        <p class="mt-3 mb-0 fs-6" id="txtConfirmarEstado"></p>
      </div>
      <div class="modal-footer border-0 justify-content-center gap-2">
        <button type="button" class="btn btn-secondary" id="btnCancelarEstado">Cancelar</button>
        <button type="button" class="btn text-white fw-semibold" style="background:#2ECC71;border:none;" id="btnConfirmarEstado">Sí, cambiar</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modalConfirmarRol" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" style="max-width:420px;">
    <div class="modal-content border-0 shadow">
      <div class="modal-header" style="background:linear-gradient(135deg,#2ECC71 0%,#1A8A4A 100%);">
        <h5 class="modal-title text-white fw-bold"><i class="lni lni-users me-2"></i>Cambiar Rol</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body text-center py-4">
        <i class="lni lni-question-circle" style="font-size:3rem;color:#2ECC71;"></i>
        <p class="mt-3 mb-0 fs-6" id="txtConfirmarRol"></p>
      </div>
      <div class="modal-footer border-0 justify-content-center gap-2">
        <button type="button" class="btn btn-secondary" id="btnCancelarRol" data-bs-dismiss="modal">Cancelar</button>
        <button type="button" class="btn text-white fw-semibold" style="background:#2ECC71;border:none;" id="btnConfirmarRol">Sí, cambiar</button>
      </div>
    </div>
  </div>
</div>

<?php MostrarFooter(); ?>
<script src="/PowerZone/Views/funciones/gestionUsuarios.js"></script>
<?php MostrarJS(); ?>
<script src="/PowerZone/Views/funciones/gestionUsuarios.js"></script>
</body>
</html>
