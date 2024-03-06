-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ing_soft
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ing_soft
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ing_soft` DEFAULT CHARACTER SET utf8mb4 ;
USE `ing_soft` ;

-- -----------------------------------------------------
-- Table `ing_soft`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ing_soft`.`usuarios` (
  `id_usuario` INT(11) NOT NULL,
  `nombre_usuario` VARCHAR(255) NULL DEFAULT NULL,
  `apellido_usuario` VARCHAR(255) NULL DEFAULT NULL,
  `correo_usuario` VARCHAR(255) NULL DEFAULT NULL,
  `contrasena_usurio` VARCHAR(255) NULL DEFAULT NULL,
  `tipo_usuario` ENUM('Conductor', 'Pasajero') NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `ing_soft`.`conductores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ing_soft`.`conductores` (
  `id_conductor` INT(11) NOT NULL,
  `id_usuario_conductor` INT(11) NULL DEFAULT NULL,
  `licencia_conductor` VARCHAR(20) NULL DEFAULT NULL,
  `telefono_conductor` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`id_conductor`),
  UNIQUE INDEX `id_usuario_conductor` (`id_usuario_conductor` ASC) VISIBLE,
  CONSTRAINT `conductores_ibfk_1`
    FOREIGN KEY (`id_usuario_conductor`)
    REFERENCES `ing_soft`.`usuarios` (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `ing_soft`.`rutas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ing_soft`.`rutas` (
  `id_ruta` INT(11) NOT NULL,
  `nombre_ruta` VARCHAR(255) NULL DEFAULT NULL,
  `descripcion_ruta` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id_ruta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `ing_soft`.`autobus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ing_soft`.`autobus` (
  `id_autobus` INT(11) NOT NULL,
  `id_conductor_autobus` INT(11) NULL DEFAULT NULL,
  `id_ruta_autobus` INT(11) NULL DEFAULT NULL,
  `capacidad_maxima_autobus` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_autobus`),
  INDEX `id_conductor_autobus` (`id_conductor_autobus` ASC) VISIBLE,
  INDEX `id_ruta_autobus` (`id_ruta_autobus` ASC) VISIBLE,
  CONSTRAINT `autobus_ibfk_1`
    FOREIGN KEY (`id_conductor_autobus`)
    REFERENCES `ing_soft`.`conductores` (`id_conductor`),
  CONSTRAINT `autobus_ibfk_2`
    FOREIGN KEY (`id_ruta_autobus`)
    REFERENCES `ing_soft`.`rutas` (`id_ruta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `ing_soft`.`conteo_pasajeros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ing_soft`.`conteo_pasajeros` (
  `id_conteo` INT(11) NOT NULL,
  `id_autobus_conteo` INT(11) NULL DEFAULT NULL,
  `fecha_hora_conteo` DATETIME NULL DEFAULT NULL,
  `cantidad_pasajeros_conteo` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_conteo`),
  INDEX `id_autobus_conteo` (`id_autobus_conteo` ASC) VISIBLE,
  CONSTRAINT `conteo_pasajeros_ibfk_1`
    FOREIGN KEY (`id_autobus_conteo`)
    REFERENCES `ing_soft`.`autobus` (`id_autobus`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `ing_soft`.`paradas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ing_soft`.`paradas` (
  `id_parada` INT(11) NOT NULL,
  `nombre_parada` VARCHAR(255) NULL DEFAULT NULL,
  `latitud_parada` DECIMAL(10,8) NULL DEFAULT NULL,
  `longitud_parada` DECIMAL(11,8) NULL DEFAULT NULL,
  PRIMARY KEY (`id_parada`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `ing_soft`.`pasajeros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ing_soft`.`pasajeros` (
  `id_pasajero` INT(11) NOT NULL,
  `id_usuario_pasajero` INT(11) NULL DEFAULT NULL,
  `telefono_pasajero` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`id_pasajero`),
  UNIQUE INDEX `id_usuario_pasajero` (`id_usuario_pasajero` ASC) VISIBLE,
  CONSTRAINT `pasajeros_ibfk_1`
    FOREIGN KEY (`id_usuario_pasajero`)
    REFERENCES `ing_soft`.`usuarios` (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `ing_soft`.`registro_viaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ing_soft`.`registro_viaje` (
  `id_registro` INT(11) NOT NULL,
  `id_autobus_registro` INT(11) NULL DEFAULT NULL,
  `fecha_hora_salida_registro` DATETIME NULL DEFAULT NULL,
  `fecha_hora_llegada_registro` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_registro`),
  INDEX `id_autobus_registro` (`id_autobus_registro` ASC) VISIBLE,
  CONSTRAINT `registro_viaje_ibfk_1`
    FOREIGN KEY (`id_autobus_registro`)
    REFERENCES `ing_soft`.`autobus` (`id_autobus`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `ing_soft`.`ruta_parada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ing_soft`.`ruta_parada` (
  `id_ruta_parada` INT(11) NOT NULL,
  `id_ruta_ruta_parada` INT(11) NULL DEFAULT NULL,
  `id_parada_ruta_parada` INT(11) NULL DEFAULT NULL,
  `orden_ruta_parada` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_ruta_parada`),
  INDEX `id_ruta_ruta_parada` (`id_ruta_ruta_parada` ASC) VISIBLE,
  INDEX `id_parada_ruta_parada` (`id_parada_ruta_parada` ASC) VISIBLE,
  CONSTRAINT `ruta_parada_ibfk_1`
    FOREIGN KEY (`id_ruta_ruta_parada`)
    REFERENCES `ing_soft`.`rutas` (`id_ruta`),
  CONSTRAINT `ruta_parada_ibfk_2`
    FOREIGN KEY (`id_parada_ruta_parada`)
    REFERENCES `ing_soft`.`paradas` (`id_parada`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
