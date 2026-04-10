-- phpMyAdmin SQL Dump
-- version 4.7.5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 10-04-2026 a las 08:14:19
-- Versión del servidor: 5.6.34
-- Versión de PHP: 5.6.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_tambo`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `dni` char(8) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `nombre`, `dni`, `telefono`, `estado`) VALUES
(1, 'Juan Pérez', '12345678', '987654321', 1),
(2, 'María López', '87654321', '912345678', 1),
(3, 'Gabriela Velasquez', '53327820', '912345678', 1),
(4, 'Gilberto Pomodoro', '66609832', '000000000', 0),
(5, 'Carlos Ramírez', '44556677', NULL, 1),
(6, 'Ana Torres', '77889900', NULL, 0),
(7, 'Luis Mendoza', '33445566', NULL, 1),
(8, 'Paola Ríos', '99887766', NULL, 0),
(9, 'José Castillo', '11223344', NULL, 1),
(10, 'Rocío Fernández', '22334455', NULL, 1)

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `id_detalle` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  `id_venta` int(11) DEFAULT NULL,
  `id_producto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `detalle_venta`
--

INSERT INTO `detalle_venta` (`id_detalle`, `cantidad`, `subtotal`, `id_venta`, `id_producto`) VALUES
(1, 2, '7.00', 1, 1),
(2, 1, '4.50', 1, 2),
(3, 2, '6.40', 1, 3),
(4, 2, '5.60', 2, 5),
(5, 1, '3.50', 3, 1),
(6, 2, '9.00', 3, 2),
(11, 2, '5.00', 6, 6),
(12, 1, '3.00', 6, 20),
(14, 1, '7.50', 7, 9),
(15, 1, '4.20', 7, 16),
(16, 1, '1.50', 7, 23),
(17, 1, '3.20', 8, 7),
(18, 2, '5.00', 8, 21),
(19, 1, '5.50', 9, 14),
(20, 2, '5.00', 9, 6)

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `precio` decimal(8,2) NOT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `stock` int(11) NOT NULL,
  `estado` tinyint(4) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_producto`, `nombre`, `precio`, `categoria`, `stock`, `estado`) VALUES
(1, 'Coca Cola 500ml', '3.50', 'Bebidas', 10, 1),
(2, 'Inka Kola 1L', '4.50', 'Bebidas', 30, 1),
(3, 'Empanada de pollo', '3.40', 'Comidas', 46, 1),
(5, 'Galletas Oreo', '2.80', 'Golosinas', 10, 1),
(6, 'Agua San Luis 625ml', '2.50', 'Bebidas', 28, 1),
(7, 'Sprite 500ml', '3.20', 'Bebidas', 16, 1),
(8, 'Fanta 500ml', '3.20', 'Bebidas', 11, 1),
(9, 'Red Bull 250ml', '7.50', 'Bebidas', 8, 1),
(10, 'Gatorade 500ml', '4.50', 'Bebidas', 10, 1),
(11, 'Pan Bimbo Blanco', '6.00', 'Panadería', 11, 1),
(12, 'Pan Hot Dog Bimbo', '5.80', 'Panadería', 9, 1),
(13, 'Empanada de carne', '3.60', 'Comidas', 39, 1),
(14, 'Sándwich de jamón y queso', '5.50', 'Comidas', 25, 1),
(15, 'Hamburguesa clásica', '6.50', 'Comidas', 20, 1),
(16, 'Papas Lays Clásicas', '4.20', 'Snacks', 35, 1),
(17, 'Doritos Nacho', '4.50', 'Snacks', 30, 1),
(18, 'Cheetos Queso', '4.00', 'Snacks', 28, 1),
(19, 'Piqueo Snax BBQ', '3.80', 'Snacks', 22, 1),
(20, 'Chocolate Sublime', '3.00', 'Golosinas', 40, 1),
(21, 'Chocolate Princesa', '2.50', 'Golosinas', 35, 1),
(22, 'Caramelo Halls', '2.00', 'Golosinas', 50, 1),
(23, 'Chicle Trident', '1.80', 'Golosinas', 45, 1),
(24, 'Yogurt Gloria Fresa 1L', '5.20', 'Lácteos', 11, 1),
(26, 'Arroz Costeño 1Kg', '4.80', 'Abarrotes', 20, 1),
(27, 'Azúcar Rubia 1Kg', '4.20', 'Abarrotes', 18, 1),
(28, 'Aceite Primor 900ml', '9.80', 'Abarrotes', 8, 1),
(29, 'Fideos Don Vittorio', '3.50', 'Abarrotes', 25, 1),
(30, 'Café Nescafé Clásico', '8.50', 'Bebidas Calientes', 10, 1),
(32, 'Pizza', '15.50', 'Comidas', 40, 0),
(33, 'hamburguesa', '5.20', 'Comida', 30, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `id_proveedor` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `ruc` char(11) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`id_proveedor`, `nombre`, `ruc`, `telefono`, `estado`) VALUES
(1, 'Distribuidora Laive', '20123456789', '014567890', 1),
(2, 'Alicorp SAC', '20456789012', '014123456', 1),
(3, 'Romero', '50258659212', '014123456', 1),
(4, 'Proveedor Inactivo', '20000000000', '000000000', 1),
(5, 'San Fernando SAC', '20100123456', '014567321', 1),
(6, 'Gloria S.A.', '20123489012', '014789654', 1),
(7, 'Backus y Johnston', '20100345678', '014852369', 1),
(8, 'Nestlé Perú', '20100456789', '014963258', 1),
(9, 'Coca-Cola Perú', '20100567890', '014159753', 1),
(10, 'PepsiCo Perú', '20100678901', '014357951', 1),
(11, 'Arca Continental Lindley', '20100789012', '014258369', 1),
(12, 'Donofrio Perú', '20100890123', '014456789', 1),
(13, 'Mondelez Perú', '20100901234', '014654321', 1),
(14, 'Proveedor Regional Lima Norte', '20987654321', '014000111', 0),
(16, 'Mayorsa', '20108730294', '996424652', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `rol` varchar(20) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `username`, `password`, `rol`, `estado`) VALUES
(1, 'admin', '1234', 'ADMIN', 1),
(2, 'cajero1', '1234', 'EMPLEADO', 1),
(3, 'cajero2', '1234', 'EMPLEADO', 0),
(4, 'Fernando', '123', 'Jefe', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `id_venta` int(11) NOT NULL,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  `total` decimal(10,2) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`id_venta`, `fecha`, `total`, `id_cliente`, `estado`) VALUES
(1, '2025-12-16 21:40:03', '17.90', 1, 1),
(2, '2025-12-16 21:40:03', '5.60', 2, 1),
(3, '2025-12-16 21:40:03', '12.50', 3, 1),
(6, '2025-12-23 00:00:00', '10.00', 10, 1),
(7, '2025-12-23 00:00:00', '13.20', 11, 1),
(8, '2025-12-23 00:00:00', '8.50', 13, 1),
(9, '2025-12-23 00:00:00', '11.50', 14, 1),
(10, '2026-02-07 01:22:20', '3.50', 2, 1),
(11, '2026-02-07 02:16:54', '21.20', 9, 1),
(12, '2026-02-07 03:13:19', '26.30', 21, 0),
(13, '2026-02-10 03:30:18', '10.40', 1, 1),
(15, '2026-02-24 01:00:53', '9.10', 20, 0),
(16, '2026-02-26 20:49:48', '5.30', 18, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`),
  ADD UNIQUE KEY `dni` (`dni`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_venta` (`id_venta`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`id_venta`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `venta` (`id_venta`),
  ADD CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
