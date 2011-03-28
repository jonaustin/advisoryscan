#!/bin/perl -w
use strict;
#use diagnostics;
use Data::Dumper;

use VulnRetrieve::POP3;
use VulnMessage::Mail;
use VulnDB;

my $vulndb_obj = VulnDB->new();

my @source_hash_refs = @{$vulndb_obj->source_mgr->get_source()};

# loop through all sources and grab new messages
for my $source_hash_ref (@source_hash_refs) {
    my @msg_objs;
    my%source = %$source_hash_ref;
    
    #print "['" . $source{email} . "', '" . $source{email_password} . "', '" . $source{email_server} . "']\n";
    my $vuln_retriever = VulnRetrieve::POP3->new( $source{email}, $source{email_password}, $source{email_server} );

    my @msgs = $vuln_retriever->fetchAll();
    #my @msgs = $vuln_retriever->fetchSome(10);

    for my $msg (@msgs) {
        push @msg_objs, VulnMessage::Mail->parse($msg);
    }

    $vulndb_obj->insert_msg(\@msg_objs, $source{name}, 'mail');

}


# go thru and assign all new (is_processed=0) msgs to users whose criteria matches
my @user_hash_refs = @{$vulndb_obj->user_mgr->get_auth_user( query => [ is_active => 1 ] )};

for my $user_hash_ref (@user_hash_refs) {
    my @msg_refs = @{$vulndb_obj->find_msgs_by_user( $user_hash_ref, [ is_processed => 0 ] )};
    $vulndb_obj->add_user_msgs( { user => $user_hash_ref, msgs => \@msg_refs } );

    #for my $msg_ref (@msg_refs) { print $msg_ref->subject . "\n"; }
}

# set all new messages (is_processed=0) to is_processed=1
my @msgs = @{$vulndb_obj->message_mgr->get_message( query => [ is_processed => 0 ] )};
for my $msg (@msgs) {
    $msg->{is_processed} = 1;
    $msg->save();
}

