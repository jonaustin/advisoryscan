package VulnDB::RDBO::MessageType;

use strict;

use base qw(VulnDB::RDBO);

__PACKAGE__->meta->setup(
    table   => 'message_type',

    columns => [
        id   => { type => 'integer', not_null => 1 },
        name => { type => 'varchar', default => '', length => 25, not_null => 1 },
        desc => { type => 'scalar', default => '', length => 4294967295, not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    unique_key => [ 'name' ],

    relationships => [
        message => {
            class      => 'VulnDB::RDBO::Message',
            column_map => { id => 'message_type_id' },
            type       => 'one to many',
        },

        source => {
            class      => 'VulnDB::RDBO::Source',
            column_map => { id => 'message_type_id' },
            type       => 'one to many',
        },
    ],
);

1;
