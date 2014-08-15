use strict;
use warnings;

use Test::More;
use WWW::Mechanize::Firefox;

my $w = eval { WWW::Mechanize::Firefox->new };
if ($@) {
	plan skip_all => "MozRepl does not seem to be running: $@";
}
my $url = 'http://news.perlfoundation.org/';

plan tests => 3;

subtest pages1 => sub {
	#plan tests => 3;

	my $resp = $w->get($url);  # returns HTTP::Response
	ok $resp->is_success;
	ok $w->success;
	is $w->status, '200';
};

subtest invalid_page => sub {
	#plan tests => 3;

	eval {
		$w->get("$url/xyz");
	};
	like $@, qr/^Not Found /; # Is it really supposed to throw an exception?
	# apparently sometimes this does not throw exception (and sets the status to 200)
	ok !$w->success, 'failure';
	is $w->status, '404';
};

subtest pages => sub {
	plan tests => 1;

	my $resp = $w->get($url);  # returns HTTP::Response
	ok $resp->is_success;
};

