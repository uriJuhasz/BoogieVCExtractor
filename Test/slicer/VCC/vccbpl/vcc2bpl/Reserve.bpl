axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^_ENTRY: $ctype;

axiom $is_composite(^_ENTRY);

axiom $ptr_level(^_ENTRY) == 0;

axiom $sizeof(^_ENTRY) == 16;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_ENTRY) } $inv2(#s1, #s2, #p, ^_ENTRY) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty())));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^_ENTRY, #r), l#public) } $inv_lab(#s2, $ptr(^_ENTRY, #r), l#public) == ($typed(#s2, $ptr(^_ENTRY, #r)) && $set_eq($owns(#s2, $ptr(^_ENTRY, #r)), $set_empty())));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^_ENTRY, #r)) } $in_full_extent_of(#q, $ptr(^_ENTRY, #r)) == (#q == $ptr(^_ENTRY, #r) || #q == $dot($ptr(^_ENTRY, #r), _ENTRY.$owns) || #q == $dot($ptr(^_ENTRY, #r), _ENTRY.AsUINT64#nest0) || #q == $dot($ptr(^_ENTRY, #r), _ENTRY.NextPfn#nest1)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_ENTRY, #r)) } $in_extent_of(#s, #q, $ptr(^_ENTRY, #r)) == $in_struct_extent_of(#q, $ptr(^_ENTRY, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_ENTRY, #r)) } $typed(#s, $ptr(^_ENTRY, #r)) ==> $in_extent_of(#s, #q, $ptr(^_ENTRY, #r)) == (#q == $ptr(^_ENTRY, #r) || $emb(#s, #q) == $ptr(^_ENTRY, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^_ENTRY, #r)) } $in_span_of(#q, $ptr(^_ENTRY, #r)) == (#q == $ptr(^_ENTRY, #r) || #q == $dot($ptr(^_ENTRY, #r), _ENTRY.$owns) || #q == $dot($ptr(^_ENTRY, #r), _ENTRY.AsUINT64#nest0) || #q == $dot($ptr(^_ENTRY, #r), _ENTRY.NextPfn#nest1)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^_ENTRY) } $state_spans_the_same(#s1, #s2, #p, ^_ENTRY) == ($mem_eq(#s1, #s2, $dot(#p, _ENTRY.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _ENTRY.AsUINT64#nest0)) && $mem_eq(#s1, #s2, $dot(#p, _ENTRY.NextPfn#nest1))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_ENTRY) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_ENTRY) == ($mem_eq(#s1, #s2, $dot(#p, _ENTRY.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _ENTRY.AsUINT64#nest0)) && $mem_eq(#s1, #s2, $dot(#p, _ENTRY.NextPfn#nest1))));

axiom $is_claimable(^_ENTRY) == false;

axiom $has_volatile_owns_set(^_ENTRY) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^_ENTRY, #r)) } $extent_mutable(#s1, $ptr(^_ENTRY, #r)) == $mutable(#s1, $ptr(^_ENTRY, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^_ENTRY, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^_ENTRY, #r)) == $is_fresh(#s1, #s2, $ptr(^_ENTRY, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^_ENTRY, #r)) } $extent_zero(#s1, $ptr(^_ENTRY, #r)) == ($mem(#s1, $dot($ptr(^_ENTRY, #r), _ENTRY.AsUINT64#nest0)) == 0 && $mem(#s1, $dot($ptr(^_ENTRY, #r), _ENTRY.NextPfn#nest1)) == 0));

const unique _ENTRY.$owns: $field;

axiom $static_field_properties(_ENTRY.$owns, ^_ENTRY);

axiom $is_primitive_non_volatile_field(_ENTRY.$owns);

axiom (forall #p: $ptr :: { $dot(#p, _ENTRY.$owns) } $is(#p, ^_ENTRY) ==> $dot(#p, _ENTRY.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, _ENTRY.$owns)) && $extent_hint($dot(#p, _ENTRY.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _ENTRY.$owns)) } { $st(#s, $dot(#p, _ENTRY.$owns)) } $typed2(#s, #p, ^_ENTRY) ==> $field_properties(#s, #p, _ENTRY.$owns, ^$#ptrset, false));

axiom $owns_set_field(^_ENTRY) == _ENTRY.$owns;

const unique _ENTRY.AsUINT64#nest0: $field;

axiom $static_field_properties(_ENTRY.AsUINT64#nest0, ^_ENTRY);

axiom $is_primitive_non_volatile_field(_ENTRY.AsUINT64#nest0);

axiom $field_offset(_ENTRY.AsUINT64#nest0) == 0;

axiom (forall #p: $ptr :: { $dot(#p, _ENTRY.AsUINT64#nest0) } $is(#p, ^_ENTRY) ==> $dot(#p, _ENTRY.AsUINT64#nest0) == $ptr(^^u8, $ref(#p) + 0) && $extent_hint($dot(#p, _ENTRY.AsUINT64#nest0), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _ENTRY.AsUINT64#nest0)) } { $st(#s, $dot(#p, _ENTRY.AsUINT64#nest0)) } $typed2(#s, #p, ^_ENTRY) ==> $field_properties(#s, #p, _ENTRY.AsUINT64#nest0, ^^u8, false));

const unique _ENTRY.NextPfn#nest1: $field;

axiom $static_field_properties(_ENTRY.NextPfn#nest1, ^_ENTRY);

axiom $is_primitive_non_volatile_field(_ENTRY.NextPfn#nest1);

axiom $field_offset(_ENTRY.NextPfn#nest1) == 8;

axiom (forall #p: $ptr :: { $dot(#p, _ENTRY.NextPfn#nest1) } $is(#p, ^_ENTRY) ==> $dot(#p, _ENTRY.NextPfn#nest1) == $ptr($ptr_to(^_ENTRY), $ref(#p) + 8) && $extent_hint($dot(#p, _ENTRY.NextPfn#nest1), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _ENTRY.NextPfn#nest1)) } { $st(#s, $dot(#p, _ENTRY.NextPfn#nest1)) } $typed2(#s, #p, ^_ENTRY) ==> $field_properties(#s, #p, _ENTRY.NextPfn#nest1, $ptr_to(^_ENTRY), false));

const unique ^_ENTRY.Reserve.c..23530: $ctype;

axiom $is_composite(^_ENTRY.Reserve.c..23530);

axiom $ptr_level(^_ENTRY.Reserve.c..23530) == 0;

axiom $sizeof(^_ENTRY.Reserve.c..23530) == 8;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_ENTRY.Reserve.c..23530) } $inv2(#s1, #s2, #p, ^_ENTRY.Reserve.c..23530) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty())));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^_ENTRY.Reserve.c..23530, #r), l#public) } $inv_lab(#s2, $ptr(^_ENTRY.Reserve.c..23530, #r), l#public) == ($typed(#s2, $ptr(^_ENTRY.Reserve.c..23530, #r)) && $set_eq($owns(#s2, $ptr(^_ENTRY.Reserve.c..23530, #r)), $set_empty())));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^_ENTRY.Reserve.c..23530, #r)) } $in_full_extent_of(#q, $ptr(^_ENTRY.Reserve.c..23530, #r)) == (#q == $ptr(^_ENTRY.Reserve.c..23530, #r) || #q == $dot($ptr(^_ENTRY.Reserve.c..23530, #r), _ENTRY.Reserve.c..23530.$owns) || #q == $dot($ptr(^_ENTRY.Reserve.c..23530, #r), _ENTRY.Reserve.c..23530.AsUINT64)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_ENTRY.Reserve.c..23530, #r)) } $in_extent_of(#s, #q, $ptr(^_ENTRY.Reserve.c..23530, #r)) == $in_struct_extent_of(#q, $ptr(^_ENTRY.Reserve.c..23530, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_ENTRY.Reserve.c..23530, #r)) } $typed(#s, $ptr(^_ENTRY.Reserve.c..23530, #r)) ==> $in_extent_of(#s, #q, $ptr(^_ENTRY.Reserve.c..23530, #r)) == (#q == $ptr(^_ENTRY.Reserve.c..23530, #r) || $emb(#s, #q) == $ptr(^_ENTRY.Reserve.c..23530, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^_ENTRY.Reserve.c..23530, #r)) } $in_span_of(#q, $ptr(^_ENTRY.Reserve.c..23530, #r)) == (#q == $ptr(^_ENTRY.Reserve.c..23530, #r) || #q == $dot($ptr(^_ENTRY.Reserve.c..23530, #r), _ENTRY.Reserve.c..23530.$owns) || #q == $dot($ptr(^_ENTRY.Reserve.c..23530, #r), _ENTRY.Reserve.c..23530.AsUINT64)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^_ENTRY.Reserve.c..23530) } $state_spans_the_same(#s1, #s2, #p, ^_ENTRY.Reserve.c..23530) == ($mem_eq(#s1, #s2, $dot(#p, _ENTRY.Reserve.c..23530.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _ENTRY.Reserve.c..23530.AsUINT64))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_ENTRY.Reserve.c..23530) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_ENTRY.Reserve.c..23530) == ($mem_eq(#s1, #s2, $dot(#p, _ENTRY.Reserve.c..23530.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _ENTRY.Reserve.c..23530.AsUINT64))));

axiom $is_claimable(^_ENTRY.Reserve.c..23530) == false;

axiom $has_volatile_owns_set(^_ENTRY.Reserve.c..23530) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^_ENTRY.Reserve.c..23530, #r)) } $extent_mutable(#s1, $ptr(^_ENTRY.Reserve.c..23530, #r)) == $mutable(#s1, $ptr(^_ENTRY.Reserve.c..23530, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^_ENTRY.Reserve.c..23530, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^_ENTRY.Reserve.c..23530, #r)) == $is_fresh(#s1, #s2, $ptr(^_ENTRY.Reserve.c..23530, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^_ENTRY.Reserve.c..23530, #r)) } $extent_zero(#s1, $ptr(^_ENTRY.Reserve.c..23530, #r)) == ($mem(#s1, $dot($ptr(^_ENTRY.Reserve.c..23530, #r), _ENTRY.Reserve.c..23530.AsUINT64)) == 0));

const unique _ENTRY.Reserve.c..23530.$owns: $field;

axiom $static_field_properties(_ENTRY.Reserve.c..23530.$owns, ^_ENTRY.Reserve.c..23530);

axiom $is_primitive_non_volatile_field(_ENTRY.Reserve.c..23530.$owns);

axiom (forall #p: $ptr :: { $dot(#p, _ENTRY.Reserve.c..23530.$owns) } $is(#p, ^_ENTRY.Reserve.c..23530) ==> $dot(#p, _ENTRY.Reserve.c..23530.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, _ENTRY.Reserve.c..23530.$owns)) && $extent_hint($dot(#p, _ENTRY.Reserve.c..23530.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _ENTRY.Reserve.c..23530.$owns)) } { $st(#s, $dot(#p, _ENTRY.Reserve.c..23530.$owns)) } $typed2(#s, #p, ^_ENTRY.Reserve.c..23530) ==> $field_properties(#s, #p, _ENTRY.Reserve.c..23530.$owns, ^$#ptrset, false));

axiom $owns_set_field(^_ENTRY.Reserve.c..23530) == _ENTRY.Reserve.c..23530.$owns;

const unique _ENTRY.Reserve.c..23530.AsUINT64: $field;

axiom $static_field_properties(_ENTRY.Reserve.c..23530.AsUINT64, ^_ENTRY.Reserve.c..23530);

axiom $is_primitive_non_volatile_field(_ENTRY.Reserve.c..23530.AsUINT64);

axiom $field_offset(_ENTRY.Reserve.c..23530.AsUINT64) == 0;

axiom (forall #p: $ptr :: { $dot(#p, _ENTRY.Reserve.c..23530.AsUINT64) } $is(#p, ^_ENTRY.Reserve.c..23530) ==> $dot(#p, _ENTRY.Reserve.c..23530.AsUINT64) == $ptr(^^u8, $ref(#p) + 0) && $extent_hint($dot(#p, _ENTRY.Reserve.c..23530.AsUINT64), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _ENTRY.Reserve.c..23530.AsUINT64)) } { $st(#s, $dot(#p, _ENTRY.Reserve.c..23530.AsUINT64)) } $typed2(#s, #p, ^_ENTRY.Reserve.c..23530) ==> $field_properties(#s, #p, _ENTRY.Reserve.c..23530.AsUINT64, ^^u8, false));

const unique ^_ENTRY.Reserve.c..23530.Reserve.c..23557: $ctype;

axiom $is_composite(^_ENTRY.Reserve.c..23530.Reserve.c..23557);

axiom $ptr_level(^_ENTRY.Reserve.c..23530.Reserve.c..23557) == 0;

axiom $sizeof(^_ENTRY.Reserve.c..23530.Reserve.c..23557) == 8;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_ENTRY.Reserve.c..23530.Reserve.c..23557) } $inv2(#s1, #s2, #p, ^_ENTRY.Reserve.c..23530.Reserve.c..23557) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty())));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r), l#public) } $inv_lab(#s2, $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r), l#public) == ($typed(#s2, $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r)) && $set_eq($owns(#s2, $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r)), $set_empty())));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r)) } $in_full_extent_of(#q, $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r)) == (#q == $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r) || #q == $dot($ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r), _ENTRY.Reserve.c..23530.Reserve.c..23557.$owns) || #q == $dot($ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r), _ENTRY.Reserve.c..23530.Reserve.c..23557.bitfield#0)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r)) } $in_extent_of(#s, #q, $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r)) == $in_struct_extent_of(#q, $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r)) } $typed(#s, $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r)) ==> $in_extent_of(#s, #q, $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r)) == (#q == $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r) || $emb(#s, #q) == $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r)) } $in_span_of(#q, $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r)) == (#q == $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r) || #q == $dot($ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r), _ENTRY.Reserve.c..23530.Reserve.c..23557.$owns) || #q == $dot($ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r), _ENTRY.Reserve.c..23530.Reserve.c..23557.bitfield#0)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^_ENTRY.Reserve.c..23530.Reserve.c..23557) } $state_spans_the_same(#s1, #s2, #p, ^_ENTRY.Reserve.c..23530.Reserve.c..23557) == ($mem_eq(#s1, #s2, $dot(#p, _ENTRY.Reserve.c..23530.Reserve.c..23557.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _ENTRY.Reserve.c..23530.Reserve.c..23557.bitfield#0))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_ENTRY.Reserve.c..23530.Reserve.c..23557) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_ENTRY.Reserve.c..23530.Reserve.c..23557) == ($mem_eq(#s1, #s2, $dot(#p, _ENTRY.Reserve.c..23530.Reserve.c..23557.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _ENTRY.Reserve.c..23530.Reserve.c..23557.bitfield#0))));

axiom $is_claimable(^_ENTRY.Reserve.c..23530.Reserve.c..23557) == false;

axiom $has_volatile_owns_set(^_ENTRY.Reserve.c..23530.Reserve.c..23557) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r)) } $extent_mutable(#s1, $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r)) == $mutable(#s1, $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r)) == $is_fresh(#s1, #s2, $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r)) } $extent_zero(#s1, $ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r)) == ($mem(#s1, $dot($ptr(^_ENTRY.Reserve.c..23530.Reserve.c..23557, #r), _ENTRY.Reserve.c..23530.Reserve.c..23557.bitfield#0)) == 0));

const unique _ENTRY.Reserve.c..23530.Reserve.c..23557.$owns: $field;

axiom $static_field_properties(_ENTRY.Reserve.c..23530.Reserve.c..23557.$owns, ^_ENTRY.Reserve.c..23530.Reserve.c..23557);

axiom $is_primitive_non_volatile_field(_ENTRY.Reserve.c..23530.Reserve.c..23557.$owns);

axiom (forall #p: $ptr :: { $dot(#p, _ENTRY.Reserve.c..23530.Reserve.c..23557.$owns) } $is(#p, ^_ENTRY.Reserve.c..23530.Reserve.c..23557) ==> $dot(#p, _ENTRY.Reserve.c..23530.Reserve.c..23557.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, _ENTRY.Reserve.c..23530.Reserve.c..23557.$owns)) && $extent_hint($dot(#p, _ENTRY.Reserve.c..23530.Reserve.c..23557.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _ENTRY.Reserve.c..23530.Reserve.c..23557.$owns)) } { $st(#s, $dot(#p, _ENTRY.Reserve.c..23530.Reserve.c..23557.$owns)) } $typed2(#s, #p, ^_ENTRY.Reserve.c..23530.Reserve.c..23557) ==> $field_properties(#s, #p, _ENTRY.Reserve.c..23530.Reserve.c..23557.$owns, ^$#ptrset, false));

axiom $owns_set_field(^_ENTRY.Reserve.c..23530.Reserve.c..23557) == _ENTRY.Reserve.c..23530.Reserve.c..23557.$owns;

const unique _ENTRY.Reserve.c..23530.Reserve.c..23557.bitfield#0: $field;

axiom $static_field_properties(_ENTRY.Reserve.c..23530.Reserve.c..23557.bitfield#0, ^_ENTRY.Reserve.c..23530.Reserve.c..23557);

axiom $is_primitive_non_volatile_field(_ENTRY.Reserve.c..23530.Reserve.c..23557.bitfield#0);

axiom $field_offset(_ENTRY.Reserve.c..23530.Reserve.c..23557.bitfield#0) == 0;

axiom (forall #p: $ptr :: { $dot(#p, _ENTRY.Reserve.c..23530.Reserve.c..23557.bitfield#0) } $is(#p, ^_ENTRY.Reserve.c..23530.Reserve.c..23557) ==> $dot(#p, _ENTRY.Reserve.c..23530.Reserve.c..23557.bitfield#0) == $ptr(^^u8, $ref(#p) + 0) && $extent_hint($dot(#p, _ENTRY.Reserve.c..23530.Reserve.c..23557.bitfield#0), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _ENTRY.Reserve.c..23530.Reserve.c..23557.bitfield#0)) } { $st(#s, $dot(#p, _ENTRY.Reserve.c..23530.Reserve.c..23557.bitfield#0)) } $typed2(#s, #p, ^_ENTRY.Reserve.c..23530.Reserve.c..23557) ==> $field_properties(#s, #p, _ENTRY.Reserve.c..23530.Reserve.c..23557.bitfield#0, ^^u8, false));

const unique ^_ENTRY.Reserve.c..23864: $ctype;

axiom $is_composite(^_ENTRY.Reserve.c..23864);

axiom $ptr_level(^_ENTRY.Reserve.c..23864) == 0;

axiom $sizeof(^_ENTRY.Reserve.c..23864) == 8;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_ENTRY.Reserve.c..23864) } $inv2(#s1, #s2, #p, ^_ENTRY.Reserve.c..23864) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty())));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^_ENTRY.Reserve.c..23864, #r), l#public) } $inv_lab(#s2, $ptr(^_ENTRY.Reserve.c..23864, #r), l#public) == ($typed(#s2, $ptr(^_ENTRY.Reserve.c..23864, #r)) && $set_eq($owns(#s2, $ptr(^_ENTRY.Reserve.c..23864, #r)), $set_empty())));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^_ENTRY.Reserve.c..23864, #r)) } $in_full_extent_of(#q, $ptr(^_ENTRY.Reserve.c..23864, #r)) == (#q == $ptr(^_ENTRY.Reserve.c..23864, #r) || #q == $dot($ptr(^_ENTRY.Reserve.c..23864, #r), _ENTRY.Reserve.c..23864.$owns) || #q == $dot($ptr(^_ENTRY.Reserve.c..23864, #r), _ENTRY.Reserve.c..23864.NextPfn)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_ENTRY.Reserve.c..23864, #r)) } $in_extent_of(#s, #q, $ptr(^_ENTRY.Reserve.c..23864, #r)) == $in_struct_extent_of(#q, $ptr(^_ENTRY.Reserve.c..23864, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_ENTRY.Reserve.c..23864, #r)) } $typed(#s, $ptr(^_ENTRY.Reserve.c..23864, #r)) ==> $in_extent_of(#s, #q, $ptr(^_ENTRY.Reserve.c..23864, #r)) == (#q == $ptr(^_ENTRY.Reserve.c..23864, #r) || $emb(#s, #q) == $ptr(^_ENTRY.Reserve.c..23864, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^_ENTRY.Reserve.c..23864, #r)) } $in_span_of(#q, $ptr(^_ENTRY.Reserve.c..23864, #r)) == (#q == $ptr(^_ENTRY.Reserve.c..23864, #r) || #q == $dot($ptr(^_ENTRY.Reserve.c..23864, #r), _ENTRY.Reserve.c..23864.$owns) || #q == $dot($ptr(^_ENTRY.Reserve.c..23864, #r), _ENTRY.Reserve.c..23864.NextPfn)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^_ENTRY.Reserve.c..23864) } $state_spans_the_same(#s1, #s2, #p, ^_ENTRY.Reserve.c..23864) == ($mem_eq(#s1, #s2, $dot(#p, _ENTRY.Reserve.c..23864.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _ENTRY.Reserve.c..23864.NextPfn))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_ENTRY.Reserve.c..23864) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_ENTRY.Reserve.c..23864) == ($mem_eq(#s1, #s2, $dot(#p, _ENTRY.Reserve.c..23864.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _ENTRY.Reserve.c..23864.NextPfn))));

axiom $is_claimable(^_ENTRY.Reserve.c..23864) == false;

axiom $has_volatile_owns_set(^_ENTRY.Reserve.c..23864) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^_ENTRY.Reserve.c..23864, #r)) } $extent_mutable(#s1, $ptr(^_ENTRY.Reserve.c..23864, #r)) == $mutable(#s1, $ptr(^_ENTRY.Reserve.c..23864, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^_ENTRY.Reserve.c..23864, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^_ENTRY.Reserve.c..23864, #r)) == $is_fresh(#s1, #s2, $ptr(^_ENTRY.Reserve.c..23864, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^_ENTRY.Reserve.c..23864, #r)) } $extent_zero(#s1, $ptr(^_ENTRY.Reserve.c..23864, #r)) == ($mem(#s1, $dot($ptr(^_ENTRY.Reserve.c..23864, #r), _ENTRY.Reserve.c..23864.NextPfn)) == 0));

const unique _ENTRY.Reserve.c..23864.$owns: $field;

axiom $static_field_properties(_ENTRY.Reserve.c..23864.$owns, ^_ENTRY.Reserve.c..23864);

axiom $is_primitive_non_volatile_field(_ENTRY.Reserve.c..23864.$owns);

axiom (forall #p: $ptr :: { $dot(#p, _ENTRY.Reserve.c..23864.$owns) } $is(#p, ^_ENTRY.Reserve.c..23864) ==> $dot(#p, _ENTRY.Reserve.c..23864.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, _ENTRY.Reserve.c..23864.$owns)) && $extent_hint($dot(#p, _ENTRY.Reserve.c..23864.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _ENTRY.Reserve.c..23864.$owns)) } { $st(#s, $dot(#p, _ENTRY.Reserve.c..23864.$owns)) } $typed2(#s, #p, ^_ENTRY.Reserve.c..23864) ==> $field_properties(#s, #p, _ENTRY.Reserve.c..23864.$owns, ^$#ptrset, false));

axiom $owns_set_field(^_ENTRY.Reserve.c..23864) == _ENTRY.Reserve.c..23864.$owns;

const unique _ENTRY.Reserve.c..23864.NextPfn: $field;

axiom $static_field_properties(_ENTRY.Reserve.c..23864.NextPfn, ^_ENTRY.Reserve.c..23864);

axiom $is_primitive_non_volatile_field(_ENTRY.Reserve.c..23864.NextPfn);

axiom $field_offset(_ENTRY.Reserve.c..23864.NextPfn) == 0;

axiom (forall #p: $ptr :: { $dot(#p, _ENTRY.Reserve.c..23864.NextPfn) } $is(#p, ^_ENTRY.Reserve.c..23864) ==> $dot(#p, _ENTRY.Reserve.c..23864.NextPfn) == $ptr($ptr_to(^_ENTRY), $ref(#p) + 0) && $extent_hint($dot(#p, _ENTRY.Reserve.c..23864.NextPfn), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _ENTRY.Reserve.c..23864.NextPfn)) } { $st(#s, $dot(#p, _ENTRY.Reserve.c..23864.NextPfn)) } $typed2(#s, #p, ^_ENTRY.Reserve.c..23864) ==> $field_properties(#s, #p, _ENTRY.Reserve.c..23864.NextPfn, $ptr_to(^_ENTRY), false));

const unique ^_RESERVE: $ctype;

axiom $is_composite(^_RESERVE);

axiom $ptr_level(^_RESERVE) == 0;

axiom $sizeof(^_RESERVE) == 24;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_RESERVE) } $inv2(#s1, #s2, #p, ^_RESERVE) == ($typed(#s2, #p) && $ptr_neq($read_ptr(#s2, $dot(#p, _RESERVE.Compartment), ^^void), $null) && $ptr_eq($read_ptr(#s2, $dot(#p, _RESERVE._ListHead), ^_ENTRY), $ptr_cast($read_ptr(#s2, $dot(#p, _RESERVE.ListHead), ^^void), ^_ENTRY)) && $ptr_eq($read_ptr(#s2, $dot(#p, _RESERVE._ListHead), ^_ENTRY), $null) == ($mem(#s2, $dot(#p, _RESERVE.ListDepth)) == 0) && ($ptr_eq($read_ptr(#s2, $dot(#p, _RESERVE._ListHead), ^_ENTRY), $null) || $set_in0($read_ptr(#s2, $dot(#p, _RESERVE._ListHead), ^_ENTRY), $owns(#s2, #p))) && (forall Q#p$1^50.31#tc1: $ptr :: { $set_in0(Q#p$1^50.31#tc1, $owns(#s2, #p)) } $set_in0(Q#p$1^50.31#tc1, $owns(#s2, #p)) ==> $is(Q#p$1^50.31#tc1, ^_ENTRY) && $typed2(#s2, Q#p$1^50.31#tc1, $typ(Q#p$1^50.31#tc1))) && (forall Q#p$1^51.31#dt1: int :: { $set_in0($read_ptr(#s2, $dot($ptr(^_ENTRY, Q#p$1^51.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY), $owns(#s2, #p)) } $in_range_phys_ptr($ref($ptr(^_ENTRY, Q#p$1^51.31#dt1))) ==> $set_in0($ptr(^_ENTRY, Q#p$1^51.31#dt1), $owns(#s2, #p)) ==> $ptr_eq($read_ptr(#s2, $dot($ptr(^_ENTRY, Q#p$1^51.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY), $null) || $set_in0($read_ptr(#s2, $dot($ptr(^_ENTRY, Q#p$1^51.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY), $owns(#s2, #p))) && (forall Q#p$1^52.31#dt1: int :: { $set_in0($ptr(^_ENTRY, Q#p$1^52.31#dt1), $owns(#s2, #p)) } $in_range_phys_ptr($ref($ptr(^_ENTRY, Q#p$1^52.31#dt1))) ==> $set_in0($ptr(^_ENTRY, Q#p$1^52.31#dt1), $owns(#s2, #p)) ==> $ptr_eq($read_ptr(#s2, $dot($ptr(^_ENTRY, Q#p$1^52.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY), $null) || $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($mem(#s2, $dot(#p, _RESERVE.ListIndex))), $ref($ptr(^_ENTRY, Q#p$1^52.31#dt1))) == $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($mem(#s2, $dot(#p, _RESERVE.ListIndex))), $ref($read_ptr(#s2, $dot($ptr(^_ENTRY, Q#p$1^52.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY))) + 1) && (forall Q#p$1^53.31#dt1: int :: { $set_in0($ptr(^_ENTRY, Q#p$1^53.31#dt1), $owns(#s2, #p)) } $in_range_phys_ptr($ref($ptr(^_ENTRY, Q#p$1^53.31#dt1))) ==> $set_in0($ptr(^_ENTRY, Q#p$1^53.31#dt1), $owns(#s2, #p)) ==> ($select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($mem(#s2, $dot(#p, _RESERVE.ListIndex))), $ref($ptr(^_ENTRY, Q#p$1^53.31#dt1))) == 0) == $ptr_eq($read_ptr(#s2, $dot($ptr(^_ENTRY, Q#p$1^53.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY), $null)) && ($ptr_neq($read_ptr(#s2, $dot(#p, _RESERVE._ListHead), ^_ENTRY), $null) ==> $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($mem(#s2, $dot(#p, _RESERVE.ListIndex))), $ref($read_ptr(#s2, $dot(#p, _RESERVE._ListHead), ^_ENTRY))) + 1 == $mem(#s2, $dot(#p, _RESERVE.ListDepth))) && (forall Q#p$1^55.31#dt1: int :: { $set_in0($ptr(^_ENTRY, Q#p$1^55.31#dt1), $owns(#s2, #p)) } $in_range_phys_ptr($ref($ptr(^_ENTRY, Q#p$1^55.31#dt1))) ==> $set_in0($ptr(^_ENTRY, Q#p$1^55.31#dt1), $owns(#s2, #p)) ==> $mem(#s2, $dot(#p, _RESERVE.ListDepth)) > $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($mem(#s2, $dot(#p, _RESERVE.ListIndex))), $ref($ptr(^_ENTRY, Q#p$1^55.31#dt1)))) && (forall Q#p$1^56.31#dt1: int :: { $set_in0($ptr(^_ENTRY, Q#p$1^56.31#dt1), $owns(#s2, #p)) } $in_range_phys_ptr($ref($ptr(^_ENTRY, Q#p$1^56.31#dt1))) ==> $set_in0($ptr(^_ENTRY, Q#p$1^56.31#dt1), $owns(#s2, #p)) ==> $int_to_bool($bv_extract_unsigned($mem(#s2, $dot($ptr(^_ENTRY, Q#p$1^56.31#dt1), _ENTRY.AsUINT64#nest0)), 64, 8, 9)) && ($int_to_bool($bv_extract_unsigned($mem(#s2, $dot($ptr(^_ENTRY, Q#p$1^56.31#dt1), _ENTRY.AsUINT64#nest0)), 64, 6, 7)) || $int_to_bool($bv_extract_unsigned($mem(#s2, $dot($ptr(^_ENTRY, Q#p$1^56.31#dt1), _ENTRY.AsUINT64#nest0)), 64, 7, 8))))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^_RESERVE, #r), l#public) } $inv_lab(#s2, $ptr(^_RESERVE, #r), l#public) == ($typed(#s2, $ptr(^_RESERVE, #r)) && $ptr_neq($read_ptr(#s2, $dot($ptr(^_RESERVE, #r), _RESERVE.Compartment), ^^void), $null) && $ptr_eq($read_ptr(#s2, $dot($ptr(^_RESERVE, #r), _RESERVE._ListHead), ^_ENTRY), $ptr_cast($read_ptr(#s2, $dot($ptr(^_RESERVE, #r), _RESERVE.ListHead), ^^void), ^_ENTRY)) && $ptr_eq($read_ptr(#s2, $dot($ptr(^_RESERVE, #r), _RESERVE._ListHead), ^_ENTRY), $null) == ($mem(#s2, $dot($ptr(^_RESERVE, #r), _RESERVE.ListDepth)) == 0) && ($ptr_eq($read_ptr(#s2, $dot($ptr(^_RESERVE, #r), _RESERVE._ListHead), ^_ENTRY), $null) || $set_in0($read_ptr(#s2, $dot($ptr(^_RESERVE, #r), _RESERVE._ListHead), ^_ENTRY), $owns(#s2, $ptr(^_RESERVE, #r)))) && (forall Q#p$1^50.31#tc1: $ptr :: { $set_in0(Q#p$1^50.31#tc1, $owns(#s2, $ptr(^_RESERVE, #r))) } $set_in0(Q#p$1^50.31#tc1, $owns(#s2, $ptr(^_RESERVE, #r))) ==> $is(Q#p$1^50.31#tc1, ^_ENTRY) && $typed2(#s2, Q#p$1^50.31#tc1, $typ(Q#p$1^50.31#tc1))) && (forall Q#p$1^51.31#dt1: int :: { $set_in0($read_ptr(#s2, $dot($ptr(^_ENTRY, Q#p$1^51.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY), $owns(#s2, $ptr(^_RESERVE, #r))) } $in_range_phys_ptr($ref($ptr(^_ENTRY, Q#p$1^51.31#dt1))) ==> $set_in0($ptr(^_ENTRY, Q#p$1^51.31#dt1), $owns(#s2, $ptr(^_RESERVE, #r))) ==> $ptr_eq($read_ptr(#s2, $dot($ptr(^_ENTRY, Q#p$1^51.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY), $null) || $set_in0($read_ptr(#s2, $dot($ptr(^_ENTRY, Q#p$1^51.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY), $owns(#s2, $ptr(^_RESERVE, #r)))) && (forall Q#p$1^52.31#dt1: int :: { $set_in0($ptr(^_ENTRY, Q#p$1^52.31#dt1), $owns(#s2, $ptr(^_RESERVE, #r))) } $in_range_phys_ptr($ref($ptr(^_ENTRY, Q#p$1^52.31#dt1))) ==> $set_in0($ptr(^_ENTRY, Q#p$1^52.31#dt1), $owns(#s2, $ptr(^_RESERVE, #r))) ==> $ptr_eq($read_ptr(#s2, $dot($ptr(^_ENTRY, Q#p$1^52.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY), $null) || $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($mem(#s2, $dot($ptr(^_RESERVE, #r), _RESERVE.ListIndex))), $ref($ptr(^_ENTRY, Q#p$1^52.31#dt1))) == $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($mem(#s2, $dot($ptr(^_RESERVE, #r), _RESERVE.ListIndex))), $ref($read_ptr(#s2, $dot($ptr(^_ENTRY, Q#p$1^52.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY))) + 1) && (forall Q#p$1^53.31#dt1: int :: { $set_in0($ptr(^_ENTRY, Q#p$1^53.31#dt1), $owns(#s2, $ptr(^_RESERVE, #r))) } $in_range_phys_ptr($ref($ptr(^_ENTRY, Q#p$1^53.31#dt1))) ==> $set_in0($ptr(^_ENTRY, Q#p$1^53.31#dt1), $owns(#s2, $ptr(^_RESERVE, #r))) ==> ($select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($mem(#s2, $dot($ptr(^_RESERVE, #r), _RESERVE.ListIndex))), $ref($ptr(^_ENTRY, Q#p$1^53.31#dt1))) == 0) == $ptr_eq($read_ptr(#s2, $dot($ptr(^_ENTRY, Q#p$1^53.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY), $null)) && ($ptr_neq($read_ptr(#s2, $dot($ptr(^_RESERVE, #r), _RESERVE._ListHead), ^_ENTRY), $null) ==> $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($mem(#s2, $dot($ptr(^_RESERVE, #r), _RESERVE.ListIndex))), $ref($read_ptr(#s2, $dot($ptr(^_RESERVE, #r), _RESERVE._ListHead), ^_ENTRY))) + 1 == $mem(#s2, $dot($ptr(^_RESERVE, #r), _RESERVE.ListDepth))) && (forall Q#p$1^55.31#dt1: int :: { $set_in0($ptr(^_ENTRY, Q#p$1^55.31#dt1), $owns(#s2, $ptr(^_RESERVE, #r))) } $in_range_phys_ptr($ref($ptr(^_ENTRY, Q#p$1^55.31#dt1))) ==> $set_in0($ptr(^_ENTRY, Q#p$1^55.31#dt1), $owns(#s2, $ptr(^_RESERVE, #r))) ==> $mem(#s2, $dot($ptr(^_RESERVE, #r), _RESERVE.ListDepth)) > $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($mem(#s2, $dot($ptr(^_RESERVE, #r), _RESERVE.ListIndex))), $ref($ptr(^_ENTRY, Q#p$1^55.31#dt1)))) && (forall Q#p$1^56.31#dt1: int :: { $set_in0($ptr(^_ENTRY, Q#p$1^56.31#dt1), $owns(#s2, $ptr(^_RESERVE, #r))) } $in_range_phys_ptr($ref($ptr(^_ENTRY, Q#p$1^56.31#dt1))) ==> $set_in0($ptr(^_ENTRY, Q#p$1^56.31#dt1), $owns(#s2, $ptr(^_RESERVE, #r))) ==> $int_to_bool($bv_extract_unsigned($mem(#s2, $dot($ptr(^_ENTRY, Q#p$1^56.31#dt1), _ENTRY.AsUINT64#nest0)), 64, 8, 9)) && ($int_to_bool($bv_extract_unsigned($mem(#s2, $dot($ptr(^_ENTRY, Q#p$1^56.31#dt1), _ENTRY.AsUINT64#nest0)), 64, 6, 7)) || $int_to_bool($bv_extract_unsigned($mem(#s2, $dot($ptr(^_ENTRY, Q#p$1^56.31#dt1), _ENTRY.AsUINT64#nest0)), 64, 7, 8))))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^_RESERVE, #r)) } $in_full_extent_of(#q, $ptr(^_RESERVE, #r)) == (#q == $ptr(^_RESERVE, #r) || #q == $dot($ptr(^_RESERVE, #r), _RESERVE.$owns) || #q == $dot($ptr(^_RESERVE, #r), _RESERVE.Compartment) || #q == $dot($ptr(^_RESERVE, #r), _RESERVE.ListHead) || #q == $dot($ptr(^_RESERVE, #r), _RESERVE.ListDepth) || #q == $dot($ptr(^_RESERVE, #r), _RESERVE.ListIndex) || #q == $dot($ptr(^_RESERVE, #r), _RESERVE._ListHead)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_RESERVE, #r)) } $in_extent_of(#s, #q, $ptr(^_RESERVE, #r)) == $in_struct_extent_of(#q, $ptr(^_RESERVE, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_RESERVE, #r)) } $typed(#s, $ptr(^_RESERVE, #r)) ==> $in_extent_of(#s, #q, $ptr(^_RESERVE, #r)) == (#q == $ptr(^_RESERVE, #r) || $emb(#s, #q) == $ptr(^_RESERVE, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^_RESERVE, #r)) } $in_span_of(#q, $ptr(^_RESERVE, #r)) == (#q == $ptr(^_RESERVE, #r) || #q == $dot($ptr(^_RESERVE, #r), _RESERVE.$owns) || #q == $dot($ptr(^_RESERVE, #r), _RESERVE.Compartment) || #q == $dot($ptr(^_RESERVE, #r), _RESERVE.ListHead) || #q == $dot($ptr(^_RESERVE, #r), _RESERVE.ListDepth) || #q == $dot($ptr(^_RESERVE, #r), _RESERVE.ListIndex) || #q == $dot($ptr(^_RESERVE, #r), _RESERVE._ListHead)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^_RESERVE) } $state_spans_the_same(#s1, #s2, #p, ^_RESERVE) == ($mem_eq(#s1, #s2, $dot(#p, _RESERVE.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _RESERVE.Compartment)) && $mem_eq(#s1, #s2, $dot(#p, _RESERVE.ListHead)) && $mem_eq(#s1, #s2, $dot(#p, _RESERVE.ListDepth)) && $mem_eq(#s1, #s2, $dot(#p, _RESERVE.ListIndex)) && $mem_eq(#s1, #s2, $dot(#p, _RESERVE._ListHead))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_RESERVE) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_RESERVE) == ($mem_eq(#s1, #s2, $dot(#p, _RESERVE.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _RESERVE.Compartment)) && $mem_eq(#s1, #s2, $dot(#p, _RESERVE.ListHead)) && $mem_eq(#s1, #s2, $dot(#p, _RESERVE.ListDepth)) && $mem_eq(#s1, #s2, $dot(#p, _RESERVE.ListIndex)) && $mem_eq(#s1, #s2, $dot(#p, _RESERVE._ListHead))));

axiom $is_claimable(^_RESERVE) == false;

axiom $has_volatile_owns_set(^_RESERVE) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^_RESERVE, #r)) } $extent_mutable(#s1, $ptr(^_RESERVE, #r)) == $mutable(#s1, $ptr(^_RESERVE, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^_RESERVE, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^_RESERVE, #r)) == $is_fresh(#s1, #s2, $ptr(^_RESERVE, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^_RESERVE, #r)) } $extent_zero(#s1, $ptr(^_RESERVE, #r)) == ($mem(#s1, $dot($ptr(^_RESERVE, #r), _RESERVE.Compartment)) == 0 && $mem(#s1, $dot($ptr(^_RESERVE, #r), _RESERVE.ListHead)) == 0 && $mem(#s1, $dot($ptr(^_RESERVE, #r), _RESERVE.ListDepth)) == 0 && $mem(#s1, $dot($ptr(^_RESERVE, #r), _RESERVE.ListIndex)) == 0 && $mem(#s1, $dot($ptr(^_RESERVE, #r), _RESERVE._ListHead)) == 0));

const unique _RESERVE.$owns: $field;

axiom $static_field_properties(_RESERVE.$owns, ^_RESERVE);

axiom $is_primitive_non_volatile_field(_RESERVE.$owns);

axiom (forall #p: $ptr :: { $dot(#p, _RESERVE.$owns) } $is(#p, ^_RESERVE) ==> $dot(#p, _RESERVE.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, _RESERVE.$owns)) && $extent_hint($dot(#p, _RESERVE.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _RESERVE.$owns)) } { $st(#s, $dot(#p, _RESERVE.$owns)) } $typed2(#s, #p, ^_RESERVE) ==> $field_properties(#s, #p, _RESERVE.$owns, ^$#ptrset, false));

axiom $owns_set_field(^_RESERVE) == _RESERVE.$owns;

const unique _RESERVE.Compartment: $field;

axiom $static_field_properties(_RESERVE.Compartment, ^_RESERVE);

axiom $is_primitive_non_volatile_field(_RESERVE.Compartment);

axiom $field_offset(_RESERVE.Compartment) == 0;

axiom (forall #p: $ptr :: { $dot(#p, _RESERVE.Compartment) } $is(#p, ^_RESERVE) ==> $dot(#p, _RESERVE.Compartment) == $ptr($ptr_to(^^void), $ref(#p) + 0) && $extent_hint($dot(#p, _RESERVE.Compartment), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _RESERVE.Compartment)) } { $st(#s, $dot(#p, _RESERVE.Compartment)) } $typed2(#s, #p, ^_RESERVE) ==> $field_properties(#s, #p, _RESERVE.Compartment, $ptr_to(^^void), false));

const unique _RESERVE.ListHead: $field;

axiom $static_field_properties(_RESERVE.ListHead, ^_RESERVE);

axiom $is_primitive_non_volatile_field(_RESERVE.ListHead);

axiom $field_offset(_RESERVE.ListHead) == 8;

axiom (forall #p: $ptr :: { $dot(#p, _RESERVE.ListHead) } $is(#p, ^_RESERVE) ==> $dot(#p, _RESERVE.ListHead) == $ptr($ptr_to(^^void), $ref(#p) + 8) && $extent_hint($dot(#p, _RESERVE.ListHead), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _RESERVE.ListHead)) } { $st(#s, $dot(#p, _RESERVE.ListHead)) } $typed2(#s, #p, ^_RESERVE) ==> $field_properties(#s, #p, _RESERVE.ListHead, $ptr_to(^^void), false));

const unique _RESERVE.ListDepth: $field;

axiom $static_field_properties(_RESERVE.ListDepth, ^_RESERVE);

axiom $is_primitive_non_volatile_field(_RESERVE.ListDepth);

axiom $field_offset(_RESERVE.ListDepth) == 16;

axiom (forall #p: $ptr :: { $dot(#p, _RESERVE.ListDepth) } $is(#p, ^_RESERVE) ==> $dot(#p, _RESERVE.ListDepth) == $ptr(^^u8, $ref(#p) + 16) && $extent_hint($dot(#p, _RESERVE.ListDepth), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _RESERVE.ListDepth)) } { $st(#s, $dot(#p, _RESERVE.ListDepth)) } $typed2(#s, #p, ^_RESERVE) ==> $field_properties(#s, #p, _RESERVE.ListDepth, ^^u8, false));

const unique _RESERVE.ListIndex: $field;

axiom $static_field_properties(_RESERVE.ListIndex, ^_RESERVE);

axiom $is_primitive_non_volatile_field(_RESERVE.ListIndex);

axiom (forall #p: $ptr :: { $dot(#p, _RESERVE.ListIndex) } $is(#p, ^_RESERVE) ==> $dot(#p, _RESERVE.ListIndex) == $ptr($map_t($ptr_to(^_ENTRY), ^^u8), $ghost_ref(#p, _RESERVE.ListIndex)) && $extent_hint($dot(#p, _RESERVE.ListIndex), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _RESERVE.ListIndex)) } { $st(#s, $dot(#p, _RESERVE.ListIndex)) } $typed2(#s, #p, ^_RESERVE) ==> $field_properties(#s, #p, _RESERVE.ListIndex, $map_t($ptr_to(^_ENTRY), ^^u8), false));

const unique _RESERVE._ListHead: $field;

axiom $static_field_properties(_RESERVE._ListHead, ^_RESERVE);

axiom $is_primitive_non_volatile_field(_RESERVE._ListHead);

axiom (forall #p: $ptr :: { $dot(#p, _RESERVE._ListHead) } $is(#p, ^_RESERVE) ==> $dot(#p, _RESERVE._ListHead) == $ptr($ptr_to(^_ENTRY), $ghost_ref(#p, _RESERVE._ListHead)) && $extent_hint($dot(#p, _RESERVE._ListHead), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _RESERVE._ListHead)) } { $st(#s, $dot(#p, _RESERVE._ListHead)) } $typed2(#s, #p, ^_RESERVE) ==> $field_properties(#s, #p, _RESERVE._ListHead, $ptr_to(^_ENTRY), false));

procedure _RESERVE#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE.Compartment), ^^void), $null);
  ensures $is_admissibility_check() ==> $ptr_eq($read_ptr($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE._ListHead), ^_ENTRY), $ptr_cast($read_ptr($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE.ListHead), ^^void), ^_ENTRY));
  ensures $is_admissibility_check() ==> $ptr_eq($read_ptr($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE._ListHead), ^_ENTRY), $null) == ($mem($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE.ListDepth)) == 0);
  ensures $is_admissibility_check() ==> $ptr_eq($read_ptr($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE._ListHead), ^_ENTRY), $null) || $set_in0($read_ptr($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE._ListHead), ^_ENTRY), $owns($s, $ptr(^_RESERVE, P#_this_)));
  ensures $is_admissibility_check() ==> (forall Q#p$1^50.31#tc1: $ptr :: { $set_in0(Q#p$1^50.31#tc1, $owns($s, $ptr(^_RESERVE, P#_this_))) } $set_in0(Q#p$1^50.31#tc1, $owns($s, $ptr(^_RESERVE, P#_this_))) ==> $is(Q#p$1^50.31#tc1, ^_ENTRY) && $typed2($s, Q#p$1^50.31#tc1, $typ(Q#p$1^50.31#tc1)));
  ensures $is_admissibility_check() ==> (forall Q#p$1^51.31#dt1: int :: { $set_in0($read_ptr($s, $dot($ptr(^_ENTRY, Q#p$1^51.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY), $owns($s, $ptr(^_RESERVE, P#_this_))) } $in_range_phys_ptr($ref($ptr(^_ENTRY, Q#p$1^51.31#dt1))) ==> $set_in0($ptr(^_ENTRY, Q#p$1^51.31#dt1), $owns($s, $ptr(^_RESERVE, P#_this_))) ==> $ptr_eq($read_ptr($s, $dot($ptr(^_ENTRY, Q#p$1^51.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY), $null) || $set_in0($read_ptr($s, $dot($ptr(^_ENTRY, Q#p$1^51.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY), $owns($s, $ptr(^_RESERVE, P#_this_))));
  ensures $is_admissibility_check() ==> (forall Q#p$1^52.31#dt1: int :: { $set_in0($ptr(^_ENTRY, Q#p$1^52.31#dt1), $owns($s, $ptr(^_RESERVE, P#_this_))) } $in_range_phys_ptr($ref($ptr(^_ENTRY, Q#p$1^52.31#dt1))) ==> $set_in0($ptr(^_ENTRY, Q#p$1^52.31#dt1), $owns($s, $ptr(^_RESERVE, P#_this_))) ==> $ptr_eq($read_ptr($s, $dot($ptr(^_ENTRY, Q#p$1^52.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY), $null) || $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($mem($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE.ListIndex))), $ref($ptr(^_ENTRY, Q#p$1^52.31#dt1))) == $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($mem($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE.ListIndex))), $ref($read_ptr($s, $dot($ptr(^_ENTRY, Q#p$1^52.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY))) + 1);
  ensures $is_admissibility_check() ==> (forall Q#p$1^53.31#dt1: int :: { $set_in0($ptr(^_ENTRY, Q#p$1^53.31#dt1), $owns($s, $ptr(^_RESERVE, P#_this_))) } $in_range_phys_ptr($ref($ptr(^_ENTRY, Q#p$1^53.31#dt1))) ==> $set_in0($ptr(^_ENTRY, Q#p$1^53.31#dt1), $owns($s, $ptr(^_RESERVE, P#_this_))) ==> ($select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($mem($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE.ListIndex))), $ref($ptr(^_ENTRY, Q#p$1^53.31#dt1))) == 0) == $ptr_eq($read_ptr($s, $dot($ptr(^_ENTRY, Q#p$1^53.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY), $null));
  ensures $is_admissibility_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE._ListHead), ^_ENTRY), $null) ==> $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($mem($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE.ListIndex))), $ref($read_ptr($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE._ListHead), ^_ENTRY))) + 1 == $mem($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE.ListDepth));
  ensures $is_admissibility_check() ==> (forall Q#p$1^55.31#dt1: int :: { $set_in0($ptr(^_ENTRY, Q#p$1^55.31#dt1), $owns($s, $ptr(^_RESERVE, P#_this_))) } $in_range_phys_ptr($ref($ptr(^_ENTRY, Q#p$1^55.31#dt1))) ==> $set_in0($ptr(^_ENTRY, Q#p$1^55.31#dt1), $owns($s, $ptr(^_RESERVE, P#_this_))) ==> $mem($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE.ListDepth)) > $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($mem($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE.ListIndex))), $ref($ptr(^_ENTRY, Q#p$1^55.31#dt1))));
  ensures $is_admissibility_check() ==> (forall Q#p$1^56.31#dt1: int :: { $set_in0($ptr(^_ENTRY, Q#p$1^56.31#dt1), $owns($s, $ptr(^_RESERVE, P#_this_))) } $in_range_phys_ptr($ref($ptr(^_ENTRY, Q#p$1^56.31#dt1))) ==> $set_in0($ptr(^_ENTRY, Q#p$1^56.31#dt1), $owns($s, $ptr(^_RESERVE, P#_this_))) ==> $int_to_bool($bv_extract_unsigned($mem($s, $dot($ptr(^_ENTRY, Q#p$1^56.31#dt1), _ENTRY.AsUINT64#nest0)), 64, 8, 9)) && ($int_to_bool($bv_extract_unsigned($mem($s, $dot($ptr(^_ENTRY, Q#p$1^56.31#dt1), _ENTRY.AsUINT64#nest0)), 64, 6, 7)) || $int_to_bool($bv_extract_unsigned($mem($s, $dot($ptr(^_ENTRY, Q#p$1^56.31#dt1), _ENTRY.AsUINT64#nest0)), 64, 7, 8))));
  ensures $is_unwrap_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE.Compartment), ^^void), $null);
  ensures $is_unwrap_check() ==> $ptr_eq($read_ptr($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE._ListHead), ^_ENTRY), $ptr_cast($read_ptr($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE.ListHead), ^^void), ^_ENTRY));
  ensures $is_unwrap_check() ==> $ptr_eq($read_ptr($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE._ListHead), ^_ENTRY), $null) == ($mem($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE.ListDepth)) == 0);
  ensures $is_unwrap_check() ==> $ptr_eq($read_ptr($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE._ListHead), ^_ENTRY), $null) || $set_in0($read_ptr($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE._ListHead), ^_ENTRY), $owns($s, $ptr(^_RESERVE, P#_this_)));
  ensures $is_unwrap_check() ==> (forall Q#p$1^50.31#tc1: $ptr :: { $set_in0(Q#p$1^50.31#tc1, $owns($s, $ptr(^_RESERVE, P#_this_))) } $set_in0(Q#p$1^50.31#tc1, $owns($s, $ptr(^_RESERVE, P#_this_))) ==> $is(Q#p$1^50.31#tc1, ^_ENTRY) && $typed2($s, Q#p$1^50.31#tc1, $typ(Q#p$1^50.31#tc1)));
  ensures $is_unwrap_check() ==> (forall Q#p$1^51.31#dt1: int :: { $set_in0($read_ptr($s, $dot($ptr(^_ENTRY, Q#p$1^51.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY), $owns($s, $ptr(^_RESERVE, P#_this_))) } $in_range_phys_ptr($ref($ptr(^_ENTRY, Q#p$1^51.31#dt1))) ==> $set_in0($ptr(^_ENTRY, Q#p$1^51.31#dt1), $owns($s, $ptr(^_RESERVE, P#_this_))) ==> $ptr_eq($read_ptr($s, $dot($ptr(^_ENTRY, Q#p$1^51.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY), $null) || $set_in0($read_ptr($s, $dot($ptr(^_ENTRY, Q#p$1^51.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY), $owns($s, $ptr(^_RESERVE, P#_this_))));
  ensures $is_unwrap_check() ==> (forall Q#p$1^52.31#dt1: int :: { $set_in0($ptr(^_ENTRY, Q#p$1^52.31#dt1), $owns($s, $ptr(^_RESERVE, P#_this_))) } $in_range_phys_ptr($ref($ptr(^_ENTRY, Q#p$1^52.31#dt1))) ==> $set_in0($ptr(^_ENTRY, Q#p$1^52.31#dt1), $owns($s, $ptr(^_RESERVE, P#_this_))) ==> $ptr_eq($read_ptr($s, $dot($ptr(^_ENTRY, Q#p$1^52.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY), $null) || $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($mem($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE.ListIndex))), $ref($ptr(^_ENTRY, Q#p$1^52.31#dt1))) == $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($mem($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE.ListIndex))), $ref($read_ptr($s, $dot($ptr(^_ENTRY, Q#p$1^52.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY))) + 1);
  ensures $is_unwrap_check() ==> (forall Q#p$1^53.31#dt1: int :: { $set_in0($ptr(^_ENTRY, Q#p$1^53.31#dt1), $owns($s, $ptr(^_RESERVE, P#_this_))) } $in_range_phys_ptr($ref($ptr(^_ENTRY, Q#p$1^53.31#dt1))) ==> $set_in0($ptr(^_ENTRY, Q#p$1^53.31#dt1), $owns($s, $ptr(^_RESERVE, P#_this_))) ==> ($select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($mem($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE.ListIndex))), $ref($ptr(^_ENTRY, Q#p$1^53.31#dt1))) == 0) == $ptr_eq($read_ptr($s, $dot($ptr(^_ENTRY, Q#p$1^53.31#dt1), _ENTRY.NextPfn#nest1), ^_ENTRY), $null));
  ensures $is_unwrap_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE._ListHead), ^_ENTRY), $null) ==> $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($mem($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE.ListIndex))), $ref($read_ptr($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE._ListHead), ^_ENTRY))) + 1 == $mem($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE.ListDepth));
  ensures $is_unwrap_check() ==> (forall Q#p$1^55.31#dt1: int :: { $set_in0($ptr(^_ENTRY, Q#p$1^55.31#dt1), $owns($s, $ptr(^_RESERVE, P#_this_))) } $in_range_phys_ptr($ref($ptr(^_ENTRY, Q#p$1^55.31#dt1))) ==> $set_in0($ptr(^_ENTRY, Q#p$1^55.31#dt1), $owns($s, $ptr(^_RESERVE, P#_this_))) ==> $mem($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE.ListDepth)) > $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($mem($s, $dot($ptr(^_RESERVE, P#_this_), _RESERVE.ListIndex))), $ref($ptr(^_ENTRY, Q#p$1^55.31#dt1))));
  ensures $is_unwrap_check() ==> (forall Q#p$1^56.31#dt1: int :: { $set_in0($ptr(^_ENTRY, Q#p$1^56.31#dt1), $owns($s, $ptr(^_RESERVE, P#_this_))) } $in_range_phys_ptr($ref($ptr(^_ENTRY, Q#p$1^56.31#dt1))) ==> $set_in0($ptr(^_ENTRY, Q#p$1^56.31#dt1), $owns($s, $ptr(^_RESERVE, P#_this_))) ==> $int_to_bool($bv_extract_unsigned($mem($s, $dot($ptr(^_ENTRY, Q#p$1^56.31#dt1), _ENTRY.AsUINT64#nest0)), 64, 8, 9)) && ($int_to_bool($bv_extract_unsigned($mem($s, $dot($ptr(^_ENTRY, Q#p$1^56.31#dt1), _ENTRY.AsUINT64#nest0)), 64, 6, 7)) || $int_to_bool($bv_extract_unsigned($mem($s, $dot($ptr(^_ENTRY, Q#p$1^56.31#dt1), _ENTRY.AsUINT64#nest0)), 64, 7, 8))));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _RESERVE#adm(P#_this_: int)
{
  var #wrTime$1^37.39: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^37.39, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^37.39, #loc._this_, $ptr_to_int($ptr(^_RESERVE, P#_this_)), $ptr_to(^_RESERVE)) && $local_value_is_ptr($s, #tok$1^37.39, #loc._this_, $ptr(^_RESERVE, P#_this_), $ptr_to(^_RESERVE));
    assume #wrTime$1^37.39 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^37.39, #p) } $in_writes_at(#wrTime$1^37.39, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^_RESERVE, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^_RESERVE, P#_this_));
        assume $good_state_ext(#tok$1^37.39, $s);
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
            assume $admissibility_pre($s, $ptr(^_RESERVE, P#_this_));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^_RESERVE, P#_this_));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct _RESERVE*)@null))
        call $havoc_others($ptr(^_RESERVE, P#_this_), ^_RESERVE);
        assume $good_state_ext(#tok$1^37.39, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^_RESERVE, P#_this_), ^_RESERVE);
    }

  #exit:
}



procedure Check(P#Reserve: int);
  requires $wrapped($s, $ptr(^_RESERVE, P#Reserve), ^_RESERVE);
  modifies $s, $cev_pc;
  ensures $wrapped($s, $ptr(^_RESERVE, P#Reserve), ^_RESERVE);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Check(P#Reserve: int)
{
  var loopState#0: $state;
  var L#pageCount: int where $in_range_u8(L#pageCount);
  var L#pfn: int where $in_range_phys_ptr(L#pfn);
  var #wrTime$1^60.1: int;
  var #stackframe: int;

  anon10:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^60.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^60.1, #loc.Reserve, $ptr_to_int($ptr(^_RESERVE, P#Reserve)), $ptr_to(^_RESERVE)) && $local_value_is_ptr($s, #tok$1^60.1, #loc.Reserve, $ptr(^_RESERVE, P#Reserve), $ptr_to(^_RESERVE));
    assume #wrTime$1^60.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^60.1, #p) } $in_writes_at(#wrTime$1^60.1, #p) == false);
    // assume @in_range_phys_ptr((mathint)Reserve); 
    assume $in_range_phys_ptr($ref($ptr(^_RESERVE, P#Reserve)));
    // assert @_vcc_in_domain(@state, Reserve, Reserve); 
    assert $in_domain_lab($s, $ptr(^_RESERVE, P#Reserve), $ptr(^_RESERVE, P#Reserve), l#public);
    // struct _ENTRY* pfn; 
    assume $local_value_is($s, #tok$1^65.5, #loc.pfn, $ptr_to_int($ptr(^_ENTRY, L#pfn)), $ptr_to(^_ENTRY)) && $local_value_is_ptr($s, #tok$1^65.5, #loc.pfn, $ptr(^_ENTRY, L#pfn), $ptr_to(^_ENTRY));
    // uint64_t pageCount; 
    assume $local_value_is($s, #tok$1^64.5, #loc.pageCount, L#pageCount, ^^u8);
    // var uint64_t pageCount
    // var struct _ENTRY* pfn
    // assert @_vcc_ptr_neq(Reserve, @null); 
    assert $ptr_neq($ptr(^_RESERVE, P#Reserve), $null);
    // assume @_vcc_ptr_neq(Reserve, @null); 
    assume $ptr_neq($ptr(^_RESERVE, P#Reserve), $null);
    // assert @_vcc_ptr_neq(*((Reserve->Compartment)), @null); 
    assert $ptr_neq($read_ptr($s, $dot($ptr(^_RESERVE, P#Reserve), _RESERVE.Compartment), ^^void), $null);
    // assume @_vcc_ptr_neq(*((Reserve->Compartment)), @null); 
    assume $ptr_neq($read_ptr($s, $dot($ptr(^_RESERVE, P#Reserve), _RESERVE.Compartment), ^^void), $null);
    // assert @reads_check_normal((Reserve->ListHead)); 
    assert $typed2($s, $dot($ptr(^_RESERVE, P#Reserve), _RESERVE.ListHead), $ptr_to(^^void));
    assert $thread_local2($s, $dot($ptr(^_RESERVE, P#Reserve), _RESERVE.ListHead), $ptr_to(^^void));
    // pfn := (struct _ENTRY*)*((Reserve->ListHead)); 
    L#pfn := $ref($ptr_cast($read_ptr($s, $dot($ptr(^_RESERVE, P#Reserve), _RESERVE.ListHead), ^^void), ^_ENTRY));
    assume $local_value_is($s, #tok$1^70.10, #loc.pfn, $ptr_to_int($ptr(^_ENTRY, L#pfn)), $ptr_to(^_ENTRY)) && $local_value_is_ptr($s, #tok$1^70.10, #loc.pfn, $ptr(^_ENTRY, L#pfn), $ptr_to(^_ENTRY));
    // assert @reads_check_normal((Reserve->ListDepth)); 
    assert $typed2($s, $dot($ptr(^_RESERVE, P#Reserve), _RESERVE.ListDepth), ^^u8);
    assert $thread_local2($s, $dot($ptr(^_RESERVE, P#Reserve), _RESERVE.ListDepth), ^^u8);
    // pageCount := *((Reserve->ListDepth)); 
    L#pageCount := $mem($s, $dot($ptr(^_RESERVE, P#Reserve), _RESERVE.ListDepth));
    assume $local_value_is($s, #tok$1^70.44, #loc.pageCount, L#pageCount, ^^u8);
    loopState#0 := $s;
    while (true)
      invariant $ptr_eq($ptr(^_ENTRY, L#pfn), $null) || $set_in0($ptr(^_ENTRY, L#pfn), $owns($s, $ptr(^_RESERVE, P#Reserve)));
      invariant $ptr_eq($ptr(^_ENTRY, L#pfn), $null) == (L#pageCount == 0);
      invariant $ptr_eq($ptr(^_ENTRY, L#pfn), $null) || L#pageCount == $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($mem($s, $dot($ptr(^_RESERVE, P#Reserve), _RESERVE.ListIndex))), $ref($ptr(^_ENTRY, L#pfn))) + 1;
    {
      anon9:
        assume $writes_nothing(old($s), $s);
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$1^70.5, $s);
        assume $local_value_is($s, #tok$1^70.5, #loc.pageCount, L#pageCount, ^^u8);
        assume $local_value_is($s, #tok$1^70.5, #loc.pfn, $ptr_to_int($ptr(^_ENTRY, L#pfn)), $ptr_to(^_ENTRY)) && $local_value_is_ptr($s, #tok$1^70.5, #loc.pfn, $ptr(^_ENTRY, L#pfn), $ptr_to(^_ENTRY));
        assume $local_value_is($s, #tok$1^70.5, #loc.Reserve, $ptr_to_int($ptr(^_RESERVE, P#Reserve)), $ptr_to(^_RESERVE)) && $local_value_is_ptr($s, #tok$1^70.5, #loc.Reserve, $ptr(^_RESERVE, P#Reserve), $ptr_to(^_RESERVE));
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#0, $s);
        assume true;
        // if (!=(pageCount, 0)) ...
        if (L#pageCount != 0)
        {
          anon7:
            // assert @_vcc_ptr_neq(pfn, @null); 
            assert $ptr_neq($ptr(^_ENTRY, L#pfn), $null);
            // assume @_vcc_ptr_neq(pfn, @null); 
            assume $ptr_neq($ptr(^_ENTRY, L#pfn), $null);
            // assert (_Bool)@bv_extract_unsigned(*((pfn->AsUINT64#nest0)), 64, 8, 9); 
            assert $int_to_bool($bv_extract_unsigned($mem($s, $dot($ptr(^_ENTRY, L#pfn), _ENTRY.AsUINT64#nest0)), 64, 8, 9));
            // assert true; 
            assert true;
            // assume (_Bool)@bv_extract_unsigned(*((pfn->AsUINT64#nest0)), 64, 8, 9); 
            assume $int_to_bool($bv_extract_unsigned($mem($s, $dot($ptr(^_ENTRY, L#pfn), _ENTRY.AsUINT64#nest0)), 64, 8, 9));
            // assert ||((_Bool)@bv_extract_unsigned(*((pfn->AsUINT64#nest0)), 64, 6, 7), (_Bool)@bv_extract_unsigned(*((pfn->AsUINT64#nest0)), 64, 7, 8)); 
            assert $int_to_bool($bv_extract_unsigned($mem($s, $dot($ptr(^_ENTRY, L#pfn), _ENTRY.AsUINT64#nest0)), 64, 6, 7)) || $int_to_bool($bv_extract_unsigned($mem($s, $dot($ptr(^_ENTRY, L#pfn), _ENTRY.AsUINT64#nest0)), 64, 7, 8));
            // assume ||((_Bool)@bv_extract_unsigned(*((pfn->AsUINT64#nest0)), 64, 6, 7), (_Bool)@bv_extract_unsigned(*((pfn->AsUINT64#nest0)), 64, 7, 8)); 
            assume $int_to_bool($bv_extract_unsigned($mem($s, $dot($ptr(^_ENTRY, L#pfn), _ENTRY.AsUINT64#nest0)), 64, 6, 7)) || $int_to_bool($bv_extract_unsigned($mem($s, $dot($ptr(^_ENTRY, L#pfn), _ENTRY.AsUINT64#nest0)), 64, 7, 8));
        }
        else
        {
          anon8:
            // goto #break_1; 
            goto #break_1;
        }

      #continue_1:
        // assert @reads_check_normal((pfn->NextPfn#nest1)); 
        assert $typed2($s, $dot($ptr(^_ENTRY, L#pfn), _ENTRY.NextPfn#nest1), $ptr_to(^_ENTRY));
        assert $thread_local2($s, $dot($ptr(^_ENTRY, L#pfn), _ENTRY.NextPfn#nest1), $ptr_to(^_ENTRY));
        // pfn := *((pfn->NextPfn#nest1)); 
        L#pfn := $ref($read_ptr($s, $dot($ptr(^_ENTRY, L#pfn), _ENTRY.NextPfn#nest1), ^_ENTRY));
        assume $local_value_is($s, #tok$1^72.10, #loc.pfn, $ptr_to_int($ptr(^_ENTRY, L#pfn)), $ptr_to(^_ENTRY)) && $local_value_is_ptr($s, #tok$1^72.10, #loc.pfn, $ptr(^_ENTRY, L#pfn), $ptr_to(^_ENTRY));
        // assert @in_range_u8(-(pageCount, 1)); 
        assert $in_range_u8(L#pageCount - 1);
        // pageCount := -(pageCount, 1); 
        L#pageCount := L#pageCount - 1;
        assume $local_value_is($s, #tok$1^72.30, #loc.pageCount, L#pageCount, ^^u8);
        assume true;
    }

  anon11:
    assume $full_stop_ext(#tok$1^70.5, $s);

  #break_1:
    // assert @_vcc_ptr_eq(pfn, @null); 
    assert $ptr_eq($ptr(^_ENTRY, L#pfn), $null);
    // assume @_vcc_ptr_eq(pfn, @null); 
    assume $ptr_eq($ptr(^_ENTRY, L#pfn), $null);
    // return; 
    assert $position_marker();
    goto #exit;

  anon12:
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



const unique l#public: $label;

type $map_t..$ptr_to..^_ENTRY.^^u8;

function $select.$map_t..$ptr_to..^_ENTRY.^^u8(M: $map_t..$ptr_to..^_ENTRY.^^u8, p: int) : int;

function $store.$map_t..$ptr_to..^_ENTRY.^^u8(M: $map_t..$ptr_to..^_ENTRY.^^u8, p: int, v: int) : $map_t..$ptr_to..^_ENTRY.^^u8;

function $eq.$map_t..$ptr_to..^_ENTRY.^^u8(M1: $map_t..$ptr_to..^_ENTRY.^^u8, M2: $map_t..$ptr_to..^_ENTRY.^^u8) : bool;

const $zero.$map_t..$ptr_to..^_ENTRY.^^u8: $map_t..$ptr_to..^_ENTRY.^^u8;

axiom (forall M: $map_t..$ptr_to..^_ENTRY.^^u8, p: int, v: int :: $select.$map_t..$ptr_to..^_ENTRY.^^u8($store.$map_t..$ptr_to..^_ENTRY.^^u8(M, p, v), p) == $unchecked(^^u8, v));

axiom (forall M: $map_t..$ptr_to..^_ENTRY.^^u8, p: int, v: int, q: int :: p != q ==> $select.$map_t..$ptr_to..^_ENTRY.^^u8($store.$map_t..$ptr_to..^_ENTRY.^^u8(M, q, v), p) == $select.$map_t..$ptr_to..^_ENTRY.^^u8(M, p));

axiom (forall M1: $map_t..$ptr_to..^_ENTRY.^^u8, M2: $map_t..$ptr_to..^_ENTRY.^^u8 :: { $eq.$map_t..$ptr_to..^_ENTRY.^^u8(M1, M2) } (forall p: int :: $unchecked(^^u8, $select.$map_t..$ptr_to..^_ENTRY.^^u8(M1, p)) == $unchecked(^^u8, $select.$map_t..$ptr_to..^_ENTRY.^^u8(M2, p))) ==> $eq.$map_t..$ptr_to..^_ENTRY.^^u8(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^_ENTRY.^^u8, M2: $map_t..$ptr_to..^_ENTRY.^^u8 :: { $eq.$map_t..$ptr_to..^_ENTRY.^^u8(M1, M2) } $eq.$map_t..$ptr_to..^_ENTRY.^^u8(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^_ENTRY.^^u8(0) == $zero.$map_t..$ptr_to..^_ENTRY.^^u8;

axiom (forall p: int :: $select.$map_t..$ptr_to..^_ENTRY.^^u8($zero.$map_t..$ptr_to..^_ENTRY.^^u8, p) == 0);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t($ptr_to(^_ENTRY), ^^u8)) } $eq.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($rec_fetch(r1, f)), $int_to_map_t..ptr_to..^_ENTRY.^^u8($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

axiom (forall M: $map_t..$ptr_to..^_ENTRY.^^u8, p: int :: $in_range_t(^^u8, $select.$map_t..$ptr_to..^_ENTRY.^^u8(M, p)));

const unique #tok$1^72.30: $token;

const unique #tok$1^72.10: $token;

const unique #tok$1^70.5: $token;

const unique #tok$1^70.44: $token;

const unique #tok$1^70.10: $token;

const unique #loc.pageCount: $token;

const unique #tok$1^64.5: $token;

const unique #loc.pfn: $token;

const unique #tok$1^65.5: $token;

const unique #loc.Reserve: $token;

const unique #tok$1^60.1: $token;

const unique #distTp4: $ctype;

axiom #distTp4 == $ptr_to(^_RESERVE);

const unique #loc._this_: $token;

const unique #tok$1^37.39: $token;

function $map_t..ptr_to..^_ENTRY.^^u8_to_int(x: $map_t..$ptr_to..^_ENTRY.^^u8) : int;

function $int_to_map_t..ptr_to..^_ENTRY.^^u8(x: int) : $map_t..$ptr_to..^_ENTRY.^^u8;

axiom (forall #x: $map_t..$ptr_to..^_ENTRY.^^u8 :: #x == $int_to_map_t..ptr_to..^_ENTRY.^^u8($map_t..ptr_to..^_ENTRY.^^u8_to_int(#x)));

const unique #distTp3: $ctype;

axiom #distTp3 == $map_t($ptr_to(^_ENTRY), ^^u8);

axiom $type_code_is(1, $ptr_to(^^void));

const unique #distTp2: $ctype;

axiom #distTp2 == $ptr_to(^^void);

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CReserve.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CReserve.c);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^_ENTRY);
