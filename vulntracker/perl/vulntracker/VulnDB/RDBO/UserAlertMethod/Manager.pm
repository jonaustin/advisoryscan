package VulnDB::RDBO::UserAlertMethod::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::UserAlertMethod;

sub object_class { 'VulnDB::RDBO::UserAlertMethod' }

__PACKAGE__->make_manager_methods('user_alert_methods');

1;

