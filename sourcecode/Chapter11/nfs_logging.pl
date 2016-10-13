#!/usr/bin/perl -w 
# JK 10.01.2008 

use strict; 
use Net::Ping; 
use Net::SMTP; 
use Time::HiRes; 
use POSIX qw(stfrtime); 

my $server = "nfsserver"; 
my $file       = "/home/jkemp/sysadmin/nfs_response.log"; 

# Ping server and record time and response time 
my $ping = Net::Ping->new(); 
$ping->hires(); 
my ($ret, $duration, $ip) = $ping->ping($server, 5.5); 
open FILE, ">>$file"; 
print FILE ((strftime "%b-%d-%H:%M:%S", localtime), " "); 
printf FILE ("%.3f\n", 1000 * $duration); 
close FILE; 

