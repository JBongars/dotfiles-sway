#!/usr/bin/perl
#
# Copyright 2014 Pierre Mavro <deimos@deimos.fr>
# Copyright 2014 Vivien Didelot <vivien@didelot.org>
# Copyright 2014 Andreas Guldstrand <andreas.guldstrand@gmail.com>
#
# Licensed under the terms of the GNU GPL v3, or any later version.
use strict;
use warnings;
use utf8;
use Getopt::Long;

my $t_warn = $ENV{T_WARN} // 50;
my $t_crit = $ENV{T_CRIT} // 80;
my $decimals = $ENV{DECIMALS} // 0;
my $label = $ENV{LABEL} // "";

sub help {
    print "Usage: cpu_usage [-w <warning>] [-c <critical>] [-d <decimals>]\n";
    print "-w <percent>: warning threshold to become yellow\n";
    print "-c <percent>: critical threshold to become red\n";
    print "-d <decimals>: Use <decimals> decimals for percentage (default is $decimals)\n";
    exit 0;
}

GetOptions("help|h" => \&help,
           "w=i"    => \$t_warn,
           "c=i"    => \$t_crit,
           "d=i"    => \$decimals,
);

$ENV{LC_ALL} = "en_US";

my @core_usage;
my $max_usage = 0;

open(MPSTAT, 'mpstat -P ALL 1 1 |') or die;
while (<MPSTAT>) {
    # Match individual cores (skip the "all" line)
    if (/^\d+:\d+:\d+\s+(?:AM|PM)?\s*(\d+)\s+.*\s+(\d+\.\d+)[\s\x00]?$/) {
        my $core = $1;
        my $usage = 100 - $2;
        push @core_usage, $usage;
        $max_usage = $usage if $usage > $max_usage;
    }
}
close(MPSTAT);

die 'Can\'t find CPU information' unless @core_usage;

# Format output
my $output = $label . join(" ", map { sprintf "%02.${decimals}f%%", $_ } @core_usage);

# Print full_text and short_text
print "$output\n";
print "$output\n";

# Print color based on highest core usage
if ($max_usage >= $t_crit) {
    print "#FF0000\n";
    exit 33;
} elsif ($max_usage >= $t_warn) {
    print "#FFFC00\n";
}

exit 0;
