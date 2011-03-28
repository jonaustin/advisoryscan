# This class provides one interface for creating simple methods to perform general and routine database operations on a set of items,
# as well as providing one interface to the database through Rose::DB::Object classes

package VulnDB;

use 5.008;
use strict;
use warnings;
use Carp;

use VulnMessage;


use VulnDB::RDBO::Advisory;
use VulnDB::RDBO::Advisory::Manager;
use VulnDB::RDBO::AlertMethod;
use VulnDB::RDBO::AlertMethod::Manager;
#--------------------------------------------------
# Not currently used
# use VulnDB::RDBO::App;
# use VulnDB::RDBO::App::Manager;
# use VulnDB::RDBO::AppVersion;
# use VulnDB::RDBO::AppVersion:Manager;
#-------------------------------------------------- 
use VulnDB::RDBO::AuthUser;
use VulnDB::RDBO::AuthUser::Manager;
use VulnDB::RDBO::CriteriaType;
use VulnDB::RDBO::CriteriaType::Manager;
use VulnDB::RDBO::Message;
use VulnDB::RDBO::Message::Manager;
use VulnDB::RDBO::MessageType;
use VulnDB::RDBO::MessageType::Manager;
use VulnDB::RDBO::Source;
use VulnDB::RDBO::Source::Manager;
use VulnDB::RDBO::UserAlertMethod;
use VulnDB::RDBO::UserAlertMethod::Manager;
use VulnDB::RDBO::UserCriteria;
use VulnDB::RDBO::UserCriteria::Manager;
use VulnDB::RDBO::UserProfile;
use VulnDB::RDBO::UserProfile::Manager;
use VulnDB::RDBO::UserSource;
use VulnDB::RDBO::UserSource::Manager;

use base qw(Class::Accessor);
# create nice accessors -- i.e. <get> = $vulndb->user -- <set> = $vulndb->user($someuser)
VulnDB->mk_accessors( qw(user user_mgr criteria_type criteria_type_mgr message message_mgr message_type
                        message_type_mgr source source_mgr user_alert_method user_alert_method_mgr
                        user_criteria user_criteria_mgr user_profile user_profile_mgr 
                        user_source user_source_mgr) );

our $VERSION = '0.01';

sub new {
    #In: None
    #Do: instantiate new object that allows single object access to all Rose ORM table/row and table/manager classes
    #Out: vulnDB object
    my $class   = shift;


    
    my $self = {
                    user                   => 'VulnDB::RDBO::AuthUser',
                    user_mgr               => 'VulnDB::RDBO::AuthUser::Manager',
                    criteria_type          => 'VulnDB::RDBO::CriteriaType',
                    criteria_type_mgr      => 'VulnDB::RDBO::CriteriaType::Manager',
                    message                => 'VulnDB::RDBO::Message',
                    message_mgr            => 'VulnDB::RDBO::Message::Manager',
                    message_type           => 'VulnDB::RDBO::MessageType',
                    message_type_mgr       => 'VulnDB::RDBO::MessageType::Manager',
                    source                 => 'VulnDB::RDBO::Source',
                    source_mgr             => 'VulnDB::RDBO::Source::Manager',
                    user_alert_method      => 'VulnDB::RDBO::UserAlertMethod',
                    user_alert_method_mgr  => 'VulnDB::RDBO::UserAlertMethod::Manager',
                    user_criteria          => 'VulnDB::RDBO::UserCriteria',
                    user_criteria_mgr      => 'VulnDB::RDBO::UserCriteria::Manager',
                    user_message           => 'VulnDB::RDBO::UserMessage',
                    user_message_mgr       => 'VulnDB::RDBO::UserMessage::Manager',
                    user_profile           => 'VulnDB::RDBO::UserProfile',
                    user_profile_mgr       => 'VulnDB::RDBO::UserProfile::Manager',
                    user_source            => 'VulnDB::RDBO::UserSource',
                    user_source_mgr        => 'VulnDB::RDBO::UserSource::Manager',
                };
    bless $self, $class;

    return $self;
}


### INSERTIONS ###

sub insert_msg {
    #In: reference to list of VulnMessage object(s) along with a single identifying 'source' and 'type' names that covers all msgs in this call
    #Do: Insert all message objects contained in this instance into db
    #Out: None
    
    open my $logfile, ">>", "logs/logfile.txt";

    my $self            = shift;
    my $msg_list_ref    = shift;
    my @msg_list        = @$msg_list_ref;
    my $source_name     = shift;
    my $msg_type_name       = shift;


    my $user_mgr = $self->user_mgr;
    my $users = $user_mgr->get_auth_user();

    # instantiate message row and table handlers
    my $message            = $self->message;
    my $message_mgr        = $self->message_mgr;

    # instantiate source and message_type table handlers
    my $source_mgr         = $self->source_mgr;
    my $message_type_mgr   = $self->message_type_mgr;

    # get source and message type objects
    my $source          = @{$source_mgr->get_source( query => [ name => $source_name, ] )}[0];
    my $message_type    = @{$message_type_mgr->get_message_type( query => [ name => $msg_type_name, ] )}[0];

    for my $msg ( @msg_list ) {
        my $msg_row = $message->new( 
                                    text        => $msg->msg,
                                    subject     => $msg->subject,
                                    body        => $msg->body,
                                    source_id   => $source->id,
                                    message_type_id     => $message_type->id,
                                );
        eval {
            $msg_row->save();
        };

        # write error to log if save fails
        if ($@) {
            my $cur_datetime = localtime();
            print $logfile $cur_datetime . ": " . $msg_row->error . "\n";
        }
    }

    close $logfile;
}

### CRITERIA ###

sub find_msgs_by_user {
    # given a userobj ref find all is_processed=0 messages that match user's criteria and sources and return an arrayref of message objects
    #IN: user:          user object reference
    #    opt_params:  array ref of extra field/value pairs, i.e. ['is_mailed', 1, is_processed, 0]
    #OUT: array ref of message object refs

    my $self = shift;
    my $user = shift;
    my $opt_params = shift;
    $opt_params = [] if not defined($opt_params);

    my @messages;
    # find out whether we should use advanced or simple prefs
    my $profile = ${$self->user_profile_mgr->get_user_profile(query => [user_id => $user->id] )}[0];  #get_user_profile(user_id => $user->id)}[0]; -- apparent Rose bug (always gets user_id=1)
    my $criteria_pref_type = $profile->criteria_pref_type;
    # get this user's criteria, then go through each set, find msgs that match and add to msg hash based on subject (so duplicates will get caught)
    my $user_criteria_mgr = $self->user_criteria_mgr;
    my @user_criteria     = @{$user_criteria_mgr->get_user_criteria( query => [ user_id => $user->id ] )};


    for my $criteria (@user_criteria) {
        if ($criteria->criteria_type->criteria_pref_type eq $criteria_pref_type) {
            # get user's selected sources
            my @sources;
            for my $source (@{$profile->sources}) {
                push(@sources, $source->id);
            }

            my $search_field    = $criteria->criteria_type->search_field;
            my $value           = $criteria->value;
            my $qualifier_rose   = $criteria->qualifier->rose;
            my $rose_sql_transform = $criteria->qualifier->rose_sql;

            # account for rose:db:object's inconvenient way of proclaiming NOT which disrupts my beautifully crafted database schema which otherwise abstract all this out
            if ($criteria->qualifier->name =~ /^not/) {
                $search_field = "!" . $search_field;
            }

            # replace %s in rose_sql_transform with value we're searching for
            $rose_sql_transform =~ s/%s/$value/;

            my $params = [ $search_field => { $qualifier_rose => $rose_sql_transform }, source_id => \@sources ];
            push (@$params, @$opt_params);

            push @messages, @{$self->message_mgr->get_message( query => $params ) }
        }
    }
    # weed out duplicates (find a better solution for this)
    my %msgs = ();
    for my $msg (@messages) {
        $msgs{ $msg->id } = $msg;
    }
    # convert back to array
    my @unique_msgs = ();
    for my $msg_id (keys %msgs) {
        push @unique_msgs, $msgs{$msg_id};
    }

    return \@unique_msgs;
}

sub add_user_msgs {
    # given an argument hash of a user and an arrayref of message objects, adds them to the user's set of messages
    #FIXME: if it finds any msg_ids that have already been added it will fail and no message will be added -- this should never happen, but...
    
    open my $logfile, ">>", "logs/logfile.txt";

    my $self = shift;
    my $args = shift;
    my $user = $args->{user};
    my @msgs = @{$args->{msgs}};

    my $num_msgs = @msgs;
    return if ($num_msgs == 0);

    my $user_profile = ${$self->user_profile_mgr->get_user_profile( query => [ user_id => $user->id ] )}[0];

    $user_profile->add_messages( @msgs );
    
    eval {
        $user_profile->save;
    };
    
    # write error to log if save fails
    if ($@) {
        my $cur_datetime = localtime();
        print $logfile $cur_datetime . ": VulnDB->add_user_msgs->\$user->profile->save() -- " . $user_profile->error . "\n";
    }

    close $logfile;


    
}


######## ERROR CHECKING ########

sub is_valid_user {

    my $self = shift;
    my $args = shift;
    my $username = $args->{user} || '';
    my $email    = $args->{email} || '';
    my @users    = ();


    if ($username) {
        @users = @{ $self->user_mgr->get_auth_user( query => [ username => $username ] )};
    } elsif ($email) {
        @users = @{ $self->user_mgr->get_auth_user( query => [ email    => $email ]  )};
    } else {
        croak "email or username required\n";
    }

    if (not @users) {
        return 0;
    } else {
        return 1;
    }

}


1;



