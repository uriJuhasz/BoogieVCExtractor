axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^Node: $ctype;

axiom $is_composite(^Node);

axiom $ptr_level(^Node) == 0;

axiom $sizeof(^Node) == 16;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Node) } $inv2(#s1, #s2, #p, ^Node) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty())));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^Node, #r), l#public) } $inv_lab(#s2, $ptr(^Node, #r), l#public) == ($typed(#s2, $ptr(^Node, #r)) && $set_eq($owns(#s2, $ptr(^Node, #r)), $set_empty())));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^Node, #r)) } $in_full_extent_of(#q, $ptr(^Node, #r)) == (#q == $ptr(^Node, #r) || #q == $dot($ptr(^Node, #r), Node.$owns) || #q == $dot($ptr(^Node, #r), Node.next) || #q == $dot($ptr(^Node, #r), Node.data)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Node, #r)) } $in_extent_of(#s, #q, $ptr(^Node, #r)) == $in_struct_extent_of(#q, $ptr(^Node, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Node, #r)) } $typed(#s, $ptr(^Node, #r)) ==> $in_extent_of(#s, #q, $ptr(^Node, #r)) == (#q == $ptr(^Node, #r) || $emb(#s, #q) == $ptr(^Node, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^Node, #r)) } $in_span_of(#q, $ptr(^Node, #r)) == (#q == $ptr(^Node, #r) || #q == $dot($ptr(^Node, #r), Node.$owns) || #q == $dot($ptr(^Node, #r), Node.next) || #q == $dot($ptr(^Node, #r), Node.data)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^Node) } $state_spans_the_same(#s1, #s2, #p, ^Node) == ($mem_eq(#s1, #s2, $dot(#p, Node.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Node.next)) && $mem_eq(#s1, #s2, $dot(#p, Node.data))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Node) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Node) == ($mem_eq(#s1, #s2, $dot(#p, Node.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Node.next)) && $mem_eq(#s1, #s2, $dot(#p, Node.data))));

axiom $is_claimable(^Node) == false;

axiom $has_volatile_owns_set(^Node) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^Node, #r)) } $extent_mutable(#s1, $ptr(^Node, #r)) == $mutable(#s1, $ptr(^Node, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^Node, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^Node, #r)) == $is_fresh(#s1, #s2, $ptr(^Node, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^Node, #r)) } $extent_zero(#s1, $ptr(^Node, #r)) == ($mem(#s1, $dot($ptr(^Node, #r), Node.next)) == 0 && $mem(#s1, $dot($ptr(^Node, #r), Node.data)) == 0));

const unique Node.$owns: $field;

axiom $static_field_properties(Node.$owns, ^Node);

axiom $is_primitive_non_volatile_field(Node.$owns);

axiom (forall #p: $ptr :: { $dot(#p, Node.$owns) } $is(#p, ^Node) ==> $dot(#p, Node.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, Node.$owns)) && $extent_hint($dot(#p, Node.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.$owns)) } { $st(#s, $dot(#p, Node.$owns)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.$owns, ^$#ptrset, false));

axiom $owns_set_field(^Node) == Node.$owns;

const unique Node.next: $field;

axiom $static_field_properties(Node.next, ^Node);

axiom $is_primitive_non_volatile_field(Node.next);

axiom $field_offset(Node.next) == 0;

axiom (forall #p: $ptr :: { $dot(#p, Node.next) } $is(#p, ^Node) ==> $dot(#p, Node.next) == $ptr($ptr_to(^Node), $ref(#p) + 0) && $extent_hint($dot(#p, Node.next), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.next)) } { $st(#s, $dot(#p, Node.next)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.next, $ptr_to(^Node), false));

const unique Node.data: $field;

axiom $static_field_properties(Node.data, ^Node);

axiom $is_primitive_non_volatile_field(Node.data);

axiom $field_offset(Node.data) == 8;

axiom (forall #p: $ptr :: { $dot(#p, Node.data) } $is(#p, ^Node) ==> $dot(#p, Node.data) == $ptr(^^i4, $ref(#p) + 8) && $extent_hint($dot(#p, Node.data), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.data)) } { $st(#s, $dot(#p, Node.data)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.data, ^^i4, false));

const unique ^List: $ctype;

axiom $is_composite(^List);

axiom $ptr_level(^List) == 0;

axiom $sizeof(^List) == 8;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^List) } $inv2(#s1, #s2, #p, ^List) == ($typed(#s2, #p) && ($ptr_neq($read_ptr(#s2, $dot(#p, List.head), ^Node), $null) ==> $keeps(#s2, #p, $read_ptr(#s2, $dot(#p, List.head), ^Node))) && $eq.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($mem(#s2, $dot(#p, List.followers))), $ref($ptr_cast($null, ^Node))), F#lambda#1()) && (forall Q#n$1^18.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^18.29#dt1))) ==> $keeps(#s2, #p, $ptr(^Node, Q#n$1^18.29#dt1)) ==> !$ptr_neq($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^18.29#dt1), Node.next), ^Node), $null) || $keeps(#s2, #p, $read_ptr(#s2, $dot($ptr(^Node, Q#n$1^18.29#dt1), Node.next), ^Node))) && (forall Q#n$1^19.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^19.29#dt1))) ==> $keeps(#s2, #p, $ptr(^Node, Q#n$1^19.29#dt1)) ==> (forall Q#e$1^20.5#tc2: int :: $in_range_i4(Q#e$1^20.5#tc2) ==> $select.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($mem(#s2, $dot(#p, List.followers))), $ref($ptr(^Node, Q#n$1^19.29#dt1))), Q#e$1^20.5#tc2) == ($select.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($mem(#s2, $dot(#p, List.followers))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^19.29#dt1), Node.next), ^Node))), Q#e$1^20.5#tc2) || Q#e$1^20.5#tc2 == $mem(#s2, $dot($ptr(^Node, Q#n$1^19.29#dt1), Node.data))))) && $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem(#s2, $dot(#p, List.length_acc))), $ref($ptr_cast($null, ^Node))) == 0 && (forall Q#n$1^21.51#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^21.51#dt1))) ==> $keeps(#s2, #p, $ptr(^Node, Q#n$1^21.51#dt1)) ==> $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem(#s2, $dot(#p, List.length_acc))), $ref($ptr(^Node, Q#n$1^21.51#dt1))) == $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem(#s2, $dot(#p, List.length_acc))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^21.51#dt1), Node.next), ^Node))) + 1) && (forall Q#n$1^22.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^22.29#dt1))) ==> $keeps(#s2, #p, $ptr(^Node, Q#n$1^22.29#dt1)) ==> $ptr_eq($ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem(#s2, $dot(#p, List.seq))), $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem(#s2, $dot(#p, List.idx))), $ref($ptr(^Node, Q#n$1^22.29#dt1))))), $ptr(^Node, Q#n$1^22.29#dt1))) && (forall Q#i$1^23.29#tc3: int :: $in_range_u4(Q#i$1^23.29#tc3) ==> Q#i$1^23.29#tc3 < $mem(#s2, $dot(#p, List.length)) ==> $keeps(#s2, #p, $ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem(#s2, $dot(#p, List.seq))), Q#i$1^23.29#tc3)))) && (forall Q#i$1^24.29#tc3: int :: { sk_hack($keeps(#s2, #p, $ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem(#s2, $dot(#p, List.seq))), Q#i$1^24.29#tc3)))) } $in_range_u4(Q#i$1^24.29#tc3) ==> Q#i$1^24.29#tc3 < $mem(#s2, $dot(#p, List.length)) ==> $ptr_eq($read_ptr(#s2, $dot($ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem(#s2, $dot(#p, List.seq))), Q#i$1^24.29#tc3)), Node.next), ^Node), $ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem(#s2, $dot(#p, List.seq))), Q#i$1^24.29#tc3 + 1)))) && $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem(#s2, $dot(#p, List.idx))), $ref($read_ptr(#s2, $dot(#p, List.head), ^Node))) == 0 && ($ptr_neq($read_ptr(#s2, $dot(#p, List.head), ^Node), $null) ==> $ptr_eq($ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem(#s2, $dot(#p, List.seq))), 0)), $read_ptr(#s2, $dot(#p, List.head), ^Node))) && (forall Q#n$1^26.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^26.29#dt1))) ==> $keeps(#s2, #p, $ptr(^Node, Q#n$1^26.29#dt1)) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^26.29#dt1), Node.next), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem(#s2, $dot(#p, List.idx))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^26.29#dt1), Node.next), ^Node))) == $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem(#s2, $dot(#p, List.idx))), $ref($ptr(^Node, Q#n$1^26.29#dt1))) + 1) && $mem(#s2, $dot(#p, List.length)) == $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem(#s2, $dot(#p, List.length_acc))), $ref($read_ptr(#s2, $dot(#p, List.head), ^Node)))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^List, #r), l#public) } $inv_lab(#s2, $ptr(^List, #r), l#public) == ($typed(#s2, $ptr(^List, #r)) && ($ptr_neq($read_ptr(#s2, $dot($ptr(^List, #r), List.head), ^Node), $null) ==> $keeps(#s2, $ptr(^List, #r), $read_ptr(#s2, $dot($ptr(^List, #r), List.head), ^Node))) && $eq.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($mem(#s2, $dot($ptr(^List, #r), List.followers))), $ref($ptr_cast($null, ^Node))), F#lambda#1()) && (forall Q#n$1^18.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^18.29#dt1))) ==> $keeps(#s2, $ptr(^List, #r), $ptr(^Node, Q#n$1^18.29#dt1)) ==> !$ptr_neq($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^18.29#dt1), Node.next), ^Node), $null) || $keeps(#s2, $ptr(^List, #r), $read_ptr(#s2, $dot($ptr(^Node, Q#n$1^18.29#dt1), Node.next), ^Node))) && (forall Q#n$1^19.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^19.29#dt1))) ==> $keeps(#s2, $ptr(^List, #r), $ptr(^Node, Q#n$1^19.29#dt1)) ==> (forall Q#e$1^20.5#tc2: int :: $in_range_i4(Q#e$1^20.5#tc2) ==> $select.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($mem(#s2, $dot($ptr(^List, #r), List.followers))), $ref($ptr(^Node, Q#n$1^19.29#dt1))), Q#e$1^20.5#tc2) == ($select.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($mem(#s2, $dot($ptr(^List, #r), List.followers))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^19.29#dt1), Node.next), ^Node))), Q#e$1^20.5#tc2) || Q#e$1^20.5#tc2 == $mem(#s2, $dot($ptr(^Node, Q#n$1^19.29#dt1), Node.data))))) && $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem(#s2, $dot($ptr(^List, #r), List.length_acc))), $ref($ptr_cast($null, ^Node))) == 0 && (forall Q#n$1^21.51#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^21.51#dt1))) ==> $keeps(#s2, $ptr(^List, #r), $ptr(^Node, Q#n$1^21.51#dt1)) ==> $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem(#s2, $dot($ptr(^List, #r), List.length_acc))), $ref($ptr(^Node, Q#n$1^21.51#dt1))) == $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem(#s2, $dot($ptr(^List, #r), List.length_acc))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^21.51#dt1), Node.next), ^Node))) + 1) && (forall Q#n$1^22.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^22.29#dt1))) ==> $keeps(#s2, $ptr(^List, #r), $ptr(^Node, Q#n$1^22.29#dt1)) ==> $ptr_eq($ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem(#s2, $dot($ptr(^List, #r), List.seq))), $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem(#s2, $dot($ptr(^List, #r), List.idx))), $ref($ptr(^Node, Q#n$1^22.29#dt1))))), $ptr(^Node, Q#n$1^22.29#dt1))) && (forall Q#i$1^23.29#tc3: int :: $in_range_u4(Q#i$1^23.29#tc3) ==> Q#i$1^23.29#tc3 < $mem(#s2, $dot($ptr(^List, #r), List.length)) ==> $keeps(#s2, $ptr(^List, #r), $ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem(#s2, $dot($ptr(^List, #r), List.seq))), Q#i$1^23.29#tc3)))) && (forall Q#i$1^24.29#tc3: int :: { sk_hack($keeps(#s2, $ptr(^List, #r), $ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem(#s2, $dot($ptr(^List, #r), List.seq))), Q#i$1^24.29#tc3)))) } $in_range_u4(Q#i$1^24.29#tc3) ==> Q#i$1^24.29#tc3 < $mem(#s2, $dot($ptr(^List, #r), List.length)) ==> $ptr_eq($read_ptr(#s2, $dot($ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem(#s2, $dot($ptr(^List, #r), List.seq))), Q#i$1^24.29#tc3)), Node.next), ^Node), $ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem(#s2, $dot($ptr(^List, #r), List.seq))), Q#i$1^24.29#tc3 + 1)))) && $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem(#s2, $dot($ptr(^List, #r), List.idx))), $ref($read_ptr(#s2, $dot($ptr(^List, #r), List.head), ^Node))) == 0 && ($ptr_neq($read_ptr(#s2, $dot($ptr(^List, #r), List.head), ^Node), $null) ==> $ptr_eq($ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem(#s2, $dot($ptr(^List, #r), List.seq))), 0)), $read_ptr(#s2, $dot($ptr(^List, #r), List.head), ^Node))) && (forall Q#n$1^26.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^26.29#dt1))) ==> $keeps(#s2, $ptr(^List, #r), $ptr(^Node, Q#n$1^26.29#dt1)) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^26.29#dt1), Node.next), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem(#s2, $dot($ptr(^List, #r), List.idx))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^26.29#dt1), Node.next), ^Node))) == $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem(#s2, $dot($ptr(^List, #r), List.idx))), $ref($ptr(^Node, Q#n$1^26.29#dt1))) + 1) && $mem(#s2, $dot($ptr(^List, #r), List.length)) == $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem(#s2, $dot($ptr(^List, #r), List.length_acc))), $ref($read_ptr(#s2, $dot($ptr(^List, #r), List.head), ^Node)))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^List, #r)) } $in_full_extent_of(#q, $ptr(^List, #r)) == (#q == $ptr(^List, #r) || #q == $dot($ptr(^List, #r), List.$owns) || #q == $dot($ptr(^List, #r), List.head) || #q == $dot($ptr(^List, #r), List.seq) || #q == $dot($ptr(^List, #r), List.idx) || #q == $dot($ptr(^List, #r), List.followers) || #q == $dot($ptr(^List, #r), List.length_acc) || #q == $dot($ptr(^List, #r), List.length)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^List, #r)) } $in_extent_of(#s, #q, $ptr(^List, #r)) == $in_struct_extent_of(#q, $ptr(^List, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^List, #r)) } $typed(#s, $ptr(^List, #r)) ==> $in_extent_of(#s, #q, $ptr(^List, #r)) == (#q == $ptr(^List, #r) || $emb(#s, #q) == $ptr(^List, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^List, #r)) } $in_span_of(#q, $ptr(^List, #r)) == (#q == $ptr(^List, #r) || #q == $dot($ptr(^List, #r), List.$owns) || #q == $dot($ptr(^List, #r), List.head) || #q == $dot($ptr(^List, #r), List.seq) || #q == $dot($ptr(^List, #r), List.idx) || #q == $dot($ptr(^List, #r), List.followers) || #q == $dot($ptr(^List, #r), List.length_acc) || #q == $dot($ptr(^List, #r), List.length)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^List) } $state_spans_the_same(#s1, #s2, #p, ^List) == ($mem_eq(#s1, #s2, $dot(#p, List.$owns)) && $mem_eq(#s1, #s2, $dot(#p, List.head)) && $mem_eq(#s1, #s2, $dot(#p, List.seq)) && $mem_eq(#s1, #s2, $dot(#p, List.idx)) && $mem_eq(#s1, #s2, $dot(#p, List.followers)) && $mem_eq(#s1, #s2, $dot(#p, List.length_acc)) && $mem_eq(#s1, #s2, $dot(#p, List.length))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^List) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^List) == ($mem_eq(#s1, #s2, $dot(#p, List.$owns)) && $mem_eq(#s1, #s2, $dot(#p, List.head)) && $mem_eq(#s1, #s2, $dot(#p, List.seq)) && $mem_eq(#s1, #s2, $dot(#p, List.idx)) && $mem_eq(#s1, #s2, $dot(#p, List.followers)) && $mem_eq(#s1, #s2, $dot(#p, List.length_acc)) && $mem_eq(#s1, #s2, $dot(#p, List.length))));

axiom $is_claimable(^List) == false;

axiom $has_volatile_owns_set(^List) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^List, #r)) } $extent_mutable(#s1, $ptr(^List, #r)) == $mutable(#s1, $ptr(^List, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^List, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^List, #r)) == $is_fresh(#s1, #s2, $ptr(^List, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^List, #r)) } $extent_zero(#s1, $ptr(^List, #r)) == ($mem(#s1, $dot($ptr(^List, #r), List.head)) == 0 && $mem(#s1, $dot($ptr(^List, #r), List.seq)) == 0 && $mem(#s1, $dot($ptr(^List, #r), List.idx)) == 0 && $mem(#s1, $dot($ptr(^List, #r), List.followers)) == 0 && $mem(#s1, $dot($ptr(^List, #r), List.length_acc)) == 0 && $mem(#s1, $dot($ptr(^List, #r), List.length)) == 0));

const unique List.$owns: $field;

axiom $static_field_properties(List.$owns, ^List);

axiom $is_primitive_non_volatile_field(List.$owns);

axiom (forall #p: $ptr :: { $dot(#p, List.$owns) } $is(#p, ^List) ==> $dot(#p, List.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, List.$owns)) && $extent_hint($dot(#p, List.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, List.$owns)) } { $st(#s, $dot(#p, List.$owns)) } $typed2(#s, #p, ^List) ==> $field_properties(#s, #p, List.$owns, ^$#ptrset, false));

axiom $owns_set_field(^List) == List.$owns;

const unique List.head: $field;

axiom $static_field_properties(List.head, ^List);

axiom $is_primitive_non_volatile_field(List.head);

axiom $field_offset(List.head) == 0;

axiom (forall #p: $ptr :: { $dot(#p, List.head) } $is(#p, ^List) ==> $dot(#p, List.head) == $ptr($ptr_to(^Node), $ref(#p) + 0) && $extent_hint($dot(#p, List.head), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, List.head)) } { $st(#s, $dot(#p, List.head)) } $typed2(#s, #p, ^List) ==> $field_properties(#s, #p, List.head, $ptr_to(^Node), false));

const unique List.seq: $field;

axiom $static_field_properties(List.seq, ^List);

axiom $is_primitive_non_volatile_field(List.seq);

axiom (forall #p: $ptr :: { $dot(#p, List.seq) } $is(#p, ^List) ==> $dot(#p, List.seq) == $ptr($map_t(^^u4, $ptr_to(^Node)), $ghost_ref(#p, List.seq)) && $extent_hint($dot(#p, List.seq), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, List.seq)) } { $st(#s, $dot(#p, List.seq)) } $typed2(#s, #p, ^List) ==> $field_properties(#s, #p, List.seq, $map_t(^^u4, $ptr_to(^Node)), false));

const unique List.idx: $field;

axiom $static_field_properties(List.idx, ^List);

axiom $is_primitive_non_volatile_field(List.idx);

axiom (forall #p: $ptr :: { $dot(#p, List.idx) } $is(#p, ^List) ==> $dot(#p, List.idx) == $ptr($map_t($ptr_to(^Node), ^^u4), $ghost_ref(#p, List.idx)) && $extent_hint($dot(#p, List.idx), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, List.idx)) } { $st(#s, $dot(#p, List.idx)) } $typed2(#s, #p, ^List) ==> $field_properties(#s, #p, List.idx, $map_t($ptr_to(^Node), ^^u4), false));

const unique List.followers: $field;

axiom $static_field_properties(List.followers, ^List);

axiom $is_primitive_non_volatile_field(List.followers);

axiom (forall #p: $ptr :: { $dot(#p, List.followers) } $is(#p, ^List) ==> $dot(#p, List.followers) == $ptr($map_t($ptr_to(^Node), $map_t(^^i4, ^^bool)), $ghost_ref(#p, List.followers)) && $extent_hint($dot(#p, List.followers), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, List.followers)) } { $st(#s, $dot(#p, List.followers)) } $typed2(#s, #p, ^List) ==> $field_properties(#s, #p, List.followers, $map_t($ptr_to(^Node), $map_t(^^i4, ^^bool)), false));

const unique List.length_acc: $field;

axiom $static_field_properties(List.length_acc, ^List);

axiom $is_primitive_non_volatile_field(List.length_acc);

axiom (forall #p: $ptr :: { $dot(#p, List.length_acc) } $is(#p, ^List) ==> $dot(#p, List.length_acc) == $ptr($map_t($ptr_to(^Node), ^^u4), $ghost_ref(#p, List.length_acc)) && $extent_hint($dot(#p, List.length_acc), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, List.length_acc)) } { $st(#s, $dot(#p, List.length_acc)) } $typed2(#s, #p, ^List) ==> $field_properties(#s, #p, List.length_acc, $map_t($ptr_to(^Node), ^^u4), false));

const unique List.length: $field;

axiom $static_field_properties(List.length, ^List);

axiom $is_primitive_non_volatile_field(List.length);

axiom (forall #p: $ptr :: { $dot(#p, List.length) } $is(#p, ^List) ==> $dot(#p, List.length) == $ptr(^^u4, $ghost_ref(#p, List.length)) && $extent_hint($dot(#p, List.length), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, List.length)) } { $st(#s, $dot(#p, List.length)) } $typed2(#s, #p, ^List) ==> $field_properties(#s, #p, List.length, ^^u4, false));

procedure List#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^List, P#_this_), List.head), ^Node), $null) ==> $keeps($s, $ptr(^List, P#_this_), $read_ptr($s, $dot($ptr(^List, P#_this_), List.head), ^Node));
  ensures $is_admissibility_check() ==> $eq.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($mem($s, $dot($ptr(^List, P#_this_), List.followers))), $ref($ptr_cast($null, ^Node))), F#lambda#1());
  ensures $is_admissibility_check() ==> (forall Q#n$1^18.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^18.29#dt1))) ==> $keeps($s, $ptr(^List, P#_this_), $ptr(^Node, Q#n$1^18.29#dt1)) ==> !$ptr_neq($read_ptr($s, $dot($ptr(^Node, Q#n$1^18.29#dt1), Node.next), ^Node), $null) || $keeps($s, $ptr(^List, P#_this_), $read_ptr($s, $dot($ptr(^Node, Q#n$1^18.29#dt1), Node.next), ^Node)));
  ensures $is_admissibility_check() ==> (forall Q#n$1^19.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^19.29#dt1))) ==> $keeps($s, $ptr(^List, P#_this_), $ptr(^Node, Q#n$1^19.29#dt1)) ==> (forall Q#e$1^20.5#tc2: int :: $in_range_i4(Q#e$1^20.5#tc2) ==> $select.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($mem($s, $dot($ptr(^List, P#_this_), List.followers))), $ref($ptr(^Node, Q#n$1^19.29#dt1))), Q#e$1^20.5#tc2) == ($select.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($mem($s, $dot($ptr(^List, P#_this_), List.followers))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^19.29#dt1), Node.next), ^Node))), Q#e$1^20.5#tc2) || Q#e$1^20.5#tc2 == $mem($s, $dot($ptr(^Node, Q#n$1^19.29#dt1), Node.data)))));
  ensures $is_admissibility_check() ==> $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem($s, $dot($ptr(^List, P#_this_), List.length_acc))), $ref($ptr_cast($null, ^Node))) == 0;
  ensures $is_admissibility_check() ==> (forall Q#n$1^21.51#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^21.51#dt1))) ==> $keeps($s, $ptr(^List, P#_this_), $ptr(^Node, Q#n$1^21.51#dt1)) ==> $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem($s, $dot($ptr(^List, P#_this_), List.length_acc))), $ref($ptr(^Node, Q#n$1^21.51#dt1))) == $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem($s, $dot($ptr(^List, P#_this_), List.length_acc))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^21.51#dt1), Node.next), ^Node))) + 1);
  ensures $is_admissibility_check() ==> (forall Q#n$1^22.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^22.29#dt1))) ==> $keeps($s, $ptr(^List, P#_this_), $ptr(^Node, Q#n$1^22.29#dt1)) ==> $ptr_eq($ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem($s, $dot($ptr(^List, P#_this_), List.seq))), $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem($s, $dot($ptr(^List, P#_this_), List.idx))), $ref($ptr(^Node, Q#n$1^22.29#dt1))))), $ptr(^Node, Q#n$1^22.29#dt1)));
  ensures $is_admissibility_check() ==> (forall Q#i$1^23.29#tc3: int :: $in_range_u4(Q#i$1^23.29#tc3) ==> Q#i$1^23.29#tc3 < $mem($s, $dot($ptr(^List, P#_this_), List.length)) ==> $keeps($s, $ptr(^List, P#_this_), $ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem($s, $dot($ptr(^List, P#_this_), List.seq))), Q#i$1^23.29#tc3))));
  ensures $is_admissibility_check() ==> (forall Q#i$1^24.29#tc3: int :: { sk_hack($keeps($s, $ptr(^List, P#_this_), $ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem($s, $dot($ptr(^List, P#_this_), List.seq))), Q#i$1^24.29#tc3)))) } $in_range_u4(Q#i$1^24.29#tc3) ==> Q#i$1^24.29#tc3 < $mem($s, $dot($ptr(^List, P#_this_), List.length)) ==> $ptr_eq($read_ptr($s, $dot($ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem($s, $dot($ptr(^List, P#_this_), List.seq))), Q#i$1^24.29#tc3)), Node.next), ^Node), $ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem($s, $dot($ptr(^List, P#_this_), List.seq))), Q#i$1^24.29#tc3 + 1))));
  ensures $is_admissibility_check() ==> $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem($s, $dot($ptr(^List, P#_this_), List.idx))), $ref($read_ptr($s, $dot($ptr(^List, P#_this_), List.head), ^Node))) == 0;
  ensures $is_admissibility_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^List, P#_this_), List.head), ^Node), $null) ==> $ptr_eq($ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem($s, $dot($ptr(^List, P#_this_), List.seq))), 0)), $read_ptr($s, $dot($ptr(^List, P#_this_), List.head), ^Node));
  ensures $is_admissibility_check() ==> (forall Q#n$1^26.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^26.29#dt1))) ==> $keeps($s, $ptr(^List, P#_this_), $ptr(^Node, Q#n$1^26.29#dt1)) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, Q#n$1^26.29#dt1), Node.next), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem($s, $dot($ptr(^List, P#_this_), List.idx))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^26.29#dt1), Node.next), ^Node))) == $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem($s, $dot($ptr(^List, P#_this_), List.idx))), $ref($ptr(^Node, Q#n$1^26.29#dt1))) + 1);
  ensures $is_admissibility_check() ==> $mem($s, $dot($ptr(^List, P#_this_), List.length)) == $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem($s, $dot($ptr(^List, P#_this_), List.length_acc))), $ref($read_ptr($s, $dot($ptr(^List, P#_this_), List.head), ^Node)));
  ensures $is_unwrap_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^List, P#_this_), List.head), ^Node), $null) ==> $keeps($s, $ptr(^List, P#_this_), $read_ptr($s, $dot($ptr(^List, P#_this_), List.head), ^Node));
  ensures $is_unwrap_check() ==> $eq.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($mem($s, $dot($ptr(^List, P#_this_), List.followers))), $ref($ptr_cast($null, ^Node))), F#lambda#1());
  ensures $is_unwrap_check() ==> (forall Q#n$1^18.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^18.29#dt1))) ==> $keeps($s, $ptr(^List, P#_this_), $ptr(^Node, Q#n$1^18.29#dt1)) ==> !$ptr_neq($read_ptr($s, $dot($ptr(^Node, Q#n$1^18.29#dt1), Node.next), ^Node), $null) || $keeps($s, $ptr(^List, P#_this_), $read_ptr($s, $dot($ptr(^Node, Q#n$1^18.29#dt1), Node.next), ^Node)));
  ensures $is_unwrap_check() ==> (forall Q#n$1^19.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^19.29#dt1))) ==> $keeps($s, $ptr(^List, P#_this_), $ptr(^Node, Q#n$1^19.29#dt1)) ==> (forall Q#e$1^20.5#tc2: int :: $in_range_i4(Q#e$1^20.5#tc2) ==> $select.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($mem($s, $dot($ptr(^List, P#_this_), List.followers))), $ref($ptr(^Node, Q#n$1^19.29#dt1))), Q#e$1^20.5#tc2) == ($select.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($mem($s, $dot($ptr(^List, P#_this_), List.followers))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^19.29#dt1), Node.next), ^Node))), Q#e$1^20.5#tc2) || Q#e$1^20.5#tc2 == $mem($s, $dot($ptr(^Node, Q#n$1^19.29#dt1), Node.data)))));
  ensures $is_unwrap_check() ==> $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem($s, $dot($ptr(^List, P#_this_), List.length_acc))), $ref($ptr_cast($null, ^Node))) == 0;
  ensures $is_unwrap_check() ==> (forall Q#n$1^21.51#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^21.51#dt1))) ==> $keeps($s, $ptr(^List, P#_this_), $ptr(^Node, Q#n$1^21.51#dt1)) ==> $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem($s, $dot($ptr(^List, P#_this_), List.length_acc))), $ref($ptr(^Node, Q#n$1^21.51#dt1))) == $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem($s, $dot($ptr(^List, P#_this_), List.length_acc))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^21.51#dt1), Node.next), ^Node))) + 1);
  ensures $is_unwrap_check() ==> (forall Q#n$1^22.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^22.29#dt1))) ==> $keeps($s, $ptr(^List, P#_this_), $ptr(^Node, Q#n$1^22.29#dt1)) ==> $ptr_eq($ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem($s, $dot($ptr(^List, P#_this_), List.seq))), $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem($s, $dot($ptr(^List, P#_this_), List.idx))), $ref($ptr(^Node, Q#n$1^22.29#dt1))))), $ptr(^Node, Q#n$1^22.29#dt1)));
  ensures $is_unwrap_check() ==> (forall Q#i$1^23.29#tc3: int :: $in_range_u4(Q#i$1^23.29#tc3) ==> Q#i$1^23.29#tc3 < $mem($s, $dot($ptr(^List, P#_this_), List.length)) ==> $keeps($s, $ptr(^List, P#_this_), $ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem($s, $dot($ptr(^List, P#_this_), List.seq))), Q#i$1^23.29#tc3))));
  ensures $is_unwrap_check() ==> (forall Q#i$1^24.29#tc3: int :: { sk_hack($keeps($s, $ptr(^List, P#_this_), $ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem($s, $dot($ptr(^List, P#_this_), List.seq))), Q#i$1^24.29#tc3)))) } $in_range_u4(Q#i$1^24.29#tc3) ==> Q#i$1^24.29#tc3 < $mem($s, $dot($ptr(^List, P#_this_), List.length)) ==> $ptr_eq($read_ptr($s, $dot($ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem($s, $dot($ptr(^List, P#_this_), List.seq))), Q#i$1^24.29#tc3)), Node.next), ^Node), $ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem($s, $dot($ptr(^List, P#_this_), List.seq))), Q#i$1^24.29#tc3 + 1))));
  ensures $is_unwrap_check() ==> $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem($s, $dot($ptr(^List, P#_this_), List.idx))), $ref($read_ptr($s, $dot($ptr(^List, P#_this_), List.head), ^Node))) == 0;
  ensures $is_unwrap_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^List, P#_this_), List.head), ^Node), $null) ==> $ptr_eq($ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem($s, $dot($ptr(^List, P#_this_), List.seq))), 0)), $read_ptr($s, $dot($ptr(^List, P#_this_), List.head), ^Node));
  ensures $is_unwrap_check() ==> (forall Q#n$1^26.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^26.29#dt1))) ==> $keeps($s, $ptr(^List, P#_this_), $ptr(^Node, Q#n$1^26.29#dt1)) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, Q#n$1^26.29#dt1), Node.next), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem($s, $dot($ptr(^List, P#_this_), List.idx))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^26.29#dt1), Node.next), ^Node))) == $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem($s, $dot($ptr(^List, P#_this_), List.idx))), $ref($ptr(^Node, Q#n$1^26.29#dt1))) + 1);
  ensures $is_unwrap_check() ==> $mem($s, $dot($ptr(^List, P#_this_), List.length)) == $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem($s, $dot($ptr(^List, P#_this_), List.length_acc))), $ref($read_ptr($s, $dot($ptr(^List, P#_this_), List.head), ^Node)));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation List#adm(P#_this_: int)
{
  var #wrTime$1^9.31: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^9.31, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^9.31, #loc._this_, $ptr_to_int($ptr(^List, P#_this_)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^9.31, #loc._this_, $ptr(^List, P#_this_), $ptr_to(^List));
    assume #wrTime$1^9.31 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^9.31, #p) } $in_writes_at(#wrTime$1^9.31, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^List, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^List, P#_this_));
        assume $good_state_ext(#tok$1^9.31, $s);
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
            assume $admissibility_pre($s, $ptr(^List, P#_this_));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^List, P#_this_));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct List*)@null))
        call $havoc_others($ptr(^List, P#_this_), ^List);
        assume $good_state_ext(#tok$1^9.31, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^List, P#_this_), ^List);
    }

  #exit:
}



procedure find(P#l: int) returns ($result: int);
  requires $wrapped($s, $ptr(^List, P#l), ^List);
  modifies $s, $cev_pc;
  free ensures $in_range_u4($result);
  ensures $result <= $mem($s, $dot($ptr(^List, P#l), List.length)) && (forall Q#i$1^32.51#tc3: int :: $in_range_u4(Q#i$1^32.51#tc3) ==> Q#i$1^32.51#tc3 < $result ==> $mem($s, $dot($ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem($s, $dot($ptr(^List, P#l), List.seq))), Q#i$1^32.51#tc3)), Node.data)) != 0);
  ensures $result < $mem($s, $dot($ptr(^List, P#l), List.length)) ==> $mem($s, $dot($ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem($s, $dot($ptr(^List, P#l), List.seq))), $result)), Node.data)) == 0;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation find(P#l: int) returns ($result: int)
{
  var loopState#0: $state;
  var L#n: int where $in_range_phys_ptr(L#n);
  var L#i: int where $in_range_u4(L#i);
  var #wrTime$1^30.1: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^30.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^30.1, #loc.l, $ptr_to_int($ptr(^List, P#l)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^30.1, #loc.l, $ptr(^List, P#l), $ptr_to(^List));
    assume #wrTime$1^30.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^30.1, #p) } $in_writes_at(#wrTime$1^30.1, #p) == false);
    // assume @in_range_phys_ptr((mathint)l); 
    assume $in_range_phys_ptr($ref($ptr(^List, P#l)));
    // assert @_vcc_in_domain(@state, l, l); 
    assert $in_domain_lab($s, $ptr(^List, P#l), $ptr(^List, P#l), l#public);
    // uint32_t i; 
    assume $local_value_is($s, #tok$1^36.3, #loc.i, L#i, ^^u4);
    // struct Node* n; 
    assume $local_value_is($s, #tok$1^35.10, #loc.n, $ptr_to_int($ptr(^Node, L#n)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^35.10, #loc.n, $ptr(^Node, L#n), $ptr_to(^Node));
    // var struct Node* n
    // var uint32_t i
    // assert @reads_check_normal((l->head)); 
    assert $typed2($s, $dot($ptr(^List, P#l), List.head), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^List, P#l), List.head), $ptr_to(^Node));
    // n := *((l->head)); 
    L#n := $ref($read_ptr($s, $dot($ptr(^List, P#l), List.head), ^Node));
    assume $local_value_is($s, #tok$1^38.8, #loc.n, $ptr_to_int($ptr(^Node, L#n)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^38.8, #loc.n, $ptr(^Node, L#n), $ptr_to(^Node));
    // i := 0; 
    L#i := 0;
    assume $local_value_is($s, #tok$1^38.21, #loc.i, L#i, ^^u4);
    loopState#0 := $s;
    while (true)
      invariant $ptr_neq($ptr(^Node, L#n), $null) ==> $set_in($ptr(^Node, L#n), $owns($s, $ptr(^List, P#l)));
      invariant $mem($s, $dot($ptr(^List, P#l), List.length)) - L#i == $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($mem($s, $dot($ptr(^List, P#l), List.length_acc))), $ref($ptr(^Node, L#n)));
      invariant $ptr_neq($ptr(^Node, L#n), $null) ==> $ptr_eq($ptr(^Node, L#n), $ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem($s, $dot($ptr(^List, P#l), List.seq))), L#i)));
      invariant (forall Q#j$1^42.31#tc3: int :: $in_range_u4(Q#j$1^42.31#tc3) ==> Q#j$1^42.31#tc3 < L#i ==> $mem($s, $dot($ptr(^Node, $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($mem($s, $dot($ptr(^List, P#l), List.seq))), Q#j$1^42.31#tc3)), Node.data)) != 0);
    {
      anon11:
        assume $writes_nothing(old($s), $s);
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$1^38.3, $s);
        assume $local_value_is($s, #tok$1^38.3, #loc.n, $ptr_to_int($ptr(^Node, L#n)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^38.3, #loc.n, $ptr(^Node, L#n), $ptr_to(^Node));
        assume $local_value_is($s, #tok$1^38.3, #loc.i, L#i, ^^u4);
        assume $local_value_is($s, #tok$1^38.3, #loc.l, $ptr_to_int($ptr(^List, P#l)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^38.3, #loc.l, $ptr(^List, P#l), $ptr_to(^List));
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#0, $s);
        assume true;
        // if ((_Bool)n) ...
        if ($ptr_neq($ptr(^Node, L#n), $null))
        {
          anon9:
            // assert @reads_check_normal((n->data)); 
            assert $typed2($s, $dot($ptr(^Node, L#n), Node.data), ^^i4);
            assert $thread_local2($s, $dot($ptr(^Node, L#n), Node.data), ^^i4);
            assume true;
            // if (==(*((n->data)), 0)) ...
            if ($mem($s, $dot($ptr(^Node, L#n), Node.data)) == 0)
            {
              anon7:
                // goto #break_2; 
                goto #break_2;
            }
            else
            {
              anon8:
                // empty
            }
        }
        else
        {
          anon10:
            // goto #break_2; 
            goto #break_2;
        }

      #continue_2:
        // assert @reads_check_normal((n->next)); 
        assert $typed2($s, $dot($ptr(^Node, L#n), Node.next), $ptr_to(^Node));
        assert $thread_local2($s, $dot($ptr(^Node, L#n), Node.next), $ptr_to(^Node));
        // n := *((n->next)); 
        L#n := $ref($read_ptr($s, $dot($ptr(^Node, L#n), Node.next), ^Node));
        assume $local_value_is($s, #tok$1^38.31, #loc.n, $ptr_to_int($ptr(^Node, L#n)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^38.31, #loc.n, $ptr(^Node, L#n), $ptr_to(^Node));
        // assert @in_range_u4(+(i, 1)); 
        assert $in_range_u4(L#i + 1);
        // i := +(i, 1); 
        L#i := L#i + 1;
        assume $local_value_is($s, #tok$1^38.44, #loc.i, L#i, ^^u4);
        assume true;
    }

  anon13:
    assume $full_stop_ext(#tok$1^38.3, $s);

  #break_2:
    // return i; 
    $result := L#i;
    assert $position_marker();
    goto #exit;

  anon14:
    // empty

  #exit:
}



function F#lambda#1() : $map_t..^^i4.^^bool;

const unique cf#lambda#1: $pure_function;

axiom $function_arg_type(cf#lambda#1, 0, $map_t(^^i4, ^^bool));

procedure lambda#1() returns ($result: $map_t..^^i4.^^bool);
  free ensures $result == F#lambda#1();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#k$1^17.45#tc2: int :: { $select.$map_t..^^i4.^^bool(F#lambda#1(), Q#k$1^17.45#tc2) } $in_range_i4(Q#k$1^17.45#tc2) ==> $select.$map_t..^^i4.^^bool(F#lambda#1(), Q#k$1^17.45#tc2) == false);

const unique l#public: $label;

type $map_t..^^i4.^^bool;

function $select.$map_t..^^i4.^^bool(M: $map_t..^^i4.^^bool, p: int) : bool;

function $store.$map_t..^^i4.^^bool(M: $map_t..^^i4.^^bool, p: int, v: bool) : $map_t..^^i4.^^bool;

function $eq.$map_t..^^i4.^^bool(M1: $map_t..^^i4.^^bool, M2: $map_t..^^i4.^^bool) : bool;

const $zero.$map_t..^^i4.^^bool: $map_t..^^i4.^^bool;

axiom (forall M: $map_t..^^i4.^^bool, p: int, v: bool :: $in_range_t(^^i4, p) ==> $select.$map_t..^^i4.^^bool($store.$map_t..^^i4.^^bool(M, p, v), p) == v);

axiom (forall M: $map_t..^^i4.^^bool, p: int, v: bool, q: int :: p != q ==> $select.$map_t..^^i4.^^bool($store.$map_t..^^i4.^^bool(M, q, v), p) == $select.$map_t..^^i4.^^bool(M, p));

axiom (forall M1: $map_t..^^i4.^^bool, M2: $map_t..^^i4.^^bool :: { $eq.$map_t..^^i4.^^bool(M1, M2) } (forall p: int :: $in_range_t(^^i4, p) ==> $select.$map_t..^^i4.^^bool(M1, p) == $select.$map_t..^^i4.^^bool(M2, p)) ==> $eq.$map_t..^^i4.^^bool(M1, M2));

axiom (forall M1: $map_t..^^i4.^^bool, M2: $map_t..^^i4.^^bool :: { $eq.$map_t..^^i4.^^bool(M1, M2) } $eq.$map_t..^^i4.^^bool(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^i4.^^bool(0) == $zero.$map_t..^^i4.^^bool;

axiom (forall p: int :: $select.$map_t..^^i4.^^bool($zero.$map_t..^^i4.^^bool, p) == false);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t(^^i4, ^^bool)) } $eq.$map_t..^^i4.^^bool($int_to_map_t..^^i4.^^bool($rec_fetch(r1, f)), $int_to_map_t..^^i4.^^bool($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

type $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool;

function $select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool(M: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool, p: int) : $map_t..^^i4.^^bool;

function $store.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool(M: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool, p: int, v: $map_t..^^i4.^^bool) : $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool;

function $eq.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool(M1: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool, M2: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool) : bool;

const $zero.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool;

axiom (forall M: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool, p: int, v: $map_t..^^i4.^^bool :: $select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($store.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool(M, p, v), p) == v);

axiom (forall M: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool, p: int, v: $map_t..^^i4.^^bool, q: int :: p != q ==> $select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($store.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool(M, q, v), p) == $select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool(M, p));

axiom (forall M1: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool, M2: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool :: { $eq.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool(M1, M2) } (forall p: int :: $eq.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool(M1, p), $select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool(M2, p))) ==> $eq.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool, M2: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool :: { $eq.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool(M1, M2) } $eq.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool(0) == $zero.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool;

axiom (forall p: int :: $select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($zero.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool, p) == $zero.$map_t..^^i4.^^bool);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t($ptr_to(^Node), $map_t(^^i4, ^^bool))) } $eq.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($rec_fetch(r1, f)), $int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

type $map_t..$ptr_to..^Node.^^u4;

function $select.$map_t..$ptr_to..^Node.^^u4(M: $map_t..$ptr_to..^Node.^^u4, p: int) : int;

function $store.$map_t..$ptr_to..^Node.^^u4(M: $map_t..$ptr_to..^Node.^^u4, p: int, v: int) : $map_t..$ptr_to..^Node.^^u4;

function $eq.$map_t..$ptr_to..^Node.^^u4(M1: $map_t..$ptr_to..^Node.^^u4, M2: $map_t..$ptr_to..^Node.^^u4) : bool;

const $zero.$map_t..$ptr_to..^Node.^^u4: $map_t..$ptr_to..^Node.^^u4;

axiom (forall M: $map_t..$ptr_to..^Node.^^u4, p: int, v: int :: $select.$map_t..$ptr_to..^Node.^^u4($store.$map_t..$ptr_to..^Node.^^u4(M, p, v), p) == $unchecked(^^u4, v));

axiom (forall M: $map_t..$ptr_to..^Node.^^u4, p: int, v: int, q: int :: p != q ==> $select.$map_t..$ptr_to..^Node.^^u4($store.$map_t..$ptr_to..^Node.^^u4(M, q, v), p) == $select.$map_t..$ptr_to..^Node.^^u4(M, p));

axiom (forall M1: $map_t..$ptr_to..^Node.^^u4, M2: $map_t..$ptr_to..^Node.^^u4 :: { $eq.$map_t..$ptr_to..^Node.^^u4(M1, M2) } (forall p: int :: $unchecked(^^u4, $select.$map_t..$ptr_to..^Node.^^u4(M1, p)) == $unchecked(^^u4, $select.$map_t..$ptr_to..^Node.^^u4(M2, p))) ==> $eq.$map_t..$ptr_to..^Node.^^u4(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^Node.^^u4, M2: $map_t..$ptr_to..^Node.^^u4 :: { $eq.$map_t..$ptr_to..^Node.^^u4(M1, M2) } $eq.$map_t..$ptr_to..^Node.^^u4(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^Node.^^u4(0) == $zero.$map_t..$ptr_to..^Node.^^u4;

axiom (forall p: int :: $select.$map_t..$ptr_to..^Node.^^u4($zero.$map_t..$ptr_to..^Node.^^u4, p) == 0);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t($ptr_to(^Node), ^^u4)) } $eq.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rec_fetch(r1, f)), $int_to_map_t..ptr_to..^Node.^^u4($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

axiom (forall M: $map_t..$ptr_to..^Node.^^u4, p: int :: $in_range_t(^^u4, $select.$map_t..$ptr_to..^Node.^^u4(M, p)));

type $map_t..^^u4.$ptr_to..^Node;

function $select.$map_t..^^u4.$ptr_to..^Node(M: $map_t..^^u4.$ptr_to..^Node, p: int) : int;

function $store.$map_t..^^u4.$ptr_to..^Node(M: $map_t..^^u4.$ptr_to..^Node, p: int, v: int) : $map_t..^^u4.$ptr_to..^Node;

function $eq.$map_t..^^u4.$ptr_to..^Node(M1: $map_t..^^u4.$ptr_to..^Node, M2: $map_t..^^u4.$ptr_to..^Node) : bool;

const $zero.$map_t..^^u4.$ptr_to..^Node: $map_t..^^u4.$ptr_to..^Node;

axiom (forall M: $map_t..^^u4.$ptr_to..^Node, p: int, v: int :: $in_range_t(^^u4, p) ==> $select.$map_t..^^u4.$ptr_to..^Node($store.$map_t..^^u4.$ptr_to..^Node(M, p, v), p) == v);

axiom (forall M: $map_t..^^u4.$ptr_to..^Node, p: int, v: int, q: int :: p != q ==> $select.$map_t..^^u4.$ptr_to..^Node($store.$map_t..^^u4.$ptr_to..^Node(M, q, v), p) == $select.$map_t..^^u4.$ptr_to..^Node(M, p));

axiom (forall M1: $map_t..^^u4.$ptr_to..^Node, M2: $map_t..^^u4.$ptr_to..^Node :: { $eq.$map_t..^^u4.$ptr_to..^Node(M1, M2) } (forall p: int :: $in_range_t(^^u4, p) ==> $select.$map_t..^^u4.$ptr_to..^Node(M1, p) == $select.$map_t..^^u4.$ptr_to..^Node(M2, p)) ==> $eq.$map_t..^^u4.$ptr_to..^Node(M1, M2));

axiom (forall M1: $map_t..^^u4.$ptr_to..^Node, M2: $map_t..^^u4.$ptr_to..^Node :: { $eq.$map_t..^^u4.$ptr_to..^Node(M1, M2) } $eq.$map_t..^^u4.$ptr_to..^Node(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^u4.ptr_to..^Node(0) == $zero.$map_t..^^u4.$ptr_to..^Node;

axiom (forall p: int :: $select.$map_t..^^u4.$ptr_to..^Node($zero.$map_t..^^u4.$ptr_to..^Node, p) == 0);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t(^^u4, $ptr_to(^Node))) } $eq.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rec_fetch(r1, f)), $int_to_map_t..^^u4.ptr_to..^Node($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

axiom (forall M: $map_t..^^u4.$ptr_to..^Node, p: int :: $in_range_phys_ptr($select.$map_t..^^u4.$ptr_to..^Node(M, p)));

function $map_t..^^i4.^^bool_to_int(x: $map_t..^^i4.^^bool) : int;

function $int_to_map_t..^^i4.^^bool(x: int) : $map_t..^^i4.^^bool;

axiom (forall #x: $map_t..^^i4.^^bool :: #x == $int_to_map_t..^^i4.^^bool($map_t..^^i4.^^bool_to_int(#x)));

const unique #tok$1^38.44: $token;

const unique #tok$1^38.31: $token;

const unique #tok$1^38.3: $token;

const unique #tok$1^38.21: $token;

const unique #tok$1^38.8: $token;

const unique #loc.n: $token;

const unique #tok$1^35.10: $token;

const unique #loc.i: $token;

const unique #tok$1^36.3: $token;

const unique #loc.l: $token;

const unique #tok$1^30.1: $token;

const unique #distTp6: $ctype;

axiom #distTp6 == $ptr_to(^List);

const unique #loc._this_: $token;

const unique #tok$1^9.31: $token;

axiom $type_code_is(3, ^^u4);

function $map_t..^^u4.ptr_to..^Node_to_int(x: $map_t..^^u4.$ptr_to..^Node) : int;

function $int_to_map_t..^^u4.ptr_to..^Node(x: int) : $map_t..^^u4.$ptr_to..^Node;

axiom (forall #x: $map_t..^^u4.$ptr_to..^Node :: #x == $int_to_map_t..^^u4.ptr_to..^Node($map_t..^^u4.ptr_to..^Node_to_int(#x)));

const unique #distTp5: $ctype;

axiom #distTp5 == $map_t(^^u4, $ptr_to(^Node));

function $map_t..ptr_to..^Node.^^u4_to_int(x: $map_t..$ptr_to..^Node.^^u4) : int;

function $int_to_map_t..ptr_to..^Node.^^u4(x: int) : $map_t..$ptr_to..^Node.^^u4;

axiom (forall #x: $map_t..$ptr_to..^Node.^^u4 :: #x == $int_to_map_t..ptr_to..^Node.^^u4($map_t..ptr_to..^Node.^^u4_to_int(#x)));

const unique #distTp4: $ctype;

axiom #distTp4 == $map_t($ptr_to(^Node), ^^u4);

axiom $type_code_is(2, ^^i4);

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvscomp2010?5Cvscomp2010_p3_v0.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvscomp2010?5Cvscomp2010_p3_v0.c);

function $map_t..ptr_to..^Node.map_t..^^i4.^^bool_to_int(x: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool) : int;

function $int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool(x: int) : $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool;

axiom (forall #x: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool :: #x == $int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($map_t..ptr_to..^Node.map_t..^^i4.^^bool_to_int(#x)));

const unique #distTp3: $ctype;

axiom #distTp3 == $map_t($ptr_to(^Node), $map_t(^^i4, ^^bool));

const unique #distTp2: $ctype;

axiom #distTp2 == $map_t(^^i4, ^^bool);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^Node);
