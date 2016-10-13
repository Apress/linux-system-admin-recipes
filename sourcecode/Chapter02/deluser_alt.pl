#!/usr/bin/perl -w 
use strict; 
use Net::LDAPS; 

die "Usage is deluser.pl [username]\n" if length(@ARGV) != 0; 

my $username = $ARGV[0]; 

my $ldap = Net::LDAPS->new( 'ldapserver.example.com', 
                            verify => 'optional', 
                           cafile => '/etc/ldap/cacert.pem' ) or die $@; 
my $mesg = $ldap->bind; 
 
my $entry = Net::LDAP::Entry->new; 
# Need to specify the DN of the entry 
$entry->dn("uid=$username,ou=people,dc=example,dc=com"); 
$entry->delete; 
$entry->update( $ldap ); 
$mesg = $ldap->unbind; 


