axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

const unique ^_SINGLE_LIST_ENTRY: $ctype;

axiom $is_span_sequential(^_SINGLE_LIST_ENTRY);

axiom $def_struct_type(^_SINGLE_LIST_ENTRY, 8, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_SINGLE_LIST_ENTRY) } $inv2(#s1, #s2, #p, ^_SINGLE_LIST_ENTRY) == $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^_SINGLE_LIST_ENTRY)) } $in(q, $composite_extent(s, p, ^_SINGLE_LIST_ENTRY)) == (q == p));

const unique _SINGLE_LIST_ENTRY.Next: $field;

axiom $def_phys_field(^_SINGLE_LIST_ENTRY, _SINGLE_LIST_ENTRY.Next, $ptr_to(^_SINGLE_LIST_ENTRY), false, 0);

const unique _SINGLE_LIST_ENTRY.Back: $field;

axiom $def_ghost_field(^_SINGLE_LIST_ENTRY, _SINGLE_LIST_ENTRY.Back, $ptr_to(^_SINGLE_LIST_ENTRY), false);

const unique _SINGLE_LIST_ENTRY.Manager: $field;

axiom $def_ghost_field(^_SINGLE_LIST_ENTRY, _SINGLE_LIST_ENTRY.Manager, $spec_ptr_to(^_SINGLE_LIST_MANAGER), false);

const unique ^_SINGLE_LIST_MANAGER: $ctype;

axiom $is_span_sequential(^_SINGLE_LIST_MANAGER);

axiom $def_struct_type(^_SINGLE_LIST_MANAGER, 1, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_SINGLE_LIST_MANAGER) } $inv2(#s1, #s2, #p, ^_SINGLE_LIST_MANAGER) == ((forall Q#p$1^54.31#tc1: $ptr :: {:weight 10} { $set_in(Q#p$1^54.31#tc1, $owns(#s2, #p)) } $set_in(Q#p$1^54.31#tc1, $owns(#s2, #p)) ==> $is(Q#p$1^54.31#tc1, ^_SINGLE_LIST_ENTRY)) && (forall Q#p$1^58.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#p$1^58.31#dt1, ^_SINGLE_LIST_ENTRY), $owns(#s2, #p)) } $set_in($phys_ptr_cast(Q#p$1^58.31#dt1, ^_SINGLE_LIST_ENTRY), $owns(#s2, #p)) ==> $rd_spec_ptr(#s2, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(Q#p$1^58.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER) == #p) && $set_in($rd_phys_ptr(#s2, _SINGLE_LIST_MANAGER.ListHead, #p, ^_SINGLE_LIST_ENTRY), $owns(#s2, #p)) && (forall Q#p$1^67.31#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr(#s2, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns(#s2, #p)) } { sk_hack($set_in($rd_phys_ptr(#s2, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns(#s2, #p))) } $set_in($phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), $owns(#s2, #p)) && $non_null($rd_phys_ptr(#s2, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $set_in($rd_phys_ptr(#s2, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns(#s2, #p)) && $rd_phys_ptr(#s2, _SINGLE_LIST_ENTRY.Back, $rd_phys_ptr(#s2, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY)) && (forall Q#p$1^72.31#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr(#s2, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns(#s2, #p)) } { sk_hack($set_in($rd_phys_ptr(#s2, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns(#s2, #p))) } $set_in($phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), $owns(#s2, #p)) && $non_null($rd_phys_ptr(#s2, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $set_in($rd_phys_ptr(#s2, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns(#s2, #p)) && $rd_phys_ptr(#s2, _SINGLE_LIST_ENTRY.Next, $rd_phys_ptr(#s2, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY)) && (forall Q#p$1^81.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), $owns(#s2, #p)) } { sk_hack($set_in($rd_phys_ptr(#s2, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns(#s2, #p))) } $set_in($phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), $owns(#s2, #p)) && $non_null($rd_phys_ptr(#s2, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv(#s2, _SINGLE_LIST_MANAGER.index, #p)), $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY)) + 1 == $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv(#s2, _SINGLE_LIST_MANAGER.index, #p)), $rd_phys_ptr(#s2, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY))) && $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv(#s2, _SINGLE_LIST_MANAGER.index, #p)), $rd_phys_ptr(#s2, _SINGLE_LIST_MANAGER.ListHead, #p, ^_SINGLE_LIST_ENTRY)) == 0 && (forall Q#e$1^88.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY), $owns(#s2, #p)) } $set_in($phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY), $owns(#s2, #p)) ==> 0 <= $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv(#s2, _SINGLE_LIST_MANAGER.index, #p)), $phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY)) && $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv(#s2, _SINGLE_LIST_MANAGER.index, #p)), $phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY)) < $rd_inv(#s2, _SINGLE_LIST_MANAGER.size, #p)) && (forall Q#e1$1^92.31#dt1: $ptr, Q#e2$1^92.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns(#s2, #p)), $set_in($phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns(#s2, #p)) } $set_in($phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns(#s2, #p)) && $set_in($phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns(#s2, #p)) && $phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY) != $phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv(#s2, _SINGLE_LIST_MANAGER.index, #p)), $phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY)) != $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv(#s2, _SINGLE_LIST_MANAGER.index, #p)), $phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY)))));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^_SINGLE_LIST_MANAGER)) } $in(q, $composite_extent(s, p, ^_SINGLE_LIST_MANAGER)) == (q == p));

const unique _SINGLE_LIST_MANAGER.size: $field;

axiom $def_ghost_field(^_SINGLE_LIST_MANAGER, _SINGLE_LIST_MANAGER.size, ^^u4, false);

const unique _SINGLE_LIST_MANAGER.ListHead: $field;

axiom $def_ghost_field(^_SINGLE_LIST_MANAGER, _SINGLE_LIST_MANAGER.ListHead, $ptr_to(^_SINGLE_LIST_ENTRY), false);

const unique _SINGLE_LIST_MANAGER.index: $field;

axiom $def_ghost_field(^_SINGLE_LIST_MANAGER, _SINGLE_LIST_MANAGER.index, $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4), false);

procedure _SINGLE_LIST_MANAGER#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> (forall Q#p$1^54.31#tc1: $ptr :: {:weight 10} { $set_in(Q#p$1^54.31#tc1, $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) } $set_in(Q#p$1^54.31#tc1, $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) ==> $is(Q#p$1^54.31#tc1, ^_SINGLE_LIST_ENTRY));
  ensures $is_admissibility_check() ==> (forall Q#p$1^58.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#p$1^58.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) } $set_in($phys_ptr_cast(Q#p$1^58.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) ==> $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(Q#p$1^58.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER) == $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER));
  ensures $is_admissibility_check() ==> $set_in($rd_phys_ptr($s, _SINGLE_LIST_MANAGER.ListHead, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER)));
  ensures $is_admissibility_check() ==> (forall Q#p$1^67.31#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) } { sk_hack($set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER)))) } $set_in($phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) && $non_null($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) && $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY));
  ensures $is_admissibility_check() ==> (forall Q#p$1^72.31#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) } { sk_hack($set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER)))) } $set_in($phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) && $non_null($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) && $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY));
  ensures $is_admissibility_check() ==> (forall Q#p$1^81.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) } { sk_hack($set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER)))) } $set_in($phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) && $non_null($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY)) + 1 == $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))), $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)));
  ensures $is_admissibility_check() ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))), $rd_phys_ptr($s, _SINGLE_LIST_MANAGER.ListHead, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_ENTRY)) == 0;
  ensures $is_admissibility_check() ==> (forall Q#e$1^88.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) } $set_in($phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) ==> 0 <= $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY)) && $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY)) < $rd_inv($s, _SINGLE_LIST_MANAGER.size, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER)));
  ensures $is_admissibility_check() ==> (forall Q#e1$1^92.31#dt1: $ptr, Q#e2$1^92.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))), $set_in($phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) } $set_in($phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) && $set_in($phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) && $phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY) != $phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY)) != $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY)));
  ensures $is_unwrap_check() ==> (forall Q#p$1^54.31#tc1: $ptr :: {:weight 10} { $set_in(Q#p$1^54.31#tc1, $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) } $set_in(Q#p$1^54.31#tc1, $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) ==> $is(Q#p$1^54.31#tc1, ^_SINGLE_LIST_ENTRY));
  ensures $is_unwrap_check() ==> (forall Q#p$1^58.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#p$1^58.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) } $set_in($phys_ptr_cast(Q#p$1^58.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) ==> $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(Q#p$1^58.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER) == $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER));
  ensures $is_unwrap_check() ==> $set_in($rd_phys_ptr($s, _SINGLE_LIST_MANAGER.ListHead, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER)));
  ensures $is_unwrap_check() ==> (forall Q#p$1^67.31#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) } { sk_hack($set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER)))) } $set_in($phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) && $non_null($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) && $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY));
  ensures $is_unwrap_check() ==> (forall Q#p$1^72.31#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) } { sk_hack($set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER)))) } $set_in($phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) && $non_null($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) && $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY));
  ensures $is_unwrap_check() ==> (forall Q#p$1^81.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) } { sk_hack($set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER)))) } $set_in($phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) && $non_null($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY)) + 1 == $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))), $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)));
  ensures $is_unwrap_check() ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))), $rd_phys_ptr($s, _SINGLE_LIST_MANAGER.ListHead, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_ENTRY)) == 0;
  ensures $is_unwrap_check() ==> (forall Q#e$1^88.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) } $set_in($phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) ==> 0 <= $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY)) && $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY)) < $rd_inv($s, _SINGLE_LIST_MANAGER.size, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER)));
  ensures $is_unwrap_check() ==> (forall Q#e1$1^92.31#dt1: $ptr, Q#e2$1^92.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))), $set_in($phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) } $set_in($phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) && $set_in($phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))) && $phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY) != $phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY)) != $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY)));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _SINGLE_LIST_MANAGER#adm(P#_this_: $ptr)
{
  var #wrTime$1^44.53: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^44.53, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^44.53, #loc._this_, $ptr_to_int(P#_this_), $spec_ptr_to(^_SINGLE_LIST_MANAGER));
    assume #wrTime$1^44.53 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^44.53, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_MANAGER);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER));
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
            assume $admissibility_pre($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct _SINGLE_LIST_MANAGER*)@null))
        call $havoc_others($spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_MANAGER);
        assume $good_state_ext(#tok$1^44.53, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $spec_ptr_cast(P#_this_, ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_MANAGER);
    }

  #exit:
}



procedure InitializeSingleListHead(P#ListHead: $ptr);
  requires $mutable($s, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY));
  modifies $s, $cev_pc;
  ensures $set_eq($owns($s, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)), $set_singleton($phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY))) && $set_in($phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), $owns($s, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)));
  ensures $rd_phys_ptr($s, _SINGLE_LIST_MANAGER.ListHead, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_ENTRY) == $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY);
  ensures $rd_inv($s, _SINGLE_LIST_MANAGER.size, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)) == 1;
  ensures $wrapped($s, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_MANAGER);
  ensures $is_fresh(old($s), $s, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER));
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: $set_in(#p, $extent(old($s), $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY)))));
  free ensures $call_transition(old($s), $s);



implementation InitializeSingleListHead(P#ListHead: $ptr)
{
  var prestate#8: $state;
  var owns#6: $ptrset;
  var staticWrapState#5: $state;
  var prestate#7: $state;
  var SL#ListManager: $ptr;
  var #wrTime$1^117.1: int;
  var #stackframe: int;

  anon7:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^117.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^117.1, #loc.ListHead, $ptr_to_int(P#ListHead), $ptr_to(^_SINGLE_LIST_ENTRY));
    assume #wrTime$1^117.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^117.1, (lambda #p: $ptr :: $set_in(#p, $extent($s, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY)))));
    assume $extent_mutable($s, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // struct _SINGLE_LIST_MANAGER^ ListManager; 
    assume $local_value_is($s, #tok$1^126.27, #loc.ListManager, $ptr_to_int(SL#ListManager), $spec_ptr_to(^_SINGLE_LIST_MANAGER));
    // var spec struct _SINGLE_LIST_MANAGER^ ListManager
    // assert @prim_writes_check((ListHead->Next)); 
    assert $writable_prim($s, #wrTime$1^117.1, $dot($phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Next));
    // *(ListHead->Next) := (struct _SINGLE_LIST_ENTRY*)@null; 
    call $write_int(_SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), $ptr_to_int($phys_ptr_cast($null, ^_SINGLE_LIST_ENTRY)));
    assume $full_stop_ext(#tok$1^127.5, $s);
    // assert @prim_writes_check((ListHead->Back)); 
    assert $writable_prim($s, #wrTime$1^117.1, $dot($phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Back));
    // *(ListHead->Back) := (struct _SINGLE_LIST_ENTRY*)@null; 
    call $write_int(_SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), $ptr_to_int($phys_ptr_cast($null, ^_SINGLE_LIST_ENTRY)));
    assume $full_stop_ext(#tok$1^128.27, $s);
    // ListManager := _vcc_spec_alloc<struct _SINGLE_LIST_MANAGER>(); 
    call SL#ListManager := $spec_alloc(^_SINGLE_LIST_MANAGER);
    assume $full_stop_ext(#tok$1^131.19, $s);
    assume $local_value_is($s, #tok$1^131.19, #loc.ListManager, $ptr_to_int(SL#ListManager), $spec_ptr_to(^_SINGLE_LIST_MANAGER));
    // assert @prim_writes_check((ListManager->size)); 
    assert $writable_prim($s, #wrTime$1^117.1, $dot($spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), _SINGLE_LIST_MANAGER.size));
    // *(ListManager->size) := 1; 
    call $write_int(_SINGLE_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), 1);
    assume $full_stop_ext(#tok$1^132.5, $s);
    // assert @prim_writes_check((ListManager->index)); 
    assert $writable_prim($s, #wrTime$1^117.1, $dot($spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), _SINGLE_LIST_MANAGER.index));
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER));
    // *(ListManager->index) := @map_updated(*((ListManager->index)), ListHead, 0); 
    call $write_int(_SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), $map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4_to_int($store.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), 0)));
    assume $full_stop_ext(#tok$1^133.5, $s);
    // assert @prim_writes_check((ListManager->ListHead)); 
    assert $writable_prim($s, #wrTime$1^117.1, $dot($spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), _SINGLE_LIST_MANAGER.ListHead));
    // *(ListManager->ListHead) := ListHead; 
    call $write_int(_SINGLE_LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), $ptr_to_int($phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY)));
    assume $full_stop_ext(#tok$1^134.5, $s);
    // assert @writes_check(@_vcc_span(ListHead)); 
    assert (forall #writes$1^136.27: $ptr :: { $dont_instantiate(#writes$1^136.27) } $set_in(#writes$1^136.27, $span($phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY))) ==> $top_writable($s, #wrTime$1^117.1, #writes$1^136.27));
    // stmt _vcc_set_owns(ListHead, @_vcc_set_empty); 
    call $set_owns($phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), $set_empty());
    assume $full_stop_ext(#tok$1^136.27, $s);
    // empty
    // assert @writes_check(@_vcc_span(ListManager)); 
    assert (forall #writes$1^137.27: $ptr :: { $dont_instantiate(#writes$1^137.27) } $set_in(#writes$1^137.27, $span($spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) ==> $top_writable($s, #wrTime$1^117.1, #writes$1^137.27));
    // stmt _vcc_set_owns(ListManager, @_vcc_set_singleton(ListHead)); 
    call $set_owns($spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), $set_singleton($phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY)));
    assume $full_stop_ext(#tok$1^137.27, $s);
    // empty
    // assert @prim_writes_check((ListHead->Manager)); 
    assert $writable_prim($s, #wrTime$1^117.1, $dot($phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Manager));
    // *(ListHead->Manager) := ListManager; 
    call $write_int(_SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), $ptr_to_int($spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)));
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
    assert $top_writable($s, #wrTime$1^117.1, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(ListHead), staticWrapState#5, owns#6)
    call $static_wrap($phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), staticWrapState#5, owns#6);
    assume $good_state_ext(#tok$1^139.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, ListHead), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY)), $set_empty());
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
    assert $top_writable($s, #wrTime$1^117.1, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER));
    // assert @writes_check(@_vcc_owns(@state, ListManager)); 
    assert (forall #writes$1^140.21: $ptr :: { $dont_instantiate(#writes$1^140.21) } $set_in(#writes$1^140.21, $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) ==> $top_writable($s, #wrTime$1^117.1, #writes$1^140.21));
    // stmt @_vcc_wrap(ListManager, @_vcc_typeof(ListManager)); 
    call $wrap($spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_MANAGER);
    assume $good_state_ext(#tok$1^140.21, $s);
    // assert @inv_check(forall(obj_t p; { @_vcc_set_in(p, @_vcc_owns(@state, ListManager)) } true; ==>(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_is(p, @_vcc_typeof((struct _SINGLE_LIST_ENTRY*)@null))))); 
    assert (forall Q#p$1^54.31#tc1: $ptr :: {:weight 10} { $set_in(Q#p$1^54.31#tc1, $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) } $set_in(Q#p$1^54.31#tc1, $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) ==> $is(Q#p$1^54.31#tc1, ^_SINGLE_LIST_ENTRY));
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(p, @_vcc_owns(@state, ListManager)) } true; ==>(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_eq_pure(*((p->Manager)), ListManager)))); 
    assert (forall Q#p$1^58.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#p$1^58.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) } $set_in($phys_ptr_cast(Q#p$1^58.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) ==> $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(Q#p$1^58.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER) == $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER));
    // assert @inv_check(@_vcc_set_in(*((ListManager->ListHead)), @_vcc_owns(@state, ListManager))); 
    assert $set_in($rd_phys_ptr($s, _SINGLE_LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)));
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager)) } { @trigger_hint(@_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager))) } true; ==>(&&(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_neq_null(*((p->Next)))), &&(@_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager)), @_vcc_ptr_eq_pure(*((*((p->Next))->Back)), p))))); 
    assert (forall Q#p$1^67.31#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) } { sk_hack($set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)))) } $set_in($phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) && $non_null($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) && $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY));
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(*((p->Back)), @_vcc_owns(@state, ListManager)) } { @trigger_hint(@_vcc_set_in(*((p->Back)), @_vcc_owns(@state, ListManager))) } true; ==>(&&(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_neq_null(*((p->Back)))), &&(@_vcc_set_in(*((p->Back)), @_vcc_owns(@state, ListManager)), @_vcc_ptr_eq_pure(*((*((p->Back))->Next)), p))))); 
    assert (forall Q#p$1^72.31#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) } { sk_hack($set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)))) } $set_in($phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) && $non_null($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) && $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY));
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(p, @_vcc_owns(@state, ListManager)) } { @trigger_hint(@_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager))) } true; ==>(&&(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_neq_null(*((p->Next)))), ==(+(@map_get(*((ListManager->index)), p), 1), @map_get(*((ListManager->index)), *((p->Next))))))); 
    assert (forall Q#p$1^81.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) } { sk_hack($set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)))) } $set_in($phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) && $non_null($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY)) + 1 == $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)));
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((ListManager->ListHead))), 0)); 
    assert $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $rd_phys_ptr($s, _SINGLE_LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_ENTRY)) == 0;
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* e; { @_vcc_set_in(e, @_vcc_owns(@state, ListManager)) } true; ==>(@_vcc_set_in(e, @_vcc_owns(@state, ListManager)), &&(<=(0, @map_get(*((ListManager->index)), e)), <(@map_get(*((ListManager->index)), e), *((ListManager->size))))))); 
    assert (forall Q#e$1^88.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) } $set_in($phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) ==> 0 <= $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY)) && $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY)) < $rd_inv($s, _SINGLE_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)));
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* e1; struct _SINGLE_LIST_ENTRY* e2; { @_vcc_set_in(e1, @_vcc_owns(@state, ListManager)), @_vcc_set_in(e2, @_vcc_owns(@state, ListManager)) } true; ==>(&&(&&(@_vcc_set_in(e1, @_vcc_owns(@state, ListManager)), @_vcc_set_in(e2, @_vcc_owns(@state, ListManager))), @_vcc_ptr_neq_pure(e1, e2)), !=(@map_get(*((ListManager->index)), e1), @map_get(*((ListManager->index)), e2))))); 
    assert (forall Q#e1$1^92.31#dt1: $ptr, Q#e2$1^92.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $set_in($phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) } $set_in($phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) && $set_in($phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) && $phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY) != $phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY)) != $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY)));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure PopEntryList(P#ListHead: $ptr) returns ($result: $ptr);
  requires $set_in($phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), $owns($s, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)));
  requires $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY) == $rd_phys_ptr($s, _SINGLE_LIST_MANAGER.ListHead, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_ENTRY);
  requires $closed($s, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY));
  requires $wrapped($s, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_MANAGER);
  modifies $s, $cev_pc;
  free ensures true;
  ensures $rd_inv(old($s), _SINGLE_LIST_MANAGER.size, $rd_spec_ptr(old($s), _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)) == 1 ==> $is_null($phys_ptr_cast($result, ^_SINGLE_LIST_ENTRY));
  ensures $rd_inv(old($s), _SINGLE_LIST_MANAGER.size, $rd_spec_ptr(old($s), _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)) > 1 ==> $phys_ptr_cast($result, ^_SINGLE_LIST_ENTRY) == $rd_phys_ptr(old($s), _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY);
  ensures $is_null($phys_ptr_cast($result, ^_SINGLE_LIST_ENTRY)) ==> $rd_inv(old($s), _SINGLE_LIST_MANAGER.size, $rd_spec_ptr(old($s), _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)) == $rd_inv($s, _SINGLE_LIST_MANAGER.size, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER));
  ensures $is_null($phys_ptr_cast($result, ^_SINGLE_LIST_ENTRY)) ==> $set_eq($owns($s, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)), $owns(old($s), $rd_spec_ptr(old($s), _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)));
  ensures $non_null($phys_ptr_cast($result, ^_SINGLE_LIST_ENTRY)) ==> $rd_inv($s, _SINGLE_LIST_MANAGER.size, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)) == $rd_inv(old($s), _SINGLE_LIST_MANAGER.size, $rd_spec_ptr(old($s), _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)) - 1;
  ensures $non_null($phys_ptr_cast($result, ^_SINGLE_LIST_ENTRY)) ==> $set_eq($owns($s, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)), $set_difference($owns(old($s), $rd_spec_ptr(old($s), _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)), $set_singleton($phys_ptr_cast($result, ^_SINGLE_LIST_ENTRY))));
  ensures $non_null($phys_ptr_cast($result, ^_SINGLE_LIST_ENTRY)) ==> $wrapped($s, $phys_ptr_cast($result, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY);
  ensures $wrapped($s, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_MANAGER);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $rd_spec_ptr(old($s), _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)));
  free ensures $call_transition(old($s), $s);



implementation PopEntryList(P#ListHead: $ptr) returns ($result: $ptr)
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
  var L#FirstEntry: $ptr;
  var SL#ListManager: $ptr;
  var #wrTime$1^161.1: int;
  var #stackframe: int;

  anon13:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^161.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^161.1, #loc.ListHead, $ptr_to_int(P#ListHead), $ptr_to(^_SINGLE_LIST_ENTRY));
    assume #wrTime$1^161.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^161.1, (lambda #p: $ptr :: #p == $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)));
    assume $thread_owned($s, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, *((ListHead->Manager)), *((ListHead->Manager))); 
    assert $in_domain_lab($s, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER), $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER), l#public);
    // struct _SINGLE_LIST_MANAGER^ ListManager; 
    assume $local_value_is($s, #tok$1^176.27, #loc.ListManager, $ptr_to_int(SL#ListManager), $spec_ptr_to(^_SINGLE_LIST_MANAGER));
    // struct _SINGLE_LIST_ENTRY* FirstEntry; 
    assume $local_value_is($s, #tok$1^175.5, #loc.FirstEntry, $ptr_to_int(L#FirstEntry), $ptr_to(^_SINGLE_LIST_ENTRY));
    // var struct _SINGLE_LIST_ENTRY* FirstEntry
    // assert @reads_check_normal((ListHead->Manager)); 
    assert $thread_local($s, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY));
    // ListManager := *((ListHead->Manager)); 
    SL#ListManager := $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER);
    assume $local_value_is($s, #tok$1^176.27, #loc.ListManager, $ptr_to_int(SL#ListManager), $spec_ptr_to(^_SINGLE_LIST_MANAGER));
    // assert @_vcc_in_domain(@state, ListHead, ListManager); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), l#public);
    // assume @_vcc_in_domain(@state, ListHead, ListManager); 
    assume $in_domain_lab($s, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), l#public);
    // assert ==>(@_vcc_ptr_neq_null(*((ListHead->Next))), @_vcc_in_domain(@state, *((ListHead->Next)), ListManager)); 
    assert $non_null($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $in_domain_lab($s, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), l#public);
    // assume ==>(@_vcc_ptr_neq_null(*((ListHead->Next))), @_vcc_in_domain(@state, *((ListHead->Next)), ListManager)); 
    assume $non_null($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $in_domain_lab($s, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), l#public);
    // assert @reads_check_normal((ListHead->Next)); 
    assert $thread_local($s, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY));
    // FirstEntry := *((ListHead->Next)); 
    L#FirstEntry := $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY);
    assume $local_value_is($s, #tok$1^181.5, #loc.FirstEntry, $ptr_to_int(L#FirstEntry), $ptr_to(^_SINGLE_LIST_ENTRY));
    assume true;
    // if (@_vcc_ptr_neq_null(FirstEntry)) ...
    if ($non_null($phys_ptr_cast(L#FirstEntry, ^_SINGLE_LIST_ENTRY)))
    {
      anon10:
        // assert >(*((ListManager->size)), 1); 
        assert $rd_inv($s, _SINGLE_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)) > 1;
        // assume >(*((ListManager->size)), 1); 
        assume $rd_inv($s, _SINGLE_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)) > 1;
        // assert ==>(@_vcc_ptr_neq_null(*((FirstEntry->Next))), @_vcc_in_domain(@state, *((FirstEntry->Next)), ListManager)); 
        assert $non_null($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(L#FirstEntry, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $in_domain_lab($s, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(L#FirstEntry, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), l#public);
        // assume ==>(@_vcc_ptr_neq_null(*((FirstEntry->Next))), @_vcc_in_domain(@state, *((FirstEntry->Next)), ListManager)); 
        assume $non_null($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(L#FirstEntry, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $in_domain_lab($s, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(L#FirstEntry, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), l#public);
        // _math state_t prestate#9; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#9, $state_to_int(prestate#9), ^$#state_t);
        // prestate#9 := @_vcc_current_state(@state); 
        prestate#9 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#9, $state_to_int(prestate#9), ^$#state_t);
        // assert @_vcc_wrapped(@state, ListManager); 
        assert $wrapped($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_MANAGER);
        // assume @_vcc_inv(@state, ListManager); 
        assume $inv($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_MANAGER);
        // assume @_vcc_pre_unwrap(@state); 
        assume $pre_unwrap($s);
        // assert @writes_check(ListManager); 
        assert $top_writable($s, #wrTime$1^161.1, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER));
        // stmt @_vcc_unwrap(ListManager, @_vcc_typeof(ListManager)); 
        call $unwrap($spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_MANAGER);
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
        assert $wrapped($s, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY);
        // assert @writes_check(ListHead); 
        assert $top_writable($s, #wrTime$1^161.1, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY));
        // assume @_vcc_inv(@state, ListHead); 
        assume $inv($s, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY);
        // assume ==(owns#11, @_vcc_owns(@state, ListHead)); 
        assume owns#11 == $owns($s, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY));
        // assume @_vcc_pre_static_unwrap(@state); 
        assume $pre_static_unwrap($s);
        // @_vcc_static_unwrap(pure(ListHead), prestate#12)
        call $static_unwrap($phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), prestate#12);
        assume $good_state_ext(#tok$1^187.40, $s);
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // assert @prim_writes_check((ListHead->Next)); 
        assert $writable_prim($s, #wrTime$1^161.1, $dot($phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Next));
        // assert @reads_check_normal((FirstEntry->Next)); 
        assert $thread_local($s, $phys_ptr_cast(L#FirstEntry, ^_SINGLE_LIST_ENTRY));
        // *(ListHead->Next) := *((FirstEntry->Next)); 
        call $write_int(_SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), $ptr_to_int($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(L#FirstEntry, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)));
        assume $full_stop_ext(#tok$1^188.17, $s);
        // assert @reads_check_normal((ListHead->Next)); 
        assert $thread_local($s, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY));
        assume true;
        // if (@_vcc_ptr_neq_null(*((ListHead->Next)))) ...
        if ($non_null($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)))
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
            assert $wrapped($s, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY);
            // assert @writes_check(*((ListHead->Next))); 
            assert $top_writable($s, #wrTime$1^161.1, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY));
            // assume @_vcc_inv(@state, *((ListHead->Next))); 
            assume $inv($s, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY);
            // assume ==(owns#14, @_vcc_owns(@state, *((ListHead->Next)))); 
            assume owns#14 == $owns($s, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY));
            // assume @_vcc_pre_static_unwrap(@state); 
            assume $pre_static_unwrap($s);
            // @_vcc_static_unwrap(pure(*((ListHead->Next))), prestate#15)
            call $static_unwrap($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), prestate#15);
            assume $good_state_ext(#tok$1^191.48, $s);
            // assume @_vcc_full_stop(@state); 
            assume $full_stop($s);
            // assert @prim_writes_check((*((ListHead->Next))->Back)); 
            assert $writable_prim($s, #wrTime$1^161.1, $dot($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Back));
            // assert @reads_check_normal((ListHead->Next)); 
            assert $thread_local($s, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY));
            // *(*((ListHead->Next))->Back) := ListHead; 
            call $write_int(_SINGLE_LIST_ENTRY.Back, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $ptr_to_int($phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY)));
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
            assert $top_writable($s, #wrTime$1^161.1, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY));
            // assume @_vcc_pre_static_wrap(@state); 
            assume $pre_static_wrap($s);
            // @_vcc_static_wrap(pure(*((ListHead->Next))), staticWrapState#16, owns#17)
            call $static_wrap($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), staticWrapState#16, owns#17);
            assume $good_state_ext(#tok$1^191.48, $s);
            // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((ListHead->Next))), @_vcc_set_empty)); 
            assert $set_eq($owns($s, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)), $set_empty());
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
        assert $top_writable($s, #wrTime$1^161.1, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(ListHead), staticWrapState#19, owns#20)
        call $static_wrap($phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), staticWrapState#19, owns#20);
        assume $good_state_ext(#tok$1^187.40, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, ListHead), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY)), $set_empty());
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // assert @prim_writes_check((ListManager->size)); 
        assert $writable_prim($s, #wrTime$1^161.1, $dot($spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), _SINGLE_LIST_MANAGER.size));
        // assert @in_range_u4(-(*((ListManager->size)), 1)); 
        assert $in_range_u4($rd_inv($s, _SINGLE_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)) - 1);
        // assert @reads_check_normal((ListManager->size)); 
        assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER));
        // *(ListManager->size) := -(*((ListManager->size)), 1); 
        call $write_int(_SINGLE_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), $rd_inv($s, _SINGLE_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)) - 1);
        assume $full_stop_ext(#tok$1^197.13, $s);
        // assert @_vcc_set_in(FirstEntry, @_vcc_owns(@state, ListManager)); 
        assert $set_in($phys_ptr_cast(L#FirstEntry, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)));
        // assume @_vcc_set_in(FirstEntry, @_vcc_owns(@state, ListManager)); 
        assume $set_in($phys_ptr_cast(L#FirstEntry, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)));
        // assert @writes_check(@_vcc_span(ListManager)); 
        assert (forall #writes$1^198.35: $ptr :: { $dont_instantiate(#writes$1^198.35) } $set_in(#writes$1^198.35, $span($spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) ==> $top_writable($s, #wrTime$1^161.1, #writes$1^198.35));
        // stmt _vcc_set_owns(ListManager, @_vcc_set_remove_element(@_vcc_owns(@state, ListManager), FirstEntry)); 
        call $set_owns($spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), $set_remove_element($owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)), $phys_ptr_cast(L#FirstEntry, ^_SINGLE_LIST_ENTRY)));
        assume $full_stop_ext(#tok$1^198.35, $s);
        // empty
        // (struct _SINGLE_LIST_ENTRY* -> uint32_t) res_lambda#1#3; 
        assume $local_value_is($s, #tok$1^199.35, #loc.res_lambda#1#3, $map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4_to_int(res_lambda#1#3), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
        // assert @reads_check_normal((ListManager->index)); 
        assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER));
        // res_lambda#1#3 := lambda#1(*((ListManager->index)), ListHead); 
        call res_lambda#1#3 := lambda#1($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY));
        assume $full_stop_ext(#tok$1^199.35, $s);
        assume $local_value_is($s, #tok$1^199.35, #loc.res_lambda#1#3, $map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4_to_int(res_lambda#1#3), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
        // assert @prim_writes_check((ListManager->index)); 
        assert $writable_prim($s, #wrTime$1^161.1, $dot($spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), _SINGLE_LIST_MANAGER.index));
        // *(ListManager->index) := res_lambda#1#3; 
        call $write_int(_SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), $map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4_to_int(res_lambda#1#3));
        assume $full_stop_ext(#tok$1^199.13, $s);
        // assert >(old(@prestate, *((ListManager->size))), 0); 
        assert $rd_inv(old($s), _SINGLE_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)) > 0;
        // assume >(old(@prestate, *((ListManager->size))), 0); 
        assume $rd_inv(old($s), _SINGLE_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)) > 0;
        // assert ==(*((ListManager->size)), -(old(@prestate, *((ListManager->size))), 1)); 
        assert $rd_inv($s, _SINGLE_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)) == $rd_inv(old($s), _SINGLE_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)) - 1;
        // assume ==(*((ListManager->size)), -(old(@prestate, *((ListManager->size))), 1)); 
        assume $rd_inv($s, _SINGLE_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)) == $rd_inv(old($s), _SINGLE_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)) - 1;
        // _math state_t prestate#22; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#22, $state_to_int(prestate#22), ^$#state_t);
        // prestate#22 := @_vcc_current_state(@state); 
        prestate#22 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#22, $state_to_int(prestate#22), ^$#state_t);
        // assume @_vcc_pre_wrap(@state); 
        assume $pre_wrap($s);
        // assert @writes_check(ListManager); 
        assert $top_writable($s, #wrTime$1^161.1, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER));
        // assert @writes_check(@_vcc_owns(@state, ListManager)); 
        assert (forall #writes$1^186.36: $ptr :: { $dont_instantiate(#writes$1^186.36) } $set_in(#writes$1^186.36, $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) ==> $top_writable($s, #wrTime$1^161.1, #writes$1^186.36));
        // stmt @_vcc_wrap(ListManager, @_vcc_typeof(ListManager)); 
        call $wrap($spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_MANAGER);
        assume $good_state_ext(#tok$1^186.36, $s);
        // assert @inv_check(forall(obj_t p; { @_vcc_set_in(p, @_vcc_owns(@state, ListManager)) } true; ==>(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_is(p, @_vcc_typeof((struct _SINGLE_LIST_ENTRY*)@null))))); 
        assert (forall Q#p$1^54.31#tc1: $ptr :: {:weight 10} { $set_in(Q#p$1^54.31#tc1, $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) } $set_in(Q#p$1^54.31#tc1, $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) ==> $is(Q#p$1^54.31#tc1, ^_SINGLE_LIST_ENTRY));
        // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(p, @_vcc_owns(@state, ListManager)) } true; ==>(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_eq_pure(*((p->Manager)), ListManager)))); 
        assert (forall Q#p$1^58.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#p$1^58.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) } $set_in($phys_ptr_cast(Q#p$1^58.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) ==> $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(Q#p$1^58.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER) == $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER));
        // assert @inv_check(@_vcc_set_in(*((ListManager->ListHead)), @_vcc_owns(@state, ListManager))); 
        assert $set_in($rd_phys_ptr($s, _SINGLE_LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)));
        // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager)) } { @trigger_hint(@_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager))) } true; ==>(&&(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_neq_null(*((p->Next)))), &&(@_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager)), @_vcc_ptr_eq_pure(*((*((p->Next))->Back)), p))))); 
        assert (forall Q#p$1^67.31#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) } { sk_hack($set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)))) } $set_in($phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) && $non_null($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) && $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY));
        // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(*((p->Back)), @_vcc_owns(@state, ListManager)) } { @trigger_hint(@_vcc_set_in(*((p->Back)), @_vcc_owns(@state, ListManager))) } true; ==>(&&(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_neq_null(*((p->Back)))), &&(@_vcc_set_in(*((p->Back)), @_vcc_owns(@state, ListManager)), @_vcc_ptr_eq_pure(*((*((p->Back))->Next)), p))))); 
        assert (forall Q#p$1^72.31#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) } { sk_hack($set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)))) } $set_in($phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) && $non_null($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) && $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY));
        // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(p, @_vcc_owns(@state, ListManager)) } { @trigger_hint(@_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager))) } true; ==>(&&(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_neq_null(*((p->Next)))), ==(+(@map_get(*((ListManager->index)), p), 1), @map_get(*((ListManager->index)), *((p->Next))))))); 
        assert (forall Q#p$1^81.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) } { sk_hack($set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)))) } $set_in($phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) && $non_null($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY)) + 1 == $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)));
        // assert @inv_check(==(@map_get(*((ListManager->index)), *((ListManager->ListHead))), 0)); 
        assert $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $rd_phys_ptr($s, _SINGLE_LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_ENTRY)) == 0;
        // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* e; { @_vcc_set_in(e, @_vcc_owns(@state, ListManager)) } true; ==>(@_vcc_set_in(e, @_vcc_owns(@state, ListManager)), &&(<=(0, @map_get(*((ListManager->index)), e)), <(@map_get(*((ListManager->index)), e), *((ListManager->size))))))); 
        assert (forall Q#e$1^88.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) } $set_in($phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) ==> 0 <= $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY)) && $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY)) < $rd_inv($s, _SINGLE_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)));
        // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* e1; struct _SINGLE_LIST_ENTRY* e2; { @_vcc_set_in(e1, @_vcc_owns(@state, ListManager)), @_vcc_set_in(e2, @_vcc_owns(@state, ListManager)) } true; ==>(&&(&&(@_vcc_set_in(e1, @_vcc_owns(@state, ListManager)), @_vcc_set_in(e2, @_vcc_owns(@state, ListManager))), @_vcc_ptr_neq_pure(e1, e2)), !=(@map_get(*((ListManager->index)), e1), @map_get(*((ListManager->index)), e2))))); 
        assert (forall Q#e1$1^92.31#dt1: $ptr, Q#e2$1^92.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $set_in($phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) } $set_in($phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) && $set_in($phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) && $phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY) != $phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY)) != $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY)));
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
    $result := $phys_ptr_cast(L#FirstEntry, ^_SINGLE_LIST_ENTRY);
    assert $position_marker();
    goto #exit;

  anon15:
    // empty

  #exit:
}



procedure PushEntryList(P#ListHead: $ptr, P#Entry: $ptr);
  requires $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY) == $rd_phys_ptr($s, _SINGLE_LIST_MANAGER.ListHead, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_ENTRY);
  requires $mutable($s, $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY));
  requires $rd_inv($s, _SINGLE_LIST_MANAGER.size, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)) < 2147483647;
  requires $wrapped($s, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_MANAGER);
  requires $set_in($phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), $owns($s, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)));
  modifies $s, $cev_pc;
  ensures $set_in($phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY), $owns($s, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)));
  ensures $rd_inv($s, _SINGLE_LIST_MANAGER.size, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)) == $rd_inv(old($s), _SINGLE_LIST_MANAGER.size, $rd_spec_ptr(old($s), _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)) + 1;
  ensures $set_eq($owns($s, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)), $set_union($owns(old($s), $rd_spec_ptr(old($s), _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)), $set_singleton($phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY)))) && $set_in($phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY), $owns($s, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)));
  ensures $wrapped($s, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_MANAGER);
  ensures $set_in($phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), $owns($s, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER)));
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $rd_spec_ptr(old($s), _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER) || $set_in(#p, $extent(old($s), $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY)))));
  free ensures $call_transition(old($s), $s);



implementation PushEntryList(P#ListHead: $ptr, P#Entry: $ptr)
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
  var SL#ListManager: $ptr;
  var #wrTime$1^224.1: int;
  var #stackframe: int;

  anon18:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^224.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^224.1, #loc.ListHead, $ptr_to_int(P#ListHead), $ptr_to(^_SINGLE_LIST_ENTRY));
    assume $local_value_is($s, #tok$1^224.1, #loc.Entry, $ptr_to_int(P#Entry), $ptr_to(^_SINGLE_LIST_ENTRY));
    assume #wrTime$1^224.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^224.1, (lambda #p: $ptr :: #p == $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER) || $set_in(#p, $extent($s, $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY)))));
    assume $thread_owned($s, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER));
    assume $extent_mutable($s, $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY));
    // assume true; 
    assume true;
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, *((ListHead->Manager)), *((ListHead->Manager))); 
    assert $in_domain_lab($s, $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER), $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER), l#public);
    // struct _SINGLE_LIST_MANAGER^ ListManager; 
    assume $local_value_is($s, #tok$1^236.27, #loc.ListManager, $ptr_to_int(SL#ListManager), $spec_ptr_to(^_SINGLE_LIST_MANAGER));
    // assert @reads_check_normal((ListHead->Manager)); 
    assert $thread_local($s, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY));
    // ListManager := *((ListHead->Manager)); 
    SL#ListManager := $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER);
    assume $local_value_is($s, #tok$1^236.27, #loc.ListManager, $ptr_to_int(SL#ListManager), $spec_ptr_to(^_SINGLE_LIST_MANAGER));
    // assert @_vcc_in_domain(@state, ListHead, ListManager); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), l#public);
    // assume @_vcc_in_domain(@state, ListHead, ListManager); 
    assume $in_domain_lab($s, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), l#public);
    // assert ==>(@_vcc_ptr_neq_null(*((ListHead->Next))), @_vcc_in_domain(@state, *((ListHead->Next)), ListManager)); 
    assert $non_null($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $in_domain_lab($s, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), l#public);
    // assume ==>(@_vcc_ptr_neq_null(*((ListHead->Next))), @_vcc_in_domain(@state, *((ListHead->Next)), ListManager)); 
    assume $non_null($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $in_domain_lab($s, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), l#public);
    // _math state_t prestate#23; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#23, $state_to_int(prestate#23), ^$#state_t);
    // prestate#23 := @_vcc_current_state(@state); 
    prestate#23 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#23, $state_to_int(prestate#23), ^$#state_t);
    // assert @_vcc_wrapped(@state, ListManager); 
    assert $wrapped($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_MANAGER);
    // assume @_vcc_inv(@state, ListManager); 
    assume $inv($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_MANAGER);
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$1^224.1, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER));
    // stmt @_vcc_unwrap(ListManager, @_vcc_typeof(ListManager)); 
    call $unwrap($spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_MANAGER);
    assume $good_state_ext(#tok$1^243.32, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((Entry->Next)); 
    assert $writable_prim($s, #wrTime$1^224.1, $dot($phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Next));
    // assert @reads_check_normal((ListHead->Next)); 
    assert $thread_local($s, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY));
    // *(Entry->Next) := *((ListHead->Next)); 
    call $write_int(_SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY), $ptr_to_int($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)));
    assume $full_stop_ext(#tok$1^244.9, $s);
    // assert @writes_check(@_vcc_span(Entry)); 
    assert (forall #writes$1^247.31: $ptr :: { $dont_instantiate(#writes$1^247.31) } $set_in(#writes$1^247.31, $span($phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY))) ==> $top_writable($s, #wrTime$1^224.1, #writes$1^247.31));
    // stmt _vcc_set_owns(Entry, @_vcc_set_empty); 
    call $set_owns($phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY), $set_empty());
    assume $full_stop_ext(#tok$1^247.31, $s);
    // empty
    // assert @prim_writes_check((Entry->Back)); 
    assert $writable_prim($s, #wrTime$1^224.1, $dot($phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Back));
    // *(Entry->Back) := ListHead; 
    call $write_int(_SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY), $ptr_to_int($phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY)));
    assume $full_stop_ext(#tok$1^248.9, $s);
    // assert @prim_writes_check((Entry->Manager)); 
    assert $writable_prim($s, #wrTime$1^224.1, $dot($phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Manager));
    // *(Entry->Manager) := ListManager; 
    call $write_int(_SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY), $ptr_to_int($spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)));
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
    assert $top_writable($s, #wrTime$1^224.1, $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(Entry), staticWrapState#24, owns#25)
    call $static_wrap($phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY), staticWrapState#24, owns#25);
    assume $good_state_ext(#tok$1^250.25, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, Entry), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @reads_check_normal((Entry->Next)); 
    assert $thread_local($s, $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY));
    assume true;
    // if (@_vcc_ptr_neq_null(*((Entry->Next)))) ...
    if ($non_null($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)))
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
        assert $wrapped($s, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY);
        // assert @writes_check(*((Entry->Next))); 
        assert $top_writable($s, #wrTime$1^224.1, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY));
        // assume @_vcc_inv(@state, *((Entry->Next))); 
        assume $inv($s, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY);
        // assume ==(owns#28, @_vcc_owns(@state, *((Entry->Next)))); 
        assume owns#28 == $owns($s, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY));
        // assume @_vcc_pre_static_unwrap(@state); 
        assume $pre_static_unwrap($s);
        // @_vcc_static_unwrap(pure(*((Entry->Next))), prestate#29)
        call $static_unwrap($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), prestate#29);
        assume $good_state_ext(#tok$1^253.40, $s);
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // assert @prim_writes_check((*((Entry->Next))->Back)); 
        assert $writable_prim($s, #wrTime$1^224.1, $dot($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Back));
        // assert @reads_check_normal((Entry->Next)); 
        assert $thread_local($s, $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY));
        // *(*((Entry->Next))->Back) := Entry; 
        call $write_int(_SINGLE_LIST_ENTRY.Back, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $ptr_to_int($phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY)));
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
        assert $top_writable($s, #wrTime$1^224.1, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(*((Entry->Next))), staticWrapState#30, owns#31)
        call $static_wrap($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), staticWrapState#30, owns#31);
        assume $good_state_ext(#tok$1^253.40, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((Entry->Next))), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)), $set_empty());
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
    assert $wrapped($s, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY);
    // assert @writes_check(ListHead); 
    assert $top_writable($s, #wrTime$1^224.1, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY));
    // assume @_vcc_inv(@state, ListHead); 
    assume $inv($s, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY);
    // assume ==(owns#34, @_vcc_owns(@state, ListHead)); 
    assume owns#34 == $owns($s, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(ListHead), prestate#35)
    call $static_unwrap($phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), prestate#35);
    assume $good_state_ext(#tok$1^258.36, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((ListHead->Next)); 
    assert $writable_prim($s, #wrTime$1^224.1, $dot($phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), _SINGLE_LIST_ENTRY.Next));
    // *(ListHead->Next) := Entry; 
    call $write_int(_SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), $ptr_to_int($phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY)));
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
    assert $top_writable($s, #wrTime$1^224.1, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(ListHead), staticWrapState#36, owns#37)
    call $static_wrap($phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY), staticWrapState#36, owns#37);
    assume $good_state_ext(#tok$1^258.36, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, ListHead), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((ListManager->size)); 
    assert $writable_prim($s, #wrTime$1^224.1, $dot($spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), _SINGLE_LIST_MANAGER.size));
    // assert @in_range_u4(+(*((ListManager->size)), 1)); 
    assert $in_range_u4($rd_inv($s, _SINGLE_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)) + 1);
    // assert @reads_check_normal((ListManager->size)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER));
    // *(ListManager->size) := +(*((ListManager->size)), 1); 
    call $write_int(_SINGLE_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), $rd_inv($s, _SINGLE_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)) + 1);
    assume $full_stop_ext(#tok$1^263.9, $s);
    // assert @writes_check(@_vcc_span(ListManager)); 
    assert (forall #writes$1^264.31: $ptr :: { $dont_instantiate(#writes$1^264.31) } $set_in(#writes$1^264.31, $span($spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) ==> $top_writable($s, #wrTime$1^224.1, #writes$1^264.31));
    // stmt _vcc_set_owns(ListManager, @_vcc_set_add_element(@_vcc_owns(@state, ListManager), Entry)); 
    call $set_owns($spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), $set_add_element($owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)), $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY)));
    assume $full_stop_ext(#tok$1^264.31, $s);
    // empty
    // (struct _SINGLE_LIST_ENTRY* -> uint32_t) res_lambda#2#4; 
    assume $local_value_is($s, #tok$1^265.31, #loc.res_lambda#2#4, $map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4_to_int(res_lambda#2#4), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER));
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER));
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER));
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER));
    // assert @in_range_u4(+(@map_get(*((ListManager->index)), ListHead), 1)); 
    assert $in_range_u4($select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY)) + 1);
    // assert @reads_check_normal((ListManager->index)); 
    assert $thread_local($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER));
    // res_lambda#2#4 := lambda#2(*((ListManager->index)), *((ListManager->index)), @map_get(*((ListManager->index)), ListHead), *((ListManager->index)), +(@map_get(*((ListManager->index)), ListHead), 1), Entry); 
    call res_lambda#2#4 := lambda#2($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY)), $int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(P#ListHead, ^_SINGLE_LIST_ENTRY)) + 1, $phys_ptr_cast(P#Entry, ^_SINGLE_LIST_ENTRY));
    assume $full_stop_ext(#tok$1^265.31, $s);
    assume $local_value_is($s, #tok$1^265.31, #loc.res_lambda#2#4, $map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4_to_int(res_lambda#2#4), $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));
    // assert @prim_writes_check((ListManager->index)); 
    assert $writable_prim($s, #wrTime$1^224.1, $dot($spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), _SINGLE_LIST_MANAGER.index));
    // *(ListManager->index) := res_lambda#2#4; 
    call $write_int(_SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), $map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4_to_int(res_lambda#2#4));
    assume $full_stop_ext(#tok$1^265.9, $s);
    // _math state_t prestate#39; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#39, $state_to_int(prestate#39), ^$#state_t);
    // prestate#39 := @_vcc_current_state(@state); 
    prestate#39 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#39, $state_to_int(prestate#39), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(ListManager); 
    assert $top_writable($s, #wrTime$1^224.1, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER));
    // assert @writes_check(@_vcc_owns(@state, ListManager)); 
    assert (forall #writes$1^243.32: $ptr :: { $dont_instantiate(#writes$1^243.32) } $set_in(#writes$1^243.32, $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) ==> $top_writable($s, #wrTime$1^224.1, #writes$1^243.32));
    // stmt @_vcc_wrap(ListManager, @_vcc_typeof(ListManager)); 
    call $wrap($spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_MANAGER);
    assume $good_state_ext(#tok$1^243.32, $s);
    // assert @inv_check(forall(obj_t p; { @_vcc_set_in(p, @_vcc_owns(@state, ListManager)) } true; ==>(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_is(p, @_vcc_typeof((struct _SINGLE_LIST_ENTRY*)@null))))); 
    assert (forall Q#p$1^54.31#tc1: $ptr :: {:weight 10} { $set_in(Q#p$1^54.31#tc1, $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) } $set_in(Q#p$1^54.31#tc1, $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) ==> $is(Q#p$1^54.31#tc1, ^_SINGLE_LIST_ENTRY));
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(p, @_vcc_owns(@state, ListManager)) } true; ==>(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_eq_pure(*((p->Manager)), ListManager)))); 
    assert (forall Q#p$1^58.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#p$1^58.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) } $set_in($phys_ptr_cast(Q#p$1^58.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) ==> $rd_spec_ptr($s, _SINGLE_LIST_ENTRY.Manager, $phys_ptr_cast(Q#p$1^58.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_MANAGER) == $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER));
    // assert @inv_check(@_vcc_set_in(*((ListManager->ListHead)), @_vcc_owns(@state, ListManager))); 
    assert $set_in($rd_phys_ptr($s, _SINGLE_LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)));
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager)) } { @trigger_hint(@_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager))) } true; ==>(&&(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_neq_null(*((p->Next)))), &&(@_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager)), @_vcc_ptr_eq_pure(*((*((p->Next))->Back)), p))))); 
    assert (forall Q#p$1^67.31#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) } { sk_hack($set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)))) } $set_in($phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) && $non_null($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) && $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^67.31#dt1, ^_SINGLE_LIST_ENTRY));
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(*((p->Back)), @_vcc_owns(@state, ListManager)) } { @trigger_hint(@_vcc_set_in(*((p->Back)), @_vcc_owns(@state, ListManager))) } true; ==>(&&(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_neq_null(*((p->Back)))), &&(@_vcc_set_in(*((p->Back)), @_vcc_owns(@state, ListManager)), @_vcc_ptr_eq_pure(*((*((p->Back))->Next)), p))))); 
    assert (forall Q#p$1^72.31#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) } { sk_hack($set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)))) } $set_in($phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) && $non_null($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) && $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Back, $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY) == $phys_ptr_cast(Q#p$1^72.31#dt1, ^_SINGLE_LIST_ENTRY));
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* p; { @_vcc_set_in(p, @_vcc_owns(@state, ListManager)) } { @trigger_hint(@_vcc_set_in(*((p->Next)), @_vcc_owns(@state, ListManager))) } true; ==>(&&(@_vcc_set_in(p, @_vcc_owns(@state, ListManager)), @_vcc_ptr_neq_null(*((p->Next)))), ==(+(@map_get(*((ListManager->index)), p), 1), @map_get(*((ListManager->index)), *((p->Next))))))); 
    assert (forall Q#p$1^81.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) } { sk_hack($set_in($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)))) } $set_in($phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) && $non_null($rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY)) + 1 == $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $rd_phys_ptr($s, _SINGLE_LIST_ENTRY.Next, $phys_ptr_cast(Q#p$1^81.31#dt1, ^_SINGLE_LIST_ENTRY), ^_SINGLE_LIST_ENTRY)));
    // assert @inv_check(==(@map_get(*((ListManager->index)), *((ListManager->ListHead))), 0)); 
    assert $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $rd_phys_ptr($s, _SINGLE_LIST_MANAGER.ListHead, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER), ^_SINGLE_LIST_ENTRY)) == 0;
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* e; { @_vcc_set_in(e, @_vcc_owns(@state, ListManager)) } true; ==>(@_vcc_set_in(e, @_vcc_owns(@state, ListManager)), &&(<=(0, @map_get(*((ListManager->index)), e)), <(@map_get(*((ListManager->index)), e), *((ListManager->size))))))); 
    assert (forall Q#e$1^88.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) } $set_in($phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) ==> 0 <= $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY)) && $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#e$1^88.31#dt1, ^_SINGLE_LIST_ENTRY)) < $rd_inv($s, _SINGLE_LIST_MANAGER.size, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER)));
    // assert @inv_check(forall(struct _SINGLE_LIST_ENTRY* e1; struct _SINGLE_LIST_ENTRY* e2; { @_vcc_set_in(e1, @_vcc_owns(@state, ListManager)), @_vcc_set_in(e2, @_vcc_owns(@state, ListManager)) } true; ==>(&&(&&(@_vcc_set_in(e1, @_vcc_owns(@state, ListManager)), @_vcc_set_in(e2, @_vcc_owns(@state, ListManager))), @_vcc_ptr_neq_pure(e1, e2)), !=(@map_get(*((ListManager->index)), e1), @map_get(*((ListManager->index)), e2))))); 
    assert (forall Q#e1$1^92.31#dt1: $ptr, Q#e2$1^92.31#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $set_in($phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) } $set_in($phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) && $set_in($phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY), $owns($s, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))) && $phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY) != $phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#e1$1^92.31#dt1, ^_SINGLE_LIST_ENTRY)) != $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4($rd_inv($s, _SINGLE_LIST_MANAGER.index, $spec_ptr_cast(SL#ListManager, ^_SINGLE_LIST_MANAGER))), $phys_ptr_cast(Q#e2$1^92.31#dt1, ^_SINGLE_LIST_ENTRY)));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



function F#lambda#2(#l5: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l4: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l3: int, #l2: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l1: int, #l0: $ptr) : $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4;

const unique cf#lambda#2: $pure_function;

axiom $function_arg_type(cf#lambda#2, 0, $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#2, 1, $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#2, 2, $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#2, 3, ^^u4);

axiom $function_arg_type(cf#lambda#2, 4, $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#2, 5, ^^u4);

axiom $function_arg_type(cf#lambda#2, 6, $ptr_to(^_SINGLE_LIST_ENTRY));

procedure lambda#2(#l5: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l4: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l3: int, #l2: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l1: int, #l0: $ptr) returns ($result: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4);
  free ensures $result == F#lambda#2(#l5, #l4, #l3, #l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#x$1^265.31#dt1: $ptr, #l5: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l4: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l3: int, #l2: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l1: int, #l0: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(F#lambda#2(#l5, #l4, #l3, #l2, #l1, $phys_ptr_cast(#l0, ^_SINGLE_LIST_ENTRY)), $phys_ptr_cast(Q#x$1^265.31#dt1, ^_SINGLE_LIST_ENTRY)) } true && $in_range_u4(#l3) && $in_range_u4(#l1) ==> $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(F#lambda#2(#l5, #l4, #l3, #l2, #l1, $phys_ptr_cast(#l0, ^_SINGLE_LIST_ENTRY)), $phys_ptr_cast(Q#x$1^265.31#dt1, ^_SINGLE_LIST_ENTRY)) == (if $phys_ptr_cast(Q#x$1^265.31#dt1, ^_SINGLE_LIST_ENTRY) == $phys_ptr_cast(#l0, ^_SINGLE_LIST_ENTRY) then #l1 else (if $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(#l2, $phys_ptr_cast(Q#x$1^265.31#dt1, ^_SINGLE_LIST_ENTRY)) <= #l3 then $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(#l4, $phys_ptr_cast(Q#x$1^265.31#dt1, ^_SINGLE_LIST_ENTRY)) else $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(#l5, $phys_ptr_cast(Q#x$1^265.31#dt1, ^_SINGLE_LIST_ENTRY)) + 1)));

function F#lambda#1(#l1: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l0: $ptr) : $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4;

const unique cf#lambda#1: $pure_function;

axiom $function_arg_type(cf#lambda#1, 0, $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#1, 1, $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4));

axiom $function_arg_type(cf#lambda#1, 2, $ptr_to(^_SINGLE_LIST_ENTRY));

procedure lambda#1(#l1: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l0: $ptr) returns ($result: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4);
  free ensures $result == F#lambda#1(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#x$1^199.35#dt1: $ptr, #l1: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, #l0: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(F#lambda#1(#l1, $phys_ptr_cast(#l0, ^_SINGLE_LIST_ENTRY)), $phys_ptr_cast(Q#x$1^199.35#dt1, ^_SINGLE_LIST_ENTRY)) } $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(F#lambda#1(#l1, $phys_ptr_cast(#l0, ^_SINGLE_LIST_ENTRY)), $phys_ptr_cast(Q#x$1^199.35#dt1, ^_SINGLE_LIST_ENTRY)) == (if $phys_ptr_cast(Q#x$1^199.35#dt1, ^_SINGLE_LIST_ENTRY) == $phys_ptr_cast(#l0, ^_SINGLE_LIST_ENTRY) then 0 else $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(#l1, $phys_ptr_cast(Q#x$1^199.35#dt1, ^_SINGLE_LIST_ENTRY)) - 1));

const unique l#public: $label;

type $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4;

function $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, p: $ptr) : int;

function $store.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, p: $ptr, v: int) : $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4;

function $eq.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M1: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, M2: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4) : bool;

const $zero.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4;

axiom (forall M: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, p: $ptr, v: int :: true);

axiom (forall M: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, p: $ptr, v: int, q: $ptr :: $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($store.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M, q, v), p) == (if $phys_ptr_cast(p, ^_SINGLE_LIST_ENTRY) == $phys_ptr_cast(q, ^_SINGLE_LIST_ENTRY) then $unchecked(^^u4, v) else $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M, p)));

axiom (forall M1: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, M2: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4 :: { $eq.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M1, M2) } (forall p: $ptr :: $unchecked(^^u4, $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M1, $phys_ptr_cast(p, ^_SINGLE_LIST_ENTRY))) == $unchecked(^^u4, $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M2, $phys_ptr_cast(p, ^_SINGLE_LIST_ENTRY)))) ==> $eq.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, M2: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4 :: { $eq.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M1, M2) } $eq.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^_SINGLE_LIST_ENTRY.^^u4(0) == $zero.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4;

axiom (forall p: $ptr :: $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4($zero.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, p) == 0);

axiom true;

axiom (forall M: $map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4, p: $ptr :: $in_range_t(^^u4, $select.$map_t..$ptr_to..^_SINGLE_LIST_ENTRY.^^u4(M, p)));

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

const unique #distTp3: $ctype;

axiom #distTp3 == $map_t($ptr_to(^_SINGLE_LIST_ENTRY), ^^u4);

axiom $type_code_is(1, ^^object);

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CSingleList.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CSingleList.c);

const unique #distTp2: $ctype;

axiom #distTp2 == $spec_ptr_to(^_SINGLE_LIST_MANAGER);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^_SINGLE_LIST_ENTRY);
