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
-- Table `Desart`.`article_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`article_category` ;

CREATE TABLE IF NOT EXISTS `Desart`.`article_category` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `color` VARCHAR(45) NOT NULL,
  `slug` VARCHAR(225) CHARACTER SET 'ascii' COLLATE 'ascii_general_ci' NOT NULL,
  `description` TINYTEXT NULL DEFAULT NULL,
  `parrent_id` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
  `hidden` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `category_id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `slug_UNIQUE` (`slug` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`article` ;

CREATE TABLE IF NOT EXISTS `Desart`.`article` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `article_category_id` SMALLINT(5) UNSIGNED NULL DEFAULT NULL,
  `tag_group_id` SMALLINT(5) UNSIGNED NULL DEFAULT NULL,
  `image_id` MEDIUMINT(7) NULL DEFAULT NULL COMMENT 'Default image na article',
  `user_id` SMALLINT(5) UNSIGNED NOT NULL,
  `series_id` SMALLINT(5) UNSIGNED NULL DEFAULT NULL COMMENT '0 - Hlavna kategoria, tykajuca sa webu',
  `article_history_id` SMALLINT(5) UNSIGNED NULL DEFAULT NULL,
  `slug` VARCHAR(225) CHARACTER SET 'ascii' COLLATE 'ascii_general_ci' NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `reads` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
  `custom_tags` VARCHAR(250) CHARACTER SET 'ascii' COLLATE 'ascii_general_ci' NULL COMMENT 'Custom tagy v serializovanom',
  `status` ENUM('published','draft','private') NOT NULL DEFAULT 'published',
  `type` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Typ:\n0 - Clanok\n1 - Rychla novinka',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `published_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `attachments` TINYTEXT NULL COMMENT 'Pridavne subory a obrazky',
  PRIMARY KEY (`id`, `user_id`),
  UNIQUE INDEX `article_id_UNIQUE` (`id` ASC),
  INDEX `fk_article_article_category1_idx` (`article_category_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 0;


-- -----------------------------------------------------
-- Table `Desart`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`user` ;

CREATE TABLE IF NOT EXISTS `Desart`.`user` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(32) NOT NULL,
  `email` VARCHAR(300) CHARACTER SET 'ascii' COLLATE 'ascii_general_ci' NOT NULL COMMENT 'Email',
  `active` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  `avatar` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1,
  `location` VARCHAR(255) NULL,
  `hide_email` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1,
  `banned` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  `ip` INT UNSIGNED NULL,
  `activated` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  `activation_code` BINARY(16) NOT NULL,
  `permissions` TINYTEXT NULL,
  `password` VARCHAR(150) NOT NULL,
  `rand` TINYINT(3) UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `locked_until` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `username`, `email`),
  UNIQUE INDEX `user_email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `user_nick_UNIQUE` (`username` ASC),
  UNIQUE INDEX `user_id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `activation_code_UNIQUE` (`activation_code` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 0;


-- -----------------------------------------------------
-- Table `Desart`.`comment_history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`comment_history` ;

CREATE TABLE IF NOT EXISTS `Desart`.`comment_history` (
  `id` MEDIUMINT(7) UNSIGNED NOT NULL AUTO_INCREMENT,
  `change` TINYTEXT NOT NULL,
  `change_type` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`comments` ;

CREATE TABLE IF NOT EXISTS `Desart`.`comments` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `article_id` SMALLINT(5) UNSIGNED NOT NULL,
  `user_id` SMALLINT(5) UNSIGNED NOT NULL,
  `reply_comment_id` SMALLINT(5) UNSIGNED NULL DEFAULT NULL,
  `comment_history_id` MEDIUMINT(7) UNSIGNED NOT NULL,
  `comment_type` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1,
  `text` TINYTEXT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `user_id`, `comment_history_id`),
  UNIQUE INDEX `comment_id_UNIQUE` (`id` ASC),
  INDEX `fk_comments_user1_idx` (`user_id` ASC),
  INDEX `fk_comments_comment_history1_idx` (`comment_history_id` ASC))
ENGINE = MyISAM
AUTO_INCREMENT = 0;


-- -----------------------------------------------------
-- Table `Desart`.`favorite`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`favorite` ;

CREATE TABLE IF NOT EXISTS `Desart`.`favorite` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` SMALLINT(5) UNSIGNED NULL,
  `item_id` INT(11) UNSIGNED NOT NULL,
  `type` TINYINT(2) UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`, `user_id`),
  UNIQUE INDEX `fav_id_UNIQUE` (`id` ASC),
  INDEX `fk_favorite_user1_idx` (`user_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 0;


-- -----------------------------------------------------
-- Table `Desart`.`topic_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`topic_category` ;

CREATE TABLE IF NOT EXISTS `Desart`.`topic_category` (
  `id` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL COMMENT 'Nazov fora',
  `slug` VARCHAR(225) NOT NULL,
  `description` TEXT(300) NOT NULL COMMENT 'Popis fora',
  `hidden` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  `parent_id` TINYINT(3) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `forum_id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 0;


-- -----------------------------------------------------
-- Table `Desart`.`topic`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`topic` ;

CREATE TABLE IF NOT EXISTS `Desart`.`topic` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `locked_user_id` SMALLINT(5) UNSIGNED NULL DEFAULT NULL,
  `topic_category_id` TINYINT(3) UNSIGNED NULL,
  `user_id` SMALLINT(5) UNSIGNED NULL,
  `slug` VARCHAR(225) NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `edit_count` MEDIUMINT UNSIGNED NOT NULL,
  `reads` MEDIUMINT UNSIGNED NOT NULL DEFAULT 0,
  `text` MEDIUMTEXT NOT NULL,
  `locked` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `topic_category_id`, `user_id`),
  UNIQUE INDEX `forumt_id_UNIQUE` (`id` ASC),
  INDEX `fk_topic_topic_category1_idx` (`topic_category_id` ASC),
  INDEX `fk_topic_user1_idx` (`user_id` ASC))
ENGINE = MyISAM
AUTO_INCREMENT = 0
COMMENT = 'Databaza prispevku na fore';


-- -----------------------------------------------------
-- Table `Desart`.`topic_post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`topic_post` ;

CREATE TABLE IF NOT EXISTS `Desart`.`topic_post` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` SMALLINT(5) UNSIGNED NULL,
  `topic_id` SMALLINT UNSIGNED NOT NULL,
  `edit_user_id` SMALLINT(5) UNSIGNED NULL,
  `edit_count` MEDIUMINT UNSIGNED NOT NULL,
  `text` MEDIUMTEXT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `user_id`, `topic_id`, `edit_user_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_topic_post_topic1_idx` (`topic_id` ASC),
  INDEX `fk_topic_post_user1_idx` (`user_id` ASC),
  INDEX `fk_topic_post_user2_idx` (`edit_user_id` ASC))
ENGINE = MyISAM
AUTO_INCREMENT = 0
COMMENT = 'Prispevok do topiku v databaze';


-- -----------------------------------------------------
-- Table `Desart`.`topic_read`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`topic_read` ;

CREATE TABLE IF NOT EXISTS `Desart`.`topic_read` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `topic_id` SMALLINT UNSIGNED NULL,
  `user_id` SMALLINT UNSIGNED NOT NULL,
  `read` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  `read_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `topic_id`, `user_id`),
  UNIQUE INDEX `forumr_id_UNIQUE` (`id` ASC),
  INDEX `fk_topic_read_topic1_idx` (`topic_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 0
COMMENT = 'Ci si pouzivatel precital topik';


-- -----------------------------------------------------
-- Table `Desart`.`message_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`message_group` ;

CREATE TABLE IF NOT EXISTS `Desart`.`message_group` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` SMALLINT(5) UNSIGNED NOT NULL,
  `group_name` VARCHAR(200) NOT NULL COMMENT 'Meno skupiny pouzivatel si moze vytvorit vlastnu skupinu mena mozu byt rovnake',
  `group_description` TINYTEXT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `user_id`),
  UNIQUE INDEX `group_id_UNIQUE` (`id` ASC),
  INDEX `fk_message_group_user1_idx` (`user_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`message` ;

CREATE TABLE IF NOT EXISTS `Desart`.`message` (
  `id` SMALLINT(7) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Cislo spravy',
  `user_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT 'Id pouzivatela// sender',
  `message_group_id` SMALLINT(5) UNSIGNED NOT NULL,
  `to_subject_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT 'Skupina alebo User',
  `subject_type` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '1 - User\n0 - Group',
  `is_read` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  `text` MEDIUMTEXT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `read_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `user_id`, `message_group_id`, `to_subject_id`),
  UNIQUE INDEX `message_id_UNIQUE` (`id` ASC),
  INDEX `fk_message_message_group1_idx` (`message_group_id` ASC),
  INDEX `fk_message_user1_idx` (`to_subject_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 0;


-- -----------------------------------------------------
-- Table `Desart`.`ban`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`ban` ;

CREATE TABLE IF NOT EXISTS `Desart`.`ban` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id banu',
  `user_id` SMALLINT(5) UNSIGNED NOT NULL,
  `reason` TINYTEXT CHARACTER SET 'utf8mb4' NOT NULL COMMENT 'Dovod banu',
  `duration_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `user_id`),
  UNIQUE INDEX `ban_id_UNIQUE` (`id` ASC),
  INDEX `fk_bans_user1_idx` (`user_id` ASC),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 0;


-- -----------------------------------------------------
-- Table `Desart`.`group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`group` ;

CREATE TABLE IF NOT EXISTS `Desart`.`group` (
  `id` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `color` VARCHAR(45) NULL,
  `description` TINYTEXT NULL,
  `permissions` TINYTEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`user_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`user_group` ;

CREATE TABLE IF NOT EXISTS `Desart`.`user_group` (
  `user_id` SMALLINT(5) UNSIGNED NOT NULL,
  `group_id` TINYINT(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`, `group_id`),
  INDEX `fk_user_group_user1_idx` (`user_id` ASC),
  INDEX `fk_user_group_user_groups1_idx` (`group_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`user_metadata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`user_metadata` ;

CREATE TABLE IF NOT EXISTS `Desart`.`user_metadata` (
  `user_id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `deviantart` VARCHAR(225) NOT NULL,
  `skype` VARCHAR(32) NOT NULL,
  `bio` TINYTEXT NULL DEFAULT NULL,
  `web` VARCHAR(225) NULL DEFAULT NULL,
  `birthday` TIMESTAMP NULL,
  `update_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `skype_UNIQUE` (`skype` ASC),
  INDEX `fk_user_metadata_user1_idx` (`user_id` ASC),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`article_history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`article_history` ;

CREATE TABLE IF NOT EXISTS `Desart`.`article_history` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `article_id` SMALLINT(5) UNSIGNED NOT NULL,
  `tag_group_article_id` SMALLINT(5) UNSIGNED NULL,
  `article_category_id` SMALLINT(5) UNSIGNED NULL,
  `image_id` MEDIUMINT(7) NULL,
  `user_id` SMALLINT(5) UNSIGNED NULL,
  `series_id` SMALLINT(5) UNSIGNED NULL,
  `article_history_id` INT UNSIGNED NOT NULL,
  `slug` VARCHAR(225) NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `reads` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
  `custom_tags` VARCHAR(250) NULL COMMENT 'Custom tagy v serializovanom',
  `status` ENUM('published','draft','private') NOT NULL DEFAULT 'published',
  `type` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Typ:\n0 - Clanok\n1 - Rychla novinka',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `published_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_article_history_article1_idx` (`article_id` ASC),
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`tag` ;

CREATE TABLE IF NOT EXISTS `Desart`.`tag` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tag` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `tag_UNIQUE` (`tag` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`tag_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`tag_group` ;

CREATE TABLE IF NOT EXISTS `Desart`.`tag_group` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tag_id` SMALLINT(5) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `tag_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_tag_group_tag1_idx` (`tag_id` ASC))
ENGINE = InnoDB
COMMENT = 'Skupina tagov pre nejaky Mega tag';


-- -----------------------------------------------------
-- Table `Desart`.`files`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`files` ;

CREATE TABLE IF NOT EXISTS `Desart`.`files` (
  `id` MEDIUMINT(7) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` BINARY(20) NOT NULL COMMENT 'Nazov v sha1',
  `extension` VARCHAR(3) NOT NULL DEFAULT 'png',
  `type` ENUM('image') NULL DEFAULT 'image',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `image_UNIQUE` (`name` ASC),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`series`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`series` ;

CREATE TABLE IF NOT EXISTS `Desart`.`series` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `image_id` MEDIUMINT(7) UNSIGNED NOT NULL,
  `type` ENUM('ordered', 'unordered') NOT NULL DEFAULT 'unordered',
  `name` VARCHAR(200) NOT NULL,
  `slug` VARCHAR(225) CHARACTER SET 'ascii' COLLATE 'ascii_general_ci' NOT NULL,
  `description` TINYTEXT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `color` VARCHAR(45) NOT NULL DEFAULT '#444',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `slug_UNIQUE` (`slug` ASC),
  UNIQUE INDEX `color_UNIQUE` (`color` ASC),
  INDEX `fk_series_image1_idx` (`image_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`micro_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`micro_comment` ;

CREATE TABLE IF NOT EXISTS `Desart`.`micro_comment` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` SMALLINT(5) UNSIGNED NOT NULL,
  `question_id` SMALLINT(5) UNSIGNED NOT NULL,
  `comment_type` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT 'Typ komentara, clanook, stranka',
  `reply_comment_id` SMALLINT(5) UNSIGNED NULL DEFAULT NULL,
  `comment_history_id` MEDIUMINT(7) UNSIGNED NOT NULL,
  `text` VARCHAR(250) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  PRIMARY KEY (`id`, `user_id`, `comment_history_id`),
  INDEX `fk_micro_comments_user1_idx` (`user_id` ASC),
  INDEX `fk_micro_comments_comment_history1_idx` (`comment_history_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`comment_vote`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`comment_vote` ;

CREATE TABLE IF NOT EXISTS `Desart`.`comment_vote` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `comment_id` SMALLINT(5) UNSIGNED NOT NULL,
  `down_vote` TINYINT(1) UNSIGNED NULL,
  `up_vote` TINYINT(1) UNSIGNED NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `comment_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_comments_votes_comments1_idx` (`comment_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`micro_commnet_vote`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`micro_commnet_vote` ;

CREATE TABLE IF NOT EXISTS `Desart`.`micro_commnet_vote` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `micro_comment_id` SMALLINT(5) UNSIGNED NOT NULL,
  `down_vote` TINYINT(1) UNSIGNED NOT NULL,
  `up_vote` TINYINT(1) UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `micro_comment_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_micro_commnet_vote_micro_comment1_idx` (`micro_comment_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`message_user_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`message_user_group` ;

CREATE TABLE IF NOT EXISTS `Desart`.`message_user_group` (
  `message_group_id` SMALLINT(5) UNSIGNED NOT NULL,
  `message_group_user_id` SMALLINT(5) UNSIGNED NOT NULL,
  PRIMARY KEY (`message_group_id`, `message_group_user_id`),
  INDEX `fk_message_user_group_message_group1_idx` (`message_group_id` ASC, `message_group_user_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`selection`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`selection` ;

CREATE TABLE IF NOT EXISTS `Desart`.`selection` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `selection` TINYTEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`newsletter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`newsletter` ;

CREATE TABLE IF NOT EXISTS `Desart`.`newsletter` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(300) CHARACTER SET 'ascii' COLLATE 'ascii_bin' NOT NULL,
  `selection_id` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `selection_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `fk_newsletter_selection1_idx` (`selection_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`ip_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`ip_log` ;

CREATE TABLE IF NOT EXISTS `Desart`.`ip_log` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `item_id` INT(9) UNSIGNED NOT NULL,
  `ip` INT UNSIGNED NOT NULL,
  `item_type` MEDIUMINT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `item_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`notification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`notification` ;

CREATE TABLE IF NOT EXISTS `Desart`.`notification` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` TINYINT(1) UNSIGNED NOT NULL DEFAULT 4 COMMENT '1 - custom\n2 - ping\n3 - ad\n4 - new',
  `subject` SMALLINT(5) UNSIGNED NOT NULL,
  `subject_type` TINYINT(1) UNSIGNED NOT NULL COMMENT '1 - User\n2 - Group',
  `message` MEDIUMTEXT NULL,
  `by` VARCHAR(32) NOT NULL,
  `by_type` TINYINT(1) UNSIGNED NOT NULL COMMENT '1 - User_id\n2 - Vlastne meno',
  `read` TINYINT(1) NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `read_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `subject_type_UNIQUE` (`subject_type` ASC))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
