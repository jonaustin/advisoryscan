package VulnDB::RDBO::Advisory::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::Advisory;

sub object_class { 'VulnDB::RDBO::Advisory' }

__PACKAGE__->make_manager_methods('advisory');

1;

