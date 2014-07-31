use strict;
use warnings;

use Test::More;
use Test::WWW::Mechanize;

plan tests => 3;

my $url = 'http://blogs.perl.org/';

my $w = Test::WWW::Mechanize->new;
$w->get_ok($url);

# TODO: the dash is some unicode character
$w->title_like(qr/^blogs.perl.org . blogging the onion$/);
is ord substr($w->title, 15, 1), 8212;

