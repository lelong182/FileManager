-- phpMyAdmin SQL Dump
-- version 4.0.5
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 25, 2014 at 07:17 AM
-- Server version: 5.5.32-MariaDB-log
-- PHP Version: 5.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `filemanager`
--

-- --------------------------------------------------------

--
-- Table structure for table `ci_sessions`
--

CREATE TABLE IF NOT EXISTS `ci_sessions` (
  `session_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `ip_address` varchar(45) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `user_agent` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `last_activity_idx` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `ci_sessions`
--

INSERT INTO `ci_sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('54ec25b4fc9956360358240a7483a562', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; WOW64; rv:30.0) Gecko/20100101 Firefox/30.0', 1403665830, '');

-- --------------------------------------------------------

--
-- Table structure for table `folder`
--

CREATE TABLE IF NOT EXISTS `folder` (
  `folder_id` int(11) NOT NULL AUTO_INCREMENT,
  `folder_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `parent_id` int(11) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_date` datetime NOT NULL,
  `is_trash` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`folder_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=23 ;

--
-- Dumping data for table `folder`
--

INSERT INTO `folder` (`folder_id`, `folder_name`, `slug`, `parent_id`, `created_date`, `updated_date`, `is_trash`) VALUES
(1, 'folder1', 'folder1', 0, '2014-06-24 03:38:28', '0000-00-00 00:00:00', 0),
(2, 'folder2', 'folder2', 1, '2014-06-24 03:38:58', '0000-00-00 00:00:00', 0),
(3, 'folder3', 'folder3', 1, '2014-06-24 03:39:48', '0000-00-00 00:00:00', 0),
(4, 'folder4', 'folder4', 1, '2014-06-23 18:42:36', '0000-00-00 00:00:00', 0),
(5, 'Hình ảnh', 'hinh-anh', 0, '2014-06-23 18:43:11', '0000-00-00 00:00:00', 0),
(6, 'Hình ảnh 2', 'hinh-anh-2', 5, '2014-06-23 18:49:39', '0000-00-00 00:00:00', 0),
(7, 'Hình ảnh 3', 'hinh-anh-3', 5, '2014-06-23 18:51:13', '0000-00-00 00:00:00', 0),
(8, 'folder11', 'folder11', 2, '2014-06-23 19:11:12', '0000-00-00 00:00:00', 0),
(9, 'scc', 'scc', 8, '2014-06-23 19:32:47', '0000-00-00 00:00:00', 0),
(10, 'test', 'test', 8, '2014-06-23 20:35:04', '0000-00-00 00:00:00', 0),
(11, 'test2', 'test2', 8, '2014-06-23 20:35:17', '0000-00-00 00:00:00', 0),
(12, 'test33', 'test33', 3, '2014-06-24 08:40:17', '0000-00-00 00:00:00', 0),
(13, 'asdasda', 'asdasda', 3, '2014-06-24 08:40:20', '0000-00-00 00:00:00', 0),
(14, 'Du lịch', 'du-lich', 0, '2014-06-25 02:55:26', '0000-00-00 00:00:00', 0),
(15, 'Du lịch 1', 'du-lich-1', 14, '2014-06-25 02:56:20', '0000-00-00 00:00:00', 0),
(16, 'Album 1', 'album-1', 14, '2014-06-25 03:08:52', '0000-00-00 00:00:00', 0),
(17, 'testtest', 'testtest', 0, '2014-06-25 03:09:23', '0000-00-00 00:00:00', 0),
(18, 'Biển', 'bien', 0, '2014-06-25 03:10:44', '0000-00-00 00:00:00', 0),
(19, 'Album 11', 'album-11', 17, '2014-06-25 03:11:33', '0000-00-00 00:00:00', 0),
(20, 'Hình ảnh 33', 'hinh-anh-33', 7, '2014-06-25 03:12:30', '0000-00-00 00:00:00', 0),
(21, 'poo', 'poo', 0, '2014-06-25 03:13:29', '0000-00-00 00:00:00', 0),
(22, 'bar', 'bar', 0, '2014-06-25 03:14:45', '0000-00-00 00:00:00', 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
