package  Getopt::CodeGenerator::OptStruct;
use strict;
use warnings;
use Class::Accessor::Lite (
    rw  => [qw/opt_name value/],
);
use Scalar::Util qw/looks_like_number/;
use List::MoreUtils qw/all/;

sub new {
    my $class = shift;
    bless {
        opt_name => '',
        value => '',
    }, $class;
}

sub value_key {
    my $self = shift;
    $self->{opt_name} =~ s/-/_/gr;
}

sub value_range {
    my $self = shift;
    my $value = $self->value;

    if (ref $value eq 'ARRAY') {
        $self->{value_range} = '{'. scalar @$value .'}';
    }
}

sub value_type {
    my $self = shift;
    return '=i' if($self->is_number);
    return ''   if $self->is_flag;
    return '=s';
}

sub is_value {
    return defined $_[1] && $_[1] !~ m/\A--/;
}

sub is_number {
    if (ref $_[0]->value eq 'ARRAY') {
        if (all { looks_like_number($_) } @{$_[0]->value}) {
            return 1; 
        }
    }else{
        looks_like_number($_[0]->value);
    }
}

sub is_flag {
    return $_[0]->value eq '';
}

1; 
