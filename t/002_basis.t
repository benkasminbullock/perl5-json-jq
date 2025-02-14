# -*- perl -*-
use Test::More tests => 11;

use strict;
use warnings;

use blib;
use FindBin;

use JSON::JQ;
use JSON qw/to_json/;

my $jq1 = JSON::JQ->new({ script => '.' });

my $input101 = { key1 => 'val1' };
my $input101_expected = $input101;
is_deeply($jq1->process({ data => $input101 }), $input101_expected);

my $input102 = { key1 => [ 'val1', 'val2' ] };
my $input102_expected = $input102;
is_deeply($jq1->process({ data => $input102 }), $input102_expected);

my $input103 = { key1 => { key2 => 'val2' }, key3 => [ 'val3', 'val4' ]  };
my $input103_expected = $input103;
is_deeply($jq1->process({ data => $input103 }), $input103_expected);

my $input104 = { key1 => { key2 => { key3 => 'val3', key4 => 'val4' }, key5 => [ 'val5', 'val6' ] }, key6 => 'val7' };
my $input104_expected = $input104;
is_deeply($jq1->process({ data => $input104 }), $input104_expected);

my $input105 = { key1 => '你好' };
my $input105_expected = $input105;
is_deeply($jq1->process({ data => $input105 }), $input105_expected);

my $input106 = { key1 => \do { my $a = 0 }, key2 => \do { my $b = 1 } };
my $input106_expected = { key1 => JSON::false(), key2 => JSON::true() };
is_deeply($jq1->process({ data => $input106 }), $input106_expected);

my $input107 = { key1 => JSON::false(), key2 => JSON::true() };
my $input107_expected = $input107;
is_deeply($jq1->process({ data => $input107 }), $input107_expected);

my $input108 = { key1 => 3.141592653589793238462643383279502884197169399375105820974944592307816406286 };
my $input108_expected = $input108;
is_deeply($jq1->process({ data => $input108 }), $input108_expected);

my $input109 = { key1 => undef };
my $input109_expected = $input109;
is_deeply($jq1->process({ data => $input109 }), $input109_expected);

my $input110 = undef;
my $input110_expected = undef;
is_deeply($jq1->process({ data => $input110 }), $input110_expected);

my $input111 = '{ "key1": null }';
my $input111_expected = { key1 => undef };
is_deeply($jq1->process({ json => $input111 }), $input111_expected);