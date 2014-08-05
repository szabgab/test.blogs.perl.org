use strict;
use warnings;

use Test::More;
use Test::Selenium::Remote::Driver;

plan tests => 1;

my $url = 'http://blogs.perl.org/';

my $s = Test::Selenium::Remote::Driver->new(
	#browser_name => 'safari',  # was launched headless(?) but it seems the click_ok did not update the $s object.
	browser_name => 'firefox',
	#browser_name => 'chrome',
	# follow the instructions at https://github.com/gempesaw/Selenium-Remote-Driver/wiki/Chrome-browser-automation
	# before enabling chrome

	#browser_name => 'opera',
);
#diag $s->server_is_running;
subtest main_page => sub {
	plan tests => 12;
	$s->get_ok($url);
	#diag $s->get_page_source;
	#diag $s->get_body;
	$s->body_text_contains(q{There's more than one way to blog it.});
	$s->body_text_contains('Sign In');


	# TODO: links/has_link/follow_link ?
	my $login_link = $s->find_element('Sign In', 'link_text');
	#diag $login_link;  # Test::Selenium::Remote::WebElement
	$login_link->click_ok();
	#diag $s->get_page_source;

	$s->body_text_contains(q{Sign in using...});

	my $form = $s->find_element('form', 'tag_name');
	#diag $form->get_text;
	is $form->get_attribute('action'), "${url}mt/mt-cp.fcgi";
	#my $username = $s->find_element('//input[@id="username"]', 'xpath');
	#my $username = $s->find_child_element($form, './input[@id="username"]', 'xpath'); # cannot locate element
	#my $username = $s->find_child_element($form, "./input[\@id='username']", 'xpath'); # cannot locate element
	my $username = $s->find_child_element($form, '//input[@id="username"]', 'xpath');
	is $username->get_attribute('name'), 'username';
	is $username->get_attribute('class'), 'ti';

	my $password = $s->find_child_element($form, '//input[@id="password"]', 'xpath');
	is $password->get_attribute('name'), 'password';
	is $password->get_attribute('class'), 'pw';

	$s->go_back_ok;

	my $page2_link = $s->find_element('Page 2', 'partial_link_text');
	$page2_link->click_ok();

	#diag $s->find_child_element($form, './div[@id="signin_with_mt"]', 'xpath');
	#sleep 2;
};

