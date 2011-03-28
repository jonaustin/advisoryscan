package VulnDB::RDBO::Qualifier;

use strict;

use base qw(VulnDB::RDBO);

__PACKAGE__->meta->setup(
    table   => 'qualifier',

    columns => [
        id       => { type => 'integer', not_null => 1 },
        name     => { type => 'varchar', default => '', length => 50, not_null => 1 },
        desc     => { type => 'varchar', length => 150 },
        sql      => { type => 'varchar', default => '', length => 150, not_null => 1 },
        rose     => { type => 'varchar', default => '', length => 50, not_null => 1 },
        rose_sql => { type => 'varchar', default => '', length => 50, not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    relationships => [
        user_criteria => {
            class      => 'VulnDB::RDBO::UserCriteria',
            column_map => { id => 'qualifier_id' },
            type       => 'one to many',
        },
    ],
);

1;
