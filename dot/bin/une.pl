#!/usr/bin/perl -w
use strict ;
use URI::Escape ;
 
my $encoded = `xsel -o`;
my $unencoded = uri_unescape( $encoded ) ;
print "$unencoded !\n" ;
