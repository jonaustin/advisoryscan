#!/usr/bin/perl -w
use strict;

while(<>) { 
    if (/^package/) { 
        close FILE;
        my @line = split(/ /, $_);
        my @packages = split(/:/, $line[1]);
        chomp($packages[-1]); # remove newline
        chop($packages[-1]);  # remove ;
        my $path = "";
        for my $package (@packages[0..$#packages-1]) {
            # create a directory if one doesn't exist
            $path .= "$package/";
            mkdir $path unless ( -e $path );
        }
        open FILE, ">", "${path}/${packages[-1]}.pm";
    }
print FILE unless /########/;
}
