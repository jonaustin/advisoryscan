package VulnDB::RDBO::UserCriteria;

use strict;

use base qw(VulnDB::RDBO);

__PACKAGE__->meta->setup(
    table   => 'user_criteria',

    columns => [
        id               => { type => 'integer', not_null => 1 },
        user_id          => { type => 'integer', default => '', not_null => 1 },
        criteria_type_id => { type => 'integer', default => '', not_null => 1 },
        qualifier_id     => { type => 'integer', default => '', not_null => 1 },
        value            => { type => 'varchar', default => '', length => 50, not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    foreign_keys => [
        criteria_type => {
            class       => 'VulnDB::RDBO::CriteriaType',
            key_columns => { criteria_type_id => 'id' },
        },

        qualifier => {
            class       => 'VulnDB::RDBO::Qualifier',
            key_columns => { qualifier_id => 'id' },
        },

        user => {
            class       => 'VulnDB::RDBO::AuthUser',
            key_columns => { user_id => 'id' },
        },
    ],
);

1;
