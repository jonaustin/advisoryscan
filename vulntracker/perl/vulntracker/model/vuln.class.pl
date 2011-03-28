######################################################################
package VulnDB::RDBO::Advisory;

use strict;

use base qw(VulnDB::RDBO);

__PACKAGE__->meta->setup(
    table   => 'advisory',

    columns => [
        id         => { type => 'integer', not_null => 1 },
        message_id => { type => 'integer', default => '', not_null => 1 },
        app_id     => { type => 'integer', default => '', not_null => 1 },
        version    => { type => 'varchar', default => '', length => 25, not_null => 1 },
        text       => { type => 'scalar', default => '', length => 4294967295, not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    foreign_keys => [
        app => {
            class       => 'VulnDB::RDBO::App',
            key_columns => { app_id => 'id' },
        },

        message => {
            class       => 'VulnDB::RDBO::Message',
            key_columns => { message_id => 'id' },
        },
    ],
);

1;
######################################################################
package VulnDB::RDBO::Advisory::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::Advisory;

sub object_class { 'VulnDB::RDBO::Advisory' }

__PACKAGE__->make_manager_methods('advisory');

1;

######################################################################
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
######################################################################
package VulnDB::RDBO::AlertMethod::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::AlertMethod;

sub object_class { 'VulnDB::RDBO::AlertMethod' }

__PACKAGE__->make_manager_methods('alert_method');

1;

######################################################################
package VulnDB::RDBO::App;

use strict;

use base qw(VulnDB::RDBO);

__PACKAGE__->meta->setup(
    table   => 'app',

    columns => [
        id   => { type => 'integer', not_null => 1 },
        name => { type => 'varchar', default => '', length => 150, not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    unique_key => [ 'name' ],

    relationships => [
        advisory => {
            class      => 'VulnDB::RDBO::Advisory',
            column_map => { id => 'app_id' },
            type       => 'one to many',
        },

        app_version => {
            class      => 'VulnDB::RDBO::AppVersion',
            column_map => { id => 'app_id' },
            type       => 'one to many',
        },
    ],
);

1;
######################################################################
package VulnDB::RDBO::App::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::App;

sub object_class { 'VulnDB::RDBO::App' }

__PACKAGE__->make_manager_methods('app');

1;

######################################################################
package VulnDB::RDBO::AppVersion;

use strict;

use base qw(VulnDB::RDBO);

__PACKAGE__->meta->setup(
    table   => 'app_version',

    columns => [
        id      => { type => 'integer', not_null => 1 },
        app_id  => { type => 'integer', default => '', not_null => 1 },
        version => { type => 'varchar', default => '', length => 50, not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    foreign_keys => [
        app => {
            class       => 'VulnDB::RDBO::App',
            key_columns => { app_id => 'id' },
        },
    ],
);

1;
######################################################################
package VulnDB::RDBO::AppVersion::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::AppVersion;

sub object_class { 'VulnDB::RDBO::AppVersion' }

__PACKAGE__->make_manager_methods('app_version');

1;

######################################################################
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
######################################################################
package VulnDB::RDBO::AuthUser::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::AuthUser;

sub object_class { 'VulnDB::RDBO::AuthUser' }

__PACKAGE__->make_manager_methods('auth_user');

1;

######################################################################
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
######################################################################
package VulnDB::RDBO::CriteriaType::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::CriteriaType;

sub object_class { 'VulnDB::RDBO::CriteriaType' }

__PACKAGE__->make_manager_methods('criteria_type');

1;

######################################################################
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
######################################################################
package VulnDB::RDBO::Message::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::Message;

sub object_class { 'VulnDB::RDBO::Message' }

__PACKAGE__->make_manager_methods('message');

1;

######################################################################
package VulnDB::RDBO::MessageType;

use strict;

use base qw(VulnDB::RDBO);

__PACKAGE__->meta->setup(
    table   => 'message_type',

    columns => [
        id   => { type => 'integer', not_null => 1 },
        name => { type => 'varchar', default => '', length => 25, not_null => 1 },
        desc => { type => 'scalar', default => '', length => 4294967295, not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    unique_key => [ 'name' ],

    relationships => [
        message => {
            class      => 'VulnDB::RDBO::Message',
            column_map => { id => 'message_type_id' },
            type       => 'one to many',
        },

        source => {
            class      => 'VulnDB::RDBO::Source',
            column_map => { id => 'message_type_id' },
            type       => 'one to many',
        },
    ],
);

1;
######################################################################
package VulnDB::RDBO::MessageType::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::MessageType;

sub object_class { 'VulnDB::RDBO::MessageType' }

__PACKAGE__->make_manager_methods('message_type');

1;

######################################################################
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
######################################################################
package VulnDB::RDBO::Qualifier::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::Qualifier;

sub object_class { 'VulnDB::RDBO::Qualifier' }

__PACKAGE__->make_manager_methods('qualifier');

1;

######################################################################
package VulnDB::RDBO::Source;

use strict;

use base qw(VulnDB::RDBO);

__PACKAGE__->meta->setup(
    table   => 'source',

    columns => [
        id              => { type => 'integer', not_null => 1 },
        name            => { type => 'varchar', default => '', length => 50, not_null => 1 },
        email           => { type => 'varchar', default => '', length => 50, not_null => 1 },
        email_password  => { type => 'varchar', default => '', length => 50, not_null => 1 },
        email_server    => { type => 'varchar', default => '', length => 50, not_null => 1 },
        url             => { type => 'varchar', default => '', length => 100, not_null => 1 },
        desc            => { type => 'varchar', default => '', length => 150, not_null => 1 },
        desc_long       => { type => 'scalar', default => '', length => 4294967295, not_null => 1 },
        message_type_id => { type => 'integer', default => '', not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    unique_key => [ 'name', 'message_type_id' ],

    foreign_keys => [
        message_type => {
            class       => 'VulnDB::RDBO::MessageType',
            key_columns => { message_type_id => 'id' },
        },
    ],

    relationships => [
        message => {
            class      => 'VulnDB::RDBO::Message',
            column_map => { id => 'source_id' },
            type       => 'one to many',
        },

        userprofiles => {
            column_map    => { source_id => 'id' },
            foreign_class => 'VulnDB::RDBO::UserProfile',
            map_class     => 'VulnDB::RDBO::UserSource',
            map_from      => 'source',
            map_to        => 'userprofile',
            type          => 'many to many',
        },
    ],
);

1;
######################################################################
package VulnDB::RDBO::Source::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::Source;

sub object_class { 'VulnDB::RDBO::Source' }

__PACKAGE__->make_manager_methods('source');

1;

######################################################################
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
######################################################################
package VulnDB::RDBO::UserAlertMethod::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::UserAlertMethod;

sub object_class { 'VulnDB::RDBO::UserAlertMethod' }

__PACKAGE__->make_manager_methods('user_alert_methods');

1;

######################################################################
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
######################################################################
package VulnDB::RDBO::UserCriteria::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::UserCriteria;

sub object_class { 'VulnDB::RDBO::UserCriteria' }

__PACKAGE__->make_manager_methods('user_criteria');

1;

######################################################################
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
######################################################################
package VulnDB::RDBO::UserMessage::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::UserMessage;

sub object_class { 'VulnDB::RDBO::UserMessage' }

__PACKAGE__->make_manager_methods('user_messages');

1;

######################################################################
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
######################################################################
package VulnDB::RDBO::UserProfile::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::UserProfile;

sub object_class { 'VulnDB::RDBO::UserProfile' }

__PACKAGE__->make_manager_methods('user_profile');

1;

######################################################################
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
######################################################################
package VulnDB::RDBO::UserSource::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::UserSource;

sub object_class { 'VulnDB::RDBO::UserSource' }

__PACKAGE__->make_manager_methods('user_sources');

1;

