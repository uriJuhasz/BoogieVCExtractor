axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

const unique ^_ENTRY: $ctype;

axiom $is_span_sequential(^_ENTRY);

axiom $def_struct_type(^_ENTRY, 16, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_ENTRY) } $inv2(#s1, #s2, #p, ^_ENTRY) == $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^_ENTRY)) } $in(q, $composite_extent(s, p, ^_ENTRY)) == (q == p));

const unique _ENTRY.AsUINT64#nest0: $field;

axiom $def_phys_field(^_ENTRY, _ENTRY.AsUINT64#nest0, ^^u8, false, 0);

const unique _ENTRY.NextPfn#nest1: $field;

axiom $def_phys_field(^_ENTRY, _ENTRY.NextPfn#nest1, $ptr_to(^_ENTRY), false, 8);

const unique ^_ENTRY.Reserve.c..23530: $ctype;

axiom $is_span_sequential(^_ENTRY.Reserve.c..23530);

axiom $def_struct_type(^_ENTRY.Reserve.c..23530, 8, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_ENTRY.Reserve.c..23530) } $inv2(#s1, #s2, #p, ^_ENTRY.Reserve.c..23530) == $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^_ENTRY.Reserve.c..23530)) } $in(q, $composite_extent(s, p, ^_ENTRY.Reserve.c..23530)) == (q == p));

const unique _ENTRY.Reserve.c..23530.AsUINT64: $field;

axiom $def_phys_field(^_ENTRY.Reserve.c..23530, _ENTRY.Reserve.c..23530.AsUINT64, ^^u8, false, 0);

const unique ^_ENTRY.Reserve.c..23530.Reserve.c..23557: $ctype;

axiom $is_span_sequential(^_ENTRY.Reserve.c..23530.Reserve.c..23557);

axiom $def_struct_type(^_ENTRY.Reserve.c..23530.Reserve.c..23557, 8, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_ENTRY.Reserve.c..23530.Reserve.c..23557) } $inv2(#s1, #s2, #p, ^_ENTRY.Reserve.c..23530.Reserve.c..23557) == $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^_ENTRY.Reserve.c..23530.Reserve.c..23557)) } $in(q, $composite_extent(s, p, ^_ENTRY.Reserve.c..23530.Reserve.c..23557)) == (q == p));

const unique _ENTRY.Reserve.c..23530.Reserve.c..23557.bitfield#0: $field;

axiom $def_phys_field(^_ENTRY.Reserve.c..23530.Reserve.c..23557, _ENTRY.Reserve.c..23530.Reserve.c..23557.bitfield#0, ^^u8, false, 0);

const unique ^_ENTRY.Reserve.c..23864: $ctype;

axiom $is_span_sequential(^_ENTRY.Reserve.c..23864);

axiom $def_struct_type(^_ENTRY.Reserve.c..23864, 8, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_ENTRY.Reserve.c..23864) } $inv2(#s1, #s2, #p, ^_ENTRY.Reserve.c..23864) == $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^_ENTRY.Reserve.c..23864)) } $in(q, $composite_extent(s, p, ^_ENTRY.Reserve.c..23864)) == (q == p));

const unique _ENTRY.Reserve.c..23864.NextPfn: $field;

axiom $def_phys_field(^_ENTRY.Reserve.c..23864, _ENTRY.Reserve.c..23864.NextPfn, $ptr_to(^_ENTRY), false, 0);

const unique ^_RESERVE: $ctype;

axiom $is_span_sequential(^_RESERVE);

axiom $def_struct_type(^_RESERVE, 24, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_RESERVE) } $inv2(#s1, #s2, #p, ^_RESERVE) == ($non_null($rd_phys_ptr(#s2, _RESERVE.Compartment, #p, ^^void)) && $rd_phys_ptr(#s2, _RESERVE._ListHead, #p, ^_ENTRY) == $phys_ptr_cast($rd_phys_ptr(#s2, _RESERVE.ListHead, #p, ^^void), ^_ENTRY) && $is_null($rd_phys_ptr(#s2, _RESERVE._ListHead, #p, ^_ENTRY)) == ($rd_inv(#s2, _RESERVE.ListDepth, #p) == 0) && ($is_null($rd_phys_ptr(#s2, _RESERVE._ListHead, #p, ^_ENTRY)) || $set_in0($rd_phys_ptr(#s2, _RESERVE._ListHead, #p, ^_ENTRY), $owns(#s2, #p))) && (forall Q#p$1^50.31#tc1: $ptr :: {:weight 10} { $set_in0(Q#p$1^50.31#tc1, $owns(#s2, #p)) } $set_in0(Q#p$1^50.31#tc1, $owns(#s2, #p)) ==> $is(Q#p$1^50.31#tc1, ^_ENTRY)) && (forall Q#p$1^51.31#dt1: $ptr :: {:weight 10} { $set_in0($rd_phys_ptr(#s2, _ENTRY.NextPfn#nest1, $phys_ptr_cast(Q#p$1^51.31#dt1, ^_ENTRY), ^_ENTRY), $owns(#s2, #p)) } $set_in0($phys_ptr_cast(Q#p$1^51.31#dt1, ^_ENTRY), $owns(#s2, #p)) ==> $is_null($rd_phys_ptr(#s2, _ENTRY.NextPfn#nest1, $phys_ptr_cast(Q#p$1^51.31#dt1, ^_ENTRY), ^_ENTRY)) || $set_in0($rd_phys_ptr(#s2, _ENTRY.NextPfn#nest1, $phys_ptr_cast(Q#p$1^51.31#dt1, ^_ENTRY), ^_ENTRY), $owns(#s2, #p))) && (forall Q#p$1^52.31#dt1: $ptr :: {:weight 10} { $set_in0($phys_ptr_cast(Q#p$1^52.31#dt1, ^_ENTRY), $owns(#s2, #p)) } $set_in0($phys_ptr_cast(Q#p$1^52.31#dt1, ^_ENTRY), $owns(#s2, #p)) ==> $is_null($rd_phys_ptr(#s2, _ENTRY.NextPfn#nest1, $phys_ptr_cast(Q#p$1^52.31#dt1, ^_ENTRY), ^_ENTRY)) || $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($rd_inv(#s2, _RESERVE.ListIndex, #p)), $phys_ptr_cast(Q#p$1^52.31#dt1, ^_ENTRY)) == $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($rd_inv(#s2, _RESERVE.ListIndex, #p)), $rd_phys_ptr(#s2, _ENTRY.NextPfn#nest1, $phys_ptr_cast(Q#p$1^52.31#dt1, ^_ENTRY), ^_ENTRY)) + 1) && (forall Q#p$1^53.31#dt1: $ptr :: {:weight 10} { $set_in0($phys_ptr_cast(Q#p$1^53.31#dt1, ^_ENTRY), $owns(#s2, #p)) } $set_in0($phys_ptr_cast(Q#p$1^53.31#dt1, ^_ENTRY), $owns(#s2, #p)) ==> ($select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($rd_inv(#s2, _RESERVE.ListIndex, #p)), $phys_ptr_cast(Q#p$1^53.31#dt1, ^_ENTRY)) == 0) == $is_null($rd_phys_ptr(#s2, _ENTRY.NextPfn#nest1, $phys_ptr_cast(Q#p$1^53.31#dt1, ^_ENTRY), ^_ENTRY))) && ($non_null($rd_phys_ptr(#s2, _RESERVE._ListHead, #p, ^_ENTRY)) ==> $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($rd_inv(#s2, _RESERVE.ListIndex, #p)), $rd_phys_ptr(#s2, _RESERVE._ListHead, #p, ^_ENTRY)) + 1 == $rd_inv(#s2, _RESERVE.ListDepth, #p)) && (forall Q#p$1^55.31#dt1: $ptr :: {:weight 10} { $set_in0($phys_ptr_cast(Q#p$1^55.31#dt1, ^_ENTRY), $owns(#s2, #p)) } $set_in0($phys_ptr_cast(Q#p$1^55.31#dt1, ^_ENTRY), $owns(#s2, #p)) ==> $rd_inv(#s2, _RESERVE.ListDepth, #p) > $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($rd_inv(#s2, _RESERVE.ListIndex, #p)), $phys_ptr_cast(Q#p$1^55.31#dt1, ^_ENTRY))) && (forall Q#p$1^56.31#dt1: $ptr :: {:weight 10} { $set_in0($phys_ptr_cast(Q#p$1^56.31#dt1, ^_ENTRY), $owns(#s2, #p)) } $set_in0($phys_ptr_cast(Q#p$1^56.31#dt1, ^_ENTRY), $owns(#s2, #p)) ==> $int_to_bool($bv_extract_unsigned($rd_inv(#s2, _ENTRY.AsUINT64#nest0, $phys_ptr_cast(Q#p$1^56.31#dt1, ^_ENTRY)), 64, 8, 9)) && ($int_to_bool($bv_extract_unsigned($rd_inv(#s2, _ENTRY.AsUINT64#nest0, $phys_ptr_cast(Q#p$1^56.31#dt1, ^_ENTRY)), 64, 6, 7)) || $int_to_bool($bv_extract_unsigned($rd_inv(#s2, _ENTRY.AsUINT64#nest0, $phys_ptr_cast(Q#p$1^56.31#dt1, ^_ENTRY)), 64, 7, 8))))));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^_RESERVE)) } $in(q, $composite_extent(s, p, ^_RESERVE)) == (q == p));

const unique _RESERVE.Compartment: $field;

axiom $def_phys_field(^_RESERVE, _RESERVE.Compartment, $ptr_to(^^void), false, 0);

const unique _RESERVE.ListHead: $field;

axiom $def_phys_field(^_RESERVE, _RESERVE.ListHead, $ptr_to(^^void), false, 8);

const unique _RESERVE.ListDepth: $field;

axiom $def_phys_field(^_RESERVE, _RESERVE.ListDepth, ^^u8, false, 16);

const unique _RESERVE.ListIndex: $field;

axiom $def_ghost_field(^_RESERVE, _RESERVE.ListIndex, $map_t($ptr_to(^_ENTRY), ^^u8), false);

const unique _RESERVE._ListHead: $field;

axiom $def_ghost_field(^_RESERVE, _RESERVE._ListHead, $ptr_to(^_ENTRY), false);

procedure _RESERVE#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $non_null($rd_phys_ptr($s, _RESERVE.Compartment, $phys_ptr_cast(P#_this_, ^_RESERVE), ^^void));
  ensures $is_admissibility_check() ==> $rd_phys_ptr($s, _RESERVE._ListHead, $phys_ptr_cast(P#_this_, ^_RESERVE), ^_ENTRY) == $phys_ptr_cast($rd_phys_ptr($s, _RESERVE.ListHead, $phys_ptr_cast(P#_this_, ^_RESERVE), ^^void), ^_ENTRY);
  ensures $is_admissibility_check() ==> $is_null($rd_phys_ptr($s, _RESERVE._ListHead, $phys_ptr_cast(P#_this_, ^_RESERVE), ^_ENTRY)) == ($rd_inv($s, _RESERVE.ListDepth, $phys_ptr_cast(P#_this_, ^_RESERVE)) == 0);
  ensures $is_admissibility_check() ==> $is_null($rd_phys_ptr($s, _RESERVE._ListHead, $phys_ptr_cast(P#_this_, ^_RESERVE), ^_ENTRY)) || $set_in0($rd_phys_ptr($s, _RESERVE._ListHead, $phys_ptr_cast(P#_this_, ^_RESERVE), ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE)));
  ensures $is_admissibility_check() ==> (forall Q#p$1^50.31#tc1: $ptr :: {:weight 10} { $set_in0(Q#p$1^50.31#tc1, $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) } $set_in0(Q#p$1^50.31#tc1, $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) ==> $is(Q#p$1^50.31#tc1, ^_ENTRY));
  ensures $is_admissibility_check() ==> (forall Q#p$1^51.31#dt1: $ptr :: {:weight 10} { $set_in0($rd_phys_ptr($s, _ENTRY.NextPfn#nest1, $phys_ptr_cast(Q#p$1^51.31#dt1, ^_ENTRY), ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) } $set_in0($phys_ptr_cast(Q#p$1^51.31#dt1, ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) ==> $is_null($rd_phys_ptr($s, _ENTRY.NextPfn#nest1, $phys_ptr_cast(Q#p$1^51.31#dt1, ^_ENTRY), ^_ENTRY)) || $set_in0($rd_phys_ptr($s, _ENTRY.NextPfn#nest1, $phys_ptr_cast(Q#p$1^51.31#dt1, ^_ENTRY), ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))));
  ensures $is_admissibility_check() ==> (forall Q#p$1^52.31#dt1: $ptr :: {:weight 10} { $set_in0($phys_ptr_cast(Q#p$1^52.31#dt1, ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) } $set_in0($phys_ptr_cast(Q#p$1^52.31#dt1, ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) ==> $is_null($rd_phys_ptr($s, _ENTRY.NextPfn#nest1, $phys_ptr_cast(Q#p$1^52.31#dt1, ^_ENTRY), ^_ENTRY)) || $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($rd_inv($s, _RESERVE.ListIndex, $phys_ptr_cast(P#_this_, ^_RESERVE))), $phys_ptr_cast(Q#p$1^52.31#dt1, ^_ENTRY)) == $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($rd_inv($s, _RESERVE.ListIndex, $phys_ptr_cast(P#_this_, ^_RESERVE))), $rd_phys_ptr($s, _ENTRY.NextPfn#nest1, $phys_ptr_cast(Q#p$1^52.31#dt1, ^_ENTRY), ^_ENTRY)) + 1);
  ensures $is_admissibility_check() ==> (forall Q#p$1^53.31#dt1: $ptr :: {:weight 10} { $set_in0($phys_ptr_cast(Q#p$1^53.31#dt1, ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) } $set_in0($phys_ptr_cast(Q#p$1^53.31#dt1, ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) ==> ($select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($rd_inv($s, _RESERVE.ListIndex, $phys_ptr_cast(P#_this_, ^_RESERVE))), $phys_ptr_cast(Q#p$1^53.31#dt1, ^_ENTRY)) == 0) == $is_null($rd_phys_ptr($s, _ENTRY.NextPfn#nest1, $phys_ptr_cast(Q#p$1^53.31#dt1, ^_ENTRY), ^_ENTRY)));
  ensures $is_admissibility_check() ==> $non_null($rd_phys_ptr($s, _RESERVE._ListHead, $phys_ptr_cast(P#_this_, ^_RESERVE), ^_ENTRY)) ==> $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($rd_inv($s, _RESERVE.ListIndex, $phys_ptr_cast(P#_this_, ^_RESERVE))), $rd_phys_ptr($s, _RESERVE._ListHead, $phys_ptr_cast(P#_this_, ^_RESERVE), ^_ENTRY)) + 1 == $rd_inv($s, _RESERVE.ListDepth, $phys_ptr_cast(P#_this_, ^_RESERVE));
  ensures $is_admissibility_check() ==> (forall Q#p$1^55.31#dt1: $ptr :: {:weight 10} { $set_in0($phys_ptr_cast(Q#p$1^55.31#dt1, ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) } $set_in0($phys_ptr_cast(Q#p$1^55.31#dt1, ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) ==> $rd_inv($s, _RESERVE.ListDepth, $phys_ptr_cast(P#_this_, ^_RESERVE)) > $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($rd_inv($s, _RESERVE.ListIndex, $phys_ptr_cast(P#_this_, ^_RESERVE))), $phys_ptr_cast(Q#p$1^55.31#dt1, ^_ENTRY)));
  ensures $is_admissibility_check() ==> (forall Q#p$1^56.31#dt1: $ptr :: {:weight 10} { $set_in0($phys_ptr_cast(Q#p$1^56.31#dt1, ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) } $set_in0($phys_ptr_cast(Q#p$1^56.31#dt1, ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) ==> $int_to_bool($bv_extract_unsigned($rd_inv($s, _ENTRY.AsUINT64#nest0, $phys_ptr_cast(Q#p$1^56.31#dt1, ^_ENTRY)), 64, 8, 9)) && ($int_to_bool($bv_extract_unsigned($rd_inv($s, _ENTRY.AsUINT64#nest0, $phys_ptr_cast(Q#p$1^56.31#dt1, ^_ENTRY)), 64, 6, 7)) || $int_to_bool($bv_extract_unsigned($rd_inv($s, _ENTRY.AsUINT64#nest0, $phys_ptr_cast(Q#p$1^56.31#dt1, ^_ENTRY)), 64, 7, 8))));
  ensures $is_unwrap_check() ==> $non_null($rd_phys_ptr($s, _RESERVE.Compartment, $phys_ptr_cast(P#_this_, ^_RESERVE), ^^void));
  ensures $is_unwrap_check() ==> $rd_phys_ptr($s, _RESERVE._ListHead, $phys_ptr_cast(P#_this_, ^_RESERVE), ^_ENTRY) == $phys_ptr_cast($rd_phys_ptr($s, _RESERVE.ListHead, $phys_ptr_cast(P#_this_, ^_RESERVE), ^^void), ^_ENTRY);
  ensures $is_unwrap_check() ==> $is_null($rd_phys_ptr($s, _RESERVE._ListHead, $phys_ptr_cast(P#_this_, ^_RESERVE), ^_ENTRY)) == ($rd_inv($s, _RESERVE.ListDepth, $phys_ptr_cast(P#_this_, ^_RESERVE)) == 0);
  ensures $is_unwrap_check() ==> $is_null($rd_phys_ptr($s, _RESERVE._ListHead, $phys_ptr_cast(P#_this_, ^_RESERVE), ^_ENTRY)) || $set_in0($rd_phys_ptr($s, _RESERVE._ListHead, $phys_ptr_cast(P#_this_, ^_RESERVE), ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE)));
  ensures $is_unwrap_check() ==> (forall Q#p$1^50.31#tc1: $ptr :: {:weight 10} { $set_in0(Q#p$1^50.31#tc1, $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) } $set_in0(Q#p$1^50.31#tc1, $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) ==> $is(Q#p$1^50.31#tc1, ^_ENTRY));
  ensures $is_unwrap_check() ==> (forall Q#p$1^51.31#dt1: $ptr :: {:weight 10} { $set_in0($rd_phys_ptr($s, _ENTRY.NextPfn#nest1, $phys_ptr_cast(Q#p$1^51.31#dt1, ^_ENTRY), ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) } $set_in0($phys_ptr_cast(Q#p$1^51.31#dt1, ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) ==> $is_null($rd_phys_ptr($s, _ENTRY.NextPfn#nest1, $phys_ptr_cast(Q#p$1^51.31#dt1, ^_ENTRY), ^_ENTRY)) || $set_in0($rd_phys_ptr($s, _ENTRY.NextPfn#nest1, $phys_ptr_cast(Q#p$1^51.31#dt1, ^_ENTRY), ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))));
  ensures $is_unwrap_check() ==> (forall Q#p$1^52.31#dt1: $ptr :: {:weight 10} { $set_in0($phys_ptr_cast(Q#p$1^52.31#dt1, ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) } $set_in0($phys_ptr_cast(Q#p$1^52.31#dt1, ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) ==> $is_null($rd_phys_ptr($s, _ENTRY.NextPfn#nest1, $phys_ptr_cast(Q#p$1^52.31#dt1, ^_ENTRY), ^_ENTRY)) || $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($rd_inv($s, _RESERVE.ListIndex, $phys_ptr_cast(P#_this_, ^_RESERVE))), $phys_ptr_cast(Q#p$1^52.31#dt1, ^_ENTRY)) == $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($rd_inv($s, _RESERVE.ListIndex, $phys_ptr_cast(P#_this_, ^_RESERVE))), $rd_phys_ptr($s, _ENTRY.NextPfn#nest1, $phys_ptr_cast(Q#p$1^52.31#dt1, ^_ENTRY), ^_ENTRY)) + 1);
  ensures $is_unwrap_check() ==> (forall Q#p$1^53.31#dt1: $ptr :: {:weight 10} { $set_in0($phys_ptr_cast(Q#p$1^53.31#dt1, ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) } $set_in0($phys_ptr_cast(Q#p$1^53.31#dt1, ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) ==> ($select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($rd_inv($s, _RESERVE.ListIndex, $phys_ptr_cast(P#_this_, ^_RESERVE))), $phys_ptr_cast(Q#p$1^53.31#dt1, ^_ENTRY)) == 0) == $is_null($rd_phys_ptr($s, _ENTRY.NextPfn#nest1, $phys_ptr_cast(Q#p$1^53.31#dt1, ^_ENTRY), ^_ENTRY)));
  ensures $is_unwrap_check() ==> $non_null($rd_phys_ptr($s, _RESERVE._ListHead, $phys_ptr_cast(P#_this_, ^_RESERVE), ^_ENTRY)) ==> $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($rd_inv($s, _RESERVE.ListIndex, $phys_ptr_cast(P#_this_, ^_RESERVE))), $rd_phys_ptr($s, _RESERVE._ListHead, $phys_ptr_cast(P#_this_, ^_RESERVE), ^_ENTRY)) + 1 == $rd_inv($s, _RESERVE.ListDepth, $phys_ptr_cast(P#_this_, ^_RESERVE));
  ensures $is_unwrap_check() ==> (forall Q#p$1^55.31#dt1: $ptr :: {:weight 10} { $set_in0($phys_ptr_cast(Q#p$1^55.31#dt1, ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) } $set_in0($phys_ptr_cast(Q#p$1^55.31#dt1, ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) ==> $rd_inv($s, _RESERVE.ListDepth, $phys_ptr_cast(P#_this_, ^_RESERVE)) > $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($rd_inv($s, _RESERVE.ListIndex, $phys_ptr_cast(P#_this_, ^_RESERVE))), $phys_ptr_cast(Q#p$1^55.31#dt1, ^_ENTRY)));
  ensures $is_unwrap_check() ==> (forall Q#p$1^56.31#dt1: $ptr :: {:weight 10} { $set_in0($phys_ptr_cast(Q#p$1^56.31#dt1, ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) } $set_in0($phys_ptr_cast(Q#p$1^56.31#dt1, ^_ENTRY), $owns($s, $phys_ptr_cast(P#_this_, ^_RESERVE))) ==> $int_to_bool($bv_extract_unsigned($rd_inv($s, _ENTRY.AsUINT64#nest0, $phys_ptr_cast(Q#p$1^56.31#dt1, ^_ENTRY)), 64, 8, 9)) && ($int_to_bool($bv_extract_unsigned($rd_inv($s, _ENTRY.AsUINT64#nest0, $phys_ptr_cast(Q#p$1^56.31#dt1, ^_ENTRY)), 64, 6, 7)) || $int_to_bool($bv_extract_unsigned($rd_inv($s, _ENTRY.AsUINT64#nest0, $phys_ptr_cast(Q#p$1^56.31#dt1, ^_ENTRY)), 64, 7, 8))));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _RESERVE#adm(P#_this_: $ptr)
{
  var #wrTime$1^37.39: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^37.39, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^37.39, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^_RESERVE));
    assume #wrTime$1^37.39 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^37.39, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($phys_ptr_cast(P#_this_, ^_RESERVE), ^_RESERVE);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $phys_ptr_cast(P#_this_, ^_RESERVE));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($phys_ptr_cast(P#_this_, ^_RESERVE));
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
            assume $admissibility_pre($s, $phys_ptr_cast(P#_this_, ^_RESERVE));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $phys_ptr_cast(P#_this_, ^_RESERVE));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct _RESERVE*)@null))
        call $havoc_others($phys_ptr_cast(P#_this_, ^_RESERVE), ^_RESERVE);
        assume $good_state_ext(#tok$1^37.39, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $phys_ptr_cast(P#_this_, ^_RESERVE), ^_RESERVE);
    }

  #exit:
}



procedure Check(P#Reserve: $ptr);
  requires $wrapped($s, $phys_ptr_cast(P#Reserve, ^_RESERVE), ^_RESERVE);
  modifies $s, $cev_pc;
  ensures $wrapped($s, $phys_ptr_cast(P#Reserve, ^_RESERVE), ^_RESERVE);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Check(P#Reserve: $ptr)
{
  var loopState#0: $state;
  var L#pageCount: int where $in_range_u8(L#pageCount);
  var L#pfn: $ptr;
  var #wrTime$1^60.1: int;
  var #stackframe: int;

  anon10:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^60.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^60.1, #loc.Reserve, $ptr_to_int(P#Reserve), $ptr_to(^_RESERVE));
    assume #wrTime$1^60.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^60.1, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, Reserve, Reserve); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#Reserve, ^_RESERVE), $phys_ptr_cast(P#Reserve, ^_RESERVE), l#public);
    // struct _ENTRY* pfn; 
    assume $local_value_is($s, #tok$1^65.5, #loc.pfn, $ptr_to_int(L#pfn), $ptr_to(^_ENTRY));
    // uint64_t pageCount; 
    assume $local_value_is($s, #tok$1^64.5, #loc.pageCount, L#pageCount, ^^u8);
    // var uint64_t pageCount
    // var struct _ENTRY* pfn
    // assert @_vcc_ptr_neq_null(Reserve); 
    assert $non_null($phys_ptr_cast(P#Reserve, ^_RESERVE));
    // assume @_vcc_ptr_neq_null(Reserve); 
    assume $non_null($phys_ptr_cast(P#Reserve, ^_RESERVE));
    // assert @_vcc_ptr_neq_null(*((Reserve->Compartment))); 
    assert $non_null($rd_phys_ptr($s, _RESERVE.Compartment, $phys_ptr_cast(P#Reserve, ^_RESERVE), ^^void));
    // assume @_vcc_ptr_neq_null(*((Reserve->Compartment))); 
    assume $non_null($rd_phys_ptr($s, _RESERVE.Compartment, $phys_ptr_cast(P#Reserve, ^_RESERVE), ^^void));
    // assert @reads_check_normal((Reserve->ListHead)); 
    assert $thread_local($s, $phys_ptr_cast(P#Reserve, ^_RESERVE));
    // pfn := (struct _ENTRY*)*((Reserve->ListHead)); 
    L#pfn := $phys_ptr_cast($rd_phys_ptr($s, _RESERVE.ListHead, $phys_ptr_cast(P#Reserve, ^_RESERVE), ^^void), ^_ENTRY);
    assume $local_value_is($s, #tok$1^70.10, #loc.pfn, $ptr_to_int(L#pfn), $ptr_to(^_ENTRY));
    // assert @reads_check_normal((Reserve->ListDepth)); 
    assert $thread_local($s, $phys_ptr_cast(P#Reserve, ^_RESERVE));
    // pageCount := *((Reserve->ListDepth)); 
    L#pageCount := $rd_inv($s, _RESERVE.ListDepth, $phys_ptr_cast(P#Reserve, ^_RESERVE));
    assume $local_value_is($s, #tok$1^70.44, #loc.pageCount, L#pageCount, ^^u8);
    loopState#0 := $s;
    while (true)
      invariant $is_null($phys_ptr_cast(L#pfn, ^_ENTRY)) || $set_in0($phys_ptr_cast(L#pfn, ^_ENTRY), $owns($s, $phys_ptr_cast(P#Reserve, ^_RESERVE)));
      invariant $is_null($phys_ptr_cast(L#pfn, ^_ENTRY)) == (L#pageCount == 0);
      invariant $is_null($phys_ptr_cast(L#pfn, ^_ENTRY)) || L#pageCount == $select.$map_t..$ptr_to..^_ENTRY.^^u8($int_to_map_t..ptr_to..^_ENTRY.^^u8($rd_inv($s, _RESERVE.ListIndex, $phys_ptr_cast(P#Reserve, ^_RESERVE))), $phys_ptr_cast(L#pfn, ^_ENTRY)) + 1;
    {
      anon9:
        assume $writes_nothing(old($s), $s);
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$1^70.5, $s);
        assume $local_value_is($s, #tok$1^70.5, #loc.pageCount, L#pageCount, ^^u8);
        assume $local_value_is($s, #tok$1^70.5, #loc.pfn, $ptr_to_int(L#pfn), $ptr_to(^_ENTRY));
        assume $local_value_is($s, #tok$1^70.5, #loc.Reserve, $ptr_to_int(P#Reserve), $ptr_to(^_RESERVE));
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#0, $s);
        assume true;
        // if (!=(pageCount, 0)) ...
        if (L#pageCount != 0)
        {
          anon7:
            // assert @_vcc_ptr_neq_null(pfn); 
            assert $non_null($phys_ptr_cast(L#pfn, ^_ENTRY));
            // assume @_vcc_ptr_neq_null(pfn); 
            assume $non_null($phys_ptr_cast(L#pfn, ^_ENTRY));
            // assert (_Bool)@bv_extract_unsigned(*((pfn->AsUINT64#nest0)), 64, 8, 9); 
            assert $int_to_bool($bv_extract_unsigned($rd_inv($s, _ENTRY.AsUINT64#nest0, $phys_ptr_cast(L#pfn, ^_ENTRY)), 64, 8, 9));
            // assert true; 
            assert true;
            // assume (_Bool)@bv_extract_unsigned(*((pfn->AsUINT64#nest0)), 64, 8, 9); 
            assume $int_to_bool($bv_extract_unsigned($rd_inv($s, _ENTRY.AsUINT64#nest0, $phys_ptr_cast(L#pfn, ^_ENTRY)), 64, 8, 9));
            // assert ||((_Bool)@bv_extract_unsigned(*((pfn->AsUINT64#nest0)), 64, 6, 7), (_Bool)@bv_extract_unsigned(*((pfn->AsUINT64#nest0)), 64, 7, 8)); 
            assert $int_to_bool($bv_extract_unsigned($rd_inv($s, _ENTRY.AsUINT64#nest0, $phys_ptr_cast(L#pfn, ^_ENTRY)), 64, 6, 7)) || $int_to_bool($bv_extract_unsigned($rd_inv($s, _ENTRY.AsUINT64#nest0, $phys_ptr_cast(L#pfn, ^_ENTRY)), 64, 7, 8));
            // assume ||((_Bool)@bv_extract_unsigned(*((pfn->AsUINT64#nest0)), 64, 6, 7), (_Bool)@bv_extract_unsigned(*((pfn->AsUINT64#nest0)), 64, 7, 8)); 
            assume $int_to_bool($bv_extract_unsigned($rd_inv($s, _ENTRY.AsUINT64#nest0, $phys_ptr_cast(L#pfn, ^_ENTRY)), 64, 6, 7)) || $int_to_bool($bv_extract_unsigned($rd_inv($s, _ENTRY.AsUINT64#nest0, $phys_ptr_cast(L#pfn, ^_ENTRY)), 64, 7, 8));
        }
        else
        {
          anon8:
            // goto #break_1; 
            goto #break_1;
        }

      #continue_1:
        // assert @reads_check_normal((pfn->NextPfn#nest1)); 
        assert $thread_local($s, $phys_ptr_cast(L#pfn, ^_ENTRY));
        // pfn := *((pfn->NextPfn#nest1)); 
        L#pfn := $rd_phys_ptr($s, _ENTRY.NextPfn#nest1, $phys_ptr_cast(L#pfn, ^_ENTRY), ^_ENTRY);
        assume $local_value_is($s, #tok$1^72.10, #loc.pfn, $ptr_to_int(L#pfn), $ptr_to(^_ENTRY));
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
    // assert @_vcc_ptr_eq_null(pfn); 
    assert $is_null($phys_ptr_cast(L#pfn, ^_ENTRY));
    // assume @_vcc_ptr_eq_null(pfn); 
    assume $is_null($phys_ptr_cast(L#pfn, ^_ENTRY));
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

function $select.$map_t..$ptr_to..^_ENTRY.^^u8(M: $map_t..$ptr_to..^_ENTRY.^^u8, p: $ptr) : int;

function $store.$map_t..$ptr_to..^_ENTRY.^^u8(M: $map_t..$ptr_to..^_ENTRY.^^u8, p: $ptr, v: int) : $map_t..$ptr_to..^_ENTRY.^^u8;

function $eq.$map_t..$ptr_to..^_ENTRY.^^u8(M1: $map_t..$ptr_to..^_ENTRY.^^u8, M2: $map_t..$ptr_to..^_ENTRY.^^u8) : bool;

const $zero.$map_t..$ptr_to..^_ENTRY.^^u8: $map_t..$ptr_to..^_ENTRY.^^u8;

axiom (forall M: $map_t..$ptr_to..^_ENTRY.^^u8, p: $ptr, v: int :: true);

axiom (forall M: $map_t..$ptr_to..^_ENTRY.^^u8, p: $ptr, v: int, q: $ptr :: $select.$map_t..$ptr_to..^_ENTRY.^^u8($store.$map_t..$ptr_to..^_ENTRY.^^u8(M, q, v), p) == (if $phys_ptr_cast(p, ^_ENTRY) == $phys_ptr_cast(q, ^_ENTRY) then $unchecked(^^u8, v) else $select.$map_t..$ptr_to..^_ENTRY.^^u8(M, p)));

axiom (forall M1: $map_t..$ptr_to..^_ENTRY.^^u8, M2: $map_t..$ptr_to..^_ENTRY.^^u8 :: { $eq.$map_t..$ptr_to..^_ENTRY.^^u8(M1, M2) } (forall p: $ptr :: $unchecked(^^u8, $select.$map_t..$ptr_to..^_ENTRY.^^u8(M1, $phys_ptr_cast(p, ^_ENTRY))) == $unchecked(^^u8, $select.$map_t..$ptr_to..^_ENTRY.^^u8(M2, $phys_ptr_cast(p, ^_ENTRY)))) ==> $eq.$map_t..$ptr_to..^_ENTRY.^^u8(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^_ENTRY.^^u8, M2: $map_t..$ptr_to..^_ENTRY.^^u8 :: { $eq.$map_t..$ptr_to..^_ENTRY.^^u8(M1, M2) } $eq.$map_t..$ptr_to..^_ENTRY.^^u8(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^_ENTRY.^^u8(0) == $zero.$map_t..$ptr_to..^_ENTRY.^^u8;

axiom (forall p: $ptr :: $select.$map_t..$ptr_to..^_ENTRY.^^u8($zero.$map_t..$ptr_to..^_ENTRY.^^u8, p) == 0);

axiom true;

axiom (forall M: $map_t..$ptr_to..^_ENTRY.^^u8, p: $ptr :: $in_range_t(^^u8, $select.$map_t..$ptr_to..^_ENTRY.^^u8(M, p)));

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

const unique #distTp3: $ctype;

axiom #distTp3 == $ptr_to(^^void);

function $map_t..ptr_to..^_ENTRY.^^u8_to_int(x: $map_t..$ptr_to..^_ENTRY.^^u8) : int;

function $int_to_map_t..ptr_to..^_ENTRY.^^u8(x: int) : $map_t..$ptr_to..^_ENTRY.^^u8;

axiom (forall #x: $map_t..$ptr_to..^_ENTRY.^^u8 :: #x == $int_to_map_t..ptr_to..^_ENTRY.^^u8($map_t..ptr_to..^_ENTRY.^^u8_to_int(#x)));

const unique #distTp2: $ctype;

axiom #distTp2 == $map_t($ptr_to(^_ENTRY), ^^u8);

axiom $type_code_is(1, ^^object);

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CReserve.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CReserve.c);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^_ENTRY);
