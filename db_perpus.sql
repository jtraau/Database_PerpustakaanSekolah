-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 22, 2025 at 07:20 PM
-- Server version: 8.0.40
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_perpus`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Delete_bukuuu` (IN `id_bukubaru` INT)   BEGIN
    DELETE FROM buku WHERE id_buku=id_bukubaru;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Delete_peminjaman` (IN `id_peminjamanbaru` INT)   BEGIN
    DELETE FROM peminjaman 
    WHERE id_peminjaman = id_peminjamanbaru;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Delete_siswa` (IN `id_siswabaru` INT)   BEGIN
    DELETE FROM siswa
WHERE id_siswa = id_siswabaru ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Insert_buku` ()   BEGIN
INSERT INTO BUKU (judul_buku, penulis, kategori, stok) VALUES
('Sistem Operasi','Dian Kurniawan','Teknologi',6),
('Jaringan Komputer','Ahmad Fauzi','Teknologi',5),
('Cerita Rakyat Nusantara','Lestari Dewi','Sastra',9),
('Bahasa Inggris untuk Pemula','Jane Doe','Bahasa',10),
('Biologi Dasar','Budi Rahman','Sains',7),
('Kimia Organik','Siti Aminah','Sains',5),
('Teknik Elektro','Ridwan Hakim','Teknik',6),
('Fisika Modern','Albert Einstein','Sains',4),
('Manajemen Waktu','Steven Covey','Pengembangan',8),
('Strategi Belajar Efektif','Tony Buzan','Pendidikan',6);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Insert_peminjaman` ()   BEGIN
INSERT INTO peminjaman (id_siswa, id_buku,tanggal_pinjam,tanggal_kembali,status) VALUES
	(11, 2, '2025-02-01', '2025-02-08', 'Dipinjam'),
    (2, 5, '2025-01-28', '2025-02-04', 'Dikembalikan'),
    (3, 8, '2025-02-02', '2025-02-09', 'Dipinjam'),
    (4, 10, '2025-01-30', '2025-02-06', 'Dikembalikan'),
    (5, 3, '2025-01-25', '2025-02-01', 'Dikembalikan'),
    (15, 7, '2025-02-01', '2025-02-08', 'Dipinjam'),
    (7, 1, '2025-01-29', '2025-02-05', 'Dikembalikan'),
    (8, 9, '2025-02-03', '2025-02-10', 'Dipinjam'),
    (13, 4, '2025-01-27', '2025-02-03', 'Dikembalikan'),
    (10, 11, '2025-02-01', '2025-02-08', 'Dipinjam');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Insert_siswaaa` ()   BEGIN
INSERT INTO siswa(nama,kelas) VALUES
('Farhan Maulana', 'XII-TKJ'),
    ('Gita Permata', 'X-RPL'),
    ('Hadi Sucipto', 'X-TKJ'),
    ('Intan Permadi', 'XI-RPL'),
    ('Joko Santoso', 'XI-TKJ'),
    ('Kartika Sari', 'XII-RPL'),
    ('Lintang Putri', 'XII-TKJ'),
    ('Muhammad Rizky', 'X-RPL'),
    ('Novi Andriana', 'X-TKJ'),
    ('Olivia Hernanda', 'XI-RPL');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `List_buku` ()   BEGIN
DECLARE status_pinjam varchar(20);
SELECT DISTINCT b.id_buku,b.judul_buku,b.kategori,b.penulis,
(IF(p.id_peminjaman IS NOT NULL, 'Pernah dipinjam','Tidak pernah dipinjam'))
AS status_pinjam
FROM buku b
LEFT JOIN peminjaman p ON p.id_buku=b.id_buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `List_minjem` ()   BEGIN
    SELECT DISTINCT s.id_siswa, s.nama, s.kelas, p.status
    FROM siswa s
    JOIN peminjaman p ON s.id_siswa = p.id_siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `List_siswa` ()   BEGIN
DECLARE status_peminjaman varchar(30);
SELECT DISTINCT s.id_siswa, s.nama, s.kelas,
(IF(p.id_peminjaman IS NOT NULL, 'Pernah meminjam','Tidak pernah meminjam'))
AS status_peminjaman
FROM siswa s
    LEFT JOIN peminjaman p ON s.id_siswa = p.id_siswa
;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Select_buku` ()   BEGIN
SELECT * FROM buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Select_peminjaman` ()   BEGIN
SELECT * FROM peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Select_siswa` ()   BEGIN
SELECT * FROM siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `stok_kurang` (IN `id_siswan` INT, IN `id_bukun` INT)   BEGIN
UPDATE buku SET stok=stok-1 WHERE id_buku=id_bukun;
INSERT INTO peminjaman (id_siswa, id_buku, tanggal_pinjam, status) VALUES (id_siswan, id_bukun, CURRENT_DATE,"Dipinjam");
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `stok_nambah` (IN `id_peminjamann` INT, IN `id_bukun` INT)   BEGIN
UPDATE buku SET stok=stok+1 WHERE id_buku=id_bukun;
UPDATE peminjaman SET tanggal_kembali= CURRENT_DATE ,status="Dikembalikan" WHERE id_peminjaman=id_peminjamann;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_bukuuu` (IN `id_bukubaru` INT, IN `judul_bukubaru` VARCHAR(50), IN `penulisbaru` VARCHAR(30), IN `kategoribaru` VARCHAR(20), IN `stok` INT)   BEGIN
    UPDATE buku SET judul_buku = judul_bukubaru,
    penulis=penulisbaru,
    kategori=kategoribaru,
    stok=stokbaru
    WHERE id_buku = id_bukubaru;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_peminjaman` (IN `id_peminjamanbaru` INT, IN `id_siswabaru` INT, IN `id_bukubaru` INT, IN `tanggal_pinjambaru` DATE, IN `tanggal_kembalibaru` DATE, IN `status` VARCHAR(15))   BEGIN
    UPDATE peminjaman SET id_siswa = id_siswabaru, 
        id_buku = id_bukubaru, 
        tanggal_pinjam = tanggal_pinjambaru,
        tanggal_kembali = tanggal_kembalibaru, 
        status = statusbaru
    WHERE id_peminjaman = id_peminjamanbaru;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_siswa` (IN `id_siswabaru` INT, IN `namabaru` VARCHAR(100), IN `kelasbaru` VARCHAR(20))   BEGIN
    UPDATE siswa SET nama = namabaru,
        kelas = kelasbaru
    WHERE id_siswa = id_siswabaru ;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `id_buku` int NOT NULL,
  `judul_buku` varchar(50) DEFAULT NULL,
  `penulis` varchar(30) DEFAULT NULL,
  `kategori` varchar(20) DEFAULT NULL,
  `stok` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`id_buku`, `judul_buku`, `penulis`, `kategori`, `stok`) VALUES
(1, 'Algoritma dan Pemrograman', 'Andi Wijaya', 'Teknologi', 11),
(2, 'Dasar-dasar Database', 'Budi Santoso', 'Teknologi', 4),
(3, 'Matematika Diskrit', 'Rina Sari', 'Matematika', 1),
(4, 'Sejarah Dunia', 'John Smith', 'Sejarah', 0),
(5, 'Pemrograman Web dengan PHP', 'Eko Prasetyo', 'Teknologi', 5),
(6, 'Sistem Operasi', 'Dian Kurniawan', 'Teknologi', 3),
(7, 'Jaringan Komputer', 'Ahmad Fauzi', 'Teknologi', 2),
(8, 'Cerita Rakyat Nusantara', 'Lestari Dewi', 'Sastra', 6),
(9, 'Bahasa Inggris untuk Pemula', 'Jane Doe', 'Bahasa', 7),
(10, 'Biologi Dasar', 'Budi Rahman', 'Sains', 4),
(11, 'Kimia Organik', 'Siti Aminah', 'Sains', 2),
(12, 'Teknik Elektro', 'Ridwan Hakim', 'Teknik', 3),
(13, 'Fisika Modern', 'Albert Einstein', 'Sains', 1),
(14, 'Manajemen Waktu', 'Steven Covey', 'Pengembangan', 5),
(15, 'Strategi Belajar Efektif', 'Tony Buzan', 'Pendidikan', 3);

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id_peminjaman` int NOT NULL,
  `id_siswa` int DEFAULT NULL,
  `id_buku` int DEFAULT NULL,
  `tanggal_pinjam` date DEFAULT NULL,
  `tanggal_kembali` date DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `peminjaman`
--

INSERT INTO `peminjaman` (`id_peminjaman`, `id_siswa`, `id_buku`, `tanggal_pinjam`, `tanggal_kembali`, `status`) VALUES
(1, 11, 2, '2025-02-01', '2025-02-08', 'Dipinjam'),
(2, 2, 5, '2025-01-28', '2025-02-04', 'Dikembalikan'),
(3, 3, 8, '2025-02-02', '2025-02-09', 'Dipinjam'),
(4, 4, 10, '2025-01-30', '2025-02-06', 'Dikembalikan'),
(5, 5, 3, '2025-01-25', '2025-02-01', 'Dikembalikan'),
(6, 11, 2, '2025-02-01', '2025-02-08', 'Dipinjam'),
(7, 2, 5, '2025-01-28', '2025-02-04', 'Dikembalikan'),
(8, 3, 8, '2025-02-02', '2025-02-09', 'Dipinjam'),
(9, 4, 10, '2025-01-30', '2025-02-06', 'Dikembalikan'),
(10, 5, 3, '2025-01-25', '2025-02-01', 'Dikembalikan'),
(11, 15, 7, '2025-02-01', '2025-02-08', 'Dipinjam'),
(12, 7, 1, '2025-01-29', '2025-02-05', 'Dikembalikan'),
(13, 8, 9, '2025-02-03', '2025-02-22', 'Dikembalikan'),
(14, 13, 4, '2025-01-27', '2025-02-03', 'Dikembalikan'),
(15, 10, 11, '2025-02-01', '2025-02-08', 'Dipinjam'),
(18, 14, 1, '2025-02-21', '2025-02-21', 'Dikembalikan'),
(19, 13, 1, '2025-02-21', '2025-02-22', 'Dikembalikan');

-- --------------------------------------------------------

--
-- Table structure for table `siswa`
--

CREATE TABLE `siswa` (
  `id_siswa` int NOT NULL,
  `nama` varchar(30) DEFAULT NULL,
  `kelas` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `siswa`
--

INSERT INTO `siswa` (`id_siswa`, `nama`, `kelas`) VALUES
(1, 'Andi Saputra', 'X-RPL'),
(2, 'Budi Wijaya', 'X-TKJ'),
(3, 'Citra Lestari', 'XI-RPL'),
(4, 'Dewi Kurniawan', 'XI-TKJ'),
(5, 'Eko Prasetyo', 'XII-RPL'),
(6, 'Farhan Maulana', 'XII-TKJ'),
(7, 'Gita Permata', 'X-RPL'),
(8, 'Hadi Sucipto', 'X-TKJ'),
(9, 'Intan Permadi', 'XI-RPL'),
(10, 'Joko Santoso', 'XI-TKJ'),
(11, 'Kartika Sari', 'XII-RPL'),
(12, 'Lintang Putri', 'XII-TKJ'),
(13, 'Muhammad Rizky', 'X-RPL'),
(14, 'Novi Andriana', 'X-TKJ'),
(15, 'Olivia Hernanda', 'XI-RPL');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id_buku`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`);

--
-- Indexes for table `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`id_siswa`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `buku`
--
ALTER TABLE `buku`
  MODIFY `id_buku` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id_peminjaman` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id_siswa` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
