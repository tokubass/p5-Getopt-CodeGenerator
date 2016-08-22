use Test::More;
use strict;
use warnings;
use Getopt::CodeGenerator;

subtest 'multi' => sub {
    my @argv = (qw/ --foo 1 b --bar --opt-name1 /);

    my $gen = Getopt::CodeGenerator->new(@argv);
    my $opt = shift @$gen;
    is($opt->opt_name, 'foo');
    is_deeply($opt->value, [1,'b']);
    is($opt->value_key, 'foo');
    is($opt->value_range, '{2}');
    is($opt->value_type, '=s');

    $opt = shift @$gen;
    is($opt->opt_name, 'bar');
    is($opt->value, '');
    is($opt->value_key, 'bar');
    is($opt->value_range, '');
    is($opt->value_type, '');

    $opt = shift @$gen;
    is($opt->opt_name, 'opt-name1');
    is($opt->value, '');
    is($opt->value_key, 'opt_name1');
    is($opt->value_range, '');
    is($opt->value_type, '');
};

done_testing;

