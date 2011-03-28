package VulnDB::RDBO::UserAlertMethod;

use strict;

use base qw(VulnDB::RDBO);

__PACKAGE__->meta->setup(
    table   => 'user_alert_methods',

    columns => [
        id             => { type => 'integer', not_null => 1 },
        userprofile_id => { type => 'integer', default => '', not_null => 1 },
        alertmethod_id => { type => 'integer', default => '', not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    unique_key => [ 'userprofile_id', 'alertmethod_id' ],

    foreign_keys => [
        alertmethod => {
            class       => 'VulnDB::RDBO::AlertMethod',
            key_columns => { alertmethod_id => 'id' },
        },

        userprofile => {
            class       => 'VulnDB::RDBO::UserProfile',
            key_columns => { userprofile_id => 'id' },
        },
    ],
);

1;
