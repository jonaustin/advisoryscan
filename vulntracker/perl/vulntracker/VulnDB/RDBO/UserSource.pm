package VulnDB::RDBO::UserSource;

use strict;

use base qw(VulnDB::RDBO);

__PACKAGE__->meta->setup(
    table   => 'user_sources',

    columns => [
        id             => { type => 'integer', not_null => 1 },
        userprofile_id => { type => 'integer', default => '', not_null => 1 },
        source_id      => { type => 'integer', default => '', not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    unique_key => [ 'userprofile_id', 'source_id' ],

    foreign_keys => [
        source => {
            class       => 'VulnDB::RDBO::Source',
            key_columns => { source_id => 'id' },
        },

        userprofile => {
            class       => 'VulnDB::RDBO::UserProfile',
            key_columns => { userprofile_id => 'id' },
        },
    ],
);

1;
