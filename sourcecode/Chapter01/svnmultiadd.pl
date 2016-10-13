#!/usr/bin/perl -w 
# 
# Script to add multiple files to Subversion by running SVN status and 
# asking for confirmation. 
# Usage: svnmultiadd.pl "message" 
# Juliet Kemp  04.03.2009 

use strict; 

die "Usage: svnmultiadd 'message'\n" if $#ARGV != 0; 

my $msg = " -m '$ARGV[0]'"; 

my $filelist; 
my $all; 
open ( SVN, "svn status 2>&1 |" ) or die ("Couldn't get svn status: $!"); 
while (<SVN>) { 
   die "Not a SVN working copy directory" if (/not a working copy/);; 
  my ($status, $file) = split; 
  next unless $status eq "?"; 
  unless ($all) { 
      print "Add $file? (Y/n/all/end) :"; 
      my $add = <STDIN>; 
      chomp $add; 
      last if $add eq "end"; 
      next if ($add eq "n") || ($add eq "N"); 
      ($all = 1) if $add eq "all"; 
  } 
  $filelist .= "$file "; 
} 

print "Adding files $filelist \nGo ahead? (Y/n)\n"; 
my $confirm = <STDIN>; 
chomp $confirm; 
if ( $confirm =~ /[^Yy$]/ ) { 
  `svn add $filelist; svn commit $msg`; 
} else { 
   print "Add cancelled.\n"; 
} 
 
