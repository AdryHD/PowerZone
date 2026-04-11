<?php
include_once $_SERVER["DOCUMENT_ROOT"] . "/G4_AmbienteWeb/Views/layout.php";
include_once $_SERVER["DOCUMENT_ROOT"] . "/G4_AmbienteWeb/Controllers/PedidoController.php";

$idPedido = $_GET["id"] ?? null;
$datos = ConsultarPedido($idPedido);

$pedidosAgrupados = [];
if ($idPedido === null && !empty($datos)) {
    foreach ($datos as $fila) {
        $key = $fila['id_pedido']; 
        if (!isset($pedidosAgrupados[$key])) {
            $pedidosAgrupados[$key] = $fila;
        }
    }
}

// Función auxiliar para determinar el color del badge según el estado
function obtenerColorEstado($estado) {
    switch (strtolower($estado)) {
        case 'pendiente': return 'bg-warning text-dark';
        case 'empacado':  return 'bg-info text-dark';
        case 'enviado':   return 'bg-success';
        default:          return 'bg-secondary';
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<?php MostrarCSS(); ?>
<body>
<?php MostrarNav(); ?>

<main class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-11">

            <?php if ($idPedido !== null && !empty($datos)): ?>
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h3 class="mb-0"><i class="lni lni-cart-full me-2"></i>Detalle del Pedido #<?php echo $idPedido; ?></h3>
                        <p class="text-muted">Cliente: <strong><?php echo htmlspecialchars($datos[0]['Nombre_Cliente']); ?></strong></p>
                    </div>
                    <a href="consultarPedido.php" class="btn btn-outline-primary btn-sm">Volver al Listado</a>
                </div>

                <div class="table-responsive shadow-sm mb-4">
                    <table class="table table-bordered align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Producto</th>
                                <th>Talla</th>
                                <th>Color</th>
                                <th>Cantidad</th>
                                <th>Stock Actual</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($datos as $it): ?>
                            <tr>
                                <td><strong><?php echo htmlspecialchars($it['Nombre_Producto']); ?></strong></td>
                                <td><?php echo htmlspecialchars($it['Talla']); ?></td>
                                <td><?php echo htmlspecialchars($it['Color']); ?></td>
                                <td><?php echo $it['Cantidad']; ?></td>
                                <td><span class="badge bg-secondary"><?php echo $it['Stock']; ?></span></td>
                            </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>

                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-header bg-white py-3">
                        <h6 class="fw-bold mb-0"><i class="lni lni-delivery me-2"></i>Gestión de Logística y Entrega</h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 border-end">
                                <p class="mb-1 text-muted small text-uppercase fw-bold">Información del Cliente</p>
                                <p class="mb-1"><strong>Dirección:</strong> <?php echo htmlspecialchars($datos[0]['Direccion']); ?></p>
                                <p class="mb-1"><strong>Teléfono:</strong> <?php echo htmlspecialchars($datos[0]['Telefono']); ?></p>
                                <p class="mb-1"><strong>Método de Pago:</strong> <?php echo htmlspecialchars($datos[0]['Metodo_pago']); ?></p>
                            </div>
                            <div class="col-md-6 ps-md-4">
                                <p class="mb-1 text-muted small text-uppercase fw-bold">Estado del Pedido</p>
                                <div class="d-flex align-items-center mb-3">
                                    <span class="badge <?php echo obtenerColorEstado($datos[0]['Estado']); ?> fs-6 p-2">
                                        <?php echo strtoupper($datos[0]['Estado']); ?>
                                    </span>
                                </div>
                                
                             <form method="POST" action="">
    <input type="hidden" name="idPedido" value="<?php echo $idPedido; ?>">
    
    <div class="d-grid gap-2">
        <?php 
        // Limpiamos el estado de espacios y lo pasamos a minúsculas para comparar
        $estadoActual = trim(strtolower($datos[0]['Estado'])); 
        ?>

        <?php if ($estadoActual == 'pendiente'): ?>
            <input type="hidden" name="nuevoEstado" value="empacado">
            <button type="submit" name="btnCambiarEstado" class="btn btn-warning py-2">
                <i class="lni lni-package me-2"></i>Pasar a EMPACADO
            </button>

        <?php elseif ($estadoActual == 'empacado'): ?>
            <input type="hidden" name="nuevoEstado" value="enviado">
            <button type="submit" name="btnCambiarEstado" class="btn btn-success py-2">
                <i class="lni lni-delivery me-2"></i>Pasar a ENVIADO
            </button>

        <?php else: ?>
            <div class="alert alert-success d-flex align-items-center mb-0 shadow-sm">
                <i class="lni lni-checkmark-circle fs-4 me-2"></i>
                <div>
                    <strong>Pedido Finalizado</strong><br>
                    Estado: <?php echo strtoupper($estadoActual); ?>
                </div>
            </div>
        <?php endif; ?>
    </div>
</form>
                            </div>
                        </div>
                    </div>
                </div>

            <?php elseif ($idPedido === null): ?>
                <h3 class="fw-bold mb-4">Gestión General de Pedidos (Admin)</h3>
                
                <div class="table-responsive shadow-sm rounded">
                    <table class="table table-hover bg-white align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th># Pedido</th>
                                <th>Cliente</th>
                                <th>Fecha</th>
                                <th>Teléfono</th>
                                <th>Estado</th>
                                <th class="text-center">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php if(empty($pedidosAgrupados)): ?>
                                <tr><td colspan="6" class="text-center py-4">No hay pedidos registrados en el sistema.</td></tr>
                            <?php else: ?>
                                <?php foreach ($pedidosAgrupados as $p): ?>
                                <tr>
                                    <td><strong>#<?php echo $p['id_pedido']; ?></strong></td>
                                    <td><?php echo htmlspecialchars($p['Nombre_Cliente']); ?></td>
                                    <td><?php echo date('d/m/Y H:i', strtotime($p['Fecha_pedido'])); ?></td>
                                    <td><?php echo htmlspecialchars($p['Telefono']); ?></td>
                                    <td>
                                        <span class="badge <?php echo obtenerColorEstado($p['Estado']); ?>">
                                            <?php echo strtoupper($p['Estado']); ?>
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <a href="consultarPedido.php?id=<?php echo $p['id_pedido']; ?>" class="btn btn-primary btn-sm">
                                            <i class="lni lni-eye"></i> Ver Detalle
                                        </a>
                                    </td>
                                </tr>
                                <?php endforeach; ?>
                            <?php endif; ?>
                        </tbody>
                    </table>
                </div>
            <?php else: ?>
                <div class="alert alert-warning text-center">No se encontraron datos para el pedido solicitado.</div>
            <?php endif; ?>

        </div>
    </div>
</main>

<?php MostrarFooter(); ?>
</body>
</html>