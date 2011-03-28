package VulnDB::RDBO::MessageType::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::MessageType;

sub object_class { 'VulnDB::RDBO::MessageType' }

__PACKAGE__->make_manager_methods('message_type');

1;

