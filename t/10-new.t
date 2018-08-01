#!perl -wT

use strict;

use Test::Most tests => 2;

use File::Print::Many;

isa_ok(File::Print::Many->new(), 'File::Print::Many', 'Creating File::Print::Many object');
ok(!defined(File::Print::Many::new()));
