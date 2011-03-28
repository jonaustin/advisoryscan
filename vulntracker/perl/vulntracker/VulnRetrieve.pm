
package VulnRetrieve;

use 5.008;
use strict;
use warnings;
use Carp;

our $VERSION = '0.01';

sub new {
    my $class = shift;
    my $self = { };
    bless $self, $class;
    return $self;
}

sub fetchOne {
}

sub fetchAll {
}


1;


=head1 NAME

VulnRetrieve - Retrieves new vulnerabilities that have not yet been tracked in the Vulnerability DB.

=head1 SYNOPSIS

  use VulnRetrieve;

=head1 ABSTRACT

  SuperClass that will be extended by all message retrieval specific implementation classes.

=cut
