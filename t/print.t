#!perl -w

use strict;
use warnings;
use autodie;
use Test::Most tests => 4;
use Test::NoWarnings;
use Test::TempDir::Tiny;

BEGIN {
	use_ok('File::Print::Many');
}

PRINT: {
	my $tempdir = tempdir();

	open(my $fout1, '>', "$tempdir/f1");
	open(my $fout2, '>', "$tempdir/f2");

	my $many = File::Print::Many->new([ $fout1, $fout2 ]);

	# print $many 'hello, ', "world!\n";
	$many->print('hello, ', "world!\n");

	close $fout1;
	close $fout2;

	open(my $fin, '<', "$tempdir/f1");
	my $contents;
	while(<$fin>) {
		$contents .= $_;
	}
	close($fin);
	ok($contents eq "hello, world!\n");

	open($fin, '<', "$tempdir/f2");
	$contents = undef;
	while(<$fin>) {
		$contents .= $_;
	}
	close($fin);
	ok($contents eq "hello, world!\n");
}
