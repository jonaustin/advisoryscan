package VulnDB::RDBO::AuthUser::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::AuthUser;

sub object_class { 'VulnDB::RDBO::AuthUser' }

__PACKAGE__->make_manager_methods('auth_user');

1;

