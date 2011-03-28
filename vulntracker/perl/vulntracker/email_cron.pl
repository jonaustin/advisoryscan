#!/usr/bin/perl -w
use strict;

use VulnDB;

my $vdb = VulnDB->new();

# loop through all users that have email selected as an alert method
my @user_hash_refs = @{$vdb->user_mgr->get_auth_user( query => [ is_active => 1 ] )};

for my $user_hash_ref (@user_hash_refs) {
    my @msgs = @{$vdb->find_msgs_by_user($user_hash_ref, [is_mailed => 0])};
    my $num_msgs = @msgs;
    next if $num_msgs == 0;
    
    # skip mailing if user does not have mail selected as an alert delivery method
    my $user_profile_ref = $user_hash_ref->user_profile;
    my @alert_method_refs = @{$user_profile_ref->alertmethods};
    my $wants_mail = 0;
    for my $alertmethod_ref (@alert_method_refs) {
        $wants_mail = 1 if ( $alertmethod_ref->name eq 'mail');
    }
    next if $wants_mail == 0;

    # format email
    use VulnEmail;
    my $ve = VulnEmail->new( { msgs => \@msgs, username => $user_hash_ref->username } );
    my $email = $ve->format_as_html;

    # send email
    my ($day, $month, $year) = (localtime)[3,4,5];
    $month++;
    $day = "0".$day if ($day <= 9);
    $month = "0".$month if ($month <= 9);
    $year += 1900;
    my $subject = "advisoryscan.net Digest for " . $year . "/" . $month . "/" . $day;
    #print $user_hash_ref->email . "\n";
    $ve->send_email( { subject => $subject, email => $user_hash_ref->email, body => $email } );

}

# set all new messages (is_mailed=0) to is_mailed=1
my @msgs = @{$vdb->message_mgr->get_message( query => [ is_mailed => 0 ] )};
for my $msg (@msgs) {
    $msg->{is_mailed} = 1;
    $msg->save();
}


