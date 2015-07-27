-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Hostiteľ: 127.0.0.1
-- Čas generovania: Po 27.Júl 2015, 16:58
-- Verzia serveru: 5.6.24
-- Verzia PHP: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Databáza: `desart`
--

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `article`
--

CREATE TABLE IF NOT EXISTS `article` (
  `id` smallint(5) unsigned NOT NULL,
  `article_category_id` smallint(5) unsigned DEFAULT NULL,
  `tag_group_id` smallint(5) unsigned DEFAULT NULL,
  `image_id` mediumint(7) DEFAULT NULL COMMENT 'Default image na article',
  `user_id` smallint(5) unsigned NOT NULL,
  `series_id` smallint(5) unsigned DEFAULT NULL COMMENT '0 - Hlavna kategoria, tykajuca sa webu',
  `article_history_id` smallint(5) unsigned DEFAULT NULL,
  `slug` varchar(225) CHARACTER SET ascii NOT NULL,
  `name` varchar(200) NOT NULL,
  `content` mediumtext NOT NULL,
  `reads` smallint(5) unsigned NOT NULL DEFAULT '0',
  `custom_tags` varchar(250) CHARACTER SET ascii DEFAULT NULL COMMENT 'Custom tagy v serializovanom',
  `status` enum('published','draft','private') NOT NULL DEFAULT 'published',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Typ:\n0 - Clanok\n1 - Rychla novinka',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `published_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `attachments` tinytext COMMENT 'Pridavne subory a obrazky'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `article`
--

INSERT INTO `article` (`id`, `article_category_id`, `tag_group_id`, `image_id`, `user_id`, `series_id`, `article_history_id`, `slug`, `name`, `content`, `reads`, `custom_tags`, `status`, `type`, `created_at`, `updated_at`, `published_at`, `attachments`) VALUES
(1, NULL, NULL, NULL, 1, NULL, NULL, 'banan', 'Banan', 'test članku z db <b>tučné ako prasa</b>', 0, NULL, 'published', 0, '2015-07-27 13:54:05', '2015-07-27 14:07:23', '2015-07-27 13:54:05', NULL);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `article_category`
--

CREATE TABLE IF NOT EXISTS `article_category` (
  `id` smallint(5) unsigned NOT NULL,
  `color` varchar(45) NOT NULL,
  `slug` varchar(225) CHARACTER SET ascii NOT NULL,
  `description` tinytext,
  `parrent_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `hidden` tinyint(1) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `article_history`
--

CREATE TABLE IF NOT EXISTS `article_history` (
  `id` smallint(5) unsigned NOT NULL,
  `article_id` smallint(5) unsigned NOT NULL,
  `tag_group_article_id` smallint(5) unsigned DEFAULT NULL,
  `article_category_id` smallint(5) unsigned DEFAULT NULL,
  `image_id` mediumint(7) DEFAULT NULL,
  `user_id` smallint(5) unsigned DEFAULT NULL,
  `series_id` smallint(5) unsigned DEFAULT NULL,
  `article_history_id` int(10) unsigned NOT NULL,
  `slug` varchar(225) NOT NULL,
  `name` varchar(200) NOT NULL,
  `reads` smallint(5) unsigned NOT NULL DEFAULT '0',
  `custom_tags` varchar(250) DEFAULT NULL COMMENT 'Custom tagy v serializovanom',
  `status` enum('published','draft','private') NOT NULL DEFAULT 'published',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Typ:\n0 - Clanok\n1 - Rychla novinka',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `published_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `ban`
--

CREATE TABLE IF NOT EXISTS `ban` (
  `id` int(11) unsigned NOT NULL COMMENT 'Id banu',
  `user_id` smallint(5) unsigned NOT NULL,
  `reason` tinytext NOT NULL COMMENT 'Dovod banu',
  `duration_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `comments`
--

CREATE TABLE IF NOT EXISTS `comments` (
  `id` smallint(5) unsigned NOT NULL,
  `article_id` smallint(5) unsigned NOT NULL,
  `user_id` smallint(5) unsigned NOT NULL,
  `reply_comment_id` smallint(5) unsigned DEFAULT NULL,
  `comment_history_id` mediumint(7) unsigned NOT NULL,
  `comment_type` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `text` tinytext NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `comment_history`
--

CREATE TABLE IF NOT EXISTS `comment_history` (
  `id` mediumint(7) unsigned NOT NULL,
  `change` tinytext NOT NULL,
  `change_type` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `comment_vote`
--

CREATE TABLE IF NOT EXISTS `comment_vote` (
  `id` int(10) unsigned NOT NULL,
  `comment_id` smallint(5) unsigned NOT NULL,
  `down_vote` tinyint(1) unsigned DEFAULT NULL,
  `up_vote` tinyint(1) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `favorite`
--

CREATE TABLE IF NOT EXISTS `favorite` (
  `id` smallint(5) unsigned NOT NULL,
  `user_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `item_id` int(11) unsigned NOT NULL,
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `files`
--

CREATE TABLE IF NOT EXISTS `files` (
  `id` mediumint(7) unsigned NOT NULL,
  `name` binary(20) NOT NULL COMMENT 'Nazov v sha1',
  `extension` varchar(3) NOT NULL DEFAULT 'png',
  `type` enum('image') DEFAULT 'image'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `group`
--

CREATE TABLE IF NOT EXISTS `group` (
  `id` tinyint(3) unsigned NOT NULL,
  `name` varchar(200) NOT NULL,
  `color` varchar(45) DEFAULT NULL,
  `description` tinytext,
  `permissions` tinytext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `ip_log`
--

CREATE TABLE IF NOT EXISTS `ip_log` (
  `id` int(10) unsigned NOT NULL,
  `item_id` int(9) unsigned NOT NULL,
  `ip` int(10) unsigned NOT NULL,
  `item_type` mediumint(8) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `message`
--

CREATE TABLE IF NOT EXISTS `message` (
  `id` smallint(7) unsigned NOT NULL COMMENT 'Cislo spravy',
  `user_id` smallint(5) unsigned NOT NULL COMMENT 'Id pouzivatela// sender',
  `message_group_id` smallint(5) unsigned NOT NULL,
  `to_subject_id` smallint(5) unsigned NOT NULL COMMENT 'Skupina alebo User',
  `subject_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1 - User\n0 - Group',
  `is_read` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `text` mediumtext NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `read_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `message_group`
--

CREATE TABLE IF NOT EXISTS `message_group` (
  `id` smallint(5) unsigned NOT NULL,
  `user_id` smallint(5) unsigned NOT NULL,
  `group_name` varchar(200) NOT NULL COMMENT 'Meno skupiny pouzivatel si moze vytvorit vlastnu skupinu mena mozu byt rovnake',
  `group_description` tinytext,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `message_user_group`
--

CREATE TABLE IF NOT EXISTS `message_user_group` (
  `message_group_id` smallint(5) unsigned NOT NULL,
  `message_group_user_id` smallint(5) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `micro_comment`
--

CREATE TABLE IF NOT EXISTS `micro_comment` (
  `id` smallint(5) unsigned NOT NULL,
  `user_id` smallint(5) unsigned NOT NULL,
  `question_id` smallint(5) unsigned NOT NULL,
  `comment_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT 'Typ komentara, clanook, stranka',
  `reply_comment_id` smallint(5) unsigned DEFAULT NULL,
  `comment_history_id` mediumint(7) unsigned NOT NULL,
  `text` varchar(250) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `micro_commnet_vote`
--

CREATE TABLE IF NOT EXISTS `micro_commnet_vote` (
  `id` int(10) unsigned NOT NULL,
  `micro_comment_id` smallint(5) unsigned NOT NULL,
  `down_vote` tinyint(1) unsigned NOT NULL,
  `up_vote` tinyint(1) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `newsletter`
--

CREATE TABLE IF NOT EXISTS `newsletter` (
  `id` smallint(5) unsigned NOT NULL,
  `email` varchar(300) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `selection_id` smallint(5) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `notification`
--

CREATE TABLE IF NOT EXISTS `notification` (
  `id` bigint(20) unsigned NOT NULL,
  `type` tinyint(1) unsigned NOT NULL DEFAULT '4' COMMENT '1 - custom\n2 - ping\n3 - ad\n4 - new',
  `subject` smallint(5) unsigned NOT NULL,
  `subject_type` tinyint(1) unsigned NOT NULL COMMENT '1 - User\n2 - Group',
  `message` mediumtext,
  `by_subject` varchar(32) NOT NULL,
  `by_type` tinyint(1) unsigned NOT NULL COMMENT '1 - User_id\n2 - Vlastne meno',
  `seen` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `seen_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `notification`
--

INSERT INTO `notification` (`id`, `type`, `subject`, `subject_type`, `message`, `by_subject`, `by_type`, `seen`, `created_at`, `seen_at`) VALUES
(1, 1, 1, 1, '100 tabletov týždnne za <a>Awé cezar</a> napisaný článok!', 'Admin', 2, 0, '2015-07-27 14:43:08', NULL);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `selection`
--

CREATE TABLE IF NOT EXISTS `selection` (
  `id` smallint(5) unsigned NOT NULL,
  `selection` tinytext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `series`
--

CREATE TABLE IF NOT EXISTS `series` (
  `id` smallint(5) unsigned NOT NULL,
  `image_id` mediumint(7) unsigned NOT NULL,
  `type` enum('ordered','unordered') NOT NULL DEFAULT 'unordered',
  `name` varchar(200) NOT NULL,
  `slug` varchar(225) CHARACTER SET ascii NOT NULL,
  `description` tinytext NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `color` varchar(45) NOT NULL DEFAULT '#444'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `tag`
--

CREATE TABLE IF NOT EXISTS `tag` (
  `id` smallint(5) unsigned NOT NULL,
  `tag` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `tag_group`
--

CREATE TABLE IF NOT EXISTS `tag_group` (
  `id` smallint(5) unsigned NOT NULL,
  `tag_id` smallint(5) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Skupina tagov pre nejaky Mega tag';

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `topic`
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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='Databaza prispevku na fore';

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `topic_category`
--

CREATE TABLE IF NOT EXISTS `topic_category` (
  `id` tinyint(3) unsigned NOT NULL,
  `name` varchar(200) NOT NULL COMMENT 'Nazov fora',
  `slug` varchar(225) NOT NULL,
  `description` text NOT NULL COMMENT 'Popis fora',
  `hidden` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `parent_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `topic_post`
--

CREATE TABLE IF NOT EXISTS `topic_post` (
  `id` smallint(5) unsigned NOT NULL,
  `user_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `topic_id` smallint(5) unsigned NOT NULL,
  `edit_user_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `edit_count` mediumint(8) unsigned NOT NULL,
  `text` mediumtext NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='Prispevok do topiku v databaze';

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `topic_read`
--

CREATE TABLE IF NOT EXISTS `topic_read` (
  `id` smallint(5) unsigned NOT NULL,
  `topic_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `user_id` smallint(5) unsigned NOT NULL,
  `read` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `read_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Ci si pouzivatel precital topik';

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` smallint(5) unsigned NOT NULL,
  `username` varchar(32) NOT NULL,
  `email` varchar(300) CHARACTER SET ascii NOT NULL COMMENT 'Email',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `avatar` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `location` varchar(255) DEFAULT NULL,
  `hide_email` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `banned` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ip` int(10) unsigned DEFAULT NULL,
  `activated` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `activation_code` binary(16) NOT NULL,
  `permissions` tinytext,
  `password` varchar(150) NOT NULL,
  `rand` tinyint(3) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `locked_until` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `active`, `avatar`, `location`, `hide_email`, `banned`, `ip`, `activated`, `activation_code`, `permissions`, `password`, `rand`, `created_at`, `updated_at`, `locked_until`) VALUES
(1, 'Samuell', 'samuell@gmmail.com', 1, 1, NULL, 1, 0, NULL, 1, 0x00000000000000000000000000000000, '1', 'uhorka', 69, '2015-07-27 14:09:04', NULL, NULL);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `user_group`
--

CREATE TABLE IF NOT EXISTS `user_group` (
  `user_id` smallint(5) unsigned NOT NULL,
  `group_id` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `user_metadata`
--

CREATE TABLE IF NOT EXISTS `user_metadata` (
  `user_id` smallint(5) unsigned NOT NULL,
  `deviantart` varchar(225) NOT NULL,
  `skype` varchar(32) NOT NULL,
  `bio` tinytext,
  `web` varchar(225) DEFAULT NULL,
  `birthday` timestamp NULL DEFAULT NULL,
  `update_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- Sťahujem dáta pre tabuľku `user_metadata`
--

INSERT INTO `user_metadata` (`user_id`, `deviantart`, `skype`, `bio`, `web`, `birthday`, `update_at`) VALUES
(1, 'sdfsd', 'fdsfsd', 'som ufon', 'ufoni.sk', '0000-00-00 00:00:00', NULL);

--
-- Kľúče pre exportované tabuľky
--

--
-- Indexy pre tabuľku `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`id`,`user_id`), ADD UNIQUE KEY `article_id_UNIQUE` (`id`), ADD KEY `fk_article_article_category1_idx` (`article_category_id`);

--
-- Indexy pre tabuľku `article_category`
--
ALTER TABLE `article_category`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `category_id_UNIQUE` (`id`), ADD UNIQUE KEY `slug_UNIQUE` (`slug`);

--
-- Indexy pre tabuľku `article_history`
--
ALTER TABLE `article_history`
  ADD PRIMARY KEY (`id`), ADD KEY `fk_article_history_article1_idx` (`article_id`);

--
-- Indexy pre tabuľku `ban`
--
ALTER TABLE `ban`
  ADD PRIMARY KEY (`id`,`user_id`), ADD UNIQUE KEY `ban_id_UNIQUE` (`id`), ADD UNIQUE KEY `user_id_UNIQUE` (`user_id`), ADD KEY `fk_bans_user1_idx` (`user_id`);

--
-- Indexy pre tabuľku `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`,`user_id`,`comment_history_id`), ADD UNIQUE KEY `comment_id_UNIQUE` (`id`), ADD KEY `fk_comments_user1_idx` (`user_id`), ADD KEY `fk_comments_comment_history1_idx` (`comment_history_id`);

--
-- Indexy pre tabuľku `comment_history`
--
ALTER TABLE `comment_history`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indexy pre tabuľku `comment_vote`
--
ALTER TABLE `comment_vote`
  ADD PRIMARY KEY (`id`,`comment_id`), ADD UNIQUE KEY `id_UNIQUE` (`id`), ADD KEY `fk_comments_votes_comments1_idx` (`comment_id`);

--
-- Indexy pre tabuľku `favorite`
--
ALTER TABLE `favorite`
  ADD PRIMARY KEY (`id`,`user_id`), ADD UNIQUE KEY `fav_id_UNIQUE` (`id`), ADD KEY `fk_favorite_user1_idx` (`user_id`);

--
-- Indexy pre tabuľku `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `image_UNIQUE` (`name`), ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indexy pre tabuľku `group`
--
ALTER TABLE `group`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indexy pre tabuľku `ip_log`
--
ALTER TABLE `ip_log`
  ADD PRIMARY KEY (`id`,`item_id`), ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indexy pre tabuľku `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id`,`user_id`,`message_group_id`,`to_subject_id`), ADD UNIQUE KEY `message_id_UNIQUE` (`id`), ADD KEY `fk_message_message_group1_idx` (`message_group_id`), ADD KEY `fk_message_user1_idx` (`to_subject_id`);

--
-- Indexy pre tabuľku `message_group`
--
ALTER TABLE `message_group`
  ADD PRIMARY KEY (`id`,`user_id`), ADD UNIQUE KEY `group_id_UNIQUE` (`id`), ADD KEY `fk_message_group_user1_idx` (`user_id`);

--
-- Indexy pre tabuľku `message_user_group`
--
ALTER TABLE `message_user_group`
  ADD PRIMARY KEY (`message_group_id`,`message_group_user_id`), ADD KEY `fk_message_user_group_message_group1_idx` (`message_group_id`,`message_group_user_id`);

--
-- Indexy pre tabuľku `micro_comment`
--
ALTER TABLE `micro_comment`
  ADD PRIMARY KEY (`id`,`user_id`,`comment_history_id`), ADD UNIQUE KEY `id_UNIQUE` (`id`), ADD KEY `fk_micro_comments_user1_idx` (`user_id`), ADD KEY `fk_micro_comments_comment_history1_idx` (`comment_history_id`);

--
-- Indexy pre tabuľku `micro_commnet_vote`
--
ALTER TABLE `micro_commnet_vote`
  ADD PRIMARY KEY (`id`,`micro_comment_id`), ADD UNIQUE KEY `id_UNIQUE` (`id`), ADD KEY `fk_micro_commnet_vote_micro_comment1_idx` (`micro_comment_id`);

--
-- Indexy pre tabuľku `newsletter`
--
ALTER TABLE `newsletter`
  ADD PRIMARY KEY (`id`,`selection_id`), ADD UNIQUE KEY `id_UNIQUE` (`id`), ADD UNIQUE KEY `email_UNIQUE` (`email`), ADD KEY `fk_newsletter_selection1_idx` (`selection_id`);

--
-- Indexy pre tabuľku `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `subject_type_UNIQUE` (`subject_type`);

--
-- Indexy pre tabuľku `selection`
--
ALTER TABLE `selection`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indexy pre tabuľku `series`
--
ALTER TABLE `series`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id_UNIQUE` (`id`), ADD UNIQUE KEY `slug_UNIQUE` (`slug`), ADD UNIQUE KEY `color_UNIQUE` (`color`), ADD KEY `fk_series_image1_idx` (`image_id`);

--
-- Indexy pre tabuľku `tag`
--
ALTER TABLE `tag`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id_UNIQUE` (`id`), ADD UNIQUE KEY `tag_UNIQUE` (`tag`);

--
-- Indexy pre tabuľku `tag_group`
--
ALTER TABLE `tag_group`
  ADD PRIMARY KEY (`id`,`tag_id`), ADD UNIQUE KEY `id_UNIQUE` (`id`), ADD KEY `fk_tag_group_tag1_idx` (`tag_id`);

--
-- Indexy pre tabuľku `topic`
--
ALTER TABLE `topic`
  ADD PRIMARY KEY (`id`,`topic_category_id`,`user_id`), ADD UNIQUE KEY `forumt_id_UNIQUE` (`id`), ADD KEY `fk_topic_topic_category1_idx` (`topic_category_id`), ADD KEY `fk_topic_user1_idx` (`user_id`);

--
-- Indexy pre tabuľku `topic_category`
--
ALTER TABLE `topic_category`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `forum_id_UNIQUE` (`id`);

--
-- Indexy pre tabuľku `topic_post`
--
ALTER TABLE `topic_post`
  ADD PRIMARY KEY (`id`,`user_id`,`topic_id`,`edit_user_id`), ADD UNIQUE KEY `id_UNIQUE` (`id`), ADD KEY `fk_topic_post_topic1_idx` (`topic_id`), ADD KEY `fk_topic_post_user1_idx` (`user_id`), ADD KEY `fk_topic_post_user2_idx` (`edit_user_id`);

--
-- Indexy pre tabuľku `topic_read`
--
ALTER TABLE `topic_read`
  ADD PRIMARY KEY (`id`,`topic_id`,`user_id`), ADD UNIQUE KEY `forumr_id_UNIQUE` (`id`), ADD KEY `fk_topic_read_topic1_idx` (`topic_id`);

--
-- Indexy pre tabuľku `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`,`username`,`email`), ADD UNIQUE KEY `user_email_UNIQUE` (`email`), ADD UNIQUE KEY `user_nick_UNIQUE` (`username`), ADD UNIQUE KEY `user_id_UNIQUE` (`id`), ADD UNIQUE KEY `activation_code_UNIQUE` (`activation_code`);

--
-- Indexy pre tabuľku `user_group`
--
ALTER TABLE `user_group`
  ADD PRIMARY KEY (`user_id`,`group_id`), ADD KEY `fk_user_group_user1_idx` (`user_id`), ADD KEY `fk_user_group_user_groups1_idx` (`group_id`);

--
-- Indexy pre tabuľku `user_metadata`
--
ALTER TABLE `user_metadata`
  ADD PRIMARY KEY (`user_id`), ADD UNIQUE KEY `skype_UNIQUE` (`skype`), ADD UNIQUE KEY `user_id_UNIQUE` (`user_id`), ADD KEY `fk_user_metadata_user1_idx` (`user_id`);

--
-- AUTO_INCREMENT pre exportované tabuľky
--

--
-- AUTO_INCREMENT pre tabuľku `article`
--
ALTER TABLE `article`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pre tabuľku `article_category`
--
ALTER TABLE `article_category`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pre tabuľku `article_history`
--
ALTER TABLE `article_history`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pre tabuľku `ban`
--
ALTER TABLE `ban`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id banu';
--
-- AUTO_INCREMENT pre tabuľku `comments`
--
ALTER TABLE `comments`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pre tabuľku `comment_history`
--
ALTER TABLE `comment_history`
  MODIFY `id` mediumint(7) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pre tabuľku `comment_vote`
--
ALTER TABLE `comment_vote`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pre tabuľku `favorite`
--
ALTER TABLE `favorite`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pre tabuľku `files`
--
ALTER TABLE `files`
  MODIFY `id` mediumint(7) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pre tabuľku `group`
--
ALTER TABLE `group`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pre tabuľku `ip_log`
--
ALTER TABLE `ip_log`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pre tabuľku `message`
--
ALTER TABLE `message`
  MODIFY `id` smallint(7) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Cislo spravy';
--
-- AUTO_INCREMENT pre tabuľku `message_group`
--
ALTER TABLE `message_group`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pre tabuľku `micro_comment`
--
ALTER TABLE `micro_comment`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pre tabuľku `micro_commnet_vote`
--
ALTER TABLE `micro_commnet_vote`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pre tabuľku `newsletter`
--
ALTER TABLE `newsletter`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pre tabuľku `notification`
--
ALTER TABLE `notification`
  MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pre tabuľku `selection`
--
ALTER TABLE `selection`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pre tabuľku `series`
--
ALTER TABLE `series`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pre tabuľku `tag`
--
ALTER TABLE `tag`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pre tabuľku `tag_group`
--
ALTER TABLE `tag_group`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pre tabuľku `topic`
--
ALTER TABLE `topic`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pre tabuľku `topic_category`
--
ALTER TABLE `topic_category`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pre tabuľku `topic_post`
--
ALTER TABLE `topic_post`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pre tabuľku `topic_read`
--
ALTER TABLE `topic_read`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pre tabuľku `user`
--
ALTER TABLE `user`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pre tabuľku `user_metadata`
--
ALTER TABLE `user_metadata`
  MODIFY `user_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- Obmedzenie pre exportované tabuľky
--

--
-- Obmedzenie pre tabuľku `article`
--
ALTER TABLE `article`
ADD CONSTRAINT `fk_article_article_category` FOREIGN KEY (`article_category_id`) REFERENCES `article_category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
