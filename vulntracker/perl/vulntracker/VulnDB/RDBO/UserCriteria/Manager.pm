package VulnDB::RDBO::UserCriteria::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::UserCriteria;

sub object_class { 'VulnDB::RDBO::UserCriteria' }

__PACKAGE__->make_manager_methods('user_criteria');

1;

