package VulnDB::RDBO::AppVersion::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::AppVersion;

sub object_class { 'VulnDB::RDBO::AppVersion' }

__PACKAGE__->make_manager_methods('app_version');

1;

