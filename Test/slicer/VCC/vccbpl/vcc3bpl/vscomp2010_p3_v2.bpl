axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

const unique ^_LIST_ENTRY: $ctype;

axiom $is_span_sequential(^_LIST_ENTRY);

axiom $def_struct_type(^_LIST_ENTRY, 8, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_LIST_ENTRY) } $inv2(#s1, #s2, #p, ^_LIST_ENTRY) == $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^_LIST_ENTRY)) } $in(q, $composite_extent(s, p, ^_LIST_ENTRY)) == (q == p));

const unique _LIST_ENTRY.Flink: $field;

axiom $def_phys_field(^_LIST_ENTRY, _LIST_ENTRY.Flink, $ptr_to(^_LIST_ENTRY), false, 0);

const unique _LIST_ENTRY.Blink: $field;

axiom $def_ghost_field(^_LIST_ENTRY, _LIST_ENTRY.Blink, $ptr_to(^_LIST_ENTRY), false);

const unique ^_LIST_MANAGER: $ctype;

axiom $is_span_sequential(^_LIST_MANAGER);

axiom $def_struct_type(^_LIST_MANAGER, 1, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_LIST_MANAGER) } $inv2(#s1, #s2, #p, ^_LIST_MANAGER) == ((forall Q#e$1^27.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv(#s2, _LIST_MANAGER.mem, #p)), $phys_ptr_cast(Q#e$1^27.29#dt1, ^_LIST_ENTRY)) } $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv(#s2, _LIST_MANAGER.mem, #p)), $phys_ptr_cast(Q#e$1^27.29#dt1, ^_LIST_ENTRY)) ==> $keeps(#s2, #p, $phys_ptr_cast(Q#e$1^27.29#dt1, ^_LIST_ENTRY))) && (forall Q#e$1^29.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv(#s2, _LIST_MANAGER.mem, #p)), $rd_phys_ptr(#s2, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#e$1^29.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv(#s2, _LIST_MANAGER.mem, #p)), $rd_phys_ptr(#s2, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#e$1^29.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv(#s2, _LIST_MANAGER.mem, #p)), $phys_ptr_cast(Q#e$1^29.29#dt1, ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv(#s2, _LIST_MANAGER.mem, #p)), $rd_phys_ptr(#s2, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#e$1^29.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr(#s2, _LIST_ENTRY.Blink, $rd_phys_ptr(#s2, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#e$1^29.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#e$1^29.29#dt1, ^_LIST_ENTRY)) && (forall Q#e$1^32.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv(#s2, _LIST_MANAGER.mem, #p)), $rd_phys_ptr(#s2, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#e$1^32.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv(#s2, _LIST_MANAGER.mem, #p)), $rd_phys_ptr(#s2, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#e$1^32.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv(#s2, _LIST_MANAGER.mem, #p)), $phys_ptr_cast(Q#e$1^32.29#dt1, ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv(#s2, _LIST_MANAGER.mem, #p)), $rd_phys_ptr(#s2, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#e$1^32.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr(#s2, _LIST_ENTRY.Flink, $rd_phys_ptr(#s2, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#e$1^32.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#e$1^32.29#dt1, ^_LIST_ENTRY)) && (forall Q#e$1^35.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv(#s2, _LIST_MANAGER.mem, #p)), $phys_ptr_cast(Q#e$1^35.29#dt1, ^_LIST_ENTRY)) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv(#s2, _LIST_MANAGER.mem, #p)), $rd_phys_ptr(#s2, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#e$1^35.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv(#s2, _LIST_MANAGER.mem, #p)), $phys_ptr_cast(Q#e$1^35.29#dt1, ^_LIST_ENTRY)) && $phys_ptr_cast(Q#e$1^35.29#dt1, ^_LIST_ENTRY) != $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv(#s2, _LIST_MANAGER.pointer, #p)), $rd_inv(#s2, _LIST_MANAGER.size, #p) - 1), ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv(#s2, _LIST_MANAGER.index, #p)), $phys_ptr_cast(Q#e$1^35.29#dt1, ^_LIST_ENTRY)) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv(#s2, _LIST_MANAGER.index, #p)), $rd_phys_ptr(#s2, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#e$1^35.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) && (forall Q#e$1^38.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv(#s2, _LIST_MANAGER.mem, #p)), $phys_ptr_cast(Q#e$1^38.29#dt1, ^_LIST_ENTRY)) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv(#s2, _LIST_MANAGER.mem, #p)), $rd_phys_ptr(#s2, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#e$1^38.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv(#s2, _LIST_MANAGER.mem, #p)), $phys_ptr_cast(Q#e$1^38.29#dt1, ^_LIST_ENTRY)) && $phys_ptr_cast(Q#e$1^38.29#dt1, ^_LIST_ENTRY) != $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv(#s2, _LIST_MANAGER.pointer, #p)), 0), ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv(#s2, _LIST_MANAGER.index, #p)), $phys_ptr_cast(Q#e$1^38.29#dt1, ^_LIST_ENTRY)) - 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv(#s2, _LIST_MANAGER.index, #p)), $rd_phys_ptr(#s2, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#e$1^38.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) && (forall Q#i$1^41.29#tc2: int :: {:weight 10} { $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv(#s2, _LIST_MANAGER.pointer, #p)), Q#i$1^41.29#tc2) } 0 <= Q#i$1^41.29#tc2 && Q#i$1^41.29#tc2 < $rd_inv(#s2, _LIST_MANAGER.size, #p) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv(#s2, _LIST_MANAGER.index, #p)), $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv(#s2, _LIST_MANAGER.pointer, #p)), Q#i$1^41.29#tc2), ^_LIST_ENTRY)) == Q#i$1^41.29#tc2 && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv(#s2, _LIST_MANAGER.mem, #p)), $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv(#s2, _LIST_MANAGER.pointer, #p)), Q#i$1^41.29#tc2), ^_LIST_ENTRY))) && (forall Q#e$1^44.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv(#s2, _LIST_MANAGER.mem, #p)), $phys_ptr_cast(Q#e$1^44.29#dt1, ^_LIST_ENTRY)) } { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv(#s2, _LIST_MANAGER.index, #p)), $phys_ptr_cast(Q#e$1^44.29#dt1, ^_LIST_ENTRY)) } $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv(#s2, _LIST_MANAGER.mem, #p)), $phys_ptr_cast(Q#e$1^44.29#dt1, ^_LIST_ENTRY)) ==> 0 <= $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv(#s2, _LIST_MANAGER.index, #p)), $phys_ptr_cast(Q#e$1^44.29#dt1, ^_LIST_ENTRY)) && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv(#s2, _LIST_MANAGER.index, #p)), $phys_ptr_cast(Q#e$1^44.29#dt1, ^_LIST_ENTRY)) < $rd_inv(#s2, _LIST_MANAGER.size, #p) && $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv(#s2, _LIST_MANAGER.pointer, #p)), $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv(#s2, _LIST_MANAGER.index, #p)), $phys_ptr_cast(Q#e$1^44.29#dt1, ^_LIST_ENTRY))), ^_LIST_ENTRY) == $phys_ptr_cast(Q#e$1^44.29#dt1, ^_LIST_ENTRY))));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^_LIST_MANAGER)) } $in(q, $composite_extent(s, p, ^_LIST_MANAGER)) == (q == p));

const unique _LIST_MANAGER.size: $field;

axiom $def_ghost_field(^_LIST_MANAGER, _LIST_MANAGER.size, ^^mathint, false);

const unique _LIST_MANAGER.index: $field;

axiom $def_ghost_field(^_LIST_MANAGER, _LIST_MANAGER.index, $map_t($ptr_to(^_LIST_ENTRY), ^^mathint), false);

const unique _LIST_MANAGER.pointer: $field;

axiom $def_ghost_field(^_LIST_MANAGER, _LIST_MANAGER.pointer, $map_t(^^mathint, $ptr_to(^_LIST_ENTRY)), false);

const unique _LIST_MANAGER.mem: $field;

axiom $def_ghost_field(^_LIST_MANAGER, _LIST_MANAGER.mem, $map_t($ptr_to(^_LIST_ENTRY), ^^bool), false);

procedure _LIST_MANAGER#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> (forall Q#e$1^27.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^27.29#dt1, ^_LIST_ENTRY)) } $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^27.29#dt1, ^_LIST_ENTRY)) ==> $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#e$1^27.29#dt1, ^_LIST_ENTRY)));
  ensures $is_admissibility_check() ==> (forall Q#e$1^29.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#e$1^29.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#e$1^29.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^29.29#dt1, ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#e$1^29.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#e$1^29.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#e$1^29.29#dt1, ^_LIST_ENTRY));
  ensures $is_admissibility_check() ==> (forall Q#e$1^32.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#e$1^32.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#e$1^32.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^32.29#dt1, ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#e$1^32.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Flink, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#e$1^32.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#e$1^32.29#dt1, ^_LIST_ENTRY));
  ensures $is_admissibility_check() ==> (forall Q#e$1^35.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^35.29#dt1, ^_LIST_ENTRY)) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#e$1^35.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^35.29#dt1, ^_LIST_ENTRY)) && $phys_ptr_cast(Q#e$1^35.29#dt1, ^_LIST_ENTRY) != $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER)) - 1), ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^35.29#dt1, ^_LIST_ENTRY)) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#e$1^35.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)));
  ensures $is_admissibility_check() ==> (forall Q#e$1^38.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^38.29#dt1, ^_LIST_ENTRY)) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#e$1^38.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^38.29#dt1, ^_LIST_ENTRY)) && $phys_ptr_cast(Q#e$1^38.29#dt1, ^_LIST_ENTRY) != $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), 0), ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^38.29#dt1, ^_LIST_ENTRY)) - 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#e$1^38.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)));
  ensures $is_admissibility_check() ==> (forall Q#i$1^41.29#tc2: int :: {:weight 10} { $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), Q#i$1^41.29#tc2) } 0 <= Q#i$1^41.29#tc2 && Q#i$1^41.29#tc2 < $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), Q#i$1^41.29#tc2), ^_LIST_ENTRY)) == Q#i$1^41.29#tc2 && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), Q#i$1^41.29#tc2), ^_LIST_ENTRY)));
  ensures $is_admissibility_check() ==> (forall Q#e$1^44.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^44.29#dt1, ^_LIST_ENTRY)) } { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^44.29#dt1, ^_LIST_ENTRY)) } $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^44.29#dt1, ^_LIST_ENTRY)) ==> 0 <= $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^44.29#dt1, ^_LIST_ENTRY)) && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^44.29#dt1, ^_LIST_ENTRY)) < $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER)) && $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^44.29#dt1, ^_LIST_ENTRY))), ^_LIST_ENTRY) == $phys_ptr_cast(Q#e$1^44.29#dt1, ^_LIST_ENTRY));
  ensures $is_unwrap_check() ==> (forall Q#e$1^27.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^27.29#dt1, ^_LIST_ENTRY)) } $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^27.29#dt1, ^_LIST_ENTRY)) ==> $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#e$1^27.29#dt1, ^_LIST_ENTRY)));
  ensures $is_unwrap_check() ==> (forall Q#e$1^29.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#e$1^29.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#e$1^29.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^29.29#dt1, ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#e$1^29.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#e$1^29.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#e$1^29.29#dt1, ^_LIST_ENTRY));
  ensures $is_unwrap_check() ==> (forall Q#e$1^32.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#e$1^32.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#e$1^32.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^32.29#dt1, ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#e$1^32.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Flink, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#e$1^32.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#e$1^32.29#dt1, ^_LIST_ENTRY));
  ensures $is_unwrap_check() ==> (forall Q#e$1^35.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^35.29#dt1, ^_LIST_ENTRY)) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#e$1^35.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^35.29#dt1, ^_LIST_ENTRY)) && $phys_ptr_cast(Q#e$1^35.29#dt1, ^_LIST_ENTRY) != $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER)) - 1), ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^35.29#dt1, ^_LIST_ENTRY)) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#e$1^35.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)));
  ensures $is_unwrap_check() ==> (forall Q#e$1^38.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^38.29#dt1, ^_LIST_ENTRY)) } { sk_hack($select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#e$1^38.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^38.29#dt1, ^_LIST_ENTRY)) && $phys_ptr_cast(Q#e$1^38.29#dt1, ^_LIST_ENTRY) != $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), 0), ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^38.29#dt1, ^_LIST_ENTRY)) - 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#e$1^38.29#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)));
  ensures $is_unwrap_check() ==> (forall Q#i$1^41.29#tc2: int :: {:weight 10} { $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), Q#i$1^41.29#tc2) } 0 <= Q#i$1^41.29#tc2 && Q#i$1^41.29#tc2 < $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), Q#i$1^41.29#tc2), ^_LIST_ENTRY)) == Q#i$1^41.29#tc2 && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), Q#i$1^41.29#tc2), ^_LIST_ENTRY)));
  ensures $is_unwrap_check() ==> (forall Q#e$1^44.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^44.29#dt1, ^_LIST_ENTRY)) } { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^44.29#dt1, ^_LIST_ENTRY)) } $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^44.29#dt1, ^_LIST_ENTRY)) ==> 0 <= $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^44.29#dt1, ^_LIST_ENTRY)) && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^44.29#dt1, ^_LIST_ENTRY)) < $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER)) && $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^44.29#dt1, ^_LIST_ENTRY))), ^_LIST_ENTRY) == $phys_ptr_cast(Q#e$1^44.29#dt1, ^_LIST_ENTRY));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _LIST_MANAGER#adm(P#_this_: $ptr)
{
  var #wrTime$1^21.61: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^21.61, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^21.61, #loc._this_, $ptr_to_int(P#_this_), $spec_ptr_to(^_LIST_MANAGER));
    assume #wrTime$1^21.61 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^21.61, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($spec_ptr_cast(P#_this_, ^_LIST_MANAGER), ^_LIST_MANAGER);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($spec_ptr_cast(P#_this_, ^_LIST_MANAGER));
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
            assume $admissibility_pre($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct _LIST_MANAGER*)@null))
        call $havoc_others($spec_ptr_cast(P#_this_, ^_LIST_MANAGER), ^_LIST_MANAGER);
        assume $good_state_ext(#tok$1^21.61, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), ^_LIST_MANAGER);
    }

  #exit:
}



const unique ^_NODE: $ctype;

axiom $is_span_sequential(^_NODE);

axiom $def_struct_type(^_NODE, 16, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_NODE) } $inv2(#s1, #s2, #p, ^_NODE) == $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^_NODE)) } $in(q, $composite_extent(s, p, ^_NODE)) == (q == p || q == $dot(p, _NODE.List)));

const unique _NODE.List: $field;

axiom $def_phys_field(^_NODE, _NODE.List, ^_LIST_ENTRY, false, 0);

const unique _NODE.data: $field;

axiom $def_phys_field(^_NODE, _NODE.data, ^^i4, false, 8);

const unique ^_LIST: $ctype;

axiom $is_span_sequential(^_LIST);

axiom $def_struct_type(^_LIST, 8, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_LIST) } $inv2(#s1, #s2, #p, ^_LIST) == ($keeps(#s2, #p, $rd_spec_ptr(#s2, _LIST.ListManager, #p, ^_LIST_MANAGER)) && $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv(#s2, _LIST_MANAGER.pointer, $rd_spec_ptr(#s2, _LIST.ListManager, #p, ^_LIST_MANAGER))), 0), ^_LIST_ENTRY) == $dot(#p, _LIST.Head) && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv(#s2, _LIST_MANAGER.index, $rd_spec_ptr(#s2, _LIST.ListManager, #p, ^_LIST_MANAGER))), $dot(#p, _LIST.Head)) == 0 && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv(#s2, _LIST_MANAGER.mem, $rd_spec_ptr(#s2, _LIST.ListManager, #p, ^_LIST_MANAGER))), $dot(#p, _LIST.Head)) && (forall Q#i$2^25.29#tc2: int :: {:weight 10} { $keeps(#s2, #p, $phys_ptr_cast($i8_to_ptr($byte_ptr_subtraction($phys_ptr_cast($phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv(#s2, _LIST_MANAGER.pointer, $rd_spec_ptr(#s2, _LIST.ListManager, #p, ^_LIST_MANAGER))), Q#i$2^25.29#tc2), ^_LIST_ENTRY), ^^u1), $phys_ptr_cast($dot($phys_ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE)) } { sk_hack($keeps(#s2, #p, $phys_ptr_cast($i8_to_ptr($byte_ptr_subtraction($phys_ptr_cast($phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv(#s2, _LIST_MANAGER.pointer, $rd_spec_ptr(#s2, _LIST.ListManager, #p, ^_LIST_MANAGER))), Q#i$2^25.29#tc2), ^_LIST_ENTRY), ^^u1), $phys_ptr_cast($dot($phys_ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE))) } 0 < Q#i$2^25.29#tc2 && Q#i$2^25.29#tc2 < $rd_inv(#s2, _LIST_MANAGER.size, $rd_spec_ptr(#s2, _LIST.ListManager, #p, ^_LIST_MANAGER)) ==> $keeps(#s2, #p, $phys_ptr_cast($i8_to_ptr($byte_ptr_subtraction($phys_ptr_cast($phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv(#s2, _LIST_MANAGER.pointer, $rd_spec_ptr(#s2, _LIST.ListManager, #p, ^_LIST_MANAGER))), Q#i$2^25.29#tc2), ^_LIST_ENTRY), ^^u1), $phys_ptr_cast($dot($phys_ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE)))));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^_LIST)) } $in(q, $composite_extent(s, p, ^_LIST)) == (q == p || q == $dot(p, _LIST.Head)));

const unique _LIST.Head: $field;

axiom $def_phys_field(^_LIST, _LIST.Head, ^_LIST_ENTRY, false, 0);

const unique _LIST.ListManager: $field;

axiom $def_ghost_field(^_LIST, _LIST.ListManager, $spec_ptr_to(^_LIST_MANAGER), false);

procedure _LIST#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $keeps($s, $phys_ptr_cast(P#_this_, ^_LIST), $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#_this_, ^_LIST), ^_LIST_MANAGER));
  ensures $is_admissibility_check() ==> $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#_this_, ^_LIST), ^_LIST_MANAGER))), 0), ^_LIST_ENTRY) == $dot($phys_ptr_cast(P#_this_, ^_LIST), _LIST.Head);
  ensures $is_admissibility_check() ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv($s, _LIST_MANAGER.index, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#_this_, ^_LIST), ^_LIST_MANAGER))), $dot($phys_ptr_cast(P#_this_, ^_LIST), _LIST.Head)) == 0;
  ensures $is_admissibility_check() ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#_this_, ^_LIST), ^_LIST_MANAGER))), $dot($phys_ptr_cast(P#_this_, ^_LIST), _LIST.Head));
  ensures $is_admissibility_check() ==> (forall Q#i$2^25.29#tc2: int :: {:weight 10} { $keeps($s, $phys_ptr_cast(P#_this_, ^_LIST), $phys_ptr_cast($i8_to_ptr($byte_ptr_subtraction($phys_ptr_cast($phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#_this_, ^_LIST), ^_LIST_MANAGER))), Q#i$2^25.29#tc2), ^_LIST_ENTRY), ^^u1), $phys_ptr_cast($dot($phys_ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE)) } { sk_hack($keeps($s, $phys_ptr_cast(P#_this_, ^_LIST), $phys_ptr_cast($i8_to_ptr($byte_ptr_subtraction($phys_ptr_cast($phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#_this_, ^_LIST), ^_LIST_MANAGER))), Q#i$2^25.29#tc2), ^_LIST_ENTRY), ^^u1), $phys_ptr_cast($dot($phys_ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE))) } 0 < Q#i$2^25.29#tc2 && Q#i$2^25.29#tc2 < $rd_inv($s, _LIST_MANAGER.size, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#_this_, ^_LIST), ^_LIST_MANAGER)) ==> $keeps($s, $phys_ptr_cast(P#_this_, ^_LIST), $phys_ptr_cast($i8_to_ptr($byte_ptr_subtraction($phys_ptr_cast($phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#_this_, ^_LIST), ^_LIST_MANAGER))), Q#i$2^25.29#tc2), ^_LIST_ENTRY), ^^u1), $phys_ptr_cast($dot($phys_ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE)));
  ensures $is_unwrap_check() ==> $keeps($s, $phys_ptr_cast(P#_this_, ^_LIST), $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#_this_, ^_LIST), ^_LIST_MANAGER));
  ensures $is_unwrap_check() ==> $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#_this_, ^_LIST), ^_LIST_MANAGER))), 0), ^_LIST_ENTRY) == $dot($phys_ptr_cast(P#_this_, ^_LIST), _LIST.Head);
  ensures $is_unwrap_check() ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint($rd_inv($s, _LIST_MANAGER.index, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#_this_, ^_LIST), ^_LIST_MANAGER))), $dot($phys_ptr_cast(P#_this_, ^_LIST), _LIST.Head)) == 0;
  ensures $is_unwrap_check() ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#_this_, ^_LIST), ^_LIST_MANAGER))), $dot($phys_ptr_cast(P#_this_, ^_LIST), _LIST.Head));
  ensures $is_unwrap_check() ==> (forall Q#i$2^25.29#tc2: int :: {:weight 10} { $keeps($s, $phys_ptr_cast(P#_this_, ^_LIST), $phys_ptr_cast($i8_to_ptr($byte_ptr_subtraction($phys_ptr_cast($phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#_this_, ^_LIST), ^_LIST_MANAGER))), Q#i$2^25.29#tc2), ^_LIST_ENTRY), ^^u1), $phys_ptr_cast($dot($phys_ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE)) } { sk_hack($keeps($s, $phys_ptr_cast(P#_this_, ^_LIST), $phys_ptr_cast($i8_to_ptr($byte_ptr_subtraction($phys_ptr_cast($phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#_this_, ^_LIST), ^_LIST_MANAGER))), Q#i$2^25.29#tc2), ^_LIST_ENTRY), ^^u1), $phys_ptr_cast($dot($phys_ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE))) } 0 < Q#i$2^25.29#tc2 && Q#i$2^25.29#tc2 < $rd_inv($s, _LIST_MANAGER.size, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#_this_, ^_LIST), ^_LIST_MANAGER)) ==> $keeps($s, $phys_ptr_cast(P#_this_, ^_LIST), $phys_ptr_cast($i8_to_ptr($byte_ptr_subtraction($phys_ptr_cast($phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#_this_, ^_LIST), ^_LIST_MANAGER))), Q#i$2^25.29#tc2), ^_LIST_ENTRY), ^^u1), $phys_ptr_cast($dot($phys_ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE)));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _LIST#adm(P#_this_: $ptr)
{
  var #wrTime$2^20.39: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$2^20.39, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$2^20.39, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^_LIST));
    assume #wrTime$2^20.39 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$2^20.39, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($phys_ptr_cast(P#_this_, ^_LIST), ^_LIST);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon7:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $phys_ptr_cast(P#_this_, ^_LIST));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($phys_ptr_cast(P#_this_, ^_LIST));
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
            assume $admissibility_pre($s, $phys_ptr_cast(P#_this_, ^_LIST));
        }
        else
        {
          anon9:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $phys_ptr_cast(P#_this_, ^_LIST));
        }

      anon11:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct _LIST*)@null))
        call $havoc_others($phys_ptr_cast(P#_this_, ^_LIST), ^_LIST);
        assume $good_state_ext(#tok$2^20.39, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $phys_ptr_cast(P#_this_, ^_LIST), ^_LIST);
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



function F#ListInsertAt(SP#m: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, SP#i: int, SP#e: $ptr) : $map_t..^^mathint.$ptr_to..^_LIST_ENTRY;

const unique cf#ListInsertAt: $pure_function;

axiom (forall SP#m: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, SP#i: int, SP#e: $ptr :: { F#ListInsertAt(SP#m, SP#i, SP#e) } $eq.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(F#ListInsertAt(SP#m, SP#i, SP#e), F#lambda#2(SP#m, SP#m, SP#i, $phys_ptr_cast(SP#e, ^_LIST_ENTRY), SP#i)));

axiom $function_arg_type(cf#ListInsertAt, 0, $map_t(^^mathint, $ptr_to(^_LIST_ENTRY)));

axiom $function_arg_type(cf#ListInsertAt, 1, $map_t(^^mathint, $ptr_to(^_LIST_ENTRY)));

axiom $function_arg_type(cf#ListInsertAt, 2, ^^mathint);

axiom $function_arg_type(cf#ListInsertAt, 3, $ptr_to(^_LIST_ENTRY));

procedure ListInsertAt(SP#m: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, SP#i: int, SP#e: $ptr) returns ($result: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY);
  ensures $eq.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($result, F#lambda#2(SP#m, SP#m, SP#i, $phys_ptr_cast(SP#e, ^_LIST_ENTRY), SP#i));
  free ensures $result == F#ListInsertAt(SP#m, SP#i, SP#e);
  free ensures $call_transition(old($s), $s);



procedure find(P#l: $ptr) returns ($result: int);
  requires $wrapped($s, $phys_ptr_cast(P#l, ^_LIST), ^_LIST);
  requires $rd_inv($s, _LIST_MANAGER.size, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#l, ^_LIST), ^_LIST_MANAGER)) < 4294967295;
  modifies $s, $cev_pc;
  free ensures $in_range_u4($result);
  ensures (forall Q#j$2^32.27#tc2: int :: {:weight 10} { $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#l, ^_LIST), ^_LIST_MANAGER))), Q#j$2^32.27#tc2) } 0 < Q#j$2^32.27#tc2 && Q#j$2^32.27#tc2 < $result ==> $rd_inv($s, _NODE.data, $phys_ptr_cast($i8_to_ptr($byte_ptr_subtraction($phys_ptr_cast($phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#l, ^_LIST), ^_LIST_MANAGER))), Q#j$2^32.27#tc2), ^_LIST_ENTRY), ^^u1), $phys_ptr_cast($dot($phys_ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE)) != 0);
  ensures $result < $rd_inv($s, _LIST_MANAGER.size, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#l, ^_LIST), ^_LIST_MANAGER)) ==> $rd_inv($s, _NODE.data, $phys_ptr_cast($i8_to_ptr($byte_ptr_subtraction($phys_ptr_cast($phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#l, ^_LIST), ^_LIST_MANAGER))), $result), ^_LIST_ENTRY), ^^u1), $phys_ptr_cast($dot($phys_ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE)) == 0;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation find(P#l: $ptr) returns ($result: int)
{
  var loopState#0: $state;
  var L#n: $ptr;
  var L#le: $ptr;
  var L#i: int where $in_range_u4(L#i);
  var #wrTime$2^29.1: int;
  var #stackframe: int;

  anon19:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$2^29.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$2^29.1, #loc.l, $ptr_to_int(P#l), $ptr_to(^_LIST));
    assume #wrTime$2^29.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$2^29.1, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, l, l); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#l, ^_LIST), $phys_ptr_cast(P#l, ^_LIST), l#public);
    // uint32_t i; 
    assume $local_value_is($s, #tok$2^39.3, #loc.i, L#i, ^^u4);
    // struct _LIST_ENTRY* le; 
    assume $local_value_is($s, #tok$2^38.3, #loc.le, $ptr_to_int(L#le), $ptr_to(^_LIST_ENTRY));
    // struct _NODE* n; 
    assume $local_value_is($s, #tok$2^37.3, #loc.n, $ptr_to_int(L#n), $ptr_to(^_NODE));
    // var struct _NODE* n
    // var struct _LIST_ENTRY* le
    // var uint32_t i
    // assert @_vcc_in_domain(@state, *((l->ListManager)), l); 
    assert $in_domain_lab($s, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#l, ^_LIST), ^_LIST_MANAGER), $phys_ptr_cast(P#l, ^_LIST), l#public);
    // assume @_vcc_in_domain(@state, *((l->ListManager)), l); 
    assume $in_domain_lab($s, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#l, ^_LIST), ^_LIST_MANAGER), $phys_ptr_cast(P#l, ^_LIST), l#public);
    // assert @reads_check_normal(((l->Head)->Flink)); 
    assert $thread_local($s, $dot($phys_ptr_cast(P#l, ^_LIST), _LIST.Head));
    // le := *(((l->Head)->Flink)); 
    L#le := $rd_phys_ptr($s, _LIST_ENTRY.Flink, $dot($phys_ptr_cast(P#l, ^_LIST), _LIST.Head), ^_LIST_ENTRY);
    assume $local_value_is($s, #tok$2^43.3, #loc.le, $ptr_to_int(L#le), $ptr_to(^_LIST_ENTRY));
    // i := 1; 
    L#i := 1;
    assume $local_value_is($s, #tok$2^44.3, #loc.i, L#i, ^^u4);
    loopState#0 := $s;
    while (true)
      invariant $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool($rd_inv($s, _LIST_MANAGER.mem, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#l, ^_LIST), ^_LIST_MANAGER))), $phys_ptr_cast(L#le, ^_LIST_ENTRY));
      invariant L#i <= $rd_inv($s, _LIST_MANAGER.size, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#l, ^_LIST), ^_LIST_MANAGER));
      invariant (forall Q#j$2^49.31#tc2: int :: {:weight 10} { $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#l, ^_LIST), ^_LIST_MANAGER))), Q#j$2^49.31#tc2) } 0 < Q#j$2^49.31#tc2 && Q#j$2^49.31#tc2 < L#i ==> $rd_inv($s, _NODE.data, $phys_ptr_cast($i8_to_ptr($byte_ptr_subtraction($phys_ptr_cast($phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#l, ^_LIST), ^_LIST_MANAGER))), Q#j$2^49.31#tc2), ^_LIST_ENTRY), ^^u1), $phys_ptr_cast($dot($phys_ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE)) != 0);
      invariant $phys_ptr_cast(L#le, ^_LIST_ENTRY) == $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#l, ^_LIST), ^_LIST_MANAGER))), (if L#i == $rd_inv($s, _LIST_MANAGER.size, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#l, ^_LIST), ^_LIST_MANAGER)) then 0 else L#i)), ^_LIST_ENTRY);
    {
      anon18:
        assume $writes_nothing(old($s), $s);
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$2^46.3, $s);
        assume $local_value_is($s, #tok$2^46.3, #loc.n, $ptr_to_int(L#n), $ptr_to(^_NODE));
        assume $local_value_is($s, #tok$2^46.3, #loc.le, $ptr_to_int(L#le), $ptr_to(^_LIST_ENTRY));
        assume $local_value_is($s, #tok$2^46.3, #loc.l, $ptr_to_int(P#l), $ptr_to(^_LIST));
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#0, $s);
        assume true;
        // if (@_vcc_ptr_neq(le, (l->Head))) ...
        if ($ptr_neq($phys_ptr_cast(L#le, ^_LIST_ENTRY), $dot($phys_ptr_cast(P#l, ^_LIST), _LIST.Head)))
        {
          anon15:
            // n := (struct _NODE*)@_vcc_i8_to_ptr(@_vcc_byte_ptr_subtraction((uint8_t*)le, (uint8_t*)((struct _NODE*)@null->List))); 
            L#n := $phys_ptr_cast($i8_to_ptr($byte_ptr_subtraction($phys_ptr_cast($phys_ptr_cast(L#le, ^_LIST_ENTRY), ^^u1), $phys_ptr_cast($dot($phys_ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE);
            assume $local_value_is($s, #tok$2^53.5, #loc.n, $ptr_to_int(L#n), $ptr_to(^_NODE));
            // assert @reads_check_normal((n->data)); 
            assert $thread_local($s, $phys_ptr_cast(L#n, ^_NODE));
            assume true;
            // if (==(*((n->data)), 0)) ...
            if ($rd_inv($s, _NODE.data, $phys_ptr_cast(L#n, ^_NODE)) == 0)
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
            assert (forall Q#j$2^57.28#tc2: int :: {:weight 10} { $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#l, ^_LIST), ^_LIST_MANAGER))), Q#j$2^57.28#tc2) } 0 < Q#j$2^57.28#tc2 && Q#j$2^57.28#tc2 <= L#i ==> $rd_inv($s, _NODE.data, $phys_ptr_cast($i8_to_ptr($byte_ptr_subtraction($phys_ptr_cast($phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#l, ^_LIST), ^_LIST_MANAGER))), Q#j$2^57.28#tc2), ^_LIST_ENTRY), ^^u1), $phys_ptr_cast($dot($phys_ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE)) != 0);
            // assume forall(mathint j; true; ==>(&&(<(0, j), <=(j, i)), !=(*(((struct _NODE*)@_vcc_i8_to_ptr(@_vcc_byte_ptr_subtraction((uint8_t*)@map_get(*((*((l->ListManager))->pointer)), j), (uint8_t*)((struct _NODE*)@null->List)))->data)), 0))); 
            assume (forall Q#j$2^57.28#tc2: int :: {:weight 10} { $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#l, ^_LIST), ^_LIST_MANAGER))), Q#j$2^57.28#tc2) } 0 < Q#j$2^57.28#tc2 && Q#j$2^57.28#tc2 <= L#i ==> $rd_inv($s, _NODE.data, $phys_ptr_cast($i8_to_ptr($byte_ptr_subtraction($phys_ptr_cast($phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY($rd_inv($s, _LIST_MANAGER.pointer, $rd_spec_ptr($s, _LIST.ListManager, $phys_ptr_cast(P#l, ^_LIST), ^_LIST_MANAGER))), Q#j$2^57.28#tc2), ^_LIST_ENTRY), ^^u1), $phys_ptr_cast($dot($phys_ptr_cast($null, ^_NODE), _NODE.List), ^^u1))), ^_NODE)) != 0);
            // assert @reads_check_normal((le->Flink)); 
            assert $thread_local($s, $phys_ptr_cast(L#le, ^_LIST_ENTRY));
            // le := *((le->Flink)); 
            L#le := $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(L#le, ^_LIST_ENTRY), ^_LIST_ENTRY);
            assume $local_value_is($s, #tok$2^59.5, #loc.le, $ptr_to_int(L#le), $ptr_to(^_LIST_ENTRY));
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



function F#lambda#2(#l4: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l3: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l2: int, #l1: $ptr, #l0: int) : $map_t..^^mathint.$ptr_to..^_LIST_ENTRY;

const unique cf#lambda#2: $pure_function;

axiom $function_arg_type(cf#lambda#2, 0, $map_t(^^mathint, $ptr_to(^_LIST_ENTRY)));

axiom $function_arg_type(cf#lambda#2, 1, $map_t(^^mathint, $ptr_to(^_LIST_ENTRY)));

axiom $function_arg_type(cf#lambda#2, 2, $map_t(^^mathint, $ptr_to(^_LIST_ENTRY)));

axiom $function_arg_type(cf#lambda#2, 3, ^^mathint);

axiom $function_arg_type(cf#lambda#2, 4, $ptr_to(^_LIST_ENTRY));

axiom $function_arg_type(cf#lambda#2, 5, ^^mathint);

procedure lambda#2(#l4: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l3: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l2: int, #l1: $ptr, #l0: int) returns ($result: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY);
  free ensures $result == F#lambda#2(#l4, #l3, #l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#j$1^19.27#tc2: int, #l4: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l3: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l2: int, #l1: $ptr, #l0: int :: {:weight 10} { $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(F#lambda#2(#l4, #l3, #l2, $phys_ptr_cast(#l1, ^_LIST_ENTRY), #l0), Q#j$1^19.27#tc2) } $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(F#lambda#2(#l4, #l3, #l2, $phys_ptr_cast(#l1, ^_LIST_ENTRY), #l0), Q#j$1^19.27#tc2), ^_LIST_ENTRY) == (if Q#j$1^19.27#tc2 == #l0 then $phys_ptr_cast(#l1, ^_LIST_ENTRY) else (if Q#j$1^19.27#tc2 < #l2 then $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(#l3, Q#j$1^19.27#tc2), ^_LIST_ENTRY) else $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(#l4, Q#j$1^19.27#tc2 - 1), ^_LIST_ENTRY))));

function F#lambda#1(#l2: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l1: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l0: int) : $map_t..^^mathint.$ptr_to..^_LIST_ENTRY;

const unique cf#lambda#1: $pure_function;

axiom $function_arg_type(cf#lambda#1, 0, $map_t(^^mathint, $ptr_to(^_LIST_ENTRY)));

axiom $function_arg_type(cf#lambda#1, 1, $map_t(^^mathint, $ptr_to(^_LIST_ENTRY)));

axiom $function_arg_type(cf#lambda#1, 2, $map_t(^^mathint, $ptr_to(^_LIST_ENTRY)));

axiom $function_arg_type(cf#lambda#1, 3, ^^mathint);

procedure lambda#1(#l2: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l1: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l0: int) returns ($result: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY);
  free ensures $result == F#lambda#1(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#j$1^16.27#tc2: int, #l2: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l1: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, #l0: int :: {:weight 10} { $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(F#lambda#1(#l2, #l1, #l0), Q#j$1^16.27#tc2) } $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(F#lambda#1(#l2, #l1, #l0), Q#j$1^16.27#tc2), ^_LIST_ENTRY) == (if Q#j$1^16.27#tc2 < #l0 then $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(#l1, Q#j$1^16.27#tc2), ^_LIST_ENTRY) else $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(#l2, Q#j$1^16.27#tc2 + 1), ^_LIST_ENTRY)));

const unique l#public: $label;

type $map_t..$ptr_to..^_LIST_ENTRY.^^bool;

function $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool(M: $map_t..$ptr_to..^_LIST_ENTRY.^^bool, p: $ptr) : bool;

function $store.$map_t..$ptr_to..^_LIST_ENTRY.^^bool(M: $map_t..$ptr_to..^_LIST_ENTRY.^^bool, p: $ptr, v: bool) : $map_t..$ptr_to..^_LIST_ENTRY.^^bool;

function $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^bool(M1: $map_t..$ptr_to..^_LIST_ENTRY.^^bool, M2: $map_t..$ptr_to..^_LIST_ENTRY.^^bool) : bool;

const $zero.$map_t..$ptr_to..^_LIST_ENTRY.^^bool: $map_t..$ptr_to..^_LIST_ENTRY.^^bool;

axiom (forall M: $map_t..$ptr_to..^_LIST_ENTRY.^^bool, p: $ptr, v: bool :: true);

axiom (forall M: $map_t..$ptr_to..^_LIST_ENTRY.^^bool, p: $ptr, v: bool, q: $ptr :: $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($store.$map_t..$ptr_to..^_LIST_ENTRY.^^bool(M, q, v), p) == (if $phys_ptr_cast(p, ^_LIST_ENTRY) == $phys_ptr_cast(q, ^_LIST_ENTRY) then v else $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool(M, p)));

axiom (forall M1: $map_t..$ptr_to..^_LIST_ENTRY.^^bool, M2: $map_t..$ptr_to..^_LIST_ENTRY.^^bool :: { $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^bool(M1, M2) } (forall p: $ptr :: $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool(M1, $phys_ptr_cast(p, ^_LIST_ENTRY)) == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool(M2, $phys_ptr_cast(p, ^_LIST_ENTRY))) ==> $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^bool(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^_LIST_ENTRY.^^bool, M2: $map_t..$ptr_to..^_LIST_ENTRY.^^bool :: { $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^bool(M1, M2) } $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^bool(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^_LIST_ENTRY.^^bool(0) == $zero.$map_t..$ptr_to..^_LIST_ENTRY.^^bool;

axiom (forall p: $ptr :: $select.$map_t..$ptr_to..^_LIST_ENTRY.^^bool($zero.$map_t..$ptr_to..^_LIST_ENTRY.^^bool, p) == false);

axiom true;

type $map_t..^^mathint.$ptr_to..^_LIST_ENTRY;

function $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, p: int) : $ptr;

function $store.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, p: int, v: $ptr) : $map_t..^^mathint.$ptr_to..^_LIST_ENTRY;

function $eq.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M1: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, M2: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY) : bool;

const $zero.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY;

axiom (forall M: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, p: int, v: $ptr :: true);

axiom (forall M: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, p: int, v: $ptr, q: int :: $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($store.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M, q, v), p) == (if p == q then $phys_ptr_cast(v, ^_LIST_ENTRY) else $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M, p)));

axiom (forall M1: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, M2: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY :: { $eq.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M1, M2) } (forall p: int :: $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M1, p), ^_LIST_ENTRY) == $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M2, p), ^_LIST_ENTRY)) ==> $eq.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M1, M2));

axiom (forall M1: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, M2: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY :: { $eq.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M1, M2) } $eq.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^mathint.ptr_to..^_LIST_ENTRY(0) == $zero.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY;

axiom (forall p: int :: $select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY($zero.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY, p) == $phys_ptr_cast($null, ^_LIST_ENTRY));

axiom true;

axiom (forall M: $map_t..^^mathint.$ptr_to..^_LIST_ENTRY, p: int :: $in_range_phys_ptr($select.$map_t..^^mathint.$ptr_to..^_LIST_ENTRY(M, p)));

type $map_t..$ptr_to..^_LIST_ENTRY.^^mathint;

function $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint(M: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint, p: $ptr) : int;

function $store.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint(M: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint, p: $ptr, v: int) : $map_t..$ptr_to..^_LIST_ENTRY.^^mathint;

function $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint(M1: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint, M2: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint) : bool;

const $zero.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint;

axiom (forall M: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint, p: $ptr, v: int :: true);

axiom (forall M: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint, p: $ptr, v: int, q: $ptr :: $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($store.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint(M, q, v), p) == (if $phys_ptr_cast(p, ^_LIST_ENTRY) == $phys_ptr_cast(q, ^_LIST_ENTRY) then v else $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint(M, p)));

axiom (forall M1: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint, M2: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint :: { $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint(M1, M2) } (forall p: $ptr :: $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint(M1, $phys_ptr_cast(p, ^_LIST_ENTRY)) == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint(M2, $phys_ptr_cast(p, ^_LIST_ENTRY))) ==> $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint, M2: $map_t..$ptr_to..^_LIST_ENTRY.^^mathint :: { $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint(M1, M2) } $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^_LIST_ENTRY.^^mathint(0) == $zero.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint;

axiom (forall p: $ptr :: $select.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint($zero.$map_t..$ptr_to..^_LIST_ENTRY.^^mathint, p) == 0);

axiom true;

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
