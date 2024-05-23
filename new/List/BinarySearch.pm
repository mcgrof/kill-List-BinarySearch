# Copyright Luis Chamberlain <mcgrof@kernel.org>, 2024
# // SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
#
# Simple List::BinarySearch numeric BinarySearch.pm replacement.
#
# This is a re-write of our own binary search, reducing the scope to support
# only digits as that's all need. We also provide tests under t/*.t to ensure
# compatibility and a larger list of examples and test cases.
#
# This uses perl v5.20 subroutine signatures to let us be pedantic about the
# arguments used.

package List::BinarySearch;

use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
use Scalar::Util qw(looks_like_number);

require Exporter;
use vars qw (@ISA @EXPORT);

@ISA    = qw(Exporter);
@EXPORT = qw(&binsearch_pos_num &binsearch_range_num);

sub binsearch_pos_num($target, $aref) {
	die "Only numbers allowed" unless looks_like_number($target);
	die "Expected an array reference!" unless ref $aref eq 'ARRAY';

	my ($low, $high) = (0, scalar @$aref - 1);

	while ($low <= $high) {
		my $mid = int(($low + $high) / 2);
		if ($aref->[$mid] < $target) {
			$low = $mid + 1;
		} elsif ($aref->[$mid] > $target) {
			$high = $mid - 1;
		} else {
			return $mid;
		}
	}

	return $low;
}

# Returns an inclusive range for both, if you only use one return
# value, you consume the last value.
sub binsearch_range_num ($low_target, $high_target, $aref) {
	die "Only numbers allowed" unless looks_like_number($low_target);
	die "Only numbers allowed" unless looks_like_number($high_target);
	die "Expected an array reference!" unless ref $aref eq 'ARRAY';

	my $index_low  = binsearch_pos_num($low_target, $aref);
	my $index_high = binsearch_pos_num($high_target, $aref);

	if($index_high == scalar @$aref or $aref->[$index_high] > $high_target) {
		$index_high--;
	}

	return ($index_low, $index_high);
}

1;
