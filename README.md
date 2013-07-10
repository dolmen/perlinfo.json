
perlinfo.json
=============

`perlinfo.json.pl` is a single file CGI script that you can deploy on a web
to get information about the installed perl.

The information is collected using `[Config::Perl::V][1]` and the output is
in JSON to be parsable by some future tools or JavaScript code.
The script embeds (using `[App::FatPacker][2]`) both `Config::Perl::V` and
`[JSON::PP][3]` so it has no dependency besides modules distributed with perl
itself.

    [1]: https://metacpan.org/module/Config::Perl::V
    [2]: https://metacpan.org/module/App::FatPacker
    [3]: https://metacpan.org/module/JSON::PP

### Building

    git clone https://github.com/dolmen/perlinfo.json.git
    cd perlinfo.json
    cpanm App::FatPacker JSON::PP Config::Perl::V
    ./build.pl

You can now use perlinfo.json.pl either from the command-line or as a CGI
that you can deploy on a web host (often in a `cgi-bin` directory).

### Copyright & license

Copyright 2013 Olivier Mengué.

`perlinfo.json.pl` (the result of `build.pl`) is distributed under the GNU
Affero General Public License version 3 or later. See [COPYING](COPYING) for
details.

