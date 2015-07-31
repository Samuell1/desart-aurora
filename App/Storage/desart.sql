-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Desart
-- -----------------------------------------------------
-- Databaza Desartu
DROP SCHEMA IF EXISTS `Desart` ;

-- -----------------------------------------------------
-- Schema Desart
--
-- Databaza Desartu
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Desart` DEFAULT CHARACTER SET utf8mb4 ;
USE `Desart` ;

-- -----------------------------------------------------
-- Table `Desart`.`da_article_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_article_category` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_article_category` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `color` VARCHAR(45) NOT NULL COMMENT '',
  `slug` VARCHAR(225) CHARACTER SET 'ascii' COLLATE 'ascii_general_ci' NOT NULL COMMENT '',
  `description` TINYTEXT NULL DEFAULT NULL COMMENT '',
  `parrent_id` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `hidden` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  UNIQUE INDEX `category_id_UNIQUE` (`id` ASC)  COMMENT '',
  UNIQUE INDEX `slug_UNIQUE` (`slug` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`da_article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_article` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_article` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `article_category_id` SMALLINT(5) UNSIGNED NULL DEFAULT NULL COMMENT '',
  `tag_group_id` SMALLINT(5) UNSIGNED NULL DEFAULT NULL COMMENT '',
  `image_id` MEDIUMINT(7) NULL DEFAULT NULL COMMENT 'Default image na article',
  `author` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  `series_id` SMALLINT(5) UNSIGNED NULL DEFAULT NULL COMMENT '0 - Hlavna kategoria, tykajuca sa webu',
  `article_history_id` SMALLINT(5) UNSIGNED NULL DEFAULT NULL COMMENT '',
  `slug` VARCHAR(225) CHARACTER SET 'ascii' COLLATE 'ascii_general_ci' NOT NULL COMMENT '',
  `name` VARCHAR(200) NOT NULL COMMENT '',
  `content` MEDIUMTEXT NOT NULL COMMENT '',
  `reads` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `custom_tags` VARCHAR(250) CHARACTER SET 'ascii' COLLATE 'ascii_general_ci' NULL COMMENT 'Custom tagy v serializovanom',
  `status` ENUM('published','draft','private') NOT NULL DEFAULT 'published' COMMENT '',
  `type` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Typ:\n0 - Clanok\n1 - Rychla novinka',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  `published_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `attachments` TINYTEXT NULL COMMENT 'Pridavne subory a obrazky',
  PRIMARY KEY (`id`, `author`)  COMMENT '',
  UNIQUE INDEX `article_id_UNIQUE` (`id` ASC)  COMMENT '',
  INDEX `fk_article_article_category1_idx` (`article_category_id` ASC)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 0;


-- -----------------------------------------------------
-- Table `Desart`.`da_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_user` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_user` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `username` VARCHAR(32) CHARACTER SET 'ascii' COLLATE 'ascii_general_ci' NOT NULL COMMENT '',
  `email` VARCHAR(300) CHARACTER SET 'ascii' COLLATE 'ascii_general_ci' NOT NULL COMMENT 'Email',
  `active` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `avatar` TINYINT(1) UNSIGNED NOT NULL DEFAULT 2 COMMENT 'Id v files',
  `hide_email` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '',
  `banned` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `ip` INT UNSIGNED NULL DEFAULT NULL COMMENT '',
  `account_activated` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `activation_code` BINARY(20) NOT NULL COMMENT 'Aktivacny kod v sha1',
  `permissions` TINYTEXT CHARACTER SET 'ascii' COLLATE 'ascii_general_ci' NULL COMMENT '',
  `hash` VARCHAR(200) CHARACTER SET 'ascii' COLLATE 'ascii_general_ci' NOT NULL COMMENT '',
  `rand` TINYINT(3) UNSIGNED NOT NULL COMMENT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  `locked_until` DATETIME NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`id`, `username`, `email`)  COMMENT '',
  UNIQUE INDEX `user_email_UNIQUE` (`email` ASC)  COMMENT '',
  UNIQUE INDEX `user_nick_UNIQUE` (`username` ASC)  COMMENT '',
  UNIQUE INDEX `user_id_UNIQUE` (`id` ASC)  COMMENT '',
  UNIQUE INDEX `activation_code_UNIQUE` (`activation_code` ASC)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 0;


-- -----------------------------------------------------
-- Table `Desart`.`da_comment_history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_comment_history` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_comment_history` (
  `id` MEDIUMINT(7) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `change` TINYTEXT NOT NULL COMMENT '',
  `change_type` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`da_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_comment` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_comment` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `article_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  `user_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  `reply_comment_id` SMALLINT(5) UNSIGNED NULL DEFAULT NULL COMMENT '',
  `comment_history_id` MEDIUMINT(7) UNSIGNED NOT NULL COMMENT '',
  `comment_type` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '',
  `text` TINYTEXT NOT NULL COMMENT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`, `user_id`, `comment_history_id`)  COMMENT '',
  UNIQUE INDEX `comment_id_UNIQUE` (`id` ASC)  COMMENT '',
  INDEX `fk_comments_user1_idx` (`user_id` ASC)  COMMENT '',
  INDEX `fk_comments_comment_history1_idx` (`comment_history_id` ASC)  COMMENT '')
ENGINE = MyISAM
AUTO_INCREMENT = 0;


-- -----------------------------------------------------
-- Table `Desart`.`da_favorite`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_favorite` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_favorite` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `user_id` SMALLINT(5) UNSIGNED NULL COMMENT '',
  `item_id` INT(11) UNSIGNED NOT NULL COMMENT '',
  `type` TINYINT(2) UNSIGNED NOT NULL DEFAULT 1 COMMENT '',
  PRIMARY KEY (`id`, `user_id`)  COMMENT '',
  UNIQUE INDEX `fav_id_UNIQUE` (`id` ASC)  COMMENT '',
  INDEX `fk_favorite_user1_idx` (`user_id` ASC)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 0;


-- -----------------------------------------------------
-- Table `Desart`.`da_topic_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_topic_category` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_topic_category` (
  `id` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `name` VARCHAR(200) NOT NULL COMMENT 'Nazov fora',
  `slug` VARCHAR(225) NOT NULL COMMENT '',
  `description` TEXT(300) NOT NULL COMMENT 'Popis fora',
  `hidden` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `parent_id` TINYINT(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  UNIQUE INDEX `forum_id_UNIQUE` (`id` ASC)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 0;


-- -----------------------------------------------------
-- Table `Desart`.`da_topic`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_topic` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_topic` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `locked_user_id` SMALLINT(5) UNSIGNED NULL DEFAULT NULL COMMENT '',
  `topic_category_id` TINYINT(3) UNSIGNED NULL COMMENT '',
  `user_id` SMALLINT(5) UNSIGNED NULL COMMENT '',
  `slug` VARCHAR(225) NOT NULL COMMENT '',
  `name` VARCHAR(200) NOT NULL COMMENT '',
  `edit_count` MEDIUMINT UNSIGNED NOT NULL COMMENT '',
  `reads` MEDIUMINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `text` MEDIUMTEXT NOT NULL COMMENT '',
  `locked` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`, `topic_category_id`, `user_id`)  COMMENT '',
  UNIQUE INDEX `forumt_id_UNIQUE` (`id` ASC)  COMMENT '',
  INDEX `fk_topic_topic_category1_idx` (`topic_category_id` ASC)  COMMENT '',
  INDEX `fk_topic_user1_idx` (`user_id` ASC)  COMMENT '')
ENGINE = MyISAM
AUTO_INCREMENT = 0
COMMENT = 'Databaza prispevku na fore';


-- -----------------------------------------------------
-- Table `Desart`.`da_topic_post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_topic_post` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_topic_post` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `user_id` SMALLINT(5) UNSIGNED NULL COMMENT '',
  `topic_id` SMALLINT UNSIGNED NOT NULL COMMENT '',
  `edit_user_id` SMALLINT(5) UNSIGNED NULL COMMENT '',
  `edit_count` MEDIUMINT UNSIGNED NOT NULL COMMENT '',
  `text` MEDIUMTEXT NOT NULL COMMENT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`, `user_id`, `topic_id`, `edit_user_id`)  COMMENT '',
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)  COMMENT '',
  INDEX `fk_topic_post_topic1_idx` (`topic_id` ASC)  COMMENT '',
  INDEX `fk_topic_post_user1_idx` (`user_id` ASC)  COMMENT '',
  INDEX `fk_topic_post_user2_idx` (`edit_user_id` ASC)  COMMENT '')
ENGINE = MyISAM
AUTO_INCREMENT = 0
COMMENT = 'Prispevok do topiku v databaze';


-- -----------------------------------------------------
-- Table `Desart`.`da_topic_read`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_topic_read` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_topic_read` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `topic_id` SMALLINT UNSIGNED NULL COMMENT '',
  `user_id` SMALLINT UNSIGNED NOT NULL COMMENT '',
  `read` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `read_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`, `topic_id`, `user_id`)  COMMENT '',
  UNIQUE INDEX `forumr_id_UNIQUE` (`id` ASC)  COMMENT '',
  INDEX `fk_topic_read_topic1_idx` (`topic_id` ASC)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 0
COMMENT = 'Ci si pouzivatel precital topik';


-- -----------------------------------------------------
-- Table `Desart`.`da_message_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_message_group` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_message_group` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `user_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  `group_name` VARCHAR(200) NOT NULL COMMENT 'Meno skupiny pouzivatel si moze vytvorit vlastnu skupinu mena mozu byt rovnake',
  `group_description` TINYTEXT NULL COMMENT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`, `user_id`)  COMMENT '',
  UNIQUE INDEX `group_id_UNIQUE` (`id` ASC)  COMMENT '',
  INDEX `fk_message_group_user1_idx` (`user_id` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`da_message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_message` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_message` (
  `id` SMALLINT(7) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Cislo spravy',
  `user_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT 'Id pouzivatela// sender',
  `message_group_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  `to_subject_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT 'Skupina alebo User',
  `subject_type` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '1 - User\n0 - Group',
  `is_read` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `text` MEDIUMTEXT NOT NULL COMMENT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `read_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`, `user_id`, `message_group_id`, `to_subject_id`)  COMMENT '',
  UNIQUE INDEX `message_id_UNIQUE` (`id` ASC)  COMMENT '',
  INDEX `fk_message_message_group1_idx` (`message_group_id` ASC)  COMMENT '',
  INDEX `fk_message_user1_idx` (`to_subject_id` ASC)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 0;


-- -----------------------------------------------------
-- Table `Desart`.`da_ban`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_ban` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_ban` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id banu',
  `user_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  `reason` TINYTEXT CHARACTER SET 'utf8mb4' NOT NULL COMMENT 'Dovod banu',
  `duration_at` TIMESTAMP NULL COMMENT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`, `user_id`)  COMMENT '',
  UNIQUE INDEX `ban_id_UNIQUE` (`id` ASC)  COMMENT '',
  INDEX `fk_bans_user1_idx` (`user_id` ASC)  COMMENT '',
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 0;


-- -----------------------------------------------------
-- Table `Desart`.`da_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_group` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_group` (
  `id` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `name` VARCHAR(200) NOT NULL COMMENT '',
  `color` VARCHAR(45) NULL COMMENT '',
  `description` TINYTEXT NULL COMMENT '',
  `permissions` TINYTEXT NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`da_user_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_user_group` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_user_group` (
  `user_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  `group_id` TINYINT(3) UNSIGNED NOT NULL COMMENT '',
  PRIMARY KEY (`user_id`, `group_id`)  COMMENT '',
  INDEX `fk_user_group_user1_idx` (`user_id` ASC)  COMMENT '',
  INDEX `fk_user_group_user_groups1_idx` (`group_id` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`da_user_metadata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_user_metadata` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_user_metadata` (
  `user_id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `firstname` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '',
  `lastname` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '',
  `deviantart` VARCHAR(225) NOT NULL COMMENT '',
  `skype` VARCHAR(32) NOT NULL COMMENT '',
  `bio` TINYTEXT NULL DEFAULT NULL COMMENT '',
  `web` VARCHAR(225) NULL DEFAULT NULL COMMENT '',
  `birthday` TIMESTAMP NULL COMMENT '',
  `update_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`user_id`)  COMMENT '',
  UNIQUE INDEX `skype_UNIQUE` (`skype` ASC)  COMMENT '',
  INDEX `fk_user_metadata_user1_idx` (`user_id` ASC)  COMMENT '',
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC)  COMMENT '',
  UNIQUE INDEX `firstname_UNIQUE` (`firstname` ASC)  COMMENT '',
  UNIQUE INDEX `lastname_UNIQUE` (`lastname` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`da_article_history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_article_history` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_article_history` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `article_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  `tag_group_article_id` SMALLINT(5) UNSIGNED NULL COMMENT '',
  `article_category_id` SMALLINT(5) UNSIGNED NULL COMMENT '',
  `image_id` MEDIUMINT(7) NULL COMMENT '',
  `author` SMALLINT(5) UNSIGNED NULL COMMENT '',
  `series_id` SMALLINT(5) UNSIGNED NULL COMMENT '',
  `article_history_id` INT UNSIGNED NOT NULL COMMENT '',
  `slug` VARCHAR(225) NOT NULL COMMENT '',
  `name` VARCHAR(200) NOT NULL COMMENT '',
  `reads` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `custom_tags` VARCHAR(250) NULL COMMENT 'Custom tagy v serializovanom',
  `status` ENUM('published','draft','private') NOT NULL DEFAULT 'published' COMMENT '',
  `type` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Typ:\n0 - Clanok\n1 - Rychla novinka',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  `published_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  INDEX `fk_article_history_article1_idx` (`article_id` ASC)  COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`da_tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_tag` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_tag` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `tag` VARCHAR(20) NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)  COMMENT '',
  UNIQUE INDEX `tag_UNIQUE` (`tag` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`da_tag_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_tag_group` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_tag_group` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `tag_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  PRIMARY KEY (`id`, `tag_id`)  COMMENT '',
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)  COMMENT '',
  INDEX `fk_tag_group_tag1_idx` (`tag_id` ASC)  COMMENT '')
ENGINE = InnoDB
COMMENT = 'Skupina tagov pre nejaky Mega tag';


-- -----------------------------------------------------
-- Table `Desart`.`da_file`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_file` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_file` (
  `id` MEDIUMINT(7) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `name` BINARY(20) NOT NULL COMMENT 'Nazov v sha1',
  `extension` VARCHAR(3) NOT NULL DEFAULT 'png' COMMENT '',
  `type` ENUM('image') NULL DEFAULT 'image' COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  UNIQUE INDEX `image_UNIQUE` (`name` ASC)  COMMENT '',
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`da_series`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_series` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_series` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `image_id` MEDIUMINT(7) UNSIGNED NOT NULL COMMENT '',
  `type` ENUM('ordered', 'unordered') NOT NULL DEFAULT 'unordered' COMMENT '',
  `name` VARCHAR(200) NOT NULL COMMENT '',
  `slug` VARCHAR(225) CHARACTER SET 'ascii' COLLATE 'ascii_general_ci' NOT NULL COMMENT '',
  `description` TINYTEXT NOT NULL COMMENT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  `color` VARCHAR(45) NOT NULL DEFAULT '#444' COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)  COMMENT '',
  UNIQUE INDEX `slug_UNIQUE` (`slug` ASC)  COMMENT '',
  UNIQUE INDEX `color_UNIQUE` (`color` ASC)  COMMENT '',
  INDEX `fk_series_image1_idx` (`image_id` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`da_micro_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_micro_comment` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_micro_comment` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `user_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  `question_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  `comment_type` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT 'Typ komentara, clanook, stranka',
  `reply_comment_id` SMALLINT(5) UNSIGNED NULL DEFAULT NULL COMMENT '',
  `comment_history_id` MEDIUMINT(7) UNSIGNED NOT NULL COMMENT '',
  `text` VARCHAR(250) NOT NULL COMMENT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)  COMMENT '',
  PRIMARY KEY (`id`, `user_id`, `comment_history_id`)  COMMENT '',
  INDEX `fk_micro_comments_user1_idx` (`user_id` ASC)  COMMENT '',
  INDEX `fk_micro_comments_comment_history1_idx` (`comment_history_id` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`da_comment_vote`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_comment_vote` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_comment_vote` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `comment_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  `down_vote` TINYINT(1) UNSIGNED NULL COMMENT '',
  `up_vote` TINYINT(1) UNSIGNED NULL COMMENT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`, `comment_id`)  COMMENT '',
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)  COMMENT '',
  INDEX `fk_comments_votes_comments1_idx` (`comment_id` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`da_micro_commnet_vote`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_micro_commnet_vote` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_micro_commnet_vote` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `micro_comment_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  `down_vote` TINYINT(1) UNSIGNED NOT NULL COMMENT '',
  `up_vote` TINYINT(1) UNSIGNED NOT NULL COMMENT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`, `micro_comment_id`)  COMMENT '',
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)  COMMENT '',
  INDEX `fk_micro_commnet_vote_micro_comment1_idx` (`micro_comment_id` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`da_message_user_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_message_user_group` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_message_user_group` (
  `message_group_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  `message_group_user_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  PRIMARY KEY (`message_group_id`, `message_group_user_id`)  COMMENT '',
  INDEX `fk_message_user_group_message_group1_idx` (`message_group_id` ASC, `message_group_user_id` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`da_selection`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_selection` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_selection` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `selection` TINYTEXT NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`da_newsletter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_newsletter` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_newsletter` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `email` VARCHAR(300) CHARACTER SET 'ascii' COLLATE 'ascii_bin' NOT NULL COMMENT '',
  `selection_id` SMALLINT UNSIGNED NOT NULL COMMENT '',
  PRIMARY KEY (`id`, `selection_id`)  COMMENT '',
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)  COMMENT '',
  UNIQUE INDEX `email_UNIQUE` (`email` ASC)  COMMENT '',
  INDEX `fk_newsletter_selection1_idx` (`selection_id` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`da_ip_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_ip_log` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_ip_log` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `item_id` INT(9) UNSIGNED NOT NULL COMMENT '',
  `ip` INT UNSIGNED NOT NULL COMMENT '',
  `item_type` MEDIUMINT UNSIGNED NOT NULL COMMENT '',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`, `item_id`)  COMMENT '',
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`da_notification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_notification` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_notification` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `connected_with` TINYINT(1) UNSIGNED NOT NULL COMMENT '1 - Article\n2 - Comment in Article\n3 - Comment in Topic',
  `connected_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  `type` TINYINT(1) UNSIGNED NOT NULL DEFAULT 4 COMMENT '1 - custom\n2 - ping\n3 - ad\n4 - new',
  `subject` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Komu',
  `subject_type` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '1 - User\n2 - Group',
  `message` MEDIUMTEXT NULL DEFAULT NULL COMMENT 'Sprava',
  `by_subject` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Kym',
  `seen` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Videne',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `seen_at` TIMESTAMP NULL DEFAULT NULL COMMENT 'Videne kedy',
  PRIMARY KEY (`id`)  COMMENT '',
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)  COMMENT '')
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
