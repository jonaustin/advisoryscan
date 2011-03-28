package VulnDB::RDBO::Advisory;

use strict;

use base qw(VulnDB::RDBO);

__PACKAGE__->meta->setup(
    table   => 'advisory',

    columns => [
        id         => { type => 'integer', not_null => 1 },
        message_id => { type => 'integer', default => '', not_null => 1 },
        app_id     => { type => 'integer', default => '', not_null => 1 },
        version    => { type => 'varchar', default => '', length => 25, not_null => 1 },
        text       => { type => 'scalar', default => '', length => 4294967295, not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    foreign_keys => [
        app => {
            class       => 'VulnDB::RDBO::App',
            key_columns => { app_id => 'id' },
        },

        message => {
            class       => 'VulnDB::RDBO::Message',
            key_columns => { message_id => 'id' },
        },
    ],
);

1;
