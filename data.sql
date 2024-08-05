-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 05, 2024 at 02:21 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `data`
--

-- --------------------------------------------------------

--
-- Table structure for table `item_pesanan`
--
-- Creation: Aug 05, 2024 at 11:03 AM
-- Last update: Aug 05, 2024 at 12:05 PM
--

CREATE TABLE `item_pesanan` (
  `id` int(11) NOT NULL,
  `id_pesanan` int(11) DEFAULT NULL,
  `id_produk` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `item_pesanan`
--

INSERT INTO `item_pesanan` (`id`, `id_pesanan`, `id_produk`, `quantity`) VALUES
(38, 16, 1, 1),
(39, 16, 2, 1),
(40, 16, 10, 2),
(41, 16, 3, 1),
(42, 16, 8, 1);

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--
-- Creation: Aug 05, 2024 at 11:03 AM
-- Last update: Aug 05, 2024 at 11:04 AM
--

CREATE TABLE `kategori` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`id`, `nama`) VALUES
(1, 'Minuman'),
(2, 'Makanan'),
(3, 'Promo');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--
-- Creation: Aug 05, 2024 at 11:59 AM
-- Last update: Aug 05, 2024 at 12:05 PM
--

CREATE TABLE `pembayaran` (
  `id` int(11) NOT NULL,
  `id_pesanan` int(11) DEFAULT NULL,
  `id_produk` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`id`, `id_pesanan`, `id_produk`, `quantity`) VALUES
(6, 16, 1, 1),
(7, 16, 2, 1),
(8, 16, 10, 2),
(9, 16, 3, 1),
(10, 16, 8, 1);

-- --------------------------------------------------------

--
-- Table structure for table `pesanan`
--
-- Creation: Aug 05, 2024 at 11:03 AM
-- Last update: Aug 05, 2024 at 12:05 PM
--

CREATE TABLE `pesanan` (
  `id` int(11) NOT NULL,
  `nomor_meja` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pesanan`
--

INSERT INTO `pesanan` (`id`, `nomor_meja`, `created_at`) VALUES
(16, 'MEJA NO 1', '2024-08-05 12:05:43');

-- --------------------------------------------------------

--
-- Table structure for table `printer`
--
-- Creation: Aug 05, 2024 at 11:03 AM
-- Last update: Aug 05, 2024 at 11:05 AM
--

CREATE TABLE `printer` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `printer`
--

INSERT INTO `printer` (`id`, `nama`) VALUES
(1, 'Printer Kasir'),
(2, 'Printer Dapur (Makanan)'),
(3, 'Printer Bar (Minuman)');

-- --------------------------------------------------------

--
-- Table structure for table `printer_produk`
--
-- Creation: Aug 05, 2024 at 11:03 AM
-- Last update: Aug 05, 2024 at 11:06 AM
--

CREATE TABLE `printer_produk` (
  `id_produk` int(11) DEFAULT NULL,
  `id_printer` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `printer_produk`
--

INSERT INTO `printer_produk` (`id_produk`, `id_printer`) VALUES
(1, 3),
(2, 3),
(3, 3),
(4, 3),
(5, 3),
(6, 3),
(7, 3),
(8, 2),
(9, 2),
(10, 2),
(11, 1);

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--
-- Creation: Aug 05, 2024 at 11:03 AM
-- Last update: Aug 05, 2024 at 11:04 AM
--

CREATE TABLE `produk` (
  `id` int(11) NOT NULL,
  `id_kategori` int(11) DEFAULT NULL,
  `nama` varchar(255) NOT NULL,
  `varian` varchar(255) DEFAULT NULL,
  `harga` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id`, `id_kategori`, `nama`, `varian`, `harga`) VALUES
(1, 1, 'Jeruk', 'DINGIN', 12000.00),
(2, 1, 'Jeruk', 'PANAS', 10000.00),
(3, 1, 'Teh', 'MANIS', 8000.00),
(4, 1, 'Teh', 'TAWAR', 5000.00),
(5, 1, 'Kopi', 'DINGIN', 8000.00),
(6, 1, 'Kopi', 'PANAS', 6000.00),
(7, 1, 'EXTRA ES BATU', NULL, 2000.00),
(8, 2, 'Mie', 'GORENG', 15000.00),
(9, 2, 'Mie', 'KUAH', 15000.00),
(10, 2, 'Nasi Goreng', NULL, 15000.00),
(11, 3, 'Nasi Goreng + Jeruk Dingin', NULL, 23000.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `item_pesanan`
--
ALTER TABLE `item_pesanan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pesanan` (`id_pesanan`),
  ADD KEY `id_produk` (`id_produk`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pesanan` (`id_pesanan`),
  ADD KEY `produk_ibfk_2` (`id_produk`);

--
-- Indexes for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `printer`
--
ALTER TABLE `printer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `printer_produk`
--
ALTER TABLE `printer_produk`
  ADD KEY `id_produk` (`id_produk`),
  ADD KEY `id_printer` (`id_printer`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_kategori` (`id_kategori`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `item_pesanan`
--
ALTER TABLE `item_pesanan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `pesanan`
--
ALTER TABLE `pesanan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `printer`
--
ALTER TABLE `printer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `item_pesanan`
--
ALTER TABLE `item_pesanan`
  ADD CONSTRAINT `item_pesanan_ibfk_1` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id`),
  ADD CONSTRAINT `item_pesanan_ibfk_2` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id`);

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id`),
  ADD CONSTRAINT `produk_ibfk_2` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id`);

--
-- Constraints for table `printer_produk`
--
ALTER TABLE `printer_produk`
  ADD CONSTRAINT `printer_produk_ibfk_1` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id`),
  ADD CONSTRAINT `printer_produk_ibfk_2` FOREIGN KEY (`id_printer`) REFERENCES `printer` (`id`);

--
-- Constraints for table `produk`
--
ALTER TABLE `produk`
  ADD CONSTRAINT `produk_ibfk_1` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
