-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Lun 07 Mai 2018 à 12:59
-- Version du serveur :  5.7.22-0ubuntu0.16.04.1
-- Version de PHP :  7.0.28-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `LiFi`
--

-- --------------------------------------------------------

--
-- Structure de la table `Department`
--

CREATE TABLE `Department` (
  `idDepartment` int(11) NOT NULL,
  `name` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `Department`
--

INSERT INTO `Department` (`idDepartment`, `name`) VALUES
(2, 'Salut'),
(3, 'ayay'),
(5, 'salut2'),
(7, 'firstLamp');

-- --------------------------------------------------------

--
-- Structure de la table `Discount`
--

CREATE TABLE `Discount` (
  `idDiscount` int(11) NOT NULL,
  `fkProduct` int(11) NOT NULL,
  `date_start` date NOT NULL,
  `date_end` date NOT NULL,
  `date_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `Discount`
--

INSERT INTO `Discount` (`idDiscount`, `fkProduct`, `date_start`, `date_end`, `date_update`) VALUES
(27, 2, '2018-06-12', '2018-06-14', '2018-05-06 14:55:50'),
(29, 2, '2018-06-12', '2018-06-14', '2018-05-06 14:49:49'),
(30, 2, '2018-06-12', '2018-06-14', '2018-05-06 14:53:57'),
(31, 2, '2018-06-12', '2018-06-14', '2018-05-06 14:55:01'),
(32, 2, '2018-06-12', '2018-06-14', '2018-05-06 14:55:32');

-- --------------------------------------------------------

--
-- Structure de la table `Lamp`
--

CREATE TABLE `Lamp` (
  `idLamp` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `idDepartment` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `Lamp`
--

INSERT INTO `Lamp` (`idLamp`, `name`, `idDepartment`) VALUES
(8, '', NULL),
(10, 'undefined', 3),
(11, 'lampe1 damn', 2),
(12, 'lampe12 damn', 2),
(13, 'lampe12 damn', 2),
(14, 'lampe12 damn', 2),
(15, 'lampe12 damn', 2),
(16, 'lampe12 damn', 2),
(17, 'lampe12 damn', 2),
(18, 'lampe12 damn', 2),
(19, 'itWorks', 3),
(20, 'itWorks', 3),
(21, 'undefined', 3),
(22, 'undefined', 3),
(23, 'undefined', 3);

-- --------------------------------------------------------

--
-- Structure de la table `PercentagePriceDiscount`
--

CREATE TABLE `PercentagePriceDiscount` (
  `fkDiscount` int(11) NOT NULL,
  `percentage` float NOT NULL,
  `fidelity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `PercentagePriceDiscount`
--

INSERT INTO `PercentagePriceDiscount` (`fkDiscount`, `percentage`, `fidelity`) VALUES
(27, 4, 0),
(31, 4, 0),
(32, 4, 0);

-- --------------------------------------------------------

--
-- Structure de la table `Product`
--

CREATE TABLE `Product` (
  `idProduct` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `description` varchar(34) NOT NULL,
  `price` float NOT NULL,
  `brand` varchar(32) NOT NULL,
  `idDepartment` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `Product`
--

INSERT INTO `Product` (`idProduct`, `name`, `description`, `price`, `brand`, `idDepartment`) VALUES
(2, 'viande2', 'viande2', 3, 'viande', 2),
(3, 'fzeffezfzfzefz', 'fzefez', 12, 'fzefez', 3);

-- --------------------------------------------------------

--
-- Structure de la table `QuantityDiscount`
--

CREATE TABLE `QuantityDiscount` (
  `Bought` int(11) NOT NULL,
  `Free` int(11) NOT NULL,
  `fkDiscount` int(11) NOT NULL,
  `fidelity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `QuantityDiscount`
--

INSERT INTO `QuantityDiscount` (`Bought`, `Free`, `fkDiscount`, `fidelity`) VALUES
(4, 5, 29, 0),
(4, 5, 30, 0);

-- --------------------------------------------------------

--
-- Structure de la table `User`
--

CREATE TABLE `User` (
  `id` int(11) NOT NULL,
  `password` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `User`
--

INSERT INTO `User` (`id`, `password`) VALUES
(1, '5f4dcc3b5aa765d61d8327deb882cf99');

--
-- Index pour les tables exportées
--

--
-- Index pour la table `Department`
--
ALTER TABLE `Department`
  ADD PRIMARY KEY (`idDepartment`);

--
-- Index pour la table `Discount`
--
ALTER TABLE `Discount`
  ADD PRIMARY KEY (`idDiscount`),
  ADD KEY `fkProduct` (`fkProduct`);

--
-- Index pour la table `Lamp`
--
ALTER TABLE `Lamp`
  ADD PRIMARY KEY (`idLamp`),
  ADD KEY `id_department` (`idDepartment`);

--
-- Index pour la table `PercentagePriceDiscount`
--
ALTER TABLE `PercentagePriceDiscount`
  ADD PRIMARY KEY (`fkDiscount`),
  ADD KEY `fkDiscount` (`fkDiscount`);

--
-- Index pour la table `Product`
--
ALTER TABLE `Product`
  ADD PRIMARY KEY (`idProduct`),
  ADD KEY `id_department` (`idDepartment`);

--
-- Index pour la table `QuantityDiscount`
--
ALTER TABLE `QuantityDiscount`
  ADD PRIMARY KEY (`fkDiscount`),
  ADD KEY `fkDiscount` (`fkDiscount`);

--
-- Index pour la table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `Department`
--
ALTER TABLE `Department`
  MODIFY `idDepartment` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT pour la table `Discount`
--
ALTER TABLE `Discount`
  MODIFY `idDiscount` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;
--
-- AUTO_INCREMENT pour la table `Lamp`
--
ALTER TABLE `Lamp`
  MODIFY `idLamp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT pour la table `Product`
--
ALTER TABLE `Product`
  MODIFY `idProduct` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `User`
--
ALTER TABLE `User`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `Discount`
--
ALTER TABLE `Discount`
  ADD CONSTRAINT `Discount_Product` FOREIGN KEY (`fkProduct`) REFERENCES `Product` (`idProduct`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Lamp`
--
ALTER TABLE `Lamp`
  ADD CONSTRAINT `Lamp_ibfk_1` FOREIGN KEY (`idDepartment`) REFERENCES `Department` (`idDepartment`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Contraintes pour la table `PercentagePriceDiscount`
--
ALTER TABLE `PercentagePriceDiscount`
  ADD CONSTRAINT `discountid` FOREIGN KEY (`fkDiscount`) REFERENCES `Discount` (`idDiscount`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Product`
--
ALTER TABLE `Product`
  ADD CONSTRAINT `Product_ibfk_1` FOREIGN KEY (`idDepartment`) REFERENCES `Department` (`idDepartment`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Contraintes pour la table `QuantityDiscount`
--
ALTER TABLE `QuantityDiscount`
  ADD CONSTRAINT `quantity_discountid` FOREIGN KEY (`fkDiscount`) REFERENCES `Discount` (`idDiscount`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
