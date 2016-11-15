axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^_Protector: $ctype;

axiom $is_composite(^_Protector);

axiom $ptr_level(^_Protector) == 0;

axiom $sizeof(^_Protector) == 4;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_Protector) } $inv2(#s1, #s2, #p, ^_Protector) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty())));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^_Protector, #r), l#public) } $inv_lab(#s2, $ptr(^_Protector, #r), l#public) == ($typed(#s2, $ptr(^_Protector, #r)) && $set_eq($owns(#s2, $ptr(^_Protector, #r)), $set_empty())));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^_Protector, #r)) } $in_full_extent_of(#q, $ptr(^_Protector, #r)) == (#q == $ptr(^_Protector, #r) || #q == $dot($ptr(^_Protector, #r), _Protector.$owns) || #q == $dot($ptr(^_Protector, #r), _Protector.dummy)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_Protector, #r)) } $in_extent_of(#s, #q, $ptr(^_Protector, #r)) == $in_struct_extent_of(#q, $ptr(^_Protector, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_Protector, #r)) } $typed(#s, $ptr(^_Protector, #r)) ==> $in_extent_of(#s, #q, $ptr(^_Protector, #r)) == (#q == $ptr(^_Protector, #r) || $emb(#s, #q) == $ptr(^_Protector, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^_Protector, #r)) } $in_span_of(#q, $ptr(^_Protector, #r)) == (#q == $ptr(^_Protector, #r) || #q == $dot($ptr(^_Protector, #r), _Protector.$owns) || #q == $dot($ptr(^_Protector, #r), _Protector.dummy)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^_Protector) } $state_spans_the_same(#s1, #s2, #p, ^_Protector) == ($mem_eq(#s1, #s2, $dot(#p, _Protector.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _Protector.dummy))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_Protector) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_Protector) == ($mem_eq(#s1, #s2, $dot(#p, _Protector.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _Protector.dummy))));

axiom $is_claimable(^_Protector) == true;

axiom $has_volatile_owns_set(^_Protector) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^_Protector, #r)) } $extent_mutable(#s1, $ptr(^_Protector, #r)) == $mutable(#s1, $ptr(^_Protector, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^_Protector, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^_Protector, #r)) == $is_fresh(#s1, #s2, $ptr(^_Protector, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^_Protector, #r)) } $extent_zero(#s1, $ptr(^_Protector, #r)) == ($mem(#s1, $dot($ptr(^_Protector, #r), _Protector.dummy)) == 0));

const unique _Protector.$owns: $field;

axiom $static_field_properties(_Protector.$owns, ^_Protector);

axiom $is_primitive_non_volatile_field(_Protector.$owns);

axiom (forall #p: $ptr :: { $dot(#p, _Protector.$owns) } $is(#p, ^_Protector) ==> $dot(#p, _Protector.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, _Protector.$owns)) && $extent_hint($dot(#p, _Protector.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _Protector.$owns)) } { $st(#s, $dot(#p, _Protector.$owns)) } $typed2(#s, #p, ^_Protector) ==> $field_properties(#s, #p, _Protector.$owns, ^$#ptrset, false));

axiom $owns_set_field(^_Protector) == _Protector.$owns;

const unique _Protector.dummy: $field;

axiom $static_field_properties(_Protector.dummy, ^_Protector);

axiom $is_primitive_non_volatile_field(_Protector.dummy);

axiom $field_offset(_Protector.dummy) == 0;

axiom (forall #p: $ptr :: { $dot(#p, _Protector.dummy) } $is(#p, ^_Protector) ==> $dot(#p, _Protector.dummy) == $ptr(^^i4, $ref(#p) + 0) && $extent_hint($dot(#p, _Protector.dummy), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _Protector.dummy)) } { $st(#s, $dot(#p, _Protector.dummy)) } $typed2(#s, #p, ^_Protector) ==> $field_properties(#s, #p, _Protector.dummy, ^^i4, false));

const unique ^_Rundown: $ctype;

axiom $is_composite(^_Rundown);

axiom $ptr_level(^_Rundown) == 0;

axiom $sizeof(^_Rundown) == 4;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_Rundown) } $inv2(#s1, #s2, #p, ^_Rundown) == ($typed(#s2, #p) && ($closed(#s1, $dot(#p, _Rundown.enabled_protector)) ==> $read_bool(#s1, $dot(#p, _Rundown.enabled)) == $read_bool(#s2, $dot(#p, _Rundown.enabled))) && ($closed(#s1, $dot(#p, _Rundown.enabled_protector)) ==> $read_bool(#s1, $dot(#p, _Rundown.alive)) == $read_bool(#s2, $dot(#p, _Rundown.alive))) && (!$read_bool(#s2, $dot(#p, _Rundown.alive)) ==> !$read_bool(#s2, $dot(#p, _Rundown.enabled))) && (!$read_bool(#s2, $dot(#p, _Rundown.alive)) ==> $mem(#s2, $dot(#p, _Rundown.count)) == 0) && ($mem(#s1, $dot(#p, _Rundown.count)) > 0 && $read_bool(#s1, $dot(#p, _Rundown.alive)) ==> $read_bool(#s2, $dot(#p, _Rundown.alive))) && ($read_bool(#s2, $dot(#p, _Rundown.alive)) ==> $keeps(#s2, #p, $int_to_ptr($mem(#s2, $dot(#p, _Rundown.protected_obj))))) && ($read_bool(#s2, $dot(#p, _Rundown.alive)) ==> $keeps(#s2, #p, $read_ptr(#s2, $dot(#p, _Rundown.self_claim), ^^claim))) && ($read_bool(#s2, $dot(#p, _Rundown.alive)) ==> $claims_obj($read_ptr(#s2, $dot(#p, _Rundown.self_claim), ^^claim), #p)) && ($read_bool(#s2, $dot(#p, _Rundown.alive)) ==> $ref_cnt(#s2, $read_ptr(#s2, $dot(#p, _Rundown.self_claim), ^^claim)) == $mem(#s2, $dot(#p, _Rundown.count))) && ($read_bool(#s1, $dot(#p, _Rundown.alive)) ==> $ptr_eq($read_ptr(#s1, $dot(#p, _Rundown.self_claim), ^^claim), $read_ptr(#s2, $dot(#p, _Rundown.self_claim), ^^claim))) && (!$read_bool(#s2, $dot(#p, _Rundown.enabled)) ==> $mem(#s2, $dot(#p, _Rundown.count)) <= $mem(#s1, $dot(#p, _Rundown.count)))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^_Rundown, #r), l#public) } $inv_lab(#s2, $ptr(^_Rundown, #r), l#public) == ($typed(#s2, $ptr(^_Rundown, #r)) && (!$read_bool(#s2, $dot($ptr(^_Rundown, #r), _Rundown.alive)) ==> !$read_bool(#s2, $dot($ptr(^_Rundown, #r), _Rundown.enabled))) && (!$read_bool(#s2, $dot($ptr(^_Rundown, #r), _Rundown.alive)) ==> $mem(#s2, $dot($ptr(^_Rundown, #r), _Rundown.count)) == 0) && ($mem(#s2, $dot($ptr(^_Rundown, #r), _Rundown.count)) > 0 && $read_bool(#s2, $dot($ptr(^_Rundown, #r), _Rundown.alive)) ==> $read_bool(#s2, $dot($ptr(^_Rundown, #r), _Rundown.alive))) && ($read_bool(#s2, $dot($ptr(^_Rundown, #r), _Rundown.alive)) ==> $keeps(#s2, $ptr(^_Rundown, #r), $int_to_ptr($mem(#s2, $dot($ptr(^_Rundown, #r), _Rundown.protected_obj))))) && ($read_bool(#s2, $dot($ptr(^_Rundown, #r), _Rundown.alive)) ==> $keeps(#s2, $ptr(^_Rundown, #r), $read_ptr(#s2, $dot($ptr(^_Rundown, #r), _Rundown.self_claim), ^^claim))) && ($read_bool(#s2, $dot($ptr(^_Rundown, #r), _Rundown.alive)) ==> $claims_obj($read_ptr(#s2, $dot($ptr(^_Rundown, #r), _Rundown.self_claim), ^^claim), $ptr(^_Rundown, #r))) && ($read_bool(#s2, $dot($ptr(^_Rundown, #r), _Rundown.alive)) ==> $ref_cnt(#s2, $read_ptr(#s2, $dot($ptr(^_Rundown, #r), _Rundown.self_claim), ^^claim)) == $mem(#s2, $dot($ptr(^_Rundown, #r), _Rundown.count))) && ($read_bool(#s2, $dot($ptr(^_Rundown, #r), _Rundown.alive)) ==> $ptr_eq($read_ptr(#s2, $dot($ptr(^_Rundown, #r), _Rundown.self_claim), ^^claim), $read_ptr(#s2, $dot($ptr(^_Rundown, #r), _Rundown.self_claim), ^^claim))) && (!$read_bool(#s2, $dot($ptr(^_Rundown, #r), _Rundown.enabled)) ==> $mem(#s2, $dot($ptr(^_Rundown, #r), _Rundown.count)) <= $mem(#s2, $dot($ptr(^_Rundown, #r), _Rundown.count)))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^_Rundown, #r)) } $in_full_extent_of(#q, $ptr(^_Rundown, #r)) == (#q == $ptr(^_Rundown, #r) || #q == $dot($ptr(^_Rundown, #r), _Rundown.$owns) || #q == $dot($ptr(^_Rundown, #r), _Rundown.count) || #q == $dot($ptr(^_Rundown, #r), _Rundown.self_claim) || #q == $dot($ptr(^_Rundown, #r), _Rundown.protected_obj) || #q == $dot($ptr(^_Rundown, #r), _Rundown.alive) || #q == $dot($ptr(^_Rundown, #r), _Rundown.enabled) || $in_full_extent_of(#q, $dot($ptr(^_Rundown, #r), _Rundown.enabled_protector))));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_Rundown, #r)) } $in_extent_of(#s, #q, $ptr(^_Rundown, #r)) == $in_struct_extent_of(#q, $ptr(^_Rundown, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^_Rundown, #r)) } $in_span_of(#q, $ptr(^_Rundown, #r)) == (#q == $ptr(^_Rundown, #r) || #q == $dot($ptr(^_Rundown, #r), _Rundown.$owns) || #q == $dot($ptr(^_Rundown, #r), _Rundown.count) || #q == $dot($ptr(^_Rundown, #r), _Rundown.self_claim) || #q == $dot($ptr(^_Rundown, #r), _Rundown.protected_obj) || #q == $dot($ptr(^_Rundown, #r), _Rundown.alive) || #q == $dot($ptr(^_Rundown, #r), _Rundown.enabled)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^_Rundown) } $state_spans_the_same(#s1, #s2, #p, ^_Rundown) == ($mem_eq(#s1, #s2, $dot(#p, _Rundown.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _Rundown.count)) && $mem_eq(#s1, #s2, $dot(#p, _Rundown.self_claim)) && $mem_eq(#s1, #s2, $dot(#p, _Rundown.protected_obj)) && $mem_eq(#s1, #s2, $dot(#p, _Rundown.alive)) && $mem_eq(#s1, #s2, $dot(#p, _Rundown.enabled))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_Rundown) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_Rundown) == $mem_eq(#s1, #s2, $dot(#p, _Rundown.protected_obj)));

axiom $is_claimable(^_Rundown) == true;

axiom $has_volatile_owns_set(^_Rundown) == true;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^_Rundown, #r)) } $extent_mutable(#s1, $ptr(^_Rundown, #r)) == ($mutable(#s1, $ptr(^_Rundown, #r)) && $extent_mutable(#s1, $dot($ptr(^_Rundown, #r), _Rundown.enabled_protector))));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^_Rundown, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^_Rundown, #r)) == ($is_fresh(#s1, #s2, $ptr(^_Rundown, #r)) && $extent_is_fresh(#s1, #s2, $dot($ptr(^_Rundown, #r), _Rundown.enabled_protector))));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^_Rundown, #r)) } $extent_zero(#s1, $ptr(^_Rundown, #r)) == ($mem(#s1, $dot($ptr(^_Rundown, #r), _Rundown.count)) == 0 && $mem(#s1, $dot($ptr(^_Rundown, #r), _Rundown.self_claim)) == 0 && $mem(#s1, $dot($ptr(^_Rundown, #r), _Rundown.protected_obj)) == 0 && $mem(#s1, $dot($ptr(^_Rundown, #r), _Rundown.alive)) == 0 && $mem(#s1, $dot($ptr(^_Rundown, #r), _Rundown.enabled)) == 0 && $extent_zero(#s1, $dot($ptr(^_Rundown, #r), _Rundown.enabled_protector))));

const unique _Rundown.$owns: $field;

axiom $static_field_properties(_Rundown.$owns, ^_Rundown);

axiom $is_primitive_volatile_field(_Rundown.$owns);

axiom (forall #p: $ptr :: { $dot(#p, _Rundown.$owns) } $is(#p, ^_Rundown) ==> $dot(#p, _Rundown.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, _Rundown.$owns)) && $extent_hint($dot(#p, _Rundown.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _Rundown.$owns)) } { $st(#s, $dot(#p, _Rundown.$owns)) } $typed2(#s, #p, ^_Rundown) ==> $field_properties(#s, #p, _Rundown.$owns, ^$#ptrset, true));

axiom $owns_set_field(^_Rundown) == _Rundown.$owns;

const unique _Rundown.count: $field;

axiom $static_field_properties(_Rundown.count, ^_Rundown);

axiom $is_primitive_volatile_field(_Rundown.count);

axiom $field_offset(_Rundown.count) == 0;

axiom (forall #p: $ptr :: { $dot(#p, _Rundown.count) } $is(#p, ^_Rundown) ==> $dot(#p, _Rundown.count) == $ptr(^^u4, $ref(#p) + 0) && $extent_hint($dot(#p, _Rundown.count), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _Rundown.count)) } { $st(#s, $dot(#p, _Rundown.count)) } $typed2(#s, #p, ^_Rundown) ==> $field_properties(#s, #p, _Rundown.count, ^^u4, true));

const unique _Rundown.self_claim: $field;

axiom $static_field_properties(_Rundown.self_claim, ^_Rundown);

axiom $is_primitive_volatile_field(_Rundown.self_claim);

axiom (forall #p: $ptr :: { $dot(#p, _Rundown.self_claim) } $is(#p, ^_Rundown) ==> $dot(#p, _Rundown.self_claim) == $ptr($spec_ptr_to(^^claim), $ghost_ref(#p, _Rundown.self_claim)) && $extent_hint($dot(#p, _Rundown.self_claim), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _Rundown.self_claim)) } { $st(#s, $dot(#p, _Rundown.self_claim)) } $typed2(#s, #p, ^_Rundown) ==> $field_properties(#s, #p, _Rundown.self_claim, $spec_ptr_to(^^claim), true));

const unique _Rundown.protected_obj: $field;

axiom $static_field_properties(_Rundown.protected_obj, ^_Rundown);

axiom $is_primitive_non_volatile_field(_Rundown.protected_obj);

axiom (forall #p: $ptr :: { $dot(#p, _Rundown.protected_obj) } $is(#p, ^_Rundown) ==> $dot(#p, _Rundown.protected_obj) == $ptr($ptr_to(^^void), $ghost_ref(#p, _Rundown.protected_obj)) && $extent_hint($dot(#p, _Rundown.protected_obj), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _Rundown.protected_obj)) } { $st(#s, $dot(#p, _Rundown.protected_obj)) } $typed2(#s, #p, ^_Rundown) ==> $field_properties(#s, #p, _Rundown.protected_obj, $ptr_to(^^void), false));

const unique _Rundown.alive: $field;

axiom $static_field_properties(_Rundown.alive, ^_Rundown);

axiom $is_primitive_volatile_field(_Rundown.alive);

axiom (forall #p: $ptr :: { $dot(#p, _Rundown.alive) } $is(#p, ^_Rundown) ==> $dot(#p, _Rundown.alive) == $ptr(^^bool, $ghost_ref(#p, _Rundown.alive)) && $extent_hint($dot(#p, _Rundown.alive), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _Rundown.alive)) } { $st(#s, $dot(#p, _Rundown.alive)) } $typed2(#s, #p, ^_Rundown) ==> $field_properties(#s, #p, _Rundown.alive, ^^bool, true));

const unique _Rundown.enabled: $field;

axiom $static_field_properties(_Rundown.enabled, ^_Rundown);

axiom $is_primitive_volatile_field(_Rundown.enabled);

axiom (forall #p: $ptr :: { $dot(#p, _Rundown.enabled) } $is(#p, ^_Rundown) ==> $dot(#p, _Rundown.enabled) == $ptr(^^bool, $ghost_ref(#p, _Rundown.enabled)) && $extent_hint($dot(#p, _Rundown.enabled), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _Rundown.enabled)) } { $st(#s, $dot(#p, _Rundown.enabled)) } $typed2(#s, #p, ^_Rundown) ==> $field_properties(#s, #p, _Rundown.enabled, ^^bool, true));

const unique _Rundown.enabled_protector: $field;

axiom $static_field_properties(_Rundown.enabled_protector, ^_Rundown);

axiom (forall #p: $ptr :: { $dot(#p, _Rundown.enabled_protector) } $is(#p, ^_Rundown) ==> $dot(#p, _Rundown.enabled_protector) == $ptr(^_Protector, $ghost_ref(#p, _Rundown.enabled_protector)) && $extent_hint($dot(#p, _Rundown.enabled_protector), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _Rundown.enabled_protector)) } { $st(#s, $dot(#p, _Rundown.enabled_protector)) } $typed2(#s, #p, ^_Rundown) ==> $field_properties(#s, #p, _Rundown.enabled_protector, ^_Protector, false));

procedure _Rundown#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $closed(old($s), $dot($ptr(^_Rundown, P#_this_), _Rundown.enabled_protector)) ==> $read_bool(old($s), $dot($ptr(^_Rundown, P#_this_), _Rundown.enabled)) == $read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.enabled));
  ensures $is_admissibility_check() ==> $closed(old($s), $dot($ptr(^_Rundown, P#_this_), _Rundown.enabled_protector)) ==> $read_bool(old($s), $dot($ptr(^_Rundown, P#_this_), _Rundown.alive)) == $read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.alive));
  ensures $is_admissibility_check() ==> !$read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.alive)) ==> !$read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.enabled));
  ensures $is_admissibility_check() ==> !$read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.alive)) ==> $mem($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.count)) == 0;
  ensures $is_admissibility_check() ==> $mem(old($s), $dot($ptr(^_Rundown, P#_this_), _Rundown.count)) > 0 && $read_bool(old($s), $dot($ptr(^_Rundown, P#_this_), _Rundown.alive)) ==> $read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.alive));
  ensures $is_admissibility_check() ==> $read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.alive)) ==> $keeps($s, $ptr(^_Rundown, P#_this_), $int_to_ptr($mem($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.protected_obj))));
  ensures $is_admissibility_check() ==> $read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.alive)) ==> $keeps($s, $ptr(^_Rundown, P#_this_), $read_ptr($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.self_claim), ^^claim));
  ensures $is_admissibility_check() ==> $read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.alive)) ==> $claims_obj($read_ptr($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.self_claim), ^^claim), $ptr(^_Rundown, P#_this_));
  ensures $is_admissibility_check() ==> $read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.alive)) ==> $ref_cnt($s, $read_ptr($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.self_claim), ^^claim)) == $mem($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.count));
  ensures $is_admissibility_check() ==> $read_bool(old($s), $dot($ptr(^_Rundown, P#_this_), _Rundown.alive)) ==> $ptr_eq($read_ptr(old($s), $dot($ptr(^_Rundown, P#_this_), _Rundown.self_claim), ^^claim), $read_ptr($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.self_claim), ^^claim));
  ensures $is_admissibility_check() ==> !$read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.enabled)) ==> $mem($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.count)) <= $mem(old($s), $dot($ptr(^_Rundown, P#_this_), _Rundown.count));
  ensures $is_stuttering_check() ==> $closed($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.enabled_protector)) ==> $read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.enabled)) == $read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.enabled));
  ensures $is_stuttering_check() ==> $closed($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.enabled_protector)) ==> $read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.alive)) == $read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.alive));
  ensures $is_stuttering_check() ==> $mem($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.count)) > 0 && $read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.alive)) ==> $read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.alive));
  ensures $is_stuttering_check() ==> $read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.alive)) ==> $ptr_eq($read_ptr($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.self_claim), ^^claim), $read_ptr($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.self_claim), ^^claim));
  ensures $is_stuttering_check() ==> !$read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.enabled)) ==> $mem($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.count)) <= $mem($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.count));
  ensures $is_unwrap_check() ==> $closed(old($s), $dot($ptr(^_Rundown, P#_this_), _Rundown.enabled_protector)) ==> $read_bool(old($s), $dot($ptr(^_Rundown, P#_this_), _Rundown.enabled)) == $read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.enabled));
  ensures $is_unwrap_check() ==> $closed(old($s), $dot($ptr(^_Rundown, P#_this_), _Rundown.enabled_protector)) ==> $read_bool(old($s), $dot($ptr(^_Rundown, P#_this_), _Rundown.alive)) == $read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.alive));
  ensures $is_unwrap_check() ==> !$read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.alive)) ==> !$read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.enabled));
  ensures $is_unwrap_check() ==> !$read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.alive)) ==> $mem($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.count)) == 0;
  ensures $is_unwrap_check() ==> $mem(old($s), $dot($ptr(^_Rundown, P#_this_), _Rundown.count)) > 0 && $read_bool(old($s), $dot($ptr(^_Rundown, P#_this_), _Rundown.alive)) ==> $read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.alive));
  ensures $is_unwrap_check() ==> $read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.alive)) ==> $keeps($s, $ptr(^_Rundown, P#_this_), $int_to_ptr($mem($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.protected_obj))));
  ensures $is_unwrap_check() ==> $read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.alive)) ==> $keeps($s, $ptr(^_Rundown, P#_this_), $read_ptr($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.self_claim), ^^claim));
  ensures $is_unwrap_check() ==> $read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.alive)) ==> $claims_obj($read_ptr($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.self_claim), ^^claim), $ptr(^_Rundown, P#_this_));
  ensures $is_unwrap_check() ==> $read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.alive)) ==> $ref_cnt($s, $read_ptr($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.self_claim), ^^claim)) == $mem($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.count));
  ensures $is_unwrap_check() ==> $read_bool(old($s), $dot($ptr(^_Rundown, P#_this_), _Rundown.alive)) ==> $ptr_eq($read_ptr(old($s), $dot($ptr(^_Rundown, P#_this_), _Rundown.self_claim), ^^claim), $read_ptr($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.self_claim), ^^claim));
  ensures $is_unwrap_check() ==> !$read_bool($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.enabled)) ==> $mem($s, $dot($ptr(^_Rundown, P#_this_), _Rundown.count)) <= $mem(old($s), $dot($ptr(^_Rundown, P#_this_), _Rundown.count));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _Rundown#adm(P#_this_: int)
{
  var #wrTime$1^19.67: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^19.67, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^19.67, #loc._this_, $ptr_to_int($ptr(^_Rundown, P#_this_)), $ptr_to(^_Rundown)) && $local_value_is_ptr($s, #tok$1^19.67, #loc._this_, $ptr(^_Rundown, P#_this_), $ptr_to(^_Rundown));
    assume #wrTime$1^19.67 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^19.67, #p) } $in_writes_at(#wrTime$1^19.67, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^_Rundown, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^_Rundown, P#_this_));
        assume $good_state_ext(#tok$1^19.67, $s);
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
            assume $admissibility_pre($s, $ptr(^_Rundown, P#_this_));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^_Rundown, P#_this_));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct _Rundown*)@null))
        call $havoc_others($ptr(^_Rundown, P#_this_), ^_Rundown);
        assume $good_state_ext(#tok$1^19.67, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^_Rundown, P#_this_), ^_Rundown);
    }

  #exit:
}



const unique ^_Resource: $ctype;

axiom $is_composite(^_Resource);

axiom $ptr_level(^_Resource) == 0;

axiom $sizeof(^_Resource) == 8;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_Resource) } $inv2(#s1, #s2, #p, ^_Resource) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty())));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^_Resource, #r), l#public) } $inv_lab(#s2, $ptr(^_Resource, #r), l#public) == ($typed(#s2, $ptr(^_Resource, #r)) && $set_eq($owns(#s2, $ptr(^_Resource, #r)), $set_empty())));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^_Resource, #r)) } $in_full_extent_of(#q, $ptr(^_Resource, #r)) == (#q == $ptr(^_Resource, #r) || #q == $dot($ptr(^_Resource, #r), _Resource.$owns) || #q == $dot($ptr(^_Resource, #r), _Resource.x) || $in_full_extent_of(#q, $dot($ptr(^_Resource, #r), _Resource.rd))));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_Resource, #r)) } $in_extent_of(#s, #q, $ptr(^_Resource, #r)) == $in_struct_extent_of(#q, $ptr(^_Resource, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^_Resource, #r)) } $in_span_of(#q, $ptr(^_Resource, #r)) == (#q == $ptr(^_Resource, #r) || #q == $dot($ptr(^_Resource, #r), _Resource.$owns) || #q == $dot($ptr(^_Resource, #r), _Resource.x)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^_Resource) } $state_spans_the_same(#s1, #s2, #p, ^_Resource) == ($mem_eq(#s1, #s2, $dot(#p, _Resource.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _Resource.x))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_Resource) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_Resource) == $mem_eq(#s1, #s2, $dot(#p, _Resource.$owns)));

axiom $is_claimable(^_Resource) == true;

axiom $has_volatile_owns_set(^_Resource) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^_Resource, #r)) } $extent_mutable(#s1, $ptr(^_Resource, #r)) == ($mutable(#s1, $ptr(^_Resource, #r)) && $extent_mutable(#s1, $dot($ptr(^_Resource, #r), _Resource.rd))));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^_Resource, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^_Resource, #r)) == ($is_fresh(#s1, #s2, $ptr(^_Resource, #r)) && $extent_is_fresh(#s1, #s2, $dot($ptr(^_Resource, #r), _Resource.rd))));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^_Resource, #r)) } $extent_zero(#s1, $ptr(^_Resource, #r)) == ($mem(#s1, $dot($ptr(^_Resource, #r), _Resource.x)) == 0 && $extent_zero(#s1, $dot($ptr(^_Resource, #r), _Resource.rd))));

const unique _Resource.$owns: $field;

axiom $static_field_properties(_Resource.$owns, ^_Resource);

axiom $is_primitive_non_volatile_field(_Resource.$owns);

axiom (forall #p: $ptr :: { $dot(#p, _Resource.$owns) } $is(#p, ^_Resource) ==> $dot(#p, _Resource.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, _Resource.$owns)) && $extent_hint($dot(#p, _Resource.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _Resource.$owns)) } { $st(#s, $dot(#p, _Resource.$owns)) } $typed2(#s, #p, ^_Resource) ==> $field_properties(#s, #p, _Resource.$owns, ^$#ptrset, false));

axiom $owns_set_field(^_Resource) == _Resource.$owns;

const unique _Resource.x: $field;

axiom $static_field_properties(_Resource.x, ^_Resource);

axiom $is_primitive_volatile_field(_Resource.x);

axiom $field_offset(_Resource.x) == 0;

axiom (forall #p: $ptr :: { $dot(#p, _Resource.x) } $is(#p, ^_Resource) ==> $dot(#p, _Resource.x) == $ptr(^^i4, $ref(#p) + 0) && $extent_hint($dot(#p, _Resource.x), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _Resource.x)) } { $st(#s, $dot(#p, _Resource.x)) } $typed2(#s, #p, ^_Resource) ==> $field_properties(#s, #p, _Resource.x, ^^i4, true));

const unique _Resource.rd: $field;

axiom $static_field_properties(_Resource.rd, ^_Resource);

axiom $field_offset(_Resource.rd) == 4;

axiom (forall #p: $ptr :: { $dot(#p, _Resource.rd) } $is(#p, ^_Resource) ==> $dot(#p, _Resource.rd) == $ptr(^_Rundown, $ref(#p) + 4) && $extent_hint($dot(#p, _Resource.rd), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _Resource.rd)) } { $st(#s, $dot(#p, _Resource.rd)) } $typed2(#s, #p, ^_Resource) ==> $field_properties(#s, #p, _Resource.rd, ^_Rundown, false));

const unique ^_RundownContainer: $ctype;

axiom $is_composite(^_RundownContainer);

axiom $ptr_level(^_RundownContainer) == 0;

axiom $sizeof(^_RundownContainer) == 16;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_RundownContainer) } $inv2(#s1, #s2, #p, ^_RundownContainer) == ($typed(#s2, #p) && $read_ptr(#s1, $dot(#p, _RundownContainer.rd_claim), ^^claim) == $read_ptr(#s2, $dot(#p, _RundownContainer.rd_claim), ^^claim) && $keeps(#s2, #p, $read_ptr(#s2, $dot(#p, _RundownContainer.rd_claim), ^^claim)) && $dot($read_ptr(#s1, $dot(#p, _RundownContainer.rsc), ^_Resource), _Resource.rd) == $dot($read_ptr(#s2, $dot(#p, _RundownContainer.rsc), ^_Resource), _Resource.rd) && $keeps(#s2, #p, $dot($read_ptr(#s2, $dot(#p, _RundownContainer.rsc), ^_Resource), _Resource.rd)) && $dot($dot($read_ptr(#s1, $dot(#p, _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector) == $dot($dot($read_ptr(#s2, $dot(#p, _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector) && $keeps(#s2, #p, $dot($dot($read_ptr(#s2, $dot(#p, _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector)) && $claims_obj($read_ptr(#s2, $dot(#p, _RundownContainer.rd_claim), ^^claim), $dot($read_ptr(#s2, $dot(#p, _RundownContainer.rsc), ^_Resource), _Resource.rd)) && $claims_obj($read_ptr(#s2, $dot(#p, _RundownContainer.rd_claim), ^^claim), $dot($dot($read_ptr(#s2, $dot(#p, _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector)) && $ref_cnt(#s2, $dot($dot($read_ptr(#s2, $dot(#p, _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector)) == 1 && $ref_cnt(#s2, $dot($read_ptr(#s2, $dot(#p, _RundownContainer.rsc), ^_Resource), _Resource.rd)) == 2 && $ref_cnt(#s2, $read_ptr(#s2, $dot(#p, _RundownContainer.rd_claim), ^^claim)) == 0 && (forall #cs0: $state :: { $valid_claim(#cs0, $read_ptr(#s2, $dot(#p, _RundownContainer.rd_claim), ^^claim)) } $valid_claim(#cs0, $read_ptr(#s2, $dot(#p, _RundownContainer.rd_claim), ^^claim)) ==> $read_bool(#cs0, $dot($dot($read_ptr(#s2, $dot(#p, _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled)) == $read_bool(#s2, $dot(#p, _RundownContainer.enabled))) && (forall #cs1: $state :: { $valid_claim(#cs1, $read_ptr(#s2, $dot(#p, _RundownContainer.rd_claim), ^^claim)) } $valid_claim(#cs1, $read_ptr(#s2, $dot(#p, _RundownContainer.rd_claim), ^^claim)) ==> $read_bool(#cs1, $dot($dot($read_ptr(#s2, $dot(#p, _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.alive))) && (forall #cs2: $state :: { $valid_claim(#cs2, $read_ptr(#s2, $dot(#p, _RundownContainer.rd_claim), ^^claim)) } $valid_claim(#cs2, $read_ptr(#s2, $dot(#p, _RundownContainer.rd_claim), ^^claim)) ==> $int_to_ptr($mem(#cs2, $dot($dot($read_ptr(#s2, $dot(#p, _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.protected_obj))) == $read_ptr(#s2, $dot(#p, _RundownContainer.rsc), ^_Resource))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^_RundownContainer, #r), l#public) } $inv_lab(#s2, $ptr(^_RundownContainer, #r), l#public) == ($typed(#s2, $ptr(^_RundownContainer, #r)) && $keeps(#s2, $ptr(^_RundownContainer, #r), $read_ptr(#s2, $dot($ptr(^_RundownContainer, #r), _RundownContainer.rd_claim), ^^claim)) && $keeps(#s2, $ptr(^_RundownContainer, #r), $dot($read_ptr(#s2, $dot($ptr(^_RundownContainer, #r), _RundownContainer.rsc), ^_Resource), _Resource.rd)) && $keeps(#s2, $ptr(^_RundownContainer, #r), $dot($dot($read_ptr(#s2, $dot($ptr(^_RundownContainer, #r), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector)) && $claims_obj($read_ptr(#s2, $dot($ptr(^_RundownContainer, #r), _RundownContainer.rd_claim), ^^claim), $dot($read_ptr(#s2, $dot($ptr(^_RundownContainer, #r), _RundownContainer.rsc), ^_Resource), _Resource.rd)) && $claims_obj($read_ptr(#s2, $dot($ptr(^_RundownContainer, #r), _RundownContainer.rd_claim), ^^claim), $dot($dot($read_ptr(#s2, $dot($ptr(^_RundownContainer, #r), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector)) && $ref_cnt(#s2, $dot($dot($read_ptr(#s2, $dot($ptr(^_RundownContainer, #r), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector)) == 1 && $ref_cnt(#s2, $dot($read_ptr(#s2, $dot($ptr(^_RundownContainer, #r), _RundownContainer.rsc), ^_Resource), _Resource.rd)) == 2 && $ref_cnt(#s2, $read_ptr(#s2, $dot($ptr(^_RundownContainer, #r), _RundownContainer.rd_claim), ^^claim)) == 0 && (forall #cs3: $state :: { $valid_claim(#cs3, $read_ptr(#s2, $dot($ptr(^_RundownContainer, #r), _RundownContainer.rd_claim), ^^claim)) } $valid_claim(#cs3, $read_ptr(#s2, $dot($ptr(^_RundownContainer, #r), _RundownContainer.rd_claim), ^^claim)) ==> $read_bool(#cs3, $dot($dot($read_ptr(#s2, $dot($ptr(^_RundownContainer, #r), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled)) == $read_bool(#s2, $dot($ptr(^_RundownContainer, #r), _RundownContainer.enabled))) && (forall #cs4: $state :: { $valid_claim(#cs4, $read_ptr(#s2, $dot($ptr(^_RundownContainer, #r), _RundownContainer.rd_claim), ^^claim)) } $valid_claim(#cs4, $read_ptr(#s2, $dot($ptr(^_RundownContainer, #r), _RundownContainer.rd_claim), ^^claim)) ==> $read_bool(#cs4, $dot($dot($read_ptr(#s2, $dot($ptr(^_RundownContainer, #r), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.alive))) && (forall #cs5: $state :: { $valid_claim(#cs5, $read_ptr(#s2, $dot($ptr(^_RundownContainer, #r), _RundownContainer.rd_claim), ^^claim)) } $valid_claim(#cs5, $read_ptr(#s2, $dot($ptr(^_RundownContainer, #r), _RundownContainer.rd_claim), ^^claim)) ==> $int_to_ptr($mem(#cs5, $dot($dot($read_ptr(#s2, $dot($ptr(^_RundownContainer, #r), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.protected_obj))) == $read_ptr(#s2, $dot($ptr(^_RundownContainer, #r), _RundownContainer.rsc), ^_Resource))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^_RundownContainer, #r)) } $in_full_extent_of(#q, $ptr(^_RundownContainer, #r)) == (#q == $ptr(^_RundownContainer, #r) || #q == $dot($ptr(^_RundownContainer, #r), _RundownContainer.$owns) || #q == $dot($ptr(^_RundownContainer, #r), _RundownContainer.rsc) || #q == $dot($ptr(^_RundownContainer, #r), _RundownContainer.enabled) || #q == $dot($ptr(^_RundownContainer, #r), _RundownContainer.rd_claim)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_RundownContainer, #r)) } $in_extent_of(#s, #q, $ptr(^_RundownContainer, #r)) == $in_struct_extent_of(#q, $ptr(^_RundownContainer, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_RundownContainer, #r)) } $typed(#s, $ptr(^_RundownContainer, #r)) ==> $in_extent_of(#s, #q, $ptr(^_RundownContainer, #r)) == (#q == $ptr(^_RundownContainer, #r) || $emb(#s, #q) == $ptr(^_RundownContainer, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^_RundownContainer, #r)) } $in_span_of(#q, $ptr(^_RundownContainer, #r)) == (#q == $ptr(^_RundownContainer, #r) || #q == $dot($ptr(^_RundownContainer, #r), _RundownContainer.$owns) || #q == $dot($ptr(^_RundownContainer, #r), _RundownContainer.rsc) || #q == $dot($ptr(^_RundownContainer, #r), _RundownContainer.enabled) || #q == $dot($ptr(^_RundownContainer, #r), _RundownContainer.rd_claim)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^_RundownContainer) } $state_spans_the_same(#s1, #s2, #p, ^_RundownContainer) == ($mem_eq(#s1, #s2, $dot(#p, _RundownContainer.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _RundownContainer.rsc)) && $mem_eq(#s1, #s2, $dot(#p, _RundownContainer.enabled)) && $mem_eq(#s1, #s2, $dot(#p, _RundownContainer.rd_claim))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_RundownContainer) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_RundownContainer) == ($mem_eq(#s1, #s2, $dot(#p, _RundownContainer.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _RundownContainer.rsc)) && $mem_eq(#s1, #s2, $dot(#p, _RundownContainer.enabled)) && $mem_eq(#s1, #s2, $dot(#p, _RundownContainer.rd_claim))));

axiom $is_claimable(^_RundownContainer) == false;

axiom $has_volatile_owns_set(^_RundownContainer) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^_RundownContainer, #r)) } $extent_mutable(#s1, $ptr(^_RundownContainer, #r)) == $mutable(#s1, $ptr(^_RundownContainer, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^_RundownContainer, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^_RundownContainer, #r)) == $is_fresh(#s1, #s2, $ptr(^_RundownContainer, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^_RundownContainer, #r)) } $extent_zero(#s1, $ptr(^_RundownContainer, #r)) == ($mem(#s1, $dot($ptr(^_RundownContainer, #r), _RundownContainer.rsc)) == 0 && $mem(#s1, $dot($ptr(^_RundownContainer, #r), _RundownContainer.enabled)) == 0 && $mem(#s1, $dot($ptr(^_RundownContainer, #r), _RundownContainer.rd_claim)) == 0));

const unique _RundownContainer.$owns: $field;

axiom $static_field_properties(_RundownContainer.$owns, ^_RundownContainer);

axiom $is_primitive_non_volatile_field(_RundownContainer.$owns);

axiom (forall #p: $ptr :: { $dot(#p, _RundownContainer.$owns) } $is(#p, ^_RundownContainer) ==> $dot(#p, _RundownContainer.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, _RundownContainer.$owns)) && $extent_hint($dot(#p, _RundownContainer.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _RundownContainer.$owns)) } { $st(#s, $dot(#p, _RundownContainer.$owns)) } $typed2(#s, #p, ^_RundownContainer) ==> $field_properties(#s, #p, _RundownContainer.$owns, ^$#ptrset, false));

axiom $owns_set_field(^_RundownContainer) == _RundownContainer.$owns;

const unique _RundownContainer.rsc: $field;

axiom $static_field_properties(_RundownContainer.rsc, ^_RundownContainer);

axiom $is_primitive_non_volatile_field(_RundownContainer.rsc);

axiom $field_offset(_RundownContainer.rsc) == 0;

axiom (forall #p: $ptr :: { $dot(#p, _RundownContainer.rsc) } $is(#p, ^_RundownContainer) ==> $dot(#p, _RundownContainer.rsc) == $ptr($ptr_to(^_Resource), $ref(#p) + 0) && $extent_hint($dot(#p, _RundownContainer.rsc), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _RundownContainer.rsc)) } { $st(#s, $dot(#p, _RundownContainer.rsc)) } $typed2(#s, #p, ^_RundownContainer) ==> $field_properties(#s, #p, _RundownContainer.rsc, $ptr_to(^_Resource), false));

const unique _RundownContainer.enabled: $field;

axiom $static_field_properties(_RundownContainer.enabled, ^_RundownContainer);

axiom $is_primitive_non_volatile_field(_RundownContainer.enabled);

axiom $field_offset(_RundownContainer.enabled) == 8;

axiom (forall #p: $ptr :: { $dot(#p, _RundownContainer.enabled) } $is(#p, ^_RundownContainer) ==> $dot(#p, _RundownContainer.enabled) == $ptr(^^bool, $ref(#p) + 8) && $extent_hint($dot(#p, _RundownContainer.enabled), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _RundownContainer.enabled)) } { $st(#s, $dot(#p, _RundownContainer.enabled)) } $typed2(#s, #p, ^_RundownContainer) ==> $field_properties(#s, #p, _RundownContainer.enabled, ^^bool, false));

const unique _RundownContainer.rd_claim: $field;

axiom $static_field_properties(_RundownContainer.rd_claim, ^_RundownContainer);

axiom $is_primitive_non_volatile_field(_RundownContainer.rd_claim);

axiom (forall #p: $ptr :: { $dot(#p, _RundownContainer.rd_claim) } $is(#p, ^_RundownContainer) ==> $dot(#p, _RundownContainer.rd_claim) == $ptr($spec_ptr_to(^^claim), $ghost_ref(#p, _RundownContainer.rd_claim)) && $extent_hint($dot(#p, _RundownContainer.rd_claim), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _RundownContainer.rd_claim)) } { $st(#s, $dot(#p, _RundownContainer.rd_claim)) } $typed2(#s, #p, ^_RundownContainer) ==> $field_properties(#s, #p, _RundownContainer.rd_claim, $spec_ptr_to(^^claim), false));

procedure _RundownContainer#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $read_ptr(old($s), $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim) == $read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim);
  ensures $is_admissibility_check() ==> $keeps($s, $ptr(^_RundownContainer, P#_this_), $read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim));
  ensures $is_admissibility_check() ==> $dot($read_ptr(old($s), $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd) == $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd);
  ensures $is_admissibility_check() ==> $keeps($s, $ptr(^_RundownContainer, P#_this_), $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd));
  ensures $is_admissibility_check() ==> $dot($dot($read_ptr(old($s), $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector) == $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector);
  ensures $is_admissibility_check() ==> $keeps($s, $ptr(^_RundownContainer, P#_this_), $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector));
  ensures $is_admissibility_check() ==> $claims_obj($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim), $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd));
  ensures $is_admissibility_check() ==> $claims_obj($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim), $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector));
  ensures $is_admissibility_check() ==> $ref_cnt($s, $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector)) == 1;
  ensures $is_admissibility_check() ==> $ref_cnt($s, $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd)) == 2;
  ensures $is_admissibility_check() ==> $ref_cnt($s, $read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim)) == 0;
  ensures $is_admissibility_check() ==> (forall #cs6: $state :: { $valid_claim(#cs6, $read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim)) } $valid_claim(#cs6, $read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim)) ==> $read_bool(#cs6, $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled)) == $read_bool($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.enabled)));
  ensures $is_admissibility_check() ==> (forall #cs7: $state :: { $valid_claim(#cs7, $read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim)) } $valid_claim(#cs7, $read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim)) ==> $read_bool(#cs7, $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.alive)));
  ensures $is_admissibility_check() ==> (forall #cs8: $state :: { $valid_claim(#cs8, $read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim)) } $valid_claim(#cs8, $read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim)) ==> $int_to_ptr($mem(#cs8, $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.protected_obj))) == $read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource));
  ensures $is_stuttering_check() ==> $read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim) == $read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim);
  ensures $is_stuttering_check() ==> $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd) == $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd);
  ensures $is_stuttering_check() ==> $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector) == $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector);
  ensures $is_unwrap_check() ==> $read_ptr(old($s), $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim) == $read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim);
  ensures $is_unwrap_check() ==> $keeps($s, $ptr(^_RundownContainer, P#_this_), $read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim));
  ensures $is_unwrap_check() ==> $dot($read_ptr(old($s), $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd) == $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd);
  ensures $is_unwrap_check() ==> $keeps($s, $ptr(^_RundownContainer, P#_this_), $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd));
  ensures $is_unwrap_check() ==> $dot($dot($read_ptr(old($s), $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector) == $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector);
  ensures $is_unwrap_check() ==> $keeps($s, $ptr(^_RundownContainer, P#_this_), $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector));
  ensures $is_unwrap_check() ==> $claims_obj($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim), $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd));
  ensures $is_unwrap_check() ==> $claims_obj($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim), $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector));
  ensures $is_unwrap_check() ==> $ref_cnt($s, $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector)) == 1;
  ensures $is_unwrap_check() ==> $ref_cnt($s, $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd)) == 2;
  ensures $is_unwrap_check() ==> $ref_cnt($s, $read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim)) == 0;
  ensures $is_unwrap_check() ==> (forall #cs9: $state :: { $valid_claim(#cs9, $read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim)) } $valid_claim(#cs9, $read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim)) ==> $read_bool(#cs9, $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled)) == $read_bool($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.enabled)));
  ensures $is_unwrap_check() ==> (forall #cs10: $state :: { $valid_claim(#cs10, $read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim)) } $valid_claim(#cs10, $read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim)) ==> $read_bool(#cs10, $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.alive)));
  ensures $is_unwrap_check() ==> (forall #cs11: $state :: { $valid_claim(#cs11, $read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim)) } $valid_claim(#cs11, $read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rd_claim), ^^claim)) ==> $int_to_ptr($mem(#cs11, $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.protected_obj))) == $read_ptr($s, $dot($ptr(^_RundownContainer, P#_this_), _RundownContainer.rsc), ^_Resource));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _RundownContainer#adm(P#_this_: int)
{
  var #wrTime$1^114.9: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^114.9, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^114.9, #loc._this_, $ptr_to_int($ptr(^_RundownContainer, P#_this_)), $ptr_to(^_RundownContainer)) && $local_value_is_ptr($s, #tok$1^114.9, #loc._this_, $ptr(^_RundownContainer, P#_this_), $ptr_to(^_RundownContainer));
    assume #wrTime$1^114.9 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^114.9, #p) } $in_writes_at(#wrTime$1^114.9, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon7:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^_RundownContainer, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^_RundownContainer, P#_this_));
        assume $good_state_ext(#tok$1^114.9, $s);
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
            assume $admissibility_pre($s, $ptr(^_RundownContainer, P#_this_));
        }
        else
        {
          anon9:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^_RundownContainer, P#_this_));
        }

      anon11:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct _RundownContainer*)@null))
        call $havoc_others($ptr(^_RundownContainer, P#_this_), ^_RundownContainer);
        assume $good_state_ext(#tok$1^114.9, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^_RundownContainer, P#_this_), ^_RundownContainer);
    }

  #exit:
}



procedure InitializeRundown(P#r: int, SP#obj: $ptr) returns (OP#rdi: int);
  requires $wrapped($s, SP#obj, $typ(SP#obj));
  modifies $s, $cev_pc;
  free ensures $in_range_spec_ptr($ref($ptr(^^claim, OP#rdi)));
  ensures $claims_obj($ptr(^^claim, OP#rdi), $ptr(^_Rundown, P#r));
  ensures $claims_obj($ptr(^^claim, OP#rdi), $dot($ptr(^_Rundown, P#r), _Rundown.enabled_protector));
  ensures $is_fresh(old($s), $s, $ptr(^^claim, OP#rdi)) && $wrapped($s, $ptr(^^claim, OP#rdi), ^^claim) && $ref_cnt($s, $ptr(^^claim, OP#rdi)) == 0 && (forall #cs12: $state :: { $valid_claim(#cs12, $ptr(^^claim, OP#rdi)) } $valid_claim(#cs12, $ptr(^^claim, OP#rdi)) ==> $read_bool(#cs12, $dot($ptr(^_Rundown, P#r), _Rundown.enabled)) && $int_to_ptr($mem(#cs12, $dot($ptr(^_Rundown, P#r), _Rundown.protected_obj))) == SP#obj);
  ensures $ref_cnt($s, $ptr(^_Rundown, P#r)) == 2;
  ensures $wrapped($s, $dot($ptr(^_Rundown, P#r), _Rundown.enabled_protector), ^_Protector) && $ref_cnt($s, $dot($ptr(^_Rundown, P#r), _Rundown.enabled_protector)) == 1;
  ensures $wrapped($s, $ptr(^_Rundown, P#r), ^_Rundown);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $extent(old($s), $ptr(^_Rundown, P#r))) || #p == SP#obj || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $extent(old($s), $ptr(^_Rundown, P#r))) || #p == SP#obj || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $extent(old($s), $ptr(^_Rundown, P#r))) || #p == SP#obj || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation InitializeRundown(P#r: int, SP#obj: $ptr) returns (OP#rdi: int)
{
  var claim#1doAdm: bool;
  var claim#1s2: $state;
  var claim#1s1: $state;
  var claim#1s0: $state;
  var claim#1: $ptr;
  var owns#9: $ptrset;
  var staticWrapState#8: $state;
  var prestate#10: $state;
  var beforeAtomicState#0: $state;
  var claim#0doAdm: bool;
  var claim#0s2: $state;
  var claim#0s1: $state;
  var claim#0s0: $state;
  var claim#0: $ptr;
  var atomicObj#35: $ptr;
  var prestate#7: $state;
  var SL#s1: int where $in_range_spec_ptr(SL#s1);
  var #wrTime$1^43.1: int;
  var #stackframe: int;

  anon15:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^43.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^43.1, #loc.r, $ptr_to_int($ptr(^_Rundown, P#r)), $ptr_to(^_Rundown)) && $local_value_is_ptr($s, #tok$1^43.1, #loc.r, $ptr(^_Rundown, P#r), $ptr_to(^_Rundown));
    assume $local_value_is($s, #tok$1^43.1, #loc.obj, $ptr_to_int(SP#obj), $ptr_to(^^void));
    assume #wrTime$1^43.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^43.1, #p) } $in_writes_at(#wrTime$1^43.1, #p) == ($set_in(#p, $extent($s, $ptr(^_Rundown, P#r))) || #p == SP#obj));
    assume (forall #p: $ptr :: { $extent_hint(#p, $ptr(^_Rundown, P#r)) } $set_in(#p, $extent($s, $ptr(^_Rundown, P#r))) ==> $mutable($s, #p));
    assume $thread_owned_or_even_mutable($s, SP#obj);
    // assume @in_range_phys_ptr((mathint)r); 
    assume $in_range_phys_ptr($ref($ptr(^_Rundown, P#r)));
    // assume @in_range_spec_ptr((mathint)rdi); 
    assume $in_range_spec_ptr($ref($ptr(^^claim, OP#rdi)));
    // assert @_vcc_in_domain(@state, obj, obj); 
    assert $in_domain_lab($s, SP#obj, SP#obj, l#public);
    // claim_t^ s1; 
    assume $local_value_is($s, #tok$1^53.25, #loc.s1, $ptr_to_int($ptr(^^claim, SL#s1)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^53.25, #loc.s1, $ptr(^^claim, SL#s1), $spec_ptr_to(^^claim));
    // var spec claim_t^ s1
    // assert @_vcc_typed2(@state, (r->count)); 
    assert $typed2($s, $dot($ptr(^_Rundown, P#r), _Rundown.count), ^^u4);
    // assert @prim_writes_check((r->count)); 
    assert $writable($s, #wrTime$1^43.1, $dot($ptr(^_Rundown, P#r), _Rundown.count));
    // *(r->count) := 0; 
    call $write_int($dot($ptr(^_Rundown, P#r), _Rundown.count), 0);
    assume $full_stop_ext(#tok$1^55.3, $s);
    // assert @writes_check(@_vcc_span(r)); 
    assert (forall #writes$1^56.25: $ptr :: { $dont_instantiate(#writes$1^56.25) } $set_in(#writes$1^56.25, $span($ptr(^_Rundown, P#r))) ==> $top_writable($s, #wrTime$1^43.1, #writes$1^56.25));
    // stmt _vcc_set_owns(r, @_vcc_set_empty); 
    call $set_owns($ptr(^_Rundown, P#r), $set_empty());
    assume $full_stop_ext(#tok$1^56.25, $s);
    // empty
    // assert @writes_check(@_vcc_span((r->enabled_protector))); 
    assert (forall #writes$1^57.25: $ptr :: { $dont_instantiate(#writes$1^57.25) } $set_in(#writes$1^57.25, $span($dot($ptr(^_Rundown, P#r), _Rundown.enabled_protector))) ==> $top_writable($s, #wrTime$1^43.1, #writes$1^57.25));
    // stmt _vcc_set_owns((r->enabled_protector), @_vcc_set_empty); 
    call $set_owns($dot($ptr(^_Rundown, P#r), _Rundown.enabled_protector), $set_empty());
    assume $full_stop_ext(#tok$1^57.25, $s);
    // empty
    // assert @_vcc_typed2(@state, (r->protected_obj)); 
    assert $typed2($s, $dot($ptr(^_Rundown, P#r), _Rundown.protected_obj), $ptr_to(^^void));
    // assert @prim_writes_check((r->protected_obj)); 
    assert $writable($s, #wrTime$1^43.1, $dot($ptr(^_Rundown, P#r), _Rundown.protected_obj));
    // *(r->protected_obj) := obj; 
    call $write_int($dot($ptr(^_Rundown, P#r), _Rundown.protected_obj), $ptr_to_int(SP#obj));
    assume $full_stop_ext(#tok$1^58.27, $s);
    // assert @_vcc_typed2(@state, (r->alive)); 
    assert $typed2($s, $dot($ptr(^_Rundown, P#r), _Rundown.alive), ^^bool);
    // assert @prim_writes_check((r->alive)); 
    assert $writable($s, #wrTime$1^43.1, $dot($ptr(^_Rundown, P#r), _Rundown.alive));
    // *(r->alive) := false; 
    call $write_int($dot($ptr(^_Rundown, P#r), _Rundown.alive), $bool_to_int(false));
    assume $full_stop_ext(#tok$1^58.51, $s);
    // assert @_vcc_typed2(@state, (r->enabled)); 
    assert $typed2($s, $dot($ptr(^_Rundown, P#r), _Rundown.enabled), ^^bool);
    // assert @prim_writes_check((r->enabled)); 
    assert $writable($s, #wrTime$1^43.1, $dot($ptr(^_Rundown, P#r), _Rundown.enabled));
    // *(r->enabled) := false; 
    call $write_int($dot($ptr(^_Rundown, P#r), _Rundown.enabled), $bool_to_int(false));
    assume $full_stop_ext(#tok$1^58.70, $s);
    // _math state_t prestate#7; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#7, $state_to_int(prestate#7), ^$#state_t);
    // prestate#7 := @_vcc_current_state(@state); 
    prestate#7 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#7, $state_to_int(prestate#7), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(r); 
    assert $top_writable($s, #wrTime$1^43.1, $ptr(^_Rundown, P#r));
    // assert @writes_check(@_vcc_owns(@state, r)); 
    assert (forall #writes$1^59.19: $ptr :: { $dont_instantiate(#writes$1^59.19) } $set_in(#writes$1^59.19, $owns($s, $ptr(^_Rundown, P#r))) ==> $top_writable($s, #wrTime$1^43.1, #writes$1^59.19));
    // stmt @_vcc_wrap(r, @_vcc_typeof(r)); 
    call $wrap($ptr(^_Rundown, P#r), ^_Rundown);
    assume $good_state_ext(#tok$1^59.19, $s);
    // assert @inv_check(==>(old(prestate#7, @_vcc_closed(@state, (r->enabled_protector))), ==(old(prestate#7, *((r->enabled))), *((r->enabled))))); 
    assert $closed(prestate#7, $dot($ptr(^_Rundown, P#r), _Rundown.enabled_protector)) ==> $read_bool(prestate#7, $dot($ptr(^_Rundown, P#r), _Rundown.enabled)) == $read_bool($s, $dot($ptr(^_Rundown, P#r), _Rundown.enabled));
    // assert @inv_check(==>(old(prestate#7, @_vcc_closed(@state, (r->enabled_protector))), ==(old(prestate#7, *((r->alive))), *((r->alive))))); 
    assert $closed(prestate#7, $dot($ptr(^_Rundown, P#r), _Rundown.enabled_protector)) ==> $read_bool(prestate#7, $dot($ptr(^_Rundown, P#r), _Rundown.alive)) == $read_bool($s, $dot($ptr(^_Rundown, P#r), _Rundown.alive));
    // assert @inv_check(==>(unchecked!(*((r->alive))), unchecked!(*((r->enabled))))); 
    assert !$read_bool($s, $dot($ptr(^_Rundown, P#r), _Rundown.alive)) ==> !$read_bool($s, $dot($ptr(^_Rundown, P#r), _Rundown.enabled));
    // assert @inv_check(==>(unchecked!(*((r->alive))), ==(*((r->count)), 0))); 
    assert !$read_bool($s, $dot($ptr(^_Rundown, P#r), _Rundown.alive)) ==> $mem($s, $dot($ptr(^_Rundown, P#r), _Rundown.count)) == 0;
    // assert @inv_check(==>(&&(>(old(prestate#7, *((r->count))), 0), old(prestate#7, *((r->alive)))), *((r->alive)))); 
    assert $mem(prestate#7, $dot($ptr(^_Rundown, P#r), _Rundown.count)) > 0 && $read_bool(prestate#7, $dot($ptr(^_Rundown, P#r), _Rundown.alive)) ==> $read_bool($s, $dot($ptr(^_Rundown, P#r), _Rundown.alive));
    // assert @inv_check(==>(*((r->alive)), @keeps(r, *((r->protected_obj))))); 
    assert $read_bool($s, $dot($ptr(^_Rundown, P#r), _Rundown.alive)) ==> $keeps($s, $ptr(^_Rundown, P#r), $int_to_ptr($mem($s, $dot($ptr(^_Rundown, P#r), _Rundown.protected_obj))));
    // assert @inv_check(==>(*((r->alive)), @keeps(r, *((r->self_claim))))); 
    assert $read_bool($s, $dot($ptr(^_Rundown, P#r), _Rundown.alive)) ==> $keeps($s, $ptr(^_Rundown, P#r), $read_ptr($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim));
    // assert @inv_check(==>(*((r->alive)), @_vcc_claims_obj(*((r->self_claim)), r))); 
    assert $read_bool($s, $dot($ptr(^_Rundown, P#r), _Rundown.alive)) ==> $claims_obj($read_ptr($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim), $ptr(^_Rundown, P#r));
    // assert @inv_check(==>(*((r->alive)), ==(@_vcc_ref_cnt(@state, *((r->self_claim))), *((r->count))))); 
    assert $read_bool($s, $dot($ptr(^_Rundown, P#r), _Rundown.alive)) ==> $ref_cnt($s, $read_ptr($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim)) == $mem($s, $dot($ptr(^_Rundown, P#r), _Rundown.count));
    // assert @inv_check(==>(old(prestate#7, *((r->alive))), @_vcc_ptr_eq(old(prestate#7, *((r->self_claim))), *((r->self_claim))))); 
    assert $read_bool(prestate#7, $dot($ptr(^_Rundown, P#r), _Rundown.alive)) ==> $ptr_eq($read_ptr(prestate#7, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim), $read_ptr($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim));
    // assert @inv_check(==>(unchecked!(*((r->enabled))), <=(*((r->count)), old(prestate#7, *((r->count)))))); 
    assert !$read_bool($s, $dot($ptr(^_Rundown, P#r), _Rundown.enabled)) ==> $mem($s, $dot($ptr(^_Rundown, P#r), _Rundown.count)) <= $mem(prestate#7, $dot($ptr(^_Rundown, P#r), _Rundown.count));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_not_shared(@state, r); 
    assert $not_shared($s, $ptr(^_Rundown, P#r));
    // assume @_vcc_not_shared(@state, r); 
    assume $not_shared($s, $ptr(^_Rundown, P#r));
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^64.21, $s);
    atomicObj#35 := $ptr(^_Rundown, P#r);
    // s1 := @claim(pure(true), r); 
    assert $closed($s, $ptr(^_Rundown, P#r));
    assert $top_writable($s, #wrTime$1^43.1, $ptr(^_Rundown, P#r));
    assert $is_claimable(^_Rundown);
    call $write_ref_cnt($ptr(^_Rundown, P#r), $ref_cnt($s, $ptr(^_Rundown, P#r)) + 1);
    assume $ref_cnt($s, $ptr(^_Rundown, P#r)) >= 0;
    claim#0s0 := $s;
    call claim#0 := $alloc_claim();
    assume $claims_obj(claim#0, $ptr(^_Rundown, P#r));
    SL#s1 := $ref(claim#0);
    assume $local_value_is($s, #tok$1^65.12, #loc.s1, $ptr_to_int($ptr(^^claim, SL#s1)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^65.12, #loc.s1, $ptr(^^claim, SL#s1), $spec_ptr_to(^^claim));
    assume $full_stop_ext(#tok$1^65.12, $s);
    assume claim#0 != $no_claim ==> $claim_initial_assumptions($s, claim#0, #tok$1^65.12);
    assert true;
    if (claim#0doAdm)
    {
      anon13:
        assume true;
        assume $valid_claim_impl(claim#0s0, claim#0s2);
        assume $claim_transitivity_assumptions(claim#0s1, claim#0s2, claim#0, #tok$1^65.12);
        assert true;
        assume false;
    }

  anon16:
    assume claim#0 != $no_claim ==> (forall #cs13: $state :: { $valid_claim(#cs13, claim#0) } true);
    assert $closed($s, atomicObj#35);
    assume $inv($s, atomicObj#35, ^_Rundown);
    beforeAtomicState#0 := $s;
    // assert @_vcc_typed2(@state, (r->alive)); 
    assert $typed2($s, $dot($ptr(^_Rundown, P#r), _Rundown.alive), ^^bool);
    // assert @prim_writes_check((r->alive)); 
    assert $set_in($dot($ptr(^_Rundown, P#r), _Rundown.alive), $volatile_span($s, atomicObj#35)) || $writable($s, #wrTime$1^43.1, $dot($ptr(^_Rundown, P#r), _Rundown.alive));
    // *(r->alive) := true; 
    call $write_int($dot($ptr(^_Rundown, P#r), _Rundown.alive), $bool_to_int(true));
    assume $good_state_ext(#tok$1^67.7, $s);
    // assert @_vcc_typed2(@state, (r->enabled)); 
    assert $typed2($s, $dot($ptr(^_Rundown, P#r), _Rundown.enabled), ^^bool);
    // assert @prim_writes_check((r->enabled)); 
    assert $set_in($dot($ptr(^_Rundown, P#r), _Rundown.enabled), $volatile_span($s, atomicObj#35)) || $writable($s, #wrTime$1^43.1, $dot($ptr(^_Rundown, P#r), _Rundown.enabled));
    // *(r->enabled) := true; 
    call $write_int($dot($ptr(^_Rundown, P#r), _Rundown.enabled), $bool_to_int(true));
    assume $good_state_ext(#tok$1^68.7, $s);
    // assert @_vcc_typed2(@state, (r->self_claim)); 
    assert $typed2($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), $spec_ptr_to(^^claim));
    // assert @prim_writes_check((r->self_claim)); 
    assert $set_in($dot($ptr(^_Rundown, P#r), _Rundown.self_claim), $volatile_span($s, atomicObj#35)) || $writable($s, #wrTime$1^43.1, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim));
    // *(r->self_claim) := s1; 
    call $write_int($dot($ptr(^_Rundown, P#r), _Rundown.self_claim), $ref($ptr(^^claim, SL#s1)));
    assume $good_state_ext(#tok$1^69.7, $s);
    // assert @is_atomic_obj(r); 
    assert $ptr(^_Rundown, P#r) == atomicObj#35;
    // assert @writes_check(obj); 
    assert $top_writable($s, #wrTime$1^43.1, SP#obj);
    // stmt _vcc_set_closed_owner(obj, r); 
    call $set_closed_owner(SP#obj, $ptr(^_Rundown, P#r));
    assume $good_state_ext(#tok$1^70.29, $s);
    // empty
    // assert @is_atomic_obj(r); 
    assert $ptr(^_Rundown, P#r) == atomicObj#35;
    // assert @writes_check(s1); 
    assert $top_writable($s, #wrTime$1^43.1, $ptr(^^claim, SL#s1));
    // stmt _vcc_set_closed_owner(s1, r); 
    call $set_closed_owner($ptr(^^claim, SL#s1), $ptr(^_Rundown, P#r));
    assume $good_state_ext(#tok$1^71.29, $s);
    // empty
    assert $closed(beforeAtomicState#0, $dot(atomicObj#35, _Rundown.enabled_protector)) ==> $read_bool(beforeAtomicState#0, $dot(atomicObj#35, _Rundown.enabled)) == $read_bool($s, $dot(atomicObj#35, _Rundown.enabled));
    assert $closed(beforeAtomicState#0, $dot(atomicObj#35, _Rundown.enabled_protector)) ==> $read_bool(beforeAtomicState#0, $dot(atomicObj#35, _Rundown.alive)) == $read_bool($s, $dot(atomicObj#35, _Rundown.alive));
    assert !$read_bool($s, $dot(atomicObj#35, _Rundown.alive)) ==> !$read_bool($s, $dot(atomicObj#35, _Rundown.enabled));
    assert !$read_bool($s, $dot(atomicObj#35, _Rundown.alive)) ==> $mem($s, $dot(atomicObj#35, _Rundown.count)) == 0;
    assert $mem(beforeAtomicState#0, $dot(atomicObj#35, _Rundown.count)) > 0 && $read_bool(beforeAtomicState#0, $dot(atomicObj#35, _Rundown.alive)) ==> $read_bool($s, $dot(atomicObj#35, _Rundown.alive));
    assert $read_bool($s, $dot(atomicObj#35, _Rundown.alive)) ==> $keeps($s, atomicObj#35, $int_to_ptr($mem($s, $dot(atomicObj#35, _Rundown.protected_obj))));
    assert $read_bool($s, $dot(atomicObj#35, _Rundown.alive)) ==> $keeps($s, atomicObj#35, $read_ptr($s, $dot(atomicObj#35, _Rundown.self_claim), ^^claim));
    assert $read_bool($s, $dot(atomicObj#35, _Rundown.alive)) ==> $claims_obj($read_ptr($s, $dot(atomicObj#35, _Rundown.self_claim), ^^claim), atomicObj#35);
    assert $read_bool($s, $dot(atomicObj#35, _Rundown.alive)) ==> $ref_cnt($s, $read_ptr($s, $dot(atomicObj#35, _Rundown.self_claim), ^^claim)) == $mem($s, $dot(atomicObj#35, _Rundown.count));
    assert $read_bool(beforeAtomicState#0, $dot(atomicObj#35, _Rundown.alive)) ==> $ptr_eq($read_ptr(beforeAtomicState#0, $dot(atomicObj#35, _Rundown.self_claim), ^^claim), $read_ptr($s, $dot(atomicObj#35, _Rundown.self_claim), ^^claim));
    assert !$read_bool($s, $dot(atomicObj#35, _Rundown.enabled)) ==> $mem($s, $dot(atomicObj#35, _Rundown.count)) <= $mem(beforeAtomicState#0, $dot(atomicObj#35, _Rundown.count));
    assume $full_stop_ext(#tok$1^64.21, $s);
    // _math state_t prestate#10; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#10, $state_to_int(prestate#10), ^$#state_t);
    // prestate#10 := @_vcc_current_state(@state); 
    prestate#10 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#10, $state_to_int(prestate#10), ^$#state_t);
    // _math state_t staticWrapState#8; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#8, $state_to_int(staticWrapState#8), ^$#state_t);
    // staticWrapState#8 := @_vcc_current_state(@state); 
    staticWrapState#8 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#8, $state_to_int(staticWrapState#8), ^$#state_t);
    // _math ptrset owns#9; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#9, $ptrset_to_int(owns#9), ^$#ptrset);
    // owns#9 := @_vcc_set_empty; 
    owns#9 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#9, $ptrset_to_int(owns#9), ^$#ptrset);
    // assert @writes_check((r->enabled_protector)); 
    assert $top_writable($s, #wrTime$1^43.1, $dot($ptr(^_Rundown, P#r), _Rundown.enabled_protector));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure((r->enabled_protector)), staticWrapState#8, owns#9)
    call $static_wrap($dot($ptr(^_Rundown, P#r), _Rundown.enabled_protector), staticWrapState#8, owns#9);
    assume $good_state_ext(#tok$1^73.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, (r->enabled_protector)), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $dot($ptr(^_Rundown, P#r), _Rundown.enabled_protector)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // rdi := @claim(pure(&&(*((r->enabled)), ==(*((r->protected_obj)), obj))), r, (r->enabled_protector)); 
    assert $closed($s, $ptr(^_Rundown, P#r));
    assert $top_writable($s, #wrTime$1^43.1, $ptr(^_Rundown, P#r));
    assert $is_claimable(^_Rundown);
    call $write_ref_cnt($ptr(^_Rundown, P#r), $ref_cnt($s, $ptr(^_Rundown, P#r)) + 1);
    assume $ref_cnt($s, $ptr(^_Rundown, P#r)) >= 0;
    assert $closed($s, $dot($ptr(^_Rundown, P#r), _Rundown.enabled_protector));
    assert $top_writable($s, #wrTime$1^43.1, $dot($ptr(^_Rundown, P#r), _Rundown.enabled_protector));
    assert $is_claimable(^_Protector);
    call $write_ref_cnt($dot($ptr(^_Rundown, P#r), _Rundown.enabled_protector), $ref_cnt($s, $dot($ptr(^_Rundown, P#r), _Rundown.enabled_protector)) + 1);
    assume $ref_cnt($s, $dot($ptr(^_Rundown, P#r), _Rundown.enabled_protector)) >= 0;
    claim#1s0 := $s;
    call claim#1 := $alloc_claim();
    assume $claims_obj(claim#1, $ptr(^_Rundown, P#r));
    assume $claims_obj(claim#1, $dot($ptr(^_Rundown, P#r), _Rundown.enabled_protector));
    OP#rdi := $ref(claim#1);
    assume $local_value_is($s, #tok$1^76.11, #loc.rdi, $ptr_to_int($ptr(^^claim, OP#rdi)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^76.11, #loc.rdi, $ptr(^^claim, OP#rdi), $spec_ptr_to(^^claim));
    assume $full_stop_ext(#tok$1^76.11, $s);
    assume claim#1 != $no_claim ==> $claim_initial_assumptions($s, claim#1, #tok$1^76.11);
    assert claim#1 != $no_claim ==> $read_bool($s, $dot($ptr(^_Rundown, P#r), _Rundown.enabled));
    assert claim#1 != $no_claim ==> $int_to_ptr($mem($s, $dot($ptr(^_Rundown, P#r), _Rundown.protected_obj))) == SP#obj;
    if (claim#1doAdm)
    {
      anon14:
        assume $read_bool(claim#1s1, $dot($ptr(^_Rundown, P#r), _Rundown.enabled)) && $int_to_ptr($mem(claim#1s1, $dot($ptr(^_Rundown, P#r), _Rundown.protected_obj))) == SP#obj;
        assume $valid_claim_impl(claim#1s0, claim#1s2);
        assume $claim_transitivity_assumptions(claim#1s1, claim#1s2, claim#1, #tok$1^76.11);
        assert $read_bool(claim#1s2, $dot($ptr(^_Rundown, P#r), _Rundown.enabled));
        assert $int_to_ptr($mem(claim#1s2, $dot($ptr(^_Rundown, P#r), _Rundown.protected_obj))) == SP#obj;
        assume false;
    }

  anon17:
    assume claim#1 != $no_claim ==> (forall #cs14: $state :: { $valid_claim(#cs14, claim#1) } $valid_claim(#cs14, claim#1) ==> $read_bool(#cs14, $dot($ptr(^_Rundown, P#r), _Rundown.enabled)) && $int_to_ptr($mem(#cs14, $dot($ptr(^_Rundown, P#r), _Rundown.protected_obj))) == SP#obj);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure ReferenceRundown(P#r: int, SP#rdi: int) returns (OP#res: int);
  requires true;
  requires $wrapped($s, $ptr(^^claim, SP#rdi), ^^claim);
  requires $valid_claim($s, $ptr(^^claim, SP#rdi));
  requires (forall #cs15: $state :: { $valid_claim(#cs15, $ptr(^^claim, SP#rdi)) } $valid_claim(#cs15, $ptr(^^claim, SP#rdi)) ==> $claimed_closed(#cs15, $ptr(^_Rundown, P#r)) && $read_bool(#cs15, $dot($ptr(^_Rundown, P#r), _Rundown.enabled)));
  modifies $s, $cev_pc;
  free ensures $in_range_spec_ptr($ref($ptr(^^claim, OP#res)));
  ensures $wrapped($s, $ptr(^^claim, OP#res), ^^claim) && $ref_cnt($s, $ptr(^^claim, OP#res)) == 0 && $is_fresh(old($s), $s, $ptr(^^claim, OP#res));
  ensures (forall #cs16: $state :: { $valid_claim(#cs16, $ptr(^^claim, OP#res)) } $valid_claim(#cs16, $ptr(^^claim, OP#res)) ==> $claims_obj($ptr(^^claim, OP#res), $read_ptr(#cs16, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim)) && $claimed_closed(#cs16, $ptr(^_Rundown, P#r)) && $claimed_closed(#cs16, $int_to_ptr($mem(#cs16, $by_claim(#cs16, $ptr(^^claim, SP#rdi), $ptr(^_Rundown, P#r), $dot($ptr(^_Rundown, P#r), _Rundown.protected_obj))))) && $mem(#cs16, $dot($ptr(^_Rundown, P#r), _Rundown.count)) > 0);
  ensures $wrapped($s, $ptr(^^claim, SP#rdi), ^^claim) && $valid_claim($s, $ptr(^^claim, SP#rdi));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation ReferenceRundown(P#r: int, SP#rdi: int) returns (OP#res: int)
{
  var claim#2doAdm: bool;
  var claim#2s2: $state;
  var claim#2s1: $state;
  var claim#2s0: $state;
  var claim#2: $ptr;
  var stmtexpr0#33: int where $in_range_u4(stmtexpr0#33);
  var res#2: int where $in_range_u4(res#2);
  var p#1: int where $in_range_phys_ptr(p#1);
  var beforeAtomicState#1: $state;
  var atomicObj#36: $ptr;
  var SL#c: int where $in_range_spec_ptr(SL#c);
  var #wrTime$1^80.1: int;
  var #stackframe: int;

  anon19:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^80.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^80.1, #loc.r, $ptr_to_int($ptr(^_Rundown, P#r)), $ptr_to(^_Rundown)) && $local_value_is_ptr($s, #tok$1^80.1, #loc.r, $ptr(^_Rundown, P#r), $ptr_to(^_Rundown));
    assume $local_value_is($s, #tok$1^80.1, #loc.rdi, $ptr_to_int($ptr(^^claim, SP#rdi)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^80.1, #loc.rdi, $ptr(^^claim, SP#rdi), $spec_ptr_to(^^claim));
    assume #wrTime$1^80.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^80.1, #p) } $in_writes_at(#wrTime$1^80.1, #p) == false);
    // assume @in_range_phys_ptr((mathint)r); 
    assume $in_range_phys_ptr($ref($ptr(^_Rundown, P#r)));
    // assume @in_range_spec_ptr((mathint)rdi); 
    assume $in_range_spec_ptr($ref($ptr(^^claim, SP#rdi)));
    // assume @in_range_spec_ptr((mathint)res); 
    assume $in_range_spec_ptr($ref($ptr(^^claim, OP#res)));
    // assert @_vcc_valid_claim(@state, rdi); 
    assert $valid_claim($s, $ptr(^^claim, SP#rdi));
    // assert @_vcc_in_domain(@state, rdi, rdi); 
    assert $in_domain_lab($s, $ptr(^^claim, SP#rdi), $ptr(^^claim, SP#rdi), l#public);
    // claim_t^ c; 
    assume $local_value_is($s, #tok$1^88.26, #loc.c, $ptr_to_int($ptr(^^claim, SL#c)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^88.26, #loc.c, $ptr(^^claim, SL#c), $spec_ptr_to(^^claim));
    // var spec claim_t^ c
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^90.19, $s);
    atomicObj#36 := $ptr(^_Rundown, P#r);
    assert $valid_claim($s, $ptr(^^claim, SP#rdi));
    assert $closed($s, atomicObj#36);
    assume $inv($s, atomicObj#36, ^_Rundown);
    beforeAtomicState#1 := $s;
    assume claim#2 == $no_claim;
    // assume <(*((r->count)), 4294967295); 
    assume $mem($s, $dot($ptr(^_Rundown, P#r), _Rundown.count)) < 4294967295;
    // uint32_t* p#1; 
    assume $local_value_is($s, #tok$1^92.26, #loc.p#1, $ptr_to_int($ptr(^^u4, p#1)), $ptr_to(^^u4)) && $local_value_is_ptr($s, #tok$1^92.26, #loc.p#1, $ptr(^^u4, p#1), $ptr_to(^^u4));
    // p#1 := (r->count); 
    p#1 := $ref($dot($ptr(^_Rundown, P#r), _Rundown.count));
    assume $local_value_is($s, #tok$1^92.26, #loc.p#1, $ptr_to_int($ptr(^^u4, p#1)), $ptr_to(^^u4)) && $local_value_is_ptr($s, #tok$1^92.26, #loc.p#1, $ptr(^^u4, p#1), $ptr_to(^^u4));
    // uint32_t res#2; 
    assume $local_value_is($s, #tok$1^92.5, #loc.res#2, res#2, ^^u4);
    // assert @_vcc_typed2(@state, p#1); 
    assert $typed2($s, $ptr(^^u4, p#1), ^^u4);
    // assert @prim_writes_check(p#1); 
    assert $set_in($ptr(^^u4, p#1), $volatile_span($s, atomicObj#36)) || $writable($s, #wrTime$1^80.1, $ptr(^^u4, p#1));
    // assert @in_range_u4(+(*(p#1), 1)); 
    assert $in_range_u4($mem($s, $ptr(^^u4, p#1)) + 1);
    // assert @reads_check_normal(p#1); 
    assert $typed2($s, $ptr(^^u4, p#1), ^^u4);
    assert $thread_local2($s, $ptr(^^u4, p#1), ^^u4) || $set_in($ptr(^^u4, p#1), $span(atomicObj#36));
    // *p#1 := +(*(p#1), 1); 
    call $write_int($ptr(^^u4, p#1), $mem($s, $ptr(^^u4, p#1)) + 1);
    assume $good_state_ext(#tok$1^92.26, $s);
    // assert @reads_check_normal(p#1); 
    assert $typed2($s, $ptr(^^u4, p#1), ^^u4);
    assert $thread_local2($s, $ptr(^^u4, p#1), ^^u4) || $set_in($ptr(^^u4, p#1), $span(atomicObj#36));
    // res#2 := *(p#1); 
    res#2 := $mem($s, $ptr(^^u4, p#1));
    assume $local_value_is($s, #tok$1^6.3, #loc.res#2, res#2, ^^u4);
    // empty
    // uint32_t stmtexpr0#33; 
    assume $local_value_is($s, #tok$1^92.5, #loc.stmtexpr0#33, stmtexpr0#33, ^^u4);
    // stmtexpr0#33 := res#2; 
    stmtexpr0#33 := res#2;
    assume $local_value_is($s, #tok$1^92.5, #loc.stmtexpr0#33, stmtexpr0#33, ^^u4);
    // assert @reads_check_normal((r->self_claim)); 
    assert $typed2($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), $spec_ptr_to(^^claim));
    assert $mutable($s, $ptr(^_Rundown, P#r)) || $ptr(^_Rundown, P#r) == atomicObj#36;
    // res := @claim(pure(&&(&&(>(*((r->count)), 0), @_vcc_closed(@state, *((r->protected_obj)))), @_vcc_ptr_eq(pure(old(@_vcc_when_claimed, *((r->self_claim)))), *((r->self_claim))))), *((r->self_claim))); 
    assert $closed($s, $read_ptr($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim));
    assert $top_writable($s, #wrTime$1^80.1, $read_ptr($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim)) || $owner($s, $read_ptr($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim)) == atomicObj#36;
    assert $is_claimable(^^claim);
    call $write_ref_cnt($read_ptr($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim), $ref_cnt($s, $read_ptr($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim)) + 1);
    assume $ref_cnt($s, $read_ptr($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim)) >= 0;
    claim#2s0 := $s;
    call claim#2 := $alloc_claim();
    assume $claims_obj(claim#2, $read_ptr($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim));
    OP#res := $ref(claim#2);
    assume $local_value_is($s, #tok$1^93.34, #loc.res, $ptr_to_int($ptr(^^claim, OP#res)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^93.34, #loc.res, $ptr(^^claim, OP#res), $spec_ptr_to(^^claim));
    assume $good_state_ext(#tok$1^93.34, $s);
    assume claim#2 != $no_claim ==> $claim_initial_assumptions($s, claim#2, #tok$1^93.34);
    assert claim#2 != $no_claim ==> $mem($s, $dot($ptr(^_Rundown, P#r), _Rundown.count)) > 0;
    assert claim#2 != $no_claim ==> $claimed_closed($s, $int_to_ptr($mem($s, $dot($ptr(^_Rundown, P#r), _Rundown.protected_obj))));
    assert claim#2 != $no_claim ==> $ptr_eq($read_ptr($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim), $read_ptr($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim));
    if (claim#2 != $no_claim && claim#2doAdm)
    {
      anon18:
        assume $mem(claim#2s1, $dot($ptr(^_Rundown, P#r), _Rundown.count)) > 0 && $claimed_closed(claim#2s1, $int_to_ptr($mem(claim#2s1, $dot($ptr(^_Rundown, P#r), _Rundown.protected_obj)))) && $ptr_eq($read_ptr($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim), $read_ptr(claim#2s1, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim));
        assume $valid_claim_impl(claim#2s0, claim#2s2);
        assume $claim_transitivity_assumptions(claim#2s1, claim#2s2, claim#2, #tok$1^93.34);
        assert $mem(claim#2s2, $dot($ptr(^_Rundown, P#r), _Rundown.count)) > 0;
        assert $claimed_closed(claim#2s2, $int_to_ptr($mem(claim#2s2, $dot($ptr(^_Rundown, P#r), _Rundown.protected_obj))));
        assert $ptr_eq($read_ptr($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim), $read_ptr(claim#2s2, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim));
        assume false;
    }

  anon20:
    assume claim#2 != $no_claim ==> (forall #cs17: $state :: { $valid_claim(#cs17, claim#2) } $valid_claim(#cs17, claim#2) ==> $mem(#cs17, $dot($ptr(^_Rundown, P#r), _Rundown.count)) > 0 && $claimed_closed(#cs17, $int_to_ptr($mem(#cs17, $dot($ptr(^_Rundown, P#r), _Rundown.protected_obj)))) && $ptr_eq($read_ptr($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim), $read_ptr(#cs17, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim)));
    assert $closed(beforeAtomicState#1, $dot(atomicObj#36, _Rundown.enabled_protector)) ==> $read_bool(beforeAtomicState#1, $dot(atomicObj#36, _Rundown.enabled)) == $read_bool($s, $dot(atomicObj#36, _Rundown.enabled));
    assert $closed(beforeAtomicState#1, $dot(atomicObj#36, _Rundown.enabled_protector)) ==> $read_bool(beforeAtomicState#1, $dot(atomicObj#36, _Rundown.alive)) == $read_bool($s, $dot(atomicObj#36, _Rundown.alive));
    assert !$read_bool($s, $dot(atomicObj#36, _Rundown.alive)) ==> !$read_bool($s, $dot(atomicObj#36, _Rundown.enabled));
    assert !$read_bool($s, $dot(atomicObj#36, _Rundown.alive)) ==> $mem($s, $dot(atomicObj#36, _Rundown.count)) == 0;
    assert $mem(beforeAtomicState#1, $dot(atomicObj#36, _Rundown.count)) > 0 && $read_bool(beforeAtomicState#1, $dot(atomicObj#36, _Rundown.alive)) ==> $read_bool($s, $dot(atomicObj#36, _Rundown.alive));
    assert $read_bool($s, $dot(atomicObj#36, _Rundown.alive)) ==> $keeps($s, atomicObj#36, $int_to_ptr($mem($s, $dot(atomicObj#36, _Rundown.protected_obj))));
    assert $read_bool($s, $dot(atomicObj#36, _Rundown.alive)) ==> $keeps($s, atomicObj#36, $read_ptr($s, $dot(atomicObj#36, _Rundown.self_claim), ^^claim));
    assert $read_bool($s, $dot(atomicObj#36, _Rundown.alive)) ==> $claims_obj($read_ptr($s, $dot(atomicObj#36, _Rundown.self_claim), ^^claim), atomicObj#36);
    assert $read_bool($s, $dot(atomicObj#36, _Rundown.alive)) ==> $ref_cnt($s, $read_ptr($s, $dot(atomicObj#36, _Rundown.self_claim), ^^claim)) == $mem($s, $dot(atomicObj#36, _Rundown.count));
    assert $read_bool(beforeAtomicState#1, $dot(atomicObj#36, _Rundown.alive)) ==> $ptr_eq($read_ptr(beforeAtomicState#1, $dot(atomicObj#36, _Rundown.self_claim), ^^claim), $read_ptr($s, $dot(atomicObj#36, _Rundown.self_claim), ^^claim));
    assert !$read_bool($s, $dot(atomicObj#36, _Rundown.enabled)) ==> $mem($s, $dot(atomicObj#36, _Rundown.count)) <= $mem(beforeAtomicState#1, $dot(atomicObj#36, _Rundown.count));
    assume $full_stop_ext(#tok$1^90.19, $s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure DereferenceRundown(P#r: int, SP#h: int);
  requires true;
  requires $wrapped($s, $ptr(^^claim, SP#h), ^^claim);
  requires $ref_cnt($s, $ptr(^^claim, SP#h)) == 0;
  requires (forall #cs18: $state :: { $valid_claim(#cs18, $ptr(^^claim, SP#h)) } $valid_claim(#cs18, $ptr(^^claim, SP#h)) ==> $claims_obj($ptr(^^claim, SP#h), $read_ptr(#cs18, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim)) && $claimed_closed(#cs18, $ptr(^_Rundown, P#r)) && $mem(#cs18, $dot($ptr(^_Rundown, P#r), _Rundown.count)) > 0);
  modifies $s, $cev_pc;
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^^claim, SP#h) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^^claim, SP#h) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^^claim, SP#h) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation DereferenceRundown(P#r: int, SP#h: int)
{
  var stmtexpr0#34: int where $in_range_u4(stmtexpr0#34);
  var res#4: int where $in_range_u4(res#4);
  var p#3: int where $in_range_phys_ptr(p#3);
  var beforeAtomicState#2: $state;
  var atomicObj#37: $ptr;
  var #wrTime$1^97.1: int;
  var #stackframe: int;

  anon21:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^97.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^97.1, #loc.r, $ptr_to_int($ptr(^_Rundown, P#r)), $ptr_to(^_Rundown)) && $local_value_is_ptr($s, #tok$1^97.1, #loc.r, $ptr(^_Rundown, P#r), $ptr_to(^_Rundown));
    assume $local_value_is($s, #tok$1^97.1, #loc.h, $ptr_to_int($ptr(^^claim, SP#h)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^97.1, #loc.h, $ptr(^^claim, SP#h), $spec_ptr_to(^^claim));
    assume #wrTime$1^97.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^97.1, #p) } $in_writes_at(#wrTime$1^97.1, #p) == (#p == $ptr(^^claim, SP#h)));
    assume $thread_owned($s, $ptr(^^claim, SP#h));
    // assume @in_range_phys_ptr((mathint)r); 
    assume $in_range_phys_ptr($ref($ptr(^_Rundown, P#r)));
    // assume @in_range_spec_ptr((mathint)h); 
    assume $in_range_spec_ptr($ref($ptr(^^claim, SP#h)));
    // assert @_vcc_valid_claim(@state, h); 
    assert $valid_claim($s, $ptr(^^claim, SP#h));
    // assert @_vcc_in_domain(@state, h, h); 
    assert $in_domain_lab($s, $ptr(^^claim, SP#h), $ptr(^^claim, SP#h), l#public);
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^103.19, $s);
    atomicObj#37 := $ptr(^_Rundown, P#r);
    assert $valid_claim($s, $ptr(^^claim, SP#h));
    assert $closed($s, atomicObj#37);
    assume $inv($s, atomicObj#37, ^_Rundown);
    beforeAtomicState#2 := $s;
    // assert @reads_check_normal((r->self_claim)); 
    assert $typed2($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), $spec_ptr_to(^^claim));
    assert $mutable($s, $ptr(^_Rundown, P#r)) || $ptr(^_Rundown, P#r) == atomicObj#37;
    // stmt @unclaim(h, *((r->self_claim))); 
    assert $top_writable($s, #wrTime$1^97.1, $ptr(^^claim, SP#h));
    call $unclaim($ptr(^^claim, SP#h));
    assert $claims_obj($ptr(^^claim, SP#h), $read_ptr($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim));
    assert $top_writable($s, #wrTime$1^97.1, $read_ptr($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim)) || $owner($s, $read_ptr($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim)) == atomicObj#37;
    assert $is_claimable(^^claim);
    call $write_ref_cnt($read_ptr($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim), $ref_cnt($s, $read_ptr($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim)) - 1);
    assume $ref_cnt($s, $read_ptr($s, $dot($ptr(^_Rundown, P#r), _Rundown.self_claim), ^^claim)) >= 0;
    assume $good_state_ext(#tok$1^104.27, $s);
    // empty
    // uint32_t* p#3; 
    assume $local_value_is($s, #tok$1^105.26, #loc.p#3, $ptr_to_int($ptr(^^u4, p#3)), $ptr_to(^^u4)) && $local_value_is_ptr($s, #tok$1^105.26, #loc.p#3, $ptr(^^u4, p#3), $ptr_to(^^u4));
    // p#3 := (r->count); 
    p#3 := $ref($dot($ptr(^_Rundown, P#r), _Rundown.count));
    assume $local_value_is($s, #tok$1^105.26, #loc.p#3, $ptr_to_int($ptr(^^u4, p#3)), $ptr_to(^^u4)) && $local_value_is_ptr($s, #tok$1^105.26, #loc.p#3, $ptr(^^u4, p#3), $ptr_to(^^u4));
    // uint32_t res#4; 
    assume $local_value_is($s, #tok$1^105.5, #loc.res#4, res#4, ^^u4);
    // assert @_vcc_typed2(@state, p#3); 
    assert $typed2($s, $ptr(^^u4, p#3), ^^u4);
    // assert @prim_writes_check(p#3); 
    assert $set_in($ptr(^^u4, p#3), $volatile_span($s, atomicObj#37)) || $writable($s, #wrTime$1^97.1, $ptr(^^u4, p#3));
    // assert @in_range_u4(-(*(p#3), 1)); 
    assert $in_range_u4($mem($s, $ptr(^^u4, p#3)) - 1);
    // assert @reads_check_normal(p#3); 
    assert $typed2($s, $ptr(^^u4, p#3), ^^u4);
    assert $thread_local2($s, $ptr(^^u4, p#3), ^^u4) || $set_in($ptr(^^u4, p#3), $span(atomicObj#37));
    // *p#3 := -(*(p#3), 1); 
    call $write_int($ptr(^^u4, p#3), $mem($s, $ptr(^^u4, p#3)) - 1);
    assume $good_state_ext(#tok$1^105.26, $s);
    // assert @reads_check_normal(p#3); 
    assert $typed2($s, $ptr(^^u4, p#3), ^^u4);
    assert $thread_local2($s, $ptr(^^u4, p#3), ^^u4) || $set_in($ptr(^^u4, p#3), $span(atomicObj#37));
    // res#4 := *(p#3); 
    res#4 := $mem($s, $ptr(^^u4, p#3));
    assume $local_value_is($s, #tok$1^11.3, #loc.res#4, res#4, ^^u4);
    // empty
    // uint32_t stmtexpr0#34; 
    assume $local_value_is($s, #tok$1^105.5, #loc.stmtexpr0#34, stmtexpr0#34, ^^u4);
    // stmtexpr0#34 := res#4; 
    stmtexpr0#34 := res#4;
    assume $local_value_is($s, #tok$1^105.5, #loc.stmtexpr0#34, stmtexpr0#34, ^^u4);
    assert $closed(beforeAtomicState#2, $dot(atomicObj#37, _Rundown.enabled_protector)) ==> $read_bool(beforeAtomicState#2, $dot(atomicObj#37, _Rundown.enabled)) == $read_bool($s, $dot(atomicObj#37, _Rundown.enabled));
    assert $closed(beforeAtomicState#2, $dot(atomicObj#37, _Rundown.enabled_protector)) ==> $read_bool(beforeAtomicState#2, $dot(atomicObj#37, _Rundown.alive)) == $read_bool($s, $dot(atomicObj#37, _Rundown.alive));
    assert !$read_bool($s, $dot(atomicObj#37, _Rundown.alive)) ==> !$read_bool($s, $dot(atomicObj#37, _Rundown.enabled));
    assert !$read_bool($s, $dot(atomicObj#37, _Rundown.alive)) ==> $mem($s, $dot(atomicObj#37, _Rundown.count)) == 0;
    assert $mem(beforeAtomicState#2, $dot(atomicObj#37, _Rundown.count)) > 0 && $read_bool(beforeAtomicState#2, $dot(atomicObj#37, _Rundown.alive)) ==> $read_bool($s, $dot(atomicObj#37, _Rundown.alive));
    assert $read_bool($s, $dot(atomicObj#37, _Rundown.alive)) ==> $keeps($s, atomicObj#37, $int_to_ptr($mem($s, $dot(atomicObj#37, _Rundown.protected_obj))));
    assert $read_bool($s, $dot(atomicObj#37, _Rundown.alive)) ==> $keeps($s, atomicObj#37, $read_ptr($s, $dot(atomicObj#37, _Rundown.self_claim), ^^claim));
    assert $read_bool($s, $dot(atomicObj#37, _Rundown.alive)) ==> $claims_obj($read_ptr($s, $dot(atomicObj#37, _Rundown.self_claim), ^^claim), atomicObj#37);
    assert $read_bool($s, $dot(atomicObj#37, _Rundown.alive)) ==> $ref_cnt($s, $read_ptr($s, $dot(atomicObj#37, _Rundown.self_claim), ^^claim)) == $mem($s, $dot(atomicObj#37, _Rundown.count));
    assert $read_bool(beforeAtomicState#2, $dot(atomicObj#37, _Rundown.alive)) ==> $ptr_eq($read_ptr(beforeAtomicState#2, $dot(atomicObj#37, _Rundown.self_claim), ^^claim), $read_ptr($s, $dot(atomicObj#37, _Rundown.self_claim), ^^claim));
    assert !$read_bool($s, $dot(atomicObj#37, _Rundown.enabled)) ==> $mem($s, $dot(atomicObj#37, _Rundown.count)) <= $mem(beforeAtomicState#2, $dot(atomicObj#37, _Rundown.count));
    assume $full_stop_ext(#tok$1^103.19, $s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure InitializeRundownContainer(P#rsc: int, P#cont: int);
  requires $mutable($s, $dot($dot($ptr(^_Resource, P#rsc), _Resource.rd), _Rundown.enabled_protector));
  requires $wrapped($s, $ptr(^_Resource, P#rsc), ^_Resource);
  modifies $s, $cev_pc;
  ensures $wrapped($s, $ptr(^_RundownContainer, P#cont), ^_RundownContainer);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $span($ptr(^_RundownContainer, P#cont))) || #p == $ptr(^_Resource, P#rsc) || $set_in(#p, $extent(old($s), $dot($ptr(^_Resource, P#rsc), _Resource.rd))) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $span($ptr(^_RundownContainer, P#cont))) || #p == $ptr(^_Resource, P#rsc) || $set_in(#p, $extent(old($s), $dot($ptr(^_Resource, P#rsc), _Resource.rd))) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $span($ptr(^_RundownContainer, P#cont))) || #p == $ptr(^_Resource, P#rsc) || $set_in(#p, $extent(old($s), $dot($ptr(^_Resource, P#rsc), _Resource.rd))) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation InitializeRundownContainer(P#rsc: int, P#cont: int)
{
  var owns#12: $ptrset;
  var staticWrapState#11: $state;
  var prestate#13: $state;
  var outpar#6: int where $in_range_spec_ptr(outpar#6);
  var #wrTime$1^133.1: int;
  var #stackframe: int;

  anon22:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^133.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^133.1, #loc.rsc, $ptr_to_int($ptr(^_Resource, P#rsc)), $ptr_to(^_Resource)) && $local_value_is_ptr($s, #tok$1^133.1, #loc.rsc, $ptr(^_Resource, P#rsc), $ptr_to(^_Resource));
    assume $local_value_is($s, #tok$1^133.1, #loc.cont, $ptr_to_int($ptr(^_RundownContainer, P#cont)), $ptr_to(^_RundownContainer)) && $local_value_is_ptr($s, #tok$1^133.1, #loc.cont, $ptr(^_RundownContainer, P#cont), $ptr_to(^_RundownContainer));
    assume #wrTime$1^133.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^133.1, #p) } $in_writes_at(#wrTime$1^133.1, #p) == ($set_in(#p, $span($ptr(^_RundownContainer, P#cont))) || #p == $ptr(^_Resource, P#rsc) || $set_in(#p, $extent($s, $dot($ptr(^_Resource, P#rsc), _Resource.rd)))));
    assume (forall #p: $ptr :: { $extent_hint(#p, $ptr(^_RundownContainer, P#cont)) } $set_in(#p, $span($ptr(^_RundownContainer, P#cont))) ==> $mutable($s, #p));
    assume $thread_owned($s, $ptr(^_Resource, P#rsc));
    assume (forall #p: $ptr :: { $extent_hint(#p, $dot($ptr(^_Resource, P#rsc), _Resource.rd)) } $set_in(#p, $extent($s, $dot($ptr(^_Resource, P#rsc), _Resource.rd))) ==> $mutable($s, #p));
    // assume @in_range_phys_ptr((mathint)rsc); 
    assume $in_range_phys_ptr($ref($ptr(^_Resource, P#rsc)));
    // assume @in_range_phys_ptr((mathint)cont); 
    assume $in_range_phys_ptr($ref($ptr(^_RundownContainer, P#cont)));
    // assert @_vcc_in_domain(@state, rsc, rsc); 
    assert $in_domain_lab($s, $ptr(^_Resource, P#rsc), $ptr(^_Resource, P#rsc), l#public);
    // assert @_vcc_typed2(@state, (cont->rsc)); 
    assert $typed2($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), $ptr_to(^_Resource));
    // assert @prim_writes_check((cont->rsc)); 
    assert $writable($s, #wrTime$1^133.1, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc));
    // *(cont->rsc) := rsc; 
    call $write_int($dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), $ref($ptr(^_Resource, P#rsc)));
    assume $full_stop_ext(#tok$1^139.3, $s);
    // claim_t^ outpar#6; 
    assume $local_value_is($s, #tok$2^0.0, #loc.outpar#6, $ptr_to_int($ptr(^^claim, outpar#6)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$2^0.0, #loc.outpar#6, $ptr(^^claim, outpar#6), $spec_ptr_to(^^claim));
    // assert @writes_check(@_vcc_extent(@state, (rsc->rd))); 
    assert (forall #writes$1^140.3: $ptr :: { $dont_instantiate(#writes$1^140.3) } $set_in(#writes$1^140.3, $extent($s, $dot($ptr(^_Resource, P#rsc), _Resource.rd))) ==> $top_writable($s, #wrTime$1^133.1, #writes$1^140.3));
    // assert @writes_check(rsc); 
    assert $top_writable($s, #wrTime$1^133.1, $ptr(^_Resource, P#rsc));
    // outpar#6 := InitializeRundown((rsc->rd), rsc); 
    call outpar#6 := InitializeRundown($ref($dot($ptr(^_Resource, P#rsc), _Resource.rd)), $ptr(^_Resource, P#rsc));
    assume $full_stop_ext(#tok$1^140.3, $s);
    assume $local_value_is($s, #tok$1^140.3, #loc.outpar#6, $ptr_to_int($ptr(^^claim, outpar#6)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^140.3, #loc.outpar#6, $ptr(^^claim, outpar#6), $spec_ptr_to(^^claim));
    // assert @_vcc_typed2(@state, (cont->rd_claim)); 
    assert $typed2($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), $spec_ptr_to(^^claim));
    // assert @prim_writes_check((cont->rd_claim)); 
    assert $writable($s, #wrTime$1^133.1, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim));
    // *(cont->rd_claim) := outpar#6; 
    call $write_int($dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), $ref($ptr(^^claim, outpar#6)));
    assume $full_stop_ext(#tok$1^140.77, $s);
    // assert @_vcc_typed2(@state, (cont->enabled)); 
    assert $typed2($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.enabled), ^^bool);
    // assert @prim_writes_check((cont->enabled)); 
    assert $writable($s, #wrTime$1^133.1, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.enabled));
    // *(cont->enabled) := true; 
    call $write_int($dot($ptr(^_RundownContainer, P#cont), _RundownContainer.enabled), $bool_to_int(true));
    assume $full_stop_ext(#tok$1^141.3, $s);
    // _math state_t prestate#13; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#13, $state_to_int(prestate#13), ^$#state_t);
    // prestate#13 := @_vcc_current_state(@state); 
    prestate#13 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#13, $state_to_int(prestate#13), ^$#state_t);
    // _math state_t staticWrapState#11; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#11, $state_to_int(staticWrapState#11), ^$#state_t);
    // staticWrapState#11 := @_vcc_current_state(@state); 
    staticWrapState#11 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#11, $state_to_int(staticWrapState#11), ^$#state_t);
    // _math ptrset owns#12; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#12, $ptrset_to_int(owns#12), ^$#ptrset);
    // owns#12 := @_vcc_set_empty; 
    owns#12 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#12, $ptrset_to_int(owns#12), ^$#ptrset);
    // assert @writes_check(cont); 
    assert $top_writable($s, #wrTime$1^133.1, $ptr(^_RundownContainer, P#cont));
    // assert @_vcc_wrapped(@state, ((*((cont->rsc))->rd)->enabled_protector)); 
    assert $wrapped($s, $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector), ^_Protector);
    // assert @writes_check(((*((cont->rsc))->rd)->enabled_protector)); 
    assert $top_writable($s, #wrTime$1^133.1, $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector));
    // owns#12 := pure(@_vcc_set_union(owns#12, @_vcc_set_singleton(((*((cont->rsc))->rd)->enabled_protector)))); 
    owns#12 := $set_union(owns#12, $set_singleton($dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#12, $ptrset_to_int(owns#12), ^$#ptrset);
    // staticWrapState#11 := pure(@_vcc_take_over(staticWrapState#11, cont, ((*((cont->rsc))->rd)->enabled_protector))); 
    staticWrapState#11 := $take_over(staticWrapState#11, $ptr(^_RundownContainer, P#cont), $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#11, $state_to_int(staticWrapState#11), ^$#state_t);
    // assert @_vcc_wrapped(@state, (*((cont->rsc))->rd)); 
    assert $wrapped($s, $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), ^_Rundown);
    // assert @writes_check((*((cont->rsc))->rd)); 
    assert $top_writable($s, #wrTime$1^133.1, $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd));
    // owns#12 := pure(@_vcc_set_union(owns#12, @_vcc_set_singleton((*((cont->rsc))->rd)))); 
    owns#12 := $set_union(owns#12, $set_singleton($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#12, $ptrset_to_int(owns#12), ^$#ptrset);
    // staticWrapState#11 := pure(@_vcc_take_over(staticWrapState#11, cont, (*((cont->rsc))->rd))); 
    staticWrapState#11 := $take_over(staticWrapState#11, $ptr(^_RundownContainer, P#cont), $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#11, $state_to_int(staticWrapState#11), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((cont->rd_claim))); 
    assert $wrapped($s, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim), ^^claim);
    // assert @writes_check(*((cont->rd_claim))); 
    assert $top_writable($s, #wrTime$1^133.1, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim));
    // owns#12 := pure(@_vcc_set_union(owns#12, @_vcc_set_singleton(*((cont->rd_claim))))); 
    owns#12 := $set_union(owns#12, $set_singleton($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#12, $ptrset_to_int(owns#12), ^$#ptrset);
    // staticWrapState#11 := pure(@_vcc_take_over(staticWrapState#11, cont, *((cont->rd_claim)))); 
    staticWrapState#11 := $take_over(staticWrapState#11, $ptr(^_RundownContainer, P#cont), $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#11, $state_to_int(staticWrapState#11), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(cont), staticWrapState#11, owns#12)
    call $static_wrap($ptr(^_RundownContainer, P#cont), staticWrapState#11, owns#12);
    assume $good_state_ext(#tok$1^143.19, $s);
    // assert @inv_check(@keeps_stable(old(prestate#13, *((cont->rd_claim))), *((cont->rd_claim)))); 
    assert $read_ptr(prestate#13, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim) == $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim);
    // assert @inv_check(@keeps(cont, *((cont->rd_claim)))); 
    assert $keeps($s, $ptr(^_RundownContainer, P#cont), $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim));
    // assert @inv_check(@keeps_stable(old(prestate#13, (*((cont->rsc))->rd)), (*((cont->rsc))->rd))); 
    assert $dot($read_ptr(prestate#13, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd) == $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd);
    // assert @inv_check(@keeps(cont, (*((cont->rsc))->rd))); 
    assert $keeps($s, $ptr(^_RundownContainer, P#cont), $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd));
    // assert @inv_check(@keeps_stable(old(prestate#13, ((*((cont->rsc))->rd)->enabled_protector)), ((*((cont->rsc))->rd)->enabled_protector))); 
    assert $dot($dot($read_ptr(prestate#13, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector) == $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector);
    // assert @inv_check(@keeps(cont, ((*((cont->rsc))->rd)->enabled_protector))); 
    assert $keeps($s, $ptr(^_RundownContainer, P#cont), $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector));
    // assert @inv_check(@_vcc_claims_obj(*((cont->rd_claim)), (*((cont->rsc))->rd))); 
    assert $claims_obj($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim), $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd));
    // assert @inv_check(@_vcc_claims_obj(*((cont->rd_claim)), ((*((cont->rsc))->rd)->enabled_protector))); 
    assert $claims_obj($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim), $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector));
    // assert @inv_check(==(@_vcc_ref_cnt(@state, ((*((cont->rsc))->rd)->enabled_protector)), 1)); 
    assert $ref_cnt($s, $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector)) == 1;
    // assert @inv_check(==(@_vcc_ref_cnt(@state, (*((cont->rsc))->rd)), 2)); 
    assert $ref_cnt($s, $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd)) == 2;
    // assert @inv_check(==(@_vcc_ref_cnt(@state, *((cont->rd_claim))), 0)); 
    assert $ref_cnt($s, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)) == 0;
    // assert @inv_check(@_vcc_claims(*((cont->rd_claim)), ==(*(((old(@_vcc_when_claimed, *((cont->rsc)))->rd)->enabled)), old(@_vcc_when_claimed, *((cont->enabled)))))); 
    assert (forall #cs19: $state :: { $valid_claim(#cs19, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)) } $valid_claim(#cs19, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)) ==> $read_bool(#cs19, $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled)) == $read_bool($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.enabled)));
    // assert @inv_check(@_vcc_claims(*((cont->rd_claim)), *(((old(@_vcc_when_claimed, *((cont->rsc)))->rd)->alive)))); 
    assert (forall #cs20: $state :: { $valid_claim(#cs20, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)) } $valid_claim(#cs20, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)) ==> $read_bool(#cs20, $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.alive)));
    // assert @inv_check(@_vcc_claims(*((cont->rd_claim)), ==(*(((old(@_vcc_when_claimed, *((cont->rsc)))->rd)->protected_obj)), old(@_vcc_when_claimed, *((cont->rsc)))))); 
    assert (forall #cs21: $state :: { $valid_claim(#cs21, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)) } $valid_claim(#cs21, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)) ==> $int_to_ptr($mem(#cs21, $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.protected_obj))) == $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure FinalizeRundownContainer(P#cont: int);
  requires $read_bool($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.enabled));
  requires $wrapped($s, $ptr(^_RundownContainer, P#cont), ^_RundownContainer);
  modifies $s, $cev_pc;
  ensures !$read_bool($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.enabled));
  ensures $wrapped($s, $ptr(^_RundownContainer, P#cont), ^_RundownContainer);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^_RundownContainer, P#cont) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^_RundownContainer, P#cont) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^_RundownContainer, P#cont) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation FinalizeRundownContainer(P#cont: int)
{
  var owns#24: $ptrset;
  var staticWrapState#23: $state;
  var prestate#25: $state;
  var claim#3doAdm: bool;
  var claim#3s2: $state;
  var claim#3s1: $state;
  var claim#3s0: $state;
  var claim#3: $ptr;
  var owns#21: $ptrset;
  var staticWrapState#20: $state;
  var prestate#22: $state;
  var beforeAtomicState#3: $state;
  var prestate#19: $state;
  var prestate#17: $state;
  var owns#18: $ptrset;
  var atomicObj#38: $ptr;
  var prestate#16: $state;
  var prestate#14: $state;
  var owns#15: $ptrset;
  var SL#tmp: int where $in_range_spec_ptr(SL#tmp);
  var SL#rd: int where $in_range_phys_ptr(SL#rd);
  var #wrTime$1^146.1: int;
  var #stackframe: int;

  anon24:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^146.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^146.1, #loc.cont, $ptr_to_int($ptr(^_RundownContainer, P#cont)), $ptr_to(^_RundownContainer)) && $local_value_is_ptr($s, #tok$1^146.1, #loc.cont, $ptr(^_RundownContainer, P#cont), $ptr_to(^_RundownContainer));
    assume #wrTime$1^146.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^146.1, #p) } $in_writes_at(#wrTime$1^146.1, #p) == (#p == $ptr(^_RundownContainer, P#cont)));
    assume $thread_owned($s, $ptr(^_RundownContainer, P#cont));
    // assume @in_range_phys_ptr((mathint)cont); 
    assume $in_range_phys_ptr($ref($ptr(^_RundownContainer, P#cont)));
    // assert @_vcc_in_domain(@state, cont, cont); 
    assert $in_domain_lab($s, $ptr(^_RundownContainer, P#cont), $ptr(^_RundownContainer, P#cont), l#public);
    // struct _Rundown* rd; 
    assume $local_value_is($s, #tok$1^153.25, #loc.rd, $ptr_to_int($ptr(^_Rundown, SL#rd)), $ptr_to(^_Rundown)) && $local_value_is_ptr($s, #tok$1^153.25, #loc.rd, $ptr(^_Rundown, SL#rd), $ptr_to(^_Rundown));
    // claim_t^ tmp; 
    assume $local_value_is($s, #tok$1^152.25, #loc.tmp, $ptr_to_int($ptr(^^claim, SL#tmp)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^152.25, #loc.tmp, $ptr(^^claim, SL#tmp), $spec_ptr_to(^^claim));
    // var spec claim_t^ tmp
    // var spec struct _Rundown* rd
    // _math ptrset owns#15; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#15, $ptrset_to_int(owns#15), ^$#ptrset);
    // owns#15 := @_vcc_set_empty; 
    owns#15 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#15, $ptrset_to_int(owns#15), ^$#ptrset);
    // _math state_t prestate#14; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#14, $state_to_int(prestate#14), ^$#state_t);
    // prestate#14 := @_vcc_current_state(@state); 
    prestate#14 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#14, $state_to_int(prestate#14), ^$#state_t);
    // _math state_t prestate#16; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#16, $state_to_int(prestate#16), ^$#state_t);
    // prestate#16 := @_vcc_current_state(@state); 
    prestate#16 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#16, $state_to_int(prestate#16), ^$#state_t);
    // assert @_vcc_wrapped(@state, cont); 
    assert $wrapped($s, $ptr(^_RundownContainer, P#cont), ^_RundownContainer);
    // assert @writes_check(cont); 
    assert $top_writable($s, #wrTime$1^146.1, $ptr(^_RundownContainer, P#cont));
    // assume @_vcc_inv(@state, cont); 
    assume $inv($s, $ptr(^_RundownContainer, P#cont), ^_RundownContainer);
    // prestate#16 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#16, cont, ((*((cont->rsc))->rd)->enabled_protector))); 
    prestate#16 := $release($current_state($s), prestate#16, $ptr(^_RundownContainer, P#cont), $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#16, $state_to_int(prestate#16), ^$#state_t);
    // owns#15 := pure(@_vcc_set_union(owns#15, @_vcc_set_singleton(((*((cont->rsc))->rd)->enabled_protector)))); 
    owns#15 := $set_union(owns#15, $set_singleton($dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#15, $ptrset_to_int(owns#15), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, ((*((cont->rsc))->rd)->enabled_protector))); 
    assume $typed($s, $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector));
    // prestate#16 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#16, cont, (*((cont->rsc))->rd))); 
    prestate#16 := $release($current_state($s), prestate#16, $ptr(^_RundownContainer, P#cont), $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#16, $state_to_int(prestate#16), ^$#state_t);
    // owns#15 := pure(@_vcc_set_union(owns#15, @_vcc_set_singleton((*((cont->rsc))->rd)))); 
    owns#15 := $set_union(owns#15, $set_singleton($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#15, $ptrset_to_int(owns#15), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, (*((cont->rsc))->rd))); 
    assume $typed($s, $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd));
    // prestate#16 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#16, cont, *((cont->rd_claim)))); 
    prestate#16 := $release($current_state($s), prestate#16, $ptr(^_RundownContainer, P#cont), $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#16, $state_to_int(prestate#16), ^$#state_t);
    // owns#15 := pure(@_vcc_set_union(owns#15, @_vcc_set_singleton(*((cont->rd_claim))))); 
    owns#15 := $set_union(owns#15, $set_singleton($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#15, $ptrset_to_int(owns#15), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((cont->rd_claim)))); 
    assume $typed($s, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim));
    // assume ==(owns#15, @_vcc_owns(@state, cont)); 
    assume owns#15 == $owns($s, $ptr(^_RundownContainer, P#cont));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(cont), prestate#16)
    call $static_unwrap($ptr(^_RundownContainer, P#cont), prestate#16);
    assume $good_state_ext(#tok$1^155.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (cont->enabled)); 
    assert $typed2($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.enabled), ^^bool);
    // assert @prim_writes_check((cont->enabled)); 
    assert $writable($s, #wrTime$1^146.1, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.enabled));
    // *(cont->enabled) := false; 
    call $write_int($dot($ptr(^_RundownContainer, P#cont), _RundownContainer.enabled), $bool_to_int(false));
    assume $full_stop_ext(#tok$1^156.3, $s);
    // assert @reads_check_normal((cont->rsc)); 
    assert $typed2($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), $ptr_to(^_Resource));
    assert $thread_local2($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), $ptr_to(^_Resource));
    // rd := (*((cont->rsc))->rd); 
    SL#rd := $ref($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd));
    assume $local_value_is($s, #tok$1^158.5, #loc.rd, $ptr_to_int($ptr(^_Rundown, SL#rd)), $ptr_to(^_Rundown)) && $local_value_is_ptr($s, #tok$1^158.5, #loc.rd, $ptr(^_Rundown, SL#rd), $ptr_to(^_Rundown));
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^159.21, $s);
    atomicObj#38 := $ptr(^_Rundown, SL#rd);
    // assert @_vcc_valid_claim(@state, *((cont->rd_claim))); 
    assert $valid_claim($s, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim));
    // assume @_vcc_valid_claim(@state, *((cont->rd_claim))); 
    assume $valid_claim($s, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim));
    // assert @reads_check_normal((cont->rd_claim)); 
    assert $typed2($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), $spec_ptr_to(^^claim));
    assert $thread_local2($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), $spec_ptr_to(^^claim)) || $ptr(^_RundownContainer, P#cont) == atomicObj#38;
    // stmt @unclaim(*((cont->rd_claim)), rd, (rd->enabled_protector)); 
    assert $top_writable($s, #wrTime$1^146.1, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim));
    assert $ptr(^_Rundown, SL#rd) != $dot($ptr(^_Rundown, SL#rd), _Rundown.enabled_protector);
    call $unclaim($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim));
    assert $claims_obj($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim), $ptr(^_Rundown, SL#rd));
    assert $top_writable($s, #wrTime$1^146.1, $ptr(^_Rundown, SL#rd));
    assert $is_claimable(^_Rundown);
    call $write_ref_cnt($ptr(^_Rundown, SL#rd), $ref_cnt($s, $ptr(^_Rundown, SL#rd)) - 1);
    assume $ref_cnt($s, $ptr(^_Rundown, SL#rd)) >= 0;
    assert $claims_obj($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim), $dot($ptr(^_Rundown, SL#rd), _Rundown.enabled_protector));
    assert $top_writable($s, #wrTime$1^146.1, $dot($ptr(^_Rundown, SL#rd), _Rundown.enabled_protector));
    assert $is_claimable(^_Protector);
    call $write_ref_cnt($dot($ptr(^_Rundown, SL#rd), _Rundown.enabled_protector), $ref_cnt($s, $dot($ptr(^_Rundown, SL#rd), _Rundown.enabled_protector)) - 1);
    assume $ref_cnt($s, $dot($ptr(^_Rundown, SL#rd), _Rundown.enabled_protector)) >= 0;
    assume $full_stop_ext(#tok$1^161.29, $s);
    // empty
    // _math ptrset owns#18; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#18, $ptrset_to_int(owns#18), ^$#ptrset);
    // owns#18 := @_vcc_set_empty; 
    owns#18 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#18, $ptrset_to_int(owns#18), ^$#ptrset);
    // _math state_t prestate#17; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#17, $state_to_int(prestate#17), ^$#state_t);
    // prestate#17 := @_vcc_current_state(@state); 
    prestate#17 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#17, $state_to_int(prestate#17), ^$#state_t);
    // _math state_t prestate#19; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#19, $state_to_int(prestate#19), ^$#state_t);
    // prestate#19 := @_vcc_current_state(@state); 
    prestate#19 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#19, $state_to_int(prestate#19), ^$#state_t);
    // assert @_vcc_wrapped(@state, (rd->enabled_protector)); 
    assert $wrapped($s, $dot($ptr(^_Rundown, SL#rd), _Rundown.enabled_protector), ^_Protector);
    // assert @writes_check((rd->enabled_protector)); 
    assert $top_writable($s, #wrTime$1^146.1, $dot($ptr(^_Rundown, SL#rd), _Rundown.enabled_protector));
    // assume @_vcc_inv(@state, (rd->enabled_protector)); 
    assume $inv($s, $dot($ptr(^_Rundown, SL#rd), _Rundown.enabled_protector), ^_Protector);
    // assume ==(owns#18, @_vcc_owns(@state, (rd->enabled_protector))); 
    assume owns#18 == $owns($s, $dot($ptr(^_Rundown, SL#rd), _Rundown.enabled_protector));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure((rd->enabled_protector)), prestate#19)
    call $static_unwrap($dot($ptr(^_Rundown, SL#rd), _Rundown.enabled_protector), prestate#19);
    assume $good_state_ext(#tok$1^162.23, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    assert $closed($s, atomicObj#38);
    assume $inv($s, atomicObj#38, ^_Rundown);
    beforeAtomicState#3 := $s;
    // assert @_vcc_typed2(@state, (rd->enabled)); 
    assert $typed2($s, $dot($ptr(^_Rundown, SL#rd), _Rundown.enabled), ^^bool);
    // assert @prim_writes_check((rd->enabled)); 
    assert $set_in($dot($ptr(^_Rundown, SL#rd), _Rundown.enabled), $volatile_span($s, atomicObj#38)) || $writable($s, #wrTime$1^146.1, $dot($ptr(^_Rundown, SL#rd), _Rundown.enabled));
    // *(rd->enabled) := false; 
    call $write_int($dot($ptr(^_Rundown, SL#rd), _Rundown.enabled), $bool_to_int(false));
    assume $good_state_ext(#tok$1^164.7, $s);
    assert $closed(beforeAtomicState#3, $dot(atomicObj#38, _Rundown.enabled_protector)) ==> $read_bool(beforeAtomicState#3, $dot(atomicObj#38, _Rundown.enabled)) == $read_bool($s, $dot(atomicObj#38, _Rundown.enabled));
    assert $closed(beforeAtomicState#3, $dot(atomicObj#38, _Rundown.enabled_protector)) ==> $read_bool(beforeAtomicState#3, $dot(atomicObj#38, _Rundown.alive)) == $read_bool($s, $dot(atomicObj#38, _Rundown.alive));
    assert !$read_bool($s, $dot(atomicObj#38, _Rundown.alive)) ==> !$read_bool($s, $dot(atomicObj#38, _Rundown.enabled));
    assert !$read_bool($s, $dot(atomicObj#38, _Rundown.alive)) ==> $mem($s, $dot(atomicObj#38, _Rundown.count)) == 0;
    assert $mem(beforeAtomicState#3, $dot(atomicObj#38, _Rundown.count)) > 0 && $read_bool(beforeAtomicState#3, $dot(atomicObj#38, _Rundown.alive)) ==> $read_bool($s, $dot(atomicObj#38, _Rundown.alive));
    assert $read_bool($s, $dot(atomicObj#38, _Rundown.alive)) ==> $keeps($s, atomicObj#38, $int_to_ptr($mem($s, $dot(atomicObj#38, _Rundown.protected_obj))));
    assert $read_bool($s, $dot(atomicObj#38, _Rundown.alive)) ==> $keeps($s, atomicObj#38, $read_ptr($s, $dot(atomicObj#38, _Rundown.self_claim), ^^claim));
    assert $read_bool($s, $dot(atomicObj#38, _Rundown.alive)) ==> $claims_obj($read_ptr($s, $dot(atomicObj#38, _Rundown.self_claim), ^^claim), atomicObj#38);
    assert $read_bool($s, $dot(atomicObj#38, _Rundown.alive)) ==> $ref_cnt($s, $read_ptr($s, $dot(atomicObj#38, _Rundown.self_claim), ^^claim)) == $mem($s, $dot(atomicObj#38, _Rundown.count));
    assert $read_bool(beforeAtomicState#3, $dot(atomicObj#38, _Rundown.alive)) ==> $ptr_eq($read_ptr(beforeAtomicState#3, $dot(atomicObj#38, _Rundown.self_claim), ^^claim), $read_ptr($s, $dot(atomicObj#38, _Rundown.self_claim), ^^claim));
    assert !$read_bool($s, $dot(atomicObj#38, _Rundown.enabled)) ==> $mem($s, $dot(atomicObj#38, _Rundown.count)) <= $mem(beforeAtomicState#3, $dot(atomicObj#38, _Rundown.count));
    assume $full_stop_ext(#tok$1^159.21, $s);
    // _math state_t prestate#22; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#22, $state_to_int(prestate#22), ^$#state_t);
    // prestate#22 := @_vcc_current_state(@state); 
    prestate#22 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#22, $state_to_int(prestate#22), ^$#state_t);
    // _math state_t staticWrapState#20; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#20, $state_to_int(staticWrapState#20), ^$#state_t);
    // staticWrapState#20 := @_vcc_current_state(@state); 
    staticWrapState#20 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#20, $state_to_int(staticWrapState#20), ^$#state_t);
    // _math ptrset owns#21; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#21, $ptrset_to_int(owns#21), ^$#ptrset);
    // owns#21 := @_vcc_set_empty; 
    owns#21 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#21, $ptrset_to_int(owns#21), ^$#ptrset);
    // assert @writes_check((rd->enabled_protector)); 
    assert $top_writable($s, #wrTime$1^146.1, $dot($ptr(^_Rundown, SL#rd), _Rundown.enabled_protector));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure((rd->enabled_protector)), staticWrapState#20, owns#21)
    call $static_wrap($dot($ptr(^_Rundown, SL#rd), _Rundown.enabled_protector), staticWrapState#20, owns#21);
    assume $good_state_ext(#tok$1^166.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, (rd->enabled_protector)), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $dot($ptr(^_Rundown, SL#rd), _Rundown.enabled_protector)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // tmp := @claim(pure(&&(&&(*((rd->alive)), unchecked!(*((rd->enabled)))), ==(*((rd->protected_obj)), pure(old(@_vcc_when_claimed, *((cont->rsc))))))), rd, (rd->enabled_protector)); 
    assert $closed($s, $ptr(^_Rundown, SL#rd));
    assert $top_writable($s, #wrTime$1^146.1, $ptr(^_Rundown, SL#rd));
    assert $is_claimable(^_Rundown);
    call $write_ref_cnt($ptr(^_Rundown, SL#rd), $ref_cnt($s, $ptr(^_Rundown, SL#rd)) + 1);
    assume $ref_cnt($s, $ptr(^_Rundown, SL#rd)) >= 0;
    assert $closed($s, $dot($ptr(^_Rundown, SL#rd), _Rundown.enabled_protector));
    assert $top_writable($s, #wrTime$1^146.1, $dot($ptr(^_Rundown, SL#rd), _Rundown.enabled_protector));
    assert $is_claimable(^_Protector);
    call $write_ref_cnt($dot($ptr(^_Rundown, SL#rd), _Rundown.enabled_protector), $ref_cnt($s, $dot($ptr(^_Rundown, SL#rd), _Rundown.enabled_protector)) + 1);
    assume $ref_cnt($s, $dot($ptr(^_Rundown, SL#rd), _Rundown.enabled_protector)) >= 0;
    claim#3s0 := $s;
    call claim#3 := $alloc_claim();
    assume $claims_obj(claim#3, $ptr(^_Rundown, SL#rd));
    assume $claims_obj(claim#3, $dot($ptr(^_Rundown, SL#rd), _Rundown.enabled_protector));
    SL#tmp := $ref(claim#3);
    assume $local_value_is($s, #tok$1^167.11, #loc.tmp, $ptr_to_int($ptr(^^claim, SL#tmp)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^167.11, #loc.tmp, $ptr(^^claim, SL#tmp), $spec_ptr_to(^^claim));
    assume $full_stop_ext(#tok$1^167.11, $s);
    assume claim#3 != $no_claim ==> $claim_initial_assumptions($s, claim#3, #tok$1^167.11);
    assert claim#3 != $no_claim ==> $read_bool($s, $dot($ptr(^_Rundown, SL#rd), _Rundown.alive));
    assert claim#3 != $no_claim ==> !$read_bool($s, $dot($ptr(^_Rundown, SL#rd), _Rundown.enabled));
    assert claim#3 != $no_claim ==> $int_to_ptr($mem($s, $dot($ptr(^_Rundown, SL#rd), _Rundown.protected_obj))) == $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource);
    if (claim#3doAdm)
    {
      anon23:
        assume $read_bool(claim#3s1, $dot($ptr(^_Rundown, SL#rd), _Rundown.alive)) && !$read_bool(claim#3s1, $dot($ptr(^_Rundown, SL#rd), _Rundown.enabled)) && $int_to_ptr($mem(claim#3s1, $dot($ptr(^_Rundown, SL#rd), _Rundown.protected_obj))) == $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource);
        assume $valid_claim_impl(claim#3s0, claim#3s2);
        assume $claim_transitivity_assumptions(claim#3s1, claim#3s2, claim#3, #tok$1^167.11);
        assert $read_bool(claim#3s2, $dot($ptr(^_Rundown, SL#rd), _Rundown.alive));
        assert !$read_bool(claim#3s2, $dot($ptr(^_Rundown, SL#rd), _Rundown.enabled));
        assert $int_to_ptr($mem(claim#3s2, $dot($ptr(^_Rundown, SL#rd), _Rundown.protected_obj))) == $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource);
        assume false;
    }

  anon25:
    assume claim#3 != $no_claim ==> (forall #cs22: $state :: { $valid_claim(#cs22, claim#3) } $valid_claim(#cs22, claim#3) ==> $read_bool(#cs22, $dot($ptr(^_Rundown, SL#rd), _Rundown.alive)) && !$read_bool(#cs22, $dot($ptr(^_Rundown, SL#rd), _Rundown.enabled)) && $int_to_ptr($mem(#cs22, $dot($ptr(^_Rundown, SL#rd), _Rundown.protected_obj))) == $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource));
    // assert @_vcc_set_in(*((cont->rd_claim)), @_vcc_owns(@state, cont)); 
    assert $set_in($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim), $owns($s, $ptr(^_RundownContainer, P#cont)));
    // assume @_vcc_set_in(*((cont->rd_claim)), @_vcc_owns(@state, cont)); 
    assume $set_in($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim), $owns($s, $ptr(^_RundownContainer, P#cont)));
    // assert @writes_check(@_vcc_span(cont)); 
    assert (forall #writes$1^168.27: $ptr :: { $dont_instantiate(#writes$1^168.27) } $set_in(#writes$1^168.27, $span($ptr(^_RundownContainer, P#cont))) ==> $top_writable($s, #wrTime$1^146.1, #writes$1^168.27));
    // assert @reads_check_normal((cont->rd_claim)); 
    assert $typed2($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), $spec_ptr_to(^^claim));
    assert $thread_local2($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), $spec_ptr_to(^^claim));
    // stmt _vcc_set_owns(cont, @_vcc_set_remove_element(@_vcc_owns(@state, cont), *((cont->rd_claim)))); 
    call $set_owns($ptr(^_RundownContainer, P#cont), $set_remove_element($owns($s, $ptr(^_RundownContainer, P#cont)), $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)));
    assume $full_stop_ext(#tok$1^168.27, $s);
    // empty
    // assert @_vcc_typed2(@state, (cont->rd_claim)); 
    assert $typed2($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), $spec_ptr_to(^^claim));
    // assert @prim_writes_check((cont->rd_claim)); 
    assert $writable($s, #wrTime$1^146.1, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim));
    // *(cont->rd_claim) := tmp; 
    call $write_int($dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), $ref($ptr(^^claim, SL#tmp)));
    assume $full_stop_ext(#tok$1^169.5, $s);
    // assert @writes_check(@_vcc_span(cont)); 
    assert (forall #writes$1^170.27: $ptr :: { $dont_instantiate(#writes$1^170.27) } $set_in(#writes$1^170.27, $span($ptr(^_RundownContainer, P#cont))) ==> $top_writable($s, #wrTime$1^146.1, #writes$1^170.27));
    // assert @reads_check_normal((cont->rd_claim)); 
    assert $typed2($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), $spec_ptr_to(^^claim));
    assert $thread_local2($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), $spec_ptr_to(^^claim));
    // stmt _vcc_set_owns(cont, @_vcc_set_add_element(@_vcc_owns(@state, cont), *((cont->rd_claim)))); 
    call $set_owns($ptr(^_RundownContainer, P#cont), $set_add_element($owns($s, $ptr(^_RundownContainer, P#cont)), $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)));
    assume $full_stop_ext(#tok$1^170.27, $s);
    // empty
    // _math state_t prestate#25; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#25, $state_to_int(prestate#25), ^$#state_t);
    // prestate#25 := @_vcc_current_state(@state); 
    prestate#25 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#25, $state_to_int(prestate#25), ^$#state_t);
    // _math state_t staticWrapState#23; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#23, $state_to_int(staticWrapState#23), ^$#state_t);
    // staticWrapState#23 := @_vcc_current_state(@state); 
    staticWrapState#23 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#23, $state_to_int(staticWrapState#23), ^$#state_t);
    // _math ptrset owns#24; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#24, $ptrset_to_int(owns#24), ^$#ptrset);
    // owns#24 := @_vcc_set_empty; 
    owns#24 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#24, $ptrset_to_int(owns#24), ^$#ptrset);
    // assert @writes_check(cont); 
    assert $top_writable($s, #wrTime$1^146.1, $ptr(^_RundownContainer, P#cont));
    // assert @_vcc_wrapped(@state, ((*((cont->rsc))->rd)->enabled_protector)); 
    assert $wrapped($s, $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector), ^_Protector);
    // assert @writes_check(((*((cont->rsc))->rd)->enabled_protector)); 
    assert $top_writable($s, #wrTime$1^146.1, $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector));
    // owns#24 := pure(@_vcc_set_union(owns#24, @_vcc_set_singleton(((*((cont->rsc))->rd)->enabled_protector)))); 
    owns#24 := $set_union(owns#24, $set_singleton($dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#24, $ptrset_to_int(owns#24), ^$#ptrset);
    // staticWrapState#23 := pure(@_vcc_take_over(staticWrapState#23, cont, ((*((cont->rsc))->rd)->enabled_protector))); 
    staticWrapState#23 := $take_over(staticWrapState#23, $ptr(^_RundownContainer, P#cont), $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#23, $state_to_int(staticWrapState#23), ^$#state_t);
    // assert @_vcc_wrapped(@state, (*((cont->rsc))->rd)); 
    assert $wrapped($s, $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), ^_Rundown);
    // assert @writes_check((*((cont->rsc))->rd)); 
    assert $top_writable($s, #wrTime$1^146.1, $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd));
    // owns#24 := pure(@_vcc_set_union(owns#24, @_vcc_set_singleton((*((cont->rsc))->rd)))); 
    owns#24 := $set_union(owns#24, $set_singleton($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#24, $ptrset_to_int(owns#24), ^$#ptrset);
    // staticWrapState#23 := pure(@_vcc_take_over(staticWrapState#23, cont, (*((cont->rsc))->rd))); 
    staticWrapState#23 := $take_over(staticWrapState#23, $ptr(^_RundownContainer, P#cont), $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#23, $state_to_int(staticWrapState#23), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((cont->rd_claim))); 
    assert $wrapped($s, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim), ^^claim);
    // assert @writes_check(*((cont->rd_claim))); 
    assert $top_writable($s, #wrTime$1^146.1, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim));
    // owns#24 := pure(@_vcc_set_union(owns#24, @_vcc_set_singleton(*((cont->rd_claim))))); 
    owns#24 := $set_union(owns#24, $set_singleton($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#24, $ptrset_to_int(owns#24), ^$#ptrset);
    // staticWrapState#23 := pure(@_vcc_take_over(staticWrapState#23, cont, *((cont->rd_claim)))); 
    staticWrapState#23 := $take_over(staticWrapState#23, $ptr(^_RundownContainer, P#cont), $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#23, $state_to_int(staticWrapState#23), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(cont), staticWrapState#23, owns#24)
    call $static_wrap($ptr(^_RundownContainer, P#cont), staticWrapState#23, owns#24);
    assume $good_state_ext(#tok$1^171.21, $s);
    // assert @inv_check(@keeps_stable(old(prestate#25, *((cont->rd_claim))), *((cont->rd_claim)))); 
    assert $read_ptr(prestate#25, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim) == $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim);
    // assert @inv_check(@keeps(cont, *((cont->rd_claim)))); 
    assert $keeps($s, $ptr(^_RundownContainer, P#cont), $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim));
    // assert @inv_check(@keeps_stable(old(prestate#25, (*((cont->rsc))->rd)), (*((cont->rsc))->rd))); 
    assert $dot($read_ptr(prestate#25, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd) == $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd);
    // assert @inv_check(@keeps(cont, (*((cont->rsc))->rd))); 
    assert $keeps($s, $ptr(^_RundownContainer, P#cont), $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd));
    // assert @inv_check(@keeps_stable(old(prestate#25, ((*((cont->rsc))->rd)->enabled_protector)), ((*((cont->rsc))->rd)->enabled_protector))); 
    assert $dot($dot($read_ptr(prestate#25, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector) == $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector);
    // assert @inv_check(@keeps(cont, ((*((cont->rsc))->rd)->enabled_protector))); 
    assert $keeps($s, $ptr(^_RundownContainer, P#cont), $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector));
    // assert @inv_check(@_vcc_claims_obj(*((cont->rd_claim)), (*((cont->rsc))->rd))); 
    assert $claims_obj($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim), $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd));
    // assert @inv_check(@_vcc_claims_obj(*((cont->rd_claim)), ((*((cont->rsc))->rd)->enabled_protector))); 
    assert $claims_obj($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim), $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector));
    // assert @inv_check(==(@_vcc_ref_cnt(@state, ((*((cont->rsc))->rd)->enabled_protector)), 1)); 
    assert $ref_cnt($s, $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector)) == 1;
    // assert @inv_check(==(@_vcc_ref_cnt(@state, (*((cont->rsc))->rd)), 2)); 
    assert $ref_cnt($s, $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd)) == 2;
    // assert @inv_check(==(@_vcc_ref_cnt(@state, *((cont->rd_claim))), 0)); 
    assert $ref_cnt($s, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)) == 0;
    // assert @inv_check(@_vcc_claims(*((cont->rd_claim)), ==(*(((old(@_vcc_when_claimed, *((cont->rsc)))->rd)->enabled)), old(@_vcc_when_claimed, *((cont->enabled)))))); 
    assert (forall #cs23: $state :: { $valid_claim(#cs23, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)) } $valid_claim(#cs23, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)) ==> $read_bool(#cs23, $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled)) == $read_bool($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.enabled)));
    // assert @inv_check(@_vcc_claims(*((cont->rd_claim)), *(((old(@_vcc_when_claimed, *((cont->rsc)))->rd)->alive)))); 
    assert (forall #cs24: $state :: { $valid_claim(#cs24, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)) } $valid_claim(#cs24, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)) ==> $read_bool(#cs24, $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.alive)));
    // assert @inv_check(@_vcc_claims(*((cont->rd_claim)), ==(*(((old(@_vcc_when_claimed, *((cont->rsc)))->rd)->protected_obj)), old(@_vcc_when_claimed, *((cont->rsc)))))); 
    assert (forall #cs25: $state :: { $valid_claim(#cs25, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)) } $valid_claim(#cs25, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)) ==> $int_to_ptr($mem(#cs25, $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.protected_obj))) == $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure KillRundownContainerDead(P#cont: int) returns ($result: int);
  requires $wrapped($s, $ptr(^_RundownContainer, P#cont), ^_RundownContainer);
  requires !$read_bool($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.enabled));
  requires $is_malloc_root($s, $ptr(^_RundownContainer, P#cont));
  modifies $s, $cev_pc;
  free ensures $in_range_phys_ptr($ref($ptr(^_Resource, $result)));
  ensures $ptr_eq($read_ptr(old($s), $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), $ptr(^_Resource, $result));
  ensures $wrapped($s, $ptr(^_Resource, $result), ^_Resource);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^_RundownContainer, P#cont) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^_RundownContainer, P#cont) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^_RundownContainer, P#cont) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation KillRundownContainerDead(P#cont: int) returns ($result: int)
{
  var prestate#32: $state;
  var beforeAtomicState#6: $state;
  var prestate#31: $state;
  var prestate#29: $state;
  var owns#30: $ptrset;
  var atomicObj#40: $ptr;
  var claim#4doAdm: bool;
  var claim#4s2: $state;
  var claim#4s1: $state;
  var claim#4s0: $state;
  var claim#4: $ptr;
  var beforeAtomicState#5: $state;
  var atomicObj#39: $ptr;
  var #wrTime$1^194.30: int;
  var loopState#4: $state;
  var prestate#28: $state;
  var prestate#26: $state;
  var owns#27: $ptrset;
  var L#rsc: int where $in_range_phys_ptr(L#rsc);
  var L#cur_count: int where $in_range_u4(L#cur_count);
  var L#rd: int where $in_range_phys_ptr(L#rd);
  var SL#tmp: int where $in_range_spec_ptr(SL#tmp);
  var SL#is_zero: int where $in_range_spec_ptr(SL#is_zero);
  var #wrTime$1^175.1: int;
  var #stackframe: int;

  anon34:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^175.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^175.1, #loc.cont, $ptr_to_int($ptr(^_RundownContainer, P#cont)), $ptr_to(^_RundownContainer)) && $local_value_is_ptr($s, #tok$1^175.1, #loc.cont, $ptr(^_RundownContainer, P#cont), $ptr_to(^_RundownContainer));
    assume #wrTime$1^175.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^175.1, #p) } $in_writes_at(#wrTime$1^175.1, #p) == (#p == $ptr(^_RundownContainer, P#cont)));
    assume $thread_owned($s, $ptr(^_RundownContainer, P#cont));
    // assume @in_range_phys_ptr((mathint)cont); 
    assume $in_range_phys_ptr($ref($ptr(^_RundownContainer, P#cont)));
    // assert @_vcc_in_domain(@state, cont, cont); 
    assert $in_domain_lab($s, $ptr(^_RundownContainer, P#cont), $ptr(^_RundownContainer, P#cont), l#public);
    // claim_t^ is_zero; 
    assume $local_value_is($s, #tok$1^186.25, #loc.is_zero, $ptr_to_int($ptr(^^claim, SL#is_zero)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^186.25, #loc.is_zero, $ptr(^^claim, SL#is_zero), $spec_ptr_to(^^claim));
    // claim_t^ tmp; 
    assume $local_value_is($s, #tok$1^186.25, #loc.tmp, $ptr_to_int($ptr(^^claim, SL#tmp)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^186.25, #loc.tmp, $ptr(^^claim, SL#tmp), $spec_ptr_to(^^claim));
    // struct _Rundown* rd; 
    assume $local_value_is($s, #tok$1^185.3, #loc.rd, $ptr_to_int($ptr(^_Rundown, L#rd)), $ptr_to(^_Rundown)) && $local_value_is_ptr($s, #tok$1^185.3, #loc.rd, $ptr(^_Rundown, L#rd), $ptr_to(^_Rundown));
    // uint32_t cur_count; 
    assume $local_value_is($s, #tok$1^184.3, #loc.cur_count, L#cur_count, ^^u4);
    // struct _Resource* rsc; 
    assume $local_value_is($s, #tok$1^183.3, #loc.rsc, $ptr_to_int($ptr(^_Resource, L#rsc)), $ptr_to(^_Resource)) && $local_value_is_ptr($s, #tok$1^183.3, #loc.rsc, $ptr(^_Resource, L#rsc), $ptr_to(^_Resource));
    // var struct _Resource* rsc
    // var uint32_t cur_count
    // assert @reads_check_normal((cont->rsc)); 
    assert $typed2($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), $ptr_to(^_Resource));
    assert $thread_local2($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), $ptr_to(^_Resource));
    // rd := (*((cont->rsc))->rd); 
    L#rd := $ref($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd));
    assume $local_value_is($s, #tok$1^185.3, #loc.rd, $ptr_to_int($ptr(^_Rundown, L#rd)), $ptr_to(^_Rundown)) && $local_value_is_ptr($s, #tok$1^185.3, #loc.rd, $ptr(^_Rundown, L#rd), $ptr_to(^_Rundown));
    // var spec claim_t^ tmp
    // var spec claim_t^ is_zero
    // _math ptrset owns#27; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#27, $ptrset_to_int(owns#27), ^$#ptrset);
    // owns#27 := @_vcc_set_empty; 
    owns#27 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#27, $ptrset_to_int(owns#27), ^$#ptrset);
    // _math state_t prestate#26; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#26, $state_to_int(prestate#26), ^$#state_t);
    // prestate#26 := @_vcc_current_state(@state); 
    prestate#26 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#26, $state_to_int(prestate#26), ^$#state_t);
    // _math state_t prestate#28; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
    // prestate#28 := @_vcc_current_state(@state); 
    prestate#28 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
    // assert @_vcc_wrapped(@state, cont); 
    assert $wrapped($s, $ptr(^_RundownContainer, P#cont), ^_RundownContainer);
    // assert @writes_check(cont); 
    assert $top_writable($s, #wrTime$1^175.1, $ptr(^_RundownContainer, P#cont));
    // assume @_vcc_inv(@state, cont); 
    assume $inv($s, $ptr(^_RundownContainer, P#cont), ^_RundownContainer);
    // prestate#28 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#28, cont, ((*((cont->rsc))->rd)->enabled_protector))); 
    prestate#28 := $release($current_state($s), prestate#28, $ptr(^_RundownContainer, P#cont), $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
    // owns#27 := pure(@_vcc_set_union(owns#27, @_vcc_set_singleton(((*((cont->rsc))->rd)->enabled_protector)))); 
    owns#27 := $set_union(owns#27, $set_singleton($dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#27, $ptrset_to_int(owns#27), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, ((*((cont->rsc))->rd)->enabled_protector))); 
    assume $typed($s, $dot($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd), _Rundown.enabled_protector));
    // prestate#28 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#28, cont, (*((cont->rsc))->rd))); 
    prestate#28 := $release($current_state($s), prestate#28, $ptr(^_RundownContainer, P#cont), $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
    // owns#27 := pure(@_vcc_set_union(owns#27, @_vcc_set_singleton((*((cont->rsc))->rd)))); 
    owns#27 := $set_union(owns#27, $set_singleton($dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#27, $ptrset_to_int(owns#27), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, (*((cont->rsc))->rd))); 
    assume $typed($s, $dot($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource), _Resource.rd));
    // prestate#28 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#28, cont, *((cont->rd_claim)))); 
    prestate#28 := $release($current_state($s), prestate#28, $ptr(^_RundownContainer, P#cont), $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
    // owns#27 := pure(@_vcc_set_union(owns#27, @_vcc_set_singleton(*((cont->rd_claim))))); 
    owns#27 := $set_union(owns#27, $set_singleton($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#27, $ptrset_to_int(owns#27), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((cont->rd_claim)))); 
    assume $typed($s, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim));
    // assume ==(owns#27, @_vcc_owns(@state, cont)); 
    assume owns#27 == $owns($s, $ptr(^_RundownContainer, P#cont));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(cont), prestate#28)
    call $static_unwrap($ptr(^_RundownContainer, P#cont), prestate#28);
    assume $good_state_ext(#tok$1^188.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @reads_check_normal((cont->rsc)); 
    assert $typed2($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), $ptr_to(^_Resource));
    assert $thread_local2($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), $ptr_to(^_Resource));
    // rsc := *((cont->rsc)); 
    L#rsc := $ref($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rsc), ^_Resource));
    assume $local_value_is($s, #tok$1^189.5, #loc.rsc, $ptr_to_int($ptr(^_Resource, L#rsc)), $ptr_to(^_Resource)) && $local_value_is_ptr($s, #tok$1^189.5, #loc.rsc, $ptr(^_Resource, L#rsc), $ptr_to(^_Resource));
    call $bump_timestamp();
    assume $full_stop_ext(#tok$1^194.30, $s);
    loopState#4 := $s;
    assume #wrTime$1^194.30 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^194.30, #p) } $in_writes_at(#wrTime$1^194.30, #p) == (#p == $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)));
    assert (forall #loopWrites^$1^194.30: $ptr :: { $dont_instantiate(#loopWrites^$1^194.30) } $top_writable($s, #wrTime$1^194.30, #loopWrites^$1^194.30) ==> $top_writable($s, #wrTime$1^175.1, #loopWrites^$1^194.30));
    while (true)
      invariant $ref_cnt($s, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)) == 0;
      invariant $wrapped($s, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim), ^^claim);
    {
      anon30:
        assume (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(loopState#4, #p) || #p == $read_ptr(loopState#4, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim) || $mem_eq(loopState#4, $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(loopState#4, #p) || #p == $read_ptr(loopState#4, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim) || $st_eq(loopState#4, $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(loopState#4, #p) || #p == $read_ptr(loopState#4, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim) || $ts_eq(loopState#4, $s, #p)) && $timestamp_post(loopState#4, $s);
        assume $timestamp_post(loopState#4, $s);
        assume $full_stop_ext(#tok$1^191.5, $s);
        assume $local_value_is($s, #tok$1^191.5, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
        assume $local_value_is($s, #tok$1^191.5, #loc.prestate#26, $state_to_int(prestate#26), ^$#state_t);
        assume $local_value_is($s, #tok$1^191.5, #loc.owns#27, $ptrset_to_int(owns#27), ^$#ptrset);
        assume $local_value_is($s, #tok$1^191.5, #loc.cur_count, L#cur_count, ^^u4);
        assume $local_value_is($s, #tok$1^191.5, #loc.is_zero, $ptr_to_int($ptr(^^claim, SL#is_zero)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^191.5, #loc.is_zero, $ptr(^^claim, SL#is_zero), $spec_ptr_to(^^claim));
        // assume @_vcc_mutable_increases(old(@prestate, @state), @state); 
        assume $mutable_increases(loopState#4, $s);
        assume true;
        call $atomic_havoc();
        assume $full_stop_ext(#tok$1^196.23, $s);
        atomicObj#39 := $ptr(^_Rundown, L#rd);
        assert $valid_claim($s, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim));
        assert $closed($s, atomicObj#39);
        assume $inv($s, atomicObj#39, ^_Rundown);
        beforeAtomicState#5 := $s;
        assume claim#4 == $no_claim;
        // assert @reads_check_normal((rd->count)); 
        assert $typed2($s, $dot($ptr(^_Rundown, L#rd), _Rundown.count), ^^u4);
        assert $mutable($s, $ptr(^_Rundown, L#rd)) || $ptr(^_Rundown, L#rd) == atomicObj#39;
        // cur_count := *((rd->count)); 
        L#cur_count := $mem($s, $dot($ptr(^_Rundown, L#rd), _Rundown.count));
        assume $local_value_is($s, #tok$1^197.9, #loc.cur_count, L#cur_count, ^^u4);
        assume true;
        // if (==(cur_count, 0)) ...
        if (L#cur_count == 0)
        {
          anon26:
            // assert @reads_check_normal((cont->rd_claim)); 
            assert $typed2($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), $spec_ptr_to(^^claim));
            assert $thread_local2($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), $spec_ptr_to(^^claim)) || $ptr(^_RundownContainer, P#cont) == atomicObj#39;
            // is_zero := @claim(pure(==(*((rd->count)), 0)), *((cont->rd_claim))); 
            assert $closed($s, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim));
            assert $top_writable($s, #wrTime$1^194.30, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)) || $owner($s, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)) == atomicObj#39;
            assert $is_claimable(^^claim);
            call $write_ref_cnt($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim), $ref_cnt($s, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)) + 1);
            assume $ref_cnt($s, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)) >= 0;
            claim#4s0 := $s;
            call claim#4 := $alloc_claim();
            assume $claims_obj(claim#4, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim));
            SL#is_zero := $ref(claim#4);
            assume $local_value_is($s, #tok$1^200.24, #loc.is_zero, $ptr_to_int($ptr(^^claim, SL#is_zero)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^200.24, #loc.is_zero, $ptr(^^claim, SL#is_zero), $spec_ptr_to(^^claim));
            assume $good_state_ext(#tok$1^200.24, $s);
        }
        else
        {
          anon27:
            // empty
        }

      anon31:
        assume claim#4 != $no_claim ==> $claim_initial_assumptions($s, claim#4, #tok$1^200.24);
        assert claim#4 != $no_claim ==> $mem($s, $dot($ptr(^_Rundown, L#rd), _Rundown.count)) == 0;
        if (claim#4 != $no_claim && claim#4doAdm)
        {
          anon28:
            assume $mem(claim#4s1, $dot($ptr(^_Rundown, L#rd), _Rundown.count)) == 0;
            assume $valid_claim_impl(claim#4s0, claim#4s2);
            assume $claim_transitivity_assumptions(claim#4s1, claim#4s2, claim#4, #tok$1^200.24);
            assert $mem(claim#4s2, $dot($ptr(^_Rundown, L#rd), _Rundown.count)) == 0;
            assume false;
        }

      anon32:
        assume claim#4 != $no_claim ==> (forall #cs26: $state :: { $valid_claim(#cs26, claim#4) } $valid_claim(#cs26, claim#4) ==> $mem(#cs26, $dot($ptr(^_Rundown, L#rd), _Rundown.count)) == 0);
        assert $closed(beforeAtomicState#5, $dot(atomicObj#39, _Rundown.enabled_protector)) ==> $read_bool(beforeAtomicState#5, $dot(atomicObj#39, _Rundown.enabled)) == $read_bool($s, $dot(atomicObj#39, _Rundown.enabled));
        assert $closed(beforeAtomicState#5, $dot(atomicObj#39, _Rundown.enabled_protector)) ==> $read_bool(beforeAtomicState#5, $dot(atomicObj#39, _Rundown.alive)) == $read_bool($s, $dot(atomicObj#39, _Rundown.alive));
        assert !$read_bool($s, $dot(atomicObj#39, _Rundown.alive)) ==> !$read_bool($s, $dot(atomicObj#39, _Rundown.enabled));
        assert !$read_bool($s, $dot(atomicObj#39, _Rundown.alive)) ==> $mem($s, $dot(atomicObj#39, _Rundown.count)) == 0;
        assert $mem(beforeAtomicState#5, $dot(atomicObj#39, _Rundown.count)) > 0 && $read_bool(beforeAtomicState#5, $dot(atomicObj#39, _Rundown.alive)) ==> $read_bool($s, $dot(atomicObj#39, _Rundown.alive));
        assert $read_bool($s, $dot(atomicObj#39, _Rundown.alive)) ==> $keeps($s, atomicObj#39, $int_to_ptr($mem($s, $dot(atomicObj#39, _Rundown.protected_obj))));
        assert $read_bool($s, $dot(atomicObj#39, _Rundown.alive)) ==> $keeps($s, atomicObj#39, $read_ptr($s, $dot(atomicObj#39, _Rundown.self_claim), ^^claim));
        assert $read_bool($s, $dot(atomicObj#39, _Rundown.alive)) ==> $claims_obj($read_ptr($s, $dot(atomicObj#39, _Rundown.self_claim), ^^claim), atomicObj#39);
        assert $read_bool($s, $dot(atomicObj#39, _Rundown.alive)) ==> $ref_cnt($s, $read_ptr($s, $dot(atomicObj#39, _Rundown.self_claim), ^^claim)) == $mem($s, $dot(atomicObj#39, _Rundown.count));
        assert $read_bool(beforeAtomicState#5, $dot(atomicObj#39, _Rundown.alive)) ==> $ptr_eq($read_ptr(beforeAtomicState#5, $dot(atomicObj#39, _Rundown.self_claim), ^^claim), $read_ptr($s, $dot(atomicObj#39, _Rundown.self_claim), ^^claim));
        assert !$read_bool($s, $dot(atomicObj#39, _Rundown.enabled)) ==> $mem($s, $dot(atomicObj#39, _Rundown.count)) <= $mem(beforeAtomicState#5, $dot(atomicObj#39, _Rundown.count));
        assume $full_stop_ext(#tok$1^196.23, $s);

      #continue_5:
        assume true;
        // if (unchecked!(!=(cur_count, 0))) ...
        if (!(L#cur_count != 0))
        {
          anon29:
            // goto #break_5; 
            goto #break_5;
        }

      anon33:
        assume true;
    }

  anon35:
    assume $full_stop_ext(#tok$1^191.5, $s);

  #break_5:
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^206.23, $s);
    atomicObj#40 := $ptr(^_Rundown, L#rd);
    // assert @_vcc_valid_claim(@state, is_zero); 
    assert $valid_claim($s, $ptr(^^claim, SL#is_zero));
    // assume @_vcc_valid_claim(@state, is_zero); 
    assume $valid_claim($s, $ptr(^^claim, SL#is_zero));
    // assert @_vcc_valid_claim(@state, *((cont->rd_claim))); 
    assert $valid_claim($s, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim));
    // assume @_vcc_valid_claim(@state, *((cont->rd_claim))); 
    assume $valid_claim($s, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim));
    // assert @reads_check_normal((cont->rd_claim)); 
    assert $typed2($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), $spec_ptr_to(^^claim));
    assert $thread_local2($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), $spec_ptr_to(^^claim)) || $ptr(^_RundownContainer, P#cont) == atomicObj#40;
    // stmt @unclaim(is_zero, *((cont->rd_claim))); 
    assert $top_writable($s, #wrTime$1^175.1, $ptr(^^claim, SL#is_zero));
    call $unclaim($ptr(^^claim, SL#is_zero));
    assert $claims_obj($ptr(^^claim, SL#is_zero), $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim));
    assert $top_writable($s, #wrTime$1^175.1, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim));
    assert $is_claimable(^^claim);
    call $write_ref_cnt($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim), $ref_cnt($s, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)) - 1);
    assume $ref_cnt($s, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim)) >= 0;
    assume $full_stop_ext(#tok$1^209.31, $s);
    // empty
    // assert @reads_check_normal((cont->rd_claim)); 
    assert $typed2($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), $spec_ptr_to(^^claim));
    assert $thread_local2($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), $spec_ptr_to(^^claim)) || $ptr(^_RundownContainer, P#cont) == atomicObj#40;
    // stmt @unclaim(*((cont->rd_claim)), rd, (rd->enabled_protector)); 
    assert $top_writable($s, #wrTime$1^175.1, $read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim));
    assert $ptr(^_Rundown, L#rd) != $dot($ptr(^_Rundown, L#rd), _Rundown.enabled_protector);
    call $unclaim($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim));
    assert $claims_obj($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim), $ptr(^_Rundown, L#rd));
    assert $top_writable($s, #wrTime$1^175.1, $ptr(^_Rundown, L#rd));
    assert $is_claimable(^_Rundown);
    call $write_ref_cnt($ptr(^_Rundown, L#rd), $ref_cnt($s, $ptr(^_Rundown, L#rd)) - 1);
    assume $ref_cnt($s, $ptr(^_Rundown, L#rd)) >= 0;
    assert $claims_obj($read_ptr($s, $dot($ptr(^_RundownContainer, P#cont), _RundownContainer.rd_claim), ^^claim), $dot($ptr(^_Rundown, L#rd), _Rundown.enabled_protector));
    assert $top_writable($s, #wrTime$1^175.1, $dot($ptr(^_Rundown, L#rd), _Rundown.enabled_protector));
    assert $is_claimable(^_Protector);
    call $write_ref_cnt($dot($ptr(^_Rundown, L#rd), _Rundown.enabled_protector), $ref_cnt($s, $dot($ptr(^_Rundown, L#rd), _Rundown.enabled_protector)) - 1);
    assume $ref_cnt($s, $dot($ptr(^_Rundown, L#rd), _Rundown.enabled_protector)) >= 0;
    assume $full_stop_ext(#tok$1^210.31, $s);
    // empty
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
    // assert @_vcc_wrapped(@state, (rd->enabled_protector)); 
    assert $wrapped($s, $dot($ptr(^_Rundown, L#rd), _Rundown.enabled_protector), ^_Protector);
    // assert @writes_check((rd->enabled_protector)); 
    assert $top_writable($s, #wrTime$1^175.1, $dot($ptr(^_Rundown, L#rd), _Rundown.enabled_protector));
    // assume @_vcc_inv(@state, (rd->enabled_protector)); 
    assume $inv($s, $dot($ptr(^_Rundown, L#rd), _Rundown.enabled_protector), ^_Protector);
    // assume ==(owns#30, @_vcc_owns(@state, (rd->enabled_protector))); 
    assume owns#30 == $owns($s, $dot($ptr(^_Rundown, L#rd), _Rundown.enabled_protector));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure((rd->enabled_protector)), prestate#31)
    call $static_unwrap($dot($ptr(^_Rundown, L#rd), _Rundown.enabled_protector), prestate#31);
    assume $good_state_ext(#tok$1^211.25, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    assert $closed($s, atomicObj#40);
    assume $inv($s, atomicObj#40, ^_Rundown);
    beforeAtomicState#6 := $s;
    // assert @reads_check_normal((rd->self_claim)); 
    assert $typed2($s, $dot($ptr(^_Rundown, L#rd), _Rundown.self_claim), $spec_ptr_to(^^claim));
    assert $mutable($s, $ptr(^_Rundown, L#rd)) || $ptr(^_Rundown, L#rd) == atomicObj#40;
    // tmp := *((rd->self_claim)); 
    SL#tmp := $ref($read_ptr($s, $dot($ptr(^_Rundown, L#rd), _Rundown.self_claim), ^^claim));
    assume $local_value_is($s, #tok$1^213.9, #loc.tmp, $ptr_to_int($ptr(^^claim, SL#tmp)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^213.9, #loc.tmp, $ptr(^^claim, SL#tmp), $spec_ptr_to(^^claim));
    // assert @is_atomic_obj(rd); 
    assert $ptr(^_Rundown, L#rd) == atomicObj#40;
    // assert @reads_check_normal((rd->self_claim)); 
    assert $typed2($s, $dot($ptr(^_Rundown, L#rd), _Rundown.self_claim), $spec_ptr_to(^^claim));
    assert $mutable($s, $ptr(^_Rundown, L#rd)) || $ptr(^_Rundown, L#rd) == atomicObj#40;
    // stmt _vcc_giveup_closed_owner(*((rd->self_claim)), rd); 
    call $giveup_closed_owner($read_ptr($s, $dot($ptr(^_Rundown, L#rd), _Rundown.self_claim), ^^claim), $ptr(^_Rundown, L#rd));
    assume $good_state_ext(#tok$1^214.31, $s);
    // empty
    // assert @_vcc_typed2(@state, (rd->alive)); 
    assert $typed2($s, $dot($ptr(^_Rundown, L#rd), _Rundown.alive), ^^bool);
    // assert @prim_writes_check((rd->alive)); 
    assert $set_in($dot($ptr(^_Rundown, L#rd), _Rundown.alive), $volatile_span($s, atomicObj#40)) || $writable($s, #wrTime$1^175.1, $dot($ptr(^_Rundown, L#rd), _Rundown.alive));
    // *(rd->alive) := false; 
    call $write_int($dot($ptr(^_Rundown, L#rd), _Rundown.alive), $bool_to_int(false));
    assume $good_state_ext(#tok$1^215.9, $s);
    assert $closed(beforeAtomicState#6, $dot(atomicObj#40, _Rundown.enabled_protector)) ==> $read_bool(beforeAtomicState#6, $dot(atomicObj#40, _Rundown.enabled)) == $read_bool($s, $dot(atomicObj#40, _Rundown.enabled));
    assert $closed(beforeAtomicState#6, $dot(atomicObj#40, _Rundown.enabled_protector)) ==> $read_bool(beforeAtomicState#6, $dot(atomicObj#40, _Rundown.alive)) == $read_bool($s, $dot(atomicObj#40, _Rundown.alive));
    assert !$read_bool($s, $dot(atomicObj#40, _Rundown.alive)) ==> !$read_bool($s, $dot(atomicObj#40, _Rundown.enabled));
    assert !$read_bool($s, $dot(atomicObj#40, _Rundown.alive)) ==> $mem($s, $dot(atomicObj#40, _Rundown.count)) == 0;
    assert $mem(beforeAtomicState#6, $dot(atomicObj#40, _Rundown.count)) > 0 && $read_bool(beforeAtomicState#6, $dot(atomicObj#40, _Rundown.alive)) ==> $read_bool($s, $dot(atomicObj#40, _Rundown.alive));
    assert $read_bool($s, $dot(atomicObj#40, _Rundown.alive)) ==> $keeps($s, atomicObj#40, $int_to_ptr($mem($s, $dot(atomicObj#40, _Rundown.protected_obj))));
    assert $read_bool($s, $dot(atomicObj#40, _Rundown.alive)) ==> $keeps($s, atomicObj#40, $read_ptr($s, $dot(atomicObj#40, _Rundown.self_claim), ^^claim));
    assert $read_bool($s, $dot(atomicObj#40, _Rundown.alive)) ==> $claims_obj($read_ptr($s, $dot(atomicObj#40, _Rundown.self_claim), ^^claim), atomicObj#40);
    assert $read_bool($s, $dot(atomicObj#40, _Rundown.alive)) ==> $ref_cnt($s, $read_ptr($s, $dot(atomicObj#40, _Rundown.self_claim), ^^claim)) == $mem($s, $dot(atomicObj#40, _Rundown.count));
    assert $read_bool(beforeAtomicState#6, $dot(atomicObj#40, _Rundown.alive)) ==> $ptr_eq($read_ptr(beforeAtomicState#6, $dot(atomicObj#40, _Rundown.self_claim), ^^claim), $read_ptr($s, $dot(atomicObj#40, _Rundown.self_claim), ^^claim));
    assert !$read_bool($s, $dot(atomicObj#40, _Rundown.enabled)) ==> $mem($s, $dot(atomicObj#40, _Rundown.count)) <= $mem(beforeAtomicState#6, $dot(atomicObj#40, _Rundown.count));
    assume $full_stop_ext(#tok$1^206.23, $s);
    // stmt @unclaim(tmp, rd); 
    assert $top_writable($s, #wrTime$1^175.1, $ptr(^^claim, SL#tmp));
    call $unclaim($ptr(^^claim, SL#tmp));
    assert $claims_obj($ptr(^^claim, SL#tmp), $ptr(^_Rundown, L#rd));
    assert $top_writable($s, #wrTime$1^175.1, $ptr(^_Rundown, L#rd));
    assert $is_claimable(^_Rundown);
    call $write_ref_cnt($ptr(^_Rundown, L#rd), $ref_cnt($s, $ptr(^_Rundown, L#rd)) - 1);
    assume $ref_cnt($s, $ptr(^_Rundown, L#rd)) >= 0;
    assume $full_stop_ext(#tok$1^217.29, $s);
    // empty
    // _math state_t prestate#32; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#32, $state_to_int(prestate#32), ^$#state_t);
    // prestate#32 := @_vcc_current_state(@state); 
    prestate#32 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#32, $state_to_int(prestate#32), ^$#state_t);
    // assert @_vcc_wrapped(@state, rd); 
    assert $wrapped($s, $ptr(^_Rundown, L#rd), ^_Rundown);
    // assume @_vcc_inv(@state, rd); 
    assume $inv($s, $ptr(^_Rundown, L#rd), ^_Rundown);
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(rd); 
    assert $top_writable($s, #wrTime$1^175.1, $ptr(^_Rundown, L#rd));
    // stmt @_vcc_unwrap(rd, @_vcc_typeof(rd)); 
    call $unwrap($ptr(^_Rundown, L#rd), ^_Rundown);
    assume $good_state_ext(#tok$1^218.23, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @writes_check(cont); 
    assert $top_writable($s, #wrTime$1^175.1, $ptr(^_RundownContainer, P#cont));
    // assert @writes_check(@_vcc_extent(@state, cont)); 
    assert (forall #writes$1^220.3: $ptr :: { $dont_instantiate(#writes$1^220.3) } $set_in(#writes$1^220.3, $extent($s, $ptr(^_RundownContainer, P#cont))) ==> $top_writable($s, #wrTime$1^175.1, #writes$1^220.3));
    // stmt _vcc_free(cont); 
    call $free($ptr(^_RundownContainer, P#cont));
    assume $full_stop_ext(#tok$1^220.3, $s);
    // return rsc; 
    $result := $ref($ptr(^_Resource, L#rsc));
    assert $position_marker();
    goto #exit;

  anon36:
    // empty

  #exit:
}



procedure UseRundown(P#a: int, P#r: int, SP#rdi: int);
  requires true;
  requires $wrapped($s, $ptr(^^claim, SP#rdi), ^^claim);
  requires $valid_claim($s, $ptr(^^claim, SP#rdi));
  requires (forall #cs27: $state :: { $valid_claim(#cs27, $ptr(^^claim, SP#rdi)) } $valid_claim(#cs27, $ptr(^^claim, SP#rdi)) ==> $claimed_closed(#cs27, $ptr(^_Rundown, P#r)) && $int_to_ptr($mem(#cs27, $by_claim(#cs27, $ptr(^^claim, SP#rdi), $ptr(^_Rundown, P#r), $dot($ptr(^_Rundown, P#r), _Rundown.protected_obj)))) == $ptr(^_Resource, P#a) && $read_bool(#cs27, $dot($ptr(^_Rundown, P#r), _Rundown.enabled)));
  modifies $s, $cev_pc;
  ensures $wrapped($s, $ptr(^^claim, SP#rdi), ^^claim) && $valid_claim($s, $ptr(^^claim, SP#rdi));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation UseRundown(P#a: int, P#r: int, SP#rdi: int)
{
  var beforeAtomicState#7: $state;
  var atomicObj#41: $ptr;
  var SL#ac: int where $in_range_spec_ptr(SL#ac);
  var #wrTime$1^224.1: int;
  var #stackframe: int;

  anon37:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^224.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^224.1, #loc.a, $ptr_to_int($ptr(^_Resource, P#a)), $ptr_to(^_Resource)) && $local_value_is_ptr($s, #tok$1^224.1, #loc.a, $ptr(^_Resource, P#a), $ptr_to(^_Resource));
    assume $local_value_is($s, #tok$1^224.1, #loc.r, $ptr_to_int($ptr(^_Rundown, P#r)), $ptr_to(^_Rundown)) && $local_value_is_ptr($s, #tok$1^224.1, #loc.r, $ptr(^_Rundown, P#r), $ptr_to(^_Rundown));
    assume $local_value_is($s, #tok$1^224.1, #loc.rdi, $ptr_to_int($ptr(^^claim, SP#rdi)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^224.1, #loc.rdi, $ptr(^^claim, SP#rdi), $spec_ptr_to(^^claim));
    assume #wrTime$1^224.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^224.1, #p) } $in_writes_at(#wrTime$1^224.1, #p) == false);
    // assume @in_range_phys_ptr((mathint)a); 
    assume $in_range_phys_ptr($ref($ptr(^_Resource, P#a)));
    // assume @in_range_phys_ptr((mathint)r); 
    assume $in_range_phys_ptr($ref($ptr(^_Rundown, P#r)));
    // assume @in_range_spec_ptr((mathint)rdi); 
    assume $in_range_spec_ptr($ref($ptr(^^claim, SP#rdi)));
    // assert @_vcc_valid_claim(@state, rdi); 
    assert $valid_claim($s, $ptr(^^claim, SP#rdi));
    // assert @_vcc_in_domain(@state, rdi, rdi); 
    assert $in_domain_lab($s, $ptr(^^claim, SP#rdi), $ptr(^^claim, SP#rdi), l#public);
    // claim_t^ ac; 
    assume $local_value_is($s, #tok$1^227.26, #loc.ac, $ptr_to_int($ptr(^^claim, SL#ac)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^227.26, #loc.ac, $ptr(^^claim, SL#ac), $spec_ptr_to(^^claim));
    // var spec claim_t^ ac
    // ac := ReferenceRundown(r, rdi); 
    call SL#ac := ReferenceRundown($ref($ptr(^_Rundown, P#r)), $ref($ptr(^^claim, SP#rdi)));
    assume $full_stop_ext(#tok$1^228.3, $s);
    assume $local_value_is($s, #tok$1^228.3, #loc.ac, $ptr_to_int($ptr(^^claim, SL#ac)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^228.3, #loc.ac, $ptr(^^claim, SL#ac), $spec_ptr_to(^^claim));
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^229.19, $s);
    atomicObj#41 := $ptr(^_Resource, P#a);
    assert $valid_claim($s, $ptr(^^claim, SP#rdi));
    assert $valid_claim($s, $ptr(^^claim, SL#ac));
    assert $closed($s, atomicObj#41);
    assume $inv($s, atomicObj#41, ^_Resource);
    beforeAtomicState#7 := $s;
    // assert @_vcc_typed2(@state, (a->x)); 
    assert $typed2($s, $dot($ptr(^_Resource, P#a), _Resource.x), ^^i4);
    // assert @prim_writes_check((a->x)); 
    assert $set_in($dot($ptr(^_Resource, P#a), _Resource.x), $volatile_span($s, atomicObj#41)) || $writable($s, #wrTime$1^224.1, $dot($ptr(^_Resource, P#a), _Resource.x));
    // *(a->x) := 12; 
    call $write_int($dot($ptr(^_Resource, P#a), _Resource.x), 12);
    assume $good_state_ext(#tok$1^230.5, $s);
    assert $set_eq($owns($s, atomicObj#41), $set_empty());
    assume $full_stop_ext(#tok$1^229.19, $s);
    // assert @writes_check(ac); 
    assert $top_writable($s, #wrTime$1^224.1, $ptr(^^claim, SL#ac));
    // stmt DereferenceRundown(r, ac); 
    call DereferenceRundown($ref($ptr(^_Rundown, P#r)), $ref($ptr(^^claim, SL#ac)));
    assume $full_stop_ext(#tok$1^232.3, $s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



const unique l#public: $label;

const unique #tok$1^232.3: $token;

const unique #tok$1^229.19: $token;

const unique #tok$1^230.5: $token;

const unique #tok$1^228.3: $token;

const unique #loc.ac: $token;

const unique #tok$1^227.26: $token;

const unique #loc.a: $token;

const unique #tok$1^224.1: $token;

const unique #tok$1^220.3: $token;

const unique #tok$1^218.23: $token;

const unique #loc.prestate#32: $token;

const unique #tok$1^217.29: $token;

const unique #tok$1^206.23: $token;

const unique #tok$1^215.9: $token;

const unique #tok$1^214.31: $token;

const unique #tok$1^213.9: $token;

const unique #tok$1^211.25: $token;

const unique #loc.prestate#31: $token;

const unique #loc.prestate#29: $token;

const unique #loc.owns#30: $token;

const unique #tok$1^210.31: $token;

const unique #tok$1^209.31: $token;

const unique #tok$1^196.23: $token;

const unique #tok$1^200.24: $token;

const unique #tok$1^197.9: $token;

const unique #tok$1^191.5: $token;

const unique #tok$1^194.30: $token;

const unique #tok$1^189.5: $token;

const unique #tok$1^188.19: $token;

const unique #loc.prestate#28: $token;

const unique #loc.prestate#26: $token;

const unique #loc.owns#27: $token;

const unique #tok$1^183.3: $token;

const unique #loc.cur_count: $token;

const unique #tok$1^184.3: $token;

const unique #tok$1^185.3: $token;

const unique #loc.is_zero: $token;

const unique #tok$1^186.25: $token;

const unique #tok$1^175.1: $token;

const unique #tok$1^171.21: $token;

const unique #loc.owns#24: $token;

const unique #loc.staticWrapState#23: $token;

const unique #loc.prestate#25: $token;

const unique #tok$1^170.27: $token;

const unique #tok$1^169.5: $token;

const unique #tok$1^168.27: $token;

const unique #tok$1^167.11: $token;

const unique #tok$1^166.21: $token;

const unique #loc.owns#21: $token;

const unique #loc.staticWrapState#20: $token;

const unique #loc.prestate#22: $token;

const unique #tok$1^159.21: $token;

const unique #tok$1^164.7: $token;

const unique #tok$1^162.23: $token;

const unique #loc.prestate#19: $token;

const unique #loc.prestate#17: $token;

const unique #loc.owns#18: $token;

const unique #tok$1^161.29: $token;

const unique #tok$1^158.5: $token;

const unique #tok$1^156.3: $token;

const unique #tok$1^155.19: $token;

const unique #loc.prestate#16: $token;

const unique #loc.prestate#14: $token;

const unique #loc.owns#15: $token;

const unique #loc.tmp: $token;

const unique #tok$1^152.25: $token;

const unique #loc.rd: $token;

const unique #tok$1^153.25: $token;

const unique #tok$1^146.1: $token;

const unique #tok$1^143.19: $token;

const unique #loc.owns#12: $token;

const unique #loc.staticWrapState#11: $token;

const unique #loc.prestate#13: $token;

const unique #tok$1^141.3: $token;

const unique #tok$1^140.77: $token;

const unique #tok$1^140.3: $token;

const unique #loc.outpar#6: $token;

const unique #tok$1^139.3: $token;

const unique #loc.cont: $token;

const unique #loc.rsc: $token;

const unique #tok$1^133.1: $token;

const unique #tok$1^103.19: $token;

const unique #loc.stmtexpr0#34: $token;

const unique #tok$1^11.3: $token;

const unique #loc.res#4: $token;

const unique #tok$1^105.5: $token;

const unique #loc.p#3: $token;

const unique #tok$1^105.26: $token;

const unique #tok$1^104.27: $token;

const unique #loc.h: $token;

const unique #tok$1^97.1: $token;

const unique #tok$1^90.19: $token;

const unique #loc.res: $token;

const unique #tok$1^93.34: $token;

const unique #loc.stmtexpr0#33: $token;

const unique #tok$1^6.3: $token;

const unique #loc.res#2: $token;

const unique #tok$1^92.5: $token;

const unique #distTp6: $ctype;

axiom #distTp6 == $ptr_to(^^u4);

const unique #loc.p#1: $token;

const unique #tok$1^92.26: $token;

const unique #loc.c: $token;

const unique #tok$1^88.26: $token;

const unique #tok$1^80.1: $token;

const unique #loc.rdi: $token;

const unique #tok$1^76.11: $token;

const unique #tok$1^73.21: $token;

const unique #loc.owns#9: $token;

const unique #loc.staticWrapState#8: $token;

const unique #loc.prestate#10: $token;

const unique #tok$1^64.21: $token;

const unique #tok$1^71.29: $token;

const unique #tok$1^70.29: $token;

const unique #tok$1^69.7: $token;

const unique #tok$1^68.7: $token;

const unique #tok$1^67.7: $token;

const unique #tok$1^65.12: $token;

const unique #tok$1^59.19: $token;

function $state_to_int(x: $state) : int;

function $int_to_state(x: int) : $state;

axiom (forall #x: $state :: #x == $int_to_state($state_to_int(#x)));

const unique #loc.prestate#7: $token;

const unique #tok$2^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(2, #file^?3Cno?20file?3E);

const unique #tok$1^58.70: $token;

const unique #tok$1^58.51: $token;

const unique #tok$1^58.27: $token;

const unique #tok$1^57.25: $token;

const unique #tok$1^56.25: $token;

const unique #tok$1^55.3: $token;

const unique #loc.s1: $token;

const unique #tok$1^53.25: $token;

const unique #loc.obj: $token;

const unique #loc.r: $token;

const unique #tok$1^43.1: $token;

const unique #distTp5: $ctype;

axiom #distTp5 == $ptr_to(^_RundownContainer);

const unique #tok$1^114.9: $token;

const unique #distTp4: $ctype;

axiom #distTp4 == $ptr_to(^_Resource);

const unique #distTp3: $ctype;

axiom #distTp3 == $ptr_to(^_Rundown);

const unique #loc._this_: $token;

const unique #tok$1^19.67: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CRundown.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CRundown.c);

const unique #distTp2: $ctype;

axiom #distTp2 == $ptr_to(^^void);

const unique #distTp1: $ctype;

axiom #distTp1 == $spec_ptr_to(^^claim);
