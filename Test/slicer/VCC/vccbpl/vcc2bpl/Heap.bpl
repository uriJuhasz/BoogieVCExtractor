axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^localeinfo_struct: $ctype;

axiom $is_composite(^localeinfo_struct);

axiom $ptr_level(^localeinfo_struct) == 0;

axiom $sizeof(^localeinfo_struct) == 16;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^localeinfo_struct) } $inv2(#s1, #s2, #p, ^localeinfo_struct) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty())));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^localeinfo_struct, #r), l#public) } $inv_lab(#s2, $ptr(^localeinfo_struct, #r), l#public) == ($typed(#s2, $ptr(^localeinfo_struct, #r)) && $set_eq($owns(#s2, $ptr(^localeinfo_struct, #r)), $set_empty())));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^localeinfo_struct, #r)) } $in_full_extent_of(#q, $ptr(^localeinfo_struct, #r)) == (#q == $ptr(^localeinfo_struct, #r) || #q == $dot($ptr(^localeinfo_struct, #r), localeinfo_struct.$owns) || #q == $dot($ptr(^localeinfo_struct, #r), localeinfo_struct.locinfo) || #q == $dot($ptr(^localeinfo_struct, #r), localeinfo_struct.mbcinfo)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^localeinfo_struct, #r)) } $in_extent_of(#s, #q, $ptr(^localeinfo_struct, #r)) == $in_struct_extent_of(#q, $ptr(^localeinfo_struct, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^localeinfo_struct, #r)) } $typed(#s, $ptr(^localeinfo_struct, #r)) ==> $in_extent_of(#s, #q, $ptr(^localeinfo_struct, #r)) == (#q == $ptr(^localeinfo_struct, #r) || $emb(#s, #q) == $ptr(^localeinfo_struct, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^localeinfo_struct, #r)) } $in_span_of(#q, $ptr(^localeinfo_struct, #r)) == (#q == $ptr(^localeinfo_struct, #r) || #q == $dot($ptr(^localeinfo_struct, #r), localeinfo_struct.$owns) || #q == $dot($ptr(^localeinfo_struct, #r), localeinfo_struct.locinfo) || #q == $dot($ptr(^localeinfo_struct, #r), localeinfo_struct.mbcinfo)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^localeinfo_struct) } $state_spans_the_same(#s1, #s2, #p, ^localeinfo_struct) == ($mem_eq(#s1, #s2, $dot(#p, localeinfo_struct.$owns)) && $mem_eq(#s1, #s2, $dot(#p, localeinfo_struct.locinfo)) && $mem_eq(#s1, #s2, $dot(#p, localeinfo_struct.mbcinfo))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^localeinfo_struct) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^localeinfo_struct) == ($mem_eq(#s1, #s2, $dot(#p, localeinfo_struct.$owns)) && $mem_eq(#s1, #s2, $dot(#p, localeinfo_struct.locinfo)) && $mem_eq(#s1, #s2, $dot(#p, localeinfo_struct.mbcinfo))));

axiom $is_claimable(^localeinfo_struct) == false;

axiom $has_volatile_owns_set(^localeinfo_struct) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^localeinfo_struct, #r)) } $extent_mutable(#s1, $ptr(^localeinfo_struct, #r)) == $mutable(#s1, $ptr(^localeinfo_struct, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^localeinfo_struct, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^localeinfo_struct, #r)) == $is_fresh(#s1, #s2, $ptr(^localeinfo_struct, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^localeinfo_struct, #r)) } $extent_zero(#s1, $ptr(^localeinfo_struct, #r)) == ($mem(#s1, $dot($ptr(^localeinfo_struct, #r), localeinfo_struct.locinfo)) == 0 && $mem(#s1, $dot($ptr(^localeinfo_struct, #r), localeinfo_struct.mbcinfo)) == 0));

const unique localeinfo_struct.$owns: $field;

axiom $static_field_properties(localeinfo_struct.$owns, ^localeinfo_struct);

axiom $is_primitive_non_volatile_field(localeinfo_struct.$owns);

axiom (forall #p: $ptr :: { $dot(#p, localeinfo_struct.$owns) } $is(#p, ^localeinfo_struct) ==> $dot(#p, localeinfo_struct.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, localeinfo_struct.$owns)) && $extent_hint($dot(#p, localeinfo_struct.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, localeinfo_struct.$owns)) } { $st(#s, $dot(#p, localeinfo_struct.$owns)) } $typed2(#s, #p, ^localeinfo_struct) ==> $field_properties(#s, #p, localeinfo_struct.$owns, ^$#ptrset, false));

axiom $owns_set_field(^localeinfo_struct) == localeinfo_struct.$owns;

const unique localeinfo_struct.locinfo: $field;

axiom $static_field_properties(localeinfo_struct.locinfo, ^localeinfo_struct);

axiom $is_primitive_non_volatile_field(localeinfo_struct.locinfo);

axiom $field_offset(localeinfo_struct.locinfo) == 0;

axiom (forall #p: $ptr :: { $dot(#p, localeinfo_struct.locinfo) } $is(#p, ^localeinfo_struct) ==> $dot(#p, localeinfo_struct.locinfo) == $ptr($ptr_to(^threadlocaleinfostruct), $ref(#p) + 0) && $extent_hint($dot(#p, localeinfo_struct.locinfo), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, localeinfo_struct.locinfo)) } { $st(#s, $dot(#p, localeinfo_struct.locinfo)) } $typed2(#s, #p, ^localeinfo_struct) ==> $field_properties(#s, #p, localeinfo_struct.locinfo, $ptr_to(^threadlocaleinfostruct), false));

const unique localeinfo_struct.mbcinfo: $field;

axiom $static_field_properties(localeinfo_struct.mbcinfo, ^localeinfo_struct);

axiom $is_primitive_non_volatile_field(localeinfo_struct.mbcinfo);

axiom $field_offset(localeinfo_struct.mbcinfo) == 8;

axiom (forall #p: $ptr :: { $dot(#p, localeinfo_struct.mbcinfo) } $is(#p, ^localeinfo_struct) ==> $dot(#p, localeinfo_struct.mbcinfo) == $ptr($ptr_to(^^void), $ref(#p) + 8) && $extent_hint($dot(#p, localeinfo_struct.mbcinfo), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, localeinfo_struct.mbcinfo)) } { $st(#s, $dot(#p, localeinfo_struct.mbcinfo)) } $typed2(#s, #p, ^localeinfo_struct) ==> $field_properties(#s, #p, localeinfo_struct.mbcinfo, $ptr_to(^^void), false));

const unique ^threadlocaleinfostruct: $ctype;

axiom $is_composite(^threadlocaleinfostruct);

axiom $ptr_level(^threadlocaleinfostruct) == 0;

axiom $sizeof(^threadlocaleinfostruct) == 352;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^threadlocaleinfostruct) } $inv2(#s1, #s2, #p, ^threadlocaleinfostruct) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty())));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^threadlocaleinfostruct, #r), l#public) } $inv_lab(#s2, $ptr(^threadlocaleinfostruct, #r), l#public) == ($typed(#s2, $ptr(^threadlocaleinfostruct, #r)) && $set_eq($owns(#s2, $ptr(^threadlocaleinfostruct, #r)), $set_empty())));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^threadlocaleinfostruct, #r)) } $in_full_extent_of(#q, $ptr(^threadlocaleinfostruct, #r)) == (#q == $ptr(^threadlocaleinfostruct, #r) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.$owns) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.refcount) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_codepage) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_collate_cp) || $in_array(#q, $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_handle), ^^u4, 6) || $in_array_full_extent_of(#q, $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_id), ^tagLC_ID, 6) || $in_array_full_extent_of(#q, $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_category), ^threadlocaleinfostruct.Heap.c..10972, 6) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_clike) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.mb_cur_max) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lconv_intl_refcount) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lconv_num_refcount) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lconv_mon_refcount) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lconv) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.ctype1_refcount) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.ctype1) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.pctype) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.pclmap) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.pcumap) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_time_curr)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^threadlocaleinfostruct, #r)) } $in_extent_of(#s, #q, $ptr(^threadlocaleinfostruct, #r)) == $in_struct_extent_of(#q, $ptr(^threadlocaleinfostruct, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^threadlocaleinfostruct, #r)) } $in_span_of(#q, $ptr(^threadlocaleinfostruct, #r)) == (#q == $ptr(^threadlocaleinfostruct, #r) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.$owns) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.refcount) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_codepage) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_collate_cp) || $in_array(#q, $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_handle), ^^u4, 6) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_clike) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.mb_cur_max) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lconv_intl_refcount) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lconv_num_refcount) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lconv_mon_refcount) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lconv) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.ctype1_refcount) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.ctype1) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.pctype) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.pclmap) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.pcumap) || #q == $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_time_curr)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^threadlocaleinfostruct) } $state_spans_the_same(#s1, #s2, #p, ^threadlocaleinfostruct) == ($mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.$owns)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.refcount)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.lc_codepage)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.lc_collate_cp)) && (forall #i: int :: { $idx($dot(#p, threadlocaleinfostruct.lc_handle), #i, ^^u4) } $in_range(0, #i, 5) ==> $mem_eq(#s1, #s2, $idx($dot(#p, threadlocaleinfostruct.lc_handle), #i, ^^u4))) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.lc_clike)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.mb_cur_max)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.lconv_intl_refcount)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.lconv_num_refcount)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.lconv_mon_refcount)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.lconv)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.ctype1_refcount)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.ctype1)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.pctype)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.pclmap)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.pcumap)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.lc_time_curr))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^threadlocaleinfostruct) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^threadlocaleinfostruct) == ($mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.$owns)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.refcount)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.lc_codepage)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.lc_collate_cp)) && (forall #i: int :: { $idx($dot(#p, threadlocaleinfostruct.lc_handle), #i, ^^u4) } $in_range(0, #i, 5) ==> $mem_eq(#s1, #s2, $idx($dot(#p, threadlocaleinfostruct.lc_handle), #i, ^^u4))) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.lc_clike)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.mb_cur_max)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.lconv_intl_refcount)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.lconv_num_refcount)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.lconv_mon_refcount)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.lconv)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.ctype1_refcount)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.ctype1)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.pctype)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.pclmap)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.pcumap)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.lc_time_curr))));

axiom $is_claimable(^threadlocaleinfostruct) == false;

axiom $has_volatile_owns_set(^threadlocaleinfostruct) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^threadlocaleinfostruct, #r)) } $extent_mutable(#s1, $ptr(^threadlocaleinfostruct, #r)) == ($mutable(#s1, $ptr(^threadlocaleinfostruct, #r)) && (forall #i: int :: { $idx($dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_handle), #i, ^^u4) } true) && (forall #i: int :: { $idx($dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_id), #i, ^tagLC_ID) } $in_range(0, #i, 5) ==> $extent_mutable(#s1, $idx($dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_id), #i, ^tagLC_ID))) && (forall #i: int :: { $idx($dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_category), #i, ^threadlocaleinfostruct.Heap.c..10972) } $in_range(0, #i, 5) ==> $extent_mutable(#s1, $idx($dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_category), #i, ^threadlocaleinfostruct.Heap.c..10972)))));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^threadlocaleinfostruct, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^threadlocaleinfostruct, #r)) == ($is_fresh(#s1, #s2, $ptr(^threadlocaleinfostruct, #r)) && (forall #i: int :: { $idx($dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_handle), #i, ^^u4) } true) && (forall #i: int :: { $idx($dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_id), #i, ^tagLC_ID) } $in_range(0, #i, 5) ==> $extent_is_fresh(#s1, #s2, $idx($dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_id), #i, ^tagLC_ID))) && (forall #i: int :: { $idx($dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_category), #i, ^threadlocaleinfostruct.Heap.c..10972) } $in_range(0, #i, 5) ==> $extent_is_fresh(#s1, #s2, $idx($dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_category), #i, ^threadlocaleinfostruct.Heap.c..10972)))));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^threadlocaleinfostruct, #r)) } $extent_zero(#s1, $ptr(^threadlocaleinfostruct, #r)) == ($mem(#s1, $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.refcount)) == 0 && $mem(#s1, $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_codepage)) == 0 && $mem(#s1, $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_collate_cp)) == 0 && (forall #i: int :: { $idx($dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_handle), #i, ^^u4) } $in_range(0, #i, 5) ==> $mem(#s1, $idx($dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_handle), #i, ^^u4)) == 0) && (forall #i: int :: { $idx($dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_id), #i, ^tagLC_ID) } $in_range(0, #i, 5) ==> $extent_zero(#s1, $idx($dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_id), #i, ^tagLC_ID))) && (forall #i: int :: { $idx($dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_category), #i, ^threadlocaleinfostruct.Heap.c..10972) } $in_range(0, #i, 5) ==> $extent_zero(#s1, $idx($dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_category), #i, ^threadlocaleinfostruct.Heap.c..10972))) && $mem(#s1, $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_clike)) == 0 && $mem(#s1, $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.mb_cur_max)) == 0 && $mem(#s1, $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lconv_intl_refcount)) == 0 && $mem(#s1, $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lconv_num_refcount)) == 0 && $mem(#s1, $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lconv_mon_refcount)) == 0 && $mem(#s1, $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lconv)) == 0 && $mem(#s1, $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.ctype1_refcount)) == 0 && $mem(#s1, $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.ctype1)) == 0 && $mem(#s1, $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.pctype)) == 0 && $mem(#s1, $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.pclmap)) == 0 && $mem(#s1, $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.pcumap)) == 0 && $mem(#s1, $dot($ptr(^threadlocaleinfostruct, #r), threadlocaleinfostruct.lc_time_curr)) == 0));

const unique threadlocaleinfostruct.$owns: $field;

axiom $static_field_properties(threadlocaleinfostruct.$owns, ^threadlocaleinfostruct);

axiom $is_primitive_non_volatile_field(threadlocaleinfostruct.$owns);

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.$owns) } $is(#p, ^threadlocaleinfostruct) ==> $dot(#p, threadlocaleinfostruct.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, threadlocaleinfostruct.$owns)) && $extent_hint($dot(#p, threadlocaleinfostruct.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, threadlocaleinfostruct.$owns)) } { $st(#s, $dot(#p, threadlocaleinfostruct.$owns)) } $typed2(#s, #p, ^threadlocaleinfostruct) ==> $field_properties(#s, #p, threadlocaleinfostruct.$owns, ^$#ptrset, false));

axiom $owns_set_field(^threadlocaleinfostruct) == threadlocaleinfostruct.$owns;

const unique threadlocaleinfostruct.refcount: $field;

axiom $static_field_properties(threadlocaleinfostruct.refcount, ^threadlocaleinfostruct);

axiom $is_primitive_non_volatile_field(threadlocaleinfostruct.refcount);

axiom $field_offset(threadlocaleinfostruct.refcount) == 0;

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.refcount) } $is(#p, ^threadlocaleinfostruct) ==> $dot(#p, threadlocaleinfostruct.refcount) == $ptr(^^i4, $ref(#p) + 0) && $extent_hint($dot(#p, threadlocaleinfostruct.refcount), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, threadlocaleinfostruct.refcount)) } { $st(#s, $dot(#p, threadlocaleinfostruct.refcount)) } $typed2(#s, #p, ^threadlocaleinfostruct) ==> $field_properties(#s, #p, threadlocaleinfostruct.refcount, ^^i4, false));

const unique threadlocaleinfostruct.lc_codepage: $field;

axiom $static_field_properties(threadlocaleinfostruct.lc_codepage, ^threadlocaleinfostruct);

axiom $is_primitive_non_volatile_field(threadlocaleinfostruct.lc_codepage);

axiom $field_offset(threadlocaleinfostruct.lc_codepage) == 4;

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.lc_codepage) } $is(#p, ^threadlocaleinfostruct) ==> $dot(#p, threadlocaleinfostruct.lc_codepage) == $ptr(^^u4, $ref(#p) + 4) && $extent_hint($dot(#p, threadlocaleinfostruct.lc_codepage), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, threadlocaleinfostruct.lc_codepage)) } { $st(#s, $dot(#p, threadlocaleinfostruct.lc_codepage)) } $typed2(#s, #p, ^threadlocaleinfostruct) ==> $field_properties(#s, #p, threadlocaleinfostruct.lc_codepage, ^^u4, false));

const unique threadlocaleinfostruct.lc_collate_cp: $field;

axiom $static_field_properties(threadlocaleinfostruct.lc_collate_cp, ^threadlocaleinfostruct);

axiom $is_primitive_non_volatile_field(threadlocaleinfostruct.lc_collate_cp);

axiom $field_offset(threadlocaleinfostruct.lc_collate_cp) == 8;

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.lc_collate_cp) } $is(#p, ^threadlocaleinfostruct) ==> $dot(#p, threadlocaleinfostruct.lc_collate_cp) == $ptr(^^u4, $ref(#p) + 8) && $extent_hint($dot(#p, threadlocaleinfostruct.lc_collate_cp), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, threadlocaleinfostruct.lc_collate_cp)) } { $st(#s, $dot(#p, threadlocaleinfostruct.lc_collate_cp)) } $typed2(#s, #p, ^threadlocaleinfostruct) ==> $field_properties(#s, #p, threadlocaleinfostruct.lc_collate_cp, ^^u4, false));

const unique threadlocaleinfostruct.lc_handle: $field;

axiom $static_field_properties(threadlocaleinfostruct.lc_handle, ^threadlocaleinfostruct);

axiom $is_primitive_embedded_array(threadlocaleinfostruct.lc_handle, 6);

axiom $embedded_array_size(threadlocaleinfostruct.lc_handle, ^^u4) == 6;

axiom $field_offset(threadlocaleinfostruct.lc_handle) == 12;

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.lc_handle) } $is(#p, ^threadlocaleinfostruct) ==> $dot(#p, threadlocaleinfostruct.lc_handle) == $ptr(^^u4, $ref(#p) + 12) && $extent_hint($dot(#p, threadlocaleinfostruct.lc_handle), #p));

axiom $array_field_properties(threadlocaleinfostruct.lc_handle, ^^u4, 6, false, false);

const unique threadlocaleinfostruct.lc_id: $field;

axiom $static_field_properties(threadlocaleinfostruct.lc_id, ^threadlocaleinfostruct);

axiom $embedded_array_size(threadlocaleinfostruct.lc_id, ^tagLC_ID) == 6;

axiom $field_offset(threadlocaleinfostruct.lc_id) == 36;

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.lc_id) } $is(#p, ^threadlocaleinfostruct) ==> $dot(#p, threadlocaleinfostruct.lc_id) == $ptr(^tagLC_ID, $ref(#p) + 36) && $extent_hint($dot(#p, threadlocaleinfostruct.lc_id), #p));

axiom $array_field_properties(threadlocaleinfostruct.lc_id, ^tagLC_ID, 6, false, false);

const unique threadlocaleinfostruct.lc_category: $field;

axiom $static_field_properties(threadlocaleinfostruct.lc_category, ^threadlocaleinfostruct);

axiom $embedded_array_size(threadlocaleinfostruct.lc_category, ^threadlocaleinfostruct.Heap.c..10972) == 6;

axiom $field_offset(threadlocaleinfostruct.lc_category) == 72;

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.lc_category) } $is(#p, ^threadlocaleinfostruct) ==> $dot(#p, threadlocaleinfostruct.lc_category) == $ptr(^threadlocaleinfostruct.Heap.c..10972, $ref(#p) + 72) && $extent_hint($dot(#p, threadlocaleinfostruct.lc_category), #p));

axiom $array_field_properties(threadlocaleinfostruct.lc_category, ^threadlocaleinfostruct.Heap.c..10972, 6, false, false);

const unique threadlocaleinfostruct.lc_clike: $field;

axiom $static_field_properties(threadlocaleinfostruct.lc_clike, ^threadlocaleinfostruct);

axiom $is_primitive_non_volatile_field(threadlocaleinfostruct.lc_clike);

axiom $field_offset(threadlocaleinfostruct.lc_clike) == 264;

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.lc_clike) } $is(#p, ^threadlocaleinfostruct) ==> $dot(#p, threadlocaleinfostruct.lc_clike) == $ptr(^^i4, $ref(#p) + 264) && $extent_hint($dot(#p, threadlocaleinfostruct.lc_clike), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, threadlocaleinfostruct.lc_clike)) } { $st(#s, $dot(#p, threadlocaleinfostruct.lc_clike)) } $typed2(#s, #p, ^threadlocaleinfostruct) ==> $field_properties(#s, #p, threadlocaleinfostruct.lc_clike, ^^i4, false));

const unique threadlocaleinfostruct.mb_cur_max: $field;

axiom $static_field_properties(threadlocaleinfostruct.mb_cur_max, ^threadlocaleinfostruct);

axiom $is_primitive_non_volatile_field(threadlocaleinfostruct.mb_cur_max);

axiom $field_offset(threadlocaleinfostruct.mb_cur_max) == 268;

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.mb_cur_max) } $is(#p, ^threadlocaleinfostruct) ==> $dot(#p, threadlocaleinfostruct.mb_cur_max) == $ptr(^^i4, $ref(#p) + 268) && $extent_hint($dot(#p, threadlocaleinfostruct.mb_cur_max), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, threadlocaleinfostruct.mb_cur_max)) } { $st(#s, $dot(#p, threadlocaleinfostruct.mb_cur_max)) } $typed2(#s, #p, ^threadlocaleinfostruct) ==> $field_properties(#s, #p, threadlocaleinfostruct.mb_cur_max, ^^i4, false));

const unique threadlocaleinfostruct.lconv_intl_refcount: $field;

axiom $static_field_properties(threadlocaleinfostruct.lconv_intl_refcount, ^threadlocaleinfostruct);

axiom $is_primitive_non_volatile_field(threadlocaleinfostruct.lconv_intl_refcount);

axiom $field_offset(threadlocaleinfostruct.lconv_intl_refcount) == 272;

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.lconv_intl_refcount) } $is(#p, ^threadlocaleinfostruct) ==> $dot(#p, threadlocaleinfostruct.lconv_intl_refcount) == $ptr($ptr_to(^^i4), $ref(#p) + 272) && $extent_hint($dot(#p, threadlocaleinfostruct.lconv_intl_refcount), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, threadlocaleinfostruct.lconv_intl_refcount)) } { $st(#s, $dot(#p, threadlocaleinfostruct.lconv_intl_refcount)) } $typed2(#s, #p, ^threadlocaleinfostruct) ==> $field_properties(#s, #p, threadlocaleinfostruct.lconv_intl_refcount, $ptr_to(^^i4), false));

const unique threadlocaleinfostruct.lconv_num_refcount: $field;

axiom $static_field_properties(threadlocaleinfostruct.lconv_num_refcount, ^threadlocaleinfostruct);

axiom $is_primitive_non_volatile_field(threadlocaleinfostruct.lconv_num_refcount);

axiom $field_offset(threadlocaleinfostruct.lconv_num_refcount) == 280;

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.lconv_num_refcount) } $is(#p, ^threadlocaleinfostruct) ==> $dot(#p, threadlocaleinfostruct.lconv_num_refcount) == $ptr($ptr_to(^^i4), $ref(#p) + 280) && $extent_hint($dot(#p, threadlocaleinfostruct.lconv_num_refcount), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, threadlocaleinfostruct.lconv_num_refcount)) } { $st(#s, $dot(#p, threadlocaleinfostruct.lconv_num_refcount)) } $typed2(#s, #p, ^threadlocaleinfostruct) ==> $field_properties(#s, #p, threadlocaleinfostruct.lconv_num_refcount, $ptr_to(^^i4), false));

const unique threadlocaleinfostruct.lconv_mon_refcount: $field;

axiom $static_field_properties(threadlocaleinfostruct.lconv_mon_refcount, ^threadlocaleinfostruct);

axiom $is_primitive_non_volatile_field(threadlocaleinfostruct.lconv_mon_refcount);

axiom $field_offset(threadlocaleinfostruct.lconv_mon_refcount) == 288;

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.lconv_mon_refcount) } $is(#p, ^threadlocaleinfostruct) ==> $dot(#p, threadlocaleinfostruct.lconv_mon_refcount) == $ptr($ptr_to(^^i4), $ref(#p) + 288) && $extent_hint($dot(#p, threadlocaleinfostruct.lconv_mon_refcount), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, threadlocaleinfostruct.lconv_mon_refcount)) } { $st(#s, $dot(#p, threadlocaleinfostruct.lconv_mon_refcount)) } $typed2(#s, #p, ^threadlocaleinfostruct) ==> $field_properties(#s, #p, threadlocaleinfostruct.lconv_mon_refcount, $ptr_to(^^i4), false));

const unique threadlocaleinfostruct.lconv: $field;

axiom $static_field_properties(threadlocaleinfostruct.lconv, ^threadlocaleinfostruct);

axiom $is_primitive_non_volatile_field(threadlocaleinfostruct.lconv);

axiom $field_offset(threadlocaleinfostruct.lconv) == 296;

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.lconv) } $is(#p, ^threadlocaleinfostruct) ==> $dot(#p, threadlocaleinfostruct.lconv) == $ptr($ptr_to(^^void), $ref(#p) + 296) && $extent_hint($dot(#p, threadlocaleinfostruct.lconv), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, threadlocaleinfostruct.lconv)) } { $st(#s, $dot(#p, threadlocaleinfostruct.lconv)) } $typed2(#s, #p, ^threadlocaleinfostruct) ==> $field_properties(#s, #p, threadlocaleinfostruct.lconv, $ptr_to(^^void), false));

const unique threadlocaleinfostruct.ctype1_refcount: $field;

axiom $static_field_properties(threadlocaleinfostruct.ctype1_refcount, ^threadlocaleinfostruct);

axiom $is_primitive_non_volatile_field(threadlocaleinfostruct.ctype1_refcount);

axiom $field_offset(threadlocaleinfostruct.ctype1_refcount) == 304;

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.ctype1_refcount) } $is(#p, ^threadlocaleinfostruct) ==> $dot(#p, threadlocaleinfostruct.ctype1_refcount) == $ptr($ptr_to(^^i4), $ref(#p) + 304) && $extent_hint($dot(#p, threadlocaleinfostruct.ctype1_refcount), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, threadlocaleinfostruct.ctype1_refcount)) } { $st(#s, $dot(#p, threadlocaleinfostruct.ctype1_refcount)) } $typed2(#s, #p, ^threadlocaleinfostruct) ==> $field_properties(#s, #p, threadlocaleinfostruct.ctype1_refcount, $ptr_to(^^i4), false));

const unique threadlocaleinfostruct.ctype1: $field;

axiom $static_field_properties(threadlocaleinfostruct.ctype1, ^threadlocaleinfostruct);

axiom $is_primitive_non_volatile_field(threadlocaleinfostruct.ctype1);

axiom $field_offset(threadlocaleinfostruct.ctype1) == 312;

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.ctype1) } $is(#p, ^threadlocaleinfostruct) ==> $dot(#p, threadlocaleinfostruct.ctype1) == $ptr($ptr_to(^^u2), $ref(#p) + 312) && $extent_hint($dot(#p, threadlocaleinfostruct.ctype1), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, threadlocaleinfostruct.ctype1)) } { $st(#s, $dot(#p, threadlocaleinfostruct.ctype1)) } $typed2(#s, #p, ^threadlocaleinfostruct) ==> $field_properties(#s, #p, threadlocaleinfostruct.ctype1, $ptr_to(^^u2), false));

const unique threadlocaleinfostruct.pctype: $field;

axiom $static_field_properties(threadlocaleinfostruct.pctype, ^threadlocaleinfostruct);

axiom $is_primitive_non_volatile_field(threadlocaleinfostruct.pctype);

axiom $field_offset(threadlocaleinfostruct.pctype) == 320;

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.pctype) } $is(#p, ^threadlocaleinfostruct) ==> $dot(#p, threadlocaleinfostruct.pctype) == $ptr($ptr_to(^^u2), $ref(#p) + 320) && $extent_hint($dot(#p, threadlocaleinfostruct.pctype), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, threadlocaleinfostruct.pctype)) } { $st(#s, $dot(#p, threadlocaleinfostruct.pctype)) } $typed2(#s, #p, ^threadlocaleinfostruct) ==> $field_properties(#s, #p, threadlocaleinfostruct.pctype, $ptr_to(^^u2), false));

const unique threadlocaleinfostruct.pclmap: $field;

axiom $static_field_properties(threadlocaleinfostruct.pclmap, ^threadlocaleinfostruct);

axiom $is_primitive_non_volatile_field(threadlocaleinfostruct.pclmap);

axiom $field_offset(threadlocaleinfostruct.pclmap) == 328;

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.pclmap) } $is(#p, ^threadlocaleinfostruct) ==> $dot(#p, threadlocaleinfostruct.pclmap) == $ptr($ptr_to(^^u1), $ref(#p) + 328) && $extent_hint($dot(#p, threadlocaleinfostruct.pclmap), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, threadlocaleinfostruct.pclmap)) } { $st(#s, $dot(#p, threadlocaleinfostruct.pclmap)) } $typed2(#s, #p, ^threadlocaleinfostruct) ==> $field_properties(#s, #p, threadlocaleinfostruct.pclmap, $ptr_to(^^u1), false));

const unique threadlocaleinfostruct.pcumap: $field;

axiom $static_field_properties(threadlocaleinfostruct.pcumap, ^threadlocaleinfostruct);

axiom $is_primitive_non_volatile_field(threadlocaleinfostruct.pcumap);

axiom $field_offset(threadlocaleinfostruct.pcumap) == 336;

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.pcumap) } $is(#p, ^threadlocaleinfostruct) ==> $dot(#p, threadlocaleinfostruct.pcumap) == $ptr($ptr_to(^^u1), $ref(#p) + 336) && $extent_hint($dot(#p, threadlocaleinfostruct.pcumap), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, threadlocaleinfostruct.pcumap)) } { $st(#s, $dot(#p, threadlocaleinfostruct.pcumap)) } $typed2(#s, #p, ^threadlocaleinfostruct) ==> $field_properties(#s, #p, threadlocaleinfostruct.pcumap, $ptr_to(^^u1), false));

const unique threadlocaleinfostruct.lc_time_curr: $field;

axiom $static_field_properties(threadlocaleinfostruct.lc_time_curr, ^threadlocaleinfostruct);

axiom $is_primitive_non_volatile_field(threadlocaleinfostruct.lc_time_curr);

axiom $field_offset(threadlocaleinfostruct.lc_time_curr) == 344;

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.lc_time_curr) } $is(#p, ^threadlocaleinfostruct) ==> $dot(#p, threadlocaleinfostruct.lc_time_curr) == $ptr($ptr_to(^^void), $ref(#p) + 344) && $extent_hint($dot(#p, threadlocaleinfostruct.lc_time_curr), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, threadlocaleinfostruct.lc_time_curr)) } { $st(#s, $dot(#p, threadlocaleinfostruct.lc_time_curr)) } $typed2(#s, #p, ^threadlocaleinfostruct) ==> $field_properties(#s, #p, threadlocaleinfostruct.lc_time_curr, $ptr_to(^^void), false));

const unique ^tagLC_ID: $ctype;

axiom $is_composite(^tagLC_ID);

axiom $ptr_level(^tagLC_ID) == 0;

axiom $sizeof(^tagLC_ID) == 6;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^tagLC_ID) } $inv2(#s1, #s2, #p, ^tagLC_ID) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty())));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^tagLC_ID, #r), l#public) } $inv_lab(#s2, $ptr(^tagLC_ID, #r), l#public) == ($typed(#s2, $ptr(^tagLC_ID, #r)) && $set_eq($owns(#s2, $ptr(^tagLC_ID, #r)), $set_empty())));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^tagLC_ID, #r)) } $in_full_extent_of(#q, $ptr(^tagLC_ID, #r)) == (#q == $ptr(^tagLC_ID, #r) || #q == $dot($ptr(^tagLC_ID, #r), tagLC_ID.$owns) || #q == $dot($ptr(^tagLC_ID, #r), tagLC_ID.wLanguage) || #q == $dot($ptr(^tagLC_ID, #r), tagLC_ID.wCountry) || #q == $dot($ptr(^tagLC_ID, #r), tagLC_ID.wCodePage)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^tagLC_ID, #r)) } $in_extent_of(#s, #q, $ptr(^tagLC_ID, #r)) == $in_struct_extent_of(#q, $ptr(^tagLC_ID, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^tagLC_ID, #r)) } $typed(#s, $ptr(^tagLC_ID, #r)) ==> $in_extent_of(#s, #q, $ptr(^tagLC_ID, #r)) == (#q == $ptr(^tagLC_ID, #r) || $emb(#s, #q) == $ptr(^tagLC_ID, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^tagLC_ID, #r)) } $in_span_of(#q, $ptr(^tagLC_ID, #r)) == (#q == $ptr(^tagLC_ID, #r) || #q == $dot($ptr(^tagLC_ID, #r), tagLC_ID.$owns) || #q == $dot($ptr(^tagLC_ID, #r), tagLC_ID.wLanguage) || #q == $dot($ptr(^tagLC_ID, #r), tagLC_ID.wCountry) || #q == $dot($ptr(^tagLC_ID, #r), tagLC_ID.wCodePage)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^tagLC_ID) } $state_spans_the_same(#s1, #s2, #p, ^tagLC_ID) == ($mem_eq(#s1, #s2, $dot(#p, tagLC_ID.$owns)) && $mem_eq(#s1, #s2, $dot(#p, tagLC_ID.wLanguage)) && $mem_eq(#s1, #s2, $dot(#p, tagLC_ID.wCountry)) && $mem_eq(#s1, #s2, $dot(#p, tagLC_ID.wCodePage))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^tagLC_ID) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^tagLC_ID) == ($mem_eq(#s1, #s2, $dot(#p, tagLC_ID.$owns)) && $mem_eq(#s1, #s2, $dot(#p, tagLC_ID.wLanguage)) && $mem_eq(#s1, #s2, $dot(#p, tagLC_ID.wCountry)) && $mem_eq(#s1, #s2, $dot(#p, tagLC_ID.wCodePage))));

axiom $is_claimable(^tagLC_ID) == false;

axiom $has_volatile_owns_set(^tagLC_ID) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^tagLC_ID, #r)) } $extent_mutable(#s1, $ptr(^tagLC_ID, #r)) == $mutable(#s1, $ptr(^tagLC_ID, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^tagLC_ID, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^tagLC_ID, #r)) == $is_fresh(#s1, #s2, $ptr(^tagLC_ID, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^tagLC_ID, #r)) } $extent_zero(#s1, $ptr(^tagLC_ID, #r)) == ($mem(#s1, $dot($ptr(^tagLC_ID, #r), tagLC_ID.wLanguage)) == 0 && $mem(#s1, $dot($ptr(^tagLC_ID, #r), tagLC_ID.wCountry)) == 0 && $mem(#s1, $dot($ptr(^tagLC_ID, #r), tagLC_ID.wCodePage)) == 0));

const unique tagLC_ID.$owns: $field;

axiom $static_field_properties(tagLC_ID.$owns, ^tagLC_ID);

axiom $is_primitive_non_volatile_field(tagLC_ID.$owns);

axiom (forall #p: $ptr :: { $dot(#p, tagLC_ID.$owns) } $is(#p, ^tagLC_ID) ==> $dot(#p, tagLC_ID.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, tagLC_ID.$owns)) && $extent_hint($dot(#p, tagLC_ID.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, tagLC_ID.$owns)) } { $st(#s, $dot(#p, tagLC_ID.$owns)) } $typed2(#s, #p, ^tagLC_ID) ==> $field_properties(#s, #p, tagLC_ID.$owns, ^$#ptrset, false));

axiom $owns_set_field(^tagLC_ID) == tagLC_ID.$owns;

const unique tagLC_ID.wLanguage: $field;

axiom $static_field_properties(tagLC_ID.wLanguage, ^tagLC_ID);

axiom $is_primitive_non_volatile_field(tagLC_ID.wLanguage);

axiom $field_offset(tagLC_ID.wLanguage) == 0;

axiom (forall #p: $ptr :: { $dot(#p, tagLC_ID.wLanguage) } $is(#p, ^tagLC_ID) ==> $dot(#p, tagLC_ID.wLanguage) == $ptr(^^u2, $ref(#p) + 0) && $extent_hint($dot(#p, tagLC_ID.wLanguage), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, tagLC_ID.wLanguage)) } { $st(#s, $dot(#p, tagLC_ID.wLanguage)) } $typed2(#s, #p, ^tagLC_ID) ==> $field_properties(#s, #p, tagLC_ID.wLanguage, ^^u2, false));

const unique tagLC_ID.wCountry: $field;

axiom $static_field_properties(tagLC_ID.wCountry, ^tagLC_ID);

axiom $is_primitive_non_volatile_field(tagLC_ID.wCountry);

axiom $field_offset(tagLC_ID.wCountry) == 2;

axiom (forall #p: $ptr :: { $dot(#p, tagLC_ID.wCountry) } $is(#p, ^tagLC_ID) ==> $dot(#p, tagLC_ID.wCountry) == $ptr(^^u2, $ref(#p) + 2) && $extent_hint($dot(#p, tagLC_ID.wCountry), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, tagLC_ID.wCountry)) } { $st(#s, $dot(#p, tagLC_ID.wCountry)) } $typed2(#s, #p, ^tagLC_ID) ==> $field_properties(#s, #p, tagLC_ID.wCountry, ^^u2, false));

const unique tagLC_ID.wCodePage: $field;

axiom $static_field_properties(tagLC_ID.wCodePage, ^tagLC_ID);

axiom $is_primitive_non_volatile_field(tagLC_ID.wCodePage);

axiom $field_offset(tagLC_ID.wCodePage) == 4;

axiom (forall #p: $ptr :: { $dot(#p, tagLC_ID.wCodePage) } $is(#p, ^tagLC_ID) ==> $dot(#p, tagLC_ID.wCodePage) == $ptr(^^u2, $ref(#p) + 4) && $extent_hint($dot(#p, tagLC_ID.wCodePage), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, tagLC_ID.wCodePage)) } { $st(#s, $dot(#p, tagLC_ID.wCodePage)) } $typed2(#s, #p, ^tagLC_ID) ==> $field_properties(#s, #p, tagLC_ID.wCodePage, ^^u2, false));

const unique ^threadlocaleinfostruct.Heap.c..10972: $ctype;

axiom $is_composite(^threadlocaleinfostruct.Heap.c..10972);

axiom $ptr_level(^threadlocaleinfostruct.Heap.c..10972) == 0;

axiom $sizeof(^threadlocaleinfostruct.Heap.c..10972) == 32;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^threadlocaleinfostruct.Heap.c..10972) } $inv2(#s1, #s2, #p, ^threadlocaleinfostruct.Heap.c..10972) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty())));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^threadlocaleinfostruct.Heap.c..10972, #r), l#public) } $inv_lab(#s2, $ptr(^threadlocaleinfostruct.Heap.c..10972, #r), l#public) == ($typed(#s2, $ptr(^threadlocaleinfostruct.Heap.c..10972, #r)) && $set_eq($owns(#s2, $ptr(^threadlocaleinfostruct.Heap.c..10972, #r)), $set_empty())));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^threadlocaleinfostruct.Heap.c..10972, #r)) } $in_full_extent_of(#q, $ptr(^threadlocaleinfostruct.Heap.c..10972, #r)) == (#q == $ptr(^threadlocaleinfostruct.Heap.c..10972, #r) || #q == $dot($ptr(^threadlocaleinfostruct.Heap.c..10972, #r), threadlocaleinfostruct.Heap.c..10972.$owns) || #q == $dot($ptr(^threadlocaleinfostruct.Heap.c..10972, #r), threadlocaleinfostruct.Heap.c..10972.locale) || #q == $dot($ptr(^threadlocaleinfostruct.Heap.c..10972, #r), threadlocaleinfostruct.Heap.c..10972.wlocale) || #q == $dot($ptr(^threadlocaleinfostruct.Heap.c..10972, #r), threadlocaleinfostruct.Heap.c..10972.refcount) || #q == $dot($ptr(^threadlocaleinfostruct.Heap.c..10972, #r), threadlocaleinfostruct.Heap.c..10972.wrefcount)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^threadlocaleinfostruct.Heap.c..10972, #r)) } $in_extent_of(#s, #q, $ptr(^threadlocaleinfostruct.Heap.c..10972, #r)) == $in_struct_extent_of(#q, $ptr(^threadlocaleinfostruct.Heap.c..10972, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^threadlocaleinfostruct.Heap.c..10972, #r)) } $typed(#s, $ptr(^threadlocaleinfostruct.Heap.c..10972, #r)) ==> $in_extent_of(#s, #q, $ptr(^threadlocaleinfostruct.Heap.c..10972, #r)) == (#q == $ptr(^threadlocaleinfostruct.Heap.c..10972, #r) || $emb(#s, #q) == $ptr(^threadlocaleinfostruct.Heap.c..10972, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^threadlocaleinfostruct.Heap.c..10972, #r)) } $in_span_of(#q, $ptr(^threadlocaleinfostruct.Heap.c..10972, #r)) == (#q == $ptr(^threadlocaleinfostruct.Heap.c..10972, #r) || #q == $dot($ptr(^threadlocaleinfostruct.Heap.c..10972, #r), threadlocaleinfostruct.Heap.c..10972.$owns) || #q == $dot($ptr(^threadlocaleinfostruct.Heap.c..10972, #r), threadlocaleinfostruct.Heap.c..10972.locale) || #q == $dot($ptr(^threadlocaleinfostruct.Heap.c..10972, #r), threadlocaleinfostruct.Heap.c..10972.wlocale) || #q == $dot($ptr(^threadlocaleinfostruct.Heap.c..10972, #r), threadlocaleinfostruct.Heap.c..10972.refcount) || #q == $dot($ptr(^threadlocaleinfostruct.Heap.c..10972, #r), threadlocaleinfostruct.Heap.c..10972.wrefcount)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^threadlocaleinfostruct.Heap.c..10972) } $state_spans_the_same(#s1, #s2, #p, ^threadlocaleinfostruct.Heap.c..10972) == ($mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.Heap.c..10972.$owns)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.Heap.c..10972.locale)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.Heap.c..10972.wlocale)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.Heap.c..10972.refcount)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.Heap.c..10972.wrefcount))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^threadlocaleinfostruct.Heap.c..10972) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^threadlocaleinfostruct.Heap.c..10972) == ($mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.Heap.c..10972.$owns)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.Heap.c..10972.locale)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.Heap.c..10972.wlocale)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.Heap.c..10972.refcount)) && $mem_eq(#s1, #s2, $dot(#p, threadlocaleinfostruct.Heap.c..10972.wrefcount))));

axiom $is_claimable(^threadlocaleinfostruct.Heap.c..10972) == false;

axiom $has_volatile_owns_set(^threadlocaleinfostruct.Heap.c..10972) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^threadlocaleinfostruct.Heap.c..10972, #r)) } $extent_mutable(#s1, $ptr(^threadlocaleinfostruct.Heap.c..10972, #r)) == $mutable(#s1, $ptr(^threadlocaleinfostruct.Heap.c..10972, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^threadlocaleinfostruct.Heap.c..10972, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^threadlocaleinfostruct.Heap.c..10972, #r)) == $is_fresh(#s1, #s2, $ptr(^threadlocaleinfostruct.Heap.c..10972, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^threadlocaleinfostruct.Heap.c..10972, #r)) } $extent_zero(#s1, $ptr(^threadlocaleinfostruct.Heap.c..10972, #r)) == ($mem(#s1, $dot($ptr(^threadlocaleinfostruct.Heap.c..10972, #r), threadlocaleinfostruct.Heap.c..10972.locale)) == 0 && $mem(#s1, $dot($ptr(^threadlocaleinfostruct.Heap.c..10972, #r), threadlocaleinfostruct.Heap.c..10972.wlocale)) == 0 && $mem(#s1, $dot($ptr(^threadlocaleinfostruct.Heap.c..10972, #r), threadlocaleinfostruct.Heap.c..10972.refcount)) == 0 && $mem(#s1, $dot($ptr(^threadlocaleinfostruct.Heap.c..10972, #r), threadlocaleinfostruct.Heap.c..10972.wrefcount)) == 0));

const unique threadlocaleinfostruct.Heap.c..10972.$owns: $field;

axiom $static_field_properties(threadlocaleinfostruct.Heap.c..10972.$owns, ^threadlocaleinfostruct.Heap.c..10972);

axiom $is_primitive_non_volatile_field(threadlocaleinfostruct.Heap.c..10972.$owns);

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.Heap.c..10972.$owns) } $is(#p, ^threadlocaleinfostruct.Heap.c..10972) ==> $dot(#p, threadlocaleinfostruct.Heap.c..10972.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, threadlocaleinfostruct.Heap.c..10972.$owns)) && $extent_hint($dot(#p, threadlocaleinfostruct.Heap.c..10972.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, threadlocaleinfostruct.Heap.c..10972.$owns)) } { $st(#s, $dot(#p, threadlocaleinfostruct.Heap.c..10972.$owns)) } $typed2(#s, #p, ^threadlocaleinfostruct.Heap.c..10972) ==> $field_properties(#s, #p, threadlocaleinfostruct.Heap.c..10972.$owns, ^$#ptrset, false));

axiom $owns_set_field(^threadlocaleinfostruct.Heap.c..10972) == threadlocaleinfostruct.Heap.c..10972.$owns;

const unique threadlocaleinfostruct.Heap.c..10972.locale: $field;

axiom $static_field_properties(threadlocaleinfostruct.Heap.c..10972.locale, ^threadlocaleinfostruct.Heap.c..10972);

axiom $is_primitive_non_volatile_field(threadlocaleinfostruct.Heap.c..10972.locale);

axiom $field_offset(threadlocaleinfostruct.Heap.c..10972.locale) == 0;

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.Heap.c..10972.locale) } $is(#p, ^threadlocaleinfostruct.Heap.c..10972) ==> $dot(#p, threadlocaleinfostruct.Heap.c..10972.locale) == $ptr($ptr_to(^^i1), $ref(#p) + 0) && $extent_hint($dot(#p, threadlocaleinfostruct.Heap.c..10972.locale), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, threadlocaleinfostruct.Heap.c..10972.locale)) } { $st(#s, $dot(#p, threadlocaleinfostruct.Heap.c..10972.locale)) } $typed2(#s, #p, ^threadlocaleinfostruct.Heap.c..10972) ==> $field_properties(#s, #p, threadlocaleinfostruct.Heap.c..10972.locale, $ptr_to(^^i1), false));

const unique threadlocaleinfostruct.Heap.c..10972.wlocale: $field;

axiom $static_field_properties(threadlocaleinfostruct.Heap.c..10972.wlocale, ^threadlocaleinfostruct.Heap.c..10972);

axiom $is_primitive_non_volatile_field(threadlocaleinfostruct.Heap.c..10972.wlocale);

axiom $field_offset(threadlocaleinfostruct.Heap.c..10972.wlocale) == 8;

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.Heap.c..10972.wlocale) } $is(#p, ^threadlocaleinfostruct.Heap.c..10972) ==> $dot(#p, threadlocaleinfostruct.Heap.c..10972.wlocale) == $ptr($ptr_to(^^u2), $ref(#p) + 8) && $extent_hint($dot(#p, threadlocaleinfostruct.Heap.c..10972.wlocale), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, threadlocaleinfostruct.Heap.c..10972.wlocale)) } { $st(#s, $dot(#p, threadlocaleinfostruct.Heap.c..10972.wlocale)) } $typed2(#s, #p, ^threadlocaleinfostruct.Heap.c..10972) ==> $field_properties(#s, #p, threadlocaleinfostruct.Heap.c..10972.wlocale, $ptr_to(^^u2), false));

const unique threadlocaleinfostruct.Heap.c..10972.refcount: $field;

axiom $static_field_properties(threadlocaleinfostruct.Heap.c..10972.refcount, ^threadlocaleinfostruct.Heap.c..10972);

axiom $is_primitive_non_volatile_field(threadlocaleinfostruct.Heap.c..10972.refcount);

axiom $field_offset(threadlocaleinfostruct.Heap.c..10972.refcount) == 16;

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.Heap.c..10972.refcount) } $is(#p, ^threadlocaleinfostruct.Heap.c..10972) ==> $dot(#p, threadlocaleinfostruct.Heap.c..10972.refcount) == $ptr($ptr_to(^^i4), $ref(#p) + 16) && $extent_hint($dot(#p, threadlocaleinfostruct.Heap.c..10972.refcount), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, threadlocaleinfostruct.Heap.c..10972.refcount)) } { $st(#s, $dot(#p, threadlocaleinfostruct.Heap.c..10972.refcount)) } $typed2(#s, #p, ^threadlocaleinfostruct.Heap.c..10972) ==> $field_properties(#s, #p, threadlocaleinfostruct.Heap.c..10972.refcount, $ptr_to(^^i4), false));

const unique threadlocaleinfostruct.Heap.c..10972.wrefcount: $field;

axiom $static_field_properties(threadlocaleinfostruct.Heap.c..10972.wrefcount, ^threadlocaleinfostruct.Heap.c..10972);

axiom $is_primitive_non_volatile_field(threadlocaleinfostruct.Heap.c..10972.wrefcount);

axiom $field_offset(threadlocaleinfostruct.Heap.c..10972.wrefcount) == 24;

axiom (forall #p: $ptr :: { $dot(#p, threadlocaleinfostruct.Heap.c..10972.wrefcount) } $is(#p, ^threadlocaleinfostruct.Heap.c..10972) ==> $dot(#p, threadlocaleinfostruct.Heap.c..10972.wrefcount) == $ptr($ptr_to(^^i4), $ref(#p) + 24) && $extent_hint($dot(#p, threadlocaleinfostruct.Heap.c..10972.wrefcount), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, threadlocaleinfostruct.Heap.c..10972.wrefcount)) } { $st(#s, $dot(#p, threadlocaleinfostruct.Heap.c..10972.wrefcount)) } $typed2(#s, #p, ^threadlocaleinfostruct.Heap.c..10972) ==> $field_properties(#s, #p, threadlocaleinfostruct.Heap.c..10972.wrefcount, $ptr_to(^^i4), false));

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^Heap: $ctype;

axiom $is_composite(^Heap);

axiom $ptr_level(^Heap) == 0;

axiom $sizeof(^Heap) == 4004;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Heap) } $inv2(#s1, #s2, #p, ^Heap) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty()) && $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(#s2, $dot(#p, Heap.sh))), 0), $int_to_map_t..^^i4.^^mathint($mem(#s2, $dot(#p, Heap.abs)))) && $mem(#s2, $dot(#p, Heap.len)) <= 1000 && (forall Q#i$1^65.29#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(#s2, $dot(#p, Heap.sh))), F#mark(Q#i$1^65.29#tc1)) } $in_range_u4(Q#i$1^65.29#tc1) ==> Q#i$1^65.29#tc1 != $mem(#s2, $dot(#p, Heap.len)) && Q#i$1^65.29#tc1 < $mem(#s2, $dot(#p, Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(#s2, $dot(#p, Heap.sh))), F#mark(Q#i$1^65.29#tc1)), F#lambda#6($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(#s2, $dot(#p, Heap.sh))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 2)), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(#s2, $dot(#p, Heap.sh))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 1)), $mem(#s2, $idx($dot(#p, Heap.heap), Q#i$1^65.29#tc1, ^^i4))))) && (forall Q#i$1^66.29#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(#s2, $dot(#p, Heap.sh))), F#mark(Q#i$1^66.29#tc1)) } $in_range_u4(Q#i$1^66.29#tc1) ==> Q#i$1^66.29#tc1 >= $mem(#s2, $dot(#p, Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(#s2, $dot(#p, Heap.sh))), F#mark(Q#i$1^66.29#tc1)), F#lambda#7())) && (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(#s2, $dot(#p, Heap.sh))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $mem(#s2, $dot(#p, Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(#s2, $dot(#p, Heap.sh))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) >= 0) && (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(#s2, $dot(#p, Heap.sh))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $mem(#s2, $dot(#p, Heap.len)) ==> Q#i$1^66.29#tc1 != $mem(#s2, $dot(#p, Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(#s2, $dot(#p, Heap.sh))), Q#i$1^66.29#tc1), Q#e$1^66.29#tc2) > 0 ==> Q#e$1^66.29#tc2 >= $mem(#s2, $idx($dot(#p, Heap.heap), Q#i$1^66.29#tc1, ^^i4)))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^Heap, #r), l#public) } $inv_lab(#s2, $ptr(^Heap, #r), l#public) == ($typed(#s2, $ptr(^Heap, #r)) && $set_eq($owns(#s2, $ptr(^Heap, #r)), $set_empty()) && $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(#s2, $dot($ptr(^Heap, #r), Heap.sh))), 0), $int_to_map_t..^^i4.^^mathint($mem(#s2, $dot($ptr(^Heap, #r), Heap.abs)))) && $mem(#s2, $dot($ptr(^Heap, #r), Heap.len)) <= 1000 && (forall Q#i$1^65.29#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(#s2, $dot($ptr(^Heap, #r), Heap.sh))), F#mark(Q#i$1^65.29#tc1)) } $in_range_u4(Q#i$1^65.29#tc1) ==> Q#i$1^65.29#tc1 != $mem(#s2, $dot($ptr(^Heap, #r), Heap.len)) && Q#i$1^65.29#tc1 < $mem(#s2, $dot($ptr(^Heap, #r), Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(#s2, $dot($ptr(^Heap, #r), Heap.sh))), F#mark(Q#i$1^65.29#tc1)), F#lambda#6($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(#s2, $dot($ptr(^Heap, #r), Heap.sh))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 2)), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(#s2, $dot($ptr(^Heap, #r), Heap.sh))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 1)), $mem(#s2, $idx($dot($ptr(^Heap, #r), Heap.heap), Q#i$1^65.29#tc1, ^^i4))))) && (forall Q#i$1^66.29#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(#s2, $dot($ptr(^Heap, #r), Heap.sh))), F#mark(Q#i$1^66.29#tc1)) } $in_range_u4(Q#i$1^66.29#tc1) ==> Q#i$1^66.29#tc1 >= $mem(#s2, $dot($ptr(^Heap, #r), Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(#s2, $dot($ptr(^Heap, #r), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), F#lambda#7())) && (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(#s2, $dot($ptr(^Heap, #r), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $mem(#s2, $dot($ptr(^Heap, #r), Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(#s2, $dot($ptr(^Heap, #r), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) >= 0) && (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(#s2, $dot($ptr(^Heap, #r), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $mem(#s2, $dot($ptr(^Heap, #r), Heap.len)) ==> Q#i$1^66.29#tc1 != $mem(#s2, $dot($ptr(^Heap, #r), Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(#s2, $dot($ptr(^Heap, #r), Heap.sh))), Q#i$1^66.29#tc1), Q#e$1^66.29#tc2) > 0 ==> Q#e$1^66.29#tc2 >= $mem(#s2, $idx($dot($ptr(^Heap, #r), Heap.heap), Q#i$1^66.29#tc1, ^^i4)))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^Heap, #r)) } $in_full_extent_of(#q, $ptr(^Heap, #r)) == (#q == $ptr(^Heap, #r) || #q == $dot($ptr(^Heap, #r), Heap.$owns) || #q == $dot($ptr(^Heap, #r), Heap.len) || $in_array(#q, $dot($ptr(^Heap, #r), Heap.heap), ^^i4, 1000) || #q == $dot($ptr(^Heap, #r), Heap.abs) || #q == $dot($ptr(^Heap, #r), Heap.sh)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Heap, #r)) } $in_extent_of(#s, #q, $ptr(^Heap, #r)) == $in_struct_extent_of(#q, $ptr(^Heap, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Heap, #r)) } $typed(#s, $ptr(^Heap, #r)) ==> $in_extent_of(#s, #q, $ptr(^Heap, #r)) == (#q == $ptr(^Heap, #r) || $emb(#s, #q) == $ptr(^Heap, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^Heap, #r)) } $in_span_of(#q, $ptr(^Heap, #r)) == (#q == $ptr(^Heap, #r) || #q == $dot($ptr(^Heap, #r), Heap.$owns) || #q == $dot($ptr(^Heap, #r), Heap.len) || $in_array(#q, $dot($ptr(^Heap, #r), Heap.heap), ^^i4, 1000) || #q == $dot($ptr(^Heap, #r), Heap.abs) || #q == $dot($ptr(^Heap, #r), Heap.sh)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^Heap) } $state_spans_the_same(#s1, #s2, #p, ^Heap) == ($mem_eq(#s1, #s2, $dot(#p, Heap.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Heap.len)) && (forall #i: int :: { $idx($dot(#p, Heap.heap), #i, ^^i4) } $in_range(0, #i, 999) ==> $mem_eq(#s1, #s2, $idx($dot(#p, Heap.heap), #i, ^^i4))) && $mem_eq(#s1, #s2, $dot(#p, Heap.abs)) && $mem_eq(#s1, #s2, $dot(#p, Heap.sh))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Heap) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Heap) == ($mem_eq(#s1, #s2, $dot(#p, Heap.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Heap.len)) && (forall #i: int :: { $idx($dot(#p, Heap.heap), #i, ^^i4) } $in_range(0, #i, 999) ==> $mem_eq(#s1, #s2, $idx($dot(#p, Heap.heap), #i, ^^i4))) && $mem_eq(#s1, #s2, $dot(#p, Heap.abs)) && $mem_eq(#s1, #s2, $dot(#p, Heap.sh))));

axiom $is_claimable(^Heap) == false;

axiom $has_volatile_owns_set(^Heap) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^Heap, #r)) } $extent_mutable(#s1, $ptr(^Heap, #r)) == ($mutable(#s1, $ptr(^Heap, #r)) && (forall #i: int :: { $idx($dot($ptr(^Heap, #r), Heap.heap), #i, ^^i4) } true)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^Heap, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^Heap, #r)) == ($is_fresh(#s1, #s2, $ptr(^Heap, #r)) && (forall #i: int :: { $idx($dot($ptr(^Heap, #r), Heap.heap), #i, ^^i4) } true)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^Heap, #r)) } $extent_zero(#s1, $ptr(^Heap, #r)) == ($mem(#s1, $dot($ptr(^Heap, #r), Heap.len)) == 0 && (forall #i: int :: { $idx($dot($ptr(^Heap, #r), Heap.heap), #i, ^^i4) } $in_range(0, #i, 999) ==> $mem(#s1, $idx($dot($ptr(^Heap, #r), Heap.heap), #i, ^^i4)) == 0) && $mem(#s1, $dot($ptr(^Heap, #r), Heap.abs)) == 0 && $mem(#s1, $dot($ptr(^Heap, #r), Heap.sh)) == 0));

const unique Heap.$owns: $field;

axiom $static_field_properties(Heap.$owns, ^Heap);

axiom $is_primitive_non_volatile_field(Heap.$owns);

axiom (forall #p: $ptr :: { $dot(#p, Heap.$owns) } $is(#p, ^Heap) ==> $dot(#p, Heap.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, Heap.$owns)) && $extent_hint($dot(#p, Heap.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Heap.$owns)) } { $st(#s, $dot(#p, Heap.$owns)) } $typed2(#s, #p, ^Heap) ==> $field_properties(#s, #p, Heap.$owns, ^$#ptrset, false));

axiom $owns_set_field(^Heap) == Heap.$owns;

const unique Heap.len: $field;

axiom $static_field_properties(Heap.len, ^Heap);

axiom $is_primitive_non_volatile_field(Heap.len);

axiom $field_offset(Heap.len) == 0;

axiom (forall #p: $ptr :: { $dot(#p, Heap.len) } $is(#p, ^Heap) ==> $dot(#p, Heap.len) == $ptr(^^u4, $ref(#p) + 0) && $extent_hint($dot(#p, Heap.len), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Heap.len)) } { $st(#s, $dot(#p, Heap.len)) } $typed2(#s, #p, ^Heap) ==> $field_properties(#s, #p, Heap.len, ^^u4, false));

const unique Heap.heap: $field;

axiom $static_field_properties(Heap.heap, ^Heap);

axiom $is_primitive_embedded_array(Heap.heap, 1000);

axiom $embedded_array_size(Heap.heap, ^^i4) == 1000;

axiom $field_offset(Heap.heap) == 4;

axiom (forall #p: $ptr :: { $dot(#p, Heap.heap) } $is(#p, ^Heap) ==> $dot(#p, Heap.heap) == $ptr(^^i4, $ref(#p) + 4) && $extent_hint($dot(#p, Heap.heap), #p));

axiom $array_field_properties(Heap.heap, ^^i4, 1000, false, false);

const unique Heap.abs: $field;

axiom $static_field_properties(Heap.abs, ^Heap);

axiom $is_primitive_non_volatile_field(Heap.abs);

axiom (forall #p: $ptr :: { $dot(#p, Heap.abs) } $is(#p, ^Heap) ==> $dot(#p, Heap.abs) == $ptr($map_t(^^i4, ^^mathint), $ghost_ref(#p, Heap.abs)) && $extent_hint($dot(#p, Heap.abs), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Heap.abs)) } { $st(#s, $dot(#p, Heap.abs)) } $typed2(#s, #p, ^Heap) ==> $field_properties(#s, #p, Heap.abs, $map_t(^^i4, ^^mathint), false));

const unique Heap.sh: $field;

axiom $static_field_properties(Heap.sh, ^Heap);

axiom $is_primitive_non_volatile_field(Heap.sh);

axiom (forall #p: $ptr :: { $dot(#p, Heap.sh) } $is(#p, ^Heap) ==> $dot(#p, Heap.sh) == $ptr($map_t(^^u4, $map_t(^^i4, ^^mathint)), $ghost_ref(#p, Heap.sh)) && $extent_hint($dot(#p, Heap.sh), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Heap.sh)) } { $st(#s, $dot(#p, Heap.sh)) } $typed2(#s, #p, ^Heap) ==> $field_properties(#s, #p, Heap.sh, $map_t(^^u4, $map_t(^^i4, ^^mathint)), false));

procedure Heap#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $set_eq($owns($s, $ptr(^Heap, P#_this_)), $set_empty());
  ensures $is_admissibility_check() ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.sh))), 0), $int_to_map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.abs))));
  ensures $is_admissibility_check() ==> $mem($s, $dot($ptr(^Heap, P#_this_), Heap.len)) <= 1000;
  ensures $is_admissibility_check() ==> (forall Q#i$1^65.29#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.sh))), F#mark(Q#i$1^65.29#tc1)) } $in_range_u4(Q#i$1^65.29#tc1) ==> Q#i$1^65.29#tc1 != $mem($s, $dot($ptr(^Heap, P#_this_), Heap.len)) && Q#i$1^65.29#tc1 < $mem($s, $dot($ptr(^Heap, P#_this_), Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.sh))), F#mark(Q#i$1^65.29#tc1)), F#lambda#6($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.sh))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 2)), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.sh))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 1)), $mem($s, $idx($dot($ptr(^Heap, P#_this_), Heap.heap), Q#i$1^65.29#tc1, ^^i4)))));
  ensures $is_admissibility_check() ==> (forall Q#i$1^66.29#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.sh))), F#mark(Q#i$1^66.29#tc1)) } $in_range_u4(Q#i$1^66.29#tc1) ==> Q#i$1^66.29#tc1 >= $mem($s, $dot($ptr(^Heap, P#_this_), Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), F#lambda#7()));
  ensures $is_admissibility_check() ==> (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $mem($s, $dot($ptr(^Heap, P#_this_), Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) >= 0);
  ensures $is_admissibility_check() ==> (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $mem($s, $dot($ptr(^Heap, P#_this_), Heap.len)) ==> Q#i$1^66.29#tc1 != $mem($s, $dot($ptr(^Heap, P#_this_), Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.sh))), Q#i$1^66.29#tc1), Q#e$1^66.29#tc2) > 0 ==> Q#e$1^66.29#tc2 >= $mem($s, $idx($dot($ptr(^Heap, P#_this_), Heap.heap), Q#i$1^66.29#tc1, ^^i4)));
  ensures $is_unwrap_check() ==> $set_eq($owns($s, $ptr(^Heap, P#_this_)), $set_empty());
  ensures $is_unwrap_check() ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.sh))), 0), $int_to_map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.abs))));
  ensures $is_unwrap_check() ==> $mem($s, $dot($ptr(^Heap, P#_this_), Heap.len)) <= 1000;
  ensures $is_unwrap_check() ==> (forall Q#i$1^65.29#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.sh))), F#mark(Q#i$1^65.29#tc1)) } $in_range_u4(Q#i$1^65.29#tc1) ==> Q#i$1^65.29#tc1 != $mem($s, $dot($ptr(^Heap, P#_this_), Heap.len)) && Q#i$1^65.29#tc1 < $mem($s, $dot($ptr(^Heap, P#_this_), Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.sh))), F#mark(Q#i$1^65.29#tc1)), F#lambda#6($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.sh))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 2)), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.sh))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 1)), $mem($s, $idx($dot($ptr(^Heap, P#_this_), Heap.heap), Q#i$1^65.29#tc1, ^^i4)))));
  ensures $is_unwrap_check() ==> (forall Q#i$1^66.29#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.sh))), F#mark(Q#i$1^66.29#tc1)) } $in_range_u4(Q#i$1^66.29#tc1) ==> Q#i$1^66.29#tc1 >= $mem($s, $dot($ptr(^Heap, P#_this_), Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), F#lambda#7()));
  ensures $is_unwrap_check() ==> (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $mem($s, $dot($ptr(^Heap, P#_this_), Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) >= 0);
  ensures $is_unwrap_check() ==> (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $mem($s, $dot($ptr(^Heap, P#_this_), Heap.len)) ==> Q#i$1^66.29#tc1 != $mem($s, $dot($ptr(^Heap, P#_this_), Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#_this_), Heap.sh))), Q#i$1^66.29#tc1), Q#e$1^66.29#tc2) > 0 ==> Q#e$1^66.29#tc2 >= $mem($s, $idx($dot($ptr(^Heap, P#_this_), Heap.heap), Q#i$1^66.29#tc1, ^^i4)));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Heap#adm(P#_this_: int)
{
  var #wrTime$1^55.1: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^55.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^55.1, #loc._this_, $ptr_to_int($ptr(^Heap, P#_this_)), $ptr_to(^Heap)) && $local_value_is_ptr($s, #tok$1^55.1, #loc._this_, $ptr(^Heap, P#_this_), $ptr_to(^Heap));
    assume #wrTime$1^55.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^55.1, #p) } $in_writes_at(#wrTime$1^55.1, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^Heap, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^Heap, P#_this_));
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
            assume $admissibility_pre($s, $ptr(^Heap, P#_this_));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^Heap, P#_this_));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Heap*)@null))
        call $havoc_others($ptr(^Heap, P#_this_), ^Heap);
        assume $good_state_ext(#tok$1^55.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^Heap, P#_this_), ^Heap);
    }

  #exit:
}



procedure _vswprintf_c_l(P#_DstBuf: int, P#_MaxCount: int, P#_Format: int, P#_Locale: int, P#_ArgList: int) returns ($result: int);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



procedure swprintf(P#_String: int, P#_Count: int, P#_Format: int) returns ($result: int);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation swprintf(P#_String: int, P#_Count: int, P#_Format: int) returns ($result: int)
{
  var L#_Arglist: int where $in_range_phys_ptr(L#_Arglist);
  var L#_Ret: int where $in_range_i4(L#_Ret);
  var #callConv#0: $ptr;
  var addr._Format: int where $in_range_phys_ptr(addr._Format);
  var #wrTime$3^36.1: int;
  var #stackframe: int;

  anon7:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$3^36.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$3^36.1, #loc._String, $ptr_to_int($ptr(^^u2, P#_String)), $ptr_to(^^u2)) && $local_value_is_ptr($s, #tok$3^36.1, #loc._String, $ptr(^^u2, P#_String), $ptr_to(^^u2));
    assume $local_value_is($s, #tok$3^36.1, #loc._Count, P#_Count, ^^u4);
    assume $local_value_is($s, #tok$3^36.1, #loc._Format, $ptr_to_int($ptr(^^u2, P#_Format)), $ptr_to(^^u2)) && $local_value_is_ptr($s, #tok$3^36.1, #loc._Format, $ptr(^^u2, P#_Format), $ptr_to(^^u2));
    assume #wrTime$3^36.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$3^36.1, #p) } $in_writes_at(#wrTime$3^36.1, #p) == false);
    // assume @in_range_phys_ptr((mathint)_String); 
    assume $in_range_phys_ptr($ref($ptr(^^u2, P#_String)));
    // assume @in_range_u4(_Count); 
    assume $in_range_u4(P#_Count);
    // assume @in_range_phys_ptr((mathint)_Format); 
    assume $in_range_phys_ptr($ref($ptr(^^u2, P#_Format)));
    // uint16_t** addr._Format; 
    assume $local_value_is($s, #tok$3^36.1, #loc.addr._Format, $ptr_to_int($ptr($ptr_to(^^u2), addr._Format)), $ptr_to($ptr_to(^^u2))) && $local_value_is_ptr($s, #tok$3^36.1, #loc.addr._Format, $ptr($ptr_to(^^u2), addr._Format), $ptr_to($ptr_to(^^u2)));
    // addr._Format := _vcc_stack_alloc<uint16_t*>(@stackframe, false); 
    call #callConv#0 := $stack_alloc($ptr_to(^^u2), #stackframe, false);
    assume $full_stop_ext(#tok$3^36.1, $s);
    addr._Format := $ref(#callConv#0);
    assume $local_value_is($s, #tok$3^36.1, #loc.addr._Format, $ptr_to_int($ptr($ptr_to(^^u2), addr._Format)), $ptr_to($ptr_to(^^u2))) && $local_value_is_ptr($s, #tok$3^36.1, #loc.addr._Format, $ptr($ptr_to(^^u2), addr._Format), $ptr_to($ptr_to(^^u2)));
    // assert @_vcc_typed2(@state, addr._Format); 
    assert $typed2($s, $ptr($ptr_to(^^u2), addr._Format), $ptr_to(^^u2));
    // assert @prim_writes_check(addr._Format); 
    assert $writable($s, #wrTime$3^36.1, $ptr($ptr_to(^^u2), addr._Format));
    // *addr._Format := _Format; 
    call $write_int($ptr($ptr_to(^^u2), addr._Format), $ref($ptr(^^u2, P#_Format)));
    assume $full_stop_ext(#tok$3^40.30, $s);
    // int32_t _Ret; 
    assume $local_value_is($s, #tok$3^39.5, #loc._Ret, L#_Ret, ^^i4);
    // int8_t* _Arglist; 
    assume $local_value_is($s, #tok$3^38.5, #loc._Arglist, $ptr_to_int($ptr(^^i1, L#_Arglist)), $ptr_to(^^i1)) && $local_value_is_ptr($s, #tok$3^38.5, #loc._Arglist, $ptr(^^i1, L#_Arglist), $ptr_to(^^i1));
    // var int8_t* _Arglist
    // var int32_t _Ret
    // _Arglist := (int8_t*)addr._Format[8]; 
    L#_Arglist := $ref($idx($ptr_cast($ptr($ptr_to(^^u2), addr._Format), ^^i1), 8, ^^i1));
    assume $local_value_is($s, #tok$3^40.7, #loc._Arglist, $ptr_to_int($ptr(^^i1, L#_Arglist)), $ptr_to(^^i1)) && $local_value_is_ptr($s, #tok$3^40.7, #loc._Arglist, $ptr(^^i1, L#_Arglist), $ptr_to(^^i1));
    // non-pure function
    // assert @reads_check_normal(addr._Format); 
    assert $typed2($s, $ptr($ptr_to(^^u2), addr._Format), $ptr_to(^^u2));
    assert $thread_local2($s, $ptr($ptr_to(^^u2), addr._Format), $ptr_to(^^u2));
    // _Ret := _vswprintf_c_l(_String, _Count, *(addr._Format), (struct localeinfo_struct*)@null, _Arglist); 
    call L#_Ret := _vswprintf_c_l($ref($ptr(^^u2, P#_String)), P#_Count, $ref($read_ptr($s, $ptr($ptr_to(^^u2), addr._Format), ^^u2)), $ref($ptr_cast($null, ^localeinfo_struct)), $ref($ptr(^^i1, L#_Arglist)));
    assume $full_stop_ext(#tok$3^41.12, $s);
    assume $local_value_is($s, #tok$3^41.12, #loc._Ret, L#_Ret, ^^i4);
    // _Arglist := (int8_t*)@null; 
    L#_Arglist := $ref($ptr_cast($null, ^^i1));
    assume $local_value_is($s, #tok$3^42.7, #loc._Arglist, $ptr_to_int($ptr(^^i1, L#_Arglist)), $ptr_to(^^i1)) && $local_value_is_ptr($s, #tok$3^42.7, #loc._Arglist, $ptr(^^i1, L#_Arglist), $ptr_to(^^i1));
    // stmt _vcc_stack_free(@stackframe, addr._Format); 
    call $stack_free(#stackframe, $ptr($ptr_to(^^u2), addr._Format));
    assume $full_stop_ext(#tok$3^36.1, $s);
    // return _Ret; 
    $result := L#_Ret;
    assert $position_marker();
    goto #exit;

  anon8:
    // empty
    // Block cleanup
    // stmt _vcc_stack_free(@stackframe, addr._Format); 
    call $stack_free(#stackframe, $ptr($ptr_to(^^u2), addr._Format));
    assume $full_stop_ext(#tok$3^36.1, $s);

  #exit:
}



procedure vswprintf(P#_String: int, P#_Count: int, P#_Format: int, P#_Ap: int) returns ($result: int);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation vswprintf(P#_String: int, P#_Count: int, P#_Format: int, P#_Ap: int) returns ($result: int)
{
  var res__vswprintf_c_l#41: int where $in_range_i4(res__vswprintf_c_l#41);
  var #wrTime$3^49.1: int;
  var #stackframe: int;

  anon9:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$3^49.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$3^49.1, #loc._String, $ptr_to_int($ptr(^^u2, P#_String)), $ptr_to(^^u2)) && $local_value_is_ptr($s, #tok$3^49.1, #loc._String, $ptr(^^u2, P#_String), $ptr_to(^^u2));
    assume $local_value_is($s, #tok$3^49.1, #loc._Count, P#_Count, ^^u4);
    assume $local_value_is($s, #tok$3^49.1, #loc._Format, $ptr_to_int($ptr(^^u2, P#_Format)), $ptr_to(^^u2)) && $local_value_is_ptr($s, #tok$3^49.1, #loc._Format, $ptr(^^u2, P#_Format), $ptr_to(^^u2));
    assume $local_value_is($s, #tok$3^49.1, #loc._Ap, $ptr_to_int($ptr(^^i1, P#_Ap)), $ptr_to(^^i1)) && $local_value_is_ptr($s, #tok$3^49.1, #loc._Ap, $ptr(^^i1, P#_Ap), $ptr_to(^^i1));
    assume #wrTime$3^49.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$3^49.1, #p) } $in_writes_at(#wrTime$3^49.1, #p) == false);
    // assume @in_range_phys_ptr((mathint)_String); 
    assume $in_range_phys_ptr($ref($ptr(^^u2, P#_String)));
    // assume @in_range_u4(_Count); 
    assume $in_range_u4(P#_Count);
    // assume @in_range_phys_ptr((mathint)_Format); 
    assume $in_range_phys_ptr($ref($ptr(^^u2, P#_Format)));
    // assume @in_range_phys_ptr((mathint)_Ap); 
    assume $in_range_phys_ptr($ref($ptr(^^i1, P#_Ap)));
    // int32_t res__vswprintf_c_l#41; 
    assume $local_value_is($s, #tok$3^51.12, #loc.res__vswprintf_c_l#41, res__vswprintf_c_l#41, ^^i4);
    // res__vswprintf_c_l#41 := _vswprintf_c_l(_String, _Count, _Format, (struct localeinfo_struct*)@null, _Ap); 
    call res__vswprintf_c_l#41 := _vswprintf_c_l($ref($ptr(^^u2, P#_String)), P#_Count, $ref($ptr(^^u2, P#_Format)), $ref($ptr_cast($null, ^localeinfo_struct)), $ref($ptr(^^i1, P#_Ap)));
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



procedure _swprintf_l(P#_String: int, P#_Count: int, P#_Format: int, P#_Plocinfo: int) returns ($result: int);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _swprintf_l(P#_String: int, P#_Count: int, P#_Format: int, P#_Plocinfo: int) returns ($result: int)
{
  var L#_Arglist: int where $in_range_phys_ptr(L#_Arglist);
  var L#_Ret: int where $in_range_i4(L#_Ret);
  var #callConv#1: $ptr;
  var addr._Plocinfo: int where $in_range_phys_ptr(addr._Plocinfo);
  var #wrTime$3^60.1: int;
  var #stackframe: int;

  anon11:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$3^60.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$3^60.1, #loc._String, $ptr_to_int($ptr(^^u2, P#_String)), $ptr_to(^^u2)) && $local_value_is_ptr($s, #tok$3^60.1, #loc._String, $ptr(^^u2, P#_String), $ptr_to(^^u2));
    assume $local_value_is($s, #tok$3^60.1, #loc._Count, P#_Count, ^^u4);
    assume $local_value_is($s, #tok$3^60.1, #loc._Format, $ptr_to_int($ptr(^^u2, P#_Format)), $ptr_to(^^u2)) && $local_value_is_ptr($s, #tok$3^60.1, #loc._Format, $ptr(^^u2, P#_Format), $ptr_to(^^u2));
    assume $local_value_is($s, #tok$3^60.1, #loc._Plocinfo, $ptr_to_int($ptr(^localeinfo_struct, P#_Plocinfo)), $ptr_to(^localeinfo_struct)) && $local_value_is_ptr($s, #tok$3^60.1, #loc._Plocinfo, $ptr(^localeinfo_struct, P#_Plocinfo), $ptr_to(^localeinfo_struct));
    assume #wrTime$3^60.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$3^60.1, #p) } $in_writes_at(#wrTime$3^60.1, #p) == false);
    // assume @in_range_phys_ptr((mathint)_String); 
    assume $in_range_phys_ptr($ref($ptr(^^u2, P#_String)));
    // assume @in_range_u4(_Count); 
    assume $in_range_u4(P#_Count);
    // assume @in_range_phys_ptr((mathint)_Format); 
    assume $in_range_phys_ptr($ref($ptr(^^u2, P#_Format)));
    // assume @in_range_phys_ptr((mathint)_Plocinfo); 
    assume $in_range_phys_ptr($ref($ptr(^localeinfo_struct, P#_Plocinfo)));
    // struct localeinfo_struct** addr._Plocinfo; 
    assume $local_value_is($s, #tok$3^60.1, #loc.addr._Plocinfo, $ptr_to_int($ptr($ptr_to(^localeinfo_struct), addr._Plocinfo)), $ptr_to($ptr_to(^localeinfo_struct))) && $local_value_is_ptr($s, #tok$3^60.1, #loc.addr._Plocinfo, $ptr($ptr_to(^localeinfo_struct), addr._Plocinfo), $ptr_to($ptr_to(^localeinfo_struct)));
    // addr._Plocinfo := _vcc_stack_alloc<struct localeinfo_struct*>(@stackframe, false); 
    call #callConv#1 := $stack_alloc($ptr_to(^localeinfo_struct), #stackframe, false);
    assume $full_stop_ext(#tok$3^60.1, $s);
    addr._Plocinfo := $ref(#callConv#1);
    assume $local_value_is($s, #tok$3^60.1, #loc.addr._Plocinfo, $ptr_to_int($ptr($ptr_to(^localeinfo_struct), addr._Plocinfo)), $ptr_to($ptr_to(^localeinfo_struct))) && $local_value_is_ptr($s, #tok$3^60.1, #loc.addr._Plocinfo, $ptr($ptr_to(^localeinfo_struct), addr._Plocinfo), $ptr_to($ptr_to(^localeinfo_struct)));
    // assert @_vcc_typed2(@state, addr._Plocinfo); 
    assert $typed2($s, $ptr($ptr_to(^localeinfo_struct), addr._Plocinfo), $ptr_to(^localeinfo_struct));
    // assert @prim_writes_check(addr._Plocinfo); 
    assert $writable($s, #wrTime$3^60.1, $ptr($ptr_to(^localeinfo_struct), addr._Plocinfo));
    // *addr._Plocinfo := _Plocinfo; 
    call $write_int($ptr($ptr_to(^localeinfo_struct), addr._Plocinfo), $ref($ptr(^localeinfo_struct, P#_Plocinfo)));
    assume $full_stop_ext(#tok$3^64.30, $s);
    // int32_t _Ret; 
    assume $local_value_is($s, #tok$3^63.5, #loc._Ret, L#_Ret, ^^i4);
    // int8_t* _Arglist; 
    assume $local_value_is($s, #tok$3^62.5, #loc._Arglist, $ptr_to_int($ptr(^^i1, L#_Arglist)), $ptr_to(^^i1)) && $local_value_is_ptr($s, #tok$3^62.5, #loc._Arglist, $ptr(^^i1, L#_Arglist), $ptr_to(^^i1));
    // var int8_t* _Arglist
    // var int32_t _Ret
    // _Arglist := (int8_t*)addr._Plocinfo[8]; 
    L#_Arglist := $ref($idx($ptr_cast($ptr($ptr_to(^localeinfo_struct), addr._Plocinfo), ^^i1), 8, ^^i1));
    assume $local_value_is($s, #tok$3^64.7, #loc._Arglist, $ptr_to_int($ptr(^^i1, L#_Arglist)), $ptr_to(^^i1)) && $local_value_is_ptr($s, #tok$3^64.7, #loc._Arglist, $ptr(^^i1, L#_Arglist), $ptr_to(^^i1));
    // non-pure function
    // assert @reads_check_normal(addr._Plocinfo); 
    assert $typed2($s, $ptr($ptr_to(^localeinfo_struct), addr._Plocinfo), $ptr_to(^localeinfo_struct));
    assert $thread_local2($s, $ptr($ptr_to(^localeinfo_struct), addr._Plocinfo), $ptr_to(^localeinfo_struct));
    // _Ret := _vswprintf_c_l(_String, _Count, _Format, *(addr._Plocinfo), _Arglist); 
    call L#_Ret := _vswprintf_c_l($ref($ptr(^^u2, P#_String)), P#_Count, $ref($ptr(^^u2, P#_Format)), $ref($read_ptr($s, $ptr($ptr_to(^localeinfo_struct), addr._Plocinfo), ^localeinfo_struct)), $ref($ptr(^^i1, L#_Arglist)));
    assume $full_stop_ext(#tok$3^65.12, $s);
    assume $local_value_is($s, #tok$3^65.12, #loc._Ret, L#_Ret, ^^i4);
    // _Arglist := (int8_t*)@null; 
    L#_Arglist := $ref($ptr_cast($null, ^^i1));
    assume $local_value_is($s, #tok$3^66.7, #loc._Arglist, $ptr_to_int($ptr(^^i1, L#_Arglist)), $ptr_to(^^i1)) && $local_value_is_ptr($s, #tok$3^66.7, #loc._Arglist, $ptr(^^i1, L#_Arglist), $ptr_to(^^i1));
    // stmt _vcc_stack_free(@stackframe, addr._Plocinfo); 
    call $stack_free(#stackframe, $ptr($ptr_to(^localeinfo_struct), addr._Plocinfo));
    assume $full_stop_ext(#tok$3^60.1, $s);
    // return _Ret; 
    $result := L#_Ret;
    assert $position_marker();
    goto #exit;

  anon12:
    // empty
    // Block cleanup
    // stmt _vcc_stack_free(@stackframe, addr._Plocinfo); 
    call $stack_free(#stackframe, $ptr($ptr_to(^localeinfo_struct), addr._Plocinfo));
    assume $full_stop_ext(#tok$3^60.1, $s);

  #exit:
}



procedure _vswprintf_l(P#_String: int, P#_Count: int, P#_Format: int, P#_Plocinfo: int, P#_Ap: int) returns ($result: int);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _vswprintf_l(P#_String: int, P#_Count: int, P#_Format: int, P#_Plocinfo: int, P#_Ap: int) returns ($result: int)
{
  var res__vswprintf_c_l#42: int where $in_range_i4(res__vswprintf_c_l#42);
  var #wrTime$3^73.1: int;
  var #stackframe: int;

  anon13:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$3^73.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$3^73.1, #loc._String, $ptr_to_int($ptr(^^u2, P#_String)), $ptr_to(^^u2)) && $local_value_is_ptr($s, #tok$3^73.1, #loc._String, $ptr(^^u2, P#_String), $ptr_to(^^u2));
    assume $local_value_is($s, #tok$3^73.1, #loc._Count, P#_Count, ^^u4);
    assume $local_value_is($s, #tok$3^73.1, #loc._Format, $ptr_to_int($ptr(^^u2, P#_Format)), $ptr_to(^^u2)) && $local_value_is_ptr($s, #tok$3^73.1, #loc._Format, $ptr(^^u2, P#_Format), $ptr_to(^^u2));
    assume $local_value_is($s, #tok$3^73.1, #loc._Plocinfo, $ptr_to_int($ptr(^localeinfo_struct, P#_Plocinfo)), $ptr_to(^localeinfo_struct)) && $local_value_is_ptr($s, #tok$3^73.1, #loc._Plocinfo, $ptr(^localeinfo_struct, P#_Plocinfo), $ptr_to(^localeinfo_struct));
    assume $local_value_is($s, #tok$3^73.1, #loc._Ap, $ptr_to_int($ptr(^^i1, P#_Ap)), $ptr_to(^^i1)) && $local_value_is_ptr($s, #tok$3^73.1, #loc._Ap, $ptr(^^i1, P#_Ap), $ptr_to(^^i1));
    assume #wrTime$3^73.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$3^73.1, #p) } $in_writes_at(#wrTime$3^73.1, #p) == false);
    // assume @in_range_phys_ptr((mathint)_String); 
    assume $in_range_phys_ptr($ref($ptr(^^u2, P#_String)));
    // assume @in_range_u4(_Count); 
    assume $in_range_u4(P#_Count);
    // assume @in_range_phys_ptr((mathint)_Format); 
    assume $in_range_phys_ptr($ref($ptr(^^u2, P#_Format)));
    // assume @in_range_phys_ptr((mathint)_Plocinfo); 
    assume $in_range_phys_ptr($ref($ptr(^localeinfo_struct, P#_Plocinfo)));
    // assume @in_range_phys_ptr((mathint)_Ap); 
    assume $in_range_phys_ptr($ref($ptr(^^i1, P#_Ap)));
    // int32_t res__vswprintf_c_l#42; 
    assume $local_value_is($s, #tok$3^75.12, #loc.res__vswprintf_c_l#42, res__vswprintf_c_l#42, ^^i4);
    // res__vswprintf_c_l#42 := _vswprintf_c_l(_String, _Count, _Format, _Plocinfo, _Ap); 
    call res__vswprintf_c_l#42 := _vswprintf_c_l($ref($ptr(^^u2, P#_String)), P#_Count, $ref($ptr(^^u2, P#_Format)), $ref($ptr(^localeinfo_struct, P#_Plocinfo)), $ref($ptr(^^i1, P#_Ap)));
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



procedure init(P#h: int);
  modifies $s, $cev_pc;
  ensures $wrapped($s, $ptr(^Heap, P#h), ^Heap) && $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) == 0 && $eq.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.abs))), F#lambda#10());
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $span($ptr(^Heap, P#h))) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $span($ptr(^Heap, P#h))) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $span($ptr(^Heap, P#h))) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation init(P#h: int)
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
    assume $local_value_is($s, #tok$1^69.1, #loc.h, $ptr_to_int($ptr(^Heap, P#h)), $ptr_to(^Heap)) && $local_value_is_ptr($s, #tok$1^69.1, #loc.h, $ptr(^Heap, P#h), $ptr_to(^Heap));
    assume #wrTime$1^69.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^69.1, #p) } $in_writes_at(#wrTime$1^69.1, #p) == $set_in(#p, $span($ptr(^Heap, P#h))));
    assume (forall #p: $ptr :: { $extent_hint(#p, $ptr(^Heap, P#h)) } $set_in(#p, $span($ptr(^Heap, P#h))) ==> $mutable($s, #p));
    // assume @in_range_phys_ptr((mathint)h); 
    assume $in_range_phys_ptr($ref($ptr(^Heap, P#h)));
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
    // assert @_vcc_typed2(@state, (h->sh)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    // assert @prim_writes_check((h->sh)); 
    assert $writable($s, #wrTime$1^69.1, $dot($ptr(^Heap, P#h), Heap.sh));
    // *(h->sh) := res_lambda#9#43; 
    call $write_int($dot($ptr(^Heap, P#h), Heap.sh), $map_t..^^u4.map_t..^^i4.^^mathint_to_int(res_lambda#9#43));
    assume $full_stop_ext(#tok$1^74.5, $s);
    // assert @_vcc_typed2(@state, (h->abs)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.abs), $map_t(^^i4, ^^mathint));
    // assert @prim_writes_check((h->abs)); 
    assert $writable($s, #wrTime$1^69.1, $dot($ptr(^Heap, P#h), Heap.abs));
    // assert @reads_check_normal((h->sh)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    // *(h->abs) := @map_get(*((h->sh)), 0); 
    call $write_int($dot($ptr(^Heap, P#h), Heap.abs), $map_t..^^i4.^^mathint_to_int($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), 0)));
    assume $full_stop_ext(#tok$1^75.5, $s);
    // assert @_vcc_typed2(@state, (h->len)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.len), ^^u4);
    // assert @prim_writes_check((h->len)); 
    assert $writable($s, #wrTime$1^69.1, $dot($ptr(^Heap, P#h), Heap.len));
    // *(h->len) := 0; 
    call $write_int($dot($ptr(^Heap, P#h), Heap.len), 0);
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
    assert $top_writable($s, #wrTime$1^69.1, $ptr(^Heap, P#h));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(h), staticWrapState#54, owns#55)
    call $static_wrap($ptr(^Heap, P#h), staticWrapState#54, owns#55);
    assume $good_state_ext(#tok$1^78.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, h), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^Heap, P#h)), $set_empty());
    // assert @inv_check(@map_eq(@map_get(*((h->sh)), 0), *((h->abs)))); 
    assert $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), 0), $int_to_map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.abs))));
    // assert @inv_check(<=(*((h->len)), 1000)); 
    assert $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) <= 1000;
    // assert @inv_check(forall(uint32_t i; { @map_get(*((h->sh)), mark(i)) } @in_range_u4(i); ==>(&&(!=(i, *((h->len))), <(i, *((h->len)))), @map_eq(@map_get(*((h->sh)), mark(i)), lambda#6(@map_get(*((h->sh)), unchecked+(unchecked*(2, i), 2)), @map_get(*((h->sh)), unchecked+(unchecked*(2, i), 1)), *((h->heap)[i])))))); 
    assert (forall Q#i$1^65.29#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^65.29#tc1)) } $in_range_u4(Q#i$1^65.29#tc1) ==> Q#i$1^65.29#tc1 != $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) && Q#i$1^65.29#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^65.29#tc1)), F#lambda#6($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 2)), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 1)), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), Q#i$1^65.29#tc1, ^^i4)))));
    // assert @inv_check(forall(uint32_t i; { @map_get(*((h->sh)), mark(i)) } @in_range_u4(i); ==>(>=(i, *((h->len))), @map_eq(@map_get(*((h->sh)), mark(i)), lambda#7())))); 
    assert (forall Q#i$1^66.29#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^66.29#tc1)) } $in_range_u4(Q#i$1^66.29#tc1) ==> Q#i$1^66.29#tc1 >= $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), F#lambda#7()));
    // assert @inv_check(forall(uint32_t i; int32_t e; { @map_get(@map_get(*((h->sh)), mark(i)), e) } { mark3(i, e) } { @trigger_hint(mark3(i, e)) } &&(@in_range_u4(i), @in_range_i4(e)); ==>(<(i, *((h->len))), >=(@map_get(@map_get(*((h->sh)), mark(i)), e), 0)))); 
    assert (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) >= 0);
    // assert @inv_check(forall(uint32_t i; int32_t e; { @map_get(@map_get(*((h->sh)), mark(i)), e) } { mark3(i, e) } { @trigger_hint(mark3(i, e)) } &&(@in_range_u4(i), @in_range_i4(e)); ==>(<(i, *((h->len))), ==>(!=(i, *((h->len))), ==>(>(@map_get(@map_get(*((h->sh)), i), e), 0), >=(e, *((h->heap)[i]))))))); 
    assert (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> Q#i$1^66.29#tc1 != $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), Q#i$1^66.29#tc1), Q#e$1^66.29#tc2) > 0 ==> Q#e$1^66.29#tc2 >= $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), Q#i$1^66.29#tc1, ^^i4)));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure insert(P#h: int, P#elt: int);
  requires $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) < 999;
  requires $wrapped($s, $ptr(^Heap, P#h), ^Heap);
  modifies $s, $cev_pc;
  ensures $eq.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.abs))), F#lambda#21($int_to_map_t..^^i4.^^mathint($mem(old($s), $dot($ptr(^Heap, P#h), Heap.abs))), $int_to_map_t..^^i4.^^mathint($mem(old($s), $dot($ptr(^Heap, P#h), Heap.abs))), P#elt));
  ensures $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) == $mem(old($s), $dot($ptr(^Heap, P#h), Heap.len)) + 1;
  ensures $wrapped($s, $ptr(^Heap, P#h), ^Heap);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Heap, P#h) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Heap, P#h) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Heap, P#h) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation insert(P#h: int, P#elt: int)
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
    assume $local_value_is($s, #tok$1^81.1, #loc.h, $ptr_to_int($ptr(^Heap, P#h)), $ptr_to(^Heap)) && $local_value_is_ptr($s, #tok$1^81.1, #loc.h, $ptr(^Heap, P#h), $ptr_to(^Heap));
    assume $local_value_is($s, #tok$1^81.1, #loc.elt, P#elt, ^^i4);
    assume #wrTime$1^81.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^81.1, #p) } $in_writes_at(#wrTime$1^81.1, #p) == (#p == $ptr(^Heap, P#h)));
    assume $thread_owned($s, $ptr(^Heap, P#h));
    // assume @in_range_phys_ptr((mathint)h); 
    assume $in_range_phys_ptr($ref($ptr(^Heap, P#h)));
    // assume @in_range_i4(elt); 
    assume $in_range_i4(P#elt);
    // assert @_vcc_in_domain(@state, h, h); 
    assert $in_domain_lab($s, $ptr(^Heap, P#h), $ptr(^Heap, P#h), l#public);
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
    assert $wrapped($s, $ptr(^Heap, P#h), ^Heap);
    // assert @writes_check(h); 
    assert $top_writable($s, #wrTime$1^81.1, $ptr(^Heap, P#h));
    // assume @_vcc_inv(@state, h); 
    assume $inv($s, $ptr(^Heap, P#h), ^Heap);
    // assume ==(owns#58, @_vcc_owns(@state, h)); 
    assume owns#58 == $owns($s, $ptr(^Heap, P#h));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(h), prestate#59)
    call $static_unwrap($ptr(^Heap, P#h), prestate#59);
    assume $good_state_ext(#tok$1^90.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @reads_check_normal((h->len)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.len), ^^u4);
    assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.len), ^^u4);
    // p := *((h->len)); 
    L#p := $mem($s, $dot($ptr(^Heap, P#h), Heap.len));
    assume $local_value_is($s, #tok$1^91.3, #loc.p, L#p, ^^u4);
    // assert @_vcc_typed2(@state, (h->len)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.len), ^^u4);
    // assert @prim_writes_check((h->len)); 
    assert $writable($s, #wrTime$1^81.1, $dot($ptr(^Heap, P#h), Heap.len));
    // assert @in_range_u4(+(*((h->len)), 1)); 
    assert $in_range_u4($mem($s, $dot($ptr(^Heap, P#h), Heap.len)) + 1);
    // assert @reads_check_normal((h->len)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.len), ^^u4);
    assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.len), ^^u4);
    // *(h->len) := +(*((h->len)), 1); 
    call $write_int($dot($ptr(^Heap, P#h), Heap.len), $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) + 1);
    assume $full_stop_ext(#tok$1^92.3, $s);
    // assert @_vcc_typed2(@state, (h->heap)[p]); 
    assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
    // assert @prim_writes_check((h->heap)[p]); 
    assert $writable($s, #wrTime$1^81.1, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4));
    // *(h->heap)[p] := elt; 
    call $write_int($idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), P#elt);
    assume $full_stop_ext(#tok$1^93.3, $s);
    // assert mark3(p, 0); 
    assert F#mark3(L#p, 0);
    // assume mark3(p, 0); 
    assume F#mark3(L#p, 0);
    call $bump_timestamp();
    assume $full_stop_ext(#tok$1^101.28, $s);
    loopState#0 := $s;
    assume #wrTime$1^101.28 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^101.28, #p) } $in_writes_at(#wrTime$1^101.28, #p) == $set_in(#p, $span($ptr(^Heap, P#h))));
    assert (forall #loopWrites^$1^101.28: $ptr :: { $dont_instantiate(#loopWrites^$1^101.28) } $top_writable($s, #wrTime$1^101.28, #loopWrites^$1^101.28) ==> $top_writable($s, #wrTime$1^81.1, #loopWrites^$1^101.28));
    while (true)
      invariant $mem(loopState#0, $dot($ptr(^Heap, P#h), Heap.len)) == $mem($s, $dot($ptr(^Heap, P#h), Heap.len));
      invariant $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(loopState#0, $dot($ptr(^Heap, P#h), Heap.sh))), 0), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), 0));
      invariant L#p < $mem($s, $dot($ptr(^Heap, P#h), Heap.len));
      invariant (forall Q#i$1^100.31#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^100.31#tc1)) } $in_range_u4(Q#i$1^100.31#tc1) ==> Q#i$1^100.31#tc1 >= $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^100.31#tc1)), F#lambda#11()));
      invariant (forall Q#i$1^100.31#tc1: int, Q#e$1^100.31#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^100.31#tc1)), Q#e$1^100.31#tc2) } { F#mark3(Q#i$1^100.31#tc1, Q#e$1^100.31#tc2) } { sk_hack(F#mark3(Q#i$1^100.31#tc1, Q#e$1^100.31#tc2)) } $in_range_u4(Q#i$1^100.31#tc1) && $in_range_i4(Q#e$1^100.31#tc2) ==> Q#i$1^100.31#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^100.31#tc1)), Q#e$1^100.31#tc2) >= 0);
      invariant (forall Q#i$1^100.31#tc1: int, Q#e$1^100.31#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^100.31#tc1)), Q#e$1^100.31#tc2) } { F#mark3(Q#i$1^100.31#tc1, Q#e$1^100.31#tc2) } { sk_hack(F#mark3(Q#i$1^100.31#tc1, Q#e$1^100.31#tc2)) } $in_range_u4(Q#i$1^100.31#tc1) && $in_range_i4(Q#e$1^100.31#tc2) ==> Q#i$1^100.31#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> Q#i$1^100.31#tc1 != $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), Q#i$1^100.31#tc1), Q#e$1^100.31#tc2) > 0 ==> Q#e$1^100.31#tc2 >= $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), Q#i$1^100.31#tc1, ^^i4)));
      invariant (forall Q#i$1^102.31#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^102.31#tc1)) } $in_range_u4(Q#i$1^102.31#tc1) ==> Q#i$1^102.31#tc1 != L#p && Q#i$1^102.31#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^102.31#tc1)), F#lambda#12($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^102.31#tc1), 2)), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^102.31#tc1), 1)), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), Q#i$1^102.31#tc1, ^^i4)))));
      invariant $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), L#p), F#lambda#13($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $op_mul(2, L#p) + 2), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $op_mul(2, L#p) + 1), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4)), P#elt));
      invariant $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4)) == P#elt;
    {
      anon21:
        assume (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(loopState#0, #p) || $set_in(#p, $span($ptr(^Heap, P#h))) || $mem_eq(loopState#0, $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(loopState#0, #p) || $set_in(#p, $span($ptr(^Heap, P#h))) || $st_eq(loopState#0, $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(loopState#0, #p) || $set_in(#p, $span($ptr(^Heap, P#h))) || $ts_eq(loopState#0, $s, #p)) && $timestamp_post(loopState#0, $s);
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
            assert $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), L#p2), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), $op_mul(2, L#p) + 2, ^^i4))) >= 0;
            // assume >=(@map_get(@map_get(*((h->sh)), p2), *((h->heap)[+(*(2, p), 2)])), 0); 
            assume $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), L#p2), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), $op_mul(2, L#p) + 2, ^^i4))) >= 0;
            // assert >=(@map_get(@map_get(*((h->sh)), p2), *((h->heap)[+(*(2, p), 1)])), 0); 
            assert $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), L#p2), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), $op_mul(2, L#p) + 1, ^^i4))) >= 0;
            // assume >=(@map_get(@map_get(*((h->sh)), p2), *((h->heap)[+(*(2, p), 1)])), 0); 
            assume $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), L#p2), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), $op_mul(2, L#p) + 1, ^^i4))) >= 0;
            // assert @reads_check_normal((h->heap)[p]); 
            assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
            assert $thread_local2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
            // assert @reads_check_normal((h->heap)[p2]); 
            assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p2, ^^i4), ^^i4);
            assert $thread_local2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p2, ^^i4), ^^i4);
            assume true;
            // if (<(*((h->heap)[p]), *((h->heap)[p2]))) ...
            if ($mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4)) < $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p2, ^^i4)))
            {
              anon16:
                // int32_t tmp; 
                assume $local_value_is($s, #tok$1^122.7, #loc.tmp, L#tmp, ^^i4);
                // var int32_t tmp
                // assert @reads_check_normal((h->heap)[p]); 
                assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
                assert $thread_local2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
                // tmp := *((h->heap)[p]); 
                L#tmp := $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4));
                assume $local_value_is($s, #tok$1^123.7, #loc.tmp, L#tmp, ^^i4);
                // assert @_vcc_typed2(@state, (h->heap)[p]); 
                assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
                // assert @prim_writes_check((h->heap)[p]); 
                assert $writable($s, #wrTime$1^101.28, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4));
                // assert @reads_check_normal((h->heap)[p2]); 
                assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p2, ^^i4), ^^i4);
                assert $thread_local2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p2, ^^i4), ^^i4);
                // *(h->heap)[p] := *((h->heap)[p2]); 
                call $write_int($idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p2, ^^i4)));
                assume $full_stop_ext(#tok$1^124.7, $s);
                // assert @_vcc_typed2(@state, (h->heap)[p2]); 
                assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p2, ^^i4), ^^i4);
                // assert @prim_writes_check((h->heap)[p2]); 
                assert $writable($s, #wrTime$1^101.28, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p2, ^^i4));
                // *(h->heap)[p2] := tmp; 
                call $write_int($idx($dot($ptr(^Heap, P#h), Heap.heap), L#p2, ^^i4), L#tmp);
                assume $full_stop_ext(#tok$1^125.7, $s);
            }
            else
            {
              anon17:
                // (int32_t -> mathint) res_lambda#14#45; 
                assume $local_value_is($s, #tok$1^130.40, #loc.res_lambda#14#45, $map_t..^^i4.^^mathint_to_int(res_lambda#14#45), $map_t(^^i4, ^^mathint));
                // assert @reads_check_normal((h->sh)); 
                assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
                assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
                // assert @in_range_u4(+(*(2, p), 2)); 
                assert $in_range_u4($op_mul(2, L#p) + 2);
                // assert @in_range_u4(*(2, p)); 
                assert $in_range_u4($op_mul(2, L#p));
                // assert @reads_check_normal((h->sh)); 
                assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
                assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
                // assert @in_range_u4(+(*(2, p), 1)); 
                assert $in_range_u4($op_mul(2, L#p) + 1);
                // assert @in_range_u4(*(2, p)); 
                assert $in_range_u4($op_mul(2, L#p));
                // assert @reads_check_normal((h->heap)[p]); 
                assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
                assert $thread_local2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
                // res_lambda#14#45 := lambda#14(@map_get(*((h->sh)), +(*(2, p), 2)), @map_get(*((h->sh)), +(*(2, p), 1)), *((h->heap)[p])); 
                call res_lambda#14#45 := lambda#14($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $op_mul(2, L#p) + 2), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $op_mul(2, L#p) + 1), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4)));
                assume $full_stop_ext(#tok$1^130.40, $s);
                assume $local_value_is($s, #tok$1^130.40, #loc.res_lambda#14#45, $map_t..^^i4.^^mathint_to_int(res_lambda#14#45), $map_t(^^i4, ^^mathint));
                // assert @_vcc_typed2(@state, (h->sh)); 
                assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
                // assert @prim_writes_check((h->sh)); 
                assert $writable($s, #wrTime$1^101.28, $dot($ptr(^Heap, P#h), Heap.sh));
                // assert @reads_check_normal((h->sh)); 
                assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
                assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
                // *(h->sh) := @map_updated(*((h->sh)), p, res_lambda#14#45); 
                call $write_int($dot($ptr(^Heap, P#h), Heap.sh), $map_t..^^u4.map_t..^^i4.^^mathint_to_int($store.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), L#p, res_lambda#14#45)));
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
            assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
            assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
            // assert @in_range_u4(+(*(2, p), 2)); 
            assert $in_range_u4($op_mul(2, L#p) + 2);
            // assert @in_range_u4(*(2, p)); 
            assert $in_range_u4($op_mul(2, L#p));
            // assert @reads_check_normal((h->sh)); 
            assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
            assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
            // assert @in_range_u4(+(*(2, p), 1)); 
            assert $in_range_u4($op_mul(2, L#p) + 1);
            // assert @in_range_u4(*(2, p)); 
            assert $in_range_u4($op_mul(2, L#p));
            // assert @reads_check_normal((h->heap)[p]); 
            assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
            assert $thread_local2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
            // res_lambda#15#46 := lambda#15(@map_get(*((h->sh)), +(*(2, p), 2)), @map_get(*((h->sh)), +(*(2, p), 1)), *((h->heap)[p])); 
            call res_lambda#15#46 := lambda#15($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $op_mul(2, L#p) + 2), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $op_mul(2, L#p) + 1), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4)));
            assume $full_stop_ext(#tok$1^135.38, $s);
            assume $local_value_is($s, #tok$1^135.38, #loc.res_lambda#15#46, $map_t..^^i4.^^mathint_to_int(res_lambda#15#46), $map_t(^^i4, ^^mathint));
            // assert @_vcc_typed2(@state, (h->sh)); 
            assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
            // assert @prim_writes_check((h->sh)); 
            assert $writable($s, #wrTime$1^101.28, $dot($ptr(^Heap, P#h), Heap.sh));
            // assert @reads_check_normal((h->sh)); 
            assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
            assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
            // *(h->sh) := @map_updated(*((h->sh)), p, res_lambda#15#46); 
            call $write_int($dot($ptr(^Heap, P#h), Heap.sh), $map_t..^^u4.map_t..^^i4.^^mathint_to_int($store.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), L#p, res_lambda#15#46)));
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
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^143.28, #p) } $in_writes_at(#wrTime$1^143.28, #p) == $set_in(#p, $span($ptr(^Heap, P#h))));
    assert (forall #loopWrites^$1^143.28: $ptr :: { $dont_instantiate(#loopWrites^$1^143.28) } $top_writable($s, #wrTime$1^143.28, #loopWrites^$1^143.28) ==> $top_writable($s, #wrTime$1^81.1, #loopWrites^$1^143.28));
    while (true)
      invariant $mem(loopState#1, $dot($ptr(^Heap, P#h), Heap.len)) == $mem($s, $dot($ptr(^Heap, P#h), Heap.len));
      invariant $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(loopState#1, $dot($ptr(^Heap, P#h), Heap.sh))), 0), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), 0));
      invariant L#p < $mem($s, $dot($ptr(^Heap, P#h), Heap.len));
      invariant (forall Q#i$1^142.31#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^142.31#tc1)) } $in_range_u4(Q#i$1^142.31#tc1) ==> Q#i$1^142.31#tc1 >= $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^142.31#tc1)), F#lambda#16()));
      invariant (forall Q#i$1^142.31#tc1: int, Q#e$1^142.31#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^142.31#tc1)), Q#e$1^142.31#tc2) } { F#mark3(Q#i$1^142.31#tc1, Q#e$1^142.31#tc2) } { sk_hack(F#mark3(Q#i$1^142.31#tc1, Q#e$1^142.31#tc2)) } $in_range_u4(Q#i$1^142.31#tc1) && $in_range_i4(Q#e$1^142.31#tc2) ==> Q#i$1^142.31#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^142.31#tc1)), Q#e$1^142.31#tc2) >= 0);
      invariant (forall Q#i$1^142.31#tc1: int, Q#e$1^142.31#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^142.31#tc1)), Q#e$1^142.31#tc2) } { F#mark3(Q#i$1^142.31#tc1, Q#e$1^142.31#tc2) } { sk_hack(F#mark3(Q#i$1^142.31#tc1, Q#e$1^142.31#tc2)) } $in_range_u4(Q#i$1^142.31#tc1) && $in_range_i4(Q#e$1^142.31#tc2) ==> Q#i$1^142.31#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> Q#i$1^142.31#tc1 != $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), Q#i$1^142.31#tc1), Q#e$1^142.31#tc2) > 0 ==> Q#e$1^142.31#tc2 >= $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), Q#i$1^142.31#tc1, ^^i4)));
      invariant (forall Q#i$1^144.31#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^144.31#tc1)) } $in_range_u4(Q#i$1^144.31#tc1) ==> Q#i$1^144.31#tc1 != L#p && Q#i$1^144.31#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^144.31#tc1)), F#lambda#17($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^144.31#tc1), 2)), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^144.31#tc1), 1)), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), Q#i$1^144.31#tc1, ^^i4)))));
      invariant $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), L#p), F#lambda#18($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $op_mul(2, L#p) + 2), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $op_mul(2, L#p) + 1), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4)), P#elt));
      invariant $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4)) <= P#elt;
      invariant L#p == 0 || $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), L#p), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4))) > 0;
    {
      anon24:
        assume (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(loopState#1, #p) || $set_in(#p, $span($ptr(^Heap, P#h))) || $mem_eq(loopState#1, $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(loopState#1, #p) || $set_in(#p, $span($ptr(^Heap, P#h))) || $st_eq(loopState#1, $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(loopState#1, #p) || $set_in(#p, $span($ptr(^Heap, P#h))) || $ts_eq(loopState#1, $s, #p)) && $timestamp_post(loopState#1, $s);
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
            assert $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), p2#0), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4))) > 0;
            // assume >(@map_get(@map_get(*((h->sh)), p2#0), *((h->heap)[p])), 0); 
            assume $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), p2#0), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4))) > 0;
            // (int32_t -> mathint) res_lambda#19#47; 
            assume $local_value_is($s, #tok$1^160.38, #loc.res_lambda#19#47, $map_t..^^i4.^^mathint_to_int(res_lambda#19#47), $map_t(^^i4, ^^mathint));
            // assert @reads_check_normal((h->sh)); 
            assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
            assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
            // assert @in_range_u4(+(*(2, p), 2)); 
            assert $in_range_u4($op_mul(2, L#p) + 2);
            // assert @in_range_u4(*(2, p)); 
            assert $in_range_u4($op_mul(2, L#p));
            // assert @reads_check_normal((h->sh)); 
            assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
            assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
            // assert @in_range_u4(+(*(2, p), 1)); 
            assert $in_range_u4($op_mul(2, L#p) + 1);
            // assert @in_range_u4(*(2, p)); 
            assert $in_range_u4($op_mul(2, L#p));
            // assert @reads_check_normal((h->heap)[p]); 
            assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
            assert $thread_local2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
            // res_lambda#19#47 := lambda#19(@map_get(*((h->sh)), +(*(2, p), 2)), @map_get(*((h->sh)), +(*(2, p), 1)), *((h->heap)[p])); 
            call res_lambda#19#47 := lambda#19($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $op_mul(2, L#p) + 2), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $op_mul(2, L#p) + 1), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4)));
            assume $full_stop_ext(#tok$1^160.38, $s);
            assume $local_value_is($s, #tok$1^160.38, #loc.res_lambda#19#47, $map_t..^^i4.^^mathint_to_int(res_lambda#19#47), $map_t(^^i4, ^^mathint));
            // assert @_vcc_typed2(@state, (h->sh)); 
            assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
            // assert @prim_writes_check((h->sh)); 
            assert $writable($s, #wrTime$1^143.28, $dot($ptr(^Heap, P#h), Heap.sh));
            // assert @reads_check_normal((h->sh)); 
            assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
            assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
            // *(h->sh) := @map_updated(*((h->sh)), p, res_lambda#19#47); 
            call $write_int($dot($ptr(^Heap, P#h), Heap.sh), $map_t..^^u4.map_t..^^i4.^^mathint_to_int($store.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), L#p, res_lambda#19#47)));
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
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    // assert @in_range_u4(+(*(2, p), 2)); 
    assert $in_range_u4($op_mul(2, L#p) + 2);
    // assert @in_range_u4(*(2, p)); 
    assert $in_range_u4($op_mul(2, L#p));
    // assert @reads_check_normal((h->sh)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    // assert @in_range_u4(+(*(2, p), 1)); 
    assert $in_range_u4($op_mul(2, L#p) + 1);
    // assert @in_range_u4(*(2, p)); 
    assert $in_range_u4($op_mul(2, L#p));
    // assert @reads_check_normal((h->heap)[p]); 
    assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
    assert $thread_local2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
    // res_lambda#20#48 := lambda#20(@map_get(*((h->sh)), +(*(2, p), 2)), @map_get(*((h->sh)), +(*(2, p), 1)), *((h->heap)[p])); 
    call res_lambda#20#48 := lambda#20($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $op_mul(2, L#p) + 2), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $op_mul(2, L#p) + 1), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4)));
    assume $full_stop_ext(#tok$1^166.16, $s);
    assume $local_value_is($s, #tok$1^166.16, #loc.res_lambda#20#48, $map_t..^^i4.^^mathint_to_int(res_lambda#20#48), $map_t(^^i4, ^^mathint));
    // assert @_vcc_typed2(@state, (h->sh)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    // assert @prim_writes_check((h->sh)); 
    assert $writable($s, #wrTime$1^81.1, $dot($ptr(^Heap, P#h), Heap.sh));
    // assert @reads_check_normal((h->sh)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    // *(h->sh) := @map_updated(*((h->sh)), p, res_lambda#20#48); 
    call $write_int($dot($ptr(^Heap, P#h), Heap.sh), $map_t..^^u4.map_t..^^i4.^^mathint_to_int($store.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), L#p, res_lambda#20#48)));
    assume $full_stop_ext(#tok$1^166.5, $s);
    // assert @_vcc_typed2(@state, (h->abs)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.abs), $map_t(^^i4, ^^mathint));
    // assert @prim_writes_check((h->abs)); 
    assert $writable($s, #wrTime$1^81.1, $dot($ptr(^Heap, P#h), Heap.abs));
    // assert @reads_check_normal((h->sh)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    // *(h->abs) := @map_get(*((h->sh)), p); 
    call $write_int($dot($ptr(^Heap, P#h), Heap.abs), $map_t..^^i4.^^mathint_to_int($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), L#p)));
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
    assert $top_writable($s, #wrTime$1^81.1, $ptr(^Heap, P#h));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(h), staticWrapState#60, owns#61)
    call $static_wrap($ptr(^Heap, P#h), staticWrapState#60, owns#61);
    assume $good_state_ext(#tok$1^169.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, h), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^Heap, P#h)), $set_empty());
    // assert @inv_check(@map_eq(@map_get(*((h->sh)), 0), *((h->abs)))); 
    assert $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), 0), $int_to_map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.abs))));
    // assert @inv_check(<=(*((h->len)), 1000)); 
    assert $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) <= 1000;
    // assert @inv_check(forall(uint32_t i; { @map_get(*((h->sh)), mark(i)) } @in_range_u4(i); ==>(&&(!=(i, *((h->len))), <(i, *((h->len)))), @map_eq(@map_get(*((h->sh)), mark(i)), lambda#6(@map_get(*((h->sh)), unchecked+(unchecked*(2, i), 2)), @map_get(*((h->sh)), unchecked+(unchecked*(2, i), 1)), *((h->heap)[i])))))); 
    assert (forall Q#i$1^65.29#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^65.29#tc1)) } $in_range_u4(Q#i$1^65.29#tc1) ==> Q#i$1^65.29#tc1 != $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) && Q#i$1^65.29#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^65.29#tc1)), F#lambda#6($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 2)), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 1)), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), Q#i$1^65.29#tc1, ^^i4)))));
    // assert @inv_check(forall(uint32_t i; { @map_get(*((h->sh)), mark(i)) } @in_range_u4(i); ==>(>=(i, *((h->len))), @map_eq(@map_get(*((h->sh)), mark(i)), lambda#7())))); 
    assert (forall Q#i$1^66.29#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^66.29#tc1)) } $in_range_u4(Q#i$1^66.29#tc1) ==> Q#i$1^66.29#tc1 >= $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), F#lambda#7()));
    // assert @inv_check(forall(uint32_t i; int32_t e; { @map_get(@map_get(*((h->sh)), mark(i)), e) } { mark3(i, e) } { @trigger_hint(mark3(i, e)) } &&(@in_range_u4(i), @in_range_i4(e)); ==>(<(i, *((h->len))), >=(@map_get(@map_get(*((h->sh)), mark(i)), e), 0)))); 
    assert (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) >= 0);
    // assert @inv_check(forall(uint32_t i; int32_t e; { @map_get(@map_get(*((h->sh)), mark(i)), e) } { mark3(i, e) } { @trigger_hint(mark3(i, e)) } &&(@in_range_u4(i), @in_range_i4(e)); ==>(<(i, *((h->len))), ==>(!=(i, *((h->len))), ==>(>(@map_get(@map_get(*((h->sh)), i), e), 0), >=(e, *((h->heap)[i]))))))); 
    assert (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> Q#i$1^66.29#tc1 != $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), Q#i$1^66.29#tc1), Q#e$1^66.29#tc2) > 0 ==> Q#e$1^66.29#tc2 >= $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), Q#i$1^66.29#tc1, ^^i4)));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure extractMin(P#h: int) returns ($result: int);
  requires $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) > 0;
  requires $wrapped($s, $ptr(^Heap, P#h), ^Heap);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  ensures $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($mem(old($s), $dot($ptr(^Heap, P#h), Heap.abs))), $result) > 0;
  ensures (forall Q#e$1^177.27#tc2: int :: $in_range_i4(Q#e$1^177.27#tc2) ==> $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($mem(old($s), $dot($ptr(^Heap, P#h), Heap.abs))), Q#e$1^177.27#tc2) > 0 ==> $result <= Q#e$1^177.27#tc2);
  ensures $eq.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.abs))), F#lambda#34($int_to_map_t..^^i4.^^mathint($mem(old($s), $dot($ptr(^Heap, P#h), Heap.abs))), $int_to_map_t..^^i4.^^mathint($mem(old($s), $dot($ptr(^Heap, P#h), Heap.abs))), $result));
  ensures $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) == $mem(old($s), $dot($ptr(^Heap, P#h), Heap.len)) - 1;
  ensures $wrapped($s, $ptr(^Heap, P#h), ^Heap);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Heap, P#h) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Heap, P#h) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Heap, P#h) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation extractMin(P#h: int) returns ($result: int)
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
    assume $local_value_is($s, #tok$1^172.1, #loc.h, $ptr_to_int($ptr(^Heap, P#h)), $ptr_to(^Heap)) && $local_value_is_ptr($s, #tok$1^172.1, #loc.h, $ptr(^Heap, P#h), $ptr_to(^Heap));
    assume #wrTime$1^172.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^172.1, #p) } $in_writes_at(#wrTime$1^172.1, #p) == (#p == $ptr(^Heap, P#h)));
    assume $thread_owned($s, $ptr(^Heap, P#h));
    // assume @in_range_phys_ptr((mathint)h); 
    assume $in_range_phys_ptr($ref($ptr(^Heap, P#h)));
    // assert @_vcc_in_domain(@state, h, h); 
    assert $in_domain_lab($s, $ptr(^Heap, P#h), $ptr(^Heap, P#h), l#public);
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
    assert $wrapped($s, $ptr(^Heap, P#h), ^Heap);
    // assert @writes_check(h); 
    assert $top_writable($s, #wrTime$1^172.1, $ptr(^Heap, P#h));
    // assume @_vcc_inv(@state, h); 
    assume $inv($s, $ptr(^Heap, P#h), ^Heap);
    // assume ==(owns#64, @_vcc_owns(@state, h)); 
    assume owns#64 == $owns($s, $ptr(^Heap, P#h));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(h), prestate#65)
    call $static_unwrap($ptr(^Heap, P#h), prestate#65);
    assume $good_state_ext(#tok$1^185.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @reads_check_normal((h->heap)[0]); 
    assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), 0, ^^i4), ^^i4);
    assert $thread_local2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), 0, ^^i4), ^^i4);
    // res := *((h->heap)[0]); 
    L#res := $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), 0, ^^i4));
    assume $local_value_is($s, #tok$1^186.3, #loc.res, L#res, ^^i4);
    // assert mark3(0, 0); 
    assert F#mark3(0, 0);
    // assume mark3(0, 0); 
    assume F#mark3(0, 0);
    // assert forall(int32_t e; @in_range_i4(e); ==>(>(@map_get(old(@prestate, *((h->abs))), e), 0), <=(res, e))); 
    assert (forall Q#e$1^188.26#tc2: int :: $in_range_i4(Q#e$1^188.26#tc2) ==> $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($mem(old($s), $dot($ptr(^Heap, P#h), Heap.abs))), Q#e$1^188.26#tc2) > 0 ==> L#res <= Q#e$1^188.26#tc2);
    // assume forall(int32_t e; @in_range_i4(e); ==>(>(@map_get(old(@prestate, *((h->abs))), e), 0), <=(res, e))); 
    assume (forall Q#e$1^188.26#tc2: int :: $in_range_i4(Q#e$1^188.26#tc2) ==> $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($mem(old($s), $dot($ptr(^Heap, P#h), Heap.abs))), Q#e$1^188.26#tc2) > 0 ==> L#res <= Q#e$1^188.26#tc2);
    // assert @_vcc_typed2(@state, (h->len)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.len), ^^u4);
    // assert @prim_writes_check((h->len)); 
    assert $writable($s, #wrTime$1^172.1, $dot($ptr(^Heap, P#h), Heap.len));
    // assert @in_range_u4(-(*((h->len)), 1)); 
    assert $in_range_u4($mem($s, $dot($ptr(^Heap, P#h), Heap.len)) - 1);
    // assert @reads_check_normal((h->len)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.len), ^^u4);
    assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.len), ^^u4);
    // *(h->len) := -(*((h->len)), 1); 
    call $write_int($dot($ptr(^Heap, P#h), Heap.len), $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) - 1);
    assume $full_stop_ext(#tok$1^189.3, $s);
    // assert @reads_check_normal((h->len)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.len), ^^u4);
    assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.len), ^^u4);
    // p := *((h->len)); 
    L#p := $mem($s, $dot($ptr(^Heap, P#h), Heap.len));
    assume $local_value_is($s, #tok$1^191.3, #loc.p, L#p, ^^u4);
    // assert mark3(p, 0); 
    assert F#mark3(L#p, 0);
    // assume mark3(p, 0); 
    assume F#mark3(L#p, 0);
    // assert @reads_check_normal((h->heap)[p]); 
    assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
    assert $thread_local2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
    // last := *((h->heap)[p]); 
    L#last := $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4));
    assume $local_value_is($s, #tok$1^193.3, #loc.last, L#last, ^^i4);
    // assert ==(@map_get(@map_get(*((h->sh)), p), last), 1); 
    assert $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), L#p), L#last) == 1;
    // assume ==(@map_get(@map_get(*((h->sh)), p), last), 1); 
    assume $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), L#p), L#last) == 1;
    // (int32_t -> mathint) res_lambda#22#49; 
    assume $local_value_is($s, #tok$1^195.36, #loc.res_lambda#22#49, $map_t..^^i4.^^mathint_to_int(res_lambda#22#49), $map_t(^^i4, ^^mathint));
    // res_lambda#22#49 := lambda#22(); 
    call res_lambda#22#49 := lambda#22();
    assume $full_stop_ext(#tok$1^195.36, $s);
    assume $local_value_is($s, #tok$1^195.36, #loc.res_lambda#22#49, $map_t..^^i4.^^mathint_to_int(res_lambda#22#49), $map_t(^^i4, ^^mathint));
    // assert @_vcc_typed2(@state, (h->sh)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    // assert @prim_writes_check((h->sh)); 
    assert $writable($s, #wrTime$1^172.1, $dot($ptr(^Heap, P#h), Heap.sh));
    // assert @reads_check_normal((h->sh)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    // *(h->sh) := @map_updated(*((h->sh)), p, res_lambda#22#49); 
    call $write_int($dot($ptr(^Heap, P#h), Heap.sh), $map_t..^^u4.map_t..^^i4.^^mathint_to_int($store.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), L#p, res_lambda#22#49)));
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
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^206.29, #p) } $in_writes_at(#wrTime$1^206.29, #p) == (#p == $dot($ptr(^Heap, P#h), Heap.sh)));
    assert (forall #loopWrites^$1^206.29: $ptr :: { $dont_instantiate(#loopWrites^$1^206.29) } $top_writable($s, #wrTime$1^206.29, #loopWrites^$1^206.29) ==> $top_writable($s, #wrTime$1^172.1, #loopWrites^$1^206.29));
    while (true)
      invariant $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem(loopState#2, $dot($ptr(^Heap, P#h), Heap.sh))), 0), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), 0));
      invariant L#p < $mem($s, $dot($ptr(^Heap, P#h), Heap.len));
      invariant (forall Q#i$1^205.31#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^205.31#tc1)) } $in_range_u4(Q#i$1^205.31#tc1) ==> Q#i$1^205.31#tc1 >= $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^205.31#tc1)), F#lambda#23()));
      invariant (forall Q#i$1^205.31#tc1: int, Q#e$1^205.31#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^205.31#tc1)), Q#e$1^205.31#tc2) } { F#mark3(Q#i$1^205.31#tc1, Q#e$1^205.31#tc2) } { sk_hack(F#mark3(Q#i$1^205.31#tc1, Q#e$1^205.31#tc2)) } $in_range_u4(Q#i$1^205.31#tc1) && $in_range_i4(Q#e$1^205.31#tc2) ==> Q#i$1^205.31#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^205.31#tc1)), Q#e$1^205.31#tc2) >= 0);
      invariant (forall Q#i$1^205.31#tc1: int, Q#e$1^205.31#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^205.31#tc1)), Q#e$1^205.31#tc2) } { F#mark3(Q#i$1^205.31#tc1, Q#e$1^205.31#tc2) } { sk_hack(F#mark3(Q#i$1^205.31#tc1, Q#e$1^205.31#tc2)) } $in_range_u4(Q#i$1^205.31#tc1) && $in_range_i4(Q#e$1^205.31#tc2) ==> Q#i$1^205.31#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> Q#i$1^205.31#tc1 != $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), Q#i$1^205.31#tc1), Q#e$1^205.31#tc2) > 0 ==> Q#e$1^205.31#tc2 >= $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), Q#i$1^205.31#tc1, ^^i4)));
      invariant (forall Q#i$1^207.31#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^207.31#tc1)) } $in_range_u4(Q#i$1^207.31#tc1) ==> Q#i$1^207.31#tc1 != L#p && Q#i$1^207.31#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^207.31#tc1)), F#lambda#24($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^207.31#tc1), 2)), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^207.31#tc1), 1)), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), Q#i$1^207.31#tc1, ^^i4)))));
      invariant $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), L#p), F#lambda#25($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $op_mul(2, L#p) + 2), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $op_mul(2, L#p) + 1), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4)), L#last));
    {
      anon32:
        assume (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(loopState#2, #p) || #p == $dot($ptr(^Heap, P#h), Heap.sh) || $mem_eq(loopState#2, $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(loopState#2, #p) || #p == $dot($ptr(^Heap, P#h), Heap.sh) || $st_eq(loopState#2, $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(loopState#2, #p) || #p == $dot($ptr(^Heap, P#h), Heap.sh) || $ts_eq(loopState#2, $s, #p)) && $timestamp_post(loopState#2, $s);
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
            assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
            assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
            // assert @in_range_u4(+(*(2, p), 2)); 
            assert $in_range_u4($op_mul(2, L#p) + 2);
            // assert @in_range_u4(*(2, p)); 
            assert $in_range_u4($op_mul(2, L#p));
            // assert @reads_check_normal((h->sh)); 
            assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
            assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
            // assert @in_range_u4(+(*(2, p), 1)); 
            assert $in_range_u4($op_mul(2, L#p) + 1);
            // assert @in_range_u4(*(2, p)); 
            assert $in_range_u4($op_mul(2, L#p));
            // assert @reads_check_normal((h->heap)[p]); 
            assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
            assert $thread_local2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
            // res_lambda#26#50 := lambda#26(@map_get(*((h->sh)), +(*(2, p), 2)), @map_get(*((h->sh)), +(*(2, p), 1)), *((h->heap)[p])); 
            call res_lambda#26#50 := lambda#26($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $op_mul(2, L#p) + 2), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $op_mul(2, L#p) + 1), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4)));
            assume $full_stop_ext(#tok$1^212.38, $s);
            assume $local_value_is($s, #tok$1^212.38, #loc.res_lambda#26#50, $map_t..^^i4.^^mathint_to_int(res_lambda#26#50), $map_t(^^i4, ^^mathint));
            // assert @_vcc_typed2(@state, (h->sh)); 
            assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
            // assert @prim_writes_check((h->sh)); 
            assert $writable($s, #wrTime$1^206.29, $dot($ptr(^Heap, P#h), Heap.sh));
            // assert @reads_check_normal((h->sh)); 
            assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
            assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
            // *(h->sh) := @map_updated(*((h->sh)), p, res_lambda#26#50); 
            call $write_int($dot($ptr(^Heap, P#h), Heap.sh), $map_t..^^u4.map_t..^^i4.^^mathint_to_int($store.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), L#p, res_lambda#26#50)));
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
    // assert @_vcc_typed2(@state, (h->heap)[0]); 
    assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), 0, ^^i4), ^^i4);
    // assert @prim_writes_check((h->heap)[0]); 
    assert $writable($s, #wrTime$1^172.1, $idx($dot($ptr(^Heap, P#h), Heap.heap), 0, ^^i4));
    // assert @reads_check_normal((h->heap)[*((h->len))]); 
    assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), $mem($s, $dot($ptr(^Heap, P#h), Heap.len)), ^^i4), ^^i4);
    assert $thread_local2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), $mem($s, $dot($ptr(^Heap, P#h), Heap.len)), ^^i4), ^^i4);
    // assert @reads_check_normal((h->len)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.len), ^^u4);
    assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.len), ^^u4);
    // *(h->heap)[0] := *((h->heap)[*((h->len))]); 
    call $write_int($idx($dot($ptr(^Heap, P#h), Heap.heap), 0, ^^i4), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), $mem($s, $dot($ptr(^Heap, P#h), Heap.len)), ^^i4)));
    assume $full_stop_ext(#tok$1^216.3, $s);
    // (int32_t -> mathint) res_lambda#27#51; 
    assume $local_value_is($s, #tok$1^217.36, #loc.res_lambda#27#51, $map_t..^^i4.^^mathint_to_int(res_lambda#27#51), $map_t(^^i4, ^^mathint));
    // assert @reads_check_normal((h->sh)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    // assert @in_range_u4(+(*(2, p), 2)); 
    assert $in_range_u4($op_mul(2, L#p) + 2);
    // assert @in_range_u4(*(2, p)); 
    assert $in_range_u4($op_mul(2, L#p));
    // assert @reads_check_normal((h->sh)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    // assert @in_range_u4(+(*(2, p), 1)); 
    assert $in_range_u4($op_mul(2, L#p) + 1);
    // assert @in_range_u4(*(2, p)); 
    assert $in_range_u4($op_mul(2, L#p));
    // assert @reads_check_normal((h->heap)[p]); 
    assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
    assert $thread_local2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
    // res_lambda#27#51 := lambda#27(@map_get(*((h->sh)), +(*(2, p), 2)), @map_get(*((h->sh)), +(*(2, p), 1)), *((h->heap)[p])); 
    call res_lambda#27#51 := lambda#27($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $op_mul(2, L#p) + 2), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $op_mul(2, L#p) + 1), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4)));
    assume $full_stop_ext(#tok$1^217.36, $s);
    assume $local_value_is($s, #tok$1^217.36, #loc.res_lambda#27#51, $map_t..^^i4.^^mathint_to_int(res_lambda#27#51), $map_t(^^i4, ^^mathint));
    // assert @_vcc_typed2(@state, (h->sh)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    // assert @prim_writes_check((h->sh)); 
    assert $writable($s, #wrTime$1^172.1, $dot($ptr(^Heap, P#h), Heap.sh));
    // assert @reads_check_normal((h->sh)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    // *(h->sh) := @map_updated(*((h->sh)), 0, res_lambda#27#51); 
    call $write_int($dot($ptr(^Heap, P#h), Heap.sh), $map_t..^^u4.map_t..^^i4.^^mathint_to_int($store.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), 0, res_lambda#27#51)));
    assume $full_stop_ext(#tok$1^217.25, $s);
    // p := 0; 
    L#p := 0;
    assume $local_value_is($s, #tok$1^219.3, #loc.p, L#p, ^^u4);
    call $bump_timestamp();
    assume $full_stop_ext(#tok$1^223.28, $s);
    loopState#3 := $s;
    assume #wrTime$1^223.28 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^223.28, #p) } $in_writes_at(#wrTime$1^223.28, #p) == $set_in(#p, $span($ptr(^Heap, P#h))));
    assert (forall #loopWrites^$1^223.28: $ptr :: { $dont_instantiate(#loopWrites^$1^223.28) } $top_writable($s, #wrTime$1^223.28, #loopWrites^$1^223.28) ==> $top_writable($s, #wrTime$1^172.1, #loopWrites^$1^223.28));
    while (true)
      invariant $mem(loopState#3, $dot($ptr(^Heap, P#h), Heap.len)) == $mem($s, $dot($ptr(^Heap, P#h), Heap.len));
      invariant $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), 0), F#lambda#28($int_to_map_t..^^i4.^^mathint($mem(loopState#3, $dot($ptr(^Heap, P#h), Heap.abs))), $int_to_map_t..^^i4.^^mathint($mem(loopState#3, $dot($ptr(^Heap, P#h), Heap.abs))), L#res));
      invariant (forall Q#i$1^224.31#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^224.31#tc1)) } $in_range_u4(Q#i$1^224.31#tc1) ==> Q#i$1^224.31#tc1 >= $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^224.31#tc1)), F#lambda#29()));
      invariant (forall Q#i$1^224.31#tc1: int, Q#e$1^224.31#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^224.31#tc1)), Q#e$1^224.31#tc2) } { F#mark3(Q#i$1^224.31#tc1, Q#e$1^224.31#tc2) } { sk_hack(F#mark3(Q#i$1^224.31#tc1, Q#e$1^224.31#tc2)) } $in_range_u4(Q#i$1^224.31#tc1) && $in_range_i4(Q#e$1^224.31#tc2) ==> Q#i$1^224.31#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^224.31#tc1)), Q#e$1^224.31#tc2) >= 0);
      invariant (forall Q#i$1^224.31#tc1: int, Q#e$1^224.31#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^224.31#tc1)), Q#e$1^224.31#tc2) } { F#mark3(Q#i$1^224.31#tc1, Q#e$1^224.31#tc2) } { sk_hack(F#mark3(Q#i$1^224.31#tc1, Q#e$1^224.31#tc2)) } $in_range_u4(Q#i$1^224.31#tc1) && $in_range_i4(Q#e$1^224.31#tc2) ==> Q#i$1^224.31#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> Q#i$1^224.31#tc1 != L#p ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), Q#i$1^224.31#tc1), Q#e$1^224.31#tc2) > 0 ==> Q#e$1^224.31#tc2 >= $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), Q#i$1^224.31#tc1, ^^i4)));
      invariant (forall Q#i$1^225.31#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^225.31#tc1)) } $in_range_u4(Q#i$1^225.31#tc1) ==> Q#i$1^225.31#tc1 != $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) && Q#i$1^225.31#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^225.31#tc1)), F#lambda#30($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^225.31#tc1), 2)), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^225.31#tc1), 1)), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), Q#i$1^225.31#tc1, ^^i4)))));
    {
      anon49:
        assume (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(loopState#3, #p) || $set_in(#p, $span($ptr(^Heap, P#h))) || $mem_eq(loopState#3, $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(loopState#3, #p) || $set_in(#p, $span($ptr(^Heap, P#h))) || $st_eq(loopState#3, $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(loopState#3, #p) || $set_in(#p, $span($ptr(^Heap, P#h))) || $ts_eq(loopState#3, $s, #p)) && $timestamp_post(loopState#3, $s);
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
        assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.len), ^^u4);
        assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.len), ^^u4);
        assume true;
        // if (<(p, *((h->len)))) ...
        if (L#p < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)))
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
            assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.len), ^^u4);
            assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.len), ^^u4);
            assume true;
            // if (<(l, *((h->len)))) ...
            if (L#l < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)))
            {
              anon33:
                // assert @reads_check_normal((h->heap)[l]); 
                assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#l, ^^i4), ^^i4);
                assert $thread_local2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#l, ^^i4), ^^i4);
                // assert @reads_check_normal((h->heap)[p]); 
                assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
                assert $thread_local2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
                // ite#1 := <(*((h->heap)[l]), *((h->heap)[p])); 
                ite#1 := $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#l, ^^i4)) < $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4));
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
            assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.len), ^^u4);
            assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.len), ^^u4);
            assume true;
            // if (<(r, *((h->len)))) ...
            if (L#r < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)))
            {
              anon37:
                // assert @reads_check_normal((h->heap)[r]); 
                assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#r, ^^i4), ^^i4);
                assert $thread_local2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#r, ^^i4), ^^i4);
                // assert @reads_check_normal((h->heap)[smallest]); 
                assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#smallest, ^^i4), ^^i4);
                assert $thread_local2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#smallest, ^^i4), ^^i4);
                // ite#2 := <(*((h->heap)[r]), *((h->heap)[smallest])); 
                ite#2 := $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#r, ^^i4)) < $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#smallest, ^^i4));
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
                assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
                assert $thread_local2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
                // tmp := *((h->heap)[p]); 
                L#tmp := $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4));
                assume $local_value_is($s, #tok$1^235.7, #loc.tmp, L#tmp, ^^i4);
                // assert @_vcc_typed2(@state, (h->heap)[p]); 
                assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), ^^i4);
                // assert @prim_writes_check((h->heap)[p]); 
                assert $writable($s, #wrTime$1^223.28, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4));
                // assert @reads_check_normal((h->heap)[smallest]); 
                assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#smallest, ^^i4), ^^i4);
                assert $thread_local2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#smallest, ^^i4), ^^i4);
                // *(h->heap)[p] := *((h->heap)[smallest]); 
                call $write_int($idx($dot($ptr(^Heap, P#h), Heap.heap), L#p, ^^i4), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#smallest, ^^i4)));
                assume $full_stop_ext(#tok$1^236.7, $s);
                // assert @_vcc_typed2(@state, (h->heap)[smallest]); 
                assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#smallest, ^^i4), ^^i4);
                // assert @prim_writes_check((h->heap)[smallest]); 
                assert $writable($s, #wrTime$1^223.28, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#smallest, ^^i4));
                // *(h->heap)[smallest] := tmp; 
                call $write_int($idx($dot($ptr(^Heap, P#h), Heap.heap), L#smallest, ^^i4), L#tmp);
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
                assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
                assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
                // assert @in_range_u4(+(*(2, smallest), 2)); 
                assert $in_range_u4($op_mul(2, L#smallest) + 2);
                // assert @in_range_u4(*(2, smallest)); 
                assert $in_range_u4($op_mul(2, L#smallest));
                // assert @reads_check_normal((h->sh)); 
                assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
                assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
                // assert @in_range_u4(+(*(2, smallest), 1)); 
                assert $in_range_u4($op_mul(2, L#smallest) + 1);
                // assert @in_range_u4(*(2, smallest)); 
                assert $in_range_u4($op_mul(2, L#smallest));
                // assert @reads_check_normal((h->heap)[smallest]); 
                assert $typed2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#smallest, ^^i4), ^^i4);
                assert $thread_local2($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#smallest, ^^i4), ^^i4);
                // res_lambda#31#52 := lambda#31(@map_get(*((h->sh)), +(*(2, smallest), 2)), @map_get(*((h->sh)), +(*(2, smallest), 1)), *((h->heap)[smallest])); 
                call res_lambda#31#52 := lambda#31($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $op_mul(2, L#smallest) + 2), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $op_mul(2, L#smallest) + 1), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), L#smallest, ^^i4)));
                assume $full_stop_ext(#tok$1^240.47, $s);
                assume $local_value_is($s, #tok$1^240.47, #loc.res_lambda#31#52, $map_t..^^i4.^^mathint_to_int(res_lambda#31#52), $map_t(^^i4, ^^mathint));
                // assert @_vcc_typed2(@state, (h->sh)); 
                assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
                // assert @prim_writes_check((h->sh)); 
                assert $writable($s, #wrTime$1^223.28, $dot($ptr(^Heap, P#h), Heap.sh));
                // assert @reads_check_normal((h->sh)); 
                assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
                assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
                // *(h->sh) := @map_updated(*((h->sh)), smallest, res_lambda#31#52); 
                call $write_int($dot($ptr(^Heap, P#h), Heap.sh), $map_t..^^u4.map_t..^^i4.^^mathint_to_int($store.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), L#smallest, res_lambda#31#52)));
                assume $full_stop_ext(#tok$1^240.29, $s);
                // p := smallest; 
                L#p := L#smallest;
                assume $local_value_is($s, #tok$1^241.7, #loc.p, L#p, ^^u4);
            }
            else
            {
              anon42:
                // assert forall(uint32_t i; { @map_get(*((h->sh)), mark(i)) } @in_range_u4(i); ==>(>=(i, *((h->len))), @map_eq(@map_get(*((h->sh)), mark(i)), lambda#32()))); 
                assert (forall Q#i$1^244.30#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^244.30#tc1)) } $in_range_u4(Q#i$1^244.30#tc1) ==> Q#i$1^244.30#tc1 >= $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^244.30#tc1)), F#lambda#32()));
                // assert forall(uint32_t i; int32_t e; { @map_get(@map_get(*((h->sh)), mark(i)), e) } { mark3(i, e) } { @trigger_hint(mark3(i, e)) } &&(@in_range_u4(i), @in_range_i4(e)); ==>(<(i, *((h->len))), >=(@map_get(@map_get(*((h->sh)), mark(i)), e), 0))); 
                assert (forall Q#i$1^244.30#tc1: int, Q#e$1^244.30#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^244.30#tc1)), Q#e$1^244.30#tc2) } { F#mark3(Q#i$1^244.30#tc1, Q#e$1^244.30#tc2) } { sk_hack(F#mark3(Q#i$1^244.30#tc1, Q#e$1^244.30#tc2)) } $in_range_u4(Q#i$1^244.30#tc1) && $in_range_i4(Q#e$1^244.30#tc2) ==> Q#i$1^244.30#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^244.30#tc1)), Q#e$1^244.30#tc2) >= 0);
                // assert forall(uint32_t i; int32_t e; { @map_get(@map_get(*((h->sh)), mark(i)), e) } { mark3(i, e) } { @trigger_hint(mark3(i, e)) } &&(@in_range_u4(i), @in_range_i4(e)); ==>(<(i, *((h->len))), ==>(!=(i, *((h->len))), ==>(>(@map_get(@map_get(*((h->sh)), i), e), 0), >=(e, *((h->heap)[i])))))); 
                assert (forall Q#i$1^244.30#tc1: int, Q#e$1^244.30#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^244.30#tc1)), Q#e$1^244.30#tc2) } { F#mark3(Q#i$1^244.30#tc1, Q#e$1^244.30#tc2) } { sk_hack(F#mark3(Q#i$1^244.30#tc1, Q#e$1^244.30#tc2)) } $in_range_u4(Q#i$1^244.30#tc1) && $in_range_i4(Q#e$1^244.30#tc2) ==> Q#i$1^244.30#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> Q#i$1^244.30#tc1 != $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), Q#i$1^244.30#tc1), Q#e$1^244.30#tc2) > 0 ==> Q#e$1^244.30#tc2 >= $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), Q#i$1^244.30#tc1, ^^i4)));
                // assume &&(forall(uint32_t i; { @map_get(*((h->sh)), mark(i)) } @in_range_u4(i); ==>(>=(i, *((h->len))), @map_eq(@map_get(*((h->sh)), mark(i)), lambda#33()))), &&(forall(uint32_t i; int32_t e; { @map_get(@map_get(*((h->sh)), mark(i)), e) } { mark3(i, e) } { @trigger_hint(mark3(i, e)) } &&(@in_range_u4(i), @in_range_i4(e)); ==>(<(i, *((h->len))), >=(@map_get(@map_get(*((h->sh)), mark(i)), e), 0))), forall(uint32_t i; int32_t e; { @map_get(@map_get(*((h->sh)), mark(i)), e) } { mark3(i, e) } { @trigger_hint(mark3(i, e)) } &&(@in_range_u4(i), @in_range_i4(e)); ==>(<(i, *((h->len))), ==>(!=(i, *((h->len))), ==>(>(@map_get(@map_get(*((h->sh)), i), e), 0), >=(e, *((h->heap)[i])))))))); 
                assume (forall Q#i$1^244.30#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^244.30#tc1)) } $in_range_u4(Q#i$1^244.30#tc1) ==> Q#i$1^244.30#tc1 >= $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^244.30#tc1)), F#lambda#33())) && (forall Q#i$1^244.30#tc1: int, Q#e$1^244.30#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^244.30#tc1)), Q#e$1^244.30#tc2) } { F#mark3(Q#i$1^244.30#tc1, Q#e$1^244.30#tc2) } { sk_hack(F#mark3(Q#i$1^244.30#tc1, Q#e$1^244.30#tc2)) } $in_range_u4(Q#i$1^244.30#tc1) && $in_range_i4(Q#e$1^244.30#tc2) ==> Q#i$1^244.30#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^244.30#tc1)), Q#e$1^244.30#tc2) >= 0) && (forall Q#i$1^244.30#tc1: int, Q#e$1^244.30#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^244.30#tc1)), Q#e$1^244.30#tc2) } { F#mark3(Q#i$1^244.30#tc1, Q#e$1^244.30#tc2) } { sk_hack(F#mark3(Q#i$1^244.30#tc1, Q#e$1^244.30#tc2)) } $in_range_u4(Q#i$1^244.30#tc1) && $in_range_i4(Q#e$1^244.30#tc2) ==> Q#i$1^244.30#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> Q#i$1^244.30#tc1 != $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), Q#i$1^244.30#tc1), Q#e$1^244.30#tc2) > 0 ==> Q#e$1^244.30#tc2 >= $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), Q#i$1^244.30#tc1, ^^i4)));
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
    // assert @_vcc_typed2(@state, (h->abs)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.abs), $map_t(^^i4, ^^mathint));
    // assert @prim_writes_check((h->abs)); 
    assert $writable($s, #wrTime$1^172.1, $dot($ptr(^Heap, P#h), Heap.abs));
    // assert @reads_check_normal((h->sh)); 
    assert $typed2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    assert $thread_local2($s, $dot($ptr(^Heap, P#h), Heap.sh), $map_t(^^u4, $map_t(^^i4, ^^mathint)));
    // *(h->abs) := @map_get(*((h->sh)), 0); 
    call $write_int($dot($ptr(^Heap, P#h), Heap.abs), $map_t..^^i4.^^mathint_to_int($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), 0)));
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
    assert $top_writable($s, #wrTime$1^172.1, $ptr(^Heap, P#h));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(h), staticWrapState#66, owns#67)
    call $static_wrap($ptr(^Heap, P#h), staticWrapState#66, owns#67);
    assume $good_state_ext(#tok$1^251.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, h), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^Heap, P#h)), $set_empty());
    // assert @inv_check(@map_eq(@map_get(*((h->sh)), 0), *((h->abs)))); 
    assert $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), 0), $int_to_map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.abs))));
    // assert @inv_check(<=(*((h->len)), 1000)); 
    assert $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) <= 1000;
    // assert @inv_check(forall(uint32_t i; { @map_get(*((h->sh)), mark(i)) } @in_range_u4(i); ==>(&&(!=(i, *((h->len))), <(i, *((h->len)))), @map_eq(@map_get(*((h->sh)), mark(i)), lambda#6(@map_get(*((h->sh)), unchecked+(unchecked*(2, i), 2)), @map_get(*((h->sh)), unchecked+(unchecked*(2, i), 1)), *((h->heap)[i])))))); 
    assert (forall Q#i$1^65.29#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^65.29#tc1)) } $in_range_u4(Q#i$1^65.29#tc1) ==> Q#i$1^65.29#tc1 != $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) && Q#i$1^65.29#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^65.29#tc1)), F#lambda#6($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 2)), $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), $unchk_add(^^u4, $unchk_mul(^^u4, 2, Q#i$1^65.29#tc1), 1)), $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), Q#i$1^65.29#tc1, ^^i4)))));
    // assert @inv_check(forall(uint32_t i; { @map_get(*((h->sh)), mark(i)) } @in_range_u4(i); ==>(>=(i, *((h->len))), @map_eq(@map_get(*((h->sh)), mark(i)), lambda#7())))); 
    assert (forall Q#i$1^66.29#tc1: int :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^66.29#tc1)) } $in_range_u4(Q#i$1^66.29#tc1) ==> Q#i$1^66.29#tc1 >= $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), F#lambda#7()));
    // assert @inv_check(forall(uint32_t i; int32_t e; { @map_get(@map_get(*((h->sh)), mark(i)), e) } { mark3(i, e) } { @trigger_hint(mark3(i, e)) } &&(@in_range_u4(i), @in_range_i4(e)); ==>(<(i, *((h->len))), >=(@map_get(@map_get(*((h->sh)), mark(i)), e), 0)))); 
    assert (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) >= 0);
    // assert @inv_check(forall(uint32_t i; int32_t e; { @map_get(@map_get(*((h->sh)), mark(i)), e) } { mark3(i, e) } { @trigger_hint(mark3(i, e)) } &&(@in_range_u4(i), @in_range_i4(e)); ==>(<(i, *((h->len))), ==>(!=(i, *((h->len))), ==>(>(@map_get(@map_get(*((h->sh)), i), e), 0), >=(e, *((h->heap)[i]))))))); 
    assert (forall Q#i$1^66.29#tc1: int, Q#e$1^66.29#tc2: int :: { $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), F#mark(Q#i$1^66.29#tc1)), Q#e$1^66.29#tc2) } { F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2) } { sk_hack(F#mark3(Q#i$1^66.29#tc1, Q#e$1^66.29#tc2)) } $in_range_u4(Q#i$1^66.29#tc1) && $in_range_i4(Q#e$1^66.29#tc2) ==> Q#i$1^66.29#tc1 < $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> Q#i$1^66.29#tc1 != $mem($s, $dot($ptr(^Heap, P#h), Heap.len)) ==> $select.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, P#h), Heap.sh))), Q#i$1^66.29#tc1), Q#e$1^66.29#tc2) > 0 ==> Q#e$1^66.29#tc2 >= $mem($s, $idx($dot($ptr(^Heap, P#h), Heap.heap), Q#i$1^66.29#tc1, ^^i4)));
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



procedure heapSort(P#arr: int, P#len: int) returns (OP#perm: $map_t..^^u4.^^u4);
  requires P#len < 1000;
  requires $is_mutable_array($s, $ptr(^^i4, P#arr), ^^i4, P#len);
  modifies $s, $cev_pc;
  ensures (forall Q#a$1^279.29#tc1: int, Q#b$1^279.29#tc1: int :: $in_range_u4(Q#a$1^279.29#tc1) && $in_range_u4(Q#b$1^279.29#tc1) ==> Q#a$1^279.29#tc1 < Q#b$1^279.29#tc1 && Q#b$1^279.29#tc1 < P#len ==> $select.$map_t..^^u4.^^u4(OP#perm, Q#a$1^279.29#tc1) != $select.$map_t..^^u4.^^u4(OP#perm, Q#b$1^279.29#tc1)) && (forall Q#a$1^279.96#tc1: int :: { $mem($s, $idx($ptr(^^i4, P#arr), Q#a$1^279.96#tc1, ^^i4)) } { $select.$map_t..^^u4.^^u4(OP#perm, Q#a$1^279.96#tc1) } $in_range_u4(Q#a$1^279.96#tc1) ==> Q#a$1^279.96#tc1 < P#len ==> $select.$map_t..^^u4.^^u4(OP#perm, Q#a$1^279.96#tc1) < P#len && $mem(old($s), $idx($ptr(^^i4, P#arr), $select.$map_t..^^u4.^^u4(OP#perm, Q#a$1^279.96#tc1), ^^i4)) == $mem($s, $idx($ptr(^^i4, P#arr), Q#a$1^279.96#tc1, ^^i4))) && (forall Q#a$1^279.198#tc1: int, Q#b$1^279.198#tc1: int :: $in_range_u4(Q#a$1^279.198#tc1) && $in_range_u4(Q#b$1^279.198#tc1) ==> Q#a$1^279.198#tc1 < Q#b$1^279.198#tc1 && Q#b$1^279.198#tc1 < P#len ==> $mem($s, $idx($ptr(^^i4, P#arr), Q#a$1^279.198#tc1, ^^i4)) <= $mem($s, $idx($ptr(^^i4, P#arr), Q#b$1^279.198#tc1, ^^i4)));
  ensures $is_mutable_array($s, $ptr(^^i4, P#arr), ^^i4, P#len);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $array_range(old($s), $ptr(^^i4, P#arr), ^^i4, P#len)) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $array_range(old($s), $ptr(^^i4, P#arr), ^^i4, P#len)) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $array_range(old($s), $ptr(^^i4, P#arr), ^^i4, P#len)) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation heapSort(P#arr: int, P#len: int) returns (OP#perm: $map_t..^^u4.^^u4)
{
  var prestate#71: $state;
  var prestate#69: $state;
  var owns#70: $ptrset;
  var res_extractMin#53: int where $in_range_i4(res_extractMin#53);
  var #wrTime$1^303.28: int;
  var loopState#5: $state;
  var #wrTime$1^292.28: int;
  var loopState#4: $state;
  var #callConv#2: $ptr;
  var addr.h: int where $in_range_phys_ptr(addr.h);
  var L#i: int where $in_range_u4(L#i);
  var SL#indexes: $map_t..^^i4.$map_t..^^mathint.^^u4;
  var #wrTime$1^273.1: int;
  var #stackframe: int;

  anon61:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^273.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^273.1, #loc.arr, $ptr_to_int($ptr(^^i4, P#arr)), $ptr_to(^^i4)) && $local_value_is_ptr($s, #tok$1^273.1, #loc.arr, $ptr(^^i4, P#arr), $ptr_to(^^i4));
    assume $local_value_is($s, #tok$1^273.1, #loc.len, P#len, ^^u4);
    assume #wrTime$1^273.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^273.1, #p) } $in_writes_at(#wrTime$1^273.1, #p) == $set_in(#p, $array_range($s, $ptr(^^i4, P#arr), ^^i4, P#len)));
    assume (forall #p: $ptr :: { $st($s, #p) } { $ts($s, #p) } $set_in(#p, $array_range($s, $ptr(^^i4, P#arr), ^^i4, P#len)) ==> $thread_owned_or_even_mutable($s, #p));
    // assume @in_range_phys_ptr((mathint)arr); 
    assume $in_range_phys_ptr($ref($ptr(^^i4, P#arr)));
    // assume @in_range_u4(len); 
    assume $in_range_u4(P#len);
    // (int32_t -> (mathint -> uint32_t)) indexes; 
    assume $local_value_is($s, #tok$1^283.25, #loc.indexes, $map_t..^^i4.map_t..^^mathint.^^u4_to_int(SL#indexes), $map_t(^^i4, $map_t(^^mathint, ^^u4)));
    // uint32_t i; 
    assume $local_value_is($s, #tok$1^282.3, #loc.i, L#i, ^^u4);
    // struct Heap* addr.h; 
    assume $local_value_is($s, #tok$1^273.1, #loc.addr.h, $ptr_to_int($ptr(^Heap, addr.h)), $ptr_to(^Heap)) && $local_value_is_ptr($s, #tok$1^273.1, #loc.addr.h, $ptr(^Heap, addr.h), $ptr_to(^Heap));
    // addr.h := _vcc_stack_alloc<struct Heap>(@stackframe, false); 
    call #callConv#2 := $stack_alloc(^Heap, #stackframe, false);
    assume $full_stop_ext(#tok$1^273.1, $s);
    addr.h := $ref(#callConv#2);
    assume $local_value_is($s, #tok$1^273.1, #loc.addr.h, $ptr_to_int($ptr(^Heap, addr.h)), $ptr_to(^Heap)) && $local_value_is_ptr($s, #tok$1^273.1, #loc.addr.h, $ptr(^Heap, addr.h), $ptr_to(^Heap));
    // var struct Heap h
    // var uint32_t i
    // var spec (int32_t -> (mathint -> uint32_t)) indexes
    // assert forall(uint32_t i; @in_range_u4(i); ==>(<(i, len), @_vcc_mutable(@state, arr[i]))); 
    assert (forall Q#i$1^286.26#tc1: int :: $in_range_u4(Q#i$1^286.26#tc1) ==> Q#i$1^286.26#tc1 < P#len ==> $mutable($s, $idx($ptr(^^i4, P#arr), Q#i$1^286.26#tc1, ^^i4)));
    // assume forall(uint32_t i; @in_range_u4(i); ==>(<(i, len), @_vcc_mutable(@state, arr[i]))); 
    assume (forall Q#i$1^286.26#tc1: int :: $in_range_u4(Q#i$1^286.26#tc1) ==> Q#i$1^286.26#tc1 < P#len ==> $mutable($s, $idx($ptr(^^i4, P#arr), Q#i$1^286.26#tc1, ^^i4)));
    // assert @writes_check(@_vcc_span(addr.h)); 
    assert (forall #writes$1^289.3: $ptr :: { $dont_instantiate(#writes$1^289.3) } $set_in(#writes$1^289.3, $span($ptr(^Heap, addr.h))) ==> $top_writable($s, #wrTime$1^273.1, #writes$1^289.3));
    // stmt init(addr.h); 
    call init($ref($ptr(^Heap, addr.h)));
    assume $full_stop_ext(#tok$1^289.3, $s);
    // i := 0; 
    L#i := 0;
    assume $local_value_is($s, #tok$1^291.8, #loc.i, L#i, ^^u4);
    call $bump_timestamp();
    assume $full_stop_ext(#tok$1^292.28, $s);
    loopState#4 := $s;
    assume #wrTime$1^292.28 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^292.28, #p) } $in_writes_at(#wrTime$1^292.28, #p) == (#p == $ptr(^Heap, addr.h)));
    assert (forall #loopWrites^$1^292.28: $ptr :: { $dont_instantiate(#loopWrites^$1^292.28) } $top_writable($s, #wrTime$1^292.28, #loopWrites^$1^292.28) ==> $top_writable($s, #wrTime$1^273.1, #loopWrites^$1^292.28));
    while (true)
      invariant L#i <= P#len;
      invariant $wrapped($s, $ptr(^Heap, addr.h), ^Heap);
      invariant $mem($s, $dot($ptr(^Heap, addr.h), Heap.len)) == L#i;
      invariant (forall Q#e$1^295.32#tc2: int, Q#i$1^295.32#tc3: int :: $in_range_i4(Q#e$1^295.32#tc2) ==> 0 <= Q#i$1^295.32#tc3 && Q#i$1^295.32#tc3 < $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, addr.h), Heap.abs))), Q#e$1^295.32#tc2) ==> $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e$1^295.32#tc2), Q#i$1^295.32#tc3) < P#len && $mem(loopState#4, $idx($ptr(^^i4, P#arr), $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e$1^295.32#tc2), Q#i$1^295.32#tc3), ^^i4)) == Q#e$1^295.32#tc2);
      invariant (forall Q#e1$1^295.144#tc2: int, Q#e2$1^295.144#tc2: int, Q#i1$1^295.144#tc3: int, Q#i2$1^295.144#tc3: int :: $in_range_i4(Q#e1$1^295.144#tc2) && $in_range_i4(Q#e2$1^295.144#tc2) ==> 0 <= Q#i1$1^295.144#tc3 && 0 <= Q#i2$1^295.144#tc3 && Q#i1$1^295.144#tc3 < $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, addr.h), Heap.abs))), Q#e1$1^295.144#tc2) && Q#i2$1^295.144#tc3 < $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, addr.h), Heap.abs))), Q#e2$1^295.144#tc2) && (Q#e1$1^295.144#tc2 != Q#e2$1^295.144#tc2 || Q#i1$1^295.144#tc3 != Q#i2$1^295.144#tc3) ==> $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e1$1^295.144#tc2), Q#i1$1^295.144#tc3) != $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e2$1^295.144#tc2), Q#i2$1^295.144#tc3));
      invariant (forall Q#e$1^296.31#tc2: int, Q#k$1^296.31#tc3: int :: $in_range_i4(Q#e$1^296.31#tc2) ==> 0 <= Q#k$1^296.31#tc3 && Q#k$1^296.31#tc3 < $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, addr.h), Heap.abs))), Q#e$1^296.31#tc2) ==> $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e$1^296.31#tc2), Q#k$1^296.31#tc3) < L#i);
    {
      anon57:
        assume (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(loopState#4, #p) || #p == $ptr(^Heap, addr.h) || $mem_eq(loopState#4, $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(loopState#4, #p) || #p == $ptr(^Heap, addr.h) || $st_eq(loopState#4, $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(loopState#4, #p) || #p == $ptr(^Heap, addr.h) || $ts_eq(loopState#4, $s, #p)) && $timestamp_post(loopState#4, $s);
        assume $timestamp_post(loopState#4, $s);
        assume $full_stop_ext(#tok$1^291.3, $s);
        assume $local_value_is($s, #tok$1^291.3, #loc.addr.h, $ptr_to_int($ptr(^Heap, addr.h)), $ptr_to(^Heap)) && $local_value_is_ptr($s, #tok$1^291.3, #loc.addr.h, $ptr(^Heap, addr.h), $ptr_to(^Heap));
        assume $local_value_is($s, #tok$1^291.3, #loc.indexes, $map_t..^^i4.map_t..^^mathint.^^u4_to_int(SL#indexes), $map_t(^^i4, $map_t(^^mathint, ^^u4)));
        assume $local_value_is($s, #tok$1^291.3, #loc.len, P#len, ^^u4);
        assume $local_value_is($s, #tok$1^291.3, #loc.arr, $ptr_to_int($ptr(^^i4, P#arr)), $ptr_to(^^i4)) && $local_value_is_ptr($s, #tok$1^291.3, #loc.arr, $ptr(^^i4, P#arr), $ptr_to(^^i4));
        assume true;
        // if (<(i, len)) ...
        if (L#i < P#len)
        {
          anon55:
            // assert @writes_check(addr.h); 
            assert $top_writable($s, #wrTime$1^292.28, $ptr(^Heap, addr.h));
            // assert @reads_check_normal(arr[i]); 
            assert $typed2($s, $idx($ptr(^^i4, P#arr), L#i, ^^i4), ^^i4);
            assert $thread_local2($s, $idx($ptr(^^i4, P#arr), L#i, ^^i4), ^^i4);
            // stmt insert(addr.h, *(arr[i])); 
            call insert($ref($ptr(^Heap, addr.h)), $mem($s, $idx($ptr(^^i4, P#arr), L#i, ^^i4)));
            assume $full_stop_ext(#tok$1^298.5, $s);
            // assert @reads_check_normal(arr[i]); 
            assert $typed2($s, $idx($ptr(^^i4, P#arr), L#i, ^^i4), ^^i4);
            assert $thread_local2($s, $idx($ptr(^^i4, P#arr), L#i, ^^i4), ^^i4);
            // assert @reads_check_normal(arr[i]); 
            assert $typed2($s, $idx($ptr(^^i4, P#arr), L#i, ^^i4), ^^i4);
            assert $thread_local2($s, $idx($ptr(^^i4, P#arr), L#i, ^^i4), ^^i4);
            // assert @reads_check_normal((addr.h->abs)); 
            assert $typed2($s, $dot($ptr(^Heap, addr.h), Heap.abs), $map_t(^^i4, ^^mathint));
            assert $thread_local2($s, $dot($ptr(^Heap, addr.h), Heap.abs), $map_t(^^i4, ^^mathint));
            // assert @reads_check_normal(arr[i]); 
            assert $typed2($s, $idx($ptr(^^i4, P#arr), L#i, ^^i4), ^^i4);
            assert $thread_local2($s, $idx($ptr(^^i4, P#arr), L#i, ^^i4), ^^i4);
            // indexes := @map_updated(indexes, *(arr[i]), @map_updated(@map_get(indexes, *(arr[i])), -(@map_get(*((addr.h->abs)), *(arr[i])), 1), i)); 
            SL#indexes := $store.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, $mem($s, $idx($ptr(^^i4, P#arr), L#i, ^^i4)), $store.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, $mem($s, $idx($ptr(^^i4, P#arr), L#i, ^^i4))), $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, addr.h), Heap.abs))), $mem($s, $idx($ptr(^^i4, P#arr), L#i, ^^i4))) - 1, L#i));
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
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^303.28, #p) } $in_writes_at(#wrTime$1^303.28, #p) == (#p == $ptr(^Heap, addr.h) || $set_in(#p, $array_range($s, $ptr(^^i4, P#arr), ^^i4, P#len))));
    assert (forall #loopWrites^$1^303.28: $ptr :: { $dont_instantiate(#loopWrites^$1^303.28) } $top_writable($s, #wrTime$1^303.28, #loopWrites^$1^303.28) ==> $top_writable($s, #wrTime$1^273.1, #loopWrites^$1^303.28));
    while (true)
      invariant L#i <= P#len;
      invariant $wrapped($s, $ptr(^Heap, addr.h), ^Heap);
      invariant $mem($s, $dot($ptr(^Heap, addr.h), Heap.len)) == P#len - L#i;
      invariant $is_mutable_array($s, $ptr(^^i4, P#arr), ^^i4, P#len);
      invariant (forall Q#e$1^307.32#tc2: int, Q#i$1^307.32#tc3: int :: $in_range_i4(Q#e$1^307.32#tc2) ==> 0 <= Q#i$1^307.32#tc3 && Q#i$1^307.32#tc3 < $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, addr.h), Heap.abs))), Q#e$1^307.32#tc2) ==> $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e$1^307.32#tc2), Q#i$1^307.32#tc3) < P#len && $mem(loopState#5, $idx($ptr(^^i4, P#arr), $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e$1^307.32#tc2), Q#i$1^307.32#tc3), ^^i4)) == Q#e$1^307.32#tc2);
      invariant (forall Q#e1$1^307.144#tc2: int, Q#e2$1^307.144#tc2: int, Q#i1$1^307.144#tc3: int, Q#i2$1^307.144#tc3: int :: $in_range_i4(Q#e1$1^307.144#tc2) && $in_range_i4(Q#e2$1^307.144#tc2) ==> 0 <= Q#i1$1^307.144#tc3 && 0 <= Q#i2$1^307.144#tc3 && Q#i1$1^307.144#tc3 < $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, addr.h), Heap.abs))), Q#e1$1^307.144#tc2) && Q#i2$1^307.144#tc3 < $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, addr.h), Heap.abs))), Q#e2$1^307.144#tc2) && (Q#e1$1^307.144#tc2 != Q#e2$1^307.144#tc2 || Q#i1$1^307.144#tc3 != Q#i2$1^307.144#tc3) ==> $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e1$1^307.144#tc2), Q#i1$1^307.144#tc3) != $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e2$1^307.144#tc2), Q#i2$1^307.144#tc3));
      invariant (forall Q#e$1^308.31#tc2: int, Q#a$1^308.31#tc3: int, Q#b$1^308.31#tc1: int :: $in_range_i4(Q#e$1^308.31#tc2) && $in_range_u4(Q#b$1^308.31#tc1) ==> 0 <= Q#a$1^308.31#tc3 && Q#a$1^308.31#tc3 < $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, addr.h), Heap.abs))), Q#e$1^308.31#tc2) && Q#b$1^308.31#tc1 < L#i ==> $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, Q#e$1^308.31#tc2), Q#a$1^308.31#tc3) != $select.$map_t..^^u4.^^u4(OP#perm, Q#b$1^308.31#tc1));
      invariant (forall Q#a$1^309.31#tc1: int, Q#e$1^309.31#tc2: int :: $in_range_u4(Q#a$1^309.31#tc1) && $in_range_i4(Q#e$1^309.31#tc2) ==> Q#a$1^309.31#tc1 < L#i ==> $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, addr.h), Heap.abs))), Q#e$1^309.31#tc2) > 0 ==> Q#e$1^309.31#tc2 >= $mem($s, $idx($ptr(^^i4, P#arr), Q#a$1^309.31#tc1, ^^i4)));
      invariant (forall Q#a$1^310.33#tc1: int, Q#b$1^310.33#tc1: int :: $in_range_u4(Q#a$1^310.33#tc1) && $in_range_u4(Q#b$1^310.33#tc1) ==> Q#a$1^310.33#tc1 < Q#b$1^310.33#tc1 && Q#b$1^310.33#tc1 < L#i ==> $select.$map_t..^^u4.^^u4(OP#perm, Q#a$1^310.33#tc1) != $select.$map_t..^^u4.^^u4(OP#perm, Q#b$1^310.33#tc1));
      invariant (forall Q#a$1^310.98#tc1: int :: { $mem($s, $idx($ptr(^^i4, P#arr), Q#a$1^310.98#tc1, ^^i4)) } { $select.$map_t..^^u4.^^u4(OP#perm, Q#a$1^310.98#tc1) } $in_range_u4(Q#a$1^310.98#tc1) ==> Q#a$1^310.98#tc1 < L#i ==> $select.$map_t..^^u4.^^u4(OP#perm, Q#a$1^310.98#tc1) < P#len && $mem(loopState#5, $idx($ptr(^^i4, P#arr), $select.$map_t..^^u4.^^u4(OP#perm, Q#a$1^310.98#tc1), ^^i4)) == $mem($s, $idx($ptr(^^i4, P#arr), Q#a$1^310.98#tc1, ^^i4)));
      invariant (forall Q#a$1^310.198#tc1: int, Q#b$1^310.198#tc1: int :: $in_range_u4(Q#a$1^310.198#tc1) && $in_range_u4(Q#b$1^310.198#tc1) ==> Q#a$1^310.198#tc1 < Q#b$1^310.198#tc1 && Q#b$1^310.198#tc1 < L#i ==> $mem($s, $idx($ptr(^^i4, P#arr), Q#a$1^310.198#tc1, ^^i4)) <= $mem($s, $idx($ptr(^^i4, P#arr), Q#b$1^310.198#tc1, ^^i4)));
    {
      anon60:
        assume (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(loopState#5, #p) || #p == $ptr(^Heap, addr.h) || $set_in(#p, $array_range(loopState#5, $ptr(^^i4, P#arr), ^^i4, P#len)) || $mem_eq(loopState#5, $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(loopState#5, #p) || #p == $ptr(^Heap, addr.h) || $set_in(#p, $array_range(loopState#5, $ptr(^^i4, P#arr), ^^i4, P#len)) || $st_eq(loopState#5, $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(loopState#5, #p) || #p == $ptr(^Heap, addr.h) || $set_in(#p, $array_range(loopState#5, $ptr(^^i4, P#arr), ^^i4, P#len)) || $ts_eq(loopState#5, $s, #p)) && $timestamp_post(loopState#5, $s);
        assume $timestamp_post(loopState#5, $s);
        assume $full_stop_ext(#tok$1^302.3, $s);
        assume $local_value_is($s, #tok$1^302.3, #loc.addr.h, $ptr_to_int($ptr(^Heap, addr.h)), $ptr_to(^Heap)) && $local_value_is_ptr($s, #tok$1^302.3, #loc.addr.h, $ptr(^Heap, addr.h), $ptr_to(^Heap));
        assume $local_value_is($s, #tok$1^302.3, #loc.indexes, $map_t..^^i4.map_t..^^mathint.^^u4_to_int(SL#indexes), $map_t(^^i4, $map_t(^^mathint, ^^u4)));
        assume $local_value_is($s, #tok$1^302.3, #loc.len, P#len, ^^u4);
        assume $local_value_is($s, #tok$1^302.3, #loc.arr, $ptr_to_int($ptr(^^i4, P#arr)), $ptr_to(^^i4)) && $local_value_is_ptr($s, #tok$1^302.3, #loc.arr, $ptr(^^i4, P#arr), $ptr_to(^^i4));
        assume true;
        // if (<(i, len)) ...
        if (L#i < P#len)
        {
          anon58:
            // int32_t res_extractMin#53; 
            assume $local_value_is($s, #tok$1^312.14, #loc.res_extractMin#53, res_extractMin#53, ^^i4);
            // assert @writes_check(addr.h); 
            assert $top_writable($s, #wrTime$1^303.28, $ptr(^Heap, addr.h));
            // res_extractMin#53 := extractMin(addr.h); 
            call res_extractMin#53 := extractMin($ref($ptr(^Heap, addr.h)));
            assume $full_stop_ext(#tok$1^312.14, $s);
            assume $local_value_is($s, #tok$1^312.14, #loc.res_extractMin#53, res_extractMin#53, ^^i4);
            // assert @_vcc_typed2(@state, arr[i]); 
            assert $typed2($s, $idx($ptr(^^i4, P#arr), L#i, ^^i4), ^^i4);
            // assert @prim_writes_check(arr[i]); 
            assert $writable($s, #wrTime$1^303.28, $idx($ptr(^^i4, P#arr), L#i, ^^i4));
            // *arr[i] := res_extractMin#53; 
            call $write_int($idx($ptr(^^i4, P#arr), L#i, ^^i4), res_extractMin#53);
            assume $full_stop_ext(#tok$1^312.5, $s);
            // assert @reads_check_normal(arr[i]); 
            assert $typed2($s, $idx($ptr(^^i4, P#arr), L#i, ^^i4), ^^i4);
            assert $thread_local2($s, $idx($ptr(^^i4, P#arr), L#i, ^^i4), ^^i4);
            // assert @reads_check_normal((addr.h->abs)); 
            assert $typed2($s, $dot($ptr(^Heap, addr.h), Heap.abs), $map_t(^^i4, ^^mathint));
            assert $thread_local2($s, $dot($ptr(^Heap, addr.h), Heap.abs), $map_t(^^i4, ^^mathint));
            // assert @reads_check_normal(arr[i]); 
            assert $typed2($s, $idx($ptr(^^i4, P#arr), L#i, ^^i4), ^^i4);
            assert $thread_local2($s, $idx($ptr(^^i4, P#arr), L#i, ^^i4), ^^i4);
            // perm := @map_updated(perm, i, @map_get(@map_get(indexes, *(arr[i])), @map_get(*((addr.h->abs)), *(arr[i])))); 
            OP#perm := $store.$map_t..^^u4.^^u4(OP#perm, L#i, $select.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(SL#indexes, $mem($s, $idx($ptr(^^i4, P#arr), L#i, ^^i4))), $select.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($mem($s, $dot($ptr(^Heap, addr.h), Heap.abs))), $mem($s, $idx($ptr(^^i4, P#arr), L#i, ^^i4)))));
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
    assert $wrapped($s, $ptr(^Heap, addr.h), ^Heap);
    // assert @writes_check(addr.h); 
    assert $top_writable($s, #wrTime$1^273.1, $ptr(^Heap, addr.h));
    // assume @_vcc_inv(@state, addr.h); 
    assume $inv($s, $ptr(^Heap, addr.h), ^Heap);
    // assume ==(owns#70, @_vcc_owns(@state, addr.h)); 
    assume owns#70 == $owns($s, $ptr(^Heap, addr.h));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(addr.h), prestate#71)
    call $static_unwrap($ptr(^Heap, addr.h), prestate#71);
    assume $good_state_ext(#tok$1^316.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // stmt _vcc_stack_free(@stackframe, addr.h); 
    call $stack_free(#stackframe, $ptr(^Heap, addr.h));
    assume $full_stop_ext(#tok$1^273.1, $s);
    // return; 
    assert $position_marker();
    goto #exit;

  anon64:
    // Block cleanup
    // stmt _vcc_stack_free(@stackframe, addr.h); 
    call $stack_free(#stackframe, $ptr(^Heap, addr.h));
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
  var L#__temp71683: int where $in_range_phys_ptr(L#__temp71683);
  var #callConv#3: $ptr;
  var addr.#stackframe#0: int where $in_range_phys_ptr(addr.#stackframe#0);
  var L#arr: int where $in_range_phys_ptr(L#arr);
  var SL#perm: $map_t..^^u4.^^u4;
  var #wrTime$1^320.1: int;
  var #stackframe: int;

  anon71:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^320.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^320.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^320.1, #p) } $in_writes_at(#wrTime$1^320.1, #p) == false);
    // (uint32_t -> uint32_t) perm; 
    assume $local_value_is($s, #tok$1^323.25, #loc.perm, $map_t..^^u4.^^u4_to_int(SL#perm), $map_t(^^u4, ^^u4));
    // int32_t* arr; 
    assume $local_value_is($s, #tok$1^322.3, #loc.arr, $ptr_to_int($ptr(^^i4, L#arr)), $ptr_to(^^i4)) && $local_value_is_ptr($s, #tok$1^322.3, #loc.arr, $ptr(^^i4, L#arr), $ptr_to(^^i4));
    // struct heapSortTestHarnessstackframe#0* addr.#stackframe#0; 
    assume $local_value_is($s, #tok$1^320.1, #loc.addr.#stackframe#0, $ptr_to_int($ptr(^heapSortTestHarnessstackframe#0, addr.#stackframe#0)), $ptr_to(^heapSortTestHarnessstackframe#0)) && $local_value_is_ptr($s, #tok$1^320.1, #loc.addr.#stackframe#0, $ptr(^heapSortTestHarnessstackframe#0, addr.#stackframe#0), $ptr_to(^heapSortTestHarnessstackframe#0));
    // addr.#stackframe#0 := _vcc_stack_alloc<struct heapSortTestHarnessstackframe#0>(@stackframe, false); 
    call #callConv#3 := $stack_alloc(^heapSortTestHarnessstackframe#0, #stackframe, false);
    assume $full_stop_ext(#tok$1^320.1, $s);
    addr.#stackframe#0 := $ref(#callConv#3);
    assume $local_value_is($s, #tok$1^320.1, #loc.addr.#stackframe#0, $ptr_to_int($ptr(^heapSortTestHarnessstackframe#0, addr.#stackframe#0)), $ptr_to(^heapSortTestHarnessstackframe#0)) && $local_value_is_ptr($s, #tok$1^320.1, #loc.addr.#stackframe#0, $ptr(^heapSortTestHarnessstackframe#0, addr.#stackframe#0), $ptr_to(^heapSortTestHarnessstackframe#0));
    // int32_t* __temp71683; 
    assume $local_value_is($s, #tok$1^322.15, #loc.__temp71683, $ptr_to_int($ptr(^^i4, L#__temp71683)), $ptr_to(^^i4)) && $local_value_is_ptr($s, #tok$1^322.15, #loc.__temp71683, $ptr(^^i4, L#__temp71683), $ptr_to(^^i4));
    // __temp71683 := (addr.#stackframe#0->__temp71683); 
    L#__temp71683 := $ref($dot($ptr(^heapSortTestHarnessstackframe#0, addr.#stackframe#0), heapSortTestHarnessstackframe#0.__temp71683));
    assume $local_value_is($s, #tok$1^322.15, #loc.__temp71683, $ptr_to_int($ptr(^^i4, L#__temp71683)), $ptr_to(^^i4)) && $local_value_is_ptr($s, #tok$1^322.15, #loc.__temp71683, $ptr(^^i4, L#__temp71683), $ptr_to(^^i4));
    // assert @_vcc_typed2(@state, __temp71683[0]); 
    assert $typed2($s, $idx($ptr(^^i4, L#__temp71683), 0, ^^i4), ^^i4);
    // assert @prim_writes_check(__temp71683[0]); 
    assert $writable($s, #wrTime$1^320.1, $idx($ptr(^^i4, L#__temp71683), 0, ^^i4));
    // *__temp71683[0] := 42; 
    call $write_int($idx($ptr(^^i4, L#__temp71683), 0, ^^i4), 42);
    assume $full_stop_ext(#tok$4^0.0, $s);
    // assert @_vcc_typed2(@state, __temp71683[1]); 
    assert $typed2($s, $idx($ptr(^^i4, L#__temp71683), 1, ^^i4), ^^i4);
    // assert @prim_writes_check(__temp71683[1]); 
    assert $writable($s, #wrTime$1^320.1, $idx($ptr(^^i4, L#__temp71683), 1, ^^i4));
    // *__temp71683[1] := 13; 
    call $write_int($idx($ptr(^^i4, L#__temp71683), 1, ^^i4), 13);
    assume $full_stop_ext(#tok$4^0.0, $s);
    // assert @_vcc_typed2(@state, __temp71683[2]); 
    assert $typed2($s, $idx($ptr(^^i4, L#__temp71683), 2, ^^i4), ^^i4);
    // assert @prim_writes_check(__temp71683[2]); 
    assert $writable($s, #wrTime$1^320.1, $idx($ptr(^^i4, L#__temp71683), 2, ^^i4));
    // *__temp71683[2] := 42; 
    call $write_int($idx($ptr(^^i4, L#__temp71683), 2, ^^i4), 42);
    assume $full_stop_ext(#tok$4^0.0, $s);
    // arr := __temp71683; 
    L#arr := $ref($ptr(^^i4, L#__temp71683));
    assume $local_value_is($s, #tok$1^322.3, #loc.arr, $ptr_to_int($ptr(^^i4, L#arr)), $ptr_to(^^i4)) && $local_value_is_ptr($s, #tok$1^322.3, #loc.arr, $ptr(^^i4, L#arr), $ptr_to(^^i4));
    // var spec (uint32_t -> uint32_t) perm
    // assert @writes_check(@_vcc_array_range(@state, arr, 3)); 
    assert (forall #writes$1^324.3: $ptr :: { $dont_instantiate(#writes$1^324.3) } $set_in(#writes$1^324.3, $array_range($s, $ptr(^^i4, L#arr), ^^i4, 3)) ==> $top_writable($s, #wrTime$1^320.1, #writes$1^324.3));
    // perm := heapSort(arr, 3); 
    call SL#perm := heapSort($ref($ptr(^^i4, L#arr)), 3);
    assume $full_stop_ext(#tok$1^324.3, $s);
    assume $local_value_is($s, #tok$1^324.3, #loc.perm, $map_t..^^u4.^^u4_to_int(SL#perm), $map_t(^^u4, ^^u4));
    // _Bool tmp; 
    assume $local_value_is($s, #tok$1^327.5, #loc.tmp, $bool_to_int(L#tmp), ^^bool);
    // _Bool ite#3; 
    assume $local_value_is($s, #tok$1^327.16, #loc.ite#3, $bool_to_int(ite#3), ^^bool);
    // assert @reads_check_normal(arr[0]); 
    assert $typed2($s, $idx($ptr(^^i4, L#arr), 0, ^^i4), ^^i4);
    assert $thread_local2($s, $idx($ptr(^^i4, L#arr), 0, ^^i4), ^^i4);
    // assert @reads_check_normal(arr[1]); 
    assert $typed2($s, $idx($ptr(^^i4, L#arr), 1, ^^i4), ^^i4);
    assert $thread_local2($s, $idx($ptr(^^i4, L#arr), 1, ^^i4), ^^i4);
    assume true;
    // if (<=(*(arr[0]), *(arr[1]))) ...
    if ($mem($s, $idx($ptr(^^i4, L#arr), 0, ^^i4)) <= $mem($s, $idx($ptr(^^i4, L#arr), 1, ^^i4)))
    {
      anon65:
        // assert @reads_check_normal(arr[1]); 
        assert $typed2($s, $idx($ptr(^^i4, L#arr), 1, ^^i4), ^^i4);
        assert $thread_local2($s, $idx($ptr(^^i4, L#arr), 1, ^^i4), ^^i4);
        // assert @reads_check_normal(arr[2]); 
        assert $typed2($s, $idx($ptr(^^i4, L#arr), 2, ^^i4), ^^i4);
        assert $thread_local2($s, $idx($ptr(^^i4, L#arr), 2, ^^i4), ^^i4);
        // ite#3 := <=(*(arr[1]), *(arr[2])); 
        ite#3 := $mem($s, $idx($ptr(^^i4, L#arr), 1, ^^i4)) <= $mem($s, $idx($ptr(^^i4, L#arr), 2, ^^i4));
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
    assert $typed2($s, $idx($ptr(^^i4, L#arr), 0, ^^i4), ^^i4);
    assert $thread_local2($s, $idx($ptr(^^i4, L#arr), 0, ^^i4), ^^i4);
    assume true;
    // if (==(*(arr[0]), 13)) ...
    if ($mem($s, $idx($ptr(^^i4, L#arr), 0, ^^i4)) == 13)
    {
      anon67:
        // assert @reads_check_normal(arr[1]); 
        assert $typed2($s, $idx($ptr(^^i4, L#arr), 1, ^^i4), ^^i4);
        assert $thread_local2($s, $idx($ptr(^^i4, L#arr), 1, ^^i4), ^^i4);
        // ite#5 := ==(*(arr[1]), 42); 
        ite#5 := $mem($s, $idx($ptr(^^i4, L#arr), 1, ^^i4)) == 42;
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
        assert $typed2($s, $idx($ptr(^^i4, L#arr), 2, ^^i4), ^^i4);
        assert $thread_local2($s, $idx($ptr(^^i4, L#arr), 2, ^^i4), ^^i4);
        // ite#4 := ==(*(arr[2]), 42); 
        ite#4 := $mem($s, $idx($ptr(^^i4, L#arr), 2, ^^i4)) == 42;
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
    call $stack_free(#stackframe, $ptr(^heapSortTestHarnessstackframe#0, addr.#stackframe#0));
    assume $full_stop_ext(#tok$1^320.1, $s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



const unique ^heapSortTestHarnessstackframe#0: $ctype;

axiom $is_composite(^heapSortTestHarnessstackframe#0);

axiom $ptr_level(^heapSortTestHarnessstackframe#0) == 0;

axiom $sizeof(^heapSortTestHarnessstackframe#0) == 12;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^heapSortTestHarnessstackframe#0) } $inv2(#s1, #s2, #p, ^heapSortTestHarnessstackframe#0) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty())));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^heapSortTestHarnessstackframe#0, #r), l#public) } $inv_lab(#s2, $ptr(^heapSortTestHarnessstackframe#0, #r), l#public) == ($typed(#s2, $ptr(^heapSortTestHarnessstackframe#0, #r)) && $set_eq($owns(#s2, $ptr(^heapSortTestHarnessstackframe#0, #r)), $set_empty())));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^heapSortTestHarnessstackframe#0, #r)) } $in_full_extent_of(#q, $ptr(^heapSortTestHarnessstackframe#0, #r)) == (#q == $ptr(^heapSortTestHarnessstackframe#0, #r) || #q == $dot($ptr(^heapSortTestHarnessstackframe#0, #r), heapSortTestHarnessstackframe#0.$owns) || $in_full_extent_of(#q, $as_array($dot($ptr(^heapSortTestHarnessstackframe#0, #r), heapSortTestHarnessstackframe#0.__temp71683), ^^i4, 3))));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^heapSortTestHarnessstackframe#0, #r)) } $in_extent_of(#s, #q, $ptr(^heapSortTestHarnessstackframe#0, #r)) == $in_struct_extent_of(#q, $ptr(^heapSortTestHarnessstackframe#0, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^heapSortTestHarnessstackframe#0, #r)) } $typed(#s, $ptr(^heapSortTestHarnessstackframe#0, #r)) ==> $in_extent_of(#s, #q, $ptr(^heapSortTestHarnessstackframe#0, #r)) == (#q == $ptr(^heapSortTestHarnessstackframe#0, #r) || $emb(#s, #q) == $ptr(^heapSortTestHarnessstackframe#0, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^heapSortTestHarnessstackframe#0, #r)) } $in_span_of(#q, $ptr(^heapSortTestHarnessstackframe#0, #r)) == (#q == $ptr(^heapSortTestHarnessstackframe#0, #r) || #q == $dot($ptr(^heapSortTestHarnessstackframe#0, #r), heapSortTestHarnessstackframe#0.$owns)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^heapSortTestHarnessstackframe#0) } $state_spans_the_same(#s1, #s2, #p, ^heapSortTestHarnessstackframe#0) == $mem_eq(#s1, #s2, $dot(#p, heapSortTestHarnessstackframe#0.$owns)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^heapSortTestHarnessstackframe#0) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^heapSortTestHarnessstackframe#0) == $mem_eq(#s1, #s2, $dot(#p, heapSortTestHarnessstackframe#0.$owns)));

axiom $is_claimable(^heapSortTestHarnessstackframe#0) == false;

axiom $has_volatile_owns_set(^heapSortTestHarnessstackframe#0) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^heapSortTestHarnessstackframe#0, #r)) } $extent_mutable(#s1, $ptr(^heapSortTestHarnessstackframe#0, #r)) == ($mutable(#s1, $ptr(^heapSortTestHarnessstackframe#0, #r)) && $extent_mutable(#s1, $as_array($dot($ptr(^heapSortTestHarnessstackframe#0, #r), heapSortTestHarnessstackframe#0.__temp71683), ^^i4, 3))));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^heapSortTestHarnessstackframe#0, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^heapSortTestHarnessstackframe#0, #r)) == ($is_fresh(#s1, #s2, $ptr(^heapSortTestHarnessstackframe#0, #r)) && $extent_is_fresh(#s1, #s2, $as_array($dot($ptr(^heapSortTestHarnessstackframe#0, #r), heapSortTestHarnessstackframe#0.__temp71683), ^^i4, 3))));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^heapSortTestHarnessstackframe#0, #r)) } $extent_zero(#s1, $ptr(^heapSortTestHarnessstackframe#0, #r)) == $extent_zero(#s1, $as_array($dot($ptr(^heapSortTestHarnessstackframe#0, #r), heapSortTestHarnessstackframe#0.__temp71683), ^^i4, 3)));

const unique heapSortTestHarnessstackframe#0.$owns: $field;

axiom $static_field_properties(heapSortTestHarnessstackframe#0.$owns, ^heapSortTestHarnessstackframe#0);

axiom $is_primitive_non_volatile_field(heapSortTestHarnessstackframe#0.$owns);

axiom (forall #p: $ptr :: { $dot(#p, heapSortTestHarnessstackframe#0.$owns) } $is(#p, ^heapSortTestHarnessstackframe#0) ==> $dot(#p, heapSortTestHarnessstackframe#0.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, heapSortTestHarnessstackframe#0.$owns)) && $extent_hint($dot(#p, heapSortTestHarnessstackframe#0.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, heapSortTestHarnessstackframe#0.$owns)) } { $st(#s, $dot(#p, heapSortTestHarnessstackframe#0.$owns)) } $typed2(#s, #p, ^heapSortTestHarnessstackframe#0) ==> $field_properties(#s, #p, heapSortTestHarnessstackframe#0.$owns, ^$#ptrset, false));

axiom $owns_set_field(^heapSortTestHarnessstackframe#0) == heapSortTestHarnessstackframe#0.$owns;

const unique heapSortTestHarnessstackframe#0.__temp71683: $field;

axiom $static_field_properties(heapSortTestHarnessstackframe#0.__temp71683, ^heapSortTestHarnessstackframe#0);

axiom $embedded_array_size(heapSortTestHarnessstackframe#0.__temp71683, ^^i4) == 3;

axiom $field_offset(heapSortTestHarnessstackframe#0.__temp71683) == 0;

axiom (forall #p: $ptr :: { $dot(#p, heapSortTestHarnessstackframe#0.__temp71683) } $is(#p, ^heapSortTestHarnessstackframe#0) ==> $dot(#p, heapSortTestHarnessstackframe#0.__temp71683) == $ptr(^^i4, $ref(#p) + 0) && $extent_hint($dot(#p, heapSortTestHarnessstackframe#0.__temp71683), #p));

axiom $no_inline_array_field_properties(heapSortTestHarnessstackframe#0.__temp71683, ^^i4, 3, false, false);

function F#lambda#34(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#34: $pure_function;

axiom $function_arg_type(cf#lambda#34, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#34, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#34, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#34, 3, ^^i4);

procedure lambda#34(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#34(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#k$1^178.37#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#34(#l2, #l1, #l0), Q#k$1^178.37#tc2) } $in_range_i4(Q#k$1^178.37#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#34(#l2, #l1, #l0), Q#k$1^178.37#tc2) == (if Q#k$1^178.37#tc2 == #l0 then $select.$map_t..^^i4.^^mathint(#l1, Q#k$1^178.37#tc2) - 1 else $select.$map_t..^^i4.^^mathint(#l2, Q#k$1^178.37#tc2)));

function F#lambda#33() : $map_t..^^i4.^^mathint;

const unique cf#lambda#33: $pure_function;

axiom $function_arg_type(cf#lambda#33, 0, $map_t(^^i4, ^^mathint));

procedure lambda#33() returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#33();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^244.30#tc2: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#33(), Q#e$1^244.30#tc2) } $in_range_i4(Q#e$1^244.30#tc2) ==> $select.$map_t..^^i4.^^mathint(F#lambda#33(), Q#e$1^244.30#tc2) == 0);

function F#lambda#32() : $map_t..^^i4.^^mathint;

const unique cf#lambda#32: $pure_function;

axiom $function_arg_type(cf#lambda#32, 0, $map_t(^^i4, ^^mathint));

procedure lambda#32() returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#32();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^244.30#tc2: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#32(), Q#e$1^244.30#tc2) } $in_range_i4(Q#e$1^244.30#tc2) ==> $select.$map_t..^^i4.^^mathint(F#lambda#32(), Q#e$1^244.30#tc2) == 0);

function F#lambda#31(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#31: $pure_function;

axiom $function_arg_type(cf#lambda#31, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#31, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#31, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#31, 3, ^^i4);

procedure lambda#31(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#31(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^240.47#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#31(#l2, #l1, #l0), Q#e$1^240.47#tc2) } $in_range_i4(Q#e$1^240.47#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#31(#l2, #l1, #l0), Q#e$1^240.47#tc2) == (if Q#e$1^240.47#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^240.47#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^240.47#tc2));

function F#lambda#30(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#30: $pure_function;

axiom $function_arg_type(cf#lambda#30, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#30, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#30, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#30, 3, ^^i4);

procedure lambda#30(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#30(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^225.31#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#30(#l2, #l1, #l0), Q#e$1^225.31#tc2) } $in_range_i4(Q#e$1^225.31#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#30(#l2, #l1, #l0), Q#e$1^225.31#tc2) == (if Q#e$1^225.31#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^225.31#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^225.31#tc2));

function F#lambda#29() : $map_t..^^i4.^^mathint;

const unique cf#lambda#29: $pure_function;

axiom $function_arg_type(cf#lambda#29, 0, $map_t(^^i4, ^^mathint));

procedure lambda#29() returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#29();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^224.31#tc2: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#29(), Q#e$1^224.31#tc2) } $in_range_i4(Q#e$1^224.31#tc2) ==> $select.$map_t..^^i4.^^mathint(F#lambda#29(), Q#e$1^224.31#tc2) == 0);

function F#lambda#28(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#28: $pure_function;

axiom $function_arg_type(cf#lambda#28, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#28, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#28, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#28, 3, ^^i4);

procedure lambda#28(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#28(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#k$1^222.43#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#28(#l2, #l1, #l0), Q#k$1^222.43#tc2) } $in_range_i4(Q#k$1^222.43#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#28(#l2, #l1, #l0), Q#k$1^222.43#tc2) == (if Q#k$1^222.43#tc2 == #l0 then $select.$map_t..^^i4.^^mathint(#l1, Q#k$1^222.43#tc2) - 1 else $select.$map_t..^^i4.^^mathint(#l2, Q#k$1^222.43#tc2)));

function F#lambda#27(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#27: $pure_function;

axiom $function_arg_type(cf#lambda#27, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#27, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#27, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#27, 3, ^^i4);

procedure lambda#27(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#27(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^217.36#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#27(#l2, #l1, #l0), Q#e$1^217.36#tc2) } $in_range_i4(Q#e$1^217.36#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#27(#l2, #l1, #l0), Q#e$1^217.36#tc2) == (if Q#e$1^217.36#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^217.36#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^217.36#tc2));

function F#lambda#26(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#26: $pure_function;

axiom $function_arg_type(cf#lambda#26, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#26, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#26, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#26, 3, ^^i4);

procedure lambda#26(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#26(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^212.38#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#26(#l2, #l1, #l0), Q#e$1^212.38#tc2) } $in_range_i4(Q#e$1^212.38#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#26(#l2, #l1, #l0), Q#e$1^212.38#tc2) == (if Q#e$1^212.38#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^212.38#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^212.38#tc2));

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



axiom (forall Q#e$1^208.43#tc2: int, #l3: $map_t..^^i4.^^mathint, #l2: $map_t..^^i4.^^mathint, #l1: int, #l0: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#25(#l3, #l2, #l1, #l0), Q#e$1^208.43#tc2) } $in_range_i4(Q#e$1^208.43#tc2) && $in_range_i4(#l1) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#25(#l3, #l2, #l1, #l0), Q#e$1^208.43#tc2) == (if Q#e$1^208.43#tc2 == #l0 then 1 else 0) + (if Q#e$1^208.43#tc2 == #l1 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^208.43#tc2) + $select.$map_t..^^i4.^^mathint(#l3, Q#e$1^208.43#tc2));

function F#lambda#24(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#24: $pure_function;

axiom $function_arg_type(cf#lambda#24, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#24, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#24, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#24, 3, ^^i4);

procedure lambda#24(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#24(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^207.31#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#24(#l2, #l1, #l0), Q#e$1^207.31#tc2) } $in_range_i4(Q#e$1^207.31#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#24(#l2, #l1, #l0), Q#e$1^207.31#tc2) == (if Q#e$1^207.31#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^207.31#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^207.31#tc2));

function F#lambda#23() : $map_t..^^i4.^^mathint;

const unique cf#lambda#23: $pure_function;

axiom $function_arg_type(cf#lambda#23, 0, $map_t(^^i4, ^^mathint));

procedure lambda#23() returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#23();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^205.31#tc2: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#23(), Q#e$1^205.31#tc2) } $in_range_i4(Q#e$1^205.31#tc2) ==> $select.$map_t..^^i4.^^mathint(F#lambda#23(), Q#e$1^205.31#tc2) == 0);

function F#lambda#22() : $map_t..^^i4.^^mathint;

const unique cf#lambda#22: $pure_function;

axiom $function_arg_type(cf#lambda#22, 0, $map_t(^^i4, ^^mathint));

procedure lambda#22() returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#22();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^195.36#tc2: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#22(), Q#e$1^195.36#tc2) } $in_range_i4(Q#e$1^195.36#tc2) ==> $select.$map_t..^^i4.^^mathint(F#lambda#22(), Q#e$1^195.36#tc2) == 0);

function F#lambda#21(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#21: $pure_function;

axiom $function_arg_type(cf#lambda#21, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#21, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#21, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#21, 3, ^^i4);

procedure lambda#21(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#21(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#k$1^85.37#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#21(#l2, #l1, #l0), Q#k$1^85.37#tc2) } $in_range_i4(Q#k$1^85.37#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#21(#l2, #l1, #l0), Q#k$1^85.37#tc2) == (if Q#k$1^85.37#tc2 == #l0 then $select.$map_t..^^i4.^^mathint(#l1, Q#k$1^85.37#tc2) + 1 else $select.$map_t..^^i4.^^mathint(#l2, Q#k$1^85.37#tc2)));

function F#lambda#20(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#20: $pure_function;

axiom $function_arg_type(cf#lambda#20, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#20, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#20, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#20, 3, ^^i4);

procedure lambda#20(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#20(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^166.16#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#20(#l2, #l1, #l0), Q#e$1^166.16#tc2) } $in_range_i4(Q#e$1^166.16#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#20(#l2, #l1, #l0), Q#e$1^166.16#tc2) == (if Q#e$1^166.16#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^166.16#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^166.16#tc2));

function F#lambda#19(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#19: $pure_function;

axiom $function_arg_type(cf#lambda#19, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#19, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#19, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#19, 3, ^^i4);

procedure lambda#19(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#19(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^160.38#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#19(#l2, #l1, #l0), Q#e$1^160.38#tc2) } $in_range_i4(Q#e$1^160.38#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#19(#l2, #l1, #l0), Q#e$1^160.38#tc2) == (if Q#e$1^160.38#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^160.38#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^160.38#tc2));

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



axiom (forall Q#e$1^145.43#tc2: int, #l3: $map_t..^^i4.^^mathint, #l2: $map_t..^^i4.^^mathint, #l1: int, #l0: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#18(#l3, #l2, #l1, #l0), Q#e$1^145.43#tc2) } $in_range_i4(Q#e$1^145.43#tc2) && $in_range_i4(#l1) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#18(#l3, #l2, #l1, #l0), Q#e$1^145.43#tc2) == (if Q#e$1^145.43#tc2 == #l0 then -1 else 0) + (if Q#e$1^145.43#tc2 == #l1 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^145.43#tc2) + $select.$map_t..^^i4.^^mathint(#l3, Q#e$1^145.43#tc2));

function F#lambda#17(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#17: $pure_function;

axiom $function_arg_type(cf#lambda#17, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#17, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#17, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#17, 3, ^^i4);

procedure lambda#17(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#17(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^144.31#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#17(#l2, #l1, #l0), Q#e$1^144.31#tc2) } $in_range_i4(Q#e$1^144.31#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#17(#l2, #l1, #l0), Q#e$1^144.31#tc2) == (if Q#e$1^144.31#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^144.31#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^144.31#tc2));

function F#lambda#16() : $map_t..^^i4.^^mathint;

const unique cf#lambda#16: $pure_function;

axiom $function_arg_type(cf#lambda#16, 0, $map_t(^^i4, ^^mathint));

procedure lambda#16() returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#16();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^142.31#tc2: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#16(), Q#e$1^142.31#tc2) } $in_range_i4(Q#e$1^142.31#tc2) ==> $select.$map_t..^^i4.^^mathint(F#lambda#16(), Q#e$1^142.31#tc2) == 0);

function F#lambda#15(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#15: $pure_function;

axiom $function_arg_type(cf#lambda#15, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#15, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#15, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#15, 3, ^^i4);

procedure lambda#15(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#15(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^135.38#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#15(#l2, #l1, #l0), Q#e$1^135.38#tc2) } $in_range_i4(Q#e$1^135.38#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#15(#l2, #l1, #l0), Q#e$1^135.38#tc2) == (if Q#e$1^135.38#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^135.38#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^135.38#tc2));

function F#lambda#14(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#14: $pure_function;

axiom $function_arg_type(cf#lambda#14, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#14, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#14, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#14, 3, ^^i4);

procedure lambda#14(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#14(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^130.40#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#14(#l2, #l1, #l0), Q#e$1^130.40#tc2) } $in_range_i4(Q#e$1^130.40#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#14(#l2, #l1, #l0), Q#e$1^130.40#tc2) == (if Q#e$1^130.40#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^130.40#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^130.40#tc2));

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



axiom (forall Q#e$1^103.43#tc2: int, #l3: $map_t..^^i4.^^mathint, #l2: $map_t..^^i4.^^mathint, #l1: int, #l0: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#13(#l3, #l2, #l1, #l0), Q#e$1^103.43#tc2) } $in_range_i4(Q#e$1^103.43#tc2) && $in_range_i4(#l1) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#13(#l3, #l2, #l1, #l0), Q#e$1^103.43#tc2) == (if Q#e$1^103.43#tc2 == #l0 then -1 else 0) + (if Q#e$1^103.43#tc2 == #l1 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^103.43#tc2) + $select.$map_t..^^i4.^^mathint(#l3, Q#e$1^103.43#tc2));

function F#lambda#12(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#12: $pure_function;

axiom $function_arg_type(cf#lambda#12, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#12, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#12, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#12, 3, ^^i4);

procedure lambda#12(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#12(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^102.31#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#12(#l2, #l1, #l0), Q#e$1^102.31#tc2) } $in_range_i4(Q#e$1^102.31#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#12(#l2, #l1, #l0), Q#e$1^102.31#tc2) == (if Q#e$1^102.31#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^102.31#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^102.31#tc2));

function F#lambda#11() : $map_t..^^i4.^^mathint;

const unique cf#lambda#11: $pure_function;

axiom $function_arg_type(cf#lambda#11, 0, $map_t(^^i4, ^^mathint));

procedure lambda#11() returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#11();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^100.31#tc2: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#11(), Q#e$1^100.31#tc2) } $in_range_i4(Q#e$1^100.31#tc2) ==> $select.$map_t..^^i4.^^mathint(F#lambda#11(), Q#e$1^100.31#tc2) == 0);

function F#lambda#10() : $map_t..^^i4.^^mathint;

const unique cf#lambda#10: $pure_function;

axiom $function_arg_type(cf#lambda#10, 0, $map_t(^^i4, ^^mathint));

procedure lambda#10() returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#10();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^71.67#tc2: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#10(), Q#e$1^71.67#tc2) } $in_range_i4(Q#e$1^71.67#tc2) ==> $select.$map_t..^^i4.^^mathint(F#lambda#10(), Q#e$1^71.67#tc2) == 0);

function F#lambda#9(#l0: $map_t..^^i4.^^mathint) : $map_t..^^u4.$map_t..^^i4.^^mathint;

const unique cf#lambda#9: $pure_function;

axiom $function_arg_type(cf#lambda#9, 0, $map_t(^^u4, $map_t(^^i4, ^^mathint)));

axiom $function_arg_type(cf#lambda#9, 1, $map_t(^^i4, ^^mathint));

procedure lambda#9(#l0: $map_t..^^i4.^^mathint) returns ($result: $map_t..^^u4.$map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#9(#l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^74.13#tc1: int, #l0: $map_t..^^i4.^^mathint :: { $select.$map_t..^^u4.$map_t..^^i4.^^mathint(F#lambda#9(#l0), Q#i$1^74.13#tc1) } $in_range_u4(Q#i$1^74.13#tc1) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint(F#lambda#9(#l0), Q#i$1^74.13#tc1), #l0));

function F#lambda#8() : $map_t..^^i4.^^mathint;

const unique cf#lambda#8: $pure_function;

axiom $function_arg_type(cf#lambda#8, 0, $map_t(^^i4, ^^mathint));

procedure lambda#8() returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#8();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^74.13#tc2: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#8(), Q#e$1^74.13#tc2) } $in_range_i4(Q#e$1^74.13#tc2) ==> $select.$map_t..^^i4.^^mathint(F#lambda#8(), Q#e$1^74.13#tc2) == 0);

function F#lambda#7() : $map_t..^^i4.^^mathint;

const unique cf#lambda#7: $pure_function;

axiom $function_arg_type(cf#lambda#7, 0, $map_t(^^i4, ^^mathint));

procedure lambda#7() returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#7();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^66.29#tc2: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#7(), Q#e$1^66.29#tc2) } $in_range_i4(Q#e$1^66.29#tc2) ==> $select.$map_t..^^i4.^^mathint(F#lambda#7(), Q#e$1^66.29#tc2) == 0);

function F#lambda#6(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) : $map_t..^^i4.^^mathint;

const unique cf#lambda#6: $pure_function;

axiom $function_arg_type(cf#lambda#6, 0, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#6, 1, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#6, 2, $map_t(^^i4, ^^mathint));

axiom $function_arg_type(cf#lambda#6, 3, ^^i4);

procedure lambda#6(#l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int) returns ($result: $map_t..^^i4.^^mathint);
  free ensures $result == F#lambda#6(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#e$1^65.29#tc2: int, #l2: $map_t..^^i4.^^mathint, #l1: $map_t..^^i4.^^mathint, #l0: int :: { $select.$map_t..^^i4.^^mathint(F#lambda#6(#l2, #l1, #l0), Q#e$1^65.29#tc2) } $in_range_i4(Q#e$1^65.29#tc2) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^mathint(F#lambda#6(#l2, #l1, #l0), Q#e$1^65.29#tc2) == (if Q#e$1^65.29#tc2 == #l0 then 1 else 0) + $select.$map_t..^^i4.^^mathint(#l1, Q#e$1^65.29#tc2) + $select.$map_t..^^i4.^^mathint(#l2, Q#e$1^65.29#tc2));

const unique l#public: $label;

type $map_t..^^i4.^^mathint;

function $select.$map_t..^^i4.^^mathint(M: $map_t..^^i4.^^mathint, p: int) : int;

function $store.$map_t..^^i4.^^mathint(M: $map_t..^^i4.^^mathint, p: int, v: int) : $map_t..^^i4.^^mathint;

function $eq.$map_t..^^i4.^^mathint(M1: $map_t..^^i4.^^mathint, M2: $map_t..^^i4.^^mathint) : bool;

const $zero.$map_t..^^i4.^^mathint: $map_t..^^i4.^^mathint;

axiom (forall M: $map_t..^^i4.^^mathint, p: int, v: int :: $in_range_t(^^i4, p) ==> $select.$map_t..^^i4.^^mathint($store.$map_t..^^i4.^^mathint(M, p, v), p) == v);

axiom (forall M: $map_t..^^i4.^^mathint, p: int, v: int, q: int :: p != q ==> $select.$map_t..^^i4.^^mathint($store.$map_t..^^i4.^^mathint(M, q, v), p) == $select.$map_t..^^i4.^^mathint(M, p));

axiom (forall M1: $map_t..^^i4.^^mathint, M2: $map_t..^^i4.^^mathint :: { $eq.$map_t..^^i4.^^mathint(M1, M2) } (forall p: int :: $in_range_t(^^i4, p) ==> $select.$map_t..^^i4.^^mathint(M1, p) == $select.$map_t..^^i4.^^mathint(M2, p)) ==> $eq.$map_t..^^i4.^^mathint(M1, M2));

axiom (forall M1: $map_t..^^i4.^^mathint, M2: $map_t..^^i4.^^mathint :: { $eq.$map_t..^^i4.^^mathint(M1, M2) } $eq.$map_t..^^i4.^^mathint(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^i4.^^mathint(0) == $zero.$map_t..^^i4.^^mathint;

axiom (forall p: int :: $select.$map_t..^^i4.^^mathint($zero.$map_t..^^i4.^^mathint, p) == 0);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t(^^i4, ^^mathint)) } $eq.$map_t..^^i4.^^mathint($int_to_map_t..^^i4.^^mathint($rec_fetch(r1, f)), $int_to_map_t..^^i4.^^mathint($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

type $map_t..^^u4.$map_t..^^i4.^^mathint;

function $select.$map_t..^^u4.$map_t..^^i4.^^mathint(M: $map_t..^^u4.$map_t..^^i4.^^mathint, p: int) : $map_t..^^i4.^^mathint;

function $store.$map_t..^^u4.$map_t..^^i4.^^mathint(M: $map_t..^^u4.$map_t..^^i4.^^mathint, p: int, v: $map_t..^^i4.^^mathint) : $map_t..^^u4.$map_t..^^i4.^^mathint;

function $eq.$map_t..^^u4.$map_t..^^i4.^^mathint(M1: $map_t..^^u4.$map_t..^^i4.^^mathint, M2: $map_t..^^u4.$map_t..^^i4.^^mathint) : bool;

const $zero.$map_t..^^u4.$map_t..^^i4.^^mathint: $map_t..^^u4.$map_t..^^i4.^^mathint;

axiom (forall M: $map_t..^^u4.$map_t..^^i4.^^mathint, p: int, v: $map_t..^^i4.^^mathint :: $in_range_t(^^u4, p) ==> $select.$map_t..^^u4.$map_t..^^i4.^^mathint($store.$map_t..^^u4.$map_t..^^i4.^^mathint(M, p, v), p) == v);

axiom (forall M: $map_t..^^u4.$map_t..^^i4.^^mathint, p: int, v: $map_t..^^i4.^^mathint, q: int :: p != q ==> $select.$map_t..^^u4.$map_t..^^i4.^^mathint($store.$map_t..^^u4.$map_t..^^i4.^^mathint(M, q, v), p) == $select.$map_t..^^u4.$map_t..^^i4.^^mathint(M, p));

axiom (forall M1: $map_t..^^u4.$map_t..^^i4.^^mathint, M2: $map_t..^^u4.$map_t..^^i4.^^mathint :: { $eq.$map_t..^^u4.$map_t..^^i4.^^mathint(M1, M2) } (forall p: int :: $in_range_t(^^u4, p) ==> $eq.$map_t..^^i4.^^mathint($select.$map_t..^^u4.$map_t..^^i4.^^mathint(M1, p), $select.$map_t..^^u4.$map_t..^^i4.^^mathint(M2, p))) ==> $eq.$map_t..^^u4.$map_t..^^i4.^^mathint(M1, M2));

axiom (forall M1: $map_t..^^u4.$map_t..^^i4.^^mathint, M2: $map_t..^^u4.$map_t..^^i4.^^mathint :: { $eq.$map_t..^^u4.$map_t..^^i4.^^mathint(M1, M2) } $eq.$map_t..^^u4.$map_t..^^i4.^^mathint(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^u4.map_t..^^i4.^^mathint(0) == $zero.$map_t..^^u4.$map_t..^^i4.^^mathint;

axiom (forall p: int :: $select.$map_t..^^u4.$map_t..^^i4.^^mathint($zero.$map_t..^^u4.$map_t..^^i4.^^mathint, p) == $zero.$map_t..^^i4.^^mathint);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t(^^u4, $map_t(^^i4, ^^mathint))) } $eq.$map_t..^^u4.$map_t..^^i4.^^mathint($int_to_map_t..^^u4.map_t..^^i4.^^mathint($rec_fetch(r1, f)), $int_to_map_t..^^u4.map_t..^^i4.^^mathint($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

type $map_t..^^u4.^^u4;

function $select.$map_t..^^u4.^^u4(M: $map_t..^^u4.^^u4, p: int) : int;

function $store.$map_t..^^u4.^^u4(M: $map_t..^^u4.^^u4, p: int, v: int) : $map_t..^^u4.^^u4;

function $eq.$map_t..^^u4.^^u4(M1: $map_t..^^u4.^^u4, M2: $map_t..^^u4.^^u4) : bool;

const $zero.$map_t..^^u4.^^u4: $map_t..^^u4.^^u4;

axiom (forall M: $map_t..^^u4.^^u4, p: int, v: int :: $in_range_t(^^u4, p) ==> $select.$map_t..^^u4.^^u4($store.$map_t..^^u4.^^u4(M, p, v), p) == $unchecked(^^u4, v));

axiom (forall M: $map_t..^^u4.^^u4, p: int, v: int, q: int :: p != q ==> $select.$map_t..^^u4.^^u4($store.$map_t..^^u4.^^u4(M, q, v), p) == $select.$map_t..^^u4.^^u4(M, p));

axiom (forall M1: $map_t..^^u4.^^u4, M2: $map_t..^^u4.^^u4 :: { $eq.$map_t..^^u4.^^u4(M1, M2) } (forall p: int :: $in_range_t(^^u4, p) ==> $unchecked(^^u4, $select.$map_t..^^u4.^^u4(M1, p)) == $unchecked(^^u4, $select.$map_t..^^u4.^^u4(M2, p))) ==> $eq.$map_t..^^u4.^^u4(M1, M2));

axiom (forall M1: $map_t..^^u4.^^u4, M2: $map_t..^^u4.^^u4 :: { $eq.$map_t..^^u4.^^u4(M1, M2) } $eq.$map_t..^^u4.^^u4(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^u4.^^u4(0) == $zero.$map_t..^^u4.^^u4;

axiom (forall p: int :: $select.$map_t..^^u4.^^u4($zero.$map_t..^^u4.^^u4, p) == 0);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t(^^u4, ^^u4)) } $eq.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rec_fetch(r1, f)), $int_to_map_t..^^u4.^^u4($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

axiom (forall M: $map_t..^^u4.^^u4, p: int :: $in_range_t(^^u4, $select.$map_t..^^u4.^^u4(M, p)));

type $map_t..^^mathint.^^u4;

function $select.$map_t..^^mathint.^^u4(M: $map_t..^^mathint.^^u4, p: int) : int;

function $store.$map_t..^^mathint.^^u4(M: $map_t..^^mathint.^^u4, p: int, v: int) : $map_t..^^mathint.^^u4;

function $eq.$map_t..^^mathint.^^u4(M1: $map_t..^^mathint.^^u4, M2: $map_t..^^mathint.^^u4) : bool;

const $zero.$map_t..^^mathint.^^u4: $map_t..^^mathint.^^u4;

axiom (forall M: $map_t..^^mathint.^^u4, p: int, v: int :: $select.$map_t..^^mathint.^^u4($store.$map_t..^^mathint.^^u4(M, p, v), p) == $unchecked(^^u4, v));

axiom (forall M: $map_t..^^mathint.^^u4, p: int, v: int, q: int :: p != q ==> $select.$map_t..^^mathint.^^u4($store.$map_t..^^mathint.^^u4(M, q, v), p) == $select.$map_t..^^mathint.^^u4(M, p));

axiom (forall M1: $map_t..^^mathint.^^u4, M2: $map_t..^^mathint.^^u4 :: { $eq.$map_t..^^mathint.^^u4(M1, M2) } (forall p: int :: $unchecked(^^u4, $select.$map_t..^^mathint.^^u4(M1, p)) == $unchecked(^^u4, $select.$map_t..^^mathint.^^u4(M2, p))) ==> $eq.$map_t..^^mathint.^^u4(M1, M2));

axiom (forall M1: $map_t..^^mathint.^^u4, M2: $map_t..^^mathint.^^u4 :: { $eq.$map_t..^^mathint.^^u4(M1, M2) } $eq.$map_t..^^mathint.^^u4(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^mathint.^^u4(0) == $zero.$map_t..^^mathint.^^u4;

axiom (forall p: int :: $select.$map_t..^^mathint.^^u4($zero.$map_t..^^mathint.^^u4, p) == 0);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t(^^mathint, ^^u4)) } $eq.$map_t..^^mathint.^^u4($int_to_map_t..^^mathint.^^u4($rec_fetch(r1, f)), $int_to_map_t..^^mathint.^^u4($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

axiom (forall M: $map_t..^^mathint.^^u4, p: int :: $in_range_t(^^u4, $select.$map_t..^^mathint.^^u4(M, p)));

type $map_t..^^i4.$map_t..^^mathint.^^u4;

function $select.$map_t..^^i4.$map_t..^^mathint.^^u4(M: $map_t..^^i4.$map_t..^^mathint.^^u4, p: int) : $map_t..^^mathint.^^u4;

function $store.$map_t..^^i4.$map_t..^^mathint.^^u4(M: $map_t..^^i4.$map_t..^^mathint.^^u4, p: int, v: $map_t..^^mathint.^^u4) : $map_t..^^i4.$map_t..^^mathint.^^u4;

function $eq.$map_t..^^i4.$map_t..^^mathint.^^u4(M1: $map_t..^^i4.$map_t..^^mathint.^^u4, M2: $map_t..^^i4.$map_t..^^mathint.^^u4) : bool;

const $zero.$map_t..^^i4.$map_t..^^mathint.^^u4: $map_t..^^i4.$map_t..^^mathint.^^u4;

axiom (forall M: $map_t..^^i4.$map_t..^^mathint.^^u4, p: int, v: $map_t..^^mathint.^^u4 :: $in_range_t(^^i4, p) ==> $select.$map_t..^^i4.$map_t..^^mathint.^^u4($store.$map_t..^^i4.$map_t..^^mathint.^^u4(M, p, v), p) == v);

axiom (forall M: $map_t..^^i4.$map_t..^^mathint.^^u4, p: int, v: $map_t..^^mathint.^^u4, q: int :: p != q ==> $select.$map_t..^^i4.$map_t..^^mathint.^^u4($store.$map_t..^^i4.$map_t..^^mathint.^^u4(M, q, v), p) == $select.$map_t..^^i4.$map_t..^^mathint.^^u4(M, p));

axiom (forall M1: $map_t..^^i4.$map_t..^^mathint.^^u4, M2: $map_t..^^i4.$map_t..^^mathint.^^u4 :: { $eq.$map_t..^^i4.$map_t..^^mathint.^^u4(M1, M2) } (forall p: int :: $in_range_t(^^i4, p) ==> $eq.$map_t..^^mathint.^^u4($select.$map_t..^^i4.$map_t..^^mathint.^^u4(M1, p), $select.$map_t..^^i4.$map_t..^^mathint.^^u4(M2, p))) ==> $eq.$map_t..^^i4.$map_t..^^mathint.^^u4(M1, M2));

axiom (forall M1: $map_t..^^i4.$map_t..^^mathint.^^u4, M2: $map_t..^^i4.$map_t..^^mathint.^^u4 :: { $eq.$map_t..^^i4.$map_t..^^mathint.^^u4(M1, M2) } $eq.$map_t..^^i4.$map_t..^^mathint.^^u4(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^i4.map_t..^^mathint.^^u4(0) == $zero.$map_t..^^i4.$map_t..^^mathint.^^u4;

axiom (forall p: int :: $select.$map_t..^^i4.$map_t..^^mathint.^^u4($zero.$map_t..^^i4.$map_t..^^mathint.^^u4, p) == $zero.$map_t..^^mathint.^^u4);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t(^^i4, $map_t(^^mathint, ^^u4))) } $eq.$map_t..^^i4.$map_t..^^mathint.^^u4($int_to_map_t..^^i4.map_t..^^mathint.^^u4($rec_fetch(r1, f)), $int_to_map_t..^^i4.map_t..^^mathint.^^u4($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

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

const unique #loc.__temp71683: $token;

const unique #tok$1^322.15: $token;

const unique #distTp16: $ctype;

axiom #distTp16 == $ptr_to(^heapSortTestHarnessstackframe#0);

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

const unique #distTp15: $ctype;

axiom #distTp15 == $map_t(^^i4, $map_t(^^mathint, ^^u4));

const unique #distTp14: $ctype;

axiom #distTp14 == $map_t(^^mathint, ^^u4);

const unique #loc.len: $token;

const unique #loc.arr: $token;

const unique #tok$1^273.1: $token;

const unique #distTp13: $ctype;

axiom #distTp13 == $map_t(^^u4, ^^u4);

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

const unique #distTp12: $ctype;

axiom #distTp12 == $ptr_to($ptr_to(^localeinfo_struct));

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

const unique #distTp11: $ctype;

axiom #distTp11 == $ptr_to($ptr_to(^^u2));

const unique #loc.addr._Format: $token;

const unique #loc._Count: $token;

const unique #loc._String: $token;

const unique #tok$3^36.1: $token;

const unique #file^c?3A?5CProgram?20Files?20?28x86?29?5CMicrosoft?20Visual?20Studio?2010.0?5CVC?5CINCLUDE?5Cswprintf.inl: $token;

axiom $file_name_is(3, #file^c?3A?5CProgram?20Files?20?28x86?29?5CMicrosoft?20Visual?20Studio?2010.0?5CVC?5CINCLUDE?5Cswprintf.inl);

const unique #loc._ArgList: $token;

const unique #distTp10: $ctype;

axiom #distTp10 == $ptr_to(^localeinfo_struct);

const unique #loc._Locale: $token;

const unique #loc._Format: $token;

const unique #loc._MaxCount: $token;

const unique #loc._DstBuf: $token;

const unique #tok$2^517.3: $token;

const unique #file^c?3A?5CProgram?20Files?20?28x86?29?5CMicrosoft?20Visual?20Studio?2010.0?5CVC?5CINCLUDE?5Cstdio.h: $token;

axiom $file_name_is(2, #file^c?3A?5CProgram?20Files?20?28x86?29?5CMicrosoft?20Visual?20Studio?2010.0?5CVC?5CINCLUDE?5Cstdio.h);

const unique #distTp9: $ctype;

axiom #distTp9 == $ptr_to(^Heap);

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

const unique #distTp8: $ctype;

axiom #distTp8 == $map_t(^^u4, $map_t(^^i4, ^^mathint));

const unique #distTp7: $ctype;

axiom #distTp7 == $map_t(^^i4, ^^mathint);

const unique #distTp6: $ctype;

axiom #distTp6 == $ptr_to(^^i1);

const unique #distTp5: $ctype;

axiom #distTp5 == $ptr_to(^^u1);

const unique #distTp4: $ctype;

axiom #distTp4 == $ptr_to(^^u2);

const unique #distTp3: $ctype;

axiom #distTp3 == $ptr_to(^^i4);

const unique #distTp2: $ctype;

axiom #distTp2 == $ptr_to(^^void);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^threadlocaleinfostruct);
