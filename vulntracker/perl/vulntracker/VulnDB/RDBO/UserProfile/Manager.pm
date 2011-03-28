package VulnDB::RDBO::UserProfile::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::UserProfile;

sub object_class { 'VulnDB::RDBO::UserProfile' }

__PACKAGE__->make_manager_methods('user_profile');

1;

