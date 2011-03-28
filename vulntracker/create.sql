BEGIN;
CREATE TABLE `advisory` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `message_id` integer NOT NULL,
    `app_id` integer NOT NULL,
    `version` varchar(25) NOT NULL,
    `text` longtext NOT NULL
);
CREATE TABLE `app` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` varchar(150) NOT NULL UNIQUE
);
ALTER TABLE `advisory` ADD CONSTRAINT app_id_refs_id_63421648 FOREIGN KEY (`app_id`) REFERENCES `app` (`id`);
CREATE TABLE `app_version` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `app_id` integer NOT NULL REFERENCES `app` (`id`),
    `version` varchar(50) NOT NULL
);
CREATE TABLE `message_type` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` varchar(25) NOT NULL UNIQUE,
    `description` longtext NOT NULL
);
CREATE TABLE `user_criteria` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `user_id` integer NOT NULL,
    `criteria_id` integer NOT NULL,
    `criteria_value_id` integer NOT NULL
);
CREATE TABLE `source` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` varchar(50) NOT NULL,
    `url` varchar(100) NOT NULL,
    `desc` varchar(150) NOT NULL,
    `type_id` integer NOT NULL REFERENCES `message_type` (`id`)
);
CREATE TABLE `user` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `email` varchar(75) NOT NULL UNIQUE
);
ALTER TABLE `user_criteria` ADD CONSTRAINT user_id_refs_id_4baa58fe FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
CREATE TABLE `criteria` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` varchar(50) NOT NULL UNIQUE,
    `desc` longtext NOT NULL,
    `type` varchar(50) NOT NULL
);
ALTER TABLE `user_criteria` ADD CONSTRAINT criteria_id_refs_id_3413a524 FOREIGN KEY (`criteria_id`) REFERENCES `criteria` (`id`);
CREATE TABLE `message` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `text` longtext NOT NULL,
    `subject` varchar(250) NOT NULL UNIQUE,
    `body` longtext NOT NULL,
    `type_id` integer NOT NULL REFERENCES `message_type` (`id`),
    `source_id` integer NOT NULL REFERENCES `source` (`id`),
    `processed` bool NOT NULL
);
ALTER TABLE `advisory` ADD CONSTRAINT message_id_refs_id_2a949678 FOREIGN KEY (`message_id`) REFERENCES `message` (`id`);
CREATE TABLE `criteria_value` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `criteria_id` integer NOT NULL REFERENCES `criteria` (`id`),
    `value` varchar(50) NOT NULL,
    `user_id` integer NOT NULL REFERENCES `user` (`id`)
);
ALTER TABLE `user_criteria` ADD CONSTRAINT criteria_value_id_refs_id_6742b210 FOREIGN KEY (`criteria_value_id`) REFERENCES `criteria_value` (`id`);
COMMIT;
