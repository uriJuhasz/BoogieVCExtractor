axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^Node: $ctype;

axiom $is_composite(^Node);

axiom $ptr_level(^Node) == 0;

axiom $sizeof(^Node) == 32;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Node) } $inv2(#s1, #s2, #p, ^Node) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty()) && $closed(#s2, $read_ptr(#s2, $dot(#p, Node.m), ^Mgr)) && ($ptr_neq($read_ptr(#s2, $dot(#p, Node.l), ^Node), $null) ==> $ptr_neq($read_ptr(#s2, $dot(#p, Node.l), ^Node), #p)) && ($ptr_neq($read_ptr(#s2, $dot(#p, Node.l), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot(#p, Node.l), ^Node), Node.p), ^Node), #p)) && ($ptr_neq($read_ptr(#s2, $dot(#p, Node.l), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot(#p, Node.l), ^Node), Node.m), ^Mgr), $read_ptr(#s2, $dot(#p, Node.m), ^Mgr))) && ($ptr_neq($read_ptr(#s2, $dot(#p, Node.l), ^Node), $null) ==> $closed(#s2, $read_ptr(#s2, $dot(#p, Node.l), ^Node))) && ($ptr_neq($read_ptr(#s2, $dot(#p, Node.r), ^Node), $null) ==> $ptr_neq($read_ptr(#s2, $dot(#p, Node.r), ^Node), #p)) && ($ptr_neq($read_ptr(#s2, $dot(#p, Node.r), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot(#p, Node.r), ^Node), Node.p), ^Node), #p)) && ($ptr_neq($read_ptr(#s2, $dot(#p, Node.r), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot(#p, Node.r), ^Node), Node.m), ^Mgr), $read_ptr(#s2, $dot(#p, Node.m), ^Mgr))) && ($ptr_neq($read_ptr(#s2, $dot(#p, Node.r), ^Node), $null) ==> $closed(#s2, $read_ptr(#s2, $dot(#p, Node.r), ^Node))) && ($ptr_eq(#p, $read_ptr(#s2, $dot($read_ptr(#s2, $dot(#p, Node.m), ^Mgr), Mgr.except), ^Node)) || $mem(#s2, $dot(#p, Node.sum)) == $unchk_add(^^i4, $unchk_add(^^i4, $mem(#s2, $dot(#p, Node.val)), (if $ptr_eq($read_ptr(#s2, $dot(#p, Node.l), ^Node), $null) then 0 else $mem(#s2, $dot($read_ptr(#s2, $dot(#p, Node.l), ^Node), Node.sum)))), (if $ptr_eq($read_ptr(#s2, $dot(#p, Node.r), ^Node), $null) then 0 else $mem(#s2, $dot($read_ptr(#s2, $dot(#p, Node.r), ^Node), Node.sum))))) && ($mem(#s1, $dot(#p, Node.sum)) == $mem(#s2, $dot(#p, Node.sum)) || $inv(#s2, $read_ptr(#s2, $dot(#p, Node.p), ^Node), ^Node) || $ptr_eq($read_ptr(#s2, $dot(#p, Node.p), ^Node), $null)) && ($closed(#s1, #p) && !$closed(#s2, #p) ==> false)));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^Node, #r), l#public) } $inv_lab(#s2, $ptr(^Node, #r), l#public) == ($typed(#s2, $ptr(^Node, #r)) && $set_eq($owns(#s2, $ptr(^Node, #r)), $set_empty()) && $closed(#s2, $read_ptr(#s2, $dot($ptr(^Node, #r), Node.m), ^Mgr)) && ($ptr_neq($read_ptr(#s2, $dot($ptr(^Node, #r), Node.l), ^Node), $null) ==> $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, #r), Node.l), ^Node), $ptr(^Node, #r))) && ($ptr_neq($read_ptr(#s2, $dot($ptr(^Node, #r), Node.l), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^Node, #r), Node.l), ^Node), Node.p), ^Node), $ptr(^Node, #r))) && ($ptr_neq($read_ptr(#s2, $dot($ptr(^Node, #r), Node.l), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^Node, #r), Node.l), ^Node), Node.m), ^Mgr), $read_ptr(#s2, $dot($ptr(^Node, #r), Node.m), ^Mgr))) && ($ptr_neq($read_ptr(#s2, $dot($ptr(^Node, #r), Node.l), ^Node), $null) ==> $closed(#s2, $read_ptr(#s2, $dot($ptr(^Node, #r), Node.l), ^Node))) && ($ptr_neq($read_ptr(#s2, $dot($ptr(^Node, #r), Node.r), ^Node), $null) ==> $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, #r), Node.r), ^Node), $ptr(^Node, #r))) && ($ptr_neq($read_ptr(#s2, $dot($ptr(^Node, #r), Node.r), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^Node, #r), Node.r), ^Node), Node.p), ^Node), $ptr(^Node, #r))) && ($ptr_neq($read_ptr(#s2, $dot($ptr(^Node, #r), Node.r), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^Node, #r), Node.r), ^Node), Node.m), ^Mgr), $read_ptr(#s2, $dot($ptr(^Node, #r), Node.m), ^Mgr))) && ($ptr_neq($read_ptr(#s2, $dot($ptr(^Node, #r), Node.r), ^Node), $null) ==> $closed(#s2, $read_ptr(#s2, $dot($ptr(^Node, #r), Node.r), ^Node))) && ($ptr_eq($ptr(^Node, #r), $read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^Node, #r), Node.m), ^Mgr), Mgr.except), ^Node)) || $mem(#s2, $dot($ptr(^Node, #r), Node.sum)) == $unchk_add(^^i4, $unchk_add(^^i4, $mem(#s2, $dot($ptr(^Node, #r), Node.val)), (if $ptr_eq($read_ptr(#s2, $dot($ptr(^Node, #r), Node.l), ^Node), $null) then 0 else $mem(#s2, $dot($read_ptr(#s2, $dot($ptr(^Node, #r), Node.l), ^Node), Node.sum)))), (if $ptr_eq($read_ptr(#s2, $dot($ptr(^Node, #r), Node.r), ^Node), $null) then 0 else $mem(#s2, $dot($read_ptr(#s2, $dot($ptr(^Node, #r), Node.r), ^Node), Node.sum))))) && (true || $inv(#s2, $read_ptr(#s2, $dot($ptr(^Node, #r), Node.p), ^Node), ^Node) || $ptr_eq($read_ptr(#s2, $dot($ptr(^Node, #r), Node.p), ^Node), $null)) && ($closed(#s2, $ptr(^Node, #r)) && !$closed(#s2, $ptr(^Node, #r)) ==> false)));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^Node, #r)) } $in_full_extent_of(#q, $ptr(^Node, #r)) == (#q == $ptr(^Node, #r) || #q == $dot($ptr(^Node, #r), Node.$owns) || #q == $dot($ptr(^Node, #r), Node.l) || #q == $dot($ptr(^Node, #r), Node.r) || #q == $dot($ptr(^Node, #r), Node.p) || #q == $dot($ptr(^Node, #r), Node.val) || #q == $dot($ptr(^Node, #r), Node.sum) || #q == $dot($ptr(^Node, #r), Node.m)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Node, #r)) } $in_extent_of(#s, #q, $ptr(^Node, #r)) == $in_struct_extent_of(#q, $ptr(^Node, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Node, #r)) } $typed(#s, $ptr(^Node, #r)) ==> $in_extent_of(#s, #q, $ptr(^Node, #r)) == (#q == $ptr(^Node, #r) || $emb(#s, #q) == $ptr(^Node, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^Node, #r)) } $in_span_of(#q, $ptr(^Node, #r)) == (#q == $ptr(^Node, #r) || #q == $dot($ptr(^Node, #r), Node.$owns) || #q == $dot($ptr(^Node, #r), Node.l) || #q == $dot($ptr(^Node, #r), Node.r) || #q == $dot($ptr(^Node, #r), Node.p) || #q == $dot($ptr(^Node, #r), Node.val) || #q == $dot($ptr(^Node, #r), Node.sum) || #q == $dot($ptr(^Node, #r), Node.m)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^Node) } $state_spans_the_same(#s1, #s2, #p, ^Node) == ($mem_eq(#s1, #s2, $dot(#p, Node.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Node.l)) && $mem_eq(#s1, #s2, $dot(#p, Node.r)) && $mem_eq(#s1, #s2, $dot(#p, Node.p)) && $mem_eq(#s1, #s2, $dot(#p, Node.val)) && $mem_eq(#s1, #s2, $dot(#p, Node.sum)) && $mem_eq(#s1, #s2, $dot(#p, Node.m))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Node) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Node) == ($mem_eq(#s1, #s2, $dot(#p, Node.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Node.l)) && $mem_eq(#s1, #s2, $dot(#p, Node.r)) && $mem_eq(#s1, #s2, $dot(#p, Node.p)) && $mem_eq(#s1, #s2, $dot(#p, Node.m))));

axiom $is_claimable(^Node) == false;

axiom $has_volatile_owns_set(^Node) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^Node, #r)) } $extent_mutable(#s1, $ptr(^Node, #r)) == $mutable(#s1, $ptr(^Node, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^Node, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^Node, #r)) == $is_fresh(#s1, #s2, $ptr(^Node, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^Node, #r)) } $extent_zero(#s1, $ptr(^Node, #r)) == ($mem(#s1, $dot($ptr(^Node, #r), Node.l)) == 0 && $mem(#s1, $dot($ptr(^Node, #r), Node.r)) == 0 && $mem(#s1, $dot($ptr(^Node, #r), Node.p)) == 0 && $mem(#s1, $dot($ptr(^Node, #r), Node.val)) == 0 && $mem(#s1, $dot($ptr(^Node, #r), Node.sum)) == 0 && $mem(#s1, $dot($ptr(^Node, #r), Node.m)) == 0));

const unique Node.$owns: $field;

axiom $static_field_properties(Node.$owns, ^Node);

axiom $is_primitive_non_volatile_field(Node.$owns);

axiom (forall #p: $ptr :: { $dot(#p, Node.$owns) } $is(#p, ^Node) ==> $dot(#p, Node.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, Node.$owns)) && $extent_hint($dot(#p, Node.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.$owns)) } { $st(#s, $dot(#p, Node.$owns)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.$owns, ^$#ptrset, false));

axiom $owns_set_field(^Node) == Node.$owns;

const unique Node.l: $field;

axiom $static_field_properties(Node.l, ^Node);

axiom $is_primitive_non_volatile_field(Node.l);

axiom $field_offset(Node.l) == 0;

axiom (forall #p: $ptr :: { $dot(#p, Node.l) } $is(#p, ^Node) ==> $dot(#p, Node.l) == $ptr($ptr_to(^Node), $ref(#p) + 0) && $extent_hint($dot(#p, Node.l), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.l)) } { $st(#s, $dot(#p, Node.l)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.l, $ptr_to(^Node), false));

const unique Node.r: $field;

axiom $static_field_properties(Node.r, ^Node);

axiom $is_primitive_non_volatile_field(Node.r);

axiom $field_offset(Node.r) == 8;

axiom (forall #p: $ptr :: { $dot(#p, Node.r) } $is(#p, ^Node) ==> $dot(#p, Node.r) == $ptr($ptr_to(^Node), $ref(#p) + 8) && $extent_hint($dot(#p, Node.r), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.r)) } { $st(#s, $dot(#p, Node.r)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.r, $ptr_to(^Node), false));

const unique Node.p: $field;

axiom $static_field_properties(Node.p, ^Node);

axiom $is_primitive_non_volatile_field(Node.p);

axiom $field_offset(Node.p) == 16;

axiom (forall #p: $ptr :: { $dot(#p, Node.p) } $is(#p, ^Node) ==> $dot(#p, Node.p) == $ptr($ptr_to(^Node), $ref(#p) + 16) && $extent_hint($dot(#p, Node.p), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.p)) } { $st(#s, $dot(#p, Node.p)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.p, $ptr_to(^Node), false));

const unique Node.val: $field;

axiom $static_field_properties(Node.val, ^Node);

axiom $is_primitive_volatile_field(Node.val);

axiom $field_offset(Node.val) == 24;

axiom (forall #p: $ptr :: { $dot(#p, Node.val) } $is(#p, ^Node) ==> $dot(#p, Node.val) == $ptr(^^i4, $ref(#p) + 24) && $extent_hint($dot(#p, Node.val), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.val)) } { $st(#s, $dot(#p, Node.val)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.val, ^^i4, true));

const unique Node.sum: $field;

axiom $static_field_properties(Node.sum, ^Node);

axiom $is_primitive_volatile_field(Node.sum);

axiom $field_offset(Node.sum) == 28;

axiom (forall #p: $ptr :: { $dot(#p, Node.sum) } $is(#p, ^Node) ==> $dot(#p, Node.sum) == $ptr(^^i4, $ref(#p) + 28) && $extent_hint($dot(#p, Node.sum), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.sum)) } { $st(#s, $dot(#p, Node.sum)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.sum, ^^i4, true));

const unique Node.m: $field;

axiom $static_field_properties(Node.m, ^Node);

axiom $is_primitive_non_volatile_field(Node.m);

axiom (forall #p: $ptr :: { $dot(#p, Node.m) } $is(#p, ^Node) ==> $dot(#p, Node.m) == $ptr($spec_ptr_to(^Mgr), $ghost_ref(#p, Node.m)) && $extent_hint($dot(#p, Node.m), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.m)) } { $st(#s, $dot(#p, Node.m)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.m, $spec_ptr_to(^Mgr), false));

procedure Node#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $set_eq($owns($s, $ptr(^Node, P#_this_)), $set_empty());
  ensures $is_admissibility_check() ==> $closed($s, $read_ptr($s, $dot($ptr(^Node, P#_this_), Node.m), ^Mgr));
  ensures $is_admissibility_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.l), ^Node), $null) ==> $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.l), ^Node), $ptr(^Node, P#_this_));
  ensures $is_admissibility_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.l), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.l), ^Node), Node.p), ^Node), $ptr(^Node, P#_this_));
  ensures $is_admissibility_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.l), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.l), ^Node), Node.m), ^Mgr), $read_ptr($s, $dot($ptr(^Node, P#_this_), Node.m), ^Mgr));
  ensures $is_admissibility_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.l), ^Node), $null) ==> $closed($s, $read_ptr($s, $dot($ptr(^Node, P#_this_), Node.l), ^Node));
  ensures $is_admissibility_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.r), ^Node), $null) ==> $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.r), ^Node), $ptr(^Node, P#_this_));
  ensures $is_admissibility_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.r), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.r), ^Node), Node.p), ^Node), $ptr(^Node, P#_this_));
  ensures $is_admissibility_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.r), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.r), ^Node), Node.m), ^Mgr), $read_ptr($s, $dot($ptr(^Node, P#_this_), Node.m), ^Mgr));
  ensures $is_admissibility_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.r), ^Node), $null) ==> $closed($s, $read_ptr($s, $dot($ptr(^Node, P#_this_), Node.r), ^Node));
  ensures $is_admissibility_check() ==> $ptr_eq($ptr(^Node, P#_this_), $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.m), ^Mgr), Mgr.except), ^Node)) || $mem($s, $dot($ptr(^Node, P#_this_), Node.sum)) == $unchk_add(^^i4, $unchk_add(^^i4, $mem($s, $dot($ptr(^Node, P#_this_), Node.val)), (if $ptr_eq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.l), ^Node), $null) then 0 else $mem($s, $dot($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.l), ^Node), Node.sum)))), (if $ptr_eq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.r), ^Node), $null) then 0 else $mem($s, $dot($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.r), ^Node), Node.sum))));
  ensures $is_admissibility_check() ==> $mem(old($s), $dot($ptr(^Node, P#_this_), Node.sum)) == $mem($s, $dot($ptr(^Node, P#_this_), Node.sum)) || $inv($s, $read_ptr($s, $dot($ptr(^Node, P#_this_), Node.p), ^Node), ^Node) || $ptr_eq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.p), ^Node), $null);
  ensures $is_admissibility_check() ==> $closed(old($s), $ptr(^Node, P#_this_)) && !$closed($s, $ptr(^Node, P#_this_)) ==> false;
  ensures $is_stuttering_check() ==> $mem($s, $dot($ptr(^Node, P#_this_), Node.sum)) == $mem($s, $dot($ptr(^Node, P#_this_), Node.sum)) || $inv($s, $read_ptr($s, $dot($ptr(^Node, P#_this_), Node.p), ^Node), ^Node) || $ptr_eq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.p), ^Node), $null);
  ensures $is_stuttering_check() ==> $closed($s, $ptr(^Node, P#_this_)) && !$closed($s, $ptr(^Node, P#_this_)) ==> false;
  ensures $is_unwrap_check() ==> $set_eq($owns($s, $ptr(^Node, P#_this_)), $set_empty());
  ensures $is_unwrap_check() ==> $closed($s, $read_ptr($s, $dot($ptr(^Node, P#_this_), Node.m), ^Mgr));
  ensures $is_unwrap_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.l), ^Node), $null) ==> $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.l), ^Node), $ptr(^Node, P#_this_));
  ensures $is_unwrap_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.l), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.l), ^Node), Node.p), ^Node), $ptr(^Node, P#_this_));
  ensures $is_unwrap_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.l), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.l), ^Node), Node.m), ^Mgr), $read_ptr($s, $dot($ptr(^Node, P#_this_), Node.m), ^Mgr));
  ensures $is_unwrap_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.l), ^Node), $null) ==> $closed($s, $read_ptr($s, $dot($ptr(^Node, P#_this_), Node.l), ^Node));
  ensures $is_unwrap_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.r), ^Node), $null) ==> $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.r), ^Node), $ptr(^Node, P#_this_));
  ensures $is_unwrap_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.r), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.r), ^Node), Node.p), ^Node), $ptr(^Node, P#_this_));
  ensures $is_unwrap_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.r), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.r), ^Node), Node.m), ^Mgr), $read_ptr($s, $dot($ptr(^Node, P#_this_), Node.m), ^Mgr));
  ensures $is_unwrap_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.r), ^Node), $null) ==> $closed($s, $read_ptr($s, $dot($ptr(^Node, P#_this_), Node.r), ^Node));
  ensures $is_unwrap_check() ==> $ptr_eq($ptr(^Node, P#_this_), $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.m), ^Mgr), Mgr.except), ^Node)) || $mem($s, $dot($ptr(^Node, P#_this_), Node.sum)) == $unchk_add(^^i4, $unchk_add(^^i4, $mem($s, $dot($ptr(^Node, P#_this_), Node.val)), (if $ptr_eq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.l), ^Node), $null) then 0 else $mem($s, $dot($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.l), ^Node), Node.sum)))), (if $ptr_eq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.r), ^Node), $null) then 0 else $mem($s, $dot($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.r), ^Node), Node.sum))));
  ensures $is_unwrap_check() ==> $mem(old($s), $dot($ptr(^Node, P#_this_), Node.sum)) == $mem($s, $dot($ptr(^Node, P#_this_), Node.sum)) || $inv($s, $read_ptr($s, $dot($ptr(^Node, P#_this_), Node.p), ^Node), ^Node) || $ptr_eq($read_ptr($s, $dot($ptr(^Node, P#_this_), Node.p), ^Node), $null);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Node#adm(P#_this_: int)
{
  var #wrTime$1^38.1: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^38.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^38.1, #loc._this_, $ptr_to_int($ptr(^Node, P#_this_)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^38.1, #loc._this_, $ptr(^Node, P#_this_), $ptr_to(^Node));
    assume #wrTime$1^38.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^38.1, #p) } $in_writes_at(#wrTime$1^38.1, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^Node, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^Node, P#_this_));
        assume $good_state_ext(#tok$1^38.1, $s);
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
            assume $admissibility_pre($s, $ptr(^Node, P#_this_));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^Node, P#_this_));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Node*)@null))
        call $havoc_others($ptr(^Node, P#_this_), ^Node);
        assume $good_state_ext(#tok$1^38.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^Node, P#_this_), ^Node);
    }

  #exit:
}



const unique ^Mgr: $ctype;

axiom $is_composite(^Mgr);

axiom $ptr_level(^Mgr) == 0;

axiom $sizeof(^Mgr) == 1;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Mgr) } $inv2(#s1, #s2, #p, ^Mgr) == ($typed(#s2, #p) && ($ptr_eq($read_ptr(#s1, $dot(#p, Mgr.except), ^Node), $read_ptr(#s2, $dot(#p, Mgr.except), ^Node)) || $ptr_eq($read_ptr(#s1, $dot(#p, Mgr.except), ^Node), $null) || $inv(#s2, $read_ptr(#s1, $dot(#p, Mgr.except), ^Node), ^Node)) && $inv_is_owner_approved(#s1, #s2, #p, Mgr.except) && (forall Q#n$1^56.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^56.29#dt1))) ==> $set_in($ptr(^Node, Q#n$1^56.29#dt1), $owns(#s2, #p)) ==> $ptr_eq($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^56.29#dt1), Node.m), ^Mgr), #p)) && (forall Q#n$1^57.30#dt1: int :: { $set_in($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^57.30#dt1), Node.p), ^Node), $owns(#s2, #p)) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^57.30#dt1))) ==> $set_in($ptr(^Node, Q#n$1^57.30#dt1), $owns(#s2, #p)) ==> $ptr_eq($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^57.30#dt1), Node.p), ^Node), $null) || $set_in($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^57.30#dt1), Node.p), ^Node), $owns(#s2, #p))) && (forall Q#n$1^58.30#dt1: int :: { $set_in($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^58.30#dt1), Node.l), ^Node), $owns(#s2, #p)) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^58.30#dt1))) ==> $set_in($ptr(^Node, Q#n$1^58.30#dt1), $owns(#s2, #p)) ==> $ptr_eq($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^58.30#dt1), Node.l), ^Node), $null) || $set_in($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^58.30#dt1), Node.l), ^Node), $owns(#s2, #p))) && (forall Q#n$1^59.30#dt1: int :: { $set_in($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^59.30#dt1), Node.r), ^Node), $owns(#s2, #p)) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^59.30#dt1))) ==> $set_in($ptr(^Node, Q#n$1^59.30#dt1), $owns(#s2, #p)) ==> $ptr_eq($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^59.30#dt1), Node.r), ^Node), $null) || $set_in($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^59.30#dt1), Node.r), ^Node), $owns(#s2, #p))) && ($closed(#s1, #p) && !$closed(#s2, #p) ==> false)));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^Mgr, #r), l#public) } $inv_lab(#s2, $ptr(^Mgr, #r), l#public) == ($typed(#s2, $ptr(^Mgr, #r)) && ($ptr_eq($read_ptr(#s2, $dot($ptr(^Mgr, #r), Mgr.except), ^Node), $read_ptr(#s2, $dot($ptr(^Mgr, #r), Mgr.except), ^Node)) || $ptr_eq($read_ptr(#s2, $dot($ptr(^Mgr, #r), Mgr.except), ^Node), $null) || $inv(#s2, $read_ptr(#s2, $dot($ptr(^Mgr, #r), Mgr.except), ^Node), ^Node)) && $inv_is_owner_approved(#s2, #s2, $ptr(^Mgr, #r), Mgr.except) && (forall Q#n$1^56.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^56.29#dt1))) ==> $set_in($ptr(^Node, Q#n$1^56.29#dt1), $owns(#s2, $ptr(^Mgr, #r))) ==> $ptr_eq($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^56.29#dt1), Node.m), ^Mgr), $ptr(^Mgr, #r))) && (forall Q#n$1^57.30#dt1: int :: { $set_in($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^57.30#dt1), Node.p), ^Node), $owns(#s2, $ptr(^Mgr, #r))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^57.30#dt1))) ==> $set_in($ptr(^Node, Q#n$1^57.30#dt1), $owns(#s2, $ptr(^Mgr, #r))) ==> $ptr_eq($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^57.30#dt1), Node.p), ^Node), $null) || $set_in($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^57.30#dt1), Node.p), ^Node), $owns(#s2, $ptr(^Mgr, #r)))) && (forall Q#n$1^58.30#dt1: int :: { $set_in($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^58.30#dt1), Node.l), ^Node), $owns(#s2, $ptr(^Mgr, #r))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^58.30#dt1))) ==> $set_in($ptr(^Node, Q#n$1^58.30#dt1), $owns(#s2, $ptr(^Mgr, #r))) ==> $ptr_eq($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^58.30#dt1), Node.l), ^Node), $null) || $set_in($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^58.30#dt1), Node.l), ^Node), $owns(#s2, $ptr(^Mgr, #r)))) && (forall Q#n$1^59.30#dt1: int :: { $set_in($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^59.30#dt1), Node.r), ^Node), $owns(#s2, $ptr(^Mgr, #r))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^59.30#dt1))) ==> $set_in($ptr(^Node, Q#n$1^59.30#dt1), $owns(#s2, $ptr(^Mgr, #r))) ==> $ptr_eq($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^59.30#dt1), Node.r), ^Node), $null) || $set_in($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^59.30#dt1), Node.r), ^Node), $owns(#s2, $ptr(^Mgr, #r)))) && ($closed(#s2, $ptr(^Mgr, #r)) && !$closed(#s2, $ptr(^Mgr, #r)) ==> false)));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^Mgr, #r)) } $in_full_extent_of(#q, $ptr(^Mgr, #r)) == (#q == $ptr(^Mgr, #r) || #q == $dot($ptr(^Mgr, #r), Mgr.$owns) || #q == $dot($ptr(^Mgr, #r), Mgr.except)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Mgr, #r)) } $in_extent_of(#s, #q, $ptr(^Mgr, #r)) == $in_struct_extent_of(#q, $ptr(^Mgr, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Mgr, #r)) } $typed(#s, $ptr(^Mgr, #r)) ==> $in_extent_of(#s, #q, $ptr(^Mgr, #r)) == (#q == $ptr(^Mgr, #r) || $emb(#s, #q) == $ptr(^Mgr, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^Mgr, #r)) } $in_span_of(#q, $ptr(^Mgr, #r)) == (#q == $ptr(^Mgr, #r) || #q == $dot($ptr(^Mgr, #r), Mgr.$owns) || #q == $dot($ptr(^Mgr, #r), Mgr.except)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^Mgr) } $state_spans_the_same(#s1, #s2, #p, ^Mgr) == ($mem_eq(#s1, #s2, $dot(#p, Mgr.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Mgr.except))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Mgr) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Mgr) == $mem_eq(#s1, #s2, $dot(#p, Mgr.$owns)));

axiom $is_claimable(^Mgr) == false;

axiom $has_volatile_owns_set(^Mgr) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^Mgr, #r)) } $extent_mutable(#s1, $ptr(^Mgr, #r)) == $mutable(#s1, $ptr(^Mgr, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^Mgr, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^Mgr, #r)) == $is_fresh(#s1, #s2, $ptr(^Mgr, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^Mgr, #r)) } $extent_zero(#s1, $ptr(^Mgr, #r)) == ($mem(#s1, $dot($ptr(^Mgr, #r), Mgr.except)) == 0));

const unique Mgr.$owns: $field;

axiom $static_field_properties(Mgr.$owns, ^Mgr);

axiom $is_primitive_non_volatile_field(Mgr.$owns);

axiom (forall #p: $ptr :: { $dot(#p, Mgr.$owns) } $is(#p, ^Mgr) ==> $dot(#p, Mgr.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, Mgr.$owns)) && $extent_hint($dot(#p, Mgr.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Mgr.$owns)) } { $st(#s, $dot(#p, Mgr.$owns)) } $typed2(#s, #p, ^Mgr) ==> $field_properties(#s, #p, Mgr.$owns, ^$#ptrset, false));

axiom $owns_set_field(^Mgr) == Mgr.$owns;

const unique Mgr.except: $field;

axiom $static_field_properties(Mgr.except, ^Mgr);

axiom $is_primitive_volatile_field(Mgr.except);

axiom (forall #p: $ptr :: { $dot(#p, Mgr.except) } $is(#p, ^Mgr) ==> $dot(#p, Mgr.except) == $ptr($ptr_to(^Node), $ghost_ref(#p, Mgr.except)) && $extent_hint($dot(#p, Mgr.except), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Mgr.except)) } { $st(#s, $dot(#p, Mgr.except)) } $typed2(#s, #p, ^Mgr) ==> $field_properties(#s, #p, Mgr.except, $ptr_to(^Node), true));

procedure Mgr#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $ptr_eq($read_ptr(old($s), $dot($ptr(^Mgr, P#_this_), Mgr.except), ^Node), $read_ptr($s, $dot($ptr(^Mgr, P#_this_), Mgr.except), ^Node)) || $ptr_eq($read_ptr(old($s), $dot($ptr(^Mgr, P#_this_), Mgr.except), ^Node), $null) || $inv($s, $read_ptr(old($s), $dot($ptr(^Mgr, P#_this_), Mgr.except), ^Node), ^Node);
  ensures $is_admissibility_check() ==> $inv_is_owner_approved(old($s), $s, $ptr(^Mgr, P#_this_), Mgr.except);
  ensures $is_admissibility_check() ==> (forall Q#n$1^56.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^56.29#dt1))) ==> $set_in($ptr(^Node, Q#n$1^56.29#dt1), $owns($s, $ptr(^Mgr, P#_this_))) ==> $ptr_eq($read_ptr($s, $dot($ptr(^Node, Q#n$1^56.29#dt1), Node.m), ^Mgr), $ptr(^Mgr, P#_this_)));
  ensures $is_admissibility_check() ==> (forall Q#n$1^57.30#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^57.30#dt1), Node.p), ^Node), $owns($s, $ptr(^Mgr, P#_this_))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^57.30#dt1))) ==> $set_in($ptr(^Node, Q#n$1^57.30#dt1), $owns($s, $ptr(^Mgr, P#_this_))) ==> $ptr_eq($read_ptr($s, $dot($ptr(^Node, Q#n$1^57.30#dt1), Node.p), ^Node), $null) || $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^57.30#dt1), Node.p), ^Node), $owns($s, $ptr(^Mgr, P#_this_))));
  ensures $is_admissibility_check() ==> (forall Q#n$1^58.30#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^58.30#dt1), Node.l), ^Node), $owns($s, $ptr(^Mgr, P#_this_))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^58.30#dt1))) ==> $set_in($ptr(^Node, Q#n$1^58.30#dt1), $owns($s, $ptr(^Mgr, P#_this_))) ==> $ptr_eq($read_ptr($s, $dot($ptr(^Node, Q#n$1^58.30#dt1), Node.l), ^Node), $null) || $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^58.30#dt1), Node.l), ^Node), $owns($s, $ptr(^Mgr, P#_this_))));
  ensures $is_admissibility_check() ==> (forall Q#n$1^59.30#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^59.30#dt1), Node.r), ^Node), $owns($s, $ptr(^Mgr, P#_this_))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^59.30#dt1))) ==> $set_in($ptr(^Node, Q#n$1^59.30#dt1), $owns($s, $ptr(^Mgr, P#_this_))) ==> $ptr_eq($read_ptr($s, $dot($ptr(^Node, Q#n$1^59.30#dt1), Node.r), ^Node), $null) || $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^59.30#dt1), Node.r), ^Node), $owns($s, $ptr(^Mgr, P#_this_))));
  ensures $is_admissibility_check() ==> $closed(old($s), $ptr(^Mgr, P#_this_)) && !$closed($s, $ptr(^Mgr, P#_this_)) ==> false;
  ensures $is_stuttering_check() ==> $ptr_eq($read_ptr($s, $dot($ptr(^Mgr, P#_this_), Mgr.except), ^Node), $read_ptr($s, $dot($ptr(^Mgr, P#_this_), Mgr.except), ^Node)) || $ptr_eq($read_ptr($s, $dot($ptr(^Mgr, P#_this_), Mgr.except), ^Node), $null) || $inv($s, $read_ptr($s, $dot($ptr(^Mgr, P#_this_), Mgr.except), ^Node), ^Node);
  ensures $is_stuttering_check() ==> $inv_is_owner_approved($s, $s, $ptr(^Mgr, P#_this_), Mgr.except);
  ensures $is_stuttering_check() ==> $closed($s, $ptr(^Mgr, P#_this_)) && !$closed($s, $ptr(^Mgr, P#_this_)) ==> false;
  ensures $is_unwrap_check() ==> $ptr_eq($read_ptr(old($s), $dot($ptr(^Mgr, P#_this_), Mgr.except), ^Node), $read_ptr($s, $dot($ptr(^Mgr, P#_this_), Mgr.except), ^Node)) || $ptr_eq($read_ptr(old($s), $dot($ptr(^Mgr, P#_this_), Mgr.except), ^Node), $null) || $inv($s, $read_ptr(old($s), $dot($ptr(^Mgr, P#_this_), Mgr.except), ^Node), ^Node);
  ensures $is_unwrap_check() ==> $inv_is_owner_approved(old($s), $s, $ptr(^Mgr, P#_this_), Mgr.except);
  ensures $is_unwrap_check() ==> (forall Q#n$1^56.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^56.29#dt1))) ==> $set_in($ptr(^Node, Q#n$1^56.29#dt1), $owns($s, $ptr(^Mgr, P#_this_))) ==> $ptr_eq($read_ptr($s, $dot($ptr(^Node, Q#n$1^56.29#dt1), Node.m), ^Mgr), $ptr(^Mgr, P#_this_)));
  ensures $is_unwrap_check() ==> (forall Q#n$1^57.30#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^57.30#dt1), Node.p), ^Node), $owns($s, $ptr(^Mgr, P#_this_))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^57.30#dt1))) ==> $set_in($ptr(^Node, Q#n$1^57.30#dt1), $owns($s, $ptr(^Mgr, P#_this_))) ==> $ptr_eq($read_ptr($s, $dot($ptr(^Node, Q#n$1^57.30#dt1), Node.p), ^Node), $null) || $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^57.30#dt1), Node.p), ^Node), $owns($s, $ptr(^Mgr, P#_this_))));
  ensures $is_unwrap_check() ==> (forall Q#n$1^58.30#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^58.30#dt1), Node.l), ^Node), $owns($s, $ptr(^Mgr, P#_this_))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^58.30#dt1))) ==> $set_in($ptr(^Node, Q#n$1^58.30#dt1), $owns($s, $ptr(^Mgr, P#_this_))) ==> $ptr_eq($read_ptr($s, $dot($ptr(^Node, Q#n$1^58.30#dt1), Node.l), ^Node), $null) || $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^58.30#dt1), Node.l), ^Node), $owns($s, $ptr(^Mgr, P#_this_))));
  ensures $is_unwrap_check() ==> (forall Q#n$1^59.30#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^59.30#dt1), Node.r), ^Node), $owns($s, $ptr(^Mgr, P#_this_))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^59.30#dt1))) ==> $set_in($ptr(^Node, Q#n$1^59.30#dt1), $owns($s, $ptr(^Mgr, P#_this_))) ==> $ptr_eq($read_ptr($s, $dot($ptr(^Node, Q#n$1^59.30#dt1), Node.r), ^Node), $null) || $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^59.30#dt1), Node.r), ^Node), $owns($s, $ptr(^Mgr, P#_this_))));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Mgr#adm(P#_this_: int)
{
  var #wrTime$1^52.53: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^52.53, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^52.53, #loc._this_, $ptr_to_int($ptr(^Mgr, P#_this_)), $spec_ptr_to(^Mgr)) && $local_value_is_ptr($s, #tok$1^52.53, #loc._this_, $ptr(^Mgr, P#_this_), $spec_ptr_to(^Mgr));
    assume #wrTime$1^52.53 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^52.53, #p) } $in_writes_at(#wrTime$1^52.53, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon7:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^Mgr, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^Mgr, P#_this_));
        assume $good_state_ext(#tok$1^52.53, $s);
        // assert true; 
        assert true;
    }
    else
    {
      anon10:
        assume true;
        // if (@_vcc_is_admissibility_check) ...
        if ($is_admissibility_check())
        {
          anon8:
            // assume @_vcc_admissibility_pre(@state, _this_); 
            assume $admissibility_pre($s, $ptr(^Mgr, P#_this_));
        }
        else
        {
          anon9:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^Mgr, P#_this_));
        }

      anon11:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Mgr*)@null))
        call $havoc_others($ptr(^Mgr, P#_this_), ^Mgr);
        assume $good_state_ext(#tok$1^52.53, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^Mgr, P#_this_), ^Mgr);
    }

  #exit:
}



axiom $is_owner_approved(^Mgr, Mgr.except);

const unique ^$#fnptr#1: $ctype;

axiom $is_fnptr_type(^$#fnptr#1);

type $#fnptr#1;

const unique ^$#fnptr#2: $ctype;

axiom $is_fnptr_type(^$#fnptr#2);

type $#fnptr#2;

const unique ^$#fnptr#3: $ctype;

axiom $is_fnptr_type(^$#fnptr#3);

type $#fnptr#3;

const unique ^$#fnptr#4: $ctype;

axiom $is_fnptr_type(^$#fnptr#4);

type $#fnptr#4;

const unique ^$#fnptr#5: $ctype;

axiom $is_fnptr_type(^$#fnptr#5);

type $#fnptr#5;

const unique ^$#fnptr#6: $ctype;

axiom $is_fnptr_type(^$#fnptr#6);

type $#fnptr#6;

const unique ^$#fnptr#7: $ctype;

axiom $is_fnptr_type(^$#fnptr#7);

type $#fnptr#7;

const unique ^$#fnptr#8: $ctype;

axiom $is_fnptr_type(^$#fnptr#8);

type $#fnptr#8;

procedure update(P#n: int, P#v: int, SP#m: int);
  requires $set_in($ptr(^Node, P#n), $owns($s, $ptr(^Mgr, SP#m)));
  requires $wrapped($s, $ptr(^Mgr, SP#m), ^Mgr);
  requires $ptr_eq($read_ptr($s, $dot($ptr(^Mgr, SP#m), Mgr.except), ^Node), $null);
  modifies $s, $cev_pc;
  ensures $wrapped($s, $ptr(^Mgr, SP#m), ^Mgr) && $ptr_eq($read_ptr($s, $dot($ptr(^Mgr, SP#m), Mgr.except), ^Node), $null);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Mgr, SP#m) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Mgr, SP#m) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Mgr, SP#m) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation update(P#n: int, P#v: int, SP#m: int)
{
  var ite#2: int where $in_range_i4(ite#2);
  var ite#1: int where $in_range_i4(ite#1);
  var beforeAtomicState#2: $state;
  var atomicObj#6: $ptr;
  var atomicObj#7: $ptr;
  var L#a: int where $in_range_i4(L#a);
  var L#b: int where $in_range_i4(L#b);
  var #wrTime$1^81.28: int;
  var loopState#1: $state;
  var beforeAtomicState#0: $state;
  var atomicObj#4: $ptr;
  var atomicObj#5: $ptr;
  var local.n: int where $in_range_phys_ptr(local.n);
  var #wrTime$1^64.1: int;
  var #stackframe: int;

  anon16:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^64.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^64.1, #loc.n, $ptr_to_int($ptr(^Node, P#n)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^64.1, #loc.n, $ptr(^Node, P#n), $ptr_to(^Node));
    assume $local_value_is($s, #tok$1^64.1, #loc.v, P#v, ^^i4);
    assume $local_value_is($s, #tok$1^64.1, #loc.m, $ptr_to_int($ptr(^Mgr, SP#m)), $spec_ptr_to(^Mgr)) && $local_value_is_ptr($s, #tok$1^64.1, #loc.m, $ptr(^Mgr, SP#m), $spec_ptr_to(^Mgr));
    assume #wrTime$1^64.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^64.1, #p) } $in_writes_at(#wrTime$1^64.1, #p) == (#p == $ptr(^Mgr, SP#m)));
    assume $thread_owned($s, $ptr(^Mgr, SP#m));
    // assume @in_range_phys_ptr((mathint)n); 
    assume $in_range_phys_ptr($ref($ptr(^Node, P#n)));
    // assume @in_range_i4(v); 
    assume $in_range_i4(P#v);
    // assume @in_range_spec_ptr((mathint)m); 
    assume $in_range_spec_ptr($ref($ptr(^Mgr, SP#m)));
    // struct Node* local.n; 
    assume $local_value_is($s, #tok$2^0.0, #loc.local.n, $ptr_to_int($ptr(^Node, local.n)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$2^0.0, #loc.local.n, $ptr(^Node, local.n), $ptr_to(^Node));
    // local.n := n; 
    local.n := $ref($ptr(^Node, P#n));
    assume $local_value_is($s, #tok$2^0.0, #loc.local.n, $ptr_to_int($ptr(^Node, local.n)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$2^0.0, #loc.local.n, $ptr(^Node, local.n), $ptr_to(^Node));
    // assert @_vcc_in_domain(@state, m, m); 
    assert $in_domain_lab($s, $ptr(^Mgr, SP#m), $ptr(^Mgr, SP#m), l#public);
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^69.19, $s);
    atomicObj#5 := $ptr(^Mgr, SP#m);
    atomicObj#4 := $ptr(^Node, local.n);
    assert $closed($s, atomicObj#4);
    assume $inv($s, atomicObj#4, ^Node);
    assert $closed($s, atomicObj#5);
    assume $inv($s, atomicObj#5, ^Mgr);
    beforeAtomicState#0 := $s;
    // assert @_vcc_typed2(@state, (local.n->val)); 
    assert $typed2($s, $dot($ptr(^Node, local.n), Node.val), ^^i4);
    // assert @prim_writes_check((local.n->val)); 
    assert $set_in($dot($ptr(^Node, local.n), Node.val), $volatile_span($s, atomicObj#4)) || $set_in($dot($ptr(^Node, local.n), Node.val), $volatile_span($s, atomicObj#5)) || $writable($s, #wrTime$1^64.1, $dot($ptr(^Node, local.n), Node.val));
    // *(local.n->val) := v; 
    call $write_int($dot($ptr(^Node, local.n), Node.val), P#v);
    assume $good_state_ext(#tok$1^70.5, $s);
    // assert @_vcc_typed2(@state, (m->except)); 
    assert $typed2($s, $dot($ptr(^Mgr, SP#m), Mgr.except), $ptr_to(^Node));
    // assert @prim_writes_check((m->except)); 
    assert $set_in($dot($ptr(^Mgr, SP#m), Mgr.except), $volatile_span($s, atomicObj#4)) || $set_in($dot($ptr(^Mgr, SP#m), Mgr.except), $volatile_span($s, atomicObj#5)) || $writable($s, #wrTime$1^64.1, $dot($ptr(^Mgr, SP#m), Mgr.except));
    // *(m->except) := local.n; 
    call $write_int($dot($ptr(^Mgr, SP#m), Mgr.except), $ref($ptr(^Node, local.n)));
    assume $good_state_ext(#tok$1^72.7, $s);
    // assert @writes_check(m); 
    assert $top_writable($s, #wrTime$1^64.1, $ptr(^Mgr, SP#m));
    // stmt _vcc_bump_volatile_version(m); 
    call $bump_volatile_version($ptr(^Mgr, SP#m));
    assume $good_state_ext(#tok$1^73.23, $s);
    assert $set_eq($owns($s, atomicObj#4), $set_empty());
    assert $closed($s, $read_ptr($s, $dot(atomicObj#4, Node.m), ^Mgr));
    assert $ptr_neq($read_ptr($s, $dot(atomicObj#4, Node.l), ^Node), $null) ==> $ptr_neq($read_ptr($s, $dot(atomicObj#4, Node.l), ^Node), atomicObj#4);
    assert $ptr_neq($read_ptr($s, $dot(atomicObj#4, Node.l), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot(atomicObj#4, Node.l), ^Node), Node.p), ^Node), atomicObj#4);
    assert $ptr_neq($read_ptr($s, $dot(atomicObj#4, Node.l), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot(atomicObj#4, Node.l), ^Node), Node.m), ^Mgr), $read_ptr($s, $dot(atomicObj#4, Node.m), ^Mgr));
    assert $ptr_neq($read_ptr($s, $dot(atomicObj#4, Node.l), ^Node), $null) ==> $closed($s, $read_ptr($s, $dot(atomicObj#4, Node.l), ^Node));
    assert $ptr_neq($read_ptr($s, $dot(atomicObj#4, Node.r), ^Node), $null) ==> $ptr_neq($read_ptr($s, $dot(atomicObj#4, Node.r), ^Node), atomicObj#4);
    assert $ptr_neq($read_ptr($s, $dot(atomicObj#4, Node.r), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot(atomicObj#4, Node.r), ^Node), Node.p), ^Node), atomicObj#4);
    assert $ptr_neq($read_ptr($s, $dot(atomicObj#4, Node.r), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot(atomicObj#4, Node.r), ^Node), Node.m), ^Mgr), $read_ptr($s, $dot(atomicObj#4, Node.m), ^Mgr));
    assert $ptr_neq($read_ptr($s, $dot(atomicObj#4, Node.r), ^Node), $null) ==> $closed($s, $read_ptr($s, $dot(atomicObj#4, Node.r), ^Node));
    assert $ptr_eq(atomicObj#4, $read_ptr($s, $dot($read_ptr($s, $dot(atomicObj#4, Node.m), ^Mgr), Mgr.except), ^Node)) || $mem($s, $dot(atomicObj#4, Node.sum)) == $unchk_add(^^i4, $unchk_add(^^i4, $mem($s, $dot(atomicObj#4, Node.val)), (if $ptr_eq($read_ptr($s, $dot(atomicObj#4, Node.l), ^Node), $null) then 0 else $mem($s, $dot($read_ptr($s, $dot(atomicObj#4, Node.l), ^Node), Node.sum)))), (if $ptr_eq($read_ptr($s, $dot(atomicObj#4, Node.r), ^Node), $null) then 0 else $mem($s, $dot($read_ptr($s, $dot(atomicObj#4, Node.r), ^Node), Node.sum))));
    assert $mem(beforeAtomicState#0, $dot(atomicObj#4, Node.sum)) == $mem($s, $dot(atomicObj#4, Node.sum)) || $inv($s, $read_ptr($s, $dot(atomicObj#4, Node.p), ^Node), ^Node) || $ptr_eq($read_ptr($s, $dot(atomicObj#4, Node.p), ^Node), $null);
    assert $closed(beforeAtomicState#0, atomicObj#4) && !$closed($s, atomicObj#4) ==> false;
    assert $ptr_eq($read_ptr(beforeAtomicState#0, $dot(atomicObj#5, Mgr.except), ^Node), $read_ptr($s, $dot(atomicObj#5, Mgr.except), ^Node)) || $ptr_eq($read_ptr(beforeAtomicState#0, $dot(atomicObj#5, Mgr.except), ^Node), $null) || $inv($s, $read_ptr(beforeAtomicState#0, $dot(atomicObj#5, Mgr.except), ^Node), ^Node);
    assert $inv_is_owner_approved(beforeAtomicState#0, $s, atomicObj#5, Mgr.except);
    assert (forall Q#n$1^56.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^56.29#dt1))) ==> $set_in($ptr(^Node, Q#n$1^56.29#dt1), $owns($s, atomicObj#5)) ==> $ptr_eq($read_ptr($s, $dot($ptr(^Node, Q#n$1^56.29#dt1), Node.m), ^Mgr), atomicObj#5));
    assert (forall Q#n$1^57.30#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^57.30#dt1), Node.p), ^Node), $owns($s, atomicObj#5)) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^57.30#dt1))) ==> $set_in($ptr(^Node, Q#n$1^57.30#dt1), $owns($s, atomicObj#5)) ==> $ptr_eq($read_ptr($s, $dot($ptr(^Node, Q#n$1^57.30#dt1), Node.p), ^Node), $null) || $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^57.30#dt1), Node.p), ^Node), $owns($s, atomicObj#5)));
    assert (forall Q#n$1^58.30#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^58.30#dt1), Node.l), ^Node), $owns($s, atomicObj#5)) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^58.30#dt1))) ==> $set_in($ptr(^Node, Q#n$1^58.30#dt1), $owns($s, atomicObj#5)) ==> $ptr_eq($read_ptr($s, $dot($ptr(^Node, Q#n$1^58.30#dt1), Node.l), ^Node), $null) || $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^58.30#dt1), Node.l), ^Node), $owns($s, atomicObj#5)));
    assert (forall Q#n$1^59.30#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^59.30#dt1), Node.r), ^Node), $owns($s, atomicObj#5)) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^59.30#dt1))) ==> $set_in($ptr(^Node, Q#n$1^59.30#dt1), $owns($s, atomicObj#5)) ==> $ptr_eq($read_ptr($s, $dot($ptr(^Node, Q#n$1^59.30#dt1), Node.r), ^Node), $null) || $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^59.30#dt1), Node.r), ^Node), $owns($s, atomicObj#5)));
    assert $closed(beforeAtomicState#0, atomicObj#5) && !$closed($s, atomicObj#5) ==> false;
    assume $full_stop_ext(#tok$1^69.19, $s);
    call $bump_timestamp();
    assume $full_stop_ext(#tok$1^81.28, $s);
    loopState#1 := $s;
    assume #wrTime$1^81.28 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^81.28, #p) } $in_writes_at(#wrTime$1^81.28, #p) == (#p == $ptr(^Mgr, SP#m)));
    assert (forall #loopWrites^$1^81.28: $ptr :: { $dont_instantiate(#loopWrites^$1^81.28) } $top_writable($s, #wrTime$1^81.28, #loopWrites^$1^81.28) ==> $top_writable($s, #wrTime$1^64.1, #loopWrites^$1^81.28));
    while (true)
      invariant $ptr_eq($read_ptr($s, $dot($ptr(^Mgr, SP#m), Mgr.except), ^Node), $ptr(^Node, local.n));
      invariant $wrapped($s, $ptr(^Mgr, SP#m), ^Mgr);
      invariant $ptr_eq($ptr(^Node, local.n), $null) || $set_in($ptr(^Node, local.n), $owns($s, $ptr(^Mgr, SP#m)));
    {
      anon15:
        assume (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(loopState#1, #p) || #p == $ptr(^Mgr, SP#m) || $mem_eq(loopState#1, $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(loopState#1, #p) || #p == $ptr(^Mgr, SP#m) || $st_eq(loopState#1, $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(loopState#1, #p) || #p == $ptr(^Mgr, SP#m) || $ts_eq(loopState#1, $s, #p)) && $timestamp_post(loopState#1, $s);
        assume $timestamp_post(loopState#1, $s);
        assume $full_stop_ext(#tok$1^77.3, $s);
        assume $local_value_is($s, #tok$1^77.3, #loc.local.n, $ptr_to_int($ptr(^Node, local.n)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^77.3, #loc.local.n, $ptr(^Node, local.n), $ptr_to(^Node));
        assume $local_value_is($s, #tok$1^77.3, #loc.m, $ptr_to_int($ptr(^Mgr, SP#m)), $spec_ptr_to(^Mgr)) && $local_value_is_ptr($s, #tok$1^77.3, #loc.m, $ptr(^Mgr, SP#m), $spec_ptr_to(^Mgr));
        assume $local_value_is($s, #tok$1^77.3, #loc.v, P#v, ^^i4);
        assume $local_value_is($s, #tok$1^77.3, #loc.n, $ptr_to_int($ptr(^Node, P#n)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^77.3, #loc.n, $ptr(^Node, P#n), $ptr_to(^Node));
        assume true;
        // if ((_Bool)local.n) ...
        if ($ptr_neq($ptr(^Node, local.n), $null))
        {
          anon13:
            // int32_t b; 
            assume $local_value_is($s, #tok$1^83.5, #loc.b, L#b, ^^i4);
            // int32_t a; 
            assume $local_value_is($s, #tok$1^83.5, #loc.a, L#a, ^^i4);
            // var int32_t a
            // var int32_t b
            // assert @_vcc_in_domain(@state, m, m); 
            assert $in_domain_lab($s, $ptr(^Mgr, SP#m), $ptr(^Mgr, SP#m), l#public);
            // assume @_vcc_in_domain(@state, m, m); 
            assume $in_domain_lab($s, $ptr(^Mgr, SP#m), $ptr(^Mgr, SP#m), l#public);
            // assert @_vcc_in_domain(@state, local.n, m); 
            assert $in_domain_lab($s, $ptr(^Node, local.n), $ptr(^Mgr, SP#m), l#public);
            // assume @_vcc_in_domain(@state, local.n, m); 
            assume $in_domain_lab($s, $ptr(^Node, local.n), $ptr(^Mgr, SP#m), l#public);
            assume true;
            call $atomic_havoc();
            assume $full_stop_ext(#tok$1^87.21, $s);
            atomicObj#7 := $ptr(^Mgr, SP#m);
            atomicObj#6 := $ptr(^Node, local.n);
            assert $closed($s, atomicObj#6);
            assume $inv($s, atomicObj#6, ^Node);
            assert $closed($s, atomicObj#7);
            assume $inv($s, atomicObj#7, ^Mgr);
            beforeAtomicState#2 := $s;
            // assert ||(@_vcc_ptr_eq(*((local.n->p)), @null), @_vcc_in_domain(@state, *((local.n->p)), m)); 
            assert $ptr_eq($read_ptr($s, $dot($ptr(^Node, local.n), Node.p), ^Node), $null) || $in_domain_lab($s, $read_ptr($s, $dot($ptr(^Node, local.n), Node.p), ^Node), $ptr(^Mgr, SP#m), l#public);
            // assume ||(@_vcc_ptr_eq(*((local.n->p)), @null), @_vcc_in_domain(@state, *((local.n->p)), m)); 
            assume $ptr_eq($read_ptr($s, $dot($ptr(^Node, local.n), Node.p), ^Node), $null) || $in_domain_lab($s, $read_ptr($s, $dot($ptr(^Node, local.n), Node.p), ^Node), $ptr(^Mgr, SP#m), l#public);
            // assume &&(==(a, *((*((local.n->l))->sum))), ==(b, *((*((local.n->r))->sum)))); 
            assume L#a == $mem($s, $dot($read_ptr($s, $dot($ptr(^Node, local.n), Node.l), ^Node), Node.sum)) && L#b == $mem($s, $dot($read_ptr($s, $dot($ptr(^Node, local.n), Node.r), ^Node), Node.sum));
            // int32_t ite#1; 
            assume $local_value_is($s, #tok$1^90.54, #loc.ite#1, ite#1, ^^i4);
            // assert @reads_check_normal((local.n->l)); 
            assert $typed2($s, $dot($ptr(^Node, local.n), Node.l), $ptr_to(^Node));
            assert $thread_local2($s, $dot($ptr(^Node, local.n), Node.l), $ptr_to(^Node)) || $ptr(^Node, local.n) == atomicObj#6 || $ptr(^Node, local.n) == atomicObj#7;
            // ite#1 := @ite(@_vcc_ptr_eq(*((local.n->l)), @null), 0, a); 
            ite#1 := (if $ptr_eq($read_ptr($s, $dot($ptr(^Node, local.n), Node.l), ^Node), $null) then 0 else L#a);
            assume $local_value_is($s, #tok$1^90.54, #loc.ite#1, ite#1, ^^i4);
            // int32_t ite#2; 
            assume $local_value_is($s, #tok$1^90.86, #loc.ite#2, ite#2, ^^i4);
            // assert @reads_check_normal((local.n->r)); 
            assert $typed2($s, $dot($ptr(^Node, local.n), Node.r), $ptr_to(^Node));
            assert $thread_local2($s, $dot($ptr(^Node, local.n), Node.r), $ptr_to(^Node)) || $ptr(^Node, local.n) == atomicObj#6 || $ptr(^Node, local.n) == atomicObj#7;
            // ite#2 := @ite(@_vcc_ptr_eq(*((local.n->r)), @null), 0, b); 
            ite#2 := (if $ptr_eq($read_ptr($s, $dot($ptr(^Node, local.n), Node.r), ^Node), $null) then 0 else L#b);
            assume $local_value_is($s, #tok$1^90.86, #loc.ite#2, ite#2, ^^i4);
            // assert @_vcc_typed2(@state, (local.n->sum)); 
            assert $typed2($s, $dot($ptr(^Node, local.n), Node.sum), ^^i4);
            // assert @prim_writes_check((local.n->sum)); 
            assert $set_in($dot($ptr(^Node, local.n), Node.sum), $volatile_span($s, atomicObj#6)) || $set_in($dot($ptr(^Node, local.n), Node.sum), $volatile_span($s, atomicObj#7)) || $writable($s, #wrTime$1^81.28, $dot($ptr(^Node, local.n), Node.sum));
            // assert @reads_check_normal((local.n->val)); 
            assert $typed2($s, $dot($ptr(^Node, local.n), Node.val), ^^i4);
            assert $mutable($s, $ptr(^Node, local.n)) || $ptr(^Node, local.n) == atomicObj#6 || $ptr(^Node, local.n) == atomicObj#7;
            // *(local.n->sum) := unchecked+(unchecked+(*((local.n->val)), ite#1), ite#2); 
            call $write_int($dot($ptr(^Node, local.n), Node.sum), $unchk_add(^^i4, $unchk_add(^^i4, $mem($s, $dot($ptr(^Node, local.n), Node.val)), ite#1), ite#2));
            assume $good_state_ext(#tok$1^90.7, $s);
            // assert @_vcc_typed2(@state, (m->except)); 
            assert $typed2($s, $dot($ptr(^Mgr, SP#m), Mgr.except), $ptr_to(^Node));
            // assert @prim_writes_check((m->except)); 
            assert $set_in($dot($ptr(^Mgr, SP#m), Mgr.except), $volatile_span($s, atomicObj#6)) || $set_in($dot($ptr(^Mgr, SP#m), Mgr.except), $volatile_span($s, atomicObj#7)) || $writable($s, #wrTime$1^81.28, $dot($ptr(^Mgr, SP#m), Mgr.except));
            // assert @reads_check_normal((local.n->p)); 
            assert $typed2($s, $dot($ptr(^Node, local.n), Node.p), $ptr_to(^Node));
            assert $thread_local2($s, $dot($ptr(^Node, local.n), Node.p), $ptr_to(^Node)) || $ptr(^Node, local.n) == atomicObj#6 || $ptr(^Node, local.n) == atomicObj#7;
            // *(m->except) := *((local.n->p)); 
            call $write_int($dot($ptr(^Mgr, SP#m), Mgr.except), $ref($read_ptr($s, $dot($ptr(^Node, local.n), Node.p), ^Node)));
            assume $good_state_ext(#tok$1^92.8, $s);
            // assert @writes_check(m); 
            assert $top_writable($s, #wrTime$1^81.28, $ptr(^Mgr, SP#m));
            // stmt _vcc_bump_volatile_version(m); 
            call $bump_volatile_version($ptr(^Mgr, SP#m));
            assume $good_state_ext(#tok$1^93.24, $s);
            assert $set_eq($owns($s, atomicObj#6), $set_empty());
            assert $closed($s, $read_ptr($s, $dot(atomicObj#6, Node.m), ^Mgr));
            assert $ptr_neq($read_ptr($s, $dot(atomicObj#6, Node.l), ^Node), $null) ==> $ptr_neq($read_ptr($s, $dot(atomicObj#6, Node.l), ^Node), atomicObj#6);
            assert $ptr_neq($read_ptr($s, $dot(atomicObj#6, Node.l), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot(atomicObj#6, Node.l), ^Node), Node.p), ^Node), atomicObj#6);
            assert $ptr_neq($read_ptr($s, $dot(atomicObj#6, Node.l), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot(atomicObj#6, Node.l), ^Node), Node.m), ^Mgr), $read_ptr($s, $dot(atomicObj#6, Node.m), ^Mgr));
            assert $ptr_neq($read_ptr($s, $dot(atomicObj#6, Node.l), ^Node), $null) ==> $closed($s, $read_ptr($s, $dot(atomicObj#6, Node.l), ^Node));
            assert $ptr_neq($read_ptr($s, $dot(atomicObj#6, Node.r), ^Node), $null) ==> $ptr_neq($read_ptr($s, $dot(atomicObj#6, Node.r), ^Node), atomicObj#6);
            assert $ptr_neq($read_ptr($s, $dot(atomicObj#6, Node.r), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot(atomicObj#6, Node.r), ^Node), Node.p), ^Node), atomicObj#6);
            assert $ptr_neq($read_ptr($s, $dot(atomicObj#6, Node.r), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot(atomicObj#6, Node.r), ^Node), Node.m), ^Mgr), $read_ptr($s, $dot(atomicObj#6, Node.m), ^Mgr));
            assert $ptr_neq($read_ptr($s, $dot(atomicObj#6, Node.r), ^Node), $null) ==> $closed($s, $read_ptr($s, $dot(atomicObj#6, Node.r), ^Node));
            assert $ptr_eq(atomicObj#6, $read_ptr($s, $dot($read_ptr($s, $dot(atomicObj#6, Node.m), ^Mgr), Mgr.except), ^Node)) || $mem($s, $dot(atomicObj#6, Node.sum)) == $unchk_add(^^i4, $unchk_add(^^i4, $mem($s, $dot(atomicObj#6, Node.val)), (if $ptr_eq($read_ptr($s, $dot(atomicObj#6, Node.l), ^Node), $null) then 0 else $mem($s, $dot($read_ptr($s, $dot(atomicObj#6, Node.l), ^Node), Node.sum)))), (if $ptr_eq($read_ptr($s, $dot(atomicObj#6, Node.r), ^Node), $null) then 0 else $mem($s, $dot($read_ptr($s, $dot(atomicObj#6, Node.r), ^Node), Node.sum))));
            assert $mem(beforeAtomicState#2, $dot(atomicObj#6, Node.sum)) == $mem($s, $dot(atomicObj#6, Node.sum)) || $inv($s, $read_ptr($s, $dot(atomicObj#6, Node.p), ^Node), ^Node) || $ptr_eq($read_ptr($s, $dot(atomicObj#6, Node.p), ^Node), $null);
            assert $closed(beforeAtomicState#2, atomicObj#6) && !$closed($s, atomicObj#6) ==> false;
            assert $ptr_eq($read_ptr(beforeAtomicState#2, $dot(atomicObj#7, Mgr.except), ^Node), $read_ptr($s, $dot(atomicObj#7, Mgr.except), ^Node)) || $ptr_eq($read_ptr(beforeAtomicState#2, $dot(atomicObj#7, Mgr.except), ^Node), $null) || $inv($s, $read_ptr(beforeAtomicState#2, $dot(atomicObj#7, Mgr.except), ^Node), ^Node);
            assert $inv_is_owner_approved(beforeAtomicState#2, $s, atomicObj#7, Mgr.except);
            assert (forall Q#n$1^56.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^56.29#dt1))) ==> $set_in($ptr(^Node, Q#n$1^56.29#dt1), $owns($s, atomicObj#7)) ==> $ptr_eq($read_ptr($s, $dot($ptr(^Node, Q#n$1^56.29#dt1), Node.m), ^Mgr), atomicObj#7));
            assert (forall Q#n$1^57.30#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^57.30#dt1), Node.p), ^Node), $owns($s, atomicObj#7)) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^57.30#dt1))) ==> $set_in($ptr(^Node, Q#n$1^57.30#dt1), $owns($s, atomicObj#7)) ==> $ptr_eq($read_ptr($s, $dot($ptr(^Node, Q#n$1^57.30#dt1), Node.p), ^Node), $null) || $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^57.30#dt1), Node.p), ^Node), $owns($s, atomicObj#7)));
            assert (forall Q#n$1^58.30#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^58.30#dt1), Node.l), ^Node), $owns($s, atomicObj#7)) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^58.30#dt1))) ==> $set_in($ptr(^Node, Q#n$1^58.30#dt1), $owns($s, atomicObj#7)) ==> $ptr_eq($read_ptr($s, $dot($ptr(^Node, Q#n$1^58.30#dt1), Node.l), ^Node), $null) || $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^58.30#dt1), Node.l), ^Node), $owns($s, atomicObj#7)));
            assert (forall Q#n$1^59.30#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^59.30#dt1), Node.r), ^Node), $owns($s, atomicObj#7)) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^59.30#dt1))) ==> $set_in($ptr(^Node, Q#n$1^59.30#dt1), $owns($s, atomicObj#7)) ==> $ptr_eq($read_ptr($s, $dot($ptr(^Node, Q#n$1^59.30#dt1), Node.r), ^Node), $null) || $set_in($read_ptr($s, $dot($ptr(^Node, Q#n$1^59.30#dt1), Node.r), ^Node), $owns($s, atomicObj#7)));
            assert $closed(beforeAtomicState#2, atomicObj#7) && !$closed($s, atomicObj#7) ==> false;
            assume $full_stop_ext(#tok$1^87.21, $s);
            // assert @reads_check_normal((local.n->p)); 
            assert $typed2($s, $dot($ptr(^Node, local.n), Node.p), $ptr_to(^Node));
            assert $thread_local2($s, $dot($ptr(^Node, local.n), Node.p), $ptr_to(^Node));
            // local.n := *((local.n->p)); 
            local.n := $ref($read_ptr($s, $dot($ptr(^Node, local.n), Node.p), ^Node));
            assume $local_value_is($s, #tok$1^96.5, #loc.local.n, $ptr_to_int($ptr(^Node, local.n)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^96.5, #loc.local.n, $ptr(^Node, local.n), $ptr_to(^Node));
        }
        else
        {
          anon14:
            // goto #break_3; 
            goto #break_3;
        }

      #continue_3:
        assume true;
    }

  anon17:
    assume $full_stop_ext(#tok$1^77.3, $s);

  #break_3:
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



const unique l#public: $label;

const unique #tok$1^96.5: $token;

const unique #tok$1^87.21: $token;

const unique #tok$1^93.24: $token;

const unique #tok$1^92.8: $token;

const unique #tok$1^90.7: $token;

const unique #loc.ite#2: $token;

const unique #tok$1^90.86: $token;

const unique #loc.ite#1: $token;

const unique #tok$1^90.54: $token;

const unique #loc.a: $token;

const unique #loc.b: $token;

const unique #tok$1^83.5: $token;

const unique #tok$1^77.3: $token;

const unique #tok$1^81.28: $token;

const unique #tok$1^69.19: $token;

const unique #tok$1^73.23: $token;

const unique #tok$1^72.7: $token;

const unique #tok$1^70.5: $token;

const unique #loc.local.n: $token;

const unique #tok$2^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(2, #file^?3Cno?20file?3E);

const unique #loc.m: $token;

const unique #loc.v: $token;

const unique #loc.n: $token;

const unique #tok$1^64.1: $token;

const unique #tok$1^52.53: $token;

const unique #loc._this_: $token;

const unique #tok$1^38.1: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvacid?2D0?5CComposite.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvacid?2D0?5CComposite.c);

const unique #distTp2: $ctype;

axiom #distTp2 == $spec_ptr_to(^Mgr);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^Node);
