use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'          => 'Blogs',
    'VERSION_FROM'  => 'lib/Blogs.pm',
    'PREREQ_PM'     => {
                           'Test::More'           => '1.00',
                           'Test::WWW::Mechanize' => 0,
                        },
    ABSTRACT_FROM => 'lib/Blogs.pm',
    AUTHOR        => 'Gabor Szabo <szabgab@cpan.org>',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),

    (eval { ExtUtils::MakeMaker->VERSION(6.46) }
      ? (META_MERGE => {
          resources => {
            repository => 'http://github.com/szabgab/test.blogs.perl.org',
          }
        })
      : ()
    ),
);
