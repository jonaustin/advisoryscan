package VulnDB::RDBO::Qualifier::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::Qualifier;

sub object_class { 'VulnDB::RDBO::Qualifier' }

__PACKAGE__->make_manager_methods('qualifier');

1;

