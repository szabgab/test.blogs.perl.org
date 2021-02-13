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
	# once in a while this seem to return success...
	ok !$resp->is_success or diag $resp->content;
	ok !$w->success, 'failure';
	is $w->status, '404';
};


subtest pages => sub {
	#plan tests => 1;

	my $resp = $w->get($url);  # returns HTTP::Response
	ok $resp->is_success;
	is $w->status, '200';

	my $download_link = $w->find_link( text => 'Download Perl' );
	is $download_link->url, 'http://www.perl.org/get.html';

	# this call which should be probably invalid as there was only one paramter passed
	# returns a link while it should probably throw an exception?
	my $link = $w->find_link( 'Perl 5 wikix');
	diag $link->url;

	my $p5_wiki = $w->find_link( text  => 'Perl 5 wikix');
	diag $p5_wiki;
	ok !$p5_wiki, 'There should not be a p5 wiki link';

$w->autodie(1);  # during development

	# TODO: Explore link

};

