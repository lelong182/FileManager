-- phpMyAdmin SQL Dump
-- version 4.0.5
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 09, 2014 at 01:56 PM
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
('d671f72aac6b46d6431ef18336154ffe', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; WOW64; rv:30.0) Gecko/20100101 Firefox/30.0', 1404899098, '');

-- --------------------------------------------------------

--
-- Table structure for table `file`
--

CREATE TABLE IF NOT EXISTS `file` (
  `file_id` int(11) NOT NULL AUTO_INCREMENT,
  `folder_id` int(11) NOT NULL,
  `file_name` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `raw_name` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `file_type` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `file_ext` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `size` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `capacity` int(11) NOT NULL,
  `date_upload` datetime NOT NULL,
  `date_update` datetime NOT NULL,
  PRIMARY KEY (`file_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=26 ;

--
-- Dumping data for table `file`
--

INSERT INTO `file` (`file_id`, `folder_id`, `file_name`, `raw_name`, `file_type`, `file_ext`, `size`, `capacity`, `date_upload`, `date_update`) VALUES
(1, 1, 'no_image.jpg', 'no_image', 'image/jpeg', '.jpg', '375x375', 8, '2014-07-09 15:28:56', '2014-07-09 15:28:56'),
(2, 1, 'no-image.jpg', 'no-image', 'image/jpeg', '.jpg', '279x279', 7, '2014-07-09 15:28:56', '2014-07-09 15:28:56'),
(3, 2, 'no_image.jpg', 'no_image', 'image/jpeg', '.jpg', '375x375', 8, '2014-07-09 15:30:41', '2014-07-09 15:30:41'),
(4, 2, 'no-image.jpg', 'no-image', 'image/jpeg', '.jpg', '279x279', 7, '2014-07-09 15:30:41', '2014-07-09 15:30:41'),
(5, 1, '1-layout_copy.jpg', '1-layout_copy', 'image/jpeg', '.jpg', '1920x1715', 1560, '2014-07-09 15:50:53', '2014-07-09 15:50:53'),
(6, 2, '1-layout_copy.jpg', '1-layout_copy', 'image/jpeg', '.jpg', '1920x1715', 1560, '2014-07-09 15:56:43', '2014-07-09 15:56:43'),
(7, 2, '1-layout_copy1.jpg', '1-layout_copy1', 'image/jpeg', '.jpg', '1920x1715', 1560, '2014-07-09 15:59:03', '2014-07-09 15:59:03'),
(8, 2, 'layout-tgk.jpg', 'layout-tgk', 'image/jpeg', '.jpg', '1200x1354', 786, '2014-07-09 15:59:03', '2014-07-09 15:59:03'),
(9, 2, '1-layout_copy2.jpg', '1-layout_copy2', 'image/jpeg', '.jpg', '1920x1715', 1560, '2014-07-09 16:00:14', '2014-07-09 16:00:14'),
(10, 2, 'layout-tgk1.jpg', 'layout-tgk1', 'image/jpeg', '.jpg', '1200x1354', 786, '2014-07-09 16:00:14', '2014-07-09 16:00:14'),
(11, 2, 'Logo_mize_task_00_Tong_hop.jpg', 'Logo_mize_task_00_Tong_hop', 'image/jpeg', '.jpg', '1754x1240', 1175, '2014-07-09 16:00:15', '2014-07-09 16:00:15'),
(12, 3, '1-layout_copy.jpg', '1-layout_copy', 'image/jpeg', '.jpg', '1920x1715', 1560, '2014-07-09 16:11:44', '2014-07-09 16:11:44'),
(13, 3, 'layout-tgk.jpg', 'layout-tgk', 'image/jpeg', '.jpg', '1200x1354', 786, '2014-07-09 16:11:45', '2014-07-09 16:11:45'),
(14, 3, '1-layout_copy1.jpg', '1-layout_copy1', 'image/jpeg', '.jpg', '1920x1715', 1560, '2014-07-09 16:12:13', '2014-07-09 16:12:13'),
(15, 3, '4-layout-detail.jpg', '4-layout-detail', 'image/jpeg', '.jpg', '1200x1612', 479, '2014-07-09 16:12:13', '2014-07-09 16:12:13'),
(16, 3, 'Photo0679.jpg', 'Photo0679', 'image/jpeg', '.jpg', '2048x1536', 1098, '2014-07-09 16:16:53', '2014-07-09 16:16:53'),
(17, 3, 'title.jpg', 'title', 'image/jpeg', '.jpg', '58x15', 1, '2014-07-09 16:17:51', '2014-07-09 16:17:51'),
(18, 3, 'Logo_mize_task_00_Tong_hop.jpg', 'Logo_mize_task_00_Tong_hop', 'image/jpeg', '.jpg', '1754x1240', 1175, '2014-07-09 16:18:48', '2014-07-09 16:18:48'),
(19, 1, 'title.jpg', 'title', 'image/jpeg', '.jpg', '58x15', 1, '2014-07-09 16:23:58', '2014-07-09 16:23:58'),
(20, 1, 'logo_mize_task_02-01.png', 'logo_mize_task_02-01', 'image/png', '.png', '1754x933', 38, '2014-07-09 16:25:59', '2014-07-09 16:25:59'),
(21, 3, 'trangchu.jpg', 'trangchu', 'image/jpeg', '.jpg', '1400x2137', 1704, '2014-07-09 16:30:08', '2014-07-09 16:30:08'),
(22, 3, 'Photo06791.jpg', 'Photo06791', 'image/jpeg', '.jpg', '2048x1536', 1098, '2014-07-09 16:44:58', '2014-07-09 16:44:58'),
(23, 3, 'Logo_mize_task_00_Tong_hop1.jpg', 'Logo_mize_task_00_Tong_hop1', 'image/jpeg', '.jpg', '1754x1240', 1175, '2014-07-09 16:45:57', '2014-07-09 16:45:57'),
(24, 2, 'logo_mize_task_02-01.png', 'logo_mize_task_02-01', 'image/png', '.png', '1754x933', 38, '2014-07-09 16:48:21', '2014-07-09 16:48:21'),
(25, 2, 'logo_mize_task.png', 'logo_mize_task', 'image/png', '.png', '184x184', 7, '2014-07-09 16:48:21', '2014-07-09 16:48:21');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `folder`
--

INSERT INTO `folder` (`folder_id`, `folder_name`, `slug`, `parent_id`, `created_date`, `updated_date`, `is_trash`) VALUES
(1, 'Album 1', 'album-1', 0, '2014-07-07 16:04:38', '0000-00-00 00:00:00', 0),
(2, 'Album 2', 'album-2', 0, '2014-07-07 16:04:52', '0000-00-00 00:00:00', 0),
(3, 'Album 3', 'album-3', 0, '2014-07-07 16:05:03', '0000-00-00 00:00:00', 0),
(4, 'Album 31', 'album-31', 3, '2014-07-07 16:08:51', '0000-00-00 00:00:00', 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
