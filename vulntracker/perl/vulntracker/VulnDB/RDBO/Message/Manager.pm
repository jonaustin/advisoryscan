package VulnDB::RDBO::Message::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::Message;

sub object_class { 'VulnDB::RDBO::Message' }

__PACKAGE__->make_manager_methods('message');

1;

