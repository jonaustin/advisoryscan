
package VulnEmail;

use 5.008;
use strict;
use warnings;
use Carp;

our $VERSION = '0.01';

sub new {
    #In: (username or email) and messages arrayref
    my $class   = shift;
    my $args    = shift;
    my $msgs_ref    = $args->{msgs} || [];
    my $email   = $args->{email} || '';
    my $username= $args->{username} || '';

    my $self    = { msgs => $msgs_ref, email => $email, username => $username, email => '' };

    
    bless $self, $class;

}


sub format_as_html {
    #In: arrayref of messages
    #Do: format message subjects/bodies into html (basically just text with an html index of subjects)
    #Out: email text scalar

    my $self = shift;
    my @msgs = @{$self->{msgs}};

    my ($email_html, $email_text) = '';

    $email_html .= ("<a href='http://advisoryscan.net/messages/" . $_->id . "'> " . $_->subject . "</a> <br /> <br /> \n") for (@msgs);

    $self->{email} = $email_html


}

sub send_email {
    #In: email, subject, and body scalars in a hash ref
    #Do: send email
    #Out: none

    open my $logfile, ">>", "logs/logfile.txt";
    my $self    = shift;
    my $args    = shift;
    my $subject = $args->{subject} || '';
    my $email   = $args->{email};
    my $body   = $args->{body} || '';

    if (not $email) { croak "email arg is required" }

    eval {
        use MIME::Lite;
	#MIME::Lite->send("sendmail");

        my $msg = MIME::Lite->new(
            Subject => $subject,
            From    => 'no-reply@advisoryscan.net',
            To      => $email,
            Type    => 'text/html',
            Data    => $body,
        );
        $msg->send();
    };
    if ($@) {
        my $cur_datetime = localtime();
        print $logfile $cur_datetime . ": " . $@ . "\n";
    }
}

1;


=head1 NAME

VulnEmail - Takes in a user/email, combines all new vulns based on their app/version criteria and sends email
