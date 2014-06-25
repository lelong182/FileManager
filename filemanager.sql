-- phpMyAdmin SQL Dump
-- version 4.0.5
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 25, 2014 at 05:31 PM
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
('500f2e3d39f80920380d288a76c78d06', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; WOW64; rv:30.0) Gecko/20100101 Firefox/30.0', 1403690427, ''),
('782bb79459d12d2557fd69ec8b36464e', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; WOW64; rv:30.0) Gecko/20100101 Firefox/30.0', 1403702706, '');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

--
-- Dumping data for table `folder`
--

INSERT INTO `folder` (`folder_id`, `folder_name`, `slug`, `parent_id`, `created_date`, `updated_date`, `is_trash`) VALUES
(1, 'Album 1', 'album-1', 0, '2014-06-25 06:34:59', '0000-00-00 00:00:00', 0),
(2, 'Album 2', 'album-2', 0, '2014-06-25 06:35:13', '0000-00-00 00:00:00', 0),
(3, 'Album 3', 'album-3', 0, '2014-06-25 06:58:05', '0000-00-00 00:00:00', 0),
(4, 'Album 21', 'album-21', 2, '2014-06-25 06:55:17', '0000-00-00 00:00:00', 0),
(5, 'Album 22', 'album-22', 2, '2014-06-25 06:35:47', '0000-00-00 00:00:00', 0),
(6, 'Album 211', 'album-211', 4, '2014-06-25 06:36:01', '0000-00-00 00:00:00', 0),
(7, 'Album 212', 'album-212', 4, '2014-06-25 06:36:14', '0000-00-00 00:00:00', 0),
(8, 'Album 11', 'album-11', 1, '2014-06-25 06:36:41', '0000-00-00 00:00:00', 0),
(9, 'Album 4', 'album-4', 0, '2014-06-25 13:01:48', '0000-00-00 00:00:00', 0),
(10, 'Album 55', 'album-55', 0, '2014-06-25 13:09:18', '0000-00-00 00:00:00', 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
