#!/usr/bin/perl -X

##IT TAKES THE GRAMMAR AS INPUT AND PROCESS SOME CHANGES BEFORE COMPILING
use strict;
use warnings;
use File::Basename;

binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
binmode STDERR, ':utf8';
use utf8;
use open qw(:std :utf8);

my $file = shift(@ARGV);
open (my $FILE, $file) or die "The file '$file' cannot be open: $!\n";

my $N=10 ; #number of times [ ]+ and [ ]* are applied


$/ = "%";
while (my $rule = <$FILE>) {
	if ($rule !~ /(\]\+)|(\]\*)/) {
		print $rule;
	}else {
		my @lines = split ('\n', $rule);
		for (my $l = 0; $l <= $#lines; $l++) {
			my $line = $lines[$l];
			if ($line !~ /(\]\+)|(\]\*)/) {
				print "$line\n";
			} else {
				my ($dep, $pattern) = ($line =~ /([^:]+):([\w\W ]+)/);
				my @pattern = split (" ", $pattern);
				print "$dep: ";
				for (my $i = 0; $i <= $#pattern; $i++) {
					if ($pattern[$i] ne "") {      
						my $tag = $pattern[$i];
						if ($tag  =~ /(\]\+)$|(\]\*)$/)  {
							PrintNtimes($tag,$N);
						} else {
							print  "$tag ";
						}
					}
				}
			print "\n"; 
			}
		}
	}
} 


sub PrintNtimes {
	my ($x,$n) = @_ ;
	my $k = 0;
	my $y = "";
	for (my $k = 1; $k <= $n; $k++) {
		if ($x  =~ /(\]\+)$/ && $k==1)  { 
			$y = $x;
			$y =~ s/(\+$)//;
			print "$y ";
		} else { 
			$x =~ s/(\+$)|(\*$)/?/;
			print "$x ";
		}
	}
	return 1 ;
}
