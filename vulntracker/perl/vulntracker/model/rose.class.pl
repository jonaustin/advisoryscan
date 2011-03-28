######################################################################
package My::RDBO::Advisory;

use strict;

use base qw(My::RDBO);

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
            class       => 'My::RDBO::App',
            key_columns => { app_id => 'id' },
        },

        message => {
            class       => 'My::RDBO::Message',
            key_columns => { message_id => 'id' },
        },
    ],
);

1;
######################################################################
package My::RDBO::Advisory::Manager;

use base qw(Rose::DB::Object::Manager);

use My::RDBO::Advisory;

sub object_class { 'My::RDBO::Advisory' }

__PACKAGE__->make_manager_methods('advisory');

1;

######################################################################
package My::RDBO::AlertMethod;

use strict;

use base qw(My::RDBO);

__PACKAGE__->meta->setup(
    table   => 'alert_methods',

    columns => [
        id        => { type => 'integer', not_null => 1 },
        name      => { type => 'varchar', default => '', length => 50, not_null => 1 },
        desc      => { type => 'varchar', default => '', length => 100, not_null => 1 },
        desc_long => { type => 'scalar', default => '', length => 4294967295, not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    unique_key => [ 'name' ],
);

1;
######################################################################
package My::RDBO::AlertMethod::Manager;

use base qw(Rose::DB::Object::Manager);

use My::RDBO::AlertMethod;

sub object_class { 'My::RDBO::AlertMethod' }

__PACKAGE__->make_manager_methods('alert_methods');

1;

######################################################################
package My::RDBO::App;

use strict;

use base qw(My::RDBO);

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
            class      => 'My::RDBO::Advisory',
            column_map => { id => 'app_id' },
            type       => 'one to many',
        },
    ],
);

1;
######################################################################
package My::RDBO::App::Manager;

use base qw(Rose::DB::Object::Manager);

use My::RDBO::App;

sub object_class { 'My::RDBO::App' }

__PACKAGE__->make_manager_methods('app');

1;

######################################################################
package My::RDBO::AppVersion;

use strict;

use base qw(My::RDBO);

__PACKAGE__->meta->setup(
    table   => 'app_version',

    columns => [
        id      => { type => 'integer', not_null => 1 },
        app_id  => { type => 'integer', default => '', not_null => 1 },
        version => { type => 'varchar', default => '', length => 50, not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],
);

1;
######################################################################
package My::RDBO::AppVersion::Manager;

use base qw(Rose::DB::Object::Manager);

use My::RDBO::AppVersion;

sub object_class { 'My::RDBO::AppVersion' }

__PACKAGE__->make_manager_methods('app_version');

1;

######################################################################
package My::RDBO::Criteria;

use strict;

use base qw(My::RDBO);

__PACKAGE__->meta->setup(
    table   => 'criteria',

    columns => [
        id   => { type => 'integer', not_null => 1 },
        name => { type => 'varchar', default => '', length => 50, not_null => 1 },
        desc => { type => 'scalar', default => '', length => 4294967295, not_null => 1 },
        type => { type => 'varchar', default => '', length => 50, not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    unique_key => [ 'name' ],

    relationships => [
        user_criteria => {
            class      => 'My::RDBO::UserCriteria',
            column_map => { id => 'criteria_id' },
            type       => 'one to many',
        },
    ],
);

1;
######################################################################
package My::RDBO::Criteria::Manager;

use base qw(Rose::DB::Object::Manager);

use My::RDBO::Criteria;

sub object_class { 'My::RDBO::Criteria' }

__PACKAGE__->make_manager_methods('criteria');

1;

######################################################################
package My::RDBO::Message;

use strict;

use base qw(My::RDBO);

__PACKAGE__->meta->setup(
    table   => 'message',

    columns => [
        id        => { type => 'integer', not_null => 1 },
        text      => { type => 'scalar', default => '', length => 4294967295, not_null => 1 },
        subject   => { type => 'varchar', default => '', length => 250, not_null => 1 },
        body      => { type => 'scalar', default => '', length => 4294967295, not_null => 1 },
        type_id   => { type => 'integer', default => '', not_null => 1 },
        source_id => { type => 'integer', default => '', not_null => 1 },
        processed => { type => 'integer', default => '', not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    unique_keys => [
        [ 'subject' ],
        [ 'subject', 'source_id' ],
    ],

    relationships => [
        advisory => {
            class      => 'My::RDBO::Advisory',
            column_map => { id => 'message_id' },
            type       => 'one to many',
        },
    ],
);

1;
######################################################################
package My::RDBO::Message::Manager;

use base qw(Rose::DB::Object::Manager);

use My::RDBO::Message;

sub object_class { 'My::RDBO::Message' }

__PACKAGE__->make_manager_methods('message');

1;

######################################################################
package My::RDBO::MessageType;

use strict;

use base qw(My::RDBO);

__PACKAGE__->meta->setup(
    table   => 'message_type',

    columns => [
        id   => { type => 'integer', not_null => 1 },
        name => { type => 'varchar', default => '', length => 25, not_null => 1 },
        desc => { type => 'scalar', default => '', length => 4294967295, not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    unique_key => [ 'name' ],
);

1;
######################################################################
package My::RDBO::MessageType::Manager;

use base qw(Rose::DB::Object::Manager);

use My::RDBO::MessageType;

sub object_class { 'My::RDBO::MessageType' }

__PACKAGE__->make_manager_methods('message_type');

1;

######################################################################
package My::RDBO::Source;

use strict;

use base qw(My::RDBO);

__PACKAGE__->meta->setup(
    table   => 'source',

    columns => [
        id        => { type => 'integer', not_null => 1 },
        name      => { type => 'varchar', default => '', length => 50, not_null => 1 },
        url       => { type => 'varchar', default => '', length => 100, not_null => 1 },
        desc      => { type => 'varchar', default => '', length => 150, not_null => 1 },
        desc_long => { type => 'scalar', default => '', length => 4294967295, not_null => 1 },
        type_id   => { type => 'integer', default => '', not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    unique_key => [ 'name', 'type_id' ],
);

1;
######################################################################
package My::RDBO::Source::Manager;

use base qw(Rose::DB::Object::Manager);

use My::RDBO::Source;

sub object_class { 'My::RDBO::Source' }

__PACKAGE__->make_manager_methods('source');

1;

######################################################################
package My::RDBO::UserAlertMethod;

use strict;

use base qw(My::RDBO);

__PACKAGE__->meta->setup(
    table   => 'user_alert_methods',

    columns => [
        id              => { type => 'integer', not_null => 1 },
        userprofile_id  => { type => 'integer', default => '', not_null => 1 },
        alertmethods_id => { type => 'integer', default => '', not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    unique_key => [ 'userprofile_id', 'alertmethods_id' ],
);

1;
######################################################################
package My::RDBO::UserAlertMethod::Manager;

use base qw(Rose::DB::Object::Manager);

use My::RDBO::UserAlertMethod;

sub object_class { 'My::RDBO::UserAlertMethod' }

__PACKAGE__->make_manager_methods('user_alert_methods');

1;

######################################################################
package My::RDBO::UserCriteria;

use strict;

use base qw(My::RDBO);

__PACKAGE__->meta->setup(
    table   => 'user_criteria',

    columns => [
        id          => { type => 'integer', not_null => 1 },
        user_id     => { type => 'integer', default => '', not_null => 1 },
        criteria_id => { type => 'integer', default => '', not_null => 1 },
        value       => { type => 'varchar', default => '', length => 50, not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    foreign_keys => [
        criteria => {
            class       => 'My::RDBO::Criteria',
            key_columns => { criteria_id => 'id' },
        },
    ],
);

1;
######################################################################
package My::RDBO::UserCriteria::Manager;

use base qw(Rose::DB::Object::Manager);

use My::RDBO::UserCriteria;

sub object_class { 'My::RDBO::UserCriteria' }

__PACKAGE__->make_manager_methods('user_criteria');

1;

######################################################################
package My::RDBO::UserProfile;

use strict;

use base qw(My::RDBO);

__PACKAGE__->meta->setup(
    table   => 'user_profile',

    columns => [
        id          => { type => 'integer', not_null => 1 },
        user_id     => { type => 'integer', default => '', not_null => 1 },
        where_heard => { type => 'varchar', default => '', length => 250, not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    unique_key => [ 'user_id' ],
);

1;
######################################################################
package My::RDBO::UserProfile::Manager;

use base qw(Rose::DB::Object::Manager);

use My::RDBO::UserProfile;

sub object_class { 'My::RDBO::UserProfile' }

__PACKAGE__->make_manager_methods('user_profile');

1;

######################################################################
package My::RDBO::UserSource;

use strict;

use base qw(My::RDBO);

__PACKAGE__->meta->setup(
    table   => 'user_sources',

    columns => [
        id             => { type => 'integer', not_null => 1 },
        userprofile_id => { type => 'integer', default => '', not_null => 1 },
        source_id      => { type => 'integer', default => '', not_null => 1 },
    ],

    primary_key_columns => [ 'id' ],

    unique_key => [ 'userprofile_id', 'source_id' ],
);

1;
######################################################################
package My::RDBO::UserSource::Manager;

use base qw(Rose::DB::Object::Manager);

use My::RDBO::UserSource;

sub object_class { 'My::RDBO::UserSource' }

__PACKAGE__->make_manager_methods('user_sources');

1;

