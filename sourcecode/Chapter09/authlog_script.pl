#!/usr/bin/perl -w 
use strict; 
my $inputfile = "/var/log/auth.log"; 
my $outputfile = "~/authlogout.txt"; 
my $searchstring = "192.168"; 
open (INPUT, "<$inputfile"); 
open (OUTPUT, ">$outputfile"); 
while (<INPUT>) { 
      print OUTPUT if ! /$searchstring/; 
} 
close INPUT; 
close OUTPUT; 
