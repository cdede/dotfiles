#!/usr/bin/perl
# uncode to utf8
use Encode;  
$str=`xsel -o`;
$str =~ s/\\u([0-9a-fA-F]{4})/pack("U",hex($1))/eg;  
$str = encode( "utf8", $str );
print $str;
