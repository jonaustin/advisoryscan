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

-- --------------------------------------------------------
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


