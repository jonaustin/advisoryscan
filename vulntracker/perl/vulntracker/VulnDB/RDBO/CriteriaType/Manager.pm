package VulnDB::RDBO::CriteriaType::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::CriteriaType;

sub object_class { 'VulnDB::RDBO::CriteriaType' }

__PACKAGE__->make_manager_methods('criteria_type');

1;

