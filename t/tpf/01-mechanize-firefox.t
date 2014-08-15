use strict;
use warnings;

use Test::More;
use WWW::Mechanize::Firefox;

my $w = eval { WWW::Mechanize::Firefox->new };
if ($@) {
	plan skip_all => "MozRepl does not seem to be running: $@";
}
my $url = 'http://news.perlfoundation.org/';

plan tests => 2;

subtest invalid_page => sub {
	eval {
		$w->get("$url/xyz");
	};
	like $@, qr/^Not Found /;
	ok !$w->success, 'failure';
};

subtest pages => sub {
	my $resp = $w->get($url);  # returns HTTP::Response
	ok $resp->is_success;
}

