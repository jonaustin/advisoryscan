package VulnDB::RDBO::AppVersion;

use strict;

use base qw(VulnDB::RDBO);

__PACKAGE__->meta->setup(
    table   => 'app_version',

    columns => [
        id      => { type => 'integer', not_null => 1 },
        app_id  => { type => 'integer', default => '', not_null => 1 },
        version => { type => 'varchar', default => '', length => 50, not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    foreign_keys => [
        app => {
            class       => 'VulnDB::RDBO::App',
            key_columns => { app_id => 'id' },
        },
    ],
);

1;
