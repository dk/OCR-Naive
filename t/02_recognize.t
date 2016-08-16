#! /usr/bin/perl
# $Id: 02-recognize.t,v 1.2 2007/08/21 05:18:47 dk Exp $

use strict;
use warnings;

use Test::More tests => 6;

use Prima::noX11;
use File::Basename;
use OCR::Naive qw(:all);

my $f;

# 1
$f = dirname($0) . '/02.dict';
ok( -f $f, 'have dict file');
die "Can't find 02.dict" unless -f _;

# 2
my $db = load_dictionary( $f);
ok( $db, "load dictionary " . ( $db ? ": $!" : ''));
die "Can't load 02.dict" unless $db;

# 3
ok( 1 < scalar(keys %$db), "db is loaded correctly");

# 4
$f = dirname($0) . '/02.png';
ok( -f $f, 'have png file');
die "Can't find 02.png, go away" unless -f _;

# 5
my $i = Prima::Image-> load( $f);
ok( $i, "can load png " . ($@ ? ": $@" : ''));
die "Can't load png, go away" unless $i;

# 6
$i = enhance_image($i);
my @text = recognize( $i, $db, minspace => 12); # font is ibm vio 12x30
my $text = $text[0] || '';
ok( $text eq 'use OCR::Naive');
