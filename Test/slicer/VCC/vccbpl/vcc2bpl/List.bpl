axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^_LIST_ENTRY: $ctype;

axiom $is_composite(^_LIST_ENTRY);

axiom $ptr_level(^_LIST_ENTRY) == 0;

axiom $sizeof(^_LIST_ENTRY) == 16;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_LIST_ENTRY) } $inv2(#s1, #s2, #p, ^_LIST_ENTRY) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty())));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^_LIST_ENTRY, #r), l#public) } $inv_lab(#s2, $ptr(^_LIST_ENTRY, #r), l#public) == ($typed(#s2, $ptr(^_LIST_ENTRY, #r)) && $set_eq($owns(#s2, $ptr(^_LIST_ENTRY, #r)), $set_empty())));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^_LIST_ENTRY, #r)) } $in_full_extent_of(#q, $ptr(^_LIST_ENTRY, #r)) == (#q == $ptr(^_LIST_ENTRY, #r) || #q == $dot($ptr(^_LIST_ENTRY, #r), _LIST_ENTRY.$owns) || #q == $dot($ptr(^_LIST_ENTRY, #r), _LIST_ENTRY.Flink) || #q == $dot($ptr(^_LIST_ENTRY, #r), _LIST_ENTRY.Blink) || #q == $dot($ptr(^_LIST_ENTRY, #r), _LIST_ENTRY.Manager)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_LIST_ENTRY, #r)) } $in_extent_of(#s, #q, $ptr(^_LIST_ENTRY, #r)) == $in_struct_extent_of(#q, $ptr(^_LIST_ENTRY, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_LIST_ENTRY, #r)) } $typed(#s, $ptr(^_LIST_ENTRY, #r)) ==> $in_extent_of(#s, #q, $ptr(^_LIST_ENTRY, #r)) == (#q == $ptr(^_LIST_ENTRY, #r) || $emb(#s, #q) == $ptr(^_LIST_ENTRY, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^_LIST_ENTRY, #r)) } $in_span_of(#q, $ptr(^_LIST_ENTRY, #r)) == (#q == $ptr(^_LIST_ENTRY, #r) || #q == $dot($ptr(^_LIST_ENTRY, #r), _LIST_ENTRY.$owns) || #q == $dot($ptr(^_LIST_ENTRY, #r), _LIST_ENTRY.Flink) || #q == $dot($ptr(^_LIST_ENTRY, #r), _LIST_ENTRY.Blink) || #q == $dot($ptr(^_LIST_ENTRY, #r), _LIST_ENTRY.Manager)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^_LIST_ENTRY) } $state_spans_the_same(#s1, #s2, #p, ^_LIST_ENTRY) == ($mem_eq(#s1, #s2, $dot(#p, _LIST_ENTRY.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_ENTRY.Flink)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_ENTRY.Blink)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_ENTRY.Manager))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_LIST_ENTRY) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_LIST_ENTRY) == ($mem_eq(#s1, #s2, $dot(#p, _LIST_ENTRY.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_ENTRY.Flink)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_ENTRY.Blink)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_ENTRY.Manager))));

axiom $is_claimable(^_LIST_ENTRY) == false;

axiom $has_volatile_owns_set(^_LIST_ENTRY) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^_LIST_ENTRY, #r)) } $extent_mutable(#s1, $ptr(^_LIST_ENTRY, #r)) == $mutable(#s1, $ptr(^_LIST_ENTRY, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^_LIST_ENTRY, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^_LIST_ENTRY, #r)) == $is_fresh(#s1, #s2, $ptr(^_LIST_ENTRY, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^_LIST_ENTRY, #r)) } $extent_zero(#s1, $ptr(^_LIST_ENTRY, #r)) == ($mem(#s1, $dot($ptr(^_LIST_ENTRY, #r), _LIST_ENTRY.Flink)) == 0 && $mem(#s1, $dot($ptr(^_LIST_ENTRY, #r), _LIST_ENTRY.Blink)) == 0 && $mem(#s1, $dot($ptr(^_LIST_ENTRY, #r), _LIST_ENTRY.Manager)) == 0));

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

axiom $field_offset(_LIST_ENTRY.Blink) == 8;

axiom (forall #p: $ptr :: { $dot(#p, _LIST_ENTRY.Blink) } $is(#p, ^_LIST_ENTRY) ==> $dot(#p, _LIST_ENTRY.Blink) == $ptr($ptr_to(^_LIST_ENTRY), $ref(#p) + 8) && $extent_hint($dot(#p, _LIST_ENTRY.Blink), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _LIST_ENTRY.Blink)) } { $st(#s, $dot(#p, _LIST_ENTRY.Blink)) } $typed2(#s, #p, ^_LIST_ENTRY) ==> $field_properties(#s, #p, _LIST_ENTRY.Blink, $ptr_to(^_LIST_ENTRY), false));

const unique _LIST_ENTRY.Manager: $field;

axiom $static_field_properties(_LIST_ENTRY.Manager, ^_LIST_ENTRY);

axiom $is_primitive_non_volatile_field(_LIST_ENTRY.Manager);

axiom (forall #p: $ptr :: { $dot(#p, _LIST_ENTRY.Manager) } $is(#p, ^_LIST_ENTRY) ==> $dot(#p, _LIST_ENTRY.Manager) == $ptr($spec_ptr_to(^_LIST_MANAGER), $ghost_ref(#p, _LIST_ENTRY.Manager)) && $extent_hint($dot(#p, _LIST_ENTRY.Manager), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _LIST_ENTRY.Manager)) } { $st(#s, $dot(#p, _LIST_ENTRY.Manager)) } $typed2(#s, #p, ^_LIST_ENTRY) ==> $field_properties(#s, #p, _LIST_ENTRY.Manager, $spec_ptr_to(^_LIST_MANAGER), false));

const unique ^_LIST_MANAGER: $ctype;

axiom $is_composite(^_LIST_MANAGER);

axiom $ptr_level(^_LIST_MANAGER) == 0;

axiom $sizeof(^_LIST_MANAGER) == 1;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_LIST_MANAGER) } $inv2(#s1, #s2, #p, ^_LIST_MANAGER) == ($typed(#s2, #p) && (forall Q#p$1^47.31#dt1: int :: { $keeps(#s2, #p, $ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1))) ==> $keeps(#s2, #p, $ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1)) ==> $ptr_eq($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1), _LIST_ENTRY.Manager), ^_LIST_MANAGER), #p)) && $keeps(#s2, #p, $read_ptr(#s2, $dot(#p, _LIST_MANAGER.ListHead), ^_LIST_ENTRY)) && $keeps(#s2, #p, $read_ptr(#s2, $dot($read_ptr(#s2, $dot(#p, _LIST_MANAGER.ListHead), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY)) && (forall Q#p$1^60.31#dt1: int :: { $keeps(#s2, #p, $read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)) } { sk_hack($keeps(#s2, #p, $read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1))) ==> $keeps(#s2, #p, $ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1)) ==> $keeps(#s2, #p, $read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)) && $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1))) && (forall Q#p$1^66.31#dt1: int :: { $keeps(#s2, #p, $read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)) } { sk_hack($keeps(#s2, #p, $read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1))) ==> $keeps(#s2, #p, $ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1)) ==> $keeps(#s2, #p, $read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)) && $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1))) && (forall Q#p$1^75.31#dt1: int :: { $keeps(#s2, #p, $ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1)) } { sk_hack($keeps(#s2, #p, $read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1))) ==> $keeps(#s2, #p, $ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1)) && $ptr_neq($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $read_ptr(#s2, $dot(#p, _LIST_MANAGER.ListHead), ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem(#s2, $dot(#p, _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1))) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem(#s2, $dot(#p, _LIST_MANAGER.index))), $ref($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)))) && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem(#s2, $dot(#p, _LIST_MANAGER.index))), $ref($read_ptr(#s2, $dot(#p, _LIST_MANAGER.ListHead), ^_LIST_ENTRY))) == 0 && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem(#s2, $dot(#p, _LIST_MANAGER.index))), $ref($read_ptr(#s2, $dot($read_ptr(#s2, $dot(#p, _LIST_MANAGER.ListHead), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) == $mem(#s2, $dot(#p, _LIST_MANAGER.size)) - 1 && (forall Q#e$1^83.31#dt1: int :: { $keeps(#s2, #p, $ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1))) ==> $keeps(#s2, #p, $ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem(#s2, $dot(#p, _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1))) < $mem(#s2, $dot(#p, _LIST_MANAGER.size))) && (forall Q#e1$1^87.31#dt1: int, Q#e2$1^87.31#dt1: int :: { $keeps(#s2, #p, $ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1)), $keeps(#s2, #p, $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1))) && $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1))) ==> $keeps(#s2, #p, $ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1)) && $keeps(#s2, #p, $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) && $ptr_neq($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem(#s2, $dot(#p, _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1))) != $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem(#s2, $dot(#p, _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1))))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^_LIST_MANAGER, #r), l#public) } $inv_lab(#s2, $ptr(^_LIST_MANAGER, #r), l#public) == ($typed(#s2, $ptr(^_LIST_MANAGER, #r)) && (forall Q#p$1^47.31#dt1: int :: { $keeps(#s2, $ptr(^_LIST_MANAGER, #r), $ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1))) ==> $keeps(#s2, $ptr(^_LIST_MANAGER, #r), $ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1)) ==> $ptr_eq($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1), _LIST_ENTRY.Manager), ^_LIST_MANAGER), $ptr(^_LIST_MANAGER, #r))) && $keeps(#s2, $ptr(^_LIST_MANAGER, #r), $read_ptr(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.ListHead), ^_LIST_ENTRY)) && $keeps(#s2, $ptr(^_LIST_MANAGER, #r), $read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY)) && (forall Q#p$1^60.31#dt1: int :: { $keeps(#s2, $ptr(^_LIST_MANAGER, #r), $read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)) } { sk_hack($keeps(#s2, $ptr(^_LIST_MANAGER, #r), $read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1))) ==> $keeps(#s2, $ptr(^_LIST_MANAGER, #r), $ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1)) ==> $keeps(#s2, $ptr(^_LIST_MANAGER, #r), $read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)) && $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1))) && (forall Q#p$1^66.31#dt1: int :: { $keeps(#s2, $ptr(^_LIST_MANAGER, #r), $read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)) } { sk_hack($keeps(#s2, $ptr(^_LIST_MANAGER, #r), $read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1))) ==> $keeps(#s2, $ptr(^_LIST_MANAGER, #r), $ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1)) ==> $keeps(#s2, $ptr(^_LIST_MANAGER, #r), $read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)) && $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1))) && (forall Q#p$1^75.31#dt1: int :: { $keeps(#s2, $ptr(^_LIST_MANAGER, #r), $ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1)) } { sk_hack($keeps(#s2, $ptr(^_LIST_MANAGER, #r), $read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1))) ==> $keeps(#s2, $ptr(^_LIST_MANAGER, #r), $ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1)) && $ptr_neq($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $read_ptr(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.ListHead), ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1))) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.index))), $ref($read_ptr(#s2, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)))) && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.index))), $ref($read_ptr(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.ListHead), ^_LIST_ENTRY))) == 0 && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.index))), $ref($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) == $mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.size)) - 1 && (forall Q#e$1^83.31#dt1: int :: { $keeps(#s2, $ptr(^_LIST_MANAGER, #r), $ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1))) ==> $keeps(#s2, $ptr(^_LIST_MANAGER, #r), $ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1))) < $mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.size))) && (forall Q#e1$1^87.31#dt1: int, Q#e2$1^87.31#dt1: int :: { $keeps(#s2, $ptr(^_LIST_MANAGER, #r), $ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1)), $keeps(#s2, $ptr(^_LIST_MANAGER, #r), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1))) && $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1))) ==> $keeps(#s2, $ptr(^_LIST_MANAGER, #r), $ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1)) && $keeps(#s2, $ptr(^_LIST_MANAGER, #r), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) && $ptr_neq($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1))) != $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem(#s2, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1))))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^_LIST_MANAGER, #r)) } $in_full_extent_of(#q, $ptr(^_LIST_MANAGER, #r)) == (#q == $ptr(^_LIST_MANAGER, #r) || #q == $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.$owns) || #q == $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.size) || #q == $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.ListHead) || #q == $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.index)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_LIST_MANAGER, #r)) } $in_extent_of(#s, #q, $ptr(^_LIST_MANAGER, #r)) == $in_struct_extent_of(#q, $ptr(^_LIST_MANAGER, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_LIST_MANAGER, #r)) } $typed(#s, $ptr(^_LIST_MANAGER, #r)) ==> $in_extent_of(#s, #q, $ptr(^_LIST_MANAGER, #r)) == (#q == $ptr(^_LIST_MANAGER, #r) || $emb(#s, #q) == $ptr(^_LIST_MANAGER, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^_LIST_MANAGER, #r)) } $in_span_of(#q, $ptr(^_LIST_MANAGER, #r)) == (#q == $ptr(^_LIST_MANAGER, #r) || #q == $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.$owns) || #q == $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.size) || #q == $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.ListHead) || #q == $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.index)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^_LIST_MANAGER) } $state_spans_the_same(#s1, #s2, #p, ^_LIST_MANAGER) == ($mem_eq(#s1, #s2, $dot(#p, _LIST_MANAGER.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_MANAGER.size)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_MANAGER.ListHead)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_MANAGER.index))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_LIST_MANAGER) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_LIST_MANAGER) == ($mem_eq(#s1, #s2, $dot(#p, _LIST_MANAGER.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_MANAGER.size)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_MANAGER.ListHead)) && $mem_eq(#s1, #s2, $dot(#p, _LIST_MANAGER.index))));

axiom $is_claimable(^_LIST_MANAGER) == false;

axiom $has_volatile_owns_set(^_LIST_MANAGER) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^_LIST_MANAGER, #r)) } $extent_mutable(#s1, $ptr(^_LIST_MANAGER, #r)) == $mutable(#s1, $ptr(^_LIST_MANAGER, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^_LIST_MANAGER, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^_LIST_MANAGER, #r)) == $is_fresh(#s1, #s2, $ptr(^_LIST_MANAGER, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^_LIST_MANAGER, #r)) } $extent_zero(#s1, $ptr(^_LIST_MANAGER, #r)) == ($mem(#s1, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.size)) == 0 && $mem(#s1, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.ListHead)) == 0 && $mem(#s1, $dot($ptr(^_LIST_MANAGER, #r), _LIST_MANAGER.index)) == 0));

const unique _LIST_MANAGER.$owns: $field;

axiom $static_field_properties(_LIST_MANAGER.$owns, ^_LIST_MANAGER);

axiom $is_primitive_non_volatile_field(_LIST_MANAGER.$owns);

axiom (forall #p: $ptr :: { $dot(#p, _LIST_MANAGER.$owns) } $is(#p, ^_LIST_MANAGER) ==> $dot(#p, _LIST_MANAGER.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, _LIST_MANAGER.$owns)) && $extent_hint($dot(#p, _LIST_MANAGER.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _LIST_MANAGER.$owns)) } { $st(#s, $dot(#p, _LIST_MANAGER.$owns)) } $typed2(#s, #p, ^_LIST_MANAGER) ==> $field_properties(#s, #p, _LIST_MANAGER.$owns, ^$#ptrset, false));

axiom $owns_set_field(^_LIST_MANAGER) == _LIST_MANAGER.$owns;

const unique _LIST_MANAGER.size: $field;

axiom $static_field_properties(_LIST_MANAGER.size, ^_LIST_MANAGER);

axiom $is_primitive_non_volatile_field(_LIST_MANAGER.size);

axiom (forall #p: $ptr :: { $dot(#p, _LIST_MANAGER.size) } $is(#p, ^_LIST_MANAGER) ==> $dot(#p, _LIST_MANAGER.size) == $ptr(^^u4, $ghost_ref(#p, _LIST_MANAGER.size)) && $extent_hint($dot(#p, _LIST_MANAGER.size), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _LIST_MANAGER.size)) } { $st(#s, $dot(#p, _LIST_MANAGER.size)) } $typed2(#s, #p, ^_LIST_MANAGER) ==> $field_properties(#s, #p, _LIST_MANAGER.size, ^^u4, false));

const unique _LIST_MANAGER.ListHead: $field;

axiom $static_field_properties(_LIST_MANAGER.ListHead, ^_LIST_MANAGER);

axiom $is_primitive_non_volatile_field(_LIST_MANAGER.ListHead);

axiom (forall #p: $ptr :: { $dot(#p, _LIST_MANAGER.ListHead) } $is(#p, ^_LIST_MANAGER) ==> $dot(#p, _LIST_MANAGER.ListHead) == $ptr($ptr_to(^_LIST_ENTRY), $ghost_ref(#p, _LIST_MANAGER.ListHead)) && $extent_hint($dot(#p, _LIST_MANAGER.ListHead), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _LIST_MANAGER.ListHead)) } { $st(#s, $dot(#p, _LIST_MANAGER.ListHead)) } $typed2(#s, #p, ^_LIST_MANAGER) ==> $field_properties(#s, #p, _LIST_MANAGER.ListHead, $ptr_to(^_LIST_ENTRY), false));

const unique _LIST_MANAGER.index: $field;

axiom $static_field_properties(_LIST_MANAGER.index, ^_LIST_MANAGER);

axiom $is_primitive_non_volatile_field(_LIST_MANAGER.index);

axiom (forall #p: $ptr :: { $dot(#p, _LIST_MANAGER.index) } $is(#p, ^_LIST_MANAGER) ==> $dot(#p, _LIST_MANAGER.index) == $ptr($map_t($ptr_to(^_LIST_ENTRY), ^^u4), $ghost_ref(#p, _LIST_MANAGER.index)) && $extent_hint($dot(#p, _LIST_MANAGER.index), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _LIST_MANAGER.index)) } { $st(#s, $dot(#p, _LIST_MANAGER.index)) } $typed2(#s, #p, ^_LIST_MANAGER) ==> $field_properties(#s, #p, _LIST_MANAGER.index, $map_t($ptr_to(^_LIST_ENTRY), ^^u4), false));

procedure _LIST_MANAGER#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> (forall Q#p$1^47.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1)) ==> $ptr_eq($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1), _LIST_ENTRY.Manager), ^_LIST_MANAGER), $ptr(^_LIST_MANAGER, P#_this_)));
  ensures $is_admissibility_check() ==> $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $read_ptr($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.ListHead), ^_LIST_ENTRY));
  ensures $is_admissibility_check() ==> $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY));
  ensures $is_admissibility_check() ==> (forall Q#p$1^60.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1)) ==> $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1)));
  ensures $is_admissibility_check() ==> (forall Q#p$1^66.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1)) ==> $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1)));
  ensures $is_admissibility_check() ==> (forall Q#p$1^75.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1)) && $ptr_neq($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $read_ptr($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.ListHead), ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1))) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))));
  ensures $is_admissibility_check() ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.ListHead), ^_LIST_ENTRY))) == 0;
  ensures $is_admissibility_check() ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) == $mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.size)) - 1;
  ensures $is_admissibility_check() ==> (forall Q#e$1^83.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1))) < $mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.size)));
  ensures $is_admissibility_check() ==> (forall Q#e1$1^87.31#dt1: int, Q#e2$1^87.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1)), $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1))) && $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1)) && $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) && $ptr_neq($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1))) != $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1))));
  ensures $is_unwrap_check() ==> (forall Q#p$1^47.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1)) ==> $ptr_eq($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1), _LIST_ENTRY.Manager), ^_LIST_MANAGER), $ptr(^_LIST_MANAGER, P#_this_)));
  ensures $is_unwrap_check() ==> $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $read_ptr($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.ListHead), ^_LIST_ENTRY));
  ensures $is_unwrap_check() ==> $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY));
  ensures $is_unwrap_check() ==> (forall Q#p$1^60.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1)) ==> $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1)));
  ensures $is_unwrap_check() ==> (forall Q#p$1^66.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1)) ==> $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1)));
  ensures $is_unwrap_check() ==> (forall Q#p$1^75.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1)) && $ptr_neq($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $read_ptr($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.ListHead), ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1))) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))));
  ensures $is_unwrap_check() ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.ListHead), ^_LIST_ENTRY))) == 0;
  ensures $is_unwrap_check() ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) == $mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.size)) - 1;
  ensures $is_unwrap_check() ==> (forall Q#e$1^83.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1))) < $mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.size)));
  ensures $is_unwrap_check() ==> (forall Q#e1$1^87.31#dt1: int, Q#e2$1^87.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1)), $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1))) && $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1)) && $keeps($s, $ptr(^_LIST_MANAGER, P#_this_), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) && $ptr_neq($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1))) != $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, P#_this_), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1))));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _LIST_MANAGER#adm(P#_this_: int)
{
  var #wrTime$1^37.53: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^37.53, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^37.53, #loc._this_, $ptr_to_int($ptr(^_LIST_MANAGER, P#_this_)), $spec_ptr_to(^_LIST_MANAGER)) && $local_value_is_ptr($s, #tok$1^37.53, #loc._this_, $ptr(^_LIST_MANAGER, P#_this_), $spec_ptr_to(^_LIST_MANAGER));
    assume #wrTime$1^37.53 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^37.53, #p) } $in_writes_at(#wrTime$1^37.53, #p) == false);
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
        assume $good_state_ext(#tok$1^37.53, $s);
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
        assume $good_state_ext(#tok$1^37.53, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^_LIST_MANAGER, P#_this_), ^_LIST_MANAGER);
    }

  #exit:
}



procedure InitializeListHead(P#ListHead: int);
  modifies $s, $cev_pc;
  ensures $wrapped($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), ^_LIST_MANAGER) && $is_fresh(old($s), $s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER));
  ensures $set_eq($owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)), $set_singleton($ptr(^_LIST_ENTRY, P#ListHead))) && $set_in($ptr(^_LIST_ENTRY, P#ListHead), $owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)));
  ensures $mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.size)) == 1;
  ensures $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, P#ListHead));
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $span($ptr(^_LIST_ENTRY, P#ListHead))) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $span($ptr(^_LIST_ENTRY, P#ListHead))) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $span($ptr(^_LIST_ENTRY, P#ListHead))) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation InitializeListHead(P#ListHead: int)
{
  var prestate#14: $state;
  var owns#12: $ptrset;
  var staticWrapState#11: $state;
  var prestate#13: $state;
  var #callConv#0: $ptr;
  var SL#ListManager: int where $in_range_spec_ptr(SL#ListManager);
  var #wrTime$2^7.1: int;
  var #stackframe: int;

  anon7:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$2^7.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$2^7.1, #loc.ListHead, $ptr_to_int($ptr(^_LIST_ENTRY, P#ListHead)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^7.1, #loc.ListHead, $ptr(^_LIST_ENTRY, P#ListHead), $ptr_to(^_LIST_ENTRY));
    assume #wrTime$2^7.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$2^7.1, #p) } $in_writes_at(#wrTime$2^7.1, #p) == $set_in(#p, $span($ptr(^_LIST_ENTRY, P#ListHead))));
    assume (forall #p: $ptr :: { $extent_hint(#p, $ptr(^_LIST_ENTRY, P#ListHead)) } $set_in(#p, $span($ptr(^_LIST_ENTRY, P#ListHead))) ==> $mutable($s, #p));
    // assume @in_range_phys_ptr((mathint)ListHead); 
    assume $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, P#ListHead)));
    // struct _LIST_MANAGER^ ListManager; 
    assume $local_value_is($s, #tok$2^9.27, #loc.ListManager, $ptr_to_int($ptr(^_LIST_MANAGER, SL#ListManager)), $spec_ptr_to(^_LIST_MANAGER)) && $local_value_is_ptr($s, #tok$2^9.27, #loc.ListManager, $ptr(^_LIST_MANAGER, SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // var spec struct _LIST_MANAGER^ ListManager
    // assert @_vcc_typed2(@state, (ListHead->Blink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), $ptr_to(^_LIST_ENTRY));
    // assert @prim_writes_check((ListHead->Blink)); 
    assert $writable($s, #wrTime$2^7.1, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink));
    // *(ListHead->Blink) := ListHead; 
    call $write_int($dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), $ref($ptr(^_LIST_ENTRY, P#ListHead)));
    assume $full_stop_ext(#tok$2^10.23, $s);
    // assert @_vcc_typed2(@state, (ListHead->Flink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    // assert @prim_writes_check((ListHead->Flink)); 
    assert $writable($s, #wrTime$2^7.1, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink));
    // *(ListHead->Flink) := ListHead; 
    call $write_int($dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), $ref($ptr(^_LIST_ENTRY, P#ListHead)));
    assume $full_stop_ext(#tok$2^10.5, $s);
    // ListManager := _vcc_spec_alloc<struct _LIST_MANAGER>(); 
    call #callConv#0 := $spec_alloc(^_LIST_MANAGER);
    assume $full_stop_ext(#tok$2^13.19, $s);
    SL#ListManager := $ref(#callConv#0);
    assume $local_value_is($s, #tok$2^13.19, #loc.ListManager, $ptr_to_int($ptr(^_LIST_MANAGER, SL#ListManager)), $spec_ptr_to(^_LIST_MANAGER)) && $local_value_is_ptr($s, #tok$2^13.19, #loc.ListManager, $ptr(^_LIST_MANAGER, SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // assert @_vcc_typed2(@state, (ListManager->size)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), ^^u4);
    // assert @prim_writes_check((ListManager->size)); 
    assert $writable($s, #wrTime$2^7.1, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size));
    // *(ListManager->size) := 1; 
    call $write_int($dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), 1);
    assume $full_stop_ext(#tok$2^14.5, $s);
    // assert @_vcc_typed2(@state, (ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @prim_writes_check((ListManager->index)); 
    assert $writable($s, #wrTime$2^7.1, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index));
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // *(ListManager->index) := @map_updated(*((ListManager->index)), ListHead, 0); 
    call $write_int($dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int($store.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, P#ListHead)), 0)));
    assume $full_stop_ext(#tok$2^15.5, $s);
    // assert @_vcc_typed2(@state, (ListManager->ListHead)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), $ptr_to(^_LIST_ENTRY));
    // assert @prim_writes_check((ListManager->ListHead)); 
    assert $writable($s, #wrTime$2^7.1, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead));
    // *(ListManager->ListHead) := ListHead; 
    call $write_int($dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), $ref($ptr(^_LIST_ENTRY, P#ListHead)));
    assume $full_stop_ext(#tok$2^16.5, $s);
    // assert @_vcc_typed2(@state, (ListHead->Manager)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), $spec_ptr_to(^_LIST_MANAGER));
    // assert @prim_writes_check((ListHead->Manager)); 
    assert $writable($s, #wrTime$2^7.1, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager));
    // *(ListHead->Manager) := ListManager; 
    call $write_int($dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), $ref($ptr(^_LIST_MANAGER, SL#ListManager)));
    assume $full_stop_ext(#tok$2^17.5, $s);
    // assert @writes_check(@_vcc_span(ListManager)); 
    assert (forall #writes$2^18.27: $ptr :: { $dont_instantiate(#writes$2^18.27) } $set_in(#writes$2^18.27, $span($ptr(^_LIST_MANAGER, SL#ListManager))) ==> $top_writable($s, #wrTime$2^7.1, #writes$2^18.27));
    // stmt _vcc_set_owns(ListManager, @_vcc_set_singleton(ListHead)); 
    call $set_owns($ptr(^_LIST_MANAGER, SL#ListManager), $set_singleton($ptr(^_LIST_ENTRY, P#ListHead)));
    assume $full_stop_ext(#tok$2^18.27, $s);
    // empty
    // _math state_t prestate#13; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#13, $state_to_int(prestate#13), ^$#state_t);
    // prestate#13 := @_vcc_current_state(@state); 
    prestate#13 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#13, $state_to_int(prestate#13), ^$#state_t);
    // _math state_t staticWrapState#11; 
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#11, $state_to_int(staticWrapState#11), ^$#state_t);
    // staticWrapState#11 := @_vcc_current_state(@state); 
    staticWrapState#11 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#11, $state_to_int(staticWrapState#11), ^$#state_t);
    // _math ptrset owns#12; 
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#12, $ptrset_to_int(owns#12), ^$#ptrset);
    // owns#12 := @_vcc_set_empty; 
    owns#12 := $set_empty();
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#12, $ptrset_to_int(owns#12), ^$#ptrset);
    // assert @writes_check(ListHead); 
    assert $top_writable($s, #wrTime$2^7.1, $ptr(^_LIST_ENTRY, P#ListHead));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(ListHead), staticWrapState#11, owns#12)
    call $static_wrap($ptr(^_LIST_ENTRY, P#ListHead), staticWrapState#11, owns#12);
    assume $good_state_ext(#tok$2^19.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, ListHead), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^_LIST_ENTRY, P#ListHead)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#14; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#14, $state_to_int(prestate#14), ^$#state_t);
    // prestate#14 := @_vcc_current_state(@state); 
    prestate#14 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#14, $state_to_int(prestate#14), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$2^7.1, $ptr(^_LIST_MANAGER, SL#ListManager));
    // assert @writes_check(@_vcc_owns(@state, ListManager)); 
    assert (forall #writes$2^20.21: $ptr :: { $dont_instantiate(#writes$2^20.21) } $set_in(#writes$2^20.21, $owns($s, $ptr(^_LIST_MANAGER, SL#ListManager))) ==> $top_writable($s, #wrTime$2^7.1, #writes$2^20.21));
    // stmt @_vcc_wrap(ListManager, @_vcc_typeof(ListManager)); 
    call $wrap($ptr(^_LIST_MANAGER, SL#ListManager), ^_LIST_MANAGER);
    assume $good_state_ext(#tok$2^20.21, $s);
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } @in_range_phys_ptr((mathint)p); ==>(@keeps(ListManager, p), @_vcc_ptr_eq(*((p->Manager)), ListManager)))); 
    assert (forall Q#p$1^47.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1)) ==> $ptr_eq($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1), _LIST_ENTRY.Manager), ^_LIST_MANAGER), $ptr(^_LIST_MANAGER, SL#ListManager)));
    // assert @inv_check(@keeps(ListManager, *((ListManager->ListHead)))); 
    assert $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY));
    // assert @inv_check(@keeps(ListManager, *((*((ListManager->ListHead))->Blink)))); 
    assert $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Flink))) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } @in_range_phys_ptr((mathint)p); ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Flink))), @_vcc_ptr_eq(*((*((p->Flink))->Blink)), p))))); 
    assert (forall Q#p$1^60.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1)) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1)));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Blink))) } { @trigger_hint(@keeps(ListManager, *((p->Blink)))) } @in_range_phys_ptr((mathint)p); ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Blink))), @_vcc_ptr_eq(*((*((p->Blink))->Flink)), p))))); 
    assert (forall Q#p$1^66.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1)) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1)));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } @in_range_phys_ptr((mathint)p); ==>(&&(@keeps(ListManager, p), @_vcc_ptr_neq(*((p->Flink)), *((ListManager->ListHead)))), ==(+(@map_get(*((ListManager->index)), p), 1), @map_get(*((ListManager->index)), *((p->Flink))))))); 
    assert (forall Q#p$1^75.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1)) && $ptr_neq($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1))) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))));
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((ListManager->ListHead))), 0)); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY))) == 0;
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((*((ListManager->ListHead))->Blink))), -(*((ListManager->size)), 1))); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) == $mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)) - 1;
    // assert @inv_check(forall(struct _LIST_ENTRY* e; { @keeps(ListManager, e) } @in_range_phys_ptr((mathint)e); ==>(@keeps(ListManager, e), <(@map_get(*((ListManager->index)), e), *((ListManager->size)))))); 
    assert (forall Q#e$1^83.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1))) < $mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)));
    // assert @inv_check(forall(struct _LIST_ENTRY* e1; struct _LIST_ENTRY* e2; { @keeps(ListManager, e1), @keeps(ListManager, e2) } &&(@in_range_phys_ptr((mathint)e1), @in_range_phys_ptr((mathint)e2)); ==>(&&(&&(@keeps(ListManager, e1), @keeps(ListManager, e2)), @_vcc_ptr_neq(e1, e2)), !=(@map_get(*((ListManager->index)), e1), @map_get(*((ListManager->index)), e2))))); 
    assert (forall Q#e1$1^87.31#dt1: int, Q#e2$1^87.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1)), $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1))) && $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1)) && $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) && $ptr_neq($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1))) != $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure IsListEmpty(P#ListHead: int) returns ($result: bool);
  requires $wrapped($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), ^_LIST_MANAGER);
  requires $set_in($ptr(^_LIST_ENTRY, P#ListHead), $owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)));
  modifies $s, $cev_pc;
  ensures $result == ($mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.size)) == 1);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation IsListEmpty(P#ListHead: int) returns ($result: bool)
{
  var #wrTime$2^24.1: int;
  var #stackframe: int;

  anon8:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$2^24.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$2^24.1, #loc.ListHead, $ptr_to_int($ptr(^_LIST_ENTRY, P#ListHead)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^24.1, #loc.ListHead, $ptr(^_LIST_ENTRY, P#ListHead), $ptr_to(^_LIST_ENTRY));
    assume #wrTime$2^24.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$2^24.1, #p) } $in_writes_at(#wrTime$2^24.1, #p) == false);
    // assume @in_range_phys_ptr((mathint)ListHead); 
    assume $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, P#ListHead)));
    // assert @_vcc_in_domain(@state, *((ListHead->Manager)), *((ListHead->Manager))); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), l#public);
    // assert @_vcc_set_in(*((ListHead->Flink)), @_vcc_owns(@state, *((ListHead->Manager)))); 
    assert $set_in($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)));
    // assume @_vcc_set_in(*((ListHead->Flink)), @_vcc_owns(@state, *((ListHead->Manager)))); 
    assume $set_in($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)));
    // assert @reads_check_normal((ListHead->Flink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    assert $thread_local2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    // return @_vcc_ptr_eq(*((ListHead->Flink)), ListHead); 
    $result := $ptr_eq($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, P#ListHead));
    assert $position_marker();
    goto #exit;

  anon9:
    // empty

  #exit:
}



procedure RemoveEntryList(P#Entry: int) returns ($result: bool);
  requires $set_in($ptr(^_LIST_ENTRY, P#Entry), $owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), ^_LIST_MANAGER)));
  requires $ptr_neq($ptr(^_LIST_ENTRY, P#Entry), $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.ListHead), ^_LIST_ENTRY));
  requires $wrapped($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), ^_LIST_MANAGER), ^_LIST_MANAGER);
  modifies $s, $cev_pc;
  ensures $wrapped($s, $ptr(^_LIST_ENTRY, P#Entry), ^_LIST_ENTRY) && $is_fresh(old($s), $s, $ptr(^_LIST_ENTRY, P#Entry));
  ensures $set_eq($owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), ^_LIST_MANAGER)), $set_difference($owns(old($s), $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), ^_LIST_MANAGER)), $set_singleton($ptr(^_LIST_ENTRY, P#Entry))));
  ensures $mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.size)) == $mem(old($s), $dot($read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.size)) - 1;
  ensures $ptr_eq($read_ptr(old($s), $dot($read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), $read_ptr($s, $dot($read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.ListHead), ^_LIST_ENTRY));
  ensures (forall Q#le$1^153.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#le$1^153.29#dt1))) ==> $set_in($ptr(^_LIST_ENTRY, Q#le$1^153.29#dt1), $owns(old($s), $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), ^_LIST_MANAGER))) ==> $emb(old($s), $ptr(^_LIST_ENTRY, Q#le$1^153.29#dt1)) == $emb($s, $ptr(^_LIST_ENTRY, Q#le$1^153.29#dt1)));
  ensures $wrapped($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), ^_LIST_MANAGER), ^_LIST_MANAGER);
  ensures $result == ($mem($s, $dot($read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.size)) == 1);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), ^_LIST_MANAGER) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), ^_LIST_MANAGER) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), ^_LIST_MANAGER) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation RemoveEntryList(P#Entry: int) returns ($result: bool)
{
  var prestate#28: $state;
  var res_lambda#1#6: $map_t..$ptr_to..^_LIST_ENTRY.^^u4;
  var owns#26: $ptrset;
  var staticWrapState#25: $state;
  var prestate#27: $state;
  var prestate#24: $state;
  var prestate#22: $state;
  var owns#23: $ptrset;
  var owns#20: $ptrset;
  var staticWrapState#19: $state;
  var prestate#21: $state;
  var prestate#18: $state;
  var prestate#16: $state;
  var owns#17: $ptrset;
  var prestate#15: $state;
  var L#Blink: int where $in_range_phys_ptr(L#Blink);
  var L#Flink: int where $in_range_phys_ptr(L#Flink);
  var SL#ListManager: int where $in_range_spec_ptr(SL#ListManager);
  var #wrTime$2^30.1: int;
  var #stackframe: int;

  anon10:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$2^30.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$2^30.1, #loc.Entry, $ptr_to_int($ptr(^_LIST_ENTRY, P#Entry)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^30.1, #loc.Entry, $ptr(^_LIST_ENTRY, P#Entry), $ptr_to(^_LIST_ENTRY));
    assume #wrTime$2^30.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$2^30.1, #p) } $in_writes_at(#wrTime$2^30.1, #p) == (#p == $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), ^_LIST_MANAGER)));
    assume $thread_owned($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), ^_LIST_MANAGER));
    // assume @in_range_phys_ptr((mathint)Entry); 
    assume $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, P#Entry)));
    // assert @_vcc_in_domain(@state, *((Entry->Manager)), *((Entry->Manager))); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), ^_LIST_MANAGER), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), ^_LIST_MANAGER), l#public);
    // struct _LIST_MANAGER^ ListManager; 
    assume $local_value_is($s, #tok$2^33.27, #loc.ListManager, $ptr_to_int($ptr(^_LIST_MANAGER, SL#ListManager)), $spec_ptr_to(^_LIST_MANAGER)) && $local_value_is_ptr($s, #tok$2^33.27, #loc.ListManager, $ptr(^_LIST_MANAGER, SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // struct _LIST_ENTRY* Flink; 
    assume $local_value_is($s, #tok$2^32.5, #loc.Flink, $ptr_to_int($ptr(^_LIST_ENTRY, L#Flink)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^32.5, #loc.Flink, $ptr(^_LIST_ENTRY, L#Flink), $ptr_to(^_LIST_ENTRY));
    // struct _LIST_ENTRY* Blink; 
    assume $local_value_is($s, #tok$2^32.5, #loc.Blink, $ptr_to_int($ptr(^_LIST_ENTRY, L#Blink)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^32.5, #loc.Blink, $ptr(^_LIST_ENTRY, L#Blink), $ptr_to(^_LIST_ENTRY));
    // var struct _LIST_ENTRY* Blink
    // var struct _LIST_ENTRY* Flink
    // assert @reads_check_normal((Entry->Manager)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), $spec_ptr_to(^_LIST_MANAGER));
    assert $thread_local2($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), $spec_ptr_to(^_LIST_MANAGER));
    // ListManager := *((Entry->Manager)); 
    SL#ListManager := $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), ^_LIST_MANAGER));
    assume $local_value_is($s, #tok$2^33.27, #loc.ListManager, $ptr_to_int($ptr(^_LIST_MANAGER, SL#ListManager)), $spec_ptr_to(^_LIST_MANAGER)) && $local_value_is_ptr($s, #tok$2^33.27, #loc.ListManager, $ptr(^_LIST_MANAGER, SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // assert @_vcc_in_domain(@state, Entry, ListManager); 
    assert $in_domain_lab($s, $ptr(^_LIST_ENTRY, P#Entry), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assume @_vcc_in_domain(@state, Entry, ListManager); 
    assume $in_domain_lab($s, $ptr(^_LIST_ENTRY, P#Entry), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assert @_vcc_in_domain(@state, *((Entry->Blink)), ListManager); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Blink), ^_LIST_ENTRY), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assume @_vcc_in_domain(@state, *((Entry->Blink)), ListManager); 
    assume $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Blink), ^_LIST_ENTRY), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assert @_vcc_in_domain(@state, *((Entry->Flink)), ListManager); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assume @_vcc_in_domain(@state, *((Entry->Flink)), ListManager); 
    assume $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assert @reads_check_normal((Entry->Blink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Blink), $ptr_to(^_LIST_ENTRY));
    assert $thread_local2($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Blink), $ptr_to(^_LIST_ENTRY));
    // Blink := *((Entry->Blink)); 
    L#Blink := $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Blink), ^_LIST_ENTRY));
    assume $local_value_is($s, #tok$2^39.5, #loc.Blink, $ptr_to_int($ptr(^_LIST_ENTRY, L#Blink)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^39.5, #loc.Blink, $ptr(^_LIST_ENTRY, L#Blink), $ptr_to(^_LIST_ENTRY));
    // assert @reads_check_normal((Entry->Flink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    assert $thread_local2($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    // Flink := *((Entry->Flink)); 
    L#Flink := $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Flink), ^_LIST_ENTRY));
    assume $local_value_is($s, #tok$2^40.5, #loc.Flink, $ptr_to_int($ptr(^_LIST_ENTRY, L#Flink)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^40.5, #loc.Flink, $ptr(^_LIST_ENTRY, L#Flink), $ptr_to(^_LIST_ENTRY));
    // _math state_t prestate#15; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#15, $state_to_int(prestate#15), ^$#state_t);
    // prestate#15 := @_vcc_current_state(@state); 
    prestate#15 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#15, $state_to_int(prestate#15), ^$#state_t);
    // assert @_vcc_wrapped(@state, ListManager); 
    assert $wrapped($s, $ptr(^_LIST_MANAGER, SL#ListManager), ^_LIST_MANAGER);
    // assume @_vcc_inv(@state, ListManager); 
    assume $inv($s, $ptr(^_LIST_MANAGER, SL#ListManager), ^_LIST_MANAGER);
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$2^30.1, $ptr(^_LIST_MANAGER, SL#ListManager));
    // stmt @_vcc_unwrap(ListManager, @_vcc_typeof(ListManager)); 
    call $unwrap($ptr(^_LIST_MANAGER, SL#ListManager), ^_LIST_MANAGER);
    assume $good_state_ext(#tok$2^41.32, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math ptrset owns#17; 
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#17, $ptrset_to_int(owns#17), ^$#ptrset);
    // owns#17 := @_vcc_set_empty; 
    owns#17 := $set_empty();
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#17, $ptrset_to_int(owns#17), ^$#ptrset);
    // _math state_t prestate#16; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#16, $state_to_int(prestate#16), ^$#state_t);
    // prestate#16 := @_vcc_current_state(@state); 
    prestate#16 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#16, $state_to_int(prestate#16), ^$#state_t);
    // _math state_t prestate#18; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#18, $state_to_int(prestate#18), ^$#state_t);
    // prestate#18 := @_vcc_current_state(@state); 
    prestate#18 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#18, $state_to_int(prestate#18), ^$#state_t);
    // assert @_vcc_wrapped(@state, Blink); 
    assert $wrapped($s, $ptr(^_LIST_ENTRY, L#Blink), ^_LIST_ENTRY);
    // assert @writes_check(Blink); 
    assert $top_writable($s, #wrTime$2^30.1, $ptr(^_LIST_ENTRY, L#Blink));
    // assume @_vcc_inv(@state, Blink); 
    assume $inv($s, $ptr(^_LIST_ENTRY, L#Blink), ^_LIST_ENTRY);
    // assume ==(owns#17, @_vcc_owns(@state, Blink)); 
    assume owns#17 == $owns($s, $ptr(^_LIST_ENTRY, L#Blink));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(Blink), prestate#18)
    call $static_unwrap($ptr(^_LIST_ENTRY, L#Blink), prestate#18);
    assume $good_state_ext(#tok$2^42.36, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (Blink->Flink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, L#Blink), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    // assert @prim_writes_check((Blink->Flink)); 
    assert $writable($s, #wrTime$2^30.1, $dot($ptr(^_LIST_ENTRY, L#Blink), _LIST_ENTRY.Flink));
    // *(Blink->Flink) := Flink; 
    call $write_int($dot($ptr(^_LIST_ENTRY, L#Blink), _LIST_ENTRY.Flink), $ref($ptr(^_LIST_ENTRY, L#Flink)));
    assume $full_stop_ext(#tok$2^43.13, $s);
    // _math state_t prestate#21; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#21, $state_to_int(prestate#21), ^$#state_t);
    // prestate#21 := @_vcc_current_state(@state); 
    prestate#21 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#21, $state_to_int(prestate#21), ^$#state_t);
    // _math state_t staticWrapState#19; 
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#19, $state_to_int(staticWrapState#19), ^$#state_t);
    // staticWrapState#19 := @_vcc_current_state(@state); 
    staticWrapState#19 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#19, $state_to_int(staticWrapState#19), ^$#state_t);
    // _math ptrset owns#20; 
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#20, $ptrset_to_int(owns#20), ^$#ptrset);
    // owns#20 := @_vcc_set_empty; 
    owns#20 := $set_empty();
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#20, $ptrset_to_int(owns#20), ^$#ptrset);
    // assert @writes_check(Blink); 
    assert $top_writable($s, #wrTime$2^30.1, $ptr(^_LIST_ENTRY, L#Blink));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(Blink), staticWrapState#19, owns#20)
    call $static_wrap($ptr(^_LIST_ENTRY, L#Blink), staticWrapState#19, owns#20);
    assume $good_state_ext(#tok$2^42.36, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, Blink), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^_LIST_ENTRY, L#Blink)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math ptrset owns#23; 
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#23, $ptrset_to_int(owns#23), ^$#ptrset);
    // owns#23 := @_vcc_set_empty; 
    owns#23 := $set_empty();
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#23, $ptrset_to_int(owns#23), ^$#ptrset);
    // _math state_t prestate#22; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#22, $state_to_int(prestate#22), ^$#state_t);
    // prestate#22 := @_vcc_current_state(@state); 
    prestate#22 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#22, $state_to_int(prestate#22), ^$#state_t);
    // _math state_t prestate#24; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#24, $state_to_int(prestate#24), ^$#state_t);
    // prestate#24 := @_vcc_current_state(@state); 
    prestate#24 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#24, $state_to_int(prestate#24), ^$#state_t);
    // assert @_vcc_wrapped(@state, Flink); 
    assert $wrapped($s, $ptr(^_LIST_ENTRY, L#Flink), ^_LIST_ENTRY);
    // assert @writes_check(Flink); 
    assert $top_writable($s, #wrTime$2^30.1, $ptr(^_LIST_ENTRY, L#Flink));
    // assume @_vcc_inv(@state, Flink); 
    assume $inv($s, $ptr(^_LIST_ENTRY, L#Flink), ^_LIST_ENTRY);
    // assume ==(owns#23, @_vcc_owns(@state, Flink)); 
    assume owns#23 == $owns($s, $ptr(^_LIST_ENTRY, L#Flink));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(Flink), prestate#24)
    call $static_unwrap($ptr(^_LIST_ENTRY, L#Flink), prestate#24);
    assume $good_state_ext(#tok$2^45.36, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (Flink->Blink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, L#Flink), _LIST_ENTRY.Blink), $ptr_to(^_LIST_ENTRY));
    // assert @prim_writes_check((Flink->Blink)); 
    assert $writable($s, #wrTime$2^30.1, $dot($ptr(^_LIST_ENTRY, L#Flink), _LIST_ENTRY.Blink));
    // *(Flink->Blink) := Blink; 
    call $write_int($dot($ptr(^_LIST_ENTRY, L#Flink), _LIST_ENTRY.Blink), $ref($ptr(^_LIST_ENTRY, L#Blink)));
    assume $full_stop_ext(#tok$2^46.13, $s);
    // _math state_t prestate#27; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
    // prestate#27 := @_vcc_current_state(@state); 
    prestate#27 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
    // _math state_t staticWrapState#25; 
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#25, $state_to_int(staticWrapState#25), ^$#state_t);
    // staticWrapState#25 := @_vcc_current_state(@state); 
    staticWrapState#25 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#25, $state_to_int(staticWrapState#25), ^$#state_t);
    // _math ptrset owns#26; 
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#26, $ptrset_to_int(owns#26), ^$#ptrset);
    // owns#26 := @_vcc_set_empty; 
    owns#26 := $set_empty();
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#26, $ptrset_to_int(owns#26), ^$#ptrset);
    // assert @writes_check(Flink); 
    assert $top_writable($s, #wrTime$2^30.1, $ptr(^_LIST_ENTRY, L#Flink));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(Flink), staticWrapState#25, owns#26)
    call $static_wrap($ptr(^_LIST_ENTRY, L#Flink), staticWrapState#25, owns#26);
    assume $good_state_ext(#tok$2^45.36, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, Flink), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^_LIST_ENTRY, L#Flink)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (ListManager->size)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), ^^u4);
    // assert @prim_writes_check((ListManager->size)); 
    assert $writable($s, #wrTime$2^30.1, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size));
    // assert @in_range_u4(-(*((ListManager->size)), 1)); 
    assert $in_range_u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)) - 1);
    // assert @reads_check_normal((ListManager->size)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), ^^u4);
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), ^^u4);
    // *(ListManager->size) := -(*((ListManager->size)), 1); 
    call $write_int($dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), $mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)) - 1);
    assume $full_stop_ext(#tok$2^50.9, $s);
    // assert @_vcc_set_in(Entry, @_vcc_owns(@state, ListManager)); 
    assert $set_in($ptr(^_LIST_ENTRY, P#Entry), $owns($s, $ptr(^_LIST_MANAGER, SL#ListManager)));
    // assume @_vcc_set_in(Entry, @_vcc_owns(@state, ListManager)); 
    assume $set_in($ptr(^_LIST_ENTRY, P#Entry), $owns($s, $ptr(^_LIST_MANAGER, SL#ListManager)));
    // assert @writes_check(@_vcc_span(ListManager)); 
    assert (forall #writes$2^51.31: $ptr :: { $dont_instantiate(#writes$2^51.31) } $set_in(#writes$2^51.31, $span($ptr(^_LIST_MANAGER, SL#ListManager))) ==> $top_writable($s, #wrTime$2^30.1, #writes$2^51.31));
    // stmt _vcc_set_owns(ListManager, @_vcc_set_remove_element(@_vcc_owns(@state, ListManager), Entry)); 
    call $set_owns($ptr(^_LIST_MANAGER, SL#ListManager), $set_remove_element($owns($s, $ptr(^_LIST_MANAGER, SL#ListManager)), $ptr(^_LIST_ENTRY, P#Entry)));
    assume $full_stop_ext(#tok$2^51.31, $s);
    // empty
    // (struct _LIST_ENTRY* -> uint32_t) res_lambda#1#6; 
    assume $local_value_is($s, #tok$2^52.31, #loc.res_lambda#1#6, $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#1#6), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // res_lambda#1#6 := lambda#1(*((ListManager->index)), *((ListManager->index)), @map_get(*((ListManager->index)), Entry), *((ListManager->index))); 
    call res_lambda#1#6 := lambda#1($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, P#Entry))), $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))));
    assume $full_stop_ext(#tok$2^52.31, $s);
    assume $local_value_is($s, #tok$2^52.31, #loc.res_lambda#1#6, $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#1#6), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @_vcc_typed2(@state, (ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @prim_writes_check((ListManager->index)); 
    assert $writable($s, #wrTime$2^30.1, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index));
    // *(ListManager->index) := res_lambda#1#6; 
    call $write_int($dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#1#6));
    assume $full_stop_ext(#tok$2^52.9, $s);
    // _math state_t prestate#28; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
    // prestate#28 := @_vcc_current_state(@state); 
    prestate#28 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$2^30.1, $ptr(^_LIST_MANAGER, SL#ListManager));
    // assert @writes_check(@_vcc_owns(@state, ListManager)); 
    assert (forall #writes$2^41.32: $ptr :: { $dont_instantiate(#writes$2^41.32) } $set_in(#writes$2^41.32, $owns($s, $ptr(^_LIST_MANAGER, SL#ListManager))) ==> $top_writable($s, #wrTime$2^30.1, #writes$2^41.32));
    // stmt @_vcc_wrap(ListManager, @_vcc_typeof(ListManager)); 
    call $wrap($ptr(^_LIST_MANAGER, SL#ListManager), ^_LIST_MANAGER);
    assume $good_state_ext(#tok$2^41.32, $s);
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } @in_range_phys_ptr((mathint)p); ==>(@keeps(ListManager, p), @_vcc_ptr_eq(*((p->Manager)), ListManager)))); 
    assert (forall Q#p$1^47.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1)) ==> $ptr_eq($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1), _LIST_ENTRY.Manager), ^_LIST_MANAGER), $ptr(^_LIST_MANAGER, SL#ListManager)));
    // assert @inv_check(@keeps(ListManager, *((ListManager->ListHead)))); 
    assert $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY));
    // assert @inv_check(@keeps(ListManager, *((*((ListManager->ListHead))->Blink)))); 
    assert $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Flink))) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } @in_range_phys_ptr((mathint)p); ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Flink))), @_vcc_ptr_eq(*((*((p->Flink))->Blink)), p))))); 
    assert (forall Q#p$1^60.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1)) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1)));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Blink))) } { @trigger_hint(@keeps(ListManager, *((p->Blink)))) } @in_range_phys_ptr((mathint)p); ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Blink))), @_vcc_ptr_eq(*((*((p->Blink))->Flink)), p))))); 
    assert (forall Q#p$1^66.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1)) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1)));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } @in_range_phys_ptr((mathint)p); ==>(&&(@keeps(ListManager, p), @_vcc_ptr_neq(*((p->Flink)), *((ListManager->ListHead)))), ==(+(@map_get(*((ListManager->index)), p), 1), @map_get(*((ListManager->index)), *((p->Flink))))))); 
    assert (forall Q#p$1^75.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1)) && $ptr_neq($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1))) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))));
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((ListManager->ListHead))), 0)); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY))) == 0;
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((*((ListManager->ListHead))->Blink))), -(*((ListManager->size)), 1))); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) == $mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)) - 1;
    // assert @inv_check(forall(struct _LIST_ENTRY* e; { @keeps(ListManager, e) } @in_range_phys_ptr((mathint)e); ==>(@keeps(ListManager, e), <(@map_get(*((ListManager->index)), e), *((ListManager->size)))))); 
    assert (forall Q#e$1^83.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1))) < $mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)));
    // assert @inv_check(forall(struct _LIST_ENTRY* e1; struct _LIST_ENTRY* e2; { @keeps(ListManager, e1), @keeps(ListManager, e2) } &&(@in_range_phys_ptr((mathint)e1), @in_range_phys_ptr((mathint)e2)); ==>(&&(&&(@keeps(ListManager, e1), @keeps(ListManager, e2)), @_vcc_ptr_neq(e1, e2)), !=(@map_get(*((ListManager->index)), e1), @map_get(*((ListManager->index)), e2))))); 
    assert (forall Q#e1$1^87.31#dt1: int, Q#e2$1^87.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1)), $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1))) && $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1)) && $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) && $ptr_neq($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1))) != $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return @_vcc_ptr_eq(Flink, Blink); 
    $result := $ptr_eq($ptr(^_LIST_ENTRY, L#Flink), $ptr(^_LIST_ENTRY, L#Blink));
    assert $position_marker();
    goto #exit;

  anon11:
    // empty

  #exit:
}



procedure RemoveHeadList(P#ListHead: int) returns ($result: int);
  requires $ptr_neq($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.ListHead), ^_LIST_ENTRY));
  requires $set_in($ptr(^_LIST_ENTRY, P#ListHead), $owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)));
  requires $wrapped($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), ^_LIST_MANAGER);
  modifies $s, $cev_pc;
  free ensures $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, $result)));
  ensures $ptr_eq($read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER));
  ensures $ptr_eq($read_ptr(old($s), $dot($read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.ListHead), ^_LIST_ENTRY));
  ensures (forall Q#le$1^177.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#le$1^177.29#dt1))) ==> $set_in($ptr(^_LIST_ENTRY, Q#le$1^177.29#dt1), $owns(old($s), $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER))) ==> $emb(old($s), $ptr(^_LIST_ENTRY, Q#le$1^177.29#dt1)) == $emb($s, $ptr(^_LIST_ENTRY, Q#le$1^177.29#dt1)));
  ensures $mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.size)) == $mem(old($s), $dot($read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.size)) - 1;
  ensures $set_eq($owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)), $set_difference($owns(old($s), $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)), $set_singleton($ptr(^_LIST_ENTRY, $result))));
  ensures $set_in($ptr(^_LIST_ENTRY, $result), $owns(old($s), $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)));
  ensures $wrapped($s, $ptr(^_LIST_ENTRY, $result), ^_LIST_ENTRY);
  ensures $set_in($ptr(^_LIST_ENTRY, P#ListHead), $owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)));
  ensures $wrapped($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), ^_LIST_MANAGER);
  ensures $ptr_eq($ptr(^_LIST_ENTRY, $result), $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY));
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation RemoveHeadList(P#ListHead: int) returns ($result: int)
{
  var prestate#42: $state;
  var res_lambda#2#7: $map_t..$ptr_to..^_LIST_ENTRY.^^u4;
  var owns#40: $ptrset;
  var staticWrapState#39: $state;
  var prestate#41: $state;
  var prestate#38: $state;
  var prestate#36: $state;
  var owns#37: $ptrset;
  var owns#34: $ptrset;
  var staticWrapState#33: $state;
  var prestate#35: $state;
  var prestate#32: $state;
  var prestate#30: $state;
  var owns#31: $ptrset;
  var prestate#29: $state;
  var L#Flink: int where $in_range_phys_ptr(L#Flink);
  var L#Entry: int where $in_range_phys_ptr(L#Entry);
  var SL#ListManager: int where $in_range_spec_ptr(SL#ListManager);
  var #wrTime$2^61.1: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$2^61.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$2^61.1, #loc.ListHead, $ptr_to_int($ptr(^_LIST_ENTRY, P#ListHead)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^61.1, #loc.ListHead, $ptr(^_LIST_ENTRY, P#ListHead), $ptr_to(^_LIST_ENTRY));
    assume #wrTime$2^61.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$2^61.1, #p) } $in_writes_at(#wrTime$2^61.1, #p) == (#p == $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)));
    assume $thread_owned($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER));
    // assume @in_range_phys_ptr((mathint)ListHead); 
    assume $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, P#ListHead)));
    // assert @_vcc_in_domain(@state, *((ListHead->Manager)), *((ListHead->Manager))); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), l#public);
    // struct _LIST_MANAGER^ ListManager; 
    assume $local_value_is($s, #tok$2^64.27, #loc.ListManager, $ptr_to_int($ptr(^_LIST_MANAGER, SL#ListManager)), $spec_ptr_to(^_LIST_MANAGER)) && $local_value_is_ptr($s, #tok$2^64.27, #loc.ListManager, $ptr(^_LIST_MANAGER, SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // struct _LIST_ENTRY* Entry; 
    assume $local_value_is($s, #tok$2^63.5, #loc.Entry, $ptr_to_int($ptr(^_LIST_ENTRY, L#Entry)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^63.5, #loc.Entry, $ptr(^_LIST_ENTRY, L#Entry), $ptr_to(^_LIST_ENTRY));
    // struct _LIST_ENTRY* Flink; 
    assume $local_value_is($s, #tok$2^63.5, #loc.Flink, $ptr_to_int($ptr(^_LIST_ENTRY, L#Flink)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^63.5, #loc.Flink, $ptr(^_LIST_ENTRY, L#Flink), $ptr_to(^_LIST_ENTRY));
    // var struct _LIST_ENTRY* Flink
    // var struct _LIST_ENTRY* Entry
    // assert @reads_check_normal((ListHead->Manager)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), $spec_ptr_to(^_LIST_MANAGER));
    assert $thread_local2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), $spec_ptr_to(^_LIST_MANAGER));
    // ListManager := *((ListHead->Manager)); 
    SL#ListManager := $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER));
    assume $local_value_is($s, #tok$2^64.27, #loc.ListManager, $ptr_to_int($ptr(^_LIST_MANAGER, SL#ListManager)), $spec_ptr_to(^_LIST_MANAGER)) && $local_value_is_ptr($s, #tok$2^64.27, #loc.ListManager, $ptr(^_LIST_MANAGER, SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // assert @_vcc_in_domain(@state, ListHead, ListManager); 
    assert $in_domain_lab($s, $ptr(^_LIST_ENTRY, P#ListHead), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assume @_vcc_in_domain(@state, ListHead, ListManager); 
    assume $in_domain_lab($s, $ptr(^_LIST_ENTRY, P#ListHead), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assert @_vcc_in_domain(@state, *((ListHead->Flink)), ListManager); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assume @_vcc_in_domain(@state, *((ListHead->Flink)), ListManager); 
    assume $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assert @_vcc_in_domain(@state, *((*((ListHead->Flink))->Flink)), ListManager); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assume @_vcc_in_domain(@state, *((*((ListHead->Flink))->Flink)), ListManager); 
    assume $in_domain_lab($s, $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assert @reads_check_normal((ListHead->Flink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    assert $thread_local2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    // Entry := *((ListHead->Flink)); 
    L#Entry := $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY));
    assume $local_value_is($s, #tok$2^70.5, #loc.Entry, $ptr_to_int($ptr(^_LIST_ENTRY, L#Entry)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^70.5, #loc.Entry, $ptr(^_LIST_ENTRY, L#Entry), $ptr_to(^_LIST_ENTRY));
    // assert @reads_check_normal((*((ListHead->Flink))->Flink)); 
    assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    assert $thread_local2($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    // assert @reads_check_normal((ListHead->Flink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    assert $thread_local2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    // Flink := *((*((ListHead->Flink))->Flink)); 
    L#Flink := $ref($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY), _LIST_ENTRY.Flink), ^_LIST_ENTRY));
    assume $local_value_is($s, #tok$2^71.5, #loc.Flink, $ptr_to_int($ptr(^_LIST_ENTRY, L#Flink)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^71.5, #loc.Flink, $ptr(^_LIST_ENTRY, L#Flink), $ptr_to(^_LIST_ENTRY));
    // _math state_t prestate#29; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#29, $state_to_int(prestate#29), ^$#state_t);
    // prestate#29 := @_vcc_current_state(@state); 
    prestate#29 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#29, $state_to_int(prestate#29), ^$#state_t);
    // assert @_vcc_wrapped(@state, ListManager); 
    assert $wrapped($s, $ptr(^_LIST_MANAGER, SL#ListManager), ^_LIST_MANAGER);
    // assume @_vcc_inv(@state, ListManager); 
    assume $inv($s, $ptr(^_LIST_MANAGER, SL#ListManager), ^_LIST_MANAGER);
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$2^61.1, $ptr(^_LIST_MANAGER, SL#ListManager));
    // stmt @_vcc_unwrap(ListManager, @_vcc_typeof(ListManager)); 
    call $unwrap($ptr(^_LIST_MANAGER, SL#ListManager), ^_LIST_MANAGER);
    assume $good_state_ext(#tok$2^72.32, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math ptrset owns#31; 
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#31, $ptrset_to_int(owns#31), ^$#ptrset);
    // owns#31 := @_vcc_set_empty; 
    owns#31 := $set_empty();
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#31, $ptrset_to_int(owns#31), ^$#ptrset);
    // _math state_t prestate#30; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#30, $state_to_int(prestate#30), ^$#state_t);
    // prestate#30 := @_vcc_current_state(@state); 
    prestate#30 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#30, $state_to_int(prestate#30), ^$#state_t);
    // _math state_t prestate#32; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#32, $state_to_int(prestate#32), ^$#state_t);
    // prestate#32 := @_vcc_current_state(@state); 
    prestate#32 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#32, $state_to_int(prestate#32), ^$#state_t);
    // assert @_vcc_wrapped(@state, ListHead); 
    assert $wrapped($s, $ptr(^_LIST_ENTRY, P#ListHead), ^_LIST_ENTRY);
    // assert @writes_check(ListHead); 
    assert $top_writable($s, #wrTime$2^61.1, $ptr(^_LIST_ENTRY, P#ListHead));
    // assume @_vcc_inv(@state, ListHead); 
    assume $inv($s, $ptr(^_LIST_ENTRY, P#ListHead), ^_LIST_ENTRY);
    // assume ==(owns#31, @_vcc_owns(@state, ListHead)); 
    assume owns#31 == $owns($s, $ptr(^_LIST_ENTRY, P#ListHead));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(ListHead), prestate#32)
    call $static_unwrap($ptr(^_LIST_ENTRY, P#ListHead), prestate#32);
    assume $good_state_ext(#tok$2^73.36, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (ListHead->Flink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    // assert @prim_writes_check((ListHead->Flink)); 
    assert $writable($s, #wrTime$2^61.1, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink));
    // *(ListHead->Flink) := Flink; 
    call $write_int($dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), $ref($ptr(^_LIST_ENTRY, L#Flink)));
    assume $full_stop_ext(#tok$2^74.13, $s);
    // _math state_t prestate#35; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#35, $state_to_int(prestate#35), ^$#state_t);
    // prestate#35 := @_vcc_current_state(@state); 
    prestate#35 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#35, $state_to_int(prestate#35), ^$#state_t);
    // _math state_t staticWrapState#33; 
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#33, $state_to_int(staticWrapState#33), ^$#state_t);
    // staticWrapState#33 := @_vcc_current_state(@state); 
    staticWrapState#33 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#33, $state_to_int(staticWrapState#33), ^$#state_t);
    // _math ptrset owns#34; 
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#34, $ptrset_to_int(owns#34), ^$#ptrset);
    // owns#34 := @_vcc_set_empty; 
    owns#34 := $set_empty();
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#34, $ptrset_to_int(owns#34), ^$#ptrset);
    // assert @writes_check(ListHead); 
    assert $top_writable($s, #wrTime$2^61.1, $ptr(^_LIST_ENTRY, P#ListHead));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(ListHead), staticWrapState#33, owns#34)
    call $static_wrap($ptr(^_LIST_ENTRY, P#ListHead), staticWrapState#33, owns#34);
    assume $good_state_ext(#tok$2^73.36, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, ListHead), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^_LIST_ENTRY, P#ListHead)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math ptrset owns#37; 
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#37, $ptrset_to_int(owns#37), ^$#ptrset);
    // owns#37 := @_vcc_set_empty; 
    owns#37 := $set_empty();
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#37, $ptrset_to_int(owns#37), ^$#ptrset);
    // _math state_t prestate#36; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#36, $state_to_int(prestate#36), ^$#state_t);
    // prestate#36 := @_vcc_current_state(@state); 
    prestate#36 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#36, $state_to_int(prestate#36), ^$#state_t);
    // _math state_t prestate#38; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#38, $state_to_int(prestate#38), ^$#state_t);
    // prestate#38 := @_vcc_current_state(@state); 
    prestate#38 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#38, $state_to_int(prestate#38), ^$#state_t);
    // assert @_vcc_wrapped(@state, Flink); 
    assert $wrapped($s, $ptr(^_LIST_ENTRY, L#Flink), ^_LIST_ENTRY);
    // assert @writes_check(Flink); 
    assert $top_writable($s, #wrTime$2^61.1, $ptr(^_LIST_ENTRY, L#Flink));
    // assume @_vcc_inv(@state, Flink); 
    assume $inv($s, $ptr(^_LIST_ENTRY, L#Flink), ^_LIST_ENTRY);
    // assume ==(owns#37, @_vcc_owns(@state, Flink)); 
    assume owns#37 == $owns($s, $ptr(^_LIST_ENTRY, L#Flink));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(Flink), prestate#38)
    call $static_unwrap($ptr(^_LIST_ENTRY, L#Flink), prestate#38);
    assume $good_state_ext(#tok$2^76.36, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (Flink->Blink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, L#Flink), _LIST_ENTRY.Blink), $ptr_to(^_LIST_ENTRY));
    // assert @prim_writes_check((Flink->Blink)); 
    assert $writable($s, #wrTime$2^61.1, $dot($ptr(^_LIST_ENTRY, L#Flink), _LIST_ENTRY.Blink));
    // *(Flink->Blink) := ListHead; 
    call $write_int($dot($ptr(^_LIST_ENTRY, L#Flink), _LIST_ENTRY.Blink), $ref($ptr(^_LIST_ENTRY, P#ListHead)));
    assume $full_stop_ext(#tok$2^77.13, $s);
    // _math state_t prestate#41; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#41, $state_to_int(prestate#41), ^$#state_t);
    // prestate#41 := @_vcc_current_state(@state); 
    prestate#41 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#41, $state_to_int(prestate#41), ^$#state_t);
    // _math state_t staticWrapState#39; 
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#39, $state_to_int(staticWrapState#39), ^$#state_t);
    // staticWrapState#39 := @_vcc_current_state(@state); 
    staticWrapState#39 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#39, $state_to_int(staticWrapState#39), ^$#state_t);
    // _math ptrset owns#40; 
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#40, $ptrset_to_int(owns#40), ^$#ptrset);
    // owns#40 := @_vcc_set_empty; 
    owns#40 := $set_empty();
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#40, $ptrset_to_int(owns#40), ^$#ptrset);
    // assert @writes_check(Flink); 
    assert $top_writable($s, #wrTime$2^61.1, $ptr(^_LIST_ENTRY, L#Flink));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(Flink), staticWrapState#39, owns#40)
    call $static_wrap($ptr(^_LIST_ENTRY, L#Flink), staticWrapState#39, owns#40);
    assume $good_state_ext(#tok$2^76.36, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, Flink), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^_LIST_ENTRY, L#Flink)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (ListManager->size)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), ^^u4);
    // assert @prim_writes_check((ListManager->size)); 
    assert $writable($s, #wrTime$2^61.1, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size));
    // assert @in_range_u4(-(*((ListManager->size)), 1)); 
    assert $in_range_u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)) - 1);
    // assert @reads_check_normal((ListManager->size)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), ^^u4);
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), ^^u4);
    // *(ListManager->size) := -(*((ListManager->size)), 1); 
    call $write_int($dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), $mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)) - 1);
    assume $full_stop_ext(#tok$2^81.9, $s);
    // assert @_vcc_set_in(Entry, @_vcc_owns(@state, ListManager)); 
    assert $set_in($ptr(^_LIST_ENTRY, L#Entry), $owns($s, $ptr(^_LIST_MANAGER, SL#ListManager)));
    // assume @_vcc_set_in(Entry, @_vcc_owns(@state, ListManager)); 
    assume $set_in($ptr(^_LIST_ENTRY, L#Entry), $owns($s, $ptr(^_LIST_MANAGER, SL#ListManager)));
    // assert @writes_check(@_vcc_span(ListManager)); 
    assert (forall #writes$2^82.31: $ptr :: { $dont_instantiate(#writes$2^82.31) } $set_in(#writes$2^82.31, $span($ptr(^_LIST_MANAGER, SL#ListManager))) ==> $top_writable($s, #wrTime$2^61.1, #writes$2^82.31));
    // stmt _vcc_set_owns(ListManager, @_vcc_set_remove_element(@_vcc_owns(@state, ListManager), Entry)); 
    call $set_owns($ptr(^_LIST_MANAGER, SL#ListManager), $set_remove_element($owns($s, $ptr(^_LIST_MANAGER, SL#ListManager)), $ptr(^_LIST_ENTRY, L#Entry)));
    assume $full_stop_ext(#tok$2^82.31, $s);
    // empty
    // (struct _LIST_ENTRY* -> uint32_t) res_lambda#2#7; 
    assume $local_value_is($s, #tok$2^83.31, #loc.res_lambda#2#7, $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#2#7), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // res_lambda#2#7 := lambda#2(*((ListManager->index)), *((ListManager->index)), @map_get(*((ListManager->index)), Entry), *((ListManager->index))); 
    call res_lambda#2#7 := lambda#2($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, L#Entry))), $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))));
    assume $full_stop_ext(#tok$2^83.31, $s);
    assume $local_value_is($s, #tok$2^83.31, #loc.res_lambda#2#7, $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#2#7), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @_vcc_typed2(@state, (ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @prim_writes_check((ListManager->index)); 
    assert $writable($s, #wrTime$2^61.1, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index));
    // *(ListManager->index) := res_lambda#2#7; 
    call $write_int($dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#2#7));
    assume $full_stop_ext(#tok$2^83.9, $s);
    // _math state_t prestate#42; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#42, $state_to_int(prestate#42), ^$#state_t);
    // prestate#42 := @_vcc_current_state(@state); 
    prestate#42 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#42, $state_to_int(prestate#42), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$2^61.1, $ptr(^_LIST_MANAGER, SL#ListManager));
    // assert @writes_check(@_vcc_owns(@state, ListManager)); 
    assert (forall #writes$2^72.32: $ptr :: { $dont_instantiate(#writes$2^72.32) } $set_in(#writes$2^72.32, $owns($s, $ptr(^_LIST_MANAGER, SL#ListManager))) ==> $top_writable($s, #wrTime$2^61.1, #writes$2^72.32));
    // stmt @_vcc_wrap(ListManager, @_vcc_typeof(ListManager)); 
    call $wrap($ptr(^_LIST_MANAGER, SL#ListManager), ^_LIST_MANAGER);
    assume $good_state_ext(#tok$2^72.32, $s);
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } @in_range_phys_ptr((mathint)p); ==>(@keeps(ListManager, p), @_vcc_ptr_eq(*((p->Manager)), ListManager)))); 
    assert (forall Q#p$1^47.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1)) ==> $ptr_eq($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1), _LIST_ENTRY.Manager), ^_LIST_MANAGER), $ptr(^_LIST_MANAGER, SL#ListManager)));
    // assert @inv_check(@keeps(ListManager, *((ListManager->ListHead)))); 
    assert $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY));
    // assert @inv_check(@keeps(ListManager, *((*((ListManager->ListHead))->Blink)))); 
    assert $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Flink))) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } @in_range_phys_ptr((mathint)p); ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Flink))), @_vcc_ptr_eq(*((*((p->Flink))->Blink)), p))))); 
    assert (forall Q#p$1^60.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1)) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1)));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Blink))) } { @trigger_hint(@keeps(ListManager, *((p->Blink)))) } @in_range_phys_ptr((mathint)p); ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Blink))), @_vcc_ptr_eq(*((*((p->Blink))->Flink)), p))))); 
    assert (forall Q#p$1^66.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1)) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1)));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } @in_range_phys_ptr((mathint)p); ==>(&&(@keeps(ListManager, p), @_vcc_ptr_neq(*((p->Flink)), *((ListManager->ListHead)))), ==(+(@map_get(*((ListManager->index)), p), 1), @map_get(*((ListManager->index)), *((p->Flink))))))); 
    assert (forall Q#p$1^75.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1)) && $ptr_neq($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1))) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))));
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((ListManager->ListHead))), 0)); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY))) == 0;
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((*((ListManager->ListHead))->Blink))), -(*((ListManager->size)), 1))); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) == $mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)) - 1;
    // assert @inv_check(forall(struct _LIST_ENTRY* e; { @keeps(ListManager, e) } @in_range_phys_ptr((mathint)e); ==>(@keeps(ListManager, e), <(@map_get(*((ListManager->index)), e), *((ListManager->size)))))); 
    assert (forall Q#e$1^83.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1))) < $mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)));
    // assert @inv_check(forall(struct _LIST_ENTRY* e1; struct _LIST_ENTRY* e2; { @keeps(ListManager, e1), @keeps(ListManager, e2) } &&(@in_range_phys_ptr((mathint)e1), @in_range_phys_ptr((mathint)e2)); ==>(&&(&&(@keeps(ListManager, e1), @keeps(ListManager, e2)), @_vcc_ptr_neq(e1, e2)), !=(@map_get(*((ListManager->index)), e1), @map_get(*((ListManager->index)), e2))))); 
    assert (forall Q#e1$1^87.31#dt1: int, Q#e2$1^87.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1)), $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1))) && $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1)) && $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) && $ptr_neq($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1))) != $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return Entry; 
    $result := $ref($ptr(^_LIST_ENTRY, L#Entry));
    assert $position_marker();
    goto #exit;

  anon13:
    // empty

  #exit:
}



procedure RemoveTailList(P#ListHead: int) returns ($result: int);
  requires $mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.size)) > 1;
  requires $ptr_neq($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY), $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.ListHead), ^_LIST_ENTRY));
  requires $set_in($ptr(^_LIST_ENTRY, P#ListHead), $owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)));
  requires $wrapped($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), ^_LIST_MANAGER);
  modifies $s, $cev_pc;
  free ensures $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, $result)));
  ensures $ptr_eq($read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER));
  ensures $ptr_eq($read_ptr(old($s), $dot($read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.ListHead), ^_LIST_ENTRY));
  ensures (forall Q#le$1^205.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#le$1^205.29#dt1))) ==> $set_in($ptr(^_LIST_ENTRY, Q#le$1^205.29#dt1), $owns(old($s), $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER))) ==> $emb(old($s), $ptr(^_LIST_ENTRY, Q#le$1^205.29#dt1)) == $emb($s, $ptr(^_LIST_ENTRY, Q#le$1^205.29#dt1)));
  ensures $mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.size)) == $mem(old($s), $dot($read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.size)) - 1;
  ensures $set_eq($owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)), $set_difference($owns(old($s), $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)), $set_singleton($ptr(^_LIST_ENTRY, $result))));
  ensures $wrapped($s, $ptr(^_LIST_ENTRY, $result), ^_LIST_ENTRY);
  ensures $set_in($ptr(^_LIST_ENTRY, P#ListHead), $owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)));
  ensures $wrapped($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), ^_LIST_MANAGER);
  ensures $ptr_eq($ptr(^_LIST_ENTRY, $result), $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY));
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation RemoveTailList(P#ListHead: int) returns ($result: int)
{
  var prestate#56: $state;
  var res_lambda#3#8: $map_t..$ptr_to..^_LIST_ENTRY.^^u4;
  var owns#54: $ptrset;
  var staticWrapState#53: $state;
  var prestate#55: $state;
  var prestate#52: $state;
  var prestate#50: $state;
  var owns#51: $ptrset;
  var owns#48: $ptrset;
  var staticWrapState#47: $state;
  var prestate#49: $state;
  var prestate#46: $state;
  var prestate#44: $state;
  var owns#45: $ptrset;
  var prestate#43: $state;
  var L#Blink: int where $in_range_phys_ptr(L#Blink);
  var L#Entry: int where $in_range_phys_ptr(L#Entry);
  var SL#ListManager: int where $in_range_spec_ptr(SL#ListManager);
  var #wrTime$2^91.1: int;
  var #stackframe: int;

  anon14:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$2^91.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$2^91.1, #loc.ListHead, $ptr_to_int($ptr(^_LIST_ENTRY, P#ListHead)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^91.1, #loc.ListHead, $ptr(^_LIST_ENTRY, P#ListHead), $ptr_to(^_LIST_ENTRY));
    assume #wrTime$2^91.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$2^91.1, #p) } $in_writes_at(#wrTime$2^91.1, #p) == (#p == $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)));
    assume $thread_owned($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER));
    // assume @in_range_phys_ptr((mathint)ListHead); 
    assume $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, P#ListHead)));
    // assert @_vcc_in_domain(@state, *((ListHead->Manager)), *((ListHead->Manager))); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), l#public);
    // struct _LIST_MANAGER^ ListManager; 
    assume $local_value_is($s, #tok$2^94.27, #loc.ListManager, $ptr_to_int($ptr(^_LIST_MANAGER, SL#ListManager)), $spec_ptr_to(^_LIST_MANAGER)) && $local_value_is_ptr($s, #tok$2^94.27, #loc.ListManager, $ptr(^_LIST_MANAGER, SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // struct _LIST_ENTRY* Entry; 
    assume $local_value_is($s, #tok$2^93.5, #loc.Entry, $ptr_to_int($ptr(^_LIST_ENTRY, L#Entry)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^93.5, #loc.Entry, $ptr(^_LIST_ENTRY, L#Entry), $ptr_to(^_LIST_ENTRY));
    // struct _LIST_ENTRY* Blink; 
    assume $local_value_is($s, #tok$2^93.5, #loc.Blink, $ptr_to_int($ptr(^_LIST_ENTRY, L#Blink)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^93.5, #loc.Blink, $ptr(^_LIST_ENTRY, L#Blink), $ptr_to(^_LIST_ENTRY));
    // var struct _LIST_ENTRY* Blink
    // var struct _LIST_ENTRY* Entry
    // assert @reads_check_normal((ListHead->Manager)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), $spec_ptr_to(^_LIST_MANAGER));
    assert $thread_local2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), $spec_ptr_to(^_LIST_MANAGER));
    // ListManager := *((ListHead->Manager)); 
    SL#ListManager := $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER));
    assume $local_value_is($s, #tok$2^94.27, #loc.ListManager, $ptr_to_int($ptr(^_LIST_MANAGER, SL#ListManager)), $spec_ptr_to(^_LIST_MANAGER)) && $local_value_is_ptr($s, #tok$2^94.27, #loc.ListManager, $ptr(^_LIST_MANAGER, SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // assert @_vcc_in_domain(@state, ListHead, ListManager); 
    assert $in_domain_lab($s, $ptr(^_LIST_ENTRY, P#ListHead), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assume @_vcc_in_domain(@state, ListHead, ListManager); 
    assume $in_domain_lab($s, $ptr(^_LIST_ENTRY, P#ListHead), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assert @_vcc_in_domain(@state, *((ListHead->Blink)), ListManager); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assume @_vcc_in_domain(@state, *((ListHead->Blink)), ListManager); 
    assume $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assert @_vcc_in_domain(@state, *((*((ListHead->Blink))->Blink)), ListManager); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assume @_vcc_in_domain(@state, *((*((ListHead->Blink))->Blink)), ListManager); 
    assume $in_domain_lab($s, $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assert @reads_check_normal((ListHead->Blink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), $ptr_to(^_LIST_ENTRY));
    assert $thread_local2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), $ptr_to(^_LIST_ENTRY));
    // Entry := *((ListHead->Blink)); 
    L#Entry := $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY));
    assume $local_value_is($s, #tok$2^100.5, #loc.Entry, $ptr_to_int($ptr(^_LIST_ENTRY, L#Entry)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^100.5, #loc.Entry, $ptr(^_LIST_ENTRY, L#Entry), $ptr_to(^_LIST_ENTRY));
    // assert @reads_check_normal((*((ListHead->Blink))->Blink)); 
    assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY), _LIST_ENTRY.Blink), $ptr_to(^_LIST_ENTRY));
    assert $thread_local2($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY), _LIST_ENTRY.Blink), $ptr_to(^_LIST_ENTRY));
    // assert @reads_check_normal((ListHead->Blink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), $ptr_to(^_LIST_ENTRY));
    assert $thread_local2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), $ptr_to(^_LIST_ENTRY));
    // Blink := *((*((ListHead->Blink))->Blink)); 
    L#Blink := $ref($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY));
    assume $local_value_is($s, #tok$2^101.5, #loc.Blink, $ptr_to_int($ptr(^_LIST_ENTRY, L#Blink)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^101.5, #loc.Blink, $ptr(^_LIST_ENTRY, L#Blink), $ptr_to(^_LIST_ENTRY));
    // _math state_t prestate#43; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#43, $state_to_int(prestate#43), ^$#state_t);
    // prestate#43 := @_vcc_current_state(@state); 
    prestate#43 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#43, $state_to_int(prestate#43), ^$#state_t);
    // assert @_vcc_wrapped(@state, ListManager); 
    assert $wrapped($s, $ptr(^_LIST_MANAGER, SL#ListManager), ^_LIST_MANAGER);
    // assume @_vcc_inv(@state, ListManager); 
    assume $inv($s, $ptr(^_LIST_MANAGER, SL#ListManager), ^_LIST_MANAGER);
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$2^91.1, $ptr(^_LIST_MANAGER, SL#ListManager));
    // stmt @_vcc_unwrap(ListManager, @_vcc_typeof(ListManager)); 
    call $unwrap($ptr(^_LIST_MANAGER, SL#ListManager), ^_LIST_MANAGER);
    assume $good_state_ext(#tok$2^102.32, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math ptrset owns#45; 
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#45, $ptrset_to_int(owns#45), ^$#ptrset);
    // owns#45 := @_vcc_set_empty; 
    owns#45 := $set_empty();
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#45, $ptrset_to_int(owns#45), ^$#ptrset);
    // _math state_t prestate#44; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#44, $state_to_int(prestate#44), ^$#state_t);
    // prestate#44 := @_vcc_current_state(@state); 
    prestate#44 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#44, $state_to_int(prestate#44), ^$#state_t);
    // _math state_t prestate#46; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#46, $state_to_int(prestate#46), ^$#state_t);
    // prestate#46 := @_vcc_current_state(@state); 
    prestate#46 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#46, $state_to_int(prestate#46), ^$#state_t);
    // assert @_vcc_wrapped(@state, ListHead); 
    assert $wrapped($s, $ptr(^_LIST_ENTRY, P#ListHead), ^_LIST_ENTRY);
    // assert @writes_check(ListHead); 
    assert $top_writable($s, #wrTime$2^91.1, $ptr(^_LIST_ENTRY, P#ListHead));
    // assume @_vcc_inv(@state, ListHead); 
    assume $inv($s, $ptr(^_LIST_ENTRY, P#ListHead), ^_LIST_ENTRY);
    // assume ==(owns#45, @_vcc_owns(@state, ListHead)); 
    assume owns#45 == $owns($s, $ptr(^_LIST_ENTRY, P#ListHead));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(ListHead), prestate#46)
    call $static_unwrap($ptr(^_LIST_ENTRY, P#ListHead), prestate#46);
    assume $good_state_ext(#tok$2^103.36, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (ListHead->Blink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), $ptr_to(^_LIST_ENTRY));
    // assert @prim_writes_check((ListHead->Blink)); 
    assert $writable($s, #wrTime$2^91.1, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink));
    // *(ListHead->Blink) := Blink; 
    call $write_int($dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), $ref($ptr(^_LIST_ENTRY, L#Blink)));
    assume $full_stop_ext(#tok$2^104.13, $s);
    // _math state_t prestate#49; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#49, $state_to_int(prestate#49), ^$#state_t);
    // prestate#49 := @_vcc_current_state(@state); 
    prestate#49 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#49, $state_to_int(prestate#49), ^$#state_t);
    // _math state_t staticWrapState#47; 
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#47, $state_to_int(staticWrapState#47), ^$#state_t);
    // staticWrapState#47 := @_vcc_current_state(@state); 
    staticWrapState#47 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#47, $state_to_int(staticWrapState#47), ^$#state_t);
    // _math ptrset owns#48; 
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#48, $ptrset_to_int(owns#48), ^$#ptrset);
    // owns#48 := @_vcc_set_empty; 
    owns#48 := $set_empty();
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#48, $ptrset_to_int(owns#48), ^$#ptrset);
    // assert @writes_check(ListHead); 
    assert $top_writable($s, #wrTime$2^91.1, $ptr(^_LIST_ENTRY, P#ListHead));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(ListHead), staticWrapState#47, owns#48)
    call $static_wrap($ptr(^_LIST_ENTRY, P#ListHead), staticWrapState#47, owns#48);
    assume $good_state_ext(#tok$2^103.36, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, ListHead), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^_LIST_ENTRY, P#ListHead)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math ptrset owns#51; 
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#51, $ptrset_to_int(owns#51), ^$#ptrset);
    // owns#51 := @_vcc_set_empty; 
    owns#51 := $set_empty();
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#51, $ptrset_to_int(owns#51), ^$#ptrset);
    // _math state_t prestate#50; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#50, $state_to_int(prestate#50), ^$#state_t);
    // prestate#50 := @_vcc_current_state(@state); 
    prestate#50 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#50, $state_to_int(prestate#50), ^$#state_t);
    // _math state_t prestate#52; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#52, $state_to_int(prestate#52), ^$#state_t);
    // prestate#52 := @_vcc_current_state(@state); 
    prestate#52 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#52, $state_to_int(prestate#52), ^$#state_t);
    // assert @_vcc_wrapped(@state, Blink); 
    assert $wrapped($s, $ptr(^_LIST_ENTRY, L#Blink), ^_LIST_ENTRY);
    // assert @writes_check(Blink); 
    assert $top_writable($s, #wrTime$2^91.1, $ptr(^_LIST_ENTRY, L#Blink));
    // assume @_vcc_inv(@state, Blink); 
    assume $inv($s, $ptr(^_LIST_ENTRY, L#Blink), ^_LIST_ENTRY);
    // assume ==(owns#51, @_vcc_owns(@state, Blink)); 
    assume owns#51 == $owns($s, $ptr(^_LIST_ENTRY, L#Blink));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(Blink), prestate#52)
    call $static_unwrap($ptr(^_LIST_ENTRY, L#Blink), prestate#52);
    assume $good_state_ext(#tok$2^106.36, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (Blink->Flink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, L#Blink), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    // assert @prim_writes_check((Blink->Flink)); 
    assert $writable($s, #wrTime$2^91.1, $dot($ptr(^_LIST_ENTRY, L#Blink), _LIST_ENTRY.Flink));
    // *(Blink->Flink) := ListHead; 
    call $write_int($dot($ptr(^_LIST_ENTRY, L#Blink), _LIST_ENTRY.Flink), $ref($ptr(^_LIST_ENTRY, P#ListHead)));
    assume $full_stop_ext(#tok$2^107.13, $s);
    // _math state_t prestate#55; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#55, $state_to_int(prestate#55), ^$#state_t);
    // prestate#55 := @_vcc_current_state(@state); 
    prestate#55 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#55, $state_to_int(prestate#55), ^$#state_t);
    // _math state_t staticWrapState#53; 
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#53, $state_to_int(staticWrapState#53), ^$#state_t);
    // staticWrapState#53 := @_vcc_current_state(@state); 
    staticWrapState#53 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#53, $state_to_int(staticWrapState#53), ^$#state_t);
    // _math ptrset owns#54; 
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#54, $ptrset_to_int(owns#54), ^$#ptrset);
    // owns#54 := @_vcc_set_empty; 
    owns#54 := $set_empty();
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#54, $ptrset_to_int(owns#54), ^$#ptrset);
    // assert @writes_check(Blink); 
    assert $top_writable($s, #wrTime$2^91.1, $ptr(^_LIST_ENTRY, L#Blink));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(Blink), staticWrapState#53, owns#54)
    call $static_wrap($ptr(^_LIST_ENTRY, L#Blink), staticWrapState#53, owns#54);
    assume $good_state_ext(#tok$2^106.36, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, Blink), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^_LIST_ENTRY, L#Blink)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (ListManager->size)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), ^^u4);
    // assert @prim_writes_check((ListManager->size)); 
    assert $writable($s, #wrTime$2^91.1, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size));
    // assert @in_range_u4(-(*((ListManager->size)), 1)); 
    assert $in_range_u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)) - 1);
    // assert @reads_check_normal((ListManager->size)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), ^^u4);
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), ^^u4);
    // *(ListManager->size) := -(*((ListManager->size)), 1); 
    call $write_int($dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), $mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)) - 1);
    assume $full_stop_ext(#tok$2^111.9, $s);
    // assert @_vcc_set_in(Entry, @_vcc_owns(@state, ListManager)); 
    assert $set_in($ptr(^_LIST_ENTRY, L#Entry), $owns($s, $ptr(^_LIST_MANAGER, SL#ListManager)));
    // assume @_vcc_set_in(Entry, @_vcc_owns(@state, ListManager)); 
    assume $set_in($ptr(^_LIST_ENTRY, L#Entry), $owns($s, $ptr(^_LIST_MANAGER, SL#ListManager)));
    // assert @writes_check(@_vcc_span(ListManager)); 
    assert (forall #writes$2^112.31: $ptr :: { $dont_instantiate(#writes$2^112.31) } $set_in(#writes$2^112.31, $span($ptr(^_LIST_MANAGER, SL#ListManager))) ==> $top_writable($s, #wrTime$2^91.1, #writes$2^112.31));
    // stmt _vcc_set_owns(ListManager, @_vcc_set_remove_element(@_vcc_owns(@state, ListManager), Entry)); 
    call $set_owns($ptr(^_LIST_MANAGER, SL#ListManager), $set_remove_element($owns($s, $ptr(^_LIST_MANAGER, SL#ListManager)), $ptr(^_LIST_ENTRY, L#Entry)));
    assume $full_stop_ext(#tok$2^112.31, $s);
    // empty
    // (struct _LIST_ENTRY* -> uint32_t) res_lambda#3#8; 
    assume $local_value_is($s, #tok$2^113.31, #loc.res_lambda#3#8, $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#3#8), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // res_lambda#3#8 := lambda#3(*((ListManager->index)), *((ListManager->index)), @map_get(*((ListManager->index)), Entry), *((ListManager->index))); 
    call res_lambda#3#8 := lambda#3($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, L#Entry))), $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))));
    assume $full_stop_ext(#tok$2^113.31, $s);
    assume $local_value_is($s, #tok$2^113.31, #loc.res_lambda#3#8, $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#3#8), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @_vcc_typed2(@state, (ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @prim_writes_check((ListManager->index)); 
    assert $writable($s, #wrTime$2^91.1, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index));
    // *(ListManager->index) := res_lambda#3#8; 
    call $write_int($dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#3#8));
    assume $full_stop_ext(#tok$2^113.9, $s);
    // _math state_t prestate#56; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#56, $state_to_int(prestate#56), ^$#state_t);
    // prestate#56 := @_vcc_current_state(@state); 
    prestate#56 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#56, $state_to_int(prestate#56), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$2^91.1, $ptr(^_LIST_MANAGER, SL#ListManager));
    // assert @writes_check(@_vcc_owns(@state, ListManager)); 
    assert (forall #writes$2^102.32: $ptr :: { $dont_instantiate(#writes$2^102.32) } $set_in(#writes$2^102.32, $owns($s, $ptr(^_LIST_MANAGER, SL#ListManager))) ==> $top_writable($s, #wrTime$2^91.1, #writes$2^102.32));
    // stmt @_vcc_wrap(ListManager, @_vcc_typeof(ListManager)); 
    call $wrap($ptr(^_LIST_MANAGER, SL#ListManager), ^_LIST_MANAGER);
    assume $good_state_ext(#tok$2^102.32, $s);
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } @in_range_phys_ptr((mathint)p); ==>(@keeps(ListManager, p), @_vcc_ptr_eq(*((p->Manager)), ListManager)))); 
    assert (forall Q#p$1^47.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1)) ==> $ptr_eq($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1), _LIST_ENTRY.Manager), ^_LIST_MANAGER), $ptr(^_LIST_MANAGER, SL#ListManager)));
    // assert @inv_check(@keeps(ListManager, *((ListManager->ListHead)))); 
    assert $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY));
    // assert @inv_check(@keeps(ListManager, *((*((ListManager->ListHead))->Blink)))); 
    assert $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Flink))) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } @in_range_phys_ptr((mathint)p); ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Flink))), @_vcc_ptr_eq(*((*((p->Flink))->Blink)), p))))); 
    assert (forall Q#p$1^60.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1)) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1)));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Blink))) } { @trigger_hint(@keeps(ListManager, *((p->Blink)))) } @in_range_phys_ptr((mathint)p); ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Blink))), @_vcc_ptr_eq(*((*((p->Blink))->Flink)), p))))); 
    assert (forall Q#p$1^66.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1)) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1)));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } @in_range_phys_ptr((mathint)p); ==>(&&(@keeps(ListManager, p), @_vcc_ptr_neq(*((p->Flink)), *((ListManager->ListHead)))), ==(+(@map_get(*((ListManager->index)), p), 1), @map_get(*((ListManager->index)), *((p->Flink))))))); 
    assert (forall Q#p$1^75.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1)) && $ptr_neq($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1))) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))));
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((ListManager->ListHead))), 0)); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY))) == 0;
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((*((ListManager->ListHead))->Blink))), -(*((ListManager->size)), 1))); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) == $mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)) - 1;
    // assert @inv_check(forall(struct _LIST_ENTRY* e; { @keeps(ListManager, e) } @in_range_phys_ptr((mathint)e); ==>(@keeps(ListManager, e), <(@map_get(*((ListManager->index)), e), *((ListManager->size)))))); 
    assert (forall Q#e$1^83.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1))) < $mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)));
    // assert @inv_check(forall(struct _LIST_ENTRY* e1; struct _LIST_ENTRY* e2; { @keeps(ListManager, e1), @keeps(ListManager, e2) } &&(@in_range_phys_ptr((mathint)e1), @in_range_phys_ptr((mathint)e2)); ==>(&&(&&(@keeps(ListManager, e1), @keeps(ListManager, e2)), @_vcc_ptr_neq(e1, e2)), !=(@map_get(*((ListManager->index)), e1), @map_get(*((ListManager->index)), e2))))); 
    assert (forall Q#e1$1^87.31#dt1: int, Q#e2$1^87.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1)), $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1))) && $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1)) && $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) && $ptr_neq($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1))) != $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return Entry; 
    $result := $ref($ptr(^_LIST_ENTRY, L#Entry));
    assert $position_marker();
    goto #exit;

  anon15:
    // empty

  #exit:
}



procedure InsertTailList(P#ListHead: int, P#Entry: int);
  requires $mutable($s, $ptr(^_LIST_ENTRY, P#Entry));
  requires $mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.size)) < 4294967295;
  requires $wrapped($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), ^_LIST_MANAGER);
  requires $set_in($ptr(^_LIST_ENTRY, P#ListHead), $owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)));
  modifies $s, $cev_pc;
  ensures $ptr_eq($read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER));
  ensures $ptr_eq($read_ptr(old($s), $dot($read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.ListHead), ^_LIST_ENTRY));
  ensures (forall Q#le$1^234.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#le$1^234.29#dt1))) ==> $set_in($ptr(^_LIST_ENTRY, Q#le$1^234.29#dt1), $owns(old($s), $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER))) ==> $emb(old($s), $ptr(^_LIST_ENTRY, Q#le$1^234.29#dt1)) == $emb($s, $ptr(^_LIST_ENTRY, Q#le$1^234.29#dt1)));
  ensures $set_in($ptr(^_LIST_ENTRY, P#Entry), $owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)));
  ensures $mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.size)) == $mem(old($s), $dot($read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.size)) + 1;
  ensures $set_eq($owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)), $set_union($owns(old($s), $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)), $set_singleton($ptr(^_LIST_ENTRY, P#Entry)))) && $set_in($ptr(^_LIST_ENTRY, P#Entry), $owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)));
  ensures $ptr_eq($read_ptr(old($s), $dot($read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.ListHead), ^_LIST_ENTRY));
  ensures $ptr_eq($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), ^_LIST_MANAGER), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER));
  ensures $wrapped($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), ^_LIST_MANAGER);
  ensures $set_in($ptr(^_LIST_ENTRY, P#ListHead), $owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)));
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER) || $set_in(#p, $span($ptr(^_LIST_ENTRY, P#Entry))) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER) || $set_in(#p, $span($ptr(^_LIST_ENTRY, P#Entry))) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER) || $set_in(#p, $span($ptr(^_LIST_ENTRY, P#Entry))) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation InsertTailList(P#ListHead: int, P#Entry: int)
{
  var prestate#73: $state;
  var res_lambda#4#9: $map_t..$ptr_to..^_LIST_ENTRY.^^u4;
  var owns#71: $ptrset;
  var staticWrapState#70: $state;
  var prestate#72: $state;
  var prestate#69: $state;
  var prestate#67: $state;
  var owns#68: $ptrset;
  var owns#65: $ptrset;
  var staticWrapState#64: $state;
  var prestate#66: $state;
  var prestate#63: $state;
  var prestate#61: $state;
  var owns#62: $ptrset;
  var prestate#60: $state;
  var owns#58: $ptrset;
  var staticWrapState#57: $state;
  var prestate#59: $state;
  var SL#ListManager: int where $in_range_spec_ptr(SL#ListManager);
  var #wrTime$2^121.1: int;
  var #stackframe: int;

  anon18:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$2^121.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$2^121.1, #loc.ListHead, $ptr_to_int($ptr(^_LIST_ENTRY, P#ListHead)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^121.1, #loc.ListHead, $ptr(^_LIST_ENTRY, P#ListHead), $ptr_to(^_LIST_ENTRY));
    assume $local_value_is($s, #tok$2^121.1, #loc.Entry, $ptr_to_int($ptr(^_LIST_ENTRY, P#Entry)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^121.1, #loc.Entry, $ptr(^_LIST_ENTRY, P#Entry), $ptr_to(^_LIST_ENTRY));
    assume #wrTime$2^121.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$2^121.1, #p) } $in_writes_at(#wrTime$2^121.1, #p) == (#p == $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER) || $set_in(#p, $span($ptr(^_LIST_ENTRY, P#Entry)))));
    assume $thread_owned($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER));
    assume (forall #p: $ptr :: { $extent_hint(#p, $ptr(^_LIST_ENTRY, P#Entry)) } $set_in(#p, $span($ptr(^_LIST_ENTRY, P#Entry))) ==> $mutable($s, #p));
    // assume @in_range_phys_ptr((mathint)ListHead); 
    assume $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, P#ListHead)));
    // assume @in_range_phys_ptr((mathint)Entry); 
    assume $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, P#Entry)));
    // assert @_vcc_in_domain(@state, *((ListHead->Manager)), *((ListHead->Manager))); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), l#public);
    // struct _LIST_MANAGER^ ListManager; 
    assume $local_value_is($s, #tok$2^123.27, #loc.ListManager, $ptr_to_int($ptr(^_LIST_MANAGER, SL#ListManager)), $spec_ptr_to(^_LIST_MANAGER)) && $local_value_is_ptr($s, #tok$2^123.27, #loc.ListManager, $ptr(^_LIST_MANAGER, SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // assert @reads_check_normal((ListHead->Manager)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), $spec_ptr_to(^_LIST_MANAGER));
    assert $thread_local2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), $spec_ptr_to(^_LIST_MANAGER));
    // ListManager := *((ListHead->Manager)); 
    SL#ListManager := $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER));
    assume $local_value_is($s, #tok$2^123.27, #loc.ListManager, $ptr_to_int($ptr(^_LIST_MANAGER, SL#ListManager)), $spec_ptr_to(^_LIST_MANAGER)) && $local_value_is_ptr($s, #tok$2^123.27, #loc.ListManager, $ptr(^_LIST_MANAGER, SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // assert @_vcc_in_domain(@state, ListHead, ListManager); 
    assert $in_domain_lab($s, $ptr(^_LIST_ENTRY, P#ListHead), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assume @_vcc_in_domain(@state, ListHead, ListManager); 
    assume $in_domain_lab($s, $ptr(^_LIST_ENTRY, P#ListHead), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assert @_vcc_in_domain(@state, *((ListHead->Blink)), ListManager); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assume @_vcc_in_domain(@state, *((ListHead->Blink)), ListManager); 
    assume $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assert @_vcc_typed2(@state, (Entry->Flink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    // assert @prim_writes_check((Entry->Flink)); 
    assert $writable($s, #wrTime$2^121.1, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Flink));
    // *(Entry->Flink) := ListHead; 
    call $write_int($dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Flink), $ref($ptr(^_LIST_ENTRY, P#ListHead)));
    assume $full_stop_ext(#tok$2^128.5, $s);
    // assert @_vcc_typed2(@state, (Entry->Blink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Blink), $ptr_to(^_LIST_ENTRY));
    // assert @prim_writes_check((Entry->Blink)); 
    assert $writable($s, #wrTime$2^121.1, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Blink));
    // assert @reads_check_normal((ListHead->Blink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), $ptr_to(^_LIST_ENTRY));
    assert $thread_local2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), $ptr_to(^_LIST_ENTRY));
    // *(Entry->Blink) := *((ListHead->Blink)); 
    call $write_int($dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Blink), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY)));
    assume $full_stop_ext(#tok$2^129.5, $s);
    // assert @_vcc_typed2(@state, (Entry->Manager)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), $spec_ptr_to(^_LIST_MANAGER));
    // assert @prim_writes_check((Entry->Manager)); 
    assert $writable($s, #wrTime$2^121.1, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager));
    // *(Entry->Manager) := ListManager; 
    call $write_int($dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), $ref($ptr(^_LIST_MANAGER, SL#ListManager)));
    assume $full_stop_ext(#tok$2^130.27, $s);
    // _math state_t prestate#59; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#59, $state_to_int(prestate#59), ^$#state_t);
    // prestate#59 := @_vcc_current_state(@state); 
    prestate#59 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#59, $state_to_int(prestate#59), ^$#state_t);
    // _math state_t staticWrapState#57; 
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#57, $state_to_int(staticWrapState#57), ^$#state_t);
    // staticWrapState#57 := @_vcc_current_state(@state); 
    staticWrapState#57 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#57, $state_to_int(staticWrapState#57), ^$#state_t);
    // _math ptrset owns#58; 
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#58, $ptrset_to_int(owns#58), ^$#ptrset);
    // owns#58 := @_vcc_set_empty; 
    owns#58 := $set_empty();
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#58, $ptrset_to_int(owns#58), ^$#ptrset);
    // assert @writes_check(Entry); 
    assert $top_writable($s, #wrTime$2^121.1, $ptr(^_LIST_ENTRY, P#Entry));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(Entry), staticWrapState#57, owns#58)
    call $static_wrap($ptr(^_LIST_ENTRY, P#Entry), staticWrapState#57, owns#58);
    assume $good_state_ext(#tok$2^132.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, Entry), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^_LIST_ENTRY, P#Entry)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#60; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#60, $state_to_int(prestate#60), ^$#state_t);
    // prestate#60 := @_vcc_current_state(@state); 
    prestate#60 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#60, $state_to_int(prestate#60), ^$#state_t);
    // assert @_vcc_wrapped(@state, ListManager); 
    assert $wrapped($s, $ptr(^_LIST_MANAGER, SL#ListManager), ^_LIST_MANAGER);
    // assume @_vcc_inv(@state, ListManager); 
    assume $inv($s, $ptr(^_LIST_MANAGER, SL#ListManager), ^_LIST_MANAGER);
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$2^121.1, $ptr(^_LIST_MANAGER, SL#ListManager));
    // stmt @_vcc_unwrap(ListManager, @_vcc_typeof(ListManager)); 
    call $unwrap($ptr(^_LIST_MANAGER, SL#ListManager), ^_LIST_MANAGER);
    assume $good_state_ext(#tok$2^133.32, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math ptrset owns#62; 
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#62, $ptrset_to_int(owns#62), ^$#ptrset);
    // owns#62 := @_vcc_set_empty; 
    owns#62 := $set_empty();
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#62, $ptrset_to_int(owns#62), ^$#ptrset);
    // _math state_t prestate#61; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#61, $state_to_int(prestate#61), ^$#state_t);
    // prestate#61 := @_vcc_current_state(@state); 
    prestate#61 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#61, $state_to_int(prestate#61), ^$#state_t);
    // _math state_t prestate#63; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#63, $state_to_int(prestate#63), ^$#state_t);
    // prestate#63 := @_vcc_current_state(@state); 
    prestate#63 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#63, $state_to_int(prestate#63), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((ListHead->Blink))); 
    assert $wrapped($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assert @writes_check(*((ListHead->Blink))); 
    assert $top_writable($s, #wrTime$2^121.1, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY));
    // assume @_vcc_inv(@state, *((ListHead->Blink))); 
    assume $inv($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assume ==(owns#62, @_vcc_owns(@state, *((ListHead->Blink)))); 
    assume owns#62 == $owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(*((ListHead->Blink))), prestate#63)
    call $static_unwrap($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY), prestate#63);
    assume $good_state_ext(#tok$2^134.36, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (*((ListHead->Blink))->Flink)); 
    assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    // assert @prim_writes_check((*((ListHead->Blink))->Flink)); 
    assert $writable($s, #wrTime$2^121.1, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY), _LIST_ENTRY.Flink));
    // assert @reads_check_normal((ListHead->Blink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), $ptr_to(^_LIST_ENTRY));
    assert $thread_local2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), $ptr_to(^_LIST_ENTRY));
    // *(*((ListHead->Blink))->Flink) := Entry; 
    call $write_int($dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY), _LIST_ENTRY.Flink), $ref($ptr(^_LIST_ENTRY, P#Entry)));
    assume $full_stop_ext(#tok$2^135.13, $s);
    // _math state_t prestate#66; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#66, $state_to_int(prestate#66), ^$#state_t);
    // prestate#66 := @_vcc_current_state(@state); 
    prestate#66 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#66, $state_to_int(prestate#66), ^$#state_t);
    // _math state_t staticWrapState#64; 
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#64, $state_to_int(staticWrapState#64), ^$#state_t);
    // staticWrapState#64 := @_vcc_current_state(@state); 
    staticWrapState#64 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#64, $state_to_int(staticWrapState#64), ^$#state_t);
    // _math ptrset owns#65; 
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#65, $ptrset_to_int(owns#65), ^$#ptrset);
    // owns#65 := @_vcc_set_empty; 
    owns#65 := $set_empty();
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#65, $ptrset_to_int(owns#65), ^$#ptrset);
    // assert @writes_check(*((ListHead->Blink))); 
    assert $top_writable($s, #wrTime$2^121.1, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(*((ListHead->Blink))), staticWrapState#64, owns#65)
    call $static_wrap($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY), staticWrapState#64, owns#65);
    assume $good_state_ext(#tok$2^134.36, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((ListHead->Blink))), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), ^_LIST_ENTRY)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math ptrset owns#68; 
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#68, $ptrset_to_int(owns#68), ^$#ptrset);
    // owns#68 := @_vcc_set_empty; 
    owns#68 := $set_empty();
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#68, $ptrset_to_int(owns#68), ^$#ptrset);
    // _math state_t prestate#67; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#67, $state_to_int(prestate#67), ^$#state_t);
    // prestate#67 := @_vcc_current_state(@state); 
    prestate#67 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#67, $state_to_int(prestate#67), ^$#state_t);
    // _math state_t prestate#69; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#69, $state_to_int(prestate#69), ^$#state_t);
    // prestate#69 := @_vcc_current_state(@state); 
    prestate#69 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#69, $state_to_int(prestate#69), ^$#state_t);
    // assert @_vcc_wrapped(@state, ListHead); 
    assert $wrapped($s, $ptr(^_LIST_ENTRY, P#ListHead), ^_LIST_ENTRY);
    // assert @writes_check(ListHead); 
    assert $top_writable($s, #wrTime$2^121.1, $ptr(^_LIST_ENTRY, P#ListHead));
    // assume @_vcc_inv(@state, ListHead); 
    assume $inv($s, $ptr(^_LIST_ENTRY, P#ListHead), ^_LIST_ENTRY);
    // assume ==(owns#68, @_vcc_owns(@state, ListHead)); 
    assume owns#68 == $owns($s, $ptr(^_LIST_ENTRY, P#ListHead));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(ListHead), prestate#69)
    call $static_unwrap($ptr(^_LIST_ENTRY, P#ListHead), prestate#69);
    assume $good_state_ext(#tok$2^137.36, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (ListHead->Blink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), $ptr_to(^_LIST_ENTRY));
    // assert @prim_writes_check((ListHead->Blink)); 
    assert $writable($s, #wrTime$2^121.1, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink));
    // *(ListHead->Blink) := Entry; 
    call $write_int($dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Blink), $ref($ptr(^_LIST_ENTRY, P#Entry)));
    assume $full_stop_ext(#tok$2^138.13, $s);
    // _math state_t prestate#72; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#72, $state_to_int(prestate#72), ^$#state_t);
    // prestate#72 := @_vcc_current_state(@state); 
    prestate#72 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#72, $state_to_int(prestate#72), ^$#state_t);
    // _math state_t staticWrapState#70; 
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#70, $state_to_int(staticWrapState#70), ^$#state_t);
    // staticWrapState#70 := @_vcc_current_state(@state); 
    staticWrapState#70 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#70, $state_to_int(staticWrapState#70), ^$#state_t);
    // _math ptrset owns#71; 
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#71, $ptrset_to_int(owns#71), ^$#ptrset);
    // owns#71 := @_vcc_set_empty; 
    owns#71 := $set_empty();
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#71, $ptrset_to_int(owns#71), ^$#ptrset);
    // assert @writes_check(ListHead); 
    assert $top_writable($s, #wrTime$2^121.1, $ptr(^_LIST_ENTRY, P#ListHead));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(ListHead), staticWrapState#70, owns#71)
    call $static_wrap($ptr(^_LIST_ENTRY, P#ListHead), staticWrapState#70, owns#71);
    assume $good_state_ext(#tok$2^137.36, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, ListHead), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^_LIST_ENTRY, P#ListHead)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (ListManager->size)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), ^^u4);
    // assert @prim_writes_check((ListManager->size)); 
    assert $writable($s, #wrTime$2^121.1, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size));
    // assert @in_range_u4(+(*((ListManager->size)), 1)); 
    assert $in_range_u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)) + 1);
    // assert @reads_check_normal((ListManager->size)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), ^^u4);
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), ^^u4);
    // *(ListManager->size) := +(*((ListManager->size)), 1); 
    call $write_int($dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), $mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)) + 1);
    assume $full_stop_ext(#tok$2^142.9, $s);
    // assert @writes_check(@_vcc_span(ListManager)); 
    assert (forall #writes$2^143.31: $ptr :: { $dont_instantiate(#writes$2^143.31) } $set_in(#writes$2^143.31, $span($ptr(^_LIST_MANAGER, SL#ListManager))) ==> $top_writable($s, #wrTime$2^121.1, #writes$2^143.31));
    // stmt _vcc_set_owns(ListManager, @_vcc_set_add_element(@_vcc_owns(@state, ListManager), Entry)); 
    call $set_owns($ptr(^_LIST_MANAGER, SL#ListManager), $set_add_element($owns($s, $ptr(^_LIST_MANAGER, SL#ListManager)), $ptr(^_LIST_ENTRY, P#Entry)));
    assume $full_stop_ext(#tok$2^143.31, $s);
    // empty
    // assert @reads_check_normal((ListManager->ListHead)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), $ptr_to(^_LIST_ENTRY));
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), $ptr_to(^_LIST_ENTRY));
    assume true;
    // if (@_vcc_ptr_eq(ListHead, *((ListManager->ListHead)))) ...
    if ($ptr_eq($ptr(^_LIST_ENTRY, P#ListHead), $read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY)))
    {
      anon16:
        // assert @_vcc_typed2(@state, (ListManager->index)); 
        assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
        // assert @prim_writes_check((ListManager->index)); 
        assert $writable($s, #wrTime$2^121.1, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index));
        // assert @reads_check_normal((ListManager->index)); 
        assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
        assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
        // assert @in_range_u4(-(*((ListManager->size)), 1)); 
        assert $in_range_u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)) - 1);
        // assert @reads_check_normal((ListManager->size)); 
        assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), ^^u4);
        assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), ^^u4);
        // *(ListManager->index) := @map_updated(*((ListManager->index)), Entry, -(*((ListManager->size)), 1)); 
        call $write_int($dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int($store.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, P#Entry)), $mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)) - 1)));
        assume $full_stop_ext(#tok$2^146.13, $s);
    }
    else
    {
      anon17:
        // (struct _LIST_ENTRY* -> uint32_t) res_lambda#4#9; 
        assume $local_value_is($s, #tok$2^148.35, #loc.res_lambda#4#9, $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#4#9), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
        // assert @reads_check_normal((ListManager->index)); 
        assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
        assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
        // assert @reads_check_normal((ListManager->index)); 
        assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
        assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
        // assert @reads_check_normal((ListManager->index)); 
        assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
        assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
        // assert @reads_check_normal((ListManager->index)); 
        assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
        assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
        // assert @reads_check_normal((ListManager->index)); 
        assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
        assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
        // res_lambda#4#9 := lambda#4(*((ListManager->index)), *((ListManager->index)), @map_get(*((ListManager->index)), ListHead), *((ListManager->index)), @map_get(*((ListManager->index)), ListHead), Entry); 
        call res_lambda#4#9 := lambda#4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, P#ListHead))), $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, P#ListHead))), $ref($ptr(^_LIST_ENTRY, P#Entry)));
        assume $full_stop_ext(#tok$2^148.35, $s);
        assume $local_value_is($s, #tok$2^148.35, #loc.res_lambda#4#9, $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#4#9), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
        // assert @_vcc_typed2(@state, (ListManager->index)); 
        assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
        // assert @prim_writes_check((ListManager->index)); 
        assert $writable($s, #wrTime$2^121.1, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index));
        // *(ListManager->index) := res_lambda#4#9; 
        call $write_int($dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#4#9));
        assume $full_stop_ext(#tok$2^148.13, $s);
    }

  anon19:
    // _math state_t prestate#73; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#73, $state_to_int(prestate#73), ^$#state_t);
    // prestate#73 := @_vcc_current_state(@state); 
    prestate#73 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#73, $state_to_int(prestate#73), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$2^121.1, $ptr(^_LIST_MANAGER, SL#ListManager));
    // assert @writes_check(@_vcc_owns(@state, ListManager)); 
    assert (forall #writes$2^133.32: $ptr :: { $dont_instantiate(#writes$2^133.32) } $set_in(#writes$2^133.32, $owns($s, $ptr(^_LIST_MANAGER, SL#ListManager))) ==> $top_writable($s, #wrTime$2^121.1, #writes$2^133.32));
    // stmt @_vcc_wrap(ListManager, @_vcc_typeof(ListManager)); 
    call $wrap($ptr(^_LIST_MANAGER, SL#ListManager), ^_LIST_MANAGER);
    assume $good_state_ext(#tok$2^133.32, $s);
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } @in_range_phys_ptr((mathint)p); ==>(@keeps(ListManager, p), @_vcc_ptr_eq(*((p->Manager)), ListManager)))); 
    assert (forall Q#p$1^47.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1)) ==> $ptr_eq($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1), _LIST_ENTRY.Manager), ^_LIST_MANAGER), $ptr(^_LIST_MANAGER, SL#ListManager)));
    // assert @inv_check(@keeps(ListManager, *((ListManager->ListHead)))); 
    assert $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY));
    // assert @inv_check(@keeps(ListManager, *((*((ListManager->ListHead))->Blink)))); 
    assert $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Flink))) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } @in_range_phys_ptr((mathint)p); ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Flink))), @_vcc_ptr_eq(*((*((p->Flink))->Blink)), p))))); 
    assert (forall Q#p$1^60.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1)) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1)));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Blink))) } { @trigger_hint(@keeps(ListManager, *((p->Blink)))) } @in_range_phys_ptr((mathint)p); ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Blink))), @_vcc_ptr_eq(*((*((p->Blink))->Flink)), p))))); 
    assert (forall Q#p$1^66.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1)) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1)));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } @in_range_phys_ptr((mathint)p); ==>(&&(@keeps(ListManager, p), @_vcc_ptr_neq(*((p->Flink)), *((ListManager->ListHead)))), ==(+(@map_get(*((ListManager->index)), p), 1), @map_get(*((ListManager->index)), *((p->Flink))))))); 
    assert (forall Q#p$1^75.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1)) && $ptr_neq($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1))) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))));
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((ListManager->ListHead))), 0)); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY))) == 0;
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((*((ListManager->ListHead))->Blink))), -(*((ListManager->size)), 1))); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) == $mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)) - 1;
    // assert @inv_check(forall(struct _LIST_ENTRY* e; { @keeps(ListManager, e) } @in_range_phys_ptr((mathint)e); ==>(@keeps(ListManager, e), <(@map_get(*((ListManager->index)), e), *((ListManager->size)))))); 
    assert (forall Q#e$1^83.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1))) < $mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)));
    // assert @inv_check(forall(struct _LIST_ENTRY* e1; struct _LIST_ENTRY* e2; { @keeps(ListManager, e1), @keeps(ListManager, e2) } &&(@in_range_phys_ptr((mathint)e1), @in_range_phys_ptr((mathint)e2)); ==>(&&(&&(@keeps(ListManager, e1), @keeps(ListManager, e2)), @_vcc_ptr_neq(e1, e2)), !=(@map_get(*((ListManager->index)), e1), @map_get(*((ListManager->index)), e2))))); 
    assert (forall Q#e1$1^87.31#dt1: int, Q#e2$1^87.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1)), $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1))) && $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1)) && $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) && $ptr_neq($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1))) != $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure InsertHeadList(P#ListHead: int, P#Entry: int);
  requires $mutable($s, $ptr(^_LIST_ENTRY, P#Entry));
  requires $mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.size)) < 4294967295;
  requires $wrapped($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), ^_LIST_MANAGER);
  requires $set_in($ptr(^_LIST_ENTRY, P#ListHead), $owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)));
  modifies $s, $cev_pc;
  ensures $ptr_eq($read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER));
  ensures $ptr_eq($read_ptr(old($s), $dot($read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.ListHead), ^_LIST_ENTRY));
  ensures (forall Q#le$1^265.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#le$1^265.29#dt1))) ==> $set_in($ptr(^_LIST_ENTRY, Q#le$1^265.29#dt1), $owns(old($s), $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER))) ==> $emb(old($s), $ptr(^_LIST_ENTRY, Q#le$1^265.29#dt1)) == $emb($s, $ptr(^_LIST_ENTRY, Q#le$1^265.29#dt1)));
  ensures $set_in($ptr(^_LIST_ENTRY, P#Entry), $owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)));
  ensures $mem($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.size)) == $mem(old($s), $dot($read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), _LIST_MANAGER.size)) + 1;
  ensures $set_eq($owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)), $set_union($owns(old($s), $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)), $set_singleton($ptr(^_LIST_ENTRY, P#Entry)))) && $set_in($ptr(^_LIST_ENTRY, P#Entry), $owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)));
  ensures $ptr_eq($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), ^_LIST_MANAGER), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER));
  ensures $wrapped($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), ^_LIST_MANAGER);
  ensures $set_in($ptr(^_LIST_ENTRY, P#ListHead), $owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER)));
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER) || $set_in(#p, $span($ptr(^_LIST_ENTRY, P#Entry))) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER) || $set_in(#p, $span($ptr(^_LIST_ENTRY, P#Entry))) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $read_ptr(old($s), $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER) || $set_in(#p, $span($ptr(^_LIST_ENTRY, P#Entry))) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation InsertHeadList(P#ListHead: int, P#Entry: int)
{
  var prestate#90: $state;
  var res_lambda#5#10: $map_t..$ptr_to..^_LIST_ENTRY.^^u4;
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
  var owns#75: $ptrset;
  var staticWrapState#74: $state;
  var prestate#76: $state;
  var SL#ListManager: int where $in_range_spec_ptr(SL#ListManager);
  var #wrTime$2^158.1: int;
  var #stackframe: int;

  anon20:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$2^158.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$2^158.1, #loc.ListHead, $ptr_to_int($ptr(^_LIST_ENTRY, P#ListHead)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^158.1, #loc.ListHead, $ptr(^_LIST_ENTRY, P#ListHead), $ptr_to(^_LIST_ENTRY));
    assume $local_value_is($s, #tok$2^158.1, #loc.Entry, $ptr_to_int($ptr(^_LIST_ENTRY, P#Entry)), $ptr_to(^_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$2^158.1, #loc.Entry, $ptr(^_LIST_ENTRY, P#Entry), $ptr_to(^_LIST_ENTRY));
    assume #wrTime$2^158.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$2^158.1, #p) } $in_writes_at(#wrTime$2^158.1, #p) == (#p == $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER) || $set_in(#p, $span($ptr(^_LIST_ENTRY, P#Entry)))));
    assume $thread_owned($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER));
    assume (forall #p: $ptr :: { $extent_hint(#p, $ptr(^_LIST_ENTRY, P#Entry)) } $set_in(#p, $span($ptr(^_LIST_ENTRY, P#Entry))) ==> $mutable($s, #p));
    // assume @in_range_phys_ptr((mathint)ListHead); 
    assume $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, P#ListHead)));
    // assume @in_range_phys_ptr((mathint)Entry); 
    assume $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, P#Entry)));
    // assert @_vcc_in_domain(@state, *((ListHead->Manager)), *((ListHead->Manager))); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER), l#public);
    // struct _LIST_MANAGER^ ListManager; 
    assume $local_value_is($s, #tok$2^160.27, #loc.ListManager, $ptr_to_int($ptr(^_LIST_MANAGER, SL#ListManager)), $spec_ptr_to(^_LIST_MANAGER)) && $local_value_is_ptr($s, #tok$2^160.27, #loc.ListManager, $ptr(^_LIST_MANAGER, SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // assert @reads_check_normal((ListHead->Manager)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), $spec_ptr_to(^_LIST_MANAGER));
    assert $thread_local2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), $spec_ptr_to(^_LIST_MANAGER));
    // ListManager := *((ListHead->Manager)); 
    SL#ListManager := $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Manager), ^_LIST_MANAGER));
    assume $local_value_is($s, #tok$2^160.27, #loc.ListManager, $ptr_to_int($ptr(^_LIST_MANAGER, SL#ListManager)), $spec_ptr_to(^_LIST_MANAGER)) && $local_value_is_ptr($s, #tok$2^160.27, #loc.ListManager, $ptr(^_LIST_MANAGER, SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // assert @_vcc_in_domain(@state, ListHead, ListManager); 
    assert $in_domain_lab($s, $ptr(^_LIST_ENTRY, P#ListHead), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assume @_vcc_in_domain(@state, ListHead, ListManager); 
    assume $in_domain_lab($s, $ptr(^_LIST_ENTRY, P#ListHead), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assert @_vcc_in_domain(@state, *((ListHead->Flink)), ListManager); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assume @_vcc_in_domain(@state, *((ListHead->Flink)), ListManager); 
    assume $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $ptr(^_LIST_MANAGER, SL#ListManager), l#public);
    // assert @_vcc_typed2(@state, (Entry->Blink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Blink), $ptr_to(^_LIST_ENTRY));
    // assert @prim_writes_check((Entry->Blink)); 
    assert $writable($s, #wrTime$2^158.1, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Blink));
    // *(Entry->Blink) := ListHead; 
    call $write_int($dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Blink), $ref($ptr(^_LIST_ENTRY, P#ListHead)));
    assume $full_stop_ext(#tok$2^165.5, $s);
    // assert @_vcc_typed2(@state, (Entry->Flink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    // assert @prim_writes_check((Entry->Flink)); 
    assert $writable($s, #wrTime$2^158.1, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Flink));
    // assert @reads_check_normal((ListHead->Flink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    assert $thread_local2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    // *(Entry->Flink) := *((ListHead->Flink)); 
    call $write_int($dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Flink), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY)));
    assume $full_stop_ext(#tok$2^166.5, $s);
    // assert @_vcc_typed2(@state, (Entry->Manager)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), $spec_ptr_to(^_LIST_MANAGER));
    // assert @prim_writes_check((Entry->Manager)); 
    assert $writable($s, #wrTime$2^158.1, $dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager));
    // *(Entry->Manager) := ListManager; 
    call $write_int($dot($ptr(^_LIST_ENTRY, P#Entry), _LIST_ENTRY.Manager), $ref($ptr(^_LIST_MANAGER, SL#ListManager)));
    assume $full_stop_ext(#tok$2^167.27, $s);
    // _math state_t prestate#76; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#76, $state_to_int(prestate#76), ^$#state_t);
    // prestate#76 := @_vcc_current_state(@state); 
    prestate#76 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#76, $state_to_int(prestate#76), ^$#state_t);
    // _math state_t staticWrapState#74; 
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#74, $state_to_int(staticWrapState#74), ^$#state_t);
    // staticWrapState#74 := @_vcc_current_state(@state); 
    staticWrapState#74 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#74, $state_to_int(staticWrapState#74), ^$#state_t);
    // _math ptrset owns#75; 
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#75, $ptrset_to_int(owns#75), ^$#ptrset);
    // owns#75 := @_vcc_set_empty; 
    owns#75 := $set_empty();
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#75, $ptrset_to_int(owns#75), ^$#ptrset);
    // assert @writes_check(Entry); 
    assert $top_writable($s, #wrTime$2^158.1, $ptr(^_LIST_ENTRY, P#Entry));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(Entry), staticWrapState#74, owns#75)
    call $static_wrap($ptr(^_LIST_ENTRY, P#Entry), staticWrapState#74, owns#75);
    assume $good_state_ext(#tok$2^168.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, Entry), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^_LIST_ENTRY, P#Entry)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#77; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#77, $state_to_int(prestate#77), ^$#state_t);
    // prestate#77 := @_vcc_current_state(@state); 
    prestate#77 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#77, $state_to_int(prestate#77), ^$#state_t);
    // assert @_vcc_wrapped(@state, ListManager); 
    assert $wrapped($s, $ptr(^_LIST_MANAGER, SL#ListManager), ^_LIST_MANAGER);
    // assume @_vcc_inv(@state, ListManager); 
    assume $inv($s, $ptr(^_LIST_MANAGER, SL#ListManager), ^_LIST_MANAGER);
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$2^158.1, $ptr(^_LIST_MANAGER, SL#ListManager));
    // stmt @_vcc_unwrap(ListManager, @_vcc_typeof(ListManager)); 
    call $unwrap($ptr(^_LIST_MANAGER, SL#ListManager), ^_LIST_MANAGER);
    assume $good_state_ext(#tok$2^169.32, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math ptrset owns#79; 
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#79, $ptrset_to_int(owns#79), ^$#ptrset);
    // owns#79 := @_vcc_set_empty; 
    owns#79 := $set_empty();
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#79, $ptrset_to_int(owns#79), ^$#ptrset);
    // _math state_t prestate#78; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#78, $state_to_int(prestate#78), ^$#state_t);
    // prestate#78 := @_vcc_current_state(@state); 
    prestate#78 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#78, $state_to_int(prestate#78), ^$#state_t);
    // _math state_t prestate#80; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#80, $state_to_int(prestate#80), ^$#state_t);
    // prestate#80 := @_vcc_current_state(@state); 
    prestate#80 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#80, $state_to_int(prestate#80), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((ListHead->Flink))); 
    assert $wrapped($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assert @writes_check(*((ListHead->Flink))); 
    assert $top_writable($s, #wrTime$2^158.1, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY));
    // assume @_vcc_inv(@state, *((ListHead->Flink))); 
    assume $inv($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assume ==(owns#79, @_vcc_owns(@state, *((ListHead->Flink)))); 
    assume owns#79 == $owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(*((ListHead->Flink))), prestate#80)
    call $static_unwrap($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY), prestate#80);
    assume $good_state_ext(#tok$2^170.36, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (*((ListHead->Flink))->Blink)); 
    assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY), _LIST_ENTRY.Blink), $ptr_to(^_LIST_ENTRY));
    // assert @prim_writes_check((*((ListHead->Flink))->Blink)); 
    assert $writable($s, #wrTime$2^158.1, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY), _LIST_ENTRY.Blink));
    // assert @reads_check_normal((ListHead->Flink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    assert $thread_local2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    // *(*((ListHead->Flink))->Blink) := Entry; 
    call $write_int($dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY), _LIST_ENTRY.Blink), $ref($ptr(^_LIST_ENTRY, P#Entry)));
    assume $full_stop_ext(#tok$2^171.13, $s);
    // _math state_t prestate#83; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#83, $state_to_int(prestate#83), ^$#state_t);
    // prestate#83 := @_vcc_current_state(@state); 
    prestate#83 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#83, $state_to_int(prestate#83), ^$#state_t);
    // _math state_t staticWrapState#81; 
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#81, $state_to_int(staticWrapState#81), ^$#state_t);
    // staticWrapState#81 := @_vcc_current_state(@state); 
    staticWrapState#81 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#81, $state_to_int(staticWrapState#81), ^$#state_t);
    // _math ptrset owns#82; 
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#82, $ptrset_to_int(owns#82), ^$#ptrset);
    // owns#82 := @_vcc_set_empty; 
    owns#82 := $set_empty();
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#82, $ptrset_to_int(owns#82), ^$#ptrset);
    // assert @writes_check(*((ListHead->Flink))); 
    assert $top_writable($s, #wrTime$2^158.1, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(*((ListHead->Flink))), staticWrapState#81, owns#82)
    call $static_wrap($read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY), staticWrapState#81, owns#82);
    assume $good_state_ext(#tok$2^170.36, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((ListHead->Flink))), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $read_ptr($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), ^_LIST_ENTRY)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math ptrset owns#85; 
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#85, $ptrset_to_int(owns#85), ^$#ptrset);
    // owns#85 := @_vcc_set_empty; 
    owns#85 := $set_empty();
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#85, $ptrset_to_int(owns#85), ^$#ptrset);
    // _math state_t prestate#84; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#84, $state_to_int(prestate#84), ^$#state_t);
    // prestate#84 := @_vcc_current_state(@state); 
    prestate#84 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#84, $state_to_int(prestate#84), ^$#state_t);
    // _math state_t prestate#86; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#86, $state_to_int(prestate#86), ^$#state_t);
    // prestate#86 := @_vcc_current_state(@state); 
    prestate#86 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#86, $state_to_int(prestate#86), ^$#state_t);
    // assert @_vcc_wrapped(@state, ListHead); 
    assert $wrapped($s, $ptr(^_LIST_ENTRY, P#ListHead), ^_LIST_ENTRY);
    // assert @writes_check(ListHead); 
    assert $top_writable($s, #wrTime$2^158.1, $ptr(^_LIST_ENTRY, P#ListHead));
    // assume @_vcc_inv(@state, ListHead); 
    assume $inv($s, $ptr(^_LIST_ENTRY, P#ListHead), ^_LIST_ENTRY);
    // assume ==(owns#85, @_vcc_owns(@state, ListHead)); 
    assume owns#85 == $owns($s, $ptr(^_LIST_ENTRY, P#ListHead));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(ListHead), prestate#86)
    call $static_unwrap($ptr(^_LIST_ENTRY, P#ListHead), prestate#86);
    assume $good_state_ext(#tok$2^173.36, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (ListHead->Flink)); 
    assert $typed2($s, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), $ptr_to(^_LIST_ENTRY));
    // assert @prim_writes_check((ListHead->Flink)); 
    assert $writable($s, #wrTime$2^158.1, $dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink));
    // *(ListHead->Flink) := Entry; 
    call $write_int($dot($ptr(^_LIST_ENTRY, P#ListHead), _LIST_ENTRY.Flink), $ref($ptr(^_LIST_ENTRY, P#Entry)));
    assume $full_stop_ext(#tok$2^174.13, $s);
    // _math state_t prestate#89; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#89, $state_to_int(prestate#89), ^$#state_t);
    // prestate#89 := @_vcc_current_state(@state); 
    prestate#89 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#89, $state_to_int(prestate#89), ^$#state_t);
    // _math state_t staticWrapState#87; 
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#87, $state_to_int(staticWrapState#87), ^$#state_t);
    // staticWrapState#87 := @_vcc_current_state(@state); 
    staticWrapState#87 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.staticWrapState#87, $state_to_int(staticWrapState#87), ^$#state_t);
    // _math ptrset owns#88; 
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#88, $ptrset_to_int(owns#88), ^$#ptrset);
    // owns#88 := @_vcc_set_empty; 
    owns#88 := $set_empty();
    assume $local_value_is($s, #tok$3^0.0, #loc.owns#88, $ptrset_to_int(owns#88), ^$#ptrset);
    // assert @writes_check(ListHead); 
    assert $top_writable($s, #wrTime$2^158.1, $ptr(^_LIST_ENTRY, P#ListHead));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(ListHead), staticWrapState#87, owns#88)
    call $static_wrap($ptr(^_LIST_ENTRY, P#ListHead), staticWrapState#87, owns#88);
    assume $good_state_ext(#tok$2^173.36, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, ListHead), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^_LIST_ENTRY, P#ListHead)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (ListManager->size)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), ^^u4);
    // assert @prim_writes_check((ListManager->size)); 
    assert $writable($s, #wrTime$2^158.1, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size));
    // assert @in_range_u4(+(*((ListManager->size)), 1)); 
    assert $in_range_u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)) + 1);
    // assert @reads_check_normal((ListManager->size)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), ^^u4);
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), ^^u4);
    // *(ListManager->size) := +(*((ListManager->size)), 1); 
    call $write_int($dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size), $mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)) + 1);
    assume $full_stop_ext(#tok$2^178.9, $s);
    // assert @writes_check(@_vcc_span(ListManager)); 
    assert (forall #writes$2^179.31: $ptr :: { $dont_instantiate(#writes$2^179.31) } $set_in(#writes$2^179.31, $span($ptr(^_LIST_MANAGER, SL#ListManager))) ==> $top_writable($s, #wrTime$2^158.1, #writes$2^179.31));
    // stmt _vcc_set_owns(ListManager, @_vcc_set_add_element(@_vcc_owns(@state, ListManager), Entry)); 
    call $set_owns($ptr(^_LIST_MANAGER, SL#ListManager), $set_add_element($owns($s, $ptr(^_LIST_MANAGER, SL#ListManager)), $ptr(^_LIST_ENTRY, P#Entry)));
    assume $full_stop_ext(#tok$2^179.31, $s);
    // empty
    // (struct _LIST_ENTRY* -> uint32_t) res_lambda#5#10; 
    assume $local_value_is($s, #tok$2^180.31, #loc.res_lambda#5#10, $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#5#10), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @in_range_u4(+(@map_get(*((ListManager->index)), ListHead), 1)); 
    assert $in_range_u4($select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, P#ListHead))) + 1);
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // res_lambda#5#10 := lambda#5(*((ListManager->index)), *((ListManager->index)), @map_get(*((ListManager->index)), ListHead), *((ListManager->index)), +(@map_get(*((ListManager->index)), ListHead), 1), Entry); 
    call res_lambda#5#10 := lambda#5($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, P#ListHead))), $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, P#ListHead))) + 1, $ref($ptr(^_LIST_ENTRY, P#Entry)));
    assume $full_stop_ext(#tok$2^180.31, $s);
    assume $local_value_is($s, #tok$2^180.31, #loc.res_lambda#5#10, $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#5#10), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @_vcc_typed2(@state, (ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @prim_writes_check((ListManager->index)); 
    assert $writable($s, #wrTime$2^158.1, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index));
    // *(ListManager->index) := res_lambda#5#10; 
    call $write_int($dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index), $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#5#10));
    assume $full_stop_ext(#tok$2^180.9, $s);
    // _math state_t prestate#90; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#90, $state_to_int(prestate#90), ^$#state_t);
    // prestate#90 := @_vcc_current_state(@state); 
    prestate#90 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#90, $state_to_int(prestate#90), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$2^158.1, $ptr(^_LIST_MANAGER, SL#ListManager));
    // assert @writes_check(@_vcc_owns(@state, ListManager)); 
    assert (forall #writes$2^169.32: $ptr :: { $dont_instantiate(#writes$2^169.32) } $set_in(#writes$2^169.32, $owns($s, $ptr(^_LIST_MANAGER, SL#ListManager))) ==> $top_writable($s, #wrTime$2^158.1, #writes$2^169.32));
    // stmt @_vcc_wrap(ListManager, @_vcc_typeof(ListManager)); 
    call $wrap($ptr(^_LIST_MANAGER, SL#ListManager), ^_LIST_MANAGER);
    assume $good_state_ext(#tok$2^169.32, $s);
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } @in_range_phys_ptr((mathint)p); ==>(@keeps(ListManager, p), @_vcc_ptr_eq(*((p->Manager)), ListManager)))); 
    assert (forall Q#p$1^47.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1)) ==> $ptr_eq($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^47.31#dt1), _LIST_ENTRY.Manager), ^_LIST_MANAGER), $ptr(^_LIST_MANAGER, SL#ListManager)));
    // assert @inv_check(@keeps(ListManager, *((ListManager->ListHead)))); 
    assert $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY));
    // assert @inv_check(@keeps(ListManager, *((*((ListManager->ListHead))->Blink)))); 
    assert $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Flink))) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } @in_range_phys_ptr((mathint)p); ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Flink))), @_vcc_ptr_eq(*((*((p->Flink))->Blink)), p))))); 
    assert (forall Q#p$1^60.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1)) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY)) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#p$1^60.31#dt1)));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Blink))) } { @trigger_hint(@keeps(ListManager, *((p->Blink)))) } @in_range_phys_ptr((mathint)p); ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Blink))), @_vcc_ptr_eq(*((*((p->Blink))->Flink)), p))))); 
    assert (forall Q#p$1^66.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1)) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY)) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1), _LIST_ENTRY.Blink), ^_LIST_ENTRY), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $ptr(^_LIST_ENTRY, Q#p$1^66.31#dt1)));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } @in_range_phys_ptr((mathint)p); ==>(&&(@keeps(ListManager, p), @_vcc_ptr_neq(*((p->Flink)), *((ListManager->ListHead)))), ==(+(@map_get(*((ListManager->index)), p), 1), @map_get(*((ListManager->index)), *((p->Flink))))))); 
    assert (forall Q#p$1^75.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1)) } { sk_hack($keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1)) && $ptr_neq($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY), $read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1))) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_LIST_ENTRY, Q#p$1^75.31#dt1), _LIST_ENTRY.Flink), ^_LIST_ENTRY))));
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((ListManager->ListHead))), 0)); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY))) == 0;
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((*((ListManager->ListHead))->Blink))), -(*((ListManager->size)), 1))); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.ListHead), ^_LIST_ENTRY), _LIST_ENTRY.Blink), ^_LIST_ENTRY))) == $mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)) - 1;
    // assert @inv_check(forall(struct _LIST_ENTRY* e; { @keeps(ListManager, e) } @in_range_phys_ptr((mathint)e); ==>(@keeps(ListManager, e), <(@map_get(*((ListManager->index)), e), *((ListManager->size)))))); 
    assert (forall Q#e$1^83.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e$1^83.31#dt1))) < $mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.size)));
    // assert @inv_check(forall(struct _LIST_ENTRY* e1; struct _LIST_ENTRY* e2; { @keeps(ListManager, e1), @keeps(ListManager, e2) } &&(@in_range_phys_ptr((mathint)e1), @in_range_phys_ptr((mathint)e2)); ==>(&&(&&(@keeps(ListManager, e1), @keeps(ListManager, e2)), @_vcc_ptr_neq(e1, e2)), !=(@map_get(*((ListManager->index)), e1), @map_get(*((ListManager->index)), e2))))); 
    assert (forall Q#e1$1^87.31#dt1: int, Q#e2$1^87.31#dt1: int :: { $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1)), $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1))) && $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1))) ==> $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1)) && $keeps($s, $ptr(^_LIST_MANAGER, SL#ListManager), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) && $ptr_neq($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1), $ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e1$1^87.31#dt1))) != $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_LIST_MANAGER, SL#ListManager), _LIST_MANAGER.index))), $ref($ptr(^_LIST_ENTRY, Q#e2$1^87.31#dt1))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



function F#lambda#5(#l5: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l4: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l3: int, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: int) : $map_t..$ptr_to..^_LIST_ENTRY.^^u4;

const unique cf#lambda#5: $pure_function;

axiom $function_arg_type(cf#lambda#5, 0, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#5, 1, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#5, 2, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#5, 3, ^^u4);

axiom $function_arg_type(cf#lambda#5, 4, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#5, 5, ^^u4);

axiom $function_arg_type(cf#lambda#5, 6, $ptr_to(^_LIST_ENTRY));

procedure lambda#5(#l5: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l4: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l3: int, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: int) returns ($result: $map_t..$ptr_to..^_LIST_ENTRY.^^u4);
  free ensures $result == F#lambda#5(#l5, #l4, #l3, #l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#x$2^180.31#dt1: int, #l5: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l4: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l3: int, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: int :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(F#lambda#5(#l5, #l4, #l3, #l2, #l1, $ref($ptr(^_LIST_ENTRY, #l0))), $ref($ptr(^_LIST_ENTRY, Q#x$2^180.31#dt1))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#x$2^180.31#dt1))) && $in_range_u4(#l3) && $in_range_u4(#l1) && $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, #l0))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(F#lambda#5(#l5, #l4, #l3, #l2, #l1, $ref($ptr(^_LIST_ENTRY, #l0))), $ref($ptr(^_LIST_ENTRY, Q#x$2^180.31#dt1))) == (if $ptr_eq($ptr(^_LIST_ENTRY, Q#x$2^180.31#dt1), $ptr(^_LIST_ENTRY, #l0)) then #l1 else (if $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l2, $ref($ptr(^_LIST_ENTRY, Q#x$2^180.31#dt1))) <= #l3 then $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l4, $ref($ptr(^_LIST_ENTRY, Q#x$2^180.31#dt1))) else $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l5, $ref($ptr(^_LIST_ENTRY, Q#x$2^180.31#dt1))) + 1)));

function F#lambda#4(#l5: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l4: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l3: int, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: int) : $map_t..$ptr_to..^_LIST_ENTRY.^^u4;

const unique cf#lambda#4: $pure_function;

axiom $function_arg_type(cf#lambda#4, 0, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#4, 1, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#4, 2, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#4, 3, ^^u4);

axiom $function_arg_type(cf#lambda#4, 4, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#4, 5, ^^u4);

axiom $function_arg_type(cf#lambda#4, 6, $ptr_to(^_LIST_ENTRY));

procedure lambda#4(#l5: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l4: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l3: int, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: int) returns ($result: $map_t..$ptr_to..^_LIST_ENTRY.^^u4);
  free ensures $result == F#lambda#4(#l5, #l4, #l3, #l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#x$2^148.35#dt1: int, #l5: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l4: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l3: int, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: int :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(F#lambda#4(#l5, #l4, #l3, #l2, #l1, $ref($ptr(^_LIST_ENTRY, #l0))), $ref($ptr(^_LIST_ENTRY, Q#x$2^148.35#dt1))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#x$2^148.35#dt1))) && $in_range_u4(#l3) && $in_range_u4(#l1) && $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, #l0))) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(F#lambda#4(#l5, #l4, #l3, #l2, #l1, $ref($ptr(^_LIST_ENTRY, #l0))), $ref($ptr(^_LIST_ENTRY, Q#x$2^148.35#dt1))) == (if $ptr_eq($ptr(^_LIST_ENTRY, Q#x$2^148.35#dt1), $ptr(^_LIST_ENTRY, #l0)) then #l1 else (if $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l2, $ref($ptr(^_LIST_ENTRY, Q#x$2^148.35#dt1))) < #l3 then $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l4, $ref($ptr(^_LIST_ENTRY, Q#x$2^148.35#dt1))) else $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l5, $ref($ptr(^_LIST_ENTRY, Q#x$2^148.35#dt1))) + 1)));

function F#lambda#3(#l3: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: $map_t..$ptr_to..^_LIST_ENTRY.^^u4) : $map_t..$ptr_to..^_LIST_ENTRY.^^u4;

const unique cf#lambda#3: $pure_function;

axiom $function_arg_type(cf#lambda#3, 0, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#3, 1, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#3, 2, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#3, 3, ^^u4);

axiom $function_arg_type(cf#lambda#3, 4, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

procedure lambda#3(#l3: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: $map_t..$ptr_to..^_LIST_ENTRY.^^u4) returns ($result: $map_t..$ptr_to..^_LIST_ENTRY.^^u4);
  free ensures $result == F#lambda#3(#l3, #l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#x$2^113.31#dt1: int, #l3: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: $map_t..$ptr_to..^_LIST_ENTRY.^^u4 :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(F#lambda#3(#l3, #l2, #l1, #l0), $ref($ptr(^_LIST_ENTRY, Q#x$2^113.31#dt1))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#x$2^113.31#dt1))) && $in_range_u4(#l1) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(F#lambda#3(#l3, #l2, #l1, #l0), $ref($ptr(^_LIST_ENTRY, Q#x$2^113.31#dt1))) == (if $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l0, $ref($ptr(^_LIST_ENTRY, Q#x$2^113.31#dt1))) < #l1 then $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l2, $ref($ptr(^_LIST_ENTRY, Q#x$2^113.31#dt1))) else $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l3, $ref($ptr(^_LIST_ENTRY, Q#x$2^113.31#dt1))) - 1));

function F#lambda#2(#l3: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: $map_t..$ptr_to..^_LIST_ENTRY.^^u4) : $map_t..$ptr_to..^_LIST_ENTRY.^^u4;

const unique cf#lambda#2: $pure_function;

axiom $function_arg_type(cf#lambda#2, 0, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#2, 1, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#2, 2, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#2, 3, ^^u4);

axiom $function_arg_type(cf#lambda#2, 4, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

procedure lambda#2(#l3: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: $map_t..$ptr_to..^_LIST_ENTRY.^^u4) returns ($result: $map_t..$ptr_to..^_LIST_ENTRY.^^u4);
  free ensures $result == F#lambda#2(#l3, #l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#x$2^83.31#dt1: int, #l3: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: $map_t..$ptr_to..^_LIST_ENTRY.^^u4 :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(F#lambda#2(#l3, #l2, #l1, #l0), $ref($ptr(^_LIST_ENTRY, Q#x$2^83.31#dt1))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#x$2^83.31#dt1))) && $in_range_u4(#l1) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(F#lambda#2(#l3, #l2, #l1, #l0), $ref($ptr(^_LIST_ENTRY, Q#x$2^83.31#dt1))) == (if $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l0, $ref($ptr(^_LIST_ENTRY, Q#x$2^83.31#dt1))) < #l1 then $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l2, $ref($ptr(^_LIST_ENTRY, Q#x$2^83.31#dt1))) else $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l3, $ref($ptr(^_LIST_ENTRY, Q#x$2^83.31#dt1))) - 1));

function F#lambda#1(#l3: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: $map_t..$ptr_to..^_LIST_ENTRY.^^u4) : $map_t..$ptr_to..^_LIST_ENTRY.^^u4;

const unique cf#lambda#1: $pure_function;

axiom $function_arg_type(cf#lambda#1, 0, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#1, 1, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#1, 2, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#1, 3, ^^u4);

axiom $function_arg_type(cf#lambda#1, 4, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

procedure lambda#1(#l3: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: $map_t..$ptr_to..^_LIST_ENTRY.^^u4) returns ($result: $map_t..$ptr_to..^_LIST_ENTRY.^^u4);
  free ensures $result == F#lambda#1(#l3, #l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#x$2^52.31#dt1: int, #l3: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: $map_t..$ptr_to..^_LIST_ENTRY.^^u4 :: { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(F#lambda#1(#l3, #l2, #l1, #l0), $ref($ptr(^_LIST_ENTRY, Q#x$2^52.31#dt1))) } $in_range_phys_ptr($ref($ptr(^_LIST_ENTRY, Q#x$2^52.31#dt1))) && $in_range_u4(#l1) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(F#lambda#1(#l3, #l2, #l1, #l0), $ref($ptr(^_LIST_ENTRY, Q#x$2^52.31#dt1))) == (if $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l0, $ref($ptr(^_LIST_ENTRY, Q#x$2^52.31#dt1))) < #l1 then $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l2, $ref($ptr(^_LIST_ENTRY, Q#x$2^52.31#dt1))) else $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l3, $ref($ptr(^_LIST_ENTRY, Q#x$2^52.31#dt1))) - 1));

const unique l#public: $label;

type $map_t..$ptr_to..^_LIST_ENTRY.^^u4;

function $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, p: int) : int;

function $store.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, p: int, v: int) : $map_t..$ptr_to..^_LIST_ENTRY.^^u4;

function $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M1: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, M2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4) : bool;

const $zero.$map_t..$ptr_to..^_LIST_ENTRY.^^u4: $map_t..$ptr_to..^_LIST_ENTRY.^^u4;

axiom (forall M: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, p: int, v: int :: $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($store.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M, p, v), p) == $unchecked(^^u4, v));

axiom (forall M: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, p: int, v: int, q: int :: p != q ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($store.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M, q, v), p) == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M, p));

axiom (forall M1: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, M2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4 :: { $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M1, M2) } (forall p: int :: $unchecked(^^u4, $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M1, p)) == $unchecked(^^u4, $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M2, p))) ==> $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, M2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4 :: { $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M1, M2) } $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4(0) == $zero.$map_t..$ptr_to..^_LIST_ENTRY.^^u4;

axiom (forall p: int :: $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($zero.$map_t..$ptr_to..^_LIST_ENTRY.^^u4, p) == 0);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t($ptr_to(^_LIST_ENTRY), ^^u4)) } $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rec_fetch(r1, f)), $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

axiom (forall M: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, p: int :: $in_range_t(^^u4, $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M, p)));

const unique #loc.#l0: $token;

const unique #loc.#l1: $token;

const unique #loc.#l2: $token;

const unique #loc.#l3: $token;

const unique #loc.#l4: $token;

const unique #loc.#l5: $token;

const unique #loc.prestate#90: $token;

const unique #tok$2^180.9: $token;

const unique #loc.res_lambda#5#10: $token;

const unique #tok$2^180.31: $token;

const unique #tok$2^179.31: $token;

const unique #tok$2^178.9: $token;

const unique #loc.owns#88: $token;

const unique #loc.staticWrapState#87: $token;

const unique #loc.prestate#89: $token;

const unique #tok$2^174.13: $token;

const unique #tok$2^173.36: $token;

const unique #loc.prestate#86: $token;

const unique #loc.prestate#84: $token;

const unique #loc.owns#85: $token;

const unique #loc.owns#82: $token;

const unique #loc.staticWrapState#81: $token;

const unique #loc.prestate#83: $token;

const unique #tok$2^171.13: $token;

const unique #tok$2^170.36: $token;

const unique #loc.prestate#80: $token;

const unique #loc.prestate#78: $token;

const unique #loc.owns#79: $token;

const unique #tok$2^169.32: $token;

const unique #loc.prestate#77: $token;

const unique #tok$2^168.21: $token;

const unique #loc.owns#75: $token;

const unique #loc.staticWrapState#74: $token;

const unique #loc.prestate#76: $token;

const unique #tok$2^167.27: $token;

const unique #tok$2^166.5: $token;

const unique #tok$2^165.5: $token;

const unique #tok$2^160.27: $token;

const unique #tok$2^158.1: $token;

const unique #loc.prestate#73: $token;

const unique #tok$2^148.13: $token;

const unique #loc.res_lambda#4#9: $token;

const unique #tok$2^148.35: $token;

const unique #tok$2^146.13: $token;

const unique #tok$2^143.31: $token;

const unique #tok$2^142.9: $token;

const unique #loc.owns#71: $token;

const unique #loc.staticWrapState#70: $token;

const unique #loc.prestate#72: $token;

const unique #tok$2^138.13: $token;

const unique #tok$2^137.36: $token;

const unique #loc.prestate#69: $token;

const unique #loc.prestate#67: $token;

const unique #loc.owns#68: $token;

const unique #loc.owns#65: $token;

const unique #loc.staticWrapState#64: $token;

const unique #loc.prestate#66: $token;

const unique #tok$2^135.13: $token;

const unique #tok$2^134.36: $token;

const unique #loc.prestate#63: $token;

const unique #loc.prestate#61: $token;

const unique #loc.owns#62: $token;

const unique #tok$2^133.32: $token;

const unique #loc.prestate#60: $token;

const unique #tok$2^132.21: $token;

const unique #loc.owns#58: $token;

const unique #loc.staticWrapState#57: $token;

const unique #loc.prestate#59: $token;

const unique #tok$2^130.27: $token;

const unique #tok$2^129.5: $token;

const unique #tok$2^128.5: $token;

const unique #tok$2^123.27: $token;

const unique #tok$2^121.1: $token;

const unique #loc.prestate#56: $token;

const unique #tok$2^113.9: $token;

const unique #loc.res_lambda#3#8: $token;

const unique #tok$2^113.31: $token;

const unique #tok$2^112.31: $token;

const unique #tok$2^111.9: $token;

const unique #loc.owns#54: $token;

const unique #loc.staticWrapState#53: $token;

const unique #loc.prestate#55: $token;

const unique #tok$2^107.13: $token;

const unique #tok$2^106.36: $token;

const unique #loc.prestate#52: $token;

const unique #loc.prestate#50: $token;

const unique #loc.owns#51: $token;

const unique #loc.owns#48: $token;

const unique #loc.staticWrapState#47: $token;

const unique #loc.prestate#49: $token;

const unique #tok$2^104.13: $token;

const unique #tok$2^103.36: $token;

const unique #loc.prestate#46: $token;

const unique #loc.prestate#44: $token;

const unique #loc.owns#45: $token;

const unique #tok$2^102.32: $token;

const unique #loc.prestate#43: $token;

const unique #tok$2^101.5: $token;

const unique #tok$2^100.5: $token;

const unique #tok$2^93.5: $token;

const unique #tok$2^94.27: $token;

const unique #tok$2^91.1: $token;

const unique #loc.prestate#42: $token;

const unique #tok$2^83.9: $token;

const unique #loc.res_lambda#2#7: $token;

const unique #tok$2^83.31: $token;

const unique #tok$2^82.31: $token;

const unique #tok$2^81.9: $token;

const unique #loc.owns#40: $token;

const unique #loc.staticWrapState#39: $token;

const unique #loc.prestate#41: $token;

const unique #tok$2^77.13: $token;

const unique #tok$2^76.36: $token;

const unique #loc.prestate#38: $token;

const unique #loc.prestate#36: $token;

const unique #loc.owns#37: $token;

const unique #loc.owns#34: $token;

const unique #loc.staticWrapState#33: $token;

const unique #loc.prestate#35: $token;

const unique #tok$2^74.13: $token;

const unique #tok$2^73.36: $token;

const unique #loc.prestate#32: $token;

const unique #loc.prestate#30: $token;

const unique #loc.owns#31: $token;

const unique #tok$2^72.32: $token;

const unique #loc.prestate#29: $token;

const unique #tok$2^71.5: $token;

const unique #tok$2^70.5: $token;

const unique #tok$2^63.5: $token;

const unique #tok$2^64.27: $token;

const unique #tok$2^61.1: $token;

const unique #loc.prestate#28: $token;

const unique #tok$2^52.9: $token;

const unique #loc.res_lambda#1#6: $token;

const unique #tok$2^52.31: $token;

const unique #tok$2^51.31: $token;

const unique #tok$2^50.9: $token;

const unique #loc.owns#26: $token;

const unique #loc.staticWrapState#25: $token;

const unique #loc.prestate#27: $token;

const unique #tok$2^46.13: $token;

const unique #tok$2^45.36: $token;

const unique #loc.prestate#24: $token;

const unique #loc.prestate#22: $token;

const unique #loc.owns#23: $token;

const unique #loc.owns#20: $token;

const unique #loc.staticWrapState#19: $token;

const unique #loc.prestate#21: $token;

const unique #tok$2^43.13: $token;

const unique #tok$2^42.36: $token;

const unique #loc.prestate#18: $token;

const unique #loc.prestate#16: $token;

const unique #loc.owns#17: $token;

const unique #tok$2^41.32: $token;

const unique #loc.prestate#15: $token;

const unique #tok$2^40.5: $token;

const unique #tok$2^39.5: $token;

const unique #loc.Blink: $token;

const unique #loc.Flink: $token;

const unique #tok$2^32.5: $token;

const unique #tok$2^33.27: $token;

const unique #loc.Entry: $token;

const unique #tok$2^30.1: $token;

const unique #tok$2^24.1: $token;

const unique #tok$2^20.21: $token;

const unique #loc.prestate#14: $token;

const unique #tok$2^19.21: $token;

const unique #loc.owns#12: $token;

const unique #loc.staticWrapState#11: $token;

function $state_to_int(x: $state) : int;

function $int_to_state(x: int) : $state;

axiom (forall #x: $state :: #x == $int_to_state($state_to_int(#x)));

const unique #loc.prestate#13: $token;

const unique #tok$3^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(3, #file^?3Cno?20file?3E);

const unique #tok$2^18.27: $token;

const unique #tok$2^17.5: $token;

const unique #tok$2^16.5: $token;

const unique #tok$2^15.5: $token;

const unique #tok$2^14.5: $token;

const unique #tok$2^13.19: $token;

const unique #tok$2^10.5: $token;

const unique #tok$2^10.23: $token;

const unique #loc.ListManager: $token;

const unique #tok$2^9.27: $token;

const unique #loc.ListHead: $token;

const unique #tok$2^7.1: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CList.c: $token;

axiom $file_name_is(2, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CList.c);

const unique #loc._this_: $token;

const unique #tok$1^37.53: $token;

function $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(x: $map_t..$ptr_to..^_LIST_ENTRY.^^u4) : int;

function $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4(x: int) : $map_t..$ptr_to..^_LIST_ENTRY.^^u4;

axiom (forall #x: $map_t..$ptr_to..^_LIST_ENTRY.^^u4 :: #x == $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(#x)));

const unique #distTp3: $ctype;

axiom #distTp3 == $map_t($ptr_to(^_LIST_ENTRY), ^^u4);

const unique #file^c?3A?5Cdev?5Cfelt?5Cvcc?5Ctest?5Ctestsuite?5Cexamples?5Clist.h: $token;

axiom $file_name_is(1, #file^c?3A?5Cdev?5Cfelt?5Cvcc?5Ctest?5Ctestsuite?5Cexamples?5Clist.h);

const unique #distTp2: $ctype;

axiom #distTp2 == $spec_ptr_to(^_LIST_MANAGER);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^_LIST_ENTRY);
