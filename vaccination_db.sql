-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 31-08-2024 a las 05:28:21
-- Versión del servidor: 10.4.25-MariaDB
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `vaccination_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `children`
--

CREATE TABLE `children` (
  `id` bigint(20) NOT NULL,
  `first_name` text NOT NULL,
  `last_name_father` text NOT NULL,
  `last_name_mother` text NOT NULL,
  `birth_date` date NOT NULL,
  `birth_certificate_number` text NOT NULL,
  `identity_card_number` text NOT NULL,
  `registration_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `child_code` text DEFAULT NULL,
  `guardian_first_name` text DEFAULT NULL,
  `guardian_last_name_father` text DEFAULT NULL,
  `guardian_last_name_mother` text DEFAULT NULL,
  `guardian_identity_card_number` text DEFAULT NULL,
  `guardian_relationship` text DEFAULT NULL,
  `guardian_phone_number` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `children`
--

INSERT INTO `children` (`id`, `first_name`, `last_name_father`, `last_name_mother`, `birth_date`, `birth_certificate_number`, `identity_card_number`, `registration_date`, `child_code`, `guardian_first_name`, `guardian_last_name_father`, `guardian_last_name_mother`, `guardian_identity_card_number`, `guardian_relationship`, `guardian_phone_number`) VALUES
(1, 'Juan', 'Perez', 'Lopez', '2015-06-15', 'BCN123456', 'ICN654321', '2023-01-10 04:00:00', 'C001', 'Maria', 'Perez', 'Gomez', 'GICN123456', 'Mother', '555-1234'),
(2, 'Ana', 'Garcia', 'Martinez', '2016-08-20', 'BCN654321', 'ICN123456', '2023-02-15 04:00:00', 'C002', 'Carlos', 'Garcia', 'Lopez', 'GICN654321', 'Father', '555-5678'),
(3, 'Luis', 'Rodriguez', 'Fernandez', '2014-11-30', 'BCN789012', 'ICN789012', '2023-03-05 04:00:00', 'C003', 'Laura', 'Rodriguez', 'Martinez', 'GICN789012', 'Mother', '555-9012');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) NOT NULL,
  `child_id` bigint(20) DEFAULT NULL,
  `notification_type` text NOT NULL,
  `sent_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` text DEFAULT NULL CHECK (`status` in ('sent','read'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `notifications`
--

INSERT INTO `notifications` (`id`, `child_id`, `notification_type`, `sent_date`, `status`) VALUES
(1, 1, 'Vaccination Reminder', '2023-01-15 04:00:00', 'sent'),
(2, 2, 'Vaccination Reminder', '2023-02-20 04:00:00', 'read'),
(3, 3, 'Vaccination Overdue', '2023-03-05 04:00:00', 'sent');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `staff`
--

CREATE TABLE `staff` (
  `id` bigint(20) NOT NULL,
  `position` text NOT NULL,
  `first_name` text NOT NULL,
  `last_name` text NOT NULL,
  `identity_card_number` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `staff`
--

INSERT INTO `staff` (`id`, `position`, `first_name`, `last_name`, `identity_card_number`) VALUES
(1, 'Nurse', 'Sofia', 'Lopez', 'SICN123456'),
(2, 'Doctor', 'Miguel', 'Ramirez', 'SICN654321');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vaccinations`
--

CREATE TABLE `vaccinations` (
  `id` bigint(20) NOT NULL,
  `child_id` bigint(20) DEFAULT NULL,
  `vaccine_id` bigint(20) DEFAULT NULL,
  `dose_number` int(11) NOT NULL,
  `administration_date` date NOT NULL,
  `staff_id` bigint(20) DEFAULT NULL,
  `next_dose_date` date DEFAULT NULL,
  `status` text DEFAULT NULL CHECK (`status` in ('completed','pending','overdue'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `vaccinations`
--

INSERT INTO `vaccinations` (`id`, `child_id`, `vaccine_id`, `dose_number`, `administration_date`, `staff_id`, `next_dose_date`, `status`) VALUES
(1, 1, 1, 1, '2023-01-20', 1, '2023-07-20', 'completed'),
(2, 2, 2, 1, '2023-02-25', 2, '2023-08-25', 'pending'),
(3, 3, 3, 1, '2023-03-10', 1, '2023-09-10', 'overdue');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vaccination_schedule`
--

CREATE TABLE `vaccination_schedule` (
  `id` bigint(20) NOT NULL,
  `vaccine_id` bigint(20) DEFAULT NULL,
  `dose_number` int(11) NOT NULL,
  `recommended_age_months` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `vaccination_schedule`
--

INSERT INTO `vaccination_schedule` (`id`, `vaccine_id`, `dose_number`, `recommended_age_months`) VALUES
(1, 1, 1, 12),
(2, 1, 2, 24),
(3, 2, 1, 2),
(4, 2, 2, 4),
(5, 2, 3, 6),
(6, 3, 1, 0),
(7, 3, 2, 1),
(8, 3, 3, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vaccines`
--

CREATE TABLE `vaccines` (
  `id` bigint(20) NOT NULL,
  `name` text NOT NULL,
  `total_doses` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `vaccines`
--

INSERT INTO `vaccines` (`id`, `name`, `total_doses`) VALUES
(1, 'MMR', 2),
(2, 'Polio', 3),
(3, 'Hepatitis B', 3);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `children`
--
ALTER TABLE `children`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `birth_certificate_number` (`birth_certificate_number`) USING HASH,
  ADD UNIQUE KEY `identity_card_number` (`identity_card_number`) USING HASH,
  ADD UNIQUE KEY `child_code` (`child_code`) USING HASH,
  ADD UNIQUE KEY `guardian_identity_card_number` (`guardian_identity_card_number`) USING HASH;

--
-- Indices de la tabla `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `child_id` (`child_id`);

--
-- Indices de la tabla `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `position` (`position`) USING HASH,
  ADD UNIQUE KEY `identity_card_number` (`identity_card_number`) USING HASH;

--
-- Indices de la tabla `vaccinations`
--
ALTER TABLE `vaccinations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `child_id` (`child_id`),
  ADD KEY `vaccine_id` (`vaccine_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indices de la tabla `vaccination_schedule`
--
ALTER TABLE `vaccination_schedule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vaccine_id` (`vaccine_id`);

--
-- Indices de la tabla `vaccines`
--
ALTER TABLE `vaccines`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `children`
--
ALTER TABLE `children`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `staff`
--
ALTER TABLE `staff`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `vaccinations`
--
ALTER TABLE `vaccinations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `vaccination_schedule`
--
ALTER TABLE `vaccination_schedule`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `vaccines`
--
ALTER TABLE `vaccines`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`child_id`) REFERENCES `children` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `vaccinations`
--
ALTER TABLE `vaccinations`
  ADD CONSTRAINT `vaccinations_ibfk_1` FOREIGN KEY (`child_id`) REFERENCES `children` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `vaccinations_ibfk_2` FOREIGN KEY (`vaccine_id`) REFERENCES `vaccines` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `vaccinations_ibfk_3` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `vaccination_schedule`
--
ALTER TABLE `vaccination_schedule`
  ADD CONSTRAINT `vaccination_schedule_ibfk_1` FOREIGN KEY (`vaccine_id`) REFERENCES `vaccines` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
