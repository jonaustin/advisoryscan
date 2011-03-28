package VulnDB::RDBO::AuthUser;

use strict;

use base qw(VulnDB::RDBO);

__PACKAGE__->meta->setup(
    table   => 'auth_user',

    columns => [
        id           => { type => 'integer', not_null => 1 },
        username     => { type => 'varchar', default => '', length => 30, not_null => 1 },
        first_name   => { type => 'varchar', default => '', length => 30, not_null => 1 },
        last_name    => { type => 'varchar', default => '', length => 30, not_null => 1 },
        email        => { type => 'varchar', default => '', length => 75, not_null => 1 },
        password     => { type => 'varchar', default => '', length => 128, not_null => 1 },
        is_staff     => { type => 'integer', default => '', not_null => 1 },
        is_active    => { type => 'integer', default => '', not_null => 1 },
        is_superuser => { type => 'integer', default => '', not_null => 1 },
        last_login   => { type => 'datetime', default => '', not_null => 1 },
        date_joined  => { type => 'datetime', default => '', not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    unique_key => [ 'username' ],

    relationships => [
        user_criteria => {
            class      => 'VulnDB::RDBO::UserCriteria',
            column_map => { id => 'user_id' },
            type       => 'one to many',
        },

        user_profile => {
            class      => 'VulnDB::RDBO::UserProfile',
            column_map => { id => 'user_id' },
            type       => 'one to one',
        },
    ],
);

1;
