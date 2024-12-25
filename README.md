# Bash Data Structures & Miscellanea

BDSM is a library for those insane enough to use bash as a general-purpose
programming language.

## Notes on the coding style

Apart from strings, bash only has two data structures: arrays (indexed by
integers), and associative arrays (indexed by strings). This library does
not use normal arrays whatsoever, as they are backed by linked lists and
therefore have terrible performance characteristics. Instead, you will
see associative arrays that happen to use (stringified) integers as keys.

If a function takes a reference as an argument, you will see all local
variables start their name with `_`. This is to reduce the chance of a
naming conflict making the reference resolve to the wrong variable.
As such, it is Very Much Not Recommended to pass variables that themselves
start with `_` as reference.
