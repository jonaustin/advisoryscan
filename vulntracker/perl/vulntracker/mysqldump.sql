-- phpMyAdmin SQL Dump
-- version 2.9.1.1-Debian-2ubuntu1
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: May 07, 2007 at 09:58 AM
-- Server version: 5.0.38
-- PHP Version: 5.2.1
-- 
-- Database: `vulntracker_criteria2`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `advisory`
-- 
SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE `advisory` (
  `id` int(11) NOT NULL auto_increment,
  `message_id` int(11) NOT NULL,
  `app_id` int(11) NOT NULL,
  `version` varchar(25) NOT NULL,
  `text` longtext NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `message_id` (`message_id`),
  KEY `app_id` (`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `advisory`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `alert_method`
-- 

CREATE TABLE `alert_method` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `desc` varchar(100) NOT NULL,
  `desc_long` longtext NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- 
-- Dumping data for table `alert_method`
-- 

INSERT INTO `alert_method` (`id`, `name`, `desc`, `desc_long`) VALUES 
(1, 'rss', 'rss feeds', ''),
(2, 'mail', 'email', '');

-- --------------------------------------------------------

-- 
-- Table structure for table `app`
-- 

CREATE TABLE `app` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `app`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `app_version`
-- 

CREATE TABLE `app_version` (
  `id` int(11) NOT NULL auto_increment,
  `app_id` int(11) NOT NULL,
  `version` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `app_id` (`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `app_version`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `auth_group`
-- 

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- 
-- Dumping data for table `auth_group`
-- 

INSERT INTO `auth_group` (`id`, `name`) VALUES 
(1, 'users');

-- --------------------------------------------------------

-- 
-- Table structure for table `auth_group_permissions`
-- 

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL auto_increment,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `auth_group_permissions`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `auth_message`
-- 

CREATE TABLE `auth_message` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `message` longtext NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `auth_message_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `auth_message`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `auth_permission`
-- 

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id` (`content_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=49 ;

-- 
-- Dumping data for table `auth_permission`
-- 

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES 
(1, 'Can add message', 1, 'add_message'),
(2, 'Can change message', 1, 'change_message'),
(3, 'Can delete message', 1, 'delete_message'),
(4, 'Can add group', 2, 'add_group'),
(5, 'Can change group', 2, 'change_group'),
(6, 'Can delete group', 2, 'delete_group'),
(7, 'Can add user', 3, 'add_user'),
(8, 'Can change user', 3, 'change_user'),
(9, 'Can delete user', 3, 'delete_user'),
(10, 'Can add permission', 4, 'add_permission'),
(11, 'Can change permission', 4, 'change_permission'),
(12, 'Can delete permission', 4, 'delete_permission'),
(13, 'Can add content type', 5, 'add_contenttype'),
(14, 'Can change content type', 5, 'change_contenttype'),
(15, 'Can delete content type', 5, 'delete_contenttype'),
(16, 'Can add session', 6, 'add_session'),
(17, 'Can change session', 6, 'change_session'),
(18, 'Can delete session', 6, 'delete_session'),
(19, 'Can add site', 7, 'add_site'),
(20, 'Can change site', 7, 'change_site'),
(21, 'Can delete site', 7, 'delete_site'),
(22, 'Can add log entry', 8, 'add_logentry'),
(23, 'Can change log entry', 8, 'change_logentry'),
(24, 'Can delete log entry', 8, 'delete_logentry'),
(25, 'Can add alert method', 9, 'add_alertmethod'),
(26, 'Can change alert method', 9, 'change_alertmethod'),
(27, 'Can delete alert method', 9, 'delete_alertmethod'),
(28, 'Can add criteria type', 10, 'add_criteriatype'),
(29, 'Can change criteria type', 10, 'change_criteriatype'),
(30, 'Can delete criteria type', 10, 'delete_criteriatype'),
(31, 'Can add user criteria', 11, 'add_usercriteria'),
(32, 'Can change user criteria', 11, 'change_usercriteria'),
(33, 'Can delete user criteria', 11, 'delete_usercriteria'),
(34, 'Can add source', 12, 'add_source'),
(35, 'Can change source', 12, 'change_source'),
(36, 'Can delete source', 12, 'delete_source'),
(37, 'Can add message type', 13, 'add_messagetype'),
(38, 'Can change message type', 13, 'change_messagetype'),
(39, 'Can delete message type', 13, 'delete_messagetype'),
(40, 'Can add message', 14, 'add_message'),
(41, 'Can change message', 14, 'change_message'),
(42, 'Can delete message', 14, 'delete_message'),
(43, 'Can add criteria qualifier', 15, 'add_criteriaqualifier'),
(44, 'Can change criteria qualifier', 15, 'change_criteriaqualifier'),
(45, 'Can delete criteria qualifier', 15, 'delete_criteriaqualifier'),
(46, 'Can add user profile', 16, 'add_userprofile'),
(47, 'Can change user profile', 16, 'change_userprofile'),
(48, 'Can delete user profile', 16, 'delete_userprofile');

-- --------------------------------------------------------

-- 
-- Table structure for table `auth_user`
-- 

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `password` varchar(128) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` datetime NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

-- 
-- Dumping data for table `auth_user`
-- 

INSERT INTO `auth_user` (`id`, `username`, `first_name`, `last_name`, `email`, `password`, `is_staff`, `is_active`, `is_superuser`, `last_login`, `date_joined`) VALUES 
(1, 'jon', 'jon', 'austin', 'jon.i.austin@gmail.com', 'sha1$67239$e8929bcd0522ae9b907945cfc5da7eddb733256f', 1, 1, 1, '2007-05-06 17:20:53', '2007-04-05 20:51:48'),
(4, 'testuser', 'test', 'test', 'test@lkj.net', 'sha1$ae624$9d729ef2b02118c79db59854b928439d2b8a9779', 0, 1, 0, '2007-04-09 15:50:45', '2007-04-09 15:50:45'),
(5, 'testt', 'test', 'user', 'test@test.com', 'sha1$6cf35$cf1ab9bfab452d3653fd0226100efe0bcd707ffc', 0, 1, 0, '2007-05-06 13:26:52', '2007-05-04 05:35:11');

-- --------------------------------------------------------

-- 
-- Table structure for table `auth_user_groups`
-- 

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

-- 
-- Dumping data for table `auth_user_groups`
-- 

INSERT INTO `auth_user_groups` (`id`, `user_id`, `group_id`) VALUES 
(1, 4, 1),
(8, 5, 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `auth_user_user_permissions`
-- 

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `auth_user_user_permissions`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `criteria_type`
-- 

CREATE TABLE `criteria_type` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `search_field` varchar(100) NOT NULL,
  `desc` longtext NOT NULL,
  `input_type` varchar(50) NOT NULL,
  `criteria_pref_type` varchar(50) NOT NULL default 'advanced',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

-- 
-- Dumping data for table `criteria_type`
-- 

INSERT INTO `criteria_type` (`id`, `name`, `search_field`, `desc`, `input_type`, `criteria_pref_type`) VALUES 
(1, 'subject', 'subject', '', 'text', 'advanced'),
(2, 'message body', 'body', '', 'text', 'advanced'),
(3, 'name', 'subject', 'Product/Application Name', 'text', 'simple'),
(4, 'version', 'subject', 'Product/Application Version', 'text', 'simple');

-- --------------------------------------------------------

-- 
-- Table structure for table `django_admin_log`
-- 

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL auto_increment,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) default NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `django_admin_log_user_id` (`user_id`),
  KEY `django_admin_log_content_type_id` (`content_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=88 ;

-- 
-- Dumping data for table `django_admin_log`
-- 

INSERT INTO `django_admin_log` (`id`, `action_time`, `user_id`, `content_type_id`, `object_id`, `object_repr`, `action_flag`, `change_message`) VALUES 
(1, '2007-04-05 20:53:14', 1, 9, '1', 'rss', 1, ''),
(2, '2007-04-05 20:54:26', 1, 9, '2', 'mail', 1, ''),
(3, '2007-04-05 20:54:51', 1, 15, '1', 'contains', 1, ''),
(4, '2007-04-05 20:55:31', 1, 10, '1', 'subject', 1, ''),
(5, '2007-04-05 20:55:43', 1, 10, '2', 'message body', 1, ''),
(6, '2007-04-05 20:56:12', 1, 13, '1', 'mail', 1, ''),
(7, '2007-04-05 20:58:14', 1, 12, '1', 'bugtraq', 1, ''),
(8, '2007-04-05 21:32:22', 1, 9, '1', 'test', 1, ''),
(9, '2007-04-05 21:32:54', 1, 9, '1', 'rss', 2, 'Changed name and desc.'),
(10, '2007-04-05 21:32:55', 1, 9, '1', 'rss', 2, 'No fields changed.'),
(11, '2007-04-05 21:33:01', 1, 9, '2', 'mail', 1, ''),
(12, '2007-04-05 21:35:53', 1, 3, '1', 'jon', 2, 'Added user profile "jon". Changed staff status, active, superuser status, sources for user profile "jon" and alert methods for user profile "jon".'),
(13, '2007-04-06 11:36:57', 1, 3, '1', 'jon', 2, 'Added user criteria "foo". Changed staff status, active, superuser status, sources for user profile "jon" and alert methods for user profile "jon".'),
(14, '2007-04-06 11:37:15', 1, 3, '1', 'jon', 2, 'Added user criteria "bar". Changed staff status, active, superuser status, sources for user profile "jon" and alert methods for user profile "jon".'),
(15, '2007-04-07 17:48:42', 1, 15, '2', 'is', 1, ''),
(16, '2007-04-07 17:52:04', 1, 12, '2', 'Full Disclosure', 1, ''),
(17, '2007-04-07 17:53:30', 1, 12, '3', 'VulnWatch', 1, ''),
(18, '2007-04-07 17:58:26', 1, 15, '3', 'starts_with', 1, ''),
(19, '2007-04-07 17:58:52', 1, 15, '4', 'ends_with', 1, ''),
(20, '2007-04-07 17:59:03', 1, 15, '3', 'starts_with', 2, 'Changed sql.'),
(21, '2007-04-07 17:59:46', 1, 15, '5', 'not_start_with', 1, ''),
(22, '2007-04-07 18:00:06', 1, 15, '6', 'not_contains', 1, ''),
(23, '2007-04-07 18:04:05', 1, 15, '7', 'not_equal', 1, ''),
(24, '2007-04-07 18:04:33', 1, 15, '2', 'equals', 2, 'Changed name and desc.'),
(25, '2007-04-07 18:23:46', 1, 15, '8', 'regexp', 1, ''),
(26, '2007-04-07 18:26:26', 1, 15, '7', 'not_equal', 2, 'Changed desc.'),
(27, '2007-04-07 18:26:57', 1, 15, '2', 'equal to', 2, 'Changed name and desc.'),
(28, '2007-04-07 18:27:07', 1, 15, '2', 'equal to', 2, 'Changed desc.'),
(29, '2007-04-07 19:17:18', 1, 10, '3', 'Product/Application Name', 1, ''),
(30, '2007-04-07 19:17:31', 1, 10, '4', 'Product/Application Version', 1, ''),
(31, '2007-04-08 01:33:51', 1, 10, '4', 'version', 2, 'Changed name and desc.'),
(32, '2007-04-08 01:34:18', 1, 10, '3', 'name', 2, 'Changed name and desc.'),
(33, '2007-04-08 15:55:53', 1, 3, '1', 'jon', 2, 'Changed staff status, active, superuser status, value for user criteria "adf", value for user criteria "wer", sources for user profile "jon" and alert methods for user profile "jon".'),
(34, '2007-04-09 15:50:02', 1, 2, '1', 'users', 1, ''),
(35, '2007-04-09 15:50:36', 1, 3, '3', 'testuser', 3, ''),
(36, '2007-04-10 14:23:11', 1, 3, '1', 'jon', 2, 'Changed staff status, active, superuser status, criteria pref type for user profile "jon", sources for user profile "jon", alert methods for user profile "jon" and messages for user profile "jon".'),
(37, '2007-04-10 14:24:07', 1, 3, '2', 'test', 2, 'Changed staff status, active and superuser status.'),
(38, '2007-04-10 14:25:00', 1, 3, '2', 'test', 2, 'Changed staff status, active and superuser status.'),
(39, '2007-04-10 18:21:01', 1, 15, '8', 'regexp', 2, 'Changed rose and rose sql.'),
(40, '2007-04-10 18:21:13', 1, 15, '7', 'not_equal', 2, 'Changed rose and rose sql.'),
(41, '2007-04-10 18:30:56', 1, 15, '6', 'not_contains', 2, 'Changed rose and rose sql.'),
(42, '2007-04-10 19:32:13', 1, 3, '1', 'jon', 2, 'Changed staff status, active, superuser status, value for user criteria "php", sources for user profile "jon", alert methods for user profile "jon" and messages for user profile "jon". Deleted user criteria "asdfadf", user criteria "435", user criteria "werwer" and user criteria "dfg".'),
(43, '2007-04-10 19:32:33', 1, 3, '1', 'jon', 2, 'Changed staff status, active, superuser status, qualifier for user criteria "php", sources for user profile "jon", alert methods for user profile "jon" and messages for user profile "jon".'),
(44, '2007-04-10 20:00:51', 1, 15, '1', 'contains', 2, 'Changed rose and rose sql.'),
(45, '2007-04-10 20:01:03', 1, 15, '2', 'equal to', 2, 'Changed rose and rose sql.'),
(46, '2007-04-10 20:01:15', 1, 15, '3', 'starts_with', 2, 'Changed rose and rose sql.'),
(47, '2007-04-10 20:01:57', 1, 15, '4', 'ends_with', 2, 'Changed rose and rose sql.'),
(48, '2007-04-10 20:02:58', 1, 15, '5', 'not_start_with', 2, 'Changed rose and rose sql.'),
(49, '2007-04-10 20:03:04', 1, 15, '6', 'not_contains', 2, 'No fields changed.'),
(50, '2007-04-10 20:03:10', 1, 15, '7', 'not_equal', 2, 'No fields changed.'),
(51, '2007-04-10 20:12:31', 1, 15, '6', 'not_contains', 2, 'Changed rose.'),
(52, '2007-04-10 20:12:40', 1, 15, '5', 'not_start_with', 2, 'Changed rose.'),
(53, '2007-04-10 20:12:47', 1, 15, '4', 'ends_with', 2, 'Changed rose.'),
(54, '2007-04-10 20:12:54', 1, 15, '3', 'starts_with', 2, 'Changed rose.'),
(55, '2007-04-10 20:13:00', 1, 15, '1', 'contains', 2, 'Changed rose.'),
(56, '2007-04-11 09:21:39', 1, 3, '1', 'jon', 2, 'Changed staff status, active, superuser status, qualifier for user criteria "remot", value for user criteria "remot", sources for user profile "jon", alert methods for user profile "jon" and messages for user profile "jon".'),
(57, '2007-04-11 09:22:50', 1, 3, '1', 'jon', 2, 'Changed staff status, active, superuser status, qualifier for user criteria "magick", value for user criteria "magick", sources for user profile "jon", alert methods for user profile "jon" and messages for user profile "jon".'),
(58, '2007-04-11 09:23:36', 1, 3, '1', 'jon', 2, 'Changed staff status, active, superuser status, qualifier for user criteria "remot", value for user criteria "remot", sources for user profile "jon", alert methods for user profile "jon" and messages for user profile "jon".'),
(59, '2007-04-11 17:58:22', 1, 3, '1', 'jon', 2, 'Added user criteria "php". Changed staff status, active, superuser status, value for user criteria "re:", sources for user profile "jon", alert methods for user profile "jon" and messages for user profile "jon".'),
(60, '2007-04-14 13:08:47', 1, 12, '4', 'php security', 1, ''),
(61, '2007-04-14 13:19:48', 1, 12, '5', 'Web Security - webappsec.com', 1, ''),
(62, '2007-04-14 13:21:31', 1, 12, '5', 'Web Security - webappsec.com', 2, 'Changed url.'),
(63, '2007-04-14 15:04:44', 1, 12, '6', 'Infosec News', 1, ''),
(64, '2007-04-14 15:08:12', 1, 12, '7', 'Web App Security (securityfocus)', 1, ''),
(65, '2007-04-14 15:08:28', 1, 12, '5', 'Web Security (webappsec.org)', 2, 'Changed name.'),
(66, '2007-04-14 15:35:32', 1, 12, '8', 'NTBugtraq', 1, ''),
(67, '2007-04-14 15:39:06', 1, 12, '9', 'Firewall Wizards', 1, ''),
(68, '2007-04-14 16:09:47', 1, 12, '10', 'Secunia Security Advisories List', 1, ''),
(69, '2007-04-14 16:29:55', 1, 12, '9', 'Firewall Wizards', 3, ''),
(70, '2007-05-03 20:00:40', 1, 12, '1', 'bugtraq', 2, 'Changed desc and desc long.'),
(71, '2007-05-03 20:03:16', 1, 12, '1', 'bugtraq', 2, 'Changed url.'),
(72, '2007-05-04 03:58:24', 1, 12, '1', 'bugtraq', 2, 'Changed email, email password and email server.'),
(73, '2007-05-04 03:58:49', 1, 12, '2', 'Full Disclosure', 2, 'Changed email, email password and email server.'),
(74, '2007-05-04 03:59:10', 1, 12, '6', 'Infosec News', 2, 'Changed email, email password and email server.'),
(75, '2007-05-04 03:59:20', 1, 12, '6', 'Infosec News', 2, 'Changed email server.'),
(76, '2007-05-04 03:59:46', 1, 12, '8', 'NTBugtraq', 2, 'Changed email, email password and email server.'),
(77, '2007-05-04 04:00:08', 1, 12, '4', 'php security', 2, 'Changed email, email password and email server.'),
(78, '2007-05-04 04:00:25', 1, 12, '10', 'Secunia Security Advisories List', 2, 'Changed email, email password and email server.'),
(79, '2007-05-04 04:03:52', 1, 12, '1', 'bugtraq2', 2, 'Changed name.'),
(80, '2007-05-04 04:04:01', 1, 12, '1', 'bugtraq', 2, 'Changed name.'),
(81, '2007-05-04 04:04:52', 1, 12, '7', 'Web App Security (securityfocus)', 2, 'Changed email, email password and email server.'),
(82, '2007-05-04 04:05:20', 1, 12, '5', 'Web Security (webappsec.org)', 2, 'Changed email, email password and email server.'),
(83, '2007-05-04 05:53:13', 1, 3, '1', 'jon', 2, 'Changed staff status, active, superuser status, sources for user profile "jon", alert methods for user profile "jon" and messages for user profile "jon".'),
(84, '2007-05-06 03:00:38', 1, 12, '5', 'Web Security (webappsec.org)', 2, 'Changed email.'),
(85, '2007-05-06 03:26:58', 1, 3, '2', 'test', 3, ''),
(86, '2007-05-06 03:27:32', 1, 3, '6', 'test1', 3, ''),
(87, '2007-05-06 04:09:04', 1, 3, '5', 'testt', 2, 'Added user criteria "disclosure". Changed staff status, active, superuser status, where heard for user profile "testt", criteria pref type for user profile "testt", sources for user profile "testt", alert methods for user profile "testt" and messages for user profile "testt".');

-- --------------------------------------------------------

-- 
-- Table structure for table `django_content_type`
-- 

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

-- 
-- Dumping data for table `django_content_type`
-- 

INSERT INTO `django_content_type` (`id`, `name`, `app_label`, `model`) VALUES 
(1, 'message', 'auth', 'message'),
(2, 'group', 'auth', 'group'),
(3, 'user', 'auth', 'user'),
(4, 'permission', 'auth', 'permission'),
(5, 'content type', 'contenttypes', 'contenttype'),
(6, 'session', 'sessions', 'session'),
(7, 'site', 'sites', 'site'),
(8, 'log entry', 'admin', 'logentry'),
(9, 'alert method', 'vulnalert', 'alertmethod'),
(10, 'criteria type', 'vulnalert', 'criteriatype'),
(11, 'user criteria', 'vulnalert', 'usercriteria'),
(12, 'source', 'vulnalert', 'source'),
(13, 'message type', 'vulnalert', 'messagetype'),
(14, 'message', 'vulnalert', 'message'),
(15, 'criteria qualifier', 'vulnalert', 'criteriaqualifier'),
(16, 'user profile', 'vulnalert', 'userprofile');

-- --------------------------------------------------------

-- 
-- Table structure for table `django_session`
-- 

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY  (`session_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `django_session`
-- 

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES 
('003e35553a2387994927e471a240d765', 'KGRwMQpTJ3Rlc3Rjb29raWUnCnAyClMnd29ya2VkJwpwMwpzUydfYXV0aF91c2VyX2lkJwpwNApM\nMUwKc1MnX2F1dGhfdXNlcl9iYWNrZW5kJwpwNQpTJ3Z1bG50cmFja2VyLmF1dGguYXV0aF9lbWFp\nbC5FbWFpbEJhY2tlbmQnCnA2CnMuMjZiNDM5MGIxYjk3MzA4MTU0MzdmMTVmOGJjMGYyMDU=\n', '2007-04-21 21:08:55'),
('023e0290062816d42ea2830dcf3cecce', 'KGRwMQpTJ19hdXRoX3VzZXJfYmFja2VuZCcKcDIKUyd2dWxudHJhY2tlci5hdXRoLmF1dGhfZW1h\naWwuRW1haWxCYWNrZW5kJwpwMwpzUydfYXV0aF91c2VyX2lkJwpwNApMMUwKcy44ZGRmM2ZlNzlj\nZDIwOWZkOGE5M2U1ZTg5MTAwMmY0Ng==\n', '2007-04-19 20:52:01'),
('056dc1414a09c42a90ef953a861c8254', 'KGRwMQpTJ3Rlc3Rjb29raWUnCnAyClMnd29ya2VkJwpwMwpzUydfYXV0aF91c2VyX2JhY2tlbmQn\nCnA0ClMndnVsbnRyYWNrZXIuYXV0aC5hdXRoX2VtYWlsLkVtYWlsQmFja2VuZCcKcDUKc1MnX2F1\ndGhfdXNlcl9pZCcKcDYKTDFMCnMuMGQ3NjVkMDlmMzE5ZDYxZDY0NDYwZjEwOWU4YmM0OTQ=\n', '2007-05-16 15:45:01'),
('137b435f147b2782c55697863edfd8d8', 'KGRwMQpTJ19hdXRoX3VzZXJfYmFja2VuZCcKcDIKUyd2dWxudHJhY2tlci5hdXRoLmF1dGhfZW1h\naWwuRW1haWxCYWNrZW5kJwpwMwpzUydfYXV0aF91c2VyX2lkJwpwNApMMUwKcy44ZGRmM2ZlNzlj\nZDIwOWZkOGE5M2U1ZTg5MTAwMmY0Ng==\n', '2007-05-18 05:54:07'),
('176cf7049bbc4eb58fe7babd91689d80', 'KGRwMQpTJ19hdXRoX3VzZXJfYmFja2VuZCcKcDIKUyd2dWxudHJhY2tlci5hdXRoLmF1dGhfZW1h\naWwuRW1haWxCYWNrZW5kJwpwMwpzUydfYXV0aF91c2VyX2lkJwpwNApMMUwKcy44ZGRmM2ZlNzlj\nZDIwOWZkOGE5M2U1ZTg5MTAwMmY0Ng==\n', '2007-04-24 17:58:55'),
('1b64ddcbf73f63f8d9602e2f96ddacb1', 'KGRwMQpTJ3Rlc3Rjb29raWUnCnAyClMnd29ya2VkJwpwMwpzLjFjNjMxNzZhZjA2OWQ0Mzg0ZjRk\nYzIzOTY2ZWZmNDc1\n', '2007-05-16 19:28:59'),
('2bb118669673304ae1fb9d1239977f14', 'KGRwMQpTJ19hdXRoX3VzZXJfYmFja2VuZCcKcDIKUyd2dWxudHJhY2tlci5hdXRoLmF1dGhfZW1h\naWwuRW1haWxCYWNrZW5kJwpwMwpzUydfYXV0aF91c2VyX2lkJwpwNApMMUwKcy44ZGRmM2ZlNzlj\nZDIwOWZkOGE5M2U1ZTg5MTAwMmY0Ng==\n', '2007-04-24 17:57:26'),
('2fa89c1d0ad6cba68cf9f07bb68c6f4d', 'KGRwMQpTJ3Rlc3Rjb29raWUnCnAyClMnd29ya2VkJwpwMwpzUydfYXV0aF91c2VyX2JhY2tlbmQn\nCnA0ClMndnVsbnRyYWNrZXIuYXV0aC5hdXRoX2VtYWlsLkVtYWlsQmFja2VuZCcKcDUKc1MnX2F1\ndGhfdXNlcl9pZCcKcDYKTDFMCnMuMGQ3NjVkMDlmMzE5ZDYxZDY0NDYwZjEwOWU4YmM0OTQ=\n', '2007-05-04 02:40:55'),
('3a21c07216f927363dc957be64516333', 'KGRwMQpTJ3Rlc3Rjb29raWUnCnAyClMnd29ya2VkJwpwMwpzUydfYXV0aF91c2VyX2JhY2tlbmQn\nCnA0ClMndnVsbnRyYWNrZXIuYXV0aC5hdXRoX2VtYWlsLkVtYWlsQmFja2VuZCcKcDUKc1MnX2F1\ndGhfdXNlcl9pZCcKcDYKTDFMCnMuMGQ3NjVkMDlmMzE5ZDYxZDY0NDYwZjEwOWU4YmM0OTQ=\n', '2007-05-19 00:30:14'),
('3faa99f1bba1e5cb95a725c27fe97896', 'KGRwMQpTJ3Rlc3Rjb29raWUnCnAyClMnd29ya2VkJwpwMwpzUydfYXV0aF91c2VyX2JhY2tlbmQn\nCnA0ClMndnVsbnRyYWNrZXIuYXV0aC5hdXRoX2VtYWlsLkVtYWlsQmFja2VuZCcKcDUKc1MnX2F1\ndGhfdXNlcl9pZCcKcDYKTDFMCnMuMGQ3NjVkMDlmMzE5ZDYxZDY0NDYwZjEwOWU4YmM0OTQ=\n', '2007-05-05 21:45:58'),
('462fe5be6252ceb24bcb2dd256c7a18b', 'KGRwMQpTJ3Rlc3Rjb29raWUnCnAyClMnd29ya2VkJwpwMwpzUydfYXV0aF91c2VyX2JhY2tlbmQn\nCnA0ClMndnVsbnRyYWNrZXIuYXV0aC5hdXRoX2VtYWlsLkVtYWlsQmFja2VuZCcKcDUKc1MnX2F1\ndGhfdXNlcl9pZCcKcDYKTDFMCnMuMGQ3NjVkMDlmMzE5ZDYxZDY0NDYwZjEwOWU4YmM0OTQ=\n', '2007-05-16 19:16:15'),
('5a4c0da6119a7eb81f3383a0b9154024', 'KGRwMQpTJ3Rlc3Rjb29raWUnCnAyClMnd29ya2VkJwpwMwpzUydfYXV0aF91c2VyX2JhY2tlbmQn\nCnA0ClMndnVsbnRyYWNrZXIuYXV0aC5hdXRoX2VtYWlsLkVtYWlsQmFja2VuZCcKcDUKc1MnX2F1\ndGhfdXNlcl9pZCcKcDYKTDFMCnMuMGQ3NjVkMDlmMzE5ZDYxZDY0NDYwZjEwOWU4YmM0OTQ=\n', '2007-05-07 18:39:41'),
('5ee6aee8a0739ee2c537a2a8b9ca761f', 'KGRwMQpTJ3Rlc3Rjb29raWUnCnAyClMnd29ya2VkJwpwMwpzUydfYXV0aF91c2VyX2lkJwpwNApM\nMUwKc1MnX2F1dGhfdXNlcl9iYWNrZW5kJwpwNQpTJ3Z1bG50cmFja2VyLmF1dGguYXV0aF9lbWFp\nbC5FbWFpbEJhY2tlbmQnCnA2CnMuMjZiNDM5MGIxYjk3MzA4MTU0MzdmMTVmOGJjMGYyMDU=\n', '2007-05-18 05:35:46'),
('7314510744d5317b3d86abd1a3dbe2ce', 'KGRwMQpTJ3Rlc3Rjb29raWUnCnAyClMnd29ya2VkJwpwMwpzLjFjNjMxNzZhZjA2OWQ0Mzg0ZjRk\nYzIzOTY2ZWZmNDc1\n', '2007-05-03 07:37:37'),
('82735e91bd3c368afdcc0def56b999e1', 'KGRwMQpTJ3Rlc3Rjb29raWUnCnAyClMnd29ya2VkJwpwMwpzUydfYXV0aF91c2VyX2JhY2tlbmQn\nCnA0ClMndnVsbnRyYWNrZXIuYXV0aC5hdXRoX2VtYWlsLkVtYWlsQmFja2VuZCcKcDUKc1MnX2F1\ndGhfdXNlcl9pZCcKcDYKTDFMCnMuMGQ3NjVkMDlmMzE5ZDYxZDY0NDYwZjEwOWU4YmM0OTQ=\n', '2007-05-05 16:07:59'),
('8b7912111bed60d18fd23605f79f7efd', 'KGRwMQpTJ19hdXRoX3VzZXJfYmFja2VuZCcKcDIKUyd2dWxudHJhY2tlci5hdXRoLmF1dGhfZW1h\naWwuRW1haWxCYWNrZW5kJwpwMwpzUydfYXV0aF91c2VyX2lkJwpwNApMMUwKcy44ZGRmM2ZlNzlj\nZDIwOWZkOGE5M2U1ZTg5MTAwMmY0Ng==\n', '2007-05-20 17:20:53'),
('8f83172b66d9256b017a42ffbcd96029', 'KGRwMQpTJ3Rlc3Rjb29raWUnCnAyClMnd29ya2VkJwpwMwpzUydfYXV0aF91c2VyX2lkJwpwNApM\nMUwKc1MnX2F1dGhfdXNlcl9iYWNrZW5kJwpwNQpTJ3Z1bG50cmFja2VyLmF1dGguYXV0aF9lbWFp\nbC5FbWFpbEJhY2tlbmQnCnA2CnMuMjZiNDM5MGIxYjk3MzA4MTU0MzdmMTVmOGJjMGYyMDU=\n', '2007-05-07 14:42:56'),
('974385a14446899566bfb9dd2926d88e', 'KGRwMQpTJ3Rlc3Rjb29raWUnCnAyClMnd29ya2VkJwpwMwpzUydfYXV0aF91c2VyX2JhY2tlbmQn\nCnA0ClMndnVsbnRyYWNrZXIuYXV0aC5hdXRoX2VtYWlsLkVtYWlsQmFja2VuZCcKcDUKc1MnX2F1\ndGhfdXNlcl9pZCcKcDYKTDFMCnMuMGQ3NjVkMDlmMzE5ZDYxZDY0NDYwZjEwOWU4YmM0OTQ=\n', '2007-05-16 15:33:55'),
('97e83781063c5b226fb8c6004c63172c', 'KGRwMQpTJ3Rlc3Rjb29raWUnCnAyClMnd29ya2VkJwpwMwpzUydfYXV0aF91c2VyX2JhY2tlbmQn\nCnA0ClMndnVsbnRyYWNrZXIuYXV0aC5hdXRoX2VtYWlsLkVtYWlsQmFja2VuZCcKcDUKc1MnX2F1\ndGhfdXNlcl9pZCcKcDYKTDFMCnMuMGQ3NjVkMDlmMzE5ZDYxZDY0NDYwZjEwOWU4YmM0OTQ=\n', '2007-05-16 15:50:19'),
('9b070aef0084c76446f7687eda28e3ce', 'KGRwMQpTJ3Rlc3Rjb29raWUnCnAyClMnd29ya2VkJwpwMwpzUydfYXV0aF91c2VyX2JhY2tlbmQn\nCnA0ClMndnVsbnRyYWNrZXIuYXV0aC5hdXRoX2VtYWlsLkVtYWlsQmFja2VuZCcKcDUKc1MnX2F1\ndGhfdXNlcl9pZCcKcDYKTDFMCnMuMGQ3NjVkMDlmMzE5ZDYxZDY0NDYwZjEwOWU4YmM0OTQ=\n', '2007-05-07 16:18:18'),
('9d9635f4878ffa91e1656b7e6184fa99', 'KGRwMQpTJ3Rlc3Rjb29raWUnCnAyClMnd29ya2VkJwpwMwpzUydfYXV0aF91c2VyX2JhY2tlbmQn\nCnA0ClMndnVsbnRyYWNrZXIuYXV0aC5hdXRoX2VtYWlsLkVtYWlsQmFja2VuZCcKcDUKc1MnX2F1\ndGhfdXNlcl9pZCcKcDYKTDFMCnMuMGQ3NjVkMDlmMzE5ZDYxZDY0NDYwZjEwOWU4YmM0OTQ=\n', '2007-05-05 16:12:06'),
('a2ea007807b4ec4abdfca93244a44cd2', 'KGRwMQpTJ19hdXRoX3VzZXJfYmFja2VuZCcKcDIKUyd2dWxudHJhY2tlci5hdXRoLmF1dGhfZW1h\naWwuRW1haWxCYWNrZW5kJwpwMwpzUydfYXV0aF91c2VyX2lkJwpwNApMMUwKcy44ZGRmM2ZlNzlj\nZDIwOWZkOGE5M2U1ZTg5MTAwMmY0Ng==\n', '2007-04-19 20:52:31'),
('ada35afd3c6d2399ee137473b1b81a17', 'KGRwMQpTJ3Rlc3Rjb29raWUnCnAyClMnd29ya2VkJwpwMwpzUydfYXV0aF91c2VyX2JhY2tlbmQn\nCnA0ClMndnVsbnRyYWNrZXIuYXV0aC5hdXRoX2VtYWlsLkVtYWlsQmFja2VuZCcKcDUKc1MnX2F1\ndGhfdXNlcl9pZCcKcDYKTDFMCnMuMGQ3NjVkMDlmMzE5ZDYxZDY0NDYwZjEwOWU4YmM0OTQ=\n', '2007-05-16 19:22:19'),
('af2e8ce713522ea020ecb60d6a06fd69', 'KGRwMQpTJ3Rlc3Rjb29raWUnCnAyClMnd29ya2VkJwpwMwpzUydfYXV0aF91c2VyX2JhY2tlbmQn\nCnA0ClMndnVsbnRyYWNrZXIuYXV0aC5hdXRoX2VtYWlsLkVtYWlsQmFja2VuZCcKcDUKc1MnX2F1\ndGhfdXNlcl9pZCcKcDYKTDFMCnMuMGQ3NjVkMDlmMzE5ZDYxZDY0NDYwZjEwOWU4YmM0OTQ=\n', '2007-05-07 18:39:12'),
('b4f3e17386d5ec15bac928ed6ff5b246', 'KGRwMQpTJ3Rlc3Rjb29raWUnCnAyClMnd29ya2VkJwpwMwpzUydfYXV0aF91c2VyX2JhY2tlbmQn\nCnA0ClMndnVsbnRyYWNrZXIuYXV0aC5hdXRoX2VtYWlsLkVtYWlsQmFja2VuZCcKcDUKc1MnX2F1\ndGhfdXNlcl9pZCcKcDYKTDVMCnMuYzU2Mjc3MzI3MGJmYzQ5YjI0ZmY1OGRiMWYwMTc0Mjc=\n', '2007-05-20 04:06:16'),
('c6e22c4195ec2b29344b70813c20abd8', 'KGRwMQpTJ19hdXRoX3VzZXJfYmFja2VuZCcKcDIKUyd2dWxudHJhY2tlci5hdXRoLmF1dGhfZW1h\naWwuRW1haWxCYWNrZW5kJwpwMwpzUydfYXV0aF91c2VyX2lkJwpwNApMMUwKcy44ZGRmM2ZlNzlj\nZDIwOWZkOGE5M2U1ZTg5MTAwMmY0Ng==\n', '2007-04-28 13:07:03'),
('c82ee18820987a9c149f132c19077b52', 'KGRwMQpTJ19hdXRoX3VzZXJfaWQnCnAyCkwxTApzUydfYXV0aF91c2VyX2JhY2tlbmQnCnAzClMn\ndnVsbnRyYWNrZXIuYXV0aC5hdXRoX2VtYWlsLkVtYWlsQmFja2VuZCcKcDQKcy4wYWU2M2E5MWUw\nOTI2NzgxOTE4MzdmYWI2MGRlOTlmMQ==\n', '2007-04-23 17:25:31'),
('cf2c96cde1d6f5c3b11555d57cfd3071', 'KGRwMQpTJ3Rlc3Rjb29raWUnCnAyClMnd29ya2VkJwpwMwpzUydfYXV0aF91c2VyX2JhY2tlbmQn\nCnA0ClMndnVsbnRyYWNrZXIuYXV0aC5hdXRoX2VtYWlsLkVtYWlsQmFja2VuZCcKcDUKc1MnX2F1\ndGhfdXNlcl9pZCcKcDYKTDFMCnMuMGQ3NjVkMDlmMzE5ZDYxZDY0NDYwZjEwOWU4YmM0OTQ=\n', '2007-05-02 08:18:09'),
('f0d1838de1c3af757407ba6380b0084d', 'KGRwMQpTJ3Rlc3Rjb29raWUnCnAyClMnd29ya2VkJwpwMwpzUydfYXV0aF91c2VyX2JhY2tlbmQn\nCnA0ClMndnVsbnRyYWNrZXIuYXV0aC5hdXRoX2VtYWlsLkVtYWlsQmFja2VuZCcKcDUKc1MnX2F1\ndGhfdXNlcl9pZCcKcDYKTDVMCnMuYzU2Mjc3MzI3MGJmYzQ5YjI0ZmY1OGRiMWYwMTc0Mjc=\n', '2007-05-20 13:26:52'),
('f73afa0c3ee59387bc01743ea903f1bb', 'KGRwMQpTJ3Rlc3Rjb29raWUnCnAyClMnd29ya2VkJwpwMwpzUydfYXV0aF91c2VyX2JhY2tlbmQn\nCnA0ClMndnVsbnRyYWNrZXIuYXV0aC5hdXRoX2VtYWlsLkVtYWlsQmFja2VuZCcKcDUKc1MnX2F1\ndGhfdXNlcl9pZCcKcDYKTDFMCnMuMGQ3NjVkMDlmMzE5ZDYxZDY0NDYwZjEwOWU4YmM0OTQ=\n', '2007-05-16 15:48:51'),
('ff9a483af29eb4a701eeb2b39f37cc7a', 'KGRwMQpTJ19hdXRoX3VzZXJfYmFja2VuZCcKcDIKUyd2dWxudHJhY2tlci5hdXRoLmF1dGhfZW1h\naWwuRW1haWxCYWNrZW5kJwpwMwpzUydfYXV0aF91c2VyX2lkJwpwNApMMUwKcy44ZGRmM2ZlNzlj\nZDIwOWZkOGE5M2U1ZTg5MTAwMmY0Ng==\n', '2007-04-28 17:22:07');

-- --------------------------------------------------------

-- 
-- Table structure for table `django_site`
-- 

CREATE TABLE `django_site` (
  `id` int(11) NOT NULL auto_increment,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- 
-- Dumping data for table `django_site`
-- 

INSERT INTO `django_site` (`id`, `domain`, `name`) VALUES 
(1, 'example.com', 'example.com');

-- 
-- Table structure for table `message`
-- 

CREATE TABLE `message` (
  `id` int(11) NOT NULL auto_increment,
  `text` longtext NOT NULL,
  `subject` varchar(250) NOT NULL,
  `body` longtext NOT NULL,
  `message_type_id` int(11) NOT NULL,
  `source_id` int(11) NOT NULL,
  `processed` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `subject` (`subject`),
  KEY `message_type_id` (`message_type_id`),
  KEY `source_id` (`source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=272 ;


-- --------------------------------------------------------

-- 
-- Table structure for table `message_type`
-- 

CREATE TABLE `message_type` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(25) NOT NULL,
  `desc` longtext NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- 
-- Dumping data for table `message_type`
-- 

INSERT INTO `message_type` (`id`, `name`, `desc`) VALUES 
(1, 'mail', 'mailing list emails');

-- --------------------------------------------------------

-- 
-- Table structure for table `qualifier`
-- 

CREATE TABLE `qualifier` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `desc` varchar(150) NOT NULL,
  `sql` varchar(150) NOT NULL,
  `rose` varchar(50) NOT NULL,
  `rose_sql` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

-- 
-- Dumping data for table `qualifier`
-- 

INSERT INTO `qualifier` (`id`, `name`, `desc`, `sql`, `rose`, `rose_sql`) VALUES 
(1, 'contains', 'contains', 'ILIKE "%s"', 'like', '%%s%'),
(2, 'equal to', 'equal', '= "%s"', 'eq', '%s'),
(3, 'starts_with', 'starts with', 'ILIKE "%s%"', 'like', '%s%'),
(4, 'ends_with', 'ends with', 'ILIKE "%%s"', 'like', '%%s'),
(5, 'not_start_with', 'does not start with', 'NOT LIKE "%s%"', 'like', '%s%'),
(6, 'not_contains', 'does not contain', 'NOT ILIKE "%s"', 'like', '"%%s%"'),
(7, 'not_equal', 'not equal to', '<> "%s"', 'ne', '%s'),
(8, 'regexp', 'regular expression', 'REGEXP "%s"', 'regexp', '%s');

-- --------------------------------------------------------

-- 
-- Table structure for table `source`
-- 

CREATE TABLE `source` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `url` varchar(100) NOT NULL,
  `desc` varchar(150) NOT NULL,
  `desc_long` longtext,
  `message_type_id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `email_password` varchar(50) NOT NULL,
  `email_server` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`,`message_type_id`),
  KEY `message_type_id` (`message_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

-- 
-- Dumping data for table `source`
-- 

INSERT INTO `source` (`id`, `name`, `url`, `desc`, `desc_long`, `message_type_id`, `email`, `email_password`, `email_server`) VALUES 
(1, 'bugtraq', 'http://www.securityfocus.com/archive/1/description', 'The premier general security mailing list. Vulnerabilities are often announced here first, so check frequently!', 'BugTraq is a full disclosure moderated mailing list for the *detailed* discussion and announcement of computer security vulnerabilities: what they are, how to exploit them, and how to fix them.', 1, 'bugtraq2@digitalslack.com', '$tr@ng3r', 'mail.digitalslack.com'),
(2, 'Full Disclosure', 'http://lists.grok.org.uk/full-disclosure-charter.html', 'An unmoderated high-traffic forum for disclosure of security information', 'An unmoderated high-traffic forum for disclosure of security information. Fresh vulnerabilities sometimes hit this list many hours before they pass through the Bugtraq moderation queue. The relaxed atmosphere of this quirky list provides some comic relief and certain industry gossip. Unfortunately 80% of the posts are worthless drivel, so finding the gems takes patience.', 1, 'fulldisclosure@slypheed.com', '$tr@ng3r', 'mail.slypheed.com'),
(3, 'VulnWatch', 'http://www.vulnwatch.org/', 'A non-discussion, non-patch, all-vulnerability annoucement list supported and run by a community of volunteer moderators distributed around the world.', 'A non-discussion, non-patch, all-vulnerability annoucement list supported and run by a community of volunteer moderators distributed around the world.', 1, 'vulnwatch@slypheed.com', '$tr@ng3r', 'mail.slypheed.com'),
(4, 'php security', 'http://www.phparch.com/phpsec/', '[phpsec] is a mailing list dedicated to the security of PHP and its related applications.', '[phpsec] is a mailing list dedicated to the security of PHP and its related applications. Our goal is to maintain an early-warning system through which developers, systems administrators and researches can discuss and exchange information about maintaining PHP, PHP applications and PHP systems secure.\r\n\r\n[phpsec] is a moderated mailing list. This allows us to keep the signal-to-noise ratio as high as possible. Messages that will reach the list include:\r\n\r\n    * Announcements of new security products relevant to PHP\r\n    * Reports of publicly-known security issues related to PHP or PHP applications\r\n    * Requests/discussions on PHP security (e.g.: setup, installation and maintenance)\r\n    * Requests/discussions on PHP security in application development\r\n\r\nExamples of messages that will not reach the list include:\r\n\r\n    * General PHP help problems\r\n    * PHP programming questions unrelated to security\r\n    * Reports of exploits or other security holes of which the appropriate maintainers have not yet been made aware\r\n    * Messages that are generally off-topic, commercial in nature, personal attacks, profanity and otherwise offensive material. These will be immediately moderated off the list.\r\n', 1, 'phpsecurity@slypheed.com', '$tr@ng3r', 'mail.slypheed.com'),
(5, 'Web Security (webappsec.org)', 'http://webappsec.org', 'The Web Security Mailing List is an open information forum for discussing topics relevant to web security.', 'What is The Web Security Mailing List?\r\nThe Web Security Mailing List is an open information forum for discussing topics relevant to web security. Topics include, but are not limited to, industry news and technical discussions surrounding web applications, proxies, honeypots, new attack types, methodologies, application firewalls, discoveries, experiences, web servers, application servers, database security, tools, solutions, and others.\r\n\r\nThe Web Security Mailing List is maintained by the Web Application Security Consortium (WASC)\r\nhttp://www.webappsec.org\r\n\r\nThe Web Application Security Consortium (WASC) is an international group of experts, industry practitioners, and organizational representatives who produce open source and widely agreed upon best-practice security standards for the World Wide Web.\r\n\r\nAs an active community, WASC facilitates the exchange ideas and organizes several industry projects. WASC consistently releases technical information, contributed articles, security guidelines, and other useful documentation. Businesses, educational institutions, governments, application developers, security professionals, and software vendors all over the world utilize our materials to assist with the challenges presented by web application security.', 1, 'webappsecorg2@slypheed.com', '$tr@ng3r', 'mail.slypheed.com'),
(6, 'Infosec News', 'http://www.infosecnews.org/', 'InfoSec News is a privately run, medium traffic list that caters to the distribution of information security news articles.', 'InfoSec News is a privately run, medium traffic list that caters to the distribution of information security news articles. These articles come from such sources as newspapers, magazines and online resources.\r\n\r\nSo that you may quickly and efficiently filter past the articles of no interest, the e-mail subject line will always contain the title of the article.\r\n\r\nThis list contains:\r\n\r\n    * Articles catering to such topics as security, hacking, firewalls, new security encryption, forensics, critical infrastructure protection, products, public hacks, hoaxes and legislation affecting these topics\r\n    * Information on where you can obtain articles in current magazines\r\n    * Security book reviews and information\r\n    * Security conference/seminar information\r\n    * New security product information\r\n    * And anything else that comes to mind...\r\n\r\nWe encourage feedback. The list maintainers like to hear what you think of the list. Let us know what we could improve and which parts are "right on." We also encourage subscribers to submit articles or URLs. If you submit an article, please send either the URL or follow this style guide. We also encourage subscribers to provide feedback on articles or stories that are posted to the list. Anonymous feedback is always welcome.', 1, 'infosecnews@slypheed.com', '$tr@ng3r', 'mail.slypheed.com'),
(7, 'Web App Security (securityfocus)', 'http://www.securityfocus.com/archive/107/description', 'Provides insights on the unique challenges which make web applications notoriously hard to secure.', 'Objective\r\nWhilst the webappsec list is an open and free discussion forum, in order to make the list fair and accessible to all while maintaining relevancy, we have developed this list charter. This charter sets out the lists operating rules for both posting and moderating.\r\n\r\nInformation about subscribing, unsubscribing and the archives can be found at the end of this charter.\r\n\r\nBackground\r\nThe Web Application Security mailing list hosted at securityfocus.com was founded in late 1999. It was originally named "www-mobile-code" and renamed to "webappsec" in 2001 to reflect the real intent and scope. The list is moderated by David Ahmad (david_ahmad@symantec.com).\r\n\r\nWhat is appropriate content?\r\nThe list is an open discussion forum for most things related to web application security. Appropriate posts would fall into the following three main categories:\r\n\r\nNews\r\nSpecific news stories about web application security technology, standards, issues, architectures or related topics.\r\n\r\nTechnical Discussions\r\nTechnical discussions abut specific areas of web application security. These may include design, development, deployment, testing or management.\r\n\r\nAnnouncements\r\nWhitepapers that deal with web application security or closely related topics maybe posted. Papers that require a user to register before downloading or receiving the paper must NOT be posted and will be rejected.\r\n\r\n', 1, 'webappsecsf@slypheed.com', '$tr@ng3r', 'mail.slypheed.com'),
(8, 'NTBugtraq', 'http://www.cert.org/other_sources/usenet.html', 'NTBugtraq is a mailing list for the discussion of security exploits and security bugs in Windows and related software.', 'What is the NTBugtraq Charter?\r\nIn the tradition of what was originally Aleph One''s Bugtraq mailing list, this list has been created to invite the free and open discussion of Windows Operating Systems Security Exploits/Security Bugs or *SEBs* as I call them. This list is not intended to be a forum to discuss "how to" issues, but instead should be used to report reproducible SEBs which you have personally encountered with a Windows OS or any product that runs on a Windows OS.\r\n\r\nWhat is a Security Exploit or Security Bug?\r\nAnything that can be done to a Windows OS installation via a remote connection (network or RAS) or through the local installation of software which causes the Windows OS to react in anything but an expected fashion. So telnet to TCP port 135 and typing 15 characters thereby causing the CPU to go to 100% utilization would be an acceptable topic. Sitting at a console logged in as Administrator and removing the Administrator''s file permissions on the %systemroot%\\system32 directory would not be considered an acceptable topic.\r\n\r\n[ From the List Charter at http://www.ntbugtraq.com/default.aspx?pid=31&sid=1 ]', 1, 'ntbugtraq@slypheed.com', '$tr@ng3r', 'mail.slypheed.com'),
(10, 'Secunia Security Advisories List', 'http://secunia.com/secunia_security_advisories/', 'The Secunia Security Advisories list is a high volume list which covers all the latest security vulnerabilities and security updates. ', 'The Secunia Security Advisories list is a high volume list with an average of 10 messages a day. The list covers all the latest security vulnerabilities and security updates.\r\n', 1, 'secuniaadvisories@slypheed.com', '$tr@ng3r', 'mail.slypheed.com');

-- --------------------------------------------------------

-- 
-- Table structure for table `user_alert_methods`
-- 

CREATE TABLE `user_alert_methods` (
  `id` int(11) NOT NULL auto_increment,
  `userprofile_id` int(11) NOT NULL,
  `alertmethod_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `userprofile_id` (`userprofile_id`,`alertmethod_id`),
  KEY `userprofile_id_2` (`userprofile_id`),
  KEY `alertmethod_id` (`alertmethod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=228 ;

-- 
-- Dumping data for table `user_alert_methods`
-- 

INSERT INTO `user_alert_methods` (`id`, `userprofile_id`, `alertmethod_id`) VALUES 
(227, 1, 1),
(226, 1, 2),
(215, 3, 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `user_criteria`
-- 

CREATE TABLE `user_criteria` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `criteria_type_id` int(11) NOT NULL,
  `qualifier_id` int(11) NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `user_id` (`user_id`),
  KEY `criteria_type_id` (`criteria_type_id`),
  KEY `qualifier_id` (`qualifier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

-- 
-- Dumping data for table `user_criteria`
-- 

INSERT INTO `user_criteria` (`id`, `user_id`, `criteria_type_id`, `qualifier_id`, `value`) VALUES 
(12, 1, 3, 1, 'php'),
(13, 1, 3, 1, 'disclosure');

-- --------------------------------------------------------

-- 
-- Table structure for table `user_messages`
-- 

CREATE TABLE `user_messages` (
  `id` int(11) NOT NULL auto_increment,
  `userprofile_id` int(11) NOT NULL,
  `message_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `userprofile_id` (`userprofile_id`,`message_id`),
  KEY `userprofile_id_2` (`userprofile_id`),
  KEY `message_id` (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=43 ;

-- 
-- Dumping data for table `user_messages`
-- 

INSERT INTO `user_messages` (`id`, `userprofile_id`, `message_id`) VALUES 
(16, 1, 1),
(1, 1, 5),
(17, 1, 6),
(18, 1, 7),
(2, 1, 9),
(19, 1, 12),
(20, 1, 13),
(21, 1, 20),
(3, 1, 22),
(22, 1, 28),
(4, 1, 44),
(23, 1, 45),
(24, 1, 48),
(25, 1, 49),
(26, 1, 94),
(27, 1, 96),
(28, 1, 110),
(5, 1, 121),
(6, 1, 127),
(7, 1, 130),
(8, 1, 132),
(9, 1, 133),
(29, 1, 143),
(10, 1, 156),
(30, 1, 163),
(31, 1, 164),
(11, 1, 179),
(32, 1, 183),
(33, 1, 184),
(34, 1, 185),
(35, 1, 187),
(14, 1, 199),
(12, 1, 227),
(13, 1, 229),
(36, 1, 235),
(37, 1, 236),
(38, 1, 237),
(39, 1, 238),
(40, 1, 239),
(41, 1, 240),
(42, 1, 241),
(15, 1, 267);

-- --------------------------------------------------------

-- 
-- Table structure for table `user_profile`
-- 

CREATE TABLE `user_profile` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `where_heard` varchar(250) NOT NULL,
  `criteria_pref_type` varchar(50) NOT NULL default 'simple',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `user_profile_user_id` (`user_id`),
  KEY `user_id_2` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

-- 
-- Dumping data for table `user_profile`
-- 

INSERT INTO `user_profile` (`id`, `user_id`, `where_heard`, `criteria_pref_type`) VALUES 
(1, 1, 'nowhere', 'simple'),
(2, 4, '', ''),
(3, 5, 'nowhere', 'simple');

-- --------------------------------------------------------

-- 
-- Table structure for table `user_sources`
-- 

CREATE TABLE `user_sources` (
  `id` int(11) NOT NULL auto_increment,
  `userprofile_id` int(11) NOT NULL,
  `source_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `userprofile_id` (`userprofile_id`,`source_id`),
  KEY `userprofile_id_2` (`userprofile_id`),
  KEY `source_id` (`source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=557 ;

-- 
-- Dumping data for table `user_sources`
-- 

INSERT INTO `user_sources` (`id`, `userprofile_id`, `source_id`) VALUES 
(548, 1, 1),
(549, 1, 2),
(554, 1, 3),
(552, 1, 4),
(556, 1, 5),
(550, 1, 6),
(555, 1, 7),
(551, 1, 8),
(553, 1, 10),
(497, 3, 1),
(498, 3, 2),
(503, 3, 3),
(501, 3, 4),
(505, 3, 5),
(499, 3, 6),
(504, 3, 7),
(500, 3, 8),
(502, 3, 10);

-- 
-- Constraints for dumped tables
-- 

-- 
-- Constraints for table `advisory`
-- 
ALTER TABLE `advisory`
  ADD CONSTRAINT `advisory_ibfk_1` FOREIGN KEY (`message_id`) REFERENCES `message` (`id`),
  ADD CONSTRAINT `advisory_ibfk_2` FOREIGN KEY (`app_id`) REFERENCES `app` (`id`);

-- 
-- Constraints for table `app_version`
-- 
ALTER TABLE `app_version`
  ADD CONSTRAINT `app_version_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `app` (`id`);

-- 
-- Constraints for table `auth_permission`
-- 
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `content_type_id_refs_id_728de91f` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

-- 
-- Constraints for table `message`
-- 
ALTER TABLE `message`
  ADD CONSTRAINT `message_ibfk_1` FOREIGN KEY (`message_type_id`) REFERENCES `message_type` (`id`),
  ADD CONSTRAINT `message_ibfk_2` FOREIGN KEY (`source_id`) REFERENCES `source` (`id`);

-- 
-- Constraints for table `source`
-- 
ALTER TABLE `source`
  ADD CONSTRAINT `source_ibfk_1` FOREIGN KEY (`message_type_id`) REFERENCES `message_type` (`id`);

-- 
-- Constraints for table `user_alert_methods`
-- 
ALTER TABLE `user_alert_methods`
  ADD CONSTRAINT `user_alert_methods_ibfk_1` FOREIGN KEY (`userprofile_id`) REFERENCES `user_profile` (`id`),
  ADD CONSTRAINT `user_alert_methods_ibfk_2` FOREIGN KEY (`alertmethod_id`) REFERENCES `alert_method` (`id`);

-- 
-- Constraints for table `user_criteria`
-- 
ALTER TABLE `user_criteria`
  ADD CONSTRAINT `user_criteria_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `user_criteria_ibfk_2` FOREIGN KEY (`criteria_type_id`) REFERENCES `criteria_type` (`id`),
  ADD CONSTRAINT `user_criteria_ibfk_3` FOREIGN KEY (`qualifier_id`) REFERENCES `qualifier` (`id`);

-- 
-- Constraints for table `user_messages`
-- 
ALTER TABLE `user_messages`
  ADD CONSTRAINT `user_messages_ibfk_1` FOREIGN KEY (`userprofile_id`) REFERENCES `user_profile` (`id`),
  ADD CONSTRAINT `user_messages_ibfk_2` FOREIGN KEY (`message_id`) REFERENCES `message` (`id`);

-- 
-- Constraints for table `user_profile`
-- 
ALTER TABLE `user_profile`
  ADD CONSTRAINT `user_profile_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

-- 
-- Constraints for table `user_sources`
-- 
ALTER TABLE `user_sources`
  ADD CONSTRAINT `user_sources_ibfk_1` FOREIGN KEY (`userprofile_id`) REFERENCES `user_profile` (`id`),
  ADD CONSTRAINT `user_sources_ibfk_2` FOREIGN KEY (`source_id`) REFERENCES `source` (`id`);

