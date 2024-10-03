#!/bin/perl
# To create sitemap.txt from local directory
# 20241003 Simon Avery - free to anyone who wants it.
# Usage: create_sitemap.pl https://domain.co.uk/ 
# Works from start of local directory

use strict;

my $output_sitemap = "sitemap.txt";

print "Creating sitemap of fles below current directory into $output_sitemap\n";
my $files_found=0;
my $files_included=0;
my $domain = $ARGV[0];

if (! $domain) {
    print "Error: Supply the URL prefix. Eg: $0 https://mydomain.com/\n";
    exit 1;
    }

open(FH, '>', $output_sitemap) or die $!;
foreach ('.') { &process_files_in($_); } 

close(FH);

print "Complete. $files_found files found, of which $files_included were included in ./sitemap.txt\n";

exit 0; 
    
sub process_files_in { 
    my $dir=shift; 
    return unless (-d $dir && ! -l $dir); 
    $dir =~ s!^\./!!; 
    warn "cannot traverse directory $dir\n" 
    unless (opendir D,$dir); 
    my @files = map {$dir.'/'.$_} grep {!m/^\.{1,2}$/} readdir D; 
    closedir D; 
    foreach (@files) { 
        if (-l $_) { warn "Not processing symlink $_\n"; } 
    elsif (-d $_) { &process_files_in($_); } 
    elsif (-f $_) { &process_file($_); } 
    else          { warn "Not processing file $_\n"; } 
    } 
} 
    
sub process_file { 
    my $filename = shift; 
    $files_found++;
    $filename =~ m/\.([a-z]+)$/;

    print "Found: $filename\n";

    my $extension = lc($1);

    if ( ( $extension eq 'htm' ) || ($extension eq 'html') ) { 

        # Special check for ./index.html - when we find it, we remove the filename
        if ( $filename eq './index.html') {
            print "Found index.html! Removing to just leave domain\n";
            print FH $domain . "\n";
            return;
            }

        # Remove leading ./ if exists in top tier filenames
        my $firstchar = substr $filename, 0, 1;

        if ($firstchar =~ /\./) {
         #   print "Stripping leading ./ from $filename\n";
            my $filename2 = substr($filename, 2);
            $filename = $filename2;
            }

        print "VALID Path! $domain" . "$filename\n";
        $files_included++;
        print FH $domain . $filename . "\n";
        }
       
} 
