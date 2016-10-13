#!/usr/bin/perl -w 
use strict; 

# Use whichever module matches your server 
#use Net::LDAP; 
use Net::LDAPS; 

die "Usage is adduser.pl [username] ["realname"]\n" if length(@ARGV) != 1; 

my $username = $ARGV[0]; 
my $realname = $ARGV[1]; 

# Plain LDAP version if you prefer this to the LDAPS version 
# my $ldap = Net::LDAP->new( 'ldapserver.example.com'); 
my $ldap = Net::LDAPS->new( 'ldapserver.example.com', 
                           verify => 'optional', 
                           cafile => '/etc/ldap/cacert.pem' ) or die $@; 
my $mesg = $ldap->bind; 
$mesg = $ldap->search( base    => "ou=people,dc=example,dc=com", 
                    filter  => "(uid=$username)", 
      ); 
$mesg->code && die $mesg->error; 

my $searchResults = $mesg->count;   
die "Error! Username already exists!" unless $searchResults == 0; 

$mesg = $ldap->search ( base   => "ou=people,dc=example,dc=com", 
                       attrs  => [ 'uidNumber' ], 
                     ); 
my @entries = $mesg->sorted('uidNumber'); 
my $entry = pop @entries; 
my $newuid = $entry->get_value( 'uidNumber' ); 
$newuid++; 

my  $result = $ldap->add("uid=$username,ou=people,dc=example,dc=com",  
              attr => [ 'cn'            => $realname, 
                         'uid'           => $userid, 
                         'uidNumber'     => $newuid, 
                         'mail'          => '$username@example.com', 
                         'homeDirectory' => '/home/$username', 
                         'objectclass'   => [ 'person', 'inetOrgPerson', 
                                              'posixAccount' ] 
                       ] 
         ); 

$mesg = $ldap->unbind; 

