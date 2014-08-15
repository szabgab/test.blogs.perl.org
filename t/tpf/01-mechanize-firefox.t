use strict;
use warnings;

use Test::More;
use WWW::Mechanize::Firefox;

my $w = eval { WWW::Mechanize::Firefox->new( autodie => 1 ) };
if ($@) {
	plan skip_all => "MozRepl does not seem to be running: $@";
}
my $url = 'http://news.perlfoundation.org/';

plan tests => 3;

# We have this just to make sure the success was set to True once before we testing the 404 error.
subtest pages1 => sub {
	#plan tests => 3;

	my $resp = $w->get($url);  # returns HTTP::Response
	ok $resp->is_success;
	ok $w->success;
	is $w->status, '200';
};

subtest invalid_page => sub {
	#plan tests => 3;

	$w->autodie(0);
	my $resp = $w->get("$url/xyz");
	ok !$resp->is_success;
	ok !$w->success, 'failure';
	is $w->status, '404';
};

$w->autodie(1);  # during development

subtest pages => sub {
	#plan tests => 1;

	my $resp = $w->get($url);  # returns HTTP::Response
	ok $resp->is_success;
	is $w->status, '200';

};

