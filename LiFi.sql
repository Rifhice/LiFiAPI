-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 22, 2018 at 07:09 PM
-- Server version: 5.7.22-0ubuntu0.16.04.1
-- PHP Version: 7.0.30-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `LiFi`
--

-- --------------------------------------------------------

--
-- Table structure for table `Department`
--

CREATE TABLE `Department` (
  `idDepartment` int(11) NOT NULL,
  `name` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Department`
--

INSERT INTO `Department` (`idDepartment`, `name`) VALUES
(38, 'Fresh Food'),
(47, 'Pet Food '),
(49, 'Condiments');

-- --------------------------------------------------------

--
-- Table structure for table `Discount`
--

CREATE TABLE `Discount` (
  `idDiscount` int(11) NOT NULL,
  `fkProduct` int(11) NOT NULL,
  `date_start` date NOT NULL,
  `date_end` date NOT NULL,
  `date_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Discount`
--

INSERT INTO `Discount` (`idDiscount`, `fkProduct`, `date_start`, `date_end`, `date_update`) VALUES
(56, 23, '2018-05-18', '2018-05-24', '2018-05-22 08:55:50'),
(57, 27, '2018-06-12', '2018-06-14', '2018-05-18 08:26:47'),
(58, 27, '2018-06-12', '2018-06-14', '2018-05-18 08:29:12'),
(59, 30, '2018-06-12', '2018-06-14', '2018-05-18 09:14:29'),
(60, 25, '2018-06-12', '2018-06-14', '2018-05-18 08:32:39'),
(61, 28, '2018-06-12', '2018-06-14', '2018-05-18 08:50:17'),
(65, 25, '2018-05-18', '2018-05-24', '2018-05-22 08:56:34'),
(67, 26, '2018-06-12', '2018-06-14', '2018-05-18 09:05:20'),
(68, 25, '2018-06-12', '2018-06-14', '2018-05-18 09:06:11'),
(69, 26, '2018-05-18', '2018-05-20', '2018-05-18 09:14:09');

-- --------------------------------------------------------

--
-- Table structure for table `Lamp`
--

CREATE TABLE `Lamp` (
  `idLamp` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `idDepartment` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Lamp`
--

INSERT INTO `Lamp` (`idLamp`, `name`, `idDepartment`) VALUES
(1, 'Fruits', 38),
(2, 'Rabbits', 47),
(3, 'Dogs', 47),
(4, 'Ketchup', 49),
(5, 'Vegetables', 38);

-- --------------------------------------------------------

--
-- Table structure for table `PercentagePriceDiscount`
--

CREATE TABLE `PercentagePriceDiscount` (
  `fkDiscount` int(11) NOT NULL,
  `percentage` float NOT NULL,
  `fidelity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `PercentagePriceDiscount`
--

INSERT INTO `PercentagePriceDiscount` (`fkDiscount`, `percentage`, `fidelity`) VALUES
(56, 50, 0),
(61, 10, 0),
(65, 33, 1),
(69, 66, 0);

-- --------------------------------------------------------

--
-- Table structure for table `Product`
--

CREATE TABLE `Product` (
  `idProduct` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `description` varchar(256) NOT NULL,
  `price` float NOT NULL,
  `brand` varchar(32) NOT NULL,
  `idDepartment` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Product`
--

INSERT INTO `Product` (`idProduct`, `name`, `description`, `price`, `brand`, `idDepartment`) VALUES
(23, 'Light for dogs', 'Medium Maxi , 10 kg , contains carrots, apples, beans and chicken', 3, 'Ultima', 47),
(25, 'Ketchup', 'de qualité supérieur', 3, 'Heinz', 49),
(26, 'Gel', 'zero bacteries', 3, 'Mr Propre', 47),
(27, 'Eau', 'eau de source, état naturel', 1, 'Cristaline', 47),
(28, 'tabouret', 'dossier', 27, 'table&chaises', 38),
(30, 'épuisette', 'bleue et robuste', 20, 'Decath&Peche', 38),
(31, 'tabouret', 'dossier', 27, 'table&chaises', 38);

-- --------------------------------------------------------

--
-- Table structure for table `QuantityDiscount`
--

CREATE TABLE `QuantityDiscount` (
  `bought` int(11) NOT NULL,
  `free` int(11) NOT NULL,
  `fkDiscount` int(11) NOT NULL,
  `fidelity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `QuantityDiscount`
--

INSERT INTO `QuantityDiscount` (`bought`, `free`, `fkDiscount`, `fidelity`) VALUES
(3, 2, 59, 1),
(5, 2, 67, 1),
(5, 2, 68, 1);

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `id` int(11) NOT NULL,
  `password` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `User`
--

INSERT INTO `User` (`id`, `password`) VALUES
(1, '5f4dcc3b5aa765d61d8327deb882cf99');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Department`
--
ALTER TABLE `Department`
  ADD PRIMARY KEY (`idDepartment`);

--
-- Indexes for table `Discount`
--
ALTER TABLE `Discount`
  ADD PRIMARY KEY (`idDiscount`),
  ADD KEY `fkProduct` (`fkProduct`);

--
-- Indexes for table `Lamp`
--
ALTER TABLE `Lamp`
  ADD PRIMARY KEY (`idLamp`),
  ADD KEY `id_department` (`idDepartment`);

--
-- Indexes for table `PercentagePriceDiscount`
--
ALTER TABLE `PercentagePriceDiscount`
  ADD PRIMARY KEY (`fkDiscount`),
  ADD KEY `fkDiscount` (`fkDiscount`);

--
-- Indexes for table `Product`
--
ALTER TABLE `Product`
  ADD PRIMARY KEY (`idProduct`),
  ADD KEY `id_department` (`idDepartment`);

--
-- Indexes for table `QuantityDiscount`
--
ALTER TABLE `QuantityDiscount`
  ADD PRIMARY KEY (`fkDiscount`),
  ADD KEY `fkDiscount` (`fkDiscount`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Department`
--
ALTER TABLE `Department`
  MODIFY `idDepartment` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;
--
-- AUTO_INCREMENT for table `Discount`
--
ALTER TABLE `Discount`
  MODIFY `idDiscount` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;
--
-- AUTO_INCREMENT for table `Product`
--
ALTER TABLE `Product`
  MODIFY `idProduct` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
--
-- AUTO_INCREMENT for table `User`
--
ALTER TABLE `User`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `Discount`
--
ALTER TABLE `Discount`
  ADD CONSTRAINT `Discount_Product` FOREIGN KEY (`fkProduct`) REFERENCES `Product` (`idProduct`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Lamp`
--
ALTER TABLE `Lamp`
  ADD CONSTRAINT `Lamp_ibfk_1` FOREIGN KEY (`idDepartment`) REFERENCES `Department` (`idDepartment`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `PercentagePriceDiscount`
--
ALTER TABLE `PercentagePriceDiscount`
  ADD CONSTRAINT `discountid` FOREIGN KEY (`fkDiscount`) REFERENCES `Discount` (`idDiscount`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Product`
--
ALTER TABLE `Product`
  ADD CONSTRAINT `Product_ibfk_1` FOREIGN KEY (`idDepartment`) REFERENCES `Department` (`idDepartment`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `QuantityDiscount`
--
ALTER TABLE `QuantityDiscount`
  ADD CONSTRAINT `quantity_discountid` FOREIGN KEY (`fkDiscount`) REFERENCES `Discount` (`idDiscount`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
