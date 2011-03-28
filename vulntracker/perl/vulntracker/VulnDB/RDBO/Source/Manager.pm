package VulnDB::RDBO::Source::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::Source;

sub object_class { 'VulnDB::RDBO::Source' }

__PACKAGE__->make_manager_methods('source');

1;

