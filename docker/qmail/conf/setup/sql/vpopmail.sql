-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: mariadb1.vm.ma-it.lan
-- Generation Time: Jun 15, 2018 at 12:39 PM
-- Server version: 10.2.15-MariaDB-10.2.15+maria~jessie-log
-- PHP Version: 7.0.27-0+deb9u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `vpopmail`
--

-- --------------------------------------------------------

--
-- Table structure for table `vpopmail`
--

DROP TABLE IF EXISTS `vpopmail`;
CREATE TABLE `vpopmail` (
  `pw_name` char(32) COLLATE latin1_bin NOT NULL,
  `pw_domain` char(96) COLLATE latin1_bin NOT NULL,
  `pw_passwd` char(40) COLLATE latin1_bin DEFAULT NULL,
  `pw_uid` int(11) DEFAULT NULL,
  `pw_gid` int(11) DEFAULT NULL,
  `pw_gecos` char(48) COLLATE latin1_bin DEFAULT NULL,
  `pw_dir` char(160) COLLATE latin1_bin DEFAULT NULL,
  `pw_shell` char(20) COLLATE latin1_bin DEFAULT NULL,
  `pw_clear_passwd` varchar(64) COLLATE latin1_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `vpopmail`
--
ALTER TABLE `vpopmail`
  ADD PRIMARY KEY (`pw_name`,`pw_domain`);
COMMIT;
