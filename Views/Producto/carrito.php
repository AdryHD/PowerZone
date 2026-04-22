<?php
header('Cache-Control: no-store, no-cache, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
include_once $_SERVER["DOCUMENT_ROOT"] . "/PowerZone/Views/layout.php";
include_once $_SERVER["DOCUMENT_ROOT"] . "/PowerZone/Controllers/CarritoController.php";

if (session_status() === PHP_SESSION_NONE) session_start();

$items = ObtenerCarrito();

$lista = [];
$total = 0.00;
$cartId = null;
if (!empty($items) && is_array($items)) {
    foreach ($items as $row) {
        $cartId = $row['id_carrito'] ?? $cartId;
        $id_det = $row['id_detalle'];
        $precio = (float)($row['precio_unitario'] ?? 0);
        $cant   = (int)($row['cantidad'] ?? 0);
        $subtotal = $precio * $cant;
        $lista[$id_det] = [
            'id_detalle' => $id_det,
            'id_producto' => $row['id_producto'] ?? null,
            'nombre' => $row['nombre_producto'] ?? '',
            'imagen' => $row['imagen'] ?? '',
            'talla' => $row['talla'] ?? '',
            'color' => $row['color'] ?? '',
            'precio_unitario' => $precio,
            'cantidad' => $cant,
            'subtotal' => $subtotal
        ];
        $total += $subtotal;
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<?php MostrarCSS(); ?>
<body>
<?php MostrarNav(); ?>

<main class="container" style="padding:30px 0; min-height:60vh;">
    <div class="row">
        <div class="col-md-8">
            <h3 class="fw-bold">Resumen del Carrito</h3>
            <?php if (empty($lista)): ?>
                <div class="alert alert-info mt-4">Tu carrito está vacío. <a href="/PowerZone/Views/Producto/tienda.php">Ir a tienda</a></div>
            <?php else: ?>
                <div class="table-responsive mt-4">
                    <table class="table align-middle">
                        <thead>
                            <tr>
                                <th>Producto</th>
                                <th>Precio</th>
                                <th style="width:120px;">Cantidad</th>
                                <th>Subtotal</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                        <?php foreach ($lista as $it): ?>
                            <tr data-id="<?php echo $it['id_detalle']; ?>">
                                <td>
                                    <div style="display:flex;gap:12px;align-items:center;">
                                        <?php if (!empty($it['imagen'])): ?>
                                            <img src="<?php echo htmlspecialchars($it['imagen']); ?>" alt="" style="width:70px;height:70px;object-fit:cover;border-radius:8px;">
                                        <?php else: ?>
                                            <div style="width:70px;height:70px;background:#f0f0f0;border-radius:8px;display:flex;align-items:center;justify-content:center;color:#999;">No img</div>
                                        <?php endif; ?>
                                        <div>
                                            <div class="fw-bold"><?php echo htmlspecialchars($it['nombre']); ?></div>
                                            <small class="text-muted"><?php echo htmlspecialchars($it['talla']); ?> <?php echo htmlspecialchars($it['color']); ?></small>
                                        </div>
                                    </div>
                                </td>
                                <td>₡<?php echo number_format($it['precio_unitario'], 2); ?></td>
                                <td>
                                    <div class="input-group">
                                        <input type="number" min="1" class="form-control qty-input" value="<?php echo $it['cantidad']; ?>">
                                        <button class="btn btn-outline-secondary btn-update" type="button">Actualizar</button>
                                    </div>
                                </td>
                                <td>₡<?php echo number_format($it['subtotal'], 2); ?></td>
                                <td>
                                    <button class="btn btn-sm btn-danger btn-remove">Eliminar</button>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            <?php endif; ?>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm p-3">
                <h5 class="fw-bold">Resumen</h5>
                <div class="d-flex justify-content-between mt-3">
                    <div>Subtotal</div>
                    <div>₡<?php echo number_format($total, 2); ?></div>
                </div>
                <div class="d-flex justify-content-between mt-2">
                    <div>Envío</div>
                    <div>₡0.00</div>
                </div>
                <hr>
                <div class="d-flex justify-content-between fw-bold fs-5">
                    <div>Total</div>
                    <div>₡<?php echo number_format($total, 2); ?></div>
                </div>

                <div class="mt-4">
                    <button id="btnVaciar" class="btn btn-outline-secondary w-100 mb-2">Vaciar carrito</button>
                    <button id="btnCancelar" class="btn btn-warning w-100 mb-2">Cancelar carrito</button>
                </div>

                <hr>
                <h6 class="fw-bold">Datos del pedido</h6>
                <form id="formFinalizar">
                    <div class="mb-2">
                        <input type="text" name="direccion" class="form-control" placeholder="Dirección de envío" required>
                    </div>
                    <div class="mb-2">
                        <input type="text" name="telefono" class="form-control" placeholder="Teléfono" required>
                    </div>
                    <div class="mb-2">
                        <select name="metodo_pago" class="form-select" required>
                            <option value="">Seleccione método de pago</option>
                            <option value="Tarjeta">Tarjeta</option>
                            <option value="Transferencia">Transferencia</option>
                        </select>
                    </div>
                    <div class="mb-2">
                        <textarea name="observaciones" class="form-control" placeholder="Observaciones (opcional)" rows="2"></textarea>
                    </div>
                    <button class="btn btn-success w-100" id="btnFinalizar" type="submit">Confirmar</button>
                </form>
            </div>
        </div>
    </div>
</main>

<div class="modal fade" id="modalEliminarItem" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" style="max-width:400px;">
    <div class="modal-content border-0 shadow">
      <div class="modal-header" style="background:linear-gradient(135deg,#2ECC71 0%,#1A8A4A 100%);">
        <h5 class="modal-title text-white fw-bold"><i class="lni lni-trash me-2"></i>Eliminar producto</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body text-center py-4">
        <i class="lni lni-question-circle" style="font-size:3rem;color:#2ECC71;"></i>
        <p class="mt-3 mb-0 fs-6">¿Deseas eliminar este producto del carrito?</p>
      </div>
      <div class="modal-footer border-0 justify-content-center gap-2">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button type="button" class="btn text-white fw-semibold" style="background:#2ECC71;border:none;" id="btnConfirmarEliminarItem" data-bs-dismiss="modal">Sí, eliminar</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modalVaciarCarrito" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" style="max-width:400px;">
    <div class="modal-content border-0 shadow">
      <div class="modal-header" style="background:linear-gradient(135deg,#2ECC71 0%,#1A8A4A 100%);">
        <h5 class="modal-title text-white fw-bold"><i class="lni lni-trash me-2"></i>Vaciar carrito</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body text-center py-4">
        <i class="lni lni-question-circle" style="font-size:3rem;color:#2ECC71;"></i>
        <p class="mt-3 mb-0 fs-6">¿Deseas vaciar todos los productos del carrito?</p>
      </div>
      <div class="modal-footer border-0 justify-content-center gap-2">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button type="button" class="btn text-white fw-semibold" style="background:#2ECC71;border:none;" id="btnConfirmarVaciar" data-bs-dismiss="modal">Sí, vaciar</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modalCancelarCarrito" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" style="max-width:400px;">
    <div class="modal-content border-0 shadow">
      <div class="modal-header" style="background:linear-gradient(135deg,#2ECC71 0%,#1A8A4A 100%);">
        <h5 class="modal-title text-white fw-bold"><i class="lni lni-close me-2"></i>Cancelar carrito</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body text-center py-4">
        <i class="lni lni-question-circle" style="font-size:3rem;color:#2ECC71;"></i>
        <p class="mt-3 mb-0 fs-6">¿Deseas cancelar el carrito? Esta acción eliminará todos los productos.</p>
      </div>
      <div class="modal-footer border-0 justify-content-center gap-2">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button type="button" class="btn text-white fw-semibold" style="background:#2ECC71;border:none;" id="btnConfirmarCancelar" data-bs-dismiss="modal">Sí, cancelar</button>
      </div>
    </div>
  </div>
</div>

<?php MostrarFooter(); ?>
<?php MostrarJS(); ?>

<script src="../funciones/carrito.js"></script>

</body>
</html>
