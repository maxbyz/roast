use v6;
use Test;

plan 20;

# adapted from t/operators/eq.t and t/operators/cond.t
# relational ops are in relational.t
# cmp, leq, <=>, etc. are in comparison.t

#L<S03/Chaining binary precedence>
#L<S03/Comparison semantics>

# string equality & inequality
ok("a" eq "a",     "eq true");
ok(!("a" eq "ab"), "eq false");
ok("a" ne "ab",    "ne true");
ok(!("a" ne "a"),  "ne false");

# potential problem cases
ok("\0" eq "\0",   "eq on strings with null chars");
ok(!("\0" eq "\0\0"),   "!eq on strings with null chars but different lengths");
ok(!("a" eq "a\0"),   "eq doesn't have null-padding semantics");
ok(!("a" eq "a "),   "eq doesn't have space-padding semantics");
ok("a" ne "a\0",   "ne doesn't have null-padding semantics");
ok("a" ne "a ",   "ne doesn't have space-padding semantics");

# string context on undefined values
my $foo;
#?rakudo todo "+Any() doesn't work yet"
ok($foo eq "",     "Any eq ''");
ok($foo ne "f",    "Any ne 'f'");

my @foo;
ok(@foo[0] eq "",  "Array Any eq ''");
ok(@foo[0] ne "f",  "Array Any ne 'f'");

# numeric equality & inequality
ok(2 == 2,         "== true");
ok(!(2 == 3),      "== false");
ok(2 != 3,         "!= true");
ok(!(2 != 2),      "!= false");

#L<S03/Negated relational operators>
ok(2 !== 3,         "!== true");
ok(!(2 !== 2),      "!== false");
ok($foo !eq "f",    "!eq true");
ok(!($foo !eq ""),  "!eq false");

# numeric context on undefined values
#?rakudo skip "+Any doesn't work yet"
ok($foo == 0,      "Any == 0");
ok(@foo[0] == 0,   "Array Any == 0");

# XXX: need tests for coercion string and numeric coercions

# vim: ft=perl6
