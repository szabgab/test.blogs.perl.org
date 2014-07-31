use strict;
use warnings;

use Test::More;
use Test::Selenium::Remote::Driver;

plan tests => 1;

my $url = 'http://blogs.perl.org/';

my $s = Test::Selenium::Remote::Driver->new;
diag $s->server_is_running;
$s->get_ok($url);


