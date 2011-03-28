package VulnDB::RDBO::CriteriaType;

use strict;

use base qw(VulnDB::RDBO);

__PACKAGE__->meta->setup(
    table   => 'criteria_type',

    columns => [
        id                 => { type => 'integer', not_null => 1 },
        name               => { type => 'varchar', default => '', length => 50, not_null => 1 },
        search_field       => { type => 'varchar', default => '', length => 100, not_null => 1 },
        desc               => { type => 'scalar', default => '', length => 4294967295, not_null => 1 },
        input_type         => { type => 'varchar', default => '', length => 50, not_null => 1 },
        criteria_pref_type => { type => 'varchar', default => 'advanced', length => 50, not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    unique_key => [ 'name' ],

    relationships => [
        user_criteria => {
            class      => 'VulnDB::RDBO::UserCriteria',
            column_map => { id => 'criteria_type_id' },
            type       => 'one to many',
        },
    ],
);

1;
