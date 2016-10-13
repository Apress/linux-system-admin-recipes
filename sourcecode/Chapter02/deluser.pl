#!/usr/bin/perl -w 
use strict; 
use Net::LDAPS; 

die "Usage is deluser.pl [username] if length(@ARGV) != 0; 

my $username = $ARGV[0]; 
 

my $ldap = Net::LDAPS->new( 'ldapserver.example.com', 
                             verify => 'optional', 
                            cafile => '/etc/ldap/cacert.pem' ) or die $@; 
my $mesg = $ldap->bind; 

$mesg = $ldap->delete("uid=$username,ou=people,dc=example,dc=com"); 

$mesg = $ldap->unbind; 

