#!/usr/bin/perl -w 
use strict; 
use Net::LDAPS; 

my $ldap = Net::LDAPS->new( 'ldapserver.example.com', 
                           verify => 'optional', 
                            cafile => '/etc/ldap/cacert.pem' ) or die $@; 
my $mesg = $ldap->bind; 

$mesg = $ldap->search( base    => "ou=people,dc=example,dc=com", 
                        filter  => "mail=*", 
                         attrs   => [ 'uid', 'mail' ], 
                       ); 
my @entries = $mesg->entries; 

foreach my $entry ( @entries ) { 
       $mesg = $ldap->modify( $entry, replace => { 'mail' => 
'$uid@mail.example.com'  
} ); 
}

$mesg = ldap->unbind 

