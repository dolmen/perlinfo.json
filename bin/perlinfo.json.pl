#!/usr/bin/env perl

use strict;
use warnings;

use Config::Perl::V ();
use JSON::PP ();

if ($ENV{GATEWAY_INTERFACE}) {
    print "Content-Type: application/json\015\012\015\012"
}


my $config = do {
    # If we are fatpacked a CODEREF has been inserted into @INC,
    # so we remove it
    local @INC = grep { ! ref } @INC;
    Config::Perl::V::myconfig()
};

print JSON::PP->new->ascii->pretty->encode($config);

