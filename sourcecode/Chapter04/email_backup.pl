#!/usr/bin/perl -w 
 
use strict; 
use Archive::Tar; 
use File::Find; 
use MIME::Lite; 
use Net::SMTP; 
 
sub sendmail(); 
sub wanted(); 

my $email        = 'my.name@gmail.com'; 
my $from         = 'my.address@example.com'; 
my $smtpserver   = "smtp.example.com"; 
my @archive_list; 
my $backup_dir   = "/home/jkemp/personal/"; 
my $tarfile      = "/home/jkemp/gmailtar.tgz"; 
 
find ( \&wanted, $backup_dir ); 
Archive::Tar->create_archive($tarfile, "1", @archive_list); 
sendmail(); 

sub wanted() { 
    return unless -f $File::Find::name; 
    push @archive_list, $File::Find::name; 
} 

sub sendmail() { 
    my $msg = MIME::Lite->new(To   => $email, 
              From => $from, 
                              Subject => "Backup email", 
                              Type  => "multipart/mixed"); 
    $msg->attach(Type  => "application/gzip", 
                 Path  => $tarfile, 
                 Filename  => "gmailtar.tgz"); 
    $msg->send('smtp', $smtpserver); 
} 

