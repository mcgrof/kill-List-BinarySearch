#!/usr/bin/perl

use strict;
use warnings;

use List::BinarySearch;
use Test::More;

can_ok('List::BinarySearch', 'binsearch_pos_num');
can_ok('List::BinarySearch', 'binsearch_range_num');

done_testing();
