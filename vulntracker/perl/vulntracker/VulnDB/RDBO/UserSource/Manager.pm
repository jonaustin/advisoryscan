package VulnDB::RDBO::UserSource::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::UserSource;

sub object_class { 'VulnDB::RDBO::UserSource' }

__PACKAGE__->make_manager_methods('user_sources');

1;

