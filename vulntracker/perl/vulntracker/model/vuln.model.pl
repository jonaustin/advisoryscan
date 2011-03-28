#!/usr/bin/perl
use strict;
use warnings;

BEGIN {
  package VulnDB::RDBO; $INC{"VulnDB/RDBO.pm"} = __FILE__;
  use base qw(Rose::DB::Object);
  sub init_db { shift; VulnDB::RDB->new }
  }

  BEGIN {
  package VulnDB::RDB; $INC{"VulnDB/RDB.pm"} = __FILE__;
  use base qw(Rose::DB);

  our $FILENAME = __FILE__ . ".sqlite";

  __PACKAGE__->register_db
    (driver => 'mysql',
     database => 'vulntracker_test',
     'host' => 'localhost',
     'username' => 'root',
     'password' => '1984',
    );
  unless (0 and -f $FILENAME) {
    __PACKAGE__->initialize_database;
  }

  sub initialize_database {
    my $class = shift;
    my $db = $class->new;
    die unless $db->driver eq "mysql";
    unlink $db->database;
    my $dbh = $db->dbh;
    $dbh->{RaiseError} = 0;
    $dbh->{PrintError} = 0;
    $dbh->do($_) or die "$DBI::errstr
      for $_" for split /\n{2,}/, <<'END_OF_SQL';

CREATE TABLE `message_type` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(25) NOT NULL,
  `desc` longtext NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


CREATE TABLE `source` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `email_password` varchar(50) NOT NULL,
  `email_server` varchar(50) NOT NULL,
  `url` varchar(100) NOT NULL,
  `desc` varchar(150) NOT NULL,
  `desc_long` longtext NOT NULL,
  `message_type_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`,`message_type_id`),
  INDEX (`message_type_id`),
  FOREIGN KEY (`message_type_id`) REFERENCES `message_type`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


CREATE TABLE `message` (
  `id` int(11) NOT NULL auto_increment,
  `text` longtext NOT NULL,
  `subject` varchar(250) NOT NULL,
  `body` longtext NOT NULL,
  `message_type_id` int(11) NOT NULL,
  `source_id` int(11) NOT NULL,
  `is_processed` tinyint(1) NOT NULL,
  `is_mailed` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id`),
  INDEX (`subject`),
  INDEX (`message_type_id`),
  FOREIGN KEY (`message_type_id`) REFERENCES `message_type`(`id`),
  INDEX (`source_id`),
  FOREIGN KEY (`source_id`) REFERENCES `source`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
 

CREATE TABLE `app` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `app_version`
-- 

CREATE TABLE `app_version` (
  `id` int(11) NOT NULL auto_increment,
  `app_id` int(11) NOT NULL,
  `version` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`),
  INDEX (`app_id`),
  FOREIGN KEY (`app_id`) REFERENCES `app`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
  INDEX (`message_id`),
  FOREIGN KEY (`message_id`) REFERENCES `message`(`id`),
  INDEX (`app_id`),
  FOREIGN KEY (`app_id`) REFERENCES `app`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


-- --------------------------------------------------------
-- 
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;



CREATE TABLE `qualifier` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `desc` varchar(150) NULL,
  `sql` varchar(150) NOT NULL,
  `rose` varchar(50) NOT NULL,
  `rose_sql` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


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
  INDEX (`user_id`),
  FOREIGN KEY (`user_id`) REFERENCES `auth_user`(`id`),
  INDEX (`criteria_type_id`),
  FOREIGN KEY (`criteria_type_id`) REFERENCES `criteria_type`(`id`),
  INDEX (`qualifier_id`),
  FOREIGN KEY (`qualifier_id`) REFERENCES `qualifier`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- Table structure for table `alert_method`
-- 

CREATE TABLE `alert_method` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `desc` varchar(100) NOT NULL,
  `desc_long` longtext NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
  INDEX (`user_id`),
  FOREIGN KEY (`user_id`) REFERENCES `auth_user`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

CREATE TABLE `user_messages` (
  `id` int(11) NOT NULL auto_increment,
  `userprofile_id` int(11) NOT NULL,
  `message_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `userprofile_id` (`userprofile_id`,`message_id`),
  INDEX (`userprofile_id`),
  FOREIGN KEY (`userprofile_id`) REFERENCES `user_profile`(`id`),
  INDEX (`message_id`),
  FOREIGN KEY (`message_id`) REFERENCES `message`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


-- 
-- Table structure for table `user_sources`
-- 

CREATE TABLE `user_sources` (
  `id` int(11) NOT NULL auto_increment,
  `userprofile_id` int(11) NOT NULL,
  `source_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `userprofile_id` (`userprofile_id`,`source_id`),
  INDEX (`userprofile_id`),
  FOREIGN KEY (`userprofile_id`) REFERENCES `user_profile`(`id`),
  INDEX (`source_id`),
  FOREIGN KEY (`source_id`) REFERENCES `source`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
  INDEX (`userprofile_id`),
  FOREIGN KEY (`userprofile_id`) REFERENCES `user_profile`(`id`),
  INDEX (`alertmethod_id`),
  FOREIGN KEY (`alertmethod_id`) REFERENCES `alert_method`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


-- --------------------------------------------------------


END_OF_SQL
  }

  if ("use loader") {
    require Rose::DB::Object::Loader;
    my $loader = Rose::DB::Object::Loader->new
      (db_class => __PACKAGE__,
       base_class => 'VulnDB::RDBO',
       class_prefix => 'VulnDB::RDBO',
      );
    my @classes = $loader->make_classes;

    if ("show resulting classes") {
      foreach my $class (@classes) {
        print "#" x 70, "\n";
        if ($class->isa('Rose::DB::Object')) {
          print $class->meta->perl_class_definition;
        } else {                # Rose::DB::Object::Manager subclasses
          print $class->perl_class_definition, "\n";
        }
      }
    }
  }
}
