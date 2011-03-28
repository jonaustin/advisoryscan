package VulnDB::RDBO::UserMessage::Manager;

use base qw(Rose::DB::Object::Manager);

use VulnDB::RDBO::UserMessage;

sub object_class { 'VulnDB::RDBO::UserMessage' }

__PACKAGE__->make_manager_methods('user_messages');

1;

