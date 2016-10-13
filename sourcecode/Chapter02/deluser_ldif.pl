#!/usr/bin/perl -w 
use strict; 
use Net::LDAP::LDIF; 

# Open a file for reading from - the r option 
my $ldif = Net::LDAP::LDIF->new( "file.ldif", "r"); 

my $ldap = Net::LDAPS->new( 'ldapserver.example.com', 
                            verify => 'optional', 
                           cafile => '/etc/ldap/cacert.pem' ) or die $@; 
my $mesg = $ldap->bind; 

while( not $ldif->eof ( ) ) { 
   $entry = $ldif->read_entry ( ); 
   if ( $ldif->error ( ) ) { 
           print "Error msg: ", $ldif->error ( ), "\n"; 
           print "Error lines:\n", $ldif->error_lines ( ), "\n"; 
   } else { 
           $mesg = $ldap->delete($entry); 
   } 
 } 
$mesg = $ldap->unbind; 
