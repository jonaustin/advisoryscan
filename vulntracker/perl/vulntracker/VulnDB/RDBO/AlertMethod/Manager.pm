package VulnDB::RDBO::AlertMethod::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::AlertMethod;

sub object_class { 'VulnDB::RDBO::AlertMethod' }

__PACKAGE__->make_manager_methods('alert_method');

1;

