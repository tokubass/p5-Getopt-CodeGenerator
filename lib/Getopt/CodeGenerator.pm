package Getopt::CodeGenerator;
use strict;
use warnings;
use Text::MicroTemplate;
use Getopt::CodeGenerator::OptStruct;

sub import {
    my $class = shift;
    if (@_) {
        my $self = $class->new(split(" ",$_[0]));
        print $self->generate_code;
    }

    # for oneliner
    if ($0 eq '-') {
        exit 0;
    }
}

sub new {
    my $class = shift;
    my $opts = get_opts(@_);
    bless $opts, $class;
}

sub get_opts {
    my @argv = map { split '=', $_ } @_;
    my @data;

    while(defined(my $opt_name = shift @argv)) {
        next if $opt_name eq '--';
        
        if ($opt_name =~ s/\A--//) {
            my $struct = Getopt::CodeGenerator::OptStruct->new;
            $struct->opt_name($opt_name);

            my $i = 0;
            for (@argv) {
                last unless $struct->is_value($_);
                $i++;
            }

            if ($i == 1) {
                $struct->value(splice(@argv,0,1));
            }elsif ($i > 1) {
                $struct->value([splice(@argv,0,$i)]);
            }
            
            push @data,$struct;
                
            next;
        }
        die 'expect option name. but got ', "$opt_name";
    }

    return \@data;

}


sub generate_code {
    my $self = shift;
    my $renderer =  Text::MicroTemplate->new(
        template => do { local $/; <DATA> },
        escape_func  => undef,
    )->build;
    $renderer->($self);
}


1; 

=encoding utf-8

=head1 NAME

 Getopt::CodeGenerator - for Getopt::Long code geenerator

=head1 SYNOPSIS

 $ perl -Ilib -MGetopt::CodeGenerator='--foo a  --bar 2 --mix 1 a --dry-run'
 use Getopt::Long qw(:config posix_default no_ignore_case gnu_compat);
 my %opt;
 my $res = GetOptions(
     'foo=s' => \$opt{foo},
     'bar=i' => \$opt{bar},
     'mix=s{2}' => \@{$opt{mix}},
     'dry-run' => \$opt{dry_run},
 );

=head1 LICENSE

Copyright (C) tokubass.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

tokubass E<lt>tokubass {at} cpan.orgE<gt>

=cut

__DATA__
use Getopt::Long qw(:config posix_default no_ignore_case gnu_compat);
my %opt;
my $res = GetOptions(
? for my $struct  (@{$_[0]}) {
?    if($struct->value_range) {
    '<?= $struct->opt_name . $struct->value_type . $struct->value_range ?>' => \@{$opt{<?= $struct->value_key ?>}},
?    }
?    else{
    '<?= $struct->opt_name . $struct->value_type . $struct->value_range ?>' => \$opt{<?= $struct->value_key ?>},
?    }
? }
);
