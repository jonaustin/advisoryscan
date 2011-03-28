package VulnDB::RDBO::App::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::App;

sub object_class { 'VulnDB::RDBO::App' }

__PACKAGE__->make_manager_methods('app');

1;

