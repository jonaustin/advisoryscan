package VulnMessage::Mail;

use 5.008;
use strict;
use warnings;
use Carp;

use Mail::Message;

use base qw(VulnMessage);

# create nice accessors -- i.e. <get> = $object->user -- <set> = $object->user($someuser)
VulnMessage->mk_accessors( qw(msg) );

sub parse {
    #In: RFC mail message
    #Do: separate into subject/body/raw msg
    #Out: VulnMessage::Mail object which is hash of {subject,body,msg} 

    #Init
    my $class = shift;
    my $msg = shift;
    my $self = $class->SUPER::new($msg);

    # Create Mail Object and get subject and body
    my $msg_obj = Mail::Message->read($self->{msg});
    $self->{body} = $msg_obj->body()->decoded;
    $self->{subject} = $msg_obj->subject();

    return $self;
}



1;
