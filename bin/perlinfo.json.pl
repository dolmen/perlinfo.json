#!/usr/bin/env perl

use strict;
use warnings;

package App::PerlInfoJSON;
our $VERSION = '0.001';

use Config::Perl::V ();
use JSON::PP ();

if ($ENV{GATEWAY_INTERFACE}) {
    print "Content-Type: application/json\015\012\015\012"
}


my $config = Config::Perl::V::myconfig();
# If we are fatpacked a CODEREF has been inserted into @INC,
# so we remove it
$config->{inc} = [ grep { ! ref } @{$config->{inc}} ];

# Inject info about ourself
$config->{+__PACKAGE__} = {
    version => $VERSION,
};

print JSON::PP->new->ascii->pretty->encode($config);

