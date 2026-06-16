-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema top_filmes_locadora
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema top_filmes_locadora
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `top_filmes_locadora` DEFAULT CHARACTER SET utf8 ;
USE `top_filmes_locadora` ;

-- -----------------------------------------------------
-- Table `top_filmes_locadora`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `top_filmes_locadora`.`clientes` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(60) NOT NULL,
  `telefone` VARCHAR(11) NOT NULL,
  `email` VARCHAR(60) NOT NULL,
  `endereco` VARCHAR(80) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `data_cadastro` DATE NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `top_filmes_locadora`.`filmes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `top_filmes_locadora`.`filmes` (
  `id_filme` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(60) NOT NULL,
  `ano_lancamento` DATE NOT NULL,
  `duracao` INT NOT NULL,
  `classificacao_indicativa` VARCHAR(3) NOT NULL,
  `descricao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_filme`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `top_filmes_locadora`.`atores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `top_filmes_locadora`.`atores` (
  `id_ator` INT NOT NULL AUTO_INCREMENT,
  `nome_artistico` VARCHAR(60) NOT NULL,
  `nacionalidade` VARCHAR(20) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  PRIMARY KEY (`id_ator`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `top_filmes_locadora`.`funcionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `top_filmes_locadora`.`funcionarios` (
  `id_funcionario` INT NOT NULL AUTO_INCREMENT,
  `cpf` VARCHAR(11) NOT NULL,
  `cargo` VARCHAR(10) NOT NULL,
  `salario` DECIMAL(8,2) NOT NULL,
  `data_contratacao` DATE NOT NULL,
  PRIMARY KEY (`id_funcionario`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `top_filmes_locadora`.`alugueis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `top_filmes_locadora`.`alugueis` (
  `id_aluguel` INT NOT NULL AUTO_INCREMENT,
  `data_aluguel` DATE NOT NULL,
  `data_prevista_devolucao` DATE NOT NULL,
  `data_real_devolucao` DATE NOT NULL,
  `valor_total` DECIMAL(8,2) NOT NULL,
  `multa` DECIMAL(8,2) NOT NULL,
  `id_cliente` INT NOT NULL,
  `id_funcionario` INT NOT NULL,
  PRIMARY KEY (`id_aluguel`),
  INDEX `fk_alugueis_1_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `fk_alugueis2_idx` (`id_funcionario` ASC) VISIBLE,
  CONSTRAINT `fk_alugueis1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `top_filmes_locadora`.`clientes` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alugueis2`
    FOREIGN KEY (`id_funcionario`)
    REFERENCES `top_filmes_locadora`.`funcionarios` (`id_funcionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `top_filmes_locadora`.`pagamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `top_filmes_locadora`.`pagamentos` (
  `id_pagamento` INT NOT NULL AUTO_INCREMENT,
  `valor_pago` DECIMAL(8,2) NOT NULL,
  `data_pagamento` DATE NOT NULL,
  `forma_pagamento` VARCHAR(10) NOT NULL,
  `id_aluguel` INT NOT NULL,
  PRIMARY KEY (`id_pagamento`),
  INDEX `fk_pagamentos_1_idx` (`id_aluguel` ASC) VISIBLE,
  CONSTRAINT `fk_pagamentos_1`
    FOREIGN KEY (`id_aluguel`)
    REFERENCES `top_filmes_locadora`.`alugueis` (`id_aluguel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `top_filmes_locadora`.`estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `top_filmes_locadora`.`estoque` (
  `id_estoque` INT NOT NULL AUTO_INCREMENT,
  `id_filme` INT NOT NULL,
  `status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_estoque`),
  INDEX `fk_estoque1_idx` (`id_filme` ASC) VISIBLE,
  CONSTRAINT `fk_estoque1`
    FOREIGN KEY (`id_filme`)
    REFERENCES `top_filmes_locadora`.`filmes` (`id_filme`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `top_filmes_locadora`.`intens_alugel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `top_filmes_locadora`.`intens_alugel` (
  `id_aluguel` INT NOT NULL,
  `id_estoque` INT NOT NULL,
  INDEX `fk_itens_aluguel_1_idx` (`id_aluguel` ASC) VISIBLE,
  INDEX `fk_itens_aluguel_2_idx` (`id_estoque` ASC) VISIBLE,
  CONSTRAINT `fk_itens_aluguel_1`
    FOREIGN KEY (`id_aluguel`)
    REFERENCES `top_filmes_locadora`.`alugueis` (`id_aluguel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_aluguel_2`
    FOREIGN KEY (`id_estoque`)
    REFERENCES `top_filmes_locadora`.`estoque` (`id_estoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `top_filmes_locadora`.`filme_ator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `top_filmes_locadora`.`filme_ator` (
  `id_filme` INT NOT NULL,
  `id_ator` INT NOT NULL,
  PRIMARY KEY (`id_filme`, `id_ator`),
  INDEX `fk_filme_ator2_idx` (`id_ator` ASC) VISIBLE,
  CONSTRAINT `fk_filme_ator1`
    FOREIGN KEY (`id_filme`)
    REFERENCES `top_filmes_locadora`.`filmes` (`id_filme`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_filme_ator2`
    FOREIGN KEY (`id_ator`)
    REFERENCES `top_filmes_locadora`.`atores` (`id_ator`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `top_filmes_locadora`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `top_filmes_locadora`.`categorias` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT,
  `nome_categoria` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `top_filmes_locadora`.`filmes_categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `top_filmes_locadora`.`filmes_categoria` (
  `id_filme` INT NOT NULL,
  `id_categoria` INT NOT NULL,
  PRIMARY KEY (`id_filme`, `id_categoria`),
  INDEX `fk_filmes_categoria2_idx` (`id_categoria` ASC) VISIBLE,
  CONSTRAINT `fk_filmes_categoria1`
    FOREIGN KEY (`id_filme`)
    REFERENCES `top_filmes_locadora`.`filmes` (`id_filme`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_filmes_categoria2`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `top_filmes_locadora`.`categorias` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
