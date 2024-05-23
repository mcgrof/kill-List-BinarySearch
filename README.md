copyleft-next replacement for List-BinarySearch
===============================================

List::BinarySearch is ancient and has a few issues:

  a) The project hasnt't received any updates since 2018
  b) It's licensed under GPLv1 or Artistica v1 license which are
     not compatible with GPLv2
  c) Some distributions don't carry a package for it

Debian in particular doesn't have it anymore. I looked at the code
and was bewildered with the amount of insane hacks to support ancient
versions of perl and to also support running our custom comparison
routine.

All the above challenges seem silly to deal with on users if we can
just implement what we need and call it a day. So let's provide a clear
source for a new replacement for List::BinarySearch. We do this by
giving a new home to a replacement library and making the license clear.

We provide a set of tests which keep it compatible with the old implementation.
We don't care to provide a full cpan perl module replacement, but patches
welcome to do that if anyone cares. This repository exists just to provide a
test unit home to ensure backward compatibility with the old library.

Testing correctness
===================

```bash
make test
```

This tests both the old and then the new library. You can therefore focus on
correctness by just expanding the test unit once, and if both work then we have
parity.

Replacing the code
==================

The new library is simple and self contained to only allow digit arrays.
The way to replace it may look like this in your patch:

{{{
-       my ($lowidx, $highidx) = binsearch_range { $a <=> $b }  $low, $high, @{$dataref};
+       my ($lowidx, $highidx) = binsearch_range_num($low, $high, $dataref);
}}}

Where $dataref is an array of digits.
