package VulnRetrieve::POP3;

use 5.008;
use strict;
use warnings;
use Carp;

use Net::POP3;

use base qw(VulnRetrieve);

sub new {
    my $class = shift;
    my ($username, $password, $server) = @_;
    my $self = {username=>$username, password=>$password, server=>$server};
    $self = bless $self, $class;

    # Note: oldest msg is first in messages hash
    my $pop = Net::POP3->new($server)
        or die "Can't open connection to $server : $!\n";
    defined($pop->login($username, $password)) #FIXME: apop fails with bad file descriptor
        or die "Can't authenticate: $!\n";
    $self->{messages} = $pop->list
        or die "Can't get list of undeleted messages: $!\n";
    $self->{pop} = $pop;


    return $self;
}

sub fetchOne {
    #In: msgid or default to 1 (oldest)
    #Do: fetch mesg
    #Out: scalar of mesg text fetched
    my $self = shift;
    my $msgid = shift || 1;
    my $pop = $self->{pop};
    
    # $message is a reference to an array of lines
    my $message = $pop->get($msgid);
        unless (defined $message) {
            warn "Couldn't fetch $msgid from server: $!\n";
    }

    $pop->delete($msgid);
    
    my $msg_txt = join('', @$message);

    return $msg_txt;
}


sub fetchSome {
    #In: number to fetch, 0 if all
    #Do: fetch num messages from oldest (1) to newest (max)
    #Out: array of message (text) scalars

    my $self = shift;
    my $num_to_fetch = shift;
    my $num_msgs= keys(%{$self->{messages}});
    # set to max if $num_to_fetch is > $num_msgs
    $num_to_fetch = $num_msgs if $num_to_fetch > $num_msgs;
    my @messages_text;

    $num_to_fetch = $num_msgs if $num_to_fetch == 0;

    for my $msgid (1..$num_to_fetch) {
         push @messages_text, ($self->fetchOne($msgid)); 
    }

    return @messages_text;

}




sub fetchAll { 
    #In: None
    #Do: call fetchSome(0) to grab all msgs
    #Out: array of message (text) scalars
    my $self = shift;
    return $self->fetchSome(0);
}

sub DESTROY {
    my $self = shift;
    my $pop = $self->{pop};

    $pop->quit();
}
    

1;
