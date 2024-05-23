#!/usr/bin/perl

use strict;
use warnings;

use List::BinarySearch;
use Test::More;

can_ok('List::BinarySearch', 'binsearch_pos');
can_ok('List::BinarySearch', 'binsearch_range');

done_testing();
