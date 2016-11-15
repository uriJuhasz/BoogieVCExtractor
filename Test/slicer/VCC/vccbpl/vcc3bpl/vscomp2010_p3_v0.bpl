axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

const unique ^Node: $ctype;

axiom $is_span_sequential(^Node);

axiom $def_struct_type(^Node, 16, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Node) } $inv2(#s1, #s2, #p, ^Node) == $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^Node)) } $in(q, $composite_extent(s, p, ^Node)) == (q == p));

const unique Node.next: $field;

axiom $def_phys_field(^Node, Node.next, $ptr_to(^Node), false, 0);

const unique Node.data: $field;

axiom $def_phys_field(^Node, Node.data, ^^i4, false, 8);

const unique ^List: $ctype;

axiom $is_span_sequential(^List);

axiom $def_struct_type(^List, 8, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^List) } $inv2(#s1, #s2, #p, ^List) == (($non_null($rd_phys_ptr(#s2, List.head, #p, ^Node)) ==> $keeps(#s2, #p, $rd_phys_ptr(#s2, List.head, #p, ^Node))) && $eq.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($rd_inv(#s2, List.followers, #p)), $phys_ptr_cast($null, ^Node)), F#lambda#1()) && (forall Q#n$1^18.29#dt1: $ptr :: {:weight 10} { $keeps(#s2, #p, $rd_phys_ptr(#s2, Node.next, $phys_ptr_cast(Q#n$1^18.29#dt1, ^Node), ^Node)) } { sk_hack($keeps(#s2, #p, $rd_phys_ptr(#s2, Node.next, $phys_ptr_cast(Q#n$1^18.29#dt1, ^Node), ^Node))) } $keeps(#s2, #p, $phys_ptr_cast(Q#n$1^18.29#dt1, ^Node)) ==> !$non_null($rd_phys_ptr(#s2, Node.next, $phys_ptr_cast(Q#n$1^18.29#dt1, ^Node), ^Node)) || $keeps(#s2, #p, $rd_phys_ptr(#s2, Node.next, $phys_ptr_cast(Q#n$1^18.29#dt1, ^Node), ^Node))) && (forall Q#n$1^19.29#dt1: $ptr :: {:weight 10} { $keeps(#s2, #p, $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node)) } { sk_hack($keeps(#s2, #p, $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node))) } $keeps(#s2, #p, $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node)) ==> (forall Q#e$1^20.5#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($rd_inv(#s2, List.followers, #p)), $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node)), Q#e$1^20.5#tc2) } { $select.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($rd_inv(#s2, List.followers, #p)), $rd_phys_ptr(#s2, Node.next, $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node), ^Node)), Q#e$1^20.5#tc2) } $in_range_i4(Q#e$1^20.5#tc2) ==> $select.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($rd_inv(#s2, List.followers, #p)), $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node)), Q#e$1^20.5#tc2) == ($select.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($rd_inv(#s2, List.followers, #p)), $rd_phys_ptr(#s2, Node.next, $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node), ^Node)), Q#e$1^20.5#tc2) || Q#e$1^20.5#tc2 == $rd_inv(#s2, Node.data, $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node))))) && $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv(#s2, List.length_acc, #p)), $phys_ptr_cast($null, ^Node)) == 0 && (forall Q#n$1^21.51#dt1: $ptr :: {:weight 10} { $keeps(#s2, #p, $phys_ptr_cast(Q#n$1^21.51#dt1, ^Node)) } { sk_hack($keeps(#s2, #p, $phys_ptr_cast(Q#n$1^21.51#dt1, ^Node))) } $keeps(#s2, #p, $phys_ptr_cast(Q#n$1^21.51#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv(#s2, List.length_acc, #p)), $phys_ptr_cast(Q#n$1^21.51#dt1, ^Node)) == $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv(#s2, List.length_acc, #p)), $rd_phys_ptr(#s2, Node.next, $phys_ptr_cast(Q#n$1^21.51#dt1, ^Node), ^Node)) + 1) && (forall Q#n$1^22.29#dt1: $ptr :: {:weight 10} { $keeps(#s2, #p, $phys_ptr_cast(Q#n$1^22.29#dt1, ^Node)) } { sk_hack($keeps(#s2, #p, $phys_ptr_cast(Q#n$1^22.29#dt1, ^Node))) } $keeps(#s2, #p, $phys_ptr_cast(Q#n$1^22.29#dt1, ^Node)) ==> $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv(#s2, List.seq, #p)), $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv(#s2, List.idx, #p)), $phys_ptr_cast(Q#n$1^22.29#dt1, ^Node))), ^Node) == $phys_ptr_cast(Q#n$1^22.29#dt1, ^Node)) && (forall Q#i$1^23.29#tc3: int :: {:weight 10} { $keeps(#s2, #p, $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv(#s2, List.seq, #p)), Q#i$1^23.29#tc3), ^Node)) } { sk_hack($keeps(#s2, #p, $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv(#s2, List.seq, #p)), Q#i$1^23.29#tc3), ^Node))) } $in_range_u4(Q#i$1^23.29#tc3) ==> Q#i$1^23.29#tc3 < $rd_inv(#s2, List.length, #p) ==> $keeps(#s2, #p, $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv(#s2, List.seq, #p)), Q#i$1^23.29#tc3), ^Node))) && (forall Q#i$1^24.29#tc3: int :: {:weight 10} { sk_hack($keeps(#s2, #p, $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv(#s2, List.seq, #p)), Q#i$1^24.29#tc3), ^Node))) } { $rd_phys_ptr(#s2, Node.next, $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv(#s2, List.seq, #p)), Q#i$1^24.29#tc3), ^Node), ^Node) } $in_range_u4(Q#i$1^24.29#tc3) ==> Q#i$1^24.29#tc3 < $rd_inv(#s2, List.length, #p) ==> $rd_phys_ptr(#s2, Node.next, $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv(#s2, List.seq, #p)), Q#i$1^24.29#tc3), ^Node), ^Node) == $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv(#s2, List.seq, #p)), Q#i$1^24.29#tc3 + 1), ^Node)) && $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv(#s2, List.idx, #p)), $rd_phys_ptr(#s2, List.head, #p, ^Node)) == 0 && ($non_null($rd_phys_ptr(#s2, List.head, #p, ^Node)) ==> $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv(#s2, List.seq, #p)), 0), ^Node) == $rd_phys_ptr(#s2, List.head, #p, ^Node)) && (forall Q#n$1^26.29#dt1: $ptr :: {:weight 10} { $keeps(#s2, #p, $phys_ptr_cast(Q#n$1^26.29#dt1, ^Node)) } { sk_hack($keeps(#s2, #p, $phys_ptr_cast(Q#n$1^26.29#dt1, ^Node))) } $keeps(#s2, #p, $phys_ptr_cast(Q#n$1^26.29#dt1, ^Node)) && $non_null($rd_phys_ptr(#s2, Node.next, $phys_ptr_cast(Q#n$1^26.29#dt1, ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv(#s2, List.idx, #p)), $rd_phys_ptr(#s2, Node.next, $phys_ptr_cast(Q#n$1^26.29#dt1, ^Node), ^Node)) == $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv(#s2, List.idx, #p)), $phys_ptr_cast(Q#n$1^26.29#dt1, ^Node)) + 1) && $rd_inv(#s2, List.length, #p) == $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv(#s2, List.length_acc, #p)), $rd_phys_ptr(#s2, List.head, #p, ^Node))));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^List)) } $in(q, $composite_extent(s, p, ^List)) == (q == p));

const unique List.head: $field;

axiom $def_phys_field(^List, List.head, $ptr_to(^Node), false, 0);

const unique List.seq: $field;

axiom $def_ghost_field(^List, List.seq, $map_t(^^u4, $ptr_to(^Node)), false);

const unique List.idx: $field;

axiom $def_ghost_field(^List, List.idx, $map_t($ptr_to(^Node), ^^u4), false);

const unique List.followers: $field;

axiom $def_ghost_field(^List, List.followers, $map_t($ptr_to(^Node), $map_t(^^i4, ^^bool)), false);

const unique List.length_acc: $field;

axiom $def_ghost_field(^List, List.length_acc, $map_t($ptr_to(^Node), ^^u4), false);

const unique List.length: $field;

axiom $def_ghost_field(^List, List.length, ^^u4, false);

procedure List#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $non_null($rd_phys_ptr($s, List.head, $phys_ptr_cast(P#_this_, ^List), ^Node)) ==> $keeps($s, $phys_ptr_cast(P#_this_, ^List), $rd_phys_ptr($s, List.head, $phys_ptr_cast(P#_this_, ^List), ^Node));
  ensures $is_admissibility_check() ==> $eq.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($rd_inv($s, List.followers, $phys_ptr_cast(P#_this_, ^List))), $phys_ptr_cast($null, ^Node)), F#lambda#1());
  ensures $is_admissibility_check() ==> (forall Q#n$1^18.29#dt1: $ptr :: {:weight 10} { $keeps($s, $phys_ptr_cast(P#_this_, ^List), $rd_phys_ptr($s, Node.next, $phys_ptr_cast(Q#n$1^18.29#dt1, ^Node), ^Node)) } { sk_hack($keeps($s, $phys_ptr_cast(P#_this_, ^List), $rd_phys_ptr($s, Node.next, $phys_ptr_cast(Q#n$1^18.29#dt1, ^Node), ^Node))) } $keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^18.29#dt1, ^Node)) ==> !$non_null($rd_phys_ptr($s, Node.next, $phys_ptr_cast(Q#n$1^18.29#dt1, ^Node), ^Node)) || $keeps($s, $phys_ptr_cast(P#_this_, ^List), $rd_phys_ptr($s, Node.next, $phys_ptr_cast(Q#n$1^18.29#dt1, ^Node), ^Node)));
  ensures $is_admissibility_check() ==> (forall Q#n$1^19.29#dt1: $ptr :: {:weight 10} { $keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node)) } { sk_hack($keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node))) } $keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node)) ==> (forall Q#e$1^20.5#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($rd_inv($s, List.followers, $phys_ptr_cast(P#_this_, ^List))), $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node)), Q#e$1^20.5#tc2) } { $select.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($rd_inv($s, List.followers, $phys_ptr_cast(P#_this_, ^List))), $rd_phys_ptr($s, Node.next, $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node), ^Node)), Q#e$1^20.5#tc2) } $in_range_i4(Q#e$1^20.5#tc2) ==> $select.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($rd_inv($s, List.followers, $phys_ptr_cast(P#_this_, ^List))), $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node)), Q#e$1^20.5#tc2) == ($select.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($rd_inv($s, List.followers, $phys_ptr_cast(P#_this_, ^List))), $rd_phys_ptr($s, Node.next, $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node), ^Node)), Q#e$1^20.5#tc2) || Q#e$1^20.5#tc2 == $rd_inv($s, Node.data, $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node)))));
  ensures $is_admissibility_check() ==> $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv($s, List.length_acc, $phys_ptr_cast(P#_this_, ^List))), $phys_ptr_cast($null, ^Node)) == 0;
  ensures $is_admissibility_check() ==> (forall Q#n$1^21.51#dt1: $ptr :: {:weight 10} { $keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^21.51#dt1, ^Node)) } { sk_hack($keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^21.51#dt1, ^Node))) } $keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^21.51#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv($s, List.length_acc, $phys_ptr_cast(P#_this_, ^List))), $phys_ptr_cast(Q#n$1^21.51#dt1, ^Node)) == $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv($s, List.length_acc, $phys_ptr_cast(P#_this_, ^List))), $rd_phys_ptr($s, Node.next, $phys_ptr_cast(Q#n$1^21.51#dt1, ^Node), ^Node)) + 1);
  ensures $is_admissibility_check() ==> (forall Q#n$1^22.29#dt1: $ptr :: {:weight 10} { $keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^22.29#dt1, ^Node)) } { sk_hack($keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^22.29#dt1, ^Node))) } $keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^22.29#dt1, ^Node)) ==> $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#_this_, ^List))), $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv($s, List.idx, $phys_ptr_cast(P#_this_, ^List))), $phys_ptr_cast(Q#n$1^22.29#dt1, ^Node))), ^Node) == $phys_ptr_cast(Q#n$1^22.29#dt1, ^Node));
  ensures $is_admissibility_check() ==> (forall Q#i$1^23.29#tc3: int :: {:weight 10} { $keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#_this_, ^List))), Q#i$1^23.29#tc3), ^Node)) } { sk_hack($keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#_this_, ^List))), Q#i$1^23.29#tc3), ^Node))) } $in_range_u4(Q#i$1^23.29#tc3) ==> Q#i$1^23.29#tc3 < $rd_inv($s, List.length, $phys_ptr_cast(P#_this_, ^List)) ==> $keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#_this_, ^List))), Q#i$1^23.29#tc3), ^Node)));
  ensures $is_admissibility_check() ==> (forall Q#i$1^24.29#tc3: int :: {:weight 10} { sk_hack($keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#_this_, ^List))), Q#i$1^24.29#tc3), ^Node))) } { $rd_phys_ptr($s, Node.next, $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#_this_, ^List))), Q#i$1^24.29#tc3), ^Node), ^Node) } $in_range_u4(Q#i$1^24.29#tc3) ==> Q#i$1^24.29#tc3 < $rd_inv($s, List.length, $phys_ptr_cast(P#_this_, ^List)) ==> $rd_phys_ptr($s, Node.next, $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#_this_, ^List))), Q#i$1^24.29#tc3), ^Node), ^Node) == $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#_this_, ^List))), Q#i$1^24.29#tc3 + 1), ^Node));
  ensures $is_admissibility_check() ==> $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv($s, List.idx, $phys_ptr_cast(P#_this_, ^List))), $rd_phys_ptr($s, List.head, $phys_ptr_cast(P#_this_, ^List), ^Node)) == 0;
  ensures $is_admissibility_check() ==> $non_null($rd_phys_ptr($s, List.head, $phys_ptr_cast(P#_this_, ^List), ^Node)) ==> $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#_this_, ^List))), 0), ^Node) == $rd_phys_ptr($s, List.head, $phys_ptr_cast(P#_this_, ^List), ^Node);
  ensures $is_admissibility_check() ==> (forall Q#n$1^26.29#dt1: $ptr :: {:weight 10} { $keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^26.29#dt1, ^Node)) } { sk_hack($keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^26.29#dt1, ^Node))) } $keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^26.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.next, $phys_ptr_cast(Q#n$1^26.29#dt1, ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv($s, List.idx, $phys_ptr_cast(P#_this_, ^List))), $rd_phys_ptr($s, Node.next, $phys_ptr_cast(Q#n$1^26.29#dt1, ^Node), ^Node)) == $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv($s, List.idx, $phys_ptr_cast(P#_this_, ^List))), $phys_ptr_cast(Q#n$1^26.29#dt1, ^Node)) + 1);
  ensures $is_admissibility_check() ==> $rd_inv($s, List.length, $phys_ptr_cast(P#_this_, ^List)) == $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv($s, List.length_acc, $phys_ptr_cast(P#_this_, ^List))), $rd_phys_ptr($s, List.head, $phys_ptr_cast(P#_this_, ^List), ^Node));
  ensures $is_unwrap_check() ==> $non_null($rd_phys_ptr($s, List.head, $phys_ptr_cast(P#_this_, ^List), ^Node)) ==> $keeps($s, $phys_ptr_cast(P#_this_, ^List), $rd_phys_ptr($s, List.head, $phys_ptr_cast(P#_this_, ^List), ^Node));
  ensures $is_unwrap_check() ==> $eq.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($rd_inv($s, List.followers, $phys_ptr_cast(P#_this_, ^List))), $phys_ptr_cast($null, ^Node)), F#lambda#1());
  ensures $is_unwrap_check() ==> (forall Q#n$1^18.29#dt1: $ptr :: {:weight 10} { $keeps($s, $phys_ptr_cast(P#_this_, ^List), $rd_phys_ptr($s, Node.next, $phys_ptr_cast(Q#n$1^18.29#dt1, ^Node), ^Node)) } { sk_hack($keeps($s, $phys_ptr_cast(P#_this_, ^List), $rd_phys_ptr($s, Node.next, $phys_ptr_cast(Q#n$1^18.29#dt1, ^Node), ^Node))) } $keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^18.29#dt1, ^Node)) ==> !$non_null($rd_phys_ptr($s, Node.next, $phys_ptr_cast(Q#n$1^18.29#dt1, ^Node), ^Node)) || $keeps($s, $phys_ptr_cast(P#_this_, ^List), $rd_phys_ptr($s, Node.next, $phys_ptr_cast(Q#n$1^18.29#dt1, ^Node), ^Node)));
  ensures $is_unwrap_check() ==> (forall Q#n$1^19.29#dt1: $ptr :: {:weight 10} { $keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node)) } { sk_hack($keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node))) } $keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node)) ==> (forall Q#e$1^20.5#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($rd_inv($s, List.followers, $phys_ptr_cast(P#_this_, ^List))), $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node)), Q#e$1^20.5#tc2) } { $select.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($rd_inv($s, List.followers, $phys_ptr_cast(P#_this_, ^List))), $rd_phys_ptr($s, Node.next, $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node), ^Node)), Q#e$1^20.5#tc2) } $in_range_i4(Q#e$1^20.5#tc2) ==> $select.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($rd_inv($s, List.followers, $phys_ptr_cast(P#_this_, ^List))), $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node)), Q#e$1^20.5#tc2) == ($select.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool($rd_inv($s, List.followers, $phys_ptr_cast(P#_this_, ^List))), $rd_phys_ptr($s, Node.next, $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node), ^Node)), Q#e$1^20.5#tc2) || Q#e$1^20.5#tc2 == $rd_inv($s, Node.data, $phys_ptr_cast(Q#n$1^19.29#dt1, ^Node)))));
  ensures $is_unwrap_check() ==> $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv($s, List.length_acc, $phys_ptr_cast(P#_this_, ^List))), $phys_ptr_cast($null, ^Node)) == 0;
  ensures $is_unwrap_check() ==> (forall Q#n$1^21.51#dt1: $ptr :: {:weight 10} { $keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^21.51#dt1, ^Node)) } { sk_hack($keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^21.51#dt1, ^Node))) } $keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^21.51#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv($s, List.length_acc, $phys_ptr_cast(P#_this_, ^List))), $phys_ptr_cast(Q#n$1^21.51#dt1, ^Node)) == $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv($s, List.length_acc, $phys_ptr_cast(P#_this_, ^List))), $rd_phys_ptr($s, Node.next, $phys_ptr_cast(Q#n$1^21.51#dt1, ^Node), ^Node)) + 1);
  ensures $is_unwrap_check() ==> (forall Q#n$1^22.29#dt1: $ptr :: {:weight 10} { $keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^22.29#dt1, ^Node)) } { sk_hack($keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^22.29#dt1, ^Node))) } $keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^22.29#dt1, ^Node)) ==> $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#_this_, ^List))), $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv($s, List.idx, $phys_ptr_cast(P#_this_, ^List))), $phys_ptr_cast(Q#n$1^22.29#dt1, ^Node))), ^Node) == $phys_ptr_cast(Q#n$1^22.29#dt1, ^Node));
  ensures $is_unwrap_check() ==> (forall Q#i$1^23.29#tc3: int :: {:weight 10} { $keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#_this_, ^List))), Q#i$1^23.29#tc3), ^Node)) } { sk_hack($keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#_this_, ^List))), Q#i$1^23.29#tc3), ^Node))) } $in_range_u4(Q#i$1^23.29#tc3) ==> Q#i$1^23.29#tc3 < $rd_inv($s, List.length, $phys_ptr_cast(P#_this_, ^List)) ==> $keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#_this_, ^List))), Q#i$1^23.29#tc3), ^Node)));
  ensures $is_unwrap_check() ==> (forall Q#i$1^24.29#tc3: int :: {:weight 10} { sk_hack($keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#_this_, ^List))), Q#i$1^24.29#tc3), ^Node))) } { $rd_phys_ptr($s, Node.next, $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#_this_, ^List))), Q#i$1^24.29#tc3), ^Node), ^Node) } $in_range_u4(Q#i$1^24.29#tc3) ==> Q#i$1^24.29#tc3 < $rd_inv($s, List.length, $phys_ptr_cast(P#_this_, ^List)) ==> $rd_phys_ptr($s, Node.next, $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#_this_, ^List))), Q#i$1^24.29#tc3), ^Node), ^Node) == $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#_this_, ^List))), Q#i$1^24.29#tc3 + 1), ^Node));
  ensures $is_unwrap_check() ==> $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv($s, List.idx, $phys_ptr_cast(P#_this_, ^List))), $rd_phys_ptr($s, List.head, $phys_ptr_cast(P#_this_, ^List), ^Node)) == 0;
  ensures $is_unwrap_check() ==> $non_null($rd_phys_ptr($s, List.head, $phys_ptr_cast(P#_this_, ^List), ^Node)) ==> $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#_this_, ^List))), 0), ^Node) == $rd_phys_ptr($s, List.head, $phys_ptr_cast(P#_this_, ^List), ^Node);
  ensures $is_unwrap_check() ==> (forall Q#n$1^26.29#dt1: $ptr :: {:weight 10} { $keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^26.29#dt1, ^Node)) } { sk_hack($keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^26.29#dt1, ^Node))) } $keeps($s, $phys_ptr_cast(P#_this_, ^List), $phys_ptr_cast(Q#n$1^26.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.next, $phys_ptr_cast(Q#n$1^26.29#dt1, ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv($s, List.idx, $phys_ptr_cast(P#_this_, ^List))), $rd_phys_ptr($s, Node.next, $phys_ptr_cast(Q#n$1^26.29#dt1, ^Node), ^Node)) == $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv($s, List.idx, $phys_ptr_cast(P#_this_, ^List))), $phys_ptr_cast(Q#n$1^26.29#dt1, ^Node)) + 1);
  ensures $is_unwrap_check() ==> $rd_inv($s, List.length, $phys_ptr_cast(P#_this_, ^List)) == $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv($s, List.length_acc, $phys_ptr_cast(P#_this_, ^List))), $rd_phys_ptr($s, List.head, $phys_ptr_cast(P#_this_, ^List), ^Node));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation List#adm(P#_this_: $ptr)
{
  var #wrTime$1^9.31: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^9.31, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^9.31, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^List));
    assume #wrTime$1^9.31 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^9.31, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($phys_ptr_cast(P#_this_, ^List), ^List);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $phys_ptr_cast(P#_this_, ^List));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($phys_ptr_cast(P#_this_, ^List));
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
            assume $admissibility_pre($s, $phys_ptr_cast(P#_this_, ^List));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $phys_ptr_cast(P#_this_, ^List));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct List*)@null))
        call $havoc_others($phys_ptr_cast(P#_this_, ^List), ^List);
        assume $good_state_ext(#tok$1^9.31, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $phys_ptr_cast(P#_this_, ^List), ^List);
    }

  #exit:
}



procedure find(P#l: $ptr) returns ($result: int);
  requires $wrapped($s, $phys_ptr_cast(P#l, ^List), ^List);
  modifies $s, $cev_pc;
  free ensures $in_range_u4($result);
  ensures $result <= $rd_inv($s, List.length, $phys_ptr_cast(P#l, ^List)) && (forall Q#i$1^32.51#tc3: int :: {:weight 10} { $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#l, ^List))), Q#i$1^32.51#tc3) } $in_range_u4(Q#i$1^32.51#tc3) ==> Q#i$1^32.51#tc3 < $result ==> $rd_inv($s, Node.data, $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#l, ^List))), Q#i$1^32.51#tc3), ^Node)) != 0);
  ensures $result < $rd_inv($s, List.length, $phys_ptr_cast(P#l, ^List)) ==> $rd_inv($s, Node.data, $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#l, ^List))), $result), ^Node)) == 0;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation find(P#l: $ptr) returns ($result: int)
{
  var loopState#0: $state;
  var L#n: $ptr;
  var L#i: int where $in_range_u4(L#i);
  var #wrTime$1^30.1: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^30.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^30.1, #loc.l, $ptr_to_int(P#l), $ptr_to(^List));
    assume #wrTime$1^30.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^30.1, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, l, l); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#l, ^List), $phys_ptr_cast(P#l, ^List), l#public);
    // uint32_t i; 
    assume $local_value_is($s, #tok$1^36.3, #loc.i, L#i, ^^u4);
    // struct Node* n; 
    assume $local_value_is($s, #tok$1^35.10, #loc.n, $ptr_to_int(L#n), $ptr_to(^Node));
    // var struct Node* n
    // var uint32_t i
    // assert @reads_check_normal((l->head)); 
    assert $thread_local($s, $phys_ptr_cast(P#l, ^List));
    // n := *((l->head)); 
    L#n := $rd_phys_ptr($s, List.head, $phys_ptr_cast(P#l, ^List), ^Node);
    assume $local_value_is($s, #tok$1^38.8, #loc.n, $ptr_to_int(L#n), $ptr_to(^Node));
    // i := 0; 
    L#i := 0;
    assume $local_value_is($s, #tok$1^38.21, #loc.i, L#i, ^^u4);
    loopState#0 := $s;
    while (true)
      invariant $non_null($phys_ptr_cast(L#n, ^Node)) ==> $set_in($phys_ptr_cast(L#n, ^Node), $owns($s, $phys_ptr_cast(P#l, ^List)));
      invariant $rd_inv($s, List.length, $phys_ptr_cast(P#l, ^List)) - L#i == $select.$map_t..$ptr_to..^Node.^^u4($int_to_map_t..ptr_to..^Node.^^u4($rd_inv($s, List.length_acc, $phys_ptr_cast(P#l, ^List))), $phys_ptr_cast(L#n, ^Node));
      invariant $non_null($phys_ptr_cast(L#n, ^Node)) ==> $phys_ptr_cast(L#n, ^Node) == $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#l, ^List))), L#i), ^Node);
      invariant (forall Q#j$1^42.31#tc3: int :: {:weight 10} { $select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#l, ^List))), Q#j$1^42.31#tc3) } $in_range_u4(Q#j$1^42.31#tc3) ==> Q#j$1^42.31#tc3 < L#i ==> $rd_inv($s, Node.data, $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node($int_to_map_t..^^u4.ptr_to..^Node($rd_inv($s, List.seq, $phys_ptr_cast(P#l, ^List))), Q#j$1^42.31#tc3), ^Node)) != 0);
    {
      anon11:
        assume $writes_nothing(old($s), $s);
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$1^38.3, $s);
        assume $local_value_is($s, #tok$1^38.3, #loc.n, $ptr_to_int(L#n), $ptr_to(^Node));
        assume $local_value_is($s, #tok$1^38.3, #loc.i, L#i, ^^u4);
        assume $local_value_is($s, #tok$1^38.3, #loc.l, $ptr_to_int(P#l), $ptr_to(^List));
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#0, $s);
        assume true;
        // if (@_vcc_ptr_neq_null(n)) ...
        if ($non_null($phys_ptr_cast(L#n, ^Node)))
        {
          anon9:
            // assert @reads_check_normal((n->data)); 
            assert $thread_local($s, $phys_ptr_cast(L#n, ^Node));
            assume true;
            // if (==(*((n->data)), 0)) ...
            if ($rd_inv($s, Node.data, $phys_ptr_cast(L#n, ^Node)) == 0)
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
        assert $thread_local($s, $phys_ptr_cast(L#n, ^Node));
        // n := *((n->next)); 
        L#n := $rd_phys_ptr($s, Node.next, $phys_ptr_cast(L#n, ^Node), ^Node);
        assume $local_value_is($s, #tok$1^38.31, #loc.n, $ptr_to_int(L#n), $ptr_to(^Node));
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



axiom (forall Q#k$1^17.45#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^bool(F#lambda#1(), Q#k$1^17.45#tc2) } $in_range_i4(Q#k$1^17.45#tc2) ==> $select.$map_t..^^i4.^^bool(F#lambda#1(), Q#k$1^17.45#tc2) == false);

const unique l#public: $label;

type $map_t..^^i4.^^bool;

function $select.$map_t..^^i4.^^bool(M: $map_t..^^i4.^^bool, p: int) : bool;

function $store.$map_t..^^i4.^^bool(M: $map_t..^^i4.^^bool, p: int, v: bool) : $map_t..^^i4.^^bool;

function $eq.$map_t..^^i4.^^bool(M1: $map_t..^^i4.^^bool, M2: $map_t..^^i4.^^bool) : bool;

const $zero.$map_t..^^i4.^^bool: $map_t..^^i4.^^bool;

axiom (forall M: $map_t..^^i4.^^bool, p: int, v: bool :: true);

axiom (forall M: $map_t..^^i4.^^bool, p: int, v: bool, q: int :: $select.$map_t..^^i4.^^bool($store.$map_t..^^i4.^^bool(M, q, v), p) == (if $unchecked(^^i4, p) == $unchecked(^^i4, q) then v else $select.$map_t..^^i4.^^bool(M, p)));

axiom (forall M1: $map_t..^^i4.^^bool, M2: $map_t..^^i4.^^bool :: { $eq.$map_t..^^i4.^^bool(M1, M2) } (forall p: int :: $select.$map_t..^^i4.^^bool(M1, $unchecked(^^i4, p)) == $select.$map_t..^^i4.^^bool(M2, $unchecked(^^i4, p))) ==> $eq.$map_t..^^i4.^^bool(M1, M2));

axiom (forall M1: $map_t..^^i4.^^bool, M2: $map_t..^^i4.^^bool :: { $eq.$map_t..^^i4.^^bool(M1, M2) } $eq.$map_t..^^i4.^^bool(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^i4.^^bool(0) == $zero.$map_t..^^i4.^^bool;

axiom (forall p: int :: $select.$map_t..^^i4.^^bool($zero.$map_t..^^i4.^^bool, p) == false);

axiom true;

type $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool;

function $select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool(M: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool, p: $ptr) : $map_t..^^i4.^^bool;

function $store.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool(M: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool, p: $ptr, v: $map_t..^^i4.^^bool) : $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool;

function $eq.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool(M1: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool, M2: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool) : bool;

const $zero.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool;

axiom (forall M: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool, p: $ptr, v: $map_t..^^i4.^^bool :: true);

axiom (forall M: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool, p: $ptr, v: $map_t..^^i4.^^bool, q: $ptr :: $select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($store.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool(M, q, v), p) == (if $phys_ptr_cast(p, ^Node) == $phys_ptr_cast(q, ^Node) then v else $select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool(M, p)));

axiom (forall M1: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool, M2: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool :: { $eq.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool(M1, M2) } (forall p: $ptr :: $eq.$map_t..^^i4.^^bool($select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool(M1, $phys_ptr_cast(p, ^Node)), $select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool(M2, $phys_ptr_cast(p, ^Node)))) ==> $eq.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool, M2: $map_t..$ptr_to..^Node.$map_t..^^i4.^^bool :: { $eq.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool(M1, M2) } $eq.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^Node.map_t..^^i4.^^bool(0) == $zero.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool;

axiom (forall p: $ptr :: $select.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool($zero.$map_t..$ptr_to..^Node.$map_t..^^i4.^^bool, p) == $zero.$map_t..^^i4.^^bool);

axiom true;

type $map_t..$ptr_to..^Node.^^u4;

function $select.$map_t..$ptr_to..^Node.^^u4(M: $map_t..$ptr_to..^Node.^^u4, p: $ptr) : int;

function $store.$map_t..$ptr_to..^Node.^^u4(M: $map_t..$ptr_to..^Node.^^u4, p: $ptr, v: int) : $map_t..$ptr_to..^Node.^^u4;

function $eq.$map_t..$ptr_to..^Node.^^u4(M1: $map_t..$ptr_to..^Node.^^u4, M2: $map_t..$ptr_to..^Node.^^u4) : bool;

const $zero.$map_t..$ptr_to..^Node.^^u4: $map_t..$ptr_to..^Node.^^u4;

axiom (forall M: $map_t..$ptr_to..^Node.^^u4, p: $ptr, v: int :: true);

axiom (forall M: $map_t..$ptr_to..^Node.^^u4, p: $ptr, v: int, q: $ptr :: $select.$map_t..$ptr_to..^Node.^^u4($store.$map_t..$ptr_to..^Node.^^u4(M, q, v), p) == (if $phys_ptr_cast(p, ^Node) == $phys_ptr_cast(q, ^Node) then $unchecked(^^u4, v) else $select.$map_t..$ptr_to..^Node.^^u4(M, p)));

axiom (forall M1: $map_t..$ptr_to..^Node.^^u4, M2: $map_t..$ptr_to..^Node.^^u4 :: { $eq.$map_t..$ptr_to..^Node.^^u4(M1, M2) } (forall p: $ptr :: $unchecked(^^u4, $select.$map_t..$ptr_to..^Node.^^u4(M1, $phys_ptr_cast(p, ^Node))) == $unchecked(^^u4, $select.$map_t..$ptr_to..^Node.^^u4(M2, $phys_ptr_cast(p, ^Node)))) ==> $eq.$map_t..$ptr_to..^Node.^^u4(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^Node.^^u4, M2: $map_t..$ptr_to..^Node.^^u4 :: { $eq.$map_t..$ptr_to..^Node.^^u4(M1, M2) } $eq.$map_t..$ptr_to..^Node.^^u4(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^Node.^^u4(0) == $zero.$map_t..$ptr_to..^Node.^^u4;

axiom (forall p: $ptr :: $select.$map_t..$ptr_to..^Node.^^u4($zero.$map_t..$ptr_to..^Node.^^u4, p) == 0);

axiom true;

axiom (forall M: $map_t..$ptr_to..^Node.^^u4, p: $ptr :: $in_range_t(^^u4, $select.$map_t..$ptr_to..^Node.^^u4(M, p)));

type $map_t..^^u4.$ptr_to..^Node;

function $select.$map_t..^^u4.$ptr_to..^Node(M: $map_t..^^u4.$ptr_to..^Node, p: int) : $ptr;

function $store.$map_t..^^u4.$ptr_to..^Node(M: $map_t..^^u4.$ptr_to..^Node, p: int, v: $ptr) : $map_t..^^u4.$ptr_to..^Node;

function $eq.$map_t..^^u4.$ptr_to..^Node(M1: $map_t..^^u4.$ptr_to..^Node, M2: $map_t..^^u4.$ptr_to..^Node) : bool;

const $zero.$map_t..^^u4.$ptr_to..^Node: $map_t..^^u4.$ptr_to..^Node;

axiom (forall M: $map_t..^^u4.$ptr_to..^Node, p: int, v: $ptr :: true);

axiom (forall M: $map_t..^^u4.$ptr_to..^Node, p: int, v: $ptr, q: int :: $select.$map_t..^^u4.$ptr_to..^Node($store.$map_t..^^u4.$ptr_to..^Node(M, q, v), p) == (if $unchecked(^^u4, p) == $unchecked(^^u4, q) then $phys_ptr_cast(v, ^Node) else $select.$map_t..^^u4.$ptr_to..^Node(M, p)));

axiom (forall M1: $map_t..^^u4.$ptr_to..^Node, M2: $map_t..^^u4.$ptr_to..^Node :: { $eq.$map_t..^^u4.$ptr_to..^Node(M1, M2) } (forall p: int :: $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node(M1, $unchecked(^^u4, p)), ^Node) == $phys_ptr_cast($select.$map_t..^^u4.$ptr_to..^Node(M2, $unchecked(^^u4, p)), ^Node)) ==> $eq.$map_t..^^u4.$ptr_to..^Node(M1, M2));

axiom (forall M1: $map_t..^^u4.$ptr_to..^Node, M2: $map_t..^^u4.$ptr_to..^Node :: { $eq.$map_t..^^u4.$ptr_to..^Node(M1, M2) } $eq.$map_t..^^u4.$ptr_to..^Node(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^u4.ptr_to..^Node(0) == $zero.$map_t..^^u4.$ptr_to..^Node;

axiom (forall p: int :: $select.$map_t..^^u4.$ptr_to..^Node($zero.$map_t..^^u4.$ptr_to..^Node, p) == $phys_ptr_cast($null, ^Node));

axiom true;

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
