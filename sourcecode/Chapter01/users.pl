#!/usr/bin/perl -w 
# Script to print non-system user lines from /etc/passwd 
# JK 25.03.2009 

use strict; 

# Declare subroutines before they're used; this one is defined after 
# the main script logic, lines 25-29.  You could if you preferred define 
# it here. 
sub printuser; 

die "Usage: $0" unless @ARGV == 0; 

my $file = "/etc/passwd"; 

open FILE, $file; 
while ( <FILE> ) { 
    my @userarray = split /:/; 
    if ( $userarray[2] && ( $userarray[2] >= 1000 ) ) { 
        printuser(@userarray); 
    } 
} 
close FILE; 

sub printuser { 
    my @userarray = @_; 
    my $userline = join "\t", @userarray; 
    print "$userline\n"; 
} 

