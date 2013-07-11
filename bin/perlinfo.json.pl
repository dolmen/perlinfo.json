#!/usr/bin/env perl

use strict;
use warnings;

package App::PerlInfoJSON;
our $VERSION = '0.002';

use Config::Perl::V ();
use JSON::PP ();


sub loaded_module_versions
{
    no strict 'refs';

    my $module_versions = shift || {};
    my $package = shift || '';
    my $stash = shift || \%{$package.'::'};

    my $glob;
    if (exists $stash->{'VERSION'}
	&& defined *{$glob = $stash->{'VERSION'}}{'SCALAR'}) {

	$module_versions->{$package} = ${$glob} if defined ${$glob};
    }

    foreach my $k (grep { substr($_, -2) eq '::' } keys %$stash) {
	next if "${package}::$k" eq '::main::';
	loaded_module_versions(
	    $module_versions,
	    ($package ? ($package.'::'.substr($k, 0, -2)) : substr($k, 0, -2)),
	    $stash->{$k});
    }

    return $module_versions
}




if ($ENV{GATEWAY_INTERFACE}) {
    print "Content-Type: application/json\015\012\015\012"
}


my $config = Config::Perl::V::myconfig();
# If we are fatpacked a CODEREF has been inserted into @INC,
# so we remove it
$config->{inc} = [ grep { ! ref } @{$config->{inc}} ];


# Inject info about ourself
# This gives information about some available modules (that have been loaded
# to run this script) without any I/O cost.
$config->{+__PACKAGE__} = {
    versions => loaded_module_versions(),
};

print JSON::PP->new->canonical->ascii->pretty->encode($config);

