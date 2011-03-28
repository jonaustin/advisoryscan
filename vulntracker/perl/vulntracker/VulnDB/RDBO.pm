#!/usr/bin/perl
use strict;
use warnings;

package VulnDB::RDBO;
use base qw(Rose::DB::Object);
use VulnDB::RDB;

sub init_db { shift; VulnDB::RDB->new }

1;
