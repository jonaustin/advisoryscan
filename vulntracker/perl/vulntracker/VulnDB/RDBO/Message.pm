package VulnDB::RDBO::Message;

use strict;

use base qw(VulnDB::RDBO);

__PACKAGE__->meta->setup(
    table   => 'message',

    columns => [
        id              => { type => 'integer', not_null => 1 },
        text            => { type => 'scalar', default => '', length => 4294967295, not_null => 1 },
        subject         => { type => 'varchar', default => '', length => 250, not_null => 1 },
        body            => { type => 'scalar', default => '', length => 4294967295, not_null => 1 },
        message_type_id => { type => 'integer', default => '', not_null => 1 },
        source_id       => { type => 'integer', default => '', not_null => 1 },
        is_processed    => { type => 'integer', default => '', not_null => 1 },
        is_mailed       => { type => 'integer', default => '', not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    foreign_keys => [
        message_type => {
            class       => 'VulnDB::RDBO::MessageType',
            key_columns => { message_type_id => 'id' },
        },

        source => {
            class       => 'VulnDB::RDBO::Source',
            key_columns => { source_id => 'id' },
        },
    ],

    relationships => [
        advisory => {
            class      => 'VulnDB::RDBO::Advisory',
            column_map => { id => 'message_id' },
            type       => 'one to many',
        },

        userprofiles => {
            column_map    => { message_id => 'id' },
            foreign_class => 'VulnDB::RDBO::UserProfile',
            map_class     => 'VulnDB::RDBO::UserMessage',
            map_from      => 'message',
            map_to        => 'userprofile',
            type          => 'many to many',
        },
    ],
);

1;
