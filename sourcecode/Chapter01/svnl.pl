#!/usr/bin/perl -w 
# svnl.pl: script to add labels to SVN commit message 
# usage: svnl.pl A|B|C “commit message” 
# Juliet Kemp 23.03.2009 

use strict; 

die 'usage: svnl.pl A|B|C "commit message"' if $#ARGV > 1; 

my $label   = $ARGV[0]; 
my $msg     = $ARGV[1] || ""; 
my $project; 

if    ( $label eq "A" )    { $project = "Project Able:"; } 
elsif ( $label eq "B" )    { $project = "Project Beta: "; } 
elsif ( $label eq "C" )    { $project = "Project Code:"; } 
else                       { $project = "Other: $label"; } 

`svn commit -m "$project $msg"`; 
 
