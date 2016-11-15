axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^_SINGLE_LIST_ENTRY: $ctype;

axiom $is_composite(^_SINGLE_LIST_ENTRY);

axiom $ptr_level(^_SINGLE_LIST_ENTRY) == 0;

axiom $sizeof(^_SINGLE_LIST_ENTRY) == 8;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_SINGLE_LIST_ENTRY) } $inv2(#s1, #s2, #p, ^_SINGLE_LIST_ENTRY) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty())));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^_SINGLE_LIST_ENTRY, #r), l#public) } $inv_lab(#s2, $ptr(^_SINGLE_LIST_ENTRY, #r), l#public) == ($typed(#s2, $ptr(^_SINGLE_LIST_ENTRY, #r)) && $set_eq($owns(#s2, $ptr(^_SINGLE_LIST_ENTRY, #r)), $set_empty())));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^_SINGLE_LIST_ENTRY, #r)) } $in_full_extent_of(#q, $ptr(^_SINGLE_LIST_ENTRY, #r)) == (#q == $ptr(^_SINGLE_LIST_ENTRY, #r) || #q == $dot($ptr(^_SINGLE_LIST_ENTRY, #r), _SINGLE_LIST_ENTRY.$owns) || #q == $dot($ptr(^_SINGLE_LIST_ENTRY, #r), _SINGLE_LIST_ENTRY.Next) || #q == $dot($ptr(^_SINGLE_LIST_ENTRY, #r), _SINGLE_LIST_ENTRY.Back) || #q == $dot($ptr(^_SINGLE_LIST_ENTRY, #r), _SINGLE_LIST_ENTRY.Manager)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_SINGLE_LIST_ENTRY, #r)) } $in_extent_of(#s, #q, $ptr(^_SINGLE_LIST_ENTRY, #r)) == $in_struct_extent_of(#q, $ptr(^_SINGLE_LIST_ENTRY, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_SINGLE_LIST_ENTRY, #r)) } $typed(#s, $ptr(^_SINGLE_LIST_ENTRY, #r)) ==> $in_extent_of(#s, #q, $ptr(^_SINGLE_LIST_ENTRY, #r)) == (#q == $ptr(^_SINGLE_LIST_ENTRY, #r) || $emb(#s, #q) == $ptr(^_SINGLE_LIST_ENTRY, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^_SINGLE_LIST_ENTRY, #r)) } $in_span_of(#q, $ptr(^_SINGLE_LIST_ENTRY, #r)) == (#q == $ptr(^_SINGLE_LIST_ENTRY, #r) || #q == $dot($ptr(^_SINGLE_LIST_ENTRY, #r), _SINGLE_LIST_ENTRY.$owns) || #q == $dot($ptr(^_SINGLE_LIST_ENTRY, #r), _SINGLE_LIST_ENTRY.Next) || #q == $dot($ptr(^_SINGLE_LIST_ENTRY, #r), _SINGLE_LIST_ENTRY.Back) || #q == $dot($ptr(^_SINGLE_LIST_ENTRY, #r), _SINGLE_LIST_ENTRY.Manager)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^_SINGLE_LIST_ENTRY) } $state_spans_the_same(#s1, #s2, #p, ^_SINGLE_LIST_ENTRY) == ($mem_eq(#s1, #s2, $dot(#p, _SINGLE_LIST_ENTRY.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _SINGLE_LIST_ENTRY.Next)) && $mem_eq(#s1, #s2, $dot(#p, _SINGLE_LIST_ENTRY.Back)) && $mem_eq(#s1, #s2, $dot(#p, _SINGLE_LIST_ENTRY.Manager))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_SINGLE_LIST_ENTRY) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_SINGLE_LIST_ENTRY) == ($mem_eq(#s1, #s2, $dot(#p, _SINGLE_LIST_ENTRY.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _SINGLE_LIST_ENTRY.Next)) && $mem_eq(#s1, #s2, $dot(#p, _SINGLE_LIST_ENTRY.Back)) && $mem_eq(#s1, #s2, $dot(#p, _SINGLE_LIST_ENTRY.Manager))));

axiom $is_claimable(^_SINGLE_LIST_ENTRY) == false;

axiom $has_volatile_owns_set(^_SINGLE_LIST_ENTRY) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^_SINGLE_LIST_ENTRY, #r)) } $extent_mutable(#s1, $ptr(^_SINGLE_LIST_ENTRY, #r)) == $mutable(#s1, $ptr(^_SINGLE_LIST_ENTRY, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^_SINGLE_LIST_ENTRY, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^_SINGLE_LIST_ENTRY, #r)) == $is_fresh(#s1, #s2, $ptr(^_SINGLE_LIST_ENTRY, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^_SINGLE_LIST_ENTRY, #r)) } $extent_zero(#s1, $ptr(^_SINGLE_LIST_ENTRY, #r)) == ($mem(#s1, $dot($ptr(^_SINGLE_LIST_ENTRY, #r), _SINGLE_LIST_ENTRY.Next)) == 0 && $mem(#s1, $dot($ptr(^_SINGLE_LIST_ENTRY, #r), _SINGLE_LIST_ENTRY.Back)) == 0 && $mem(#s1, $dot($ptr(^_SINGLE_LIST_ENTRY, #r), _SINGLE_LIST_ENTRY.Manager)) == 0));

const unique _SINGLE_LIST_ENTRY.$owns: $field;

axiom $static_field_properties(_SINGLE_LIST_ENTRY.$owns, ^_SINGLE_LIST_ENTRY);

axiom $is_primitive_non_volatile_field(_SINGLE_LIST_ENTRY.$owns);

axiom (forall #p: $ptr :: { $dot(#p, _SINGLE_LIST_ENTRY.$owns) } $is(#p, ^_SINGLE_LIST_ENTRY) ==> $dot(#p, _SINGLE_LIST_ENTRY.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, _SINGLE_LIST_ENTRY.$owns)) && $extent_hint($dot(#p, _SINGLE_LIST_ENTRY.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _SINGLE_LIST_ENTRY.$owns)) } { $st(#s, $dot(#p, _SINGLE_LIST_ENTRY.$owns)) } $typed2(#s, #p, ^_SINGLE_LIST_ENTRY) ==> $field_properties(#s, #p, _SINGLE_LIST_ENTRY.$owns, ^$#ptrset, false));

axiom $owns_set_field(^_SINGLE_LIST_ENTRY) == _SINGLE_LIST_ENTRY.$owns;

const unique _SINGLE_LIST_ENTRY.Next: $field;

axiom $static_field_properties(_SINGLE_LIST_ENTRY.Next, ^_SINGLE_LIST_ENTRY);

axiom $is_primitive_non_volatile_field(_SINGLE_LIST_ENTRY.Next);

axiom $field_offset(_SINGLE_LIST_ENTRY.Next) == 0;

axiom (forall #p: $ptr :: { $dot(#p, _SINGLE_LIST_ENTRY.Next) } $is(#p, ^_SINGLE_LIST_ENTRY) ==> $dot(#p, _SINGLE_LIST_ENTRY.Next) == $ptr($ptr_to(^_SINGLE_LIST_ENTRY), $ref(#p) + 0) && $extent_hint($dot(#p, _SINGLE_LIST_ENTRY.Next), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _SINGLE_LIST_ENTRY.Next)) } { $st(#s, $dot(#p, _SINGLE_LIST_ENTRY.Next)) } $typed2(#s, #p, ^_SINGLE_LIST_ENTRY) ==> $field_properties(#s, #p, _SINGLE_LIST_ENTRY.Next, $ptr_to(^_SINGLE_LIST_ENTRY), false));

const unique _SINGLE_LIST_ENTRY.Back: $field;

axiom $static_field_properties(_SINGLE_LIST_ENTRY.Back, ^_SINGLE_LIST_ENTRY);

axiom $is_primitive_non_volatile_field(_SINGLE_LIST_ENTRY.Back);

axiom (forall #p: $ptr :: { $dot(#p, _SINGLE_LIST_ENTRY.Back) } $is(#p, ^_SINGLE_LIST_ENTRY) ==> $dot(#p, _SINGLE_LIST_ENTRY.Back) == $ptr($ptr_to(^_SINGLE_LIST_ENTRY), $ghost_ref(#p, _SINGLE_LIST_ENTRY.Back)) && $extent_hint($dot(#p, _SINGLE_LIST_ENTRY.Back), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _SINGLE_LIST_ENTRY.Back)) } { $st(#s, $dot(#p, _SINGLE_LIST_ENTRY.Back)) } $typed2(#s, #p, ^_SINGLE_LIST_ENTRY) ==> $field_properties(#s, #p, _SINGLE_LIST_ENTRY.Back, $ptr_to(^_SINGLE_LIST_ENTRY), false));

const unique _SINGLE_LIST_ENTRY.Manager: $field;

axiom $static_field_properties(_SINGLE_LIST_ENTRY.Manager, ^_SINGLE_LIST_ENTRY);

axiom $is_primitive_non_volatile_field(_SINGLE_LIST_ENTRY.Manager);

axiom (forall #p: $ptr :: { $dot(#p, _SINGLE_LIST_ENTRY.Manager) } $is(#p, ^_SINGLE_LIST_ENTRY) ==> $dot(#p, _SINGLE_LIST_ENTRY.Manager) == $ptr($spec_ptr_to(^_SINGLE_LIST_MANAGER), $ghost_ref(#p, _SINGLE_LIST_ENTRY.Manager)) && $extent_hint($dot(#p, _SINGLE_LIST_ENTRY.Manager), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _SINGLE_LIST_ENTRY.Manager)) } { $st(#s, $dot(#p, _SINGLE_LIST_ENTRY.Manager)) } $typed2(#s, #p, ^_SINGLE_LIST_ENTRY) ==> $field_properties(#s, #p, _SINGLE_LIST_ENTRY.Manager, $spec_ptr_to(^_SINGLE_LIST_MANAGER), false));

const unique ^_SINGLE_LIST_MANAGER: $ctype;

axiom $is_composite(^_SINGLE_LIST_MANAGER);

axiom $ptr_level(^_SINGLE_LIST_MANAGER) == 0;

axiom $sizeof(^_SINGLE_LIST_MANAGER) == 1;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_SINGLE_LIST_MANAGER) } $inv2(#s1, #s2, #p, ^_SINGLE_LIST_MANAGER) == ($typed(#s2, #p) && (forall Q#p$1^54.31#tc1: $ptr :: { $set_in(Q#p$1^54.31#tc1, $owns(#s2, #p)) } $set_in(Q#p$1^54.31#tc1, $owns(#s2, #p)) ==> $is(Q#p$1^54.31#tc1, ^_SINGLE_LIST_ENTRY) && $typed2(#s2, Q#p$1^54.31#tc1, $typ(Q#p$1^54.31#tc1)) && !$is_ghost_ptr(Q#p$1^54.31#tc1)) && (forall Q#p$1^58.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1), $owns(#s2, #p)) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1), $owns(#s2, #p)) ==> $ptr_eq($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), #p)) && $set_in($read_ptr(#s2, $dot(#p, _SINGLE_LIST_MANAGER.ListHead), ^_SINGLE_LIST_ENTRY), $owns(#s2, #p)) && (forall Q#p$1^67.31#dt1: int :: { $set_in($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns(#s2, #p)) } { sk_hack($set_in($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns(#s2, #p))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), $owns(#s2, #p)) && $ptr_neq($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $null) ==> $set_in($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns(#s2, #p)) && $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1))) && (forall Q#p$1^72.31#dt1: int :: { $set_in($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $owns(#s2, #p)) } { sk_hack($set_in($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $owns(#s2, #p))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), $owns(#s2, #p)) && $ptr_neq($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $null) ==> $set_in($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $owns(#s2, #p)) && $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1))) && (forall Q#p$1^81.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), $owns(#s2, #p)) } { sk_hack($set_in($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns(#s2, #p))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), $owns(#s2, #p)) && $ptr_neq($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $null) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem(#s2, $dot(#p, _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1))) + 1 == $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem(#s2, $dot(#p, _SINGLE_LIST_MANAGER.index))), $ref($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY)))) && $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem(#s2, $dot(#p, _SINGLE_LIST_MANAGER.index))), $ref($read_ptr(#s2, $dot(#p, _SINGLE_LIST_MANAGER.ListHead), ^_SINGLE_LIST_ENTRY))) == 0 && (forall Q#e$1^88.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1), $owns(#s2, #p)) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1), $owns(#s2, #p)) ==> 0 <= $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem(#s2, $dot(#p, _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1))) && $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem(#s2, $dot(#p, _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1))) < $mem(#s2, $dot(#p, _SINGLE_LIST_MANAGER.size))) && (forall Q#e1$1^92.31#dt1: int, Q#e2$1^92.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1), $owns(#s2, #p)), $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1), $owns(#s2, #p)) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1))) && $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1), $owns(#s2, #p)) && $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1), $owns(#s2, #p)) && $ptr_neq($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1), $ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1)) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem(#s2, $dot(#p, _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1))) != $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem(#s2, $dot(#p, _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1))))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r), l#public) } $inv_lab(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r), l#public) == ($typed(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r)) && (forall Q#p$1^54.31#tc1: $ptr :: { $set_in(Q#p$1^54.31#tc1, $owns(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r))) } $set_in(Q#p$1^54.31#tc1, $owns(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r))) ==> $is(Q#p$1^54.31#tc1, ^_SINGLE_LIST_ENTRY) && $typed2(#s2, Q#p$1^54.31#tc1, $typ(Q#p$1^54.31#tc1)) && !$is_ghost_ptr(Q#p$1^54.31#tc1)) && (forall Q#p$1^58.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1), $owns(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1), $owns(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r))) ==> $ptr_eq($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), $ptr(^_SINGLE_LIST_MANAGER, #r))) && $set_in($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_MANAGER, #r), _SINGLE_LIST_MANAGER.ListHead), ^_SINGLE_LIST_ENTRY), $owns(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r))) && (forall Q#p$1^67.31#dt1: int :: { $set_in($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r))) } { sk_hack($set_in($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r)))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), $owns(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $null) ==> $set_in($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r))) && $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1))) && (forall Q#p$1^72.31#dt1: int :: { $set_in($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $owns(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r))) } { sk_hack($set_in($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $owns(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r)))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), $owns(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $null) ==> $set_in($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $owns(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r))) && $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1))) && (forall Q#p$1^81.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), $owns(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r))) } { sk_hack($set_in($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r)))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), $owns(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $null) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem(#s2, $dot($ptr(^_SINGLE_LIST_MANAGER, #r), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1))) + 1 == $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem(#s2, $dot($ptr(^_SINGLE_LIST_MANAGER, #r), _SINGLE_LIST_MANAGER.index))), $ref($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY)))) && $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem(#s2, $dot($ptr(^_SINGLE_LIST_MANAGER, #r), _SINGLE_LIST_MANAGER.index))), $ref($read_ptr(#s2, $dot($ptr(^_SINGLE_LIST_MANAGER, #r), _SINGLE_LIST_MANAGER.ListHead), ^_SINGLE_LIST_ENTRY))) == 0 && (forall Q#e$1^88.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1), $owns(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1), $owns(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r))) ==> 0 <= $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem(#s2, $dot($ptr(^_SINGLE_LIST_MANAGER, #r), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1))) && $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem(#s2, $dot($ptr(^_SINGLE_LIST_MANAGER, #r), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1))) < $mem(#s2, $dot($ptr(^_SINGLE_LIST_MANAGER, #r), _SINGLE_LIST_MANAGER.size))) && (forall Q#e1$1^92.31#dt1: int, Q#e2$1^92.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1), $owns(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r))), $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1), $owns(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1))) && $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1), $owns(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r))) && $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1), $owns(#s2, $ptr(^_SINGLE_LIST_MANAGER, #r))) && $ptr_neq($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1), $ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1)) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem(#s2, $dot($ptr(^_SINGLE_LIST_MANAGER, #r), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1))) != $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem(#s2, $dot($ptr(^_SINGLE_LIST_MANAGER, #r), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1))))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^_SINGLE_LIST_MANAGER, #r)) } $in_full_extent_of(#q, $ptr(^_SINGLE_LIST_MANAGER, #r)) == (#q == $ptr(^_SINGLE_LIST_MANAGER, #r) || #q == $dot($ptr(^_SINGLE_LIST_MANAGER, #r), _SINGLE_LIST_MANAGER.$owns) || #q == $dot($ptr(^_SINGLE_LIST_MANAGER, #r), _SINGLE_LIST_MANAGER.size) || #q == $dot($ptr(^_SINGLE_LIST_MANAGER, #r), _SINGLE_LIST_MANAGER.ListHead) || #q == $dot($ptr(^_SINGLE_LIST_MANAGER, #r), _SINGLE_LIST_MANAGER.index)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_SINGLE_LIST_MANAGER, #r)) } $in_extent_of(#s, #q, $ptr(^_SINGLE_LIST_MANAGER, #r)) == $in_struct_extent_of(#q, $ptr(^_SINGLE_LIST_MANAGER, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_SINGLE_LIST_MANAGER, #r)) } $typed(#s, $ptr(^_SINGLE_LIST_MANAGER, #r)) ==> $in_extent_of(#s, #q, $ptr(^_SINGLE_LIST_MANAGER, #r)) == (#q == $ptr(^_SINGLE_LIST_MANAGER, #r) || $emb(#s, #q) == $ptr(^_SINGLE_LIST_MANAGER, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^_SINGLE_LIST_MANAGER, #r)) } $in_span_of(#q, $ptr(^_SINGLE_LIST_MANAGER, #r)) == (#q == $ptr(^_SINGLE_LIST_MANAGER, #r) || #q == $dot($ptr(^_SINGLE_LIST_MANAGER, #r), _SINGLE_LIST_MANAGER.$owns) || #q == $dot($ptr(^_SINGLE_LIST_MANAGER, #r), _SINGLE_LIST_MANAGER.size) || #q == $dot($ptr(^_SINGLE_LIST_MANAGER, #r), _SINGLE_LIST_MANAGER.ListHead) || #q == $dot($ptr(^_SINGLE_LIST_MANAGER, #r), _SINGLE_LIST_MANAGER.index)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^_SINGLE_LIST_MANAGER) } $state_spans_the_same(#s1, #s2, #p, ^_SINGLE_LIST_MANAGER) == ($mem_eq(#s1, #s2, $dot(#p, _SINGLE_LIST_MANAGER.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _SINGLE_LIST_MANAGER.size)) && $mem_eq(#s1, #s2, $dot(#p, _SINGLE_LIST_MANAGER.ListHead)) && $mem_eq(#s1, #s2, $dot(#p, _SINGLE_LIST_MANAGER.index))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_SINGLE_LIST_MANAGER) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_SINGLE_LIST_MANAGER) == ($mem_eq(#s1, #s2, $dot(#p, _SINGLE_LIST_MANAGER.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _SINGLE_LIST_MANAGER.size)) && $mem_eq(#s1, #s2, $dot(#p, _SINGLE_LIST_MANAGER.ListHead)) && $mem_eq(#s1, #s2, $dot(#p, _SINGLE_LIST_MANAGER.index))));

axiom $is_claimable(^_SINGLE_LIST_MANAGER) == false;

axiom $has_volatile_owns_set(^_SINGLE_LIST_MANAGER) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^_SINGLE_LIST_MANAGER, #r)) } $extent_mutable(#s1, $ptr(^_SINGLE_LIST_MANAGER, #r)) == $mutable(#s1, $ptr(^_SINGLE_LIST_MANAGER, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^_SINGLE_LIST_MANAGER, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^_SINGLE_LIST_MANAGER, #r)) == $is_fresh(#s1, #s2, $ptr(^_SINGLE_LIST_MANAGER, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^_SINGLE_LIST_MANAGER, #r)) } $extent_zero(#s1, $ptr(^_SINGLE_LIST_MANAGER, #r)) == ($mem(#s1, $dot($ptr(^_SINGLE_LIST_MANAGER, #r), _SINGLE_LIST_MANAGER.size)) == 0 && $mem(#s1, $dot($ptr(^_SINGLE_LIST_MANAGER, #r), _SINGLE_LIST_MANAGER.ListHead)) == 0 && $mem(#s1, $dot($ptr(^_SINGLE_LIST_MANAGER, #r), _SINGLE_LIST_MANAGER.index)) == 0));

const unique _SINGLE_LIST_MANAGER.$owns: $field;

axiom $static_field_properties(_SINGLE_LIST_MANAGER.$owns, ^_SINGLE_LIST_MANAGER);

axiom $is_primitive_non_volatile_field(_SINGLE_LIST_MANAGER.$owns);

axiom (forall #p: $ptr :: { $dot(#p, _SINGLE_LIST_MANAGER.$owns) } $is(#p, ^_SINGLE_LIST_MANAGER) ==> $dot(#p, _SINGLE_LIST_MANAGER.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, _SINGLE_LIST_MANAGER.$owns)) && $extent_hint($dot(#p, _SINGLE_LIST_MANAGER.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _SINGLE_LIST_MANAGER.$owns)) } { $st(#s, $dot(#p, _SINGLE_LIST_MANAGER.$owns)) } $typed2(#s, #p, ^_SINGLE_LIST_MANAGER) ==> $field_properties(#s, #p, _SINGLE_LIST_MANAGER.$owns, ^$#ptrset, false));

axiom $owns_set_field(^_SINGLE_LIST_MANAGER) == _SINGLE_LIST_MANAGER.$owns;

const unique _SINGLE_LIST_MANAGER.size: $field;

axiom $static_field_properties(_SINGLE_LIST_MANAGER.size, ^_SINGLE_LIST_MANAGER);

axiom $is_primitive_non_volatile_field(_SINGLE_LIST_MANAGER.size);

axiom (forall #p: $ptr :: { $dot(#p, _SINGLE_LIST_MANAGER.size) } $is(#p, ^_SINGLE_LIST_MANAGER) ==> $dot(#p, _SINGLE_LIST_MANAGER.size) == $ptr(^^u4, $ghost_ref(#p, _SINGLE_LIST_MANAGER.size)) && $extent_hint($dot(#p, _SINGLE_LIST_MANAGER.size), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _SINGLE_LIST_MANAGER.size)) } { $st(#s, $dot(#p, _SINGLE_LIST_MANAGER.size)) } $typed2(#s, #p, ^_SINGLE_LIST_MANAGER) ==> $field_properties(#s, #p, _SINGLE_LIST_MANAGER.size, ^^u4, false));

const unique _SINGLE_LIST_MANAGER.ListHead: $field;

axiom $static_field_properties(_SINGLE_LIST_MANAGER.ListHead, ^_SINGLE_LIST_MANAGER);

axiom $is_primitive_non_volatile_field(_SINGLE_LIST_MANAGER.ListHead);

axiom (forall #p: $ptr :: { $dot(#p, _SINGLE_LIST_MANAGER.ListHead) } $is(#p, ^_SINGLE_LIST_MANAGER) ==> $dot(#p, _SINGLE_LIST_MANAGER.ListHead) == $ptr($ptr_to(^_SINGLE_LIST_ENTRY), $ghost_ref(#p, _SINGLE_LIST_MANAGER.ListHead)) && $extent_hint($dot(#p, _SINGLE_LIST_MANAGER.ListHead), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _SINGLE_LIST_MANAGER.ListHead)) } { $st(#s, $dot(#p, _SINGLE_LIST_MANAGER.ListHead)) } $typed2(#s, #p, ^_SINGLE_LIST_MANAGER) ==> $field_properties(#s, #p, _SINGLE_LIST_MANAGER.ListHead, $ptr_to(^_SINGLE_LIST_ENTRY), false));

const unique _SINGLE_LIST_MANAGER.index: $field;

axiom $static_field_properties(_SINGLE_LIST_MANAGER.index, ^_SINGLE_LIST_MANAGER);

axiom $is_primitive_non_volatile_field(_SINGLE_LIST_MANAGER.index);

axiom (forall #p: $ptr :: { $dot(#p, _SINGLE_LIST_MANAGER.index) } $is(#p, ^_SINGLE_LIST_MANAGER) ==> $dot(#p, _SINGLE_LIST_MANAGER.index) == $ptr($map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4), $ghost_ref(#p, _SINGLE_LIST_MANAGER.index)) && $extent_hint($dot(#p, _SINGLE_LIST_MANAGER.index), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _SINGLE_LIST_MANAGER.index)) } { $st(#s, $dot(#p, _SINGLE_LIST_MANAGER.index)) } $typed2(#s, #p, ^_SINGLE_LIST_MANAGER) ==> $field_properties(#s, #p, _SINGLE_LIST_MANAGER.index, $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4), false));

procedure _SINGLE_LIST_MANAGER#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> (forall Q#p$1^54.31#tc1: $ptr :: { $set_in(Q#p$1^54.31#tc1, $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) } $set_in(Q#p$1^54.31#tc1, $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) ==> $is(Q#p$1^54.31#tc1, ^_SINGLE_LIST_ENTRY) && $typed2($s, Q#p$1^54.31#tc1, $typ(Q#p$1^54.31#tc1)) && !$is_ghost_ptr(Q#p$1^54.31#tc1));
  ensures $is_admissibility_check() ==> (forall Q#p$1^58.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) ==> $ptr_eq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), $ptr(^_SINGLE_LIST_MANAGER, P#_this_)));
  ensures $is_admissibility_check() ==> $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_MANAGER, P#_this_), _SINGLE_LIST_MANAGER.ListHead), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_)));
  ensures $is_admissibility_check() ==> (forall Q#p$1^67.31#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) } { sk_hack($set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_)))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) && $ptr_neq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $null) ==> $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1)));
  ensures $is_admissibility_check() ==> (forall Q#p$1^72.31#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) } { sk_hack($set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_)))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) && $ptr_neq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $null) ==> $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1)));
  ensures $is_admissibility_check() ==> (forall Q#p$1^81.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) } { sk_hack($set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_)))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) && $ptr_neq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $null) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, P#_this_), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1))) + 1 == $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, P#_this_), _SINGLE_LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY))));
  ensures $is_admissibility_check() ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, P#_this_), _SINGLE_LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_SINGLE_LIST_MANAGER, P#_this_), _SINGLE_LIST_MANAGER.ListHead), ^_SINGLE_LIST_ENTRY))) == 0;
  ensures $is_admissibility_check() ==> (forall Q#e$1^88.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) ==> 0 <= $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, P#_this_), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1))) && $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, P#_this_), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1))) < $mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, P#_this_), _SINGLE_LIST_MANAGER.size)));
  ensures $is_admissibility_check() ==> (forall Q#e1$1^92.31#dt1: int, Q#e2$1^92.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))), $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1))) && $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) && $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) && $ptr_neq($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1), $ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1)) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, P#_this_), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1))) != $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, P#_this_), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1))));
  ensures $is_unwrap_check() ==> (forall Q#p$1^54.31#tc1: $ptr :: { $set_in(Q#p$1^54.31#tc1, $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) } $set_in(Q#p$1^54.31#tc1, $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) ==> $is(Q#p$1^54.31#tc1, ^_SINGLE_LIST_ENTRY) && $typed2($s, Q#p$1^54.31#tc1, $typ(Q#p$1^54.31#tc1)) && !$is_ghost_ptr(Q#p$1^54.31#tc1));
  ensures $is_unwrap_check() ==> (forall Q#p$1^58.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) ==> $ptr_eq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), $ptr(^_SINGLE_LIST_MANAGER, P#_this_)));
  ensures $is_unwrap_check() ==> $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_MANAGER, P#_this_), _SINGLE_LIST_MANAGER.ListHead), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_)));
  ensures $is_unwrap_check() ==> (forall Q#p$1^67.31#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) } { sk_hack($set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_)))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) && $ptr_neq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $null) ==> $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1)));
  ensures $is_unwrap_check() ==> (forall Q#p$1^72.31#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) } { sk_hack($set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_)))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) && $ptr_neq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $null) ==> $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1)));
  ensures $is_unwrap_check() ==> (forall Q#p$1^81.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) } { sk_hack($set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_)))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) && $ptr_neq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $null) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, P#_this_), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1))) + 1 == $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, P#_this_), _SINGLE_LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY))));
  ensures $is_unwrap_check() ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, P#_this_), _SINGLE_LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_SINGLE_LIST_MANAGER, P#_this_), _SINGLE_LIST_MANAGER.ListHead), ^_SINGLE_LIST_ENTRY))) == 0;
  ensures $is_unwrap_check() ==> (forall Q#e$1^88.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) ==> 0 <= $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, P#_this_), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1))) && $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, P#_this_), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1))) < $mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, P#_this_), _SINGLE_LIST_MANAGER.size)));
  ensures $is_unwrap_check() ==> (forall Q#e1$1^92.31#dt1: int, Q#e2$1^92.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))), $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1))) && $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) && $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_))) && $ptr_neq($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1), $ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1)) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, P#_this_), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1))) != $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, P#_this_), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1))));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _SINGLE_LIST_MANAGER#adm(P#_this_: int)
{
  var #wrTime$1^44.53: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^44.53, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^44.53, #loc._this_, $ptr_to_int($ptr(^_SINGLE_LIST_MANAGER, P#_this_)), $spec_ptr_to(^_SINGLE_LIST_MANAGER)) && $local_value_is_ptr($s, #tok$1^44.53, #loc._this_, $ptr(^_SINGLE_LIST_MANAGER, P#_this_), $spec_ptr_to(^_SINGLE_LIST_MANAGER));
    assume #wrTime$1^44.53 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^44.53, #p) } $in_writes_at(#wrTime$1^44.53, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^_SINGLE_LIST_MANAGER, P#_this_));
        assume $good_state_ext(#tok$1^44.53, $s);
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
            assume $admissibility_pre($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct _SINGLE_LIST_MANAGER*)@null))
        call $havoc_others($ptr(^_SINGLE_LIST_MANAGER, P#_this_), ^_SINGLE_LIST_MANAGER);
        assume $good_state_ext(#tok$1^44.53, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^_SINGLE_LIST_MANAGER, P#_this_), ^_SINGLE_LIST_MANAGER);
    }

  #exit:
}



procedure InitializeSingleListHead(P#ListHead: int);
  requires $mutable($s, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead));
  modifies $s, $cev_pc;
  ensures $set_eq($owns($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER)), $set_singleton($ptr(^_SINGLE_LIST_ENTRY, P#ListHead))) && $set_in($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), $owns($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER)));
  ensures $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), _SINGLE_LIST_MANAGER.ListHead), ^_SINGLE_LIST_ENTRY), $ptr(^_SINGLE_LIST_ENTRY, P#ListHead));
  ensures $mem($s, $dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), _SINGLE_LIST_MANAGER.size)) == 1;
  ensures $wrapped($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_MANAGER);
  ensures $is_fresh(old($s), $s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER));
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $extent(old($s), $ptr(^_SINGLE_LIST_ENTRY, P#ListHead))) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $extent(old($s), $ptr(^_SINGLE_LIST_ENTRY, P#ListHead))) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $extent(old($s), $ptr(^_SINGLE_LIST_ENTRY, P#ListHead))) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation InitializeSingleListHead(P#ListHead: int)
{
  var prestate#8: $state;
  var owns#6: $ptrset;
  var staticWrapState#5: $state;
  var prestate#7: $state;
  var #callConv#0: $ptr;
  var SL#ListManager: int where $in_range_spec_ptr(SL#ListManager);
  var #wrTime$1^117.1: int;
  var #stackframe: int;

  anon7:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^117.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^117.1, #loc.ListHead, $ptr_to_int($ptr(^_SINGLE_LIST_ENTRY, P#ListHead)), $ptr_to(^_SINGLE_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$1^117.1, #loc.ListHead, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead), $ptr_to(^_SINGLE_LIST_ENTRY));
    assume #wrTime$1^117.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^117.1, #p) } $in_writes_at(#wrTime$1^117.1, #p) == $set_in(#p, $extent($s, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead))));
    assume (forall #p: $ptr :: { $extent_hint(#p, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead)) } $set_in(#p, $extent($s, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead))) ==> $mutable($s, #p));
    // assume @in_range_phys_ptr((mathint)ListHead); 
    assume $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, P#ListHead)));
    // struct _SINGLE_LIST_MANAGER^ ListManager; 
    assume $local_value_is($s, #tok$1^126.27, #loc.ListManager, $ptr_to_int($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)), $spec_ptr_to(^_SINGLE_LIST_MANAGER)) && $local_value_is_ptr($s, #tok$1^126.27, #loc.ListManager, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), $spec_ptr_to(^_SINGLE_LIST_MANAGER));
    // var spec struct _SINGLE_LIST_MANAGER^ ListManager
    // assert @_vcc_typed2(@state, (ListHead->Next)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), $ptr_to(^_SINGLE_LIST_ENTRY));
    // assert @prim_writes_check((ListHead->Next)); 
    assert $writable($s, #wrTime$1^117.1, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next));
    // *(ListHead->Next) := (struct _SINGLE_LIST_ENTRY*)@null; 
    call $write_int($dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), $ref($ptr_cast($null, ^_SINGLE_LIST_ENTRY)));
    assume $full_stop_ext(#tok$1^127.5, $s);
    // assert @_vcc_typed2(@state, (ListHead->Back)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Back), $ptr_to(^_SINGLE_LIST_ENTRY));
    // assert @prim_writes_check((ListHead->Back)); 
    assert $writable($s, #wrTime$1^117.1, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Back));
    // *(ListHead->Back) := (struct _SINGLE_LIST_ENTRY*)@null; 
    call $write_int($dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Back), $ref($ptr_cast($null, ^_SINGLE_LIST_ENTRY)));
    assume $full_stop_ext(#tok$1^128.27, $s);
    // ListManager := _vcc_spec_alloc<struct _SINGLE_LIST_MANAGER>(); 
    call #callConv#0 := $spec_alloc(^_SINGLE_LIST_MANAGER);
    assume $full_stop_ext(#tok$1^131.19, $s);
    SL#ListManager := $ref(#callConv#0);
    assume $local_value_is($s, #tok$1^131.19, #loc.ListManager, $ptr_to_int($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)), $spec_ptr_to(^_SINGLE_LIST_MANAGER)) && $local_value_is_ptr($s, #tok$1^131.19, #loc.ListManager, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), $spec_ptr_to(^_SINGLE_LIST_MANAGER));
    // assert @_vcc_typed2(@state, (ListManager->size)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size), ^^u4);
    // assert @prim_writes_check((ListManager->size)); 
    assert $writable($s, #wrTime$1^117.1, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size));
    // *(ListManager->size) := 1; 
    call $write_int($dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size), 1);
    assume $full_stop_ext(#tok$1^132.5, $s);
    // assert @_vcc_typed2(@state, (ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
    // assert @prim_writes_check((ListManager->index)); 
    assert $writable($s, #wrTime$1^117.1, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index));
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
    // *(ListManager->index) := @map_updated(*((ListManager->index)), ListHead, 0); 
    call $write_int($dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index), $map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4_to_int($store.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, P#ListHead)), 0)));
    assume $full_stop_ext(#tok$1^133.5, $s);
    // assert @_vcc_typed2(@state, (ListManager->ListHead)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.ListHead), $ptr_to(^_SINGLE_LIST_ENTRY));
    // assert @prim_writes_check((ListManager->ListHead)); 
    assert $writable($s, #wrTime$1^117.1, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.ListHead));
    // *(ListManager->ListHead) := ListHead; 
    call $write_int($dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.ListHead), $ref($ptr(^_SINGLE_LIST_ENTRY, P#ListHead)));
    assume $full_stop_ext(#tok$1^134.5, $s);
    // assert @writes_check(@_vcc_span(ListHead)); 
    assert (forall #writes$1^136.27: $ptr :: { $dont_instantiate(#writes$1^136.27) } $set_in(#writes$1^136.27, $span($ptr(^_SINGLE_LIST_ENTRY, P#ListHead))) ==> $top_writable($s, #wrTime$1^117.1, #writes$1^136.27));
    // stmt _vcc_set_owns(ListHead, @_vcc_set_empty); 
    call $set_owns($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), $set_empty());
    assume $full_stop_ext(#tok$1^136.27, $s);
    // empty
    // assert @writes_check(@_vcc_span(ListManager)); 
    assert (forall #writes$1^137.27: $ptr :: { $dont_instantiate(#writes$1^137.27) } $set_in(#writes$1^137.27, $span($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) ==> $top_writable($s, #wrTime$1^117.1, #writes$1^137.27));
    // stmt _vcc_set_owns(ListManager, @_vcc_set_singleton(ListHead)); 
    call $set_owns($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), $set_singleton($ptr(^_SINGLE_LIST_ENTRY, P#ListHead)));
    assume $full_stop_ext(#tok$1^137.27, $s);
    // empty
    // assert @_vcc_typed2(@state, (ListHead->Manager)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), $spec_ptr_to(^_SINGLE_LIST_MANAGER));
    // assert @prim_writes_check((ListHead->Manager)); 
    assert $writable($s, #wrTime$1^117.1, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager));
    // *(ListHead->Manager) := ListManager; 
    call $write_int($dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), $ref($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)));
    assume $full_stop_ext(#tok$1^138.5, $s);
    // _math state_t prestate#7; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#7, $state_to_int(prestate#7), ^$#state_t);
    // prestate#7 := @_vcc_current_state(@state); 
    prestate#7 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#7, $state_to_int(prestate#7), ^$#state_t);
    // _math state_t staticWrapState#5; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#5, $state_to_int(staticWrapState#5), ^$#state_t);
    // staticWrapState#5 := @_vcc_current_state(@state); 
    staticWrapState#5 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#5, $state_to_int(staticWrapState#5), ^$#state_t);
    // _math ptrset owns#6; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#6, $ptrset_to_int(owns#6), ^$#ptrset);
    // owns#6 := @_vcc_set_empty; 
    owns#6 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#6, $ptrset_to_int(owns#6), ^$#ptrset);
    // assert @writes_check(ListHead); 
    assert $top_writable($s, #wrTime$1^117.1, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(ListHead), staticWrapState#5, owns#6)
    call $static_wrap($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), staticWrapState#5, owns#6);
    assume $good_state_ext(#tok$1^139.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, ListHead), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#8; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#8, $state_to_int(prestate#8), ^$#state_t);
    // prestate#8 := @_vcc_current_state(@state); 
    prestate#8 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#8, $state_to_int(prestate#8), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$1^117.1, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager));
    // assert @writes_check(@_vcc_owns(@state, ListManager)); 
    assert (forall #writes$1^140.21: $ptr :: { $dont_instantiate(#writes$1^140.21) } $set_in(#writes$1^140.21, $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) ==> $top_writable($s, #wrTime$1^117.1, #writes$1^140.21));
    // stmt @_vcc_wrap(ListManager, @_vcc_typeof(ListManager)); 
    call $wrap($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), ^_SINGLE_LIST_MANAGER);
    assume $good_state_ext(#tok$1^140.21, $s);
    // assert @inv_check(forall(obj_t p; { @_vcc_set_in(p, @_vcc_owns(@state, ListManager)) } true; ==>(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), &&(@_vcc_is(p, @_vcc_typeof((struct _SINGLE_LIST_ENTRY*)@null)), &&(@_vcc_typed2(@state, p), unchecked!(@_vcc_is_ghost_ptr(p))))))); 
    assert (forall Q#p$1^54.31#tc1: $ptr :: { $set_in(Q#p$1^54.31#tc1, $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) } $set_in(Q#p$1^54.31#tc1, $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) ==> $is(Q#p$1^54.31#tc1, ^_SINGLE_LIST_ENTRY) && $typed2($s, Q#p$1^54.31#tc1, $typ(Q#p$1^54.31#tc1)) && !$is_ghost_ptr(Q#p$1^54.31#tc1));
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(p, @_vcc_owns(@state, ListManager)) } @in_range_phys_ptr((mathint)p); ==>(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_eq(*((p->Manager)), ListManager)))); 
    assert (forall Q#p$1^58.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) ==> $ptr_eq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)));
    // assert @inv_check(@_vcc_set_in(*((ListManager->ListHead)), @_vcc_owns(@state, ListManager))); 
    assert $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.ListHead), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)));
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager)) } { @trigger_hint(@_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager))) } @in_range_phys_ptr((mathint)p); ==>(&&(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_neq(*((p->Next)), @null)), &&(@_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager)), @_vcc_ptr_eq(*((*((p->Next))->Back)), p))))); 
    assert (forall Q#p$1^67.31#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) } { sk_hack($set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) && $ptr_neq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $null) ==> $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1)));
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(*((p->Back)), @_vcc_owns(@state, ListManager)) } { @trigger_hint(@_vcc_set_in(*((p->Back)), @_vcc_owns(@state, ListManager))) } @in_range_phys_ptr((mathint)p); ==>(&&(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_neq(*((p->Back)), @null)), &&(@_vcc_set_in(*((p->Back)), @_vcc_owns(@state, ListManager)), @_vcc_ptr_eq(*((*((p->Back))->Next)), p))))); 
    assert (forall Q#p$1^72.31#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) } { sk_hack($set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) && $ptr_neq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $null) ==> $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1)));
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(p, @_vcc_owns(@state, ListManager)) } { @trigger_hint(@_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager))) } @in_range_phys_ptr((mathint)p); ==>(&&(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_neq(*((p->Next)), @null)), ==(+(@map_get(*((ListManager->index)), p), 1), @map_get(*((ListManager->index)), *((p->Next))))))); 
    assert (forall Q#p$1^81.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) } { sk_hack($set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) && $ptr_neq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $null) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1))) + 1 == $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY))));
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((ListManager->ListHead))), 0)); 
    assert $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.ListHead), ^_SINGLE_LIST_ENTRY))) == 0;
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* e; { @_vcc_set_in(e, @_vcc_owns(@state, ListManager)) } @in_range_phys_ptr((mathint)e); ==>(@_vcc_set_in(e, @_vcc_owns(@state, ListManager)), &&(<=(0, @map_get(*((ListManager->index)), e)), <(@map_get(*((ListManager->index)), e), *((ListManager->size))))))); 
    assert (forall Q#e$1^88.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) ==> 0 <= $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1))) && $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1))) < $mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size)));
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* e1; struct _SINGLE_LIST_ENTRY* e2; { @_vcc_set_in(e1, @_vcc_owns(@state, ListManager)), @_vcc_set_in(e2, @_vcc_owns(@state, ListManager)) } &&(@in_range_phys_ptr((mathint)e1), @in_range_phys_ptr((mathint)e2)); ==>(&&(&&(@_vcc_set_in(e1, @_vcc_owns(@state, ListManager)), @_vcc_set_in(e2, @_vcc_owns(@state, ListManager))), @_vcc_ptr_neq(e1, e2)), !=(@map_get(*((ListManager->index)), e1), @map_get(*((ListManager->index)), e2))))); 
    assert (forall Q#e1$1^92.31#dt1: int, Q#e2$1^92.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))), $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1))) && $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) && $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) && $ptr_neq($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1), $ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1)) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1))) != $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure PopEntryList(P#ListHead: int) returns ($result: int);
  requires $set_in($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), $owns($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER)));
  requires $ptr_eq($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), _SINGLE_LIST_MANAGER.ListHead), ^_SINGLE_LIST_ENTRY));
  requires $closed($s, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead));
  requires $wrapped($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_MANAGER);
  modifies $s, $cev_pc;
  free ensures $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, $result)));
  ensures $mem(old($s), $dot($read_ptr(old($s), $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), _SINGLE_LIST_MANAGER.size)) == 1 ==> $ptr_eq($ptr(^_SINGLE_LIST_ENTRY, $result), $null);
  ensures $mem(old($s), $dot($read_ptr(old($s), $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), _SINGLE_LIST_MANAGER.size)) > 1 ==> $ptr_eq($ptr(^_SINGLE_LIST_ENTRY, $result), $read_ptr(old($s), $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY));
  ensures $ptr_eq($ptr(^_SINGLE_LIST_ENTRY, $result), $null) ==> $mem(old($s), $dot($read_ptr(old($s), $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), _SINGLE_LIST_MANAGER.size)) == $mem($s, $dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), _SINGLE_LIST_MANAGER.size));
  ensures $ptr_eq($ptr(^_SINGLE_LIST_ENTRY, $result), $null) ==> $set_eq($owns($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER)), $owns(old($s), $read_ptr(old($s), $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER)));
  ensures $ptr_neq($ptr(^_SINGLE_LIST_ENTRY, $result), $null) ==> $mem($s, $dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), _SINGLE_LIST_MANAGER.size)) == $mem(old($s), $dot($read_ptr(old($s), $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), _SINGLE_LIST_MANAGER.size)) - 1;
  ensures $ptr_neq($ptr(^_SINGLE_LIST_ENTRY, $result), $null) ==> $set_eq($owns($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER)), $set_difference($owns(old($s), $read_ptr(old($s), $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER)), $set_singleton($ptr(^_SINGLE_LIST_ENTRY, $result))));
  ensures $ptr_neq($ptr(^_SINGLE_LIST_ENTRY, $result), $null) ==> $wrapped($s, $ptr(^_SINGLE_LIST_ENTRY, $result), ^_SINGLE_LIST_ENTRY);
  ensures $wrapped($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_MANAGER);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $read_ptr(old($s), $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $read_ptr(old($s), $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $read_ptr(old($s), $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation PopEntryList(P#ListHead: int) returns ($result: int)
{
  var prestate#22: $state;
  var res_lambda#1#3: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4;
  var owns#20: $ptrset;
  var staticWrapState#19: $state;
  var prestate#21: $state;
  var owns#17: $ptrset;
  var staticWrapState#16: $state;
  var prestate#18: $state;
  var prestate#15: $state;
  var prestate#13: $state;
  var owns#14: $ptrset;
  var prestate#12: $state;
  var prestate#10: $state;
  var owns#11: $ptrset;
  var prestate#9: $state;
  var L#FirstEntry: int where $in_range_phys_ptr(L#FirstEntry);
  var SL#ListManager: int where $in_range_spec_ptr(SL#ListManager);
  var #wrTime$1^161.1: int;
  var #stackframe: int;

  anon13:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^161.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^161.1, #loc.ListHead, $ptr_to_int($ptr(^_SINGLE_LIST_ENTRY, P#ListHead)), $ptr_to(^_SINGLE_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$1^161.1, #loc.ListHead, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead), $ptr_to(^_SINGLE_LIST_ENTRY));
    assume #wrTime$1^161.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^161.1, #p) } $in_writes_at(#wrTime$1^161.1, #p) == (#p == $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER)));
    assume $thread_owned($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER));
    // assume @in_range_phys_ptr((mathint)ListHead); 
    assume $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, P#ListHead)));
    // assert @_vcc_in_domain(@state, *((ListHead->Manager)), *((ListHead->Manager))); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), l#public);
    // struct _SINGLE_LIST_MANAGER^ ListManager; 
    assume $local_value_is($s, #tok$1^176.27, #loc.ListManager, $ptr_to_int($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)), $spec_ptr_to(^_SINGLE_LIST_MANAGER)) && $local_value_is_ptr($s, #tok$1^176.27, #loc.ListManager, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), $spec_ptr_to(^_SINGLE_LIST_MANAGER));
    // struct _SINGLE_LIST_ENTRY* FirstEntry; 
    assume $local_value_is($s, #tok$1^175.5, #loc.FirstEntry, $ptr_to_int($ptr(^_SINGLE_LIST_ENTRY, L#FirstEntry)), $ptr_to(^_SINGLE_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$1^175.5, #loc.FirstEntry, $ptr(^_SINGLE_LIST_ENTRY, L#FirstEntry), $ptr_to(^_SINGLE_LIST_ENTRY));
    // var struct _SINGLE_LIST_ENTRY* FirstEntry
    // assert @reads_check_normal((ListHead->Manager)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), $spec_ptr_to(^_SINGLE_LIST_MANAGER));
    assert $thread_local2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), $spec_ptr_to(^_SINGLE_LIST_MANAGER));
    // ListManager := *((ListHead->Manager)); 
    SL#ListManager := $ref($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER));
    assume $local_value_is($s, #tok$1^176.27, #loc.ListManager, $ptr_to_int($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)), $spec_ptr_to(^_SINGLE_LIST_MANAGER)) && $local_value_is_ptr($s, #tok$1^176.27, #loc.ListManager, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), $spec_ptr_to(^_SINGLE_LIST_MANAGER));
    // assert @_vcc_in_domain(@state, ListHead, ListManager); 
    assert $in_domain_lab($s, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead), $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), l#public);
    // assume @_vcc_in_domain(@state, ListHead, ListManager); 
    assume $in_domain_lab($s, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead), $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), l#public);
    // assert ==>(@_vcc_ptr_neq(*((ListHead->Next)), @null), @_vcc_in_domain(@state, *((ListHead->Next)), ListManager)); 
    assert $ptr_neq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $null) ==> $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), l#public);
    // assume ==>(@_vcc_ptr_neq(*((ListHead->Next)), @null), @_vcc_in_domain(@state, *((ListHead->Next)), ListManager)); 
    assume $ptr_neq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $null) ==> $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), l#public);
    // assert @reads_check_normal((ListHead->Next)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), $ptr_to(^_SINGLE_LIST_ENTRY));
    assert $thread_local2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), $ptr_to(^_SINGLE_LIST_ENTRY));
    // FirstEntry := *((ListHead->Next)); 
    L#FirstEntry := $ref($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY));
    assume $local_value_is($s, #tok$1^181.5, #loc.FirstEntry, $ptr_to_int($ptr(^_SINGLE_LIST_ENTRY, L#FirstEntry)), $ptr_to(^_SINGLE_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$1^181.5, #loc.FirstEntry, $ptr(^_SINGLE_LIST_ENTRY, L#FirstEntry), $ptr_to(^_SINGLE_LIST_ENTRY));
    assume true;
    // if (@_vcc_ptr_neq(FirstEntry, @null)) ...
    if ($ptr_neq($ptr(^_SINGLE_LIST_ENTRY, L#FirstEntry), $null))
    {
      anon10:
        // assert >(*((ListManager->size)), 1); 
        assert $mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size)) > 1;
        // assume >(*((ListManager->size)), 1); 
        assume $mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size)) > 1;
        // assert ==>(@_vcc_ptr_neq(*((FirstEntry->Next)), @null), @_vcc_in_domain(@state, *((FirstEntry->Next)), ListManager)); 
        assert $ptr_neq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, L#FirstEntry), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $null) ==> $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, L#FirstEntry), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), l#public);
        // assume ==>(@_vcc_ptr_neq(*((FirstEntry->Next)), @null), @_vcc_in_domain(@state, *((FirstEntry->Next)), ListManager)); 
        assume $ptr_neq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, L#FirstEntry), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $null) ==> $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, L#FirstEntry), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), l#public);
        // _math state_t prestate#9; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#9, $state_to_int(prestate#9), ^$#state_t);
        // prestate#9 := @_vcc_current_state(@state); 
        prestate#9 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#9, $state_to_int(prestate#9), ^$#state_t);
        // assert @_vcc_wrapped(@state, ListManager); 
        assert $wrapped($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), ^_SINGLE_LIST_MANAGER);
        // assume @_vcc_inv(@state, ListManager); 
        assume $inv($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), ^_SINGLE_LIST_MANAGER);
        // assume @_vcc_pre_unwrap(@state); 
        assume $pre_unwrap($s);
        // assert @writes_check(ListManager); 
        assert $top_writable($s, #wrTime$1^161.1, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager));
        // stmt @_vcc_unwrap(ListManager, @_vcc_typeof(ListManager)); 
        call $unwrap($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), ^_SINGLE_LIST_MANAGER);
        assume $good_state_ext(#tok$1^186.36, $s);
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // _math ptrset owns#11; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#11, $ptrset_to_int(owns#11), ^$#ptrset);
        // owns#11 := @_vcc_set_empty; 
        owns#11 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#11, $ptrset_to_int(owns#11), ^$#ptrset);
        // _math state_t prestate#10; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#10, $state_to_int(prestate#10), ^$#state_t);
        // prestate#10 := @_vcc_current_state(@state); 
        prestate#10 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#10, $state_to_int(prestate#10), ^$#state_t);
        // _math state_t prestate#12; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#12, $state_to_int(prestate#12), ^$#state_t);
        // prestate#12 := @_vcc_current_state(@state); 
        prestate#12 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#12, $state_to_int(prestate#12), ^$#state_t);
        // assert @_vcc_wrapped(@state, ListHead); 
        assert $wrapped($s, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead), ^_SINGLE_LIST_ENTRY);
        // assert @writes_check(ListHead); 
        assert $top_writable($s, #wrTime$1^161.1, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead));
        // assume @_vcc_inv(@state, ListHead); 
        assume $inv($s, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead), ^_SINGLE_LIST_ENTRY);
        // assume ==(owns#11, @_vcc_owns(@state, ListHead)); 
        assume owns#11 == $owns($s, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead));
        // assume @_vcc_pre_static_unwrap(@state); 
        assume $pre_static_unwrap($s);
        // @_vcc_static_unwrap(pure(ListHead), prestate#12)
        call $static_unwrap($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), prestate#12);
        assume $good_state_ext(#tok$1^187.40, $s);
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // assert @_vcc_typed2(@state, (ListHead->Next)); 
        assert $typed2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), $ptr_to(^_SINGLE_LIST_ENTRY));
        // assert @prim_writes_check((ListHead->Next)); 
        assert $writable($s, #wrTime$1^161.1, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next));
        // assert @reads_check_normal((FirstEntry->Next)); 
        assert $typed2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, L#FirstEntry), _SINGLE_LIST_ENTRY.Next), $ptr_to(^_SINGLE_LIST_ENTRY));
        assert $thread_local2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, L#FirstEntry), _SINGLE_LIST_ENTRY.Next), $ptr_to(^_SINGLE_LIST_ENTRY));
        // *(ListHead->Next) := *((FirstEntry->Next)); 
        call $write_int($dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), $ref($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, L#FirstEntry), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY)));
        assume $full_stop_ext(#tok$1^188.17, $s);
        // assert @reads_check_normal((ListHead->Next)); 
        assert $typed2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), $ptr_to(^_SINGLE_LIST_ENTRY));
        assert $thread_local2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), $ptr_to(^_SINGLE_LIST_ENTRY));
        assume true;
        // if (@_vcc_ptr_neq(*((ListHead->Next)), @null)) ...
        if ($ptr_neq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $null))
        {
          anon8:
            // _math ptrset owns#14; 
            assume $local_value_is($s, #tok$2^0.0, #loc.owns#14, $ptrset_to_int(owns#14), ^$#ptrset);
            // owns#14 := @_vcc_set_empty; 
            owns#14 := $set_empty();
            assume $local_value_is($s, #tok$2^0.0, #loc.owns#14, $ptrset_to_int(owns#14), ^$#ptrset);
            // _math state_t prestate#13; 
            assume $local_value_is($s, #tok$2^0.0, #loc.prestate#13, $state_to_int(prestate#13), ^$#state_t);
            // prestate#13 := @_vcc_current_state(@state); 
            prestate#13 := $current_state($s);
            assume $local_value_is($s, #tok$2^0.0, #loc.prestate#13, $state_to_int(prestate#13), ^$#state_t);
            // _math state_t prestate#15; 
            assume $local_value_is($s, #tok$2^0.0, #loc.prestate#15, $state_to_int(prestate#15), ^$#state_t);
            // prestate#15 := @_vcc_current_state(@state); 
            prestate#15 := $current_state($s);
            assume $local_value_is($s, #tok$2^0.0, #loc.prestate#15, $state_to_int(prestate#15), ^$#state_t);
            // assert @_vcc_wrapped(@state, *((ListHead->Next))); 
            assert $wrapped($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY);
            // assert @writes_check(*((ListHead->Next))); 
            assert $top_writable($s, #wrTime$1^161.1, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY));
            // assume @_vcc_inv(@state, *((ListHead->Next))); 
            assume $inv($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY);
            // assume ==(owns#14, @_vcc_owns(@state, *((ListHead->Next)))); 
            assume owns#14 == $owns($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY));
            // assume @_vcc_pre_static_unwrap(@state); 
            assume $pre_static_unwrap($s);
            // @_vcc_static_unwrap(pure(*((ListHead->Next))), prestate#15)
            call $static_unwrap($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), prestate#15);
            assume $good_state_ext(#tok$1^191.48, $s);
            // assume @_vcc_full_stop(@state); 
            assume $full_stop($s);
            // assert @_vcc_typed2(@state, (*((ListHead->Next))->Back)); 
            assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Back), $ptr_to(^_SINGLE_LIST_ENTRY));
            // assert @prim_writes_check((*((ListHead->Next))->Back)); 
            assert $writable($s, #wrTime$1^161.1, $dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Back));
            // assert @reads_check_normal((ListHead->Next)); 
            assert $typed2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), $ptr_to(^_SINGLE_LIST_ENTRY));
            assert $thread_local2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), $ptr_to(^_SINGLE_LIST_ENTRY));
            // *(*((ListHead->Next))->Back) := ListHead; 
            call $write_int($dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Back), $ref($ptr(^_SINGLE_LIST_ENTRY, P#ListHead)));
            assume $full_stop_ext(#tok$1^192.25, $s);
            // _math state_t prestate#18; 
            assume $local_value_is($s, #tok$2^0.0, #loc.prestate#18, $state_to_int(prestate#18), ^$#state_t);
            // prestate#18 := @_vcc_current_state(@state); 
            prestate#18 := $current_state($s);
            assume $local_value_is($s, #tok$2^0.0, #loc.prestate#18, $state_to_int(prestate#18), ^$#state_t);
            // _math state_t staticWrapState#16; 
            assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#16, $state_to_int(staticWrapState#16), ^$#state_t);
            // staticWrapState#16 := @_vcc_current_state(@state); 
            staticWrapState#16 := $current_state($s);
            assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#16, $state_to_int(staticWrapState#16), ^$#state_t);
            // _math ptrset owns#17; 
            assume $local_value_is($s, #tok$2^0.0, #loc.owns#17, $ptrset_to_int(owns#17), ^$#ptrset);
            // owns#17 := @_vcc_set_empty; 
            owns#17 := $set_empty();
            assume $local_value_is($s, #tok$2^0.0, #loc.owns#17, $ptrset_to_int(owns#17), ^$#ptrset);
            // assert @writes_check(*((ListHead->Next))); 
            assert $top_writable($s, #wrTime$1^161.1, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY));
            // assume @_vcc_pre_static_wrap(@state); 
            assume $pre_static_wrap($s);
            // @_vcc_static_wrap(pure(*((ListHead->Next))), staticWrapState#16, owns#17)
            call $static_wrap($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), staticWrapState#16, owns#17);
            assume $good_state_ext(#tok$1^191.48, $s);
            // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((ListHead->Next))), @_vcc_set_empty)); 
            assert $set_eq($owns($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY)), $set_empty());
            // assume @_vcc_full_stop(@state); 
            assume $full_stop($s);
        }
        else
        {
          anon9:
            // empty
        }

      anon11:
        // _math state_t prestate#21; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#21, $state_to_int(prestate#21), ^$#state_t);
        // prestate#21 := @_vcc_current_state(@state); 
        prestate#21 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#21, $state_to_int(prestate#21), ^$#state_t);
        // _math state_t staticWrapState#19; 
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#19, $state_to_int(staticWrapState#19), ^$#state_t);
        // staticWrapState#19 := @_vcc_current_state(@state); 
        staticWrapState#19 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#19, $state_to_int(staticWrapState#19), ^$#state_t);
        // _math ptrset owns#20; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#20, $ptrset_to_int(owns#20), ^$#ptrset);
        // owns#20 := @_vcc_set_empty; 
        owns#20 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#20, $ptrset_to_int(owns#20), ^$#ptrset);
        // assert @writes_check(ListHead); 
        assert $top_writable($s, #wrTime$1^161.1, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(ListHead), staticWrapState#19, owns#20)
        call $static_wrap($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), staticWrapState#19, owns#20);
        assume $good_state_ext(#tok$1^187.40, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, ListHead), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead)), $set_empty());
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // assert @_vcc_typed2(@state, (ListManager->size)); 
        assert $typed2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size), ^^u4);
        // assert @prim_writes_check((ListManager->size)); 
        assert $writable($s, #wrTime$1^161.1, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size));
        // assert @in_range_u4(-(*((ListManager->size)), 1)); 
        assert $in_range_u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size)) - 1);
        // assert @reads_check_normal((ListManager->size)); 
        assert $typed2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size), ^^u4);
        assert $thread_local2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size), ^^u4);
        // *(ListManager->size) := -(*((ListManager->size)), 1); 
        call $write_int($dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size), $mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size)) - 1);
        assume $full_stop_ext(#tok$1^197.13, $s);
        // assert @_vcc_set_in(FirstEntry, @_vcc_owns(@state, ListManager)); 
        assert $set_in($ptr(^_SINGLE_LIST_ENTRY, L#FirstEntry), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)));
        // assume @_vcc_set_in(FirstEntry, @_vcc_owns(@state, ListManager)); 
        assume $set_in($ptr(^_SINGLE_LIST_ENTRY, L#FirstEntry), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)));
        // assert @writes_check(@_vcc_span(ListManager)); 
        assert (forall #writes$1^198.35: $ptr :: { $dont_instantiate(#writes$1^198.35) } $set_in(#writes$1^198.35, $span($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) ==> $top_writable($s, #wrTime$1^161.1, #writes$1^198.35));
        // stmt _vcc_set_owns(ListManager, @_vcc_set_remove_element(@_vcc_owns(@state, ListManager), FirstEntry)); 
        call $set_owns($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), $set_remove_element($owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)), $ptr(^_SINGLE_LIST_ENTRY, L#FirstEntry)));
        assume $full_stop_ext(#tok$1^198.35, $s);
        // empty
        // (struct _SINGLE_LIST_ENTRY* -> uint32_t) res_lambda#1#3; 
        assume $local_value_is($s, #tok$1^199.35, #loc.res_lambda#1#3, $map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4_to_int(res_lambda#1#3), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
        // assert @reads_check_normal((ListManager->index)); 
        assert $typed2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
        assert $thread_local2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
        // res_lambda#1#3 := lambda#1(*((ListManager->index)), ListHead); 
        call res_lambda#1#3 := lambda#1($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, P#ListHead)));
        assume $full_stop_ext(#tok$1^199.35, $s);
        assume $local_value_is($s, #tok$1^199.35, #loc.res_lambda#1#3, $map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4_to_int(res_lambda#1#3), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
        // assert @_vcc_typed2(@state, (ListManager->index)); 
        assert $typed2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
        // assert @prim_writes_check((ListManager->index)); 
        assert $writable($s, #wrTime$1^161.1, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index));
        // *(ListManager->index) := res_lambda#1#3; 
        call $write_int($dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index), $map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4_to_int(res_lambda#1#3));
        assume $full_stop_ext(#tok$1^199.13, $s);
        // assert >(old(@prestate, *((ListManager->size))), 0); 
        assert $mem(old($s), $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size)) > 0;
        // assume >(old(@prestate, *((ListManager->size))), 0); 
        assume $mem(old($s), $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size)) > 0;
        // assert ==(*((ListManager->size)), -(old(@prestate, *((ListManager->size))), 1)); 
        assert $mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size)) == $mem(old($s), $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size)) - 1;
        // assume ==(*((ListManager->size)), -(old(@prestate, *((ListManager->size))), 1)); 
        assume $mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size)) == $mem(old($s), $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size)) - 1;
        // _math state_t prestate#22; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#22, $state_to_int(prestate#22), ^$#state_t);
        // prestate#22 := @_vcc_current_state(@state); 
        prestate#22 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#22, $state_to_int(prestate#22), ^$#state_t);
        // assume @_vcc_pre_wrap(@state); 
        assume $pre_wrap($s);
        // assert @writes_check(ListManager); 
        assert $top_writable($s, #wrTime$1^161.1, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager));
        // assert @writes_check(@_vcc_owns(@state, ListManager)); 
        assert (forall #writes$1^186.36: $ptr :: { $dont_instantiate(#writes$1^186.36) } $set_in(#writes$1^186.36, $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) ==> $top_writable($s, #wrTime$1^161.1, #writes$1^186.36));
        // stmt @_vcc_wrap(ListManager, @_vcc_typeof(ListManager)); 
        call $wrap($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), ^_SINGLE_LIST_MANAGER);
        assume $good_state_ext(#tok$1^186.36, $s);
        // assert @inv_check(forall(obj_t p; { @_vcc_set_in(p, @_vcc_owns(@state, ListManager)) } true; ==>(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), &&(@_vcc_is(p, @_vcc_typeof((struct _SINGLE_LIST_ENTRY*)@null)), &&(@_vcc_typed2(@state, p), unchecked!(@_vcc_is_ghost_ptr(p))))))); 
        assert (forall Q#p$1^54.31#tc1: $ptr :: { $set_in(Q#p$1^54.31#tc1, $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) } $set_in(Q#p$1^54.31#tc1, $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) ==> $is(Q#p$1^54.31#tc1, ^_SINGLE_LIST_ENTRY) && $typed2($s, Q#p$1^54.31#tc1, $typ(Q#p$1^54.31#tc1)) && !$is_ghost_ptr(Q#p$1^54.31#tc1));
        // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(p, @_vcc_owns(@state, ListManager)) } @in_range_phys_ptr((mathint)p); ==>(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_eq(*((p->Manager)), ListManager)))); 
        assert (forall Q#p$1^58.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) ==> $ptr_eq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)));
        // assert @inv_check(@_vcc_set_in(*((ListManager->ListHead)), @_vcc_owns(@state, ListManager))); 
        assert $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.ListHead), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)));
        // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager)) } { @trigger_hint(@_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager))) } @in_range_phys_ptr((mathint)p); ==>(&&(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_neq(*((p->Next)), @null)), &&(@_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager)), @_vcc_ptr_eq(*((*((p->Next))->Back)), p))))); 
        assert (forall Q#p$1^67.31#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) } { sk_hack($set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) && $ptr_neq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $null) ==> $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1)));
        // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(*((p->Back)), @_vcc_owns(@state, ListManager)) } { @trigger_hint(@_vcc_set_in(*((p->Back)), @_vcc_owns(@state, ListManager))) } @in_range_phys_ptr((mathint)p); ==>(&&(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_neq(*((p->Back)), @null)), &&(@_vcc_set_in(*((p->Back)), @_vcc_owns(@state, ListManager)), @_vcc_ptr_eq(*((*((p->Back))->Next)), p))))); 
        assert (forall Q#p$1^72.31#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) } { sk_hack($set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) && $ptr_neq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $null) ==> $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1)));
        // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(p, @_vcc_owns(@state, ListManager)) } { @trigger_hint(@_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager))) } @in_range_phys_ptr((mathint)p); ==>(&&(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_neq(*((p->Next)), @null)), ==(+(@map_get(*((ListManager->index)), p), 1), @map_get(*((ListManager->index)), *((p->Next))))))); 
        assert (forall Q#p$1^81.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) } { sk_hack($set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) && $ptr_neq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $null) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1))) + 1 == $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY))));
        // assert @inv_check(==(@map_get(*((ListManager->index)), *((ListManager->ListHead))), 0)); 
        assert $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.ListHead), ^_SINGLE_LIST_ENTRY))) == 0;
        // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* e; { @_vcc_set_in(e, @_vcc_owns(@state, ListManager)) } @in_range_phys_ptr((mathint)e); ==>(@_vcc_set_in(e, @_vcc_owns(@state, ListManager)), &&(<=(0, @map_get(*((ListManager->index)), e)), <(@map_get(*((ListManager->index)), e), *((ListManager->size))))))); 
        assert (forall Q#e$1^88.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) ==> 0 <= $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1))) && $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1))) < $mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size)));
        // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* e1; struct _SINGLE_LIST_ENTRY* e2; { @_vcc_set_in(e1, @_vcc_owns(@state, ListManager)), @_vcc_set_in(e2, @_vcc_owns(@state, ListManager)) } &&(@in_range_phys_ptr((mathint)e1), @in_range_phys_ptr((mathint)e2)); ==>(&&(&&(@_vcc_set_in(e1, @_vcc_owns(@state, ListManager)), @_vcc_set_in(e2, @_vcc_owns(@state, ListManager))), @_vcc_ptr_neq(e1, e2)), !=(@map_get(*((ListManager->index)), e1), @map_get(*((ListManager->index)), e2))))); 
        assert (forall Q#e1$1^92.31#dt1: int, Q#e2$1^92.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))), $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1))) && $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) && $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) && $ptr_neq($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1), $ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1)) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1))) != $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1))));
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
    }
    else
    {
      anon12:
        // empty
    }

  anon14:
    // return FirstEntry; 
    $result := $ref($ptr(^_SINGLE_LIST_ENTRY, L#FirstEntry));
    assert $position_marker();
    goto #exit;

  anon15:
    // empty

  #exit:
}



procedure PushEntryList(P#ListHead: int, P#Entry: int);
  requires $ptr_eq($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), _SINGLE_LIST_MANAGER.ListHead), ^_SINGLE_LIST_ENTRY));
  requires $mutable($s, $ptr(^_SINGLE_LIST_ENTRY, P#Entry));
  requires $mem($s, $dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), _SINGLE_LIST_MANAGER.size)) < 2147483647;
  requires $wrapped($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_MANAGER);
  requires $set_in($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), $owns($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER)));
  modifies $s, $cev_pc;
  ensures $set_in($ptr(^_SINGLE_LIST_ENTRY, P#Entry), $owns($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER)));
  ensures $mem($s, $dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), _SINGLE_LIST_MANAGER.size)) == $mem(old($s), $dot($read_ptr(old($s), $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), _SINGLE_LIST_MANAGER.size)) + 1;
  ensures $set_eq($owns($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER)), $set_union($owns(old($s), $read_ptr(old($s), $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER)), $set_singleton($ptr(^_SINGLE_LIST_ENTRY, P#Entry)))) && $set_in($ptr(^_SINGLE_LIST_ENTRY, P#Entry), $owns($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER)));
  ensures $wrapped($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_MANAGER);
  ensures $set_in($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), $owns($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER)));
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $read_ptr(old($s), $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER) || $set_in(#p, $extent(old($s), $ptr(^_SINGLE_LIST_ENTRY, P#Entry))) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $read_ptr(old($s), $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER) || $set_in(#p, $extent(old($s), $ptr(^_SINGLE_LIST_ENTRY, P#Entry))) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $read_ptr(old($s), $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER) || $set_in(#p, $extent(old($s), $ptr(^_SINGLE_LIST_ENTRY, P#Entry))) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation PushEntryList(P#ListHead: int, P#Entry: int)
{
  var prestate#39: $state;
  var res_lambda#2#4: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4;
  var owns#37: $ptrset;
  var staticWrapState#36: $state;
  var prestate#38: $state;
  var prestate#35: $state;
  var prestate#33: $state;
  var owns#34: $ptrset;
  var owns#31: $ptrset;
  var staticWrapState#30: $state;
  var prestate#32: $state;
  var prestate#29: $state;
  var prestate#27: $state;
  var owns#28: $ptrset;
  var owns#25: $ptrset;
  var staticWrapState#24: $state;
  var prestate#26: $state;
  var prestate#23: $state;
  var SL#ListManager: int where $in_range_spec_ptr(SL#ListManager);
  var #wrTime$1^224.1: int;
  var #stackframe: int;

  anon18:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^224.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^224.1, #loc.ListHead, $ptr_to_int($ptr(^_SINGLE_LIST_ENTRY, P#ListHead)), $ptr_to(^_SINGLE_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$1^224.1, #loc.ListHead, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead), $ptr_to(^_SINGLE_LIST_ENTRY));
    assume $local_value_is($s, #tok$1^224.1, #loc.Entry, $ptr_to_int($ptr(^_SINGLE_LIST_ENTRY, P#Entry)), $ptr_to(^_SINGLE_LIST_ENTRY)) && $local_value_is_ptr($s, #tok$1^224.1, #loc.Entry, $ptr(^_SINGLE_LIST_ENTRY, P#Entry), $ptr_to(^_SINGLE_LIST_ENTRY));
    assume #wrTime$1^224.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^224.1, #p) } $in_writes_at(#wrTime$1^224.1, #p) == (#p == $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER) || $set_in(#p, $extent($s, $ptr(^_SINGLE_LIST_ENTRY, P#Entry)))));
    assume $thread_owned($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER));
    assume (forall #p: $ptr :: { $extent_hint(#p, $ptr(^_SINGLE_LIST_ENTRY, P#Entry)) } $set_in(#p, $extent($s, $ptr(^_SINGLE_LIST_ENTRY, P#Entry))) ==> $mutable($s, #p));
    // assume @in_range_phys_ptr((mathint)ListHead); 
    assume $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, P#ListHead)));
    // assume @in_range_phys_ptr((mathint)Entry); 
    assume $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, P#Entry)));
    // assert @_vcc_in_domain(@state, *((ListHead->Manager)), *((ListHead->Manager))); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), l#public);
    // struct _SINGLE_LIST_MANAGER^ ListManager; 
    assume $local_value_is($s, #tok$1^236.27, #loc.ListManager, $ptr_to_int($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)), $spec_ptr_to(^_SINGLE_LIST_MANAGER)) && $local_value_is_ptr($s, #tok$1^236.27, #loc.ListManager, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), $spec_ptr_to(^_SINGLE_LIST_MANAGER));
    // assert @reads_check_normal((ListHead->Manager)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), $spec_ptr_to(^_SINGLE_LIST_MANAGER));
    assert $thread_local2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), $spec_ptr_to(^_SINGLE_LIST_MANAGER));
    // ListManager := *((ListHead->Manager)); 
    SL#ListManager := $ref($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER));
    assume $local_value_is($s, #tok$1^236.27, #loc.ListManager, $ptr_to_int($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)), $spec_ptr_to(^_SINGLE_LIST_MANAGER)) && $local_value_is_ptr($s, #tok$1^236.27, #loc.ListManager, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), $spec_ptr_to(^_SINGLE_LIST_MANAGER));
    // assert @_vcc_in_domain(@state, ListHead, ListManager); 
    assert $in_domain_lab($s, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead), $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), l#public);
    // assume @_vcc_in_domain(@state, ListHead, ListManager); 
    assume $in_domain_lab($s, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead), $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), l#public);
    // assert ==>(@_vcc_ptr_neq(*((ListHead->Next)), @null), @_vcc_in_domain(@state, *((ListHead->Next)), ListManager)); 
    assert $ptr_neq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $null) ==> $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), l#public);
    // assume ==>(@_vcc_ptr_neq(*((ListHead->Next)), @null), @_vcc_in_domain(@state, *((ListHead->Next)), ListManager)); 
    assume $ptr_neq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $null) ==> $in_domain_lab($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), l#public);
    // _math state_t prestate#23; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#23, $state_to_int(prestate#23), ^$#state_t);
    // prestate#23 := @_vcc_current_state(@state); 
    prestate#23 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#23, $state_to_int(prestate#23), ^$#state_t);
    // assert @_vcc_wrapped(@state, ListManager); 
    assert $wrapped($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), ^_SINGLE_LIST_MANAGER);
    // assume @_vcc_inv(@state, ListManager); 
    assume $inv($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), ^_SINGLE_LIST_MANAGER);
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$1^224.1, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager));
    // stmt @_vcc_unwrap(ListManager, @_vcc_typeof(ListManager)); 
    call $unwrap($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), ^_SINGLE_LIST_MANAGER);
    assume $good_state_ext(#tok$1^243.32, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (Entry->Next)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Next), $ptr_to(^_SINGLE_LIST_ENTRY));
    // assert @prim_writes_check((Entry->Next)); 
    assert $writable($s, #wrTime$1^224.1, $dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Next));
    // assert @reads_check_normal((ListHead->Next)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), $ptr_to(^_SINGLE_LIST_ENTRY));
    assert $thread_local2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), $ptr_to(^_SINGLE_LIST_ENTRY));
    // *(Entry->Next) := *((ListHead->Next)); 
    call $write_int($dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Next), $ref($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY)));
    assume $full_stop_ext(#tok$1^244.9, $s);
    // assert @writes_check(@_vcc_span(Entry)); 
    assert (forall #writes$1^247.31: $ptr :: { $dont_instantiate(#writes$1^247.31) } $set_in(#writes$1^247.31, $span($ptr(^_SINGLE_LIST_ENTRY, P#Entry))) ==> $top_writable($s, #wrTime$1^224.1, #writes$1^247.31));
    // stmt _vcc_set_owns(Entry, @_vcc_set_empty); 
    call $set_owns($ptr(^_SINGLE_LIST_ENTRY, P#Entry), $set_empty());
    assume $full_stop_ext(#tok$1^247.31, $s);
    // empty
    // assert @_vcc_typed2(@state, (Entry->Back)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Back), $ptr_to(^_SINGLE_LIST_ENTRY));
    // assert @prim_writes_check((Entry->Back)); 
    assert $writable($s, #wrTime$1^224.1, $dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Back));
    // *(Entry->Back) := ListHead; 
    call $write_int($dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Back), $ref($ptr(^_SINGLE_LIST_ENTRY, P#ListHead)));
    assume $full_stop_ext(#tok$1^248.9, $s);
    // assert @_vcc_typed2(@state, (Entry->Manager)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Manager), $spec_ptr_to(^_SINGLE_LIST_MANAGER));
    // assert @prim_writes_check((Entry->Manager)); 
    assert $writable($s, #wrTime$1^224.1, $dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Manager));
    // *(Entry->Manager) := ListManager; 
    call $write_int($dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Manager), $ref($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)));
    assume $full_stop_ext(#tok$1^249.9, $s);
    // _math state_t prestate#26; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#26, $state_to_int(prestate#26), ^$#state_t);
    // prestate#26 := @_vcc_current_state(@state); 
    prestate#26 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#26, $state_to_int(prestate#26), ^$#state_t);
    // _math state_t staticWrapState#24; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#24, $state_to_int(staticWrapState#24), ^$#state_t);
    // staticWrapState#24 := @_vcc_current_state(@state); 
    staticWrapState#24 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#24, $state_to_int(staticWrapState#24), ^$#state_t);
    // _math ptrset owns#25; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#25, $ptrset_to_int(owns#25), ^$#ptrset);
    // owns#25 := @_vcc_set_empty; 
    owns#25 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#25, $ptrset_to_int(owns#25), ^$#ptrset);
    // assert @writes_check(Entry); 
    assert $top_writable($s, #wrTime$1^224.1, $ptr(^_SINGLE_LIST_ENTRY, P#Entry));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(Entry), staticWrapState#24, owns#25)
    call $static_wrap($ptr(^_SINGLE_LIST_ENTRY, P#Entry), staticWrapState#24, owns#25);
    assume $good_state_ext(#tok$1^250.25, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, Entry), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^_SINGLE_LIST_ENTRY, P#Entry)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @reads_check_normal((Entry->Next)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Next), $ptr_to(^_SINGLE_LIST_ENTRY));
    assert $thread_local2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Next), $ptr_to(^_SINGLE_LIST_ENTRY));
    assume true;
    // if (@_vcc_ptr_neq(*((Entry->Next)), @null)) ...
    if ($ptr_neq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $null))
    {
      anon16:
        // _math ptrset owns#28; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#28, $ptrset_to_int(owns#28), ^$#ptrset);
        // owns#28 := @_vcc_set_empty; 
        owns#28 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#28, $ptrset_to_int(owns#28), ^$#ptrset);
        // _math state_t prestate#27; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
        // prestate#27 := @_vcc_current_state(@state); 
        prestate#27 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
        // _math state_t prestate#29; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#29, $state_to_int(prestate#29), ^$#state_t);
        // prestate#29 := @_vcc_current_state(@state); 
        prestate#29 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#29, $state_to_int(prestate#29), ^$#state_t);
        // assert @_vcc_wrapped(@state, *((Entry->Next))); 
        assert $wrapped($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY);
        // assert @writes_check(*((Entry->Next))); 
        assert $top_writable($s, #wrTime$1^224.1, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY));
        // assume @_vcc_inv(@state, *((Entry->Next))); 
        assume $inv($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY);
        // assume ==(owns#28, @_vcc_owns(@state, *((Entry->Next)))); 
        assume owns#28 == $owns($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY));
        // assume @_vcc_pre_static_unwrap(@state); 
        assume $pre_static_unwrap($s);
        // @_vcc_static_unwrap(pure(*((Entry->Next))), prestate#29)
        call $static_unwrap($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), prestate#29);
        assume $good_state_ext(#tok$1^253.40, $s);
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // assert @_vcc_typed2(@state, (*((Entry->Next))->Back)); 
        assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Back), $ptr_to(^_SINGLE_LIST_ENTRY));
        // assert @prim_writes_check((*((Entry->Next))->Back)); 
        assert $writable($s, #wrTime$1^224.1, $dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Back));
        // assert @reads_check_normal((Entry->Next)); 
        assert $typed2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Next), $ptr_to(^_SINGLE_LIST_ENTRY));
        assert $thread_local2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Next), $ptr_to(^_SINGLE_LIST_ENTRY));
        // *(*((Entry->Next))->Back) := Entry; 
        call $write_int($dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Back), $ref($ptr(^_SINGLE_LIST_ENTRY, P#Entry)));
        assume $full_stop_ext(#tok$1^254.17, $s);
        // _math state_t prestate#32; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#32, $state_to_int(prestate#32), ^$#state_t);
        // prestate#32 := @_vcc_current_state(@state); 
        prestate#32 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#32, $state_to_int(prestate#32), ^$#state_t);
        // _math state_t staticWrapState#30; 
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#30, $state_to_int(staticWrapState#30), ^$#state_t);
        // staticWrapState#30 := @_vcc_current_state(@state); 
        staticWrapState#30 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#30, $state_to_int(staticWrapState#30), ^$#state_t);
        // _math ptrset owns#31; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#31, $ptrset_to_int(owns#31), ^$#ptrset);
        // owns#31 := @_vcc_set_empty; 
        owns#31 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#31, $ptrset_to_int(owns#31), ^$#ptrset);
        // assert @writes_check(*((Entry->Next))); 
        assert $top_writable($s, #wrTime$1^224.1, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(*((Entry->Next))), staticWrapState#30, owns#31)
        call $static_wrap($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), staticWrapState#30, owns#31);
        assume $good_state_ext(#tok$1^253.40, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((Entry->Next))), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#Entry), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY)), $set_empty());
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
    }
    else
    {
      anon17:
        // empty
    }

  anon19:
    // _math ptrset owns#34; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#34, $ptrset_to_int(owns#34), ^$#ptrset);
    // owns#34 := @_vcc_set_empty; 
    owns#34 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#34, $ptrset_to_int(owns#34), ^$#ptrset);
    // _math state_t prestate#33; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#33, $state_to_int(prestate#33), ^$#state_t);
    // prestate#33 := @_vcc_current_state(@state); 
    prestate#33 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#33, $state_to_int(prestate#33), ^$#state_t);
    // _math state_t prestate#35; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#35, $state_to_int(prestate#35), ^$#state_t);
    // prestate#35 := @_vcc_current_state(@state); 
    prestate#35 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#35, $state_to_int(prestate#35), ^$#state_t);
    // assert @_vcc_wrapped(@state, ListHead); 
    assert $wrapped($s, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead), ^_SINGLE_LIST_ENTRY);
    // assert @writes_check(ListHead); 
    assert $top_writable($s, #wrTime$1^224.1, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead));
    // assume @_vcc_inv(@state, ListHead); 
    assume $inv($s, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead), ^_SINGLE_LIST_ENTRY);
    // assume ==(owns#34, @_vcc_owns(@state, ListHead)); 
    assume owns#34 == $owns($s, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(ListHead), prestate#35)
    call $static_unwrap($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), prestate#35);
    assume $good_state_ext(#tok$1^258.36, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (ListHead->Next)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), $ptr_to(^_SINGLE_LIST_ENTRY));
    // assert @prim_writes_check((ListHead->Next)); 
    assert $writable($s, #wrTime$1^224.1, $dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next));
    // *(ListHead->Next) := Entry; 
    call $write_int($dot($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), _SINGLE_LIST_ENTRY.Next), $ref($ptr(^_SINGLE_LIST_ENTRY, P#Entry)));
    assume $full_stop_ext(#tok$1^259.13, $s);
    // _math state_t prestate#38; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#38, $state_to_int(prestate#38), ^$#state_t);
    // prestate#38 := @_vcc_current_state(@state); 
    prestate#38 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#38, $state_to_int(prestate#38), ^$#state_t);
    // _math state_t staticWrapState#36; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#36, $state_to_int(staticWrapState#36), ^$#state_t);
    // staticWrapState#36 := @_vcc_current_state(@state); 
    staticWrapState#36 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#36, $state_to_int(staticWrapState#36), ^$#state_t);
    // _math ptrset owns#37; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#37, $ptrset_to_int(owns#37), ^$#ptrset);
    // owns#37 := @_vcc_set_empty; 
    owns#37 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#37, $ptrset_to_int(owns#37), ^$#ptrset);
    // assert @writes_check(ListHead); 
    assert $top_writable($s, #wrTime$1^224.1, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(ListHead), staticWrapState#36, owns#37)
    call $static_wrap($ptr(^_SINGLE_LIST_ENTRY, P#ListHead), staticWrapState#36, owns#37);
    assume $good_state_ext(#tok$1^258.36, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, ListHead), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^_SINGLE_LIST_ENTRY, P#ListHead)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (ListManager->size)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size), ^^u4);
    // assert @prim_writes_check((ListManager->size)); 
    assert $writable($s, #wrTime$1^224.1, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size));
    // assert @in_range_u4(+(*((ListManager->size)), 1)); 
    assert $in_range_u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size)) + 1);
    // assert @reads_check_normal((ListManager->size)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size), ^^u4);
    assert $thread_local2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size), ^^u4);
    // *(ListManager->size) := +(*((ListManager->size)), 1); 
    call $write_int($dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size), $mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size)) + 1);
    assume $full_stop_ext(#tok$1^263.9, $s);
    // assert @writes_check(@_vcc_span(ListManager)); 
    assert (forall #writes$1^264.31: $ptr :: { $dont_instantiate(#writes$1^264.31) } $set_in(#writes$1^264.31, $span($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) ==> $top_writable($s, #wrTime$1^224.1, #writes$1^264.31));
    // stmt _vcc_set_owns(ListManager, @_vcc_set_add_element(@_vcc_owns(@state, ListManager), Entry)); 
    call $set_owns($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), $set_add_element($owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)), $ptr(^_SINGLE_LIST_ENTRY, P#Entry)));
    assume $full_stop_ext(#tok$1^264.31, $s);
    // empty
    // (struct _SINGLE_LIST_ENTRY* -> uint32_t) res_lambda#2#4; 
    assume $local_value_is($s, #tok$1^265.31, #loc.res_lambda#2#4, $map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4_to_int(res_lambda#2#4), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
    // assert @in_range_u4(+(@map_get(*((ListManager->index)), ListHead), 1)); 
    assert $in_range_u4($select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, P#ListHead))) + 1);
    // assert @reads_check_normal((ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
    assert $thread_local2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
    // res_lambda#2#4 := lambda#2(*((ListManager->index)), *((ListManager->index)), @map_get(*((ListManager->index)), ListHead), *((ListManager->index)), +(@map_get(*((ListManager->index)), ListHead), 1), Entry); 
    call res_lambda#2#4 := lambda#2($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, P#ListHead))), $int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, P#ListHead))) + 1, $ref($ptr(^_SINGLE_LIST_ENTRY, P#Entry)));
    assume $full_stop_ext(#tok$1^265.31, $s);
    assume $local_value_is($s, #tok$1^265.31, #loc.res_lambda#2#4, $map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4_to_int(res_lambda#2#4), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
    // assert @_vcc_typed2(@state, (ListManager->index)); 
    assert $typed2($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
    // assert @prim_writes_check((ListManager->index)); 
    assert $writable($s, #wrTime$1^224.1, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index));
    // *(ListManager->index) := res_lambda#2#4; 
    call $write_int($dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index), $map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4_to_int(res_lambda#2#4));
    assume $full_stop_ext(#tok$1^265.9, $s);
    // _math state_t prestate#39; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#39, $state_to_int(prestate#39), ^$#state_t);
    // prestate#39 := @_vcc_current_state(@state); 
    prestate#39 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#39, $state_to_int(prestate#39), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$1^224.1, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager));
    // assert @writes_check(@_vcc_owns(@state, ListManager)); 
    assert (forall #writes$1^243.32: $ptr :: { $dont_instantiate(#writes$1^243.32) } $set_in(#writes$1^243.32, $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) ==> $top_writable($s, #wrTime$1^224.1, #writes$1^243.32));
    // stmt @_vcc_wrap(ListManager, @_vcc_typeof(ListManager)); 
    call $wrap($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), ^_SINGLE_LIST_MANAGER);
    assume $good_state_ext(#tok$1^243.32, $s);
    // assert @inv_check(forall(obj_t p; { @_vcc_set_in(p, @_vcc_owns(@state, ListManager)) } true; ==>(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), &&(@_vcc_is(p, @_vcc_typeof((struct _SINGLE_LIST_ENTRY*)@null)), &&(@_vcc_typed2(@state, p), unchecked!(@_vcc_is_ghost_ptr(p))))))); 
    assert (forall Q#p$1^54.31#tc1: $ptr :: { $set_in(Q#p$1^54.31#tc1, $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) } $set_in(Q#p$1^54.31#tc1, $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) ==> $is(Q#p$1^54.31#tc1, ^_SINGLE_LIST_ENTRY) && $typed2($s, Q#p$1^54.31#tc1, $typ(Q#p$1^54.31#tc1)) && !$is_ghost_ptr(Q#p$1^54.31#tc1));
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(p, @_vcc_owns(@state, ListManager)) } @in_range_phys_ptr((mathint)p); ==>(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_eq(*((p->Manager)), ListManager)))); 
    assert (forall Q#p$1^58.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) ==> $ptr_eq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^58.31#dt1), _SINGLE_LIST_ENTRY.Manager), ^_SINGLE_LIST_MANAGER), $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)));
    // assert @inv_check(@_vcc_set_in(*((ListManager->ListHead)), @_vcc_owns(@state, ListManager))); 
    assert $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.ListHead), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)));
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager)) } { @trigger_hint(@_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager))) } @in_range_phys_ptr((mathint)p); ==>(&&(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_neq(*((p->Next)), @null)), &&(@_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager)), @_vcc_ptr_eq(*((*((p->Next))->Back)), p))))); 
    assert (forall Q#p$1^67.31#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) } { sk_hack($set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) && $ptr_neq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $null) ==> $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $ptr(^_SINGLE_LIST_ENTRY, Q#p$1^67.31#dt1)));
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(*((p->Back)), @_vcc_owns(@state, ListManager)) } { @trigger_hint(@_vcc_set_in(*((p->Back)), @_vcc_owns(@state, ListManager))) } @in_range_phys_ptr((mathint)p); ==>(&&(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_neq(*((p->Back)), @null)), &&(@_vcc_set_in(*((p->Back)), @_vcc_owns(@state, ListManager)), @_vcc_ptr_eq(*((*((p->Back))->Next)), p))))); 
    assert (forall Q#p$1^72.31#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) } { sk_hack($set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) && $ptr_neq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $null) ==> $set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) && $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1), _SINGLE_LIST_ENTRY.Back), ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $ptr(^_SINGLE_LIST_ENTRY, Q#p$1^72.31#dt1)));
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(p, @_vcc_owns(@state, ListManager)) } { @trigger_hint(@_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager))) } @in_range_phys_ptr((mathint)p); ==>(&&(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_neq(*((p->Next)), @null)), ==(+(@map_get(*((ListManager->index)), p), 1), @map_get(*((ListManager->index)), *((p->Next))))))); 
    assert (forall Q#p$1^81.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) } { sk_hack($set_in($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager)))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) && $ptr_neq($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY), $null) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1))) + 1 == $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_SINGLE_LIST_ENTRY, Q#p$1^81.31#dt1), _SINGLE_LIST_ENTRY.Next), ^_SINGLE_LIST_ENTRY))));
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((ListManager->ListHead))), 0)); 
    assert $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($read_ptr($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.ListHead), ^_SINGLE_LIST_ENTRY))) == 0;
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* e; { @_vcc_set_in(e, @_vcc_owns(@state, ListManager)) } @in_range_phys_ptr((mathint)e); ==>(@_vcc_set_in(e, @_vcc_owns(@state, ListManager)), &&(<=(0, @map_get(*((ListManager->index)), e)), <(@map_get(*((ListManager->index)), e), *((ListManager->size))))))); 
    assert (forall Q#e$1^88.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) ==> 0 <= $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1))) && $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e$1^88.31#dt1))) < $mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.size)));
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* e1; struct _SINGLE_LIST_ENTRY* e2; { @_vcc_set_in(e1, @_vcc_owns(@state, ListManager)), @_vcc_set_in(e2, @_vcc_owns(@state, ListManager)) } &&(@in_range_phys_ptr((mathint)e1), @in_range_phys_ptr((mathint)e2)); ==>(&&(&&(@_vcc_set_in(e1, @_vcc_owns(@state, ListManager)), @_vcc_set_in(e2, @_vcc_owns(@state, ListManager))), @_vcc_ptr_neq(e1, e2)), !=(@map_get(*((ListManager->index)), e1), @map_get(*((ListManager->index)), e2))))); 
    assert (forall Q#e1$1^92.31#dt1: int, Q#e2$1^92.31#dt1: int :: { $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))), $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1))) && $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1))) ==> $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) && $set_in($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1), $owns($s, $ptr(^_SINGLE_LIST_MANAGER, SL#ListManager))) && $ptr_neq($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1), $ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1)) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e1$1^92.31#dt1))) != $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($mem($s, $dot($ptr(^_SINGLE_LIST_MANAGER, SL#ListManager), _SINGLE_LIST_MANAGER.index))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#e2$1^92.31#dt1))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



function F#lambda#2(#l5: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l4: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l3: int, #l2: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l1: int, #l0: int) : $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4;

const unique cf#lambda#2: $pure_function;

axiom $function_arg_type(cf#lambda#2, 0, $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#2, 1, $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#2, 2, $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#2, 3, ^^u4);

axiom $function_arg_type(cf#lambda#2, 4, $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#2, 5, ^^u4);

axiom $function_arg_type(cf#lambda#2, 6, $ptr_to(^_SINGLE_LIST_ENTRY));

procedure lambda#2(#l5: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l4: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l3: int, #l2: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l1: int, #l0: int) returns ($result: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4);
  free ensures $result == F#lambda#2(#l5, #l4, #l3, #l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#x$1^265.31#dt1: int, #l5: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l4: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l3: int, #l2: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l1: int, #l0: int :: { $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(F#lambda#2(#l5, #l4, #l3, #l2, #l1, $ref($ptr(^_SINGLE_LIST_ENTRY, #l0))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#x$1^265.31#dt1))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#x$1^265.31#dt1))) && $in_range_u4(#l3) && $in_range_u4(#l1) && $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, #l0))) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(F#lambda#2(#l5, #l4, #l3, #l2, #l1, $ref($ptr(^_SINGLE_LIST_ENTRY, #l0))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#x$1^265.31#dt1))) == (if $ptr_eq($ptr(^_SINGLE_LIST_ENTRY, Q#x$1^265.31#dt1), $ptr(^_SINGLE_LIST_ENTRY, #l0)) then #l1 else (if $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(#l2, $ref($ptr(^_SINGLE_LIST_ENTRY, Q#x$1^265.31#dt1))) <= #l3 then $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(#l4, $ref($ptr(^_SINGLE_LIST_ENTRY, Q#x$1^265.31#dt1))) else $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(#l5, $ref($ptr(^_SINGLE_LIST_ENTRY, Q#x$1^265.31#dt1))) + 1)));

function F#lambda#1(#l1: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l0: int) : $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4;

const unique cf#lambda#1: $pure_function;

axiom $function_arg_type(cf#lambda#1, 0, $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#1, 1, $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#1, 2, $ptr_to(^_SINGLE_LIST_ENTRY));

procedure lambda#1(#l1: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l0: int) returns ($result: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4);
  free ensures $result == F#lambda#1(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#x$1^199.35#dt1: int, #l1: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l0: int :: { $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(F#lambda#1(#l1, $ref($ptr(^_SINGLE_LIST_ENTRY, #l0))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#x$1^199.35#dt1))) } $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, Q#x$1^199.35#dt1))) && $in_range_phys_ptr($ref($ptr(^_SINGLE_LIST_ENTRY, #l0))) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(F#lambda#1(#l1, $ref($ptr(^_SINGLE_LIST_ENTRY, #l0))), $ref($ptr(^_SINGLE_LIST_ENTRY, Q#x$1^199.35#dt1))) == (if $ptr_eq($ptr(^_SINGLE_LIST_ENTRY, Q#x$1^199.35#dt1), $ptr(^_SINGLE_LIST_ENTRY, #l0)) then 0 else $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(#l1, $ref($ptr(^_SINGLE_LIST_ENTRY, Q#x$1^199.35#dt1))) - 1));

const unique l#public: $label;

type $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4;

function $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, p: int) : int;

function $store.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, p: int, v: int) : $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4;

function $eq.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M1: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, M2: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4) : bool;

const $zero.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4;

axiom (forall M: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, p: int, v: int :: $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($store.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M, p, v), p) == $unchecked(^^u4, v));

axiom (forall M: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, p: int, v: int, q: int :: p != q ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($store.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M, q, v), p) == $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M, p));

axiom (forall M1: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, M2: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4 :: { $eq.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M1, M2) } (forall p: int :: $unchecked(^^u4, $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M1, p)) == $unchecked(^^u4, $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M2, p))) ==> $eq.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, M2: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4 :: { $eq.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M1, M2) } $eq.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4(0) == $zero.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4;

axiom (forall p: int :: $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($zero.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, p) == 0);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4)) } $eq.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rec_fetch(r1, f)), $int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

axiom (forall M: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, p: int :: $in_range_t(^^u4, $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M, p)));

const unique #loc.#l0: $token;

const unique #loc.#l1: $token;

const unique #loc.#l2: $token;

const unique #loc.#l3: $token;

const unique #loc.#l4: $token;

const unique #loc.#l5: $token;

const unique #loc.prestate#39: $token;

const unique #tok$1^265.9: $token;

const unique #loc.res_lambda#2#4: $token;

const unique #tok$1^265.31: $token;

const unique #tok$1^264.31: $token;

const unique #tok$1^263.9: $token;

const unique #loc.owns#37: $token;

const unique #loc.staticWrapState#36: $token;

const unique #loc.prestate#38: $token;

const unique #tok$1^259.13: $token;

const unique #tok$1^258.36: $token;

const unique #loc.prestate#35: $token;

const unique #loc.prestate#33: $token;

const unique #loc.owns#34: $token;

const unique #loc.owns#31: $token;

const unique #loc.staticWrapState#30: $token;

const unique #loc.prestate#32: $token;

const unique #tok$1^254.17: $token;

const unique #tok$1^253.40: $token;

const unique #loc.prestate#29: $token;

const unique #loc.prestate#27: $token;

const unique #loc.owns#28: $token;

const unique #tok$1^250.25: $token;

const unique #loc.owns#25: $token;

const unique #loc.staticWrapState#24: $token;

const unique #loc.prestate#26: $token;

const unique #tok$1^249.9: $token;

const unique #tok$1^248.9: $token;

const unique #tok$1^247.31: $token;

const unique #tok$1^244.9: $token;

const unique #tok$1^243.32: $token;

const unique #loc.prestate#23: $token;

const unique #tok$1^236.27: $token;

const unique #loc.Entry: $token;

const unique #tok$1^224.1: $token;

const unique #loc.prestate#22: $token;

const unique #tok$1^199.13: $token;

const unique #loc.res_lambda#1#3: $token;

const unique #tok$1^199.35: $token;

const unique #tok$1^198.35: $token;

const unique #tok$1^197.13: $token;

const unique #loc.owns#20: $token;

const unique #loc.staticWrapState#19: $token;

const unique #loc.prestate#21: $token;

const unique #loc.owns#17: $token;

const unique #loc.staticWrapState#16: $token;

const unique #loc.prestate#18: $token;

const unique #tok$1^192.25: $token;

const unique #tok$1^191.48: $token;

const unique #loc.prestate#15: $token;

const unique #loc.prestate#13: $token;

const unique #loc.owns#14: $token;

const unique #tok$1^188.17: $token;

const unique #tok$1^187.40: $token;

const unique #loc.prestate#12: $token;

const unique #loc.prestate#10: $token;

const unique #loc.owns#11: $token;

const unique #tok$1^186.36: $token;

const unique #loc.prestate#9: $token;

const unique #tok$1^181.5: $token;

const unique #loc.FirstEntry: $token;

const unique #tok$1^175.5: $token;

const unique #tok$1^176.27: $token;

const unique #tok$1^161.1: $token;

const unique #tok$1^140.21: $token;

const unique #loc.prestate#8: $token;

const unique #tok$1^139.21: $token;

const unique #loc.owns#6: $token;

const unique #loc.staticWrapState#5: $token;

function $state_to_int(x: $state) : int;

function $int_to_state(x: int) : $state;

axiom (forall #x: $state :: #x == $int_to_state($state_to_int(#x)));

const unique #loc.prestate#7: $token;

const unique #tok$2^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(2, #file^?3Cno?20file?3E);

const unique #tok$1^138.5: $token;

const unique #tok$1^137.27: $token;

const unique #tok$1^136.27: $token;

const unique #tok$1^134.5: $token;

const unique #tok$1^133.5: $token;

const unique #tok$1^132.5: $token;

const unique #tok$1^131.19: $token;

const unique #tok$1^128.27: $token;

const unique #tok$1^127.5: $token;

const unique #loc.ListManager: $token;

const unique #tok$1^126.27: $token;

const unique #loc.ListHead: $token;

const unique #tok$1^117.1: $token;

const unique #loc._this_: $token;

const unique #tok$1^44.53: $token;

function $map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4_to_int(x: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4) : int;

function $int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4(x: int) : $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4;

axiom (forall #x: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4 :: #x == $int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4_to_int(#x)));

const unique #distTp4: $ctype;

axiom #distTp4 == $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4);

axiom $type_code_is(1, $ptr_to(^^void));

const unique #distTp3: $ctype;

axiom #distTp3 == $ptr_to(^^void);

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CSingleList.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CSingleList.c);

const unique #distTp2: $ctype;

axiom #distTp2 == $spec_ptr_to(^_SINGLE_LIST_MANAGER);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^_SINGLE_LIST_ENTRY);
