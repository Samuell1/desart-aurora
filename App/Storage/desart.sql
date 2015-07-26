-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 26, 2015 at 09:42 PM
-- Server version: 5.6.24-log
-- PHP Version: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `desart`
--

-- --------------------------------------------------------

--
-- Table structure for table `article`
--

CREATE TABLE IF NOT EXISTS `article` (
  `id` smallint(5) unsigned NOT NULL,
  `content` text NOT NULL,
  `description` varchar(115) NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `article`
--

INSERT INTO `article` (`id`, `content`, `description`, `create_time`, `update_time`) VALUES
(1, 'hjkanskfjnkjansf', 'asfasfasf', '2015-07-26 19:13:30', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `article_category`
--

CREATE TABLE IF NOT EXISTS `article_category` (
  `id` smallint(5) unsigned NOT NULL,
  `color` varchar(45) NOT NULL,
  `slug` varchar(225) NOT NULL,
  `description` tinytext,
  `parrent_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `hidden` tinyint(1) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `article_history`
--

CREATE TABLE IF NOT EXISTS `article_history` (
  `id` int(10) unsigned NOT NULL,
  `article_id` smallint(5) unsigned NOT NULL,
  `user_id` smallint(5) unsigned NOT NULL,
  `article_category_id` smallint(5) unsigned NOT NULL,
  `serie_id` tinyint(3) unsigned DEFAULT NULL,
  `content` text NOT NULL,
  `description` varchar(115) NOT NULL,
  `name` varchar(200) NOT NULL,
  `img` binary(20) NOT NULL,
  `status` enum('published','draft','private') NOT NULL DEFAULT 'published',
  `custom_tags` varchar(250) DEFAULT NULL,
  `tag_group_article_id` smallint(5) unsigned DEFAULT NULL,
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `article_metadata`
--

CREATE TABLE IF NOT EXISTS `article_metadata` (
  `id` smallint(5) unsigned NOT NULL,
  `tag_group_article_id` smallint(5) unsigned DEFAULT NULL,
  `article_category_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `image_id` mediumint(7) NOT NULL DEFAULT '0',
  `user_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `series_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `article_history_id` int(10) unsigned NOT NULL,
  `slug` varchar(225) NOT NULL,
  `name` varchar(200) NOT NULL,
  `reads` smallint(5) unsigned NOT NULL DEFAULT '0',
  `is_flash` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `custom_tags` varchar(250) DEFAULT NULL,
  `status` enum('published','draft','private') NOT NULL DEFAULT 'published',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `published_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `article_metadata`
--

INSERT INTO `article_metadata` (`id`, `tag_group_article_id`, `article_category_id`, `image_id`, `user_id`, `series_id`, `article_history_id`, `slug`, `name`, `reads`, `is_flash`, `custom_tags`, `status`, `type`, `create_time`, `update_time`, `published_time`) VALUES
(1, 0, 0, 0, 0, 0, 1, 'veeenex', 'VeeeneX je bomba', 0, 0, NULL, 'published', 0, '2015-07-26 19:14:21', NULL, '2015-07-26 19:14:21');

-- --------------------------------------------------------

--
-- Table structure for table `bans`
--

CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(11) unsigned NOT NULL COMMENT 'Id banu',
  `user_id` smallint(5) unsigned NOT NULL,
  `reason` tinytext CHARACTER SET utf8 COLLATE utf8_czech_ci NOT NULL COMMENT 'Dovod banu',
  `duration_time` timestamp NULL DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE IF NOT EXISTS `comments` (
  `id` smallint(5) unsigned NOT NULL,
  `article_id` smallint(5) unsigned NOT NULL,
  `user_id` smallint(5) unsigned NOT NULL,
  `reply_comment_id` smallint(5) unsigned DEFAULT NULL,
  `comment_history_id` mediumint(7) unsigned NOT NULL,
  `comment_type` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `text` tinytext NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `comment_history`
--

CREATE TABLE IF NOT EXISTS `comment_history` (
  `id` mediumint(7) unsigned NOT NULL,
  `change` tinytext NOT NULL,
  `change_type` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `comment_vote`
--

CREATE TABLE IF NOT EXISTS `comment_vote` (
  `id` int(10) unsigned NOT NULL,
  `comment_id` smallint(5) unsigned NOT NULL,
  `down_vote` tinyint(1) unsigned DEFAULT NULL,
  `up_vote` tinyint(1) unsigned DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `download`
--

CREATE TABLE IF NOT EXISTS `download` (
  `id` tinyint(3) unsigned NOT NULL COMMENT 'ID Stahovaneho suboru',
  `user_id` smallint(5) unsigned NOT NULL,
  `download_category_id` tinyint(4) unsigned NOT NULL,
  `name` varchar(150) NOT NULL COMMENT 'Nazov downloadu',
  `description` tinytext,
  `download_count` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT 'Pocet stiahnuti',
  `img` varchar(153) NOT NULL COMMENT 'Na velky obrazok',
  `preview` varchar(153) NOT NULL COMMENT 'Na maly obrazok',
  `file` int(11) unsigned NOT NULL,
  `author` varchar(150) DEFAULT 'Annonymous',
  `file_size` smallint(6) unsigned NOT NULL,
  `size_type` int(1) unsigned NOT NULL COMMENT 'Typy velkosti napr: MB - 1, KB - 2',
  `file_type` varchar(5) NOT NULL COMMENT 'Napr psd, bez body',
  `demo` varchar(255) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `download_category`
--

CREATE TABLE IF NOT EXISTS `download_category` (
  `id` tinyint(4) unsigned NOT NULL,
  `parent_id` smallint(5) unsigned NOT NULL,
  `color` varchar(45) NOT NULL,
  `slug` varchar(225) NOT NULL,
  `description` tinytext
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `favorite`
--

CREATE TABLE IF NOT EXISTS `favorite` (
  `id` smallint(5) unsigned NOT NULL,
  `user_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `item_id` int(11) unsigned NOT NULL,
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `image`
--

CREATE TABLE IF NOT EXISTS `image` (
  `id` mediumint(7) unsigned NOT NULL,
  `image` binary(20) NOT NULL,
  `extension` varchar(3) NOT NULL DEFAULT 'png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ip_log`
--

CREATE TABLE IF NOT EXISTS `ip_log` (
  `id` int(10) unsigned NOT NULL,
  `item_id` int(9) unsigned NOT NULL,
  `ip` int(10) unsigned NOT NULL,
  `item_type` mediumint(8) unsigned NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE IF NOT EXISTS `message` (
  `id` smallint(7) unsigned NOT NULL COMMENT 'Cislo spravy',
  `user_id` smallint(5) unsigned NOT NULL COMMENT 'Id pouzivatela// sender',
  `message_group_id` smallint(5) unsigned NOT NULL,
  `to_user_id` smallint(5) unsigned NOT NULL,
  `is_user` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `is_read` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `text` mediumtext NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `read_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `message_group`
--

CREATE TABLE IF NOT EXISTS `message_group` (
  `id` smallint(5) unsigned NOT NULL,
  `user_id` smallint(5) unsigned NOT NULL,
  `group_name` varchar(200) NOT NULL COMMENT 'Meno skupiny pouzivatel si moze vytvorit vlastnu skupinu mena mozu byt rovnake',
  `group_description` tinytext,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `message_user_group`
--

CREATE TABLE IF NOT EXISTS `message_user_group` (
  `message_group_id` smallint(5) unsigned NOT NULL,
  `message_group_user_id` smallint(5) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `micro_comment`
--

CREATE TABLE IF NOT EXISTS `micro_comment` (
  `id` smallint(5) unsigned NOT NULL,
  `user_id` smallint(5) unsigned NOT NULL,
  `question_id` smallint(5) unsigned NOT NULL,
  `comment_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT 'Typ komentara, clanook, stranka',
  `reply_comment_id` smallint(5) unsigned DEFAULT NULL,
  `comment_history_id` mediumint(7) unsigned NOT NULL,
  `text` varchar(250) NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `micro_commnet_vote`
--

CREATE TABLE IF NOT EXISTS `micro_commnet_vote` (
  `id` int(10) unsigned NOT NULL,
  `micro_comment_id` smallint(5) unsigned NOT NULL,
  `down_vote` tinyint(1) unsigned NOT NULL,
  `up_vote` tinyint(1) unsigned NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `newsletter`
--

CREATE TABLE IF NOT EXISTS `newsletter` (
  `id` smallint(5) unsigned NOT NULL,
  `email` varchar(300) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `selection_id` smallint(5) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `selection`
--

CREATE TABLE IF NOT EXISTS `selection` (
  `id` smallint(5) unsigned NOT NULL,
  `selection` tinytext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `series`
--

CREATE TABLE IF NOT EXISTS `series` (
  `id` smallint(5) unsigned NOT NULL,
  `name` varchar(200) NOT NULL,
  `slug` varchar(225) NOT NULL,
  `description` tinytext NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tag`
--

CREATE TABLE IF NOT EXISTS `tag` (
  `id` smallint(5) unsigned NOT NULL,
  `tag` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tag_group`
--

CREATE TABLE IF NOT EXISTS `tag_group` (
  `id` smallint(5) unsigned NOT NULL,
  `tag_id` smallint(5) unsigned NOT NULL,
  `article_id` smallint(5) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `topic`
--

CREATE TABLE IF NOT EXISTS `topic` (
  `id` smallint(5) unsigned NOT NULL,
  `locked_user_id` smallint(5) unsigned DEFAULT NULL,
  `topic_category_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `user_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `slug` varchar(225) NOT NULL,
  `name` varchar(200) NOT NULL,
  `edit_count` mediumint(8) unsigned NOT NULL,
  `reads` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `text` mediumtext NOT NULL,
  `locked` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='Databaza prispevku na fore';

-- --------------------------------------------------------

--
-- Table structure for table `topic_category`
--

CREATE TABLE IF NOT EXISTS `topic_category` (
  `id` tinyint(3) unsigned NOT NULL,
  `name` varchar(200) NOT NULL COMMENT 'Nazov fora',
  `slug` varchar(225) NOT NULL,
  `description` text NOT NULL COMMENT 'Popis fora',
  `hidden` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `parent_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `topic_post`
--

CREATE TABLE IF NOT EXISTS `topic_post` (
  `id` smallint(5) unsigned NOT NULL,
  `user_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `topic_id` smallint(5) unsigned NOT NULL,
  `edit_user_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `edit_count` mediumint(8) unsigned NOT NULL,
  `text` mediumtext NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='Prispevok do topiku v databaze';

-- --------------------------------------------------------

--
-- Table structure for table `topic_read`
--

CREATE TABLE IF NOT EXISTS `topic_read` (
  `id` smallint(5) unsigned NOT NULL,
  `topic_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `user_id` smallint(5) unsigned NOT NULL,
  `read` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `read_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Ci si pouzivatel precital topik';

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` smallint(5) unsigned NOT NULL,
  `nick` varchar(32) NOT NULL,
  `group_id` tinyint(3) unsigned NOT NULL,
  `email` varchar(300) CHARACTER SET ascii NOT NULL COMMENT 'Email',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `avatar` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `location` varchar(255) DEFAULT NULL,
  `hide_email` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `ip` int(10) unsigned DEFAULT NULL,
  `activated` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `activation_code` binary(16) NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_flash`
--

CREATE TABLE IF NOT EXISTS `user_flash` (
  `id` mediumint(7) unsigned NOT NULL,
  `user_id` smallint(5) unsigned NOT NULL,
  `message` tinytext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_group`
--

CREATE TABLE IF NOT EXISTS `user_group` (
  `user_id` smallint(5) unsigned NOT NULL,
  `user_groups_id` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_groups`
--

CREATE TABLE IF NOT EXISTS `user_groups` (
  `id` tinyint(3) unsigned NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` tinytext,
  `permissions` tinytext
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_metadata`
--

CREATE TABLE IF NOT EXISTS `user_metadata` (
  `user_id` smallint(5) unsigned NOT NULL,
  `deviantart` varchar(225) NOT NULL,
  `skype` varchar(32) NOT NULL,
  `bio` tinytext,
  `web` varchar(225) DEFAULT NULL,
  `birthday` timestamp NULL DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_passwords`
--

CREATE TABLE IF NOT EXISTS `user_passwords` (
  `user_id` smallint(5) unsigned NOT NULL,
  `password` varchar(150) NOT NULL,
  `old_password` varchar(225) NOT NULL,
  `using_old_password` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `rand` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_permissions`
--

CREATE TABLE IF NOT EXISTS `user_permissions` (
  `id` smallint(5) unsigned NOT NULL,
  `user_id` smallint(5) unsigned NOT NULL,
  `permissions` tinytext
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_ping`
--

CREATE TABLE IF NOT EXISTS `user_ping` (
  `id` int(10) unsigned NOT NULL,
  `to_user_id` smallint(5) unsigned NOT NULL,
  `by_user_id` smallint(5) unsigned NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` smallint(5) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `description_UNIQUE` (`description`), ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indexes for table `article_category`
--
ALTER TABLE `article_category`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `category_id_UNIQUE` (`id`);

--
-- Indexes for table `article_history`
--
ALTER TABLE `article_history`
  ADD PRIMARY KEY (`id`,`article_id`,`user_id`,`article_category_id`), ADD UNIQUE KEY `id_UNIQUE` (`id`), ADD UNIQUE KEY `description_UNIQUE` (`description`), ADD UNIQUE KEY `img_UNIQUE` (`img`);

--
-- Indexes for table `article_metadata`
--
ALTER TABLE `article_metadata`
  ADD PRIMARY KEY (`id`,`article_category_id`,`image_id`,`user_id`,`series_id`,`article_history_id`), ADD UNIQUE KEY `article_id_UNIQUE` (`id`), ADD UNIQUE KEY `article_name_UNIQUE` (`name`), ADD UNIQUE KEY `tag_group_article_id_UNIQUE` (`tag_group_article_id`), ADD KEY `fk_article_metadata_article_category1_idx` (`article_category_id`), ADD KEY `fk_article_metadata_images1_idx` (`image_id`), ADD KEY `fk_article_metadata_series1_idx` (`series_id`), ADD KEY `fk_article_metadata_article_history1_idx` (`article_history_id`), ADD KEY `fk_article_metadata_user1_idx` (`user_id`);

--
-- Indexes for table `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`id`,`user_id`), ADD UNIQUE KEY `ban_id_UNIQUE` (`id`), ADD UNIQUE KEY `user_id_UNIQUE` (`user_id`), ADD KEY `fk_bans_user1_idx` (`user_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`,`user_id`,`comment_history_id`), ADD UNIQUE KEY `comment_id_UNIQUE` (`id`), ADD KEY `fk_comments_user1_idx` (`user_id`), ADD KEY `fk_comments_comment_history1_idx` (`comment_history_id`);

--
-- Indexes for table `comment_history`
--
ALTER TABLE `comment_history`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indexes for table `comment_vote`
--
ALTER TABLE `comment_vote`
  ADD PRIMARY KEY (`id`,`comment_id`), ADD UNIQUE KEY `id_UNIQUE` (`id`), ADD KEY `fk_comments_votes_comments1_idx` (`comment_id`);

--
-- Indexes for table `download`
--
ALTER TABLE `download`
  ADD PRIMARY KEY (`id`,`user_id`,`download_category_id`), ADD UNIQUE KEY `down_id_UNIQUE` (`id`), ADD UNIQUE KEY `download_img_UNIQUE` (`img`), ADD UNIQUE KEY `download_preview_UNIQUE` (`preview`), ADD UNIQUE KEY `download_file_UNIQUE` (`file`), ADD UNIQUE KEY `name_UNIQUE` (`name`), ADD KEY `fk_downloads_download_category1_idx` (`download_category_id`), ADD KEY `fk_downloads_user1_idx` (`user_id`);

--
-- Indexes for table `download_category`
--
ALTER TABLE `download_category`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id_UNIQUE` (`id`), ADD UNIQUE KEY `color_UNIQUE` (`color`);

--
-- Indexes for table `favorite`
--
ALTER TABLE `favorite`
  ADD PRIMARY KEY (`id`,`user_id`), ADD UNIQUE KEY `fav_id_UNIQUE` (`id`), ADD KEY `fk_favorite_user1_idx` (`user_id`);

--
-- Indexes for table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `image_UNIQUE` (`image`), ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indexes for table `ip_log`
--
ALTER TABLE `ip_log`
  ADD PRIMARY KEY (`id`,`item_id`), ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id`,`user_id`,`message_group_id`,`to_user_id`), ADD UNIQUE KEY `message_id_UNIQUE` (`id`), ADD KEY `fk_message_message_group1_idx` (`message_group_id`), ADD KEY `fk_message_user1_idx` (`to_user_id`);

--
-- Indexes for table `message_group`
--
ALTER TABLE `message_group`
  ADD PRIMARY KEY (`id`,`user_id`), ADD UNIQUE KEY `group_id_UNIQUE` (`id`), ADD KEY `fk_message_group_user1_idx` (`user_id`);

--
-- Indexes for table `message_user_group`
--
ALTER TABLE `message_user_group`
  ADD PRIMARY KEY (`message_group_id`,`message_group_user_id`), ADD KEY `fk_message_user_group_message_group1_idx` (`message_group_id`,`message_group_user_id`);

--
-- Indexes for table `micro_comment`
--
ALTER TABLE `micro_comment`
  ADD PRIMARY KEY (`id`,`user_id`,`comment_history_id`), ADD UNIQUE KEY `id_UNIQUE` (`id`), ADD KEY `fk_micro_comments_user1_idx` (`user_id`), ADD KEY `fk_micro_comments_comment_history1_idx` (`comment_history_id`);

--
-- Indexes for table `micro_commnet_vote`
--
ALTER TABLE `micro_commnet_vote`
  ADD PRIMARY KEY (`id`,`micro_comment_id`), ADD UNIQUE KEY `id_UNIQUE` (`id`), ADD KEY `fk_micro_commnet_vote_micro_comment1_idx` (`micro_comment_id`);

--
-- Indexes for table `newsletter`
--
ALTER TABLE `newsletter`
  ADD PRIMARY KEY (`id`,`selection_id`), ADD UNIQUE KEY `id_UNIQUE` (`id`), ADD UNIQUE KEY `email_UNIQUE` (`email`), ADD KEY `fk_newsletter_selection1_idx` (`selection_id`);

--
-- Indexes for table `selection`
--
ALTER TABLE `selection`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indexes for table `series`
--
ALTER TABLE `series`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indexes for table `tag`
--
ALTER TABLE `tag`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id_UNIQUE` (`id`), ADD UNIQUE KEY `tag_UNIQUE` (`tag`);

--
-- Indexes for table `tag_group`
--
ALTER TABLE `tag_group`
  ADD PRIMARY KEY (`id`,`tag_id`,`article_id`), ADD UNIQUE KEY `id_UNIQUE` (`id`), ADD KEY `fk_tag_group_tag1_idx` (`tag_id`), ADD KEY `fk_tag_group_article_metadata1_idx` (`article_id`);

--
-- Indexes for table `topic`
--
ALTER TABLE `topic`
  ADD PRIMARY KEY (`id`,`topic_category_id`,`user_id`), ADD UNIQUE KEY `forumt_id_UNIQUE` (`id`), ADD KEY `fk_topic_topic_category1_idx` (`topic_category_id`), ADD KEY `fk_topic_user1_idx` (`user_id`);

--
-- Indexes for table `topic_category`
--
ALTER TABLE `topic_category`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `forum_id_UNIQUE` (`id`);

--
-- Indexes for table `topic_post`
--
ALTER TABLE `topic_post`
  ADD PRIMARY KEY (`id`,`user_id`,`topic_id`,`edit_user_id`), ADD UNIQUE KEY `id_UNIQUE` (`id`), ADD KEY `fk_topic_post_topic1_idx` (`topic_id`), ADD KEY `fk_topic_post_user1_idx` (`user_id`), ADD KEY `fk_topic_post_user2_idx` (`edit_user_id`);

--
-- Indexes for table `topic_read`
--
ALTER TABLE `topic_read`
  ADD PRIMARY KEY (`id`,`topic_id`,`user_id`), ADD UNIQUE KEY `forumr_id_UNIQUE` (`id`), ADD KEY `fk_topic_read_topic1_idx` (`topic_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`,`nick`,`group_id`,`email`), ADD UNIQUE KEY `user_email_UNIQUE` (`email`), ADD UNIQUE KEY `user_nick_UNIQUE` (`nick`), ADD UNIQUE KEY `user_id_UNIQUE` (`id`), ADD UNIQUE KEY `activation_code_UNIQUE` (`activation_code`);

--
-- Indexes for table `user_flash`
--
ALTER TABLE `user_flash`
  ADD PRIMARY KEY (`id`,`user_id`), ADD UNIQUE KEY `id_UNIQUE` (`id`), ADD UNIQUE KEY `user_id1_UNIQUE` (`user_id`), ADD KEY `fk_user_flash_user1_idx` (`user_id`);

--
-- Indexes for table `user_group`
--
ALTER TABLE `user_group`
  ADD PRIMARY KEY (`user_id`,`user_groups_id`), ADD KEY `fk_user_group_user1_idx` (`user_id`), ADD KEY `fk_user_group_user_groups1_idx` (`user_groups_id`);

--
-- Indexes for table `user_groups`
--
ALTER TABLE `user_groups`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indexes for table `user_metadata`
--
ALTER TABLE `user_metadata`
  ADD PRIMARY KEY (`user_id`), ADD UNIQUE KEY `skype_UNIQUE` (`skype`), ADD UNIQUE KEY `user_id_UNIQUE` (`user_id`), ADD KEY `fk_user_metadata_user1_idx` (`user_id`);

--
-- Indexes for table `user_passwords`
--
ALTER TABLE `user_passwords`
  ADD PRIMARY KEY (`user_id`), ADD UNIQUE KEY `password_UNIQUE` (`password`), ADD UNIQUE KEY `user_id_UNIQUE` (`user_id`), ADD KEY `fk_user_passwords_user1_idx` (`user_id`);

--
-- Indexes for table `user_permissions`
--
ALTER TABLE `user_permissions`
  ADD PRIMARY KEY (`id`,`user_id`), ADD UNIQUE KEY `id_UNIQUE` (`id`), ADD UNIQUE KEY `user_id_UNIQUE` (`user_id`), ADD KEY `fk_user_permissions_user1_idx` (`user_id`);

--
-- Indexes for table `user_ping`
--
ALTER TABLE `user_ping`
  ADD PRIMARY KEY (`id`,`to_user_id`,`by_user_id`,`user_id`), ADD UNIQUE KEY `id_UNIQUE` (`id`), ADD KEY `fk_user_ping_user1_idx` (`to_user_id`), ADD KEY `fk_user_ping_by_user_idx` (`by_user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `article`
--
ALTER TABLE `article`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `article_category`
--
ALTER TABLE `article_category`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `article_history`
--
ALTER TABLE `article_history`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `article_metadata`
--
ALTER TABLE `article_metadata`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `bans`
--
ALTER TABLE `bans`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id banu';
--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `comment_history`
--
ALTER TABLE `comment_history`
  MODIFY `id` mediumint(7) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `comment_vote`
--
ALTER TABLE `comment_vote`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `download`
--
ALTER TABLE `download`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID Stahovaneho suboru';
--
-- AUTO_INCREMENT for table `download_category`
--
ALTER TABLE `download_category`
  MODIFY `id` tinyint(4) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `favorite`
--
ALTER TABLE `favorite`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `image`
--
ALTER TABLE `image`
  MODIFY `id` mediumint(7) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `ip_log`
--
ALTER TABLE `ip_log`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `id` smallint(7) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Cislo spravy';
--
-- AUTO_INCREMENT for table `message_group`
--
ALTER TABLE `message_group`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `micro_comment`
--
ALTER TABLE `micro_comment`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `micro_commnet_vote`
--
ALTER TABLE `micro_commnet_vote`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `newsletter`
--
ALTER TABLE `newsletter`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `selection`
--
ALTER TABLE `selection`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `series`
--
ALTER TABLE `series`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tag`
--
ALTER TABLE `tag`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tag_group`
--
ALTER TABLE `tag_group`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `topic`
--
ALTER TABLE `topic`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `topic_category`
--
ALTER TABLE `topic_category`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `topic_post`
--
ALTER TABLE `topic_post`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `topic_read`
--
ALTER TABLE `topic_read`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_flash`
--
ALTER TABLE `user_flash`
  MODIFY `id` mediumint(7) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_metadata`
--
ALTER TABLE `user_metadata`
  MODIFY `user_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_passwords`
--
ALTER TABLE `user_passwords`
  MODIFY `user_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_permissions`
--
ALTER TABLE `user_permissions`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_ping`
--
ALTER TABLE `user_ping`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `bans`
--
ALTER TABLE `bans`
ADD CONSTRAINT `fk_bans_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `comment_vote`
--
ALTER TABLE `comment_vote`
ADD CONSTRAINT `fk_comments_votes_comments1` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `download`
--
ALTER TABLE `download`
ADD CONSTRAINT `fk_downloads_download_category1` FOREIGN KEY (`download_category_id`) REFERENCES `download_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_downloads_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `favorite`
--
ALTER TABLE `favorite`
ADD CONSTRAINT `fk_favorite_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `message_group`
--
ALTER TABLE `message_group`
ADD CONSTRAINT `fk_message_group_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `message_user_group`
--
ALTER TABLE `message_user_group`
ADD CONSTRAINT `fk_message_user_group_message_group1` FOREIGN KEY (`message_group_id`, `message_group_user_id`) REFERENCES `message_group` (`id`, `user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `micro_comment`
--
ALTER TABLE `micro_comment`
ADD CONSTRAINT `fk_micro_comments_comment_history1` FOREIGN KEY (`comment_history_id`) REFERENCES `comment_history` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_micro_comments_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `micro_commnet_vote`
--
ALTER TABLE `micro_commnet_vote`
ADD CONSTRAINT `fk_micro_commnet_vote_micro_comment1` FOREIGN KEY (`micro_comment_id`) REFERENCES `micro_comment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `newsletter`
--
ALTER TABLE `newsletter`
ADD CONSTRAINT `fk_newsletter_selection1` FOREIGN KEY (`selection_id`) REFERENCES `selection` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tag_group`
--
ALTER TABLE `tag_group`
ADD CONSTRAINT `fk_tag_group_article_metadata1` FOREIGN KEY (`article_id`) REFERENCES `article_metadata` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_tag_group_tag1` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `topic_read`
--
ALTER TABLE `topic_read`
ADD CONSTRAINT `fk_topic_read_topic1` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `user_flash`
--
ALTER TABLE `user_flash`
ADD CONSTRAINT `fk_user_flash_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_group`
--
ALTER TABLE `user_group`
ADD CONSTRAINT `fk_user_group_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_user_group_user_groups1` FOREIGN KEY (`user_groups_id`) REFERENCES `user_groups` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user_metadata`
--
ALTER TABLE `user_metadata`
ADD CONSTRAINT `fk_user_metadata_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_passwords`
--
ALTER TABLE `user_passwords`
ADD CONSTRAINT `fk_user_passwords_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_permissions`
--
ALTER TABLE `user_permissions`
ADD CONSTRAINT `fk_user_permissions_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_ping`
--
ALTER TABLE `user_ping`
ADD CONSTRAINT `fk_user_ping_by_user` FOREIGN KEY (`by_user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_user_ping_to_user` FOREIGN KEY (`to_user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
