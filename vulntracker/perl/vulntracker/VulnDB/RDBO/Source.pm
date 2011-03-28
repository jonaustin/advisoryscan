package VulnDB::RDBO::Source;

use strict;

use base qw(VulnDB::RDBO);

__PACKAGE__->meta->setup(
    table   => 'source',

    columns => [
        id              => { type => 'integer', not_null => 1 },
        name            => { type => 'varchar', default => '', length => 50, not_null => 1 },
        email           => { type => 'varchar', default => '', length => 50, not_null => 1 },
        email_password  => { type => 'varchar', default => '', length => 50, not_null => 1 },
        email_server    => { type => 'varchar', default => '', length => 50, not_null => 1 },
        url             => { type => 'varchar', default => '', length => 100, not_null => 1 },
        desc            => { type => 'varchar', default => '', length => 150, not_null => 1 },
        desc_long       => { type => 'scalar', default => '', length => 4294967295, not_null => 1 },
        message_type_id => { type => 'integer', default => '', not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    unique_key => [ 'name', 'message_type_id' ],

    foreign_keys => [
        message_type => {
            class       => 'VulnDB::RDBO::MessageType',
            key_columns => { message_type_id => 'id' },
        },
    ],

    relationships => [
        message => {
            class      => 'VulnDB::RDBO::Message',
            column_map => { id => 'source_id' },
            type       => 'one to many',
        },

        userprofiles => {
            column_map    => { source_id => 'id' },
            foreign_class => 'VulnDB::RDBO::UserProfile',
            map_class     => 'VulnDB::RDBO::UserSource',
            map_from      => 'source',
            map_to        => 'userprofile',
            type          => 'many to many',
        },
    ],
);

1;
