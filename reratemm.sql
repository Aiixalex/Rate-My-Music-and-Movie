-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Apr 11, 2021 at 08:57 AM
-- Server version: 8.0.21
-- PHP Version: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `reratemm`
--

-- --------------------------------------------------------

--
-- Table structure for table `Act`
--

DROP TABLE IF EXISTS `Act`;
CREATE TABLE IF NOT EXISTS `Act` (
  `movie_id` int NOT NULL,
  `actor_id` int NOT NULL,
  PRIMARY KEY (`movie_id`,`actor_id`) USING BTREE,
  INDEX `movie_id_fk` (`movie_id`) USING BTREE,
  INDEX `actor_id_fk` (`actor_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

--
-- Dumping data for table `Act`
--

INSERT INTO `Act` (`movie_id`, `actor_id`) VALUES
(5, 1),
(4, 2),
(2, 4),
(1, 5),
(2, 5),
(3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `Actor`
--

DROP TABLE IF EXISTS `Actor`;
CREATE TABLE IF NOT EXISTS `Actor` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `country` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `date_of_birth` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

--
-- Dumping data for table `Actor`
--

INSERT INTO `Actor` (`id`, `name`, `country`, `date_of_birth`) VALUES
(1, 'Jackie Chan', 'Hong Kong', '19540407'),
(2, 'Robert Downey Jr.', 'United States of America', '19650404'),
(3, 'Takeru Satoh', 'Japan', '19890321'),
(4, 'Hyun Bin', 'Korea', '19820925'),
(5, 'Fan Bingbing', 'China', '19810916');

-- --------------------------------------------------------

--
-- Table structure for table `Album`
--

DROP TABLE IF EXISTS `Album`;
CREATE TABLE IF NOT EXISTS `Album` (
  `id` int NOT NULL,
  `cover` varchar(255) DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `album_or_ep` int DEFAULT NULL,
  `releaseDate` datetime DEFAULT NULL,
  `detailedInfo` text CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `genre_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

--
-- Dumping data for table `Album`
--

INSERT INTO `Album` (`id`, `cover`, `name`, `album_or_ep`, `releaseDate`, `detailedInfo`, `genre_id`) VALUES
(1, NULL, 'album_1', 1, '2020-01-01 00:00:00', 'info1', 4),
(2, NULL, 'album_2', 1, '2020-01-02 00:00:00', 'info2', 4),
(3, NULL, 'album_3', 1, '2020-01-03 00:00:00', 'info3', 4),
(4, NULL, 'album_4', 0, '2020-01-04 00:00:00', 'info4', 4),
(5, NULL, 'album_5', 1, '2020-01-05 00:00:00', 'info5', 4);

-- --------------------------------------------------------

--
-- Table structure for table `AlbumArtist`
--

DROP TABLE IF EXISTS `AlbumArtist`;
CREATE TABLE IF NOT EXISTS `AlbumArtist` (
  `album_id` int NOT NULL,
  `artist_id` int NOT NULL,
  PRIMARY KEY (`album_id`,`artist_id`) USING BTREE,
  INDEX `album_id_fk` (`album_id`) USING BTREE,
  INDEX `artist_id_fk` (`artist_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

--
-- Dumping data for table `AlbumArtist`
--

INSERT INTO `AlbumArtist` (`album_id`, `artist_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 2);

-- --------------------------------------------------------

--
-- Table structure for table `AlbumComment`
--

DROP TABLE IF EXISTS `AlbumComment`;
CREATE TABLE IF NOT EXISTS `AlbumComment` (
  `comment_id` int NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `createtime` datetime DEFAULT NULL,
  `album_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `album_id_fk` (`album_id`) USING BTREE,
  INDEX `user_id_fk` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

--
-- Dumping data for table `AlbumComment`
--

INSERT INTO `AlbumComment` (`comment_id`, `content`, `createtime`, `album_id`, `user_id`) VALUES
(1, '{content1:\"content1\",content2:\"conten2\"}', '2019-01-01 00:00:00', 1, 31703000),
(2, '{content1:\"content1\",content2:\"conten2\"}', '2019-01-02 00:00:00', 1, 31703001),
(3, '{content1:\"content1\",content2:\"conten2\"}', '2019-01-03 00:00:00', 1, 31703003),
(4, '{content1:\"content1\",content2:\"conten2\"}', '2019-01-04 00:00:00', 1, 31703003),
(5, '{content1:\"content1\",content2:\"conten2\"}', '2019-01-05 00:00:00', 1, 31703004);

-- --------------------------------------------------------

--
-- Table structure for table `AlbumRating`
--

DROP TABLE IF EXISTS `AlbumRating`;
CREATE TABLE IF NOT EXISTS `AlbumRating` (
  `createtime` datetime DEFAULT NULL,
  `value` int DEFAULT NULL,
  `album_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`album_id`, `user_id`) USING BTREE,
  INDEX `album_id_fk` (`album_id`) USING BTREE,
  INDEX `user_id_fk` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

--
-- Dumping data for table `AlbumRating`
--

INSERT INTO `AlbumRating` (`createtime`, `value`, `album_id`, `user_id`) VALUES
('2020-03-01 00:00:00', 9, 1, 31703000),
('2020-03-02 00:00:00', 10, 1, 31703001),
('2020-03-03 00:00:00', 8, 2, 31703002),
('2020-03-04 00:00:00', 9, 2, 31703003),
('2020-03-05 00:00:00', 8, 3, 31703003);

-- --------------------------------------------------------

--
-- Table structure for table `Artist`
--

DROP TABLE IF EXISTS `Artist`;
CREATE TABLE IF NOT EXISTS `Artist` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `portrait` varchar(255) DEFAULT NULL,
  `detailedinfo` text CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `company` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `country` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `genre_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

--
-- Dumping data for table `Artist`
--

INSERT INTO `Artist` (`id`, `name`, `portrait`, `detailedinfo`, `company`, `country`, `genre_id`) VALUES
(1, 'Pink Floyd', NULL, 'info1', 'Columbia Records', 'British', 5),
(2, 'b', NULL, 'info2', 'MicroSoft', 'Canada', 5),
(3, 'c', NULL, 'info3', 'MicroSoft', 'Canada', 5),
(4, 'd', NULL, 'info4', 'SFU', 'Canada', 5),
(5, 'e', NULL, 'info5', 'SFU', 'Canada', 5);

-- --------------------------------------------------------

--
-- Table structure for table `Direct`
--

DROP TABLE IF EXISTS `Direct`;
CREATE TABLE IF NOT EXISTS `Direct` (
  `movie_id` int NOT NULL,
  `director_id` int NOT NULL,
  PRIMARY KEY (`movie_id`,`director_id`) USING BTREE,
  INDEX `movie_id_fk` (`movie_id`) USING BTREE,
  INDEX `director_id_fk` (`director_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

--
-- Dumping data for table `Direct`
--

INSERT INTO `Direct` (`movie_id`, `director_id`) VALUES
(5, 1),
(4, 2),
(3, 3),
(2, 4),
(1, 5);

-- --------------------------------------------------------

--
-- Table structure for table `Director`
--

DROP TABLE IF EXISTS `Director`;
CREATE TABLE IF NOT EXISTS `Director` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `country` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `date_of_birth` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

--
-- Dumping data for table `Director`
--

INSERT INTO `Director` (`id`, `name`, `country`, `date_of_birth`) VALUES
(1, 'director_1', 'country_1', '19700201'),
(2, 'director_2', 'country_2', '19700202'),
(3, 'director_3', 'country_3', '19700301'),
(4, 'director_4', 'country_4', '19700203'),
(5, 'director_5', 'country_5', '19700204');

-- --------------------------------------------------------

--
-- Table structure for table `Genre`
--

DROP TABLE IF EXISTS `Genre`;
CREATE TABLE IF NOT EXISTS `Genre` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `album_track_artist_movie` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

--
-- Dumping data for table `Genre`
--

INSERT INTO `Genre` (`id`, `name`, `album_track_artist_movie`) VALUES
(1, 'genre_1', 2),
(2, 'genre_2', 2),
(3, 'genre_3', 4),
(4, 'genre_4', 1),
(5, 'genre_5', 3);

-- --------------------------------------------------------

--
-- Table structure for table `Movie`
--

DROP TABLE IF EXISTS `Movie`;
CREATE TABLE IF NOT EXISTS `Movie` (
  `id` int NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `release_date` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `country` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `detailed_information` text CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `genre_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

--
-- Dumping data for table `Movie`
--

INSERT INTO `Movie` (`id`, `title`, `release_date`, `country`, `detailed_information`, `genre_id`) VALUES
(1, 'movie_1', '20180505', 'China', 'movie_info_1', 3),
(2, 'movie_2', '20180502', 'China', 'movie_info_2', 3),
(3, 'movie_3', '20180503', 'China', 'movie_info_3', 3),
(4, 'movie_4', '20180504', 'China', 'movie_info_4', 3),
(5, 'movie_5', '20180505', 'China', 'movie_info_5', 3);

-- --------------------------------------------------------

--
-- Table structure for table `MovieComment`
--

DROP TABLE IF EXISTS `MovieComment`;
CREATE TABLE IF NOT EXISTS `MovieComment` (
  `comment_id` int NOT NULL,
  `createtime` datetime DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_bin,
  `movie_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `movie_id_fk` (`movie_id`) USING BTREE,
  INDEX `user_id_fk` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

--
-- Dumping data for table `MovieComment`
--

INSERT INTO `MovieComment` (`comment_id`, `createtime`, `content`, `movie_id`, `user_id`) VALUES
(1, '2020-01-01 00:00:00', 'comment_1', 1, 31703001),
(2, '2020-02-01 00:00:00', 'comment_2', 2, 31703001),
(3, '2020-03-01 00:00:00', 'comment_3', 2, 31703002),
(4, '2020-04-01 00:00:00', 'comment_4', 4, 31703003),
(5, '2020-05-01 00:00:00', 'comment_5', 5, 31703004);

-- --------------------------------------------------------

--
-- Table structure for table `MovieRating`
--

DROP TABLE IF EXISTS `MovieRating`;
CREATE TABLE IF NOT EXISTS `MovieRating` (
  `createtime` datetime DEFAULT NULL,
  `value` int DEFAULT NULL,
  `movie_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`movie_id`, `user_id`) USING BTREE,
  INDEX `movie_id_fk` (`movie_id`) USING BTREE,
  INDEX `user_id_fk` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

--
-- Dumping data for table `MovieRating`
--

INSERT INTO `MovieRating` (`createtime`, `value`, `movie_id`, `user_id`) VALUES
('2020-02-01 00:00:00', 7, 1, 31703001),
('2020-02-01 00:00:00', 6, 2, 31703003),
('2020-03-01 00:00:00', 8, 3, 31703003),
('2020-04-01 00:00:00', 5, 4, 31703004),
('2020-05-01 00:00:00', 10, 5, 31703004);

-- --------------------------------------------------------

--
-- Table structure for table `TrackArtist`
--

DROP TABLE IF EXISTS `TrackArtist`;
CREATE TABLE IF NOT EXISTS `TrackArtist` (
  `track_id` int NOT NULL,
  `album_id` int NOT NULL,
  `artist_id` int NOT NULL,
  PRIMARY KEY (`track_id`, `album_id`, `artist_id`) USING BTREE,
  INDEX `track_fk` (`track_id`, `album_id`) USING BTREE,
  INDEX `artist_id_fk` (`artist_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

--
-- Dumping data for table `TrackArtist`
--

INSERT INTO `TrackArtist` (`track_id`, `album_id`, `artist_id`) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 1, 1),
(4, 1, 1),
(1, 2, 1),
(1, 5, 2);

-- --------------------------------------------------------

--
-- Table structure for table `Track`
--

DROP TABLE IF EXISTS `Track`;
CREATE TABLE IF NOT EXISTS `Track` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `album_id` int NOT NULL,
  `genre_id` int DEFAULT NULL,
  PRIMARY KEY (`id`, `album_id`) USING BTREE,
  INDEX `album_id_fk` (`album_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

--
-- Dumping data for table `Track`
--

INSERT INTO `Track` (`id`, `name`, `album_id`, `genre_id`) VALUES
(1, 'track_1', 1, 1),
(2, 'track_2', 1, 1),
(3, 'track_3', 1, 1),
(4, 'track_4', 1, 1),
(1, 'track_1', 2, 2),
(1, 'track_1', 5, 2);

-- --------------------------------------------------------

--
-- Table structure for table `TrackRating`
--

DROP TABLE IF EXISTS `TrackRating`;
CREATE TABLE IF NOT EXISTS `TrackRating` (
  `createtime` datetime DEFAULT NULL,
  `value` int DEFAULT NULL,
  `track_id` int NOT NULL,
  `album_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`track_id`, `album_id`, `user_id`) USING BTREE,
  INDEX `track_fk` (`track_id`, `album_id`) USING BTREE,
  INDEX `user_id_fk` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

--
-- Dumping data for table `TrackRating`
--

INSERT INTO `TrackRating` (`createtime`, `value`, `track_id`, `album_id`, `user_id`) VALUES
('2020-01-01 00:00:00', 10, 1, 1, 31703001),
('2020-01-01 00:00:00', 9, 2, 1, 31703001),
('2020-01-01 00:00:00', 8, 3, 1, 31703001),
('2020-01-01 00:00:00', 6, 1, 1, 31703002),
('2020-01-01 00:00:00', 5, 2, 1, 31703002);

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
CREATE TABLE IF NOT EXISTS `User` (
  `id` int NOT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL UNIQUE,
  `music_rating_weight` double DEFAULT 10,
  `movie_rating_weight` double DEFAULT 10,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL UNIQUE,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `certification_information` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

--
-- Dumping data for table `User`
--

INSERT INTO `User` (`id`, `email`, `music_rating_weight`, `movie_rating_weight`, `username`, `password`, `certification_information`) VALUES
(31703000, 'a@sfu.ca', 50, 15, 'user0', '123456', 'Keyboard of Band Re-tros.'),
(31703001, 'b@sfu.ca', 10, 10, 'user1', '123456', NULL),
(31703002, 'c@sfu.ca', 10, 10, 'user2', 'fgh', NULL),
(31703003, 'd@sfu.ca', 10, 10, 'user3', 'jjlh', NULL),
(31703004, 'e@sfu.ca', 10, 10, 'user4', 'fgh', NULL),
(31703005, 'f@sfu.ca', 10, 10, 'user5', 'jjlh', NULL);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Act`
--
ALTER TABLE `Act`
  ADD CONSTRAINT `act_movie_fk` FOREIGN KEY (`movie_id`) REFERENCES `Movie` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `act_actor_fk` FOREIGN KEY (`actor_id`) REFERENCES `Actor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `AlbumArtist`
--
ALTER TABLE `AlbumArtist`
  ADD CONSTRAINT `aa_album_fk` FOREIGN KEY (`album_id`) REFERENCES `Album` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `aa_artist_fk` FOREIGN KEY (`artist_id`) REFERENCES `Artist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `AlbumComment`
--
ALTER TABLE `AlbumComment`
  ADD CONSTRAINT `ac_album_fk` FOREIGN KEY (`album_id`) REFERENCES `Album` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ac_user_fk` FOREIGN KEY (`user_id`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `AlbumRating`
--
ALTER TABLE `AlbumRating`
  ADD CONSTRAINT `ar_album_fk` FOREIGN KEY (`album_id`) REFERENCES `Album` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ar_user_fk` FOREIGN KEY (`user_id`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Album`
--
ALTER TABLE `Album`
  ADD CONSTRAINT `album_genre_fk` FOREIGN KEY (`genre_id`) REFERENCES `Genre` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Artist`
--
ALTER TABLE `Artist`
  ADD CONSTRAINT `artist_genre_fk` FOREIGN KEY (`genre_id`) REFERENCES `Genre` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Direct`
--
ALTER TABLE `Direct`
  ADD CONSTRAINT `direct_movie_fk` FOREIGN KEY (`movie_id`) REFERENCES `Movie` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `direct_director_fk` FOREIGN KEY (`director_id`) REFERENCES `Director` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `MovieComment`
--
ALTER TABLE `MovieComment`
  ADD CONSTRAINT `mc_movie_fk` FOREIGN KEY (`movie_id`) REFERENCES `Movie` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mc_user_fk` FOREIGN KEY (`user_id`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `MovieRating`
--
ALTER TABLE `MovieRating`
  ADD CONSTRAINT `mr_movie_fk` FOREIGN KEY (`movie_id`) REFERENCES `Movie` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mr_user_fk` FOREIGN KEY (`user_id`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Movie`
--
ALTER TABLE `Movie`
  ADD CONSTRAINT `movie_genre_fk` FOREIGN KEY (`genre_id`) REFERENCES `Genre` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `TrackArtist`
--
ALTER TABLE `TrackArtist`
  ADD CONSTRAINT `ta_track_fk` FOREIGN KEY (`track_id`, `album_id`) REFERENCES `Track` (`id`, `album_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ta_artist_fk` FOREIGN KEY (`artist_id`) REFERENCES `Artist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Track`
--
ALTER TABLE `Track`
  ADD CONSTRAINT `track_album_fk` FOREIGN KEY (`album_id`) REFERENCES `Album` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
  ADD CONSTRAINT `track_genre_fk` FOREIGN KEY (`genre_id`) REFERENCES `Genre` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `TrackRating`
--
ALTER TABLE `TrackRating`
  ADD CONSTRAINT `tr_track_fk` FOREIGN KEY (`track_id`, `album_id`) REFERENCES `Track` (`id`, `album_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tr_user_fk` FOREIGN KEY (`user_id`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
