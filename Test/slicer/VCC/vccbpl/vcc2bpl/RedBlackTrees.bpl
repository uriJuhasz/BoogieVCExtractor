axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^Node: $ctype;

axiom $is_composite(^Node);

axiom $ptr_level(^Node) == 0;

axiom $sizeof(^Node) == 40;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Node) } $inv2(#s1, #s2, #p, ^Node) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty())));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^Node, #r), l#public) } $inv_lab(#s2, $ptr(^Node, #r), l#public) == ($typed(#s2, $ptr(^Node, #r)) && $set_eq($owns(#s2, $ptr(^Node, #r)), $set_empty())));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^Node, #r)) } $in_full_extent_of(#q, $ptr(^Node, #r)) == (#q == $ptr(^Node, #r) || #q == $dot($ptr(^Node, #r), Node.$owns) || #q == $dot($ptr(^Node, #r), Node.red) || #q == $dot($ptr(^Node, #r), Node.key) || #q == $dot($ptr(^Node, #r), Node.value) || #q == $dot($ptr(^Node, #r), Node.left) || #q == $dot($ptr(^Node, #r), Node.right) || #q == $dot($ptr(^Node, #r), Node.parent)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Node, #r)) } $in_extent_of(#s, #q, $ptr(^Node, #r)) == $in_struct_extent_of(#q, $ptr(^Node, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Node, #r)) } $typed(#s, $ptr(^Node, #r)) ==> $in_extent_of(#s, #q, $ptr(^Node, #r)) == (#q == $ptr(^Node, #r) || $emb(#s, #q) == $ptr(^Node, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^Node, #r)) } $in_span_of(#q, $ptr(^Node, #r)) == (#q == $ptr(^Node, #r) || #q == $dot($ptr(^Node, #r), Node.$owns) || #q == $dot($ptr(^Node, #r), Node.red) || #q == $dot($ptr(^Node, #r), Node.key) || #q == $dot($ptr(^Node, #r), Node.value) || #q == $dot($ptr(^Node, #r), Node.left) || #q == $dot($ptr(^Node, #r), Node.right) || #q == $dot($ptr(^Node, #r), Node.parent)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^Node) } $state_spans_the_same(#s1, #s2, #p, ^Node) == ($mem_eq(#s1, #s2, $dot(#p, Node.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Node.red)) && $mem_eq(#s1, #s2, $dot(#p, Node.key)) && $mem_eq(#s1, #s2, $dot(#p, Node.value)) && $mem_eq(#s1, #s2, $dot(#p, Node.left)) && $mem_eq(#s1, #s2, $dot(#p, Node.right)) && $mem_eq(#s1, #s2, $dot(#p, Node.parent))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Node) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Node) == ($mem_eq(#s1, #s2, $dot(#p, Node.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Node.red)) && $mem_eq(#s1, #s2, $dot(#p, Node.key)) && $mem_eq(#s1, #s2, $dot(#p, Node.value)) && $mem_eq(#s1, #s2, $dot(#p, Node.left)) && $mem_eq(#s1, #s2, $dot(#p, Node.right)) && $mem_eq(#s1, #s2, $dot(#p, Node.parent))));

axiom $is_claimable(^Node) == false;

axiom $has_volatile_owns_set(^Node) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^Node, #r)) } $extent_mutable(#s1, $ptr(^Node, #r)) == $mutable(#s1, $ptr(^Node, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^Node, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^Node, #r)) == $is_fresh(#s1, #s2, $ptr(^Node, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^Node, #r)) } $extent_zero(#s1, $ptr(^Node, #r)) == ($mem(#s1, $dot($ptr(^Node, #r), Node.red)) == 0 && $mem(#s1, $dot($ptr(^Node, #r), Node.key)) == 0 && $mem(#s1, $dot($ptr(^Node, #r), Node.value)) == 0 && $mem(#s1, $dot($ptr(^Node, #r), Node.left)) == 0 && $mem(#s1, $dot($ptr(^Node, #r), Node.right)) == 0 && $mem(#s1, $dot($ptr(^Node, #r), Node.parent)) == 0));

const unique Node.$owns: $field;

axiom $static_field_properties(Node.$owns, ^Node);

axiom $is_primitive_non_volatile_field(Node.$owns);

axiom (forall #p: $ptr :: { $dot(#p, Node.$owns) } $is(#p, ^Node) ==> $dot(#p, Node.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, Node.$owns)) && $extent_hint($dot(#p, Node.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.$owns)) } { $st(#s, $dot(#p, Node.$owns)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.$owns, ^$#ptrset, false));

axiom $owns_set_field(^Node) == Node.$owns;

const unique Node.red: $field;

axiom $static_field_properties(Node.red, ^Node);

axiom $is_primitive_non_volatile_field(Node.red);

axiom $field_offset(Node.red) == 0;

axiom (forall #p: $ptr :: { $dot(#p, Node.red) } $is(#p, ^Node) ==> $dot(#p, Node.red) == $ptr(^^bool, $ref(#p) + 0) && $extent_hint($dot(#p, Node.red), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.red)) } { $st(#s, $dot(#p, Node.red)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.red, ^^bool, false));

const unique Node.key: $field;

axiom $static_field_properties(Node.key, ^Node);

axiom $is_primitive_non_volatile_field(Node.key);

axiom $field_offset(Node.key) == 4;

axiom (forall #p: $ptr :: { $dot(#p, Node.key) } $is(#p, ^Node) ==> $dot(#p, Node.key) == $ptr(^^i4, $ref(#p) + 4) && $extent_hint($dot(#p, Node.key), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.key)) } { $st(#s, $dot(#p, Node.key)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.key, ^^i4, false));

const unique Node.value: $field;

axiom $static_field_properties(Node.value, ^Node);

axiom $is_primitive_non_volatile_field(Node.value);

axiom $field_offset(Node.value) == 8;

axiom (forall #p: $ptr :: { $dot(#p, Node.value) } $is(#p, ^Node) ==> $dot(#p, Node.value) == $ptr(^^i4, $ref(#p) + 8) && $extent_hint($dot(#p, Node.value), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.value)) } { $st(#s, $dot(#p, Node.value)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.value, ^^i4, false));

const unique Node.left: $field;

axiom $static_field_properties(Node.left, ^Node);

axiom $is_primitive_non_volatile_field(Node.left);

axiom $field_offset(Node.left) == 16;

axiom (forall #p: $ptr :: { $dot(#p, Node.left) } $is(#p, ^Node) ==> $dot(#p, Node.left) == $ptr($ptr_to(^Node), $ref(#p) + 16) && $extent_hint($dot(#p, Node.left), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.left)) } { $st(#s, $dot(#p, Node.left)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.left, $ptr_to(^Node), false));

const unique Node.right: $field;

axiom $static_field_properties(Node.right, ^Node);

axiom $is_primitive_non_volatile_field(Node.right);

axiom $field_offset(Node.right) == 24;

axiom (forall #p: $ptr :: { $dot(#p, Node.right) } $is(#p, ^Node) ==> $dot(#p, Node.right) == $ptr($ptr_to(^Node), $ref(#p) + 24) && $extent_hint($dot(#p, Node.right), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.right)) } { $st(#s, $dot(#p, Node.right)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.right, $ptr_to(^Node), false));

const unique Node.parent: $field;

axiom $static_field_properties(Node.parent, ^Node);

axiom $is_primitive_non_volatile_field(Node.parent);

axiom $field_offset(Node.parent) == 32;

axiom (forall #p: $ptr :: { $dot(#p, Node.parent) } $is(#p, ^Node) ==> $dot(#p, Node.parent) == $ptr($ptr_to(^Node), $ref(#p) + 32) && $extent_hint($dot(#p, Node.parent), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.parent)) } { $st(#s, $dot(#p, Node.parent)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.parent, $ptr_to(^Node), false));

const unique ^Tree: $ctype;

axiom $is_composite(^Tree);

axiom $ptr_level(^Tree) == 0;

axiom $sizeof(^Tree) == 8;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Tree) } $inv2(#s1, #s2, #p, ^Tree) == ($typed(#s2, #p) && !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr_cast($null, ^Node))) && ($ptr_neq($read_ptr(#s2, $dot(#p, Tree.root), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node)))) && ($ptr_neq($read_ptr(#s2, $dot(#p, Tree.root), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot(#p, Tree.root), ^Node), Node.parent), ^Node), $null)) && (forall Q#m$1^82.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($ptr_cast($null, ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1)))) && (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem(#s2, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) < $mem(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key))) && (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem(#s2, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) > $mem(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key))) && (forall Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } { F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1))) } { sk_hack(F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) == $set_in($ptr(^Node, Q#m$1^82.29#dt1), $owns(#s2, #p))) && (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1)))) && (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1)))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node)))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node)))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node)))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.left), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)) || $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.right), ^Node), $ptr(^Node, Q#n$1^82.29#dt1))) && (forall Q#n$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#n$1^82.29#dt1)))) && (forall Q#m$1^83.29#dt1: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem(#s2, $dot(#p, Tree.abs))), $mem(#s2, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem(#s2, $dot(#p, Tree.abs))), $mem(#s2, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) == $mem(#s2, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.value))) && (forall Q#k$1^83.29#tc2: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem(#s2, $dot(#p, Tree.abs))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $mem(#s2, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem(#s2, $dot(#p, Tree.abs))), Q#k$1^83.29#tc2) == 0) && (forall Q#n$1^84.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && $ptr_eq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) || $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $read_ptr(#s2, $dot(#p, Tree.root), ^Node))) && (forall Q#n$1^84.29#dt1: int, Q#m$1^84.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && (($ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) && $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr_cast($null, ^Node))) || $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr(^Node, Q#n$1^84.29#dt1)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))))))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^Tree, #r), l#public) } $inv_lab(#s2, $ptr(^Tree, #r), l#public) == ($typed(#s2, $ptr(^Tree, #r)) && !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr_cast($null, ^Node))) && ($ptr_neq($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node)))) && ($ptr_neq($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node), Node.parent), ^Node), $null)) && (forall Q#m$1^82.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($ptr_cast($null, ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1)))) && (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem(#s2, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) < $mem(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key))) && (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem(#s2, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) > $mem(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key))) && (forall Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } { F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1))) } { sk_hack(F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) == $set_in($ptr(^Node, Q#m$1^82.29#dt1), $owns(#s2, $ptr(^Tree, #r)))) && (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1)))) && (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1)))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node)))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node)))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node)))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.left), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)) || $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.right), ^Node), $ptr(^Node, Q#n$1^82.29#dt1))) && (forall Q#n$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#n$1^82.29#dt1)))) && (forall Q#m$1^83.29#dt1: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem(#s2, $dot($ptr(^Tree, #r), Tree.abs))), $mem(#s2, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem(#s2, $dot($ptr(^Tree, #r), Tree.abs))), $mem(#s2, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) == $mem(#s2, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.value))) && (forall Q#k$1^83.29#tc2: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem(#s2, $dot($ptr(^Tree, #r), Tree.abs))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $mem(#s2, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem(#s2, $dot($ptr(^Tree, #r), Tree.abs))), Q#k$1^83.29#tc2) == 0) && (forall Q#n$1^84.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && $ptr_eq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) || $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))) && (forall Q#n$1^84.29#dt1: int, Q#m$1^84.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && (($ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) && $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr_cast($null, ^Node))) || $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr(^Node, Q#n$1^84.29#dt1)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))))))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^Tree, #r)) } $in_full_extent_of(#q, $ptr(^Tree, #r)) == (#q == $ptr(^Tree, #r) || #q == $dot($ptr(^Tree, #r), Tree.$owns) || #q == $dot($ptr(^Tree, #r), Tree.root) || #q == $dot($ptr(^Tree, #r), Tree.abs) || #q == $dot($ptr(^Tree, #r), Tree.R)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Tree, #r)) } $in_extent_of(#s, #q, $ptr(^Tree, #r)) == $in_struct_extent_of(#q, $ptr(^Tree, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Tree, #r)) } $typed(#s, $ptr(^Tree, #r)) ==> $in_extent_of(#s, #q, $ptr(^Tree, #r)) == (#q == $ptr(^Tree, #r) || $emb(#s, #q) == $ptr(^Tree, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^Tree, #r)) } $in_span_of(#q, $ptr(^Tree, #r)) == (#q == $ptr(^Tree, #r) || #q == $dot($ptr(^Tree, #r), Tree.$owns) || #q == $dot($ptr(^Tree, #r), Tree.root) || #q == $dot($ptr(^Tree, #r), Tree.abs) || #q == $dot($ptr(^Tree, #r), Tree.R)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^Tree) } $state_spans_the_same(#s1, #s2, #p, ^Tree) == ($mem_eq(#s1, #s2, $dot(#p, Tree.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Tree.root)) && $mem_eq(#s1, #s2, $dot(#p, Tree.abs)) && $mem_eq(#s1, #s2, $dot(#p, Tree.R))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Tree) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Tree) == ($mem_eq(#s1, #s2, $dot(#p, Tree.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Tree.root)) && $mem_eq(#s1, #s2, $dot(#p, Tree.abs)) && $mem_eq(#s1, #s2, $dot(#p, Tree.R))));

axiom $is_claimable(^Tree) == false;

axiom $has_volatile_owns_set(^Tree) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^Tree, #r)) } $extent_mutable(#s1, $ptr(^Tree, #r)) == $mutable(#s1, $ptr(^Tree, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^Tree, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^Tree, #r)) == $is_fresh(#s1, #s2, $ptr(^Tree, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^Tree, #r)) } $extent_zero(#s1, $ptr(^Tree, #r)) == ($mem(#s1, $dot($ptr(^Tree, #r), Tree.root)) == 0 && $mem(#s1, $dot($ptr(^Tree, #r), Tree.abs)) == 0 && $mem(#s1, $dot($ptr(^Tree, #r), Tree.R)) == 0));

const unique Tree.$owns: $field;

axiom $static_field_properties(Tree.$owns, ^Tree);

axiom $is_primitive_non_volatile_field(Tree.$owns);

axiom (forall #p: $ptr :: { $dot(#p, Tree.$owns) } $is(#p, ^Tree) ==> $dot(#p, Tree.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, Tree.$owns)) && $extent_hint($dot(#p, Tree.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Tree.$owns)) } { $st(#s, $dot(#p, Tree.$owns)) } $typed2(#s, #p, ^Tree) ==> $field_properties(#s, #p, Tree.$owns, ^$#ptrset, false));

axiom $owns_set_field(^Tree) == Tree.$owns;

const unique Tree.root: $field;

axiom $static_field_properties(Tree.root, ^Tree);

axiom $is_primitive_non_volatile_field(Tree.root);

axiom $field_offset(Tree.root) == 0;

axiom (forall #p: $ptr :: { $dot(#p, Tree.root) } $is(#p, ^Tree) ==> $dot(#p, Tree.root) == $ptr($ptr_to(^Node), $ref(#p) + 0) && $extent_hint($dot(#p, Tree.root), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Tree.root)) } { $st(#s, $dot(#p, Tree.root)) } $typed2(#s, #p, ^Tree) ==> $field_properties(#s, #p, Tree.root, $ptr_to(^Node), false));

const unique Tree.abs: $field;

axiom $static_field_properties(Tree.abs, ^Tree);

axiom $is_primitive_non_volatile_field(Tree.abs);

axiom (forall #p: $ptr :: { $dot(#p, Tree.abs) } $is(#p, ^Tree) ==> $dot(#p, Tree.abs) == $ptr($map_t(^^i4, ^^i4), $ghost_ref(#p, Tree.abs)) && $extent_hint($dot(#p, Tree.abs), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Tree.abs)) } { $st(#s, $dot(#p, Tree.abs)) } $typed2(#s, #p, ^Tree) ==> $field_properties(#s, #p, Tree.abs, $map_t(^^i4, ^^i4), false));

const unique Tree.R: $field;

axiom $static_field_properties(Tree.R, ^Tree);

axiom $is_primitive_non_volatile_field(Tree.R);

axiom (forall #p: $ptr :: { $dot(#p, Tree.R) } $is(#p, ^Tree) ==> $dot(#p, Tree.R) == $ptr($map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)), $ghost_ref(#p, Tree.R)) && $extent_hint($dot(#p, Tree.R), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Tree.R)) } { $st(#s, $dot(#p, Tree.R)) } $typed2(#s, #p, ^Tree) ==> $field_properties(#s, #p, Tree.R, $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)), false));

procedure Tree#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr_cast($null, ^Node)));
  ensures $is_admissibility_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node)));
  ensures $is_admissibility_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node), Node.parent), ^Node), $null);
  ensures $is_admissibility_check() ==> (forall Q#m$1^82.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr_cast($null, ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) < $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) > $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
  ensures $is_admissibility_check() ==> (forall Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } { F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1))) } { sk_hack(F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) == $set_in($ptr(^Node, Q#m$1^82.29#dt1), $owns($s, $ptr(^Tree, P#_this_))));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node))));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node))));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node))));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.left), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)) || $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.right), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
  ensures $is_admissibility_check() ==> true;
  ensures $is_admissibility_check() ==> (forall Q#m$1^83.29#dt1: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#_this_), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#_this_), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) == $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.value)));
  ensures $is_admissibility_check() ==> (forall Q#k$1^83.29#tc2: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#_this_), Tree.abs))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#_this_), Tree.abs))), Q#k$1^83.29#tc2) == 0);
  ensures $is_admissibility_check() ==> (forall Q#n$1^84.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && $ptr_eq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) || $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node)));
  ensures $is_admissibility_check() ==> (forall Q#n$1^84.29#dt1: int, Q#m$1^84.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && (($ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) && $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr_cast($null, ^Node))) || $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr(^Node, Q#n$1^84.29#dt1)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))))));
  ensures $is_unwrap_check() ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr_cast($null, ^Node)));
  ensures $is_unwrap_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node)));
  ensures $is_unwrap_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node), Node.parent), ^Node), $null);
  ensures $is_unwrap_check() ==> (forall Q#m$1^82.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr_cast($null, ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) < $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) > $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
  ensures $is_unwrap_check() ==> (forall Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } { F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1))) } { sk_hack(F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) == $set_in($ptr(^Node, Q#m$1^82.29#dt1), $owns($s, $ptr(^Tree, P#_this_))));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node))));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node))));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node))));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.left), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)) || $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.right), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
  ensures $is_unwrap_check() ==> true;
  ensures $is_unwrap_check() ==> (forall Q#m$1^83.29#dt1: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#_this_), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#_this_), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) == $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.value)));
  ensures $is_unwrap_check() ==> (forall Q#k$1^83.29#tc2: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#_this_), Tree.abs))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#_this_), Tree.abs))), Q#k$1^83.29#tc2) == 0);
  ensures $is_unwrap_check() ==> (forall Q#n$1^84.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && $ptr_eq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) || $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node)));
  ensures $is_unwrap_check() ==> (forall Q#n$1^84.29#dt1: int, Q#m$1^84.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && (($ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) && $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr_cast($null, ^Node))) || $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr(^Node, Q#n$1^84.29#dt1)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))))));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Tree#adm(P#_this_: int)
{
  var #wrTime$1^77.31: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^77.31, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^77.31, #loc._this_, $ptr_to_int($ptr(^Tree, P#_this_)), $ptr_to(^Tree)) && $local_value_is_ptr($s, #tok$1^77.31, #loc._this_, $ptr(^Tree, P#_this_), $ptr_to(^Tree));
    assume #wrTime$1^77.31 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^77.31, #p) } $in_writes_at(#wrTime$1^77.31, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^Tree, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^Tree, P#_this_));
        assume $good_state_ext(#tok$1^77.31, $s);
        // assert true; 
        assert true;
    }
    else
    {
      anon4:
        assume true;
        // if (@_vcc_is_admissibility_check) ...
        if ($is_admissibility_check())
        {
          anon2:
            // assume @_vcc_admissibility_pre(@state, _this_); 
            assume $admissibility_pre($s, $ptr(^Tree, P#_this_));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^Tree, P#_this_));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Tree*)@null))
        call $havoc_others($ptr(^Tree, P#_this_), ^Tree);
        assume $good_state_ext(#tok$1^77.31, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^Tree, P#_this_), ^Tree);
    }

  #exit:
}



function F#mark(SP#p: int) : int;

const unique cf#mark: $pure_function;

axiom (forall SP#p: int :: { F#mark(SP#p) } $ptr_eq($ptr(^Node, F#mark(SP#p)), $ptr(^Node, SP#p)));

axiom $function_arg_type(cf#mark, 0, $ptr_to(^Node));

axiom $function_arg_type(cf#mark, 1, $ptr_to(^Node));

procedure mark(SP#p: int) returns ($result: int);
  free ensures $in_range_phys_ptr($ref($ptr(^Node, $result)));
  ensures $ptr_eq($ptr(^Node, $result), $ptr(^Node, SP#p));
  free ensures $result == F#mark(SP#p);
  free ensures $call_transition(old($s), $s);



function F#doMark(SP#p: int) : bool;

const unique cf#doMark: $pure_function;

axiom (forall SP#p: int :: { F#doMark(SP#p) } F#doMark(SP#p) == $ptr_eq($ptr(^Node, F#mark($ref($ptr(^Node, SP#p)))), $ptr(^Node, SP#p)));

axiom $function_arg_type(cf#doMark, 0, ^^bool);

axiom $function_arg_type(cf#doMark, 1, $ptr_to(^Node));

procedure doMark(SP#p: int) returns ($result: bool);
  ensures $result == $ptr_eq($ptr(^Node, F#mark($ref($ptr(^Node, SP#p)))), $ptr(^Node, SP#p));
  free ensures $result == F#doMark(SP#p);
  free ensures $call_transition(old($s), $s);



function F#mark2(SP#p: int) : bool;

const unique cf#mark2: $pure_function;

axiom $function_arg_type(cf#mark2, 0, ^^bool);

axiom $function_arg_type(cf#mark2, 1, $ptr_to(^Node));

procedure mark2(SP#p: int) returns ($result: bool);
  free ensures $result == F#mark2(SP#p);
  free ensures $call_transition(old($s), $s);



procedure tree_init(P#t: int);
  modifies $s, $cev_pc;
  ensures $wrapped($s, $ptr(^Tree, P#t), ^Tree);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $span($ptr(^Tree, P#t))) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $span($ptr(^Tree, P#t))) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $span($ptr(^Tree, P#t))) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);






procedure tree_find(P#t: int, P#key: int) returns ($result: int);
  requires $wrapped($s, $ptr(^Tree, P#t), ^Tree);
  modifies $s, $cev_pc;
  free ensures $in_range_phys_ptr($ref($ptr(^Node, $result)));
  ensures $ptr_neq($ptr(^Node, $result), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, $result))) && $mem($s, $dot($ptr(^Node, $result), Node.key)) == P#key;
  ensures $ptr_eq($ptr(^Node, $result), $null) ==> (forall Q#n$1^104.53#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^104.53#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^104.53#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#n$1^104.53#dt1), Node.key)) != P#key);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation tree_find(P#t: int, P#key: int) returns ($result: int)
{
  var loopState#0: $state;
  var L#p: int where $in_range_phys_ptr(L#p);
  var #wrTime$1^101.1: int;
  var #stackframe: int;

  anon15:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^101.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^101.1, #loc.t, $ptr_to_int($ptr(^Tree, P#t)), $ptr_to(^Tree)) && $local_value_is_ptr($s, #tok$1^101.1, #loc.t, $ptr(^Tree, P#t), $ptr_to(^Tree));
    assume $local_value_is($s, #tok$1^101.1, #loc.key, P#key, ^^i4);
    assume #wrTime$1^101.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^101.1, #p) } $in_writes_at(#wrTime$1^101.1, #p) == false);
    // assume @in_range_phys_ptr((mathint)t); 
    assume $in_range_phys_ptr($ref($ptr(^Tree, P#t)));
    // assume @in_range_i4(key); 
    assume $in_range_i4(P#key);
    // assert @_vcc_in_domain(@state, t, t); 
    assert $in_domain_lab($s, $ptr(^Tree, P#t), $ptr(^Tree, P#t), l#public);
    // struct Node* p; 
    assume $local_value_is($s, #tok$1^106.3, #loc.p, $ptr_to_int($ptr(^Node, L#p)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^106.3, #loc.p, $ptr(^Node, L#p), $ptr_to(^Node));
    // var struct Node* p
    // assert @reads_check_normal((t->root)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.root), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.root), $ptr_to(^Node));
    // p := *((t->root)); 
    L#p := $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node));
    assume $local_value_is($s, #tok$1^107.3, #loc.p, $ptr_to_int($ptr(^Node, L#p)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^107.3, #loc.p, $ptr(^Node, L#p), $ptr_to(^Node));
    loopState#0 := $s;
    while (true)
      invariant $ptr_eq($ptr(^Node, L#p), $null) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, L#p))))));
      invariant (forall Q#n$1^110.31#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^110.31#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#n$1^110.31#dt1), Node.key)) == P#key && $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^110.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, L#p))), $ref($ptr(^Node, Q#n$1^110.31#dt1))));
    {
      anon14:
        assume $writes_nothing(old($s), $s);
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$1^108.3, $s);
        assume $local_value_is($s, #tok$1^108.3, #loc.key, P#key, ^^i4);
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#0, $s);
        assume true;
        // if ((_Bool)p) ...
        if ($ptr_neq($ptr(^Node, L#p), $null))
        {
          anon12:
            // assert @reads_check_normal((p->key)); 
            assert $typed2($s, $dot($ptr(^Node, L#p), Node.key), ^^i4);
            assert $thread_local2($s, $dot($ptr(^Node, L#p), Node.key), ^^i4);
            assume true;
            // if (<(key, *((p->key)))) ...
            if (P#key < $mem($s, $dot($ptr(^Node, L#p), Node.key)))
            {
              anon8:
                // assert @reads_check_normal((p->left)); 
                assert $typed2($s, $dot($ptr(^Node, L#p), Node.left), $ptr_to(^Node));
                assert $thread_local2($s, $dot($ptr(^Node, L#p), Node.left), $ptr_to(^Node));
                // p := *((p->left)); 
                L#p := $ref($read_ptr($s, $dot($ptr(^Node, L#p), Node.left), ^Node));
                assume $local_value_is($s, #tok$1^113.7, #loc.p, $ptr_to_int($ptr(^Node, L#p)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^113.7, #loc.p, $ptr(^Node, L#p), $ptr_to(^Node));
            }
            else
            {
              anon11:
                // assert @reads_check_normal((p->key)); 
                assert $typed2($s, $dot($ptr(^Node, L#p), Node.key), ^^i4);
                assert $thread_local2($s, $dot($ptr(^Node, L#p), Node.key), ^^i4);
                assume true;
                // if (>(key, *((p->key)))) ...
                if (P#key > $mem($s, $dot($ptr(^Node, L#p), Node.key)))
                {
                  anon9:
                    // assert @reads_check_normal((p->right)); 
                    assert $typed2($s, $dot($ptr(^Node, L#p), Node.right), $ptr_to(^Node));
                    assert $thread_local2($s, $dot($ptr(^Node, L#p), Node.right), $ptr_to(^Node));
                    // p := *((p->right)); 
                    L#p := $ref($read_ptr($s, $dot($ptr(^Node, L#p), Node.right), ^Node));
                    assume $local_value_is($s, #tok$1^115.7, #loc.p, $ptr_to_int($ptr(^Node, L#p)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^115.7, #loc.p, $ptr(^Node, L#p), $ptr_to(^Node));
                }
                else
                {
                  anon10:
                    // return p; 
                    $result := $ref($ptr(^Node, L#p));
                    assert $position_marker();
                    goto #exit;
                }
            }
        }
        else
        {
          anon13:
            // goto #break_10; 
            goto #break_10;
        }

      #continue_10:
        assume true;
    }

  anon16:
    assume $full_stop_ext(#tok$1^108.3, $s);

  #break_10:
    // return (struct Node*)@null; 
    $result := $ref($ptr_cast($null, ^Node));
    assert $position_marker();
    goto #exit;

  anon17:
    // empty

  #exit:
}



procedure tree_lookup(P#t: int, P#key: int) returns ($result: int);
  requires $wrapped($s, $ptr(^Tree, P#t), ^Tree);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  ensures $result == $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), P#key);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation tree_lookup(P#t: int, P#key: int) returns ($result: int)
{
  var L#r: int where $in_range_phys_ptr(L#r);
  var #wrTime$1^122.1: int;
  var #stackframe: int;

  anon20:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^122.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^122.1, #loc.t, $ptr_to_int($ptr(^Tree, P#t)), $ptr_to(^Tree)) && $local_value_is_ptr($s, #tok$1^122.1, #loc.t, $ptr(^Tree, P#t), $ptr_to(^Tree));
    assume $local_value_is($s, #tok$1^122.1, #loc.key, P#key, ^^i4);
    assume #wrTime$1^122.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^122.1, #p) } $in_writes_at(#wrTime$1^122.1, #p) == false);
    // assume @in_range_phys_ptr((mathint)t); 
    assume $in_range_phys_ptr($ref($ptr(^Tree, P#t)));
    // assume @in_range_i4(key); 
    assume $in_range_i4(P#key);
    // assert @_vcc_in_domain(@state, t, t); 
    assert $in_domain_lab($s, $ptr(^Tree, P#t), $ptr(^Tree, P#t), l#public);
    // struct Node* r; 
    assume $local_value_is($s, #tok$1^126.3, #loc.r, $ptr_to_int($ptr(^Node, L#r)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^126.3, #loc.r, $ptr(^Node, L#r), $ptr_to(^Node));
    // non-pure function
    // r := tree_find(t, key); 
    call L#r := tree_find($ref($ptr(^Tree, P#t)), P#key);
    assume $full_stop_ext(#tok$1^126.13, $s);
    assume $local_value_is($s, #tok$1^126.13, #loc.r, $ptr_to_int($ptr(^Node, L#r)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^126.13, #loc.r, $ptr(^Node, L#r), $ptr_to(^Node));
    assume true;
    // if (@_vcc_ptr_eq(r, @null)) ...
    if ($ptr_eq($ptr(^Node, L#r), $null))
    {
      anon18:
        // assert @_vcc_inv(@state, t); 
        assert $inv($s, $ptr(^Tree, P#t), ^Tree);
        // assume @_vcc_inv(@state, t); 
        assume $inv($s, $ptr(^Tree, P#t), ^Tree);
        // return 0; 
        $result := 0;
        assert $position_marker();
        goto #exit;
    }
    else
    {
      anon19:
        // assert @reads_check_normal((r->value)); 
        assert $typed2($s, $dot($ptr(^Node, L#r), Node.value), ^^i4);
        assert $thread_local2($s, $dot($ptr(^Node, L#r), Node.value), ^^i4);
        // return *((r->value)); 
        $result := $mem($s, $dot($ptr(^Node, L#r), Node.value));
        assert $position_marker();
        goto #exit;
    }

  anon21:
    // empty

  #exit:
}



procedure tree_insert(P#t: int, P#x: int);
  requires !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, P#x)));
  requires (forall Q#n$1^138.28#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^138.28#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^138.28#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#n$1^138.28#dt1), Node.key)) != $mem($s, $dot($ptr(^Node, P#x), Node.key)));
  requires $wrapped($s, $ptr(^Tree, P#t), ^Tree);
  modifies $s, $cev_pc;
  ensures (forall Q#n$1^139.27#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^139.27#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^139.27#dt1))) == ($ptr_eq($ptr(^Node, Q#n$1^139.27#dt1), $ptr(^Node, P#x)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(old($s), $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr(old($s), $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^139.27#dt1)))));
  ensures $mem(old($s), $dot($ptr(^Node, P#x), Node.key)) == $mem($s, $dot($ptr(^Node, P#x), Node.key)) && $mem(old($s), $dot($ptr(^Node, P#x), Node.value)) == $mem($s, $dot($ptr(^Node, P#x), Node.value));
  ensures $wrapped($s, $ptr(^Tree, P#t), ^Tree);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Tree, P#t) || $set_in(#p, $span($ptr(^Node, P#x))) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Tree, P#t) || $set_in(#p, $span($ptr(^Node, P#x))) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Tree, P#t) || $set_in(#p, $span($ptr(^Node, P#x))) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation tree_insert(P#t: int, P#x: int)
{
  var prestate#44: $state;
  var owns#42: $ptrset;
  var staticWrapState#41: $state;
  var prestate#43: $state;
  var res_lambda#7#20: $map_t..$ptr_to..^Node.^^bool;
  var owns#39: $ptrset;
  var staticWrapState#38: $state;
  var prestate#40: $state;
  var prestate#37: $state;
  var prestate#35: $state;
  var owns#36: $ptrset;
  var owns#33: $ptrset;
  var staticWrapState#32: $state;
  var prestate#34: $state;
  var prestate#31: $state;
  var prestate#29: $state;
  var owns#30: $ptrset;
  var #wrTime$1^168.28: int;
  var loopState#1: $state;
  var res_lambda#6#19: $map_t..$ptr_to..^Node.^^bool;
  var prestate#28: $state;
  var owns#26: $ptrset;
  var staticWrapState#25: $state;
  var prestate#27: $state;
  var res_lambda#5#18: $map_t..$ptr_to..^Node.^^bool;
  var res_lambda#4#17: $map_t..^^i4.^^i4;
  var assign#13: int where $in_range_phys_ptr(assign#13);
  var assign#12: int where $in_range_phys_ptr(assign#12);
  var prestate#24: $state;
  var L#p: int where $in_range_phys_ptr(L#p);
  var L#n: int where $in_range_phys_ptr(L#n);
  var #wrTime$1^134.1: int;
  var #stackframe: int;

  anon36:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^134.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^134.1, #loc.t, $ptr_to_int($ptr(^Tree, P#t)), $ptr_to(^Tree)) && $local_value_is_ptr($s, #tok$1^134.1, #loc.t, $ptr(^Tree, P#t), $ptr_to(^Tree));
    assume $local_value_is($s, #tok$1^134.1, #loc.x, $ptr_to_int($ptr(^Node, P#x)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^134.1, #loc.x, $ptr(^Node, P#x), $ptr_to(^Node));
    assume #wrTime$1^134.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^134.1, #p) } $in_writes_at(#wrTime$1^134.1, #p) == (#p == $ptr(^Tree, P#t) || $set_in(#p, $span($ptr(^Node, P#x)))));
    assume $thread_owned($s, $ptr(^Tree, P#t));
    assume (forall #p: $ptr :: { $extent_hint(#p, $ptr(^Node, P#x)) } $set_in(#p, $span($ptr(^Node, P#x))) ==> $mutable($s, #p));
    // assume @in_range_phys_ptr((mathint)t); 
    assume $in_range_phys_ptr($ref($ptr(^Tree, P#t)));
    // assume @in_range_phys_ptr((mathint)x); 
    assume $in_range_phys_ptr($ref($ptr(^Node, P#x)));
    // assert @_vcc_in_domain(@state, t, t); 
    assert $in_domain_lab($s, $ptr(^Tree, P#t), $ptr(^Tree, P#t), l#public);
    // struct Node* n; 
    assume $local_value_is($s, #tok$1^142.3, #loc.n, $ptr_to_int($ptr(^Node, L#n)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^142.3, #loc.n, $ptr(^Node, L#n), $ptr_to(^Node));
    // struct Node* p; 
    assume $local_value_is($s, #tok$1^142.3, #loc.p, $ptr_to_int($ptr(^Node, L#p)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^142.3, #loc.p, $ptr(^Node, L#p), $ptr_to(^Node));
    // var struct Node* p
    // var struct Node* n
    // _math state_t prestate#24; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#24, $state_to_int(prestate#24), ^$#state_t);
    // prestate#24 := @_vcc_current_state(@state); 
    prestate#24 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#24, $state_to_int(prestate#24), ^$#state_t);
    // assert @_vcc_wrapped(@state, t); 
    assert $wrapped($s, $ptr(^Tree, P#t), ^Tree);
    // assume @_vcc_inv(@state, t); 
    assume $inv($s, $ptr(^Tree, P#t), ^Tree);
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(t); 
    assert $top_writable($s, #wrTime$1^134.1, $ptr(^Tree, P#t));
    // stmt @_vcc_unwrap(t, @_vcc_typeof(t)); 
    call $unwrap($ptr(^Tree, P#t), ^Tree);
    assume $good_state_ext(#tok$1^144.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // struct Node* assign#12; 
    assume $local_value_is($s, #tok$2^0.0, #loc.assign#12, $ptr_to_int($ptr(^Node, assign#12)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$2^0.0, #loc.assign#12, $ptr(^Node, assign#12), $ptr_to(^Node));
    // struct Node* assign#13; 
    assume $local_value_is($s, #tok$2^0.0, #loc.assign#13, $ptr_to_int($ptr(^Node, assign#13)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$2^0.0, #loc.assign#13, $ptr(^Node, assign#13), $ptr_to(^Node));
    // assign#13 := (struct Node*)@null; 
    assign#13 := $ref($ptr_cast($null, ^Node));
    assume $local_value_is($s, #tok$2^0.0, #loc.assign#13, $ptr_to_int($ptr(^Node, assign#13)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$2^0.0, #loc.assign#13, $ptr(^Node, assign#13), $ptr_to(^Node));
    // assert @_vcc_typed2(@state, (x->parent)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
    // assert @prim_writes_check((x->parent)); 
    assert $writable($s, #wrTime$1^134.1, $dot($ptr(^Node, P#x), Node.parent));
    // *(x->parent) := assign#13; 
    call $write_int($dot($ptr(^Node, P#x), Node.parent), $ref($ptr(^Node, assign#13)));
    assume $full_stop_ext(#tok$1^146.24, $s);
    // assign#12 := assign#13; 
    assign#12 := $ref($ptr(^Node, assign#13));
    assume $local_value_is($s, #tok$2^0.0, #loc.assign#12, $ptr_to_int($ptr(^Node, assign#12)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$2^0.0, #loc.assign#12, $ptr(^Node, assign#12), $ptr_to(^Node));
    // assert @_vcc_typed2(@state, (x->right)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.right), $ptr_to(^Node));
    // assert @prim_writes_check((x->right)); 
    assert $writable($s, #wrTime$1^134.1, $dot($ptr(^Node, P#x), Node.right));
    // *(x->right) := assign#12; 
    call $write_int($dot($ptr(^Node, P#x), Node.right), $ref($ptr(^Node, assign#12)));
    assume $full_stop_ext(#tok$1^146.13, $s);
    // assert @_vcc_typed2(@state, (x->left)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.left), $ptr_to(^Node));
    // assert @prim_writes_check((x->left)); 
    assert $writable($s, #wrTime$1^134.1, $dot($ptr(^Node, P#x), Node.left));
    // *(x->left) := assign#12; 
    call $write_int($dot($ptr(^Node, P#x), Node.left), $ref($ptr(^Node, assign#12)));
    assume $full_stop_ext(#tok$1^146.3, $s);
    // assert @reads_check_normal((t->root)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.root), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.root), $ptr_to(^Node));
    // p := *((t->root)); 
    L#p := $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node));
    assume $local_value_is($s, #tok$1^148.3, #loc.p, $ptr_to_int($ptr(^Node, L#p)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^148.3, #loc.p, $ptr(^Node, L#p), $ptr_to(^Node));
    // (int32_t -> int32_t) res_lambda#4#17; 
    assume $local_value_is($s, #tok$1^151.14, #loc.res_lambda#4#17, $map_t..^^i4.^^i4_to_int(res_lambda#4#17), $map_t(^^i4, ^^i4));
    // assert @reads_check_normal((t->abs)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.abs), $map_t(^^i4, ^^i4));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.abs), $map_t(^^i4, ^^i4));
    // assert @reads_check_normal((x->value)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.value), ^^i4);
    assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.value), ^^i4);
    // assert @reads_check_normal((x->key)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.key), ^^i4);
    assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.key), ^^i4);
    // res_lambda#4#17 := lambda#4(*((t->abs)), *((x->value)), *((x->key))); 
    call res_lambda#4#17 := lambda#4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, P#x), Node.value)), $mem($s, $dot($ptr(^Node, P#x), Node.key)));
    assume $full_stop_ext(#tok$1^151.14, $s);
    assume $local_value_is($s, #tok$1^151.14, #loc.res_lambda#4#17, $map_t..^^i4.^^i4_to_int(res_lambda#4#17), $map_t(^^i4, ^^i4));
    // assert @_vcc_typed2(@state, (t->abs)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.abs), $map_t(^^i4, ^^i4));
    // assert @prim_writes_check((t->abs)); 
    assert $writable($s, #wrTime$1^134.1, $dot($ptr(^Tree, P#t), Tree.abs));
    // *(t->abs) := res_lambda#4#17; 
    call $write_int($dot($ptr(^Tree, P#t), Tree.abs), $map_t..^^i4.^^i4_to_int(res_lambda#4#17));
    assume $full_stop_ext(#tok$1^151.5, $s);
    // assert @writes_check(@_vcc_span(t)); 
    assert (forall #writes$1^152.5: $ptr :: { $dont_instantiate(#writes$1^152.5) } $set_in(#writes$1^152.5, $span($ptr(^Tree, P#t))) ==> $top_writable($s, #wrTime$1^134.1, #writes$1^152.5));
    // stmt _vcc_set_owns(t, @_vcc_set_union(@_vcc_owns(@state, t), @_vcc_set_singleton(x))); 
    call $set_owns($ptr(^Tree, P#t), $set_union($owns($s, $ptr(^Tree, P#t)), $set_singleton($ptr(^Node, P#x))));
    assume $full_stop_ext(#tok$1^152.5, $s);
    // (struct Node* -> _Bool) res_lambda#5#18; 
    assume $local_value_is($s, #tok$1^153.15, #loc.res_lambda#5#18, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#5#18), $map_t($ptr_to(^Node), ^^bool));
    // res_lambda#5#18 := lambda#5(x); 
    call res_lambda#5#18 := lambda#5($ref($ptr(^Node, P#x)));
    assume $full_stop_ext(#tok$1^153.15, $s);
    assume $local_value_is($s, #tok$1^153.15, #loc.res_lambda#5#18, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#5#18), $map_t($ptr_to(^Node), ^^bool));
    // assert @_vcc_typed2(@state, (t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @prim_writes_check((t->R)); 
    assert $writable($s, #wrTime$1^134.1, $dot($ptr(^Tree, P#t), Tree.R));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // *(t->R) := @map_updated(*((t->R)), x, res_lambda#5#18); 
    call $write_int($dot($ptr(^Tree, P#t), Tree.R), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, P#x)), res_lambda#5#18)));
    assume $full_stop_ext(#tok$1^153.5, $s);
    assume true;
    // if (@_vcc_ptr_eq(p, @null)) ...
    if ($ptr_eq($ptr(^Node, L#p), $null))
    {
      anon22:
        // assert @_vcc_typed2(@state, (t->root)); 
        assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.root), $ptr_to(^Node));
        // assert @prim_writes_check((t->root)); 
        assert $writable($s, #wrTime$1^134.1, $dot($ptr(^Tree, P#t), Tree.root));
        // *(t->root) := x; 
        call $write_int($dot($ptr(^Tree, P#t), Tree.root), $ref($ptr(^Node, P#x)));
        assume $full_stop_ext(#tok$1^157.5, $s);
        // _math state_t prestate#27; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
        // prestate#27 := @_vcc_current_state(@state); 
        prestate#27 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
        // _math state_t staticWrapState#25; 
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#25, $state_to_int(staticWrapState#25), ^$#state_t);
        // staticWrapState#25 := @_vcc_current_state(@state); 
        staticWrapState#25 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#25, $state_to_int(staticWrapState#25), ^$#state_t);
        // _math ptrset owns#26; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#26, $ptrset_to_int(owns#26), ^$#ptrset);
        // owns#26 := @_vcc_set_empty; 
        owns#26 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#26, $ptrset_to_int(owns#26), ^$#ptrset);
        // assert @writes_check(x); 
        assert $top_writable($s, #wrTime$1^134.1, $ptr(^Node, P#x));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(x), staticWrapState#25, owns#26)
        call $static_wrap($ptr(^Node, P#x), staticWrapState#25, owns#26);
        assume $good_state_ext(#tok$1^158.21, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, x), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $ptr(^Node, P#x)), $set_empty());
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // _math state_t prestate#28; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
        // prestate#28 := @_vcc_current_state(@state); 
        prestate#28 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
        // assume @_vcc_pre_wrap(@state); 
        assume $pre_wrap($s);
        // assert @writes_check(t); 
        assert $top_writable($s, #wrTime$1^134.1, $ptr(^Tree, P#t));
        // assert @writes_check(@_vcc_owns(@state, t)); 
        assert (forall #writes$1^159.21: $ptr :: { $dont_instantiate(#writes$1^159.21) } $set_in(#writes$1^159.21, $owns($s, $ptr(^Tree, P#t))) ==> $top_writable($s, #wrTime$1^134.1, #writes$1^159.21));
        // stmt @_vcc_wrap(t, @_vcc_typeof(t)); 
        call $wrap($ptr(^Tree, P#t), ^Tree);
        assume $good_state_ext(#tok$1^159.21, $s);
        // assert @inv_check(unchecked!(@map_get(@map_get(*((t->R)), *((t->root))), (struct Node*)@null))); 
        assert !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr_cast($null, ^Node)));
        // assert @inv_check(==>(@_vcc_ptr_neq(*((t->root)), @null), @map_get(@map_get(*((t->R)), *((t->root))), *((t->root))))); 
        assert $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
        // assert @inv_check(==>(@_vcc_ptr_neq(*((t->root)), @null), @_vcc_ptr_eq(*((*((t->root))->parent)), @null))); 
        assert $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), Node.parent), ^Node), $null);
        // assert @inv_check(forall(struct Node* m; @in_range_phys_ptr((mathint)m); unchecked!(@map_get(@map_get(*((t->R)), (struct Node*)@null), m)))); 
        assert (forall Q#m$1^82.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr_cast($null, ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
        // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->left))), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->left))), m), <(*((m->key)), *((n->key))))))); 
        assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) < $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
        // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->right))), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->right))), m), >(*((m->key)), *((n->key))))))); 
        assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) > $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
        // assert @inv_check(forall(struct Node* m; { @map_get(@map_get(*((t->R)), *((t->root))), m) } { mark2(m) } { @trigger_hint(mark2(m)) } @in_range_phys_ptr((mathint)m); ==(@map_get(@map_get(*((t->R)), *((t->root))), m), @_vcc_set_in(m, @_vcc_owns(@state, t))))); 
        assert (forall Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } { F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1))) } { sk_hack(F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) == $set_in($ptr(^Node, Q#m$1^82.29#dt1), $owns($s, $ptr(^Tree, P#t))));
        // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), m)))); 
        assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
        // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), n)))); 
        assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
        // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->left)), @null)), @map_get(@map_get(*((t->R)), n), *((n->left)))))); 
        assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node))));
        // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->left)), @null)), @_vcc_ptr_eq(*((*((n->left))->parent)), n)))); 
        assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
        // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->right)), @null)), @map_get(@map_get(*((t->R)), n), *((n->right)))))); 
        assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node))));
        // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->right)), @null)), @_vcc_ptr_eq(*((*((n->right))->parent)), n)))); 
        assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
        // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->parent)), @null)), @map_get(@map_get(*((t->R)), *((t->root))), *((n->parent)))))); 
        assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node))));
        // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->parent)), @null)), ||(@_vcc_ptr_eq(*((*((n->parent))->left)), n), @_vcc_ptr_eq(*((*((n->parent))->right)), n))))); 
        assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.left), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)) || $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.right), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
        // assert @inv_check(forall(struct Node* n; { @map_get(@map_get(*((t->R)), *((t->root))), n) } @in_range_phys_ptr((mathint)n); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), @map_get(@map_get(*((t->R)), n), n)))); 
        assert (forall Q#n$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
        // assert @inv_check(true); 
        assert true;
        // assert @inv_check(forall(struct Node* m; { @map_get(*((t->abs)), *((m->key))) } @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), ==(@map_get(*((t->abs)), *((m->key))), *((m->value)))))); 
        assert (forall Q#m$1^83.29#dt1: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) == $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.value)));
        // assert @inv_check(forall(int32_t k; { @map_get(*((t->abs)), k) } @in_range_i4(k); ==>(forall(struct Node* m; @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), !=(*((m->key)), k))), ==(@map_get(*((t->abs)), k), 0)))); 
        assert (forall Q#k$1^83.29#tc2: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), Q#k$1^83.29#tc2) == 0);
        // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_eq(*((mark(n)->parent)), @null)), ||(@_vcc_ptr_eq(n, (struct Node*)@null), @_vcc_ptr_eq(n, *((t->root))))))); 
        assert (forall Q#n$1^84.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && $ptr_eq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) || $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
        // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), mark(n)), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==(@map_get(@map_get(*((t->R)), mark(n)), m), &&(@map_get(@map_get(*((t->R)), *((t->root))), n), ||(||(||(&&(@_vcc_ptr_eq(n, (struct Node*)@null), @_vcc_ptr_eq(m, (struct Node*)@null)), @_vcc_ptr_eq(m, n)), @map_get(@map_get(*((t->R)), *((n->left))), m)), @map_get(@map_get(*((t->R)), *((n->right))), m)))))); 
        assert (forall Q#n$1^84.29#dt1: int, Q#m$1^84.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && (($ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) && $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr_cast($null, ^Node))) || $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr(^Node, Q#n$1^84.29#dt1)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))))));
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // return; 
        assert $position_marker();
        goto #exit;
    }
    else
    {
      anon23:
        // empty
    }

  anon37:
    // (struct Node* -> _Bool) res_lambda#6#19; 
    assume $local_value_is($s, #tok$1^163.41, #loc.res_lambda#6#19, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#6#19), $map_t($ptr_to(^Node), ^^bool));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @reads_check_normal((t->root)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.root), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.root), $ptr_to(^Node));
    // res_lambda#6#19 := lambda#6(old(@prestate, @map_get(*((t->R)), *((t->root)))), x); 
    call res_lambda#6#19 := lambda#6($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(old($s), $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr(old($s), $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, P#x)));
    assume $full_stop_ext(#tok$1^163.41, $s);
    assume $local_value_is($s, #tok$1^163.41, #loc.res_lambda#6#19, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#6#19), $map_t($ptr_to(^Node), ^^bool));
    // assert @_vcc_typed2(@state, (t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @prim_writes_check((t->R)); 
    assert $writable($s, #wrTime$1^134.1, $dot($ptr(^Tree, P#t), Tree.R));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @reads_check_normal((t->root)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.root), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.root), $ptr_to(^Node));
    // *(t->R) := @map_updated(*((t->R)), *((t->root)), res_lambda#6#19); 
    call $write_int($dot($ptr(^Tree, P#t), Tree.R), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)), res_lambda#6#19)));
    assume $full_stop_ext(#tok$1^163.25, $s);
    // assert doMark(*((t->root))); 
    assert F#doMark($ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
    // assume doMark(*((t->root))); 
    assume F#doMark($ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
    // assert @map_get(@map_get(*((t->R)), *((t->root))), x); 
    assert $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, P#x)));
    // assume @map_get(@map_get(*((t->R)), *((t->root))), x); 
    assume $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, P#x)));
    call $bump_timestamp();
    assume $full_stop_ext(#tok$1^168.28, $s);
    loopState#1 := $s;
    assume #wrTime$1^168.28 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^168.28, #p) } $in_writes_at(#wrTime$1^168.28, #p) == ($set_in(#p, $set_difference($owns($s, $ptr(^Tree, P#t)), $set_singleton($ptr(^Node, P#x)))) || #p == $dot($ptr(^Tree, P#t), Tree.R)));
    assert (forall #loopWrites^$1^168.28: $ptr :: { $dont_instantiate(#loopWrites^$1^168.28) } $top_writable($s, #wrTime$1^168.28, #loopWrites^$1^168.28) ==> $top_writable($s, #wrTime$1^134.1, #loopWrites^$1^168.28));
    while (true)
      invariant (forall Q#p$1^169.32#tc3: $ptr :: $set_in(Q#p$1^169.32#tc3, $owns($s, $ptr(^Tree, P#t))) ==> Q#p$1^169.32#tc3 == $ptr(^Node, P#x) || $wrapped($s, Q#p$1^169.32#tc3, $typ(Q#p$1^169.32#tc3)));
      invariant $mutable($s, $ptr(^Node, P#x));
      invariant $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(loopState#1, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr(loopState#1, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))));
      invariant $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(loopState#1, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr_cast($null, ^Node))), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr_cast($null, ^Node))));
      invariant $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(loopState#1, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, P#x))), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, P#x))));
      invariant !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr_cast($null, ^Node)));
      invariant $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
      invariant $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), Node.parent), ^Node), $null);
      invariant (forall Q#m$1^171.31#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^171.31#dt1))) ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr_cast($null, ^Node))), $ref($ptr(^Node, Q#m$1^171.31#dt1))));
      invariant (forall Q#n$1^171.31#dt1: int, Q#m$1^171.31#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^171.31#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^171.31#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^171.31#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^171.31#dt1), Node.key)) < $mem($s, $dot($ptr(^Node, Q#n$1^171.31#dt1), Node.key)));
      invariant (forall Q#n$1^171.31#dt1: int, Q#m$1^171.31#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^171.31#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^171.31#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^171.31#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^171.31#dt1), Node.key)) > $mem($s, $dot($ptr(^Node, Q#n$1^171.31#dt1), Node.key)));
      invariant (forall Q#m$1^171.31#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^171.31#dt1))) } { F#mark2($ref($ptr(^Node, Q#m$1^171.31#dt1))) } { sk_hack(F#mark2($ref($ptr(^Node, Q#m$1^171.31#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^171.31#dt1))) == $set_in($ptr(^Node, Q#m$1^171.31#dt1), $owns($s, $ptr(^Tree, P#t))));
      invariant (forall Q#n$1^171.31#dt1: int, Q#m$1^171.31#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^171.31#dt1))), $ref($ptr(^Node, Q#m$1^171.31#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^171.31#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^171.31#dt1))), $ref($ptr(^Node, Q#m$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^171.31#dt1))));
      invariant (forall Q#n$1^171.31#dt1: int, Q#m$1^171.31#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^171.31#dt1))), $ref($ptr(^Node, Q#m$1^171.31#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^171.31#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^171.31#dt1))), $ref($ptr(^Node, Q#m$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^171.31#dt1))));
      invariant (forall Q#n$1^171.31#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^171.31#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))), Node.left), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^171.31#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^171.31#dt1), Node.left), ^Node))));
      invariant (forall Q#n$1^171.31#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^171.31#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))), Node.left), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^171.31#dt1), Node.left), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^171.31#dt1)));
      invariant (forall Q#n$1^171.31#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^171.31#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))), Node.right), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^171.31#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^171.31#dt1), Node.right), ^Node))));
      invariant (forall Q#n$1^171.31#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^171.31#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))), Node.right), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^171.31#dt1), Node.right), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^171.31#dt1)));
      invariant (forall Q#n$1^171.31#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^171.31#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))), Node.parent), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^171.31#dt1), Node.parent), ^Node))));
      invariant (forall Q#n$1^171.31#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^171.31#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^171.31#dt1), Node.parent), ^Node), Node.left), ^Node), $ptr(^Node, Q#n$1^171.31#dt1)) || $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^171.31#dt1), Node.parent), ^Node), Node.right), ^Node), $ptr(^Node, Q#n$1^171.31#dt1)));
      invariant (forall Q#n$1^171.31#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^171.31#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^171.31#dt1))), $ref($ptr(^Node, Q#n$1^171.31#dt1))));
      invariant true;
      invariant (forall Q#m$1^172.31#dt1: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^172.31#dt1), Node.key))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^172.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^172.31#dt1))) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^172.31#dt1), Node.key))) == $mem($s, $dot($ptr(^Node, Q#m$1^172.31#dt1), Node.value)));
      invariant (forall Q#k$1^172.31#tc2: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), Q#k$1^172.31#tc2) } $in_range_i4(Q#k$1^172.31#tc2) ==> (forall Q#m$1^172.31#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^172.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^172.31#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^172.31#dt1), Node.key)) != Q#k$1^172.31#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), Q#k$1^172.31#tc2) == 0);
      invariant (forall Q#n$1^173.31#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^173.31#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^173.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^173.31#dt1))) && $ptr_eq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^173.31#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($ptr(^Node, Q#n$1^173.31#dt1), $ptr(^Node, P#x)) || $ptr_eq($ptr(^Node, Q#n$1^173.31#dt1), $read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
      invariant (forall Q#n$1^173.31#dt1: int, Q#m$1^173.31#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^173.31#dt1)))))), $ref($ptr(^Node, Q#m$1^173.31#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^173.31#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^173.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^173.31#dt1)))))), $ref($ptr(^Node, Q#m$1^173.31#dt1))) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^173.31#dt1))) && (($ptr_eq($ptr(^Node, Q#n$1^173.31#dt1), $ptr(^Node, L#p)) && $ptr_eq($ptr(^Node, Q#m$1^173.31#dt1), $ptr(^Node, P#x))) || $ptr_eq($ptr(^Node, Q#m$1^173.31#dt1), $ptr(^Node, Q#n$1^173.31#dt1)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^173.31#dt1), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^173.31#dt1))) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^173.31#dt1), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^173.31#dt1))))));
      invariant $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, L#p)));
      invariant $ptr_neq($ptr(^Node, L#p), $ptr(^Node, P#x));
      invariant !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, L#p), Node.left), ^Node))), $ref($ptr(^Node, P#x)));
      invariant !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, L#p), Node.right), ^Node))), $ref($ptr(^Node, P#x)));
      invariant (forall Q#n$1^176.31#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^176.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^176.31#dt1))) ==> $ptr_eq($ptr(^Node, Q#n$1^176.31#dt1), $ptr(^Node, P#x)) || $mem($s, $dot($ptr(^Node, Q#n$1^176.31#dt1), Node.key)) != $mem($s, $dot($ptr(^Node, P#x), Node.key)));
    {
      anon35:
        assume (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(loopState#1, #p) || $set_in(#p, $set_difference($owns(loopState#1, $ptr(^Tree, P#t)), $set_singleton($ptr(^Node, P#x)))) || #p == $dot($ptr(^Tree, P#t), Tree.R) || $mem_eq(loopState#1, $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(loopState#1, #p) || $set_in(#p, $set_difference($owns(loopState#1, $ptr(^Tree, P#t)), $set_singleton($ptr(^Node, P#x)))) || #p == $dot($ptr(^Tree, P#t), Tree.R) || $st_eq(loopState#1, $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(loopState#1, #p) || $set_in(#p, $set_difference($owns(loopState#1, $ptr(^Tree, P#t)), $set_singleton($ptr(^Node, P#x)))) || #p == $dot($ptr(^Tree, P#t), Tree.R) || $ts_eq(loopState#1, $s, #p)) && $timestamp_post(loopState#1, $s);
        assume $timestamp_post(loopState#1, $s);
        assume $full_stop_ext(#tok$1^167.3, $s);
        assume $local_value_is($s, #tok$1^167.3, #loc.res_lambda#6#19, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#6#19), $map_t($ptr_to(^Node), ^^bool));
        assume $local_value_is($s, #tok$1^167.3, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
        assume $local_value_is($s, #tok$1^167.3, #loc.owns#26, $ptrset_to_int(owns#26), ^$#ptrset);
        assume $local_value_is($s, #tok$1^167.3, #loc.staticWrapState#25, $state_to_int(staticWrapState#25), ^$#state_t);
        assume $local_value_is($s, #tok$1^167.3, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
        assume $local_value_is($s, #tok$1^167.3, #loc.res_lambda#5#18, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#5#18), $map_t($ptr_to(^Node), ^^bool));
        assume $local_value_is($s, #tok$1^167.3, #loc.res_lambda#4#17, $map_t..^^i4.^^i4_to_int(res_lambda#4#17), $map_t(^^i4, ^^i4));
        assume $local_value_is($s, #tok$1^167.3, #loc.assign#13, $ptr_to_int($ptr(^Node, assign#13)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^167.3, #loc.assign#13, $ptr(^Node, assign#13), $ptr_to(^Node));
        assume $local_value_is($s, #tok$1^167.3, #loc.assign#12, $ptr_to_int($ptr(^Node, assign#12)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^167.3, #loc.assign#12, $ptr(^Node, assign#12), $ptr_to(^Node));
        assume $local_value_is($s, #tok$1^167.3, #loc.prestate#24, $state_to_int(prestate#24), ^$#state_t);
        assume $local_value_is($s, #tok$1^167.3, #loc.n, $ptr_to_int($ptr(^Node, L#n)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^167.3, #loc.n, $ptr(^Node, L#n), $ptr_to(^Node));
        assume $local_value_is($s, #tok$1^167.3, #loc.x, $ptr_to_int($ptr(^Node, P#x)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^167.3, #loc.x, $ptr(^Node, P#x), $ptr_to(^Node));
        assume true;
        // if (true) ...
        if (true)
        {
          anon32:
            // assert @reads_check_normal((x->key)); 
            assert $typed2($s, $dot($ptr(^Node, P#x), Node.key), ^^i4);
            assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.key), ^^i4);
            // assert @reads_check_normal((p->key)); 
            assert $typed2($s, $dot($ptr(^Node, L#p), Node.key), ^^i4);
            assert $thread_local2($s, $dot($ptr(^Node, L#p), Node.key), ^^i4);
            assume true;
            // if (<(*((x->key)), *((p->key)))) ...
            if ($mem($s, $dot($ptr(^Node, P#x), Node.key)) < $mem($s, $dot($ptr(^Node, L#p), Node.key)))
            {
              anon26:
                // assert @reads_check_normal((p->left)); 
                assert $typed2($s, $dot($ptr(^Node, L#p), Node.left), $ptr_to(^Node));
                assert $thread_local2($s, $dot($ptr(^Node, L#p), Node.left), $ptr_to(^Node));
                // n := *((p->left)); 
                L#n := $ref($read_ptr($s, $dot($ptr(^Node, L#p), Node.left), ^Node));
                assume $local_value_is($s, #tok$1^179.7, #loc.n, $ptr_to_int($ptr(^Node, L#n)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^179.7, #loc.n, $ptr(^Node, L#n), $ptr_to(^Node));
                assume true;
                // if (@_vcc_ptr_eq(n, @null)) ...
                if ($ptr_eq($ptr(^Node, L#n), $null))
                {
                  anon24:
                    // _math ptrset owns#30; 
                    assume $local_value_is($s, #tok$2^0.0, #loc.owns#30, $ptrset_to_int(owns#30), ^$#ptrset);
                    // owns#30 := @_vcc_set_empty; 
                    owns#30 := $set_empty();
                    assume $local_value_is($s, #tok$2^0.0, #loc.owns#30, $ptrset_to_int(owns#30), ^$#ptrset);
                    // _math state_t prestate#29; 
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#29, $state_to_int(prestate#29), ^$#state_t);
                    // prestate#29 := @_vcc_current_state(@state); 
                    prestate#29 := $current_state($s);
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#29, $state_to_int(prestate#29), ^$#state_t);
                    // _math state_t prestate#31; 
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#31, $state_to_int(prestate#31), ^$#state_t);
                    // prestate#31 := @_vcc_current_state(@state); 
                    prestate#31 := $current_state($s);
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#31, $state_to_int(prestate#31), ^$#state_t);
                    // assert @_vcc_wrapped(@state, p); 
                    assert $wrapped($s, $ptr(^Node, L#p), ^Node);
                    // assert @writes_check(p); 
                    assert $top_writable($s, #wrTime$1^168.28, $ptr(^Node, L#p));
                    // assume @_vcc_inv(@state, p); 
                    assume $inv($s, $ptr(^Node, L#p), ^Node);
                    // assume ==(owns#30, @_vcc_owns(@state, p)); 
                    assume owns#30 == $owns($s, $ptr(^Node, L#p));
                    // assume @_vcc_pre_static_unwrap(@state); 
                    assume $pre_static_unwrap($s);
                    // @_vcc_static_unwrap(pure(p), prestate#31)
                    call $static_unwrap($ptr(^Node, L#p), prestate#31);
                    assume $good_state_ext(#tok$1^181.36, $s);
                    // assume @_vcc_full_stop(@state); 
                    assume $full_stop($s);
                    // assert @_vcc_typed2(@state, (p->left)); 
                    assert $typed2($s, $dot($ptr(^Node, L#p), Node.left), $ptr_to(^Node));
                    // assert @prim_writes_check((p->left)); 
                    assert $writable($s, #wrTime$1^168.28, $dot($ptr(^Node, L#p), Node.left));
                    // *(p->left) := x; 
                    call $write_int($dot($ptr(^Node, L#p), Node.left), $ref($ptr(^Node, P#x)));
                    assume $full_stop_ext(#tok$1^181.41, $s);
                    // _math state_t prestate#34; 
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#34, $state_to_int(prestate#34), ^$#state_t);
                    // prestate#34 := @_vcc_current_state(@state); 
                    prestate#34 := $current_state($s);
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#34, $state_to_int(prestate#34), ^$#state_t);
                    // _math state_t staticWrapState#32; 
                    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#32, $state_to_int(staticWrapState#32), ^$#state_t);
                    // staticWrapState#32 := @_vcc_current_state(@state); 
                    staticWrapState#32 := $current_state($s);
                    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#32, $state_to_int(staticWrapState#32), ^$#state_t);
                    // _math ptrset owns#33; 
                    assume $local_value_is($s, #tok$2^0.0, #loc.owns#33, $ptrset_to_int(owns#33), ^$#ptrset);
                    // owns#33 := @_vcc_set_empty; 
                    owns#33 := $set_empty();
                    assume $local_value_is($s, #tok$2^0.0, #loc.owns#33, $ptrset_to_int(owns#33), ^$#ptrset);
                    // assert @writes_check(p); 
                    assert $top_writable($s, #wrTime$1^168.28, $ptr(^Node, L#p));
                    // assume @_vcc_pre_static_wrap(@state); 
                    assume $pre_static_wrap($s);
                    // @_vcc_static_wrap(pure(p), staticWrapState#32, owns#33)
                    call $static_wrap($ptr(^Node, L#p), staticWrapState#32, owns#33);
                    assume $good_state_ext(#tok$1^181.36, $s);
                    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, p), @_vcc_set_empty)); 
                    assert $set_eq($owns($s, $ptr(^Node, L#p)), $set_empty());
                    // assume @_vcc_full_stop(@state); 
                    assume $full_stop($s);
                    // goto #break_11; 
                    goto #break_11;
                }
                else
                {
                  anon25:
                    // empty
                }
            }
            else
            {
              anon31:
                // assert @reads_check_normal((x->key)); 
                assert $typed2($s, $dot($ptr(^Node, P#x), Node.key), ^^i4);
                assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.key), ^^i4);
                // assert @reads_check_normal((p->key)); 
                assert $typed2($s, $dot($ptr(^Node, L#p), Node.key), ^^i4);
                assert $thread_local2($s, $dot($ptr(^Node, L#p), Node.key), ^^i4);
                assume true;
                // if (>(*((x->key)), *((p->key)))) ...
                if ($mem($s, $dot($ptr(^Node, P#x), Node.key)) > $mem($s, $dot($ptr(^Node, L#p), Node.key)))
                {
                  anon29:
                    // assert @reads_check_normal((p->right)); 
                    assert $typed2($s, $dot($ptr(^Node, L#p), Node.right), $ptr_to(^Node));
                    assert $thread_local2($s, $dot($ptr(^Node, L#p), Node.right), $ptr_to(^Node));
                    // n := *((p->right)); 
                    L#n := $ref($read_ptr($s, $dot($ptr(^Node, L#p), Node.right), ^Node));
                    assume $local_value_is($s, #tok$1^185.7, #loc.n, $ptr_to_int($ptr(^Node, L#n)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^185.7, #loc.n, $ptr(^Node, L#n), $ptr_to(^Node));
                    assume true;
                    // if (@_vcc_ptr_eq(n, @null)) ...
                    if ($ptr_eq($ptr(^Node, L#n), $null))
                    {
                      anon27:
                        // _math ptrset owns#36; 
                        assume $local_value_is($s, #tok$2^0.0, #loc.owns#36, $ptrset_to_int(owns#36), ^$#ptrset);
                        // owns#36 := @_vcc_set_empty; 
                        owns#36 := $set_empty();
                        assume $local_value_is($s, #tok$2^0.0, #loc.owns#36, $ptrset_to_int(owns#36), ^$#ptrset);
                        // _math state_t prestate#35; 
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#35, $state_to_int(prestate#35), ^$#state_t);
                        // prestate#35 := @_vcc_current_state(@state); 
                        prestate#35 := $current_state($s);
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#35, $state_to_int(prestate#35), ^$#state_t);
                        // _math state_t prestate#37; 
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#37, $state_to_int(prestate#37), ^$#state_t);
                        // prestate#37 := @_vcc_current_state(@state); 
                        prestate#37 := $current_state($s);
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#37, $state_to_int(prestate#37), ^$#state_t);
                        // assert @_vcc_wrapped(@state, p); 
                        assert $wrapped($s, $ptr(^Node, L#p), ^Node);
                        // assert @writes_check(p); 
                        assert $top_writable($s, #wrTime$1^168.28, $ptr(^Node, L#p));
                        // assume @_vcc_inv(@state, p); 
                        assume $inv($s, $ptr(^Node, L#p), ^Node);
                        // assume ==(owns#36, @_vcc_owns(@state, p)); 
                        assume owns#36 == $owns($s, $ptr(^Node, L#p));
                        // assume @_vcc_pre_static_unwrap(@state); 
                        assume $pre_static_unwrap($s);
                        // @_vcc_static_unwrap(pure(p), prestate#37)
                        call $static_unwrap($ptr(^Node, L#p), prestate#37);
                        assume $good_state_ext(#tok$1^187.36, $s);
                        // assume @_vcc_full_stop(@state); 
                        assume $full_stop($s);
                        // assert @_vcc_typed2(@state, (p->right)); 
                        assert $typed2($s, $dot($ptr(^Node, L#p), Node.right), $ptr_to(^Node));
                        // assert @prim_writes_check((p->right)); 
                        assert $writable($s, #wrTime$1^168.28, $dot($ptr(^Node, L#p), Node.right));
                        // *(p->right) := x; 
                        call $write_int($dot($ptr(^Node, L#p), Node.right), $ref($ptr(^Node, P#x)));
                        assume $full_stop_ext(#tok$1^187.41, $s);
                        // _math state_t prestate#40; 
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#40, $state_to_int(prestate#40), ^$#state_t);
                        // prestate#40 := @_vcc_current_state(@state); 
                        prestate#40 := $current_state($s);
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#40, $state_to_int(prestate#40), ^$#state_t);
                        // _math state_t staticWrapState#38; 
                        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#38, $state_to_int(staticWrapState#38), ^$#state_t);
                        // staticWrapState#38 := @_vcc_current_state(@state); 
                        staticWrapState#38 := $current_state($s);
                        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#38, $state_to_int(staticWrapState#38), ^$#state_t);
                        // _math ptrset owns#39; 
                        assume $local_value_is($s, #tok$2^0.0, #loc.owns#39, $ptrset_to_int(owns#39), ^$#ptrset);
                        // owns#39 := @_vcc_set_empty; 
                        owns#39 := $set_empty();
                        assume $local_value_is($s, #tok$2^0.0, #loc.owns#39, $ptrset_to_int(owns#39), ^$#ptrset);
                        // assert @writes_check(p); 
                        assert $top_writable($s, #wrTime$1^168.28, $ptr(^Node, L#p));
                        // assume @_vcc_pre_static_wrap(@state); 
                        assume $pre_static_wrap($s);
                        // @_vcc_static_wrap(pure(p), staticWrapState#38, owns#39)
                        call $static_wrap($ptr(^Node, L#p), staticWrapState#38, owns#39);
                        assume $good_state_ext(#tok$1^187.36, $s);
                        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, p), @_vcc_set_empty)); 
                        assert $set_eq($owns($s, $ptr(^Node, L#p)), $set_empty());
                        // assume @_vcc_full_stop(@state); 
                        assume $full_stop($s);
                        // goto #break_11; 
                        goto #break_11;
                    }
                    else
                    {
                      anon28:
                        // empty
                    }
                }
                else
                {
                  anon30:
                    // assert false; 
                    assert false;
                    // assume false; 
                    assume false;
                }
            }

          anon33:
            // assert doMark(p); 
            assert F#doMark($ref($ptr(^Node, L#p)));
            // assert doMark(n); 
            assert F#doMark($ref($ptr(^Node, L#n)));
            // assume &&(doMark(p), doMark(n)); 
            assume F#doMark($ref($ptr(^Node, L#p))) && F#doMark($ref($ptr(^Node, L#n)));
            // (struct Node* -> _Bool) res_lambda#7#20; 
            assume $local_value_is($s, #tok$1^194.37, #loc.res_lambda#7#20, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#7#20), $map_t($ptr_to(^Node), ^^bool));
            // assert @reads_check_normal((t->R)); 
            assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
            assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
            // res_lambda#7#20 := lambda#7(@map_get(*((t->R)), n), x); 
            call res_lambda#7#20 := lambda#7($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, L#n))), $ref($ptr(^Node, P#x)));
            assume $full_stop_ext(#tok$1^194.37, $s);
            assume $local_value_is($s, #tok$1^194.37, #loc.res_lambda#7#20, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#7#20), $map_t($ptr_to(^Node), ^^bool));
            // assert @_vcc_typed2(@state, (t->R)); 
            assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
            // assert @prim_writes_check((t->R)); 
            assert $writable($s, #wrTime$1^168.28, $dot($ptr(^Tree, P#t), Tree.R));
            // assert @reads_check_normal((t->R)); 
            assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
            assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
            // *(t->R) := @map_updated(*((t->R)), n, res_lambda#7#20); 
            call $write_int($dot($ptr(^Tree, P#t), Tree.R), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, L#n)), res_lambda#7#20)));
            assume $full_stop_ext(#tok$1^194.27, $s);
            // p := n; 
            L#p := $ref($ptr(^Node, L#n));
            assume $local_value_is($s, #tok$1^195.5, #loc.p, $ptr_to_int($ptr(^Node, L#p)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^195.5, #loc.p, $ptr(^Node, L#p), $ptr_to(^Node));
        }
        else
        {
          anon34:
            // goto #break_11; 
            goto #break_11;
        }

      #continue_11:
        assume true;
    }

  anon38:
    assume $full_stop_ext(#tok$1^167.3, $s);

  #break_11:
    // assert @_vcc_typed2(@state, (x->parent)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
    // assert @prim_writes_check((x->parent)); 
    assert $writable($s, #wrTime$1^134.1, $dot($ptr(^Node, P#x), Node.parent));
    // *(x->parent) := p; 
    call $write_int($dot($ptr(^Node, P#x), Node.parent), $ref($ptr(^Node, L#p)));
    assume $full_stop_ext(#tok$1^198.3, $s);
    // _math state_t prestate#43; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#43, $state_to_int(prestate#43), ^$#state_t);
    // prestate#43 := @_vcc_current_state(@state); 
    prestate#43 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#43, $state_to_int(prestate#43), ^$#state_t);
    // _math state_t staticWrapState#41; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#41, $state_to_int(staticWrapState#41), ^$#state_t);
    // staticWrapState#41 := @_vcc_current_state(@state); 
    staticWrapState#41 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#41, $state_to_int(staticWrapState#41), ^$#state_t);
    // _math ptrset owns#42; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#42, $ptrset_to_int(owns#42), ^$#ptrset);
    // owns#42 := @_vcc_set_empty; 
    owns#42 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#42, $ptrset_to_int(owns#42), ^$#ptrset);
    // assert @writes_check(x); 
    assert $top_writable($s, #wrTime$1^134.1, $ptr(^Node, P#x));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(x), staticWrapState#41, owns#42)
    call $static_wrap($ptr(^Node, P#x), staticWrapState#41, owns#42);
    assume $good_state_ext(#tok$1^199.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, x), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^Node, P#x)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#44; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#44, $state_to_int(prestate#44), ^$#state_t);
    // prestate#44 := @_vcc_current_state(@state); 
    prestate#44 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#44, $state_to_int(prestate#44), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(t); 
    assert $top_writable($s, #wrTime$1^134.1, $ptr(^Tree, P#t));
    // assert @writes_check(@_vcc_owns(@state, t)); 
    assert (forall #writes$1^200.19: $ptr :: { $dont_instantiate(#writes$1^200.19) } $set_in(#writes$1^200.19, $owns($s, $ptr(^Tree, P#t))) ==> $top_writable($s, #wrTime$1^134.1, #writes$1^200.19));
    // stmt @_vcc_wrap(t, @_vcc_typeof(t)); 
    call $wrap($ptr(^Tree, P#t), ^Tree);
    assume $good_state_ext(#tok$1^200.19, $s);
    // assert @inv_check(unchecked!(@map_get(@map_get(*((t->R)), *((t->root))), (struct Node*)@null))); 
    assert !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr_cast($null, ^Node)));
    // assert @inv_check(==>(@_vcc_ptr_neq(*((t->root)), @null), @map_get(@map_get(*((t->R)), *((t->root))), *((t->root))))); 
    assert $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
    // assert @inv_check(==>(@_vcc_ptr_neq(*((t->root)), @null), @_vcc_ptr_eq(*((*((t->root))->parent)), @null))); 
    assert $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), Node.parent), ^Node), $null);
    // assert @inv_check(forall(struct Node* m; @in_range_phys_ptr((mathint)m); unchecked!(@map_get(@map_get(*((t->R)), (struct Node*)@null), m)))); 
    assert (forall Q#m$1^82.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr_cast($null, ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->left))), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->left))), m), <(*((m->key)), *((n->key))))))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) < $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->right))), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->right))), m), >(*((m->key)), *((n->key))))))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) > $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
    // assert @inv_check(forall(struct Node* m; { @map_get(@map_get(*((t->R)), *((t->root))), m) } { mark2(m) } { @trigger_hint(mark2(m)) } @in_range_phys_ptr((mathint)m); ==(@map_get(@map_get(*((t->R)), *((t->root))), m), @_vcc_set_in(m, @_vcc_owns(@state, t))))); 
    assert (forall Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } { F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1))) } { sk_hack(F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) == $set_in($ptr(^Node, Q#m$1^82.29#dt1), $owns($s, $ptr(^Tree, P#t))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), m)))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), n)))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->left)), @null)), @map_get(@map_get(*((t->R)), n), *((n->left)))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->left)), @null)), @_vcc_ptr_eq(*((*((n->left))->parent)), n)))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->right)), @null)), @map_get(@map_get(*((t->R)), n), *((n->right)))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->right)), @null)), @_vcc_ptr_eq(*((*((n->right))->parent)), n)))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->parent)), @null)), @map_get(@map_get(*((t->R)), *((t->root))), *((n->parent)))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->parent)), @null)), ||(@_vcc_ptr_eq(*((*((n->parent))->left)), n), @_vcc_ptr_eq(*((*((n->parent))->right)), n))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.left), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)) || $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.right), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
    // assert @inv_check(forall(struct Node* n; { @map_get(@map_get(*((t->R)), *((t->root))), n) } @in_range_phys_ptr((mathint)n); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), @map_get(@map_get(*((t->R)), n), n)))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
    // assert @inv_check(true); 
    assert true;
    // assert @inv_check(forall(struct Node* m; { @map_get(*((t->abs)), *((m->key))) } @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), ==(@map_get(*((t->abs)), *((m->key))), *((m->value)))))); 
    assert (forall Q#m$1^83.29#dt1: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) == $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.value)));
    // assert @inv_check(forall(int32_t k; { @map_get(*((t->abs)), k) } @in_range_i4(k); ==>(forall(struct Node* m; @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), !=(*((m->key)), k))), ==(@map_get(*((t->abs)), k), 0)))); 
    assert (forall Q#k$1^83.29#tc2: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), Q#k$1^83.29#tc2) == 0);
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_eq(*((mark(n)->parent)), @null)), ||(@_vcc_ptr_eq(n, (struct Node*)@null), @_vcc_ptr_eq(n, *((t->root))))))); 
    assert (forall Q#n$1^84.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && $ptr_eq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) || $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), mark(n)), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==(@map_get(@map_get(*((t->R)), mark(n)), m), &&(@map_get(@map_get(*((t->R)), *((t->root))), n), ||(||(||(&&(@_vcc_ptr_eq(n, (struct Node*)@null), @_vcc_ptr_eq(m, (struct Node*)@null)), @_vcc_ptr_eq(m, n)), @map_get(@map_get(*((t->R)), *((n->left))), m)), @map_get(@map_get(*((t->R)), *((n->right))), m)))))); 
    assert (forall Q#n$1^84.29#dt1: int, Q#m$1^84.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && (($ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) && $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr_cast($null, ^Node))) || $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr(^Node, Q#n$1^84.29#dt1)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure left_rotate(P#t: int, P#x: int);
  requires $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, P#x)));
  requires $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#x), Node.right), ^Node), $null);
  requires $wrapped($s, $ptr(^Tree, P#t), ^Tree);
  modifies $s, $cev_pc;
  ensures $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(old($s), $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr(old($s), $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)))) && $eq.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem(old($s), $dot($ptr(^Tree, P#t), Tree.abs))), $int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))));
  ensures $wrapped($s, $ptr(^Tree, P#t), ^Tree);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Tree, P#t) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Tree, P#t) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Tree, P#t) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation left_rotate(P#t: int, P#x: int)
{
  var prestate#70: $state;
  var res_lambda#8#21: $map_t..$ptr_to..^Node.^^bool;
  var owns#68: $ptrset;
  var staticWrapState#67: $state;
  var prestate#69: $state;
  var owns#65: $ptrset;
  var staticWrapState#64: $state;
  var prestate#66: $state;
  var owns#62: $ptrset;
  var staticWrapState#61: $state;
  var prestate#63: $state;
  var prestate#60: $state;
  var prestate#58: $state;
  var owns#59: $ptrset;
  var owns#56: $ptrset;
  var staticWrapState#55: $state;
  var prestate#57: $state;
  var prestate#54: $state;
  var prestate#52: $state;
  var owns#53: $ptrset;
  var prestate#51: $state;
  var prestate#49: $state;
  var owns#50: $ptrset;
  var prestate#48: $state;
  var prestate#46: $state;
  var owns#47: $ptrset;
  var prestate#45: $state;
  var L#y: int where $in_range_phys_ptr(L#y);
  var #wrTime$1^203.1: int;
  var #stackframe: int;

  anon46:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^203.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^203.1, #loc.t, $ptr_to_int($ptr(^Tree, P#t)), $ptr_to(^Tree)) && $local_value_is_ptr($s, #tok$1^203.1, #loc.t, $ptr(^Tree, P#t), $ptr_to(^Tree));
    assume $local_value_is($s, #tok$1^203.1, #loc.x, $ptr_to_int($ptr(^Node, P#x)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^203.1, #loc.x, $ptr(^Node, P#x), $ptr_to(^Node));
    assume #wrTime$1^203.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^203.1, #p) } $in_writes_at(#wrTime$1^203.1, #p) == (#p == $ptr(^Tree, P#t)));
    assume $thread_owned($s, $ptr(^Tree, P#t));
    // assume @in_range_phys_ptr((mathint)t); 
    assume $in_range_phys_ptr($ref($ptr(^Tree, P#t)));
    // assume @in_range_phys_ptr((mathint)x); 
    assume $in_range_phys_ptr($ref($ptr(^Node, P#x)));
    // assert @_vcc_in_domain(@state, t, t); 
    assert $in_domain_lab($s, $ptr(^Tree, P#t), $ptr(^Tree, P#t), l#public);
    // struct Node* y; 
    assume $local_value_is($s, #tok$1^209.3, #loc.y, $ptr_to_int($ptr(^Node, L#y)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^209.3, #loc.y, $ptr(^Node, L#y), $ptr_to(^Node));
    // var struct Node* y
    // _math state_t prestate#45; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#45, $state_to_int(prestate#45), ^$#state_t);
    // prestate#45 := @_vcc_current_state(@state); 
    prestate#45 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#45, $state_to_int(prestate#45), ^$#state_t);
    // assert @_vcc_wrapped(@state, t); 
    assert $wrapped($s, $ptr(^Tree, P#t), ^Tree);
    // assume @_vcc_inv(@state, t); 
    assume $inv($s, $ptr(^Tree, P#t), ^Tree);
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(t); 
    assert $top_writable($s, #wrTime$1^203.1, $ptr(^Tree, P#t));
    // stmt @_vcc_unwrap(t, @_vcc_typeof(t)); 
    call $unwrap($ptr(^Tree, P#t), ^Tree);
    assume $good_state_ext(#tok$1^211.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert doMark(x); 
    assert F#doMark($ref($ptr(^Node, P#x)));
    // assume doMark(x); 
    assume F#doMark($ref($ptr(^Node, P#x)));
    // _math ptrset owns#47; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#47, $ptrset_to_int(owns#47), ^$#ptrset);
    // owns#47 := @_vcc_set_empty; 
    owns#47 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#47, $ptrset_to_int(owns#47), ^$#ptrset);
    // _math state_t prestate#46; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#46, $state_to_int(prestate#46), ^$#state_t);
    // prestate#46 := @_vcc_current_state(@state); 
    prestate#46 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#46, $state_to_int(prestate#46), ^$#state_t);
    // _math state_t prestate#48; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#48, $state_to_int(prestate#48), ^$#state_t);
    // prestate#48 := @_vcc_current_state(@state); 
    prestate#48 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#48, $state_to_int(prestate#48), ^$#state_t);
    // assert @_vcc_wrapped(@state, x); 
    assert $wrapped($s, $ptr(^Node, P#x), ^Node);
    // assert @writes_check(x); 
    assert $top_writable($s, #wrTime$1^203.1, $ptr(^Node, P#x));
    // assume @_vcc_inv(@state, x); 
    assume $inv($s, $ptr(^Node, P#x), ^Node);
    // assume ==(owns#47, @_vcc_owns(@state, x)); 
    assume owns#47 == $owns($s, $ptr(^Node, P#x));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(x), prestate#48)
    call $static_unwrap($ptr(^Node, P#x), prestate#48);
    assume $good_state_ext(#tok$1^212.53, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @reads_check_normal((x->right)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.right), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.right), $ptr_to(^Node));
    // y := *((x->right)); 
    L#y := $ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.right), ^Node));
    assume $local_value_is($s, #tok$1^213.3, #loc.y, $ptr_to_int($ptr(^Node, L#y)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^213.3, #loc.y, $ptr(^Node, L#y), $ptr_to(^Node));
    // assert doMark(y); 
    assert F#doMark($ref($ptr(^Node, L#y)));
    // assume doMark(y); 
    assume F#doMark($ref($ptr(^Node, L#y)));
    // _math ptrset owns#50; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#50, $ptrset_to_int(owns#50), ^$#ptrset);
    // owns#50 := @_vcc_set_empty; 
    owns#50 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#50, $ptrset_to_int(owns#50), ^$#ptrset);
    // _math state_t prestate#49; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#49, $state_to_int(prestate#49), ^$#state_t);
    // prestate#49 := @_vcc_current_state(@state); 
    prestate#49 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#49, $state_to_int(prestate#49), ^$#state_t);
    // _math state_t prestate#51; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#51, $state_to_int(prestate#51), ^$#state_t);
    // prestate#51 := @_vcc_current_state(@state); 
    prestate#51 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#51, $state_to_int(prestate#51), ^$#state_t);
    // assert @_vcc_wrapped(@state, y); 
    assert $wrapped($s, $ptr(^Node, L#y), ^Node);
    // assert @writes_check(y); 
    assert $top_writable($s, #wrTime$1^203.1, $ptr(^Node, L#y));
    // assume @_vcc_inv(@state, y); 
    assume $inv($s, $ptr(^Node, L#y), ^Node);
    // assume ==(owns#50, @_vcc_owns(@state, y)); 
    assume owns#50 == $owns($s, $ptr(^Node, L#y));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(y), prestate#51)
    call $static_unwrap($ptr(^Node, L#y), prestate#51);
    assume $good_state_ext(#tok$1^214.53, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (x->right)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.right), $ptr_to(^Node));
    // assert @prim_writes_check((x->right)); 
    assert $writable($s, #wrTime$1^203.1, $dot($ptr(^Node, P#x), Node.right));
    // assert @reads_check_normal((y->left)); 
    assert $typed2($s, $dot($ptr(^Node, L#y), Node.left), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, L#y), Node.left), $ptr_to(^Node));
    // *(x->right) := *((y->left)); 
    call $write_int($dot($ptr(^Node, P#x), Node.right), $ref($read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node)));
    assume $full_stop_ext(#tok$1^216.3, $s);
    // assert @reads_check_normal((y->left)); 
    assert $typed2($s, $dot($ptr(^Node, L#y), Node.left), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, L#y), Node.left), $ptr_to(^Node));
    assume true;
    // if (@_vcc_ptr_neq(*((y->left)), @null)) ...
    if ($ptr_neq($read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node), $null))
    {
      anon39:
        // _math ptrset owns#53; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#53, $ptrset_to_int(owns#53), ^$#ptrset);
        // owns#53 := @_vcc_set_empty; 
        owns#53 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#53, $ptrset_to_int(owns#53), ^$#ptrset);
        // _math state_t prestate#52; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#52, $state_to_int(prestate#52), ^$#state_t);
        // prestate#52 := @_vcc_current_state(@state); 
        prestate#52 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#52, $state_to_int(prestate#52), ^$#state_t);
        // _math state_t prestate#54; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#54, $state_to_int(prestate#54), ^$#state_t);
        // prestate#54 := @_vcc_current_state(@state); 
        prestate#54 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#54, $state_to_int(prestate#54), ^$#state_t);
        // assert @_vcc_wrapped(@state, *((y->left))); 
        assert $wrapped($s, $read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node), ^Node);
        // assert @writes_check(*((y->left))); 
        assert $top_writable($s, #wrTime$1^203.1, $read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node));
        // assume @_vcc_inv(@state, *((y->left))); 
        assume $inv($s, $read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node), ^Node);
        // assume ==(owns#53, @_vcc_owns(@state, *((y->left)))); 
        assume owns#53 == $owns($s, $read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node));
        // assume @_vcc_pre_static_unwrap(@state); 
        assume $pre_static_unwrap($s);
        // @_vcc_static_unwrap(pure(*((y->left))), prestate#54)
        call $static_unwrap($read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node), prestate#54);
        assume $good_state_ext(#tok$1^218.34, $s);
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // assert @_vcc_typed2(@state, (*((y->left))->parent)); 
        assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node), Node.parent), $ptr_to(^Node));
        // assert @prim_writes_check((*((y->left))->parent)); 
        assert $writable($s, #wrTime$1^203.1, $dot($read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node), Node.parent));
        // assert @reads_check_normal((y->left)); 
        assert $typed2($s, $dot($ptr(^Node, L#y), Node.left), $ptr_to(^Node));
        assert $thread_local2($s, $dot($ptr(^Node, L#y), Node.left), $ptr_to(^Node));
        // *(*((y->left))->parent) := x; 
        call $write_int($dot($read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node), Node.parent), $ref($ptr(^Node, P#x)));
        assume $full_stop_ext(#tok$1^218.43, $s);
        // _math state_t prestate#57; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#57, $state_to_int(prestate#57), ^$#state_t);
        // prestate#57 := @_vcc_current_state(@state); 
        prestate#57 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#57, $state_to_int(prestate#57), ^$#state_t);
        // _math state_t staticWrapState#55; 
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#55, $state_to_int(staticWrapState#55), ^$#state_t);
        // staticWrapState#55 := @_vcc_current_state(@state); 
        staticWrapState#55 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#55, $state_to_int(staticWrapState#55), ^$#state_t);
        // _math ptrset owns#56; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#56, $ptrset_to_int(owns#56), ^$#ptrset);
        // owns#56 := @_vcc_set_empty; 
        owns#56 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#56, $ptrset_to_int(owns#56), ^$#ptrset);
        // assert @writes_check(*((y->left))); 
        assert $top_writable($s, #wrTime$1^203.1, $read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(*((y->left))), staticWrapState#55, owns#56)
        call $static_wrap($read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node), staticWrapState#55, owns#56);
        assume $good_state_ext(#tok$1^218.34, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((y->left))), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node)), $set_empty());
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
    }
    else
    {
      anon40:
        // empty
    }

  anon47:
    // assert @_vcc_typed2(@state, (y->parent)); 
    assert $typed2($s, $dot($ptr(^Node, L#y), Node.parent), $ptr_to(^Node));
    // assert @prim_writes_check((y->parent)); 
    assert $writable($s, #wrTime$1^203.1, $dot($ptr(^Node, L#y), Node.parent));
    // assert @reads_check_normal((x->parent)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
    // *(y->parent) := *((x->parent)); 
    call $write_int($dot($ptr(^Node, L#y), Node.parent), $ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node)));
    assume $full_stop_ext(#tok$1^219.3, $s);
    // assert @reads_check_normal((x->parent)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
    assume true;
    // if (@_vcc_ptr_eq(*((x->parent)), @null)) ...
    if ($ptr_eq($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), $null))
    {
      anon41:
        // assert @_vcc_typed2(@state, (t->root)); 
        assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.root), $ptr_to(^Node));
        // assert @prim_writes_check((t->root)); 
        assert $writable($s, #wrTime$1^203.1, $dot($ptr(^Tree, P#t), Tree.root));
        // *(t->root) := y; 
        call $write_int($dot($ptr(^Tree, P#t), Tree.root), $ref($ptr(^Node, L#y)));
        assume $full_stop_ext(#tok$1^221.5, $s);
    }
    else
    {
      anon44:
        // assert doMark(*((x->parent))); 
        assert F#doMark($ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node)));
        // assume doMark(*((x->parent))); 
        assume F#doMark($ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node)));
        // _math ptrset owns#59; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#59, $ptrset_to_int(owns#59), ^$#ptrset);
        // owns#59 := @_vcc_set_empty; 
        owns#59 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#59, $ptrset_to_int(owns#59), ^$#ptrset);
        // _math state_t prestate#58; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#58, $state_to_int(prestate#58), ^$#state_t);
        // prestate#58 := @_vcc_current_state(@state); 
        prestate#58 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#58, $state_to_int(prestate#58), ^$#state_t);
        // _math state_t prestate#60; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#60, $state_to_int(prestate#60), ^$#state_t);
        // prestate#60 := @_vcc_current_state(@state); 
        prestate#60 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#60, $state_to_int(prestate#60), ^$#state_t);
        // assert @_vcc_wrapped(@state, *((x->parent))); 
        assert $wrapped($s, $read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), ^Node);
        // assert @writes_check(*((x->parent))); 
        assert $top_writable($s, #wrTime$1^203.1, $read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node));
        // assume @_vcc_inv(@state, *((x->parent))); 
        assume $inv($s, $read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), ^Node);
        // assume ==(owns#59, @_vcc_owns(@state, *((x->parent)))); 
        assume owns#59 == $owns($s, $read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node));
        // assume @_vcc_pre_static_unwrap(@state); 
        assume $pre_static_unwrap($s);
        // @_vcc_static_unwrap(pure(*((x->parent))), prestate#60)
        call $static_unwrap($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), prestate#60);
        assume $good_state_ext(#tok$1^224.32, $s);
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // assert @reads_check_normal((*((x->parent))->left)); 
        assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), Node.left), $ptr_to(^Node));
        assert $thread_local2($s, $dot($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), Node.left), $ptr_to(^Node));
        // assert @reads_check_normal((x->parent)); 
        assert $typed2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
        assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
        assume true;
        // if (@_vcc_ptr_eq(*((*((x->parent))->left)), x)) ...
        if ($ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), Node.left), ^Node), $ptr(^Node, P#x)))
        {
          anon42:
            // assert @_vcc_typed2(@state, (*((x->parent))->left)); 
            assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), Node.left), $ptr_to(^Node));
            // assert @prim_writes_check((*((x->parent))->left)); 
            assert $writable($s, #wrTime$1^203.1, $dot($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), Node.left));
            // assert @reads_check_normal((x->parent)); 
            assert $typed2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
            assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
            // *(*((x->parent))->left) := y; 
            call $write_int($dot($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), Node.left), $ref($ptr(^Node, L#y)));
            assume $full_stop_ext(#tok$1^226.9, $s);
        }
        else
        {
          anon43:
            // assert @_vcc_typed2(@state, (*((x->parent))->right)); 
            assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), Node.right), $ptr_to(^Node));
            // assert @prim_writes_check((*((x->parent))->right)); 
            assert $writable($s, #wrTime$1^203.1, $dot($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), Node.right));
            // assert @reads_check_normal((x->parent)); 
            assert $typed2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
            assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
            // *(*((x->parent))->right) := y; 
            call $write_int($dot($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), Node.right), $ref($ptr(^Node, L#y)));
            assume $full_stop_ext(#tok$1^228.9, $s);
        }

      anon45:
        // _math state_t prestate#63; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#63, $state_to_int(prestate#63), ^$#state_t);
        // prestate#63 := @_vcc_current_state(@state); 
        prestate#63 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#63, $state_to_int(prestate#63), ^$#state_t);
        // _math state_t staticWrapState#61; 
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#61, $state_to_int(staticWrapState#61), ^$#state_t);
        // staticWrapState#61 := @_vcc_current_state(@state); 
        staticWrapState#61 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#61, $state_to_int(staticWrapState#61), ^$#state_t);
        // _math ptrset owns#62; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#62, $ptrset_to_int(owns#62), ^$#ptrset);
        // owns#62 := @_vcc_set_empty; 
        owns#62 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#62, $ptrset_to_int(owns#62), ^$#ptrset);
        // assert @writes_check(*((x->parent))); 
        assert $top_writable($s, #wrTime$1^203.1, $read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(*((x->parent))), staticWrapState#61, owns#62)
        call $static_wrap($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), staticWrapState#61, owns#62);
        assume $good_state_ext(#tok$1^224.32, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((x->parent))), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node)), $set_empty());
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
    }

  anon48:
    // assert @_vcc_typed2(@state, (y->left)); 
    assert $typed2($s, $dot($ptr(^Node, L#y), Node.left), $ptr_to(^Node));
    // assert @prim_writes_check((y->left)); 
    assert $writable($s, #wrTime$1^203.1, $dot($ptr(^Node, L#y), Node.left));
    // *(y->left) := x; 
    call $write_int($dot($ptr(^Node, L#y), Node.left), $ref($ptr(^Node, P#x)));
    assume $full_stop_ext(#tok$1^231.3, $s);
    // assert @_vcc_typed2(@state, (x->parent)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
    // assert @prim_writes_check((x->parent)); 
    assert $writable($s, #wrTime$1^203.1, $dot($ptr(^Node, P#x), Node.parent));
    // *(x->parent) := y; 
    call $write_int($dot($ptr(^Node, P#x), Node.parent), $ref($ptr(^Node, L#y)));
    assume $full_stop_ext(#tok$1^232.3, $s);
    // _math state_t prestate#66; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#66, $state_to_int(prestate#66), ^$#state_t);
    // prestate#66 := @_vcc_current_state(@state); 
    prestate#66 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#66, $state_to_int(prestate#66), ^$#state_t);
    // _math state_t staticWrapState#64; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#64, $state_to_int(staticWrapState#64), ^$#state_t);
    // staticWrapState#64 := @_vcc_current_state(@state); 
    staticWrapState#64 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#64, $state_to_int(staticWrapState#64), ^$#state_t);
    // _math ptrset owns#65; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#65, $ptrset_to_int(owns#65), ^$#ptrset);
    // owns#65 := @_vcc_set_empty; 
    owns#65 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#65, $ptrset_to_int(owns#65), ^$#ptrset);
    // assert @writes_check(x); 
    assert $top_writable($s, #wrTime$1^203.1, $ptr(^Node, P#x));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(x), staticWrapState#64, owns#65)
    call $static_wrap($ptr(^Node, P#x), staticWrapState#64, owns#65);
    assume $good_state_ext(#tok$1^233.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, x), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^Node, P#x)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#69; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#69, $state_to_int(prestate#69), ^$#state_t);
    // prestate#69 := @_vcc_current_state(@state); 
    prestate#69 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#69, $state_to_int(prestate#69), ^$#state_t);
    // _math state_t staticWrapState#67; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#67, $state_to_int(staticWrapState#67), ^$#state_t);
    // staticWrapState#67 := @_vcc_current_state(@state); 
    staticWrapState#67 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#67, $state_to_int(staticWrapState#67), ^$#state_t);
    // _math ptrset owns#68; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#68, $ptrset_to_int(owns#68), ^$#ptrset);
    // owns#68 := @_vcc_set_empty; 
    owns#68 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#68, $ptrset_to_int(owns#68), ^$#ptrset);
    // assert @writes_check(y); 
    assert $top_writable($s, #wrTime$1^203.1, $ptr(^Node, L#y));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(y), staticWrapState#67, owns#68)
    call $static_wrap($ptr(^Node, L#y), staticWrapState#67, owns#68);
    assume $good_state_ext(#tok$1^233.43, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, y), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^Node, L#y)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert doMark(*((x->right))); 
    assert F#doMark($ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.right), ^Node)));
    // assume doMark(*((x->right))); 
    assume F#doMark($ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.right), ^Node)));
    // assert forall(struct Node* m; { @trigger_hint(@map_get(@map_get(*((t->R)), y), m)) } { @map_get(@map_get(*((t->R)), *((x->right))), m) } @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((x->right))), m), >(*((m->key)), *((x->key))))); 
    assert (forall Q#m$1^236.26#dt1: int :: { sk_hack($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, L#y))), $ref($ptr(^Node, Q#m$1^236.26#dt1)))) } { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^236.26#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^236.26#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^236.26#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^236.26#dt1), Node.key)) > $mem($s, $dot($ptr(^Node, P#x), Node.key)));
    // assume forall(struct Node* m; { @trigger_hint(@map_get(@map_get(*((t->R)), y), m)) } { @map_get(@map_get(*((t->R)), *((x->right))), m) } @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((x->right))), m), >(*((m->key)), *((x->key))))); 
    assume (forall Q#m$1^236.26#dt1: int :: { sk_hack($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, L#y))), $ref($ptr(^Node, Q#m$1^236.26#dt1)))) } { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^236.26#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^236.26#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^236.26#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^236.26#dt1), Node.key)) > $mem($s, $dot($ptr(^Node, P#x), Node.key)));
    // assert @_vcc_typed2(@state, (t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @prim_writes_check((t->R)); 
    assert $writable($s, #wrTime$1^203.1, $dot($ptr(^Tree, P#t), Tree.R));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // *(t->R) := @map_updated(*((t->R)), y, @map_get(*((t->R)), x)); 
    call $write_int($dot($ptr(^Tree, P#t), Tree.R), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, L#y)), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, P#x))))));
    assume $full_stop_ext(#tok$1^239.5, $s);
    // (struct Node* -> _Bool) res_lambda#8#21; 
    assume $local_value_is($s, #tok$1^240.15, #loc.res_lambda#8#21, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#8#21), $map_t($ptr_to(^Node), ^^bool));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @reads_check_normal((x->right)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.right), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.right), $ptr_to(^Node));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @reads_check_normal((x->left)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.left), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.left), $ptr_to(^Node));
    // res_lambda#8#21 := lambda#8(@map_get(*((t->R)), *((x->right))), @map_get(*((t->R)), *((x->left))), x); 
    call res_lambda#8#21 := lambda#8($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.right), ^Node))), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.left), ^Node))), $ref($ptr(^Node, P#x)));
    assume $full_stop_ext(#tok$1^240.15, $s);
    assume $local_value_is($s, #tok$1^240.15, #loc.res_lambda#8#21, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#8#21), $map_t($ptr_to(^Node), ^^bool));
    // assert @_vcc_typed2(@state, (t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @prim_writes_check((t->R)); 
    assert $writable($s, #wrTime$1^203.1, $dot($ptr(^Tree, P#t), Tree.R));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // *(t->R) := @map_updated(*((t->R)), x, res_lambda#8#21); 
    call $write_int($dot($ptr(^Tree, P#t), Tree.R), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, P#x)), res_lambda#8#21)));
    assume $full_stop_ext(#tok$1^240.5, $s);
    // _math state_t prestate#70; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#70, $state_to_int(prestate#70), ^$#state_t);
    // prestate#70 := @_vcc_current_state(@state); 
    prestate#70 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#70, $state_to_int(prestate#70), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(t); 
    assert $top_writable($s, #wrTime$1^203.1, $ptr(^Tree, P#t));
    // assert @writes_check(@_vcc_owns(@state, t)); 
    assert (forall #writes$1^243.19: $ptr :: { $dont_instantiate(#writes$1^243.19) } $set_in(#writes$1^243.19, $owns($s, $ptr(^Tree, P#t))) ==> $top_writable($s, #wrTime$1^203.1, #writes$1^243.19));
    // stmt @_vcc_wrap(t, @_vcc_typeof(t)); 
    call $wrap($ptr(^Tree, P#t), ^Tree);
    assume $good_state_ext(#tok$1^243.19, $s);
    // assert @inv_check(unchecked!(@map_get(@map_get(*((t->R)), *((t->root))), (struct Node*)@null))); 
    assert !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr_cast($null, ^Node)));
    // assert @inv_check(==>(@_vcc_ptr_neq(*((t->root)), @null), @map_get(@map_get(*((t->R)), *((t->root))), *((t->root))))); 
    assert $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
    // assert @inv_check(==>(@_vcc_ptr_neq(*((t->root)), @null), @_vcc_ptr_eq(*((*((t->root))->parent)), @null))); 
    assert $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), Node.parent), ^Node), $null);
    // assert @inv_check(forall(struct Node* m; @in_range_phys_ptr((mathint)m); unchecked!(@map_get(@map_get(*((t->R)), (struct Node*)@null), m)))); 
    assert (forall Q#m$1^82.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr_cast($null, ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->left))), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->left))), m), <(*((m->key)), *((n->key))))))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) < $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->right))), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->right))), m), >(*((m->key)), *((n->key))))))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) > $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
    // assert @inv_check(forall(struct Node* m; { @map_get(@map_get(*((t->R)), *((t->root))), m) } { mark2(m) } { @trigger_hint(mark2(m)) } @in_range_phys_ptr((mathint)m); ==(@map_get(@map_get(*((t->R)), *((t->root))), m), @_vcc_set_in(m, @_vcc_owns(@state, t))))); 
    assert (forall Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } { F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1))) } { sk_hack(F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) == $set_in($ptr(^Node, Q#m$1^82.29#dt1), $owns($s, $ptr(^Tree, P#t))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), m)))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), n)))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->left)), @null)), @map_get(@map_get(*((t->R)), n), *((n->left)))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->left)), @null)), @_vcc_ptr_eq(*((*((n->left))->parent)), n)))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->right)), @null)), @map_get(@map_get(*((t->R)), n), *((n->right)))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->right)), @null)), @_vcc_ptr_eq(*((*((n->right))->parent)), n)))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->parent)), @null)), @map_get(@map_get(*((t->R)), *((t->root))), *((n->parent)))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->parent)), @null)), ||(@_vcc_ptr_eq(*((*((n->parent))->left)), n), @_vcc_ptr_eq(*((*((n->parent))->right)), n))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.left), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)) || $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.right), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
    // assert @inv_check(forall(struct Node* n; { @map_get(@map_get(*((t->R)), *((t->root))), n) } @in_range_phys_ptr((mathint)n); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), @map_get(@map_get(*((t->R)), n), n)))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
    // assert @inv_check(true); 
    assert true;
    // assert @inv_check(forall(struct Node* m; { @map_get(*((t->abs)), *((m->key))) } @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), ==(@map_get(*((t->abs)), *((m->key))), *((m->value)))))); 
    assert (forall Q#m$1^83.29#dt1: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) == $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.value)));
    // assert @inv_check(forall(int32_t k; { @map_get(*((t->abs)), k) } @in_range_i4(k); ==>(forall(struct Node* m; @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), !=(*((m->key)), k))), ==(@map_get(*((t->abs)), k), 0)))); 
    assert (forall Q#k$1^83.29#tc2: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), Q#k$1^83.29#tc2) == 0);
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_eq(*((mark(n)->parent)), @null)), ||(@_vcc_ptr_eq(n, (struct Node*)@null), @_vcc_ptr_eq(n, *((t->root))))))); 
    assert (forall Q#n$1^84.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && $ptr_eq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) || $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), mark(n)), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==(@map_get(@map_get(*((t->R)), mark(n)), m), &&(@map_get(@map_get(*((t->R)), *((t->root))), n), ||(||(||(&&(@_vcc_ptr_eq(n, (struct Node*)@null), @_vcc_ptr_eq(m, (struct Node*)@null)), @_vcc_ptr_eq(m, n)), @map_get(@map_get(*((t->R)), *((n->left))), m)), @map_get(@map_get(*((t->R)), *((n->right))), m)))))); 
    assert (forall Q#n$1^84.29#dt1: int, Q#m$1^84.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && (($ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) && $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr_cast($null, ^Node))) || $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr(^Node, Q#n$1^84.29#dt1)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure right_rotate(P#t: int, P#y: int);
  requires $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, P#y)));
  requires $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#y), Node.left), ^Node), $null);
  requires $wrapped($s, $ptr(^Tree, P#t), ^Tree);
  modifies $s, $cev_pc;
  ensures $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(old($s), $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr(old($s), $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)))) && $eq.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem(old($s), $dot($ptr(^Tree, P#t), Tree.abs))), $int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))));
  ensures $wrapped($s, $ptr(^Tree, P#t), ^Tree);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Tree, P#t) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Tree, P#t) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Tree, P#t) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation right_rotate(P#t: int, P#y: int)
{
  var prestate#96: $state;
  var res_lambda#9#22: $map_t..$ptr_to..^Node.^^bool;
  var owns#94: $ptrset;
  var staticWrapState#93: $state;
  var prestate#95: $state;
  var owns#91: $ptrset;
  var staticWrapState#90: $state;
  var prestate#92: $state;
  var owns#88: $ptrset;
  var staticWrapState#87: $state;
  var prestate#89: $state;
  var prestate#86: $state;
  var prestate#84: $state;
  var owns#85: $ptrset;
  var owns#82: $ptrset;
  var staticWrapState#81: $state;
  var prestate#83: $state;
  var prestate#80: $state;
  var prestate#78: $state;
  var owns#79: $ptrset;
  var prestate#77: $state;
  var prestate#75: $state;
  var owns#76: $ptrset;
  var prestate#74: $state;
  var prestate#72: $state;
  var owns#73: $ptrset;
  var prestate#71: $state;
  var L#x: int where $in_range_phys_ptr(L#x);
  var #wrTime$1^246.1: int;
  var #stackframe: int;

  anon56:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^246.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^246.1, #loc.t, $ptr_to_int($ptr(^Tree, P#t)), $ptr_to(^Tree)) && $local_value_is_ptr($s, #tok$1^246.1, #loc.t, $ptr(^Tree, P#t), $ptr_to(^Tree));
    assume $local_value_is($s, #tok$1^246.1, #loc.y, $ptr_to_int($ptr(^Node, P#y)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^246.1, #loc.y, $ptr(^Node, P#y), $ptr_to(^Node));
    assume #wrTime$1^246.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^246.1, #p) } $in_writes_at(#wrTime$1^246.1, #p) == (#p == $ptr(^Tree, P#t)));
    assume $thread_owned($s, $ptr(^Tree, P#t));
    // assume @in_range_phys_ptr((mathint)t); 
    assume $in_range_phys_ptr($ref($ptr(^Tree, P#t)));
    // assume @in_range_phys_ptr((mathint)y); 
    assume $in_range_phys_ptr($ref($ptr(^Node, P#y)));
    // assert @_vcc_in_domain(@state, t, t); 
    assert $in_domain_lab($s, $ptr(^Tree, P#t), $ptr(^Tree, P#t), l#public);
    // struct Node* x; 
    assume $local_value_is($s, #tok$1^252.3, #loc.x, $ptr_to_int($ptr(^Node, L#x)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^252.3, #loc.x, $ptr(^Node, L#x), $ptr_to(^Node));
    // var struct Node* x
    // _math state_t prestate#71; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#71, $state_to_int(prestate#71), ^$#state_t);
    // prestate#71 := @_vcc_current_state(@state); 
    prestate#71 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#71, $state_to_int(prestate#71), ^$#state_t);
    // assert @_vcc_wrapped(@state, t); 
    assert $wrapped($s, $ptr(^Tree, P#t), ^Tree);
    // assume @_vcc_inv(@state, t); 
    assume $inv($s, $ptr(^Tree, P#t), ^Tree);
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(t); 
    assert $top_writable($s, #wrTime$1^246.1, $ptr(^Tree, P#t));
    // stmt @_vcc_unwrap(t, @_vcc_typeof(t)); 
    call $unwrap($ptr(^Tree, P#t), ^Tree);
    assume $good_state_ext(#tok$1^254.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert doMark(y); 
    assert F#doMark($ref($ptr(^Node, P#y)));
    // assume doMark(y); 
    assume F#doMark($ref($ptr(^Node, P#y)));
    // _math ptrset owns#73; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#73, $ptrset_to_int(owns#73), ^$#ptrset);
    // owns#73 := @_vcc_set_empty; 
    owns#73 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#73, $ptrset_to_int(owns#73), ^$#ptrset);
    // _math state_t prestate#72; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#72, $state_to_int(prestate#72), ^$#state_t);
    // prestate#72 := @_vcc_current_state(@state); 
    prestate#72 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#72, $state_to_int(prestate#72), ^$#state_t);
    // _math state_t prestate#74; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#74, $state_to_int(prestate#74), ^$#state_t);
    // prestate#74 := @_vcc_current_state(@state); 
    prestate#74 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#74, $state_to_int(prestate#74), ^$#state_t);
    // assert @_vcc_wrapped(@state, y); 
    assert $wrapped($s, $ptr(^Node, P#y), ^Node);
    // assert @writes_check(y); 
    assert $top_writable($s, #wrTime$1^246.1, $ptr(^Node, P#y));
    // assume @_vcc_inv(@state, y); 
    assume $inv($s, $ptr(^Node, P#y), ^Node);
    // assume ==(owns#73, @_vcc_owns(@state, y)); 
    assume owns#73 == $owns($s, $ptr(^Node, P#y));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(y), prestate#74)
    call $static_unwrap($ptr(^Node, P#y), prestate#74);
    assume $good_state_ext(#tok$1^255.53, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @reads_check_normal((y->left)); 
    assert $typed2($s, $dot($ptr(^Node, P#y), Node.left), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, P#y), Node.left), $ptr_to(^Node));
    // x := *((y->left)); 
    L#x := $ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.left), ^Node));
    assume $local_value_is($s, #tok$1^256.3, #loc.x, $ptr_to_int($ptr(^Node, L#x)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^256.3, #loc.x, $ptr(^Node, L#x), $ptr_to(^Node));
    // assert doMark(x); 
    assert F#doMark($ref($ptr(^Node, L#x)));
    // assume doMark(x); 
    assume F#doMark($ref($ptr(^Node, L#x)));
    // _math ptrset owns#76; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#76, $ptrset_to_int(owns#76), ^$#ptrset);
    // owns#76 := @_vcc_set_empty; 
    owns#76 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#76, $ptrset_to_int(owns#76), ^$#ptrset);
    // _math state_t prestate#75; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#75, $state_to_int(prestate#75), ^$#state_t);
    // prestate#75 := @_vcc_current_state(@state); 
    prestate#75 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#75, $state_to_int(prestate#75), ^$#state_t);
    // _math state_t prestate#77; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#77, $state_to_int(prestate#77), ^$#state_t);
    // prestate#77 := @_vcc_current_state(@state); 
    prestate#77 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#77, $state_to_int(prestate#77), ^$#state_t);
    // assert @_vcc_wrapped(@state, x); 
    assert $wrapped($s, $ptr(^Node, L#x), ^Node);
    // assert @writes_check(x); 
    assert $top_writable($s, #wrTime$1^246.1, $ptr(^Node, L#x));
    // assume @_vcc_inv(@state, x); 
    assume $inv($s, $ptr(^Node, L#x), ^Node);
    // assume ==(owns#76, @_vcc_owns(@state, x)); 
    assume owns#76 == $owns($s, $ptr(^Node, L#x));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(x), prestate#77)
    call $static_unwrap($ptr(^Node, L#x), prestate#77);
    assume $good_state_ext(#tok$1^257.53, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (y->left)); 
    assert $typed2($s, $dot($ptr(^Node, P#y), Node.left), $ptr_to(^Node));
    // assert @prim_writes_check((y->left)); 
    assert $writable($s, #wrTime$1^246.1, $dot($ptr(^Node, P#y), Node.left));
    // assert @reads_check_normal((x->right)); 
    assert $typed2($s, $dot($ptr(^Node, L#x), Node.right), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, L#x), Node.right), $ptr_to(^Node));
    // *(y->left) := *((x->right)); 
    call $write_int($dot($ptr(^Node, P#y), Node.left), $ref($read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node)));
    assume $full_stop_ext(#tok$1^259.3, $s);
    // assert @reads_check_normal((x->right)); 
    assert $typed2($s, $dot($ptr(^Node, L#x), Node.right), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, L#x), Node.right), $ptr_to(^Node));
    assume true;
    // if (@_vcc_ptr_neq(*((x->right)), @null)) ...
    if ($ptr_neq($read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node), $null))
    {
      anon49:
        // _math ptrset owns#79; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#79, $ptrset_to_int(owns#79), ^$#ptrset);
        // owns#79 := @_vcc_set_empty; 
        owns#79 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#79, $ptrset_to_int(owns#79), ^$#ptrset);
        // _math state_t prestate#78; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#78, $state_to_int(prestate#78), ^$#state_t);
        // prestate#78 := @_vcc_current_state(@state); 
        prestate#78 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#78, $state_to_int(prestate#78), ^$#state_t);
        // _math state_t prestate#80; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#80, $state_to_int(prestate#80), ^$#state_t);
        // prestate#80 := @_vcc_current_state(@state); 
        prestate#80 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#80, $state_to_int(prestate#80), ^$#state_t);
        // assert @_vcc_wrapped(@state, *((x->right))); 
        assert $wrapped($s, $read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node), ^Node);
        // assert @writes_check(*((x->right))); 
        assert $top_writable($s, #wrTime$1^246.1, $read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node));
        // assume @_vcc_inv(@state, *((x->right))); 
        assume $inv($s, $read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node), ^Node);
        // assume ==(owns#79, @_vcc_owns(@state, *((x->right)))); 
        assume owns#79 == $owns($s, $read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node));
        // assume @_vcc_pre_static_unwrap(@state); 
        assume $pre_static_unwrap($s);
        // @_vcc_static_unwrap(pure(*((x->right))), prestate#80)
        call $static_unwrap($read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node), prestate#80);
        assume $good_state_ext(#tok$1^261.34, $s);
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // assert @_vcc_typed2(@state, (*((x->right))->parent)); 
        assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node), Node.parent), $ptr_to(^Node));
        // assert @prim_writes_check((*((x->right))->parent)); 
        assert $writable($s, #wrTime$1^246.1, $dot($read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node), Node.parent));
        // assert @reads_check_normal((x->right)); 
        assert $typed2($s, $dot($ptr(^Node, L#x), Node.right), $ptr_to(^Node));
        assert $thread_local2($s, $dot($ptr(^Node, L#x), Node.right), $ptr_to(^Node));
        // *(*((x->right))->parent) := y; 
        call $write_int($dot($read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node), Node.parent), $ref($ptr(^Node, P#y)));
        assume $full_stop_ext(#tok$1^261.44, $s);
        // _math state_t prestate#83; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#83, $state_to_int(prestate#83), ^$#state_t);
        // prestate#83 := @_vcc_current_state(@state); 
        prestate#83 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#83, $state_to_int(prestate#83), ^$#state_t);
        // _math state_t staticWrapState#81; 
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#81, $state_to_int(staticWrapState#81), ^$#state_t);
        // staticWrapState#81 := @_vcc_current_state(@state); 
        staticWrapState#81 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#81, $state_to_int(staticWrapState#81), ^$#state_t);
        // _math ptrset owns#82; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#82, $ptrset_to_int(owns#82), ^$#ptrset);
        // owns#82 := @_vcc_set_empty; 
        owns#82 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#82, $ptrset_to_int(owns#82), ^$#ptrset);
        // assert @writes_check(*((x->right))); 
        assert $top_writable($s, #wrTime$1^246.1, $read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(*((x->right))), staticWrapState#81, owns#82)
        call $static_wrap($read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node), staticWrapState#81, owns#82);
        assume $good_state_ext(#tok$1^261.34, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((x->right))), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node)), $set_empty());
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
    }
    else
    {
      anon50:
        // empty
    }

  anon57:
    // assert @_vcc_typed2(@state, (x->parent)); 
    assert $typed2($s, $dot($ptr(^Node, L#x), Node.parent), $ptr_to(^Node));
    // assert @prim_writes_check((x->parent)); 
    assert $writable($s, #wrTime$1^246.1, $dot($ptr(^Node, L#x), Node.parent));
    // assert @reads_check_normal((y->parent)); 
    assert $typed2($s, $dot($ptr(^Node, P#y), Node.parent), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, P#y), Node.parent), $ptr_to(^Node));
    // *(x->parent) := *((y->parent)); 
    call $write_int($dot($ptr(^Node, L#x), Node.parent), $ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node)));
    assume $full_stop_ext(#tok$1^262.3, $s);
    // assert @reads_check_normal((y->parent)); 
    assert $typed2($s, $dot($ptr(^Node, P#y), Node.parent), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, P#y), Node.parent), $ptr_to(^Node));
    assume true;
    // if (@_vcc_ptr_eq(*((y->parent)), @null)) ...
    if ($ptr_eq($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), $null))
    {
      anon51:
        // assert @_vcc_typed2(@state, (t->root)); 
        assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.root), $ptr_to(^Node));
        // assert @prim_writes_check((t->root)); 
        assert $writable($s, #wrTime$1^246.1, $dot($ptr(^Tree, P#t), Tree.root));
        // *(t->root) := x; 
        call $write_int($dot($ptr(^Tree, P#t), Tree.root), $ref($ptr(^Node, L#x)));
        assume $full_stop_ext(#tok$1^263.32, $s);
    }
    else
    {
      anon54:
        // assert doMark(*((y->parent))); 
        assert F#doMark($ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node)));
        // assume doMark(*((y->parent))); 
        assume F#doMark($ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node)));
        // _math ptrset owns#85; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#85, $ptrset_to_int(owns#85), ^$#ptrset);
        // owns#85 := @_vcc_set_empty; 
        owns#85 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#85, $ptrset_to_int(owns#85), ^$#ptrset);
        // _math state_t prestate#84; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#84, $state_to_int(prestate#84), ^$#state_t);
        // prestate#84 := @_vcc_current_state(@state); 
        prestate#84 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#84, $state_to_int(prestate#84), ^$#state_t);
        // _math state_t prestate#86; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#86, $state_to_int(prestate#86), ^$#state_t);
        // prestate#86 := @_vcc_current_state(@state); 
        prestate#86 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#86, $state_to_int(prestate#86), ^$#state_t);
        // assert @_vcc_wrapped(@state, *((y->parent))); 
        assert $wrapped($s, $read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), ^Node);
        // assert @writes_check(*((y->parent))); 
        assert $top_writable($s, #wrTime$1^246.1, $read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node));
        // assume @_vcc_inv(@state, *((y->parent))); 
        assume $inv($s, $read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), ^Node);
        // assume ==(owns#85, @_vcc_owns(@state, *((y->parent)))); 
        assume owns#85 == $owns($s, $read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node));
        // assume @_vcc_pre_static_unwrap(@state); 
        assume $pre_static_unwrap($s);
        // @_vcc_static_unwrap(pure(*((y->parent))), prestate#86)
        call $static_unwrap($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), prestate#86);
        assume $good_state_ext(#tok$1^266.32, $s);
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // assert @reads_check_normal((*((y->parent))->left)); 
        assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), Node.left), $ptr_to(^Node));
        assert $thread_local2($s, $dot($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), Node.left), $ptr_to(^Node));
        // assert @reads_check_normal((y->parent)); 
        assert $typed2($s, $dot($ptr(^Node, P#y), Node.parent), $ptr_to(^Node));
        assert $thread_local2($s, $dot($ptr(^Node, P#y), Node.parent), $ptr_to(^Node));
        assume true;
        // if (@_vcc_ptr_eq(*((*((y->parent))->left)), y)) ...
        if ($ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), Node.left), ^Node), $ptr(^Node, P#y)))
        {
          anon52:
            // assert @_vcc_typed2(@state, (*((y->parent))->left)); 
            assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), Node.left), $ptr_to(^Node));
            // assert @prim_writes_check((*((y->parent))->left)); 
            assert $writable($s, #wrTime$1^246.1, $dot($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), Node.left));
            // assert @reads_check_normal((y->parent)); 
            assert $typed2($s, $dot($ptr(^Node, P#y), Node.parent), $ptr_to(^Node));
            assert $thread_local2($s, $dot($ptr(^Node, P#y), Node.parent), $ptr_to(^Node));
            // *(*((y->parent))->left) := x; 
            call $write_int($dot($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), Node.left), $ref($ptr(^Node, L#x)));
            assume $full_stop_ext(#tok$1^268.9, $s);
        }
        else
        {
          anon53:
            // assert @_vcc_typed2(@state, (*((y->parent))->right)); 
            assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), Node.right), $ptr_to(^Node));
            // assert @prim_writes_check((*((y->parent))->right)); 
            assert $writable($s, #wrTime$1^246.1, $dot($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), Node.right));
            // assert @reads_check_normal((y->parent)); 
            assert $typed2($s, $dot($ptr(^Node, P#y), Node.parent), $ptr_to(^Node));
            assert $thread_local2($s, $dot($ptr(^Node, P#y), Node.parent), $ptr_to(^Node));
            // *(*((y->parent))->right) := x; 
            call $write_int($dot($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), Node.right), $ref($ptr(^Node, L#x)));
            assume $full_stop_ext(#tok$1^270.9, $s);
        }

      anon55:
        // _math state_t prestate#89; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#89, $state_to_int(prestate#89), ^$#state_t);
        // prestate#89 := @_vcc_current_state(@state); 
        prestate#89 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#89, $state_to_int(prestate#89), ^$#state_t);
        // _math state_t staticWrapState#87; 
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#87, $state_to_int(staticWrapState#87), ^$#state_t);
        // staticWrapState#87 := @_vcc_current_state(@state); 
        staticWrapState#87 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#87, $state_to_int(staticWrapState#87), ^$#state_t);
        // _math ptrset owns#88; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#88, $ptrset_to_int(owns#88), ^$#ptrset);
        // owns#88 := @_vcc_set_empty; 
        owns#88 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#88, $ptrset_to_int(owns#88), ^$#ptrset);
        // assert @writes_check(*((y->parent))); 
        assert $top_writable($s, #wrTime$1^246.1, $read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(*((y->parent))), staticWrapState#87, owns#88)
        call $static_wrap($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), staticWrapState#87, owns#88);
        assume $good_state_ext(#tok$1^266.32, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((y->parent))), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node)), $set_empty());
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
    }

  anon58:
    // assert @_vcc_typed2(@state, (x->right)); 
    assert $typed2($s, $dot($ptr(^Node, L#x), Node.right), $ptr_to(^Node));
    // assert @prim_writes_check((x->right)); 
    assert $writable($s, #wrTime$1^246.1, $dot($ptr(^Node, L#x), Node.right));
    // *(x->right) := y; 
    call $write_int($dot($ptr(^Node, L#x), Node.right), $ref($ptr(^Node, P#y)));
    assume $full_stop_ext(#tok$1^273.3, $s);
    // assert @_vcc_typed2(@state, (y->parent)); 
    assert $typed2($s, $dot($ptr(^Node, P#y), Node.parent), $ptr_to(^Node));
    // assert @prim_writes_check((y->parent)); 
    assert $writable($s, #wrTime$1^246.1, $dot($ptr(^Node, P#y), Node.parent));
    // *(y->parent) := x; 
    call $write_int($dot($ptr(^Node, P#y), Node.parent), $ref($ptr(^Node, L#x)));
    assume $full_stop_ext(#tok$1^274.3, $s);
    // _math state_t prestate#92; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#92, $state_to_int(prestate#92), ^$#state_t);
    // prestate#92 := @_vcc_current_state(@state); 
    prestate#92 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#92, $state_to_int(prestate#92), ^$#state_t);
    // _math state_t staticWrapState#90; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#90, $state_to_int(staticWrapState#90), ^$#state_t);
    // staticWrapState#90 := @_vcc_current_state(@state); 
    staticWrapState#90 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#90, $state_to_int(staticWrapState#90), ^$#state_t);
    // _math ptrset owns#91; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#91, $ptrset_to_int(owns#91), ^$#ptrset);
    // owns#91 := @_vcc_set_empty; 
    owns#91 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#91, $ptrset_to_int(owns#91), ^$#ptrset);
    // assert @writes_check(x); 
    assert $top_writable($s, #wrTime$1^246.1, $ptr(^Node, L#x));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(x), staticWrapState#90, owns#91)
    call $static_wrap($ptr(^Node, L#x), staticWrapState#90, owns#91);
    assume $good_state_ext(#tok$1^276.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, x), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^Node, L#x)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#95; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#95, $state_to_int(prestate#95), ^$#state_t);
    // prestate#95 := @_vcc_current_state(@state); 
    prestate#95 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#95, $state_to_int(prestate#95), ^$#state_t);
    // _math state_t staticWrapState#93; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#93, $state_to_int(staticWrapState#93), ^$#state_t);
    // staticWrapState#93 := @_vcc_current_state(@state); 
    staticWrapState#93 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#93, $state_to_int(staticWrapState#93), ^$#state_t);
    // _math ptrset owns#94; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#94, $ptrset_to_int(owns#94), ^$#ptrset);
    // owns#94 := @_vcc_set_empty; 
    owns#94 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#94, $ptrset_to_int(owns#94), ^$#ptrset);
    // assert @writes_check(y); 
    assert $top_writable($s, #wrTime$1^246.1, $ptr(^Node, P#y));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(y), staticWrapState#93, owns#94)
    call $static_wrap($ptr(^Node, P#y), staticWrapState#93, owns#94);
    assume $good_state_ext(#tok$1^276.43, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, y), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^Node, P#y)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert doMark(*((y->left))); 
    assert F#doMark($ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.left), ^Node)));
    // assume doMark(*((y->left))); 
    assume F#doMark($ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.left), ^Node)));
    // assert forall(struct Node* m; { @trigger_hint(@map_get(@map_get(*((t->R)), x), m)) } { @map_get(@map_get(*((t->R)), *((y->left))), m) } @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((y->left))), m), <(*((m->key)), *((y->key))))); 
    assert (forall Q#m$1^279.26#dt1: int :: { sk_hack($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, L#x))), $ref($ptr(^Node, Q#m$1^279.26#dt1)))) } { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^279.26#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^279.26#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^279.26#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^279.26#dt1), Node.key)) < $mem($s, $dot($ptr(^Node, P#y), Node.key)));
    // assume forall(struct Node* m; { @trigger_hint(@map_get(@map_get(*((t->R)), x), m)) } { @map_get(@map_get(*((t->R)), *((y->left))), m) } @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((y->left))), m), <(*((m->key)), *((y->key))))); 
    assume (forall Q#m$1^279.26#dt1: int :: { sk_hack($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, L#x))), $ref($ptr(^Node, Q#m$1^279.26#dt1)))) } { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^279.26#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^279.26#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^279.26#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^279.26#dt1), Node.key)) < $mem($s, $dot($ptr(^Node, P#y), Node.key)));
    // assert @_vcc_typed2(@state, (t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @prim_writes_check((t->R)); 
    assert $writable($s, #wrTime$1^246.1, $dot($ptr(^Tree, P#t), Tree.R));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // *(t->R) := @map_updated(*((t->R)), x, @map_get(*((t->R)), y)); 
    call $write_int($dot($ptr(^Tree, P#t), Tree.R), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, L#x)), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, P#y))))));
    assume $full_stop_ext(#tok$1^282.5, $s);
    // (struct Node* -> _Bool) res_lambda#9#22; 
    assume $local_value_is($s, #tok$1^283.15, #loc.res_lambda#9#22, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#9#22), $map_t($ptr_to(^Node), ^^bool));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @reads_check_normal((y->right)); 
    assert $typed2($s, $dot($ptr(^Node, P#y), Node.right), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, P#y), Node.right), $ptr_to(^Node));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @reads_check_normal((y->left)); 
    assert $typed2($s, $dot($ptr(^Node, P#y), Node.left), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, P#y), Node.left), $ptr_to(^Node));
    // res_lambda#9#22 := lambda#9(@map_get(*((t->R)), *((y->right))), @map_get(*((t->R)), *((y->left))), y); 
    call res_lambda#9#22 := lambda#9($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.right), ^Node))), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.left), ^Node))), $ref($ptr(^Node, P#y)));
    assume $full_stop_ext(#tok$1^283.15, $s);
    assume $local_value_is($s, #tok$1^283.15, #loc.res_lambda#9#22, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#9#22), $map_t($ptr_to(^Node), ^^bool));
    // assert @_vcc_typed2(@state, (t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @prim_writes_check((t->R)); 
    assert $writable($s, #wrTime$1^246.1, $dot($ptr(^Tree, P#t), Tree.R));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // *(t->R) := @map_updated(*((t->R)), y, res_lambda#9#22); 
    call $write_int($dot($ptr(^Tree, P#t), Tree.R), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, P#y)), res_lambda#9#22)));
    assume $full_stop_ext(#tok$1^283.5, $s);
    // _math state_t prestate#96; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#96, $state_to_int(prestate#96), ^$#state_t);
    // prestate#96 := @_vcc_current_state(@state); 
    prestate#96 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#96, $state_to_int(prestate#96), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(t); 
    assert $top_writable($s, #wrTime$1^246.1, $ptr(^Tree, P#t));
    // assert @writes_check(@_vcc_owns(@state, t)); 
    assert (forall #writes$1^286.19: $ptr :: { $dont_instantiate(#writes$1^286.19) } $set_in(#writes$1^286.19, $owns($s, $ptr(^Tree, P#t))) ==> $top_writable($s, #wrTime$1^246.1, #writes$1^286.19));
    // stmt @_vcc_wrap(t, @_vcc_typeof(t)); 
    call $wrap($ptr(^Tree, P#t), ^Tree);
    assume $good_state_ext(#tok$1^286.19, $s);
    // assert @inv_check(unchecked!(@map_get(@map_get(*((t->R)), *((t->root))), (struct Node*)@null))); 
    assert !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr_cast($null, ^Node)));
    // assert @inv_check(==>(@_vcc_ptr_neq(*((t->root)), @null), @map_get(@map_get(*((t->R)), *((t->root))), *((t->root))))); 
    assert $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
    // assert @inv_check(==>(@_vcc_ptr_neq(*((t->root)), @null), @_vcc_ptr_eq(*((*((t->root))->parent)), @null))); 
    assert $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), Node.parent), ^Node), $null);
    // assert @inv_check(forall(struct Node* m; @in_range_phys_ptr((mathint)m); unchecked!(@map_get(@map_get(*((t->R)), (struct Node*)@null), m)))); 
    assert (forall Q#m$1^82.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr_cast($null, ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->left))), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->left))), m), <(*((m->key)), *((n->key))))))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) < $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->right))), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->right))), m), >(*((m->key)), *((n->key))))))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) > $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
    // assert @inv_check(forall(struct Node* m; { @map_get(@map_get(*((t->R)), *((t->root))), m) } { mark2(m) } { @trigger_hint(mark2(m)) } @in_range_phys_ptr((mathint)m); ==(@map_get(@map_get(*((t->R)), *((t->root))), m), @_vcc_set_in(m, @_vcc_owns(@state, t))))); 
    assert (forall Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } { F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1))) } { sk_hack(F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) == $set_in($ptr(^Node, Q#m$1^82.29#dt1), $owns($s, $ptr(^Tree, P#t))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), m)))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), n)))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->left)), @null)), @map_get(@map_get(*((t->R)), n), *((n->left)))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->left)), @null)), @_vcc_ptr_eq(*((*((n->left))->parent)), n)))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->right)), @null)), @map_get(@map_get(*((t->R)), n), *((n->right)))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->right)), @null)), @_vcc_ptr_eq(*((*((n->right))->parent)), n)))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->parent)), @null)), @map_get(@map_get(*((t->R)), *((t->root))), *((n->parent)))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->parent)), @null)), ||(@_vcc_ptr_eq(*((*((n->parent))->left)), n), @_vcc_ptr_eq(*((*((n->parent))->right)), n))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.left), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)) || $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.right), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
    // assert @inv_check(forall(struct Node* n; { @map_get(@map_get(*((t->R)), *((t->root))), n) } @in_range_phys_ptr((mathint)n); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), @map_get(@map_get(*((t->R)), n), n)))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
    // assert @inv_check(true); 
    assert true;
    // assert @inv_check(forall(struct Node* m; { @map_get(*((t->abs)), *((m->key))) } @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), ==(@map_get(*((t->abs)), *((m->key))), *((m->value)))))); 
    assert (forall Q#m$1^83.29#dt1: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) == $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.value)));
    // assert @inv_check(forall(int32_t k; { @map_get(*((t->abs)), k) } @in_range_i4(k); ==>(forall(struct Node* m; @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), !=(*((m->key)), k))), ==(@map_get(*((t->abs)), k), 0)))); 
    assert (forall Q#k$1^83.29#tc2: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), Q#k$1^83.29#tc2) == 0);
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_eq(*((mark(n)->parent)), @null)), ||(@_vcc_ptr_eq(n, (struct Node*)@null), @_vcc_ptr_eq(n, *((t->root))))))); 
    assert (forall Q#n$1^84.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && $ptr_eq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) || $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), mark(n)), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==(@map_get(@map_get(*((t->R)), mark(n)), m), &&(@map_get(@map_get(*((t->R)), *((t->root))), n), ||(||(||(&&(@_vcc_ptr_eq(n, (struct Node*)@null), @_vcc_ptr_eq(m, (struct Node*)@null)), @_vcc_ptr_eq(m, n)), @map_get(@map_get(*((t->R)), *((n->left))), m)), @map_get(@map_get(*((t->R)), *((n->right))), m)))))); 
    assert (forall Q#n$1^84.29#dt1: int, Q#m$1^84.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && (($ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) && $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr_cast($null, ^Node))) || $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr(^Node, Q#n$1^84.29#dt1)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



function F#lambda#9(#l2: $map_t..$ptr_to..^Node.^^bool, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: int) : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#9: $pure_function;

axiom $function_arg_type(cf#lambda#9, 0, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#9, 1, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#9, 2, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#9, 3, $ptr_to(^Node));

procedure lambda#9(#l2: $map_t..$ptr_to..^Node.^^bool, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: int) returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#9(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#m$1^283.15#dt1: int, #l2: $map_t..$ptr_to..^Node.^^bool, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: int :: { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#9(#l2, #l1, $ref($ptr(^Node, #l0))), $ref($ptr(^Node, Q#m$1^283.15#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^283.15#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, #l0))) ==> $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#9(#l2, #l1, $ref($ptr(^Node, #l0))), $ref($ptr(^Node, Q#m$1^283.15#dt1))) == ($ptr_eq($ptr(^Node, Q#m$1^283.15#dt1), $ptr(^Node, #l0)) || $select.$map_t..$ptr_to..^Node.^^bool(#l1, $ref($ptr(^Node, Q#m$1^283.15#dt1))) || $select.$map_t..$ptr_to..^Node.^^bool(#l2, $ref($ptr(^Node, Q#m$1^283.15#dt1)))));

function F#lambda#8(#l2: $map_t..$ptr_to..^Node.^^bool, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: int) : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#8: $pure_function;

axiom $function_arg_type(cf#lambda#8, 0, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#8, 1, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#8, 2, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#8, 3, $ptr_to(^Node));

procedure lambda#8(#l2: $map_t..$ptr_to..^Node.^^bool, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: int) returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#8(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#m$1^240.15#dt1: int, #l2: $map_t..$ptr_to..^Node.^^bool, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: int :: { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#8(#l2, #l1, $ref($ptr(^Node, #l0))), $ref($ptr(^Node, Q#m$1^240.15#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^240.15#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, #l0))) ==> $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#8(#l2, #l1, $ref($ptr(^Node, #l0))), $ref($ptr(^Node, Q#m$1^240.15#dt1))) == ($ptr_eq($ptr(^Node, Q#m$1^240.15#dt1), $ptr(^Node, #l0)) || $select.$map_t..$ptr_to..^Node.^^bool(#l1, $ref($ptr(^Node, Q#m$1^240.15#dt1))) || $select.$map_t..$ptr_to..^Node.^^bool(#l2, $ref($ptr(^Node, Q#m$1^240.15#dt1)))));

function F#lambda#7(#l1: $map_t..$ptr_to..^Node.^^bool, #l0: int) : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#7: $pure_function;

axiom $function_arg_type(cf#lambda#7, 0, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#7, 1, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#7, 2, $ptr_to(^Node));

procedure lambda#7(#l1: $map_t..$ptr_to..^Node.^^bool, #l0: int) returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#7(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#k$1^194.37#dt1: int, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: int :: { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#7(#l1, $ref($ptr(^Node, #l0))), $ref($ptr(^Node, Q#k$1^194.37#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#k$1^194.37#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, #l0))) ==> $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#7(#l1, $ref($ptr(^Node, #l0))), $ref($ptr(^Node, Q#k$1^194.37#dt1))) == ($ptr_eq($ptr(^Node, Q#k$1^194.37#dt1), $ptr(^Node, #l0)) || $select.$map_t..$ptr_to..^Node.^^bool(#l1, $ref($ptr(^Node, Q#k$1^194.37#dt1)))));

function F#lambda#6(#l1: $map_t..$ptr_to..^Node.^^bool, #l0: int) : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#6: $pure_function;

axiom $function_arg_type(cf#lambda#6, 0, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#6, 1, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#6, 2, $ptr_to(^Node));

procedure lambda#6(#l1: $map_t..$ptr_to..^Node.^^bool, #l0: int) returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#6(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#n$1^163.41#dt1: int, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: int :: { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#6(#l1, $ref($ptr(^Node, #l0))), $ref($ptr(^Node, Q#n$1^163.41#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^163.41#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, #l0))) ==> $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#6(#l1, $ref($ptr(^Node, #l0))), $ref($ptr(^Node, Q#n$1^163.41#dt1))) == ($ptr_eq($ptr(^Node, Q#n$1^163.41#dt1), $ptr(^Node, #l0)) || $select.$map_t..$ptr_to..^Node.^^bool(#l1, $ref($ptr(^Node, Q#n$1^163.41#dt1)))));

function F#lambda#5(#l0: int) : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#5: $pure_function;

axiom $function_arg_type(cf#lambda#5, 0, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#5, 1, $ptr_to(^Node));

procedure lambda#5(#l0: int) returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#5(#l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#n$1^153.15#dt1: int, #l0: int :: { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#5($ref($ptr(^Node, #l0))), $ref($ptr(^Node, Q#n$1^153.15#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^153.15#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, #l0))) ==> $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#5($ref($ptr(^Node, #l0))), $ref($ptr(^Node, Q#n$1^153.15#dt1))) == $ptr_eq($ptr(^Node, Q#n$1^153.15#dt1), $ptr(^Node, #l0)));

function F#lambda#4(#l2: $map_t..^^i4.^^i4, #l1: int, #l0: int) : $map_t..^^i4.^^i4;

const unique cf#lambda#4: $pure_function;

axiom $function_arg_type(cf#lambda#4, 0, $map_t(^^i4, ^^i4));

axiom $function_arg_type(cf#lambda#4, 1, $map_t(^^i4, ^^i4));

axiom $function_arg_type(cf#lambda#4, 2, ^^i4);

axiom $function_arg_type(cf#lambda#4, 3, ^^i4);

procedure lambda#4(#l2: $map_t..^^i4.^^i4, #l1: int, #l0: int) returns ($result: $map_t..^^i4.^^i4);
  free ensures $result == F#lambda#4(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#k$1^151.14#tc2: int, #l2: $map_t..^^i4.^^i4, #l1: int, #l0: int :: { $select.$map_t..^^i4.^^i4(F#lambda#4(#l2, #l1, #l0), Q#k$1^151.14#tc2) } $in_range_i4(Q#k$1^151.14#tc2) && $in_range_i4(#l1) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^i4(F#lambda#4(#l2, #l1, #l0), Q#k$1^151.14#tc2) == (if Q#k$1^151.14#tc2 == #l0 then #l1 else $select.$map_t..^^i4.^^i4(#l2, Q#k$1^151.14#tc2)));

function F#lambda#3() : $map_t..^^i4.^^i4;

const unique cf#lambda#3: $pure_function;

axiom $function_arg_type(cf#lambda#3, 0, $map_t(^^i4, ^^i4));

procedure lambda#3() returns ($result: $map_t..^^i4.^^i4);
  free ensures $result == F#lambda#3();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#k$1^94.14#tc2: int :: { $select.$map_t..^^i4.^^i4(F#lambda#3(), Q#k$1^94.14#tc2) } $in_range_i4(Q#k$1^94.14#tc2) ==> $select.$map_t..^^i4.^^i4(F#lambda#3(), Q#k$1^94.14#tc2) == 0);

function F#lambda#2(#l0: $map_t..$ptr_to..^Node.^^bool) : $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#2: $pure_function;

axiom $function_arg_type(cf#lambda#2, 0, $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));

axiom $function_arg_type(cf#lambda#2, 1, $map_t($ptr_to(^Node), ^^bool));

procedure lambda#2(#l0: $map_t..$ptr_to..^Node.^^bool) returns ($result: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#2(#l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#m$1^93.12#dt1: int, #l0: $map_t..$ptr_to..^Node.^^bool :: { $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(F#lambda#2(#l0), $ref($ptr(^Node, Q#m$1^93.12#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^93.12#dt1))) ==> $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(F#lambda#2(#l0), $ref($ptr(^Node, Q#m$1^93.12#dt1))), #l0));

function F#lambda#1() : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#1: $pure_function;

axiom $function_arg_type(cf#lambda#1, 0, $map_t($ptr_to(^Node), ^^bool));

procedure lambda#1() returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#1();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#n$1^93.12#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#1(), $ref($ptr(^Node, Q#n$1^93.12#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^93.12#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#1(), $ref($ptr(^Node, Q#n$1^93.12#dt1))) == false);

const unique l#public: $label;

type $map_t..$ptr_to..^Node.^^bool;

function $select.$map_t..$ptr_to..^Node.^^bool(M: $map_t..$ptr_to..^Node.^^bool, p: int) : bool;

function $store.$map_t..$ptr_to..^Node.^^bool(M: $map_t..$ptr_to..^Node.^^bool, p: int, v: bool) : $map_t..$ptr_to..^Node.^^bool;

function $eq.$map_t..$ptr_to..^Node.^^bool(M1: $map_t..$ptr_to..^Node.^^bool, M2: $map_t..$ptr_to..^Node.^^bool) : bool;

const $zero.$map_t..$ptr_to..^Node.^^bool: $map_t..$ptr_to..^Node.^^bool;

axiom (forall M: $map_t..$ptr_to..^Node.^^bool, p: int, v: bool :: $select.$map_t..$ptr_to..^Node.^^bool($store.$map_t..$ptr_to..^Node.^^bool(M, p, v), p) == v);

axiom (forall M: $map_t..$ptr_to..^Node.^^bool, p: int, v: bool, q: int :: p != q ==> $select.$map_t..$ptr_to..^Node.^^bool($store.$map_t..$ptr_to..^Node.^^bool(M, q, v), p) == $select.$map_t..$ptr_to..^Node.^^bool(M, p));

axiom (forall M1: $map_t..$ptr_to..^Node.^^bool, M2: $map_t..$ptr_to..^Node.^^bool :: { $eq.$map_t..$ptr_to..^Node.^^bool(M1, M2) } (forall p: int :: $select.$map_t..$ptr_to..^Node.^^bool(M1, p) == $select.$map_t..$ptr_to..^Node.^^bool(M2, p)) ==> $eq.$map_t..$ptr_to..^Node.^^bool(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^Node.^^bool, M2: $map_t..$ptr_to..^Node.^^bool :: { $eq.$map_t..$ptr_to..^Node.^^bool(M1, M2) } $eq.$map_t..$ptr_to..^Node.^^bool(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^Node.^^bool(0) == $zero.$map_t..$ptr_to..^Node.^^bool;

axiom (forall p: int :: $select.$map_t..$ptr_to..^Node.^^bool($zero.$map_t..$ptr_to..^Node.^^bool, p) == false);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t($ptr_to(^Node), ^^bool)) } $eq.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.^^bool($rec_fetch(r1, f)), $int_to_map_t..ptr_to..^Node.^^bool($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

type $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

function $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, p: int) : $map_t..$ptr_to..^Node.^^bool;

function $store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, p: int, v: $map_t..$ptr_to..^Node.^^bool) : $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

function $eq.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, M2: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool) : bool;

const $zero.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

axiom (forall M: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, p: int, v: $map_t..$ptr_to..^Node.^^bool :: $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M, p, v), p) == v);

axiom (forall M: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, p: int, v: $map_t..$ptr_to..^Node.^^bool, q: int :: p != q ==> $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M, q, v), p) == $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M, p));

axiom (forall M1: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, M2: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool :: { $eq.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1, M2) } (forall p: int :: $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1, p), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M2, p))) ==> $eq.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, M2: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool :: { $eq.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1, M2) } $eq.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool(0) == $zero.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

axiom (forall p: int :: $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($zero.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, p) == $zero.$map_t..$ptr_to..^Node.^^bool);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool))) } $eq.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rec_fetch(r1, f)), $int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

type $map_t..^^i4.^^i4;

function $select.$map_t..^^i4.^^i4(M: $map_t..^^i4.^^i4, p: int) : int;

function $store.$map_t..^^i4.^^i4(M: $map_t..^^i4.^^i4, p: int, v: int) : $map_t..^^i4.^^i4;

function $eq.$map_t..^^i4.^^i4(M1: $map_t..^^i4.^^i4, M2: $map_t..^^i4.^^i4) : bool;

const $zero.$map_t..^^i4.^^i4: $map_t..^^i4.^^i4;

axiom (forall M: $map_t..^^i4.^^i4, p: int, v: int :: $in_range_t(^^i4, p) ==> $select.$map_t..^^i4.^^i4($store.$map_t..^^i4.^^i4(M, p, v), p) == $unchecked(^^i4, v));

axiom (forall M: $map_t..^^i4.^^i4, p: int, v: int, q: int :: p != q ==> $select.$map_t..^^i4.^^i4($store.$map_t..^^i4.^^i4(M, q, v), p) == $select.$map_t..^^i4.^^i4(M, p));

axiom (forall M1: $map_t..^^i4.^^i4, M2: $map_t..^^i4.^^i4 :: { $eq.$map_t..^^i4.^^i4(M1, M2) } (forall p: int :: $in_range_t(^^i4, p) ==> $unchecked(^^i4, $select.$map_t..^^i4.^^i4(M1, p)) == $unchecked(^^i4, $select.$map_t..^^i4.^^i4(M2, p))) ==> $eq.$map_t..^^i4.^^i4(M1, M2));

axiom (forall M1: $map_t..^^i4.^^i4, M2: $map_t..^^i4.^^i4 :: { $eq.$map_t..^^i4.^^i4(M1, M2) } $eq.$map_t..^^i4.^^i4(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^i4.^^i4(0) == $zero.$map_t..^^i4.^^i4;

axiom (forall p: int :: $select.$map_t..^^i4.^^i4($zero.$map_t..^^i4.^^i4, p) == 0);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t(^^i4, ^^i4)) } $eq.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rec_fetch(r1, f)), $int_to_map_t..^^i4.^^i4($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

axiom (forall M: $map_t..^^i4.^^i4, p: int :: $in_range_t(^^i4, $select.$map_t..^^i4.^^i4(M, p)));

const unique #loc.#l0: $token;

const unique #loc.#l1: $token;

const unique #loc.#l2: $token;

const unique #tok$1^286.19: $token;

const unique #loc.prestate#96: $token;

const unique #tok$1^283.5: $token;

const unique #loc.res_lambda#9#22: $token;

const unique #tok$1^283.15: $token;

const unique #tok$1^282.5: $token;

const unique #tok$1^276.43: $token;

const unique #loc.owns#94: $token;

const unique #loc.staticWrapState#93: $token;

const unique #loc.prestate#95: $token;

const unique #tok$1^276.19: $token;

const unique #loc.owns#91: $token;

const unique #loc.staticWrapState#90: $token;

const unique #loc.prestate#92: $token;

const unique #tok$1^274.3: $token;

const unique #tok$1^273.3: $token;

const unique #loc.owns#88: $token;

const unique #loc.staticWrapState#87: $token;

const unique #loc.prestate#89: $token;

const unique #tok$1^270.9: $token;

const unique #tok$1^268.9: $token;

const unique #tok$1^266.32: $token;

const unique #loc.prestate#86: $token;

const unique #loc.prestate#84: $token;

const unique #loc.owns#85: $token;

const unique #tok$1^263.32: $token;

const unique #tok$1^262.3: $token;

const unique #loc.owns#82: $token;

const unique #loc.staticWrapState#81: $token;

const unique #loc.prestate#83: $token;

const unique #tok$1^261.44: $token;

const unique #tok$1^261.34: $token;

const unique #loc.prestate#80: $token;

const unique #loc.prestate#78: $token;

const unique #loc.owns#79: $token;

const unique #tok$1^259.3: $token;

const unique #tok$1^257.53: $token;

const unique #loc.prestate#77: $token;

const unique #loc.prestate#75: $token;

const unique #loc.owns#76: $token;

const unique #tok$1^256.3: $token;

const unique #tok$1^255.53: $token;

const unique #loc.prestate#74: $token;

const unique #loc.prestate#72: $token;

const unique #loc.owns#73: $token;

const unique #tok$1^254.19: $token;

const unique #loc.prestate#71: $token;

const unique #tok$1^252.3: $token;

const unique #tok$1^246.1: $token;

const unique #tok$1^243.19: $token;

const unique #loc.prestate#70: $token;

const unique #tok$1^240.5: $token;

const unique #loc.res_lambda#8#21: $token;

const unique #tok$1^240.15: $token;

const unique #tok$1^239.5: $token;

const unique #tok$1^233.43: $token;

const unique #loc.owns#68: $token;

const unique #loc.staticWrapState#67: $token;

const unique #loc.prestate#69: $token;

const unique #tok$1^233.19: $token;

const unique #loc.owns#65: $token;

const unique #loc.staticWrapState#64: $token;

const unique #loc.prestate#66: $token;

const unique #tok$1^232.3: $token;

const unique #tok$1^231.3: $token;

const unique #loc.owns#62: $token;

const unique #loc.staticWrapState#61: $token;

const unique #loc.prestate#63: $token;

const unique #tok$1^228.9: $token;

const unique #tok$1^226.9: $token;

const unique #tok$1^224.32: $token;

const unique #loc.prestate#60: $token;

const unique #loc.prestate#58: $token;

const unique #loc.owns#59: $token;

const unique #tok$1^221.5: $token;

const unique #tok$1^219.3: $token;

const unique #loc.owns#56: $token;

const unique #loc.staticWrapState#55: $token;

const unique #loc.prestate#57: $token;

const unique #tok$1^218.43: $token;

const unique #tok$1^218.34: $token;

const unique #loc.prestate#54: $token;

const unique #loc.prestate#52: $token;

const unique #loc.owns#53: $token;

const unique #tok$1^216.3: $token;

const unique #tok$1^214.53: $token;

const unique #loc.prestate#51: $token;

const unique #loc.prestate#49: $token;

const unique #loc.owns#50: $token;

const unique #tok$1^213.3: $token;

const unique #tok$1^212.53: $token;

const unique #loc.prestate#48: $token;

const unique #loc.prestate#46: $token;

const unique #loc.owns#47: $token;

const unique #tok$1^211.19: $token;

const unique #loc.prestate#45: $token;

const unique #loc.y: $token;

const unique #tok$1^209.3: $token;

const unique #tok$1^203.1: $token;

const unique #tok$1^200.19: $token;

const unique #loc.prestate#44: $token;

const unique #tok$1^199.19: $token;

const unique #loc.owns#42: $token;

const unique #loc.staticWrapState#41: $token;

const unique #loc.prestate#43: $token;

const unique #tok$1^198.3: $token;

const unique #tok$1^195.5: $token;

const unique #tok$1^194.27: $token;

const unique #loc.res_lambda#7#20: $token;

const unique #tok$1^194.37: $token;

const unique #loc.owns#39: $token;

const unique #loc.staticWrapState#38: $token;

const unique #loc.prestate#40: $token;

const unique #tok$1^187.41: $token;

const unique #tok$1^187.36: $token;

const unique #loc.prestate#37: $token;

const unique #loc.prestate#35: $token;

const unique #loc.owns#36: $token;

const unique #tok$1^185.7: $token;

const unique #loc.owns#33: $token;

const unique #loc.staticWrapState#32: $token;

const unique #loc.prestate#34: $token;

const unique #tok$1^181.41: $token;

const unique #tok$1^181.36: $token;

const unique #loc.prestate#31: $token;

const unique #loc.prestate#29: $token;

const unique #loc.owns#30: $token;

const unique #tok$1^179.7: $token;

const unique #tok$1^167.3: $token;

axiom $type_code_is(3, $ptr_to(^^void));

const unique #distTp6: $ctype;

axiom #distTp6 == $ptr_to(^^void);

const unique #tok$1^168.28: $token;

const unique #tok$1^163.25: $token;

const unique #loc.res_lambda#6#19: $token;

const unique #tok$1^163.41: $token;

const unique #tok$1^159.21: $token;

const unique #loc.prestate#28: $token;

const unique #tok$1^158.21: $token;

const unique #loc.owns#26: $token;

const unique #loc.staticWrapState#25: $token;

const unique #loc.prestate#27: $token;

const unique #tok$1^157.5: $token;

const unique #tok$1^153.5: $token;

const unique #loc.res_lambda#5#18: $token;

const unique #tok$1^153.15: $token;

const unique #tok$1^152.5: $token;

const unique #tok$1^151.5: $token;

const unique #loc.res_lambda#4#17: $token;

const unique #tok$1^151.14: $token;

const unique #tok$1^148.3: $token;

const unique #tok$1^146.3: $token;

const unique #tok$1^146.13: $token;

const unique #tok$1^146.24: $token;

const unique #loc.assign#13: $token;

const unique #loc.assign#12: $token;

const unique #tok$1^144.19: $token;

const unique #loc.prestate#24: $token;

const unique #loc.n: $token;

const unique #tok$1^142.3: $token;

const unique #loc.x: $token;

const unique #tok$1^134.1: $token;

const unique #tok$1^126.13: $token;

const unique #loc.r: $token;

const unique #tok$1^126.3: $token;

const unique #tok$1^122.1: $token;

const unique #tok$1^115.7: $token;

const unique #tok$1^113.7: $token;

const unique #tok$1^108.3: $token;

const unique #tok$1^107.3: $token;

const unique #tok$1^106.3: $token;

const unique #loc.key: $token;

const unique #tok$1^101.1: $token;

const unique #tok$1^97.19: $token;

function $state_to_int(x: $state) : int;

function $int_to_state(x: int) : $state;

axiom (forall #x: $state :: #x == $int_to_state($state_to_int(#x)));

const unique #loc.prestate#23: $token;

const unique #tok$2^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(2, #file^?3Cno?20file?3E);

const unique #tok$1^95.5: $token;

const unique #tok$1^94.5: $token;

const unique #loc.res_lambda#3#16: $token;

const unique #tok$1^94.14: $token;

const unique #tok$1^93.5: $token;

function $map_t..ptr_to..^Node.^^bool_to_int(x: $map_t..$ptr_to..^Node.^^bool) : int;

function $int_to_map_t..ptr_to..^Node.^^bool(x: int) : $map_t..$ptr_to..^Node.^^bool;

axiom (forall #x: $map_t..$ptr_to..^Node.^^bool :: #x == $int_to_map_t..ptr_to..^Node.^^bool($map_t..ptr_to..^Node.^^bool_to_int(#x)));

const unique #loc.res_lambda#1#15: $token;

const unique #loc.res_lambda#2#14: $token;

const unique #tok$1^93.12: $token;

const unique #tok$1^91.3: $token;

const unique #loc.t: $token;

const unique #tok$1^87.1: $token;

const unique #tok$1^49.39: $token;

const unique #tok$1^47.39: $token;

const unique #loc.p: $token;

const unique #tok$1^46.39: $token;

const unique #distTp5: $ctype;

axiom #distTp5 == $ptr_to(^Tree);

const unique #loc._this_: $token;

const unique #tok$1^77.31: $token;

axiom $type_code_is(2, ^^i4);

function $map_t..^^i4.^^i4_to_int(x: $map_t..^^i4.^^i4) : int;

function $int_to_map_t..^^i4.^^i4(x: int) : $map_t..^^i4.^^i4;

axiom (forall #x: $map_t..^^i4.^^i4 :: #x == $int_to_map_t..^^i4.^^i4($map_t..^^i4.^^i4_to_int(#x)));

const unique #distTp4: $ctype;

axiom #distTp4 == $map_t(^^i4, ^^i4);

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvacid?2D0?5CRedBlackTrees.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvacid?2D0?5CRedBlackTrees.c);

function $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int(x: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool) : int;

function $int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool(x: int) : $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

axiom (forall #x: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool :: #x == $int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int(#x)));

const unique #distTp3: $ctype;

axiom #distTp3 == $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool));

const unique #distTp2: $ctype;

axiom #distTp2 == $map_t($ptr_to(^Node), ^^bool);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^Node);
