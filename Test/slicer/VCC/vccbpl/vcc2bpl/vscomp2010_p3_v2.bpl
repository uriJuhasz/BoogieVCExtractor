axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^_LIST_ENTRY: $ctype;

axiom $is_composite(^_LIST_ENTRY);

axiom $ptr_level(^_LIST_ENTRY) == 0;

axiom $sizeof(^_LIST_ENTRY) == 8;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_LIST_ENTRY) } $inv2(#s1, #s2, #p, ^_LIST_ENTRY) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty())));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^_LIST_ENTRY, #r), l#public) } $inv_lab(#s2, $ptr(^_LIST_ENTRY, #r), l#public) == ($typed(#s2, $ptr(^_LIST_ENTRY, #r)) && $set_eq($owns(#s2, $ptr(^_LIST_ENTRY, #r)), $set_empty())));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^_LIST_ENTRY, #r)) } $in_full_extent_of(#q, $ptr(^_LIST_ENTRY, #r)) == (#q == $ptr(^_LIST_ENTRY, #r) || #q == $dot($ptr(^_LIST_ENTRY, #r), _LIST_ENTRY.$owns) || #q == $dot($ptr(^_LIST_ENTRY, #r), _LIST_ENTRY.Flink) || #q == $dot($ptr(^_LIST_ENTRY, #r), _LIST_ENTRY.Blink)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_LIST_ENTRY, #r)) } $in_extent_of(#s, #q, $ptr(^_LIST_ENTRY, #r)) == $in_struct_extent_of(#q, $ptr(^_LIST_ENTRY, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_LIST_ENTRY, #r)) } $typed(#s, $ptr(^_LIST_ENTRY, #r)) ==> $in_extent_of(#s, #q, $ptr(^_LIST_ENTRY, #r)) == (#q == $ptr(^_LIST_ENTRY, #r) || $emb(#s, #q) == $ptr(^_LIST_ENTRY, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^_LIST_ENTRY, #r)) } $in_span_of(#q, $ptr(^_LIST_ENTRY, #r)) == (#q == $ptr(^_LIST_ENTRY, #r) || #q == $dot($ptr(^_LIST_ENTRY, #r), _LIST_ENTRY.$owns) || #q == $dot($ptr(^_LIST_ENTRY, #r), _LIST_ENTRY.Flink) || #q == $dot($ptr(^_LIST_ENTRY, #r), _LIST_ENTRY.Blink)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^_LIST_ENTRY) } $state_spans_the_same(#s1, #s2, #p, ^_LIST_ENTRY) == ($mem_eq(#s1, #s2, $dot(#p, _LIST_ENTRY.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_ENTRY.Flink)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_ENTRY.Blink))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_LIST_ENTRY) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_LIST_ENTRY) == ($mem_eq(#s1, #s2, $dot(#p, _LIST_ENTRY.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_ENTRY.Flink)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_ENTRY.Blink))));

axiom $is_claimable(^_LIST_ENTRY) == false;

axiom $has_volatile_owns_set(^_LIST_ENTRY) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^_LIST_ENTRY, #r)) } $extent_mutable(#s1, $ptr(^_LIST_ENTRY, #r)) == $mutable(#s1, $ptr(^_LIST_ENTRY, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^_LIST_ENTRY, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^_LIST_ENTRY, #r)) == $is_fresh(#s1, #s2, $ptr(^_LIST_ENTRY, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^_LIST_ENTRY, #r)) } $extent_zero(#s1, $ptr(^_LIST_ENTRY, #r)) == ($mem(#s1, $dot($ptr(^_LIST_ENTRY, #r), _LIST_ENTRY.Flink)) == 0 && $mem(#s1, $dot($ptr(^_LIST_ENTRY, #r), _LIST_ENTRY.Blink)) == 0));

const unique _LIST_ENTRY.$owns: $field;

axiom $static_field_properties(_LIST_ENTRY.$owns, ^_LIST_ENTRY);

axiom $is_primitive_non_volatile_field(_LIST_ENTRY.$owns);

axiom (forall #p: $ptr :: { $dot(#p, _LIST_ENTRY.$owns) } $is(#p, ^_LIST_ENTRY) ==> $dot(#p, _LIST_ENTRY.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, _LIST_ENTRY.$owns)) && $extent_hint($dot(#p, _LIST_ENTRY.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _LIST_ENTRY.$owns)) } { $st(#s, $dot(#p, _LIST_ENTRY.$owns)) } $typed2(#s, #p, ^_LIST_ENTRY) ==> $field_properties(#s, #p, _LIST_ENTRY.$owns, ^$#ptrset, false));

axiom $owns_set_field(^_LIST_ENTRY) == _LIST_ENTRY.$owns;

const unique _LIST_ENTRY.Flink: $field;

axiom $static_field_properties(_LIST_ENTRY.Flink, ^_LIST_ENTRY);

axiom $is_primitive_non_volatile_field(_LIST_ENTRY.Flink);

axiom $field_offset(_LIST_ENTRY.Flink) == 0;

axiom (forall #p: $ptr :: { $dot(#p, _LIST_ENTRY.Flink) } $is(#p, ^_LIST_ENTRY) ==> $dot(#p, _LIST_ENTRY.Flink) == $ptr($ptr_to(^_LIST_ENTRY), $ref(#p) + 0) && $extent_hint($dot(#p, _LIST_ENTRY.Flink), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _LIST_ENTRY.Flink)) } { $st(#s, $dot(#p, _LIST_ENTRY.Flink)) } $typed2(#s, #p, ^_LIST_ENTRY) ==> $field_properties(#s, #p, _LIST_ENTRY.Flink, $ptr_to(^_LIST_ENTRY), false));

const unique _LIST_ENTRY.Blink: $field;

axiom $static_field_properties(_LIST_ENTRY.Blink, ^_LIST_ENTRY);

axiom $is_primitive_non_volatile_field(_LIST_ENTRY.Blink);

axiom (forall #p: $ptr :: { $dot(#p, _LIST_ENTRY.Blink) } $is(#p, ^_LIST_ENTRY) ==> $dot(#p, _LIST_ENTRY.Blink) == $ptr($ptr_to(^_LIST_ENTRY), $ghost_ref(#p, _LIST_ENTRY.Blink)) && $extent_hint($dot(#p, _LIST_ENTRY.Blink), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _LIST_ENTRY.Blink)) } { $st(#s, $dot(#p, _LIST_ENTRY.Blink)) } $typed2(#s, #p, ^_LIST_ENTRY) ==> $field_properties(#s, #p, _LIST_ENTRY.Blink, $ptr_to(^_LIST_ENTRY), false));

const unique ^_LIST_MANAGER: $ctype;

axiom $is_composite(^_LIST_MANAGER);

axiom $ptr_level(^_LIST_MANAGER) == 0;

axiom $sizeof(^_LIST_MANAGER) == 1;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_LIST_MANAGER) } $inv2(#s1, #s2, #p, ^_LIST_MANAGER) == ($typed(#s2, #p) && (forall Q#e$1^27.29#dt1: int :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot(#p, _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^27.29#dt1))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^27.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot(#p, _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^27.29#dt1))) ==> $keeps(#s2, #p, $ptr(^_LIST_ENTRY, Q#e$1^27.29#dt1))) && (forall Q#e$1^29.29#dt1: int :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot(#p, _LIST_MANAGER.mem))), $ref($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot(#p, _LIST_MANAGER.mem))), $ref($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot(#p, _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot(#p, _LIST_MANAGER.mem))), $ref($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) && $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1))) && (forall Q#e$1^32.29#dt1: int :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot(#p, _LIST_MANAGER.mem))), $ref($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot(#p, _LIST_MANAGER.mem))), $ref($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot(#p, _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot(#p, _LIST_MANAGER.mem))), $ref($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) && $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1))) && (forall Q#e$1^35.29#dt1: int :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot(#p, _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1))) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot(#p, _LIST_MANAGER.mem))), $ref($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot(#p, _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1))) && $ptr_neq($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1), $ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem(#s2, $dot(#p, _LIST_MANAGER.pointer))), $mem(#s2, $dot(#p, _LIST_MANAGER.size)) - 1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem(#s2, $dot(#p, _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1))) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem(#s2, $dot(#p, _LIST_MANAGER.index))), $ref($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)))) && (forall Q#e$1^38.29#dt1: int :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot(#p, _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1))) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot(#p, _LIST_MANAGER.mem))), $ref($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot(#p, _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1))) && $ptr_neq($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1), $ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem(#s2, $dot(#p, _LIST_MANAGER.pointer))), 0))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem(#s2, $dot(#p, _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1))) - 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem(#s2, $dot(#p, _LIST_MANAGER.index))), $ref($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)))) && (forall Q#i$1^41.29#tc2: int :: 0 <= Q#i$1^41.29#tc2 && Q#i$1^41.29#tc2 < $mem(#s2, $dot(#p, _LIST_MANAGER.size)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem(#s2, $dot(#p, _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem(#s2, $dot(#p, _LIST_MANAGER.pointer))), Q#i$1^41.29#tc2)))) == Q#i$1^41.29#tc2 && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot(#p, _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem(#s2, $dot(#p, _LIST_MANAGER.pointer))), Q#i$1^41.29#tc2))))) && (forall Q#e$1^44.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot(#p, _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1))) ==> 0 <= $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem(#s2, $dot(#p, _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1))) && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem(#s2, $dot(#p, _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1))) < $mem(#s2, $dot(#p, _LIST_MANAGER.size)) && $ptr_eq($ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem(#s2, $dot(#p, _LIST_MANAGER.pointer))), $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem(#s2, $dot(#p, _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1))))), $ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1)))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^_LIST_MANAGER, #r), l#public) } $inv_lab(#s2, $ptr(^_LIST_MANAGER, #r), l#public) == ($typed(#s2, $ptr(^_LIST_MANAGER, #r)) && (forall Q#e$1^27.29#dt1: int :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^27.29#dt1))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^27.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^27.29#dt1))) ==> $keeps(#s2, $ptr(^_LIST_MANAGER, #r), $ptr(^_LIST_ENTRY, Q#e$1^27.29#dt1))) && (forall Q#e$1^29.29#dt1: int :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.mem))), $ref($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.mem))), $ref($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.mem))), $ref($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) && $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1))) && (forall Q#e$1^32.29#dt1: int :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.mem))), $ref($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.mem))), $ref($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.mem))), $ref($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) && $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1))) && (forall Q#e$1^35.29#dt1: int :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1))) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.mem))), $ref($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1))) && $ptr_neq($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1), $ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.pointer))), $mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.size)) - 1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1))) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.index))), $ref($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)))) && (forall Q#e$1^38.29#dt1: int :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1))) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.mem))), $ref($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1))) && $ptr_neq($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1), $ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.pointer))), 0))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1))) - 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.index))), $ref($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)))) && (forall Q#i$1^41.29#tc2: int :: 0 <= Q#i$1^41.29#tc2 && Q#i$1^41.29#tc2 < $mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.size)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.pointer))), Q#i$1^41.29#tc2)))) == Q#i$1^41.29#tc2 && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.pointer))), Q#i$1^41.29#tc2))))) && (forall Q#e$1^44.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1))) ==> 0 <= $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1))) && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1))) < $mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.size)) && $ptr_eq($ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.pointer))), $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1))))), $ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1)))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^_LIST_MANAGER, #r)) } $in_full_extent_of(#q, $ptr(^_LIST_MANAGER, #r)) == (#q == $ptr(^_LIST_MANAGER, #r) || #q == $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.$owns) || #q == $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.size) || #q == $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.index) || #q == $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.pointer) || #q == $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.mem)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_LIST_MANAGER, #r)) } $in_extent_of(#s, #q, $ptr(^_LIST_MANAGER, #r)) == $in_struct_extent_of(#q, $ptr(^_LIST_MANAGER, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_LIST_MANAGER, #r)) } $typed(#s, $ptr(^_LIST_MANAGER, #r)) ==> $in_extent_of(#s, #q, $ptr(^_LIST_MANAGER, #r)) == (#q == $ptr(^_LIST_MANAGER, #r) || $emb(#s, #q) == $ptr(^_LIST_MANAGER, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^_LIST_MANAGER, #r)) } $in_span_of(#q, $ptr(^_LIST_MANAGER, #r)) == (#q == $ptr(^_LIST_MANAGER, #r) || #q == $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.$owns) || #q == $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.size) || #q == $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.index) || #q == $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.pointer) || #q == $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.mem)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^_LIST_MANAGER) } $state_spans_the_same(#s1, #s2, #p, ^_LIST_MANAGER) == ($mem_eq(#s1, #s2, $dot(#p, _LIST_MANAGER.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_MANAGER.size)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_MANAGER.index)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_MANAGER.pointer)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_MANAGER.mem))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_LIST_MANAGER) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_LIST_MANAGER) == ($mem_eq(#s1, #s2, $dot(#p, _LIST_MANAGER.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_MANAGER.size)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_MANAGER.index)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_MANAGER.pointer)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_MANAGER.mem))));

axiom $is_claimable(^_LIST_MANAGER) == false;

axiom $has_volatile_owns_set(^_LIST_MANAGER) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^_LIST_MANAGER, #r)) } $extent_mutable(#s1, $ptr(^_LIST_MANAGER, #r)) == $mutable(#s1, $ptr(^_LIST_MANAGER, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^_LIST_MANAGER, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^_LIST_MANAGER, #r)) == $is_fresh(#s1, #s2, $ptr(^_LIST_MANAGER, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^_LIST_MANAGER, #r)) } $extent_zero(#s1, $ptr(^_LIST_MANAGER, #r)) == ($mem(#s1, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.size)) == 0 && $mem(#s1, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.index)) == 0 && $mem(#s1, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.pointer)) == 0 && $mem(#s1, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.mem)) == 0));

const unique _LIST_MANAGER.$owns: $field;

axiom $static_field_properties(_LIST_MANAGER.$owns, ^_LIST_MANAGER);

axiom $is_primitive_non_volatile_field(_LIST_MANAGER.$owns);

axiom (forall #p: $ptr :: { $dot(#p, _LIST_MANAGER.$owns) } $is(#p, ^_LIST_MANAGER) ==> $dot(#p, _LIST_MANAGER.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, _LIST_MANAGER.$owns)) && $extent_hint($dot(#p, _LIST_MANAGER.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _LIST_MANAGER.$owns)) } { $st(#s, $dot(#p, _LIST_MANAGER.$owns)) } $typed2(#s, #p, ^_LIST_MANAGER) ==> $field_properties(#s, #p, _LIST_MANAGER.$owns, ^$#ptrset, false));

axiom $owns_set_field(^_LIST_MANAGER) == _LIST_MANAGER.$owns;

const unique _LIST_MANAGER.size: $field;

axiom $static_field_properties(_LIST_MANAGER.size, ^_LIST_MANAGER);

axiom $is_primitive_non_volatile_field(_LIST_MANAGER.size);

axiom (forall #p: $ptr :: { $dot(#p, _LIST_MANAGER.size) } $is(#p, ^_LIST_MANAGER) ==> $dot(#p, _LIST_MANAGER.size) == $ptr(^^mathint, $ghost_ref(#p, _LIST_MANAGER.size)) && $extent_hint($dot(#p, _LIST_MANAGER.size), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _LIST_MANAGER.size)) } { $st(#s, $dot(#p, _LIST_MANAGER.size)) } $typed2(#s, #p, ^_LIST_MANAGER) ==> $field_properties(#s, #p, _LIST_MANAGER.size, ^^mathint, false));

const unique _LIST_MANAGER.index: $field;

axiom $static_field_properties(_LIST_MANAGER.index, ^_LIST_MANAGER);

axiom $is_primitive_non_volatile_field(_LIST_MANAGER.index);

axiom (forall #p: $ptr :: { $dot(#p, _LIST_MANAGER.index) } $is(#p, ^_LIST_MANAGER) ==> $dot(#p, _LIST_MANAGER.index) == $ptr($map_t($ptr_to(^_LIST_ENTRY), ^^mathint), $ghost_ref(#p, _LIST_MANAGER.index)) && $extent_hint($dot(#p, _LIST_MANAGER.index), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _LIST_MANAGER.index)) } { $st(#s, $dot(#p, _LIST_MANAGER.index)) } $typed2(#s, #p, ^_LIST_MANAGER) ==> $field_properties(#s, #p, _LIST_MANAGER.index, $map_t($ptr_to(^_LIST_ENTRY), ^^mathint), false));

const unique _LIST_MANAGER.pointer: $field;

axiom $static_field_properties(_LIST_MANAGER.pointer, ^_LIST_MANAGER);

axiom $is_primitive_non_volatile_field(_LIST_MANAGER.pointer);

axiom (forall #p: $ptr :: { $dot(#p, _LIST_MANAGER.pointer) } $is(#p, ^_LIST_MANAGER) ==> $dot(#p, _LIST_MANAGER.pointer) == $ptr($map_t(^^mathint, $ptr_to(^_LIST_ENTRY)), $ghost_ref(#p, _LIST_MANAGER.pointer)) && $extent_hint($dot(#p, _LIST_MANAGER.pointer), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _LIST_MANAGER.pointer)) } { $st(#s, $dot(#p, _LIST_MANAGER.pointer)) } $typed2(#s, #p, ^_LIST_MANAGER) ==> $field_properties(#s, #p, _LIST_MANAGER.pointer, $map_t(^^mathint, $ptr_to(^_LIST_ENTRY)), false));

const unique _LIST_MANAGER.mem: $field;

axiom $static_field_properties(_LIST_MANAGER.mem, ^_LIST_MANAGER);

axiom $is_primitive_non_volatile_field(_LIST_MANAGER.mem);

axiom (forall #p: $ptr :: { $dot(#p, _LIST_MANAGER.mem) } $is(#p, ^_LIST_MANAGER) ==> $dot(#p, _LIST_MANAGER.mem) == $ptr($map_t($ptr_to(^_LIST_ENTRY), ^^bool), $ghost_ref(#p, _LIST_MANAGER.mem)) && $extent_hint($dot(#p, _LIST_MANAGER.mem), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _LIST_MANAGER.mem)) } { $st(#s, $dot(#p, _LIST_MANAGER.mem)) } $typed2(#s, #p, ^_LIST_MANAGER) ==> $field_properties(#s, #p, _LIST_MANAGER.mem, $map_t($ptr_to(^_LIST_ENTRY), ^^bool), false));

procedure _LIST_MANAGER#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> (forall Q#e$1^27.29#dt1: int :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^27.29#dt1))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^27.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^27.29#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#e$1^27.29#dt1)));
  ensures $is_admissibility_check() ==> (forall Q#e$1^29.29#dt1: int :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1)));
  ensures $is_admissibility_check() ==> (forall Q#e$1^32.29#dt1: int :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1)));
  ensures $is_admissibility_check() ==> (forall Q#e$1^35.29#dt1: int :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1))) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1))) && $ptr_neq($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1), $ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.pointer))), $mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.size)) - 1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1))) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))));
  ensures $is_admissibility_check() ==> (forall Q#e$1^38.29#dt1: int :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1))) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1))) && $ptr_neq($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1), $ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.pointer))), 0))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1))) - 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY))));
  ensures $is_admissibility_check() ==> (forall Q#i$1^41.29#tc2: int :: 0 <= Q#i$1^41.29#tc2 && Q#i$1^41.29#tc2 < $mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.size)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.pointer))), Q#i$1^41.29#tc2)))) == Q#i$1^41.29#tc2 && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.pointer))), Q#i$1^41.29#tc2)))));
  ensures $is_admissibility_check() ==> (forall Q#e$1^44.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1))) ==> 0 <= $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1))) && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1))) < $mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.size)) && $ptr_eq($ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.pointer))), $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1))))), $ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1)));
  ensures $is_unwrap_check() ==> (forall Q#e$1^27.29#dt1: int :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^27.29#dt1))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^27.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^27.29#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#e$1^27.29#dt1)));
  ensures $is_unwrap_check() ==> (forall Q#e$1^29.29#dt1: int :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#e$1^29.29#dt1)));
  ensures $is_unwrap_check() ==> (forall Q#e$1^32.29#dt1: int :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#e$1^32.29#dt1)));
  ensures $is_unwrap_check() ==> (forall Q#e$1^35.29#dt1: int :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1))) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1))) && $ptr_neq($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1), $ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.pointer))), $mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.size)) - 1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1))) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^35.29#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))));
  ensures $is_unwrap_check() ==> (forall Q#e$1^38.29#dt1: int :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1))) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1))) && $ptr_neq($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1), $ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.pointer))), 0))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1))) - 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#e$1^38.29#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY))));
  ensures $is_unwrap_check() ==> (forall Q#i$1^41.29#tc2: int :: 0 <= Q#i$1^41.29#tc2 && Q#i$1^41.29#tc2 < $mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.size)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.pointer))), Q#i$1^41.29#tc2)))) == Q#i$1^41.29#tc2 && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.pointer))), Q#i$1^41.29#tc2)))));
  ensures $is_unwrap_check() ==> (forall Q#e$1^44.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1))) ==> 0 <= $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1))) && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1))) < $mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.size)) && $ptr_eq($ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.pointer))), $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1))))), $ptr(^_LIST_ENTRY, Q#e$1^44.29#dt1)));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _LIST_MANAGER#adm(P#_this_: int)
{
  var #wrTime$1^21.61: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^21.61, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^21.61, #loc._this_, $ptr_to_int($ptr(^_LIST_MANAGER, P#_this_)), $spec_ptr_to(^_LIST_MANAGER)) && $local_value_is_ptr($s, #tok$1^21.61, #loc._this_, $ptr(^_LIST_MANAGER, P#_this_), $spec_ptr_to(^_LIST_MANAGER));
    assume #wrTime$1^21.61 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^21.61, #p) } $in_writes_at(#wrTime$1^21.61, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^_LIST_MANAGER, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^_LIST_MANAGER, P#_this_));
        assume $good_state_ext(#tok$1^21.61, $s);
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
            assume $admissibility_pre($s, $ptr(^_LIST_MANAGER, P#_this_));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^_LIST_MANAGER, P#_this_));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct _LIST_MANAGER*)@null))
        call $havoc_others($ptr(^_LIST_MANAGER, P#_this_), ^_LIST_MANAGER);
        assume $good_state_ext(#tok$1^21.61, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^_LIST_MANAGER, P#_this_), ^_LIST_MANAGER);
    }

  #exit:
}



const unique ^_NODE: $ctype;

axiom $is_composite(^_NODE);

axiom $ptr_level(^_NODE) == 0;

axiom $sizeof(^_NODE) == 16;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_NODE) } $inv2(#s1, #s2, #p, ^_NODE) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty())));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^_NODE, #r), l#public) } $inv_lab(#s2, $ptr(^_NODE, #r), l#public) == ($typed(#s2, $ptr(^_NODE, #r)) && $set_eq($owns(#s2, $ptr(^_NODE, #r)), $set_empty())));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^_NODE, #r)) } $in_full_extent_of(#q, $ptr(^_NODE, #r)) == (#q == $ptr(^_NODE, #r) || #q == $dot($ptr(^_NODE, #r), _NODE.$owns) || $in_full_extent_of(#q, $dot($ptr(^_NODE, #r), _NODE.List)) || #q == $dot($ptr(^_NODE, #r), _NODE.data)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_NODE, #r)) } $in_extent_of(#s, #q, $ptr(^_NODE, #r)) == $in_struct_extent_of(#q, $ptr(^_NODE, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^_NODE, #r)) } $in_span_of(#q, $ptr(^_NODE, #r)) == (#q == $ptr(^_NODE, #r) || #q == $dot($ptr(^_NODE, #r), _NODE.$owns) || #q == $dot($ptr(^_NODE, #r), _NODE.data)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^_NODE) } $state_spans_the_same(#s1, #s2, #p, ^_NODE) == ($mem_eq(#s1, #s2, $dot(#p, _NODE.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _NODE.data))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_NODE) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_NODE) == ($mem_eq(#s1, #s2, $dot(#p, _NODE.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _NODE.data))));

axiom $is_claimable(^_NODE) == false;

axiom $has_volatile_owns_set(^_NODE) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^_NODE, #r)) } $extent_mutable(#s1, $ptr(^_NODE, #r)) == ($mutable(#s1, $ptr(^_NODE, #r)) && $extent_mutable(#s1, $dot($ptr(^_NODE, #r), _NODE.List))));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^_NODE, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^_NODE, #r)) == ($is_fresh(#s1, #s2, $ptr(^_NODE, #r)) && $extent_is_fresh(#s1, #s2, $dot($ptr(^_NODE, #r), _NODE.List))));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^_NODE, #r)) } $extent_zero(#s1, $ptr(^_NODE, #r)) == ($extent_zero(#s1, $dot($ptr(^_NODE, #r), _NODE.List)) && $mem(#s1, $dot($ptr(^_NODE, #r), _NODE.data)) == 0));

const unique _NODE.$owns: $field;

axiom $static_field_properties(_NODE.$owns, ^_NODE);

axiom $is_primitive_non_volatile_field(_NODE.$owns);

axiom (forall #p: $ptr :: { $dot(#p, _NODE.$owns) } $is(#p, ^_NODE) ==> $dot(#p, _NODE.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, _NODE.$owns)) && $extent_hint($dot(#p, _NODE.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _NODE.$owns)) } { $st(#s, $dot(#p, _NODE.$owns)) } $typed2(#s, #p, ^_NODE) ==> $field_properties(#s, #p, _NODE.$owns, ^$#ptrset, false));

axiom $owns_set_field(^_NODE) == _NODE.$owns;

const unique _NODE.List: $field;

axiom $static_field_properties(_NODE.List, ^_NODE);

axiom $field_offset(_NODE.List) == 0;

axiom (forall #p: $ptr :: { $dot(#p, _NODE.List) } $is(#p, ^_NODE) ==> $dot(#p, _NODE.List) == $ptr(^_LIST_ENTRY, $ref(#p) + 0) && $extent_hint($dot(#p, _NODE.List), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _NODE.List)) } { $st(#s, $dot(#p, _NODE.List)) } $typed2(#s, #p, ^_NODE) ==> $field_properties(#s, #p, _NODE.List, ^_LIST_ENTRY, false));

const unique _NODE.data: $field;

axiom $static_field_properties(_NODE.data, ^_NODE);

axiom $is_primitive_non_volatile_field(_NODE.data);

axiom $field_offset(_NODE.data) == 8;

axiom (forall #p: $ptr :: { $dot(#p, _NODE.data) } $is(#p, ^_NODE) ==> $dot(#p, _NODE.data) == $ptr(^^i4, $ref(#p) + 8) && $extent_hint($dot(#p, _NODE.data), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _NODE.data)) } { $st(#s, $dot(#p, _NODE.data)) } $typed2(#s, #p, ^_NODE) ==> $field_properties(#s, #p, _NODE.data, ^^i4, false));

const unique ^_LIST: $ctype;

axiom $is_composite(^_LIST);

axiom $ptr_level(^_LIST) == 0;

axiom $sizeof(^_LIST) == 8;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_LIST) } $inv2(#s1, #s2, #p, ^_LIST) == ($typed(#s2, #p) && $keeps(#s2, #p, $read_ptr(#s2, $dot(#p, _LIST.ListManager), ^_LIST_MANAGER)) && $ptr_eq($ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem(#s2, $dot($read_ptr(#s2, $dot(#p, _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.pointer))), 0)), $dot(#p, _LIST.Head)) && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem(#s2, $dot($read_ptr(#s2, $dot(#p, _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.index))), $ref($dot(#p, _LIST.Head))) == 0 && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot($read_ptr(#s2, $dot(#p, _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.mem))), $ref($dot(#p, _LIST.Head))) && (forall Q#i$2^25.29#tc2: int :: 0 < Q#i$2^25.29#tc2 && Q#i$2^25.29#tc2 < $mem(#s2, $dot($read_ptr(#s2, $dot(#p, _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.size)) ==> $keeps(#s2, #p, $ptr_cast($i8_to_ptr($byte_ptr_subtraction($ptr(^^u1, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem(#s2, $dot($read_ptr(#s2, $dot(#p, _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.pointer))), Q#i$2^25.29#tc2)), $ptr_cast($dot($ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE)))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^_LIST, #r), l#public) } $inv_lab(#s2, $ptr(^_LIST, #r), l#public) == ($typed(#s2, $ptr(^_LIST, #r)) && $keeps(#s2, $ptr(^_LIST, #r), $read_ptr(#s2, $dot($ptr(^_LIST, #r), _LIST.ListManager), ^_LIST_MANAGER)) && $ptr_eq($ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem(#s2, $dot($read_ptr(#s2, $dot($ptr(^_LIST, #r), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.pointer))), 0)), $dot($ptr(^_LIST, #r), _LIST.Head)) && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem(#s2, $dot($read_ptr(#s2, $dot($ptr(^_LIST, #r), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.index))), $ref($dot($ptr(^_LIST, #r), _LIST.Head))) == 0 && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem(#s2, $dot($read_ptr(#s2, $dot($ptr(^_LIST, #r), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.mem))), $ref($dot($ptr(^_LIST, #r), _LIST.Head))) && (forall Q#i$2^25.29#tc2: int :: 0 < Q#i$2^25.29#tc2 && Q#i$2^25.29#tc2 < $mem(#s2, $dot($read_ptr(#s2, $dot($ptr(^_LIST, #r), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.size)) ==> $keeps(#s2, $ptr(^_LIST, #r), $ptr_cast($i8_to_ptr($byte_ptr_subtraction($ptr(^^u1, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem(#s2, $dot($read_ptr(#s2, $dot($ptr(^_LIST, #r), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.pointer))), Q#i$2^25.29#tc2)), $ptr_cast($dot($ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE)))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^_LIST, #r)) } $in_full_extent_of(#q, $ptr(^_LIST, #r)) == (#q == $ptr(^_LIST, #r) || #q == $dot($ptr(^_LIST, #r), _LIST.$owns) || $in_full_extent_of(#q, $dot($ptr(^_LIST, #r), _LIST.Head)) || #q == $dot($ptr(^_LIST, #r), _LIST.ListManager)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_LIST, #r)) } $in_extent_of(#s, #q, $ptr(^_LIST, #r)) == $in_struct_extent_of(#q, $ptr(^_LIST, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^_LIST, #r)) } $in_span_of(#q, $ptr(^_LIST, #r)) == (#q == $ptr(^_LIST, #r) || #q == $dot($ptr(^_LIST, #r), _LIST.$owns) || #q == $dot($ptr(^_LIST, #r), _LIST.ListManager)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^_LIST) } $state_spans_the_same(#s1, #s2, #p, ^_LIST) == ($mem_eq(#s1, #s2, $dot(#p, _LIST.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _LIST.ListManager))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_LIST) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_LIST) == ($mem_eq(#s1, #s2, $dot(#p, _LIST.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _LIST.ListManager))));

axiom $is_claimable(^_LIST) == false;

axiom $has_volatile_owns_set(^_LIST) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^_LIST, #r)) } $extent_mutable(#s1, $ptr(^_LIST, #r)) == ($mutable(#s1, $ptr(^_LIST, #r)) && $extent_mutable(#s1, $dot($ptr(^_LIST, #r), _LIST.Head))));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^_LIST, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^_LIST, #r)) == ($is_fresh(#s1, #s2, $ptr(^_LIST, #r)) && $extent_is_fresh(#s1, #s2, $dot($ptr(^_LIST, #r), _LIST.Head))));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^_LIST, #r)) } $extent_zero(#s1, $ptr(^_LIST, #r)) == ($extent_zero(#s1, $dot($ptr(^_LIST, #r), _LIST.Head)) && $mem(#s1, $dot($ptr(^_LIST, #r), _LIST.ListManager)) == 0));

const unique _LIST.$owns: $field;

axiom $static_field_properties(_LIST.$owns, ^_LIST);

axiom $is_primitive_non_volatile_field(_LIST.$owns);

axiom (forall #p: $ptr :: { $dot(#p, _LIST.$owns) } $is(#p, ^_LIST) ==> $dot(#p, _LIST.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, _LIST.$owns)) && $extent_hint($dot(#p, _LIST.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _LIST.$owns)) } { $st(#s, $dot(#p, _LIST.$owns)) } $typed2(#s, #p, ^_LIST) ==> $field_properties(#s, #p, _LIST.$owns, ^$#ptrset, false));

axiom $owns_set_field(^_LIST) == _LIST.$owns;

const unique _LIST.Head: $field;

axiom $static_field_properties(_LIST.Head, ^_LIST);

axiom $field_offset(_LIST.Head) == 0;

axiom (forall #p: $ptr :: { $dot(#p, _LIST.Head) } $is(#p, ^_LIST) ==> $dot(#p, _LIST.Head) == $ptr(^_LIST_ENTRY, $ref(#p) + 0) && $extent_hint($dot(#p, _LIST.Head), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _LIST.Head)) } { $st(#s, $dot(#p, _LIST.Head)) } $typed2(#s, #p, ^_LIST) ==> $field_properties(#s, #p, _LIST.Head, ^_LIST_ENTRY, false));

const unique _LIST.ListManager: $field;

axiom $static_field_properties(_LIST.ListManager, ^_LIST);

axiom $is_primitive_non_volatile_field(_LIST.ListManager);

axiom (forall #p: $ptr :: { $dot(#p, _LIST.ListManager) } $is(#p, ^_LIST) ==> $dot(#p, _LIST.ListManager) == $ptr($spec_ptr_to(^_LIST_MANAGER), $ghost_ref(#p, _LIST.ListManager)) && $extent_hint($dot(#p, _LIST.ListManager), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _LIST.ListManager)) } { $st(#s, $dot(#p, _LIST.ListManager)) } $typed2(#s, #p, ^_LIST) ==> $field_properties(#s, #p, _LIST.ListManager, $spec_ptr_to(^_LIST_MANAGER), false));

procedure _LIST#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $keeps($s, $ptr(^_LIST, P#_this_), $read_ptr($s, $dot($ptr(^_LIST, P#_this_), _LIST.ListManager), ^_LIST_MANAGER));
  ensures $is_admissibility_check() ==> $ptr_eq($ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST, P#_this_), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.pointer))), 0)), $dot($ptr(^_LIST, P#_this_), _LIST.Head));
  ensures $is_admissibility_check() ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST, P#_this_), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.index))), $ref($dot($ptr(^_LIST, P#_this_), _LIST.Head))) == 0;
  ensures $is_admissibility_check() ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST, P#_this_), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.mem))), $ref($dot($ptr(^_LIST, P#_this_), _LIST.Head)));
  ensures $is_admissibility_check() ==> (forall Q#i$2^25.29#tc2: int :: 0 < Q#i$2^25.29#tc2 && Q#i$2^25.29#tc2 < $mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST, P#_this_), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.size)) ==> $keeps($s, $ptr(^_LIST, P#_this_), $ptr_cast($i8_to_ptr($byte_ptr_subtraction($ptr(^^u1, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST, P#_this_), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.pointer))), Q#i$2^25.29#tc2)), $ptr_cast($dot($ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE)));
  ensures $is_unwrap_check() ==> $keeps($s, $ptr(^_LIST, P#_this_), $read_ptr($s, $dot($ptr(^_LIST, P#_this_), _LIST.ListManager), ^_LIST_MANAGER));
  ensures $is_unwrap_check() ==> $ptr_eq($ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST, P#_this_), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.pointer))), 0)), $dot($ptr(^_LIST, P#_this_), _LIST.Head));
  ensures $is_unwrap_check() ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST, P#_this_), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.index))), $ref($dot($ptr(^_LIST, P#_this_), _LIST.Head))) == 0;
  ensures $is_unwrap_check() ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST, P#_this_), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.mem))), $ref($dot($ptr(^_LIST, P#_this_), _LIST.Head)));
  ensures $is_unwrap_check() ==> (forall Q#i$2^25.29#tc2: int :: 0 < Q#i$2^25.29#tc2 && Q#i$2^25.29#tc2 < $mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST, P#_this_), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.size)) ==> $keeps($s, $ptr(^_LIST, P#_this_), $ptr_cast($i8_to_ptr($byte_ptr_subtraction($ptr(^^u1, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST, P#_this_), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.pointer))), Q#i$2^25.29#tc2)), $ptr_cast($dot($ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE)));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _LIST#adm(P#_this_: int)
{
  var #wrTime$2^20.39: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$2^20.39, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$2^20.39, #loc._this_, $ptr_to_int($ptr(^_LIST, P#_this_)), $ptr_to(^_LIST)) && $local_value_is_ptr($s, #tok$2^20.39, #loc._this_, $ptr(^_LIST, P#_this_), $ptr_to(^_LIST));
    assume #wrTime$2^20.39 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$2^20.39, #p) } $in_writes_at(#wrTime$2^20.39, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon7:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^_LIST, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^_LIST, P#_this_));
        assume $good_state_ext(#tok$2^20.39, $s);
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
            assume $admissibility_pre($s, $ptr(^_LIST, P#_this_));
        }
        else
        {
          anon9:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^_LIST, P#_this_));
        }

      anon11:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct _LIST*)@null))
        call $havoc_others($ptr(^_LIST, P#_this_), ^_LIST);
        assume $good_state_ext(#tok$2^20.39, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^_LIST, P#_this_), ^_LIST);
    }

  #exit:
}



function F#ListRemoveAt(SP#m: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, SP#i: int) : $map_t..^^mathint.$ptr_to..^_LIST_ENTRY;

const unique cf#ListRemoveAt: $pure_function;

axiom (forall SP#m: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, SP#i: int :: { F#ListRemoveAt(SP#m, SP#i) } $eq.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(F#ListRemoveAt(SP#m, SP#i), F#lambda#1(SP#m, SP#m, SP#i)));

axiom $function_arg_type(cf#ListRemoveAt, 0, $map_t(^^mathint, $ptr_to(^_LIST_ENTRY)));

axiom $function_arg_type(cf#ListRemoveAt, 1, $map_t(^^mathint, $ptr_to(^_LIST_ENTRY)));

axiom $function_arg_type(cf#ListRemoveAt, 2, ^^mathint);

procedure ListRemoveAt(SP#m: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, SP#i: int) returns ($result: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY);
  ensures $eq.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($result, F#lambda#1(SP#m, SP#m, SP#i));
  free ensures $result == F#ListRemoveAt(SP#m, SP#i);
  free ensures $call_transition(old($s), $s);



function F#ListInsertAt(SP#m: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, SP#i: int, SP#e: int) : $map_t..^^mathint.$ptr_to..^_LIST_ENTRY;

const unique cf#ListInsertAt: $pure_function;

axiom (forall SP#m: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, SP#i: int, SP#e: int :: { F#ListInsertAt(SP#m, SP#i, SP#e) } $eq.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(F#ListInsertAt(SP#m, SP#i, SP#e), F#lambda#2(SP#m, SP#m, SP#i, $ref($ptr(^_LIST_ENTRY, SP#e)), SP#i)));

axiom $function_arg_type(cf#ListInsertAt, 0, $map_t(^^mathint, $ptr_to(^_LIST_ENTRY)));

axiom $function_arg_type(cf#ListInsertAt, 1, $map_t(^^mathint, $ptr_to(^_LIST_ENTRY)));

axiom $function_arg_type(cf#ListInsertAt, 2, ^^mathint);

axiom $function_arg_type(cf#ListInsertAt, 3, $ptr_to(^_LIST_ENTRY));

procedure ListInsertAt(SP#m: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, SP#i: int, SP#e: int) returns ($result: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY);
  ensures $eq.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($result, F#lambda#2(SP#m, SP#m, SP#i, $ref($ptr(^_LIST_ENTRY, SP#e)), SP#i));
  free ensures $result == F#ListInsertAt(SP#m, SP#i, SP#e);
  free ensures $call_transition(old($s), $s);



procedure find(P#l: int) returns ($result: int);
  requires $wrapped($s, $ptr(^_LIST, P#l), ^_LIST);
  requires $mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST, P#l), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.size)) < 4294967295;
  modifies $s, $cev_pc;
  free ensures $in_range_u4($result);
  ensures (forall Q#j$2^32.27#tc2: int :: 0 < Q#j$2^32.27#tc2 && Q#j$2^32.27#tc2 < $result ==> $mem($s, $dot($ptr_cast($i8_to_ptr($byte_ptr_subtraction($ptr(^^u1, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST, P#l), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.pointer))), Q#j$2^32.27#tc2)), $ptr_cast($dot($ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE), _NODE.data)) != 0);
  ensures $result < $mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST, P#l), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.size)) ==> $mem($s, $dot($ptr_cast($i8_to_ptr($byte_ptr_subtraction($ptr_cast($ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST, P#l), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.pointer))), $result)), ^^u1), $ptr_cast($dot($ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE), _NODE.data)) == 0;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation find(P#l: int) returns ($result: int)
{
  var loopState#0: $state;
  var L#n: int where $in_range_phys_ptr(L#n);
  var L#le: int where $in_range_phys_ptr(L#le);
  var L#i: int where $in_range_u4(L#i);
  var #wrTime$2^29.1: int;
  var #stackframe: int;

  anon19:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$2^29.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$2^29.1, #loc.l, $ptr_to_int($ptr(^_LIST, P#l)), $ptr_to(^_LIST)) && $local_value_is_ptr($s, #tok$2^29.1, #loc.l, $ptr(^_LIST, P#l), $ptr_to(^_LIST));
    assume #wrTime$2^29.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$2^29.1, #p) } $in_writes_at(#wrTime$2^29.1, #p) == false);
    // assume @in_range_phys_ptr((mathint)l); 
    assume $in_range_phys_ptr($ref($ptr(^_LIST, P#l)));
    // assert @_vcc_in_domain(@state, l, l); 
    assert $in_domain_lab($s, $ptr(^_LIST, P#l), $ptr(^_LIST, P#l), l#public);
    // uint32_t i; 
    assume $local_value_is($s, #tok$2^39.3, #loc.i, L#i, ^^u4);
    // struct _LIST_ENTRY* le; 
    assume $local_value_is($s, #tok$2^38.3, #loc.le, $ptr_to_int($ptr(^_LIST_ENTRY, L#le)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^38.3, #loc.le, $ptr(^_LIST_ENTRY, L#le), $ptr_to(^_LIST_ENTRY));
    // struct _NODE* n; 
    assume $local_value_is($s, #tok$2^37.3, #loc.n, $ptr_to_int($ptr(^_NODE, L#n)), $ptr_to(^_NODE)) && $local_value_is_ptr($s, #tok$2^37.3, #loc.n, $ptr(^_NODE, L#n), $ptr_to(^_NODE));
    // var struct _NODE* n
    // var struct _LIST_ENTRY* le
    // var uint32_t i
    // assert @_vcc_in_domain(@state, *((l->ListManager)), l); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_LIST, P#l), _LIST.ListManager), ^_LIST_MANAGER), $ptr(^_LIST, P#l), l#public);
    // assume @_vcc_in_domain(@state, *((l->ListManager)), l); 
    assume $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_LIST, P#l), _LIST.ListManager), ^_LIST_MANAGER), $ptr(^_LIST, P#l), l#public);
    // assert @reads_check_normal(((l->Head)->Flink)); 
    assert $typed2($s, $dot($dot($ptr(^_LIST, P#l), _LIST.Head), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    assert $thread_local2($s, $dot($dot($ptr(^_LIST, P#l), _LIST.Head), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    // le := *(((l->Head)->Flink)); 
    L#le := $ref($read_ptr($s, $dot($dot($ptr(^_LIST, P#l), _LIST.Head), _LIST_ENTRY.Flink), ^_LIST_ENTRY));
    assume $local_value_is($s, #tok$2^43.3, #loc.le, $ptr_to_int($ptr(^_LIST_ENTRY, L#le)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^43.3, #loc.le, $ptr(^_LIST_ENTRY, L#le), $ptr_to(^_LIST_ENTRY));
    // i := 1; 
    L#i := 1;
    assume $local_value_is($s, #tok$2^44.3, #loc.i, L#i, ^^u4);
    loopState#0 := $s;
    while (true)
      invariant $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST, P#l), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.mem))), $ref($ptr(^_LIST_ENTRY, L#le)));
      invariant L#i <= $mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST, P#l), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.size));
      invariant (forall Q#j$2^49.31#tc2: int :: 0 < Q#j$2^49.31#tc2 && Q#j$2^49.31#tc2 < L#i ==> $mem($s, $dot($ptr_cast($i8_to_ptr($byte_ptr_subtraction($ptr(^^u1, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST, P#l), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.pointer))), Q#j$2^49.31#tc2)), $ptr_cast($dot($ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE), _NODE.data)) != 0);
      invariant $ptr_eq($ptr(^_LIST_ENTRY, L#le), $ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST, P#l), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.pointer))), (if L#i == $mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST, P#l), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.size)) then 0 else L#i))));
    {
      anon18:
        assume $writes_nothing(old($s), $s);
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$2^46.3, $s);
        assume $local_value_is($s, #tok$2^46.3, #loc.n, $ptr_to_int($ptr(^_NODE, L#n)), $ptr_to(^_NODE)) && $local_value_is_ptr($s, #tok$2^46.3, #loc.n, $ptr(^_NODE, L#n), $ptr_to(^_NODE));
        assume $local_value_is($s, #tok$2^46.3, #loc.le, $ptr_to_int($ptr(^_LIST_ENTRY, L#le)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^46.3, #loc.le, $ptr(^_LIST_ENTRY, L#le), $ptr_to(^_LIST_ENTRY));
        assume $local_value_is($s, #tok$2^46.3, #loc.l, $ptr_to_int($ptr(^_LIST, P#l)), $ptr_to(^_LIST)) && $local_value_is_ptr($s, #tok$2^46.3, #loc.l, $ptr(^_LIST, P#l), $ptr_to(^_LIST));
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#0, $s);
        assume true;
        // if (@_vcc_ptr_neq(le, (l->Head))) ...
        if ($ptr_neq($ptr(^_LIST_ENTRY, L#le), $dot($ptr(^_LIST, P#l), _LIST.Head)))
        {
          anon15:
            // n := (struct _NODE*)@_vcc_i8_to_ptr(@_vcc_byte_ptr_subtraction((uint8_t*)le, (uint8_t*)((struct _NODE*)@null->List))); 
            L#n := $ref($ptr_cast($i8_to_ptr($byte_ptr_subtraction($ptr_cast($ptr(^_LIST_ENTRY, L#le), ^^u1), $ptr_cast($dot($ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE));
            assume $local_value_is($s, #tok$2^53.5, #loc.n, $ptr_to_int($ptr(^_NODE, L#n)), $ptr_to(^_NODE)) && $local_value_is_ptr($s, #tok$2^53.5, #loc.n, $ptr(^_NODE, L#n), $ptr_to(^_NODE));
            // assert @reads_check_normal((n->data)); 
            assert $typed2($s, $dot($ptr(^_NODE, L#n), _NODE.data), ^^i4);
            assert $thread_local2($s, $dot($ptr(^_NODE, L#n), _NODE.data), ^^i4);
            assume true;
            // if (==(*((n->data)), 0)) ...
            if ($mem($s, $dot($ptr(^_NODE, L#n), _NODE.data)) == 0)
            {
              anon13:
                // goto #break_3; 
                goto #break_3;
            }
            else
            {
              anon14:
                // empty
            }

          anon16:
            // assert forall(mathint j; true; ==>(&&(<(0, j), <=(j, i)), !=(*(((struct _NODE*)@_vcc_i8_to_ptr(@_vcc_byte_ptr_subtraction((uint8_t*)@map_get(*((*((l->ListManager))->pointer)), j), (uint8_t*)((struct _NODE*)@null->List)))->data)), 0))); 
            assert (forall Q#j$2^57.28#tc2: int :: 0 < Q#j$2^57.28#tc2 && Q#j$2^57.28#tc2 <= L#i ==> $mem($s, $dot($ptr_cast($i8_to_ptr($byte_ptr_subtraction($ptr(^^u1, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST, P#l), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.pointer))), Q#j$2^57.28#tc2)), $ptr_cast($dot($ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE), _NODE.data)) != 0);
            // assume forall(mathint j; true; ==>(&&(<(0, j), <=(j, i)), !=(*(((struct _NODE*)@_vcc_i8_to_ptr(@_vcc_byte_ptr_subtraction((uint8_t*)@map_get(*((*((l->ListManager))->pointer)), j), (uint8_t*)((struct _NODE*)@null->List)))->data)), 0))); 
            assume (forall Q#j$2^57.28#tc2: int :: 0 < Q#j$2^57.28#tc2 && Q#j$2^57.28#tc2 <= L#i ==> $mem($s, $dot($ptr_cast($i8_to_ptr($byte_ptr_subtraction($ptr(^^u1, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST, P#l), _LIST.ListManager), ^_LIST_MANAGER), _LIST_MANAGER.pointer))), Q#j$2^57.28#tc2)), $ptr_cast($dot($ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE), _NODE.data)) != 0);
            // assert @reads_check_normal((le->Flink)); 
            assert $typed2($s, $dot($ptr(^_LIST_ENTRY, L#le), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
            assert $thread_local2($s, $dot($ptr(^_LIST_ENTRY, L#le), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
            // le := *((le->Flink)); 
            L#le := $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, L#le), _LIST_ENTRY.Flink), ^_LIST_ENTRY));
            assume $local_value_is($s, #tok$2^59.5, #loc.le, $ptr_to_int($ptr(^_LIST_ENTRY, L#le)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^59.5, #loc.le, $ptr(^_LIST_ENTRY, L#le), $ptr_to(^_LIST_ENTRY));
            // assert @in_range_u4(+(i, 1)); 
            assert $in_range_u4(L#i + 1);
            // i := +(i, 1); 
            L#i := L#i + 1;
            assume $local_value_is($s, #tok$2^60.5, #loc.i, L#i, ^^u4);
        }
        else
        {
          anon17:
            // goto #break_3; 
            goto #break_3;
        }

      #continue_3:
        assume true;
    }

  anon20:
    assume $full_stop_ext(#tok$2^46.3, $s);

  #break_3:
    // return i; 
    $result := L#i;
    assert $position_marker();
    goto #exit;

  anon21:
    // empty

  #exit:
}



function F#lambda#2(#l4: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l3: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l2: int, #l1: int, #l0: int) : $map_t..^^mathint.$ptr_to..^_LIST_ENTRY;

const unique cf#lambda#2: $pure_function;

axiom $function_arg_type(cf#lambda#2, 0, $map_t(^^mathint, $ptr_to(^_LIST_ENTRY)));

axiom $function_arg_type(cf#lambda#2, 1, $map_t(^^mathint, $ptr_to(^_LIST_ENTRY)));

axiom $function_arg_type(cf#lambda#2, 2, $map_t(^^mathint, $ptr_to(^_LIST_ENTRY)));

axiom $function_arg_type(cf#lambda#2, 3, ^^mathint);

axiom $function_arg_type(cf#lambda#2, 4, $ptr_to(^_LIST_ENTRY));

axiom $function_arg_type(cf#lambda#2, 5, ^^mathint);

procedure lambda#2(#l4: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l3: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l2: int, #l1: int, #l0: int) returns ($result: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY);
  free ensures $result == F#lambda#2(#l4, #l3, #l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#j$1^19.27#tc2: int, #l4: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l3: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l2: int, #l1: int, #l0: int :: { $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(F#lambda#2(#l4, #l3, #l2, $ref($ptr(^_LIST_ENTRY, #l1)), #l0), Q#j$1^19.27#tc2) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, #l1))) ==> $ptr_eq($ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(F#lambda#2(#l4, #l3, #l2, $ref($ptr(^_LIST_ENTRY, #l1)), #l0), Q#j$1^19.27#tc2)), (if Q#j$1^19.27#tc2 == #l0 then $ptr(^_LIST_ENTRY, #l1) else (if Q#j$1^19.27#tc2 < #l2 then $ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(#l3, Q#j$1^19.27#tc2)) else $ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(#l4, Q#j$1^19.27#tc2 - 1))))));

function F#lambda#1(#l2: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l1: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l0: int) : $map_t..^^mathint.$ptr_to..^_LIST_ENTRY;

const unique cf#lambda#1: $pure_function;

axiom $function_arg_type(cf#lambda#1, 0, $map_t(^^mathint, $ptr_to(^_LIST_ENTRY)));

axiom $function_arg_type(cf#lambda#1, 1, $map_t(^^mathint, $ptr_to(^_LIST_ENTRY)));

axiom $function_arg_type(cf#lambda#1, 2, $map_t(^^mathint, $ptr_to(^_LIST_ENTRY)));

axiom $function_arg_type(cf#lambda#1, 3, ^^mathint);

procedure lambda#1(#l2: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l1: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l0: int) returns ($result: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY);
  free ensures $result == F#lambda#1(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#j$1^16.27#tc2: int, #l2: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l1: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l0: int :: { $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(F#lambda#1(#l2, #l1, #l0), Q#j$1^16.27#tc2) } $ptr_eq($ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(F#lambda#1(#l2, #l1, #l0), Q#j$1^16.27#tc2)), (if Q#j$1^16.27#tc2 < #l0 then $ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(#l1, Q#j$1^16.27#tc2)) else $ptr(^_LIST_ENTRY, $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(#l2, Q#j$1^16.27#tc2 + 1)))));

const unique l#public: $label;

type $map_t..$ptr_to..^_LIST_ENTRY.^^bool;

function $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool(M: $map_t..$ptr_to..^_LIST_ENTRY.^^bool, p: int) : bool;

function $store.$map_t..$ptr_to..^_LIST_ENTRY.^^bool(M: $map_t..$ptr_to..^_LIST_ENTRY.^^bool, p: int, v: bool) : $map_t..$ptr_to..^_LIST_ENTRY.^^bool;

function $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^bool(M1: $map_t..$ptr_to..^_LIST_ENTRY.^^bool, M2: $map_t..$ptr_to..^_LIST_ENTRY.^^bool) : bool;

const $zero.$map_t..$ptr_to..^_LIST_ENTRY.^^bool: $map_t..$ptr_to..^_LIST_ENTRY.^^bool;

axiom (forall M: $map_t..$ptr_to..^_LIST_ENTRY.^^bool, p: int, v: bool :: $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($store.$map_t..$ptr_to..^_LIST_ENTRY.^^bool(M, p, v), p) == v);

axiom (forall M: $map_t..$ptr_to..^_LIST_ENTRY.^^bool, p: int, v: bool, q: int :: p != q ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($store.$map_t..$ptr_to..^_LIST_ENTRY.^^bool(M, q, v), p) == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool(M, p));

axiom (forall M1: $map_t..$ptr_to..^_LIST_ENTRY.^^bool, M2: $map_t..$ptr_to..^_LIST_ENTRY.^^bool :: { $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^bool(M1, M2) } (forall p: int :: $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool(M1, p) == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool(M2, p)) ==> $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^bool(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^_LIST_ENTRY.^^bool, M2: $map_t..$ptr_to..^_LIST_ENTRY.^^bool :: { $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^bool(M1, M2) } $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^bool(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool(0) == $zero.$map_t..$ptr_to..^_LIST_ENTRY.^^bool;

axiom (forall p: int :: $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($zero.$map_t..$ptr_to..^_LIST_ENTRY.^^bool, p) == false);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t($ptr_to(^_LIST_ENTRY), ^^bool)) } $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rec_fetch(r1, f)), $int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

type $map_t..^^mathint.$ptr_to..^_LIST_ENTRY;

function $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, p: int) : int;

function $store.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, p: int, v: int) : $map_t..^^mathint.$ptr_to..^_LIST_ENTRY;

function $eq.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M1: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, M2: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY) : bool;

const $zero.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY;

axiom (forall M: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, p: int, v: int :: $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($store.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M, p, v), p) == v);

axiom (forall M: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, p: int, v: int, q: int :: p != q ==> $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($store.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M, q, v), p) == $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M, p));

axiom (forall M1: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, M2: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY :: { $eq.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M1, M2) } (forall p: int :: $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M1, p) == $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M2, p)) ==> $eq.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M1, M2));

axiom (forall M1: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, M2: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY :: { $eq.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M1, M2) } $eq.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY(0) == $zero.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY;

axiom (forall p: int :: $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($zero.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY, p) == 0);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t(^^mathint, $ptr_to(^_LIST_ENTRY))) } $eq.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rec_fetch(r1, f)), $int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

axiom (forall M: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, p: int :: $in_range_phys_ptr($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M, p)));

type $map_t..$ptr_to..^_LIST_ENTRY.^^mathint;

function $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint(M: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint, p: int) : int;

function $store.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint(M: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint, p: int, v: int) : $map_t..$ptr_to..^_LIST_ENTRY.^^mathint;

function $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint(M1: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint, M2: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint) : bool;

const $zero.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint;

axiom (forall M: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint, p: int, v: int :: $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($store.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint(M, p, v), p) == v);

axiom (forall M: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint, p: int, v: int, q: int :: p != q ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($store.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint(M, q, v), p) == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint(M, p));

axiom (forall M1: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint, M2: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint :: { $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint(M1, M2) } (forall p: int :: $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint(M1, p) == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint(M2, p)) ==> $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint, M2: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint :: { $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint(M1, M2) } $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint(0) == $zero.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint;

axiom (forall p: int :: $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($zero.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint, p) == 0);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t($ptr_to(^_LIST_ENTRY), ^^mathint)) } $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rec_fetch(r1, f)), $int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

const unique #tok$1^16.27: $token;

const unique #loc.#l0: $token;

const unique #loc.#l1: $token;

const unique #loc.#l2: $token;

const unique #loc.#l3: $token;

const unique #loc.#l4: $token;

const unique #tok$1^19.27: $token;

const unique #tok$2^60.5: $token;

const unique #tok$2^59.5: $token;

const unique #tok$2^53.5: $token;

const unique #tok$2^46.3: $token;

const unique #tok$2^44.3: $token;

const unique #tok$2^43.3: $token;

const unique #distTp7: $ctype;

axiom #distTp7 == $ptr_to(^_NODE);

const unique #loc.n: $token;

const unique #tok$2^37.3: $token;

const unique #loc.le: $token;

const unique #tok$2^38.3: $token;

const unique #tok$2^39.3: $token;

const unique #loc.l: $token;

const unique #tok$2^29.1: $token;

const unique #loc.e: $token;

const unique #tok$1^18.39: $token;

const unique #loc.i: $token;

const unique #loc.m: $token;

const unique #tok$1^15.39: $token;

const unique #distTp6: $ctype;

axiom #distTp6 == $ptr_to(^_LIST);

const unique #tok$2^20.39: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvscomp2010?5Cvscomp2010_p3_v2.c: $token;

axiom $file_name_is(2, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvscomp2010?5Cvscomp2010_p3_v2.c);

const unique #distTp5: $ctype;

axiom #distTp5 == $spec_ptr_to(^_LIST_MANAGER);

const unique #loc._this_: $token;

const unique #tok$1^21.61: $token;

axiom $type_code_is(2, ^^mathint);

function $map_t..ptr_to..^_LIST_ENTRY.^^mathint_to_int(x: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint) : int;

function $int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint(x: int) : $map_t..$ptr_to..^_LIST_ENTRY.^^mathint;

axiom (forall #x: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint :: #x == $int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($map_t..ptr_to..^_LIST_ENTRY.^^mathint_to_int(#x)));

const unique #distTp4: $ctype;

axiom #distTp4 == $map_t($ptr_to(^_LIST_ENTRY), ^^mathint);

function $map_t..^^mathint.ptr_to..^_LIST_ENTRY_to_int(x: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY) : int;

function $int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY(x: int) : $map_t..^^mathint.$ptr_to..^_LIST_ENTRY;

axiom (forall #x: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY :: #x == $int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($map_t..^^mathint.ptr_to..^_LIST_ENTRY_to_int(#x)));

const unique #distTp3: $ctype;

axiom #distTp3 == $map_t(^^mathint, $ptr_to(^_LIST_ENTRY));

const unique #file^c?3A?5Cdev?5Cfelt?5Cvcc?5Ctest?5Ctestsuite?5Cvscomp2010?5CList.h: $token;

axiom $file_name_is(1, #file^c?3A?5Cdev?5Cfelt?5Cvcc?5Ctest?5Ctestsuite?5Cvscomp2010?5CList.h);

function $map_t..ptr_to..^_LIST_ENTRY.^^bool_to_int(x: $map_t..$ptr_to..^_LIST_ENTRY.^^bool) : int;

function $int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool(x: int) : $map_t..$ptr_to..^_LIST_ENTRY.^^bool;

axiom (forall #x: $map_t..$ptr_to..^_LIST_ENTRY.^^bool :: #x == $int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($map_t..ptr_to..^_LIST_ENTRY.^^bool_to_int(#x)));

const unique #distTp2: $ctype;

axiom #distTp2 == $map_t($ptr_to(^_LIST_ENTRY), ^^bool);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^_LIST_ENTRY);
