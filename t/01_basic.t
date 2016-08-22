use Test::More;
use strict;
use warnings;
use Getopt::CodeGenerator;

subtest 'number' => sub {
    my @argv = ([qw/ --foo 10 /],[qw/ --foo=10 /]);

    for my $arg (@argv) {
        my $gen = Getopt::CodeGenerator->new(@$arg);
        my $opt = shift @$gen;
        is($opt->opt_name, 'foo');
        is($opt->value, 10);
        is($opt->value_key, 'foo');
        is($opt->value_range, '');
        is($opt->value_type, '=i');
    }
};
subtest 'string' => sub {
    my @argv = (qw/ --foo aa /);

    my $gen = Getopt::CodeGenerator->new(@argv);
    my $opt = shift @$gen;
    is($opt->opt_name, 'foo');
    is($opt->value, 'aa');
    is($opt->value_key, 'foo');
    is($opt->value_range, '');
    is($opt->value_type, '=s');
};
subtest 'mix type' => sub {
    my @argv = (qw/ --foo aa 10/);

    my $gen = Getopt::CodeGenerator->new(@argv);
    my $opt = shift @$gen;
    is($opt->opt_name, 'foo');
    is_deeply($opt->value, ['aa', 10]);
    is($opt->value_key, 'foo');
    is($opt->value_range, '{2}');
    is($opt->value_type, '=s');
};

done_testing;
