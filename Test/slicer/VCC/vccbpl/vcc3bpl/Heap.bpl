axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^localeinfo_struct: $ctype;

axiom $is_span_sequential(^localeinfo_struct);

axiom $def_struct_type(^localeinfo_struct, 16, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^localeinfo_struct) } $inv2(#s1, #s2, #p, ^localeinfo_struct) == $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^localeinfo_struct)) } $in(q, $composite_extent(s, p, ^localeinfo_struct)) == (q == p));

const unique localeinfo_struct.locinfo: $field;

axiom $def_phys_field(^localeinfo_struct, localeinfo_struct.locinfo, $ptr_to(^threadlocaleinfostruct), false, 0);

const unique localeinfo_struct.mbcinfo: $field;

axiom $def_phys_field(^localeinfo_struct, localeinfo_struct.mbcinfo, ^^object, false, 8);

const unique ^threadlocaleinfostruct: $ctype;

axiom $is_span_sequential(^threadlocaleinfostruct);

axiom $def_struct_type(^threadlocaleinfostruct, 352, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^threadlocaleinfostruct) } $inv2(#s1, #s2, #p, ^threadlocaleinfostruct) == $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^threadlocaleinfostruct)) } $in(q, $composite_extent(s, p, ^threadlocaleinfostruct)) == (q == p || $in_composite_array(q, $dot(p, threadlocaleinfostruct.lc_id), 6) || $in_composite_array(q, $dot(p, threadlocaleinfostruct.lc_category), 6)));

const unique threadlocaleinfostruct.refcount: $field;

axiom $def_phys_field(^threadlocaleinfostruct, threadlocaleinfostruct.refcount, ^^i4, false, 0);

const unique threadlocaleinfostruct.lc_codepage: $field;

axiom $def_phys_field(^threadlocaleinfostruct, threadlocaleinfostruct.lc_codepage, ^^u4, false, 4);

const unique threadlocaleinfostruct.lc_collate_cp: $field;

axiom $def_phys_field(^threadlocaleinfostruct, threadlocaleinfostruct.lc_collate_cp, ^^u4, false, 8);

const unique threadlocaleinfostruct.lc_handle: $field;

axiom $def_phys_arr_field(^threadlocaleinfostruct, threadlocaleinfostruct.lc_handle, ^^u4, false, 12, 6);

const unique threadlocaleinfostruct.lc_id: $field;

axiom $def_phys_arr_field(^threadlocaleinfostruct, threadlocaleinfostruct.lc_id, ^tagLC_ID, false, 36, 6);

const unique threadlocaleinfostruct.lc_category: $field;

axiom $def_phys_arr_field(^threadlocaleinfostruct, threadlocaleinfostruct.lc_category, ^threadlocaleinfostruct.Heap.c..10972, false, 72, 6);

const unique threadlocaleinfostruct.lc_clike: $field;

axiom $def_phys_field(^threadlocaleinfostruct, threadlocaleinfostruct.lc_clike, ^^i4, false, 264);

const unique threadlocaleinfostruct.mb_cur_max: $field;

axiom $def_phys_field(^threadlocaleinfostruct, threadlocaleinfostruct.mb_cur_max, ^^i4, false, 268);

const unique threadlocaleinfostruct.lconv_intl_refcount: $field;

axiom $def_phys_field(^threadlocaleinfostruct, threadlocaleinfostruct.lconv_intl_refcount, $ptr_to(^^i4), false, 272);

const unique threadlocaleinfostruct.lconv_num_refcount: $field;

axiom $def_phys_field(^threadlocaleinfostruct, threadlocaleinfostruct.lconv_num_refcount, $ptr_to(^^i4), false, 280);

const unique threadlocaleinfostruct.lconv_mon_refcount: $field;

axiom $def_phys_field(^threadlocaleinfostruct, threadlocaleinfostruct.lconv_mon_refcount, $ptr_to(^^i4), false, 288);

const unique threadlocaleinfostruct.lconv: $field;

axiom $def_phys_field(^threadlocaleinfostruct, threadlocaleinfostruct.lconv, ^^object, false, 296);

const unique threadlocaleinfostruct.ctype1_refcount: $field;

axiom $def_phys_field(^threadlocaleinfostruct, threadlocaleinfostruct.ctype1_refcount, $ptr_to(^^i4), false, 304);

const unique threadlocaleinfostruct.ctype1: $field;

axiom $def_phys_field(^threadlocaleinfostruct, threadlocaleinfostruct.ctype1, $ptr_to(^^u2), false, 312);

const unique threadlocaleinfostruct.pctype: $field;

axiom $def_phys_field(^threadlocaleinfostruct, threadlocaleinfostruct.pctype, $ptr_to(^^u2), false, 320);

const unique threadlocaleinfostruct.pclmap: $field;

axiom $def_phys_field(^threadlocaleinfostruct, threadlocaleinfostruct.pclmap, $ptr_to(^^u1), false, 328);

const unique threadlocaleinfostruct.pcumap: $field;

axiom $def_phys_field(^threadlocaleinfostruct, threadlocaleinfostruct.pcumap, $ptr_to(^^u1), false, 336);

const unique threadlocaleinfostruct.lc_time_curr: $field;

axiom $def_phys_field(^threadlocaleinfostruct, threadlocaleinfostruct.lc_time_curr, ^^object, false, 344);

const unique ^tagLC_ID: $ctype;

axiom $is_span_sequential(^tagLC_ID);

axiom $def_struct_type(^tagLC_ID, 6, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^tagLC_ID) } $inv2(#s1, #s2, #p, ^tagLC_ID) == $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^tagLC_ID)) } $in(q, $composite_extent(s, p, ^tagLC_ID)) == (q == p));

const unique tagLC_ID.wLanguage: $field;

axiom $def_phys_field(^tagLC_ID, tagLC_ID.wLanguage, ^^u2, false, 0);

const unique tagLC_ID.wCountry: $field;

axiom $def_phys_field(^tagLC_ID, tagLC_ID.wCountry, ^^u2, false, 2);

const unique tagLC_ID.wCodePage: $field;

axiom $def_phys_field(^tagLC_ID, tagLC_ID.wCodePage, ^^u2, false, 4);

const unique ^threadlocaleinfostruct.Heap.c..10972: $ctype;

axiom $is_span_sequential(^threadlocaleinfostruct.Heap.c..10972);

axiom $def_struct_type(^threadlocaleinfostruct.Heap.c..10972, 32, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^threadlocaleinfostruct.Heap.c..10972) } $inv2(#s1, #s2, #p, ^threadlocaleinfostruct.Heap.c..10972) == $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^threadlocaleinfostruct.Heap.c..10972)) } $in(q, $composite_extent(s, p, ^threadlocaleinfostruct.Heap.c..10972)) == (q == p));

const unique threadlocaleinfostruct.Heap.c..10972.locale: $field;

axiom $def_phys_field(^threadlocaleinfostruct.Heap.c..10972, threadlocaleinfostruct.Heap.c..10972.locale, $ptr_to(^^i1), false, 0);

const unique threadlocaleinfostruct.Heap.c..10972.wlocale: $field;

axiom $def_phys_field(^threadlocaleinfostruct.Heap.c..10972, threadlocaleinfostruct.Heap.c..10972.wlocale, $ptr_to(^^u2), false, 8);

const unique threadlocaleinfostruct.Heap.c..10972.refcount: $field;

axiom $def_phys_field(^threadlocaleinfostruct.Heap.c..10972, threadlocaleinfostruct.Heap.c..10972.refcount, $ptr_to(^^i4), false, 16);

const unique threadlocaleinfostruct.Heap.c..10972.wrefcount: $field;

axiom $def_phys_field(^threadlocaleinfostruct.Heap.c..10972, threadlocaleinfostruct.Heap.c..10972.wrefcount, $ptr_to(^^i4), false, 24);

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

const unique ^Heap: $ctype;

axiom $is_span_sequential(^Heap);

axiom $def_struct_type(^Heap, 4004, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Heap) } $inv2(#s1, #s2, #p, ^Heap) == ($set_eq($owns(#s2, #p), $set_empty()) && $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv(#s2, Heap.sh, #p)), 0), $int_to_map_t..^^i4.^^mathint($rd_inv(#s2, Heap.abs, #p))) && $rd_inv(#s2, Heap.len, #p) <= 1000 && (forall Q#i$1^65.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv(#s2, Heap.sh, #p)), F#mark(Q#i$1^65.29#tc1)) } $in_range_u4(Q#i$1^65.29#tc1) ==> Q#i$1^65.29#tc1 != $rd_inv(#s2, Heap.len, #p) && Q#i$1^65.29#tc1 < $rd_inv(#s2, Heap.len, #p) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv(#s2, Heap.sh, #p)), F#mark(Q#i$1^65.29#tc1)), F#lambda#6($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv(#s2, Heap.sh, #p)), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 2)), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv(#s2, Heap.sh, #p)), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 1)), $rd_inv(#s2, $field($idx($dot(#p, Heap.heap), Q#i$1^65.29#tc1)), $emb0($idx($dot(#p, Heap.heap), Q#i$1^65.29#tc1)))))) && (forall Q#i$1^66.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv(#s2, Heap.sh, #p)), F#mark(Q#i$1^66.29#tc1)) } $in_range_u4(Q#i$1^66.29#tc1) ==> Q#i$1^66.29#tc1 >= $rd_inv(#s2, Heap.len, #p) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv(#s2, Heap.sh, #p)), F#mark(Q#i$1^66.29#tc1)), F#lambda#7())) && (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv(#s2, Heap.sh, #p)), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $rd_inv(#s2, Heap.len, #p) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv(#s2, Heap.sh, #p)), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) >= 0) && (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv(#s2, Heap.sh, #p)), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $rd_inv(#s2, Heap.len, #p) ==> Q#i$1^66.29#tc1 != $rd_inv(#s2, Heap.len, #p) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv(#s2, Heap.sh, #p)), Q#i$1^66.29#tc1), Q#e$1^66.29#tc2) > 0 ==> Q#e$1^66.29#tc2 >= $rd_inv(#s2, $field($idx($dot(#p, Heap.heap), Q#i$1^66.29#tc1)), $emb0($idx($dot(#p, Heap.heap), Q#i$1^66.29#tc1))))));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^Heap)) } $in(q, $composite_extent(s, p, ^Heap)) == (q == p));

const unique Heap.len: $field;

axiom $def_phys_field(^Heap, Heap.len, ^^u4, false, 0);

const unique Heap.heap: $field;

axiom $def_phys_arr_field(^Heap, Heap.heap, ^^i4, false, 4, 1000);

const unique Heap.abs: $field;

axiom $def_ghost_field(^Heap, Heap.abs, $map_t(^^i4, ^^mathint), false);

const unique Heap.sh: $field;

axiom $def_ghost_field(^Heap, Heap.sh, $map_t(^^u4, $map_t(^^i4, ^^mathint)), false);

procedure Heap#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $set_eq($owns($s, $phys_ptr_cast(P#_this_, ^Heap)), $set_empty());
  ensures $is_admissibility_check() ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#_this_, ^Heap))), 0), $int_to_map_t..^^i4.^^mathint($rd_inv($s, Heap.abs, $phys_ptr_cast(P#_this_, ^Heap))));
  ensures $is_admissibility_check() ==> $rd_inv($s, Heap.len, $phys_ptr_cast(P#_this_, ^Heap)) <= 1000;
  ensures $is_admissibility_check() ==> (forall Q#i$1^65.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#_this_, ^Heap))), F#mark(Q#i$1^65.29#tc1)) } $in_range_u4(Q#i$1^65.29#tc1) ==> Q#i$1^65.29#tc1 != $rd_inv($s, Heap.len, $phys_ptr_cast(P#_this_, ^Heap)) && Q#i$1^65.29#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#_this_, ^Heap)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#_this_, ^Heap))), F#mark(Q#i$1^65.29#tc1)), F#lambda#6($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#_this_, ^Heap))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 2)), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#_this_, ^Heap))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 1)), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#_this_, ^Heap), Heap.heap), Q#i$1^65.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#_this_, ^Heap), Heap.heap), Q#i$1^65.29#tc1))))));
  ensures $is_admissibility_check() ==> (forall Q#i$1^66.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#_this_, ^Heap))), F#mark(Q#i$1^66.29#tc1)) } $in_range_u4(Q#i$1^66.29#tc1) ==> Q#i$1^66.29#tc1 >= $rd_inv($s, Heap.len, $phys_ptr_cast(P#_this_, ^Heap)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#_this_, ^Heap))), F#mark(Q#i$1^66.29#tc1)), F#lambda#7()));
  ensures $is_admissibility_check() ==> (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#_this_, ^Heap))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#_this_, ^Heap)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#_this_, ^Heap))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) >= 0);
  ensures $is_admissibility_check() ==> (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#_this_, ^Heap))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#_this_, ^Heap)) ==> Q#i$1^66.29#tc1 != $rd_inv($s, Heap.len, $phys_ptr_cast(P#_this_, ^Heap)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#_this_, ^Heap))), Q#i$1^66.29#tc1), Q#e$1^66.29#tc2) > 0 ==> Q#e$1^66.29#tc2 >= $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#_this_, ^Heap), Heap.heap), Q#i$1^66.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#_this_, ^Heap), Heap.heap), Q#i$1^66.29#tc1))));
  ensures $is_unwrap_check() ==> $set_eq($owns($s, $phys_ptr_cast(P#_this_, ^Heap)), $set_empty());
  ensures $is_unwrap_check() ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#_this_, ^Heap))), 0), $int_to_map_t..^^i4.^^mathint($rd_inv($s, Heap.abs, $phys_ptr_cast(P#_this_, ^Heap))));
  ensures $is_unwrap_check() ==> $rd_inv($s, Heap.len, $phys_ptr_cast(P#_this_, ^Heap)) <= 1000;
  ensures $is_unwrap_check() ==> (forall Q#i$1^65.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#_this_, ^Heap))), F#mark(Q#i$1^65.29#tc1)) } $in_range_u4(Q#i$1^65.29#tc1) ==> Q#i$1^65.29#tc1 != $rd_inv($s, Heap.len, $phys_ptr_cast(P#_this_, ^Heap)) && Q#i$1^65.29#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#_this_, ^Heap)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#_this_, ^Heap))), F#mark(Q#i$1^65.29#tc1)), F#lambda#6($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#_this_, ^Heap))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 2)), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#_this_, ^Heap))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 1)), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#_this_, ^Heap), Heap.heap), Q#i$1^65.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#_this_, ^Heap), Heap.heap), Q#i$1^65.29#tc1))))));
  ensures $is_unwrap_check() ==> (forall Q#i$1^66.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#_this_, ^Heap))), F#mark(Q#i$1^66.29#tc1)) } $in_range_u4(Q#i$1^66.29#tc1) ==> Q#i$1^66.29#tc1 >= $rd_inv($s, Heap.len, $phys_ptr_cast(P#_this_, ^Heap)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#_this_, ^Heap))), F#mark(Q#i$1^66.29#tc1)), F#lambda#7()));
  ensures $is_unwrap_check() ==> (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#_this_, ^Heap))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#_this_, ^Heap)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#_this_, ^Heap))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) >= 0);
  ensures $is_unwrap_check() ==> (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#_this_, ^Heap))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#_this_, ^Heap)) ==> Q#i$1^66.29#tc1 != $rd_inv($s, Heap.len, $phys_ptr_cast(P#_this_, ^Heap)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#_this_, ^Heap))), Q#i$1^66.29#tc1), Q#e$1^66.29#tc2) > 0 ==> Q#e$1^66.29#tc2 >= $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#_this_, ^Heap), Heap.heap), Q#i$1^66.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#_this_, ^Heap), Heap.heap), Q#i$1^66.29#tc1))));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Heap#adm(P#_this_: $ptr)
{
  var #wrTime$1^55.1: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^55.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^55.1, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^Heap));
    assume #wrTime$1^55.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^55.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($phys_ptr_cast(P#_this_, ^Heap), ^Heap);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $phys_ptr_cast(P#_this_, ^Heap));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($phys_ptr_cast(P#_this_, ^Heap));
        assume $good_state_ext(#tok$1^55.1, $s);
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
            assume $admissibility_pre($s, $phys_ptr_cast(P#_this_, ^Heap));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $phys_ptr_cast(P#_this_, ^Heap));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Heap*)@null))
        call $havoc_others($phys_ptr_cast(P#_this_, ^Heap), ^Heap);
        assume $good_state_ext(#tok$1^55.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $phys_ptr_cast(P#_this_, ^Heap), ^Heap);
    }

  #exit:
}



procedure _vswprintf_c_l(P#_DstBuf: $ptr, P#_MaxCount: int, P#_Format: $ptr, P#_Locale: $ptr, P#_ArgList: $ptr) returns ($result: int);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



procedure swprintf(P#_String: $ptr, P#_Count: int, P#_Format: $ptr) returns ($result: int);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation swprintf(P#_String: $ptr, P#_Count: int, P#_Format: $ptr) returns ($result: int)
{
  var L#_Arglist: $ptr;
  var L#_Ret: int where $in_range_i4(L#_Ret);
  var addr._Format: $ptr;
  var #wrTime$3^36.1: int;
  var #stackframe: int;

  anon7:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$3^36.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$3^36.1, #loc._String, $ptr_to_int(P#_String), $ptr_to(^^u2));
    assume $local_value_is($s, #tok$3^36.1, #loc._Count, P#_Count, ^^u4);
    assume $local_value_is($s, #tok$3^36.1, #loc._Format, $ptr_to_int(P#_Format), $ptr_to(^^u2));
    assume #wrTime$3^36.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$3^36.1, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @in_range_u4(_Count); 
    assume $in_range_u4(P#_Count);
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // uint16_t** addr._Format; 
    assume $local_value_is($s, #tok$3^36.1, #loc.addr._Format, $ptr_to_int(addr._Format), $ptr_to($ptr_to(^^u2)));
    // addr._Format := _vcc_stack_alloc<uint16_t*>(@stackframe, false); 
    call addr._Format := $stack_alloc($ptr_to(^^u2), #stackframe, false);
    assume $full_stop_ext(#tok$3^36.1, $s);
    assume $local_value_is($s, #tok$3^36.1, #loc.addr._Format, $ptr_to_int(addr._Format), $ptr_to($ptr_to(^^u2)));
    // assert @prim_writes_check(addr._Format); 
    assert $writable_prim($s, #wrTime$3^36.1, $phys_ptr_cast(addr._Format, $ptr_to(^^u2)));
    // *addr._Format := _Format; 
    call $write_int($field($phys_ptr_cast(addr._Format, $ptr_to(^^u2))), $emb0($phys_ptr_cast(addr._Format, $ptr_to(^^u2))), $ptr_to_int($phys_ptr_cast(P#_Format, ^^u2)));
    assume $full_stop_ext(#tok$3^40.30, $s);
    // int32_t _Ret; 
    assume $local_value_is($s, #tok$3^39.5, #loc._Ret, L#_Ret, ^^i4);
    // int8_t* _Arglist; 
    assume $local_value_is($s, #tok$3^38.5, #loc._Arglist, $ptr_to_int(L#_Arglist), $ptr_to(^^i1));
    // var int8_t* _Arglist
    // var int32_t _Ret
    // _Arglist := (int8_t*)addr._Format[8]; 
    L#_Arglist := $idx($phys_ptr_cast($phys_ptr_cast(addr._Format, $ptr_to(^^u2)), ^^i1), 8);
    assume $local_value_is($s, #tok$3^40.7, #loc._Arglist, $ptr_to_int(L#_Arglist), $ptr_to(^^i1));
    // non-pure function
    // assert @reads_check_normal(addr._Format); 
    assert $thread_local($s, $phys_ptr_cast(addr._Format, $ptr_to(^^u2)));
    // _Ret := _vswprintf_c_l(_String, _Count, *(addr._Format), (struct localeinfo_struct*)@null, _Arglist); 
    call L#_Ret := _vswprintf_c_l($phys_ptr_cast(P#_String, ^^u2), P#_Count, $rd_phys_ptr($s, $field($phys_ptr_cast(addr._Format, $ptr_to(^^u2))), $emb0($phys_ptr_cast(addr._Format, $ptr_to(^^u2))), ^^u2), $phys_ptr_cast($null, ^localeinfo_struct), $phys_ptr_cast(L#_Arglist, ^^i1));
    assume $full_stop_ext(#tok$3^41.12, $s);
    assume $local_value_is($s, #tok$3^41.12, #loc._Ret, L#_Ret, ^^i4);
    // _Arglist := (int8_t*)@null; 
    L#_Arglist := $phys_ptr_cast($null, ^^i1);
    assume $local_value_is($s, #tok$3^42.7, #loc._Arglist, $ptr_to_int(L#_Arglist), $ptr_to(^^i1));
    // stmt _vcc_stack_free(@stackframe, addr._Format); 
    call $stack_free(#stackframe, $phys_ptr_cast(addr._Format, $ptr_to(^^u2)));
    assume $full_stop_ext(#tok$3^36.1, $s);
    // return _Ret; 
    $result := L#_Ret;
    assert $position_marker();
    goto #exit;

  anon8:
    // empty
    // Block cleanup
    // stmt _vcc_stack_free(@stackframe, addr._Format); 
    call $stack_free(#stackframe, $phys_ptr_cast(addr._Format, $ptr_to(^^u2)));
    assume $full_stop_ext(#tok$3^36.1, $s);

  #exit:
}



procedure vswprintf(P#_String: $ptr, P#_Count: int, P#_Format: $ptr, P#_Ap: $ptr) returns ($result: int);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation vswprintf(P#_String: $ptr, P#_Count: int, P#_Format: $ptr, P#_Ap: $ptr) returns ($result: int)
{
  var res__vswprintf_c_l#41: int where $in_range_i4(res__vswprintf_c_l#41);
  var #wrTime$3^49.1: int;
  var #stackframe: int;

  anon9:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$3^49.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$3^49.1, #loc._String, $ptr_to_int(P#_String), $ptr_to(^^u2));
    assume $local_value_is($s, #tok$3^49.1, #loc._Count, P#_Count, ^^u4);
    assume $local_value_is($s, #tok$3^49.1, #loc._Format, $ptr_to_int(P#_Format), $ptr_to(^^u2));
    assume $local_value_is($s, #tok$3^49.1, #loc._Ap, $ptr_to_int(P#_Ap), $ptr_to(^^i1));
    assume #wrTime$3^49.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$3^49.1, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @in_range_u4(_Count); 
    assume $in_range_u4(P#_Count);
    // assume true; 
    assume true;
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // int32_t res__vswprintf_c_l#41; 
    assume $local_value_is($s, #tok$3^51.12, #loc.res__vswprintf_c_l#41, res__vswprintf_c_l#41, ^^i4);
    // res__vswprintf_c_l#41 := _vswprintf_c_l(_String, _Count, _Format, (struct localeinfo_struct*)@null, _Ap); 
    call res__vswprintf_c_l#41 := _vswprintf_c_l($phys_ptr_cast(P#_String, ^^u2), P#_Count, $phys_ptr_cast(P#_Format, ^^u2), $phys_ptr_cast($null, ^localeinfo_struct), $phys_ptr_cast(P#_Ap, ^^i1));
    assume $full_stop_ext(#tok$3^51.12, $s);
    assume $local_value_is($s, #tok$3^51.12, #loc.res__vswprintf_c_l#41, res__vswprintf_c_l#41, ^^i4);
    // return res__vswprintf_c_l#41; 
    $result := res__vswprintf_c_l#41;
    assert $position_marker();
    goto #exit;

  anon10:
    // empty

  #exit:
}



procedure _swprintf_l(P#_String: $ptr, P#_Count: int, P#_Format: $ptr, P#_Plocinfo: $ptr) returns ($result: int);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _swprintf_l(P#_String: $ptr, P#_Count: int, P#_Format: $ptr, P#_Plocinfo: $ptr) returns ($result: int)
{
  var L#_Arglist: $ptr;
  var L#_Ret: int where $in_range_i4(L#_Ret);
  var addr._Plocinfo: $ptr;
  var #wrTime$3^60.1: int;
  var #stackframe: int;

  anon11:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$3^60.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$3^60.1, #loc._String, $ptr_to_int(P#_String), $ptr_to(^^u2));
    assume $local_value_is($s, #tok$3^60.1, #loc._Count, P#_Count, ^^u4);
    assume $local_value_is($s, #tok$3^60.1, #loc._Format, $ptr_to_int(P#_Format), $ptr_to(^^u2));
    assume $local_value_is($s, #tok$3^60.1, #loc._Plocinfo, $ptr_to_int(P#_Plocinfo), $ptr_to(^localeinfo_struct));
    assume #wrTime$3^60.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$3^60.1, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @in_range_u4(_Count); 
    assume $in_range_u4(P#_Count);
    // assume true; 
    assume true;
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // struct localeinfo_struct** addr._Plocinfo; 
    assume $local_value_is($s, #tok$3^60.1, #loc.addr._Plocinfo, $ptr_to_int(addr._Plocinfo), $ptr_to($ptr_to(^localeinfo_struct)));
    // addr._Plocinfo := _vcc_stack_alloc<struct localeinfo_struct*>(@stackframe, false); 
    call addr._Plocinfo := $stack_alloc($ptr_to(^localeinfo_struct), #stackframe, false);
    assume $full_stop_ext(#tok$3^60.1, $s);
    assume $local_value_is($s, #tok$3^60.1, #loc.addr._Plocinfo, $ptr_to_int(addr._Plocinfo), $ptr_to($ptr_to(^localeinfo_struct)));
    // assert @prim_writes_check(addr._Plocinfo); 
    assert $writable_prim($s, #wrTime$3^60.1, $phys_ptr_cast(addr._Plocinfo, $ptr_to(^localeinfo_struct)));
    // *addr._Plocinfo := _Plocinfo; 
    call $write_int($field($phys_ptr_cast(addr._Plocinfo, $ptr_to(^localeinfo_struct))), $emb0($phys_ptr_cast(addr._Plocinfo, $ptr_to(^localeinfo_struct))), $ptr_to_int($phys_ptr_cast(P#_Plocinfo, ^localeinfo_struct)));
    assume $full_stop_ext(#tok$3^64.30, $s);
    // int32_t _Ret; 
    assume $local_value_is($s, #tok$3^63.5, #loc._Ret, L#_Ret, ^^i4);
    // int8_t* _Arglist; 
    assume $local_value_is($s, #tok$3^62.5, #loc._Arglist, $ptr_to_int(L#_Arglist), $ptr_to(^^i1));
    // var int8_t* _Arglist
    // var int32_t _Ret
    // _Arglist := (int8_t*)addr._Plocinfo[8]; 
    L#_Arglist := $idx($phys_ptr_cast($phys_ptr_cast(addr._Plocinfo, $ptr_to(^localeinfo_struct)), ^^i1), 8);
    assume $local_value_is($s, #tok$3^64.7, #loc._Arglist, $ptr_to_int(L#_Arglist), $ptr_to(^^i1));
    // non-pure function
    // assert @reads_check_normal(addr._Plocinfo); 
    assert $thread_local($s, $phys_ptr_cast(addr._Plocinfo, $ptr_to(^localeinfo_struct)));
    // _Ret := _vswprintf_c_l(_String, _Count, _Format, *(addr._Plocinfo), _Arglist); 
    call L#_Ret := _vswprintf_c_l($phys_ptr_cast(P#_String, ^^u2), P#_Count, $phys_ptr_cast(P#_Format, ^^u2), $rd_phys_ptr($s, $field($phys_ptr_cast(addr._Plocinfo, $ptr_to(^localeinfo_struct))), $emb0($phys_ptr_cast(addr._Plocinfo, $ptr_to(^localeinfo_struct))), ^localeinfo_struct), $phys_ptr_cast(L#_Arglist, ^^i1));
    assume $full_stop_ext(#tok$3^65.12, $s);
    assume $local_value_is($s, #tok$3^65.12, #loc._Ret, L#_Ret, ^^i4);
    // _Arglist := (int8_t*)@null; 
    L#_Arglist := $phys_ptr_cast($null, ^^i1);
    assume $local_value_is($s, #tok$3^66.7, #loc._Arglist, $ptr_to_int(L#_Arglist), $ptr_to(^^i1));
    // stmt _vcc_stack_free(@stackframe, addr._Plocinfo); 
    call $stack_free(#stackframe, $phys_ptr_cast(addr._Plocinfo, $ptr_to(^localeinfo_struct)));
    assume $full_stop_ext(#tok$3^60.1, $s);
    // return _Ret; 
    $result := L#_Ret;
    assert $position_marker();
    goto #exit;

  anon12:
    // empty
    // Block cleanup
    // stmt _vcc_stack_free(@stackframe, addr._Plocinfo); 
    call $stack_free(#stackframe, $phys_ptr_cast(addr._Plocinfo, $ptr_to(^localeinfo_struct)));
    assume $full_stop_ext(#tok$3^60.1, $s);

  #exit:
}



procedure _vswprintf_l(P#_String: $ptr, P#_Count: int, P#_Format: $ptr, P#_Plocinfo: $ptr, P#_Ap: $ptr) returns ($result: int);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _vswprintf_l(P#_String: $ptr, P#_Count: int, P#_Format: $ptr, P#_Plocinfo: $ptr, P#_Ap: $ptr) returns ($result: int)
{
  var res__vswprintf_c_l#42: int where $in_range_i4(res__vswprintf_c_l#42);
  var #wrTime$3^73.1: int;
  var #stackframe: int;

  anon13:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$3^73.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$3^73.1, #loc._String, $ptr_to_int(P#_String), $ptr_to(^^u2));
    assume $local_value_is($s, #tok$3^73.1, #loc._Count, P#_Count, ^^u4);
    assume $local_value_is($s, #tok$3^73.1, #loc._Format, $ptr_to_int(P#_Format), $ptr_to(^^u2));
    assume $local_value_is($s, #tok$3^73.1, #loc._Plocinfo, $ptr_to_int(P#_Plocinfo), $ptr_to(^localeinfo_struct));
    assume $local_value_is($s, #tok$3^73.1, #loc._Ap, $ptr_to_int(P#_Ap), $ptr_to(^^i1));
    assume #wrTime$3^73.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$3^73.1, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @in_range_u4(_Count); 
    assume $in_range_u4(P#_Count);
    // assume true; 
    assume true;
    // assume true; 
    assume true;
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // int32_t res__vswprintf_c_l#42; 
    assume $local_value_is($s, #tok$3^75.12, #loc.res__vswprintf_c_l#42, res__vswprintf_c_l#42, ^^i4);
    // res__vswprintf_c_l#42 := _vswprintf_c_l(_String, _Count, _Format, _Plocinfo, _Ap); 
    call res__vswprintf_c_l#42 := _vswprintf_c_l($phys_ptr_cast(P#_String, ^^u2), P#_Count, $phys_ptr_cast(P#_Format, ^^u2), $phys_ptr_cast(P#_Plocinfo, ^localeinfo_struct), $phys_ptr_cast(P#_Ap, ^^i1));
    assume $full_stop_ext(#tok$3^75.12, $s);
    assume $local_value_is($s, #tok$3^75.12, #loc.res__vswprintf_c_l#42, res__vswprintf_c_l#42, ^^i4);
    // return res__vswprintf_c_l#42; 
    $result := res__vswprintf_c_l#42;
    assert $position_marker();
    goto #exit;

  anon14:
    // empty

  #exit:
}



function F#mark(SP#i: int) : int;

const unique cf#mark: $pure_function;

axiom (forall SP#i: int :: { F#mark(SP#i) } $in_range_u4(F#mark(SP#i)) && F#mark(SP#i) == $unchecked(^^u4, SP#i));

axiom $function_arg_type(cf#mark, 0, ^^u4);

axiom $function_arg_type(cf#mark, 1, ^^u4);

procedure mark(SP#i: int) returns ($result: int);
  free ensures $in_range_u4($result);
  ensures $result == $unchecked(^^u4, SP#i);
  free ensures $result == F#mark(SP#i);
  free ensures $call_transition(old($s), $s);



function F#mark3(SP#i: int, SP#e: int) : bool;

const unique cf#mark3: $pure_function;

axiom (forall SP#i: int, SP#e: int :: { F#mark3(SP#i, SP#e) } F#mark3(SP#i, SP#e) == (F#mark(SP#i) >= 0 && F#mark($op_mul(2, SP#i) + 1) >= 0 && F#mark($op_mul(2, SP#i) + 2) >= 0));

axiom $function_arg_type(cf#mark3, 0, ^^bool);

axiom $function_arg_type(cf#mark3, 1, ^^u4);

axiom $function_arg_type(cf#mark3, 2, ^^i4);

procedure mark3(SP#i: int, SP#e: int) returns ($result: bool);
  ensures $result == (F#mark(SP#i) >= 0 && F#mark($op_mul(2, SP#i) + 1) >= 0 && F#mark($op_mul(2, SP#i) + 2) >= 0);
  free ensures $result == F#mark3(SP#i, SP#e);
  free ensures $call_transition(old($s), $s);



procedure init(P#h: $ptr);
  modifies $s, $cev_pc;
  ensures $wrapped($s, $phys_ptr_cast(P#h, ^Heap), ^Heap) && $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) == 0 && $eq.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($rd_inv($s, Heap.abs, $phys_ptr_cast(P#h, ^Heap))), F#lambda#10());
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: $set_in(#p, $span($phys_ptr_cast(P#h, ^Heap)))));
  free ensures $call_transition(old($s), $s);



implementation init(P#h: $ptr)
{
  var owns#55: $ptrset;
  var staticWrapState#54: $state;
  var prestate#56: $state;
  var res_lambda#8#44: $map_t..^^i4.^^mathint;
  var res_lambda#9#43: $map_t..^^u4.$map_t..^^i4.^^mathint;
  var #wrTime$1^69.1: int;
  var #stackframe: int;

  anon15:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^69.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^69.1, #loc.h, $ptr_to_int(P#h), $ptr_to(^Heap));
    assume #wrTime$1^69.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^69.1, (lambda #p: $ptr :: $set_in(#p, $span($phys_ptr_cast(P#h, ^Heap)))));
    assume $mutable($s, $phys_ptr_cast(P#h, ^Heap));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // (uint32_t -> (int32_t -> mathint)) res_lambda#9#43; 
    assume $local_value_is($s, #tok$1^74.13, #loc.res_lambda#9#43, $map_t..^^u4.map_t..^^i4.^^mathint_to_int(res_lambda#9#43), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    // (int32_t -> mathint) res_lambda#8#44; 
    assume $local_value_is($s, #tok$1^74.13, #loc.res_lambda#8#44, $map_t..^^i4.^^mathint_to_int(res_lambda#8#44), $map_t(^^i4, ^^mathint));
    // res_lambda#8#44 := lambda#8(); 
    call res_lambda#8#44 := lambda#8();
    assume $full_stop_ext(#tok$1^74.13, $s);
    assume $local_value_is($s, #tok$1^74.13, #loc.res_lambda#8#44, $map_t..^^i4.^^mathint_to_int(res_lambda#8#44), $map_t(^^i4, ^^mathint));
    // res_lambda#9#43 := lambda#9(res_lambda#8#44); 
    call res_lambda#9#43 := lambda#9(res_lambda#8#44);
    assume $full_stop_ext(#tok$1^74.13, $s);
    assume $local_value_is($s, #tok$1^74.13, #loc.res_lambda#9#43, $map_t..^^u4.map_t..^^i4.^^mathint_to_int(res_lambda#9#43), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    // assert @prim_writes_check((h->sh)); 
    assert $writable_prim($s, #wrTime$1^69.1, $dot($phys_ptr_cast(P#h, ^Heap), Heap.sh));
    // *(h->sh) := res_lambda#9#43; 
    call $write_int(Heap.sh, $phys_ptr_cast(P#h, ^Heap), $map_t..^^u4.map_t..^^i4.^^mathint_to_int(res_lambda#9#43));
    assume $full_stop_ext(#tok$1^74.5, $s);
    // assert @prim_writes_check((h->abs)); 
    assert $writable_prim($s, #wrTime$1^69.1, $dot($phys_ptr_cast(P#h, ^Heap), Heap.abs));
    // assert @reads_check_normal((h->sh)); 
    assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
    // *(h->abs) := @map_get(*((h->sh)), 0); 
    call $write_int(Heap.abs, $phys_ptr_cast(P#h, ^Heap), $map_t..^^i4.^^mathint_to_int($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), 0)));
    assume $full_stop_ext(#tok$1^75.5, $s);
    // assert @prim_writes_check((h->len)); 
    assert $writable_prim($s, #wrTime$1^69.1, $dot($phys_ptr_cast(P#h, ^Heap), Heap.len));
    // *(h->len) := 0; 
    call $write_int(Heap.len, $phys_ptr_cast(P#h, ^Heap), 0);
    assume $full_stop_ext(#tok$1^77.3, $s);
    // _math state_t prestate#56; 
    assume $local_value_is($s, #tok$4^0.0, #loc.prestate#56, $state_to_int(prestate#56), ^$#state_t);
    // prestate#56 := @_vcc_current_state(@state); 
    prestate#56 := $current_state($s);
    assume $local_value_is($s, #tok$4^0.0, #loc.prestate#56, $state_to_int(prestate#56), ^$#state_t);
    // _math state_t staticWrapState#54; 
    assume $local_value_is($s, #tok$4^0.0, #loc.staticWrapState#54, $state_to_int(staticWrapState#54), ^$#state_t);
    // staticWrapState#54 := @_vcc_current_state(@state); 
    staticWrapState#54 := $current_state($s);
    assume $local_value_is($s, #tok$4^0.0, #loc.staticWrapState#54, $state_to_int(staticWrapState#54), ^$#state_t);
    // _math ptrset owns#55; 
    assume $local_value_is($s, #tok$4^0.0, #loc.owns#55, $ptrset_to_int(owns#55), ^$#ptrset);
    // owns#55 := @_vcc_set_empty; 
    owns#55 := $set_empty();
    assume $local_value_is($s, #tok$4^0.0, #loc.owns#55, $ptrset_to_int(owns#55), ^$#ptrset);
    // assert @writes_check(h); 
    assert $top_writable($s, #wrTime$1^69.1, $phys_ptr_cast(P#h, ^Heap));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(h), staticWrapState#54, owns#55)
    call $static_wrap($phys_ptr_cast(P#h, ^Heap), staticWrapState#54, owns#55);
    assume $good_state_ext(#tok$1^78.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, h), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(P#h, ^Heap)), $set_empty());
    // assert @inv_check(@map_eq(@map_get(*((h->sh)), 0), *((h->abs)))); 
    assert $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), 0), $int_to_map_t..^^i4.^^mathint($rd_inv($s, Heap.abs, $phys_ptr_cast(P#h, ^Heap))));
    // assert @inv_check(<=(*((h->len)), 1000)); 
    assert $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) <= 1000;
    // assert @inv_check(forall(uint32_t i; { @map_get(*((h->sh)), mark(i)) } @in_range_u4(i); ==>(&&(!=(i, *((h->len))), <(i, *((h->len)))), @map_eq(@map_get(*((h->sh)), mark(i)), lambda#6(@map_get(*((h->sh)), unchecked+(unchecked*(2, i), 2)), @map_get(*((h->sh)), unchecked+(unchecked*(2, i), 1)), *((h->heap)[i])))))); 
    assert (forall Q#i$1^65.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^65.29#tc1)) } $in_range_u4(Q#i$1^65.29#tc1) ==> Q#i$1^65.29#tc1 != $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) && Q#i$1^65.29#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^65.29#tc1)), F#lambda#6($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 2)), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 1)), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^65.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^65.29#tc1))))));
    // assert @inv_check(forall(uint32_t i; { @map_get(*((h->sh)), mark(i)) } @in_range_u4(i); ==>(>=(i, *((h->len))), @map_eq(@map_get(*((h->sh)), mark(i)), lambda#7())))); 
    assert (forall Q#i$1^66.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^66.29#tc1)) } $in_range_u4(Q#i$1^66.29#tc1) ==> Q#i$1^66.29#tc1 >= $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^66.29#tc1)), F#lambda#7()));
    // assert @inv_check(forall(uint32_t i; int32_t e; { @map_get(@map_get(*((h->sh)), mark(i)), e) } { mark3(i, e) } { @trigger_hint(mark3(i, e)) } &&(@in_range_u4(i), @in_range_i4(e)); ==>(<(i, *((h->len))), >=(@map_get(@map_get(*((h->sh)), mark(i)), e), 0)))); 
    assert (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) >= 0);
    // assert @inv_check(forall(uint32_t i; int32_t e; { @map_get(@map_get(*((h->sh)), mark(i)), e) } { mark3(i, e) } { @trigger_hint(mark3(i, e)) } &&(@in_range_u4(i), @in_range_i4(e)); ==>(<(i, *((h->len))), ==>(!=(i, *((h->len))), ==>(>(@map_get(@map_get(*((h->sh)), i), e), 0), >=(e, *((h->heap)[i]))))))); 
    assert (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> Q#i$1^66.29#tc1 != $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), Q#i$1^66.29#tc1), Q#e$1^66.29#tc2) > 0 ==> Q#e$1^66.29#tc2 >= $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^66.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^66.29#tc1))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure insert(P#h: $ptr, P#elt: int);
  requires $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) < 999;
  requires $wrapped($s, $phys_ptr_cast(P#h, ^Heap), ^Heap);
  modifies $s, $cev_pc;
  ensures $eq.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($rd_inv($s, Heap.abs, $phys_ptr_cast(P#h, ^Heap))), F#lambda#21($int_to_map_t..^^i4.^^mathint($rd_inv(old($s), Heap.abs, $phys_ptr_cast(P#h, ^Heap))), $int_to_map_t..^^i4.^^mathint($rd_inv(old($s), Heap.abs, $phys_ptr_cast(P#h, ^Heap))), P#elt));
  ensures $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) == $rd_inv(old($s), Heap.len, $phys_ptr_cast(P#h, ^Heap)) + 1;
  ensures $wrapped($s, $phys_ptr_cast(P#h, ^Heap), ^Heap);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#h, ^Heap)));
  free ensures $call_transition(old($s), $s);



implementation insert(P#h: $ptr, P#elt: int)
{
  var owns#61: $ptrset;
  var staticWrapState#60: $state;
  var prestate#62: $state;
  var res_lambda#20#48: $map_t..^^i4.^^mathint;
  var res_lambda#19#47: $map_t..^^i4.^^mathint;
  var p2#0: int where $in_range_u4(p2#0);
  var #wrTime$1^143.28: int;
  var loopState#1: $state;
  var res_lambda#15#46: $map_t..^^i4.^^mathint;
  var res_lambda#14#45: $map_t..^^i4.^^mathint;
  var L#tmp: int where $in_range_i4(L#tmp);
  var L#p2: int where $in_range_u4(L#p2);
  var #wrTime$1^101.28: int;
  var loopState#0: $state;
  var prestate#59: $state;
  var prestate#57: $state;
  var owns#58: $ptrset;
  var L#p: int where $in_range_u4(L#p);
  var #wrTime$1^81.1: int;
  var #stackframe: int;

  anon25:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^81.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^81.1, #loc.h, $ptr_to_int(P#h), $ptr_to(^Heap));
    assume $local_value_is($s, #tok$1^81.1, #loc.elt, P#elt, ^^i4);
    assume #wrTime$1^81.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^81.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#h, ^Heap)));
    assume $thread_owned($s, $phys_ptr_cast(P#h, ^Heap));
    // assume true; 
    assume true;
    // assume @in_range_i4(elt); 
    assume $in_range_i4(P#elt);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, h, h); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#h, ^Heap), $phys_ptr_cast(P#h, ^Heap), l#public);
    // uint32_t p; 
    assume $local_value_is($s, #tok$1^88.3, #loc.p, L#p, ^^u4);
    // var uint32_t p
    // _math ptrset owns#58; 
    assume $local_value_is($s, #tok$4^0.0, #loc.owns#58, $ptrset_to_int(owns#58), ^$#ptrset);
    // owns#58 := @_vcc_set_empty; 
    owns#58 := $set_empty();
    assume $local_value_is($s, #tok$4^0.0, #loc.owns#58, $ptrset_to_int(owns#58), ^$#ptrset);
    // _math state_t prestate#57; 
    assume $local_value_is($s, #tok$4^0.0, #loc.prestate#57, $state_to_int(prestate#57), ^$#state_t);
    // prestate#57 := @_vcc_current_state(@state); 
    prestate#57 := $current_state($s);
    assume $local_value_is($s, #tok$4^0.0, #loc.prestate#57, $state_to_int(prestate#57), ^$#state_t);
    // _math state_t prestate#59; 
    assume $local_value_is($s, #tok$4^0.0, #loc.prestate#59, $state_to_int(prestate#59), ^$#state_t);
    // prestate#59 := @_vcc_current_state(@state); 
    prestate#59 := $current_state($s);
    assume $local_value_is($s, #tok$4^0.0, #loc.prestate#59, $state_to_int(prestate#59), ^$#state_t);
    // assert @_vcc_wrapped(@state, h); 
    assert $wrapped($s, $phys_ptr_cast(P#h, ^Heap), ^Heap);
    // assert @writes_check(h); 
    assert $top_writable($s, #wrTime$1^81.1, $phys_ptr_cast(P#h, ^Heap));
    // assume @_vcc_inv(@state, h); 
    assume $inv($s, $phys_ptr_cast(P#h, ^Heap), ^Heap);
    // assume ==(owns#58, @_vcc_owns(@state, h)); 
    assume owns#58 == $owns($s, $phys_ptr_cast(P#h, ^Heap));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(h), prestate#59)
    call $static_unwrap($phys_ptr_cast(P#h, ^Heap), prestate#59);
    assume $good_state_ext(#tok$1^90.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @reads_check_normal((h->len)); 
    assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
    // p := *((h->len)); 
    L#p := $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap));
    assume $local_value_is($s, #tok$1^91.3, #loc.p, L#p, ^^u4);
    // assert @prim_writes_check((h->len)); 
    assert $writable_prim($s, #wrTime$1^81.1, $dot($phys_ptr_cast(P#h, ^Heap), Heap.len));
    // assert @in_range_u4(+(*((h->len)), 1)); 
    assert $in_range_u4($rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) + 1);
    // assert @reads_check_normal((h->len)); 
    assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
    // *(h->len) := +(*((h->len)), 1); 
    call $write_int(Heap.len, $phys_ptr_cast(P#h, ^Heap), $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) + 1);
    assume $full_stop_ext(#tok$1^92.3, $s);
    // assert @prim_writes_check((h->heap)[p]); 
    assert $writable_prim($s, #wrTime$1^81.1, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p));
    // *(h->heap)[p] := elt; 
    call $write_int($field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), P#elt);
    assume $full_stop_ext(#tok$1^93.3, $s);
    // assert mark3(p, 0); 
    assert F#mark3(L#p, 0);
    // assume mark3(p, 0); 
    assume F#mark3(L#p, 0);
    call $bump_timestamp();
    assume $full_stop_ext(#tok$1^101.28, $s);
    loopState#0 := $s;
    assume #wrTime$1^101.28 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^101.28, (lambda #p: $ptr :: $set_in(#p, $span($phys_ptr_cast(P#h, ^Heap)))));
    assert (forall #loopWrites^$1^101.28: $ptr :: { $dont_instantiate(#loopWrites^$1^101.28) } $listed_in_writes($s, #wrTime$1^101.28, #loopWrites^$1^101.28) ==> $top_writable($s, #wrTime$1^81.1, #loopWrites^$1^101.28));
    while (true)
      invariant $rd_inv(loopState#0, Heap.len, $phys_ptr_cast(P#h, ^Heap)) == $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap));
      invariant $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv(loopState#0, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), 0), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), 0));
      invariant L#p < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap));
      invariant (forall Q#i$1^100.31#tc1: int :: {:weight 10} { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^100.31#tc1)) } $in_range_u4(Q#i$1^100.31#tc1) ==> Q#i$1^100.31#tc1 >= $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^100.31#tc1)), F#lambda#11()));
      invariant (forall Q#i$1^100.31#tc1: int, Q#e$1^100.31#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^100.31#tc1)), Q#e$1^100.31#tc2) } { F#mark3(Q#i$1^100.31#tc1, Q#e$1^100.31#tc2) } { sk_hack(F#mark3(Q#i$1^100.31#tc1, Q#e$1^100.31#tc2)) } $in_range_u4(Q#i$1^100.31#tc1) && $in_range_i4(Q#e$1^100.31#tc2) ==> Q#i$1^100.31#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^100.31#tc1)), Q#e$1^100.31#tc2) >= 0);
      invariant (forall Q#i$1^100.31#tc1: int, Q#e$1^100.31#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^100.31#tc1)), Q#e$1^100.31#tc2) } { F#mark3(Q#i$1^100.31#tc1, Q#e$1^100.31#tc2) } { sk_hack(F#mark3(Q#i$1^100.31#tc1, Q#e$1^100.31#tc2)) } $in_range_u4(Q#i$1^100.31#tc1) && $in_range_i4(Q#e$1^100.31#tc2) ==> Q#i$1^100.31#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> Q#i$1^100.31#tc1 != $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), Q#i$1^100.31#tc1), Q#e$1^100.31#tc2) > 0 ==> Q#e$1^100.31#tc2 >= $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^100.31#tc1)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^100.31#tc1))));
      invariant (forall Q#i$1^102.31#tc1: int :: {:weight 10} { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^102.31#tc1)) } $in_range_u4(Q#i$1^102.31#tc1) ==> Q#i$1^102.31#tc1 != L#p && Q#i$1^102.31#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^102.31#tc1)), F#lambda#12($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^102.31#tc1), 2)), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^102.31#tc1), 1)), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^102.31#tc1)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^102.31#tc1))))));
      invariant $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), L#p), F#lambda#13($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $op_mul(2, L#p) + 2), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $op_mul(2, L#p) + 1), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p))), P#elt));
      invariant $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p))) == P#elt;
    {
      anon21:
        assume $modifies(loopState#0, $s, (lambda #p: $ptr :: $set_in(#p, $span($phys_ptr_cast(P#h, ^Heap)))));
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$1^97.3, $s);
        assume $local_value_is($s, #tok$1^97.3, #loc.prestate#59, $state_to_int(prestate#59), ^$#state_t);
        assume $local_value_is($s, #tok$1^97.3, #loc.prestate#57, $state_to_int(prestate#57), ^$#state_t);
        assume $local_value_is($s, #tok$1^97.3, #loc.owns#58, $ptrset_to_int(owns#58), ^$#ptrset);
        assume $local_value_is($s, #tok$1^97.3, #loc.p, L#p, ^^u4);
        assume $local_value_is($s, #tok$1^97.3, #loc.elt, P#elt, ^^i4);
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#0, $s);
        assume true;
        // if (>(p, 0)) ...
        if (L#p > 0)
        {
          anon18:
            // uint32_t p2; 
            assume $local_value_is($s, #tok$1^106.5, #loc.p2, L#p2, ^^u4);
            // var uint32_t p2
            // assert !=(2, 0); 
            assert 2 != 0;
            // assert @in_range_u4(-(p, 1)); 
            assert $in_range_u4(L#p - 1);
            // p2 := /(-(p, 1), 2); 
            L#p2 := (L#p - 1) / 2;
            assume $local_value_is($s, #tok$1^108.5, #loc.p2, L#p2, ^^u4);
            // assert mark3(p2, 0); 
            assert F#mark3(L#p2, 0);
            // assume mark3(p2, 0); 
            assume F#mark3(L#p2, 0);
            // assert mark3(+(*(2, p), 1), 0); 
            assert F#mark3($op_mul(2, L#p) + 1, 0);
            // assume mark3(+(*(2, p), 1), 0); 
            assume F#mark3($op_mul(2, L#p) + 1, 0);
            // assert mark3(+(*(2, p), 2), 0); 
            assert F#mark3($op_mul(2, L#p) + 2, 0);
            // assume mark3(+(*(2, p), 2), 0); 
            assume F#mark3($op_mul(2, L#p) + 2, 0);
            // assert >=(@map_get(@map_get(*((h->sh)), p2), *((h->heap)[+(*(2, p), 2)])), 0); 
            assert $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), L#p2), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), $op_mul(2, L#p) + 2)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), $op_mul(2, L#p) + 2)))) >= 0;
            // assume >=(@map_get(@map_get(*((h->sh)), p2), *((h->heap)[+(*(2, p), 2)])), 0); 
            assume $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), L#p2), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), $op_mul(2, L#p) + 2)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), $op_mul(2, L#p) + 2)))) >= 0;
            // assert >=(@map_get(@map_get(*((h->sh)), p2), *((h->heap)[+(*(2, p), 1)])), 0); 
            assert $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), L#p2), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), $op_mul(2, L#p) + 1)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), $op_mul(2, L#p) + 1)))) >= 0;
            // assume >=(@map_get(@map_get(*((h->sh)), p2), *((h->heap)[+(*(2, p), 1)])), 0); 
            assume $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), L#p2), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), $op_mul(2, L#p) + 1)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), $op_mul(2, L#p) + 1)))) >= 0;
            // assert @reads_check_normal((h->heap)[p]); 
            assert $thread_local($s, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p));
            // assert @reads_check_normal((h->heap)[p2]); 
            assert $thread_local($s, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p2));
            assume true;
            // if (<(*((h->heap)[p]), *((h->heap)[p2]))) ...
            if ($rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p))) < $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p2)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p2))))
            {
              anon16:
                // int32_t tmp; 
                assume $local_value_is($s, #tok$1^122.7, #loc.tmp, L#tmp, ^^i4);
                // var int32_t tmp
                // assert @reads_check_normal((h->heap)[p]); 
                assert $thread_local($s, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p));
                // tmp := *((h->heap)[p]); 
                L#tmp := $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)));
                assume $local_value_is($s, #tok$1^123.7, #loc.tmp, L#tmp, ^^i4);
                // assert @prim_writes_check((h->heap)[p]); 
                assert $writable_prim($s, #wrTime$1^101.28, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p));
                // assert @reads_check_normal((h->heap)[p2]); 
                assert $thread_local($s, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p2));
                // *(h->heap)[p] := *((h->heap)[p2]); 
                call $write_int($field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p2)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p2))));
                assume $full_stop_ext(#tok$1^124.7, $s);
                // assert @prim_writes_check((h->heap)[p2]); 
                assert $writable_prim($s, #wrTime$1^101.28, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p2));
                // *(h->heap)[p2] := tmp; 
                call $write_int($field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p2)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p2)), L#tmp);
                assume $full_stop_ext(#tok$1^125.7, $s);
            }
            else
            {
              anon17:
                // (int32_t -> mathint) res_lambda#14#45; 
                assume $local_value_is($s, #tok$1^130.40, #loc.res_lambda#14#45, $map_t..^^i4.^^mathint_to_int(res_lambda#14#45), $map_t(^^i4, ^^mathint));
                // assert @reads_check_normal((h->sh)); 
                assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
                // assert @in_range_u4(+(*(2, p), 2)); 
                assert $in_range_u4($op_mul(2, L#p) + 2);
                // assert @in_range_u4(*(2, p)); 
                assert $in_range_u4($op_mul(2, L#p));
                // assert @reads_check_normal((h->sh)); 
                assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
                // assert @in_range_u4(+(*(2, p), 1)); 
                assert $in_range_u4($op_mul(2, L#p) + 1);
                // assert @in_range_u4(*(2, p)); 
                assert $in_range_u4($op_mul(2, L#p));
                // assert @reads_check_normal((h->heap)[p]); 
                assert $thread_local($s, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p));
                // res_lambda#14#45 := lambda#14(@map_get(*((h->sh)), +(*(2, p), 2)), @map_get(*((h->sh)), +(*(2, p), 1)), *((h->heap)[p])); 
                call res_lambda#14#45 := lambda#14($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $op_mul(2, L#p) + 2), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $op_mul(2, L#p) + 1), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p))));
                assume $full_stop_ext(#tok$1^130.40, $s);
                assume $local_value_is($s, #tok$1^130.40, #loc.res_lambda#14#45, $map_t..^^i4.^^mathint_to_int(res_lambda#14#45), $map_t(^^i4, ^^mathint));
                // assert @prim_writes_check((h->sh)); 
                assert $writable_prim($s, #wrTime$1^101.28, $dot($phys_ptr_cast(P#h, ^Heap), Heap.sh));
                // assert @reads_check_normal((h->sh)); 
                assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
                // *(h->sh) := @map_updated(*((h->sh)), p, res_lambda#14#45); 
                call $write_int(Heap.sh, $phys_ptr_cast(P#h, ^Heap), $map_t..^^u4.map_t..^^i4.^^mathint_to_int($store.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), L#p, res_lambda#14#45)));
                assume $full_stop_ext(#tok$1^130.29, $s);
                // p := p2; 
                L#p := L#p2;
                assume $local_value_is($s, #tok$1^131.7, #loc.p, L#p, ^^u4);
                // goto #break_35; 
                goto #break_35;
            }

          anon19:
            // (int32_t -> mathint) res_lambda#15#46; 
            assume $local_value_is($s, #tok$1^135.38, #loc.res_lambda#15#46, $map_t..^^i4.^^mathint_to_int(res_lambda#15#46), $map_t(^^i4, ^^mathint));
            // assert @reads_check_normal((h->sh)); 
            assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
            // assert @in_range_u4(+(*(2, p), 2)); 
            assert $in_range_u4($op_mul(2, L#p) + 2);
            // assert @in_range_u4(*(2, p)); 
            assert $in_range_u4($op_mul(2, L#p));
            // assert @reads_check_normal((h->sh)); 
            assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
            // assert @in_range_u4(+(*(2, p), 1)); 
            assert $in_range_u4($op_mul(2, L#p) + 1);
            // assert @in_range_u4(*(2, p)); 
            assert $in_range_u4($op_mul(2, L#p));
            // assert @reads_check_normal((h->heap)[p]); 
            assert $thread_local($s, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p));
            // res_lambda#15#46 := lambda#15(@map_get(*((h->sh)), +(*(2, p), 2)), @map_get(*((h->sh)), +(*(2, p), 1)), *((h->heap)[p])); 
            call res_lambda#15#46 := lambda#15($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $op_mul(2, L#p) + 2), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $op_mul(2, L#p) + 1), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p))));
            assume $full_stop_ext(#tok$1^135.38, $s);
            assume $local_value_is($s, #tok$1^135.38, #loc.res_lambda#15#46, $map_t..^^i4.^^mathint_to_int(res_lambda#15#46), $map_t(^^i4, ^^mathint));
            // assert @prim_writes_check((h->sh)); 
            assert $writable_prim($s, #wrTime$1^101.28, $dot($phys_ptr_cast(P#h, ^Heap), Heap.sh));
            // assert @reads_check_normal((h->sh)); 
            assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
            // *(h->sh) := @map_updated(*((h->sh)), p, res_lambda#15#46); 
            call $write_int(Heap.sh, $phys_ptr_cast(P#h, ^Heap), $map_t..^^u4.map_t..^^i4.^^mathint_to_int($store.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), L#p, res_lambda#15#46)));
            assume $full_stop_ext(#tok$1^135.27, $s);
            // p := p2; 
            L#p := L#p2;
            assume $local_value_is($s, #tok$1^136.5, #loc.p, L#p, ^^u4);
        }
        else
        {
          anon20:
            // goto #break_35; 
            goto #break_35;
        }

      #continue_35:
        assume true;
    }

  anon26:
    assume $full_stop_ext(#tok$1^97.3, $s);

  #break_35:
    call $bump_timestamp();
    assume $full_stop_ext(#tok$1^143.28, $s);
    loopState#1 := $s;
    assume #wrTime$1^143.28 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^143.28, (lambda #p: $ptr :: $set_in(#p, $span($phys_ptr_cast(P#h, ^Heap)))));
    assert (forall #loopWrites^$1^143.28: $ptr :: { $dont_instantiate(#loopWrites^$1^143.28) } $listed_in_writes($s, #wrTime$1^143.28, #loopWrites^$1^143.28) ==> $top_writable($s, #wrTime$1^81.1, #loopWrites^$1^143.28));
    while (true)
      invariant $rd_inv(loopState#1, Heap.len, $phys_ptr_cast(P#h, ^Heap)) == $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap));
      invariant $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv(loopState#1, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), 0), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), 0));
      invariant L#p < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap));
      invariant (forall Q#i$1^142.31#tc1: int :: {:weight 10} { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^142.31#tc1)) } $in_range_u4(Q#i$1^142.31#tc1) ==> Q#i$1^142.31#tc1 >= $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^142.31#tc1)), F#lambda#16()));
      invariant (forall Q#i$1^142.31#tc1: int, Q#e$1^142.31#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^142.31#tc1)), Q#e$1^142.31#tc2) } { F#mark3(Q#i$1^142.31#tc1, Q#e$1^142.31#tc2) } { sk_hack(F#mark3(Q#i$1^142.31#tc1, Q#e$1^142.31#tc2)) } $in_range_u4(Q#i$1^142.31#tc1) && $in_range_i4(Q#e$1^142.31#tc2) ==> Q#i$1^142.31#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^142.31#tc1)), Q#e$1^142.31#tc2) >= 0);
      invariant (forall Q#i$1^142.31#tc1: int, Q#e$1^142.31#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^142.31#tc1)), Q#e$1^142.31#tc2) } { F#mark3(Q#i$1^142.31#tc1, Q#e$1^142.31#tc2) } { sk_hack(F#mark3(Q#i$1^142.31#tc1, Q#e$1^142.31#tc2)) } $in_range_u4(Q#i$1^142.31#tc1) && $in_range_i4(Q#e$1^142.31#tc2) ==> Q#i$1^142.31#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> Q#i$1^142.31#tc1 != $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), Q#i$1^142.31#tc1), Q#e$1^142.31#tc2) > 0 ==> Q#e$1^142.31#tc2 >= $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^142.31#tc1)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^142.31#tc1))));
      invariant (forall Q#i$1^144.31#tc1: int :: {:weight 10} { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^144.31#tc1)) } $in_range_u4(Q#i$1^144.31#tc1) ==> Q#i$1^144.31#tc1 != L#p && Q#i$1^144.31#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^144.31#tc1)), F#lambda#17($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^144.31#tc1), 2)), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^144.31#tc1), 1)), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^144.31#tc1)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^144.31#tc1))))));
      invariant $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), L#p), F#lambda#18($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $op_mul(2, L#p) + 2), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $op_mul(2, L#p) + 1), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p))), P#elt));
      invariant $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p))) <= P#elt;
      invariant L#p == 0 || $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), L#p), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)))) > 0;
    {
      anon24:
        assume $modifies(loopState#1, $s, (lambda #p: $ptr :: $set_in(#p, $span($phys_ptr_cast(P#h, ^Heap)))));
        assume $timestamp_post(loopState#1, $s);
        assume $full_stop_ext(#tok$1^139.3, $s);
        assume $local_value_is($s, #tok$1^139.3, #loc.res_lambda#15#46, $map_t..^^i4.^^mathint_to_int(res_lambda#15#46), $map_t(^^i4, ^^mathint));
        assume $local_value_is($s, #tok$1^139.3, #loc.res_lambda#14#45, $map_t..^^i4.^^mathint_to_int(res_lambda#14#45), $map_t(^^i4, ^^mathint));
        assume $local_value_is($s, #tok$1^139.3, #loc.tmp, L#tmp, ^^i4);
        assume $local_value_is($s, #tok$1^139.3, #loc.p2, L#p2, ^^u4);
        assume $local_value_is($s, #tok$1^139.3, #loc.prestate#59, $state_to_int(prestate#59), ^$#state_t);
        assume $local_value_is($s, #tok$1^139.3, #loc.prestate#57, $state_to_int(prestate#57), ^$#state_t);
        assume $local_value_is($s, #tok$1^139.3, #loc.owns#58, $ptrset_to_int(owns#58), ^$#ptrset);
        assume $local_value_is($s, #tok$1^139.3, #loc.p, L#p, ^^u4);
        assume $local_value_is($s, #tok$1^139.3, #loc.elt, P#elt, ^^i4);
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#1, $s);
        assume true;
        // if (>(p, 0)) ...
        if (L#p > 0)
        {
          anon22:
            // uint32_t p2#0; 
            assume $local_value_is($s, #tok$1^149.5, #loc.p2#0, p2#0, ^^u4);
            // var uint32_t p2
            // assert !=(2, 0); 
            assert 2 != 0;
            // assert @in_range_u4(-(p, 1)); 
            assert $in_range_u4(L#p - 1);
            // p2#0 := /(-(p, 1), 2); 
            p2#0 := (L#p - 1) / 2;
            assume $local_value_is($s, #tok$1^151.5, #loc.p2#0, p2#0, ^^u4);
            // assert mark3(p2#0, 0); 
            assert F#mark3(p2#0, 0);
            // assume mark3(p2#0, 0); 
            assume F#mark3(p2#0, 0);
            // assert >(@map_get(@map_get(*((h->sh)), p2#0), *((h->heap)[p])), 0); 
            assert $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), p2#0), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)))) > 0;
            // assume >(@map_get(@map_get(*((h->sh)), p2#0), *((h->heap)[p])), 0); 
            assume $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), p2#0), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)))) > 0;
            // (int32_t -> mathint) res_lambda#19#47; 
            assume $local_value_is($s, #tok$1^160.38, #loc.res_lambda#19#47, $map_t..^^i4.^^mathint_to_int(res_lambda#19#47), $map_t(^^i4, ^^mathint));
            // assert @reads_check_normal((h->sh)); 
            assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
            // assert @in_range_u4(+(*(2, p), 2)); 
            assert $in_range_u4($op_mul(2, L#p) + 2);
            // assert @in_range_u4(*(2, p)); 
            assert $in_range_u4($op_mul(2, L#p));
            // assert @reads_check_normal((h->sh)); 
            assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
            // assert @in_range_u4(+(*(2, p), 1)); 
            assert $in_range_u4($op_mul(2, L#p) + 1);
            // assert @in_range_u4(*(2, p)); 
            assert $in_range_u4($op_mul(2, L#p));
            // assert @reads_check_normal((h->heap)[p]); 
            assert $thread_local($s, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p));
            // res_lambda#19#47 := lambda#19(@map_get(*((h->sh)), +(*(2, p), 2)), @map_get(*((h->sh)), +(*(2, p), 1)), *((h->heap)[p])); 
            call res_lambda#19#47 := lambda#19($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $op_mul(2, L#p) + 2), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $op_mul(2, L#p) + 1), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p))));
            assume $full_stop_ext(#tok$1^160.38, $s);
            assume $local_value_is($s, #tok$1^160.38, #loc.res_lambda#19#47, $map_t..^^i4.^^mathint_to_int(res_lambda#19#47), $map_t(^^i4, ^^mathint));
            // assert @prim_writes_check((h->sh)); 
            assert $writable_prim($s, #wrTime$1^143.28, $dot($phys_ptr_cast(P#h, ^Heap), Heap.sh));
            // assert @reads_check_normal((h->sh)); 
            assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
            // *(h->sh) := @map_updated(*((h->sh)), p, res_lambda#19#47); 
            call $write_int(Heap.sh, $phys_ptr_cast(P#h, ^Heap), $map_t..^^u4.map_t..^^i4.^^mathint_to_int($store.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), L#p, res_lambda#19#47)));
            assume $full_stop_ext(#tok$1^160.27, $s);
            // p := p2#0; 
            L#p := p2#0;
            assume $local_value_is($s, #tok$1^161.5, #loc.p, L#p, ^^u4);
        }
        else
        {
          anon23:
            // goto #break_36; 
            goto #break_36;
        }

      #continue_36:
        assume true;
    }

  anon27:
    assume $full_stop_ext(#tok$1^139.3, $s);

  #break_36:
    // (int32_t -> mathint) res_lambda#20#48; 
    assume $local_value_is($s, #tok$1^166.16, #loc.res_lambda#20#48, $map_t..^^i4.^^mathint_to_int(res_lambda#20#48), $map_t(^^i4, ^^mathint));
    // assert @reads_check_normal((h->sh)); 
    assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
    // assert @in_range_u4(+(*(2, p), 2)); 
    assert $in_range_u4($op_mul(2, L#p) + 2);
    // assert @in_range_u4(*(2, p)); 
    assert $in_range_u4($op_mul(2, L#p));
    // assert @reads_check_normal((h->sh)); 
    assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
    // assert @in_range_u4(+(*(2, p), 1)); 
    assert $in_range_u4($op_mul(2, L#p) + 1);
    // assert @in_range_u4(*(2, p)); 
    assert $in_range_u4($op_mul(2, L#p));
    // assert @reads_check_normal((h->heap)[p]); 
    assert $thread_local($s, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p));
    // res_lambda#20#48 := lambda#20(@map_get(*((h->sh)), +(*(2, p), 2)), @map_get(*((h->sh)), +(*(2, p), 1)), *((h->heap)[p])); 
    call res_lambda#20#48 := lambda#20($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $op_mul(2, L#p) + 2), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $op_mul(2, L#p) + 1), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p))));
    assume $full_stop_ext(#tok$1^166.16, $s);
    assume $local_value_is($s, #tok$1^166.16, #loc.res_lambda#20#48, $map_t..^^i4.^^mathint_to_int(res_lambda#20#48), $map_t(^^i4, ^^mathint));
    // assert @prim_writes_check((h->sh)); 
    assert $writable_prim($s, #wrTime$1^81.1, $dot($phys_ptr_cast(P#h, ^Heap), Heap.sh));
    // assert @reads_check_normal((h->sh)); 
    assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
    // *(h->sh) := @map_updated(*((h->sh)), p, res_lambda#20#48); 
    call $write_int(Heap.sh, $phys_ptr_cast(P#h, ^Heap), $map_t..^^u4.map_t..^^i4.^^mathint_to_int($store.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), L#p, res_lambda#20#48)));
    assume $full_stop_ext(#tok$1^166.5, $s);
    // assert @prim_writes_check((h->abs)); 
    assert $writable_prim($s, #wrTime$1^81.1, $dot($phys_ptr_cast(P#h, ^Heap), Heap.abs));
    // assert @reads_check_normal((h->sh)); 
    assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
    // *(h->abs) := @map_get(*((h->sh)), p); 
    call $write_int(Heap.abs, $phys_ptr_cast(P#h, ^Heap), $map_t..^^i4.^^mathint_to_int($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), L#p)));
    assume $full_stop_ext(#tok$1^167.5, $s);
    // _math state_t prestate#62; 
    assume $local_value_is($s, #tok$4^0.0, #loc.prestate#62, $state_to_int(prestate#62), ^$#state_t);
    // prestate#62 := @_vcc_current_state(@state); 
    prestate#62 := $current_state($s);
    assume $local_value_is($s, #tok$4^0.0, #loc.prestate#62, $state_to_int(prestate#62), ^$#state_t);
    // _math state_t staticWrapState#60; 
    assume $local_value_is($s, #tok$4^0.0, #loc.staticWrapState#60, $state_to_int(staticWrapState#60), ^$#state_t);
    // staticWrapState#60 := @_vcc_current_state(@state); 
    staticWrapState#60 := $current_state($s);
    assume $local_value_is($s, #tok$4^0.0, #loc.staticWrapState#60, $state_to_int(staticWrapState#60), ^$#state_t);
    // _math ptrset owns#61; 
    assume $local_value_is($s, #tok$4^0.0, #loc.owns#61, $ptrset_to_int(owns#61), ^$#ptrset);
    // owns#61 := @_vcc_set_empty; 
    owns#61 := $set_empty();
    assume $local_value_is($s, #tok$4^0.0, #loc.owns#61, $ptrset_to_int(owns#61), ^$#ptrset);
    // assert @writes_check(h); 
    assert $top_writable($s, #wrTime$1^81.1, $phys_ptr_cast(P#h, ^Heap));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(h), staticWrapState#60, owns#61)
    call $static_wrap($phys_ptr_cast(P#h, ^Heap), staticWrapState#60, owns#61);
    assume $good_state_ext(#tok$1^169.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, h), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(P#h, ^Heap)), $set_empty());
    // assert @inv_check(@map_eq(@map_get(*((h->sh)), 0), *((h->abs)))); 
    assert $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), 0), $int_to_map_t..^^i4.^^mathint($rd_inv($s, Heap.abs, $phys_ptr_cast(P#h, ^Heap))));
    // assert @inv_check(<=(*((h->len)), 1000)); 
    assert $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) <= 1000;
    // assert @inv_check(forall(uint32_t i; { @map_get(*((h->sh)), mark(i)) } @in_range_u4(i); ==>(&&(!=(i, *((h->len))), <(i, *((h->len)))), @map_eq(@map_get(*((h->sh)), mark(i)), lambda#6(@map_get(*((h->sh)), unchecked+(unchecked*(2, i), 2)), @map_get(*((h->sh)), unchecked+(unchecked*(2, i), 1)), *((h->heap)[i])))))); 
    assert (forall Q#i$1^65.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^65.29#tc1)) } $in_range_u4(Q#i$1^65.29#tc1) ==> Q#i$1^65.29#tc1 != $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) && Q#i$1^65.29#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^65.29#tc1)), F#lambda#6($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 2)), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 1)), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^65.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^65.29#tc1))))));
    // assert @inv_check(forall(uint32_t i; { @map_get(*((h->sh)), mark(i)) } @in_range_u4(i); ==>(>=(i, *((h->len))), @map_eq(@map_get(*((h->sh)), mark(i)), lambda#7())))); 
    assert (forall Q#i$1^66.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^66.29#tc1)) } $in_range_u4(Q#i$1^66.29#tc1) ==> Q#i$1^66.29#tc1 >= $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^66.29#tc1)), F#lambda#7()));
    // assert @inv_check(forall(uint32_t i; int32_t e; { @map_get(@map_get(*((h->sh)), mark(i)), e) } { mark3(i, e) } { @trigger_hint(mark3(i, e)) } &&(@in_range_u4(i), @in_range_i4(e)); ==>(<(i, *((h->len))), >=(@map_get(@map_get(*((h->sh)), mark(i)), e), 0)))); 
    assert (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) >= 0);
    // assert @inv_check(forall(uint32_t i; int32_t e; { @map_get(@map_get(*((h->sh)), mark(i)), e) } { mark3(i, e) } { @trigger_hint(mark3(i, e)) } &&(@in_range_u4(i), @in_range_i4(e)); ==>(<(i, *((h->len))), ==>(!=(i, *((h->len))), ==>(>(@map_get(@map_get(*((h->sh)), i), e), 0), >=(e, *((h->heap)[i]))))))); 
    assert (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> Q#i$1^66.29#tc1 != $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), Q#i$1^66.29#tc1), Q#e$1^66.29#tc2) > 0 ==> Q#e$1^66.29#tc2 >= $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^66.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^66.29#tc1))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure extractMin(P#h: $ptr) returns ($result: int);
  requires $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) > 0;
  requires $wrapped($s, $phys_ptr_cast(P#h, ^Heap), ^Heap);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  ensures $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($rd_inv(old($s), Heap.abs, $phys_ptr_cast(P#h, ^Heap))), $result) > 0;
  ensures (forall Q#e$1^177.27#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($rd_inv(old($s), Heap.abs, $phys_ptr_cast(P#h, ^Heap))), Q#e$1^177.27#tc2) } $in_range_i4(Q#e$1^177.27#tc2) ==> $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($rd_inv(old($s), Heap.abs, $phys_ptr_cast(P#h, ^Heap))), Q#e$1^177.27#tc2) > 0 ==> $result <= Q#e$1^177.27#tc2);
  ensures $eq.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($rd_inv($s, Heap.abs, $phys_ptr_cast(P#h, ^Heap))), F#lambda#34($int_to_map_t..^^i4.^^mathint($rd_inv(old($s), Heap.abs, $phys_ptr_cast(P#h, ^Heap))), $int_to_map_t..^^i4.^^mathint($rd_inv(old($s), Heap.abs, $phys_ptr_cast(P#h, ^Heap))), $result));
  ensures $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) == $rd_inv(old($s), Heap.len, $phys_ptr_cast(P#h, ^Heap)) - 1;
  ensures $wrapped($s, $phys_ptr_cast(P#h, ^Heap), ^Heap);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#h, ^Heap)));
  free ensures $call_transition(old($s), $s);



implementation extractMin(P#h: $ptr) returns ($result: int)
{
  var owns#67: $ptrset;
  var staticWrapState#66: $state;
  var prestate#68: $state;
  var res_lambda#31#52: $map_t..^^i4.^^mathint;
  var L#tmp: int where $in_range_i4(L#tmp);
  var ite#2: bool;
  var ite#1: bool;
  var L#l: int where $in_range_u4(L#l);
  var L#r: int where $in_range_u4(L#r);
  var L#smallest: int where $in_range_u4(L#smallest);
  var #wrTime$1^223.28: int;
  var loopState#3: $state;
  var res_lambda#27#51: $map_t..^^i4.^^mathint;
  var res_lambda#26#50: $map_t..^^i4.^^mathint;
  var #wrTime$1^206.29: int;
  var loopState#2: $state;
  var res_lambda#22#49: $map_t..^^i4.^^mathint;
  var prestate#65: $state;
  var prestate#63: $state;
  var owns#64: $ptrset;
  var L#res: int where $in_range_i4(L#res);
  var L#last: int where $in_range_i4(L#last);
  var L#p: int where $in_range_u4(L#p);
  var #wrTime$1^172.1: int;
  var #stackframe: int;

  anon50:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^172.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^172.1, #loc.h, $ptr_to_int(P#h), $ptr_to(^Heap));
    assume #wrTime$1^172.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^172.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#h, ^Heap)));
    assume $thread_owned($s, $phys_ptr_cast(P#h, ^Heap));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, h, h); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#h, ^Heap), $phys_ptr_cast(P#h, ^Heap), l#public);
    // uint32_t p; 
    assume $local_value_is($s, #tok$1^183.3, #loc.p, L#p, ^^u4);
    // int32_t last; 
    assume $local_value_is($s, #tok$1^182.3, #loc.last, L#last, ^^i4);
    // int32_t res; 
    assume $local_value_is($s, #tok$1^181.3, #loc.res, L#res, ^^i4);
    // var int32_t res
    // var int32_t last
    // var uint32_t p
    // _math ptrset owns#64; 
    assume $local_value_is($s, #tok$4^0.0, #loc.owns#64, $ptrset_to_int(owns#64), ^$#ptrset);
    // owns#64 := @_vcc_set_empty; 
    owns#64 := $set_empty();
    assume $local_value_is($s, #tok$4^0.0, #loc.owns#64, $ptrset_to_int(owns#64), ^$#ptrset);
    // _math state_t prestate#63; 
    assume $local_value_is($s, #tok$4^0.0, #loc.prestate#63, $state_to_int(prestate#63), ^$#state_t);
    // prestate#63 := @_vcc_current_state(@state); 
    prestate#63 := $current_state($s);
    assume $local_value_is($s, #tok$4^0.0, #loc.prestate#63, $state_to_int(prestate#63), ^$#state_t);
    // _math state_t prestate#65; 
    assume $local_value_is($s, #tok$4^0.0, #loc.prestate#65, $state_to_int(prestate#65), ^$#state_t);
    // prestate#65 := @_vcc_current_state(@state); 
    prestate#65 := $current_state($s);
    assume $local_value_is($s, #tok$4^0.0, #loc.prestate#65, $state_to_int(prestate#65), ^$#state_t);
    // assert @_vcc_wrapped(@state, h); 
    assert $wrapped($s, $phys_ptr_cast(P#h, ^Heap), ^Heap);
    // assert @writes_check(h); 
    assert $top_writable($s, #wrTime$1^172.1, $phys_ptr_cast(P#h, ^Heap));
    // assume @_vcc_inv(@state, h); 
    assume $inv($s, $phys_ptr_cast(P#h, ^Heap), ^Heap);
    // assume ==(owns#64, @_vcc_owns(@state, h)); 
    assume owns#64 == $owns($s, $phys_ptr_cast(P#h, ^Heap));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(h), prestate#65)
    call $static_unwrap($phys_ptr_cast(P#h, ^Heap), prestate#65);
    assume $good_state_ext(#tok$1^185.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @reads_check_normal((h->heap)[0]); 
    assert $thread_local($s, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), 0));
    // res := *((h->heap)[0]); 
    L#res := $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), 0)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), 0)));
    assume $local_value_is($s, #tok$1^186.3, #loc.res, L#res, ^^i4);
    // assert mark3(0, 0); 
    assert F#mark3(0, 0);
    // assume mark3(0, 0); 
    assume F#mark3(0, 0);
    // assert forall(int32_t e; @in_range_i4(e); ==>(>(@map_get(old(@prestate, *((h->abs))), e), 0), <=(res, e))); 
    assert (forall Q#e$1^188.26#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($rd_inv(old($s), Heap.abs, $phys_ptr_cast(P#h, ^Heap))), Q#e$1^188.26#tc2) } $in_range_i4(Q#e$1^188.26#tc2) ==> $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($rd_inv(old($s), Heap.abs, $phys_ptr_cast(P#h, ^Heap))), Q#e$1^188.26#tc2) > 0 ==> L#res <= Q#e$1^188.26#tc2);
    // assume forall(int32_t e; @in_range_i4(e); ==>(>(@map_get(old(@prestate, *((h->abs))), e), 0), <=(res, e))); 
    assume (forall Q#e$1^188.26#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($rd_inv(old($s), Heap.abs, $phys_ptr_cast(P#h, ^Heap))), Q#e$1^188.26#tc2) } $in_range_i4(Q#e$1^188.26#tc2) ==> $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($rd_inv(old($s), Heap.abs, $phys_ptr_cast(P#h, ^Heap))), Q#e$1^188.26#tc2) > 0 ==> L#res <= Q#e$1^188.26#tc2);
    // assert @prim_writes_check((h->len)); 
    assert $writable_prim($s, #wrTime$1^172.1, $dot($phys_ptr_cast(P#h, ^Heap), Heap.len));
    // assert @in_range_u4(-(*((h->len)), 1)); 
    assert $in_range_u4($rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) - 1);
    // assert @reads_check_normal((h->len)); 
    assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
    // *(h->len) := -(*((h->len)), 1); 
    call $write_int(Heap.len, $phys_ptr_cast(P#h, ^Heap), $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) - 1);
    assume $full_stop_ext(#tok$1^189.3, $s);
    // assert @reads_check_normal((h->len)); 
    assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
    // p := *((h->len)); 
    L#p := $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap));
    assume $local_value_is($s, #tok$1^191.3, #loc.p, L#p, ^^u4);
    // assert mark3(p, 0); 
    assert F#mark3(L#p, 0);
    // assume mark3(p, 0); 
    assume F#mark3(L#p, 0);
    // assert @reads_check_normal((h->heap)[p]); 
    assert $thread_local($s, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p));
    // last := *((h->heap)[p]); 
    L#last := $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)));
    assume $local_value_is($s, #tok$1^193.3, #loc.last, L#last, ^^i4);
    // assert ==(@map_get(@map_get(*((h->sh)), p), last), 1); 
    assert $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), L#p), L#last) == 1;
    // assume ==(@map_get(@map_get(*((h->sh)), p), last), 1); 
    assume $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), L#p), L#last) == 1;
    // (int32_t -> mathint) res_lambda#22#49; 
    assume $local_value_is($s, #tok$1^195.36, #loc.res_lambda#22#49, $map_t..^^i4.^^mathint_to_int(res_lambda#22#49), $map_t(^^i4, ^^mathint));
    // res_lambda#22#49 := lambda#22(); 
    call res_lambda#22#49 := lambda#22();
    assume $full_stop_ext(#tok$1^195.36, $s);
    assume $local_value_is($s, #tok$1^195.36, #loc.res_lambda#22#49, $map_t..^^i4.^^mathint_to_int(res_lambda#22#49), $map_t(^^i4, ^^mathint));
    // assert @prim_writes_check((h->sh)); 
    assert $writable_prim($s, #wrTime$1^172.1, $dot($phys_ptr_cast(P#h, ^Heap), Heap.sh));
    // assert @reads_check_normal((h->sh)); 
    assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
    // *(h->sh) := @map_updated(*((h->sh)), p, res_lambda#22#49); 
    call $write_int(Heap.sh, $phys_ptr_cast(P#h, ^Heap), $map_t..^^u4.map_t..^^i4.^^mathint_to_int($store.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), L#p, res_lambda#22#49)));
    assume $full_stop_ext(#tok$1^195.25, $s);
    assume true;
    // if (==(p, 0)) ...
    if (L#p == 0)
    {
      anon28:
        // goto end; 
        goto end;
    }
    else
    {
      anon29:
        // empty
    }

  anon51:
    // assert !=(2, 0); 
    assert 2 != 0;
    // assert @in_range_u4(-(p, 1)); 
    assert $in_range_u4(L#p - 1);
    // p := /(-(p, 1), 2); 
    L#p := (L#p - 1) / 2;
    assume $local_value_is($s, #tok$1^199.3, #loc.p, L#p, ^^u4);
    // assert mark3(p, 0); 
    assert F#mark3(L#p, 0);
    // assume mark3(p, 0); 
    assume F#mark3(L#p, 0);
    call $bump_timestamp();
    assume $full_stop_ext(#tok$1^206.29, $s);
    loopState#2 := $s;
    assume #wrTime$1^206.29 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^206.29, (lambda #p: $ptr :: #p == $dot($phys_ptr_cast(P#h, ^Heap), Heap.sh)));
    assert (forall #loopWrites^$1^206.29: $ptr :: { $dont_instantiate(#loopWrites^$1^206.29) } $listed_in_writes($s, #wrTime$1^206.29, #loopWrites^$1^206.29) ==> $top_writable($s, #wrTime$1^172.1, #loopWrites^$1^206.29));
    while (true)
      invariant $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv(loopState#2, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), 0), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), 0));
      invariant L#p < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap));
      invariant (forall Q#i$1^205.31#tc1: int :: {:weight 10} { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^205.31#tc1)) } $in_range_u4(Q#i$1^205.31#tc1) ==> Q#i$1^205.31#tc1 >= $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^205.31#tc1)), F#lambda#23()));
      invariant (forall Q#i$1^205.31#tc1: int, Q#e$1^205.31#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^205.31#tc1)), Q#e$1^205.31#tc2) } { F#mark3(Q#i$1^205.31#tc1, Q#e$1^205.31#tc2) } { sk_hack(F#mark3(Q#i$1^205.31#tc1, Q#e$1^205.31#tc2)) } $in_range_u4(Q#i$1^205.31#tc1) && $in_range_i4(Q#e$1^205.31#tc2) ==> Q#i$1^205.31#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^205.31#tc1)), Q#e$1^205.31#tc2) >= 0);
      invariant (forall Q#i$1^205.31#tc1: int, Q#e$1^205.31#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^205.31#tc1)), Q#e$1^205.31#tc2) } { F#mark3(Q#i$1^205.31#tc1, Q#e$1^205.31#tc2) } { sk_hack(F#mark3(Q#i$1^205.31#tc1, Q#e$1^205.31#tc2)) } $in_range_u4(Q#i$1^205.31#tc1) && $in_range_i4(Q#e$1^205.31#tc2) ==> Q#i$1^205.31#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> Q#i$1^205.31#tc1 != $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), Q#i$1^205.31#tc1), Q#e$1^205.31#tc2) > 0 ==> Q#e$1^205.31#tc2 >= $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^205.31#tc1)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^205.31#tc1))));
      invariant (forall Q#i$1^207.31#tc1: int :: {:weight 10} { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^207.31#tc1)) } $in_range_u4(Q#i$1^207.31#tc1) ==> Q#i$1^207.31#tc1 != L#p && Q#i$1^207.31#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^207.31#tc1)), F#lambda#24($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^207.31#tc1), 2)), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^207.31#tc1), 1)), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^207.31#tc1)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^207.31#tc1))))));
      invariant $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), L#p), F#lambda#25($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $op_mul(2, L#p) + 2), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $op_mul(2, L#p) + 1), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p))), L#last));
    {
      anon32:
        assume $modifies(loopState#2, $s, (lambda #p: $ptr :: #p == $dot($phys_ptr_cast(P#h, ^Heap), Heap.sh)));
        assume $timestamp_post(loopState#2, $s);
        assume $full_stop_ext(#tok$1^202.3, $s);
        assume $local_value_is($s, #tok$1^202.3, #loc.res_lambda#22#49, $map_t..^^i4.^^mathint_to_int(res_lambda#22#49), $map_t(^^i4, ^^mathint));
        assume $local_value_is($s, #tok$1^202.3, #loc.prestate#65, $state_to_int(prestate#65), ^$#state_t);
        assume $local_value_is($s, #tok$1^202.3, #loc.prestate#63, $state_to_int(prestate#63), ^$#state_t);
        assume $local_value_is($s, #tok$1^202.3, #loc.owns#64, $ptrset_to_int(owns#64), ^$#ptrset);
        assume $local_value_is($s, #tok$1^202.3, #loc.res, L#res, ^^i4);
        assume $local_value_is($s, #tok$1^202.3, #loc.last, L#last, ^^i4);
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#2, $s);
        assume true;
        // if (>(p, 0)) ...
        if (L#p > 0)
        {
          anon30:
            // assert mark3(p, 0); 
            assert F#mark3(L#p, 0);
            // assume mark3(p, 0); 
            assume F#mark3(L#p, 0);
            // assert mark3(/(-(p, 1), 2), 0); 
            assert F#mark3((L#p - 1) / 2, 0);
            // assume mark3(/(-(p, 1), 2), 0); 
            assume F#mark3((L#p - 1) / 2, 0);
            // (int32_t -> mathint) res_lambda#26#50; 
            assume $local_value_is($s, #tok$1^212.38, #loc.res_lambda#26#50, $map_t..^^i4.^^mathint_to_int(res_lambda#26#50), $map_t(^^i4, ^^mathint));
            // assert @reads_check_normal((h->sh)); 
            assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
            // assert @in_range_u4(+(*(2, p), 2)); 
            assert $in_range_u4($op_mul(2, L#p) + 2);
            // assert @in_range_u4(*(2, p)); 
            assert $in_range_u4($op_mul(2, L#p));
            // assert @reads_check_normal((h->sh)); 
            assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
            // assert @in_range_u4(+(*(2, p), 1)); 
            assert $in_range_u4($op_mul(2, L#p) + 1);
            // assert @in_range_u4(*(2, p)); 
            assert $in_range_u4($op_mul(2, L#p));
            // assert @reads_check_normal((h->heap)[p]); 
            assert $thread_local($s, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p));
            // res_lambda#26#50 := lambda#26(@map_get(*((h->sh)), +(*(2, p), 2)), @map_get(*((h->sh)), +(*(2, p), 1)), *((h->heap)[p])); 
            call res_lambda#26#50 := lambda#26($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $op_mul(2, L#p) + 2), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $op_mul(2, L#p) + 1), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p))));
            assume $full_stop_ext(#tok$1^212.38, $s);
            assume $local_value_is($s, #tok$1^212.38, #loc.res_lambda#26#50, $map_t..^^i4.^^mathint_to_int(res_lambda#26#50), $map_t(^^i4, ^^mathint));
            // assert @prim_writes_check((h->sh)); 
            assert $writable_prim($s, #wrTime$1^206.29, $dot($phys_ptr_cast(P#h, ^Heap), Heap.sh));
            // assert @reads_check_normal((h->sh)); 
            assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
            // *(h->sh) := @map_updated(*((h->sh)), p, res_lambda#26#50); 
            call $write_int(Heap.sh, $phys_ptr_cast(P#h, ^Heap), $map_t..^^u4.map_t..^^i4.^^mathint_to_int($store.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), L#p, res_lambda#26#50)));
            assume $full_stop_ext(#tok$1^212.27, $s);
            // assert !=(2, 0); 
            assert 2 != 0;
            // assert @in_range_u4(-(p, 1)); 
            assert $in_range_u4(L#p - 1);
            // p := /(-(p, 1), 2); 
            L#p := (L#p - 1) / 2;
            assume $local_value_is($s, #tok$1^213.5, #loc.p, L#p, ^^u4);
        }
        else
        {
          anon31:
            // goto #break_37; 
            goto #break_37;
        }

      #continue_37:
        assume true;
    }

  anon52:
    assume $full_stop_ext(#tok$1^202.3, $s);

  #break_37:
    // assert @prim_writes_check((h->heap)[0]); 
    assert $writable_prim($s, #wrTime$1^172.1, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), 0));
    // assert @reads_check_normal((h->heap)[*((h->len))]); 
    assert $thread_local($s, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap))));
    // assert @reads_check_normal((h->len)); 
    assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
    // *(h->heap)[0] := *((h->heap)[*((h->len))]); 
    call $write_int($field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), 0)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), 0)), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)))), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap))))));
    assume $full_stop_ext(#tok$1^216.3, $s);
    // (int32_t -> mathint) res_lambda#27#51; 
    assume $local_value_is($s, #tok$1^217.36, #loc.res_lambda#27#51, $map_t..^^i4.^^mathint_to_int(res_lambda#27#51), $map_t(^^i4, ^^mathint));
    // assert @reads_check_normal((h->sh)); 
    assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
    // assert @in_range_u4(+(*(2, p), 2)); 
    assert $in_range_u4($op_mul(2, L#p) + 2);
    // assert @in_range_u4(*(2, p)); 
    assert $in_range_u4($op_mul(2, L#p));
    // assert @reads_check_normal((h->sh)); 
    assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
    // assert @in_range_u4(+(*(2, p), 1)); 
    assert $in_range_u4($op_mul(2, L#p) + 1);
    // assert @in_range_u4(*(2, p)); 
    assert $in_range_u4($op_mul(2, L#p));
    // assert @reads_check_normal((h->heap)[p]); 
    assert $thread_local($s, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p));
    // res_lambda#27#51 := lambda#27(@map_get(*((h->sh)), +(*(2, p), 2)), @map_get(*((h->sh)), +(*(2, p), 1)), *((h->heap)[p])); 
    call res_lambda#27#51 := lambda#27($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $op_mul(2, L#p) + 2), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $op_mul(2, L#p) + 1), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p))));
    assume $full_stop_ext(#tok$1^217.36, $s);
    assume $local_value_is($s, #tok$1^217.36, #loc.res_lambda#27#51, $map_t..^^i4.^^mathint_to_int(res_lambda#27#51), $map_t(^^i4, ^^mathint));
    // assert @prim_writes_check((h->sh)); 
    assert $writable_prim($s, #wrTime$1^172.1, $dot($phys_ptr_cast(P#h, ^Heap), Heap.sh));
    // assert @reads_check_normal((h->sh)); 
    assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
    // *(h->sh) := @map_updated(*((h->sh)), 0, res_lambda#27#51); 
    call $write_int(Heap.sh, $phys_ptr_cast(P#h, ^Heap), $map_t..^^u4.map_t..^^i4.^^mathint_to_int($store.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), 0, res_lambda#27#51)));
    assume $full_stop_ext(#tok$1^217.25, $s);
    // p := 0; 
    L#p := 0;
    assume $local_value_is($s, #tok$1^219.3, #loc.p, L#p, ^^u4);
    call $bump_timestamp();
    assume $full_stop_ext(#tok$1^223.28, $s);
    loopState#3 := $s;
    assume #wrTime$1^223.28 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^223.28, (lambda #p: $ptr :: $set_in(#p, $span($phys_ptr_cast(P#h, ^Heap)))));
    assert (forall #loopWrites^$1^223.28: $ptr :: { $dont_instantiate(#loopWrites^$1^223.28) } $listed_in_writes($s, #wrTime$1^223.28, #loopWrites^$1^223.28) ==> $top_writable($s, #wrTime$1^172.1, #loopWrites^$1^223.28));
    while (true)
      invariant $rd_inv(loopState#3, Heap.len, $phys_ptr_cast(P#h, ^Heap)) == $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap));
      invariant $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), 0), F#lambda#28($int_to_map_t..^^i4.^^mathint($rd_inv(loopState#3, Heap.abs, $phys_ptr_cast(P#h, ^Heap))), $int_to_map_t..^^i4.^^mathint($rd_inv(loopState#3, Heap.abs, $phys_ptr_cast(P#h, ^Heap))), L#res));
      invariant (forall Q#i$1^224.31#tc1: int :: {:weight 10} { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^224.31#tc1)) } $in_range_u4(Q#i$1^224.31#tc1) ==> Q#i$1^224.31#tc1 >= $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^224.31#tc1)), F#lambda#29()));
      invariant (forall Q#i$1^224.31#tc1: int, Q#e$1^224.31#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^224.31#tc1)), Q#e$1^224.31#tc2) } { F#mark3(Q#i$1^224.31#tc1, Q#e$1^224.31#tc2) } { sk_hack(F#mark3(Q#i$1^224.31#tc1, Q#e$1^224.31#tc2)) } $in_range_u4(Q#i$1^224.31#tc1) && $in_range_i4(Q#e$1^224.31#tc2) ==> Q#i$1^224.31#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^224.31#tc1)), Q#e$1^224.31#tc2) >= 0);
      invariant (forall Q#i$1^224.31#tc1: int, Q#e$1^224.31#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^224.31#tc1)), Q#e$1^224.31#tc2) } { F#mark3(Q#i$1^224.31#tc1, Q#e$1^224.31#tc2) } { sk_hack(F#mark3(Q#i$1^224.31#tc1, Q#e$1^224.31#tc2)) } $in_range_u4(Q#i$1^224.31#tc1) && $in_range_i4(Q#e$1^224.31#tc2) ==> Q#i$1^224.31#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> Q#i$1^224.31#tc1 != L#p ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), Q#i$1^224.31#tc1), Q#e$1^224.31#tc2) > 0 ==> Q#e$1^224.31#tc2 >= $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^224.31#tc1)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^224.31#tc1))));
      invariant (forall Q#i$1^225.31#tc1: int :: {:weight 10} { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^225.31#tc1)) } $in_range_u4(Q#i$1^225.31#tc1) ==> Q#i$1^225.31#tc1 != $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) && Q#i$1^225.31#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^225.31#tc1)), F#lambda#30($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^225.31#tc1), 2)), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^225.31#tc1), 1)), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^225.31#tc1)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^225.31#tc1))))));
    {
      anon49:
        assume $modifies(loopState#3, $s, (lambda #p: $ptr :: $set_in(#p, $span($phys_ptr_cast(P#h, ^Heap)))));
        assume $timestamp_post(loopState#3, $s);
        assume $full_stop_ext(#tok$1^220.3, $s);
        assume $local_value_is($s, #tok$1^220.3, #loc.res_lambda#27#51, $map_t..^^i4.^^mathint_to_int(res_lambda#27#51), $map_t(^^i4, ^^mathint));
        assume $local_value_is($s, #tok$1^220.3, #loc.res_lambda#26#50, $map_t..^^i4.^^mathint_to_int(res_lambda#26#50), $map_t(^^i4, ^^mathint));
        assume $local_value_is($s, #tok$1^220.3, #loc.res_lambda#22#49, $map_t..^^i4.^^mathint_to_int(res_lambda#22#49), $map_t(^^i4, ^^mathint));
        assume $local_value_is($s, #tok$1^220.3, #loc.prestate#65, $state_to_int(prestate#65), ^$#state_t);
        assume $local_value_is($s, #tok$1^220.3, #loc.prestate#63, $state_to_int(prestate#63), ^$#state_t);
        assume $local_value_is($s, #tok$1^220.3, #loc.owns#64, $ptrset_to_int(owns#64), ^$#ptrset);
        assume $local_value_is($s, #tok$1^220.3, #loc.res, L#res, ^^i4);
        assume $local_value_is($s, #tok$1^220.3, #loc.last, L#last, ^^i4);
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#3, $s);
        // assert @reads_check_normal((h->len)); 
        assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
        assume true;
        // if (<(p, *((h->len)))) ...
        if (L#p < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)))
        {
          anon43:
            // uint32_t smallest; 
            assume $local_value_is($s, #tok$1^228.5, #loc.smallest, L#smallest, ^^u4);
            // uint32_t r; 
            assume $local_value_is($s, #tok$1^227.5, #loc.r, L#r, ^^u4);
            // uint32_t l; 
            assume $local_value_is($s, #tok$1^227.5, #loc.l, L#l, ^^u4);
            // assert @in_range_u4(+(*(2, p), 1)); 
            assert $in_range_u4($op_mul(2, L#p) + 1);
            // assert @in_range_u4(*(2, p)); 
            assert $in_range_u4($op_mul(2, L#p));
            // l := +(*(2, p), 1); 
            L#l := $op_mul(2, L#p) + 1;
            assume $local_value_is($s, #tok$1^227.5, #loc.l, L#l, ^^u4);
            // assert @in_range_u4(+(*(2, p), 2)); 
            assert $in_range_u4($op_mul(2, L#p) + 2);
            // assert @in_range_u4(*(2, p)); 
            assert $in_range_u4($op_mul(2, L#p));
            // r := +(*(2, p), 2); 
            L#r := $op_mul(2, L#p) + 2;
            assume $local_value_is($s, #tok$1^227.5, #loc.r, L#r, ^^u4);
            // smallest := p; 
            L#smallest := L#p;
            assume $local_value_is($s, #tok$1^228.5, #loc.smallest, L#smallest, ^^u4);
            // _Bool ite#1; 
            assume $local_value_is($s, #tok$1^229.9, #loc.ite#1, $bool_to_int(ite#1), ^^bool);
            // assert @reads_check_normal((h->len)); 
            assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
            assume true;
            // if (<(l, *((h->len)))) ...
            if (L#l < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)))
            {
              anon33:
                // assert @reads_check_normal((h->heap)[l]); 
                assert $thread_local($s, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#l));
                // assert @reads_check_normal((h->heap)[p]); 
                assert $thread_local($s, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p));
                // ite#1 := <(*((h->heap)[l]), *((h->heap)[p])); 
                ite#1 := $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#l)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#l))) < $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)));
                assume $local_value_is($s, #tok$1^229.9, #loc.ite#1, $bool_to_int(ite#1), ^^bool);
            }
            else
            {
              anon34:
                // ite#1 := false; 
                ite#1 := false;
                assume $local_value_is($s, #tok$1^229.9, #loc.ite#1, $bool_to_int(ite#1), ^^bool);
            }

          anon44:
            assume true;
            // if (ite#1) ...
            if (ite#1)
            {
              anon35:
                // smallest := l; 
                L#smallest := L#l;
                assume $local_value_is($s, #tok$1^230.7, #loc.smallest, L#smallest, ^^u4);
            }
            else
            {
              anon36:
                // empty
            }

          anon45:
            // _Bool ite#2; 
            assume $local_value_is($s, #tok$1^231.9, #loc.ite#2, $bool_to_int(ite#2), ^^bool);
            // assert @reads_check_normal((h->len)); 
            assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
            assume true;
            // if (<(r, *((h->len)))) ...
            if (L#r < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)))
            {
              anon37:
                // assert @reads_check_normal((h->heap)[r]); 
                assert $thread_local($s, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#r));
                // assert @reads_check_normal((h->heap)[smallest]); 
                assert $thread_local($s, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#smallest));
                // ite#2 := <(*((h->heap)[r]), *((h->heap)[smallest])); 
                ite#2 := $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#r)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#r))) < $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#smallest)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#smallest)));
                assume $local_value_is($s, #tok$1^231.9, #loc.ite#2, $bool_to_int(ite#2), ^^bool);
            }
            else
            {
              anon38:
                // ite#2 := false; 
                ite#2 := false;
                assume $local_value_is($s, #tok$1^231.9, #loc.ite#2, $bool_to_int(ite#2), ^^bool);
            }

          anon46:
            assume true;
            // if (ite#2) ...
            if (ite#2)
            {
              anon39:
                // smallest := r; 
                L#smallest := L#r;
                assume $local_value_is($s, #tok$1^232.7, #loc.smallest, L#smallest, ^^u4);
            }
            else
            {
              anon40:
                // empty
            }

          anon47:
            assume true;
            // if (!=(smallest, p)) ...
            if (L#smallest != L#p)
            {
              anon41:
                // int32_t tmp; 
                assume $local_value_is($s, #tok$1^234.7, #loc.tmp, L#tmp, ^^i4);
                // var int32_t tmp
                // assert @reads_check_normal((h->heap)[p]); 
                assert $thread_local($s, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p));
                // tmp := *((h->heap)[p]); 
                L#tmp := $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)));
                assume $local_value_is($s, #tok$1^235.7, #loc.tmp, L#tmp, ^^i4);
                // assert @prim_writes_check((h->heap)[p]); 
                assert $writable_prim($s, #wrTime$1^223.28, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p));
                // assert @reads_check_normal((h->heap)[smallest]); 
                assert $thread_local($s, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#smallest));
                // *(h->heap)[p] := *((h->heap)[smallest]); 
                call $write_int($field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#p)), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#smallest)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#smallest))));
                assume $full_stop_ext(#tok$1^236.7, $s);
                // assert @prim_writes_check((h->heap)[smallest]); 
                assert $writable_prim($s, #wrTime$1^223.28, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#smallest));
                // *(h->heap)[smallest] := tmp; 
                call $write_int($field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#smallest)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#smallest)), L#tmp);
                assume $full_stop_ext(#tok$1^237.7, $s);
                // assert mark3(smallest, 0); 
                assert F#mark3(L#smallest, 0);
                // assume mark3(smallest, 0); 
                assume F#mark3(L#smallest, 0);
                // assert mark3(p, 0); 
                assert F#mark3(L#p, 0);
                // assume mark3(p, 0); 
                assume F#mark3(L#p, 0);
                // (int32_t -> mathint) res_lambda#31#52; 
                assume $local_value_is($s, #tok$1^240.47, #loc.res_lambda#31#52, $map_t..^^i4.^^mathint_to_int(res_lambda#31#52), $map_t(^^i4, ^^mathint));
                // assert @reads_check_normal((h->sh)); 
                assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
                // assert @in_range_u4(+(*(2, smallest), 2)); 
                assert $in_range_u4($op_mul(2, L#smallest) + 2);
                // assert @in_range_u4(*(2, smallest)); 
                assert $in_range_u4($op_mul(2, L#smallest));
                // assert @reads_check_normal((h->sh)); 
                assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
                // assert @in_range_u4(+(*(2, smallest), 1)); 
                assert $in_range_u4($op_mul(2, L#smallest) + 1);
                // assert @in_range_u4(*(2, smallest)); 
                assert $in_range_u4($op_mul(2, L#smallest));
                // assert @reads_check_normal((h->heap)[smallest]); 
                assert $thread_local($s, $idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#smallest));
                // res_lambda#31#52 := lambda#31(@map_get(*((h->sh)), +(*(2, smallest), 2)), @map_get(*((h->sh)), +(*(2, smallest), 1)), *((h->heap)[smallest])); 
                call res_lambda#31#52 := lambda#31($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $op_mul(2, L#smallest) + 2), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $op_mul(2, L#smallest) + 1), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#smallest)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), L#smallest))));
                assume $full_stop_ext(#tok$1^240.47, $s);
                assume $local_value_is($s, #tok$1^240.47, #loc.res_lambda#31#52, $map_t..^^i4.^^mathint_to_int(res_lambda#31#52), $map_t(^^i4, ^^mathint));
                // assert @prim_writes_check((h->sh)); 
                assert $writable_prim($s, #wrTime$1^223.28, $dot($phys_ptr_cast(P#h, ^Heap), Heap.sh));
                // assert @reads_check_normal((h->sh)); 
                assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
                // *(h->sh) := @map_updated(*((h->sh)), smallest, res_lambda#31#52); 
                call $write_int(Heap.sh, $phys_ptr_cast(P#h, ^Heap), $map_t..^^u4.map_t..^^i4.^^mathint_to_int($store.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), L#smallest, res_lambda#31#52)));
                assume $full_stop_ext(#tok$1^240.29, $s);
                // p := smallest; 
                L#p := L#smallest;
                assume $local_value_is($s, #tok$1^241.7, #loc.p, L#p, ^^u4);
            }
            else
            {
              anon42:
                // assert forall(uint32_t i; { @map_get(*((h->sh)), mark(i)) } @in_range_u4(i); ==>(>=(i, *((h->len))), @map_eq(@map_get(*((h->sh)), mark(i)), lambda#32()))); 
                assert (forall Q#i$1^244.30#tc1: int :: {:weight 10} { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^244.30#tc1)) } $in_range_u4(Q#i$1^244.30#tc1) ==> Q#i$1^244.30#tc1 >= $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^244.30#tc1)), F#lambda#32()));
                // assert forall(uint32_t i; int32_t e; { @map_get(@map_get(*((h->sh)), mark(i)), e) } { mark3(i, e) } { @trigger_hint(mark3(i, e)) } &&(@in_range_u4(i), @in_range_i4(e)); ==>(<(i, *((h->len))), >=(@map_get(@map_get(*((h->sh)), mark(i)), e), 0))); 
                assert (forall Q#i$1^244.30#tc1: int, Q#e$1^244.30#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^244.30#tc1)), Q#e$1^244.30#tc2) } { F#mark3(Q#i$1^244.30#tc1, Q#e$1^244.30#tc2) } { sk_hack(F#mark3(Q#i$1^244.30#tc1, Q#e$1^244.30#tc2)) } $in_range_u4(Q#i$1^244.30#tc1) && $in_range_i4(Q#e$1^244.30#tc2) ==> Q#i$1^244.30#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^244.30#tc1)), Q#e$1^244.30#tc2) >= 0);
                // assert forall(uint32_t i; int32_t e; { @map_get(@map_get(*((h->sh)), mark(i)), e) } { mark3(i, e) } { @trigger_hint(mark3(i, e)) } &&(@in_range_u4(i), @in_range_i4(e)); ==>(<(i, *((h->len))), ==>(!=(i, *((h->len))), ==>(>(@map_get(@map_get(*((h->sh)), i), e), 0), >=(e, *((h->heap)[i])))))); 
                assert (forall Q#i$1^244.30#tc1: int, Q#e$1^244.30#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^244.30#tc1)), Q#e$1^244.30#tc2) } { F#mark3(Q#i$1^244.30#tc1, Q#e$1^244.30#tc2) } { sk_hack(F#mark3(Q#i$1^244.30#tc1, Q#e$1^244.30#tc2)) } $in_range_u4(Q#i$1^244.30#tc1) && $in_range_i4(Q#e$1^244.30#tc2) ==> Q#i$1^244.30#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> Q#i$1^244.30#tc1 != $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), Q#i$1^244.30#tc1), Q#e$1^244.30#tc2) > 0 ==> Q#e$1^244.30#tc2 >= $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^244.30#tc1)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^244.30#tc1))));
                // assume &&(forall(uint32_t i; { @map_get(*((h->sh)), mark(i)) } @in_range_u4(i); ==>(>=(i, *((h->len))), @map_eq(@map_get(*((h->sh)), mark(i)), lambda#33()))), &&(forall(uint32_t i; int32_t e; { @map_get(@map_get(*((h->sh)), mark(i)), e) } { mark3(i, e) } { @trigger_hint(mark3(i, e)) } &&(@in_range_u4(i), @in_range_i4(e)); ==>(<(i, *((h->len))), >=(@map_get(@map_get(*((h->sh)), mark(i)), e), 0))), forall(uint32_t i; int32_t e; { @map_get(@map_get(*((h->sh)), mark(i)), e) } { mark3(i, e) } { @trigger_hint(mark3(i, e)) } &&(@in_range_u4(i), @in_range_i4(e)); ==>(<(i, *((h->len))), ==>(!=(i, *((h->len))), ==>(>(@map_get(@map_get(*((h->sh)), i), e), 0), >=(e, *((h->heap)[i])))))))); 
                assume (forall Q#i$1^244.30#tc1: int :: {:weight 10} { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^244.30#tc1)) } $in_range_u4(Q#i$1^244.30#tc1) ==> Q#i$1^244.30#tc1 >= $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^244.30#tc1)), F#lambda#33())) && (forall Q#i$1^244.30#tc1: int, Q#e$1^244.30#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^244.30#tc1)), Q#e$1^244.30#tc2) } { F#mark3(Q#i$1^244.30#tc1, Q#e$1^244.30#tc2) } { sk_hack(F#mark3(Q#i$1^244.30#tc1, Q#e$1^244.30#tc2)) } $in_range_u4(Q#i$1^244.30#tc1) && $in_range_i4(Q#e$1^244.30#tc2) ==> Q#i$1^244.30#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^244.30#tc1)), Q#e$1^244.30#tc2) >= 0) && (forall Q#i$1^244.30#tc1: int, Q#e$1^244.30#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^244.30#tc1)), Q#e$1^244.30#tc2) } { F#mark3(Q#i$1^244.30#tc1, Q#e$1^244.30#tc2) } { sk_hack(F#mark3(Q#i$1^244.30#tc1, Q#e$1^244.30#tc2)) } $in_range_u4(Q#i$1^244.30#tc1) && $in_range_i4(Q#e$1^244.30#tc2) ==> Q#i$1^244.30#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> Q#i$1^244.30#tc1 != $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), Q#i$1^244.30#tc1), Q#e$1^244.30#tc2) > 0 ==> Q#e$1^244.30#tc2 >= $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^244.30#tc1)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^244.30#tc1))));
                // goto #break_38; 
                goto #break_38;
            }
        }
        else
        {
          anon48:
            // goto #break_38; 
            goto #break_38;
        }

      #continue_38:
        assume true;
    }

  anon53:
    assume $full_stop_ext(#tok$1^220.3, $s);

  #break_38:

  end:
    // assert @prim_writes_check((h->abs)); 
    assert $writable_prim($s, #wrTime$1^172.1, $dot($phys_ptr_cast(P#h, ^Heap), Heap.abs));
    // assert @reads_check_normal((h->sh)); 
    assert $thread_local($s, $phys_ptr_cast(P#h, ^Heap));
    // *(h->abs) := @map_get(*((h->sh)), 0); 
    call $write_int(Heap.abs, $phys_ptr_cast(P#h, ^Heap), $map_t..^^i4.^^mathint_to_int($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), 0)));
    assume $full_stop_ext(#tok$1^250.25, $s);
    // _math state_t prestate#68; 
    assume $local_value_is($s, #tok$4^0.0, #loc.prestate#68, $state_to_int(prestate#68), ^$#state_t);
    // prestate#68 := @_vcc_current_state(@state); 
    prestate#68 := $current_state($s);
    assume $local_value_is($s, #tok$4^0.0, #loc.prestate#68, $state_to_int(prestate#68), ^$#state_t);
    // _math state_t staticWrapState#66; 
    assume $local_value_is($s, #tok$4^0.0, #loc.staticWrapState#66, $state_to_int(staticWrapState#66), ^$#state_t);
    // staticWrapState#66 := @_vcc_current_state(@state); 
    staticWrapState#66 := $current_state($s);
    assume $local_value_is($s, #tok$4^0.0, #loc.staticWrapState#66, $state_to_int(staticWrapState#66), ^$#state_t);
    // _math ptrset owns#67; 
    assume $local_value_is($s, #tok$4^0.0, #loc.owns#67, $ptrset_to_int(owns#67), ^$#ptrset);
    // owns#67 := @_vcc_set_empty; 
    owns#67 := $set_empty();
    assume $local_value_is($s, #tok$4^0.0, #loc.owns#67, $ptrset_to_int(owns#67), ^$#ptrset);
    // assert @writes_check(h); 
    assert $top_writable($s, #wrTime$1^172.1, $phys_ptr_cast(P#h, ^Heap));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(h), staticWrapState#66, owns#67)
    call $static_wrap($phys_ptr_cast(P#h, ^Heap), staticWrapState#66, owns#67);
    assume $good_state_ext(#tok$1^251.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, h), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(P#h, ^Heap)), $set_empty());
    // assert @inv_check(@map_eq(@map_get(*((h->sh)), 0), *((h->abs)))); 
    assert $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), 0), $int_to_map_t..^^i4.^^mathint($rd_inv($s, Heap.abs, $phys_ptr_cast(P#h, ^Heap))));
    // assert @inv_check(<=(*((h->len)), 1000)); 
    assert $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) <= 1000;
    // assert @inv_check(forall(uint32_t i; { @map_get(*((h->sh)), mark(i)) } @in_range_u4(i); ==>(&&(!=(i, *((h->len))), <(i, *((h->len)))), @map_eq(@map_get(*((h->sh)), mark(i)), lambda#6(@map_get(*((h->sh)), unchecked+(unchecked*(2, i), 2)), @map_get(*((h->sh)), unchecked+(unchecked*(2, i), 1)), *((h->heap)[i])))))); 
    assert (forall Q#i$1^65.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^65.29#tc1)) } $in_range_u4(Q#i$1^65.29#tc1) ==> Q#i$1^65.29#tc1 != $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) && Q#i$1^65.29#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^65.29#tc1)), F#lambda#6($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 2)), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 1)), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^65.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^65.29#tc1))))));
    // assert @inv_check(forall(uint32_t i; { @map_get(*((h->sh)), mark(i)) } @in_range_u4(i); ==>(>=(i, *((h->len))), @map_eq(@map_get(*((h->sh)), mark(i)), lambda#7())))); 
    assert (forall Q#i$1^66.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^66.29#tc1)) } $in_range_u4(Q#i$1^66.29#tc1) ==> Q#i$1^66.29#tc1 >= $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^66.29#tc1)), F#lambda#7()));
    // assert @inv_check(forall(uint32_t i; int32_t e; { @map_get(@map_get(*((h->sh)), mark(i)), e) } { mark3(i, e) } { @trigger_hint(mark3(i, e)) } &&(@in_range_u4(i), @in_range_i4(e)); ==>(<(i, *((h->len))), >=(@map_get(@map_get(*((h->sh)), mark(i)), e), 0)))); 
    assert (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) >= 0);
    // assert @inv_check(forall(uint32_t i; int32_t e; { @map_get(@map_get(*((h->sh)), mark(i)), e) } { mark3(i, e) } { @trigger_hint(mark3(i, e)) } &&(@in_range_u4(i), @in_range_i4(e)); ==>(<(i, *((h->len))), ==>(!=(i, *((h->len))), ==>(>(@map_get(@map_get(*((h->sh)), i), e), 0), >=(e, *((h->heap)[i]))))))); 
    assert (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> Q#i$1^66.29#tc1 != $rd_inv($s, Heap.len, $phys_ptr_cast(P#h, ^Heap)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rd_inv($s, Heap.sh, $phys_ptr_cast(P#h, ^Heap))), Q#i$1^66.29#tc1), Q#e$1^66.29#tc2) > 0 ==> Q#e$1^66.29#tc2 >= $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^66.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#h, ^Heap), Heap.heap), Q#i$1^66.29#tc1))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return res; 
    $result := L#res;
    assert $position_marker();
    goto #exit;

  anon54:
    // empty

  #exit:
}



procedure heapSort(P#arr: $ptr, P#len: int) returns (OP#perm: $map_t..^^u4.^^u4);
  requires P#len < 1000;
  requires $is_mutable_array($s, $phys_ptr_cast(P#arr, ^^i4), ^^i4, P#len);
  modifies $s, $cev_pc;
  ensures (forall Q#a$1^279.29#tc1: int, Q#b$1^279.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^u4(OP#perm, Q#a$1^279.29#tc1), $select.$map_t..^^u4.^^u4(OP#perm, Q#b$1^279.29#tc1) } $in_range_u4(Q#a$1^279.29#tc1) && $in_range_u4(Q#b$1^279.29#tc1) ==> Q#a$1^279.29#tc1 < Q#b$1^279.29#tc1 && Q#b$1^279.29#tc1 < P#len ==> $select.$map_t..^^u4.^^u4(OP#perm, Q#a$1^279.29#tc1) != $select.$map_t..^^u4.^^u4(OP#perm, Q#b$1^279.29#tc1)) && (forall Q#a$1^279.96#tc1: int :: {:weight 10} { $rd_inv($s, $field($idx($phys_ptr_cast(P#arr, ^^i4), Q#a$1^279.96#tc1)), $emb0($idx($phys_ptr_cast(P#arr, ^^i4), Q#a$1^279.96#tc1))) } { $select.$map_t..^^u4.^^u4(OP#perm, Q#a$1^279.96#tc1) } $in_range_u4(Q#a$1^279.96#tc1) ==> Q#a$1^279.96#tc1 < P#len ==> $select.$map_t..^^u4.^^u4(OP#perm, Q#a$1^279.96#tc1) < P#len && $rd_inv(old($s), $field($idx($phys_ptr_cast(P#arr, ^^i4), $select.$map_t..^^u4.^^u4(OP#perm, Q#a$1^279.96#tc1))), $emb0($idx($phys_ptr_cast(P#arr, ^^i4), $select.$map_t..^^u4.^^u4(OP#perm, Q#a$1^279.96#tc1)))) == $rd_inv($s, $field($idx($phys_ptr_cast(P#arr, ^^i4), Q#a$1^279.96#tc1)), $emb0($idx($phys_ptr_cast(P#arr, ^^i4), Q#a$1^279.96#tc1)))) && (forall Q#a$1^279.198#tc1: int, Q#b$1^279.198#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#arr, ^^i4), Q#a$1^279.198#tc1), $idx($phys_ptr_cast(P#arr, ^^i4), Q#b$1^279.198#tc1) } $in_range_u4(Q#a$1^279.198#tc1) && $in_range_u4(Q#b$1^279.198#tc1) ==> Q#a$1^279.198#tc1 < Q#b$1^279.198#tc1 && Q#b$1^279.198#tc1 < P#len ==> $rd_inv($s, $field($idx($phys_ptr_cast(P#arr, ^^i4), Q#a$1^279.198#tc1)), $emb0($idx($phys_ptr_cast(P#arr, ^^i4), Q#a$1^279.198#tc1))) <= $rd_inv($s, $field($idx($phys_ptr_cast(P#arr, ^^i4), Q#b$1^279.198#tc1)), $emb0($idx($phys_ptr_cast(P#arr, ^^i4), Q#b$1^279.198#tc1))));
  ensures $is_mutable_array($s, $phys_ptr_cast(P#arr, ^^i4), ^^i4, P#len);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: $set_in(#p, $array_range(old($s), $phys_ptr_cast(P#arr, ^^i4), ^^i4, P#len))));
  free ensures $call_transition(old($s), $s);



implementation heapSort(P#arr: $ptr, P#len: int) returns (OP#perm: $map_t..^^u4.^^u4)
{
  var prestate#71: $state;
  var prestate#69: $state;
  var owns#70: $ptrset;
  var res_extractMin#53: int where $in_range_i4(res_extractMin#53);
  var #wrTime$1^303.28: int;
  var loopState#5: $state;
  var #wrTime$1^292.28: int;
  var loopState#4: $state;
  var addr.h: $ptr;
  var L#i: int where $in_range_u4(L#i);
  var SL#indexes: $map_t..^^i4.$map_t..^^mathint.^^u4;
  var #wrTime$1^273.1: int;
  var #stackframe: int;

  anon61:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^273.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^273.1, #loc.arr, $ptr_to_int(P#arr), $ptr_to(^^i4));
    assume $local_value_is($s, #tok$1^273.1, #loc.len, P#len, ^^u4);
    assume #wrTime$1^273.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^273.1, (lambda #p: $ptr :: $set_in(#p, $array_range($s, $phys_ptr_cast(P#arr, ^^i4), ^^i4, P#len))));
    assume $initially_mutable_array($s, $phys_ptr_cast(P#arr, ^^i4), ^^i4, P#len);
    // assume true; 
    assume true;
    // assume @in_range_u4(len); 
    assume $in_range_u4(P#len);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // (int32_t -> (mathint -> uint32_t)) indexes; 
    assume $local_value_is($s, #tok$1^283.25, #loc.indexes, $map_t..^^i4.map_t..^^mathint.^^u4_to_int(SL#indexes), $map_t(^^i4, $map_t(^^mathint, ^^u4)));
    // uint32_t i; 
    assume $local_value_is($s, #tok$1^282.3, #loc.i, L#i, ^^u4);
    // struct Heap* addr.h; 
    assume $local_value_is($s, #tok$1^273.1, #loc.addr.h, $ptr_to_int(addr.h), $ptr_to(^Heap));
    // addr.h := _vcc_stack_alloc<struct Heap>(@stackframe, false); 
    call addr.h := $stack_alloc(^Heap, #stackframe, false);
    assume $full_stop_ext(#tok$1^273.1, $s);
    assume $local_value_is($s, #tok$1^273.1, #loc.addr.h, $ptr_to_int(addr.h), $ptr_to(^Heap));
    // var struct Heap h
    // var uint32_t i
    // var spec (int32_t -> (mathint -> uint32_t)) indexes
    // assert @writes_check(@_vcc_span(addr.h)); 
    assert (forall #writes$1^289.3: $ptr :: { $dont_instantiate(#writes$1^289.3) } $set_in(#writes$1^289.3, $span($phys_ptr_cast(addr.h, ^Heap))) ==> $top_writable($s, #wrTime$1^273.1, #writes$1^289.3));
    // stmt init(addr.h); 
    call init($phys_ptr_cast(addr.h, ^Heap));
    assume $full_stop_ext(#tok$1^289.3, $s);
    // i := 0; 
    L#i := 0;
    assume $local_value_is($s, #tok$1^291.8, #loc.i, L#i, ^^u4);
    call $bump_timestamp();
    assume $full_stop_ext(#tok$1^292.28, $s);
    loopState#4 := $s;
    assume #wrTime$1^292.28 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^292.28, (lambda #p: $ptr :: #p == $phys_ptr_cast(addr.h, ^Heap)));
    assert (forall #loopWrites^$1^292.28: $ptr :: { $dont_instantiate(#loopWrites^$1^292.28) } $listed_in_writes($s, #wrTime$1^292.28, #loopWrites^$1^292.28) ==> $top_writable($s, #wrTime$1^273.1, #loopWrites^$1^292.28));
    while (true)
      invariant L#i <= P#len;
      invariant $wrapped($s, $phys_ptr_cast(addr.h, ^Heap), ^Heap);
      invariant $rd_inv($s, Heap.len, $phys_ptr_cast(addr.h, ^Heap)) == L#i;
      invariant (forall Q#e$1^295.32#tc2: int, Q#i$1^295.32#tc3: int :: {:weight 10} { $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e$1^295.32#tc2), Q#i$1^295.32#tc3) } $in_range_i4(Q#e$1^295.32#tc2) ==> 0 <= Q#i$1^295.32#tc3 && Q#i$1^295.32#tc3 < $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($rd_inv($s, Heap.abs, $phys_ptr_cast(addr.h, ^Heap))), Q#e$1^295.32#tc2) ==> $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e$1^295.32#tc2), Q#i$1^295.32#tc3) < P#len && $rd_inv(loopState#4, $field($idx($phys_ptr_cast(P#arr, ^^i4), $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e$1^295.32#tc2), Q#i$1^295.32#tc3))), $emb0($idx($phys_ptr_cast(P#arr, ^^i4), $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e$1^295.32#tc2), Q#i$1^295.32#tc3)))) == Q#e$1^295.32#tc2);
      invariant (forall Q#e1$1^295.144#tc2: int, Q#e2$1^295.144#tc2: int, Q#i1$1^295.144#tc3: int, Q#i2$1^295.144#tc3: int :: {:weight 10} { $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e1$1^295.144#tc2), Q#i1$1^295.144#tc3), $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e2$1^295.144#tc2), Q#i2$1^295.144#tc3) } $in_range_i4(Q#e1$1^295.144#tc2) && $in_range_i4(Q#e2$1^295.144#tc2) ==> 0 <= Q#i1$1^295.144#tc3 && 0 <= Q#i2$1^295.144#tc3 && Q#i1$1^295.144#tc3 < $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($rd_inv($s, Heap.abs, $phys_ptr_cast(addr.h, ^Heap))), Q#e1$1^295.144#tc2) && Q#i2$1^295.144#tc3 < $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($rd_inv($s, Heap.abs, $phys_ptr_cast(addr.h, ^Heap))), Q#e2$1^295.144#tc2) && (Q#e1$1^295.144#tc2 != Q#e2$1^295.144#tc2 || Q#i1$1^295.144#tc3 != Q#i2$1^295.144#tc3) ==> $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e1$1^295.144#tc2), Q#i1$1^295.144#tc3) != $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e2$1^295.144#tc2), Q#i2$1^295.144#tc3));
      invariant (forall Q#e$1^296.31#tc2: int, Q#k$1^296.31#tc3: int :: {:weight 10} { $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e$1^296.31#tc2), Q#k$1^296.31#tc3) } $in_range_i4(Q#e$1^296.31#tc2) ==> 0 <= Q#k$1^296.31#tc3 && Q#k$1^296.31#tc3 < $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($rd_inv($s, Heap.abs, $phys_ptr_cast(addr.h, ^Heap))), Q#e$1^296.31#tc2) ==> $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e$1^296.31#tc2), Q#k$1^296.31#tc3) < L#i);
    {
      anon57:
        assume $modifies(loopState#4, $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(addr.h, ^Heap)));
        assume $timestamp_post(loopState#4, $s);
        assume $full_stop_ext(#tok$1^291.3, $s);
        assume $local_value_is($s, #tok$1^291.3, #loc.addr.h, $ptr_to_int(addr.h), $ptr_to(^Heap));
        assume $local_value_is($s, #tok$1^291.3, #loc.indexes, $map_t..^^i4.map_t..^^mathint.^^u4_to_int(SL#indexes), $map_t(^^i4, $map_t(^^mathint, ^^u4)));
        assume $local_value_is($s, #tok$1^291.3, #loc.len, P#len, ^^u4);
        assume $local_value_is($s, #tok$1^291.3, #loc.arr, $ptr_to_int(P#arr), $ptr_to(^^i4));
        assume true;
        // if (<(i, len)) ...
        if (L#i < P#len)
        {
          anon55:
            // assert @writes_check(addr.h); 
            assert $top_writable($s, #wrTime$1^292.28, $phys_ptr_cast(addr.h, ^Heap));
            // assert @reads_check_normal(arr[i]); 
            assert $thread_local($s, $idx($phys_ptr_cast(P#arr, ^^i4), L#i));
            // stmt insert(addr.h, *(arr[i])); 
            call insert($phys_ptr_cast(addr.h, ^Heap), $rd_inv($s, $field($idx($phys_ptr_cast(P#arr, ^^i4), L#i)), $emb0($idx($phys_ptr_cast(P#arr, ^^i4), L#i))));
            assume $full_stop_ext(#tok$1^298.5, $s);
            // assert @reads_check_normal(arr[i]); 
            assert $thread_local($s, $idx($phys_ptr_cast(P#arr, ^^i4), L#i));
            // assert @reads_check_normal(arr[i]); 
            assert $thread_local($s, $idx($phys_ptr_cast(P#arr, ^^i4), L#i));
            // assert @reads_check_normal((addr.h->abs)); 
            assert $thread_local($s, $phys_ptr_cast(addr.h, ^Heap));
            // assert @reads_check_normal(arr[i]); 
            assert $thread_local($s, $idx($phys_ptr_cast(P#arr, ^^i4), L#i));
            // indexes := @map_updated(indexes, *(arr[i]), @map_updated(@map_get(indexes, *(arr[i])), -(@map_get(*((addr.h->abs)), *(arr[i])), 1), i)); 
            SL#indexes := $store.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, $rd_inv($s, $field($idx($phys_ptr_cast(P#arr, ^^i4), L#i)), $emb0($idx($phys_ptr_cast(P#arr, ^^i4), L#i))), $store.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, $rd_inv($s, $field($idx($phys_ptr_cast(P#arr, ^^i4), L#i)), $emb0($idx($phys_ptr_cast(P#arr, ^^i4), L#i)))), $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($rd_inv($s, Heap.abs, $phys_ptr_cast(addr.h, ^Heap))), $rd_inv($s, $field($idx($phys_ptr_cast(P#arr, ^^i4), L#i)), $emb0($idx($phys_ptr_cast(P#arr, ^^i4), L#i)))) - 1, L#i));
            assume $local_value_is($s, #tok$1^299.27, #loc.indexes, $map_t..^^i4.map_t..^^mathint.^^u4_to_int(SL#indexes), $map_t(^^i4, $map_t(^^mathint, ^^u4)));
        }
        else
        {
          anon56:
            // goto #break_39; 
            goto #break_39;
        }

      #continue_39:
        // assert @in_range_u4(+(i, 1)); 
        assert $in_range_u4(L#i + 1);
        // i := +(i, 1); 
        L#i := L#i + 1;
        assume $local_value_is($s, #tok$1^291.24, #loc.i, L#i, ^^u4);
        assume true;
    }

  anon62:
    assume $full_stop_ext(#tok$1^291.3, $s);

  #break_39:
    // i := 0; 
    L#i := 0;
    assume $local_value_is($s, #tok$1^302.8, #loc.i, L#i, ^^u4);
    call $bump_timestamp();
    assume $full_stop_ext(#tok$1^303.28, $s);
    loopState#5 := $s;
    assume #wrTime$1^303.28 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^303.28, (lambda #p: $ptr :: #p == $phys_ptr_cast(addr.h, ^Heap) || $set_in(#p, $array_range($s, $phys_ptr_cast(P#arr, ^^i4), ^^i4, P#len))));
    assert (forall #loopWrites^$1^303.28: $ptr :: { $dont_instantiate(#loopWrites^$1^303.28) } $listed_in_writes($s, #wrTime$1^303.28, #loopWrites^$1^303.28) ==> $top_writable($s, #wrTime$1^273.1, #loopWrites^$1^303.28));
    while (true)
      invariant L#i <= P#len;
      invariant $wrapped($s, $phys_ptr_cast(addr.h, ^Heap), ^Heap);
      invariant $rd_inv($s, Heap.len, $phys_ptr_cast(addr.h, ^Heap)) == P#len - L#i;
      invariant $is_mutable_array($s, $phys_ptr_cast(P#arr, ^^i4), ^^i4, P#len);
      invariant (forall Q#e$1^307.32#tc2: int, Q#i$1^307.32#tc3: int :: {:weight 10} { $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e$1^307.32#tc2), Q#i$1^307.32#tc3) } $in_range_i4(Q#e$1^307.32#tc2) ==> 0 <= Q#i$1^307.32#tc3 && Q#i$1^307.32#tc3 < $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($rd_inv($s, Heap.abs, $phys_ptr_cast(addr.h, ^Heap))), Q#e$1^307.32#tc2) ==> $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e$1^307.32#tc2), Q#i$1^307.32#tc3) < P#len && $rd_inv(loopState#5, $field($idx($phys_ptr_cast(P#arr, ^^i4), $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e$1^307.32#tc2), Q#i$1^307.32#tc3))), $emb0($idx($phys_ptr_cast(P#arr, ^^i4), $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e$1^307.32#tc2), Q#i$1^307.32#tc3)))) == Q#e$1^307.32#tc2);
      invariant (forall Q#e1$1^307.144#tc2: int, Q#e2$1^307.144#tc2: int, Q#i1$1^307.144#tc3: int, Q#i2$1^307.144#tc3: int :: {:weight 10} { $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e1$1^307.144#tc2), Q#i1$1^307.144#tc3), $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e2$1^307.144#tc2), Q#i2$1^307.144#tc3) } $in_range_i4(Q#e1$1^307.144#tc2) && $in_range_i4(Q#e2$1^307.144#tc2) ==> 0 <= Q#i1$1^307.144#tc3 && 0 <= Q#i2$1^307.144#tc3 && Q#i1$1^307.144#tc3 < $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($rd_inv($s, Heap.abs, $phys_ptr_cast(addr.h, ^Heap))), Q#e1$1^307.144#tc2) && Q#i2$1^307.144#tc3 < $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($rd_inv($s, Heap.abs, $phys_ptr_cast(addr.h, ^Heap))), Q#e2$1^307.144#tc2) && (Q#e1$1^307.144#tc2 != Q#e2$1^307.144#tc2 || Q#i1$1^307.144#tc3 != Q#i2$1^307.144#tc3) ==> $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e1$1^307.144#tc2), Q#i1$1^307.144#tc3) != $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e2$1^307.144#tc2), Q#i2$1^307.144#tc3));
      invariant (forall Q#e$1^308.31#tc2: int, Q#a$1^308.31#tc3: int, Q#b$1^308.31#tc1: int :: {:weight 10} { $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e$1^308.31#tc2), Q#a$1^308.31#tc3), $select.$map_t..^^u4.^^u4(OP#perm, Q#b$1^308.31#tc1) } $in_range_i4(Q#e$1^308.31#tc2) && $in_range_u4(Q#b$1^308.31#tc1) ==> 0 <= Q#a$1^308.31#tc3 && Q#a$1^308.31#tc3 < $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($rd_inv($s, Heap.abs, $phys_ptr_cast(addr.h, ^Heap))), Q#e$1^308.31#tc2) && Q#b$1^308.31#tc1 < L#i ==> $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e$1^308.31#tc2), Q#a$1^308.31#tc3) != $select.$map_t..^^u4.^^u4(OP#perm, Q#b$1^308.31#tc1));
      invariant (forall Q#a$1^309.31#tc1: int, Q#e$1^309.31#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($rd_inv($s, Heap.abs, $phys_ptr_cast(addr.h, ^Heap))), Q#e$1^309.31#tc2), $idx($phys_ptr_cast(P#arr, ^^i4), Q#a$1^309.31#tc1) } $in_range_u4(Q#a$1^309.31#tc1) && $in_range_i4(Q#e$1^309.31#tc2) ==> Q#a$1^309.31#tc1 < L#i ==> $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($rd_inv($s, Heap.abs, $phys_ptr_cast(addr.h, ^Heap))), Q#e$1^309.31#tc2) > 0 ==> Q#e$1^309.31#tc2 >= $rd_inv($s, $field($idx($phys_ptr_cast(P#arr, ^^i4), Q#a$1^309.31#tc1)), $emb0($idx($phys_ptr_cast(P#arr, ^^i4), Q#a$1^309.31#tc1))));
      invariant (forall Q#a$1^310.33#tc1: int, Q#b$1^310.33#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^u4(OP#perm, Q#a$1^310.33#tc1), $select.$map_t..^^u4.^^u4(OP#perm, Q#b$1^310.33#tc1) } $in_range_u4(Q#a$1^310.33#tc1) && $in_range_u4(Q#b$1^310.33#tc1) ==> Q#a$1^310.33#tc1 < Q#b$1^310.33#tc1 && Q#b$1^310.33#tc1 < L#i ==> $select.$map_t..^^u4.^^u4(OP#perm, Q#a$1^310.33#tc1) != $select.$map_t..^^u4.^^u4(OP#perm, Q#b$1^310.33#tc1));
      invariant (forall Q#a$1^310.98#tc1: int :: {:weight 10} { $rd_inv($s, $field($idx($phys_ptr_cast(P#arr, ^^i4), Q#a$1^310.98#tc1)), $emb0($idx($phys_ptr_cast(P#arr, ^^i4), Q#a$1^310.98#tc1))) } { $select.$map_t..^^u4.^^u4(OP#perm, Q#a$1^310.98#tc1) } $in_range_u4(Q#a$1^310.98#tc1) ==> Q#a$1^310.98#tc1 < L#i ==> $select.$map_t..^^u4.^^u4(OP#perm, Q#a$1^310.98#tc1) < P#len && $rd_inv(loopState#5, $field($idx($phys_ptr_cast(P#arr, ^^i4), $select.$map_t..^^u4.^^u4(OP#perm, Q#a$1^310.98#tc1))), $emb0($idx($phys_ptr_cast(P#arr, ^^i4), $select.$map_t..^^u4.^^u4(OP#perm, Q#a$1^310.98#tc1)))) == $rd_inv($s, $field($idx($phys_ptr_cast(P#arr, ^^i4), Q#a$1^310.98#tc1)), $emb0($idx($phys_ptr_cast(P#arr, ^^i4), Q#a$1^310.98#tc1))));
      invariant (forall Q#a$1^310.198#tc1: int, Q#b$1^310.198#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#arr, ^^i4), Q#a$1^310.198#tc1), $idx($phys_ptr_cast(P#arr, ^^i4), Q#b$1^310.198#tc1) } $in_range_u4(Q#a$1^310.198#tc1) && $in_range_u4(Q#b$1^310.198#tc1) ==> Q#a$1^310.198#tc1 < Q#b$1^310.198#tc1 && Q#b$1^310.198#tc1 < L#i ==> $rd_inv($s, $field($idx($phys_ptr_cast(P#arr, ^^i4), Q#a$1^310.198#tc1)), $emb0($idx($phys_ptr_cast(P#arr, ^^i4), Q#a$1^310.198#tc1))) <= $rd_inv($s, $field($idx($phys_ptr_cast(P#arr, ^^i4), Q#b$1^310.198#tc1)), $emb0($idx($phys_ptr_cast(P#arr, ^^i4), Q#b$1^310.198#tc1))));
    {
      anon60:
        assume $modifies(loopState#5, $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(addr.h, ^Heap) || $set_in(#p, $array_range(loopState#5, $phys_ptr_cast(P#arr, ^^i4), ^^i4, P#len))));
        assume $timestamp_post(loopState#5, $s);
        assume $full_stop_ext(#tok$1^302.3, $s);
        assume $local_value_is($s, #tok$1^302.3, #loc.addr.h, $ptr_to_int(addr.h), $ptr_to(^Heap));
        assume $local_value_is($s, #tok$1^302.3, #loc.indexes, $map_t..^^i4.map_t..^^mathint.^^u4_to_int(SL#indexes), $map_t(^^i4, $map_t(^^mathint, ^^u4)));
        assume $local_value_is($s, #tok$1^302.3, #loc.len, P#len, ^^u4);
        assume $local_value_is($s, #tok$1^302.3, #loc.arr, $ptr_to_int(P#arr), $ptr_to(^^i4));
        assume true;
        // if (<(i, len)) ...
        if (L#i < P#len)
        {
          anon58:
            // int32_t res_extractMin#53; 
            assume $local_value_is($s, #tok$1^312.14, #loc.res_extractMin#53, res_extractMin#53, ^^i4);
            // assert @writes_check(addr.h); 
            assert $top_writable($s, #wrTime$1^303.28, $phys_ptr_cast(addr.h, ^Heap));
            // res_extractMin#53 := extractMin(addr.h); 
            call res_extractMin#53 := extractMin($phys_ptr_cast(addr.h, ^Heap));
            assume $full_stop_ext(#tok$1^312.14, $s);
            assume $local_value_is($s, #tok$1^312.14, #loc.res_extractMin#53, res_extractMin#53, ^^i4);
            // assert @prim_writes_check(arr[i]); 
            assert $writable_prim($s, #wrTime$1^303.28, $idx($phys_ptr_cast(P#arr, ^^i4), L#i));
            // *arr[i] := res_extractMin#53; 
            call $write_int($field($idx($phys_ptr_cast(P#arr, ^^i4), L#i)), $emb0($idx($phys_ptr_cast(P#arr, ^^i4), L#i)), res_extractMin#53);
            assume $full_stop_ext(#tok$1^312.5, $s);
            // assert @reads_check_normal(arr[i]); 
            assert $thread_local($s, $idx($phys_ptr_cast(P#arr, ^^i4), L#i));
            // assert @reads_check_normal((addr.h->abs)); 
            assert $thread_local($s, $phys_ptr_cast(addr.h, ^Heap));
            // assert @reads_check_normal(arr[i]); 
            assert $thread_local($s, $idx($phys_ptr_cast(P#arr, ^^i4), L#i));
            // perm := @map_updated(perm, i, @map_get(@map_get(indexes, *(arr[i])), @map_get(*((addr.h->abs)), *(arr[i])))); 
            OP#perm := $store.$map_t..^^u4.^^u4(OP#perm, L#i, $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, $rd_inv($s, $field($idx($phys_ptr_cast(P#arr, ^^i4), L#i)), $emb0($idx($phys_ptr_cast(P#arr, ^^i4), L#i)))), $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($rd_inv($s, Heap.abs, $phys_ptr_cast(addr.h, ^Heap))), $rd_inv($s, $field($idx($phys_ptr_cast(P#arr, ^^i4), L#i)), $emb0($idx($phys_ptr_cast(P#arr, ^^i4), L#i))))));
            assume $local_value_is($s, #tok$1^313.27, #loc.perm, $map_t..^^u4.^^u4_to_int(OP#perm), $map_t(^^u4, ^^u4));
        }
        else
        {
          anon59:
            // goto #break_40; 
            goto #break_40;
        }

      #continue_40:
        // assert @in_range_u4(+(i, 1)); 
        assert $in_range_u4(L#i + 1);
        // i := +(i, 1); 
        L#i := L#i + 1;
        assume $local_value_is($s, #tok$1^302.24, #loc.i, L#i, ^^u4);
        assume true;
    }

  anon63:
    assume $full_stop_ext(#tok$1^302.3, $s);

  #break_40:
    // _math ptrset owns#70; 
    assume $local_value_is($s, #tok$4^0.0, #loc.owns#70, $ptrset_to_int(owns#70), ^$#ptrset);
    // owns#70 := @_vcc_set_empty; 
    owns#70 := $set_empty();
    assume $local_value_is($s, #tok$4^0.0, #loc.owns#70, $ptrset_to_int(owns#70), ^$#ptrset);
    // _math state_t prestate#69; 
    assume $local_value_is($s, #tok$4^0.0, #loc.prestate#69, $state_to_int(prestate#69), ^$#state_t);
    // prestate#69 := @_vcc_current_state(@state); 
    prestate#69 := $current_state($s);
    assume $local_value_is($s, #tok$4^0.0, #loc.prestate#69, $state_to_int(prestate#69), ^$#state_t);
    // _math state_t prestate#71; 
    assume $local_value_is($s, #tok$4^0.0, #loc.prestate#71, $state_to_int(prestate#71), ^$#state_t);
    // prestate#71 := @_vcc_current_state(@state); 
    prestate#71 := $current_state($s);
    assume $local_value_is($s, #tok$4^0.0, #loc.prestate#71, $state_to_int(prestate#71), ^$#state_t);
    // assert @_vcc_wrapped(@state, addr.h); 
    assert $wrapped($s, $phys_ptr_cast(addr.h, ^Heap), ^Heap);
    // assert @writes_check(addr.h); 
    assert $top_writable($s, #wrTime$1^273.1, $phys_ptr_cast(addr.h, ^Heap));
    // assume @_vcc_inv(@state, addr.h); 
    assume $inv($s, $phys_ptr_cast(addr.h, ^Heap), ^Heap);
    // assume ==(owns#70, @_vcc_owns(@state, addr.h)); 
    assume owns#70 == $owns($s, $phys_ptr_cast(addr.h, ^Heap));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(addr.h), prestate#71)
    call $static_unwrap($phys_ptr_cast(addr.h, ^Heap), prestate#71);
    assume $good_state_ext(#tok$1^316.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // stmt _vcc_stack_free(@stackframe, addr.h); 
    call $stack_free(#stackframe, $phys_ptr_cast(addr.h, ^Heap));
    assume $full_stop_ext(#tok$1^273.1, $s);
    // return; 
    assert $position_marker();
    goto #exit;

  anon64:
    // Block cleanup
    // stmt _vcc_stack_free(@stackframe, addr.h); 
    call $stack_free(#stackframe, $phys_ptr_cast(addr.h, ^Heap));
    assume $full_stop_ext(#tok$1^273.1, $s);

  #exit:
}



procedure heapSortTestHarness();
  modifies $s, $cev_pc;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation heapSortTestHarness()
{
  var ite#5: bool;
  var ite#4: bool;
  var tmp#0: bool;
  var ite#3: bool;
  var L#tmp: bool;
  var L#__temp71610: $ptr;
  var addr.#stackframe#0: $ptr;
  var L#arr: $ptr;
  var SL#perm: $map_t..^^u4.^^u4;
  var #wrTime$1^320.1: int;
  var #stackframe: int;

  anon71:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^320.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^320.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^320.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // (uint32_t -> uint32_t) perm; 
    assume $local_value_is($s, #tok$1^323.25, #loc.perm, $map_t..^^u4.^^u4_to_int(SL#perm), $map_t(^^u4, ^^u4));
    // int32_t* arr; 
    assume $local_value_is($s, #tok$1^322.3, #loc.arr, $ptr_to_int(L#arr), $ptr_to(^^i4));
    // struct heapSortTestHarnessstackframe#0* addr.#stackframe#0; 
    assume $local_value_is($s, #tok$1^320.1, #loc.addr.#stackframe#0, $ptr_to_int(addr.#stackframe#0), $ptr_to(^heapSortTestHarnessstackframe#0));
    // addr.#stackframe#0 := _vcc_stack_alloc<struct heapSortTestHarnessstackframe#0>(@stackframe, false); 
    call addr.#stackframe#0 := $stack_alloc(^heapSortTestHarnessstackframe#0, #stackframe, false);
    assume $full_stop_ext(#tok$1^320.1, $s);
    assume $local_value_is($s, #tok$1^320.1, #loc.addr.#stackframe#0, $ptr_to_int(addr.#stackframe#0), $ptr_to(^heapSortTestHarnessstackframe#0));
    // int32_t* __temp71610; 
    assume $local_value_is($s, #tok$1^322.15, #loc.__temp71610, $ptr_to_int(L#__temp71610), $ptr_to(^^i4));
    // __temp71610 := (addr.#stackframe#0->__temp71610); 
    L#__temp71610 := $dot($phys_ptr_cast(addr.#stackframe#0, ^heapSortTestHarnessstackframe#0), heapSortTestHarnessstackframe#0.__temp71610);
    assume $local_value_is($s, #tok$1^322.15, #loc.__temp71610, $ptr_to_int(L#__temp71610), $ptr_to(^^i4));
    // assert @prim_writes_check(__temp71610[0]); 
    assert $writable_prim($s, #wrTime$1^320.1, $idx($phys_ptr_cast(L#__temp71610, ^^i4), 0));
    // *__temp71610[0] := 42; 
    call $write_int($field($idx($phys_ptr_cast(L#__temp71610, ^^i4), 0)), $emb0($idx($phys_ptr_cast(L#__temp71610, ^^i4), 0)), 42);
    assume $full_stop_ext(#tok$4^0.0, $s);
    // assert @prim_writes_check(__temp71610[1]); 
    assert $writable_prim($s, #wrTime$1^320.1, $idx($phys_ptr_cast(L#__temp71610, ^^i4), 1));
    // *__temp71610[1] := 13; 
    call $write_int($field($idx($phys_ptr_cast(L#__temp71610, ^^i4), 1)), $emb0($idx($phys_ptr_cast(L#__temp71610, ^^i4), 1)), 13);
    assume $full_stop_ext(#tok$4^0.0, $s);
    // assert @prim_writes_check(__temp71610[2]); 
    assert $writable_prim($s, #wrTime$1^320.1, $idx($phys_ptr_cast(L#__temp71610, ^^i4), 2));
    // *__temp71610[2] := 42; 
    call $write_int($field($idx($phys_ptr_cast(L#__temp71610, ^^i4), 2)), $emb0($idx($phys_ptr_cast(L#__temp71610, ^^i4), 2)), 42);
    assume $full_stop_ext(#tok$4^0.0, $s);
    // arr := __temp71610; 
    L#arr := $phys_ptr_cast(L#__temp71610, ^^i4);
    assume $local_value_is($s, #tok$1^322.3, #loc.arr, $ptr_to_int(L#arr), $ptr_to(^^i4));
    // var spec (uint32_t -> uint32_t) perm
    // assert @writes_check(@_vcc_array_range(@state, arr, 3)); 
    assert (forall #writes$1^324.3: $ptr :: { $dont_instantiate(#writes$1^324.3) } $set_in(#writes$1^324.3, $array_range($s, $phys_ptr_cast(L#arr, ^^i4), ^^i4, 3)) ==> $top_writable($s, #wrTime$1^320.1, #writes$1^324.3));
    // perm := heapSort(arr, 3); 
    call SL#perm := heapSort($phys_ptr_cast(L#arr, ^^i4), 3);
    assume $full_stop_ext(#tok$1^324.3, $s);
    assume $local_value_is($s, #tok$1^324.3, #loc.perm, $map_t..^^u4.^^u4_to_int(SL#perm), $map_t(^^u4, ^^u4));
    // _Bool tmp; 
    assume $local_value_is($s, #tok$1^327.5, #loc.tmp, $bool_to_int(L#tmp), ^^bool);
    // _Bool ite#3; 
    assume $local_value_is($s, #tok$1^327.16, #loc.ite#3, $bool_to_int(ite#3), ^^bool);
    // assert @reads_check_normal(arr[0]); 
    assert $thread_local($s, $idx($phys_ptr_cast(L#arr, ^^i4), 0));
    // assert @reads_check_normal(arr[1]); 
    assert $thread_local($s, $idx($phys_ptr_cast(L#arr, ^^i4), 1));
    assume true;
    // if (<=(*(arr[0]), *(arr[1]))) ...
    if ($rd_inv($s, $field($idx($phys_ptr_cast(L#arr, ^^i4), 0)), $emb0($idx($phys_ptr_cast(L#arr, ^^i4), 0))) <= $rd_inv($s, $field($idx($phys_ptr_cast(L#arr, ^^i4), 1)), $emb0($idx($phys_ptr_cast(L#arr, ^^i4), 1))))
    {
      anon65:
        // assert @reads_check_normal(arr[1]); 
        assert $thread_local($s, $idx($phys_ptr_cast(L#arr, ^^i4), 1));
        // assert @reads_check_normal(arr[2]); 
        assert $thread_local($s, $idx($phys_ptr_cast(L#arr, ^^i4), 2));
        // ite#3 := <=(*(arr[1]), *(arr[2])); 
        ite#3 := $rd_inv($s, $field($idx($phys_ptr_cast(L#arr, ^^i4), 1)), $emb0($idx($phys_ptr_cast(L#arr, ^^i4), 1))) <= $rd_inv($s, $field($idx($phys_ptr_cast(L#arr, ^^i4), 2)), $emb0($idx($phys_ptr_cast(L#arr, ^^i4), 2)));
        assume $local_value_is($s, #tok$1^327.16, #loc.ite#3, $bool_to_int(ite#3), ^^bool);
    }
    else
    {
      anon66:
        // ite#3 := false; 
        ite#3 := false;
        assume $local_value_is($s, #tok$1^327.16, #loc.ite#3, $bool_to_int(ite#3), ^^bool);
    }

  anon72:
    // tmp := ite#3; 
    L#tmp := ite#3;
    assume $local_value_is($s, #tok$1^327.5, #loc.tmp, $bool_to_int(L#tmp), ^^bool);
    // assert tmp; 
    assert L#tmp;
    // assume tmp; 
    assume L#tmp;
    // empty
    // _Bool tmp#0; 
    assume $local_value_is($s, #tok$1^328.5, #loc.tmp#0, $bool_to_int(tmp#0), ^^bool);
    // _Bool ite#4; 
    assume $local_value_is($s, #tok$1^328.16, #loc.ite#4, $bool_to_int(ite#4), ^^bool);
    // _Bool ite#5; 
    assume $local_value_is($s, #tok$1^328.16, #loc.ite#5, $bool_to_int(ite#5), ^^bool);
    // assert @reads_check_normal(arr[0]); 
    assert $thread_local($s, $idx($phys_ptr_cast(L#arr, ^^i4), 0));
    assume true;
    // if (==(*(arr[0]), 13)) ...
    if ($rd_inv($s, $field($idx($phys_ptr_cast(L#arr, ^^i4), 0)), $emb0($idx($phys_ptr_cast(L#arr, ^^i4), 0))) == 13)
    {
      anon67:
        // assert @reads_check_normal(arr[1]); 
        assert $thread_local($s, $idx($phys_ptr_cast(L#arr, ^^i4), 1));
        // ite#5 := ==(*(arr[1]), 42); 
        ite#5 := $rd_inv($s, $field($idx($phys_ptr_cast(L#arr, ^^i4), 1)), $emb0($idx($phys_ptr_cast(L#arr, ^^i4), 1))) == 42;
        assume $local_value_is($s, #tok$1^328.16, #loc.ite#5, $bool_to_int(ite#5), ^^bool);
    }
    else
    {
      anon68:
        // ite#5 := false; 
        ite#5 := false;
        assume $local_value_is($s, #tok$1^328.16, #loc.ite#5, $bool_to_int(ite#5), ^^bool);
    }

  anon73:
    assume true;
    // if (ite#5) ...
    if (ite#5)
    {
      anon69:
        // assert @reads_check_normal(arr[2]); 
        assert $thread_local($s, $idx($phys_ptr_cast(L#arr, ^^i4), 2));
        // ite#4 := ==(*(arr[2]), 42); 
        ite#4 := $rd_inv($s, $field($idx($phys_ptr_cast(L#arr, ^^i4), 2)), $emb0($idx($phys_ptr_cast(L#arr, ^^i4), 2))) == 42;
        assume $local_value_is($s, #tok$1^328.16, #loc.ite#4, $bool_to_int(ite#4), ^^bool);
    }
    else
    {
      anon70:
        // ite#4 := false; 
        ite#4 := false;
        assume $local_value_is($s, #tok$1^328.16, #loc.ite#4, $bool_to_int(ite#4), ^^bool);
    }

  anon74:
    // tmp#0 := ite#4; 
    tmp#0 := ite#4;
    assume $local_value_is($s, #tok$1^328.5, #loc.tmp#0, $bool_to_int(tmp#0), ^^bool);
    // assert tmp#0; 
    assert tmp#0;
    // assume tmp#0; 
    assume tmp#0;
    // empty
    // stmt _vcc_stack_free(@stackframe, addr.#stackframe#0); 
    call $stack_free(#stackframe, $phys_ptr_cast(addr.#stackframe#0, ^heapSortTestHarnessstackframe#0));
    assume $full_stop_ext(#tok$1^320.1, $s);
    // return; 
    assert $position_marker();
    goto #exit;

  anon75:
    // Block cleanup
    // stmt _vcc_stack_free(@stackframe, addr.#stackframe#0); 
    call $stack_free(#stackframe, $phys_ptr_cast(addr.#stackframe#0, ^heapSortTestHarnessstackframe#0));
    assume $full_stop_ext(#tok$1^320.1, $s);

  #exit:
}



const unique ^heapSortTestHarnessstackframe#0: $ctype;

axiom $is_span_sequential(^heapSortTestHarnessstackframe#0);

axiom $def_struct_type(^heapSortTestHarnessstackframe#0, 12, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^heapSortTestHarnessstackframe#0) } $inv2(#s1, #s2, #p, ^heapSortTestHarnessstackframe#0) == $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^heapSortTestHarnessstackframe#0)) } $in(q, $composite_extent(s, p, ^heapSortTestHarnessstackframe#0)) == (q == p));

const unique heapSortTestHarnessstackframe#0.__temp71610: $field;

axiom $def_phys_arr_field(^heapSortTestHarnessstackframe#0, heapSortTestHarnessstackframe#0.__temp71610, ^^i4, false, 0, 3);

function F#lambda#34(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#34: $pure_function;

axiom $function_arg_type(cf#lambda#34, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#34, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#34, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#34, 3, ^^i4);

procedure lambda#34(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#34(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#k$1^178.37#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#34(#l2, #l1, #l0), Q#k$1^178.37#tc2) } $in_range_i4(Q#k$1^178.37#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#34(#l2, #l1, #l0), Q#k$1^178.37#tc2) == (if Q#k$1^178.37#tc2 == #l0 then $select.$map_t..^^i4.^^mathint(#l1, Q#k$1^178.37#tc2) - 1 else $select.$map_t..^^i4.^^mathint(#l2, Q#k$1^178.37#tc2)));

function F#lambda#33() : $map_t..^^i4.^^mathint;

const unique cf#lambda#33: $pure_function;

axiom $function_arg_type(cf#lambda#33, 0, $map_t(^^i4, ^^mathint));

procedure lambda#33() returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#33();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^244.30#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#33(), Q#e$1^244.30#tc2) } $in_range_i4(Q#e$1^244.30#tc2) ==> $select.$map_t..^^i4.^^mathint(F#lambda#33(), Q#e$1^244.30#tc2) == 0);

function F#lambda#32() : $map_t..^^i4.^^mathint;

const unique cf#lambda#32: $pure_function;

axiom $function_arg_type(cf#lambda#32, 0, $map_t(^^i4, ^^mathint));

procedure lambda#32() returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#32();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^244.30#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#32(), Q#e$1^244.30#tc2) } $in_range_i4(Q#e$1^244.30#tc2) ==> $select.$map_t..^^i4.^^mathint(F#lambda#32(), Q#e$1^244.30#tc2) == 0);

function F#lambda#31(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#31: $pure_function;

axiom $function_arg_type(cf#lambda#31, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#31, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#31, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#31, 3, ^^i4);

procedure lambda#31(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#31(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^240.47#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#31(#l2, #l1, #l0), Q#e$1^240.47#tc2) } $in_range_i4(Q#e$1^240.47#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#31(#l2, #l1, #l0), Q#e$1^240.47#tc2) == (if Q#e$1^240.47#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^240.47#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^240.47#tc2));

function F#lambda#30(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#30: $pure_function;

axiom $function_arg_type(cf#lambda#30, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#30, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#30, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#30, 3, ^^i4);

procedure lambda#30(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#30(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^225.31#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#30(#l2, #l1, #l0), Q#e$1^225.31#tc2) } $in_range_i4(Q#e$1^225.31#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#30(#l2, #l1, #l0), Q#e$1^225.31#tc2) == (if Q#e$1^225.31#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^225.31#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^225.31#tc2));

function F#lambda#29() : $map_t..^^i4.^^mathint;

const unique cf#lambda#29: $pure_function;

axiom $function_arg_type(cf#lambda#29, 0, $map_t(^^i4, ^^mathint));

procedure lambda#29() returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#29();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^224.31#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#29(), Q#e$1^224.31#tc2) } $in_range_i4(Q#e$1^224.31#tc2) ==> $select.$map_t..^^i4.^^mathint(F#lambda#29(), Q#e$1^224.31#tc2) == 0);

function F#lambda#28(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#28: $pure_function;

axiom $function_arg_type(cf#lambda#28, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#28, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#28, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#28, 3, ^^i4);

procedure lambda#28(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#28(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#k$1^222.43#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#28(#l2, #l1, #l0), Q#k$1^222.43#tc2) } $in_range_i4(Q#k$1^222.43#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#28(#l2, #l1, #l0), Q#k$1^222.43#tc2) == (if Q#k$1^222.43#tc2 == #l0 then $select.$map_t..^^i4.^^mathint(#l1, Q#k$1^222.43#tc2) - 1 else $select.$map_t..^^i4.^^mathint(#l2, Q#k$1^222.43#tc2)));

function F#lambda#27(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#27: $pure_function;

axiom $function_arg_type(cf#lambda#27, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#27, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#27, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#27, 3, ^^i4);

procedure lambda#27(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#27(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^217.36#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#27(#l2, #l1, #l0), Q#e$1^217.36#tc2) } $in_range_i4(Q#e$1^217.36#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#27(#l2, #l1, #l0), Q#e$1^217.36#tc2) == (if Q#e$1^217.36#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^217.36#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^217.36#tc2));

function F#lambda#26(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#26: $pure_function;

axiom $function_arg_type(cf#lambda#26, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#26, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#26, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#26, 3, ^^i4);

procedure lambda#26(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#26(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^212.38#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#26(#l2, #l1, #l0), Q#e$1^212.38#tc2) } $in_range_i4(Q#e$1^212.38#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#26(#l2, #l1, #l0), Q#e$1^212.38#tc2) == (if Q#e$1^212.38#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^212.38#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^212.38#tc2));

function F#lambda#25(#l3: $map_t..^^i4.^^mathint, #l2: $map_t..^^i4.^^mathint, #l1: int, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#25: $pure_function;

axiom $function_arg_type(cf#lambda#25, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#25, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#25, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#25, 3, ^^i4);

axiom $function_arg_type(cf#lambda#25, 4, ^^i4);

procedure lambda#25(#l3: $map_t..^^i4.^^mathint, #l2: $map_t..^^i4.^^mathint, #l1: int, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#25(#l3, #l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^208.43#tc2: int, #l3: $map_t..^^i4.^^mathint, #l2: $map_t..^^i4.^^mathint, #l1: int, #l0: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#25(#l3, #l2, #l1, #l0), Q#e$1^208.43#tc2) } $in_range_i4(Q#e$1^208.43#tc2) && $in_range_i4(#l1) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#25(#l3, #l2, #l1, #l0), Q#e$1^208.43#tc2) == (if Q#e$1^208.43#tc2 == #l0 then 1 else 0) + (if Q#e$1^208.43#tc2 == #l1 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^208.43#tc2) + $select.$map_t..^^i4.^^mathint(#l3, Q#e$1^208.43#tc2));

function F#lambda#24(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#24: $pure_function;

axiom $function_arg_type(cf#lambda#24, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#24, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#24, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#24, 3, ^^i4);

procedure lambda#24(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#24(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^207.31#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#24(#l2, #l1, #l0), Q#e$1^207.31#tc2) } $in_range_i4(Q#e$1^207.31#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#24(#l2, #l1, #l0), Q#e$1^207.31#tc2) == (if Q#e$1^207.31#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^207.31#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^207.31#tc2));

function F#lambda#23() : $map_t..^^i4.^^mathint;

const unique cf#lambda#23: $pure_function;

axiom $function_arg_type(cf#lambda#23, 0, $map_t(^^i4, ^^mathint));

procedure lambda#23() returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#23();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^205.31#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#23(), Q#e$1^205.31#tc2) } $in_range_i4(Q#e$1^205.31#tc2) ==> $select.$map_t..^^i4.^^mathint(F#lambda#23(), Q#e$1^205.31#tc2) == 0);

function F#lambda#22() : $map_t..^^i4.^^mathint;

const unique cf#lambda#22: $pure_function;

axiom $function_arg_type(cf#lambda#22, 0, $map_t(^^i4, ^^mathint));

procedure lambda#22() returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#22();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^195.36#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#22(), Q#e$1^195.36#tc2) } $in_range_i4(Q#e$1^195.36#tc2) ==> $select.$map_t..^^i4.^^mathint(F#lambda#22(), Q#e$1^195.36#tc2) == 0);

function F#lambda#21(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#21: $pure_function;

axiom $function_arg_type(cf#lambda#21, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#21, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#21, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#21, 3, ^^i4);

procedure lambda#21(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#21(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#k$1^85.37#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#21(#l2, #l1, #l0), Q#k$1^85.37#tc2) } $in_range_i4(Q#k$1^85.37#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#21(#l2, #l1, #l0), Q#k$1^85.37#tc2) == (if Q#k$1^85.37#tc2 == #l0 then $select.$map_t..^^i4.^^mathint(#l1, Q#k$1^85.37#tc2) + 1 else $select.$map_t..^^i4.^^mathint(#l2, Q#k$1^85.37#tc2)));

function F#lambda#20(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#20: $pure_function;

axiom $function_arg_type(cf#lambda#20, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#20, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#20, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#20, 3, ^^i4);

procedure lambda#20(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#20(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^166.16#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#20(#l2, #l1, #l0), Q#e$1^166.16#tc2) } $in_range_i4(Q#e$1^166.16#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#20(#l2, #l1, #l0), Q#e$1^166.16#tc2) == (if Q#e$1^166.16#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^166.16#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^166.16#tc2));

function F#lambda#19(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#19: $pure_function;

axiom $function_arg_type(cf#lambda#19, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#19, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#19, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#19, 3, ^^i4);

procedure lambda#19(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#19(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^160.38#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#19(#l2, #l1, #l0), Q#e$1^160.38#tc2) } $in_range_i4(Q#e$1^160.38#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#19(#l2, #l1, #l0), Q#e$1^160.38#tc2) == (if Q#e$1^160.38#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^160.38#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^160.38#tc2));

function F#lambda#18(#l3: $map_t..^^i4.^^mathint, #l2: $map_t..^^i4.^^mathint, #l1: int, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#18: $pure_function;

axiom $function_arg_type(cf#lambda#18, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#18, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#18, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#18, 3, ^^i4);

axiom $function_arg_type(cf#lambda#18, 4, ^^i4);

procedure lambda#18(#l3: $map_t..^^i4.^^mathint, #l2: $map_t..^^i4.^^mathint, #l1: int, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#18(#l3, #l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^145.43#tc2: int, #l3: $map_t..^^i4.^^mathint, #l2: $map_t..^^i4.^^mathint, #l1: int, #l0: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#18(#l3, #l2, #l1, #l0), Q#e$1^145.43#tc2) } $in_range_i4(Q#e$1^145.43#tc2) && $in_range_i4(#l1) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#18(#l3, #l2, #l1, #l0), Q#e$1^145.43#tc2) == (if Q#e$1^145.43#tc2 == #l0 then -1 else 0) + (if Q#e$1^145.43#tc2 == #l1 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^145.43#tc2) + $select.$map_t..^^i4.^^mathint(#l3, Q#e$1^145.43#tc2));

function F#lambda#17(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#17: $pure_function;

axiom $function_arg_type(cf#lambda#17, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#17, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#17, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#17, 3, ^^i4);

procedure lambda#17(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#17(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^144.31#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#17(#l2, #l1, #l0), Q#e$1^144.31#tc2) } $in_range_i4(Q#e$1^144.31#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#17(#l2, #l1, #l0), Q#e$1^144.31#tc2) == (if Q#e$1^144.31#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^144.31#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^144.31#tc2));

function F#lambda#16() : $map_t..^^i4.^^mathint;

const unique cf#lambda#16: $pure_function;

axiom $function_arg_type(cf#lambda#16, 0, $map_t(^^i4, ^^mathint));

procedure lambda#16() returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#16();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^142.31#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#16(), Q#e$1^142.31#tc2) } $in_range_i4(Q#e$1^142.31#tc2) ==> $select.$map_t..^^i4.^^mathint(F#lambda#16(), Q#e$1^142.31#tc2) == 0);

function F#lambda#15(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#15: $pure_function;

axiom $function_arg_type(cf#lambda#15, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#15, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#15, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#15, 3, ^^i4);

procedure lambda#15(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#15(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^135.38#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#15(#l2, #l1, #l0), Q#e$1^135.38#tc2) } $in_range_i4(Q#e$1^135.38#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#15(#l2, #l1, #l0), Q#e$1^135.38#tc2) == (if Q#e$1^135.38#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^135.38#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^135.38#tc2));

function F#lambda#14(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#14: $pure_function;

axiom $function_arg_type(cf#lambda#14, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#14, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#14, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#14, 3, ^^i4);

procedure lambda#14(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#14(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^130.40#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#14(#l2, #l1, #l0), Q#e$1^130.40#tc2) } $in_range_i4(Q#e$1^130.40#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#14(#l2, #l1, #l0), Q#e$1^130.40#tc2) == (if Q#e$1^130.40#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^130.40#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^130.40#tc2));

function F#lambda#13(#l3: $map_t..^^i4.^^mathint, #l2: $map_t..^^i4.^^mathint, #l1: int, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#13: $pure_function;

axiom $function_arg_type(cf#lambda#13, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#13, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#13, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#13, 3, ^^i4);

axiom $function_arg_type(cf#lambda#13, 4, ^^i4);

procedure lambda#13(#l3: $map_t..^^i4.^^mathint, #l2: $map_t..^^i4.^^mathint, #l1: int, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#13(#l3, #l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^103.43#tc2: int, #l3: $map_t..^^i4.^^mathint, #l2: $map_t..^^i4.^^mathint, #l1: int, #l0: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#13(#l3, #l2, #l1, #l0), Q#e$1^103.43#tc2) } $in_range_i4(Q#e$1^103.43#tc2) && $in_range_i4(#l1) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#13(#l3, #l2, #l1, #l0), Q#e$1^103.43#tc2) == (if Q#e$1^103.43#tc2 == #l0 then -1 else 0) + (if Q#e$1^103.43#tc2 == #l1 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^103.43#tc2) + $select.$map_t..^^i4.^^mathint(#l3, Q#e$1^103.43#tc2));

function F#lambda#12(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#12: $pure_function;

axiom $function_arg_type(cf#lambda#12, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#12, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#12, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#12, 3, ^^i4);

procedure lambda#12(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#12(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^102.31#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#12(#l2, #l1, #l0), Q#e$1^102.31#tc2) } $in_range_i4(Q#e$1^102.31#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#12(#l2, #l1, #l0), Q#e$1^102.31#tc2) == (if Q#e$1^102.31#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^102.31#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^102.31#tc2));

function F#lambda#11() : $map_t..^^i4.^^mathint;

const unique cf#lambda#11: $pure_function;

axiom $function_arg_type(cf#lambda#11, 0, $map_t(^^i4, ^^mathint));

procedure lambda#11() returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#11();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^100.31#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#11(), Q#e$1^100.31#tc2) } $in_range_i4(Q#e$1^100.31#tc2) ==> $select.$map_t..^^i4.^^mathint(F#lambda#11(), Q#e$1^100.31#tc2) == 0);

function F#lambda#10() : $map_t..^^i4.^^mathint;

const unique cf#lambda#10: $pure_function;

axiom $function_arg_type(cf#lambda#10, 0, $map_t(^^i4, ^^mathint));

procedure lambda#10() returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#10();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^71.67#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#10(), Q#e$1^71.67#tc2) } $in_range_i4(Q#e$1^71.67#tc2) ==> $select.$map_t..^^i4.^^mathint(F#lambda#10(), Q#e$1^71.67#tc2) == 0);

function F#lambda#9(#l0: $map_t..^^i4.^^mathint) : $map_t..^^u4.$map_t..^^i4.^^mathint;

const unique cf#lambda#9: $pure_function;

axiom $function_arg_type(cf#lambda#9, 0, $map_t(^^u4, $map_t(^^i4, ^^mathint)));

axiom $function_arg_type(cf#lambda#9, 1, $map_t(^^i4, ^^mathint));

procedure lambda#9(#l0: $map_t..^^i4.^^mathint) returns ($result: $map_t..^^u4.$map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#9(#l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^74.13#tc1: int, #l0: $map_t..^^i4.^^mathint :: {:weight 10} { $select.$map_t..^^u4.$map_t..^^i4.^^mathint(F#lambda#9(#l0), Q#i$1^74.13#tc1) } $in_range_u4(Q#i$1^74.13#tc1) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint(F#lambda#9(#l0), Q#i$1^74.13#tc1), #l0));

function F#lambda#8() : $map_t..^^i4.^^mathint;

const unique cf#lambda#8: $pure_function;

axiom $function_arg_type(cf#lambda#8, 0, $map_t(^^i4, ^^mathint));

procedure lambda#8() returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#8();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^74.13#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#8(), Q#e$1^74.13#tc2) } $in_range_i4(Q#e$1^74.13#tc2) ==> $select.$map_t..^^i4.^^mathint(F#lambda#8(), Q#e$1^74.13#tc2) == 0);

function F#lambda#7() : $map_t..^^i4.^^mathint;

const unique cf#lambda#7: $pure_function;

axiom $function_arg_type(cf#lambda#7, 0, $map_t(^^i4, ^^mathint));

procedure lambda#7() returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#7();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^66.29#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#7(), Q#e$1^66.29#tc2) } $in_range_i4(Q#e$1^66.29#tc2) ==> $select.$map_t..^^i4.^^mathint(F#lambda#7(), Q#e$1^66.29#tc2) == 0);

function F#lambda#6(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#6: $pure_function;

axiom $function_arg_type(cf#lambda#6, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#6, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#6, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#6, 3, ^^i4);

procedure lambda#6(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#6(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^65.29#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: {:weight 10} { $select.$map_t..^^i4.^^mathint(F#lambda#6(#l2, #l1, #l0), Q#e$1^65.29#tc2) } $in_range_i4(Q#e$1^65.29#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#6(#l2, #l1, #l0), Q#e$1^65.29#tc2) == (if Q#e$1^65.29#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^65.29#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^65.29#tc2));

const unique l#public: $label;

type $map_t..^^i4.^^mathint;

function $select.$map_t..^^i4.^^mathint(M: $map_t..^^i4.^^mathint, p: int) : int;

function $store.$map_t..^^i4.^^mathint(M: $map_t..^^i4.^^mathint, p: int, v: int) : $map_t..^^i4.^^mathint;

function $eq.$map_t..^^i4.^^mathint(M1: $map_t..^^i4.^^mathint, M2: $map_t..^^i4.^^mathint) : bool;

const $zero.$map_t..^^i4.^^mathint: $map_t..^^i4.^^mathint;

axiom (forall M: $map_t..^^i4.^^mathint, p: int, v: int :: true);

axiom (forall M: $map_t..^^i4.^^mathint, p: int, v: int, q: int :: $select.$map_t..^^i4.^^mathint($store.$map_t..^^i4.^^mathint(M, q, v), p) == (if $unchecked(^^i4, p) == $unchecked(^^i4, q) then v else $select.$map_t..^^i4.^^mathint(M, p)));

axiom (forall M1: $map_t..^^i4.^^mathint, M2: $map_t..^^i4.^^mathint :: { $eq.$map_t..^^i4.^^mathint(M1, M2) } (forall p: int :: $select.$map_t..^^i4.^^mathint(M1, $unchecked(^^i4, p)) == $select.$map_t..^^i4.^^mathint(M2, $unchecked(^^i4, p))) ==> $eq.$map_t..^^i4.^^mathint(M1, M2));

axiom (forall M1: $map_t..^^i4.^^mathint, M2: $map_t..^^i4.^^mathint :: { $eq.$map_t..^^i4.^^mathint(M1, M2) } $eq.$map_t..^^i4.^^mathint(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^i4.^^mathint(0) == $zero.$map_t..^^i4.^^mathint;

axiom (forall p: int :: $select.$map_t..^^i4.^^mathint($zero.$map_t..^^i4.^^mathint, p) == 0);

axiom true;

type $map_t..^^u4.$map_t..^^i4.^^mathint;

function $select.$map_t..^^u4.$map_t..^^i4.^^mathint(M: $map_t..^^u4.$map_t..^^i4.^^mathint, p: int) : $map_t..^^i4.^^mathint;

function $store.$map_t..^^u4.$map_t..^^i4.^^mathint(M: $map_t..^^u4.$map_t..^^i4.^^mathint, p: int, v: $map_t..^^i4.^^mathint) : $map_t..^^u4.$map_t..^^i4.^^mathint;

function $eq.$map_t..^^u4.$map_t..^^i4.^^mathint(M1: $map_t..^^u4.$map_t..^^i4.^^mathint, M2: $map_t..^^u4.$map_t..^^i4.^^mathint) : bool;

const $zero.$map_t..^^u4.$map_t..^^i4.^^mathint: $map_t..^^u4.$map_t..^^i4.^^mathint;

axiom (forall M: $map_t..^^u4.$map_t..^^i4.^^mathint, p: int, v: $map_t..^^i4.^^mathint :: true);

axiom (forall M: $map_t..^^u4.$map_t..^^i4.^^mathint, p: int, v: $map_t..^^i4.^^mathint, q: int :: $select.$map_t..^^u4.$map_t..^^i4.^^mathint($store.$map_t..^^u4.$map_t..^^i4.^^mathint(M, q, v), p) == (if $unchecked(^^u4, p) == $unchecked(^^u4, q) then v else $select.$map_t..^^u4.$map_t..^^i4.^^mathint(M, p)));

axiom (forall M1: $map_t..^^u4.$map_t..^^i4.^^mathint, M2: $map_t..^^u4.$map_t..^^i4.^^mathint :: { $eq.$map_t..^^u4.$map_t..^^i4.^^mathint(M1, M2) } (forall p: int :: $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint(M1, $unchecked(^^u4, p)), $select.$map_t..^^u4.$map_t..^^i4.^^mathint(M2, $unchecked(^^u4, p)))) ==> $eq.$map_t..^^u4.$map_t..^^i4.^^mathint(M1, M2));

axiom (forall M1: $map_t..^^u4.$map_t..^^i4.^^mathint, M2: $map_t..^^u4.$map_t..^^i4.^^mathint :: { $eq.$map_t..^^u4.$map_t..^^i4.^^mathint(M1, M2) } $eq.$map_t..^^u4.$map_t..^^i4.^^mathint(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^u4.map_t..^^i4.^^mathint(0) == $zero.$map_t..^^u4.$map_t..^^i4.^^mathint;

axiom (forall p: int :: $select.$map_t..^^u4.$map_t..^^i4.^^mathint($zero.$map_t..^^u4.$map_t..^^i4.^^mathint, p) == $zero.$map_t..^^i4.^^mathint);

axiom true;

type $map_t..^^u4.^^u4;

function $select.$map_t..^^u4.^^u4(M: $map_t..^^u4.^^u4, p: int) : int;

function $store.$map_t..^^u4.^^u4(M: $map_t..^^u4.^^u4, p: int, v: int) : $map_t..^^u4.^^u4;

function $eq.$map_t..^^u4.^^u4(M1: $map_t..^^u4.^^u4, M2: $map_t..^^u4.^^u4) : bool;

const $zero.$map_t..^^u4.^^u4: $map_t..^^u4.^^u4;

axiom (forall M: $map_t..^^u4.^^u4, p: int, v: int :: true);

axiom (forall M: $map_t..^^u4.^^u4, p: int, v: int, q: int :: $select.$map_t..^^u4.^^u4($store.$map_t..^^u4.^^u4(M, q, v), p) == (if $unchecked(^^u4, p) == $unchecked(^^u4, q) then $unchecked(^^u4, v) else $select.$map_t..^^u4.^^u4(M, p)));

axiom (forall M1: $map_t..^^u4.^^u4, M2: $map_t..^^u4.^^u4 :: { $eq.$map_t..^^u4.^^u4(M1, M2) } (forall p: int :: $unchecked(^^u4, $select.$map_t..^^u4.^^u4(M1, $unchecked(^^u4, p))) == $unchecked(^^u4, $select.$map_t..^^u4.^^u4(M2, $unchecked(^^u4, p)))) ==> $eq.$map_t..^^u4.^^u4(M1, M2));

axiom (forall M1: $map_t..^^u4.^^u4, M2: $map_t..^^u4.^^u4 :: { $eq.$map_t..^^u4.^^u4(M1, M2) } $eq.$map_t..^^u4.^^u4(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^u4.^^u4(0) == $zero.$map_t..^^u4.^^u4;

axiom (forall p: int :: $select.$map_t..^^u4.^^u4($zero.$map_t..^^u4.^^u4, p) == 0);

axiom true;

axiom (forall M: $map_t..^^u4.^^u4, p: int :: $in_range_t(^^u4, $select.$map_t..^^u4.^^u4(M, p)));

type $map_t..^^mathint.^^u4;

function $select.$map_t..^^mathint.^^u4(M: $map_t..^^mathint.^^u4, p: int) : int;

function $store.$map_t..^^mathint.^^u4(M: $map_t..^^mathint.^^u4, p: int, v: int) : $map_t..^^mathint.^^u4;

function $eq.$map_t..^^mathint.^^u4(M1: $map_t..^^mathint.^^u4, M2: $map_t..^^mathint.^^u4) : bool;

const $zero.$map_t..^^mathint.^^u4: $map_t..^^mathint.^^u4;

axiom (forall M: $map_t..^^mathint.^^u4, p: int, v: int :: true);

axiom (forall M: $map_t..^^mathint.^^u4, p: int, v: int, q: int :: $select.$map_t..^^mathint.^^u4($store.$map_t..^^mathint.^^u4(M, q, v), p) == (if p == q then $unchecked(^^u4, v) else $select.$map_t..^^mathint.^^u4(M, p)));

axiom (forall M1: $map_t..^^mathint.^^u4, M2: $map_t..^^mathint.^^u4 :: { $eq.$map_t..^^mathint.^^u4(M1, M2) } (forall p: int :: $unchecked(^^u4, $select.$map_t..^^mathint.^^u4(M1, p)) == $unchecked(^^u4, $select.$map_t..^^mathint.^^u4(M2, p))) ==> $eq.$map_t..^^mathint.^^u4(M1, M2));

axiom (forall M1: $map_t..^^mathint.^^u4, M2: $map_t..^^mathint.^^u4 :: { $eq.$map_t..^^mathint.^^u4(M1, M2) } $eq.$map_t..^^mathint.^^u4(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^mathint.^^u4(0) == $zero.$map_t..^^mathint.^^u4;

axiom (forall p: int :: $select.$map_t..^^mathint.^^u4($zero.$map_t..^^mathint.^^u4, p) == 0);

axiom true;

axiom (forall M: $map_t..^^mathint.^^u4, p: int :: $in_range_t(^^u4, $select.$map_t..^^mathint.^^u4(M, p)));

type $map_t..^^i4.$map_t..^^mathint.^^u4;

function $select.$map_t..^^i4.$map_t..^^mathint.^^u4(M: $map_t..^^i4.$map_t..^^mathint.^^u4, p: int) : $map_t..^^mathint.^^u4;

function $store.$map_t..^^i4.$map_t..^^mathint.^^u4(M: $map_t..^^i4.$map_t..^^mathint.^^u4, p: int, v: $map_t..^^mathint.^^u4) : $map_t..^^i4.$map_t..^^mathint.^^u4;

function $eq.$map_t..^^i4.$map_t..^^mathint.^^u4(M1: $map_t..^^i4.$map_t..^^mathint.^^u4, M2: $map_t..^^i4.$map_t..^^mathint.^^u4) : bool;

const $zero.$map_t..^^i4.$map_t..^^mathint.^^u4: $map_t..^^i4.$map_t..^^mathint.^^u4;

axiom (forall M: $map_t..^^i4.$map_t..^^mathint.^^u4, p: int, v: $map_t..^^mathint.^^u4 :: true);

axiom (forall M: $map_t..^^i4.$map_t..^^mathint.^^u4, p: int, v: $map_t..^^mathint.^^u4, q: int :: $select.$map_t..^^i4.$map_t..^^mathint.^^u4($store.$map_t..^^i4.$map_t..^^mathint.^^u4(M, q, v), p) == (if $unchecked(^^i4, p) == $unchecked(^^i4, q) then v else $select.$map_t..^^i4.$map_t..^^mathint.^^u4(M, p)));

axiom (forall M1: $map_t..^^i4.$map_t..^^mathint.^^u4, M2: $map_t..^^i4.$map_t..^^mathint.^^u4 :: { $eq.$map_t..^^i4.$map_t..^^mathint.^^u4(M1, M2) } (forall p: int :: $eq.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(M1, $unchecked(^^i4, p)), $select.$map_t..^^i4.$map_t..^^mathint.^^u4(M2, $unchecked(^^i4, p)))) ==> $eq.$map_t..^^i4.$map_t..^^mathint.^^u4(M1, M2));

axiom (forall M1: $map_t..^^i4.$map_t..^^mathint.^^u4, M2: $map_t..^^i4.$map_t..^^mathint.^^u4 :: { $eq.$map_t..^^i4.$map_t..^^mathint.^^u4(M1, M2) } $eq.$map_t..^^i4.$map_t..^^mathint.^^u4(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^i4.map_t..^^mathint.^^u4(0) == $zero.$map_t..^^i4.$map_t..^^mathint.^^u4;

axiom (forall p: int :: $select.$map_t..^^i4.$map_t..^^mathint.^^u4($zero.$map_t..^^i4.$map_t..^^mathint.^^u4, p) == $zero.$map_t..^^mathint.^^u4);

axiom true;

function $map_t..^^mathint.^^u4_to_int(x: $map_t..^^mathint.^^u4) : int;

function $int_to_map_t..^^mathint.^^u4(x: int) : $map_t..^^mathint.^^u4;

axiom (forall #x: $map_t..^^mathint.^^u4 :: #x == $int_to_map_t..^^mathint.^^u4($map_t..^^mathint.^^u4_to_int(#x)));

const unique #tok$1^65.29: $token;

const unique #tok$1^102.31: $token;

const unique #tok$1^103.43: $token;

const unique #tok$1^144.31: $token;

const unique #tok$1^145.43: $token;

const unique #tok$1^85.37: $token;

const unique #tok$1^207.31: $token;

const unique #loc.#l3: $token;

const unique #tok$1^208.43: $token;

const unique #tok$1^222.43: $token;

const unique #tok$1^225.31: $token;

const unique #loc.#l0: $token;

const unique #loc.#l1: $token;

const unique #loc.#l2: $token;

const unique #tok$1^178.37: $token;

const unique #loc.ite#5: $token;

const unique #loc.ite#4: $token;

const unique #tok$1^328.16: $token;

const unique #loc.tmp#0: $token;

const unique #tok$1^328.5: $token;

const unique #loc.ite#3: $token;

const unique #tok$1^327.16: $token;

const unique #tok$1^327.5: $token;

const unique #tok$1^324.3: $token;

const unique #loc.__temp71610: $token;

const unique #tok$1^322.15: $token;

const unique #distTp15: $ctype;

axiom #distTp15 == $ptr_to(^heapSortTestHarnessstackframe#0);

const unique #loc.addr.#stackframe#0: $token;

const unique #tok$1^322.3: $token;

const unique #tok$1^323.25: $token;

const unique #tok$1^320.1: $token;

const unique #tok$1^316.19: $token;

const unique #loc.prestate#71: $token;

const unique #loc.prestate#69: $token;

const unique #loc.owns#70: $token;

const unique #tok$1^302.24: $token;

function $map_t..^^u4.^^u4_to_int(x: $map_t..^^u4.^^u4) : int;

function $int_to_map_t..^^u4.^^u4(x: int) : $map_t..^^u4.^^u4;

axiom (forall #x: $map_t..^^u4.^^u4 :: #x == $int_to_map_t..^^u4.^^u4($map_t..^^u4.^^u4_to_int(#x)));

const unique #loc.perm: $token;

const unique #tok$1^313.27: $token;

const unique #tok$1^312.5: $token;

const unique #loc.res_extractMin#53: $token;

const unique #tok$1^312.14: $token;

const unique #tok$1^302.3: $token;

const unique #tok$1^303.28: $token;

const unique #tok$1^302.8: $token;

const unique #tok$1^291.24: $token;

const unique #tok$1^299.27: $token;

const unique #tok$1^298.5: $token;

const unique #tok$1^291.3: $token;

axiom $type_code_is(3, ^^mathint);

const unique #tok$1^292.28: $token;

const unique #tok$1^291.8: $token;

const unique #tok$1^289.3: $token;

const unique #loc.addr.h: $token;

const unique #tok$1^282.3: $token;

function $map_t..^^i4.map_t..^^mathint.^^u4_to_int(x: $map_t..^^i4.$map_t..^^mathint.^^u4) : int;

function $int_to_map_t..^^i4.map_t..^^mathint.^^u4(x: int) : $map_t..^^i4.$map_t..^^mathint.^^u4;

axiom (forall #x: $map_t..^^i4.$map_t..^^mathint.^^u4 :: #x == $int_to_map_t..^^i4.map_t..^^mathint.^^u4($map_t..^^i4.map_t..^^mathint.^^u4_to_int(#x)));

const unique #loc.indexes: $token;

const unique #tok$1^283.25: $token;

const unique #distTp14: $ctype;

axiom #distTp14 == $map_t(^^i4, $map_t(^^mathint, ^^u4));

const unique #distTp13: $ctype;

axiom #distTp13 == $map_t(^^mathint, ^^u4);

const unique #loc.len: $token;

const unique #loc.arr: $token;

const unique #tok$1^273.1: $token;

const unique #distTp12: $ctype;

axiom #distTp12 == $map_t(^^u4, ^^u4);

const unique #tok$1^251.19: $token;

const unique #loc.owns#67: $token;

const unique #loc.staticWrapState#66: $token;

const unique #loc.prestate#68: $token;

const unique #tok$1^250.25: $token;

const unique #tok$1^241.7: $token;

const unique #tok$1^240.29: $token;

const unique #loc.res_lambda#31#52: $token;

const unique #tok$1^240.47: $token;

const unique #tok$1^237.7: $token;

const unique #tok$1^236.7: $token;

const unique #tok$1^235.7: $token;

const unique #tok$1^234.7: $token;

const unique #tok$1^232.7: $token;

const unique #loc.ite#2: $token;

const unique #tok$1^231.9: $token;

const unique #tok$1^230.7: $token;

const unique #loc.ite#1: $token;

const unique #tok$1^229.9: $token;

const unique #loc.l: $token;

const unique #loc.r: $token;

const unique #tok$1^227.5: $token;

const unique #loc.smallest: $token;

const unique #tok$1^228.5: $token;

const unique #tok$1^220.3: $token;

const unique #tok$1^223.28: $token;

const unique #tok$1^219.3: $token;

const unique #tok$1^217.25: $token;

const unique #loc.res_lambda#27#51: $token;

const unique #tok$1^217.36: $token;

const unique #tok$1^216.3: $token;

const unique #tok$1^213.5: $token;

const unique #tok$1^212.27: $token;

const unique #loc.res_lambda#26#50: $token;

const unique #tok$1^212.38: $token;

const unique #tok$1^202.3: $token;

const unique #tok$1^206.29: $token;

const unique #tok$1^199.3: $token;

const unique #tok$1^195.25: $token;

const unique #loc.res_lambda#22#49: $token;

const unique #tok$1^195.36: $token;

const unique #tok$1^193.3: $token;

const unique #tok$1^191.3: $token;

const unique #tok$1^189.3: $token;

const unique #tok$1^186.3: $token;

const unique #tok$1^185.19: $token;

const unique #loc.prestate#65: $token;

const unique #loc.prestate#63: $token;

const unique #loc.owns#64: $token;

const unique #loc.res: $token;

const unique #tok$1^181.3: $token;

const unique #loc.last: $token;

const unique #tok$1^182.3: $token;

const unique #tok$1^183.3: $token;

const unique #tok$1^172.1: $token;

const unique #tok$1^169.19: $token;

const unique #loc.owns#61: $token;

const unique #loc.staticWrapState#60: $token;

const unique #loc.prestate#62: $token;

const unique #tok$1^167.5: $token;

const unique #tok$1^166.5: $token;

const unique #loc.res_lambda#20#48: $token;

const unique #tok$1^166.16: $token;

const unique #tok$1^161.5: $token;

const unique #tok$1^160.27: $token;

const unique #loc.res_lambda#19#47: $token;

const unique #tok$1^160.38: $token;

const unique #tok$1^151.5: $token;

const unique #loc.p2#0: $token;

const unique #tok$1^149.5: $token;

const unique #tok$1^139.3: $token;

const unique #tok$1^143.28: $token;

const unique #tok$1^136.5: $token;

const unique #tok$1^135.27: $token;

const unique #loc.res_lambda#15#46: $token;

const unique #tok$1^135.38: $token;

const unique #tok$1^131.7: $token;

const unique #tok$1^130.29: $token;

const unique #loc.res_lambda#14#45: $token;

const unique #tok$1^130.40: $token;

const unique #tok$1^125.7: $token;

const unique #tok$1^124.7: $token;

const unique #tok$1^123.7: $token;

const unique #loc.tmp: $token;

const unique #tok$1^122.7: $token;

const unique #tok$1^108.5: $token;

const unique #loc.p2: $token;

const unique #tok$1^106.5: $token;

const unique #tok$1^97.3: $token;

const unique #tok$1^101.28: $token;

const unique #tok$1^93.3: $token;

const unique #tok$1^92.3: $token;

const unique #tok$1^91.3: $token;

const unique #tok$1^90.19: $token;

const unique #loc.prestate#59: $token;

const unique #loc.prestate#57: $token;

const unique #loc.owns#58: $token;

const unique #loc.p: $token;

const unique #tok$1^88.3: $token;

const unique #loc.elt: $token;

const unique #tok$1^81.1: $token;

const unique #tok$1^78.19: $token;

const unique #loc.owns#55: $token;

const unique #loc.staticWrapState#54: $token;

function $state_to_int(x: $state) : int;

function $int_to_state(x: int) : $state;

axiom (forall #x: $state :: #x == $int_to_state($state_to_int(#x)));

const unique #loc.prestate#56: $token;

const unique #tok$4^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(4, #file^?3Cno?20file?3E);

const unique #tok$1^77.3: $token;

const unique #tok$1^75.5: $token;

const unique #tok$1^74.5: $token;

const unique #loc.res_lambda#8#44: $token;

const unique #loc.res_lambda#9#43: $token;

const unique #tok$1^74.13: $token;

const unique #loc.h: $token;

const unique #tok$1^69.1: $token;

const unique #loc.e: $token;

const unique #tok$1^40.39: $token;

const unique #loc.i: $token;

const unique #tok$1^38.39: $token;

const unique #loc.res__vswprintf_c_l#42: $token;

const unique #tok$3^75.12: $token;

const unique #tok$3^73.1: $token;

const unique #tok$3^66.7: $token;

const unique #tok$3^65.12: $token;

const unique #tok$3^64.7: $token;

const unique #tok$3^62.5: $token;

const unique #tok$3^63.5: $token;

const unique #tok$3^64.30: $token;

const unique #distTp11: $ctype;

axiom #distTp11 == $ptr_to($ptr_to(^localeinfo_struct));

const unique #loc.addr._Plocinfo: $token;

const unique #loc._Plocinfo: $token;

const unique #tok$3^60.1: $token;

const unique #loc.res__vswprintf_c_l#41: $token;

const unique #tok$3^51.12: $token;

const unique #loc._Ap: $token;

const unique #tok$3^49.1: $token;

const unique #tok$3^42.7: $token;

const unique #tok$3^41.12: $token;

const unique #tok$3^40.7: $token;

const unique #loc._Arglist: $token;

const unique #tok$3^38.5: $token;

const unique #loc._Ret: $token;

const unique #tok$3^39.5: $token;

const unique #tok$3^40.30: $token;

const unique #distTp10: $ctype;

axiom #distTp10 == $ptr_to($ptr_to(^^u2));

const unique #loc.addr._Format: $token;

const unique #loc._Count: $token;

const unique #loc._String: $token;

const unique #tok$3^36.1: $token;

const unique #file^c?3A?5CProgram?20Files?20?28x86?29?5CMicrosoft?20Visual?20Studio?2010.0?5CVC?5CINCLUDE?5Cswprintf.inl: $token;

axiom $file_name_is(3, #file^c?3A?5CProgram?20Files?20?28x86?29?5CMicrosoft?20Visual?20Studio?2010.0?5CVC?5CINCLUDE?5Cswprintf.inl);

const unique #loc._ArgList: $token;

const unique #distTp9: $ctype;

axiom #distTp9 == $ptr_to(^localeinfo_struct);

const unique #loc._Locale: $token;

const unique #loc._Format: $token;

const unique #loc._MaxCount: $token;

const unique #loc._DstBuf: $token;

const unique #tok$2^517.3: $token;

const unique #file^c?3A?5CProgram?20Files?20?28x86?29?5CMicrosoft?20Visual?20Studio?2010.0?5CVC?5CINCLUDE?5Cstdio.h: $token;

axiom $file_name_is(2, #file^c?3A?5CProgram?20Files?20?28x86?29?5CMicrosoft?20Visual?20Studio?2010.0?5CVC?5CINCLUDE?5Cstdio.h);

const unique #distTp8: $ctype;

axiom #distTp8 == $ptr_to(^Heap);

const unique #loc._this_: $token;

const unique #tok$1^55.1: $token;

axiom $type_code_is(2, ^^i4);

axiom $type_code_is(1, ^^u4);

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvacid?2D0?5CHeap.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvacid?2D0?5CHeap.c);

function $map_t..^^i4.^^mathint_to_int(x: $map_t..^^i4.^^mathint) : int;

function $int_to_map_t..^^i4.^^mathint(x: int) : $map_t..^^i4.^^mathint;

axiom (forall #x: $map_t..^^i4.^^mathint :: #x == $int_to_map_t..^^i4.^^mathint($map_t..^^i4.^^mathint_to_int(#x)));

function $map_t..^^u4.map_t..^^i4.^^mathint_to_int(x: $map_t..^^u4.$map_t..^^i4.^^mathint) : int;

function $int_to_map_t..^^u4.map_t..^^i4.^^mathint(x: int) : $map_t..^^u4.$map_t..^^i4.^^mathint;

axiom (forall #x: $map_t..^^u4.$map_t..^^i4.^^mathint :: #x == $int_to_map_t..^^u4.map_t..^^i4.^^mathint($map_t..^^u4.map_t..^^i4.^^mathint_to_int(#x)));

const unique #distTp7: $ctype;

axiom #distTp7 == $map_t(^^u4, $map_t(^^i4, ^^mathint));

const unique #distTp6: $ctype;

axiom #distTp6 == $map_t(^^i4, ^^mathint);

const unique #distTp5: $ctype;

axiom #distTp5 == $ptr_to(^^i1);

const unique #distTp4: $ctype;

axiom #distTp4 == $ptr_to(^^u1);

const unique #distTp3: $ctype;

axiom #distTp3 == $ptr_to(^^u2);

const unique #distTp2: $ctype;

axiom #distTp2 == $ptr_to(^^i4);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^threadlocaleinfostruct);
