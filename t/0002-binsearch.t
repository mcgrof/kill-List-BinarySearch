#!/usr/bin/perl

use strict;
use warnings;

use List::BinarySearch qw(binsearch_pos);
use List::BinarySearch qw(binsearch_range);
use Test::More;
use Test::Exception;

my @ints = (100, 200, 300, 400, 500);

sub dummy_sub { return (1, 2, 3, 4); }

sub test_binsearch_pos {

	throws_ok {
		binsearch_pos('a', [1, 2, 3]);
	} qr/Only numbers allowed/, "binsearch_pos dies if a string is used as the first argument";

	throws_ok {
		binsearch_pos(3, "foo");
	} qr/Expected an array reference!/, "binsearch_pos dies if the second argument is not an array ref";

	my @empty_array = ();
	is(binsearch_pos(1, \@empty_array), 0,
		"an empty array means we should place the item at index 0, that was returned as expected");

        is(binsearch_pos(100, \@ints), 0, "target 5 at position 0 as expected");
        is(binsearch_pos(200, \@ints), 1, "target 200 found at position 1 as expected");
	is(binsearch_pos(50, [100, 200, 300, 400]), 0, 'target 50 needs to be added at pos 0');
	is(binsearch_pos(150, [100, 200, 300, 400]), 1, 'target 150 needs to be added at pos 1');
};

sub test_binsearch_range {
	throws_ok {
		binsearch_range('a', 'b', [1, 2, 3]);
	} qr/Only numbers allowed/, "binsearch_range dies if a string is used as the first argument";

	throws_ok {
		binsearch_range(1, 'b', [1, 2, 3]);
	} qr/Only numbers allowed/, "binsearch_range dies if a string is used as the second argument";

	throws_ok {
		binsearch_range(3, 2, "foo");
	} qr/Expected an array reference!/, "binsearch_range dies if the third argument is not an array ref";

	# is() will only grok the last value returned here
	is(dummy_sub(), 4, "Testing the last element");

	# These capture only the last value returned by binsearch_range()
	# as it returns two values, only the last value is captured here.
        is(binsearch_range(200, 500, [100,200,300,400]), 3, "binsearch_range: adjusts foir overshooting range");
        is(binsearch_range(200, 500, [100,200,300,400,500]), 4, "binsearch_range: adjusts foir overshooting range");
        is(binsearch_range(200, 500, \@ints), 4, "binsearch_range: adjusts foir overshooting range and calls variable");
        is(binsearch_range(200, 350, [100,200,300,400]), 2, "binsearch_range: corret range when upper bound is in-bounds but not found");

	# This tests both expected return values from binsearch_range()
	is_deeply([binsearch_range(200, 500, [100, 200, 300, 400])], [1, 3], "binsearch_range: correct indices for 200 and 500");

	is_deeply([binsearch_range(150, 350, [100, 200, 300, 400])], [1, 2], "give a proper low and high");
	is_deeply([binsearch_range(50, 450, [100, 200, 300, 400])], [0, 3], "Low below, high above range: 50 to 450");
	is_deeply([binsearch_range(10, 50, [100, 200, 300, 400])], [0, -1], "Both targets below range: 10 to 50");

	# Ensure elements in the list are returned
	is_deeply([binsearch_range(200, 300, [100, 200, 300, 400])], [1, 2], "exact index match for 200 and 300");
	is_deeply([binsearch_range(100, 400, [100, 200, 300, 400])], [0, 3], 'exact index match for 100 and 400');

	# Tests odd combinations to ensure we relaim compatible with the
	# old List::BinarySearch
	is_deeply([binsearch_range(200, 500, [100, 200, 300, 400])], [1, 3], '200 inside, 500 beyond');
	is_deeply([binsearch_range(50, 150, [100, 200, 300, 400])], [0, 0], 'odd case that returns same index');
	is_deeply([binsearch_range(150, 150, [100, 200, 300, 400])], [1, 0], 'might make you say wtf, implementation compatibility');
	is_deeply([binsearch_range(10, 50, [100, 200, 300, 400])], [0, -1], 'make the corner case even stranger, implementation compatibility');
}

test_binsearch_pos();
test_binsearch_range();

done_testing();
