#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use Getopt::Long;

my $t_warn = $ENV{T_WARN} // 50;
my $t_crit = $ENV{T_CRIT} // 80;
my $label  = $ENV{LABEL}  // "";

sub help {
    print "Usage: cpu_usage [-w <warning>] [-c <critical>]\n";
    print "-w <percent>: warning threshold to become yellow\n";
    print "-c <percent>: critical threshold to become red\n";
    exit 0;
}

GetOptions("help|h" => \&help,
           "w=i"    => \$t_warn,
           "c=i"    => \$t_crit,
);

$ENV{LC_ALL} = "en_US";

my @core_usage;
my $max_usage = 0;

open(MPSTAT, 'mpstat -P ALL 1 1 |') or die;
while (<MPSTAT>) {
    if (/^\d+:\d+:\d+\s+(?:AM|PM)?\s*(\d+)\s+.*\s+(\d+\.\d+)[\s\x00]?$/) {
        my $core  = $1;
        my $usage = 100 - $2;
        push @core_usage, $usage;
        $max_usage = $usage if $usage > $max_usage;
    }
}
close(MPSTAT);

die "Can't find CPU information" unless @core_usage;

# Map a usage percentage to a single hex digit (0-F), floored
# 0% -> 0, 100% -> F, linear scale
sub to_hex_digit {
    my ($pct) = @_;
    my $val = int($pct / 100 * 16);
    $val = 15 if $val > 15;  # clamp for exactly 100%
    return sprintf "%X", $val;
}

my $output = $label . join("", map { to_hex_digit($_) } @core_usage);

print "$output\n";

if ($max_usage >= $t_crit) {
    print "#FF0000\n";
    exit 33;
} elsif ($max_usage >= $t_warn) {
    print "#FFFC00\n";
}

exit 0;
