package VulnDB::RDBO::UserMessage;

use strict;

use base qw(VulnDB::RDBO);

__PACKAGE__->meta->setup(
    table   => 'user_messages',

    columns => [
        id             => { type => 'integer', not_null => 1 },
        userprofile_id => { type => 'integer', default => '', not_null => 1 },
        message_id     => { type => 'integer', default => '', not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    unique_key => [ 'userprofile_id', 'message_id' ],

    foreign_keys => [
        message => {
            class       => 'VulnDB::RDBO::Message',
            key_columns => { message_id => 'id' },
        },

        userprofile => {
            class       => 'VulnDB::RDBO::UserProfile',
            key_columns => { userprofile_id => 'id' },
        },
    ],
);

1;
