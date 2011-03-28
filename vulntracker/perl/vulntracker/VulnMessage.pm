
package VulnMessage;

use 5.008;
use strict;
use warnings;
use Carp;

use base qw(Class::Accessor);
# create nice accessors -- i.e. <get> = $object->user -- <set> = $object->user($someuser)
VulnMessage->mk_accessors( qw(msg body subject) );

our $VERSION = '0.01';

#Note: all classes desecended from VulnMessage are expected to have at least the attributes defined in this new()
sub new {

    #Init
    my $class = shift;
    my $msg = shift;
    my $self = { msg=>$msg, body=>'', subject=>'' };
    bless $self, $class;

    return $self;

}

1;


=head1 NAME

VulnMessage - Parses raw format (html,text,email) messages into the database fields

=head1 SYNOPSIS

  use VulnMessage;

=head1 ABSTRACT

  SuperClass that will be extended by all message specific implementation classes.

=cut
