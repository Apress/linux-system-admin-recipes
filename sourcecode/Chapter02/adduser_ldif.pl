#!/usr/bin/perl -w 
use strict; 
use Net::LDAP::LDIF; 
 
die "Usage is adduser.pl [username] [$newuid] ["realname"]\n" if 
length(@ARGV) != 2; 

my $username = $ARGV[0]; 
my $newuid      = $ARGV[1]; 
my $realname  = $ARGV[2]; 

# Open a file for writing to - the w option 
my $ldif = Net::LDAP::LDIF->new( "file.ldif", "w"); 

my $entry = Net::LDAP::Entry->new(); 
 
# set DN 
$entry->dn("uid=$userid,ou=people,dc=example,dc=com"); 
# You can add attributes all at once, or in as many operations as you like 
$entry->add ( 
    'cn'            => $realname, 
    'uid'           => $userid, 
    'uidNumber'     => $newuid, 
    'mail'          => "$userid@example.com", 
    'homeDirectory' => "/home/$userid", 
    'objectclass'   => [ 'person', 'inetOrgPerson', 
                         'posixAccount' ] 
 ); 
# Write the entry to the LDIF file 
$ldif->write_entry($entry); 
