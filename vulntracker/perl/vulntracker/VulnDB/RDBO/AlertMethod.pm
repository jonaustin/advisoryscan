package VulnDB::RDBO::AlertMethod;

use strict;

use base qw(VulnDB::RDBO);

__PACKAGE__->meta->setup(
    table   => 'alert_method',

    columns => [
        id        => { type => 'integer', not_null => 1 },
        name      => { type => 'varchar', default => '', length => 50, not_null => 1 },
        desc      => { type => 'varchar', default => '', length => 100, not_null => 1 },
        desc_long => { type => 'scalar', default => '', length => 4294967295, not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    unique_key => [ 'name' ],

    relationships => [
        userprofiles => {
            column_map    => { alertmethod_id => 'id' },
            foreign_class => 'VulnDB::RDBO::UserProfile',
            map_class     => 'VulnDB::RDBO::UserAlertMethod',
            map_from      => 'alertmethod',
            map_to        => 'userprofile',
            type          => 'many to many',
        },
    ],
);

1;
