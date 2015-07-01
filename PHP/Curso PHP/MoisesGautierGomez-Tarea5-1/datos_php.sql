-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 20-12-2013 a las 03:20:03
-- Versión del servidor: 5.5.27
-- Versión de PHP: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `curso_php`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `datos_php`
--

CREATE TABLE IF NOT EXISTS `datos_php` (
  `Nombre` text COLLATE utf8_spanish_ci NOT NULL,
  `Apellidos1` text COLLATE utf8_spanish_ci NOT NULL,
  `Apellidos2` text COLLATE utf8_spanish_ci NOT NULL,
  `Telefono` varchar(9) COLLATE utf8_spanish_ci NOT NULL,
  `Direccion` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `Numero` int(3) NOT NULL,
  `Piso` varchar(5) COLLATE utf8_spanish_ci NOT NULL,
  `CP` varchar(5) COLLATE utf8_spanish_ci NOT NULL,
  `Localidad` text COLLATE utf8_spanish_ci NOT NULL,
  `Provincia` text COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Tabla ejemplo curso de PHP';

--
-- Volcado de datos para la tabla `datos_php`
--

INSERT INTO `datos_php` (`Nombre`, `Apellidos1`, `Apellidos2`, `Telefono`, `Direccion`, `Numero`, `Piso`, `CP`, `Localidad`, `Provincia`) VALUES
('Nombre', 'Apellidos1', 'Apellidos2', '958123456', 'C/ Periodista Daniel Saucedo', 4, '1ºB', '18001', 'Granada', 'Granada'),
('Nombre2', 'Apellidos1Cualquiera', 'Apellidos2Cualquiera', '912345678', 'C/ Carretera de Jaén', 8, '8ºH', '18014', 'Granada', 'Granada');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
