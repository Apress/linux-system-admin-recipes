#!/usr/bin/perl -w 
use strict; 
use Net::LDAPS; 
 
my $ldapserver = 'ldapserver.example.com'; 
my $base         = 'ou=people,dc=example,dc=com'; 
my $oldhome  = 'homeserver:/homedisk/'; 
my $newhome = 'newserver:/newhome/'; 

my $ldap = Net::LDAPS->new( $ldapserver, 
                            verify => 'optional', 
                            cafile => '/etc/ldap/cacert.pem' ) or die $@; 
my $mesg = $ldap->bind; 

$mesg = $ldap->search( base    => $base, 
                         filter  => "automountInformation=*$oldhome*", 
                          attrs   => [ 'dn', 'cn', 'automountInformation' 
], 
                        ); 
my @entries = $mesg->entries; 
 
 foreach my $entry ( @entries ) { 
        my $cn = $entry->get_value( 'cn' ); 
        $mesg = $ldap->modify( $entry,  
                      replace => { 'automountInformation' =>  
                                   '-fstype=nfs,rw $newhome$cn'  } ); 
} 

$mesg = ldap->unbind 

