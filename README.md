
perlinfo.json
=============

`perlinfo.json.pl` is a single file CGI script that you can deploy on a web
to get information about the installed perl.

The information is collected using [Config::Perl::V][Config::Perl::V] and the
output is in JSON to be parsable by some future tools or JavaScript code.
The script embeds (using [App::FatPacker][App::FatPacker]) both
`Config::Perl::V` and [JSON::PP][JSON::PP] so it has no dependency besides
modules distributed with perl itself.

   [Config::Perl::V]: https://metacpan.org/module/Config::Perl::V
   [App::FatPacker]: https://metacpan.org/module/App::FatPacker
   [JSON::PP]: https://metacpan.org/module/JSON::PP

### Building

Travis: [![Build status](https://travis-ci.org/dolmen/perlinfo.json.png?branch=master)](https://travis-ci.org/dolmen/perlinfo.json)


    git clone https://github.com/dolmen/perlinfo.json.git
    cd perlinfo.json
    cpanm App::FatPacker JSON::PP Config::Perl::V
    ./build.pl

You can now use perlinfo.json.pl either from the command-line or as a CGI
that you can deploy on a web host (often in a `cgi-bin` directory).

### Examples

[SourceForge.net](http://dolmen.users.sourceforge.net/cgi-bin/perlinfo.json)

### Copyright & license

Copyright 2013 Olivier Mengué.

`perlinfo.json.pl` (the result of `build.pl`) is distributed under the GNU
Affero General Public License version 3 or later. See [COPYING](COPYING) for
details.

