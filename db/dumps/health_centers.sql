-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: localhost:8889
-- Generation Time: Jul 25, 2014 at 06:08 AM
-- Server version: 5.5.34
-- PHP Version: 5.5.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `hyperlocal`
--

-- --------------------------------------------------------

--
-- Table structure for table `health_centers`
--

CREATE TABLE `health_centers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `disp_lat` float NOT NULL,
  `disp_lon` float NOT NULL,
  `address` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `city` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `state` tinytext COLLATE utf8_unicode_ci NOT NULL,
  `zip` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `operator` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=67 ;

--
-- Dumping data for table `health_centers`
--

INSERT INTO `health_centers` (`id`, `x`, `y`, `disp_lat`, `disp_lon`, `address`, `city`, `state`, `zip`, `operator`, `status`, `name`) VALUES
(1, -88.2443, 30.4201, -88.2455, 30.4201, '13040 N Wintzell Ave', 'Bayou La Batre', 'AL', '36509', 'Bayou La Batre Area Health Development Board, Inc.', 'FQHC(confirm)', 'Mostellar Dental Center'),
(2, -88.2444, 30.4226, 0, 0, '12701 Padgett Switch Rd', 'Bayou La Batre', 'AL', '36509', 'Bayou La Batre Area Health Development Board, Inc.', 'FQHC', 'Mostellar Medical Center'),
(3, -87.7521, 30.6221, -87.7521, 30.6225, '1083 E Relham Ave', 'Loxley', 'AL', '36551', 'Franklin Primary Health Center, Inc.', 'FQHC', 'Loxley Family Medical Center'),
(4, -87.6832, 30.428, -87.6824, 30.428, '1628 North McKenzie Street', 'Foley', 'AL', '36535', 'Franklin Primary Health Center, Inc.', 'FQHC', 'South Baldwin Family Health Center[5]'),
(5, -87.7502, 30.6221, 0, 0, '3147 1st Ave', 'Loxley', 'AL', '36551', 'Franklin Primary Health Center, Inc.', 'FQHC', 'Loxley Family Dental Center'),
(6, -88.0827, 30.7312, 0, 0, '424 S Wilson Ave', 'Prichard', 'AL', '36610', 'Franklin Primary Health Center, Inc.', 'FQHC', 'Aiello/Buskey Medical Center'),
(7, -88.1061, 30.6994, -88.1048, 30.6992, '300 Bay Shore Ave', 'Mobile', 'AL', '36607', 'Franklin Primary Health Center, Inc.', 'FQHC', 'Central Plaza Towers Health Center'),
(8, -88.0648, 30.6998, 0, 0, '1303 Dr Martin L King Jr Ave', 'Mobile', 'AL', '36603', 'Franklin Primary Health Center, Inc.', 'FQHC', 'Franklin Medical and Dental Express'),
(9, -88.0648, 30.6998, 0, 0, '1303 Dr Martin L King Jr Ave', 'Mobile', 'AL', '36603', 'Franklin Primary Health Center, Inc.', 'FQHC', 'Franklin Medical Mall'),
(10, -88.0648, 30.6998, 0, 0, '1303 Dr Martin Luther King', 'Mobile', 'AL', '36603', 'Franklin Primary Health Center, Inc.', 'FQHC', 'Franklin Memorial Primary Heath Center, Inc'),
(11, -88.0488, 30.6894, 0, 0, '553 Dauphin Street', 'Mobile', 'AL', '36602', 'Franklin Primary Health Center, Inc.', 'FQHC', 'H.E. Savage Center'),
(12, -88.0963, 30.7075, -88.096, 30.7076, '572 Stanton Road', 'Mobile', 'AL', '36617', 'Franklin Primary Health Center, Inc.', 'FQHC', 'Hadley Center?'),
(13, -88.067, 30.7005, 0, 0, '1361 Dr. Martin Luther King Jr. Ave', 'Mobile', 'AL', '36603', 'Franklin Primary Health Center, Inc.', 'FQHC', 'J.R. Thomas Wellness, Fitness, and Rehabilitation Center'),
(14, -88.0872, 30.6638, -88.0869, 30.6641, '1956 Duval St', 'Mobile', 'AL', '36606', 'Franklin Primary Health Center, Inc.', 'FQHC', 'Maysville Medical Center'),
(15, -88.0828, 30.7301, -88.0831, 30.7301, '510 S Wilson Ave', 'Prichard', 'AL', '36610', 'Franklin Primary Health Center, Inc.', 'FQHC', 'Prichard Medical Center'),
(16, -88.0598, 30.6877, -88.0598, 30.6875, '1055 Dauphin St', 'Mobile', 'AL', '36604', 'Franklin Primary Health Center, Inc.', 'FQHC', 'Prevention& Education Center'),
(17, -88.0632, 30.6921, -88.0634, 30.6917, '1201 Spring Hill Ave', 'Mobile', 'AL', '36604', 'Franklin Primary Health Center, Inc.', 'FQHC', 'Springhill Health Center'),
(18, -88.0648, 30.6998, 0, 0, '1303 Dr. Martin Luther King Ave', 'Mobile', 'AL', '36652', 'Franklin Primary Health Center, Inc.', 'FQHC', 'West Mobile Family Medical Center'),
(19, -88.0648, 30.6828, -88.0646, 30.6823, '1217 Government St', 'Mobile', 'AL', '36604', 'Franklin Primary Health Center, Inc.', 'FQHC', 'Women and Children?s Center'),
(20, -87.7751, 30.8834, -87.7754, 30.8833, '312 Courthouse Sq', 'Bay Minette', 'AL', '36507', 'Mobile County Health Department', 'FQHC', 'North Baldwin Rural HIV Clinic'),
(21, -88.2288, 31.0928, -88.2285, 31.0928, '19250 North Mobile Street', 'Citronelle', 'AL', '36522', 'Mobile County Health Department', 'FQHC', 'Citronelle Clinic'),
(22, -88.128, 30.7643, 0, 0, '4547 St. Stephens Rd', 'Eight Mile', 'AL', '36613', 'Mobile County Health Department', 'FQHC', 'Eight Mile Clinic'),
(23, -88.0546, 30.6921, 0, 0, '251 N Bayou St', 'Mobile', 'AL', '36603', 'Mobile County Health Department', 'FQHC', 'Family Oriented Primary Health Care Clinic'),
(24, -88.0764, 30.6993, -88.0763, 30.6987, '248 Cox St', 'Mobile', 'AL', '36604', 'Mobile County Health Department', 'FQHC', 'Newburn Clinic'),
(25, -88.0258, 31.0045, 0, 0, 'Highway 43', 'Mount Vernon', 'AL', '36560', 'Mobile County Health Department', 'FQHC', 'North Mobile Health Center'),
(26, -88.0603, 31.1065, 0, 0, '950 Coy Smith Hwy', 'Mount Vernon', 'AL', '36560', 'Mobile County Health Department', 'FQHC', 'North Mobile Health Center'),
(27, -88.2595, 30.7703, 0, 0, '3810 Wulff Rd E', 'Citronelle', 'AL', '36575', 'Mobile County Health Department', 'FQHC', 'Semmes Clinic'),
(28, -88.0774, 30.6962, -88.0778, 30.6975, '1700 Center St', 'Mobile', 'AL', '36604', 'Mobile County Health Department', 'FQHC', 'USA Children''s and Women''s Hospital CEC'),
(29, -88.0572, 30.7387, 0, 0, '800 Whitley St', 'Mobile', 'AL', '36610', 'Mobile County Health Department', 'FQHC', 'Mobile Co Training School Clinic'),
(30, -88.0546, 30.6921, 0, 0, '251 N Bayou St', 'Mobile', 'AL', '36603', 'Mobile County Health Department', 'FQHC', 'Mobile Medical Van'),
(31, -88.2478, 30.4035, -88.2475, 30.4035, '13833 Tapia Ave', 'Bayou La Batre', 'AL', '36509', 'BayouClinic, Inc.', 'FQHC Lookalike', 'Bayou Clinic'),
(32, -87.3262, 30.6207, -87.3258, 30.6208, '748 N Highway 29', 'Cantonment', 'FL', '32533', 'Escambia Community Clinics, Inc.', 'FQHC', 'Cantonment Family Practice'),
(33, -87.2204, 30.435, -87.2197, 30.4349, '2200 North Palafox St', 'Pensacola', 'FL', '32501', 'Escambia Community Clinics, Inc.', 'FQHC', 'Escambia Community Clinics, Inc.'),
(34, -87.233, 30.4317, 0, 0, '1221 W Lakeview Ave', 'Pensacola', 'FL', '32501', 'Escambia Community Clinics, Inc.', 'FQHC', 'Lakeview Center, Inc.'),
(35, -87.2063, 30.4402, -87.206, 30.4402, '2510 North 12th Ave', 'Pensacola', 'FL', '32503', 'Escambia Community Clinics, Inc.', 'FQHC', 'Lanza Pediatrics'),
(36, -87.043, 30.6353, 0, 0, '5520 Stewart St', 'Milton', 'FL', '32570', 'Escambia Community Clinics, Inc.', 'FQHC', 'Santa Rosa Community Clinic'),
(37, -86.681, 30.7971, -86.681, 30.7974, '1321 Georgia Avenue', 'Baker', 'FL', '32531', 'North Florida Medical Centers, Inc.', 'FQHC', 'Baker Family Medical Center'),
(38, -86.5697, 30.7174, -86.5711, 30.7174, '4100 S Ferdon Blvd', 'Crestview', 'FL', '32536', 'North Florida Medical Centers, Inc.', 'FQHC', 'Crestview Health Center'),
(39, -86.1158, 30.7188, 0, 0, '1290 Circle Dr', 'DeFuniak Springs', 'FL', '32435', 'Pancare Of Florida, Inc.', 'FQHC', 'DeFuniak Springs Clinic'),
(40, -85.961, 30.4775, 0, 0, '278 Church Road', 'Bruce', 'FL', '32455', 'Pancare Of Florida, Inc.', 'FQHC', 'Muscogee Creek Indian Tribal Health Center'),
(41, -85.6332, 30.175, -85.633, 30.1754, '2309 E 15th St', 'Panama City', 'FL', '32405', 'Pancare Of Florida, Inc.', 'FQHC', 'Community Health Center ? Bay County'),
(42, -85.6627, 30.1613, -85.663, 30.1613, '707 Jenks Ave', 'Panama City', 'FL', '32401', 'Pancare Of Florida, Inc.', 'FQHC', 'Community Health Center ? Bay City[2]'),
(43, -85.6627, 30.1613, -85.663, 30.1613, '707 Jenks Ave', 'Panama City', 'FL', '32401', 'Pancare Of Florida, Inc.', 'FQHC', 'PanCare Mobile Dental Unit'),
(44, -89.9119, 30.037, 0, 0, '4626 Alcee Fortier', 'New Orleans', 'LA', '70129', 'Mary Queen of Vietnam CDC', 'FQHC Lookalike', 'New Orleans East Louisianan (NOELA) Community Health Center'),
(45, -89.3541, 30.3144, 0, 0, '109 Hospital Drive Bay', 'St. Louis', 'MS', '39520', 'Coastal Family Health Center, Inc', 'FHQC', 'Coastal Family Health Center ? Hancock County Satellite Clinic?'),
(46, -89.1325, 30.6302, 0, 0, '23453 Central Dr', 'Saucier', 'MS', '39574', 'Coastal Family Health Center, Inc', 'FHQC', 'Coastal Family Health Center - Saucier Satellite Clinic'),
(47, -88.8872, 30.4025, -88.8869, 30.4028, '282 Lameuse St', 'Biloxi', 'MS', '39530', 'Coastal Family Health Center, Inc', 'FHQC', 'Coastal Family Health Center ? Lameuse'),
(48, -88.9007, 30.4035, -88.9007, 30.404, '1046 Division St', 'Biloxi', 'MS', '39530', 'Coastal Family Health Center, Inc', 'FHQC', 'Coastal Family Health Center ? Ob/Gyn'),
(49, -88.8973, 30.4466, -88.8973, 30.447, '3446 Big Ridge Rd', 'Diberville', 'MS', '39540', 'Coastal Family Health Center, Inc', 'FHQC', 'D''Iberville Clinic'),
(50, -89.1136, 30.3687, -89.1133, 30.3687, '1408 44th Ave', 'Gulfport', 'MS', '39501', 'Coastal Family Health Center, Inc', 'FHQC', 'Gulfport Extension Health Center'),
(51, -89.0873, 30.4041, -89.0873, 30.4043, '15024 Martin Luther King, Jr. Blvd', 'Gulfport', 'MS', '39501', 'Coastal Family Health Center, Inc', 'FHQC', 'Coastal Family Health Center ? Gulfport Clinic'),
(52, -89.2431, 30.3187, 0, 0, '257 Davis Ave', 'Pass Christian', 'MS', '39571', 'Coastal Family Health Center, Inc', 'FHQC', 'Pass Christian Health Center'),
(53, -88.5305, 30.437, 0, 0, '4770 Amoco Dr', 'Moss Point', 'MS', '39563', 'Coastal Family Health Center, Inc', 'FHQC', 'Coastal Family Health Center ? Moss Point'),
(54, -88.7036, 30.5005, -88.703, 30.5005, '10828 Highway 57', 'Van Cleave', 'MS', '39565', 'Coastal Family Health Center, Inc', 'FHQC', 'Coastal Family Health Center ? Vancleave'),
(55, -88.4996, 30.4135, -88.5008, 30.4146, '6601 Orange Grove Rd', 'Moss Point', 'MS', '39563', 'Coastal Family Health Center, Inc', 'FHQC', 'Ed Mayo School Clinic'),
(56, -88.5533, 30.413, -88.5528, 30.413, '4924 Church St', 'Moss Point', 'MS', '39563', 'Coastal Family Health Center, Inc', 'FHQC', 'Moss Point High School Clinic'),
(57, -88.9007, 30.4035, -88.9007, 30.404, '1046 Division St?', 'Biloxi', 'MS', '39530', 'Coastal Family Health Center, Inc', 'FHQC', 'CFHC/March of Dimes Mom & Baby Mobile Unit'),
(58, -88.887, 30.4032, 0, 0, '739 Division St', 'Biloxi', 'MS', '39530', 'Coastal Family Health Center, Inc', 'FHQC', 'Dental Mobile Unit'),
(59, 0, 0, 0, 0, '1709 Ridgefield Road', 'Thibodaux', 'LA', '70301', 'Teche Action', '', 'Teche Action Clinic @ Thibodaux'),
(60, 0, 0, 0, 0, '121 West 134th Place', 'Galliano', 'LA', '70354', 'Teche Action', '', 'Teche Action Clinic @ Galliano'),
(61, 0, 0, 0, 0, '1115 Weber Street', 'Franklin', ' LA', '70538', 'Teche Action', '', 'Teche Action Clinic @ Franklin'),
(62, 0, 0, 0, 0, '189 Mozart Drive', 'Houma', 'LA', '70363', 'Teche Action', '', 'Teche Action Clinic @ Dulac'),
(63, 0, 0, 0, 0, '1014 West Tunnel Blvd.', 'Houma', 'LA', '70360', 'Teche Action', '', 'Teche Action Clinic @ Houma'),
(64, 0, 0, 0, 0, '5140 Church St.', 'Lafitte', 'LA', '70067', 'Jefferson Community Health Care Centers', '', 'RFK Lafitte Medical Clinic'),
(65, 0, 0, 0, 0, '8200 Highway 23', 'Belle Chasse', 'LA', '70037', 'Access Health', '', 'Belle Chasse Community Health Center'),
(66, 0, 0, 0, 0, '8050 W. Judge Perez Dr, Suite 1300', ' Chalmette', 'LA', '70032', 'Access Health', '', 'St. Bernard Community Health Center');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
