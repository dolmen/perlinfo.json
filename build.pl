#!/usr/bin/env perl

use 5.010;
use utf8;
use strict;
use warnings;

use App::FatPacker ();
use Module::CoreList;

{
    package Packer;
    BEGIN { our @ISA = ('App::FatPacker') }

    sub trace
    {
	my $self = shift;
	my @modules =
	    grep {
		/\.pm$/ && $_ ne 'Config.pm' && do {
		    (my $mod = substr($_, 0, -3)) =~ s{/}{::}gs;
		    ! $Module::CoreList::version{"5.010001"}{$mod}
		}
	    }
	    split /\r?\n/, $self->SUPER::trace(@_);

	#say STDERR $_ for @modules;

	return join("\n", @modules) . "\n"
    }
}



open my $script, '>:raw', 'perlinfo.json.pl';
my $stdout = select $script;

# Use /bin/sh as a launcher to be independent of the perl location
print $script <<'EOF';
#!/bin/sh
#! -*- perl -*-
eval 'exec perl -x $0 ${1+"$@"}'
    if 0;
EOF

print $script Packer->script_command_pack([ 'bin/perlinfo.json.pl' ]);
close $script;
select $stdout;

foreach (qw<Config/Perl/V.pm JSON/PP.pm>) {
    unless (-f "fatlib/$_") {
	unlink 'perlinfo.json.pl';
	die "install $_ from CPAN to have the packlist installed!\n";
    }
}

chmod 0755, 'perlinfo.json.pl';

say 'Done.';
