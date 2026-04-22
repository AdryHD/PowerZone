-- MariaDB dump 10.19  Distrib 10.4.28-MariaDB, for osx10.10 (x86_64)
--
-- Host: 127.0.0.1    Database: power_zone
-- ------------------------------------------------------
-- Server version	10.4.28-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `carrito`
--

DROP TABLE IF EXISTS `carrito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carrito` (
  `id_carrito` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp(),
  `estado` enum('activo','completado','cancelado') NOT NULL DEFAULT 'activo',
  PRIMARY KEY (`id_carrito`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrito`
--

LOCK TABLES `carrito` WRITE;
/*!40000 ALTER TABLE `carrito` DISABLE KEYS */;
INSERT INTO `carrito` VALUES (1,39,'2026-04-12 13:22:13','completado'),(2,39,'2026-04-12 13:27:48','completado'),(3,37,'2026-04-12 13:32:18','completado'),(4,37,'2026-04-12 13:34:21','completado'),(5,39,'2026-04-12 13:41:07','completado'),(6,37,'2026-04-14 13:51:18','cancelado'),(7,37,'2026-04-22 00:09:01','completado'),(8,37,'2026-04-22 01:00:38','activo'),(9,39,'2026-04-22 01:03:07','activo'),(10,40,'2026-04-22 01:28:48','completado'),(11,40,'2026-04-22 01:35:45','completado'),(12,40,'2026-04-22 01:36:59','completado'),(13,40,'2026-04-22 01:42:23','completado'),(14,40,'2026-04-22 01:45:59','completado'),(15,40,'2026-04-22 01:55:11','completado'),(16,41,'2026-04-22 10:37:16','completado'),(17,40,'2026-04-22 10:43:24','completado'),(18,40,'2026-04-22 10:54:18','completado'),(19,40,'2026-04-22 11:00:57','completado'),(20,40,'2026-04-22 11:16:37','completado');
/*!40000 ALTER TABLE `carrito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carrito_detalle`
--

DROP TABLE IF EXISTS `carrito_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carrito_detalle` (
  `id_detalle` int(11) NOT NULL AUTO_INCREMENT,
  `id_carrito` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT 1,
  `precio_unitario` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `id_carrito` (`id_carrito`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `carrito_detalle_ibfk_1` FOREIGN KEY (`id_carrito`) REFERENCES `carrito` (`id_carrito`),
  CONSTRAINT `carrito_detalle_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrito_detalle`
--

LOCK TABLES `carrito_detalle` WRITE;
/*!40000 ALTER TABLE `carrito_detalle` DISABLE KEYS */;
INSERT INTO `carrito_detalle` VALUES (1,1,2,1,79990.00),(2,2,2,1,79990.00),(3,3,2,1,79990.00),(4,4,2,1,79990.00),(5,5,2,1,79990.00),(6,5,3,1,24990.00),(8,7,2,1,79990.00),(9,8,2,1,79990.00),(11,10,1,1,29990.00),(12,11,3,1,24990.00),(13,12,1,1,29990.00),(14,13,4,3,39990.00),(15,14,2,1,79990.00),(16,14,1,1,29990.00),(24,15,1,2,29990.00),(25,15,3,1,24990.00),(26,8,3,1,24990.00),(30,16,2,1,79990.00),(31,16,1,1,25000.00),(32,17,5,1,30000.00),(33,18,2,1,79990.00),(34,19,7,1,8000.00),(35,20,4,1,39990.00);
/*!40000 ALTER TABLE `carrito_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `estado` enum('activo','inactivo') NOT NULL DEFAULT 'activo',
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Ropa Deportiva','activo'),(2,'Zapatos Deportivos','activo'),(3,'Accesorios','activo');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido_detalle`
--

DROP TABLE IF EXISTS `pedido_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedido_detalle` (
  `id_detalle` int(11) NOT NULL AUTO_INCREMENT,
  `id_pedido` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `id_pedido` (`id_pedido`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `pedido_detalle_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`),
  CONSTRAINT `pedido_detalle_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido_detalle`
--

LOCK TABLES `pedido_detalle` WRITE;
/*!40000 ALTER TABLE `pedido_detalle` DISABLE KEYS */;
INSERT INTO `pedido_detalle` VALUES (1,1,2,1,79990.00,79990.00),(2,2,2,1,79990.00,79990.00),(3,3,2,1,79990.00,79990.00),(4,4,2,1,79990.00,79990.00),(5,5,2,1,79990.00,79990.00),(6,5,3,1,24990.00,24990.00),(8,6,2,1,79990.00,79990.00),(9,7,1,1,29990.00,29990.00),(10,8,3,1,24990.00,24990.00),(11,9,1,1,29990.00,29990.00),(12,10,4,3,39990.00,119970.00),(13,11,2,1,79990.00,79990.00),(14,11,1,1,29990.00,29990.00),(16,12,1,2,29990.00,59980.00),(17,12,3,1,24990.00,24990.00),(19,13,2,1,79990.00,79990.00),(20,13,1,1,25000.00,25000.00),(22,14,5,1,30000.00,30000.00),(23,15,2,1,79990.00,79990.00),(24,16,7,1,8000.00,8000.00),(25,17,4,1,39990.00,39990.00);
/*!40000 ALTER TABLE `pedido_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedidos` (
  `id_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `fecha_pedido` datetime NOT NULL DEFAULT current_timestamp(),
  `direccion` varchar(200) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `estado` enum('pendiente','procesando','enviado','entregado','cancelado') NOT NULL DEFAULT 'pendiente',
  `observaciones` text DEFAULT NULL,
  `metodo_pago` varchar(50) NOT NULL,
  `num_comprobante` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,39,'2026-04-12 13:23:31','Heredia','88888888',79990.00,'enviado','','Transferencia',NULL),(2,39,'2026-04-12 13:28:00','Heredia','88888888',79990.00,'pendiente','1233','Efectivo',NULL),(3,37,'2026-04-12 13:33:14','Heredia','88888888',79990.00,'pendiente','123456','Tarjeta',NULL),(4,37,'2026-04-12 13:35:17','Heredia','88888888',79990.00,'pendiente','123','Tarjeta',NULL),(5,39,'2026-04-12 13:43:16','Heredia','88888888',104980.00,'pendiente','s','Tarjeta',NULL),(6,37,'2026-04-22 00:09:39','Heredia','88888888',79990.00,'procesando','','Tarjeta',NULL),(7,40,'2026-04-22 01:31:20','Heredia','88888888',29990.00,'pendiente','','Tarjeta',NULL),(8,40,'2026-04-22 01:36:28','Heredia','88888888',24990.00,'pendiente','','Transferencia',NULL),(9,40,'2026-04-22 01:37:51','Heredia','88888888',29990.00,'pendiente','','Tarjeta',NULL),(10,40,'2026-04-22 01:43:26','Heredia','88888888',119970.00,'pendiente','','Tarjeta',NULL),(11,40,'2026-04-22 01:52:56','Heredia','88888888',109980.00,'enviado','','Tarjeta',NULL),(12,40,'2026-04-22 02:02:09','Heredia','88888888',84970.00,'pendiente','','Tarjeta',NULL),(13,41,'2026-04-22 10:39:19','Heredia','88888888',104990.00,'pendiente','','Transferencia',NULL),(14,40,'2026-04-22 10:51:36','Heredia','88888888',30000.00,'pendiente','','Transferencia',NULL),(15,40,'2026-04-22 10:54:41','Heredia','88888888',79990.00,'pendiente','','Transferencia',NULL),(16,40,'2026-04-22 11:01:26','Heredia','88888888',8000.00,'pendiente','','Transferencia',NULL),(17,40,'2026-04-22 11:16:56','Heredia','88888888',39990.00,'procesando','','Transferencia','123456');
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL AUTO_INCREMENT,
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(120) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `talla` varchar(5) DEFAULT NULL,
  `color` varchar(30) DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `estado` enum('activo','inactivo') NOT NULL DEFAULT 'activo',
  `en_oferta` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id_producto`),
  KEY `id_categoria` (`id_categoria`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,1,'Camiseta Deportiva Pro','Tecnología Dri-FIT para máximo rendimiento',25000.00,69,'M','Verde','/G4_AmbienteWeb/Views/assets/images/products/01camiseta.png','activo',''),(2,2,'Zapatos Running Elite','Amortiguación superior para corredores',79990.00,9,'42','Negro','/G4_AmbienteWeb/Views/assets/images/products/02zapatos.png','activo','\0'),(3,1,'Shorts de Entrenamiento','Ligeros y transpirables',24990.00,27,'L','Gris','/G4_AmbienteWeb/Views/assets/images/products/03short.png','activo','\0'),(4,3,'Mochila Deportiva','Espacio para todo tu equipo',39990.00,8,'U','Gris','/G4_AmbienteWeb/Views/assets/images/products/04mochila.png','activo','\0'),(5,3,'Lentes deportivos','Lentes ergonómicos',30000.00,34,'No','Gris','/PowerZone/Views/assets/images/products/08lentes.png','activo',''),(6,3,'Bolso Gym','Perfecto para todos tus implementos',33000.00,7,'No','Lila','/PowerZone/Views/assets/images/products/13bolsogym.png','activo','\0'),(7,3,'Botella Pro X','Resitente, con correa de mano',8000.00,14,'No','Negra','/PowerZone/Views/assets/images/products/09botella.png','activo','\0'),(8,1,'Medias Deportivas','Suavidad y confort para cualquier deporte',3000.00,70,'No','Blancas','/PowerZone/Views/assets/images/products/05medias.png','activo','\0'),(9,2,'Hiking Shoes','Para cualquier tipo de terreno, confort y water resist',80000.00,70,'37','Negros','/PowerZone/Views/assets/images/products/20hiking.png','activo','\0');
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'administrador'),(2,'cliente');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `cedula` varchar(20) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `estado` enum('activo','inactivo') NOT NULL DEFAULT 'activo',
  `id_rol` int(11) NOT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp(),
  `token_recuperacion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `correo` (`correo`),
  KEY `id_rol` (`id_rol`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (37,'000000000','Administrador','admin@powerzone.com','123456','activo',1,'2026-04-08 00:27:27',NULL),(38,'118870741','DARRY ANTONIO OPORTA VILLEGAS','doporta70741@ufide.ac.cr','123456','activo',2,'2026-04-07 18:27:57',NULL),(39,'401910645','HERNANDEZ DURAN ADRIANA MARIA','ahernandez10645@ufide.ac.cr','1234567','activo',2,'2026-04-12 13:12:21',NULL),(40,'88888888','Missy Mirella','adryannahz@gmail.com','1234567','activo',2,'2026-04-22 01:27:10',NULL),(41,'401170955','DURAN MURILLO CARMEN MARIA','Carmen@gmail.com','123456','activo',2,'2026-04-22 10:27:25',NULL),(45,'401170955','DURAN MURILLO CARMEN MARIA','mari@gmail.com','123456','activo',2,'2026-04-22 10:35:07',NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'power_zone'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ActualizarCantidad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarCantidad`(
    IN pIdDetalle  INT,
    IN pIdUsuario  INT,
    IN pNuevaCant  INT
)
BEGIN
    DECLARE vIdCarrito  INT;
    DECLARE vIdProducto INT;
    DECLARE vStock      INT;
 
    
    SELECT cd.id_carrito, cd.id_producto
    INTO   vIdCarrito, vIdProducto
    FROM   carrito_detalle cd
    JOIN   carrito         c  ON c.id_carrito = cd.id_carrito
    WHERE  cd.id_detalle = pIdDetalle
      AND  c.id_usuario  = pIdUsuario
      AND  c.estado      = 'activo'
    LIMIT  1;
 
    IF vIdCarrito IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Ítem no encontrado en el carrito activo.';
    END IF;
 
    IF pNuevaCant <= 0 THEN
        DELETE FROM carrito_detalle WHERE id_detalle = pIdDetalle;
    ELSE
        SELECT stock INTO vStock
        FROM   productos
        WHERE  id_producto = vIdProducto;
 
        IF pNuevaCant > vStock THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Stock insuficiente para la cantidad solicitada.';
        END IF;
 
        UPDATE carrito_detalle
        SET    cantidad = pNuevaCant
        WHERE  id_detalle = pIdDetalle;
    END IF;
 
    SELECT ROW_COUNT() AS filas_afectadas;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ActualizarContrasena` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarContrasena`(
    pNuevaContrasena VARCHAR(255),
    pIdUsuario INT
)
BEGIN
    UPDATE  usuarios
    SET     contrasena = pNuevaContrasena
    WHERE   id_usuario = pIdUsuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ActualizarEstadoPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarEstadoPedido`(IN pIdPedido INT, IN pEstado VARCHAR(20))
BEGIN
    UPDATE pedidos
    SET estado = pEstado
    WHERE id_pedido = pIdPedido;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ActualizarEstadoUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarEstadoUsuario`(
    IN pIdUsuario INT,
    IN pEstado    VARCHAR(10)
)
BEGIN
    UPDATE usuarios
    SET estado = pEstado
    WHERE id_usuario = pIdUsuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ActualizarPerfil` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarPerfil`(
    pNombre VARCHAR(100),
    pCorreo VARCHAR(100),
    pCedula VARCHAR(20),
    pIdUsuario INT
)
BEGIN
    UPDATE  usuarios
    SET     nombre = pNombre,
            correo = pCorreo,
            cedula = pCedula
    WHERE   id_usuario = pIdUsuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ActualizarProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarProducto`(
    pIdProducto  INT,
    pIdCategoria INT,
    pNombre      VARCHAR(120),
    pDescripcion TEXT,
    pPrecio      DECIMAL(10,2),
    pStock       INT,
    pTalla       VARCHAR(5),
    pColor       VARCHAR(30),
    pImagen      VARCHAR(255)
)
BEGIN
    UPDATE productos
    SET id_categoria = pIdCategoria,
        nombre       = pNombre,
        descripcion  = pDescripcion,
        precio       = pPrecio,
        stock        = pStock,
        talla        = pTalla,
        color        = pColor,
        imagen       = CASE WHEN pImagen != '' THEN pImagen ELSE imagen END
    WHERE id_producto = pIdProducto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ActualizarRol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarRol`(IN pIdUsuario INT, IN pIdRol INT)
BEGIN
    UPDATE usuarios SET id_rol = pIdRol WHERE id_usuario = pIdUsuario;
    SELECT ROW_COUNT() AS afectados;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_AgregarAlCarrito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AgregarAlCarrito`(
    IN pIdUsuario   INT,
    IN pIdProducto  INT,
    IN pCantidad    INT
)
BEGIN
    DECLARE vIdCarrito      INT          DEFAULT NULL;
    DECLARE vIdDetalle      INT          DEFAULT NULL;
    DECLARE vCantidadActual INT          DEFAULT 0;
    DECLARE vStock          INT          DEFAULT 0;
    DECLARE vPrecio         DECIMAL(10,2);
    DECLARE vEstadoProd     VARCHAR(10);
 
    
    SELECT precio, stock, estado
    INTO   vPrecio, vStock, vEstadoProd
    FROM   productos
    WHERE  id_producto = pIdProducto
    LIMIT  1;
 
    IF vEstadoProd IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Producto no encontrado.';
    END IF;
 
    IF vEstadoProd <> 'activo' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El producto no está disponible.';
    END IF;
 
    
    SELECT id_carrito INTO vIdCarrito
    FROM   carrito
    WHERE  id_usuario = pIdUsuario
      AND  estado     = 'activo'
    LIMIT  1;
 
    IF vIdCarrito IS NULL THEN
        INSERT INTO carrito (id_usuario, estado)
        VALUES (pIdUsuario, 'activo');
        SET vIdCarrito = LAST_INSERT_ID();
    END IF;
 
    
    SELECT id_detalle, cantidad
    INTO   vIdDetalle, vCantidadActual
    FROM   carrito_detalle
    WHERE  id_carrito  = vIdCarrito
      AND  id_producto = pIdProducto
    LIMIT  1;
 
    
    IF (vCantidadActual + pCantidad) > vStock THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Stock insuficiente para la cantidad solicitada.';
    END IF;
 
    IF vIdDetalle IS NOT NULL THEN
        UPDATE carrito_detalle
        SET    cantidad = cantidad + pCantidad
        WHERE  id_detalle = vIdDetalle;
    ELSE
        INSERT INTO carrito_detalle (id_carrito, id_producto, cantidad, precio_unitario)
        VALUES (vIdCarrito, pIdProducto, pCantidad, vPrecio);
    END IF;
 
    SELECT vIdCarrito AS id_carrito;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_AgregarProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AgregarProducto`(
    pIdCategoria INT,
    pNombre VARCHAR(120),
    pDescripcion TEXT,
    pPrecio DECIMAL(10,2),
    pStock INT,
    pTalla VARCHAR(5),
    pColor VARCHAR(30),
    pImagen VARCHAR(255)
)
BEGIN
    INSERT INTO productos (id_categoria, nombre, descripcion, precio, stock, talla, color, imagen, estado)
    VALUES (pIdCategoria, pNombre, pDescripcion, pPrecio, pStock, pTalla, pColor, pImagen, 'activo');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_CambiarEstadoProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_CambiarEstadoProducto`(
    pIdProducto INT
)
BEGIN
    UPDATE productos
    SET    estado = CASE WHEN estado = 'activo' THEN 'inactivo' ELSE 'activo' END
    WHERE  id_producto = pIdProducto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_CancelarCarrito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_CancelarCarrito`(
    IN pIdUsuario INT
)
BEGIN
    DECLARE vIdCarrito INT;
 
    SELECT id_carrito INTO vIdCarrito
    FROM   carrito
    WHERE  id_usuario = pIdUsuario
      AND  estado     = 'activo'
    LIMIT  1;
 
    IF vIdCarrito IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No existe un carrito activo para este usuario.';
    END IF;
 
    DELETE FROM carrito_detalle WHERE id_carrito = vIdCarrito;
 
    UPDATE carrito
    SET    estado = 'cancelado'
    WHERE  id_carrito = vIdCarrito;
 
    SELECT vIdCarrito AS id_carrito_cancelado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ConsultarCategorias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarCategorias`()
BEGIN
    SELECT id_categoria, nombre
    FROM categorias
    WHERE estado = 'activo'
    ORDER BY nombre;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ConsultarPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarPedido`(IN pIdPedido INT)
BEGIN
    IF pIdPedido IS NULL THEN
        SELECT p.id_pedido, u.nombre AS Nombre_Cliente, u.correo AS Correo_Cliente,
            p.fecha_pedido AS Fecha_pedido, p.telefono AS Telefono, p.estado AS Estado,
            p.total AS Total, p.direccion AS Direccion, p.metodo_pago AS Metodo_pago,
            p.num_comprobante AS Num_Comprobante, p.observaciones AS Observaciones,
            NULL AS Nombre_Producto, NULL AS Talla, NULL AS Color, NULL AS Cantidad, NULL AS Stock
        FROM pedidos p JOIN usuarios u ON u.id_usuario = p.id_usuario
        ORDER BY p.fecha_pedido DESC;
    ELSE
        SELECT p.id_pedido, u.nombre AS Nombre_Cliente, u.correo AS Correo_Cliente,
            p.fecha_pedido AS Fecha_pedido, p.telefono AS Telefono, p.estado AS Estado,
            p.total AS Total, p.direccion AS Direccion, p.metodo_pago AS Metodo_pago,
            p.num_comprobante AS Num_Comprobante, p.observaciones AS Observaciones,
            pr.nombre AS Nombre_Producto, pr.talla AS Talla, pr.color AS Color,
            pd.cantidad AS Cantidad, pr.stock AS Stock
        FROM pedidos p
        JOIN usuarios u        ON u.id_usuario  = p.id_usuario
        JOIN pedido_detalle pd ON pd.id_pedido  = p.id_pedido
        JOIN productos pr      ON pr.id_producto = pd.id_producto
        WHERE p.id_pedido = pIdPedido;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ConsultarProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarProducto`(
    pIdProducto INT
)
BEGIN
    SELECT id_producto, id_categoria, nombre, descripcion, precio, stock, talla, color, imagen, estado, en_oferta
    FROM   productos
    WHERE  id_producto = pIdProducto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ConsultarProductos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarProductos`(
)
BEGIN
    SELECT  id_producto,
            id_categoria,
            nombre,
            descripcion,
            precio,
            stock,
            talla,
            color,
            imagen,
            estado,
            en_oferta,
            CASE WHEN estado = 'activo' THEN 'Activo' ELSE 'Inactivo' END AS EstadoDescripcion
    FROM    productos;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ConsultarUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarUsuario`(
    pIdUsuario INT
)
BEGIN
    SELECT  id_usuario,
            cedula,
            nombre,
            correo,
            estado,
            id_rol
    FROM    usuarios
    WHERE   id_usuario = pIdUsuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ConsultarUsuarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ConsultarUsuarios`()
BEGIN
    SELECT u.id_usuario, u.cedula, u.nombre, u.correo, u.estado, u.id_rol, r.nombre AS nombre_rol, u.fecha_registro
    FROM usuarios u
    INNER JOIN roles r ON u.id_rol = r.id_rol
    ORDER BY u.fecha_registro DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_EliminarDelCarrito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EliminarDelCarrito`(
    IN pIdDetalle  INT,
    IN pIdUsuario  INT
)
BEGIN
    DELETE cd
    FROM   carrito_detalle cd
    JOIN   carrito         c  ON c.id_carrito = cd.id_carrito
    WHERE  cd.id_detalle = pIdDetalle
      AND  c.id_usuario  = pIdUsuario
      AND  c.estado      = 'activo';
 
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Ítem no encontrado o el carrito no está activo.';
    END IF;
 
    SELECT ROW_COUNT() AS filas_afectadas;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_FinalizarCarrito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_FinalizarCarrito`(
    IN pIdUsuario      INT,
    IN pDireccion      VARCHAR(200),
    IN pTelefono       VARCHAR(20),
    IN pMetodoPago     VARCHAR(50),
    IN pObservaciones  TEXT,
    IN pNumComprobante VARCHAR(100)
)
BEGIN
    DECLARE vIdCarrito  INT;
    DECLARE vTotal      DECIMAL(10,2);
    DECLARE vIdPedido   INT;
    DECLARE vContItems  INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; RESIGNAL; END;
    START TRANSACTION;
    SELECT id_carrito INTO vIdCarrito FROM carrito WHERE id_usuario = pIdUsuario AND estado = 'activo' LIMIT 1;
    IF vIdCarrito IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No existe un carrito activo para este usuario.'; END IF;
    SELECT COUNT(*) INTO vContItems FROM carrito_detalle WHERE id_carrito = vIdCarrito;
    IF vContItems = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El carrito está vacío.'; END IF;
    SELECT SUM(cantidad * precio_unitario) INTO vTotal FROM carrito_detalle WHERE id_carrito = vIdCarrito;
    INSERT INTO pedidos (id_usuario, direccion, telefono, total, estado, metodo_pago, num_comprobante, observaciones)
    VALUES (pIdUsuario, pDireccion, pTelefono, vTotal, 'pendiente', pMetodoPago, pNumComprobante, pObservaciones);
    SET vIdPedido = LAST_INSERT_ID();
    INSERT INTO pedido_detalle (id_pedido, id_producto, cantidad, precio_unitario, subtotal)
    SELECT vIdPedido, id_producto, cantidad, precio_unitario, (cantidad * precio_unitario)
    FROM carrito_detalle WHERE id_carrito = vIdCarrito;
    UPDATE productos p JOIN carrito_detalle cd ON cd.id_producto = p.id_producto
    SET p.stock = p.stock - cd.cantidad WHERE cd.id_carrito = vIdCarrito;
    UPDATE carrito SET estado = 'completado' WHERE id_carrito = vIdCarrito;
    COMMIT;
    SELECT vIdPedido AS id_pedido, vTotal AS total;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Login`(IN pCorreo VARCHAR(100))
BEGIN
    SELECT u.id_usuario, u.nombre, u.correo, u.contrasena, u.id_rol, r.nombre AS nombre_rol
    FROM usuarios u
    INNER JOIN roles r ON u.id_rol = r.id_rol
    WHERE u.correo = pCorreo
      AND u.estado = 'activo'
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ObtenerCarrito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ObtenerCarrito`(
    IN pIdUsuario INT
)
BEGIN
    SELECT
        c.id_carrito,
        c.fecha_creacion,
        c.estado                                          AS estado_carrito,
        cd.id_detalle,
        p.id_producto,
        p.nombre                                          AS nombre_producto,
        p.imagen,
        p.talla,
        p.color,
        p.stock                                           AS stock_disponible,
        cd.cantidad,
        cd.precio_unitario,
        (cd.cantidad * cd.precio_unitario)                AS subtotal,
        SUM(cd.cantidad * cd.precio_unitario)
            OVER (PARTITION BY c.id_carrito)              AS total_carrito
    FROM   carrito          c
    JOIN   carrito_detalle  cd ON cd.id_carrito  = c.id_carrito
    JOIN   productos        p  ON p.id_producto  = cd.id_producto
    WHERE  c.id_usuario = pIdUsuario
      AND  c.estado     = 'activo'
    ORDER BY cd.id_detalle;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Registrar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Registrar`(
     pNombre VARCHAR(200),
     pCorreoElectronico VARCHAR(100),
     pContrasenna VARCHAR(255),
     pCedula VARCHAR(20)
)
BEGIN
    DECLARE vIdRol INT;
    
    SELECT id_rol INTO vIdRol
    FROM roles
    WHERE nombre = 'cliente'
    LIMIT 1;

    INSERT INTO usuarios(cedula, nombre, correo, contrasena, estado, id_rol)
    VALUES (pCedula, pNombre, pCorreoElectronico, pContrasenna, 'activo', vIdRol);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ToggleOferta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ToggleOferta`(
    pIdProducto INT
)
BEGIN
    UPDATE productos
    SET    en_oferta = CASE WHEN en_oferta = 1 THEN 0 ELSE 1 END
    WHERE  id_producto = pIdProducto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_VaciarCarrito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_VaciarCarrito`(
    IN pIdUsuario INT
)
BEGIN
    DECLARE vIdCarrito INT;
 
    SELECT id_carrito INTO vIdCarrito
    FROM   carrito
    WHERE  id_usuario = pIdUsuario
      AND  estado     = 'activo'
    LIMIT  1;
 
    IF vIdCarrito IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No existe un carrito activo para este usuario.';
    END IF;
 
    DELETE FROM carrito_detalle WHERE id_carrito = vIdCarrito;
 
    SELECT vIdCarrito AS id_carrito, ROW_COUNT() AS items_eliminados;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ValidarCorreo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ValidarCorreo`(
    pCorreo VARCHAR(100)
)
BEGIN
    SELECT  id_usuario,
            nombre,
      correo,
      contrasena
    FROM    usuarios
    WHERE   correo  = pCorreo
    AND     estado  = 'activo';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-22 12:45:53
