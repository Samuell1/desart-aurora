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
  `name` VARCHAR(100) NOT NULL COMMENT '',
  `color` VARCHAR(45) NOT NULL DEFAULT '#444' COMMENT '',
  `slug` VARCHAR(225) CHARACTER SET 'ascii' COLLATE 'ascii_general_ci' NOT NULL COMMENT '',
  `description` TINYTEXT NULL DEFAULT NULL COMMENT '',
  `parrent_id` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `hidden` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`, `slug`, `name`)  COMMENT '',
  UNIQUE INDEX `category_id_UNIQUE` (`id` ASC)  COMMENT '',
  UNIQUE INDEX `slug_UNIQUE` (`slug` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`da_article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_article` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_article` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `category_id` SMALLINT(5) UNSIGNED NULL DEFAULT NULL COMMENT '',
  `tag_group_id` SMALLINT(5) UNSIGNED NULL DEFAULT NULL COMMENT '',
  `image_id` MEDIUMINT(7) NULL DEFAULT NULL COMMENT 'Default image na article',
  `user_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  `series_id` SMALLINT(5) UNSIGNED NULL DEFAULT NULL COMMENT '0 - Hlavna kategoria, tykajuca sa webu',
  `history_id` SMALLINT(5) UNSIGNED NULL DEFAULT NULL COMMENT '',
  `slug` VARCHAR(225) CHARACTER SET 'ascii' COLLATE 'ascii_general_ci' NOT NULL COMMENT '',
  `name` VARCHAR(200) NOT NULL COMMENT '',
  `content` MEDIUMTEXT NOT NULL COMMENT '',
  `description` TINYTEXT NOT NULL COMMENT '',
  `read_count` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `custom_tags` VARCHAR(250) CHARACTER SET 'ascii' COLLATE 'ascii_general_ci' NULL COMMENT 'Custom tagy v serializovanom',
  `status` ENUM('published','draft','private') NOT NULL DEFAULT 'published' COMMENT '',
  `type` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 - Clanok\n1 - Rychla novinka',
  `sources` TINYTEXT CHARACTER SET 'ascii' COLLATE 'ascii_general_ci' NULL DEFAULT NULL COMMENT 'Zdroje v ser. array',
  `attachments` TINYTEXT CHARACTER SET 'ascii' COLLATE 'ascii_general_ci' NULL COMMENT 'Pridavne subory a obrazky v ser. array',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  `published_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`, `user_id`)  COMMENT '',
  UNIQUE INDEX `article_id_UNIQUE` (`id` ASC)  COMMENT '',
  INDEX `fk_article_article_category1_idx` (`category_id` ASC)  COMMENT '')
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
  `avatar` MEDIUMINT(7) UNSIGNED NOT NULL DEFAULT 2 COMMENT 'Id v files 2 - Default user img',
  `hide_email` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '',
  `banned` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `ip` INT UNSIGNED NULL DEFAULT NULL COMMENT '',
  `account_activated` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `activation_code` BINARY(20) NULL COMMENT 'Aktivacny kod v sha1',
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
  `subject_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  `subject_type` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '1 - Article\n2 - Topic\n3 - Question',
  `user_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  `reply_comment_id` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `reply` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `history_id` MEDIUMINT(7) UNSIGNED NOT NULL COMMENT '',
  `type` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '1 - Velky Komment\n2 - Micro',
  `text` MEDIUMTEXT NOT NULL COMMENT '',
  `choosen` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `hidden` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`, `subject_id`, `user_id`, `history_id`)  COMMENT '',
  UNIQUE INDEX `comment_id_UNIQUE` (`id` ASC)  COMMENT '',
  INDEX `fk_comments_user1_idx` (`user_id` ASC)  COMMENT '',
  INDEX `fk_comments_comment_history1_idx` (`history_id` ASC)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 0;


-- -----------------------------------------------------
-- Table `Desart`.`da_subscribe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_subscribe` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_subscribe` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `user_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  `subject_id` INT(11) UNSIGNED NOT NULL COMMENT '',
  `subject_type` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT 'Article - 1\nTopic - 2 \nQuestion - 3',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`, `user_id`, `subject_id`)  COMMENT '',
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
  `create_topic` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '',
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
  `edit_count` MEDIUMINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '',
  `read_count` MEDIUMINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `text` MEDIUMTEXT NOT NULL COMMENT '',
  `type` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT 'Topic - 1\nQuestion -2',
  `locked` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`, `topic_category_id`, `user_id`)  COMMENT '',
  UNIQUE INDEX `forumt_id_UNIQUE` (`id` ASC)  COMMENT '',
  INDEX `fk_topic_topic_category1_idx` (`topic_category_id` ASC)  COMMENT '',
  INDEX `fk_topic_user1_idx` (`user_id` ASC)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 0
COMMENT = 'Databaza prispevku na fore';


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
  `color` VARCHAR(45) NOT NULL DEFAULT '#444' COMMENT '',
  `description` TINYTEXT NULL COMMENT '',
  `permissions` TINYTEXT NULL DEFAULT NULL COMMENT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`da_user_group_map`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_user_group_map` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_user_group_map` (
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
  `firstname` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `lastname` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `deviantart` VARCHAR(225) NULL DEFAULT NULL COMMENT '',
  `skype` VARCHAR(32) NULL DEFAULT NULL COMMENT '',
  `bio` TINYTEXT NULL DEFAULT NULL COMMENT '',
  `websites` TINYTEXT CHARACTER SET 'ascii' COLLATE 'ascii_general_ci' NULL DEFAULT NULL COMMENT 'Weby pouzivatela v ser. array',
  `birthday` TIMESTAMP NULL COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`user_id`)  COMMENT '',
  UNIQUE INDEX `skype_UNIQUE` (`skype` ASC)  COMMENT '',
  INDEX `fk_user_metadata_user1_idx` (`user_id` ASC)  COMMENT '',
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC)  COMMENT '')
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
  `hidden` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)  COMMENT '',
  UNIQUE INDEX `tag_UNIQUE` (`tag` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`da_tag_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_tag_group` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_tag_group` (
  `id` MEDIUMINT(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `name` VARCHAR(45) NOT NULL COMMENT '',
  `slug` VARCHAR(45) CHARACTER SET 'ascii' COLLATE 'ascii_general_ci' NOT NULL COMMENT 'Slug pre tag',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)  COMMENT '',
  UNIQUE INDEX `slug_UNIQUE` (`slug` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`da_tag_group_map`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_tag_group_map` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_tag_group_map` (
  `tag_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  `tag_group_id` MEDIUMINT(5) UNSIGNED NOT NULL COMMENT '',
  PRIMARY KEY (`tag_id`, `tag_group_id`)  COMMENT '',
  INDEX `fk_tag_group_tag1_idx` (`tag_id` ASC)  COMMENT '',
  INDEX `fk_da_tag_group_map_da_tag_group1_idx` (`tag_group_id` ASC)  COMMENT '')
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
  `type` ENUM('image', 'zip') NULL DEFAULT 'image' COMMENT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
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
  `color` VARCHAR(45) NOT NULL DEFAULT '#444' COMMENT '',
  `name` VARCHAR(200) NOT NULL COMMENT '',
  `slug` VARCHAR(225) CHARACTER SET 'ascii' COLLATE 'ascii_general_ci' NOT NULL COMMENT '',
  `description` TINYTEXT NOT NULL COMMENT '',
  `hidden` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)  COMMENT '',
  UNIQUE INDEX `slug_UNIQUE` (`slug` ASC)  COMMENT '',
  UNIQUE INDEX `color_UNIQUE` (`color` ASC)  COMMENT '',
  INDEX `fk_series_image1_idx` (`image_id` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Desart`.`da_comment_vote`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_comment_vote` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_comment_vote` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `user_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  `comment_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  `vote` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 - Up\n1 - Down',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`id`, `comment_id`)  COMMENT '',
  UNIQUE INDEX `id_UNIQUE` (`id` ASC)  COMMENT '',
  INDEX `fk_comments_votes_comments1_idx` (`comment_id` ASC)  COMMENT '',
  INDEX `fk_da_comment_vote_da_user1_idx` (`user_id` ASC)  COMMENT '')
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


-- -----------------------------------------------------
-- Table `Desart`.`da_article_tag_map`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Desart`.`da_article_tag_map` ;

CREATE TABLE IF NOT EXISTS `Desart`.`da_article_tag_map` (
  `article_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '',
  `tag_group_id` MEDIUMINT(5) UNSIGNED NOT NULL COMMENT '',
  PRIMARY KEY (`article_id`, `tag_group_id`)  COMMENT '',
  INDEX `fk_article_tag_map_da_article1_idx` (`article_id` ASC)  COMMENT '',
  INDEX `fk_article_tag_map_da_tag_group1_idx` (`tag_group_id` ASC)  COMMENT '')
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Desart`.`da_article_category`
-- -----------------------------------------------------
START TRANSACTION;
USE `Desart`;
INSERT INTO `Desart`.`da_article_category` (`id`, `name`, `color`, `slug`, `description`, `parrent_id`, `hidden`, `created_at`, `updated_at`) VALUES (1, 'PHP', '#8892BF', 'php', 'PHP svet', 0, 0, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Desart`.`da_article`
-- -----------------------------------------------------
START TRANSACTION;
USE `Desart`;
INSERT INTO `Desart`.`da_article` (`id`, `category_id`, `tag_group_id`, `image_id`, `user_id`, `series_id`, `history_id`, `slug`, `name`, `content`, `description`, `read_count`, `custom_tags`, `status`, `type`, `sources`, `attachments`, `created_at`, `updated_at`, `published_at`) VALUES (1, 1, NULL, NULL, 1, 1, NULL, 'banan', 'Banan je tooop', 'Najlepsi je v cokolade', 'HTTP/1.1 sa dočkalo zmeny. Čo pre nás táto zmena znamená?', 500, NULL, 'published', 0, NULL, NULL, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Desart`.`da_user`
-- -----------------------------------------------------
START TRANSACTION;
USE `Desart`;
INSERT INTO `Desart`.`da_user` (`id`, `username`, `email`, `active`, `avatar`, `hide_email`, `banned`, `ip`, `account_activated`, `activation_code`, `permissions`, `hash`, `rand`, `created_at`, `updated_at`, `locked_until`) VALUES (1, 'Samuell', 'samuell.patro@gmail.com', 1, 1, 1, 0, 0, 0, NULL, NULL, 'DDyzb*9HMuxR7iTAi2a0322KlSU4gzNw2AQ0Rk9Vj64xg7d0B_BE6zNF8ACJVGP)bG0ezUSb0M9Jqv*v)MqobAM2Obd69fa90f26ac81d700b45e083f3ca9b$2y$11$3zrz9yr5Z08gcQEJJp82Zum80PablFtGYKeUmulErDdl78s9WiSbW', 89, NULL, NULL, NULL);
INSERT INTO `Desart`.`da_user` (`id`, `username`, `email`, `active`, `avatar`, `hide_email`, `banned`, `ip`, `account_activated`, `activation_code`, `permissions`, `hash`, `rand`, `created_at`, `updated_at`, `locked_until`) VALUES (2, 'VeeeneX', 'veeenex@gmail.com', 1, 1, 0, 0, 0, 1, NULL, NULL, 'DDyzb*9HMuxR7iTAi2a0322KlSU4gzNw2AQ0Rk9Vj64xg7d0B_BE6zNF8ACJVGP)bG0ezUSb0M9Jqv*v)MqobAM2Obd69fa90f26ac81d700b45e083f3ca9b$2y$11$3zrz9yr5Z08gcQEJJp82Zum80PablFtGYKeUmulErDdl78s9WiSbW', 89, NULL, NULL, NULL);
INSERT INTO `Desart`.`da_user` (`id`, `username`, `email`, `active`, `avatar`, `hide_email`, `banned`, `ip`, `account_activated`, `activation_code`, `permissions`, `hash`, `rand`, `created_at`, `updated_at`, `locked_until`) VALUES (3, 'KotassMan', 'matus.koterba@gmail.com', 1, 1, 1, 0, 0, 1, NULL, NULL, 'DDyzb*9HMuxR7iTAi2a0322KlSU4gzNw2AQ0Rk9Vj64xg7d0B_BE6zNF8ACJVGP)bG0ezUSb0M9Jqv*v)MqobAM2Obd69fa90f26ac81d700b45e083f3ca9b$2y$11$3zrz9yr5Z08gcQEJJp82Zum80PablFtGYKeUmulErDdl78s9WiSbW', 89, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Desart`.`da_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `Desart`;
INSERT INTO `Desart`.`da_comment` (`id`, `subject_id`, `subject_type`, `user_id`, `reply_comment_id`, `reply`, `history_id`, `type`, `text`, `choosen`, `hidden`, `created_at`, `updated_at`) VALUES (1, 1, 1, 1, 0, DEFAULT, 0, 1, 'Toto je komentár', DEFAULT, 0, NULL, NULL);
INSERT INTO `Desart`.`da_comment` (`id`, `subject_id`, `subject_type`, `user_id`, `reply_comment_id`, `reply`, `history_id`, `type`, `text`, `choosen`, `hidden`, `created_at`, `updated_at`) VALUES (2, 1, 1, 2, 1, DEFAULT, 0, 1, 'Hej ten sa mi nepáči', DEFAULT, 0, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Desart`.`da_topic_category`
-- -----------------------------------------------------
START TRANSACTION;
USE `Desart`;
INSERT INTO `Desart`.`da_topic_category` (`id`, `name`, `slug`, `description`, `hidden`, `create_topic`, `parent_id`, `created_at`, `updated_at`) VALUES (1, 'PHP', 'php', 'Svet php.', 0, DEFAULT, 0, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Desart`.`da_topic`
-- -----------------------------------------------------
START TRANSACTION;
USE `Desart`;
INSERT INTO `Desart`.`da_topic` (`id`, `locked_user_id`, `topic_category_id`, `user_id`, `slug`, `name`, `edit_count`, `read_count`, `text`, `type`, `locked`, `created_at`, `updated_at`) VALUES (1, NULL, 1, 2, 'co-je-to-php', 'Čo je to PHP?', 1, 1, 'Ja neviem vobec ako sa robia stranky, a čo je to vôbec php?', DEFAULT, 0, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Desart`.`da_group`
-- -----------------------------------------------------
START TRANSACTION;
USE `Desart`;
INSERT INTO `Desart`.`da_group` (`id`, `name`, `color`, `description`, `permissions`, `created_at`, `updated_at`) VALUES (1, 'Team', '#444', 'Team of This big penis', NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Desart`.`da_user_group_map`
-- -----------------------------------------------------
START TRANSACTION;
USE `Desart`;
INSERT INTO `Desart`.`da_user_group_map` (`user_id`, `group_id`) VALUES (1, 1);
INSERT INTO `Desart`.`da_user_group_map` (`user_id`, `group_id`) VALUES (2, 1);
INSERT INTO `Desart`.`da_user_group_map` (`user_id`, `group_id`) VALUES (3, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Desart`.`da_user_metadata`
-- -----------------------------------------------------
START TRANSACTION;
USE `Desart`;
INSERT INTO `Desart`.`da_user_metadata` (`user_id`, `firstname`, `lastname`, `deviantart`, `skype`, `bio`, `websites`, `birthday`, `updated_at`) VALUES (1, 'Samuel', 'Patro', NULL, 'samuell.patro', 'Som samko mam rad uhorky a kakac, som bomba :D Rad DEBUGUJEM', 'a:2:{s:6:\"DesArt\";s:17:\"http://desart.sk/\";s:6:\"Github\";s:28:\"https://github.com/Samuell95\";}', NULL, NULL);
INSERT INTO `Desart`.`da_user_metadata` (`user_id`, `firstname`, `lastname`, `deviantart`, `skype`, `bio`, `websites`, `birthday`, `updated_at`) VALUES (2, 'VeeeneX', NULL, NULL, 'veeenex', 'To som ja :D', NULL, NULL, NULL);
INSERT INTO `Desart`.`da_user_metadata` (`user_id`, `firstname`, `lastname`, `deviantart`, `skype`, `bio`, `websites`, `birthday`, `updated_at`) VALUES (3, 'KotassMan', NULL, NULL, 'kotassman', 'I like dogs', NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Desart`.`da_tag`
-- -----------------------------------------------------
START TRANSACTION;
USE `Desart`;
INSERT INTO `Desart`.`da_tag` (`id`, `tag`, `hidden`, `created_at`, `updated_at`) VALUES (1, 'php', DEFAULT, NULL, NULL);
INSERT INTO `Desart`.`da_tag` (`id`, `tag`, `hidden`, `created_at`, `updated_at`) VALUES (2, 'http', DEFAULT, NULL, NULL);
INSERT INTO `Desart`.`da_tag` (`id`, `tag`, `hidden`, `created_at`, `updated_at`) VALUES (3, 'server', DEFAULT, NULL, NULL);
INSERT INTO `Desart`.`da_tag` (`id`, `tag`, `hidden`, `created_at`, `updated_at`) VALUES (4, 'php7', DEFAULT, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Desart`.`da_tag_group`
-- -----------------------------------------------------
START TRANSACTION;
USE `Desart`;
INSERT INTO `Desart`.`da_tag_group` (`id`, `name`, `slug`, `created_at`, `updated_at`) VALUES (1, 'PHP', 'php', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Desart`.`da_tag_group_map`
-- -----------------------------------------------------
START TRANSACTION;
USE `Desart`;
INSERT INTO `Desart`.`da_tag_group_map` (`tag_id`, `tag_group_id`) VALUES (1, 1);
INSERT INTO `Desart`.`da_tag_group_map` (`tag_id`, `tag_group_id`) VALUES (2, 1);
INSERT INTO `Desart`.`da_tag_group_map` (`tag_id`, `tag_group_id`) VALUES (3, 1);
INSERT INTO `Desart`.`da_tag_group_map` (`tag_id`, `tag_group_id`) VALUES (4, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Desart`.`da_series`
-- -----------------------------------------------------
START TRANSACTION;
USE `Desart`;
INSERT INTO `Desart`.`da_series` (`id`, `image_id`, `type`, `color`, `name`, `slug`, `description`, `hidden`, `created_at`, `updated_at`) VALUES (1, 1, 'unordered', '#FFF', 'PHP Tutoriály', 'php-tutorial', 'Tutorialy pre debilov', 0, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Desart`.`da_comment_vote`
-- -----------------------------------------------------
START TRANSACTION;
USE `Desart`;
INSERT INTO `Desart`.`da_comment_vote` (`id`, `user_id`, `comment_id`, `vote`, `created_at`, `updated_at`) VALUES (1, 1, 1, 0, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Desart`.`da_article_tag_map`
-- -----------------------------------------------------
START TRANSACTION;
USE `Desart`;
INSERT INTO `Desart`.`da_article_tag_map` (`article_id`, `tag_group_id`) VALUES (1, 1);

COMMIT;

