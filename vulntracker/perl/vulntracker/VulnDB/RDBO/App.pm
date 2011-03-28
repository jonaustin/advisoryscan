package VulnDB::RDBO::App;

use strict;

use base qw(VulnDB::RDBO);

__PACKAGE__->meta->setup(
    table   => 'app',

    columns => [
        id   => { type => 'integer', not_null => 1 },
        name => { type => 'varchar', default => '', length => 150, not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    unique_key => [ 'name' ],

    relationships => [
        advisory => {
            class      => 'VulnDB::RDBO::Advisory',
            column_map => { id => 'app_id' },
            type       => 'one to many',
        },

        app_version => {
            class      => 'VulnDB::RDBO::AppVersion',
            column_map => { id => 'app_id' },
            type       => 'one to many',
        },
    ],
);

1;
