# NAME

    Getopt::CodeGenerator - for Getopt::Long code geenerator

# SYNOPSIS

    $ perl -Ilib -MGetopt::CodeGenerator='--foo a  --bar 2 --mix 1 a --dry-run'
    use Getopt::Long qw(:config posix_default no_ignore_case gnu_compat);
    my %opt;
    my $res = GetOptions(
        'foo=s' => \$opt{foo},
        'bar=i' => \$opt{bar},
        'mix=s{2}' => \@{$opt{mix}},
        'dry-run' => \$opt{dry_run},
    );

# LICENSE

Copyright (C) tokubass.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

tokubass &lt;tokubass {at} cpan.org>
