use strict;
use warnings;

use Test::More;
use Test::Selenium::Remote::Driver;

plan tests => 1;

my $url = 'http://blogs.perl.org/';

my $s = Test::Selenium::Remote::Driver->new;
#diag $s->server_is_running;
subtest main_page => sub {
	plan tests => 9;
	$s->get_ok($url);
	$s->body_text_contains(q{There's more than one way to blog it.});

	# TODO: links/has_link/follow_link ?
	my $link = $s->find_element('Sign In', 'link_text');
	#diag $link;  # Test::Selenium::Remote::WebElement
	$link->click_ok();

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

	#diag $s->find_child_element($form, './div[@id="signin_with_mt"]', 'xpath');
	#sleep 2;
};

