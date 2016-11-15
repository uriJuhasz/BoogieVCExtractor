axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

const unique ^_LIST_ENTRY: $ctype;

axiom $is_span_sequential(^_LIST_ENTRY);

axiom $def_struct_type(^_LIST_ENTRY, 16, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_LIST_ENTRY) } $inv2(#s1, #s2, #p, ^_LIST_ENTRY) == $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^_LIST_ENTRY)) } $in(q, $composite_extent(s, p, ^_LIST_ENTRY)) == (q == p));

const unique _LIST_ENTRY.Flink: $field;

axiom $def_phys_field(^_LIST_ENTRY, _LIST_ENTRY.Flink, $ptr_to(^_LIST_ENTRY), false, 0);

const unique _LIST_ENTRY.Blink: $field;

axiom $def_phys_field(^_LIST_ENTRY, _LIST_ENTRY.Blink, $ptr_to(^_LIST_ENTRY), false, 8);

const unique _LIST_ENTRY.Manager: $field;

axiom $def_ghost_field(^_LIST_ENTRY, _LIST_ENTRY.Manager, $spec_ptr_to(^_LIST_MANAGER), false);

const unique ^_LIST_MANAGER: $ctype;

axiom $is_span_sequential(^_LIST_MANAGER);

axiom $def_struct_type(^_LIST_MANAGER, 1, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_LIST_MANAGER) } $inv2(#s1, #s2, #p, ^_LIST_MANAGER) == ((forall Q#p$1^47.31#dt1: $ptr :: {:weight 10} { $keeps(#s2, #p, $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY)) } $keeps(#s2, #p, $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY)) ==> $rd_spec_ptr(#s2, _LIST_ENTRY.Manager, $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY), ^_LIST_MANAGER) == #p) && $keeps(#s2, #p, $rd_phys_ptr(#s2, _LIST_MANAGER.ListHead, #p, ^_LIST_ENTRY)) && $keeps(#s2, #p, $rd_phys_ptr(#s2, _LIST_ENTRY.Blink, $rd_phys_ptr(#s2, _LIST_MANAGER.ListHead, #p, ^_LIST_ENTRY), ^_LIST_ENTRY)) && (forall Q#p$1^60.31#dt1: $ptr :: {:weight 10} { $keeps(#s2, #p, $rd_phys_ptr(#s2, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($keeps(#s2, #p, $rd_phys_ptr(#s2, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps(#s2, #p, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY)) ==> $keeps(#s2, #p, $rd_phys_ptr(#s2, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr(#s2, _LIST_ENTRY.Blink, $rd_phys_ptr(#s2, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY)) && (forall Q#p$1^66.31#dt1: $ptr :: {:weight 10} { $keeps(#s2, #p, $rd_phys_ptr(#s2, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($keeps(#s2, #p, $rd_phys_ptr(#s2, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps(#s2, #p, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY)) ==> $keeps(#s2, #p, $rd_phys_ptr(#s2, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr(#s2, _LIST_ENTRY.Flink, $rd_phys_ptr(#s2, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY)) && (forall Q#p$1^75.31#dt1: $ptr :: {:weight 10} { $keeps(#s2, #p, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) } { sk_hack($keeps(#s2, #p, $rd_phys_ptr(#s2, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps(#s2, #p, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) && $rd_phys_ptr(#s2, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY) != $rd_phys_ptr(#s2, _LIST_MANAGER.ListHead, #p, ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv(#s2, _LIST_MANAGER.index, #p)), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv(#s2, _LIST_MANAGER.index, #p)), $rd_phys_ptr(#s2, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv(#s2, _LIST_MANAGER.index, #p)), $rd_phys_ptr(#s2, _LIST_MANAGER.ListHead, #p, ^_LIST_ENTRY)) == 0 && $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv(#s2, _LIST_MANAGER.index, #p)), $rd_phys_ptr(#s2, _LIST_ENTRY.Blink, $rd_phys_ptr(#s2, _LIST_MANAGER.ListHead, #p, ^_LIST_ENTRY), ^_LIST_ENTRY)) == $rd_inv(#s2, _LIST_MANAGER.size, #p) - 1 && (forall Q#e$1^83.31#dt1: $ptr :: {:weight 10} { $keeps(#s2, #p, $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) } $keeps(#s2, #p, $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv(#s2, _LIST_MANAGER.index, #p)), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) < $rd_inv(#s2, _LIST_MANAGER.size, #p)) && (forall Q#e1$1^87.31#dt1: $ptr, Q#e2$1^87.31#dt1: $ptr :: {:weight 10} { $keeps(#s2, #p, $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)), $keeps(#s2, #p, $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)) } $keeps(#s2, #p, $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)) && $keeps(#s2, #p, $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)) && $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY) != $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv(#s2, _LIST_MANAGER.index, #p)), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)) != $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv(#s2, _LIST_MANAGER.index, #p)), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)))));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^_LIST_MANAGER)) } $in(q, $composite_extent(s, p, ^_LIST_MANAGER)) == (q == p));

const unique _LIST_MANAGER.size: $field;

axiom $def_ghost_field(^_LIST_MANAGER, _LIST_MANAGER.size, ^^u4, false);

const unique _LIST_MANAGER.ListHead: $field;

axiom $def_ghost_field(^_LIST_MANAGER, _LIST_MANAGER.ListHead, $ptr_to(^_LIST_ENTRY), false);

const unique _LIST_MANAGER.index: $field;

axiom $def_ghost_field(^_LIST_MANAGER, _LIST_MANAGER.index, $map_t($ptr_to(^_LIST_ENTRY), ^^u4), false);

procedure _LIST_MANAGER#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> (forall Q#p$1^47.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY)) ==> $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY), ^_LIST_MANAGER) == $spec_ptr_cast(P#_this_, ^_LIST_MANAGER));
  ensures $is_admissibility_check() ==> $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), ^_LIST_ENTRY));
  ensures $is_admissibility_check() ==> $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), ^_LIST_ENTRY), ^_LIST_ENTRY));
  ensures $is_admissibility_check() ==> (forall Q#p$1^60.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY)) ==> $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY));
  ensures $is_admissibility_check() ==> (forall Q#p$1^66.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY)) ==> $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Flink, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY));
  ensures $is_admissibility_check() ==> (forall Q#p$1^75.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY) != $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)));
  ensures $is_admissibility_check() ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), ^_LIST_ENTRY)) == 0;
  ensures $is_admissibility_check() ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), ^_LIST_ENTRY), ^_LIST_ENTRY)) == $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER)) - 1;
  ensures $is_admissibility_check() ==> (forall Q#e$1^83.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) < $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER)));
  ensures $is_admissibility_check() ==> (forall Q#e1$1^87.31#dt1: $ptr, Q#e2$1^87.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)), $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)) && $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)) && $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY) != $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)) != $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)));
  ensures $is_unwrap_check() ==> (forall Q#p$1^47.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY)) ==> $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY), ^_LIST_MANAGER) == $spec_ptr_cast(P#_this_, ^_LIST_MANAGER));
  ensures $is_unwrap_check() ==> $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), ^_LIST_ENTRY));
  ensures $is_unwrap_check() ==> $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), ^_LIST_ENTRY), ^_LIST_ENTRY));
  ensures $is_unwrap_check() ==> (forall Q#p$1^60.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY)) ==> $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY));
  ensures $is_unwrap_check() ==> (forall Q#p$1^66.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY)) ==> $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Flink, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY));
  ensures $is_unwrap_check() ==> (forall Q#p$1^75.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY) != $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)));
  ensures $is_unwrap_check() ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), ^_LIST_ENTRY)) == 0;
  ensures $is_unwrap_check() ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), ^_LIST_ENTRY), ^_LIST_ENTRY)) == $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER)) - 1;
  ensures $is_unwrap_check() ==> (forall Q#e$1^83.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) < $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER)));
  ensures $is_unwrap_check() ==> (forall Q#e1$1^87.31#dt1: $ptr, Q#e2$1^87.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)), $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)) && $keeps($s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)) && $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY) != $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)) != $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _LIST_MANAGER#adm(P#_this_: $ptr)
{
  var #wrTime$1^37.53: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^37.53, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^37.53, #loc._this_, $ptr_to_int(P#_this_), $spec_ptr_to(^_LIST_MANAGER));
    assume #wrTime$1^37.53 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^37.53, (lambda #p: $ptr :: false));
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
        assume $good_state_ext(#tok$1^37.53, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $spec_ptr_cast(P#_this_, ^_LIST_MANAGER), ^_LIST_MANAGER);
    }

  #exit:
}



procedure InitializeListHead(P#ListHead: $ptr);
  modifies $s, $cev_pc;
  ensures $wrapped($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_MANAGER) && $is_fresh(old($s), $s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER));
  ensures $set_eq($owns($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)), $set_singleton($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY))) && $set_in($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $owns($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)));
  ensures $rd_inv($s, _LIST_MANAGER.size, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)) == 1;
  ensures $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_ENTRY) == $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: $set_in(#p, $span($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY)))));
  free ensures $call_transition(old($s), $s);



implementation InitializeListHead(P#ListHead: $ptr)
{
  var prestate#14: $state;
  var owns#12: $ptrset;
  var staticWrapState#11: $state;
  var prestate#13: $state;
  var SL#ListManager: $ptr;
  var #wrTime$2^7.1: int;
  var #stackframe: int;

  anon7:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$2^7.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$2^7.1, #loc.ListHead, $ptr_to_int(P#ListHead), $ptr_to(^_LIST_ENTRY));
    assume #wrTime$2^7.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$2^7.1, (lambda #p: $ptr :: $set_in(#p, $span($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY)))));
    assume $mutable($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // struct _LIST_MANAGER^ ListManager; 
    assume $local_value_is($s, #tok$2^9.27, #loc.ListManager, $ptr_to_int(SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // var spec struct _LIST_MANAGER^ ListManager
    // assert @prim_writes_check((ListHead->Blink)); 
    assert $writable_prim($s, #wrTime$2^7.1, $dot($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), _LIST_ENTRY.Blink));
    // *(ListHead->Blink) := ListHead; 
    call $write_int(_LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $ptr_to_int($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY)));
    assume $full_stop_ext(#tok$2^10.23, $s);
    // assert @prim_writes_check((ListHead->Flink)); 
    assert $writable_prim($s, #wrTime$2^7.1, $dot($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), _LIST_ENTRY.Flink));
    // *(ListHead->Flink) := ListHead; 
    call $write_int(_LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $ptr_to_int($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY)));
    assume $full_stop_ext(#tok$2^10.5, $s);
    // ListManager := _vcc_spec_alloc<struct _LIST_MANAGER>(); 
    call SL#ListManager := $spec_alloc(^_LIST_MANAGER);
    assume $full_stop_ext(#tok$2^13.19, $s);
    assume $local_value_is($s, #tok$2^13.19, #loc.ListManager, $ptr_to_int(SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // assert @prim_writes_check((ListManager->size)); 
    assert $writable_prim($s, #wrTime$2^7.1, $dot($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), _LIST_MANAGER.size));
    // *(ListManager->size) := 1; 
    call $write_int(_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), 1);
    assume $full_stop_ext(#tok$2^14.5, $s);
    // assert @prim_writes_check((ListManager->index)); 
    assert $writable_prim($s, #wrTime$2^7.1, $dot($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), _LIST_MANAGER.index));
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // *(ListManager->index) := @map_updated(*((ListManager->index)), ListHead, 0); 
    call $write_int(_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int($store.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), 0)));
    assume $full_stop_ext(#tok$2^15.5, $s);
    // assert @prim_writes_check((ListManager->ListHead)); 
    assert $writable_prim($s, #wrTime$2^7.1, $dot($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), _LIST_MANAGER.ListHead));
    // *(ListManager->ListHead) := ListHead; 
    call $write_int(_LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $ptr_to_int($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY)));
    assume $full_stop_ext(#tok$2^16.5, $s);
    // assert @prim_writes_check((ListHead->Manager)); 
    assert $writable_prim($s, #wrTime$2^7.1, $dot($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), _LIST_ENTRY.Manager));
    // *(ListHead->Manager) := ListManager; 
    call $write_int(_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $ptr_to_int($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)));
    assume $full_stop_ext(#tok$2^17.5, $s);
    // assert @writes_check(@_vcc_span(ListManager)); 
    assert (forall #writes$2^18.27: $ptr :: { $dont_instantiate(#writes$2^18.27) } $set_in(#writes$2^18.27, $span($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))) ==> $top_writable($s, #wrTime$2^7.1, #writes$2^18.27));
    // stmt _vcc_set_owns(ListManager, @_vcc_set_singleton(ListHead)); 
    call $set_owns($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $set_singleton($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY)));
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
    assert $top_writable($s, #wrTime$2^7.1, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(ListHead), staticWrapState#11, owns#12)
    call $static_wrap($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), staticWrapState#11, owns#12);
    assume $good_state_ext(#tok$2^19.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, ListHead), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY)), $set_empty());
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
    assert $top_writable($s, #wrTime$2^7.1, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @writes_check(@_vcc_owns(@state, ListManager)); 
    assert (forall #writes$2^20.21: $ptr :: { $dont_instantiate(#writes$2^20.21) } $set_in(#writes$2^20.21, $owns($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))) ==> $top_writable($s, #wrTime$2^7.1, #writes$2^20.21));
    // stmt @_vcc_wrap(ListManager, @_vcc_typeof(ListManager)); 
    call $wrap($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_MANAGER);
    assume $good_state_ext(#tok$2^20.21, $s);
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } true; ==>(@keeps(ListManager, p), @_vcc_ptr_eq_pure(*((p->Manager)), ListManager)))); 
    assert (forall Q#p$1^47.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY)) ==> $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY), ^_LIST_MANAGER) == $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @inv_check(@keeps(ListManager, *((ListManager->ListHead)))); 
    assert $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY));
    // assert @inv_check(@keeps(ListManager, *((*((ListManager->ListHead))->Blink)))); 
    assert $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY), ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Flink))) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } true; ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Flink))), @_vcc_ptr_eq_pure(*((*((p->Flink))->Blink)), p))))); 
    assert (forall Q#p$1^60.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY)) ==> $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Blink))) } { @trigger_hint(@keeps(ListManager, *((p->Blink)))) } true; ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Blink))), @_vcc_ptr_eq_pure(*((*((p->Blink))->Flink)), p))))); 
    assert (forall Q#p$1^66.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY)) ==> $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Flink, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } true; ==>(&&(@keeps(ListManager, p), @_vcc_ptr_neq_pure(*((p->Flink)), *((ListManager->ListHead)))), ==(+(@map_get(*((ListManager->index)), p), 1), @map_get(*((ListManager->index)), *((p->Flink))))))); 
    assert (forall Q#p$1^75.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY) != $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)));
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((ListManager->ListHead))), 0)); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY)) == 0;
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((*((ListManager->ListHead))->Blink))), -(*((ListManager->size)), 1))); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY), ^_LIST_ENTRY)) == $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)) - 1;
    // assert @inv_check(forall(struct _LIST_ENTRY* e; { @keeps(ListManager, e) } true; ==>(@keeps(ListManager, e), <(@map_get(*((ListManager->index)), e), *((ListManager->size)))))); 
    assert (forall Q#e$1^83.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) < $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)));
    // assert @inv_check(forall(struct _LIST_ENTRY* e1; struct _LIST_ENTRY* e2; { @keeps(ListManager, e1), @keeps(ListManager, e2) } true; ==>(&&(&&(@keeps(ListManager, e1), @keeps(ListManager, e2)), @_vcc_ptr_neq_pure(e1, e2)), !=(@map_get(*((ListManager->index)), e1), @map_get(*((ListManager->index)), e2))))); 
    assert (forall Q#e1$1^87.31#dt1: $ptr, Q#e2$1^87.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)), $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)) && $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)) && $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY) != $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)) != $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure IsListEmpty(P#ListHead: $ptr) returns ($result: bool);
  requires $wrapped($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_MANAGER);
  requires $set_in($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $owns($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)));
  modifies $s, $cev_pc;
  ensures $result == ($rd_inv($s, _LIST_MANAGER.size, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)) == 1);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation IsListEmpty(P#ListHead: $ptr) returns ($result: bool)
{
  var #wrTime$2^24.1: int;
  var #stackframe: int;

  anon8:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$2^24.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$2^24.1, #loc.ListHead, $ptr_to_int(P#ListHead), $ptr_to(^_LIST_ENTRY));
    assume #wrTime$2^24.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$2^24.1, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, *((ListHead->Manager)), *((ListHead->Manager))); 
    assert $in_domain_lab($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), l#public);
    // assert @_vcc_set_in(*((ListHead->Flink)), @_vcc_owns(@state, *((ListHead->Manager)))); 
    assert $set_in($rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), $owns($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)));
    // assume @_vcc_set_in(*((ListHead->Flink)), @_vcc_owns(@state, *((ListHead->Manager)))); 
    assume $set_in($rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), $owns($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)));
    // assert @reads_check_normal((ListHead->Flink)); 
    assert $thread_local($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // return @_vcc_ptr_eq(*((ListHead->Flink)), ListHead); 
    $result := $ptr_eq($rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    assert $position_marker();
    goto #exit;

  anon9:
    // empty

  #exit:
}



procedure RemoveEntryList(P#Entry: $ptr) returns ($result: bool);
  requires $set_in($phys_ptr_cast(P#Entry, ^_LIST_ENTRY), $owns($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_MANAGER)));
  requires $phys_ptr_cast(P#Entry, ^_LIST_ENTRY) != $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_ENTRY);
  requires $wrapped($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_MANAGER);
  modifies $s, $cev_pc;
  ensures $wrapped($s, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_ENTRY) && $is_fresh(old($s), $s, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY));
  ensures $set_eq($owns($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_MANAGER)), $set_difference($owns(old($s), $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_MANAGER)), $set_singleton($phys_ptr_cast(P#Entry, ^_LIST_ENTRY))));
  ensures $rd_inv($s, _LIST_MANAGER.size, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_MANAGER)) == $rd_inv(old($s), _LIST_MANAGER.size, $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_MANAGER)) - 1;
  ensures $rd_phys_ptr(old($s), _LIST_MANAGER.ListHead, $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_ENTRY) == $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_ENTRY);
  ensures (forall Q#le$1^153.29#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#le$1^153.29#dt1, ^_LIST_ENTRY), $owns(old($s), $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_MANAGER))) } { sk_hack($set_in($phys_ptr_cast(Q#le$1^153.29#dt1, ^_LIST_ENTRY), $owns(old($s), $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_MANAGER)))) } $set_in($phys_ptr_cast(Q#le$1^153.29#dt1, ^_LIST_ENTRY), $owns(old($s), $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_MANAGER))) ==> $emb(old($s), $phys_ptr_cast(Q#le$1^153.29#dt1, ^_LIST_ENTRY)) == $emb($s, $phys_ptr_cast(Q#le$1^153.29#dt1, ^_LIST_ENTRY)));
  ensures $wrapped($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_MANAGER);
  ensures $result == ($rd_inv($s, _LIST_MANAGER.size, $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_MANAGER)) == 1);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_MANAGER)));
  free ensures $call_transition(old($s), $s);



implementation RemoveEntryList(P#Entry: $ptr) returns ($result: bool)
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
  var L#Blink: $ptr;
  var L#Flink: $ptr;
  var SL#ListManager: $ptr;
  var #wrTime$2^30.1: int;
  var #stackframe: int;

  anon10:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$2^30.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$2^30.1, #loc.Entry, $ptr_to_int(P#Entry), $ptr_to(^_LIST_ENTRY));
    assume #wrTime$2^30.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$2^30.1, (lambda #p: $ptr :: #p == $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_MANAGER)));
    assume $thread_owned($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_MANAGER));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, *((Entry->Manager)), *((Entry->Manager))); 
    assert $in_domain_lab($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_MANAGER), $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_MANAGER), l#public);
    // struct _LIST_MANAGER^ ListManager; 
    assume $local_value_is($s, #tok$2^33.27, #loc.ListManager, $ptr_to_int(SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // struct _LIST_ENTRY* Flink; 
    assume $local_value_is($s, #tok$2^32.5, #loc.Flink, $ptr_to_int(L#Flink), $ptr_to(^_LIST_ENTRY));
    // struct _LIST_ENTRY* Blink; 
    assume $local_value_is($s, #tok$2^32.5, #loc.Blink, $ptr_to_int(L#Blink), $ptr_to(^_LIST_ENTRY));
    // var struct _LIST_ENTRY* Blink
    // var struct _LIST_ENTRY* Flink
    // assert @reads_check_normal((Entry->Manager)); 
    assert $thread_local($s, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY));
    // ListManager := *((Entry->Manager)); 
    SL#ListManager := $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_MANAGER);
    assume $local_value_is($s, #tok$2^33.27, #loc.ListManager, $ptr_to_int(SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // assert @_vcc_in_domain(@state, Entry, ListManager); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assume @_vcc_in_domain(@state, Entry, ListManager); 
    assume $in_domain_lab($s, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assert @_vcc_in_domain(@state, *((Entry->Blink)), ListManager); 
    assert $in_domain_lab($s, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assume @_vcc_in_domain(@state, *((Entry->Blink)), ListManager); 
    assume $in_domain_lab($s, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assert @_vcc_in_domain(@state, *((Entry->Flink)), ListManager); 
    assert $in_domain_lab($s, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assume @_vcc_in_domain(@state, *((Entry->Flink)), ListManager); 
    assume $in_domain_lab($s, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assert @reads_check_normal((Entry->Blink)); 
    assert $thread_local($s, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY));
    // Blink := *((Entry->Blink)); 
    L#Blink := $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_ENTRY);
    assume $local_value_is($s, #tok$2^39.5, #loc.Blink, $ptr_to_int(L#Blink), $ptr_to(^_LIST_ENTRY));
    // assert @reads_check_normal((Entry->Flink)); 
    assert $thread_local($s, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY));
    // Flink := *((Entry->Flink)); 
    L#Flink := $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_ENTRY);
    assume $local_value_is($s, #tok$2^40.5, #loc.Flink, $ptr_to_int(L#Flink), $ptr_to(^_LIST_ENTRY));
    // _math state_t prestate#15; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#15, $state_to_int(prestate#15), ^$#state_t);
    // prestate#15 := @_vcc_current_state(@state); 
    prestate#15 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#15, $state_to_int(prestate#15), ^$#state_t);
    // assert @_vcc_wrapped(@state, ListManager); 
    assert $wrapped($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_MANAGER);
    // assume @_vcc_inv(@state, ListManager); 
    assume $inv($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_MANAGER);
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$2^30.1, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // stmt @_vcc_unwrap(ListManager, @_vcc_typeof(ListManager)); 
    call $unwrap($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_MANAGER);
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
    assert $wrapped($s, $phys_ptr_cast(L#Blink, ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assert @writes_check(Blink); 
    assert $top_writable($s, #wrTime$2^30.1, $phys_ptr_cast(L#Blink, ^_LIST_ENTRY));
    // assume @_vcc_inv(@state, Blink); 
    assume $inv($s, $phys_ptr_cast(L#Blink, ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assume ==(owns#17, @_vcc_owns(@state, Blink)); 
    assume owns#17 == $owns($s, $phys_ptr_cast(L#Blink, ^_LIST_ENTRY));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(Blink), prestate#18)
    call $static_unwrap($phys_ptr_cast(L#Blink, ^_LIST_ENTRY), prestate#18);
    assume $good_state_ext(#tok$2^42.36, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((Blink->Flink)); 
    assert $writable_prim($s, #wrTime$2^30.1, $dot($phys_ptr_cast(L#Blink, ^_LIST_ENTRY), _LIST_ENTRY.Flink));
    // *(Blink->Flink) := Flink; 
    call $write_int(_LIST_ENTRY.Flink, $phys_ptr_cast(L#Blink, ^_LIST_ENTRY), $ptr_to_int($phys_ptr_cast(L#Flink, ^_LIST_ENTRY)));
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
    assert $top_writable($s, #wrTime$2^30.1, $phys_ptr_cast(L#Blink, ^_LIST_ENTRY));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(Blink), staticWrapState#19, owns#20)
    call $static_wrap($phys_ptr_cast(L#Blink, ^_LIST_ENTRY), staticWrapState#19, owns#20);
    assume $good_state_ext(#tok$2^42.36, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, Blink), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(L#Blink, ^_LIST_ENTRY)), $set_empty());
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
    assert $wrapped($s, $phys_ptr_cast(L#Flink, ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assert @writes_check(Flink); 
    assert $top_writable($s, #wrTime$2^30.1, $phys_ptr_cast(L#Flink, ^_LIST_ENTRY));
    // assume @_vcc_inv(@state, Flink); 
    assume $inv($s, $phys_ptr_cast(L#Flink, ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assume ==(owns#23, @_vcc_owns(@state, Flink)); 
    assume owns#23 == $owns($s, $phys_ptr_cast(L#Flink, ^_LIST_ENTRY));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(Flink), prestate#24)
    call $static_unwrap($phys_ptr_cast(L#Flink, ^_LIST_ENTRY), prestate#24);
    assume $good_state_ext(#tok$2^45.36, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((Flink->Blink)); 
    assert $writable_prim($s, #wrTime$2^30.1, $dot($phys_ptr_cast(L#Flink, ^_LIST_ENTRY), _LIST_ENTRY.Blink));
    // *(Flink->Blink) := Blink; 
    call $write_int(_LIST_ENTRY.Blink, $phys_ptr_cast(L#Flink, ^_LIST_ENTRY), $ptr_to_int($phys_ptr_cast(L#Blink, ^_LIST_ENTRY)));
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
    assert $top_writable($s, #wrTime$2^30.1, $phys_ptr_cast(L#Flink, ^_LIST_ENTRY));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(Flink), staticWrapState#25, owns#26)
    call $static_wrap($phys_ptr_cast(L#Flink, ^_LIST_ENTRY), staticWrapState#25, owns#26);
    assume $good_state_ext(#tok$2^45.36, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, Flink), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(L#Flink, ^_LIST_ENTRY)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((ListManager->size)); 
    assert $writable_prim($s, #wrTime$2^30.1, $dot($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), _LIST_MANAGER.size));
    // assert @in_range_u4(-(*((ListManager->size)), 1)); 
    assert $in_range_u4($rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)) - 1);
    // assert @reads_check_normal((ListManager->size)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // *(ListManager->size) := -(*((ListManager->size)), 1); 
    call $write_int(_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)) - 1);
    assume $full_stop_ext(#tok$2^50.9, $s);
    // assert @_vcc_set_in(Entry, @_vcc_owns(@state, ListManager)); 
    assert $set_in($phys_ptr_cast(P#Entry, ^_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)));
    // assume @_vcc_set_in(Entry, @_vcc_owns(@state, ListManager)); 
    assume $set_in($phys_ptr_cast(P#Entry, ^_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)));
    // assert @writes_check(@_vcc_span(ListManager)); 
    assert (forall #writes$2^51.31: $ptr :: { $dont_instantiate(#writes$2^51.31) } $set_in(#writes$2^51.31, $span($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))) ==> $top_writable($s, #wrTime$2^30.1, #writes$2^51.31));
    // stmt _vcc_set_owns(ListManager, @_vcc_set_remove_element(@_vcc_owns(@state, ListManager), Entry)); 
    call $set_owns($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $set_remove_element($owns($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)), $phys_ptr_cast(P#Entry, ^_LIST_ENTRY)));
    assume $full_stop_ext(#tok$2^51.31, $s);
    // empty
    // (struct _LIST_ENTRY* -> uint32_t) res_lambda#1#6; 
    assume $local_value_is($s, #tok$2^52.31, #loc.res_lambda#1#6, $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#1#6), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // res_lambda#1#6 := lambda#1(*((ListManager->index)), *((ListManager->index)), @map_get(*((ListManager->index)), Entry), *((ListManager->index))); 
    call res_lambda#1#6 := lambda#1($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(P#Entry, ^_LIST_ENTRY)), $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))));
    assume $full_stop_ext(#tok$2^52.31, $s);
    assume $local_value_is($s, #tok$2^52.31, #loc.res_lambda#1#6, $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#1#6), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @prim_writes_check((ListManager->index)); 
    assert $writable_prim($s, #wrTime$2^30.1, $dot($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), _LIST_MANAGER.index));
    // *(ListManager->index) := res_lambda#1#6; 
    call $write_int(_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#1#6));
    assume $full_stop_ext(#tok$2^52.9, $s);
    // _math state_t prestate#28; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
    // prestate#28 := @_vcc_current_state(@state); 
    prestate#28 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$2^30.1, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @writes_check(@_vcc_owns(@state, ListManager)); 
    assert (forall #writes$2^41.32: $ptr :: { $dont_instantiate(#writes$2^41.32) } $set_in(#writes$2^41.32, $owns($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))) ==> $top_writable($s, #wrTime$2^30.1, #writes$2^41.32));
    // stmt @_vcc_wrap(ListManager, @_vcc_typeof(ListManager)); 
    call $wrap($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_MANAGER);
    assume $good_state_ext(#tok$2^41.32, $s);
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } true; ==>(@keeps(ListManager, p), @_vcc_ptr_eq_pure(*((p->Manager)), ListManager)))); 
    assert (forall Q#p$1^47.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY)) ==> $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY), ^_LIST_MANAGER) == $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @inv_check(@keeps(ListManager, *((ListManager->ListHead)))); 
    assert $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY));
    // assert @inv_check(@keeps(ListManager, *((*((ListManager->ListHead))->Blink)))); 
    assert $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY), ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Flink))) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } true; ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Flink))), @_vcc_ptr_eq_pure(*((*((p->Flink))->Blink)), p))))); 
    assert (forall Q#p$1^60.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY)) ==> $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Blink))) } { @trigger_hint(@keeps(ListManager, *((p->Blink)))) } true; ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Blink))), @_vcc_ptr_eq_pure(*((*((p->Blink))->Flink)), p))))); 
    assert (forall Q#p$1^66.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY)) ==> $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Flink, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } true; ==>(&&(@keeps(ListManager, p), @_vcc_ptr_neq_pure(*((p->Flink)), *((ListManager->ListHead)))), ==(+(@map_get(*((ListManager->index)), p), 1), @map_get(*((ListManager->index)), *((p->Flink))))))); 
    assert (forall Q#p$1^75.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY) != $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)));
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((ListManager->ListHead))), 0)); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY)) == 0;
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((*((ListManager->ListHead))->Blink))), -(*((ListManager->size)), 1))); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY), ^_LIST_ENTRY)) == $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)) - 1;
    // assert @inv_check(forall(struct _LIST_ENTRY* e; { @keeps(ListManager, e) } true; ==>(@keeps(ListManager, e), <(@map_get(*((ListManager->index)), e), *((ListManager->size)))))); 
    assert (forall Q#e$1^83.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) < $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)));
    // assert @inv_check(forall(struct _LIST_ENTRY* e1; struct _LIST_ENTRY* e2; { @keeps(ListManager, e1), @keeps(ListManager, e2) } true; ==>(&&(&&(@keeps(ListManager, e1), @keeps(ListManager, e2)), @_vcc_ptr_neq_pure(e1, e2)), !=(@map_get(*((ListManager->index)), e1), @map_get(*((ListManager->index)), e2))))); 
    assert (forall Q#e1$1^87.31#dt1: $ptr, Q#e2$1^87.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)), $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)) && $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)) && $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY) != $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)) != $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return @_vcc_ptr_eq(Flink, Blink); 
    $result := $ptr_eq($phys_ptr_cast(L#Flink, ^_LIST_ENTRY), $phys_ptr_cast(L#Blink, ^_LIST_ENTRY));
    assert $position_marker();
    goto #exit;

  anon11:
    // empty

  #exit:
}



procedure RemoveHeadList(P#ListHead: $ptr) returns ($result: $ptr);
  requires $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY) != $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_ENTRY);
  requires $set_in($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $owns($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)));
  requires $wrapped($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_MANAGER);
  modifies $s, $cev_pc;
  free ensures true;
  ensures $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER) == $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER);
  ensures $rd_phys_ptr(old($s), _LIST_MANAGER.ListHead, $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_ENTRY) == $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_ENTRY);
  ensures (forall Q#le$1^177.29#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#le$1^177.29#dt1, ^_LIST_ENTRY), $owns(old($s), $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER))) } { sk_hack($set_in($phys_ptr_cast(Q#le$1^177.29#dt1, ^_LIST_ENTRY), $owns(old($s), $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)))) } $set_in($phys_ptr_cast(Q#le$1^177.29#dt1, ^_LIST_ENTRY), $owns(old($s), $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER))) ==> $emb(old($s), $phys_ptr_cast(Q#le$1^177.29#dt1, ^_LIST_ENTRY)) == $emb($s, $phys_ptr_cast(Q#le$1^177.29#dt1, ^_LIST_ENTRY)));
  ensures $rd_inv($s, _LIST_MANAGER.size, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)) == $rd_inv(old($s), _LIST_MANAGER.size, $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)) - 1;
  ensures $set_eq($owns($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)), $set_difference($owns(old($s), $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)), $set_singleton($phys_ptr_cast($result, ^_LIST_ENTRY))));
  ensures $set_in($phys_ptr_cast($result, ^_LIST_ENTRY), $owns(old($s), $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)));
  ensures $wrapped($s, $phys_ptr_cast($result, ^_LIST_ENTRY), ^_LIST_ENTRY);
  ensures $set_in($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $owns($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)));
  ensures $wrapped($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_MANAGER);
  ensures $phys_ptr_cast($result, ^_LIST_ENTRY) == $rd_phys_ptr(old($s), _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)));
  free ensures $call_transition(old($s), $s);



implementation RemoveHeadList(P#ListHead: $ptr) returns ($result: $ptr)
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
  var L#Flink: $ptr;
  var L#Entry: $ptr;
  var SL#ListManager: $ptr;
  var #wrTime$2^61.1: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$2^61.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$2^61.1, #loc.ListHead, $ptr_to_int(P#ListHead), $ptr_to(^_LIST_ENTRY));
    assume #wrTime$2^61.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$2^61.1, (lambda #p: $ptr :: #p == $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)));
    assume $thread_owned($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, *((ListHead->Manager)), *((ListHead->Manager))); 
    assert $in_domain_lab($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), l#public);
    // struct _LIST_MANAGER^ ListManager; 
    assume $local_value_is($s, #tok$2^64.27, #loc.ListManager, $ptr_to_int(SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // struct _LIST_ENTRY* Entry; 
    assume $local_value_is($s, #tok$2^63.5, #loc.Entry, $ptr_to_int(L#Entry), $ptr_to(^_LIST_ENTRY));
    // struct _LIST_ENTRY* Flink; 
    assume $local_value_is($s, #tok$2^63.5, #loc.Flink, $ptr_to_int(L#Flink), $ptr_to(^_LIST_ENTRY));
    // var struct _LIST_ENTRY* Flink
    // var struct _LIST_ENTRY* Entry
    // assert @reads_check_normal((ListHead->Manager)); 
    assert $thread_local($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // ListManager := *((ListHead->Manager)); 
    SL#ListManager := $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER);
    assume $local_value_is($s, #tok$2^64.27, #loc.ListManager, $ptr_to_int(SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // assert @_vcc_in_domain(@state, ListHead, ListManager); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assume @_vcc_in_domain(@state, ListHead, ListManager); 
    assume $in_domain_lab($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assert @_vcc_in_domain(@state, *((ListHead->Flink)), ListManager); 
    assert $in_domain_lab($s, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assume @_vcc_in_domain(@state, *((ListHead->Flink)), ListManager); 
    assume $in_domain_lab($s, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assert @_vcc_in_domain(@state, *((*((ListHead->Flink))->Flink)), ListManager); 
    assert $in_domain_lab($s, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assume @_vcc_in_domain(@state, *((*((ListHead->Flink))->Flink)), ListManager); 
    assume $in_domain_lab($s, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assert @reads_check_normal((ListHead->Flink)); 
    assert $thread_local($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // Entry := *((ListHead->Flink)); 
    L#Entry := $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY);
    assume $local_value_is($s, #tok$2^70.5, #loc.Entry, $ptr_to_int(L#Entry), $ptr_to(^_LIST_ENTRY));
    // assert @reads_check_normal((*((ListHead->Flink))->Flink)); 
    assert $thread_local($s, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY));
    // assert @reads_check_normal((ListHead->Flink)); 
    assert $thread_local($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // Flink := *((*((ListHead->Flink))->Flink)); 
    L#Flink := $rd_phys_ptr($s, _LIST_ENTRY.Flink, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY);
    assume $local_value_is($s, #tok$2^71.5, #loc.Flink, $ptr_to_int(L#Flink), $ptr_to(^_LIST_ENTRY));
    // _math state_t prestate#29; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#29, $state_to_int(prestate#29), ^$#state_t);
    // prestate#29 := @_vcc_current_state(@state); 
    prestate#29 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#29, $state_to_int(prestate#29), ^$#state_t);
    // assert @_vcc_wrapped(@state, ListManager); 
    assert $wrapped($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_MANAGER);
    // assume @_vcc_inv(@state, ListManager); 
    assume $inv($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_MANAGER);
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$2^61.1, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // stmt @_vcc_unwrap(ListManager, @_vcc_typeof(ListManager)); 
    call $unwrap($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_MANAGER);
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
    assert $wrapped($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assert @writes_check(ListHead); 
    assert $top_writable($s, #wrTime$2^61.1, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // assume @_vcc_inv(@state, ListHead); 
    assume $inv($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assume ==(owns#31, @_vcc_owns(@state, ListHead)); 
    assume owns#31 == $owns($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(ListHead), prestate#32)
    call $static_unwrap($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), prestate#32);
    assume $good_state_ext(#tok$2^73.36, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((ListHead->Flink)); 
    assert $writable_prim($s, #wrTime$2^61.1, $dot($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), _LIST_ENTRY.Flink));
    // *(ListHead->Flink) := Flink; 
    call $write_int(_LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $ptr_to_int($phys_ptr_cast(L#Flink, ^_LIST_ENTRY)));
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
    assert $top_writable($s, #wrTime$2^61.1, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(ListHead), staticWrapState#33, owns#34)
    call $static_wrap($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), staticWrapState#33, owns#34);
    assume $good_state_ext(#tok$2^73.36, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, ListHead), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY)), $set_empty());
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
    assert $wrapped($s, $phys_ptr_cast(L#Flink, ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assert @writes_check(Flink); 
    assert $top_writable($s, #wrTime$2^61.1, $phys_ptr_cast(L#Flink, ^_LIST_ENTRY));
    // assume @_vcc_inv(@state, Flink); 
    assume $inv($s, $phys_ptr_cast(L#Flink, ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assume ==(owns#37, @_vcc_owns(@state, Flink)); 
    assume owns#37 == $owns($s, $phys_ptr_cast(L#Flink, ^_LIST_ENTRY));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(Flink), prestate#38)
    call $static_unwrap($phys_ptr_cast(L#Flink, ^_LIST_ENTRY), prestate#38);
    assume $good_state_ext(#tok$2^76.36, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((Flink->Blink)); 
    assert $writable_prim($s, #wrTime$2^61.1, $dot($phys_ptr_cast(L#Flink, ^_LIST_ENTRY), _LIST_ENTRY.Blink));
    // *(Flink->Blink) := ListHead; 
    call $write_int(_LIST_ENTRY.Blink, $phys_ptr_cast(L#Flink, ^_LIST_ENTRY), $ptr_to_int($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY)));
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
    assert $top_writable($s, #wrTime$2^61.1, $phys_ptr_cast(L#Flink, ^_LIST_ENTRY));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(Flink), staticWrapState#39, owns#40)
    call $static_wrap($phys_ptr_cast(L#Flink, ^_LIST_ENTRY), staticWrapState#39, owns#40);
    assume $good_state_ext(#tok$2^76.36, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, Flink), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(L#Flink, ^_LIST_ENTRY)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((ListManager->size)); 
    assert $writable_prim($s, #wrTime$2^61.1, $dot($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), _LIST_MANAGER.size));
    // assert @in_range_u4(-(*((ListManager->size)), 1)); 
    assert $in_range_u4($rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)) - 1);
    // assert @reads_check_normal((ListManager->size)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // *(ListManager->size) := -(*((ListManager->size)), 1); 
    call $write_int(_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)) - 1);
    assume $full_stop_ext(#tok$2^81.9, $s);
    // assert @_vcc_set_in(Entry, @_vcc_owns(@state, ListManager)); 
    assert $set_in($phys_ptr_cast(L#Entry, ^_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)));
    // assume @_vcc_set_in(Entry, @_vcc_owns(@state, ListManager)); 
    assume $set_in($phys_ptr_cast(L#Entry, ^_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)));
    // assert @writes_check(@_vcc_span(ListManager)); 
    assert (forall #writes$2^82.31: $ptr :: { $dont_instantiate(#writes$2^82.31) } $set_in(#writes$2^82.31, $span($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))) ==> $top_writable($s, #wrTime$2^61.1, #writes$2^82.31));
    // stmt _vcc_set_owns(ListManager, @_vcc_set_remove_element(@_vcc_owns(@state, ListManager), Entry)); 
    call $set_owns($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $set_remove_element($owns($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)), $phys_ptr_cast(L#Entry, ^_LIST_ENTRY)));
    assume $full_stop_ext(#tok$2^82.31, $s);
    // empty
    // (struct _LIST_ENTRY* -> uint32_t) res_lambda#2#7; 
    assume $local_value_is($s, #tok$2^83.31, #loc.res_lambda#2#7, $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#2#7), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // res_lambda#2#7 := lambda#2(*((ListManager->index)), *((ListManager->index)), @map_get(*((ListManager->index)), Entry), *((ListManager->index))); 
    call res_lambda#2#7 := lambda#2($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(L#Entry, ^_LIST_ENTRY)), $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))));
    assume $full_stop_ext(#tok$2^83.31, $s);
    assume $local_value_is($s, #tok$2^83.31, #loc.res_lambda#2#7, $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#2#7), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @prim_writes_check((ListManager->index)); 
    assert $writable_prim($s, #wrTime$2^61.1, $dot($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), _LIST_MANAGER.index));
    // *(ListManager->index) := res_lambda#2#7; 
    call $write_int(_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#2#7));
    assume $full_stop_ext(#tok$2^83.9, $s);
    // _math state_t prestate#42; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#42, $state_to_int(prestate#42), ^$#state_t);
    // prestate#42 := @_vcc_current_state(@state); 
    prestate#42 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#42, $state_to_int(prestate#42), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$2^61.1, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @writes_check(@_vcc_owns(@state, ListManager)); 
    assert (forall #writes$2^72.32: $ptr :: { $dont_instantiate(#writes$2^72.32) } $set_in(#writes$2^72.32, $owns($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))) ==> $top_writable($s, #wrTime$2^61.1, #writes$2^72.32));
    // stmt @_vcc_wrap(ListManager, @_vcc_typeof(ListManager)); 
    call $wrap($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_MANAGER);
    assume $good_state_ext(#tok$2^72.32, $s);
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } true; ==>(@keeps(ListManager, p), @_vcc_ptr_eq_pure(*((p->Manager)), ListManager)))); 
    assert (forall Q#p$1^47.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY)) ==> $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY), ^_LIST_MANAGER) == $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @inv_check(@keeps(ListManager, *((ListManager->ListHead)))); 
    assert $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY));
    // assert @inv_check(@keeps(ListManager, *((*((ListManager->ListHead))->Blink)))); 
    assert $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY), ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Flink))) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } true; ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Flink))), @_vcc_ptr_eq_pure(*((*((p->Flink))->Blink)), p))))); 
    assert (forall Q#p$1^60.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY)) ==> $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Blink))) } { @trigger_hint(@keeps(ListManager, *((p->Blink)))) } true; ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Blink))), @_vcc_ptr_eq_pure(*((*((p->Blink))->Flink)), p))))); 
    assert (forall Q#p$1^66.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY)) ==> $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Flink, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } true; ==>(&&(@keeps(ListManager, p), @_vcc_ptr_neq_pure(*((p->Flink)), *((ListManager->ListHead)))), ==(+(@map_get(*((ListManager->index)), p), 1), @map_get(*((ListManager->index)), *((p->Flink))))))); 
    assert (forall Q#p$1^75.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY) != $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)));
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((ListManager->ListHead))), 0)); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY)) == 0;
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((*((ListManager->ListHead))->Blink))), -(*((ListManager->size)), 1))); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY), ^_LIST_ENTRY)) == $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)) - 1;
    // assert @inv_check(forall(struct _LIST_ENTRY* e; { @keeps(ListManager, e) } true; ==>(@keeps(ListManager, e), <(@map_get(*((ListManager->index)), e), *((ListManager->size)))))); 
    assert (forall Q#e$1^83.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) < $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)));
    // assert @inv_check(forall(struct _LIST_ENTRY* e1; struct _LIST_ENTRY* e2; { @keeps(ListManager, e1), @keeps(ListManager, e2) } true; ==>(&&(&&(@keeps(ListManager, e1), @keeps(ListManager, e2)), @_vcc_ptr_neq_pure(e1, e2)), !=(@map_get(*((ListManager->index)), e1), @map_get(*((ListManager->index)), e2))))); 
    assert (forall Q#e1$1^87.31#dt1: $ptr, Q#e2$1^87.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)), $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)) && $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)) && $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY) != $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)) != $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return Entry; 
    $result := $phys_ptr_cast(L#Entry, ^_LIST_ENTRY);
    assert $position_marker();
    goto #exit;

  anon13:
    // empty

  #exit:
}



procedure RemoveTailList(P#ListHead: $ptr) returns ($result: $ptr);
  requires $rd_inv($s, _LIST_MANAGER.size, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)) > 1;
  requires $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY) != $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_ENTRY);
  requires $set_in($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $owns($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)));
  requires $wrapped($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_MANAGER);
  modifies $s, $cev_pc;
  free ensures true;
  ensures $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER) == $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER);
  ensures $rd_phys_ptr(old($s), _LIST_MANAGER.ListHead, $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_ENTRY) == $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_ENTRY);
  ensures (forall Q#le$1^205.29#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#le$1^205.29#dt1, ^_LIST_ENTRY), $owns(old($s), $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER))) } { sk_hack($set_in($phys_ptr_cast(Q#le$1^205.29#dt1, ^_LIST_ENTRY), $owns(old($s), $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)))) } $set_in($phys_ptr_cast(Q#le$1^205.29#dt1, ^_LIST_ENTRY), $owns(old($s), $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER))) ==> $emb(old($s), $phys_ptr_cast(Q#le$1^205.29#dt1, ^_LIST_ENTRY)) == $emb($s, $phys_ptr_cast(Q#le$1^205.29#dt1, ^_LIST_ENTRY)));
  ensures $rd_inv($s, _LIST_MANAGER.size, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)) == $rd_inv(old($s), _LIST_MANAGER.size, $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)) - 1;
  ensures $set_eq($owns($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)), $set_difference($owns(old($s), $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)), $set_singleton($phys_ptr_cast($result, ^_LIST_ENTRY))));
  ensures $wrapped($s, $phys_ptr_cast($result, ^_LIST_ENTRY), ^_LIST_ENTRY);
  ensures $set_in($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $owns($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)));
  ensures $wrapped($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_MANAGER);
  ensures $phys_ptr_cast($result, ^_LIST_ENTRY) == $rd_phys_ptr(old($s), _LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)));
  free ensures $call_transition(old($s), $s);



implementation RemoveTailList(P#ListHead: $ptr) returns ($result: $ptr)
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
  var L#Blink: $ptr;
  var L#Entry: $ptr;
  var SL#ListManager: $ptr;
  var #wrTime$2^91.1: int;
  var #stackframe: int;

  anon14:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$2^91.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$2^91.1, #loc.ListHead, $ptr_to_int(P#ListHead), $ptr_to(^_LIST_ENTRY));
    assume #wrTime$2^91.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$2^91.1, (lambda #p: $ptr :: #p == $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)));
    assume $thread_owned($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, *((ListHead->Manager)), *((ListHead->Manager))); 
    assert $in_domain_lab($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), l#public);
    // struct _LIST_MANAGER^ ListManager; 
    assume $local_value_is($s, #tok$2^94.27, #loc.ListManager, $ptr_to_int(SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // struct _LIST_ENTRY* Entry; 
    assume $local_value_is($s, #tok$2^93.5, #loc.Entry, $ptr_to_int(L#Entry), $ptr_to(^_LIST_ENTRY));
    // struct _LIST_ENTRY* Blink; 
    assume $local_value_is($s, #tok$2^93.5, #loc.Blink, $ptr_to_int(L#Blink), $ptr_to(^_LIST_ENTRY));
    // var struct _LIST_ENTRY* Blink
    // var struct _LIST_ENTRY* Entry
    // assert @reads_check_normal((ListHead->Manager)); 
    assert $thread_local($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // ListManager := *((ListHead->Manager)); 
    SL#ListManager := $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER);
    assume $local_value_is($s, #tok$2^94.27, #loc.ListManager, $ptr_to_int(SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // assert @_vcc_in_domain(@state, ListHead, ListManager); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assume @_vcc_in_domain(@state, ListHead, ListManager); 
    assume $in_domain_lab($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assert @_vcc_in_domain(@state, *((ListHead->Blink)), ListManager); 
    assert $in_domain_lab($s, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assume @_vcc_in_domain(@state, *((ListHead->Blink)), ListManager); 
    assume $in_domain_lab($s, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assert @_vcc_in_domain(@state, *((*((ListHead->Blink))->Blink)), ListManager); 
    assert $in_domain_lab($s, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assume @_vcc_in_domain(@state, *((*((ListHead->Blink))->Blink)), ListManager); 
    assume $in_domain_lab($s, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assert @reads_check_normal((ListHead->Blink)); 
    assert $thread_local($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // Entry := *((ListHead->Blink)); 
    L#Entry := $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY);
    assume $local_value_is($s, #tok$2^100.5, #loc.Entry, $ptr_to_int(L#Entry), $ptr_to(^_LIST_ENTRY));
    // assert @reads_check_normal((*((ListHead->Blink))->Blink)); 
    assert $thread_local($s, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY));
    // assert @reads_check_normal((ListHead->Blink)); 
    assert $thread_local($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // Blink := *((*((ListHead->Blink))->Blink)); 
    L#Blink := $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY);
    assume $local_value_is($s, #tok$2^101.5, #loc.Blink, $ptr_to_int(L#Blink), $ptr_to(^_LIST_ENTRY));
    // _math state_t prestate#43; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#43, $state_to_int(prestate#43), ^$#state_t);
    // prestate#43 := @_vcc_current_state(@state); 
    prestate#43 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#43, $state_to_int(prestate#43), ^$#state_t);
    // assert @_vcc_wrapped(@state, ListManager); 
    assert $wrapped($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_MANAGER);
    // assume @_vcc_inv(@state, ListManager); 
    assume $inv($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_MANAGER);
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$2^91.1, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // stmt @_vcc_unwrap(ListManager, @_vcc_typeof(ListManager)); 
    call $unwrap($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_MANAGER);
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
    assert $wrapped($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assert @writes_check(ListHead); 
    assert $top_writable($s, #wrTime$2^91.1, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // assume @_vcc_inv(@state, ListHead); 
    assume $inv($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assume ==(owns#45, @_vcc_owns(@state, ListHead)); 
    assume owns#45 == $owns($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(ListHead), prestate#46)
    call $static_unwrap($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), prestate#46);
    assume $good_state_ext(#tok$2^103.36, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((ListHead->Blink)); 
    assert $writable_prim($s, #wrTime$2^91.1, $dot($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), _LIST_ENTRY.Blink));
    // *(ListHead->Blink) := Blink; 
    call $write_int(_LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $ptr_to_int($phys_ptr_cast(L#Blink, ^_LIST_ENTRY)));
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
    assert $top_writable($s, #wrTime$2^91.1, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(ListHead), staticWrapState#47, owns#48)
    call $static_wrap($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), staticWrapState#47, owns#48);
    assume $good_state_ext(#tok$2^103.36, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, ListHead), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY)), $set_empty());
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
    assert $wrapped($s, $phys_ptr_cast(L#Blink, ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assert @writes_check(Blink); 
    assert $top_writable($s, #wrTime$2^91.1, $phys_ptr_cast(L#Blink, ^_LIST_ENTRY));
    // assume @_vcc_inv(@state, Blink); 
    assume $inv($s, $phys_ptr_cast(L#Blink, ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assume ==(owns#51, @_vcc_owns(@state, Blink)); 
    assume owns#51 == $owns($s, $phys_ptr_cast(L#Blink, ^_LIST_ENTRY));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(Blink), prestate#52)
    call $static_unwrap($phys_ptr_cast(L#Blink, ^_LIST_ENTRY), prestate#52);
    assume $good_state_ext(#tok$2^106.36, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((Blink->Flink)); 
    assert $writable_prim($s, #wrTime$2^91.1, $dot($phys_ptr_cast(L#Blink, ^_LIST_ENTRY), _LIST_ENTRY.Flink));
    // *(Blink->Flink) := ListHead; 
    call $write_int(_LIST_ENTRY.Flink, $phys_ptr_cast(L#Blink, ^_LIST_ENTRY), $ptr_to_int($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY)));
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
    assert $top_writable($s, #wrTime$2^91.1, $phys_ptr_cast(L#Blink, ^_LIST_ENTRY));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(Blink), staticWrapState#53, owns#54)
    call $static_wrap($phys_ptr_cast(L#Blink, ^_LIST_ENTRY), staticWrapState#53, owns#54);
    assume $good_state_ext(#tok$2^106.36, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, Blink), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(L#Blink, ^_LIST_ENTRY)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((ListManager->size)); 
    assert $writable_prim($s, #wrTime$2^91.1, $dot($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), _LIST_MANAGER.size));
    // assert @in_range_u4(-(*((ListManager->size)), 1)); 
    assert $in_range_u4($rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)) - 1);
    // assert @reads_check_normal((ListManager->size)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // *(ListManager->size) := -(*((ListManager->size)), 1); 
    call $write_int(_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)) - 1);
    assume $full_stop_ext(#tok$2^111.9, $s);
    // assert @_vcc_set_in(Entry, @_vcc_owns(@state, ListManager)); 
    assert $set_in($phys_ptr_cast(L#Entry, ^_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)));
    // assume @_vcc_set_in(Entry, @_vcc_owns(@state, ListManager)); 
    assume $set_in($phys_ptr_cast(L#Entry, ^_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)));
    // assert @writes_check(@_vcc_span(ListManager)); 
    assert (forall #writes$2^112.31: $ptr :: { $dont_instantiate(#writes$2^112.31) } $set_in(#writes$2^112.31, $span($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))) ==> $top_writable($s, #wrTime$2^91.1, #writes$2^112.31));
    // stmt _vcc_set_owns(ListManager, @_vcc_set_remove_element(@_vcc_owns(@state, ListManager), Entry)); 
    call $set_owns($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $set_remove_element($owns($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)), $phys_ptr_cast(L#Entry, ^_LIST_ENTRY)));
    assume $full_stop_ext(#tok$2^112.31, $s);
    // empty
    // (struct _LIST_ENTRY* -> uint32_t) res_lambda#3#8; 
    assume $local_value_is($s, #tok$2^113.31, #loc.res_lambda#3#8, $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#3#8), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // res_lambda#3#8 := lambda#3(*((ListManager->index)), *((ListManager->index)), @map_get(*((ListManager->index)), Entry), *((ListManager->index))); 
    call res_lambda#3#8 := lambda#3($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(L#Entry, ^_LIST_ENTRY)), $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))));
    assume $full_stop_ext(#tok$2^113.31, $s);
    assume $local_value_is($s, #tok$2^113.31, #loc.res_lambda#3#8, $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#3#8), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @prim_writes_check((ListManager->index)); 
    assert $writable_prim($s, #wrTime$2^91.1, $dot($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), _LIST_MANAGER.index));
    // *(ListManager->index) := res_lambda#3#8; 
    call $write_int(_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#3#8));
    assume $full_stop_ext(#tok$2^113.9, $s);
    // _math state_t prestate#56; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#56, $state_to_int(prestate#56), ^$#state_t);
    // prestate#56 := @_vcc_current_state(@state); 
    prestate#56 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#56, $state_to_int(prestate#56), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$2^91.1, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @writes_check(@_vcc_owns(@state, ListManager)); 
    assert (forall #writes$2^102.32: $ptr :: { $dont_instantiate(#writes$2^102.32) } $set_in(#writes$2^102.32, $owns($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))) ==> $top_writable($s, #wrTime$2^91.1, #writes$2^102.32));
    // stmt @_vcc_wrap(ListManager, @_vcc_typeof(ListManager)); 
    call $wrap($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_MANAGER);
    assume $good_state_ext(#tok$2^102.32, $s);
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } true; ==>(@keeps(ListManager, p), @_vcc_ptr_eq_pure(*((p->Manager)), ListManager)))); 
    assert (forall Q#p$1^47.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY)) ==> $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY), ^_LIST_MANAGER) == $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @inv_check(@keeps(ListManager, *((ListManager->ListHead)))); 
    assert $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY));
    // assert @inv_check(@keeps(ListManager, *((*((ListManager->ListHead))->Blink)))); 
    assert $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY), ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Flink))) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } true; ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Flink))), @_vcc_ptr_eq_pure(*((*((p->Flink))->Blink)), p))))); 
    assert (forall Q#p$1^60.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY)) ==> $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Blink))) } { @trigger_hint(@keeps(ListManager, *((p->Blink)))) } true; ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Blink))), @_vcc_ptr_eq_pure(*((*((p->Blink))->Flink)), p))))); 
    assert (forall Q#p$1^66.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY)) ==> $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Flink, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } true; ==>(&&(@keeps(ListManager, p), @_vcc_ptr_neq_pure(*((p->Flink)), *((ListManager->ListHead)))), ==(+(@map_get(*((ListManager->index)), p), 1), @map_get(*((ListManager->index)), *((p->Flink))))))); 
    assert (forall Q#p$1^75.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY) != $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)));
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((ListManager->ListHead))), 0)); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY)) == 0;
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((*((ListManager->ListHead))->Blink))), -(*((ListManager->size)), 1))); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY), ^_LIST_ENTRY)) == $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)) - 1;
    // assert @inv_check(forall(struct _LIST_ENTRY* e; { @keeps(ListManager, e) } true; ==>(@keeps(ListManager, e), <(@map_get(*((ListManager->index)), e), *((ListManager->size)))))); 
    assert (forall Q#e$1^83.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) < $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)));
    // assert @inv_check(forall(struct _LIST_ENTRY* e1; struct _LIST_ENTRY* e2; { @keeps(ListManager, e1), @keeps(ListManager, e2) } true; ==>(&&(&&(@keeps(ListManager, e1), @keeps(ListManager, e2)), @_vcc_ptr_neq_pure(e1, e2)), !=(@map_get(*((ListManager->index)), e1), @map_get(*((ListManager->index)), e2))))); 
    assert (forall Q#e1$1^87.31#dt1: $ptr, Q#e2$1^87.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)), $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)) && $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)) && $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY) != $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)) != $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return Entry; 
    $result := $phys_ptr_cast(L#Entry, ^_LIST_ENTRY);
    assert $position_marker();
    goto #exit;

  anon15:
    // empty

  #exit:
}



procedure InsertTailList(P#ListHead: $ptr, P#Entry: $ptr);
  requires $mutable($s, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY));
  requires $rd_inv($s, _LIST_MANAGER.size, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)) < 4294967295;
  requires $wrapped($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_MANAGER);
  requires $set_in($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $owns($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)));
  modifies $s, $cev_pc;
  ensures $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER) == $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER);
  ensures $rd_phys_ptr(old($s), _LIST_MANAGER.ListHead, $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_ENTRY) == $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_ENTRY);
  ensures (forall Q#le$1^234.29#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#le$1^234.29#dt1, ^_LIST_ENTRY), $owns(old($s), $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER))) } { sk_hack($set_in($phys_ptr_cast(Q#le$1^234.29#dt1, ^_LIST_ENTRY), $owns(old($s), $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)))) } $set_in($phys_ptr_cast(Q#le$1^234.29#dt1, ^_LIST_ENTRY), $owns(old($s), $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER))) ==> $emb(old($s), $phys_ptr_cast(Q#le$1^234.29#dt1, ^_LIST_ENTRY)) == $emb($s, $phys_ptr_cast(Q#le$1^234.29#dt1, ^_LIST_ENTRY)));
  ensures $set_in($phys_ptr_cast(P#Entry, ^_LIST_ENTRY), $owns($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)));
  ensures $rd_inv($s, _LIST_MANAGER.size, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)) == $rd_inv(old($s), _LIST_MANAGER.size, $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)) + 1;
  ensures $set_eq($owns($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)), $set_union($owns(old($s), $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)), $set_singleton($phys_ptr_cast(P#Entry, ^_LIST_ENTRY)))) && $set_in($phys_ptr_cast(P#Entry, ^_LIST_ENTRY), $owns($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)));
  ensures $rd_phys_ptr(old($s), _LIST_MANAGER.ListHead, $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_ENTRY) == $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_ENTRY);
  ensures $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_MANAGER) == $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER);
  ensures $wrapped($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_MANAGER);
  ensures $set_in($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $owns($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)));
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER) || $set_in(#p, $span($phys_ptr_cast(P#Entry, ^_LIST_ENTRY)))));
  free ensures $call_transition(old($s), $s);



implementation InsertTailList(P#ListHead: $ptr, P#Entry: $ptr)
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
  var SL#ListManager: $ptr;
  var #wrTime$2^121.1: int;
  var #stackframe: int;

  anon18:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$2^121.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$2^121.1, #loc.ListHead, $ptr_to_int(P#ListHead), $ptr_to(^_LIST_ENTRY));
    assume $local_value_is($s, #tok$2^121.1, #loc.Entry, $ptr_to_int(P#Entry), $ptr_to(^_LIST_ENTRY));
    assume #wrTime$2^121.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$2^121.1, (lambda #p: $ptr :: #p == $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER) || $set_in(#p, $span($phys_ptr_cast(P#Entry, ^_LIST_ENTRY)))));
    assume $thread_owned($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER));
    assume $mutable($s, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY));
    // assume true; 
    assume true;
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, *((ListHead->Manager)), *((ListHead->Manager))); 
    assert $in_domain_lab($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), l#public);
    // struct _LIST_MANAGER^ ListManager; 
    assume $local_value_is($s, #tok$2^123.27, #loc.ListManager, $ptr_to_int(SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // assert @reads_check_normal((ListHead->Manager)); 
    assert $thread_local($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // ListManager := *((ListHead->Manager)); 
    SL#ListManager := $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER);
    assume $local_value_is($s, #tok$2^123.27, #loc.ListManager, $ptr_to_int(SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // assert @_vcc_in_domain(@state, ListHead, ListManager); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assume @_vcc_in_domain(@state, ListHead, ListManager); 
    assume $in_domain_lab($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assert @_vcc_in_domain(@state, *((ListHead->Blink)), ListManager); 
    assert $in_domain_lab($s, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assume @_vcc_in_domain(@state, *((ListHead->Blink)), ListManager); 
    assume $in_domain_lab($s, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assert @prim_writes_check((Entry->Flink)); 
    assert $writable_prim($s, #wrTime$2^121.1, $dot($phys_ptr_cast(P#Entry, ^_LIST_ENTRY), _LIST_ENTRY.Flink));
    // *(Entry->Flink) := ListHead; 
    call $write_int(_LIST_ENTRY.Flink, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), $ptr_to_int($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY)));
    assume $full_stop_ext(#tok$2^128.5, $s);
    // assert @prim_writes_check((Entry->Blink)); 
    assert $writable_prim($s, #wrTime$2^121.1, $dot($phys_ptr_cast(P#Entry, ^_LIST_ENTRY), _LIST_ENTRY.Blink));
    // assert @reads_check_normal((ListHead->Blink)); 
    assert $thread_local($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // *(Entry->Blink) := *((ListHead->Blink)); 
    call $write_int(_LIST_ENTRY.Blink, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), $ptr_to_int($rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY)));
    assume $full_stop_ext(#tok$2^129.5, $s);
    // assert @prim_writes_check((Entry->Manager)); 
    assert $writable_prim($s, #wrTime$2^121.1, $dot($phys_ptr_cast(P#Entry, ^_LIST_ENTRY), _LIST_ENTRY.Manager));
    // *(Entry->Manager) := ListManager; 
    call $write_int(_LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), $ptr_to_int($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)));
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
    assert $top_writable($s, #wrTime$2^121.1, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(Entry), staticWrapState#57, owns#58)
    call $static_wrap($phys_ptr_cast(P#Entry, ^_LIST_ENTRY), staticWrapState#57, owns#58);
    assume $good_state_ext(#tok$2^132.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, Entry), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#60; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#60, $state_to_int(prestate#60), ^$#state_t);
    // prestate#60 := @_vcc_current_state(@state); 
    prestate#60 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#60, $state_to_int(prestate#60), ^$#state_t);
    // assert @_vcc_wrapped(@state, ListManager); 
    assert $wrapped($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_MANAGER);
    // assume @_vcc_inv(@state, ListManager); 
    assume $inv($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_MANAGER);
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$2^121.1, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // stmt @_vcc_unwrap(ListManager, @_vcc_typeof(ListManager)); 
    call $unwrap($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_MANAGER);
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
    assert $wrapped($s, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assert @writes_check(*((ListHead->Blink))); 
    assert $top_writable($s, #wrTime$2^121.1, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY));
    // assume @_vcc_inv(@state, *((ListHead->Blink))); 
    assume $inv($s, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assume ==(owns#62, @_vcc_owns(@state, *((ListHead->Blink)))); 
    assume owns#62 == $owns($s, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(*((ListHead->Blink))), prestate#63)
    call $static_unwrap($rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), prestate#63);
    assume $good_state_ext(#tok$2^134.36, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((*((ListHead->Blink))->Flink)); 
    assert $writable_prim($s, #wrTime$2^121.1, $dot($rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), _LIST_ENTRY.Flink));
    // assert @reads_check_normal((ListHead->Blink)); 
    assert $thread_local($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // *(*((ListHead->Blink))->Flink) := Entry; 
    call $write_int(_LIST_ENTRY.Flink, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), $ptr_to_int($phys_ptr_cast(P#Entry, ^_LIST_ENTRY)));
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
    assert $top_writable($s, #wrTime$2^121.1, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(*((ListHead->Blink))), staticWrapState#64, owns#65)
    call $static_wrap($rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), staticWrapState#64, owns#65);
    assume $good_state_ext(#tok$2^134.36, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((ListHead->Blink))), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY)), $set_empty());
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
    assert $wrapped($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assert @writes_check(ListHead); 
    assert $top_writable($s, #wrTime$2^121.1, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // assume @_vcc_inv(@state, ListHead); 
    assume $inv($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assume ==(owns#68, @_vcc_owns(@state, ListHead)); 
    assume owns#68 == $owns($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(ListHead), prestate#69)
    call $static_unwrap($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), prestate#69);
    assume $good_state_ext(#tok$2^137.36, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((ListHead->Blink)); 
    assert $writable_prim($s, #wrTime$2^121.1, $dot($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), _LIST_ENTRY.Blink));
    // *(ListHead->Blink) := Entry; 
    call $write_int(_LIST_ENTRY.Blink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $ptr_to_int($phys_ptr_cast(P#Entry, ^_LIST_ENTRY)));
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
    assert $top_writable($s, #wrTime$2^121.1, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(ListHead), staticWrapState#70, owns#71)
    call $static_wrap($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), staticWrapState#70, owns#71);
    assume $good_state_ext(#tok$2^137.36, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, ListHead), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((ListManager->size)); 
    assert $writable_prim($s, #wrTime$2^121.1, $dot($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), _LIST_MANAGER.size));
    // assert @in_range_u4(+(*((ListManager->size)), 1)); 
    assert $in_range_u4($rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)) + 1);
    // assert @reads_check_normal((ListManager->size)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // *(ListManager->size) := +(*((ListManager->size)), 1); 
    call $write_int(_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)) + 1);
    assume $full_stop_ext(#tok$2^142.9, $s);
    // assert @writes_check(@_vcc_span(ListManager)); 
    assert (forall #writes$2^143.31: $ptr :: { $dont_instantiate(#writes$2^143.31) } $set_in(#writes$2^143.31, $span($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))) ==> $top_writable($s, #wrTime$2^121.1, #writes$2^143.31));
    // stmt _vcc_set_owns(ListManager, @_vcc_set_add_element(@_vcc_owns(@state, ListManager), Entry)); 
    call $set_owns($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $set_add_element($owns($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)), $phys_ptr_cast(P#Entry, ^_LIST_ENTRY)));
    assume $full_stop_ext(#tok$2^143.31, $s);
    // empty
    // assert @reads_check_normal((ListManager->ListHead)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    assume true;
    // if (@_vcc_ptr_eq(ListHead, *((ListManager->ListHead)))) ...
    if ($ptr_eq($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY)))
    {
      anon16:
        // assert @prim_writes_check((ListManager->index)); 
        assert $writable_prim($s, #wrTime$2^121.1, $dot($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), _LIST_MANAGER.index));
        // assert @reads_check_normal((ListManager->index)); 
        assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
        // assert @in_range_u4(-(*((ListManager->size)), 1)); 
        assert $in_range_u4($rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)) - 1);
        // assert @reads_check_normal((ListManager->size)); 
        assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
        // *(ListManager->index) := @map_updated(*((ListManager->index)), Entry, -(*((ListManager->size)), 1)); 
        call $write_int(_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int($store.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)) - 1)));
        assume $full_stop_ext(#tok$2^146.13, $s);
    }
    else
    {
      anon17:
        // (struct _LIST_ENTRY* -> uint32_t) res_lambda#4#9; 
        assume $local_value_is($s, #tok$2^148.35, #loc.res_lambda#4#9, $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#4#9), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
        // assert @reads_check_normal((ListManager->index)); 
        assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
        // assert @reads_check_normal((ListManager->index)); 
        assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
        // assert @reads_check_normal((ListManager->index)); 
        assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
        // assert @reads_check_normal((ListManager->index)); 
        assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
        // assert @reads_check_normal((ListManager->index)); 
        assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
        // res_lambda#4#9 := lambda#4(*((ListManager->index)), *((ListManager->index)), @map_get(*((ListManager->index)), ListHead), *((ListManager->index)), @map_get(*((ListManager->index)), ListHead), Entry); 
        call res_lambda#4#9 := lambda#4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY)), $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY)), $phys_ptr_cast(P#Entry, ^_LIST_ENTRY));
        assume $full_stop_ext(#tok$2^148.35, $s);
        assume $local_value_is($s, #tok$2^148.35, #loc.res_lambda#4#9, $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#4#9), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
        // assert @prim_writes_check((ListManager->index)); 
        assert $writable_prim($s, #wrTime$2^121.1, $dot($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), _LIST_MANAGER.index));
        // *(ListManager->index) := res_lambda#4#9; 
        call $write_int(_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#4#9));
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
    assert $top_writable($s, #wrTime$2^121.1, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @writes_check(@_vcc_owns(@state, ListManager)); 
    assert (forall #writes$2^133.32: $ptr :: { $dont_instantiate(#writes$2^133.32) } $set_in(#writes$2^133.32, $owns($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))) ==> $top_writable($s, #wrTime$2^121.1, #writes$2^133.32));
    // stmt @_vcc_wrap(ListManager, @_vcc_typeof(ListManager)); 
    call $wrap($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_MANAGER);
    assume $good_state_ext(#tok$2^133.32, $s);
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } true; ==>(@keeps(ListManager, p), @_vcc_ptr_eq_pure(*((p->Manager)), ListManager)))); 
    assert (forall Q#p$1^47.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY)) ==> $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY), ^_LIST_MANAGER) == $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @inv_check(@keeps(ListManager, *((ListManager->ListHead)))); 
    assert $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY));
    // assert @inv_check(@keeps(ListManager, *((*((ListManager->ListHead))->Blink)))); 
    assert $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY), ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Flink))) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } true; ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Flink))), @_vcc_ptr_eq_pure(*((*((p->Flink))->Blink)), p))))); 
    assert (forall Q#p$1^60.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY)) ==> $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Blink))) } { @trigger_hint(@keeps(ListManager, *((p->Blink)))) } true; ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Blink))), @_vcc_ptr_eq_pure(*((*((p->Blink))->Flink)), p))))); 
    assert (forall Q#p$1^66.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY)) ==> $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Flink, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } true; ==>(&&(@keeps(ListManager, p), @_vcc_ptr_neq_pure(*((p->Flink)), *((ListManager->ListHead)))), ==(+(@map_get(*((ListManager->index)), p), 1), @map_get(*((ListManager->index)), *((p->Flink))))))); 
    assert (forall Q#p$1^75.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY) != $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)));
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((ListManager->ListHead))), 0)); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY)) == 0;
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((*((ListManager->ListHead))->Blink))), -(*((ListManager->size)), 1))); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY), ^_LIST_ENTRY)) == $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)) - 1;
    // assert @inv_check(forall(struct _LIST_ENTRY* e; { @keeps(ListManager, e) } true; ==>(@keeps(ListManager, e), <(@map_get(*((ListManager->index)), e), *((ListManager->size)))))); 
    assert (forall Q#e$1^83.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) < $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)));
    // assert @inv_check(forall(struct _LIST_ENTRY* e1; struct _LIST_ENTRY* e2; { @keeps(ListManager, e1), @keeps(ListManager, e2) } true; ==>(&&(&&(@keeps(ListManager, e1), @keeps(ListManager, e2)), @_vcc_ptr_neq_pure(e1, e2)), !=(@map_get(*((ListManager->index)), e1), @map_get(*((ListManager->index)), e2))))); 
    assert (forall Q#e1$1^87.31#dt1: $ptr, Q#e2$1^87.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)), $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)) && $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)) && $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY) != $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)) != $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure InsertHeadList(P#ListHead: $ptr, P#Entry: $ptr);
  requires $mutable($s, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY));
  requires $rd_inv($s, _LIST_MANAGER.size, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)) < 4294967295;
  requires $wrapped($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_MANAGER);
  requires $set_in($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $owns($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)));
  modifies $s, $cev_pc;
  ensures $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER) == $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER);
  ensures $rd_phys_ptr(old($s), _LIST_MANAGER.ListHead, $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_ENTRY) == $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_ENTRY);
  ensures (forall Q#le$1^265.29#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#le$1^265.29#dt1, ^_LIST_ENTRY), $owns(old($s), $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER))) } { sk_hack($set_in($phys_ptr_cast(Q#le$1^265.29#dt1, ^_LIST_ENTRY), $owns(old($s), $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)))) } $set_in($phys_ptr_cast(Q#le$1^265.29#dt1, ^_LIST_ENTRY), $owns(old($s), $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER))) ==> $emb(old($s), $phys_ptr_cast(Q#le$1^265.29#dt1, ^_LIST_ENTRY)) == $emb($s, $phys_ptr_cast(Q#le$1^265.29#dt1, ^_LIST_ENTRY)));
  ensures $set_in($phys_ptr_cast(P#Entry, ^_LIST_ENTRY), $owns($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)));
  ensures $rd_inv($s, _LIST_MANAGER.size, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)) == $rd_inv(old($s), _LIST_MANAGER.size, $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)) + 1;
  ensures $set_eq($owns($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)), $set_union($owns(old($s), $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)), $set_singleton($phys_ptr_cast(P#Entry, ^_LIST_ENTRY)))) && $set_in($phys_ptr_cast(P#Entry, ^_LIST_ENTRY), $owns($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)));
  ensures $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), ^_LIST_MANAGER) == $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER);
  ensures $wrapped($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), ^_LIST_MANAGER);
  ensures $set_in($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $owns($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER)));
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $rd_spec_ptr(old($s), _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER) || $set_in(#p, $span($phys_ptr_cast(P#Entry, ^_LIST_ENTRY)))));
  free ensures $call_transition(old($s), $s);



implementation InsertHeadList(P#ListHead: $ptr, P#Entry: $ptr)
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
  var SL#ListManager: $ptr;
  var #wrTime$2^158.1: int;
  var #stackframe: int;

  anon20:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$2^158.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$2^158.1, #loc.ListHead, $ptr_to_int(P#ListHead), $ptr_to(^_LIST_ENTRY));
    assume $local_value_is($s, #tok$2^158.1, #loc.Entry, $ptr_to_int(P#Entry), $ptr_to(^_LIST_ENTRY));
    assume #wrTime$2^158.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$2^158.1, (lambda #p: $ptr :: #p == $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER) || $set_in(#p, $span($phys_ptr_cast(P#Entry, ^_LIST_ENTRY)))));
    assume $thread_owned($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER));
    assume $mutable($s, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY));
    // assume true; 
    assume true;
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, *((ListHead->Manager)), *((ListHead->Manager))); 
    assert $in_domain_lab($s, $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER), l#public);
    // struct _LIST_MANAGER^ ListManager; 
    assume $local_value_is($s, #tok$2^160.27, #loc.ListManager, $ptr_to_int(SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // assert @reads_check_normal((ListHead->Manager)); 
    assert $thread_local($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // ListManager := *((ListHead->Manager)); 
    SL#ListManager := $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_MANAGER);
    assume $local_value_is($s, #tok$2^160.27, #loc.ListManager, $ptr_to_int(SL#ListManager), $spec_ptr_to(^_LIST_MANAGER));
    // assert @_vcc_in_domain(@state, ListHead, ListManager); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assume @_vcc_in_domain(@state, ListHead, ListManager); 
    assume $in_domain_lab($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assert @_vcc_in_domain(@state, *((ListHead->Flink)), ListManager); 
    assert $in_domain_lab($s, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assume @_vcc_in_domain(@state, *((ListHead->Flink)), ListManager); 
    assume $in_domain_lab($s, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), l#public);
    // assert @prim_writes_check((Entry->Blink)); 
    assert $writable_prim($s, #wrTime$2^158.1, $dot($phys_ptr_cast(P#Entry, ^_LIST_ENTRY), _LIST_ENTRY.Blink));
    // *(Entry->Blink) := ListHead; 
    call $write_int(_LIST_ENTRY.Blink, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), $ptr_to_int($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY)));
    assume $full_stop_ext(#tok$2^165.5, $s);
    // assert @prim_writes_check((Entry->Flink)); 
    assert $writable_prim($s, #wrTime$2^158.1, $dot($phys_ptr_cast(P#Entry, ^_LIST_ENTRY), _LIST_ENTRY.Flink));
    // assert @reads_check_normal((ListHead->Flink)); 
    assert $thread_local($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // *(Entry->Flink) := *((ListHead->Flink)); 
    call $write_int(_LIST_ENTRY.Flink, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), $ptr_to_int($rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY)));
    assume $full_stop_ext(#tok$2^166.5, $s);
    // assert @prim_writes_check((Entry->Manager)); 
    assert $writable_prim($s, #wrTime$2^158.1, $dot($phys_ptr_cast(P#Entry, ^_LIST_ENTRY), _LIST_ENTRY.Manager));
    // *(Entry->Manager) := ListManager; 
    call $write_int(_LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY), $ptr_to_int($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)));
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
    assert $top_writable($s, #wrTime$2^158.1, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(Entry), staticWrapState#74, owns#75)
    call $static_wrap($phys_ptr_cast(P#Entry, ^_LIST_ENTRY), staticWrapState#74, owns#75);
    assume $good_state_ext(#tok$2^168.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, Entry), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#77; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#77, $state_to_int(prestate#77), ^$#state_t);
    // prestate#77 := @_vcc_current_state(@state); 
    prestate#77 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#77, $state_to_int(prestate#77), ^$#state_t);
    // assert @_vcc_wrapped(@state, ListManager); 
    assert $wrapped($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_MANAGER);
    // assume @_vcc_inv(@state, ListManager); 
    assume $inv($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_MANAGER);
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$2^158.1, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // stmt @_vcc_unwrap(ListManager, @_vcc_typeof(ListManager)); 
    call $unwrap($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_MANAGER);
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
    assert $wrapped($s, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assert @writes_check(*((ListHead->Flink))); 
    assert $top_writable($s, #wrTime$2^158.1, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY));
    // assume @_vcc_inv(@state, *((ListHead->Flink))); 
    assume $inv($s, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assume ==(owns#79, @_vcc_owns(@state, *((ListHead->Flink)))); 
    assume owns#79 == $owns($s, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(*((ListHead->Flink))), prestate#80)
    call $static_unwrap($rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), prestate#80);
    assume $good_state_ext(#tok$2^170.36, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((*((ListHead->Flink))->Blink)); 
    assert $writable_prim($s, #wrTime$2^158.1, $dot($rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), _LIST_ENTRY.Blink));
    // assert @reads_check_normal((ListHead->Flink)); 
    assert $thread_local($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // *(*((ListHead->Flink))->Blink) := Entry; 
    call $write_int(_LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), $ptr_to_int($phys_ptr_cast(P#Entry, ^_LIST_ENTRY)));
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
    assert $top_writable($s, #wrTime$2^158.1, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(*((ListHead->Flink))), staticWrapState#81, owns#82)
    call $static_wrap($rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY), staticWrapState#81, owns#82);
    assume $good_state_ext(#tok$2^170.36, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((ListHead->Flink))), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY)), $set_empty());
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
    assert $wrapped($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assert @writes_check(ListHead); 
    assert $top_writable($s, #wrTime$2^158.1, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // assume @_vcc_inv(@state, ListHead); 
    assume $inv($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), ^_LIST_ENTRY);
    // assume ==(owns#85, @_vcc_owns(@state, ListHead)); 
    assume owns#85 == $owns($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(ListHead), prestate#86)
    call $static_unwrap($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), prestate#86);
    assume $good_state_ext(#tok$2^173.36, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((ListHead->Flink)); 
    assert $writable_prim($s, #wrTime$2^158.1, $dot($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), _LIST_ENTRY.Flink));
    // *(ListHead->Flink) := Entry; 
    call $write_int(_LIST_ENTRY.Flink, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), $ptr_to_int($phys_ptr_cast(P#Entry, ^_LIST_ENTRY)));
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
    assert $top_writable($s, #wrTime$2^158.1, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(ListHead), staticWrapState#87, owns#88)
    call $static_wrap($phys_ptr_cast(P#ListHead, ^_LIST_ENTRY), staticWrapState#87, owns#88);
    assume $good_state_ext(#tok$2^173.36, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, ListHead), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((ListManager->size)); 
    assert $writable_prim($s, #wrTime$2^158.1, $dot($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), _LIST_MANAGER.size));
    // assert @in_range_u4(+(*((ListManager->size)), 1)); 
    assert $in_range_u4($rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)) + 1);
    // assert @reads_check_normal((ListManager->size)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // *(ListManager->size) := +(*((ListManager->size)), 1); 
    call $write_int(_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)) + 1);
    assume $full_stop_ext(#tok$2^178.9, $s);
    // assert @writes_check(@_vcc_span(ListManager)); 
    assert (forall #writes$2^179.31: $ptr :: { $dont_instantiate(#writes$2^179.31) } $set_in(#writes$2^179.31, $span($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))) ==> $top_writable($s, #wrTime$2^158.1, #writes$2^179.31));
    // stmt _vcc_set_owns(ListManager, @_vcc_set_add_element(@_vcc_owns(@state, ListManager), Entry)); 
    call $set_owns($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $set_add_element($owns($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)), $phys_ptr_cast(P#Entry, ^_LIST_ENTRY)));
    assume $full_stop_ext(#tok$2^179.31, $s);
    // empty
    // (struct _LIST_ENTRY* -> uint32_t) res_lambda#5#10; 
    assume $local_value_is($s, #tok$2^180.31, #loc.res_lambda#5#10, $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#5#10), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @in_range_u4(+(@map_get(*((ListManager->index)), ListHead), 1)); 
    assert $in_range_u4($select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY)) + 1);
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // res_lambda#5#10 := lambda#5(*((ListManager->index)), *((ListManager->index)), @map_get(*((ListManager->index)), ListHead), *((ListManager->index)), +(@map_get(*((ListManager->index)), ListHead), 1), Entry); 
    call res_lambda#5#10 := lambda#5($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY)), $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(P#ListHead, ^_LIST_ENTRY)) + 1, $phys_ptr_cast(P#Entry, ^_LIST_ENTRY));
    assume $full_stop_ext(#tok$2^180.31, $s);
    assume $local_value_is($s, #tok$2^180.31, #loc.res_lambda#5#10, $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#5#10), $map_t($ptr_to(^_LIST_ENTRY), ^^u4));
    // assert @prim_writes_check((ListManager->index)); 
    assert $writable_prim($s, #wrTime$2^158.1, $dot($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), _LIST_MANAGER.index));
    // *(ListManager->index) := res_lambda#5#10; 
    call $write_int(_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(res_lambda#5#10));
    assume $full_stop_ext(#tok$2^180.9, $s);
    // _math state_t prestate#90; 
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#90, $state_to_int(prestate#90), ^$#state_t);
    // prestate#90 := @_vcc_current_state(@state); 
    prestate#90 := $current_state($s);
    assume $local_value_is($s, #tok$3^0.0, #loc.prestate#90, $state_to_int(prestate#90), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$2^158.1, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @writes_check(@_vcc_owns(@state, ListManager)); 
    assert (forall #writes$2^169.32: $ptr :: { $dont_instantiate(#writes$2^169.32) } $set_in(#writes$2^169.32, $owns($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))) ==> $top_writable($s, #wrTime$2^158.1, #writes$2^169.32));
    // stmt @_vcc_wrap(ListManager, @_vcc_typeof(ListManager)); 
    call $wrap($spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_MANAGER);
    assume $good_state_ext(#tok$2^169.32, $s);
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } true; ==>(@keeps(ListManager, p), @_vcc_ptr_eq_pure(*((p->Manager)), ListManager)))); 
    assert (forall Q#p$1^47.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY)) ==> $rd_spec_ptr($s, _LIST_ENTRY.Manager, $phys_ptr_cast(Q#p$1^47.31#dt1, ^_LIST_ENTRY), ^_LIST_MANAGER) == $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER));
    // assert @inv_check(@keeps(ListManager, *((ListManager->ListHead)))); 
    assert $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY));
    // assert @inv_check(@keeps(ListManager, *((*((ListManager->ListHead))->Blink)))); 
    assert $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY), ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Flink))) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } true; ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Flink))), @_vcc_ptr_eq_pure(*((*((p->Flink))->Blink)), p))))); 
    assert (forall Q#p$1^60.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY)) ==> $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^60.31#dt1, ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, *((p->Blink))) } { @trigger_hint(@keeps(ListManager, *((p->Blink)))) } true; ==>(@keeps(ListManager, p), &&(@keeps(ListManager, *((p->Blink))), @_vcc_ptr_eq_pure(*((*((p->Blink))->Flink)), p))))); 
    assert (forall Q#p$1^66.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY)) ==> $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Flink, $rd_phys_ptr($s, _LIST_ENTRY.Blink, $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY), ^_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^66.31#dt1, ^_LIST_ENTRY));
    // assert @inv_check(forall(struct _LIST_ENTRY* p; { @keeps(ListManager, p) } { @trigger_hint(@keeps(ListManager, *((p->Flink)))) } true; ==>(&&(@keeps(ListManager, p), @_vcc_ptr_neq_pure(*((p->Flink)), *((ListManager->ListHead)))), ==(+(@map_get(*((ListManager->index)), p), 1), @map_get(*((ListManager->index)), *((p->Flink))))))); 
    assert (forall Q#p$1^75.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) } { sk_hack($keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY))) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) && $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY) != $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY)) + 1 == $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Flink, $phys_ptr_cast(Q#p$1^75.31#dt1, ^_LIST_ENTRY), ^_LIST_ENTRY)));
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((ListManager->ListHead))), 0)); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY)) == 0;
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((*((ListManager->ListHead))->Blink))), -(*((ListManager->size)), 1))); 
    assert $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $rd_phys_ptr($s, _LIST_ENTRY.Blink, $rd_phys_ptr($s, _LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), ^_LIST_ENTRY), ^_LIST_ENTRY)) == $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)) - 1;
    // assert @inv_check(forall(struct _LIST_ENTRY* e; { @keeps(ListManager, e) } true; ==>(@keeps(ListManager, e), <(@map_get(*((ListManager->index)), e), *((ListManager->size)))))); 
    assert (forall Q#e$1^83.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^83.31#dt1, ^_LIST_ENTRY)) < $rd_inv($s, _LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER)));
    // assert @inv_check(forall(struct _LIST_ENTRY* e1; struct _LIST_ENTRY* e2; { @keeps(ListManager, e1), @keeps(ListManager, e2) } true; ==>(&&(&&(@keeps(ListManager, e1), @keeps(ListManager, e2)), @_vcc_ptr_neq_pure(e1, e2)), !=(@map_get(*((ListManager->index)), e1), @map_get(*((ListManager->index)), e2))))); 
    assert (forall Q#e1$1^87.31#dt1: $ptr, Q#e2$1^87.31#dt1: $ptr :: {:weight 10} { $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)), $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)) } $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)) && $keeps($s, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)) && $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY) != $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e1$1^87.31#dt1, ^_LIST_ENTRY)) != $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($rd_inv($s, _LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_LIST_MANAGER))), $phys_ptr_cast(Q#e2$1^87.31#dt1, ^_LIST_ENTRY)));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



function F#lambda#5(#l5: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l4: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l3: int, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: $ptr) : $map_t..$ptr_to..^_LIST_ENTRY.^^u4;

const unique cf#lambda#5: $pure_function;

axiom $function_arg_type(cf#lambda#5, 0, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#5, 1, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#5, 2, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#5, 3, ^^u4);

axiom $function_arg_type(cf#lambda#5, 4, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#5, 5, ^^u4);

axiom $function_arg_type(cf#lambda#5, 6, $ptr_to(^_LIST_ENTRY));

procedure lambda#5(#l5: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l4: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l3: int, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: $ptr) returns ($result: $map_t..$ptr_to..^_LIST_ENTRY.^^u4);
  free ensures $result == F#lambda#5(#l5, #l4, #l3, #l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#x$2^180.31#dt1: $ptr, #l5: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l4: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l3: int, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(F#lambda#5(#l5, #l4, #l3, #l2, #l1, $phys_ptr_cast(#l0, ^_LIST_ENTRY)), $phys_ptr_cast(Q#x$2^180.31#dt1, ^_LIST_ENTRY)) } true && $in_range_u4(#l3) && $in_range_u4(#l1) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(F#lambda#5(#l5, #l4, #l3, #l2, #l1, $phys_ptr_cast(#l0, ^_LIST_ENTRY)), $phys_ptr_cast(Q#x$2^180.31#dt1, ^_LIST_ENTRY)) == (if $phys_ptr_cast(Q#x$2^180.31#dt1, ^_LIST_ENTRY) == $phys_ptr_cast(#l0, ^_LIST_ENTRY) then #l1 else (if $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l2, $phys_ptr_cast(Q#x$2^180.31#dt1, ^_LIST_ENTRY)) <= #l3 then $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l4, $phys_ptr_cast(Q#x$2^180.31#dt1, ^_LIST_ENTRY)) else $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l5, $phys_ptr_cast(Q#x$2^180.31#dt1, ^_LIST_ENTRY)) + 1)));

function F#lambda#4(#l5: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l4: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l3: int, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: $ptr) : $map_t..$ptr_to..^_LIST_ENTRY.^^u4;

const unique cf#lambda#4: $pure_function;

axiom $function_arg_type(cf#lambda#4, 0, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#4, 1, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#4, 2, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#4, 3, ^^u4);

axiom $function_arg_type(cf#lambda#4, 4, $map_t($ptr_to(^_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#4, 5, ^^u4);

axiom $function_arg_type(cf#lambda#4, 6, $ptr_to(^_LIST_ENTRY));

procedure lambda#4(#l5: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l4: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l3: int, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: $ptr) returns ($result: $map_t..$ptr_to..^_LIST_ENTRY.^^u4);
  free ensures $result == F#lambda#4(#l5, #l4, #l3, #l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#x$2^148.35#dt1: $ptr, #l5: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l4: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l3: int, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(F#lambda#4(#l5, #l4, #l3, #l2, #l1, $phys_ptr_cast(#l0, ^_LIST_ENTRY)), $phys_ptr_cast(Q#x$2^148.35#dt1, ^_LIST_ENTRY)) } true && $in_range_u4(#l3) && $in_range_u4(#l1) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(F#lambda#4(#l5, #l4, #l3, #l2, #l1, $phys_ptr_cast(#l0, ^_LIST_ENTRY)), $phys_ptr_cast(Q#x$2^148.35#dt1, ^_LIST_ENTRY)) == (if $phys_ptr_cast(Q#x$2^148.35#dt1, ^_LIST_ENTRY) == $phys_ptr_cast(#l0, ^_LIST_ENTRY) then #l1 else (if $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l2, $phys_ptr_cast(Q#x$2^148.35#dt1, ^_LIST_ENTRY)) < #l3 then $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l4, $phys_ptr_cast(Q#x$2^148.35#dt1, ^_LIST_ENTRY)) else $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l5, $phys_ptr_cast(Q#x$2^148.35#dt1, ^_LIST_ENTRY)) + 1)));

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



axiom (forall Q#x$2^113.31#dt1: $ptr, #l3: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: $map_t..$ptr_to..^_LIST_ENTRY.^^u4 :: {:weight 10} { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(F#lambda#3(#l3, #l2, #l1, #l0), $phys_ptr_cast(Q#x$2^113.31#dt1, ^_LIST_ENTRY)) } true && $in_range_u4(#l1) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(F#lambda#3(#l3, #l2, #l1, #l0), $phys_ptr_cast(Q#x$2^113.31#dt1, ^_LIST_ENTRY)) == (if $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l0, $phys_ptr_cast(Q#x$2^113.31#dt1, ^_LIST_ENTRY)) < #l1 then $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l2, $phys_ptr_cast(Q#x$2^113.31#dt1, ^_LIST_ENTRY)) else $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l3, $phys_ptr_cast(Q#x$2^113.31#dt1, ^_LIST_ENTRY)) - 1));

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



axiom (forall Q#x$2^83.31#dt1: $ptr, #l3: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: $map_t..$ptr_to..^_LIST_ENTRY.^^u4 :: {:weight 10} { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(F#lambda#2(#l3, #l2, #l1, #l0), $phys_ptr_cast(Q#x$2^83.31#dt1, ^_LIST_ENTRY)) } true && $in_range_u4(#l1) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(F#lambda#2(#l3, #l2, #l1, #l0), $phys_ptr_cast(Q#x$2^83.31#dt1, ^_LIST_ENTRY)) == (if $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l0, $phys_ptr_cast(Q#x$2^83.31#dt1, ^_LIST_ENTRY)) < #l1 then $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l2, $phys_ptr_cast(Q#x$2^83.31#dt1, ^_LIST_ENTRY)) else $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l3, $phys_ptr_cast(Q#x$2^83.31#dt1, ^_LIST_ENTRY)) - 1));

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



axiom (forall Q#x$2^52.31#dt1: $ptr, #l3: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, #l1: int, #l0: $map_t..$ptr_to..^_LIST_ENTRY.^^u4 :: {:weight 10} { $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(F#lambda#1(#l3, #l2, #l1, #l0), $phys_ptr_cast(Q#x$2^52.31#dt1, ^_LIST_ENTRY)) } true && $in_range_u4(#l1) ==> $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(F#lambda#1(#l3, #l2, #l1, #l0), $phys_ptr_cast(Q#x$2^52.31#dt1, ^_LIST_ENTRY)) == (if $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l0, $phys_ptr_cast(Q#x$2^52.31#dt1, ^_LIST_ENTRY)) < #l1 then $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l2, $phys_ptr_cast(Q#x$2^52.31#dt1, ^_LIST_ENTRY)) else $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(#l3, $phys_ptr_cast(Q#x$2^52.31#dt1, ^_LIST_ENTRY)) - 1));

const unique l#public: $label;

type $map_t..$ptr_to..^_LIST_ENTRY.^^u4;

function $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, p: $ptr) : int;

function $store.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, p: $ptr, v: int) : $map_t..$ptr_to..^_LIST_ENTRY.^^u4;

function $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M1: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, M2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4) : bool;

const $zero.$map_t..$ptr_to..^_LIST_ENTRY.^^u4: $map_t..$ptr_to..^_LIST_ENTRY.^^u4;

axiom (forall M: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, p: $ptr, v: int :: true);

axiom (forall M: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, p: $ptr, v: int, q: $ptr :: $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($store.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M, q, v), p) == (if $phys_ptr_cast(p, ^_LIST_ENTRY) == $phys_ptr_cast(q, ^_LIST_ENTRY) then $unchecked(^^u4, v) else $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M, p)));

axiom (forall M1: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, M2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4 :: { $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M1, M2) } (forall p: $ptr :: $unchecked(^^u4, $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M1, $phys_ptr_cast(p, ^_LIST_ENTRY))) == $unchecked(^^u4, $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M2, $phys_ptr_cast(p, ^_LIST_ENTRY)))) ==> $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, M2: $map_t..$ptr_to..^_LIST_ENTRY.^^u4 :: { $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M1, M2) } $eq.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4(0) == $zero.$map_t..$ptr_to..^_LIST_ENTRY.^^u4;

axiom (forall p: $ptr :: $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4($zero.$map_t..$ptr_to..^_LIST_ENTRY.^^u4, p) == 0);

axiom true;

axiom (forall M: $map_t..$ptr_to..^_LIST_ENTRY.^^u4, p: $ptr :: $in_range_t(^^u4, $select.$map_t..$ptr_to..^_LIST_ENTRY.^^u4(M, p)));

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

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CList.c: $token;

axiom $file_name_is(2, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CList.c);

const unique #loc._this_: $token;

const unique #tok$1^37.53: $token;

function $map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(x: $map_t..$ptr_to..^_LIST_ENTRY.^^u4) : int;

function $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4(x: int) : $map_t..$ptr_to..^_LIST_ENTRY.^^u4;

axiom (forall #x: $map_t..$ptr_to..^_LIST_ENTRY.^^u4 :: #x == $int_to_map_t..ptr_to..^_LIST_ENTRY.^^u4($map_t..ptr_to..^_LIST_ENTRY.^^u4_to_int(#x)));

const unique #distTp3: $ctype;

axiom #distTp3 == $map_t($ptr_to(^_LIST_ENTRY), ^^u4);

const unique #file^c?3A?5Cdev?5Cfelt?5Cvcc?5Ctest?5Ctestsuite?5Cexamples3?5Clist.h: $token;

axiom $file_name_is(1, #file^c?3A?5Cdev?5Cfelt?5Cvcc?5Ctest?5Ctestsuite?5Cexamples3?5Clist.h);

const unique #distTp2: $ctype;

axiom #distTp2 == $spec_ptr_to(^_LIST_MANAGER);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^_LIST_ENTRY);
