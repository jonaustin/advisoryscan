package VulnDB::RDBO::UserProfile;

use strict;

use base qw(VulnDB::RDBO);

__PACKAGE__->meta->setup(
    table   => 'user_profile',

    columns => [
        id                 => { type => 'integer', not_null => 1 },
        user_id            => { type => 'integer', default => '', not_null => 1 },
        where_heard        => { type => 'varchar', default => '', length => 250, not_null => 1 },
        criteria_pref_type => { type => 'varchar', default => 'simple', length => 50, not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    unique_key => [ 'user_id' ],

    foreign_keys => [
        user => {
            class       => 'VulnDB::RDBO::AuthUser',
            key_columns => { user_id => 'id' },
            rel_type    => 'one to one',
        },
    ],

    relationships => [
        alertmethods => {
            column_map    => { userprofile_id => 'id' },
            foreign_class => 'VulnDB::RDBO::AlertMethod',
            map_class     => 'VulnDB::RDBO::UserAlertMethod',
            map_from      => 'userprofile',
            map_to        => 'alertmethod',
            type          => 'many to many',
        },

        messages => {
            column_map    => { userprofile_id => 'id' },
            foreign_class => 'VulnDB::RDBO::Message',
            map_class     => 'VulnDB::RDBO::UserMessage',
            map_from      => 'userprofile',
            map_to        => 'message',
            type          => 'many to many',
        },

        sources => {
            column_map    => { userprofile_id => 'id' },
            foreign_class => 'VulnDB::RDBO::Source',
            map_class     => 'VulnDB::RDBO::UserSource',
            map_from      => 'userprofile',
            map_to        => 'source',
            type          => 'many to many',
        },
    ],
);

1;
