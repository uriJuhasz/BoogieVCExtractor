// Boogie program verifier version 2.3.0.61016, Copyright (c) 2003-2014, Microsoft.
// Command Line Options: /trace /print:debdeb.bpl /printDesugared vcc3_red_black_tree.bpl /proc:left_rotate

type $ctype;

type $ptr;

type $field;

type $base = $ptr;

type $primitive;

type $struct;

type $token;

type $state;

type $object = [$field][$ptr]int;

type $owner = [$ptr]$ptr;

type $closed = [$ptr]bool;

type $timestamps = [$ptr]int;

type $roots = [$ptr]$ptr;

type $pure_function;

type $label;

type $labelset;

type $ctype_branch;

function $type_branch($ctype) : $ctype_branch;

const unique $ctype_flat: $ctype_branch;

const unique $ctype_ptr: $ctype_branch;

const unique $ctype_spec_ptr: $ctype_branch;

const unique $ctype_map: $ctype_branch;

const unique $ctype_array: $ctype_branch;

function $ptr_to($ctype) : $ctype;

function $spec_ptr_to($ctype) : $ctype;

function $type_project_0($ctype) : $ctype;

axiom (forall #n: $ctype :: 
  { $ptr_to(#n) } 
  $type_project_0($ptr_to(#n)) == #n && $type_branch($ptr_to(#n)) == $ctype_ptr);

axiom (forall #n: $ctype :: 
  { $spec_ptr_to(#n) } 
  $type_project_0($spec_ptr_to(#n)) == #n
     && $type_branch($spec_ptr_to(#n)) == $ctype_spec_ptr);

axiom (forall #n: $ctype :: { $ptr_to(#n) } $sizeof($ptr_to(#n)) == $arch_ptr_size);

axiom (forall #n: $ctype :: 
  { $spec_ptr_to(#n) } 
  $sizeof($ptr_to(#n)) == $arch_ptr_size);

function $map_t($ctype, $ctype) : $ctype;

function $map_domain($ctype) : $ctype;

function $map_range($ctype) : $ctype;

axiom (forall #r: $ctype, #d: $ctype :: 
  { $map_t(#r, #d) } 
  $map_domain($map_t(#r, #d)) == #d
     && $map_range($map_t(#r, #d)) == #r
     && $type_branch($map_t(#r, #d)) == $ctype_map);

function $sizeof($ctype) : int;

function $as_in_range_t($ctype) : $ctype;

function {:inline true} $def_flat_type(t: $ctype, sz: int) : bool
{
  $sizeof(t) == sz && $type_branch(t) == $ctype_flat
}

function {:inline true} $def_primitive_type(t: $ctype, sz: int) : bool
{
  $def_flat_type(t, sz) && $is_primitive(t)
}

function {:inline true} $def_math_type(t: $ctype) : bool
{
  $def_primitive_type(t, 1) && $is_math_type(t)
}

function {:inline true} $def_fnptr_type(t: $ctype) : bool
{
  $def_primitive_type(t, $arch_ptr_size) && $is_fnptr_type(t)
}

function {:inline true} $def_record_type(t: $ctype) : bool
{
  $def_primitive_type(t, 1) && $is_record_type(t)
}

function {:inline true} $def_composite_type(t: $ctype, sz: int, claimable: bool, has_volatile_owns: bool) : bool
{
  $def_flat_type(t, sz)
   && $is_non_primitive(t)
   && ($is_claimable(t) <==> claimable)
   && (if has_volatile_owns
     then $is_volatile_field($f_owns(t))
     else $is_sequential_field($f_owns(t)))
   && true
}

function {:inline true} $def_union_type(t: $ctype, sz: int, claimable: bool, has_volatile_owns: bool) : bool
{
  $def_composite_type(t, sz, claimable, has_volatile_owns)
   && $as_union_type(t) == t
   && $is_union_type(t)
}

function {:inline true} $def_struct_type(t: $ctype, sz: int, claimable: bool, has_volatile_owns: bool) : bool
{
  $def_composite_type(t, sz, claimable, has_volatile_owns) && !$is_union_type(t)
}

function {:inline true} $def_integer_type(t: $ctype, sz: int) : bool
{
  $def_primitive_type(t, sz) && $as_in_range_t(t) == t
}

function $is_primitive(t: $ctype) : bool;

function {:inline true} $is_non_primitive(t: $ctype) : bool
{
  !$is_primitive(t)
}

function {:inline true} $is_non_primitive_ptr(p: $ptr) : bool
{
  $is_non_primitive($typ(p))
}

function $is_claimable($ctype) : bool;

function $is_span_sequential($ctype) : bool;

function $is_group_type($ctype) : bool;

function $is_math_type(t: $ctype) : bool;

function $is_fnptr_type(t: $ctype) : bool;

function $is_record_type(t: $ctype) : bool;

axiom (forall #r: $ctype, #d: $ctype :: 
  { $map_t(#r, #d) } 
  $is_primitive($map_t(#r, #d)));

axiom (forall #n: $ctype :: { $ptr_to(#n) } $is_primitive($ptr_to(#n)));

axiom (forall #n: $ctype :: { $spec_ptr_to(#n) } $is_primitive($spec_ptr_to(#n)));

axiom (forall #n: $ctype :: 
  { $is_primitive(#n) } 
  $is_primitive(#n) ==> !$is_claimable(#n));

function {:inline true} $typ(p: $ptr) : $ctype
{
  $field_type($field(p))
}

function $addr($ptr) : int;

function $base($ptr) : $base;

function $field($ptr) : $field;

function $ptr($field, $base) : $ptr;

axiom (forall t: $field, b: $base :: $field($ptr(t, b)) == t);

axiom (forall t: $field, b: $base :: $base($ptr(t, b)) == b);

axiom (forall p: $ptr :: { $base(p) } { $field(p) } $ptr($field(p), $base(p)) == p);

function {:inline true} $non_null(p: $ptr) : bool
{
  !$is_null(p)
}

function {:inline true} $is_null(p: $ptr) : bool
{
  p == $null_of($typ(p))
}

axiom (forall p: $ptr :: 
  { $addr(p) } 
  ($addr(p) == 0 <==> $is_null(p))
     && ($in_range_phys_ptr(p) ==> $in_range_uintptr($addr(p)))
     && ($in_range_phys_ptr(p) && $is_proper(p)
       ==> $in_range_uintptr($addr(p) + $sizeof($typ(p)))));

type $field_kind;

const unique $fk_base: $field_kind;

const unique $fk_owns: $field_kind;

const unique $fk_ref_cnt: $field_kind;

const unique $fk_vol_version: $field_kind;

const unique $fk_allocation_root: $field_kind;

const unique $fk_as_array_first: $field_kind;

const unique $fk_emb_array: $field_kind;

function $field_kind($field) : $field_kind;

function {:inline true} $is_base_field(f: $field) : bool
{
  $field_kind(f) == $fk_base
}

function $is_proper(p: $ptr) : bool;

axiom (forall p: $ptr :: 
  { $is_proper(p) } 
  $is_proper(p) ==> $field_parent_type($field(p)) == $typ($base(p)));

function $is(p: $ptr, t: $ctype) : bool;

axiom (forall p: $ptr, t: $ctype :: 
  { $is(p, t): bool } 
  $is(p, t): bool <==> $typ(p) == t);

function $spec_ptr_cast(p: $ptr, t: $ctype) : $ptr;

function $phys_ptr_cast(p: $ptr, t: $ctype) : $ptr;

axiom (forall p: $ptr :: 
  { $spec_ptr_cast(p, $typ(p)) } { $in_range_spec_ptr(p) } 
  $in_range_spec_ptr(p) ==> $spec_ptr_cast(p, $typ(p)) == p);

axiom (forall p: $ptr :: 
  { $phys_ptr_cast(p, $typ(p)) } { $in_range_phys_ptr(p) } 
  $in_range_phys_ptr(p)
     ==> $phys_ptr_cast(p, $typ(p)) == p && $is_phys_field($field(p)));

axiom (forall p: $ptr :: 
  { $in_range_phys_ptr($base(p)) } 
  $in_range_phys_ptr(p) ==> $in_range_phys_ptr($base(p)));

axiom (forall p: $ptr, t: $ctype :: 
  { $addr($phys_ptr_cast(p, t)) } 
  $addr($phys_ptr_cast(p, t)) == $addr(p));

function {:inline true} $cast_props(p: $ptr, t: $ctype, c: $ptr) : bool
{
  $typ(c) == t
   && ($is_null(c) <==> $is_null(p))
   && $field(c) == $as_field_with_type($field(c), t)
}

axiom (forall p: $ptr, t: $ctype :: 
  { $spec_ptr_cast(p, t) } 
  $cast_props(p, t, $spec_ptr_cast(p, t))
     && $in_range_spec_ptr($spec_ptr_cast(p, t)));

axiom (forall p: $ptr, t: $ctype :: 
  { $phys_ptr_cast(p, t) } 
  $cast_props(p, t, $phys_ptr_cast(p, t))
     && $in_range_phys_ptr($phys_ptr_cast(p, t)));

axiom (forall p: $ptr :: 
  { $in_range_phys_ptr(p) } 
  (!$in_range_phys_ptr(p) ==> $in_range_spec_ptr(p)) && true);

axiom (forall p: $ptr, f: $field :: 
  { $has_field_at0($typ(p), f), $phys_ptr_cast(p, $field_type(f)) } 
  $is_proper(p) && $in_range_phys_ptr(p) && $has_field_at0($typ(p), f)
     ==> $phys_ptr_cast(p, $field_type(f)) == $dot(p, f));

axiom (forall p: $ptr :: 
  { $phys_ptr_cast(p, $field_parent_type($field(p))), $has_field_at0($field_parent_type($field(p)), $field(p)) } 
  $is_proper(p)
       && $in_range_phys_ptr(p)
       && $has_field_at0($field_parent_type($field(p)), $field(p))
     ==> $phys_ptr_cast(p, $field_parent_type($field(p))) == $emb1(p));

function $dot(p: $ptr, f: $field) : $ptr;

axiom (forall p: $ptr, f: $field :: 
  { $dot(p, f): $ptr } 
  $dot(p, f): $ptr == $ptr(f, p));

axiom (forall p: $ptr, f: $field :: 
  { $addr($dot(p, f)) } 
  $is_phys_field(f)
     ==> $addr($dot(p, f)) == $unchk_add_ptr($addr(p), $field_offset(f)));

axiom (forall p: $ptr, f: $field :: 
  { $dot(p, f) } 
  ($in_range_spec_ptr(p) || $is_ghost_field(f) ==> $in_range_spec_ptr($dot(p, f)))
     && ($in_range_phys_ptr(p) && $is_phys_field(f) ==> $in_range_phys_ptr($dot(p, f)))
     && ($is_proper($dot(p, f)) ==> $non_null(p) ==> $non_null($dot(p, f)))
     && ($is_proper(p) && $field_parent_type(f) == $typ(p) ==> $is_proper($dot(p, f))));

function {:inline true} $emb1(p: $ptr) : $ptr
{
  $base(p)
}

function {:inline true} $emb(S: $state, p: $ptr) : $ptr
{
  $emb0(p)
}

function $emb0(p: $ptr) : $ptr;

axiom (forall p: $ptr :: 
  { $emb0(p): $ptr } 
  $emb0(p): $ptr == (if $is_primitive($typ(p)) then $base(p) else p));

function {:inline true} $simple_emb(p: $ptr) : $ptr
{
  $base(p)
}

function $is_semi_sequential_field(f: $field) : bool;

function $is_sequential_field($field) : bool;

function $is_volatile_field($field) : bool;

function $as_primitive_field($field) : $field;

function $as_composite_field($field) : $field;

function $as_field_with_type($field, $ctype) : $field;

function {:inline true} $as_ptr_with_type(p: $ptr, t: $ctype) : $ptr
{
  $ptr($as_field_with_type($field(p), t), $base(p))
}

function $field_type($field) : $ctype;

function $has_field_at0($ctype, $field) : bool;

axiom (forall f: $field :: 
  { $field_parent_type(f) } 
  $is_non_primitive($field_parent_type(f)));

function {:inline true} $def_field_family(partp: $ctype, f: $field, tp: $ctype) : bool
{
  $field_parent_type(f) == partp
   && $field_type(f) == tp
   && $as_field_with_type(f, tp) == f
   && ($is_primitive(tp) ==> $as_primitive_field(f) == f)
   && (!$is_primitive(tp) ==> $as_composite_field(f) == f)
   && $field_arr_root(f) == f
   && true
}

function {:inline true} $def_field(partp: $ctype, f: $field, tp: $ctype, isvolatile: bool) : bool
{
  $def_field_family(partp, f, tp)
   && (!isvolatile ==> $is_sequential_field(f))
   && (isvolatile ==> $is_volatile_field(f))
   && true
}

function {:inline true} $def_phys_field(partp: $ctype, f: $field, tp: $ctype, isvolatile: bool, off: int) : bool
{
  $def_field(partp, f, tp, isvolatile)
   && $field_offset(f) == off
   && $is_phys_field(f)
   && $is_base_field(f)
   && (off == 0 ==> $has_field_at0(partp, f))
   && true
}

function {:inline true} $def_ghost_field(partp: $ctype, f: $field, tp: $ctype, isvolatile: bool) : bool
{
  $def_field(partp, f, tp, isvolatile)
   && $is_base_field(f)
   && $is_ghost_field(f)
   && true
}

function {:inline true} $def_group(partp: $ctype, f: $field, tp: $ctype) : bool
{
  $def_phys_field(partp, f, tp, false, 0)
   && $f_group_root(tp) == f
   && $is_group_type(tp)
   && true
}

function $f_group_root($ctype) : $field;

function $f_root($ctype) : $field;

function $f_owns($ctype) : $field;

function $f_ref_cnt($ctype) : $field;

function $f_vol_version($ctype) : $field;

function {:inline true} $def_special_field(partp: $ctype, f: $field, tp: $ctype, fk: $field_kind) : bool
{
  $def_field_family(partp, f, tp) && $field_kind(f) == fk && true
}

function {:inline true} $def_special_ghost_field(partp: $ctype, f: $field, tp: $ctype, fk: $field_kind) : bool
{
  $def_special_field(partp, f, tp, fk) && $is_ghost_field(f)
}

const unique $primitive_emb_type: $ctype;

axiom (forall t: $ctype :: 
  { $f_root(t) } 
  (if $is_non_primitive(t)
     then $def_special_field(t, $f_root(t), t, $fk_allocation_root)
     else $def_special_field($primitive_emb_type, $f_root(t), t, $fk_allocation_root)
       && $is_sequential_field($f_root(t))));

axiom (forall t: $ctype :: 
  { $f_owns(t) } 
  $is_non_primitive(t)
     ==> $def_special_ghost_field(t, $f_owns(t), ^$#ptrset, $fk_owns));

axiom (forall t: $ctype :: 
  { $f_ref_cnt(t) } 
  $is_non_primitive(t)
     ==> $def_special_ghost_field(t, $f_ref_cnt(t), ^^mathint, $fk_ref_cnt)
       && $is_semi_sequential_field($f_ref_cnt(t)));

axiom (forall t: $ctype :: 
  { $f_vol_version(t) } 
  $is_non_primitive(t)
     ==> $def_special_ghost_field(t, $f_vol_version(t), ^$#volatile_version_t, $fk_vol_version)
       && $is_semi_sequential_field($f_vol_version(t)));

const $arch_ptr_size: int;

const $arch_ptr_type: $ctype;

function {:inline true} $in_range_uintptr(a: int) : bool
{
  $in_range_t($arch_ptr_type, a)
}

function {:inline true} $unchk_add_ptr(p: int, off: int) : int
{
  $unchk_add($arch_ptr_type, p, off)
}

axiom $arch_ptr_size == 4 ==> $arch_ptr_type == ^^u4;

axiom $arch_ptr_size == 8 ==> $arch_ptr_type == ^^u8;

const unique ^^i1: $ctype;

const unique ^^i2: $ctype;

const unique ^^i4: $ctype;

const unique ^^i8: $ctype;

const unique ^^u1: $ctype;

const unique ^^u2: $ctype;

const unique ^^u4: $ctype;

const unique ^^u8: $ctype;

const unique ^^void: $ctype;

const unique ^^bool: $ctype;

const unique ^^f4: $ctype;

const unique ^^f8: $ctype;

const unique ^^object: $ctype;

const unique ^^field: $ctype;

const unique ^^null_type: $ctype;

axiom $def_integer_type(^^i1, 1);

axiom $def_integer_type(^^i2, 2);

axiom $def_integer_type(^^i4, 4);

axiom $def_integer_type(^^i8, 8);

axiom $def_integer_type(^^u1, 1);

axiom $def_integer_type(^^u2, 2);

axiom $def_integer_type(^^u4, 4);

axiom $def_integer_type(^^u8, 8);

axiom $def_primitive_type(^^f4, 4);

axiom $def_primitive_type(^^f8, 8);

axiom $def_primitive_type(^^bool, 1);

axiom $def_primitive_type(^^void, 1);

axiom $def_math_type(^^object);

axiom $def_math_type(^^field);

axiom $def_math_type(^^null_type);

const unique ^^claim: $ctype;

const unique ^^mathint: $ctype;

const unique ^$#ptrset: $ctype;

const unique ^$#state_t: $ctype;

const unique ^$#volatile_version_t: $ctype;

const unique ^$#struct: $ctype;

const unique ^$#seq_version: $ctype;

const unique ^$#vol_version: $ctype;

axiom $def_composite_type(^^claim, 1, true, false);

axiom $def_composite_type(^$#volatile_version_t, 1, false, false);

axiom $def_math_type(^^mathint);

axiom $def_math_type(^$#ptrset);

axiom $def_math_type(^$#state_t);

axiom $def_math_type(^$#struct);

function $field_offset($field) : int;

function $field_parent_type($field) : $ctype;

function $is_ghost_field($field) : bool;

function $is_phys_field($field) : bool;

const $null: $ptr;

function {:inline true} $null_of(t: $ctype) : $ptr
{
  $phys_ptr_cast($null, t)
}

axiom $addr($null) == 0;

axiom $in_range_spec_ptr($null) && $in_range_phys_ptr($null);

function {:inline true} $is_nice_spec_ptr(p: $ptr, t: $ctype) : bool
{
  $in_range_spec_ptr(p)
   && $non_null(p)
   && $is_proper(p)
   && $field(p) == $f_root(t)
}

const unique ^$#thread_id_t: $ctype;

function $me() : $ptr;

axiom $def_composite_type(^$#thread_id_t, 1, false, true);

axiom $is_nice_spec_ptr($me(), ^$#thread_id_t);

function $is_threadtype(t: $ctype) : bool;

axiom (forall t: $ctype :: 
  { $is_threadtype(t): bool } 
  $is_threadtype(t): bool <==> t == ^$#thread_id_t);

const unique $inactive_union_owner_type: $ctype;

function $inactive_union_owner() : $ptr;

axiom $def_composite_type($inactive_union_owner_type, 1, false, true);

axiom $is_nice_spec_ptr($inactive_union_owner(), $inactive_union_owner_type);

function $field_arr_index($field) : int;

function $field_arr_root($field) : $field;

function $field_arr_size($field) : int;

function $field_arr_ctor($field, int) : $field;

axiom (forall f: $field :: 
  { $field_arr_index(f) } 
  f == $field_arr_ctor($field_arr_root(f), $field_arr_index(f)));

axiom (forall f: $field, i: int :: 
  { $field_arr_ctor(f, i) } 
  $field_arr_root($field_arr_ctor(f, i)) == f
     && $field_arr_index($field_arr_ctor(f, i)) == i);

function {:inline true} $def_arr_field(partp: $ctype, f: $field, tp: $ctype, isvolatile: bool, sz: int) : bool
{
  $def_field(partp, f, tp, isvolatile)
   && $field_arr_size(f) == sz
   && $field_arr_index(f) == 0
   && $field_kind(f) == $fk_emb_array
   && true
}

function {:inline true} $def_phys_arr_field(partp: $ctype, f: $field, tp: $ctype, isvolatile: bool, off: int, sz: int)
   : bool
{
  $def_arr_field(partp, f, tp, isvolatile, sz)
   && $field_offset(f) == off
   && $is_phys_field(f)
   && true
}

function {:inline true} $def_ghost_arr_field(partp: $ctype, f: $field, tp: $ctype, isvolatile: bool, sz: int) : bool
{
  $def_arr_field(partp, f, tp, isvolatile, sz) && $is_ghost_field(f) && true
}

function {:inline true} $def_phys_as_array_field(partp: $ctype, f: $field, tp: $ctype, isvolatile: bool, off: int, sz: int)
   : bool
{
  $def_phys_field(partp, f, $array(tp, sz), isvolatile, off) && true
}

function {:inline true} $def_ghost_as_array_field(partp: $ctype, f: $field, tp: $ctype, isvolatile: bool, sz: int) : bool
{
  $def_ghost_field(partp, f, $array(tp, sz), isvolatile) && true
}

function {:inline true} $idx_inline(p: $ptr, i: int) : $ptr
{
  $dot($base(p), $field_plus($field(p), i))
}

function $idx(p: $ptr, i: int) : $ptr;

axiom (forall p: $ptr, i: int :: 
  { $idx(p, i): $ptr } 
  $idx(p, i): $ptr == $idx_inline(p, i));

axiom (forall p: $ptr, i: int, j: int :: 
  { $idx($idx(p, i), j) } 
  $idx($idx(p, i), j) == $idx_inline(p, i + j));

axiom (forall p: $ptr, i: int :: 
  { $addr($idx(p, i)) } 
  $addr($idx(p, i)) == $unchk_add_ptr($addr(p), $sizeof($typ(p)) * i));

axiom (forall p: $ptr, i: int :: 
  { $idx(p, i) } 
  $is_proper($idx(p, i)) ==> $non_null(p) ==> $non_null($idx(p, i)));

axiom (forall p: $ptr, i: int :: 
  { $idx(p, i) } 
  ($in_range_phys_ptr(p) || $in_range_phys_ptr($base(p)))
       && $is_proper($idx(p, i))
     ==> $in_range_phys_ptr($idx(p, i)));

function $field_plus($field, int) : $field;

axiom (forall f: $field, i: int :: 
  { $field_plus(f, i) } 
  $field_kind($field_plus(f, i)) == $field_kind(f)
     && $field_arr_root($field_plus(f, i)) == $field_arr_root(f)
     && $field_arr_index($field_plus(f, i)) == $field_arr_index(f) + i
     && $field_arr_size($field_plus(f, i)) == $field_arr_size(f)
     && $field_type($field_plus(f, i)) == $field_type(f)
     && $as_field_with_type($field_plus(f, i), $field_type(f)) == $field_plus(f, i)
     && ($is_sequential_field($field_plus(f, i)) <==> $is_sequential_field(f))
     && ($is_volatile_field($field_plus(f, i)) <==> $is_volatile_field(f))
     && ($is_phys_field($field_plus(f, i)) <==> $is_phys_field(f))
     && ($in_range(0, $field_arr_index(f) + i, $field_arr_size(f) - 1)
       ==> $field_parent_type($field_plus(f, i)) == $field_parent_type($field_arr_root(f)))
     && true);

function $is_array(S: $state, p: $ptr, T: $ctype, sz: int) : bool;

axiom (forall S: $state, p: $ptr, T: $ctype, sz: int :: 
  { $is_array(S, p, T, sz): bool } 
  $is_array(S, p, T, sz): bool <==> $is_array_stateless(p, T, sz));

function {:inline true} $is_array_stateless(p: $ptr, T: $ctype, sz: int) : bool
{
  $is(p, T)
   && $is_proper(p)
   && $field_arr_size($field(p)) >= $field_arr_index($field(p)) + sz
   && p
     == $idx($dot($base(p), $field_arr_root($field(p))), $field_arr_index($field(p)))
   && $field_kind($field(p)) != $fk_base
   && $field_arr_index($field(p)) >= 0
   && $is_non_primitive($typ($emb0(p)))
}

function $is_thread_local_array(S: $state, p: $ptr, T: $ctype, sz: int) : bool;

axiom (forall S: $state, p: $ptr, T: $ctype, sz: int :: 
  { $is_thread_local_array(S, p, T, sz): bool } 
  $is_thread_local_array(S, p, T, sz): bool
     <==> $is_thread_local_array_inline(S, p, T, sz));

function {:inline true} $is_thread_local_array_inline(S: $state, p: $ptr, T: $ctype, sz: int) : bool
{
  $is_array(S, p, T, sz)
   && (if $is_primitive(T)
     then $thread_local(S, p)
     else (forall i: int :: 
      { $owner(S, $idx(p, i)) } 
      0 <= i && i < sz ==> $thread_local(S, $idx(p, i))))
}

function $is_mutable_array(S: $state, p: $ptr, T: $ctype, sz: int) : bool;

axiom (forall S: $state, p: $ptr, T: $ctype, sz: int :: 
  { $is_mutable_array(S, p, T, sz): bool } 
  $is_mutable_array(S, p, T, sz): bool
     <==> $is_array(S, p, T, sz)
       && (if $is_primitive(T)
         then $mutable(S, $emb0(p))
         else (forall i: int :: { $idx(p, i) } 0 <= i && i < sz ==> $mutable(S, $idx(p, i)))));

function $array_range(S: $state, p: $ptr, T: $ctype, sz: int) : $ptrset;

axiom (forall S: $state, p: $ptr, T: $ctype, sz: int :: 
  { $array_range(S, p, T, sz): $ptrset } 
  $array_range(S, p, T, sz): $ptrset == $array_range_no_state(p, T, sz));

function $arrays_disjoint(a: $ptr, al: int, b: $ptr, bl: int) : bool;

function $arrays_disjoint_id(a: $ptr, al: int, b: $ptr, bl: int, idx: $ptr) : int;

axiom (forall a: $ptr, al: int, b: $ptr, bl: int :: 
  { $arrays_disjoint(a, al, b, bl) } 
  (forall i: int, j: int :: 
      { $dont_instantiate_int(i), $dont_instantiate_int(j) } 
      0 <= i && i < al && 0 <= j && j < bl ==> $idx(a, i) != $idx(b, j))
     ==> $arrays_disjoint(a, al, b, bl));

axiom (forall a: $ptr, al: int, b: $ptr, bl: int :: 
  { $set_disjoint($array_range_no_state(a, $typ(a), al), $array_range_no_state(b, $typ(b), bl)) } 
  $set_disjoint($array_range_no_state(a, $typ(a), al), $array_range_no_state(b, $typ(b), bl))
     ==> $arrays_disjoint(a, al, b, bl));

axiom (forall a: $ptr, al: int, b: $ptr, bl: int, i: int :: 
  { $arrays_disjoint(a, al, b, bl), $idx_inline(a, i) } 
  $arrays_disjoint(a, al, b, bl) && 0 <= i && i < al
     ==> $arrays_disjoint_id(a, al, b, bl, $idx_inline(a, i)) == 0);

axiom (forall a: $ptr, al: int, b: $ptr, bl: int, i: int :: 
  { $arrays_disjoint(a, al, b, bl), $idx_inline(b, i) } 
  $arrays_disjoint(a, al, b, bl) && 0 <= i && i < bl
     ==> $arrays_disjoint_id(a, al, b, bl, $idx_inline(b, i)) == 1);

function {:inline true} $mem_range(s: $state, p: $ptr, sz: int) : int
{
  $mem_range_heap($heap(s), p, sz)
}

function $mem_range_heap(s: $object, p: $ptr, sz: int) : int;

axiom (forall h: $object, r: $ptr, f: $field, v: int, p: $ptr, sz: int :: 
  !$in_range(0, $index_within(p, $ptr(f, r)), sz - 1)
       || $ptr(f, r) != $idx(p, $index_within(p, $ptr(f, r)))
     ==> $mem_range_heap($update(h, r, f, v), p, sz) == $mem_range_heap(h, p, sz));

axiom (forall S0: $state, S1: $state, p: $ptr, sz: int :: 
  { $call_transition(S0, S1), $mem_range(S1, p, sz) } 
  $call_transition(S0, S1)
       && (forall i: int :: 
        { $dont_instantiate_int(i) } 
        $in_range(0, i, sz - 1) ==> $mem(S0, $idx(p, i)) == $mem(S1, $idx(p, i)))
     ==> $mem_range(S0, p, sz) == $mem_range(S1, p, sz));

axiom (forall S0: $state, S1: $state, p: $ptr, f: $field :: 
  { $call_transition(S0, S1), $rd(S1, p, f) } 
  $instantiate_int($rd(S0, p, f)));

function $index_within(p: $ptr, arr: $ptr) : int;

axiom (forall i: int, a: $ptr :: 
  { $index_within($idx(a, i), a) } 
  $index_within($idx(a, i), a) == i);

axiom (forall p: $ptr, a: $ptr, f: $field :: 
  { $index_within($dot(p, f), a) } 
  $is_proper($dot(p, f)) && $sizeof($typ(p)) <= $sizeof($typ(a))
     ==> $index_within($dot(p, f), a) == $index_within(p, a));

axiom (forall p: $ptr, q: $ptr, t: $ctype :: 
  { $index_within($as_ptr_with_type(p, t), $as_ptr_with_type(q, t)) } 
  $typ(p) == t && $typ(q) == t
     ==> $index_within(p, q) == $field_arr_index($field(p)) - $field_arr_index($field(q)));

function $array_range_no_state(p: $ptr, T: $ctype, sz: int) : $ptrset;

axiom (forall p: $ptr, T: $ctype, sz: int :: 
  { $array_range_no_state(p, T, sz): $ptrset } 
  $array_range_no_state(p, T, sz): $ptrset
     == (if $is_primitive(T)
       then (lambda q: $ptr :: 
        $emb0(q) == $emb0(p)
           && $typ(q) == T
           && $field_arr_root($field(q)) == $field_arr_root($field(p))
           && $in_range(0, $index_within(q, p), sz - 1)
           && q == $idx_inline(p, $index_within(q, p))
           && $field_kind($field(q)) != $fk_base)
       else (lambda q: $ptr :: 
        $in_range(0, $index_within(q, p), sz - 1)
           && $in(q, $full_extent($idx(p, $index_within(q, p)))))));

function $in_composite_array(q: $ptr, a: $ptr, sz: int) : bool;

axiom (forall q: $ptr, a: $ptr, sz: int :: 
  { $in_composite_array(q, a, sz): bool } 
  $in_composite_array(q, a, sz): bool
     <==> $in_range(0, $index_within(q, a), sz - 1) && q == $idx(a, $index_within(q, a)));

function $in_composite_array_lev2(s: $state, q: $ptr, a: $ptr, sz: int) : bool;

axiom (forall s: $state, q: $ptr, a: $ptr, sz: int :: 
  { $in_composite_array_lev2(s, q, a, sz): bool } 
  $in_composite_array_lev2(s, q, a, sz): bool
     <==> $in_range(0, $index_within(q, a), sz - 1)
       && $in(q, $composite_extent(s, $idx(a, $index_within(q, a)), $typ(a))));

function {:inline true} $in_array(q: $ptr, arr: $ptr, T: $ctype, sz: int) : bool
{
  $in_range(0, $index_within(q, arr), sz - 1)
   && q == $idx(arr, $index_within(q, arr))
}

function {:inline true} $in_array_full_extent_of(q: $ptr, arr: $ptr, T: $ctype, sz: int) : bool
{
  $in_range(0, $index_within(q, arr), sz - 1)
   && $in(q, $full_extent($idx(arr, $index_within(q, arr))))
}

function {:inline true} $in_array_extent_of(S: $state, q: $ptr, arr: $ptr, T: $ctype, sz: int) : bool
{
  $in_range(0, $index_within(q, arr), sz - 1)
   && $in(q, $extent(S, $idx(arr, $index_within(q, arr))))
}

function $array_members(p: $ptr, T: $ctype, sz: int) : $ptrset;

axiom (forall p: $ptr, T: $ctype, sz: int :: 
  { $array_members(p, T, sz): $ptrset } 
  $array_members(p, T, sz): $ptrset == (lambda q: $ptr :: $in_array(q, p, T, sz)));

function $array($ctype, int) : $ctype;

function $element_type($ctype) : $ctype;

function $array_length($ctype) : int;

axiom (forall T: $ctype, s: int :: 
  { $array(T, s) } 
  true
     && $element_type($array(T, s)) == T
     && $array_length($array(T, s)) == s
     && $is_non_primitive($array(T, s))
     && !$is_claimable($array(T, s))
     && $type_branch($array(T, s)) == $ctype_array
     && $is_sequential_field($f_owns($array(T, s))));

axiom (forall T: $ctype, s: int :: 
  { $sizeof($array(T, s)) } 
  $sizeof($array(T, s)) == $sizeof(T) * s);

axiom (forall S0: $state, S: $state, p: $ptr, T: $ctype, s: int :: 
  { $inv2(S0, S, p, $array(T, s)) } 
  $inv2(S0, S, p, $array(T, s)) <==> $owns(S, p) == $set_empty());

function $array_emb($ctype, int) : $field;

function {:inline true} $as_array_first_index(p: $ptr) : $ptr
{
  $dot(p, $array_emb($element_type($typ(p)), $array_length($typ(p))))
}

axiom (forall p: $ptr, t: $ctype, sz: int :: 
  { $phys_ptr_cast($as_ptr_with_type(p, $array(t, sz)), t) } 
  $phys_ptr_cast($as_ptr_with_type(p, $array(t, sz)), t)
     == $as_array_first_index(p));

axiom (forall p: $ptr, t: $ctype, sz: int :: 
  { $spec_ptr_cast($as_ptr_with_type(p, $array(t, sz)), t) } 
  $spec_ptr_cast($as_ptr_with_type(p, $array(t, sz)), t)
     == $as_array_first_index(p));

axiom (forall t: $ctype, sz: int :: 
  { $array_emb(t, sz) } { $array(t, sz) } 
  $def_field_family($array(t, sz), $array_emb(t, sz), t)
     && $field_kind($array_emb(t, sz)) == $fk_as_array_first
     && $is_phys_field($array_emb(t, sz))
     && $field_offset($array_emb(t, sz)) == 0
     && $field_arr_size($array_emb(t, sz)) == sz
     && $field_arr_index($array_emb(t, sz)) == 0
     && $field_arr_root($array_emb(t, sz)) == $array_emb(t, sz)
     && $is_sequential_field($array_emb(t, sz))
     && true);

function $as_array(p: $ptr, T: $ctype, sz: int) : $ptr;

axiom (forall p: $ptr, T: $ctype, sz: int :: 
  { $as_array(p, T, sz): $ptr } 
  $as_array(p, T, sz): $ptr
     == (if $is_proper(p)
         && $field_type($field($emb1(p))) == $array(T, sz)
         && $field(p) == $array_emb(T, sz)
       then $emb1(p)
       else $null_of($array(T, sz))));

axiom (forall S: $state, T: $ctype, sz: int, p: $ptr, a: $ptr :: 
  { $in(p, $composite_extent(S, a, $array(T, sz))) } 
  $in(p, $composite_extent(S, a, $array(T, sz)))
     <==> p == a
       || (!$is_primitive(T)
         && $in_composite_array_lev2(S, p, $as_array_first_index(a), sz)));

var $s: $state;

function $f_timestamp($state) : $timestamps;

function $f_owner($state) : $owner;

function $f_closed($state) : $closed;

function $roots(s: $state) : $roots;

function $heap(s: $state) : $object;

function $typemap($owner) : [int,$ctype]$ptr;

function {:inline true} $domain_root(s: $state, p: $ptr) : $ptr
{
  $roots(s)[p]
}

function {:inline true} $rd_inv(s: $state, f: $field, p: $ptr) : int
{
  $rd(s, p, f)
}

function {:inline true} $rd(s: $state, p: $ptr, f: $field) : int
{
  $heap(s)[f][p]
}

function {:inline true} $rdtrig(s: $state, p: $ptr, f: $field) : int
{
  $rd(s, p, f)
}

function {:inline true} $rd_spec_ptr(s: $state, f: $field, p: $ptr, t: $ctype) : $ptr
{
  $spec_ptr_cast($int_to_ptr($rd(s, p, f)), t)
}

function {:inline true} $rd_phys_ptr(s: $state, f: $field, p: $ptr, t: $ctype) : $ptr
{
  $phys_ptr_cast($int_to_ptr($rd(s, p, f)), t)
}

function {:inline true} $current_state(s: $state) : $state
{
  s
}

function {:inline false} $owner(S: $state, p: $ptr) : $ptr;

axiom (forall S: $state, p: $ptr :: 
  {:inline false} { $owner(S, p): $ptr } 
  $owner(S, p): $ptr == $f_owner(S)[p]);

function {:inline false} $closed(S: $state, p: $ptr) : bool;

axiom (forall S: $state, p: $ptr :: 
  {:inline false} { $closed(S, p): bool } 
  $closed(S, p): bool <==> $is_proper(p) && $f_closed(S)[p]);

function {:inline false} $timestamp(S: $state, p: $ptr) : int;

axiom (forall S: $state, p: $ptr :: 
  {:inline false} { $timestamp(S, p): int } 
  $timestamp(S, p): int == $f_timestamp(S)[p]);

function {:inline false} $ref_cnt(S: $state, p: $ptr) : int;

axiom (forall S: $state, p: $ptr :: 
  {:inline false} { $ref_cnt(S, p): int } 
  $ref_cnt(S, p): int == $rd(S, p, $f_ref_cnt($typ(p))));

function $position_marker() : bool;

axiom $position_marker(): bool <==> true;

function {:inline true} $owns_inline(S: $state, p: $ptr) : $ptrset
{
  $int_to_ptrset($rd(S, p, $f_owns($typ(p))))
}

function $owns(S: $state, p: $ptr) : $ptrset;

axiom (forall S: $state, p: $ptr :: 
  { $owns(S, p): $ptrset } 
  $owns(S, p): $ptrset == $owns_inline(S, p));

function {:inline true} $keeps(S: $state, #l: $ptr, #p: $ptr) : bool
{
  $set_in(#p, $owns(S, #l))
}

function {:inline true} $wrapped(S: $state, #p: $ptr, #t: $ctype) : bool
{
  $is(#p, #t)
   && $is_proper(#p)
   && $owner(S, #p) == $me()
   && $closed(S, #p)
   && $is_non_primitive(#t)
}

function {:inline true} $nested(S: $state, p: $ptr) : bool
{
  $typ($owner(S, p)) != ^$#thread_id_t
}

function {:inline true} $irrelevant(S: $state, p: $ptr) : bool
{
  $owner(S, p) != $me() || ($is_primitive($typ(p)) && $closed(S, p))
}

function $mutable(S: $state, p: $ptr) : bool;

axiom (forall S: $state, p: $ptr :: 
  { $mutable(S, p): bool } 
  $mutable(S, p): bool
     <==> $is_proper(p) && $owner(S, $emb(S, p)) == $me() && !$closed(S, $emb(S, p)));

function {:inline true} $thread_owned(S: $state, p: $ptr) : bool
{
  $owner(S, $emb(S, p)) == $me()
}

function {:inline true} $thread_owned_or_even_mutable(S: $state, p: $ptr) : bool
{
  (if $is_primitive($typ(p))
   then $owner(S, $emb(S, p)) == $me() && !$closed(S, $emb(S, p))
   else $owner(S, p) == $me())
}

function {:inline true} $initially_mutable(S: $state, W: $ptrset) : bool
{
  (forall p: $ptr :: 
  { $mutable(S, p) } 
    { $owner(S, p) } 
    { $closed(S, p) } 
    { $owner(S, $emb0(p)) } 
    { $closed(S, $emb0(p)) } 
  $set_in(p, W) ==> $mutable(S, p))
}

function {:inline true} $initially_mutable_array(S: $state, p: $ptr, t: $ctype, sz: int) : bool
{
  $is_mutable_array(S, p, t, sz)
}

function {:inline true} $initially_thread_owned_or_mutable(S: $state, W: $ptrset) : bool
{
  (forall p: $ptr :: 
  { $mutable(S, p) } 
    { $owner(S, p) } 
    { $closed(S, p) } 
    { $owner(S, $emb0(p)) } 
    { $closed(S, $emb0(p)) } 
  $set_in(p, W) ==> $thread_owned_or_even_mutable(S, p))
}

function $in_range_phys_ptr(p: $ptr) : bool;

function $in_range_spec_ptr(p: $ptr) : bool;

const $arch_spec_ptr_start: int;

function {:inline true} $is_ghost_ptr(p: $ptr) : bool
{
  $in_range_spec_ptr(p)
}

function {:inline true} $typed2_phys(S: $state, #p: $ptr, #t: $ctype) : bool
{
  $in_range_phys_ptr(#p)
}

function {:inline true} $typed2_spec(S: $state, #p: $ptr, #t: $ctype) : bool
{
  $in_range_spec_ptr(#p)
}

axiom (forall S: $state, p: $ptr :: 
  { $addr(p), $owner(S, $domain_root(S, p)) } 
  $good_state(S)
     ==> 
    $is_proper(p)
       && $in_range_phys_ptr(p)
       && $owner(S, $domain_root(S, $emb0(p))) == $me()
     ==> $typemap($f_owner(S))[$addr(p), $typ(p)] == p);

axiom (forall S: $state, p: $ptr, f: $field :: 
  { $addr($dot(p, f)), $owner(S, $domain_root(S, p)) } 
  $good_state(S)
     ==> 
    $is_proper($dot(p, f))
       && $in_range_phys_ptr($dot(p, f))
       && $owner(S, $domain_root(S, p)) == $me()
     ==> $typemap($f_owner(S))[$addr($dot(p, f)), $field_type(f)] == $dot(p, f));

axiom (forall S: $state, p: $ptr, q: $ptr :: 
  { $retype(S, q), $as_addr(p, $typ(q), $addr(q)) } 
  $good_state(S)
     ==> 
    $is_proper(p)
       && $in_range_phys_ptr(p)
       && $owner(S, $domain_root(S, $emb0(p))) == $me()
     ==> $typemap($f_owner(S))[$addr(p), $typ(p)] == p);

function $as_addr(p: $ptr, t: $ctype, a: int) : $ptr;

axiom (forall p: $ptr :: { $addr(p) } $as_addr(p, $typ(p), $addr(p)) == p);

function $retype(S: $state, p: $ptr) : $ptr;

axiom (forall S: $state, p: $ptr :: 
  { $retype(S, p): $ptr } 
  $retype(S, p): $ptr == $typemap($f_owner(S))[$addr(p), $typ(p)]);

function $ptr_eq(p1: $ptr, p2: $ptr) : bool;

axiom (forall p1: $ptr, p2: $ptr :: 
  { $ptr_eq(p1, p2): bool } 
  $ptr_eq(p1, p2): bool <==> $addr(p1) == $addr(p2));

function {:inline true} $addr_eq(p1: $ptr, p2: $ptr) : bool
{
  $ptr_eq(p1, p2)
}

function {:inline true} $ptr_neq(p1: $ptr, p2: $ptr) : bool
{
  !$ptr_eq(p1, p2)
}

function $byte_ptr_subtraction(p1: $ptr, p2: $ptr) : int;

axiom (forall p1: $ptr, p2: $ptr :: 
  { $byte_ptr_subtraction(p1, p2): int } 
  $byte_ptr_subtraction(p1, p2): int == $addr(p1) - $addr(p2));

function {:inline true} $is_primitive_field_of(S: $state, #f: $ptr, #o: $ptr) : bool
{
  $is_primitive($typ(#f)) && $emb(S, #f) == #o
}

function $is_domain_root(S: $state, p: $ptr) : bool;

axiom (forall S: $state, p: $ptr :: 
  { $is_domain_root(S, p): bool } 
  $is_domain_root(S, p): bool <==> true);

function $in_wrapped_domain(S: $state, p: $ptr) : bool;

function {:inline true} $thread_local_np(S: $state, p: $ptr) : bool
{
  !$is_primitive($typ(p))
   && $is_proper(p)
   && $owner(S, $domain_root(S, p)) == $me()
   && $non_null(p)
}

function $thread_local(S: $state, p: $ptr) : bool;

axiom (forall S: $state, p: $ptr :: 
  { $thread_local(S, p): bool } 
  $thread_local(S, p): bool
     <==> $is_proper(p)
       && (if $is_primitive($typ(p))
         then ($is_sequential_field($field(p)) || !$closed(S, $emb(S, p)))
           && $thread_local_np(S, $emb(S, p))
         else $thread_local_np(S, p)));

function {:inline true} $thread_local2(S: $state, #p: $ptr, #t: $ctype) : bool
{
  $is(#p, #t) && $thread_local(S, #p)
}

function {:inline true} $typed2(S: $state, p: $ptr, t: $ctype) : bool
{
  $thread_local2(S, p, t)
}

function {:inline true} $typed(S: $state, p: $ptr) : bool
{
  $thread_local(S, p)
}

function {:inline true} $readable_span(S: $state, p: $ptr) : bool
{
  ($is_span_sequential($typ(p)) && $thread_local(S, p)) || $mutable(S, p)
}

function $dont_instantiate($ptr) : bool;

function $dont_instantiate_int(int) : bool;

function $dont_instantiate_state($state) : bool;

function $instantiate_int(int) : bool;

function $instantiate_bool(bool) : bool;

function $instantiate_ptr($ptr) : bool;

function $instantiate_ptrset($ptrset) : bool;

function sk_hack(bool) : bool;

function $start_here() : bool;

function $expect_unreachable() : bool;

function $expect_unreachable_master(id: int) : bool;

function $expect_unreachable_child(id: int) : bool;

function $function_entry($state) : bool;

function $good_state($state) : bool;

function $invok_state($state) : bool;

function $full_stop($state) : bool;

function {:inline true} $inv(#s1: $state, #p: $ptr, typ: $ctype) : bool
{
  $inv2(#s1, #s1, #p, typ)
}

function {:inline true} $inv2nt(S1: $state, S2: $state, p: $ptr) : bool
{
  $inv2(S1, S2, p, $typ(p))
}

function $inv2(#s1: $state, #s2: $state, #p: $ptr, typ: $ctype) : bool;

function {:inline true} $full_stop_ext(t: $token, S: $state) : bool
{
  $good_state_ext(t, S) && $full_stop(S)
}

function $file_name_is(id: int, tok: $token) : bool;

axiom (forall S: $state :: 
  { $function_entry(S) } 
  $function_entry(S)
     ==> $full_stop(S) && $current_timestamp(S) >= 0 && $timestamp_checkpoint(S));

axiom (forall S: $state :: 
  { $full_stop(S) } 
  $full_stop(S) ==> $good_state(S) && $invok_state(S));

axiom (forall S: $state :: { $invok_state(S) } $invok_state(S) ==> $good_state(S));

function {:inline true} $timestamp_checkpoint(S: $state) : bool
{
  (forall p: $ptr :: { $owner(S, p) } $timestamp(S, p) <= $current_timestamp(S))
}

function $good_state_ext(id: $token, S: $state) : bool;

axiom (forall id: $token, S: $state :: 
  { $good_state_ext(id, S) } 
  $good_state_ext(id, S) ==> $good_state(S));

function {:inline true} $closed_is_transitive(S: $state) : bool
{
  (forall p: $ptr, q: $ptr :: 
  { $set_in_pos(p, $owns(S, q)) } 
  $good_state(S) && $set_in(p, $owns_inline(S, q)) && $closed(S, q)
     ==> $is_non_primitive($typ(p))
       && $owner(S, p) == q
       && $closed(S, p)
       && $non_null(p)
       && true)
}

axiom (forall S: $state, #r: $base, #t: $ctype, #f: $field, #sz: int :: 
  { $owns(S, $ptr($as_field_with_type(#f, $array(#t, #sz)), #r)) } 
  $good_state(S)
     ==> $owns(S, $ptr($as_field_with_type(#f, $array(#t, #sz)), #r)) == $set_empty());

axiom (forall S: $state, #p: $ptr, #t: $ctype :: 
  { $inv(S, #p, #t) } 
  $invok_state(S) && $closed(S, #p) ==> $inv(S, #p, #t));

axiom (forall S: $state :: 
  { $good_state(S) } 
  $good_state(S) ==> $closed_is_transitive(S));

axiom (forall S: $state, p: $ptr :: 
  { $closed(S, p) } 
  $good_state(S) ==> $closed(S, p) ==> $non_null(p));

axiom (forall S: $state, p: $ptr :: 
  { $owner(S, p) } { $domain_root(S, p) } 
  $good_state(S)
     ==> 
    $owner(S, p) == $me()
     ==> $is_proper(p)
       && $non_null(p)
       && $is_non_primitive($typ(p))
       && $is_proper(p)
       && $domain_root(S, p) == p);

axiom (forall S: $state, r: $ptr :: 
  { $owner(S, r) } 
  $good_state(S)
     ==> $non_null($owner(S, r))
       && $is_proper($owner(S, r))
       && ($typ($owner(S, r)) != ^$#thread_id_t
         ==> $is_proper(r)
           && $non_null(r)
           && $is_non_primitive($typ(r))
           && ($is_sequential_field($f_owns($typ($owner(S, r))))
             ==> $domain_root(S, r) == $domain_root(S, $owner(S, r)))));

axiom (forall S: $state, p: $ptr :: 
  { $domain_root(S, $domain_root(S, p)) } 
  $good_state(S) ==> $domain_root(S, $domain_root(S, p)) == $domain_root(S, p));

function $call_transition(S1: $state, S2: $state) : bool;

function $trans_call_transition(S1: $state, S2: $state) : bool;

axiom (forall S0: $state, S1: $state :: 
  { $call_transition(S0, S1) } 
  $call_transition(S0, S1) ==> $trans_call_transition(S0, S1));

axiom (forall S0: $state, S1: $state, S2: $state :: 
  { $trans_call_transition(S0, S1), $call_transition(S1, S2) } 
  $trans_call_transition(S0, S1) && $call_transition(S1, S2)
     ==> $trans_call_transition(S0, S2));

axiom (forall S: $state, p: $ptr, f: $field, t: $ctype :: 
  { $rdtrig(S, p, $as_field_with_type(f, $as_in_range_t(t))) } 
  $good_state(S)
     ==> $in_range_t(t, $rd(S, p, $as_field_with_type(f, $as_in_range_t(t)))));

function {:inline true} $update(h: $object, r: $ptr, f: $field, v: int) : $object
{
  h[f := h[f][r := v]]
}

function {:inline true} $havoc_at(S0: $state, S: $state, p: $ptr, f: $field) : bool
{
  $heap(S) == $update($heap(S0), p, f, $rd(S, p, f))
}

function {:inline true} $specials_eq(S0: $state, S: $state) : bool
{
  $f_timestamp(S0) == $f_timestamp(S)
   && $f_closed(S0) == $f_closed(S)
   && $f_owner(S0) == $f_owner(S)
   && $roots(S0) == $roots(S)
}

function {:inline true} $specials_eq_except(S0: $state, S: $state, p: $ptr) : bool
{
  $f_timestamp(S) == $f_timestamp(S0)[p := $f_timestamp(S)[p]]
   && $f_closed(S) == $f_closed(S0)[p := $f_closed(S)[p]]
   && $f_owner(S) == $f_owner(S0)[p := $f_owner(S)[p]]
   && $roots(S) == $roots(S0)[p := $roots(S)[p]]
}

function {:inline true} $meta_eq(s1: $state, s2: $state) : bool
{
  $specials_eq(s1, s2)
}

function {:inline true} $mutable_increases(s1: $state, s2: $state) : bool
{
  (forall p: $ptr :: 
  { $owner(s2, p) } { $closed(s2, p) } { $domain_root(s2, p) } 
  $mutable(s1, p) ==> $mutable(s2, p))
}

procedure $write_int(f: $field, p: $ptr, v: int);
  modifies $s;
  ensures $specials_eq(old($s), $s);
  ensures $heap($s) == $update($heap(old($s)), p, f, v);
  ensures $timestamp_post_strict(old($s), $s);



procedure $write_int_local(h0: [$ptr]int, f: $field, p: $ptr, v: int) returns (h: [$ptr]int);
  modifies $s;
  ensures $specials_eq(old($s), $s);
  ensures $heap($s) == $update($heap(old($s)), p, f, v);
  ensures $timestamp_post_strict(old($s), $s);
  ensures h == h0[p := v];
  ensures old($heap($s))[f] == h0;
  ensures $heap($s)[f] == h;



function {:inline true} $rd_local(h: [$ptr]int, f: $field, p: $ptr) : int
{
  h[p]
}

function {:inline true} $rd_spec_ptr_local(h: [$ptr]int, f: $field, p: $ptr, t: $ctype) : $ptr
{
  $spec_ptr_cast($int_to_ptr(h[p]), t)
}

function {:inline true} $rd_phys_ptr_local(h: [$ptr]int, f: $field, p: $ptr, t: $ctype) : $ptr
{
  $phys_ptr_cast($int_to_ptr(h[p]), t)
}

procedure $write_ref_cnt(p: $ptr, v: int);
  modifies $s;
  ensures $specials_eq(old($s), $s);
  ensures $heap($s) == $update($heap(old($s)), p, $f_ref_cnt($typ(p)), v);
  ensures $timestamp_post_strict(old($s), $s);



function $updated_owns(S0: $state, S: $state, o: $ptr, owns: $ptrset) : bool;

axiom (forall S0: $state, S: $state, o: $ptr, owns: $ptrset :: 
  { $updated_owns(S0, S, o, owns): bool } 
  $updated_owns(S0, S, o, owns): bool
     <==> $heap(S) == $update($heap(S0), o, $f_owns($typ(o)), $ptrset_to_int(owns)));

procedure $set_owns(p: $ptr, owns: $ptrset);
  requires $is_non_primitive($typ(p));
  requires $mutable($s, p);
  modifies $s;
  ensures $updated_owns(old($s), $s, p, owns);
  ensures $specials_eq(old($s), $s);
  ensures $timestamp_post_strict(old($s), $s);



function {:inline true} $timestamp_is_now(S: $state, p: $ptr) : bool
{
  $timestamp(S, p) == $current_timestamp(S)
}

function {:inline true} $now_writable(S: $state, p: $ptr) : bool
{
  $timestamp_is_now(S, p) && $mutable(S, p)
}

function {:inline true} $timestamp_post(M1: $state, M2: $state) : bool
{
  $current_timestamp(M1) <= $current_timestamp(M2) && $call_transition(M1, M2)
}

function {:inline true} $timestamp_post_strict(M1: $state, M2: $state) : bool
{
  $current_timestamp(M1) < $current_timestamp(M2) && $call_transition(M1, M2)
}

function $writes_at(time: int) : $ptrset;

function {:inline false} $in_writes_at(time: int, p: $ptr) : bool;

axiom (forall time: int, p: $ptr :: 
  {:inline false} { $in_writes_at(time, p): bool } 
  $in_writes_at(time, p): bool <==> $in(p, $writes_at(time)));

function {:inline true} $def_writes(S: $state, time: int, ptrs: $ptrset) : bool
{
  $writes_at(time) == ptrs
}

function $current_timestamp(S: $state) : int;

procedure $bump_timestamp();
  modifies $s;
  ensures $f_closed($s) == $f_closed(old($s))
   && $f_owner($s) == $f_owner(old($s))
   && $roots($s) == $roots(old($s))
   && $heap($s) == $heap(old($s));
  ensures $f_timestamp($s) == $f_timestamp(old($s))[$null := $current_timestamp($s)];
  ensures $current_timestamp(old($s)) < $current_timestamp($s);



function {:inline true} $is_fresh(M1: $state, M2: $state, p: $ptr) : bool
{
  $current_timestamp(M1) < $timestamp(M2, p)
   && $timestamp(M2, p) <= $current_timestamp(M2)
}

function {:inline true} $writable(S: $state, begin_time: int, p: $ptr) : bool
{
  $is_non_primitive($typ(p))
   && $is_proper(p)
   && 
  $mutable(S, p)
   && ($timestamp(S, p) >= begin_time || $in_writes_at(begin_time, p))
}

function {:inline true} $writable_prim(S: $state, begin_time: int, p: $ptr) : bool
{
  $is_primitive($typ(p))
   && $is_proper(p)
   && 
  $mutable(S, $emb0(p))
   && ($timestamp(S, $emb0(p)) >= begin_time || $in_writes_at(begin_time, p))
}

function {:inline true} $listed_in_writes(S: $state, begin_time: int, p: $ptr) : bool
{
  $in_writes_at(begin_time, p)
}

function {:inline false} $top_writable(S: $state, begin_time: int, p: $ptr) : bool;

axiom (forall S: $state, begin_time: int, p: $ptr :: 
  {:inline false} { $top_writable(S, begin_time, p): bool } 
  $top_writable(S, begin_time, p): bool
     <==> (if $is_primitive($typ(p))
       then $writable_prim(S, begin_time, p)
       else $owner(S, p) == $me()
         && ($timestamp(S, p) >= begin_time || $in_writes_at(begin_time, p))));

function {:inline true} $not_written(S0: $state, p: $ptr, W: $ptrset) : bool
{
  $owner(S0, $domain_root(S0, p)) == $me() && !$in($domain_root(S0, p), W)
}

function {:inline false} $modifies(S0: $state, S1: $state, W: $ptrset) : bool;

axiom (forall S0: $state, S1: $state, W: $ptrset :: 
  {:inline false} { $modifies(S0, S1, W): bool } 
  $modifies(S0, S1, W): bool
     <==> (forall p: $ptr :: 
        { $domain_root(S1, p) } 
        $not_written(S0, p, W) ==> $domain_root(S0, p) == $domain_root(S1, p))
       && (forall p: $ptr, f: $field :: 
        { $rdtrig(S1, p, f) } 
        $not_written(S0, p, W) && !$in($dot(p, f), W)
           ==> 
          $is_sequential_field(f) || $is_semi_sequential_field(f) || !$closed(S0, p)
           ==> $rd(S0, p, f) == $rd(S1, p, f))
       && (forall p: $ptr :: 
        { $f_timestamp(S1)[p] } 
        ($not_written(S0, p, W) ==> $f_timestamp(S1)[p] == $f_timestamp(S0)[p])
           && $f_timestamp(S1)[p] >= $f_timestamp(S0)[p])
       && (forall p: $ptr :: 
        { $f_closed(S1)[p] } 
        $not_written(S0, p, W) ==> ($f_closed(S1)[p] <==> $f_closed(S0)[p]))
       && (forall p: $ptr :: 
        { $f_owner(S1)[p] } 
        $not_written(S0, p, W) ==> $f_owner(S0)[p] == $f_owner(S1)[p])
       && $timestamp_post(S0, S1));

function {:inline true} $preserves_thread_local(S0: $state, S1: $state) : bool
{
  (forall p: $ptr :: 
  { $thread_local(S1, p) } 
  $thread_local(S0, p) ==> $thread_local(S1, p))
}

function {:inline true} $writes_nothing(S0: $state, S1: $state) : bool
{
  $modifies(S0, S1, $set_empty())
}

function $frame_level($pure_function) : int;

const $current_frame_level: int;

function {:inline true} $can_use_all_frame_axioms(s: $state) : bool
{
  (forall f: $pure_function :: 
  { $frame_level(f) } 
  $frame_level(f) < $current_frame_level)
}

function {:inline true} $can_use_frame_axiom_of(f: $pure_function) : bool
{
  $frame_level(f) < $current_frame_level
}

function $reads_check_pre(s: $state) : bool;

function $reads_check_post(s: $state) : bool;

procedure $reads_havoc();
  requires $reads_check_pre($s);
  modifies $s;
  ensures $reads_check_post($s);
  ensures $call_transition(old($s), $s);



function $same_array(s0: $state, s1: $state, p: $ptr, sz: int) : bool;

axiom (forall s0: $state, s1: $state, p: $ptr, sz: int :: 
  { $same_array(s0, s1, p, sz): bool } 
  $same_array(s0, s1, p, sz): bool
     <==> (forall i: int :: 
      { $idx(p, i) } 
      $in_range(0, i, sz - 1) ==> $mem(s0, $idx(p, i)) == $mem(s1, $idx(p, i))));

function $is_in_stackframe(#sf: int, p: $ptr) : bool;

function {:inline true} $is_allocated0(S0: $state, S: $state, r: $ptr, t: $ctype) : bool
{
  true
   && $is(r, t)
   && $is_proper(r)
   && $writes_nothing(S0, S)
   && $heap(S) == $heap(S0)
   && $timestamp_post_strict(S0, S)
   && !$closed(S0, r)
   && $owner(S0, r) != $me()
   && $is_malloc_root(S, r)
   && $field(r) == $f_root(t)
}

function {:inline true} $is_allocated(S0: $state, S: $state, r: $ptr, t: $ctype) : bool
{
  $is_allocated0(S0, S, r, t)
   && (if $is_primitive(t)
     then $mutable(S, $emb0(r))
       && r == $dot($emb0(r), $field(r))
       && $timestamp_is_now(S, $emb0(r))
     else $extent_mutable(S, r)
       && $extent_is_fresh(S0, S, r)
       && $all_first_option_typed(S, r))
}

function {:inline true} $is_malloc_root(S: $state, p: $ptr) : bool
{
  $is_object_root(S, p)
}

function {:inline true} $is_object_root(S: $state, p: $ptr) : bool
{
  $is_object_root_ptr(p)
}

function $is_object_root_ptr(p: $ptr) : bool;

procedure $stack_alloc(t: $ctype, sf: int, spec: bool) returns (r: $ptr);
  modifies $s;
  ensures $is_allocated(old($s), $s, r, t);
  ensures $is_in_stackframe(sf, r);
  ensures spec ==> $in_range_spec_ptr(r);
  ensures !spec ==> $in_range_phys_ptr(r);



procedure $stack_free(sf: int, x: $ptr);
  requires (if $is_primitive($typ(x)) then $mutable($s, x) else $extent_mutable($s, x));
  requires $is_in_stackframe(sf, x);
  modifies $s;
  ensures (if $is_primitive($typ(x))
   then $modifies(old($s), $s, $set_singleton($emb0(x)))
   else $modifies(old($s), $s, $extent(old($s), x)));
  ensures $heap($s) == $heap(old($s));



procedure $spec_alloc(t: $ctype) returns (r: $ptr);
  modifies $s;
  ensures $is_allocated(old($s), $s, r, t);
  ensures $in_range_spec_ptr(r);



procedure $spec_alloc_array(t: $ctype, sz: int) returns (r: $ptr);
  modifies $s;
  ensures $is_allocated(old($s), $s, r, $array(t, sz));
  ensures $in_range_spec_ptr(r);



procedure $alloc(t: $ctype) returns (r: $ptr);
  modifies $s;
  ensures $non_null(r)
   ==> $is_allocated(old($s), $s, r, t)
     && $in_range_phys_ptr(r)
     && $is_malloc_root($s, r);
  ensures $is_null(r)
   ==> $is(r, t) && $writes_nothing(old($s), $s) && $heap(old($s)) == $heap($s);



procedure $free(x: $ptr);
  requires $extent_mutable($s, x);
  requires $is_malloc_root($s, x);
  modifies $s;
  ensures $modifies(old($s), $s, $extent(old($s), x));
  ensures $heap($s) == $heap(old($s));



function $pre_wrap($state) : bool;

function $pre_unwrap($state) : bool;

function $pre_static_wrap($state) : bool;

function $pre_static_unwrap($state) : bool;

function $post_unwrap(S1: $state, S2: $state) : bool;

function $is_unwrapped_dynamic(S0: $state, S: $state, o: $ptr) : bool;

axiom (forall S0: $state, S: $state, o: $ptr :: 
  { $is_unwrapped_dynamic(S0, S, o): bool } 
  $is_unwrapped_dynamic(S0, S, o): bool
     <==> $is_unwrapped(S0, S, o)
       && $f_timestamp(S)
         == (lambda r: $ptr :: 
          (if $owner(S0, r) == o || r == o
             then $current_timestamp(S)
             else $f_timestamp(S0)[r]))
       && (forall r: $ptr :: 
        { $owner(S, r) } { $closed(S, r) } 
        $set_in(r, $owns(S0, o)) ==> $owner(S0, r) == o && $wrapped(S, r, $typ(r)))
       && $f_owner(S)
         == (lambda r: $ptr :: (if $owner(S0, r) == o then $me() else $f_owner(S0)[r])));

function $is_unwrapped(S0: $state, S: $state, o: $ptr) : bool;

axiom (forall S0: $state, S: $state, o: $ptr :: 
  { $is_unwrapped(S0, S, o): bool } 
  $is_unwrapped(S0, S, o): bool
     <==> true
       && $mutable(S, o)
       && $heap(S) == $heap(S0)
       && $owns(S0, o) == $owns(S, o)
       && (forall p: $ptr :: 
        { $domain_root(S, p) } 
        ($domain_root(S0, p) != o && $domain_root(S0, p) == $domain_root(S, p))
           || (
            $domain_root(S0, p) == o
             && ($domain_root(S, p) == p || $owner(S0, p) != o)
             && $owner(S, $domain_root(S, p)) == $me()))
       && $f_closed(S) == $f_closed(S0)[o := false]
       && $timestamp_post_strict(S0, S)
       && $post_unwrap(S0, S)
       && $typemap($f_owner(S0)) == $typemap($f_owner(S)));

function $is_wrapped_dynamic(S0: $state, S: $state, o: $ptr) : bool;

axiom (forall S0: $state, S: $state, o: $ptr :: 
  { $is_wrapped_dynamic(S0, S, o): bool } 
  $is_wrapped_dynamic(S0, S, o): bool
     <==> $is_wrapped(S0, S, o, $owns(S0, o))
       && $heap(S) == $heap(S0)
       && $owns(S0, o) == $owns(S, o)
       && $f_owner(S)
         == (lambda r: $ptr :: (if $set_in(r, $owns(S0, o)) then o else $f_owner(S0)[r])));

function $is_wrapped(S0: $state, S: $state, o: $ptr, owns: $ptrset) : bool;

axiom (forall S0: $state, S: $state, o: $ptr, owns: $ptrset :: 
  { $is_wrapped(S0, S, o, owns): bool } 
  $is_wrapped(S0, S, o, owns): bool
     <==> true
       && $f_closed(S) == $f_closed(S0)[o := true]
       && $f_timestamp(S) == $f_timestamp(S0)[o := $current_timestamp(S)]
       && (forall p: $ptr :: 
        { $domain_root(S, p) } 
        $domain_root(S, p) == $domain_root(S0, p)
           || ($domain_root(S, p) == o && (p == o || $set_in($domain_root(S0, p), owns))))
       && $wrapped(S, o, $typ(o))
       && ($is_claimable($typ(o)) ==> $ref_cnt(S0, o) == 0 && $ref_cnt(S, o) == 0)
       && $timestamp_post_strict(S0, S)
       && $typemap($f_owner(S0)) == $typemap($f_owner(S)));

procedure $unwrap(o: $ptr, T: $ctype);
  requires !$is_claimable(T) || $ref_cnt($s, o) == 0;
  requires $pre_unwrap($s);
  modifies $s;
  ensures $is_unwrapped_dynamic(old($s), $s, o);



procedure $wrap(o: $ptr, T: $ctype);
  requires $pre_wrap($s);
  requires $is_non_primitive($typ(o));
  requires $mutable($s, o);
  requires (forall p: $ptr :: 
  { $dont_instantiate(p) } 
  $set_in0(p, $owns($s, o)) ==> $wrapped($s, p, $typ(p)));
  modifies $s;
  ensures $is_wrapped_dynamic(old($s), $s, o);



function $take_over(S: $state, l: $ptr, o: $ptr) : $state;

function $release(S0: $state, S: $state, #l: $ptr, #p: $ptr) : $state;

axiom (forall S: $state, l: $ptr, p: $ptr :: 
  { $take_over(S, l, p) } 
  $f_owner($take_over(S, l, p)) == $f_owner(S)[p := l]);

axiom (forall S0: $state, S: $state, l: $ptr, p: $ptr :: 
  { $release(S0, S, l, p) } 
  $f_owner($release(S0, S, l, p)) == $f_owner(S)[p := $me()]
     && $f_timestamp($release(S0, S, l, p))
       == $f_timestamp(S)[p := $current_timestamp(S0)]);

procedure $static_unwrap(o: $ptr, S: $state);
  requires !$is_claimable($typ(o)) || $ref_cnt($s, o) == 0;
  requires $pre_static_unwrap($s);
  modifies $s;
  ensures $is_unwrapped(old($s), $s, o);
  ensures $f_owner($s) == $f_owner(S);
  ensures $f_timestamp($s) == $f_timestamp(S)[o := $current_timestamp(old($s))];



procedure $static_wrap(o: $ptr, S: $state, owns: $ptrset);
  requires $pre_static_wrap($s);
  requires $is_non_primitive($typ(o));
  requires $mutable($s, o);
  modifies $s;
  ensures $is_wrapped(old($s), $s, o, owns);
  ensures $heap($s) == $update($heap(old($s)), o, $f_owns($typ(o)), $ptrset_to_int(owns));
  ensures $f_owner($s) == $f_owner(S);



procedure $static_wrap_non_owns(o: $ptr, S: $state);
  requires $pre_static_wrap($s);
  requires $is_non_primitive($typ(o));
  requires $mutable($s, o);
  modifies $s;
  ensures $is_wrapped(old($s), $s, o, $owns(old($s), o));
  ensures $heap($s) == $heap(old($s));
  ensures $f_owner($s) == $f_owner(S);



function $spans_the_same(S1: $state, S2: $state, p: $ptr, t: $ctype) : bool;

axiom (forall S1: $state, S2: $state, p: $ptr, t: $ctype :: 
  { $spans_the_same(S1, S2, p, t): bool } 
  $spans_the_same(S1, S2, p, t): bool
     <==> $owns(S1, p) == $owns(S2, p)
       && (forall f: $field :: 
        { $rdtrig(S2, p, f) } 
        $is_proper($dot(p, f)) && f != $f_ref_cnt(t) ==> $rd(S1, p, f) == $rd(S2, p, f)));

function $nonvolatile_spans_the_same(S1: $state, S2: $state, p: $ptr, t: $ctype) : bool;

axiom (forall S1: $state, S2: $state, p: $ptr, t: $ctype :: 
  { $nonvolatile_spans_the_same(S1, S2, p, t): bool } 
  $nonvolatile_spans_the_same(S1, S2, p, t): bool
     <==> (forall f: $field :: 
      { $rdtrig(S2, p, f) } 
      $is_proper($dot(p, f)) && $is_sequential_field(f)
         ==> $rd(S1, p, f) == $rd(S2, p, f)));

function $good_for_admissibility(S: $state) : bool;

function $good_for_post_admissibility(S: $state) : bool;

function $admissibility_start(p: $ptr, t: $ctype) : bool;

axiom (forall p: $ptr, t: $ctype :: 
  { $admissibility_start(p, t): bool } 
  $admissibility_start(p, t): bool <==> $is(p, t) && $is_proper(p));

function {:inline true} $stuttering_pre(S: $state, p: $ptr) : bool
{
  (forall q: $ptr :: { $closed(S, q) } $closed(S, q) ==> $inv(S, q, $typ(q)))
   && $good_for_admissibility(S)
}

function {:inline true} $admissibility_pre(S: $state, p: $ptr) : bool
{
  $closed(S, p) && $inv(S, p, $typ(p)) && $stuttering_pre(S, p)
}

procedure $havoc_others(p: $ptr, t: $ctype);
  requires $good_for_admissibility($s);
  modifies $s;
  ensures (if $is_stuttering_check()
   then $nonvolatile_spans_the_same(old($s), $s, p, t)
   else $owns(old($s), p) == $owns($s, p) && $spans_the_same(old($s), $s, p, t));
  ensures $closed($s, p);
  ensures $closed_is_transitive($s);
  ensures $good_state($s);
  ensures $good_for_post_admissibility($s);
  ensures (forall q: $ptr :: 
  { $closed($s, q) } { $closed(old($s), q) } 
  $closed(old($s), q) || $closed($s, q)
     ==> ($spans_the_same(old($s), $s, q, $typ(q))
         && ($closed(old($s), q) <==> $closed($s, q)))
       || ($inv2(old($s), $s, q, $typ(q))
         && $nonvolatile_spans_the_same(old($s), $s, q, $typ(q))));
  ensures (forall q: $ptr :: 
  { $set_in_pos(q, $owns(old($s), p)) } 
  $set_in(q, $owns(old($s), p)) ==> $ref_cnt(old($s), q) == $ref_cnt($s, q));
  ensures $timestamp_post(old($s), $s);



function $is_stuttering_check() : bool;

function $is_unwrap_check() : bool;

function {:inline true} $is_admissibility_check() : bool
{
  !$is_stuttering_check() && !$is_unwrap_check()
}

function $good_for_pre_can_unwrap(S: $state) : bool;

function $good_for_post_can_unwrap(S: $state) : bool;

function {:inline true} $unwrap_check_pre(S: $state, p: $ptr) : bool
{
  $wrapped(S, p, $typ(p))
   && (!$is_claimable($typ(p)) || $ref_cnt(S, p) == 0)
   && $inv(S, p, $typ(p))
   && (forall q: $ptr :: { $closed(S, q) } $closed(S, q) ==> $inv(S, q, $typ(q)))
   && $good_for_pre_can_unwrap(S)
}

procedure $unwrap_check(o: $ptr);
  requires $good_for_pre_can_unwrap($s);
  modifies $s;
  ensures $good_state($s);
  ensures $good_for_post_can_unwrap($s);
  ensures $spans_the_same(old($s), $s, o, $typ(o));
  ensures $is_unwrapped(old($s), $s, o);



function $claims_obj(claim: $ptr, obj: $ptr) : bool;

function $valid_claim(S: $state, claim: $ptr) : bool;

axiom (forall S: $state, c: $ptr :: 
  { $full_stop(S), $valid_claim(S, c) } 
  $full_stop(S) && $closed(S, c) ==> $valid_claim(S, c));

axiom (forall S: $state, c: $ptr :: 
  { $valid_claim(S, c) } 
  $valid_claim(S, c) ==> $closed(S, c) && $invok_state(S));

function {:inline true} $claim_initial_assumptions(#s1: $state, c: $ptr, tok: $token) : bool
{
  $good_state_ext(tok, #s1) && $closed_is_transitive(#s1) && true
}

function {:inline true} $inv2_when_closed(#s1: $state, #s2: $state, #p: $ptr, typ: $ctype) : bool
{
  (!$closed(#s1, #p) && !$closed(#s2, #p))
   || ($inv2(#s1, #s2, #p, typ) && $nonvolatile_spans_the_same(#s1, #s2, #p, typ))
}

function {:inline true} $claim_transitivity_assumptions(#s1: $state, #s2: $state, c: $ptr, tok: $token) : bool
{
  $full_stop_ext(tok, #s1)
   && $good_state_ext(tok, #s2)
   && $closed_is_transitive(#s1)
   && $closed_is_transitive(#s2)
   && (forall #p: $ptr :: 
    { $closed(#s1, #p) } { $closed(#s2, #p) } 
    $inv2_when_closed(#s1, #s2, #p, $typ(#p)))
   && $valid_claim(#s1, c)
   && $closed(#s2, c)
   && true
}

function {:inline true} $valid_claim_impl(S0: $state, S1: $state) : bool
{
  (forall r: $ptr, f: $field :: 
  { $closed(S1, $ptr($as_field_with_type(f, ^^claim), r)) } 
  $is($ptr(f, r), ^^claim)
     ==> 
    $closed(S0, $ptr(f, r)) && $closed(S1, $ptr(f, r))
     ==> $valid_claim(S1, $ptr(f, r)))
}

function $claims_claim(c1: $ptr, c2: $ptr) : bool;

axiom (forall c1: $ptr, c2: $ptr :: 
  { $claims_claim(c1, c2) } 
  $is(c1, ^^claim)
       && $is(c2, ^^claim)
       && (forall S: $state :: $valid_claim(S, c1) ==> $closed(S, c2))
     ==> $claims_claim(c1, c2));

axiom (forall S: $state, c1: $ptr, c2: $ptr :: 
  { $valid_claim(S, c1), $claims_claim(c1, c2) } 
  $valid_claim(S, c1) && $claims_claim(c1, c2) ==> $valid_claim(S, c2));

axiom (forall S: $state, c: $ptr, o: $ptr :: 
  { $closed(S, c), $claims_obj(c, o) } 
  $good_state(S)
     ==> 
    $claims_obj(c, o) && $closed(S, c)
     ==> $instantiate_ptrset($owns(S, o)) && $closed(S, o) && $ref_cnt(S, o) > 0);

axiom (forall S: $state, c: $ptr, o: $ptr :: 
  { $valid_claim(S, c), $claims_obj(c, o) } 
  $valid_claim(S, c) && $claims_obj(c, o) ==> $inv(S, o, $typ(o)));

axiom (forall S: $state, c: $ptr, r: $ptr, f: $field :: 
  { $valid_claim(S, c), $claims_obj(c, $ptr($as_field_with_type(f, ^^claim), r)) } 
  $is($ptr(f, r), ^^claim)
     ==> 
    $valid_claim(S, c) && $claims_obj(c, $ptr(f, r))
     ==> $valid_claim(S, $ptr(f, r)));

function $not_shared(S: $state, p: $ptr) : bool;

axiom (forall S: $state, p: $ptr :: 
  { $not_shared(S, p): bool } 
  $not_shared(S, p): bool
     <==> $wrapped(S, p, $typ(p)) && (!$is_claimable($typ(p)) || $ref_cnt(S, p) == 0));

function $claimed_closed(s: $state, p: $ptr) : bool;

axiom (forall s: $state, p: $ptr :: 
  { $claimed_closed(s, p): bool } 
  $claimed_closed(s, p): bool <==> $closed(s, p));

axiom (forall S: $state, p: $ptr :: 
  { $invok_state(S), $claimed_closed(S, p) } 
  $invok_state(S) && $claimed_closed(S, p) ==> $inv(S, p, $typ(p)));

procedure $atomic_havoc();
  modifies $s;
  ensures $writes_nothing(old($s), $s);
  ensures (forall p: $ptr, f: $field :: 
  { $not_shared(old($s), p), $rdtrig($s, p, f) } 
  $not_shared(old($s), p) ==> $rd($s, p, f) == $rd(old($s), p, f));
  ensures $timestamp_post_strict(old($s), $s);



const unique $no_claim: $ptr;

axiom $no_claim == $null_of(^^claim);

procedure $alloc_claim() returns (r: $ptr);
  modifies $s;
  ensures $is_allocated0(old($s), $s, r, ^^claim);
  ensures $timestamp_is_now($s, r);
  ensures $wrapped($s, r, ^^claim);
  ensures $in_range_spec_ptr(r);
  ensures $owns($s, r) == $set_empty();
  ensures $ref_cnt($s, r) == 0;
  ensures $specials_eq_except(old($s), $s, r);
  ensures r != $no_claim;



function {:inline true} $claim_killed(S0: $state, S: $state, c: $ptr) : bool
{
  $f_closed(S) == $f_closed(S0)[c := false]
   && $f_timestamp(S) == $f_timestamp(S0)
   && $f_owner(S) == $f_owner(S0)
   && $heap(S) == $heap(S0)
   && $good_state(S)
   && $timestamp_post_strict(S0, S)
}

procedure $unclaim(c: $ptr);
  requires $wrapped($s, c, ^^claim);
  requires $ref_cnt($s, c) == 0;
  modifies $s;
  ensures $claim_killed(old($s), $s, c);



procedure $kill_claim(c: $ptr);
  modifies $s;
  ensures $claim_killed(old($s), $s, c);



function $claims_upgrade(the_new: $ptr, the_old: $ptr) : bool;

axiom (forall the_new: $ptr, the_old: $ptr :: 
  { $claims_upgrade(the_new, the_old): bool } 
  $claims_upgrade(the_new, the_old): bool
     <==> (forall o: $ptr :: $claims_obj(the_old, o) ==> $claims_obj(the_new, o)));

function $account_claim(S: $state, c: $ptr, o: $ptr) : bool;

axiom (forall S: $state, c: $ptr, o: $ptr :: 
  { $account_claim(S, c, o): bool } 
  $account_claim(S, c, o): bool
     <==> $good_state(S) && $closed(S, c) && $claims_obj(c, o));

function $claim_no(S: $state, o: $ptr, idx: int) : $ptr;

function $claim_idx(o: $ptr, c: $ptr) : int;

axiom (forall S: $state, c: $ptr, o: $ptr :: 
  { $account_claim(S, c, o) } 
  $account_claim(S, c, o)
     ==> $claim_no(S, o, $claim_idx(o, c)) == c
       && 0 <= $claim_idx(o, c)
       && $claim_idx(o, c) < $ref_cnt(S, o));

procedure $set_closed_owner(#p: $ptr, owner: $ptr);
  requires $is_non_primitive($typ(owner));
  requires $is_non_primitive($typ(#p));
  requires $owner($s, #p) == $me();
  requires $closed($s, #p);
  requires $closed($s, owner);
  requires $is_volatile_field($f_owns($typ(owner)));
  modifies $s;
  ensures $f_closed($s) == $f_closed(old($s));
  ensures $f_timestamp($s) == $f_timestamp(old($s));
  ensures $f_owner($s) == $f_owner(old($s))[#p := owner];
  ensures $roots($s)
   == (lambda q: $ptr :: 
    (if $domain_root(old($s), q) == #p
       then $domain_root($s, q)
       else $domain_root(old($s), q)));
  ensures $updated_owns(old($s), $s, owner, $set_union($set_singleton(#p), $owns(old($s), owner)));
  ensures $set_in(#p, $owns($s, owner));



function {:inline true} $new_ownees(S: $state, o: $ptr, owns: $ptrset) : $ptrset
{
  $set_difference(owns, $owns(S, o))
}

procedure $set_closed_owns(owner: $ptr, owns: $ptrset);
  requires $is_non_primitive($typ(owner));
  requires (forall p: $ptr :: 
  { $dont_instantiate(p) } { sk_hack($set_in0(p, $owns($s, owner))) } 
  $set_in(p, $new_ownees($s, owner, owns)) ==> $wrapped($s, p, $typ(p)));
  requires $closed($s, owner);
  requires $is_volatile_field($f_owns($typ(owner)));
  modifies $s;
  ensures $f_closed($s) == $f_closed(old($s));
  ensures $f_timestamp($s) == $f_timestamp(old($s));
  ensures $f_owner($s)
   == (lambda q: $ptr :: (if $in(q, owns) then owner else $f_owner(old($s))[q]));
  ensures $roots($s)
   == (lambda q: $ptr :: 
    (if $in($domain_root(old($s), q), owns)
       then $domain_root($s, q)
       else $domain_root(old($s), q)));
  ensures $updated_owns(old($s), $s, owner, owns);



procedure $giveup_closed_owner(#p: $ptr, owner: $ptr);
  requires $is_non_primitive($typ(owner));
  requires $set_in(#p, $owns($s, owner));
  requires $closed($s, owner);
  requires $is_volatile_field($f_owns($typ(owner)));
  modifies $s;
  ensures $f_closed($s) == $f_closed(old($s));
  ensures $f_timestamp($s) == $f_timestamp(old($s))[#p := $current_timestamp($s)];
  ensures $f_owner($s) == $f_owner(old($s))[#p := $me()];
  ensures $roots($s)
   == (lambda q: $ptr :: 
    (if $domain_root(old($s), q) == $domain_root(old($s), owner)
       then $domain_root($s, q)
       else $domain_root(old($s), q)));
  ensures $updated_owns(old($s), $s, owner, $set_difference($owns(old($s), owner), $set_singleton(#p)));
  ensures $timestamp_post_strict(old($s), $s);



function $in_domain_lab(S: $state, p: $ptr, q: $ptr, l: $label) : bool;

axiom (forall S: $state, p: $ptr, q: $ptr, l: $label :: 
  { $in_domain_lab(S, p, q, l): bool } 
  $in_domain_lab(S, p, q, l): bool <==> $in_domain(S, p, q));

function $in_vdomain_lab(S: $state, p: $ptr, q: $ptr, l: $label) : bool;

axiom (forall S: $state, p: $ptr, q: $ptr, l: $label :: 
  { $in_vdomain_lab(S, p, q, l): bool } 
  $in_vdomain_lab(S, p, q, l): bool <==> $in_vdomain(S, p, q));

function $inv_lab(S: $state, p: $ptr, l: $label) : bool;

axiom (forall S: $state, p: $ptr, q: $ptr, l: $label :: 
  { $in_domain_lab(S, p, q, l) } 
  $in_domain_lab(S, p, q, l) ==> $inv_lab(S, p, l));

axiom (forall S: $state, p: $ptr, q: $ptr, l: $label :: 
  { $in_vdomain_lab(S, p, q, l) } 
  $in_vdomain_lab(S, p, q, l) ==> $inv_lab(S, p, l));

function $in_domain(S: $state, p: $ptr, q: $ptr) : bool;

function $in_vdomain(S: $state, p: $ptr, q: $ptr) : bool;

axiom (forall S: $state, p: $ptr :: 
  { $in_domain(S, p, $domain_root(S, p)) } 
  $full_stop(S) && $wrapped(S, $domain_root(S, p), $typ($domain_root(S, p)))
     ==> $in_domain(S, p, $domain_root(S, p)));

axiom (forall S: $state, p: $ptr, q: $ptr :: 
  { $in_domain(S, p, q) } 
  $instantiate_ptr($domain_root(S, q))
     && ($in_domain(S, p, q)
       ==> $domain_root(S, p) == q
         && $wrapped(S, q, $typ(q))
         && $closed(S, p)
         && $set_in(p, $domain(S, q))
         && $inv(S, p, $typ(p))
         && $set_in0(p, $owns(S, $owner(S, p)))));

axiom (forall S: $state, p: $ptr, q: $ptr :: 
  { $in_domain(S, p, q) } 
  $full_stop(S) && $set_in(p, $domain(S, q)) && $wrapped(S, q, $typ(q))
     ==> $in_domain(S, p, q));

axiom (forall S: $state, q: $ptr, r: $ptr :: 
  { $in_domain(S, r, $domain_root(S, q)) } 
  $in_domain(S, q, $domain_root(S, q))
       && $is_sequential_field($f_owns($typ(q)))
       && $set_in0(r, $owns(S, q))
     ==> $owner(S, r) == q
       && $domain_root(S, r) == $domain_root(S, q)
       && $in_domain(S, r, $domain_root(S, q)));

function $as_deep_domain(S: $state, p: $ptr) : $ptr;

axiom (forall S: $state, p: $ptr :: 
  { $as_deep_domain(S, p): $ptr } 
  $as_deep_domain(S, p): $ptr == p);

function $wrapped_with_deep_domain(S: $state, p: $ptr) : bool;

axiom (forall S: $state, p: $ptr :: 
  { $wrapped_with_deep_domain(S, p): bool } 
  $wrapped_with_deep_domain(S, p): bool
     <==> $in_domain(S, p, $as_deep_domain(S, p)));

axiom (forall S: $state, p: $ptr, q: $ptr, r: $ptr :: 
  { $in_domain(S, p, $as_deep_domain(S, q)), $set_in(r, $owns(S, p)) } 
  $good_state(S)
       && $is_sequential_field($f_owns($typ(p)))
       && $in_domain(S, p, q)
       && $set_in(r, $owns(S, p))
     ==> $in_domain(S, r, q));

type $version;

function $ver_domain($version) : $ptrset;

function $int_to_version(int) : $version;

function {:inline true} $read_version(S: $state, p: $ptr) : $version
{
  $int_to_version($f_timestamp(S)[p])
}

function {:inline true} $domain(S: $state, p: $ptr) : $ptrset
{
  $ver_domain($read_version(S, p))
}

axiom (forall S: $state, p: $ptr, q: $ptr, r: $ptr :: 
  { $set_in(q, $domain(S, p)), $in_vdomain(S, r, p) } 
  $is_volatile_field($f_owns($typ(q)))
       && $set_in(q, $domain(S, p))
       && (forall S1: $state :: 
        $inv(S1, q, $typ(q))
             && $read_version(S1, p) == $read_version(S, p)
             && $domain(S1, p) == $domain(S, p)
           ==> $set_in0(r, $owns(S1, q)))
     ==> $in_vdomain(S, r, p) && $set_in0(r, $owns(S, q)));

axiom (forall S: $state, p: $ptr, q: $ptr :: 
  { $in_vdomain(S, p, q) } 
  $in_vdomain(S, p, q) ==> $in_domain(S, p, q));

function $fetch_from_domain(v: $version, p: $ptr, f: $field) : int;

axiom (forall S: $state, p: $ptr, d: $ptr, f: $field :: 
  { $rdtrig(S, p, f), $set_in(p, $domain(S, d)), $is_sequential_field(f) } 
  $set_in(p, $domain(S, d)) && $is_sequential_field(f)
     ==> $rd(S, p, f) == $fetch_from_domain($read_version(S, d), p, f));

function $in_claim_domain(p: $ptr, c: $ptr) : bool;

axiom (forall p: $ptr, c: $ptr :: 
  { $in_claim_domain(p, c) } 
  (forall s: $state :: 
      { $dont_instantiate_state(s) } 
      $valid_claim(s, c) ==> $closed(s, p))
     ==> $in_claim_domain(p, c));

function $by_claim(S: $state, c: $ptr, obj: $ptr, ptr: $ptr) : $ptr;

axiom (forall S: $state, c: $ptr, obj: $ptr, ptr: $ptr :: 
  { $by_claim(S, c, obj, ptr): $ptr } 
  $by_claim(S, c, obj, ptr): $ptr == ptr);

function $claim_version($ptr) : $version;

axiom (forall S: $state, p: $ptr, c: $ptr, f: $field :: 
  { $in_claim_domain(p, c), $rdtrig(S, p, f) } 
  $good_state(S)
       && $closed(S, c)
       && $in_claim_domain(p, c)
       && $is_sequential_field(f)
     ==> $in_claim_domain(p, c)
       && $rd(S, p, f) == $fetch_from_domain($claim_version(c), p, f));

axiom (forall S: $state, p: $ptr, q: $ptr, c: $ptr, f: $field :: 
  { $by_claim(S, c, q, $dot(p, f)) } 
  $good_state(S)
       && $closed(S, c)
       && $in_claim_domain(p, c)
       && $is_sequential_field(f)
     ==> $in_claim_domain(p, c)
       && $rd(S, p, f) == $fetch_from_domain($claim_version(c), p, f));

type $vol_version;

function $int_to_vol_version(int) : $vol_version;

function {:inline true} $volatile_version_addr(p: $ptr) : $ptr
{
  $dot(p, $f_vol_version($typ(p)))
}

function $read_vol_version(S: $state, p: $ptr) : $vol_version;

axiom (forall S: $state, p: $ptr :: 
  { $read_vol_version(S, p): $vol_version } 
  $read_vol_version(S, p): $vol_version
     == $int_to_vol_version($rd(S, p, $f_vol_version($typ(p)))));

function $fetch_from_vv(v: $vol_version, p: $ptr, f: $field) : int;

function {:inline true} $fetch_vol_field(S: $state, p: $ptr, f: $field) : int
{
  $fetch_from_vv($read_vol_version(S, p), p, f)
}

function $is_approved_by(t: $ctype, approver: $field, subject: $field) : bool;

function $is_owner_approved(t: $ctype, subject: $field) : bool;

axiom (forall S: $state, t: $ctype, p: $ptr, approver: $field, subject: $field :: 
  { $is_approved_by(t, approver, subject), $rd(S, p, subject) } 
  $full_stop(S)
       && $is_approved_by(t, approver, subject)
       && $closed(S, p)
       && ($int_to_ptr($rd(S, p, approver)) == $me()
         || $int_to_ptr($fetch_vol_field(S, p, approver)) == $me())
     ==> $rd(S, p, subject) == $fetch_vol_field(S, p, subject));

function {:inline true} $inv_is_approved_by_ptr(S1: $state, S2: $state, this: $ptr, approver: $ptr, subject: $field) : bool
{
  $rd(S1, this, subject) == $rd(S2, this, subject)
   || $is_null(approver)
   || (!$is_threadtype($typ(approver)) && $inv2nt(S1, S2, approver))
   || ($is_threadtype($typ(approver))
     && $read_vol_version(S1, this) != $read_vol_version(S2, this))
}

function $depends(S1: $state, S2: $state, dependant: $ptr, this: $ptr) : bool;

axiom (forall S1: $state, S2: $state, dependant: $ptr, this: $ptr :: 
  { $depends(S1, S2, dependant, this): bool } 
  $depends(S1, S2, dependant, this): bool
     <==> $spans_the_same(S1, S2, this, $typ(this))
       || $inv2_when_closed(S1, S2, dependant, $typ(dependant))
       || $is_threadtype($typ(dependant)));

function {:inline true} $inv_is_approved_by(S1: $state, S2: $state, this: $ptr, approver: $field, subject: $field) : bool
{
  $inv_is_approved_by_ptr(S1, S2, this, $int_to_ptr($rd(S1, this, approver)), subject)
}

axiom (forall S: $state, p: $ptr, t: $ctype, subject: $field :: 
  { $is_owner_approved(t, subject), $rd(S, p, subject) } 
  $full_stop(S)
       && $closed(S, p)
       && $is_owner_approved(t, subject)
       && $owner(S, p) == $me()
     ==> $rd(S, p, subject) == $fetch_vol_field(S, p, subject));

function {:inline true} $inv_is_owner_approved(S1: $state, S2: $state, this: $ptr, subject: $field) : bool
{
  $inv_is_approved_by_ptr(S1, S2, this, $owner(S1, this), subject)
}

procedure $bump_volatile_version(p: $ptr);
  modifies $s;
  ensures $specials_eq(old($s), $s);
  ensures $havoc_at(old($s), $s, p, $f_vol_version($typ(p)));
  ensures $read_vol_version(old($s), p) != $read_vol_version($s, p);
  ensures $timestamp_post_strict(old($s), $s);



function $composite_extent(S: $state, r: $ptr, t: $ctype) : $ptrset;

function $extent(S: $state, r: $ptr) : $ptrset;

axiom (forall S: $state, r: $ptr :: 
  { $extent(S, r): $ptrset } 
  $extent(S, r): $ptrset
     == (lambda p: $ptr :: 
      $is_proper($dot($base(p), $field(p)))
         && $composite_extent(S, r, $typ(r))[$emb0(p)]));

const $full_extent_state: $state;

function $full_extent(r: $ptr) : $ptrset;

axiom (forall r: $ptr :: 
  { $full_extent(r): $ptrset } 
  $full_extent(r): $ptrset
     == (lambda p: $ptr :: 
      $is_proper(p) && $composite_extent($full_extent_state, r, $typ(r))[$emb0(p)]));

axiom (forall S: $state, p: $ptr, r: $ptr :: 
  { $in(p, $composite_extent(S, r, $typ(r))) } 
  $extent_hint(p, r));

function $span(o: $ptr) : $ptrset;

axiom (forall o: $ptr :: 
  { $span(o): $ptrset } 
  $span(o): $ptrset == (lambda p: $ptr :: $is_proper(p) && $emb0(p) == o));

function {:inline true} $struct_extent(#p: $ptr) : $ptrset
{
  $full_extent(#p)
}

function $extent_mutable(S: $state, r: $ptr) : bool;

axiom (forall S: $state, r: $ptr :: 
  { $extent_mutable(S, r): bool } 
  $extent_mutable(S, r): bool
     <==> $mutable(S, r)
       && (forall p: $ptr :: 
        { $extent_hint(p, r) } 
        $in(p, $composite_extent(S, r, $typ(r))) ==> $mutable(S, p)));

function $extent_thread_local(S: $state, r: $ptr) : bool;

axiom (forall S: $state, r: $ptr :: 
  { $extent_thread_local(S, r): bool } 
  $extent_thread_local(S, r): bool
     <==> $readable_span(S, r)
       && (forall p: $ptr :: 
        { $extent_hint(p, r) } 
        $in(p, $composite_extent(S, r, $typ(r))) ==> $readable_span(S, p)));

axiom (forall S: $state, T: $ctype, sz: int, p: $ptr :: 
  { $extent_mutable(S, $as_ptr_with_type(p, $array(T, sz))) } 
  $extent_mutable(S, $as_ptr_with_type(p, $array(T, sz)))
     ==> $is_mutable_array(S, $as_array_first_index(p), T, sz));

axiom (forall S: $state, T: $ctype, sz: int, p: $ptr :: 
  { $mutable(S, $as_ptr_with_type(p, $array(T, sz))) } 
  $in_range_phys_ptr(p)
     ==> 
    $is_primitive(T) && $mutable(S, $as_ptr_with_type(p, $array(T, sz)))
     ==> $is_mutable_array(S, $as_array_first_index(p), T, sz));

function $extent_is_fresh(S0: $state, S: $state, r: $ptr) : bool;

axiom (forall S0: $state, S: $state, r: $ptr :: 
  { $extent_is_fresh(S0, S, r): bool } 
  $extent_is_fresh(S0, S, r): bool
     <==> $timestamp_is_now(S, r)
       && (forall p: $ptr :: 
        { $extent_hint(p, r) } 
        $in(p, $composite_extent(S, r, $typ(r))) ==> $timestamp_is_now(S, p)));

function $volatile_span(S: $state, q: $ptr) : $ptrset;

axiom (forall S: $state, q: $ptr :: 
  { $volatile_span(S, q): $ptrset } 
  $volatile_span(S, q): $ptrset
     == (lambda p: $ptr :: 
      $is_proper(p) && $is_volatile_field($field(p)) && $emb0(p) == q));

function $extent_hint(p: $ptr, q: $ptr) : bool;

axiom (forall p: $ptr, q: $ptr, r: $ptr :: 
  { $extent_hint(p, q), $extent_hint(q, r) } 
  $extent_hint(p, q) && $extent_hint(q, r) ==> $extent_hint(p, r));

axiom (forall p: $ptr, f: $field :: 
  { $dot(p, $as_composite_field(f)) } 
  $extent_hint($dot(p, $as_composite_field(f)), p));

axiom (forall p: $ptr, i: int :: { $idx(p, i) } $extent_hint($idx(p, i), p));

procedure $union_reinterpret(#x: $ptr, #off: $field);
  requires $is_union_field(#off);
  requires $field_parent_type(#off) == $typ(#x);
  modifies $s;
  ensures $owner($s, $dot(#x, #off)) == $me();
  ensures $owner($s, #x) == $me();
  ensures $extent_mutable($s, #x);
  ensures $extent_is_fresh(old($s), $s, #x);
  ensures $union_havoced(old($s), 
  $s, 
  $composite_extent(old($s), #x, $typ(#x)), 
  $composite_extent($s, #x, $typ(#x)));
  ensures $timestamp_post_strict(old($s), $s);



function {:inline true} $union_havoced(S0: $state, S1: $state, E0: $ptrset, E1: $ptrset) : bool
{
  (forall p: $ptr :: 
    { $domain_root(S1, p) } 
    $in(p, E0) || $in(p, E1) || $domain_root(S0, p) == $domain_root(S1, p))
   && (forall p: $ptr, f: $field :: 
    { $rdtrig(S1, p, f) } 
    $in(p, E0) || $in(p, E1) || $rd(S0, p, f) == $rd(S1, p, f))
   && (forall p: $ptr :: 
    { $f_timestamp(S1)[p] } 
    ($in(p, E0) || $in(p, E1) || $f_timestamp(S1)[p] == $f_timestamp(S0)[p])
       && $f_timestamp(S1)[p] >= $f_timestamp(S0)[p])
   && $f_closed(S0) == $f_closed(S1)
   && (forall p: $ptr :: 
    { $f_owner(S1)[p] } 
    $in(p, E0) || $in(p, E1) || $f_owner(S0)[p] == $f_owner(S1)[p])
   && $timestamp_post(S0, S1)
}

function $is_union_field($field) : bool;

function $as_union_type($ctype) : $ctype;

function $is_union_type($ctype) : bool;

function {:inline true} $as_union_ptr(p: $ptr, t: $ctype) : $ptr
{
  $as_ptr_with_type(p, $as_union_type(t))
}

function $first_union_field($ctype) : $field;

function {:inline true} $is_first_union_field(f: $field) : bool
{
  $is_union_field(f) && $first_union_field($field_parent_type(f)) == f
}

function $first_option_typed(S: $state, #p: $ptr) : bool;

axiom (forall S: $state, #p: $ptr :: 
  { $first_option_typed(S, #p): bool } 
  $first_option_typed(S, #p): bool
     <==> $is_union_type($typ(#p))
       ==> $owner(S, $dot(#p, $first_union_field($typ(#p)))) != $inactive_union_owner());

function $all_first_option_typed(S: $state, p: $ptr) : bool;

axiom (forall S: $state, p: $ptr :: 
  { $all_first_option_typed(S, p): bool } 
  $all_first_option_typed(S, p): bool
     <==> $first_option_typed(S, p)
       && (forall q: $ptr, t: $ctype :: 
        { $extent_hint($as_union_ptr(q, t), p) } 
        $in(q, $composite_extent(S, p, $typ(p))) ==> $first_option_typed(S, q)));

function {:inline true} $union_active(s: $state, p: $ptr, f: $field) : bool
{
  $owner(s, $dot(p, f)) != $inactive_union_owner()
}

function $active_option(S: $state, p: $ptr) : $field;

axiom (forall S: $state, p: $ptr, f: $field :: 
  { $is_union_field(f), $owner(S, $dot(p, f)) } 
  $good_state(S)
     && $is_union_field(f)
     && ($owner(S, $dot(p, f)) != $inactive_union_owner() ==> $active_option(S, p) == f)
     && ($owner(S, $dot(p, f)) == $inactive_union_owner()
       ==> (forall q: $ptr :: 
        { $extent_hint(q, p) } 
        $in(q, $composite_extent(S, $dot(p, f), $typ($dot(p, f))))
           ==> !$thread_local_np(S, q))));

axiom (forall S: $state, p: $ptr, f: $field :: 
  { $is_union_field(f), $dot(p, f), $active_option(S, p) } 
  $good_state(S) && $is_union_field(f)
     ==> f == $active_option(S, p) || $owner(S, $dot(p, f)) == $inactive_union_owner());

function $strong_struct_eq(A: $state, a: $ptr, B: $state, b: $ptr) : bool;

axiom (forall A: $state, a: $ptr, B: $state, b: $ptr :: 
  { $strong_struct_eq(A, a, B, b): bool } 
  $strong_struct_eq(A, a, B, b): bool
     <==> $strong_shallow_struct_eq(A, a, B, b)
       && (forall f: $field :: 
        { $dot(a, $as_composite_field(f)) } 
        $composite_extent(A, a, $typ(a))[$dot(a, f)]
           ==> $strong_struct_eq(A, $dot(a, f), B, $dot(b, f))));

function $strong_shallow_struct_eq(A: $state, a: $ptr, B: $state, b: $ptr) : bool;

axiom (forall A: $state, a: $ptr, B: $state, b: $ptr :: 
  { $strong_shallow_struct_eq(A, a, B, b): bool } 
  $strong_shallow_struct_eq(A, a, B, b): bool
     <==> (forall f: $field :: $rd(A, a, f) == $rd(B, b, f)));

procedure $copy_struct(dst: $ptr, src: $ptr);
  requires $typ(dst) == $typ(src);
  requires $extent_thread_local($s, src);
  modifies $s;
  ensures $specials_eq(old($s), $s);
  ensures (forall p: $ptr, f: $field :: 
  { $rdtrig($s, p, f) } 
  $composite_extent(old($s), dst, $typ(dst))[p]
     || $rd(old($s), p, f) == $rd($s, p, f));
  ensures $strong_struct_eq($s, src, $s, dst);



const $struct_zero: $struct;

axiom $good_state($vs_state($struct_zero));

function {:inline true} $vs_base(s: $struct, t: $ctype) : $ptr
{
  $phys_ptr_cast($vs_base_ref(s), t)
}

function $vs_base_ref($struct) : $ptr;

function $vs_state($struct) : $state;

axiom (forall s: $struct :: $good_state($vs_state(s)));

function $vs_deep_eq(a: $struct, b: $struct, t: $ctype) : bool;

axiom (forall a: $struct, b: $struct, t: $ctype :: 
  { $vs_deep_eq(a, b, t): bool } 
  $vs_deep_eq(a, b, t): bool
     <==> $strong_struct_eq($vs_state(a), $vs_base(a, t), $vs_state(b), $vs_base(b, t)));

function $vs_shallow_eq(a: $struct, b: $struct, t: $ctype) : bool;

axiom (forall a: $struct, b: $struct, t: $ctype :: 
  { $vs_shallow_eq(a, b, t): bool } 
  $vs_shallow_eq(a, b, t): bool
     <==> $strong_shallow_struct_eq($vs_state(a), $vs_base(a, t), $vs_state(b), $vs_base(b, t)));

function $vs_ctor(S: $state, p: $ptr) : $struct;

axiom (forall S: $state, p: $ptr :: 
  { $vs_ctor(S, p) } 
  $good_state(S)
     ==> $phys_ptr_cast($vs_base_ref($vs_ctor(S, p)), $typ(p)) == p
       && $vs_state($vs_ctor(S, p)) == S);

axiom (forall f: $field, t: $ctype :: 
  { $rdtrig($vs_state($struct_zero), $vs_base($struct_zero, t), f) } 
  $rd($vs_state($struct_zero), $vs_base($struct_zero, t), f) == 0);

function {:inline true} $mem(s: $state, p: $ptr) : int
{
  $rd(s, $base(p), $field(p))
}

function $update_int(S: $state, p: $ptr, v: int) : $state;

axiom (forall S: $state, p: $ptr, v: int :: 
  { $update_int(S, p, v) } 
  $specials_eq(S, $update_int(S, p, v))
     && $heap($update_int(S, p, v)) == $update($heap(S), $base(p), $field(p), v));

procedure $havoc(o: $ptr, t: $ctype);
  requires $is(o, t);
  modifies $s;
  ensures $specials_eq(old($s), $s);
  ensures (forall p: $ptr, f: $field :: 
  { $rdtrig($s, p, f) } 
  $composite_extent(old($s), o, t)[p] || $rd(old($s), p, f) == $rd($s, p, f));
  ensures $timestamp_post_strict(old($s), $s);



function $program_entry_point(s: $state) : bool;

function $program_entry_point_ch(s: $state) : bool;

axiom (forall S: $state :: 
  { $program_entry_point(S) } 
  $program_entry_point(S) ==> $program_entry_point_ch(S));

function {:inline true} $def_global(p: $ptr, t: $ctype) : bool
{
  $is(p, t) && $is_object_root_ptr(p) && true
}

function {:inline true} $is_global(p: $ptr, t: $ctype) : bool
{
  (forall S: $state :: 
  { $program_entry_point(S) } 
  $program_entry_point(S) ==> $extent_mutable(S, p) && $owns(S, p) == $set_empty())
}

function {:inline true} $is_global_array(p: $ptr, T: $ctype, sz: int) : bool
{
  (forall S: $state :: 
  { $program_entry_point(S) } 
  $program_entry_point(S) ==> $is_mutable_array(S, p, T, sz))
}

type $dt_tag;

function $has_arity($dt_tag, int) : bool;

function $is_datatype($ctype) : bool;

function {:inline true} $def_datatype_type(t: $ctype) : bool
{
  $def_math_type(t) && $is_datatype(t)
}

function $def_datatype_option(parent: $ctype, tag: $dt_tag, arity: int) : bool;

axiom (forall parent: $ctype, tag: $dt_tag, arity: int :: 
  { $def_datatype_option(parent, tag, arity): bool } 
  $def_datatype_option(parent, tag, arity): bool <==> $has_arity(tag, arity));

type $ptrset = [$ptr]bool;

function {:inline true} $in(p: $ptr, s: $ptrset) : bool
{
  s[p]
}

function {:inline true} $set_in(p: $ptr, s: $ptrset) : bool
{
  s[p]
}

function $set_empty() : $ptrset;

axiom $set_empty(): $ptrset == (lambda o: $ptr :: false);

function $set_singleton(p: $ptr) : $ptrset;

axiom (forall p: $ptr :: 
  { $set_singleton(p): $ptrset } 
  $set_singleton(p): $ptrset == (lambda o: $ptr :: o == p));

function $non_null_set_singleton(p: $ptr) : $ptrset;

axiom (forall p: $ptr :: 
  { $non_null_set_singleton(p): $ptrset } 
  $non_null_set_singleton(p): $ptrset
     == (lambda o: $ptr :: $non_null(p) && p == o));

function $set_union(A: $ptrset, B: $ptrset) : $ptrset;

axiom (forall A: $ptrset, B: $ptrset :: 
  { $set_union(A, B): $ptrset } 
  $set_union(A, B): $ptrset == (lambda o: $ptr :: A[o] || B[o]));

function $set_difference(A: $ptrset, B: $ptrset) : $ptrset;

axiom (forall A: $ptrset, B: $ptrset :: 
  { $set_difference(A, B): $ptrset } 
  $set_difference(A, B): $ptrset == (lambda o: $ptr :: A[o] && !B[o]));

function $set_intersection(A: $ptrset, B: $ptrset) : $ptrset;

axiom (forall A: $ptrset, B: $ptrset :: 
  { $set_intersection(A, B): $ptrset } 
  $set_intersection(A, B): $ptrset == (lambda o: $ptr :: A[o] && B[o]));

function $set_subset(A: $ptrset, B: $ptrset) : bool;

axiom (forall A: $ptrset, B: $ptrset :: 
  { $set_subset(A, B): bool } 
  $set_subset(A, B): bool
     <==> (forall o: $ptr :: 
      { $set_in(o, A) } { $set_in(o, B) } 
      $set_in(o, A) ==> $set_in(o, B)));

function {:inline true} $set_add_element(S: $ptrset, e: $ptr) : $ptrset
{
  $set_union(S, $set_singleton(e))
}

function {:inline true} $set_remove_element(S: $ptrset, e: $ptr) : $ptrset
{
  $set_difference(S, $set_singleton(e))
}

function $set_eq($ptrset, $ptrset) : bool;

axiom (forall #a: $ptrset, #b: $ptrset :: 
  { $set_eq(#a, #b) } 
  (forall #o: $ptr :: 
      { $dont_instantiate(#o) } 
      $set_in(#o, #a) <==> $set_in(#o, #b))
     ==> $set_eq(#a, #b));

axiom (forall #a: $ptrset, #b: $ptrset :: 
  { $set_eq(#a, #b) } 
  $set_eq(#a, #b) ==> #a == #b);

function $set_cardinality($ptrset) : int;

axiom $set_cardinality($set_empty()) == 0;

axiom (forall p: $ptr :: 
  { $set_singleton(p) } 
  $set_cardinality($set_singleton(p)) == 1);

function $set_universe() : $ptrset;

axiom (forall #o: $ptr :: 
  { $set_in(#o, $set_universe()) } 
  $set_in(#o, $set_universe()));

function $set_disjoint(s1: $ptrset, s2: $ptrset) : bool;

function $id_set_disjoint(p: $ptr, s1: $ptrset, s2: $ptrset) : int;

axiom (forall p: $ptr, s1: $ptrset, s2: $ptrset :: 
  { $set_disjoint(s1, s2), $set_in(p, s1) } 
  $set_disjoint(s1, s2) && $set_in(p, s1) ==> $id_set_disjoint(p, s1, s2) == 1);

axiom (forall p: $ptr, s1: $ptrset, s2: $ptrset :: 
  { $set_disjoint(s1, s2), $set_in(p, s2) } 
  $set_disjoint(s1, s2) && $set_in(p, s2) ==> $id_set_disjoint(p, s1, s2) == 2);

axiom (forall s1: $ptrset, s2: $ptrset :: 
  { $set_disjoint(s1, s2) } 
  (forall p: $ptr :: 
      { $dont_instantiate(p) } 
      ($set_in(p, s1) ==> !$set_in(p, s2)) && ($set_in(p, s2) ==> !$set_in(p, s1)))
     ==> $set_disjoint(s1, s2));

function {:inline false} $set_in_pos(p: $ptr, s: $ptrset) : bool;

axiom (forall p: $ptr, s: $ptrset :: 
  { $set_in(p, s) } 
  $set_in(p, s) ==> $set_in_pos(p, s));

function $set_in0(p: $ptr, s: $ptrset) : bool;

axiom (forall p: $ptr, s: $ptrset :: 
  { $set_in0(p, s): bool } 
  $set_in0(p, s): bool <==> $set_in(p, s));

function $get_fnptr(no: int, t: $ctype) : $ptr;

axiom (forall no: int, t: $ctype :: 
  { $get_fnptr(no, t): $ptr } 
  $get_fnptr(no, t): $ptr == $ptr($f_root(t), $get_fnptr_ref(no)));

function $get_fnptr_ref(no: int) : $base;

function $get_fnptr_inv(rf: $base) : int;

axiom (forall no: int :: $get_fnptr_inv($get_fnptr_ref(no)) == no);

function $valid_fnptr($ptr) : bool;

axiom (forall no: int, t: $ctype :: 
  { $get_fnptr(no, t) } 
  $is_fnptr_type(t)
     ==> $in_range_phys_ptr($get_fnptr(no, t)) && $valid_fnptr($get_fnptr(no, t)));

function {:inline true} $in_range(min: int, val: int, max: int) : bool
{
  min <= val && val <= max
}

function {:inline true} $bool_to_int(v: bool) : int
{
  (if v then 1 else 0)
}

function {:inline true} $int_to_bool(x: int) : bool
{
  x != 0
}

function $bool_id(x: bool) : bool;

axiom (forall x: bool :: { $bool_id(x): bool } $bool_id(x): bool <==> x);

const $min.i1: int;

const $max.i1: int;

const $min.i2: int;

const $max.i2: int;

const $min.i4: int;

const $max.i4: int;

const $min.i8: int;

const $max.i8: int;

const $max.u1: int;

const $max.u2: int;

const $max.u4: int;

const $max.u8: int;

axiom $min.i1 == -128;

axiom $max.i1 == 127;

axiom $min.i2 == -32768;

axiom $max.i2 == 32767;

axiom $min.i4 == -(65536 * 32768);

axiom $max.i4 == 65536 * 32768 - 1;

axiom $min.i8 == -(65536 * 65536 * 65536 * 32768);

axiom $max.i8 == 65536 * 65536 * 65536 * 32768 - 1;

axiom $max.u1 == 255;

axiom $max.u2 == 65535;

axiom $max.u4 == 65536 * 65536 - 1;

axiom $max.u8 == 65536 * 65536 * 65536 * 65536 - 1;

function {:inline true} $in_range_i1(x: int) : bool
{
  $in_range($min.i1, x, $max.i1)
}

function {:inline true} $in_range_i2(x: int) : bool
{
  $in_range($min.i2, x, $max.i2)
}

function {:inline true} $in_range_i4(x: int) : bool
{
  $in_range($min.i4, x, $max.i4)
}

function {:inline true} $in_range_i8(x: int) : bool
{
  $in_range($min.i8, x, $max.i8)
}

function {:inline true} $in_range_u1(x: int) : bool
{
  $in_range(0, x, $max.u1)
}

function {:inline true} $in_range_u2(x: int) : bool
{
  $in_range(0, x, $max.u2)
}

function {:inline true} $in_range_u4(x: int) : bool
{
  $in_range(0, x, $max.u4)
}

function {:inline true} $in_range_u8(x: int) : bool
{
  $in_range(0, x, $max.u8)
}

function {:inline true} $in_range_ptr(p: $ptr) : bool
{
  $in_range_u8($addr(p))
}

function {:inline true} $in_range_div_i1(x: int, y: int) : bool
{
  y != -1 || x != $min.i1
}

function {:inline true} $in_range_div_i2(x: int, y: int) : bool
{
  y != -1 || x != $min.i2
}

function {:inline true} $in_range_div_i4(x: int, y: int) : bool
{
  y != -1 || x != $min.i4
}

function {:inline true} $in_range_div_i8(x: int, y: int) : bool
{
  y != -1 || x != $min.i8
}

function $_pow2(int) : int;

axiom $_pow2(0) == 1
   && $_pow2(1) == 2
   && $_pow2(2) == 4
   && $_pow2(3) == 8
   && $_pow2(4) == 16
   && $_pow2(5) == 32
   && $_pow2(6) == 64
   && $_pow2(7) == 128
   && $_pow2(8) == 256
   && $_pow2(9) == 512
   && $_pow2(10) == 1024
   && $_pow2(11) == 2048
   && $_pow2(12) == 4096
   && $_pow2(13) == 8192
   && $_pow2(14) == 16384
   && $_pow2(15) == 32768
   && $_pow2(16) == 65536
   && $_pow2(17) == 131072
   && $_pow2(18) == 262144
   && $_pow2(19) == 524288
   && $_pow2(20) == 1048576
   && $_pow2(21) == 2097152
   && $_pow2(22) == 4194304
   && $_pow2(23) == 8388608
   && $_pow2(24) == 16777216
   && $_pow2(25) == 33554432
   && $_pow2(26) == 67108864
   && $_pow2(27) == 134217728
   && $_pow2(28) == 268435456
   && $_pow2(29) == 536870912
   && $_pow2(30) == 1073741824
   && $_pow2(31) == 2147483648
   && $_pow2(32) == 4294967296
   && $_pow2(33) == 8589934592
   && $_pow2(34) == 17179869184
   && $_pow2(35) == 34359738368
   && $_pow2(36) == 68719476736
   && $_pow2(37) == 137438953472
   && $_pow2(38) == 274877906944
   && $_pow2(39) == 549755813888
   && $_pow2(40) == 1099511627776
   && $_pow2(41) == 2199023255552
   && $_pow2(42) == 4398046511104
   && $_pow2(43) == 8796093022208
   && $_pow2(44) == 17592186044416
   && $_pow2(45) == 35184372088832
   && $_pow2(46) == 70368744177664
   && $_pow2(47) == 140737488355328
   && $_pow2(48) == 281474976710656
   && $_pow2(49) == 562949953421312
   && $_pow2(50) == 1125899906842624
   && $_pow2(51) == 2251799813685248
   && $_pow2(52) == 4503599627370496
   && $_pow2(53) == 9007199254740992
   && $_pow2(54) == 18014398509481984
   && $_pow2(55) == 36028797018963968
   && $_pow2(56) == 72057594037927936
   && $_pow2(57) == 144115188075855872
   && $_pow2(58) == 288230376151711744
   && $_pow2(59) == 576460752303423488
   && $_pow2(60) == 1152921504606846976
   && $_pow2(61) == 2305843009213693952
   && $_pow2(62) == 4611686018427387904
   && $_pow2(63) == 9223372036854775808
   && $_pow2(64) == 18446744073709551616;

axiom $unchecked(^^u4, -1) == $max.u4;

axiom $unchecked(^^u4, $max.u4 + 1) == 0;

axiom $unchecked(^^u8, -1) == $max.u8;

axiom $unchecked(^^u8, $max.u8 + 1) == 0;

function $in_range_ubits(bits: int, v: int) : bool;

axiom (forall bits: int, v: int :: 
  { $in_range_ubits(bits, v): bool } 
  $in_range_ubits(bits, v): bool <==> $in_range(0, v, $_pow2(bits) - 1));

function $unchecked_sbits(bits: int, v: int) : int;

axiom (forall bits: int, v: int :: 
  { $unchecked_sbits(bits, v) } 
  $in_range_sbits(bits, $unchecked_sbits(bits, v))
     && ($in_range_sbits(bits, v) ==> $unchecked_sbits(bits, v) == v));

function $in_range_sbits(bits: int, v: int) : bool;

axiom (forall bits: int, v: int :: 
  { $in_range_sbits(bits, v): bool } 
  $in_range_sbits(bits, v): bool
     <==> $in_range(-$_pow2(bits - 1), v, $_pow2(bits - 1) - 1));

function $unchecked_ubits(bits: int, v: int) : int;

axiom (forall bits: int, v: int :: 
  { $unchecked_ubits(bits, v) } 
  $in_range_ubits(bits, $unchecked_ubits(bits, v))
     && ($in_range_ubits(bits, v) ==> $unchecked_ubits(bits, v) == v));

function $_or(t: $ctype, x: int, y: int) : int;

function $_xor(t: $ctype, x: int, y: int) : int;

function $_and(t: $ctype, x: int, y: int) : int;

function $_not(t: $ctype, x: int) : int;

function $abs(x: int) : int;

axiom (forall x: int :: { $abs(x): int } $abs(x): int == (if x < 0 then -x else x));

function $unchk_add(t: $ctype, x: int, y: int) : int;

axiom (forall t: $ctype, x: int, y: int :: 
  { $unchk_add(t, x, y): int } 
  $unchk_add(t, x, y): int == $unchecked(t, x + y));

function $unchk_sub(t: $ctype, x: int, y: int) : int;

axiom (forall t: $ctype, x: int, y: int :: 
  { $unchk_sub(t, x, y): int } 
  $unchk_sub(t, x, y): int == $unchecked(t, x - y));

function $unchk_mul(t: $ctype, x: int, y: int) : int;

axiom (forall t: $ctype, x: int, y: int :: 
  { $unchk_mul(t, x, y): int } 
  $unchk_mul(t, x, y): int == $unchecked(t, x * y));

function $unchk_div(t: $ctype, x: int, y: int) : int;

axiom (forall t: $ctype, x: int, y: int :: 
  { $unchk_div(t, x, y): int } 
  $unchk_div(t, x, y): int == $unchecked(t, x div y));

function $unchk_mod(t: $ctype, x: int, y: int) : int;

axiom (forall t: $ctype, x: int, y: int :: 
  { $unchk_mod(t, x, y): int } 
  $unchk_mod(t, x, y): int == $unchecked(t, x mod y));

axiom (forall x: int, y: int :: 
  { $unchk_add(^^u8, x, y) } 
  $in_range_u8(x) && $in_range_u8(y) && x + y > $max.u8
     ==> $unchk_add(^^u8, x, y) == x + y - $max.u8 - 1);

axiom (forall x: int, y: int :: 
  { $unchk_add(^^u4, x, y) } 
  $in_range_u4(x) && $in_range_u4(y) && x + y > $max.u8
     ==> $unchk_add(^^u4, x, y) == x + y - $max.u4 - 1);

function $_shl(t: $ctype, x: int, y: int) : int;

axiom (forall t: $ctype, x: int, y: int :: 
  { $_shl(t, x, y): int } 
  $_shl(t, x, y): int == $unchecked(t, x * $_pow2(y)));

function $_shr(x: int, y: int) : int;

axiom (forall x: int, y: int :: 
  { $_shr(x, y): int } 
  $_shr(x, y): int == x div $_pow2(y));

function $bv_extract_signed(val: int, val_bitsize: int, from: int, to: int) : int;

function $bv_extract_unsigned(val: int, val_bitsize: int, from: int, to: int) : int;

function $bv_update(val: int, val_bitsize: int, from: int, to: int, repl: int) : int;

axiom (forall x: int, from: int, to: int, xs: int, val: int :: 
  { $bv_update(x, xs, from, to, val) } 
  0 <= from && from < to && to <= xs
     ==> 
    0 <= val && val < $_pow2(to - from)
     ==> 0 <= $bv_update(x, xs, from, to, val)
       && $bv_update(x, xs, from, to, val) < $_pow2(xs));

axiom (forall from: int, to: int, xs: int :: 
  { $bv_update(0, xs, from, to, 0) } 
  0 <= from && from < to && to <= xs ==> $bv_update(0, xs, from, to, 0) == 0);

axiom (forall from: int, to: int, val: int, x: int, xs: int :: 
  { $bv_extract_signed($bv_update(x, xs, from, to, val), xs, from, to) } 
  0 <= from && from < to && to <= xs
     ==> 
    -$_pow2(to - from - 1) <= val && val < $_pow2(to - from - 1)
     ==> $bv_extract_signed($bv_update(x, xs, from, to, val), xs, from, to) == val);

axiom (forall from: int, to: int, val: int, x: int, xs: int :: 
  { $bv_extract_unsigned($bv_update(x, xs, from, to, val), xs, from, to) } 
  0 <= from && from < to && to <= xs
     ==> 
    0 <= val && val < $_pow2(to - from)
     ==> $bv_extract_unsigned($bv_update(x, xs, from, to, val), xs, from, to) == val);

axiom (forall from: int, to: int, x: int, xs: int :: 
  { $bv_extract_signed(x, xs, from, to) } 
  0 <= from && from < to && to <= xs
     ==> $in_range(-$_pow2(to - from - 1), 
      $bv_extract_signed(x, xs, from, to), 
      $_pow2(to - from - 1) - 1));

axiom (forall from: int, to: int, x: int, xs: int :: 
  { $bv_extract_unsigned(x, xs, from, to) } 
  0 <= from && from < to && to <= xs
     ==> $in_range(0, $bv_extract_unsigned(x, xs, from, to), $_pow2(to - from) - 1));

axiom (forall from: int, to: int, x: int, y: int :: 
  { $bv_extract_unsigned(x, 32, from, to), $_and(^^u4, x, y) } 
  0 <= from && from < to && to <= 32
     ==> $bv_extract_unsigned(x, 32, from, to)
       == $_shr($_and(^^u4, x, $_shl(^^u4, $_shl(^^u4, 1, to - from) - 1, from)), from));

axiom (forall from: int, to: int, x: int, y: int :: 
  { $bv_extract_unsigned(x, 64, from, to), $_and(^^u8, x, y) } 
  0 <= from && from < to && to <= 64
     ==> $bv_extract_unsigned(x, 64, from, to)
       == $_shr($_and(^^u8, x, $_shl(^^u4, $_shl(^^u8, 1, to - from) - 1, from)), from));

axiom (forall from: int, to: int, val: int, x: int, xs: int, from2: int, to2: int :: 
  { $bv_extract_signed($bv_update(x, xs, from, to, val), xs, from2, to2) } 
  0 <= from && from < to && to <= xs
     ==> 
    0 <= from2 && from2 < to2 && to2 <= xs
     ==> 
    to2 <= from || to <= from2
     ==> $bv_extract_signed($bv_update(x, xs, from, to, val), xs, from2, to2)
       == $bv_extract_signed(x, xs, from2, to2));

axiom (forall from: int, to: int, val: int, x: int, xs: int, from2: int, to2: int :: 
  { $bv_extract_unsigned($bv_update(x, xs, from, to, val), xs, from2, to2) } 
  0 <= from && from < to && to <= xs
     ==> 
    0 <= from2 && from2 < to2 && to2 <= xs
     ==> 
    to2 <= from || to <= from2
     ==> $bv_extract_unsigned($bv_update(x, xs, from, to, val), xs, from2, to2)
       == $bv_extract_unsigned(x, xs, from2, to2));

axiom (forall from: int, to: int, xs: int :: 
  { $bv_extract_signed(0, xs, from, to) } 
  0 <= from && from < to && to <= xs ==> $bv_extract_signed(0, xs, from, to) == 0);

axiom (forall from: int, to: int, xs: int :: 
  { $bv_extract_unsigned(0, xs, from, to) } 
  0 <= from && from < to && to <= xs
     ==> $bv_extract_unsigned(0, xs, from, to) == 0);

axiom (forall from: int, to: int, val: int, xs: int :: 
  { $bv_extract_unsigned(val, xs, from, to) } 
  0 <= from && from < to && to <= xs && 0 <= val
     ==> $bv_extract_unsigned(val, xs, from, to)
       == val div $_pow2(from) mod $_pow2(to - from));

axiom (forall from: int, to: int, val: int, xs: int :: 
  { $bv_extract_signed(val, xs, from, to) } 
  0 <= from
       && from < to
       && to <= xs
       && 0 <= val
       && val div $_pow2(from) mod $_pow2(to - from) < $_pow2(to - from - 1)
     ==> $bv_extract_signed(val, xs, from, to)
       == val div $_pow2(from) mod $_pow2(to - from));

axiom (forall from: int, to: int, val: int, xs: int :: 
  { $bv_extract_signed(val, xs, from, to) } 
  0 <= from
       && from < to
       && to <= xs
       && 0 <= val
       && val div $_pow2(from) mod $_pow2(to - from) >= $_pow2(to - from - 1)
     ==> $bv_extract_signed(val, xs, from, to)
       == $_pow2(to - from - 1) - val div $_pow2(from) mod $_pow2(to - from));

function $unchecked(t: $ctype, val: int) : int;

function $in_range_t(t: $ctype, x: int) : bool;

axiom (forall val: int :: 
  { $in_range_t(^^i1, val) } 
  $in_range_t(^^i1, val) <==> $in_range_i1(val));

axiom (forall val: int :: 
  { $in_range_t(^^i2, val) } 
  $in_range_t(^^i2, val) <==> $in_range_i2(val));

axiom (forall val: int :: 
  { $in_range_t(^^i4, val) } 
  $in_range_t(^^i4, val) <==> $in_range_i4(val));

axiom (forall val: int :: 
  { $in_range_t(^^i8, val) } 
  $in_range_t(^^i8, val) <==> $in_range_i8(val));

axiom (forall val: int :: 
  { $in_range_t(^^u1, val) } 
  $in_range_t(^^u1, val) <==> $in_range_u1(val));

axiom (forall val: int :: 
  { $in_range_t(^^u2, val) } 
  $in_range_t(^^u2, val) <==> $in_range_u2(val));

axiom (forall val: int :: 
  { $in_range_t(^^u4, val) } 
  $in_range_t(^^u4, val) <==> $in_range_u4(val));

axiom (forall val: int :: 
  { $in_range_t(^^u8, val) } 
  $in_range_t(^^u8, val) <==> $in_range_u8(val));

axiom (forall val: int :: { $in_range_t(^^mathint, val) } $in_range_t(^^mathint, val));

axiom (forall t: $ctype, val: int :: 
  { $unchecked(t, val) } 
  $in_range_t(t, val) ==> $unchecked(t, val) == val);

axiom (forall t: $ctype, val: int :: 
  { $unchecked(t, val) } 
  $in_range_t(t, $unchecked(t, val)));

axiom (forall val: int :: 
  { $unchecked(^^u1, $unchecked(^^i1, val)) } 
  $in_range_u1(val) ==> $unchecked(^^u1, $unchecked(^^i1, val)) == val);

axiom (forall val: int :: 
  { $unchecked(^^u2, $unchecked(^^i2, val)) } 
  $in_range_u2(val) ==> $unchecked(^^u2, $unchecked(^^i2, val)) == val);

axiom (forall val: int :: 
  { $unchecked(^^u4, $unchecked(^^i4, val)) } 
  $in_range_u4(val) ==> $unchecked(^^u4, $unchecked(^^i4, val)) == val);

axiom (forall val: int :: 
  { $unchecked(^^u8, $unchecked(^^i8, val)) } 
  $in_range_u8(val) ==> $unchecked(^^u8, $unchecked(^^i8, val)) == val);

axiom (forall val: int :: 
  { $unchecked(^^i1, $unchecked(^^u1, val)) } 
  $in_range_i1(val) ==> $unchecked(^^i1, $unchecked(^^u1, val)) == val);

axiom (forall val: int :: 
  { $unchecked(^^i2, $unchecked(^^u2, val)) } 
  $in_range_i2(val) ==> $unchecked(^^i2, $unchecked(^^u2, val)) == val);

axiom (forall val: int :: 
  { $unchecked(^^i4, $unchecked(^^u4, val)) } 
  $in_range_i4(val) ==> $unchecked(^^i4, $unchecked(^^u4, val)) == val);

axiom (forall val: int :: 
  { $unchecked(^^i8, $unchecked(^^u8, val)) } 
  $in_range_i8(val) ==> $unchecked(^^i8, $unchecked(^^u8, val)) == val);

axiom (forall t: $ctype, x: int, y: int, z: int :: 
  { x mod $_pow2(y), $_and(t, x, z) } 
  $in_range_t(t, x) && $in_range_t(t, $_pow2(y) - 1) && x >= 0
     ==> x mod $_pow2(y) == $_and(t, x, $_pow2(y) - 1));

axiom (forall i: int, j: int :: { i div j } 0 <= i && 0 < j ==> i div j <= i);

axiom (forall i: int, j: int :: 
  { i div j } 
  i > 0 && j > 0 ==> i - j < i div j * j && i div j * j <= i);

axiom (forall i: int :: { i div i } i != 0 ==> i div i == 1);

axiom (forall i: int :: { 0 div i } i != 0 ==> 0 div i == 0);

axiom (forall x: int, y: int :: { x mod y } { x div y } x mod y == x - x div y * y);

axiom (forall x: int, y: int :: 
  { x mod y } 
  0 <= x && 0 < y ==> 0 <= x mod y && x mod y < y);

axiom (forall x: int, y: int :: 
  { x mod y } 
  0 <= x && y < 0 ==> 0 <= x mod y && x mod y < 0 - y);

axiom (forall x: int, y: int :: 
  { x mod y } 
  x <= 0 && 0 < y ==> 0 - y < x mod y && x mod y <= 0);

axiom (forall x: int, y: int :: 
  { x mod y } 
  x <= 0 && y < 0 ==> y < x mod y && x mod y <= 0);

axiom (forall t: $ctype, x: int, y: int :: 
  { $_and(t, x, y) } 
  0 <= x && $in_range_t(t, x) ==> 0 <= $_and(t, x, y) && $_and(t, x, y) <= x);

axiom (forall t: $ctype, x: int, y: int :: 
  { $_and(t, x, y) } 
  0 <= x && 0 <= y && $in_range_t(t, x) && $in_range_t(t, y)
     ==> $_and(t, x, y) <= x && $_and(t, x, y) <= y);

axiom (forall t: $ctype, x: int, y: int :: 
  { $_or(t, x, y) } 
  0 <= x && 0 <= y && $in_range_t(t, x) && $in_range_t(t, y)
     ==> 0 <= $_or(t, x, y) && $_or(t, x, y) <= x + y);

axiom (forall t: $ctype, x: int, y: int :: 
  { $_or(t, x, y) } 
  0 <= x && 0 <= y && $in_range_t(t, x) && $in_range_t(t, y)
     ==> x <= $_or(t, x, y) && y <= $_or(t, x, y));

axiom (forall t: $ctype, x: int, y: int, z: int :: 
  { $_or(t, x, y), $_pow2(z) } 
  0 <= x
       && 0 <= y
       && 0 <= z
       && z < 64
       && x < $_pow2(z)
       && y < $_pow2(z)
       && $in_range_t(t, x)
       && $in_range_t(t, y)
     ==> $_or(t, x, y) < $_pow2(z));

axiom (forall t: $ctype, x: int, y: int :: 
  { $_or(t, x, y) } 
  $in_range_u1(x) && $in_range_u1(y) ==> $in_range_u1($_or(t, x, y)));

axiom (forall t: $ctype, x: int, y: int :: 
  { $_or(t, x, y) } 
  $in_range_u2(x) && $in_range_u2(y) ==> $in_range_u2($_or(t, x, y)));

axiom (forall t: $ctype, x: int, y: int :: 
  { $_or(t, x, y) } 
  $in_range_u4(x) && $in_range_u4(y) ==> $in_range_u4($_or(t, x, y)));

axiom (forall t: $ctype, x: int, y: int :: 
  { $_or(t, x, y) } 
  $in_range_u8(x) && $in_range_u8(y) ==> $in_range_u8($_or(t, x, y)));

axiom (forall t: $ctype, x: int, y: int :: 
  { $_and(t, x, y) } 
  $in_range_u1(x) && $in_range_u1(y) ==> $in_range_u1($_and(t, x, y)));

axiom (forall t: $ctype, x: int, y: int :: 
  { $_and(t, x, y) } 
  $in_range_u2(x) && $in_range_u2(y) ==> $in_range_u2($_and(t, x, y)));

axiom (forall t: $ctype, x: int, y: int :: 
  { $_and(t, x, y) } 
  $in_range_u4(x) && $in_range_u4(y) ==> $in_range_u4($_and(t, x, y)));

axiom (forall t: $ctype, x: int, y: int :: 
  { $_and(t, x, y) } 
  $in_range_u8(x) && $in_range_u8(y) ==> $in_range_u8($_and(t, x, y)));

axiom (forall t: $ctype, x: int, y: int :: 
  { $_xor(t, x, y) } 
  $in_range_u1(x) && $in_range_u1(y) ==> $in_range_u1($_xor(t, x, y)));

axiom (forall t: $ctype, x: int, y: int :: 
  { $_xor(t, x, y) } 
  $in_range_u2(x) && $in_range_u2(y) ==> $in_range_u2($_xor(t, x, y)));

axiom (forall t: $ctype, x: int, y: int :: 
  { $_xor(t, x, y) } 
  $in_range_u4(x) && $in_range_u4(y) ==> $in_range_u4($_xor(t, x, y)));

axiom (forall t: $ctype, x: int, y: int :: 
  { $_xor(t, x, y) } 
  $in_range_u8(x) && $in_range_u8(y) ==> $in_range_u8($_xor(t, x, y)));

axiom (forall t: $ctype, x: int :: { $_not(t, x) } $in_range_t(t, $_not(t, x)));

axiom (forall t: $ctype, x: int :: 
  { $_or(t, x, $_not(t, x)) } 
  $_or(t, x, $_not(t, x)) == $_not(t, 0));

axiom (forall t: $ctype, x: int :: 
  { $_and(t, x, $_not(t, x)) } 
  $_and(t, x, $_not(t, x)) == 0);

axiom (forall t: $ctype, x: int :: 
  { $_or(t, x, 0) } 
  $in_range_t(t, x) ==> $_or(t, x, 0) == x);

axiom (forall t: $ctype, x: int :: 
  { $_or(t, x, $_not(t, 0)) } 
  $_or(t, x, $_not(t, 0)) == $_not(t, 0));

axiom (forall t: $ctype, x: int :: 
  { $_or(t, x, x) } 
  $in_range_t(t, x) ==> $_or(t, x, x) == x);

axiom (forall t: $ctype, x: int :: { $_and(t, x, 0) } $_and(t, x, 0) == 0);

axiom (forall t: $ctype, x: int :: 
  { $_and(t, x, $_not(t, 0)) } 
  $in_range_t(t, x) ==> $_and(t, x, $_not(t, 0)) == x);

axiom (forall t: $ctype, x: int :: 
  { $_and(t, x, x) } 
  $in_range_t(t, x) ==> $_and(t, x, x) == x);

axiom (forall t: $ctype, x: int, y: int :: 
  { $_and(t, $_or(t, x, y), y) } 
  $_and(t, $_or(t, x, y), y) == y);

axiom (forall t: $ctype, x: int, y: int :: 
  { $_and(t, $_or(t, x, y), x) } 
  $_and(t, $_or(t, x, y), x) == x);

axiom (forall t: $ctype, x: int :: 
  { $_xor(t, x, 0) } 
  $in_range_t(t, x) ==> $_xor(t, x, 0) == x);

axiom (forall t: $ctype, x: int :: { $_xor(t, x, x) } $_xor(t, x, x) == 0);

axiom (forall t: $ctype, x: int :: 
  { $_xor(t, x, $_not(t, 0)) } 
  $_xor(t, x, $_not(t, 0)) == $_not(t, x));

axiom (forall t: $ctype, x: int :: 
  { $_not(t, $_not(t, x)) } 
  $in_range_t(t, x) ==> $_not(t, $_not(t, x)) == x);

axiom (forall t: $ctype, x: int, y: int :: 
  { $_or(t, x, y) } 
  $_or(t, x, y) == $_or(t, y, x));

axiom (forall t: $ctype, x: int, y: int :: 
  { $_xor(t, x, y) } 
  $_xor(t, x, y) == $_xor(t, y, x));

axiom (forall t: $ctype, x: int, y: int :: 
  { $_and(t, x, y) } 
  $_and(t, x, y) == $_and(t, y, x));

function $op_mul(x: int, y: int) : int;

axiom (forall x: int, y: int :: { $op_mul(x, y): int } $op_mul(x, y): int == x * y);

function $op_add(t: $ctype, x: int, y: int) : int;

axiom (forall t: $ctype, x: int, y: int :: 
  { $op_add(t, x, y): int } 
  $op_add(t, x, y): int == x + y);

function $op_sub(t: $ctype, x: int, y: int) : int;

axiom (forall t: $ctype, x: int, y: int :: 
  { $op_sub(t, x, y): int } 
  $op_sub(t, x, y): int == x - y);

function $op_div(t: $ctype, x: int, y: int) : int;

axiom (forall t: $ctype, x: int, y: int :: 
  { $op_div(t, x, y): int } 
  $op_div(t, x, y): int == x div y);

function $op_lt(t: $ctype, x: int, y: int) : bool;

axiom (forall t: $ctype, x: int, y: int :: 
  { $op_lt(t, x, y): bool } 
  $op_lt(t, x, y): bool <==> x < y);

function $op_le(t: $ctype, x: int, y: int) : bool;

axiom (forall t: $ctype, x: int, y: int :: 
  { $op_le(t, x, y): bool } 
  $op_le(t, x, y): bool <==> x <= y);

function $op_gt(t: $ctype, x: int, y: int) : bool;

axiom (forall t: $ctype, x: int, y: int :: 
  { $op_gt(t, x, y): bool } 
  $op_gt(t, x, y): bool <==> x > y);

function $op_ge(t: $ctype, x: int, y: int) : bool;

axiom (forall t: $ctype, x: int, y: int :: 
  { $op_ge(t, x, y): bool } 
  $op_ge(t, x, y): bool <==> x >= y);

function $ptr_to_int($ptr) : int;

function $int_to_ptr(int) : $ptr;

axiom (forall p: $ptr :: $int_to_ptr($ptr_to_int(p)) == p);

function $field_to_int($field) : int;

function $int_to_field(int) : $field;

axiom (forall p: $field :: $int_to_field($field_to_int(p)) == p);

function $ptrset_to_int($ptrset) : int;

function $int_to_ptrset(int) : $ptrset;

axiom (forall p: $ptrset :: $int_to_ptrset($ptrset_to_int(p)) == p);

function $ptr_to_u8($ptr) : int;

function $ptr_to_i8($ptr) : int;

function $ptr_to_u4($ptr) : int;

function $ptr_to_i4($ptr) : int;

function $ptr_to_u2($ptr) : int;

function $ptr_to_i2($ptr) : int;

function $ptr_to_u1($ptr) : int;

function $ptr_to_i1($ptr) : int;

function $u8_to_ptr(x: int) : $ptr;

function $i8_to_ptr(x: int) : $ptr;

function $u4_to_ptr(x: int) : $ptr;

function $i4_to_ptr(x: int) : $ptr;

function $u2_to_ptr(x: int) : $ptr;

function $i2_to_ptr(x: int) : $ptr;

function $u1_to_ptr(x: int) : $ptr;

function $i1_to_ptr(x: int) : $ptr;

axiom $arch_ptr_size >= 8
   ==> (forall k: int :: { $u8_to_ptr(k) } $addr($u8_to_ptr(k)) == k);

axiom (forall k: int :: { $u4_to_ptr(k) } $addr($u4_to_ptr(k)) == k);

axiom (forall k: int :: { $u2_to_ptr(k) } $addr($u2_to_ptr(k)) == k);

axiom (forall k: int :: { $u1_to_ptr(k) } $addr($u1_to_ptr(k)) == k);

axiom $arch_ptr_size >= 8
   ==> (forall k: int :: { $i8_to_ptr(k) } k >= 0 ==> $addr($i8_to_ptr(k)) == k);

axiom (forall k: int :: { $i4_to_ptr(k) } k >= 0 ==> $addr($i4_to_ptr(k)) == k);

axiom (forall k: int :: { $i2_to_ptr(k) } k >= 0 ==> $addr($i2_to_ptr(k)) == k);

axiom (forall k: int :: { $i1_to_ptr(k) } k >= 0 ==> $addr($i1_to_ptr(k)) == k);

axiom (forall p: $ptr :: 
  { $ptr_to_u8(p) } 
  $in_range_u8($addr(p)) ==> $ptr_to_u8(p) == $addr(p));

axiom (forall p: $ptr :: 
  { $ptr_to_i8(p) } 
  $in_range_i8($addr(p)) ==> $ptr_to_i8(p) == $addr(p));

axiom (forall p: $ptr :: 
  { $ptr_to_u4(p) } 
  $in_range_u4($addr(p)) ==> $ptr_to_u4(p) == $addr(p));

axiom (forall p: $ptr :: 
  { $ptr_to_i4(p) } 
  $in_range_i4($addr(p)) ==> $ptr_to_i4(p) == $addr(p));

axiom (forall p: $ptr :: 
  { $ptr_to_u2(p) } 
  $in_range_u2($addr(p)) ==> $ptr_to_u2(p) == $addr(p));

axiom (forall p: $ptr :: 
  { $ptr_to_i2(p) } 
  $in_range_i2($addr(p)) ==> $ptr_to_i2(p) == $addr(p));

axiom (forall p: $ptr :: 
  { $ptr_to_u1(p) } 
  $in_range_u1($addr(p)) ==> $ptr_to_u1(p) == $addr(p));

axiom (forall p: $ptr :: 
  { $ptr_to_i1(p) } 
  $in_range_i1($addr(p)) ==> $ptr_to_i1(p) == $addr(p));

function $add_f4(x: $primitive, y: $primitive) : $primitive;

function $sub_f4(x: $primitive, y: $primitive) : $primitive;

function $mul_f4(x: $primitive, y: $primitive) : $primitive;

function $div_f4(x: $primitive, y: $primitive) : $primitive;

function $neg_f4(x: $primitive) : $primitive;

function $lt_f4(x: $primitive, y: $primitive) : bool;

function $leq_f4(x: $primitive, y: $primitive) : bool;

function $gt_f4(x: $primitive, y: $primitive) : bool;

function $geq_f4(x: $primitive, y: $primitive) : bool;

function $add_f8(x: $primitive, y: $primitive) : $primitive;

function $sub_f8(x: $primitive, y: $primitive) : $primitive;

function $mul_f8(x: $primitive, y: $primitive) : $primitive;

function $div_f8(x: $primitive, y: $primitive) : $primitive;

function $neg_f8(x: $primitive) : $primitive;

function $lt_f8(x: $primitive, y: $primitive) : bool;

function $leq_f8(x: $primitive, y: $primitive) : bool;

function $gt_f8(x: $primitive, y: $primitive) : bool;

function $geq_f8(x: $primitive, y: $primitive) : bool;

type cf_event;

type var_locglob;

const unique conditional_moment: cf_event;

const unique took_then_branch: cf_event;

const unique took_else_branch: cf_event;

const unique loop_register: cf_event;

const unique loop_entered: cf_event;

const unique loop_exited: cf_event;

const unique cev_local: var_locglob;

const unique cev_global: var_locglob;

const unique cev_parameter: var_locglob;

const unique cev_implicit: var_locglob;

function #cev_init(n: int) : bool;

function #cev_save_position(n: int) : $token;

function #cev_var_intro(n: int, locorglob: var_locglob, name: $token, val: int, typ: $ctype) : bool;

function #cev_var_update(n: int, locorglob: var_locglob, name: $token, val: int) : bool;

function #cev_control_flow_event(n: int, tag: cf_event) : bool;

function #cev_function_call(n: int) : bool;

var $cev_pc: int;

procedure $cev_step(pos: $token);
  modifies $cev_pc;
  ensures #cev_save_position(old($cev_pc)) == pos;
  ensures $cev_pc == old($cev_pc) + 1;



procedure $cev_pre_loop(pos: $token) returns (oldPC: int);
  modifies $cev_pc;
  ensures #cev_control_flow_event(old($cev_pc), conditional_moment);
  ensures #cev_save_position(old($cev_pc)) == pos;
  ensures oldPC == old($cev_pc) && $cev_pc == old($cev_pc) + 1;



function $local_value_is(S1: $state, pos: $token, local_name: $token, val: int, t: $ctype) : bool;

function $local_value_is_ptr(S1: $state, pos: $token, local_name: $token, val: $ptr, t: $ctype) : bool;

function $read_ptr_m(S: $state, p: $ptr, t: $ctype) : $ptr;

function $type_code_is(x: int, tp: $ctype) : bool;

function $function_arg_type(fnname: $pure_function, idx: int, tp: $ctype) : bool;

function {:inline} $int_lt_or(called: int, caller: int, otherwise: bool) : bool
{
  (0 <= caller && called < caller) || (called == caller && otherwise)
}

const $decreases_level: int;

function $yarra_heap(s: $state) : $state;

function $get_string_literal(id: int, length: int) : $ptr;

axiom (forall S: $state, id: int, length: int :: 
  { $good_state(S), $get_string_literal(id, length) } 
  $good_state(S)
     ==> $in_range_phys_ptr($get_string_literal(id, length))
       && $is_thread_local_array(S, $get_string_literal(id, length), ^^i1, length + 1));

axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

const unique ^Node: $ctype;

axiom $is_span_sequential(^Node);

axiom $def_struct_type(^Node, 40, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: 
  { $inv2(#s1, #s2, #p, ^Node) } 
  $inv2(#s1, #s2, #p, ^Node) <==> $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall p: $ptr, q: $ptr, s: $state :: 
  { $in(q, $composite_extent(s, p, ^Node)) } 
  $in(q, $composite_extent(s, p, ^Node)) <==> q == p);

const unique Node.red: $field;

axiom $def_phys_field(^Node, Node.red, ^^bool, false, 0);

const unique Node.key: $field;

axiom $def_phys_field(^Node, Node.key, ^^i4, false, 4);

const unique Node.value: $field;

axiom $def_phys_field(^Node, Node.value, ^^i4, false, 8);

const unique Node.left: $field;

axiom $def_phys_field(^Node, Node.left, $ptr_to(^Node), false, 16);

const unique Node.right: $field;

axiom $def_phys_field(^Node, Node.right, $ptr_to(^Node), false, 24);

const unique Node.parent: $field;

axiom $def_phys_field(^Node, Node.parent, $ptr_to(^Node), false, 32);

const unique ^Tree: $ctype;

axiom $is_span_sequential(^Tree);

axiom $def_struct_type(^Tree, 8, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: 
  { $inv2(#s1, #s2, #p, ^Tree) } 
  $inv2(#s1, #s2, #p, ^Tree)
     <==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
          $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), 
        $phys_ptr_cast($null, ^Node))
       && ($non_null($rd_phys_ptr(#s2, Tree.root, #p, ^Node))
         ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
            $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), 
          $rd_phys_ptr(#s2, Tree.root, #p, ^Node)))
       && ($non_null($rd_phys_ptr(#s2, Tree.root, #p, ^Node))
         ==> $is_null($rd_phys_ptr(#s2, Node.parent, $rd_phys_ptr(#s2, Tree.root, #p, ^Node), ^Node)))
       && (forall Q#m$1^82.29#dt1: $ptr :: 
        {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $phys_ptr_cast($null, ^Node)), 
            $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
        !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
            $phys_ptr_cast($null, ^Node)), 
          $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)))
       && (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
        {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $rd_phys_ptr(#s2, 
                Node.left, 
                $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
                ^Node)), 
            $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
        $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), 
            $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
           ==> 
          $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $rd_phys_ptr(#s2, 
                Node.left, 
                $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
                ^Node)), 
            $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
           ==> $rd_inv(#s2, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
             < $rd_inv(#s2, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)))
       && (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
        {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $rd_phys_ptr(#s2, 
                Node.right, 
                $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
                ^Node)), 
            $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
        $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), 
            $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
           ==> 
          $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $rd_phys_ptr(#s2, 
                Node.right, 
                $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
                ^Node)), 
            $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
           ==> $rd_inv(#s2, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
             > $rd_inv(#s2, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)))
       && (forall Q#m$1^82.29#dt1: $ptr :: 
        {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), 
            $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
          { F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
          { sk_hack(F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))) } 
        $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), 
            $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
           <==> $set_in($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node), $owns(#s2, #p)))
       && (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
        {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
            $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
        $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
            $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
           ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), 
            $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)))
       && (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
        {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
            $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
        $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
            $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
           ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), 
            $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)))
       && (forall Q#n$1^82.29#dt1: $ptr :: 
        {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
        $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
                $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), 
              $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
             && $non_null($rd_phys_ptr(#s2, 
                Node.left, 
                $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
                ^Node))
           ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
            $rd_phys_ptr(#s2, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)))
       && (forall Q#n$1^82.29#dt1: $ptr :: 
        {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
        $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
                $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), 
              $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
             && $non_null($rd_phys_ptr(#s2, 
                Node.left, 
                $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
                ^Node))
           ==> $rd_phys_ptr(#s2, 
              Node.parent, 
              $rd_phys_ptr(#s2, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
              ^Node)
             == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && (forall Q#n$1^82.29#dt1: $ptr :: 
        {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
        $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
                $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), 
              $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
             && $non_null($rd_phys_ptr(#s2, 
                Node.right, 
                $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
                ^Node))
           ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
            $rd_phys_ptr(#s2, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)))
       && (forall Q#n$1^82.29#dt1: $ptr :: 
        {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
        $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
                $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), 
              $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
             && $non_null($rd_phys_ptr(#s2, 
                Node.right, 
                $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
                ^Node))
           ==> $rd_phys_ptr(#s2, 
              Node.parent, 
              $rd_phys_ptr(#s2, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
              ^Node)
             == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && (forall Q#n$1^82.29#dt1: $ptr :: 
        {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
        $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
                $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), 
              $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
             && $non_null($rd_phys_ptr(#s2, 
                Node.parent, 
                $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
                ^Node))
           ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), 
            $rd_phys_ptr(#s2, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)))
       && (forall Q#n$1^82.29#dt1: $ptr :: 
        {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
        $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
                $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), 
              $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
             && $non_null($rd_phys_ptr(#s2, 
                Node.parent, 
                $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
                ^Node))
           ==> $rd_phys_ptr(#s2, 
                Node.left, 
                $rd_phys_ptr(#s2, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
                ^Node)
               == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)
             || $rd_phys_ptr(#s2, 
                Node.right, 
                $rd_phys_ptr(#s2, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
                ^Node)
               == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && (forall Q#n$1^82.29#dt1: $ptr :: 
        {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), 
            $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) } 
        $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), 
            $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
           ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
            $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)))
       && (forall Q#m$1^83.29#dt1: $ptr :: 
        {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv(#s2, Tree.abs, #p)), 
            $rd_inv(#s2, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) } 
        $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), 
            $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))
           ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv(#s2, Tree.abs, #p)), 
              $rd_inv(#s2, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)))
             == $rd_inv(#s2, Node.value, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)))
       && (forall Q#k$1^83.29#tc2: int :: 
        {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv(#s2, Tree.abs, #p)), Q#k$1^83.29#tc2) } 
        $in_range_i4(Q#k$1^83.29#tc2)
           ==> 
          (forall Q#m$1^83.29#dt1: $ptr :: 
            {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
                  $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), 
                $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) } 
            $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
                  $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), 
                $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))
               ==> $rd_inv(#s2, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))
                 != Q#k$1^83.29#tc2)
           ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv(#s2, Tree.abs, #p)), Q#k$1^83.29#tc2)
             == 0)
       && (forall Q#n$1^84.29#dt1: $ptr :: 
        {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node) } 
        $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
                $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), 
              $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node))
             && $is_null($rd_phys_ptr(#s2, 
                Node.parent, 
                $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node), 
                ^Node))
           ==> $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)
             || $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)
               == $rd_phys_ptr(#s2, Tree.root, #p, ^Node))
       && (forall Q#n$1^84.29#dt1: $ptr, Q#m$1^84.29#dt1: $ptr :: 
        {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), 
            $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) } 
        $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
              $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), 
            $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node))
           <==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
                $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), 
              $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node))
             && (
              ($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)
                 && $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node))
               || $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)
               || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
                  $rd_phys_ptr(#s2, Node.left, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), 
                $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node))
               || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), 
                  $rd_phys_ptr(#s2, Node.right, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), 
                $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)))));

axiom (forall p: $ptr, q: $ptr, s: $state :: 
  { $in(q, $composite_extent(s, p, ^Tree)) } 
  $in(q, $composite_extent(s, p, ^Tree)) <==> q == p);

const unique Tree.root: $field;

axiom $def_phys_field(^Tree, Tree.root, $ptr_to(^Node), false, 0);

const unique Tree.abs: $field;

axiom $def_ghost_field(^Tree, Tree.abs, $map_t(^^i4, ^^i4), false);

const unique Tree.R: $field;

axiom $def_ghost_field(^Tree, Tree.R, $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)), false);

procedure Tree#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check()
   ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
      $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
    $phys_ptr_cast($null, ^Node));
  ensures $is_admissibility_check()
   ==> 
  $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node))
   ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
      $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
    $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node));
  ensures $is_admissibility_check()
   ==> 
  $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node))
   ==> $is_null($rd_phys_ptr($s, 
      Node.parent, 
      $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node), 
      ^Node));
  ensures $is_admissibility_check()
   ==> (forall Q#m$1^82.29#dt1: $ptr :: 
    {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $phys_ptr_cast($null, ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
    !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
        $phys_ptr_cast($null, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
  ensures $is_admissibility_check()
   ==> (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
    {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, 
            Node.left, 
            $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
            ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       ==> 
      $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, 
            Node.left, 
            $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
            ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
       ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
         < $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
  ensures $is_admissibility_check()
   ==> (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
    {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, 
            Node.right, 
            $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
            ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       ==> 
      $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, 
            Node.right, 
            $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
            ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
       ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
         > $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
  ensures $is_admissibility_check()
   ==> (forall Q#m$1^82.29#dt1: $ptr :: 
    {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
      { F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
      { sk_hack(F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
       <==> $set_in($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node), 
        $owns($s, $phys_ptr_cast(P#_this_, ^Tree))));
  ensures $is_admissibility_check()
   ==> (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
    {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
       ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
  ensures $is_admissibility_check()
   ==> (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
    {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
       ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
  ensures $is_admissibility_check()
   ==> (forall Q#n$1^82.29#dt1: $ptr :: 
    {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
         && $non_null($rd_phys_ptr($s, 
            Node.left, 
            $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
            ^Node))
       ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
        $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
  ensures $is_admissibility_check()
   ==> (forall Q#n$1^82.29#dt1: $ptr :: 
    {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
         && $non_null($rd_phys_ptr($s, 
            Node.left, 
            $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
            ^Node))
       ==> $rd_phys_ptr($s, 
          Node.parent, 
          $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
          ^Node)
         == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
  ensures $is_admissibility_check()
   ==> (forall Q#n$1^82.29#dt1: $ptr :: 
    {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
         && $non_null($rd_phys_ptr($s, 
            Node.right, 
            $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
            ^Node))
       ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
        $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
  ensures $is_admissibility_check()
   ==> (forall Q#n$1^82.29#dt1: $ptr :: 
    {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
         && $non_null($rd_phys_ptr($s, 
            Node.right, 
            $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
            ^Node))
       ==> $rd_phys_ptr($s, 
          Node.parent, 
          $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
          ^Node)
         == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
  ensures $is_admissibility_check()
   ==> (forall Q#n$1^82.29#dt1: $ptr :: 
    {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
         && $non_null($rd_phys_ptr($s, 
            Node.parent, 
            $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
            ^Node))
       ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
        $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
  ensures $is_admissibility_check()
   ==> (forall Q#n$1^82.29#dt1: $ptr :: 
    {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
         && $non_null($rd_phys_ptr($s, 
            Node.parent, 
            $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
            ^Node))
       ==> $rd_phys_ptr($s, 
            Node.left, 
            $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
            ^Node)
           == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)
         || $rd_phys_ptr($s, 
            Node.right, 
            $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
            ^Node)
           == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
  ensures $is_admissibility_check()
   ==> (forall Q#n$1^82.29#dt1: $ptr :: 
    {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
  ensures $is_admissibility_check() ==> true;
  ensures $is_admissibility_check()
   ==> (forall Q#m$1^83.29#dt1: $ptr :: 
    {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#_this_, ^Tree))), 
        $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))
       ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)))
         == $rd_inv($s, Node.value, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)));
  ensures $is_admissibility_check()
   ==> (forall Q#k$1^83.29#tc2: int :: 
    {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#_this_, ^Tree))), 
        Q#k$1^83.29#tc2) } 
    $in_range_i4(Q#k$1^83.29#tc2)
       ==> 
      (forall Q#m$1^83.29#dt1: $ptr :: 
        {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
              $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
            $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) } 
        $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
              $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
            $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))
           ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) != Q#k$1^83.29#tc2)
       ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#_this_, ^Tree))), 
          Q#k$1^83.29#tc2)
         == 0);
  ensures $is_admissibility_check()
   ==> (forall Q#n$1^84.29#dt1: $ptr :: 
    {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node))
         && $is_null($rd_phys_ptr($s, 
            Node.parent, 
            $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node), 
            ^Node))
       ==> $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)
         || $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)
           == $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node));
  ensures $is_admissibility_check()
   ==> (forall Q#n$1^84.29#dt1: $ptr, Q#m$1^84.29#dt1: $ptr :: 
    {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), 
        $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), 
        $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node))
       <==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node))
         && (
          ($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)
             && $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node))
           || $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)
           || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
              $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), 
            $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node))
           || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
              $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), 
            $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node))));
  ensures $is_unwrap_check()
   ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
      $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
    $phys_ptr_cast($null, ^Node));
  ensures $is_unwrap_check()
   ==> 
  $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node))
   ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
      $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
    $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node));
  ensures $is_unwrap_check()
   ==> 
  $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node))
   ==> $is_null($rd_phys_ptr($s, 
      Node.parent, 
      $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node), 
      ^Node));
  ensures $is_unwrap_check()
   ==> (forall Q#m$1^82.29#dt1: $ptr :: 
    {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $phys_ptr_cast($null, ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
    !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
        $phys_ptr_cast($null, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
  ensures $is_unwrap_check()
   ==> (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
    {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, 
            Node.left, 
            $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
            ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       ==> 
      $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, 
            Node.left, 
            $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
            ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
       ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
         < $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
  ensures $is_unwrap_check()
   ==> (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
    {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, 
            Node.right, 
            $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
            ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       ==> 
      $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, 
            Node.right, 
            $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
            ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
       ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
         > $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
  ensures $is_unwrap_check()
   ==> (forall Q#m$1^82.29#dt1: $ptr :: 
    {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
      { F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
      { sk_hack(F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
       <==> $set_in($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node), 
        $owns($s, $phys_ptr_cast(P#_this_, ^Tree))));
  ensures $is_unwrap_check()
   ==> (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
    {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
       ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
  ensures $is_unwrap_check()
   ==> (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
    {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
        $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
       ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
  ensures $is_unwrap_check()
   ==> (forall Q#n$1^82.29#dt1: $ptr :: 
    {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
         && $non_null($rd_phys_ptr($s, 
            Node.left, 
            $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
            ^Node))
       ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
        $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
  ensures $is_unwrap_check()
   ==> (forall Q#n$1^82.29#dt1: $ptr :: 
    {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
         && $non_null($rd_phys_ptr($s, 
            Node.left, 
            $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
            ^Node))
       ==> $rd_phys_ptr($s, 
          Node.parent, 
          $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
          ^Node)
         == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
  ensures $is_unwrap_check()
   ==> (forall Q#n$1^82.29#dt1: $ptr :: 
    {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
         && $non_null($rd_phys_ptr($s, 
            Node.right, 
            $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
            ^Node))
       ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
        $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
  ensures $is_unwrap_check()
   ==> (forall Q#n$1^82.29#dt1: $ptr :: 
    {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
         && $non_null($rd_phys_ptr($s, 
            Node.right, 
            $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
            ^Node))
       ==> $rd_phys_ptr($s, 
          Node.parent, 
          $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
          ^Node)
         == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
  ensures $is_unwrap_check()
   ==> (forall Q#n$1^82.29#dt1: $ptr :: 
    {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
         && $non_null($rd_phys_ptr($s, 
            Node.parent, 
            $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
            ^Node))
       ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
        $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
  ensures $is_unwrap_check()
   ==> (forall Q#n$1^82.29#dt1: $ptr :: 
    {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
         && $non_null($rd_phys_ptr($s, 
            Node.parent, 
            $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
            ^Node))
       ==> $rd_phys_ptr($s, 
            Node.left, 
            $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
            ^Node)
           == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)
         || $rd_phys_ptr($s, 
            Node.right, 
            $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
            ^Node)
           == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
  ensures $is_unwrap_check()
   ==> (forall Q#n$1^82.29#dt1: $ptr :: 
    {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
  ensures $is_unwrap_check() ==> true;
  ensures $is_unwrap_check()
   ==> (forall Q#m$1^83.29#dt1: $ptr :: 
    {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#_this_, ^Tree))), 
        $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))
       ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#_this_, ^Tree))), 
          $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)))
         == $rd_inv($s, Node.value, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)));
  ensures $is_unwrap_check()
   ==> (forall Q#k$1^83.29#tc2: int :: 
    {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#_this_, ^Tree))), 
        Q#k$1^83.29#tc2) } 
    $in_range_i4(Q#k$1^83.29#tc2)
       ==> 
      (forall Q#m$1^83.29#dt1: $ptr :: 
        {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
              $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
            $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) } 
        $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
              $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
            $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))
           ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) != Q#k$1^83.29#tc2)
       ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#_this_, ^Tree))), 
          Q#k$1^83.29#tc2)
         == 0);
  ensures $is_unwrap_check()
   ==> (forall Q#n$1^84.29#dt1: $ptr :: 
    {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node))
         && $is_null($rd_phys_ptr($s, 
            Node.parent, 
            $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node), 
            ^Node))
       ==> $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)
         || $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)
           == $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node));
  ensures $is_unwrap_check()
   ==> (forall Q#n$1^84.29#dt1: $ptr, Q#m$1^84.29#dt1: $ptr :: 
    {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), 
        $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), 
        $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node))
       <==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node))
         && (
          ($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)
             && $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node))
           || $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)
           || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
              $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), 
            $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node))
           || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), 
              $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), 
            $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node))));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Tree#adm(P#_this_: $ptr)
{
  var #wrTime$1^77.31: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^77.31, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^77.31, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^Tree));
    assume #wrTime$1^77.31 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^77.31, (lambda #p: $ptr :: false));
    assume 2147483647 == $decreases_level;
    assume $admissibility_start($phys_ptr_cast(P#_this_, ^Tree), ^Tree);
    assume true;
    if ($is_unwrap_check())
    {
      anon1:
        assume !$is_stuttering_check();
        assume $unwrap_check_pre($s, $phys_ptr_cast(P#_this_, ^Tree));
        call $unwrap_check($phys_ptr_cast(P#_this_, ^Tree));
        /*** desugaring:
        {
          var call0formal#AT#o: $ptr;
          var call1old#AT#$s: $state;
          call0formal#AT#o := $phys_ptr_cast(P#_this_, ^Tree);
          assert $good_for_pre_can_unwrap($s);
          call1old#AT#$s := $s;
          havoc $s;
          assume $good_state($s);
          assume $good_for_post_can_unwrap($s);
          assume $spans_the_same(call1old#AT#$s, $s, call0formal#AT#o, $typ(call0formal#AT#o));
          assume $is_unwrapped(call1old#AT#$s, $s, call0formal#AT#o);
        }
        **** end desugaring */
        assume $good_state_ext(#tok$1^77.31, $s);
        assert true;
    }
    else
    {
      anon4:
        assume true;
        if ($is_admissibility_check())
        {
          anon2:
            assume $admissibility_pre($s, $phys_ptr_cast(P#_this_, ^Tree));
        }
        else
        {
          anon3:
            assume $stuttering_pre($s, $phys_ptr_cast(P#_this_, ^Tree));
        }

      anon5:
        call $havoc_others($phys_ptr_cast(P#_this_, ^Tree), ^Tree);
        /*** desugaring:
        {
          var call0formal#AT#p: $ptr;
          var call1formal#AT#t: $ctype;
          var call2old#AT#$s: $state;
          call0formal#AT#p := $phys_ptr_cast(P#_this_, ^Tree);
          call1formal#AT#t := ^Tree;
          assert $good_for_admissibility($s);
          call2old#AT#$s := $s;
          havoc $s;
          assume (if $is_stuttering_check()
   then $nonvolatile_spans_the_same(call2old#AT#$s, $s, call0formal#AT#p, call1formal#AT#t)
   else $owns(call2old#AT#$s, call0formal#AT#p) == $owns($s, call0formal#AT#p)
     && $spans_the_same(call2old#AT#$s, $s, call0formal#AT#p, call1formal#AT#t));
          assume $closed($s, call0formal#AT#p);
          assume $closed_is_transitive($s);
          assume $good_state($s);
          assume $good_for_post_admissibility($s);
          assume (forall q: $ptr :: 
  { $closed($s, q) } { $closed(call2old#AT#$s, q) } 
  $closed(call2old#AT#$s, q) || $closed($s, q)
     ==> ($spans_the_same(call2old#AT#$s, $s, q, $typ(q))
         && ($closed(call2old#AT#$s, q) <==> $closed($s, q)))
       || ($inv2(call2old#AT#$s, $s, q, $typ(q))
         && $nonvolatile_spans_the_same(call2old#AT#$s, $s, q, $typ(q))));
          assume (forall q: $ptr :: 
  { $set_in_pos(q, $owns(call2old#AT#$s, call0formal#AT#p)) } 
  $set_in(q, $owns(call2old#AT#$s, call0formal#AT#p))
     ==> $ref_cnt(call2old#AT#$s, q) == $ref_cnt($s, q));
          assume $timestamp_post(call2old#AT#$s, $s);
        }
        **** end desugaring */
        assume $good_state_ext(#tok$1^77.31, $s);
        assert true;
        assume $is_stuttering_check()
   ==> $inv2(old($s), $s, $phys_ptr_cast(P#_this_, ^Tree), ^Tree);
    }

  #exit:
}



function F#mark(SP#p: $ptr) : $ptr;

const unique cf#mark: $pure_function;

axiom (forall SP#p: $ptr :: 
  { F#mark(SP#p) } 
  $phys_ptr_cast(F#mark(SP#p), ^Node) == $phys_ptr_cast(SP#p, ^Node));

axiom $function_arg_type(cf#mark, 0, $ptr_to(^Node));

axiom $function_arg_type(cf#mark, 1, $ptr_to(^Node));

procedure mark(SP#p: $ptr) returns ($result: $ptr);
  free ensures true;
  ensures $phys_ptr_cast($result, ^Node) == $phys_ptr_cast(SP#p, ^Node);
  free ensures $result == F#mark(SP#p);
  free ensures $call_transition(old($s), $s);



function F#doMark(SP#p: $ptr) : bool;

const unique cf#doMark: $pure_function;

axiom (forall SP#p: $ptr :: 
  { F#doMark(SP#p) } 
  F#doMark(SP#p)
     <==> $phys_ptr_cast(F#mark($phys_ptr_cast(SP#p, ^Node)), ^Node)
       == $phys_ptr_cast(SP#p, ^Node));

axiom $function_arg_type(cf#doMark, 0, ^^bool);

axiom $function_arg_type(cf#doMark, 1, $ptr_to(^Node));

procedure doMark(SP#p: $ptr) returns ($result: bool);
  ensures $result
   <==> $phys_ptr_cast(F#mark($phys_ptr_cast(SP#p, ^Node)), ^Node)
     == $phys_ptr_cast(SP#p, ^Node);
  free ensures $result <==> F#doMark(SP#p);
  free ensures $call_transition(old($s), $s);



function F#mark2(SP#p: $ptr) : bool;

const unique cf#mark2: $pure_function;

axiom $function_arg_type(cf#mark2, 0, ^^bool);

axiom $function_arg_type(cf#mark2, 1, $ptr_to(^Node));

procedure mark2(SP#p: $ptr) returns ($result: bool);
  free ensures $result <==> F#mark2(SP#p);
  free ensures $call_transition(old($s), $s);



procedure tree_init(P#t: $ptr);
  modifies $s, $cev_pc;
  ensures $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: $set_in(#p, $span($phys_ptr_cast(P#t, ^Tree)))));
  free ensures $call_transition(old($s), $s);



implementation tree_init(P#t: $ptr)
{
  var prestate#23: $state;
  var res_lambda#3#16: $map_t..^^i4.^^i4;
  var res_lambda#1#15: $map_t..$ptr_to..^Node.^^bool;
  var res_lambda#2#14: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;
  var #wrTime$1^87.1: int;
  var #stackframe: int;

  anon7:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^87.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^87.1, #loc.t, $ptr_to_int(P#t), $ptr_to(^Tree));
    assume #wrTime$1^87.1 == $current_timestamp($s);
    assume $def_writes($s, 
  #wrTime$1^87.1, 
  (lambda #p: $ptr :: $set_in(#p, $span($phys_ptr_cast(P#t, ^Tree)))));
    assume $mutable($s, $phys_ptr_cast(P#t, ^Tree));
    assume true;
    assume 2147483647 == $decreases_level;
    assert $writable_prim($s, #wrTime$1^87.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.root));
    call $write_int(Tree.root, $phys_ptr_cast(P#t, ^Tree), $ptr_to_int($phys_ptr_cast($null, ^Node)));
    /*** desugaring:
    {
      var call0formal#AT#f: $field;
      var call1formal#AT#p: $ptr;
      var call2formal#AT#v: int;
      var call3old#AT#$s: $state;
      call0formal#AT#f := Tree.root;
      call1formal#AT#p := $phys_ptr_cast(P#t, ^Tree);
      call2formal#AT#v := $ptr_to_int($phys_ptr_cast($null, ^Node));
      call3old#AT#$s := $s;
      havoc $s;
      assume $specials_eq(call3old#AT#$s, $s);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
      assume $timestamp_post_strict(call3old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^91.3, $s);
    assume $local_value_is($s, 
  #tok$1^93.12, 
  #loc.res_lambda#2#14, 
  $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int(res_lambda#2#14), 
  $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assume $local_value_is($s, 
  #tok$1^93.12, 
  #loc.res_lambda#1#15, 
  $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#1#15), 
  $map_t($ptr_to(^Node), ^^bool));
    call res_lambda#1#15 := lambda#1();
    /*** desugaring:
    {
      var call0formal#AT#$result: $map_t..$ptr_to..^Node.^^bool;
      havoc call0formal#AT#$result;
      assume call0formal#AT#$result == F#lambda#1();
      assume $call_transition($s, $s);
      res_lambda#1#15 := call0formal#AT#$result;
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^93.12, $s);
    assume $local_value_is($s, 
  #tok$1^93.12, 
  #loc.res_lambda#1#15, 
  $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#1#15), 
  $map_t($ptr_to(^Node), ^^bool));
    call res_lambda#2#14 := lambda#2(res_lambda#1#15);
    /*** desugaring:
    {
      var call0formal#AT##l0: $map_t..$ptr_to..^Node.^^bool;
      var call1formal#AT#$result: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;
      call0formal#AT##l0 := res_lambda#1#15;
      havoc call1formal#AT#$result;
      assume call1formal#AT#$result == F#lambda#2(call0formal#AT##l0);
      assume $call_transition($s, $s);
      res_lambda#2#14 := call1formal#AT#$result;
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^93.12, $s);
    assume $local_value_is($s, 
  #tok$1^93.12, 
  #loc.res_lambda#2#14, 
  $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int(res_lambda#2#14), 
  $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $writable_prim($s, #wrTime$1^87.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.R));
    call $write_int(Tree.R, $phys_ptr_cast(P#t, ^Tree), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int(res_lambda#2#14));
    /*** desugaring:
    {
      var call0formal#AT#f: $field;
      var call1formal#AT#p: $ptr;
      var call2formal#AT#v: int;
      var call3old#AT#$s: $state;
      call0formal#AT#f := Tree.R;
      call1formal#AT#p := $phys_ptr_cast(P#t, ^Tree);
      call2formal#AT#v := $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int(res_lambda#2#14);
      call3old#AT#$s := $s;
      havoc $s;
      assume $specials_eq(call3old#AT#$s, $s);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
      assume $timestamp_post_strict(call3old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^93.5, $s);
    assume $local_value_is($s, 
  #tok$1^94.14, 
  #loc.res_lambda#3#16, 
  $map_t..^^i4.^^i4_to_int(res_lambda#3#16), 
  $map_t(^^i4, ^^i4));
    call res_lambda#3#16 := lambda#3();
    /*** desugaring:
    {
      var call0formal#AT#$result: $map_t..^^i4.^^i4;
      havoc call0formal#AT#$result;
      assume call0formal#AT#$result == F#lambda#3();
      assume $call_transition($s, $s);
      res_lambda#3#16 := call0formal#AT#$result;
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^94.14, $s);
    assume $local_value_is($s, 
  #tok$1^94.14, 
  #loc.res_lambda#3#16, 
  $map_t..^^i4.^^i4_to_int(res_lambda#3#16), 
  $map_t(^^i4, ^^i4));
    assert $writable_prim($s, #wrTime$1^87.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.abs));
    call $write_int(Tree.abs, $phys_ptr_cast(P#t, ^Tree), $map_t..^^i4.^^i4_to_int(res_lambda#3#16));
    /*** desugaring:
    {
      var call0formal#AT#f: $field;
      var call1formal#AT#p: $ptr;
      var call2formal#AT#v: int;
      var call3old#AT#$s: $state;
      call0formal#AT#f := Tree.abs;
      call1formal#AT#p := $phys_ptr_cast(P#t, ^Tree);
      call2formal#AT#v := $map_t..^^i4.^^i4_to_int(res_lambda#3#16);
      call3old#AT#$s := $s;
      havoc $s;
      assume $specials_eq(call3old#AT#$s, $s);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
      assume $timestamp_post_strict(call3old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^94.5, $s);
    assert (forall #writes$1^95.5: $ptr :: 
  { $dont_instantiate(#writes$1^95.5) } 
  $set_in(#writes$1^95.5, $span($phys_ptr_cast(P#t, ^Tree)))
     ==> $top_writable($s, #wrTime$1^87.1, #writes$1^95.5));
    call $set_owns($phys_ptr_cast(P#t, ^Tree), $set_empty());
    /*** desugaring:
    {
      var call0formal#AT#p: $ptr;
      var call1formal#AT#owns: $ptrset;
      var call2old#AT#$s: $state;
      call0formal#AT#p := $phys_ptr_cast(P#t, ^Tree);
      call1formal#AT#owns := $set_empty();
      assert $is_non_primitive($typ(call0formal#AT#p));
      assert $mutable($s, call0formal#AT#p);
      call2old#AT#$s := $s;
      havoc $s;
      assume $updated_owns(call2old#AT#$s, $s, call0formal#AT#p, call1formal#AT#owns);
      assume $specials_eq(call2old#AT#$s, $s);
      assume $timestamp_post_strict(call2old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^95.5, $s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#23, $state_to_int(prestate#23), ^$#state_t);
    prestate#23 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#23, $state_to_int(prestate#23), ^$#state_t);
    assume $pre_wrap($s);
    assert $top_writable($s, #wrTime$1^87.1, $phys_ptr_cast(P#t, ^Tree));
    assert (forall #writes$1^97.19: $ptr :: 
  { $dont_instantiate(#writes$1^97.19) } 
  $set_in(#writes$1^97.19, $owns($s, $phys_ptr_cast(P#t, ^Tree)))
     ==> $top_writable($s, #wrTime$1^87.1, #writes$1^97.19));
    call $wrap($phys_ptr_cast(P#t, ^Tree), ^Tree);
    /*** desugaring:
    {
      var call0formal#AT#o: $ptr;
      var call1formal#AT#T: $ctype;
      var call2old#AT#$s: $state;
      call0formal#AT#o := $phys_ptr_cast(P#t, ^Tree);
      call1formal#AT#T := ^Tree;
      assert $pre_wrap($s);
      assert $is_non_primitive($typ(call0formal#AT#o));
      assert $mutable($s, call0formal#AT#o);
      assert (forall p: $ptr :: 
  { $dont_instantiate(p) } 
  $set_in0(p, $owns($s, call0formal#AT#o)) ==> $wrapped($s, p, $typ(p)));
      call2old#AT#$s := $s;
      havoc $s;
      assume $is_wrapped_dynamic(call2old#AT#$s, $s, call0formal#AT#o);
    }
    **** end desugaring */
    assume $good_state_ext(#tok$1^97.19, $s);
    assert !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
  $phys_ptr_cast($null, ^Node));
    assert $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node))
   ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
      $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
    $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
    assert $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node))
   ==> $is_null($rd_phys_ptr($s, 
      Node.parent, 
      $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node), 
      ^Node));
    assert (forall Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast($null, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
      $phys_ptr_cast($null, ^Node)), 
    $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
     ==> 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
       < $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
     ==> 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
       > $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    assert (forall Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
    { F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
    { sk_hack(F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     <==> $set_in($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node), $owns($s, $phys_ptr_cast(P#t, ^Tree))));
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $rd_phys_ptr($s, 
        Node.parent, 
        $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
        ^Node)
       == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $rd_phys_ptr($s, 
        Node.parent, 
        $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
        ^Node)
       == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.parent, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.parent, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $rd_phys_ptr($s, 
          Node.left, 
          $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
          ^Node)
         == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)
       || $rd_phys_ptr($s, 
          Node.right, 
          $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
          ^Node)
         == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    assert true;
    assert (forall Q#m$1^83.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
      $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))
     ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)))
       == $rd_inv($s, Node.value, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)));
    assert (forall Q#k$1^83.29#tc2: int :: 
  {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
      Q#k$1^83.29#tc2) } 
  $in_range_i4(Q#k$1^83.29#tc2)
     ==> 
    (forall Q#m$1^83.29#dt1: $ptr :: 
      {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) } 
      $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))
         ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) != Q#k$1^83.29#tc2)
     ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
        Q#k$1^83.29#tc2)
       == 0);
    assert (forall Q#n$1^84.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node))
       && $is_null($rd_phys_ptr($s, 
          Node.parent, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)
       || $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)
         == $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
    assert (forall Q#n$1^84.29#dt1: $ptr, Q#m$1^84.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), 
      $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), 
      $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node))
     <==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node))
       && (
        ($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)
           && $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node))
         || $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)
         || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), 
          $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node))
         || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), 
          $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node))));
    assume $full_stop($s);
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure tree_find(P#t: $ptr, P#key: int) returns ($result: $ptr);
  requires $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
  modifies $s, $cev_pc;
  free ensures true;
  ensures $non_null($phys_ptr_cast($result, ^Node))
   ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast($result, ^Node))
     && $rd_inv($s, Node.key, $phys_ptr_cast($result, ^Node)) == P#key;
  ensures $is_null($phys_ptr_cast($result, ^Node))
   ==> (forall Q#n$1^104.53#dt1: $ptr :: 
    {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^104.53#dt1, ^Node)) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^104.53#dt1, ^Node))
       ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^104.53#dt1, ^Node)) != P#key);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation tree_find(P#t: $ptr, P#key: int) returns ($result: $ptr)
{
  var loopState#0: $state;
  var L#p: $ptr;
  var #wrTime$1^101.1: int;
  var #stackframe: int;

  anon15:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^101.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^101.1, #loc.t, $ptr_to_int(P#t), $ptr_to(^Tree));
    assume $local_value_is($s, #tok$1^101.1, #loc.key, P#key, ^^i4);
    assume #wrTime$1^101.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^101.1, (lambda #p: $ptr :: false));
    assume true;
    assume $in_range_i4(P#key);
    assume 2147483647 == $decreases_level;
    assert $in_domain_lab($s, $phys_ptr_cast(P#t, ^Tree), $phys_ptr_cast(P#t, ^Tree), l#public);
    assume $local_value_is($s, #tok$1^106.3, #loc.p, $ptr_to_int(L#p), $ptr_to(^Node));
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    L#p := $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node);
    assume $local_value_is($s, #tok$1^107.3, #loc.p, $ptr_to_int(L#p), $ptr_to(^Node));
    loopState#0 := $s;
    while (true)
      invariant $is_null($phys_ptr_cast(L#p, ^Node))
   || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
      $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
    $phys_ptr_cast(F#mark($phys_ptr_cast(L#p, ^Node)), ^Node));
      invariant (forall Q#n$1^110.31#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^110.31#dt1, ^Node)) } 
    { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(L#p, ^Node)), 
      $phys_ptr_cast(Q#n$1^110.31#dt1, ^Node)) } 
  $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^110.31#dt1, ^Node)) == P#key
       && $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^110.31#dt1, ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(L#p, ^Node)), 
      $phys_ptr_cast(Q#n$1^110.31#dt1, ^Node)));
    {
      anon14:
        assume $writes_nothing(old($s), $s);
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$1^108.3, $s);
        assume $local_value_is($s, #tok$1^108.3, #loc.key, P#key, ^^i4);
        assume $meta_eq(loopState#0, $s);
        assume true;
        if ($non_null($phys_ptr_cast(L#p, ^Node)))
        {
          anon12:
            assert $thread_local($s, $phys_ptr_cast(L#p, ^Node));
            assume true;
            if (P#key < $rd_inv($s, Node.key, $phys_ptr_cast(L#p, ^Node)))
            {
              anon8:
                assert $thread_local($s, $phys_ptr_cast(L#p, ^Node));
                L#p := $rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#p, ^Node), ^Node);
                assume $local_value_is($s, #tok$1^113.7, #loc.p, $ptr_to_int(L#p), $ptr_to(^Node));
            }
            else
            {
              anon11:
                assert $thread_local($s, $phys_ptr_cast(L#p, ^Node));
                assume true;
                if (P#key > $rd_inv($s, Node.key, $phys_ptr_cast(L#p, ^Node)))
                {
                  anon9:
                    assert $thread_local($s, $phys_ptr_cast(L#p, ^Node));
                    L#p := $rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#p, ^Node), ^Node);
                    assume $local_value_is($s, #tok$1^115.7, #loc.p, $ptr_to_int(L#p), $ptr_to(^Node));
                }
                else
                {
                  anon10:
                    $result := $phys_ptr_cast(L#p, ^Node);
                    assert $position_marker();
                    goto #exit;
                }
            }
        }
        else
        {
          anon13:
            goto #break_10;
        }

      #continue_10:
        assume true;
    }

  anon16:
    assume $full_stop_ext(#tok$1^108.3, $s);

  #break_10:
    $result := $phys_ptr_cast($null, ^Node);
    assert $position_marker();
    goto #exit;

  anon17:

  #exit:
}



procedure tree_lookup(P#t: $ptr, P#key: int) returns ($result: int);
  requires $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  ensures $result
   == $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
    P#key);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation tree_lookup(P#t: $ptr, P#key: int) returns ($result: int)
{
  var L#r: $ptr;
  var #wrTime$1^122.1: int;
  var #stackframe: int;

  anon20:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^122.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^122.1, #loc.t, $ptr_to_int(P#t), $ptr_to(^Tree));
    assume $local_value_is($s, #tok$1^122.1, #loc.key, P#key, ^^i4);
    assume #wrTime$1^122.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^122.1, (lambda #p: $ptr :: false));
    assume true;
    assume $in_range_i4(P#key);
    assume 2147483647 == $decreases_level;
    assert $in_domain_lab($s, $phys_ptr_cast(P#t, ^Tree), $phys_ptr_cast(P#t, ^Tree), l#public);
    assume $local_value_is($s, #tok$1^126.3, #loc.r, $ptr_to_int(L#r), $ptr_to(^Node));
    call L#r := tree_find($phys_ptr_cast(P#t, ^Tree), P#key);
    /*** desugaring:
    {
      var call0formal#AT#P#t: $ptr;
      var call1formal#AT#P#key: int;
      var call2old#AT#$s: $state;
      var call3old#AT#$cev_pc: int;
      var call4formal#AT#$result: $ptr;
      call0formal#AT#P#t := $phys_ptr_cast(P#t, ^Tree);
      call1formal#AT#P#key := P#key;
      assert $wrapped($s, $phys_ptr_cast(call0formal#AT#P#t, ^Tree), ^Tree);
      call2old#AT#$s := $s;
      call3old#AT#$cev_pc := $cev_pc;
      havoc $s, $cev_pc, call4formal#AT#$result;
      assume true;
      assume $non_null($phys_ptr_cast(call4formal#AT#$result, ^Node))
   ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(call0formal#AT#P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(call0formal#AT#P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(call4formal#AT#$result, ^Node))
     && $rd_inv($s, Node.key, $phys_ptr_cast(call4formal#AT#$result, ^Node))
       == call1formal#AT#P#key;
      assume $is_null($phys_ptr_cast(call4formal#AT#$result, ^Node))
   ==> (forall Q#n$1^104.53#dt1: $ptr :: 
    {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(call0formal#AT#P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(call0formal#AT#P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^104.53#dt1, ^Node)) } 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(call0formal#AT#P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(call0formal#AT#P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^104.53#dt1, ^Node))
       ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^104.53#dt1, ^Node))
         != call1formal#AT#P#key);
      assume $writes_nothing(call2old#AT#$s, $s);
      assume $call_transition(call2old#AT#$s, $s);
      L#r := call4formal#AT#$result;
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^126.13, $s);
    assume $local_value_is($s, #tok$1^126.13, #loc.r, $ptr_to_int(L#r), $ptr_to(^Node));
    assume true;
    if ($is_null($phys_ptr_cast(L#r, ^Node)))
    {
      anon18:
        assert $inv($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
        assume $inv($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
        $result := 0;
        assert $position_marker();
        goto #exit;
    }
    else
    {
      anon19:
        assert $thread_local($s, $phys_ptr_cast(L#r, ^Node));
        $result := $rd_inv($s, Node.value, $phys_ptr_cast(L#r, ^Node));
        assert $position_marker();
        goto #exit;
    }

  anon21:

  #exit:
}



procedure tree_insert(P#t: $ptr, P#x: $ptr);
  requires !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
  $phys_ptr_cast(P#x, ^Node));
  requires (forall Q#n$1^138.28#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^138.28#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^138.28#dt1, ^Node))
     ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^138.28#dt1, ^Node))
       != $rd_inv($s, Node.key, $phys_ptr_cast(P#x, ^Node)));
  requires $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
  modifies $s, $cev_pc;
  ensures (forall Q#n$1^139.27#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^139.27#dt1, ^Node)) } 
    { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(old($s), Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr(old($s), Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^139.27#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^139.27#dt1, ^Node))
     <==> $phys_ptr_cast(Q#n$1^139.27#dt1, ^Node) == $phys_ptr_cast(P#x, ^Node)
       || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(old($s), Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr(old($s), Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^139.27#dt1, ^Node)));
  ensures $rd_inv(old($s), Node.key, $phys_ptr_cast(P#x, ^Node))
     == $rd_inv($s, Node.key, $phys_ptr_cast(P#x, ^Node))
   && $rd_inv(old($s), Node.value, $phys_ptr_cast(P#x, ^Node))
     == $rd_inv($s, Node.value, $phys_ptr_cast(P#x, ^Node));
  ensures $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
  free ensures $modifies(old($s), 
  $s, 
  (lambda #p: $ptr :: 
    #p == $phys_ptr_cast(P#t, ^Tree)
       || $set_in(#p, $span($phys_ptr_cast(P#x, ^Node)))));
  free ensures $call_transition(old($s), $s);



implementation tree_insert(P#t: $ptr, P#x: $ptr)
{
  var prestate#44: $state;
  var owns#42: $ptrset;
  var staticWrapState#41: $state;
  var prestate#43: $state;
  var res_lambda#7#20: $map_t..$ptr_to..^Node.^^bool;
  var owns#39: $ptrset;
  var staticWrapState#38: $state;
  var prestate#40: $state;
  var prestate#37: $state;
  var prestate#35: $state;
  var owns#36: $ptrset;
  var owns#33: $ptrset;
  var staticWrapState#32: $state;
  var prestate#34: $state;
  var prestate#31: $state;
  var prestate#29: $state;
  var owns#30: $ptrset;
  var #wrTime$1^168.28: int;
  var loopState#1: $state;
  var res_lambda#6#19: $map_t..$ptr_to..^Node.^^bool;
  var prestate#28: $state;
  var owns#26: $ptrset;
  var staticWrapState#25: $state;
  var prestate#27: $state;
  var res_lambda#5#18: $map_t..$ptr_to..^Node.^^bool;
  var res_lambda#4#17: $map_t..^^i4.^^i4;
  var assign#13: $ptr;
  var assign#12: $ptr;
  var prestate#24: $state;
  var L#p: $ptr;
  var L#n: $ptr;
  var #wrTime$1^134.1: int;
  var #stackframe: int;

  anon36:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^134.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^134.1, #loc.t, $ptr_to_int(P#t), $ptr_to(^Tree));
    assume $local_value_is($s, #tok$1^134.1, #loc.x, $ptr_to_int(P#x), $ptr_to(^Node));
    assume #wrTime$1^134.1 == $current_timestamp($s);
    assume $def_writes($s, 
  #wrTime$1^134.1, 
  (lambda #p: $ptr :: 
    #p == $phys_ptr_cast(P#t, ^Tree)
       || $set_in(#p, $span($phys_ptr_cast(P#x, ^Node)))));
    assume $thread_owned($s, $phys_ptr_cast(P#t, ^Tree));
    assume $mutable($s, $phys_ptr_cast(P#x, ^Node));
    assume true;
    assume true;
    assume 2147483647 == $decreases_level;
    assert $in_domain_lab($s, $phys_ptr_cast(P#t, ^Tree), $phys_ptr_cast(P#t, ^Tree), l#public);
    assume $local_value_is($s, #tok$1^142.3, #loc.n, $ptr_to_int(L#n), $ptr_to(^Node));
    assume $local_value_is($s, #tok$1^142.3, #loc.p, $ptr_to_int(L#p), $ptr_to(^Node));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#24, $state_to_int(prestate#24), ^$#state_t);
    prestate#24 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#24, $state_to_int(prestate#24), ^$#state_t);
    assert $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
    assume $inv($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
    assume $pre_unwrap($s);
    assert $top_writable($s, #wrTime$1^134.1, $phys_ptr_cast(P#t, ^Tree));
    call $unwrap($phys_ptr_cast(P#t, ^Tree), ^Tree);
    /*** desugaring:
    {
      var call0formal#AT#o: $ptr;
      var call1formal#AT#T: $ctype;
      var call2old#AT#$s: $state;
      call0formal#AT#o := $phys_ptr_cast(P#t, ^Tree);
      call1formal#AT#T := ^Tree;
      assert !$is_claimable(call1formal#AT#T) || $ref_cnt($s, call0formal#AT#o) == 0;
      assert $pre_unwrap($s);
      call2old#AT#$s := $s;
      havoc $s;
      assume $is_unwrapped_dynamic(call2old#AT#$s, $s, call0formal#AT#o);
    }
    **** end desugaring */
    assume $good_state_ext(#tok$1^144.19, $s);
    assume $full_stop($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.assign#12, $ptr_to_int(assign#12), $ptr_to(^Node));
    assume $local_value_is($s, #tok$2^0.0, #loc.assign#13, $ptr_to_int(assign#13), $ptr_to(^Node));
    assign#13 := $phys_ptr_cast($null, ^Node);
    assume $local_value_is($s, #tok$2^0.0, #loc.assign#13, $ptr_to_int(assign#13), $ptr_to(^Node));
    assert $writable_prim($s, #wrTime$1^134.1, $dot($phys_ptr_cast(P#x, ^Node), Node.parent));
    call $write_int(Node.parent, $phys_ptr_cast(P#x, ^Node), $ptr_to_int($phys_ptr_cast(assign#13, ^Node)));
    /*** desugaring:
    {
      var call0formal#AT#f: $field;
      var call1formal#AT#p: $ptr;
      var call2formal#AT#v: int;
      var call3old#AT#$s: $state;
      call0formal#AT#f := Node.parent;
      call1formal#AT#p := $phys_ptr_cast(P#x, ^Node);
      call2formal#AT#v := $ptr_to_int($phys_ptr_cast(assign#13, ^Node));
      call3old#AT#$s := $s;
      havoc $s;
      assume $specials_eq(call3old#AT#$s, $s);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
      assume $timestamp_post_strict(call3old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^146.24, $s);
    assign#12 := $phys_ptr_cast(assign#13, ^Node);
    assume $local_value_is($s, #tok$2^0.0, #loc.assign#12, $ptr_to_int(assign#12), $ptr_to(^Node));
    assert $writable_prim($s, #wrTime$1^134.1, $dot($phys_ptr_cast(P#x, ^Node), Node.right));
    call $write_int(Node.right, $phys_ptr_cast(P#x, ^Node), $ptr_to_int($phys_ptr_cast(assign#12, ^Node)));
    /*** desugaring:
    {
      var call0formal#AT#f: $field;
      var call1formal#AT#p: $ptr;
      var call2formal#AT#v: int;
      var call3old#AT#$s: $state;
      call0formal#AT#f := Node.right;
      call1formal#AT#p := $phys_ptr_cast(P#x, ^Node);
      call2formal#AT#v := $ptr_to_int($phys_ptr_cast(assign#12, ^Node));
      call3old#AT#$s := $s;
      havoc $s;
      assume $specials_eq(call3old#AT#$s, $s);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
      assume $timestamp_post_strict(call3old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^146.13, $s);
    assert $writable_prim($s, #wrTime$1^134.1, $dot($phys_ptr_cast(P#x, ^Node), Node.left));
    call $write_int(Node.left, $phys_ptr_cast(P#x, ^Node), $ptr_to_int($phys_ptr_cast(assign#12, ^Node)));
    /*** desugaring:
    {
      var call0formal#AT#f: $field;
      var call1formal#AT#p: $ptr;
      var call2formal#AT#v: int;
      var call3old#AT#$s: $state;
      call0formal#AT#f := Node.left;
      call1formal#AT#p := $phys_ptr_cast(P#x, ^Node);
      call2formal#AT#v := $ptr_to_int($phys_ptr_cast(assign#12, ^Node));
      call3old#AT#$s := $s;
      havoc $s;
      assume $specials_eq(call3old#AT#$s, $s);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
      assume $timestamp_post_strict(call3old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^146.3, $s);
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    L#p := $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node);
    assume $local_value_is($s, #tok$1^148.3, #loc.p, $ptr_to_int(L#p), $ptr_to(^Node));
    assume $local_value_is($s, 
  #tok$1^151.14, 
  #loc.res_lambda#4#17, 
  $map_t..^^i4.^^i4_to_int(res_lambda#4#17), 
  $map_t(^^i4, ^^i4));
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
    assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
    call res_lambda#4#17 := lambda#4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), $rd_inv($s, Node.value, $phys_ptr_cast(P#x, ^Node)), $rd_inv($s, Node.key, $phys_ptr_cast(P#x, ^Node)));
    /*** desugaring:
    {
      var call0formal#AT##l2: $map_t..^^i4.^^i4;
      var call1formal#AT##l1: int;
      var call2formal#AT##l0: int;
      var call3formal#AT#$result: $map_t..^^i4.^^i4;
      call0formal#AT##l2 := $int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree)));
      call1formal#AT##l1 := $rd_inv($s, Node.value, $phys_ptr_cast(P#x, ^Node));
      call2formal#AT##l0 := $rd_inv($s, Node.key, $phys_ptr_cast(P#x, ^Node));
      havoc call3formal#AT#$result;
      assume call3formal#AT#$result
   == F#lambda#4(call0formal#AT##l2, call1formal#AT##l1, call2formal#AT##l0);
      assume $call_transition($s, $s);
      res_lambda#4#17 := call3formal#AT#$result;
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^151.14, $s);
    assume $local_value_is($s, 
  #tok$1^151.14, 
  #loc.res_lambda#4#17, 
  $map_t..^^i4.^^i4_to_int(res_lambda#4#17), 
  $map_t(^^i4, ^^i4));
    assert $writable_prim($s, #wrTime$1^134.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.abs));
    call $write_int(Tree.abs, $phys_ptr_cast(P#t, ^Tree), $map_t..^^i4.^^i4_to_int(res_lambda#4#17));
    /*** desugaring:
    {
      var call0formal#AT#f: $field;
      var call1formal#AT#p: $ptr;
      var call2formal#AT#v: int;
      var call3old#AT#$s: $state;
      call0formal#AT#f := Tree.abs;
      call1formal#AT#p := $phys_ptr_cast(P#t, ^Tree);
      call2formal#AT#v := $map_t..^^i4.^^i4_to_int(res_lambda#4#17);
      call3old#AT#$s := $s;
      havoc $s;
      assume $specials_eq(call3old#AT#$s, $s);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
      assume $timestamp_post_strict(call3old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^151.5, $s);
    assert (forall #writes$1^152.5: $ptr :: 
  { $dont_instantiate(#writes$1^152.5) } 
  $set_in(#writes$1^152.5, $span($phys_ptr_cast(P#t, ^Tree)))
     ==> $top_writable($s, #wrTime$1^134.1, #writes$1^152.5));
    call $set_owns($phys_ptr_cast(P#t, ^Tree), $set_union($owns($s, $phys_ptr_cast(P#t, ^Tree)), 
  $set_singleton($phys_ptr_cast(P#x, ^Node))));
    /*** desugaring:
    {
      var call0formal#AT#p: $ptr;
      var call1formal#AT#owns: $ptrset;
      var call2old#AT#$s: $state;
      call0formal#AT#p := $phys_ptr_cast(P#t, ^Tree);
      call1formal#AT#owns := $set_union($owns($s, $phys_ptr_cast(P#t, ^Tree)), 
  $set_singleton($phys_ptr_cast(P#x, ^Node)));
      assert $is_non_primitive($typ(call0formal#AT#p));
      assert $mutable($s, call0formal#AT#p);
      call2old#AT#$s := $s;
      havoc $s;
      assume $updated_owns(call2old#AT#$s, $s, call0formal#AT#p, call1formal#AT#owns);
      assume $specials_eq(call2old#AT#$s, $s);
      assume $timestamp_post_strict(call2old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^152.5, $s);
    assume $local_value_is($s, 
  #tok$1^153.15, 
  #loc.res_lambda#5#18, 
  $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#5#18), 
  $map_t($ptr_to(^Node), ^^bool));
    call res_lambda#5#18 := lambda#5($phys_ptr_cast(P#x, ^Node));
    /*** desugaring:
    {
      var call0formal#AT##l0: $ptr;
      var call1formal#AT#$result: $map_t..$ptr_to..^Node.^^bool;
      call0formal#AT##l0 := $phys_ptr_cast(P#x, ^Node);
      havoc call1formal#AT#$result;
      assume call1formal#AT#$result == F#lambda#5(call0formal#AT##l0);
      assume $call_transition($s, $s);
      res_lambda#5#18 := call1formal#AT#$result;
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^153.15, $s);
    assume $local_value_is($s, 
  #tok$1^153.15, 
  #loc.res_lambda#5#18, 
  $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#5#18), 
  $map_t($ptr_to(^Node), ^^bool));
    assert $writable_prim($s, #wrTime$1^134.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.R));
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    call $write_int(Tree.R, $phys_ptr_cast(P#t, ^Tree), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $phys_ptr_cast(P#x, ^Node), 
    res_lambda#5#18)));
    /*** desugaring:
    {
      var call0formal#AT#f: $field;
      var call1formal#AT#p: $ptr;
      var call2formal#AT#v: int;
      var call3old#AT#$s: $state;
      call0formal#AT#f := Tree.R;
      call1formal#AT#p := $phys_ptr_cast(P#t, ^Tree);
      call2formal#AT#v := $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $phys_ptr_cast(P#x, ^Node), 
    res_lambda#5#18));
      call3old#AT#$s := $s;
      havoc $s;
      assume $specials_eq(call3old#AT#$s, $s);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
      assume $timestamp_post_strict(call3old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^153.5, $s);
    assume true;
    if ($is_null($phys_ptr_cast(L#p, ^Node)))
    {
      anon22:
        assert $writable_prim($s, #wrTime$1^134.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.root));
        call $write_int(Tree.root, $phys_ptr_cast(P#t, ^Tree), $ptr_to_int($phys_ptr_cast(P#x, ^Node)));
        /*** desugaring:
        {
          var call0formal#AT#f: $field;
          var call1formal#AT#p: $ptr;
          var call2formal#AT#v: int;
          var call3old#AT#$s: $state;
          call0formal#AT#f := Tree.root;
          call1formal#AT#p := $phys_ptr_cast(P#t, ^Tree);
          call2formal#AT#v := $ptr_to_int($phys_ptr_cast(P#x, ^Node));
          call3old#AT#$s := $s;
          havoc $s;
          assume $specials_eq(call3old#AT#$s, $s);
          assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
          assume $timestamp_post_strict(call3old#AT#$s, $s);
        }
        **** end desugaring */
        assume $full_stop_ext(#tok$1^157.5, $s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
        prestate#27 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
        assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#25, 
  $state_to_int(staticWrapState#25), 
  ^$#state_t);
        staticWrapState#25 := $current_state($s);
        assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#25, 
  $state_to_int(staticWrapState#25), 
  ^$#state_t);
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#26, $ptrset_to_int(owns#26), ^$#ptrset);
        owns#26 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#26, $ptrset_to_int(owns#26), ^$#ptrset);
        assert $top_writable($s, #wrTime$1^134.1, $phys_ptr_cast(P#x, ^Node));
        assume $pre_static_wrap($s);
        call $static_wrap($phys_ptr_cast(P#x, ^Node), staticWrapState#25, owns#26);
        /*** desugaring:
        {
          var call0formal#AT#o: $ptr;
          var call1formal#AT#S: $state;
          var call2formal#AT#owns: $ptrset;
          var call3old#AT#$s: $state;
          call0formal#AT#o := $phys_ptr_cast(P#x, ^Node);
          call1formal#AT#S := staticWrapState#25;
          call2formal#AT#owns := owns#26;
          assert $pre_static_wrap($s);
          assert $is_non_primitive($typ(call0formal#AT#o));
          assert $mutable($s, call0formal#AT#o);
          call3old#AT#$s := $s;
          havoc $s;
          assume $is_wrapped(call3old#AT#$s, $s, call0formal#AT#o, call2formal#AT#owns);
          assume $heap($s)
   == $update($heap(call3old#AT#$s), 
    call0formal#AT#o, 
    $f_owns($typ(call0formal#AT#o)), 
    $ptrset_to_int(call2formal#AT#owns));
          assume $f_owner($s) == $f_owner(call1formal#AT#S);
        }
        **** end desugaring */
        assume $good_state_ext(#tok$1^158.21, $s);
        assert $set_eq($owns($s, $phys_ptr_cast(P#x, ^Node)), $set_empty());
        assume $full_stop($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
        prestate#28 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
        assume $pre_wrap($s);
        assert $top_writable($s, #wrTime$1^134.1, $phys_ptr_cast(P#t, ^Tree));
        assert (forall #writes$1^159.21: $ptr :: 
  { $dont_instantiate(#writes$1^159.21) } 
  $set_in(#writes$1^159.21, $owns($s, $phys_ptr_cast(P#t, ^Tree)))
     ==> $top_writable($s, #wrTime$1^134.1, #writes$1^159.21));
        call $wrap($phys_ptr_cast(P#t, ^Tree), ^Tree);
        /*** desugaring:
        {
          var call0formal#AT#o: $ptr;
          var call1formal#AT#T: $ctype;
          var call2old#AT#$s: $state;
          call0formal#AT#o := $phys_ptr_cast(P#t, ^Tree);
          call1formal#AT#T := ^Tree;
          assert $pre_wrap($s);
          assert $is_non_primitive($typ(call0formal#AT#o));
          assert $mutable($s, call0formal#AT#o);
          assert (forall p: $ptr :: 
  { $dont_instantiate(p) } 
  $set_in0(p, $owns($s, call0formal#AT#o)) ==> $wrapped($s, p, $typ(p)));
          call2old#AT#$s := $s;
          havoc $s;
          assume $is_wrapped_dynamic(call2old#AT#$s, $s, call0formal#AT#o);
        }
        **** end desugaring */
        assume $good_state_ext(#tok$1^159.21, $s);
        assert !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
  $phys_ptr_cast($null, ^Node));
        assert $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node))
   ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
      $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
    $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
        assert $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node))
   ==> $is_null($rd_phys_ptr($s, 
      Node.parent, 
      $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node), 
      ^Node));
        assert (forall Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast($null, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
      $phys_ptr_cast($null, ^Node)), 
    $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
        assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
     ==> 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
       < $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
        assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
     ==> 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
       > $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
        assert (forall Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
    { F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
    { sk_hack(F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     <==> $set_in($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node), $owns($s, $phys_ptr_cast(P#t, ^Tree))));
        assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
        assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
        assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
        assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $rd_phys_ptr($s, 
        Node.parent, 
        $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
        ^Node)
       == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
        assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
        assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $rd_phys_ptr($s, 
        Node.parent, 
        $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
        ^Node)
       == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
        assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.parent, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
        assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.parent, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $rd_phys_ptr($s, 
          Node.left, 
          $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
          ^Node)
         == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)
       || $rd_phys_ptr($s, 
          Node.right, 
          $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
          ^Node)
         == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
        assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
        assert true;
        assert (forall Q#m$1^83.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
      $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))
     ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)))
       == $rd_inv($s, Node.value, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)));
        assert (forall Q#k$1^83.29#tc2: int :: 
  {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
      Q#k$1^83.29#tc2) } 
  $in_range_i4(Q#k$1^83.29#tc2)
     ==> 
    (forall Q#m$1^83.29#dt1: $ptr :: 
      {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) } 
      $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))
         ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) != Q#k$1^83.29#tc2)
     ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
        Q#k$1^83.29#tc2)
       == 0);
        assert (forall Q#n$1^84.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node))
       && $is_null($rd_phys_ptr($s, 
          Node.parent, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)
       || $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)
         == $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
        assert (forall Q#n$1^84.29#dt1: $ptr, Q#m$1^84.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), 
      $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), 
      $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node))
     <==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node))
       && (
        ($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)
           && $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node))
         || $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)
         || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), 
          $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node))
         || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), 
          $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node))));
        assume $full_stop($s);
        assert $position_marker();
        goto #exit;
    }
    else
    {
      anon23:
    }

  anon37:
    assume $local_value_is($s, 
  #tok$1^163.41, 
  #loc.res_lambda#6#19, 
  $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#6#19), 
  $map_t($ptr_to(^Node), ^^bool));
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    call res_lambda#6#19 := lambda#6($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(old($s), Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
  $rd_phys_ptr(old($s), Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(P#x, ^Node));
    /*** desugaring:
    {
      var call0formal#AT##l1: $map_t..$ptr_to..^Node.^^bool;
      var call1formal#AT##l0: $ptr;
      var call2formal#AT#$result: $map_t..$ptr_to..^Node.^^bool;
      call0formal#AT##l1 := $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(old($s), Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
  $rd_phys_ptr(old($s), Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
      call1formal#AT##l0 := $phys_ptr_cast(P#x, ^Node);
      havoc call2formal#AT#$result;
      assume call2formal#AT#$result == F#lambda#6(call0formal#AT##l1, call1formal#AT##l0);
      assume $call_transition($s, $s);
      res_lambda#6#19 := call2formal#AT#$result;
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^163.41, $s);
    assume $local_value_is($s, 
  #tok$1^163.41, 
  #loc.res_lambda#6#19, 
  $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#6#19), 
  $map_t($ptr_to(^Node), ^^bool));
    assert $writable_prim($s, #wrTime$1^134.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.R));
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    call $write_int(Tree.R, $phys_ptr_cast(P#t, ^Tree), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node), 
    res_lambda#6#19)));
    /*** desugaring:
    {
      var call0formal#AT#f: $field;
      var call1formal#AT#p: $ptr;
      var call2formal#AT#v: int;
      var call3old#AT#$s: $state;
      call0formal#AT#f := Tree.R;
      call1formal#AT#p := $phys_ptr_cast(P#t, ^Tree);
      call2formal#AT#v := $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node), 
    res_lambda#6#19));
      call3old#AT#$s := $s;
      havoc $s;
      assume $specials_eq(call3old#AT#$s, $s);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
      assume $timestamp_post_strict(call3old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^163.25, $s);
    assert F#doMark($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
    assume F#doMark($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
    assert $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
  $phys_ptr_cast(P#x, ^Node));
    assume $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
  $phys_ptr_cast(P#x, ^Node));
    call $bump_timestamp();
    /*** desugaring:
    {
      var call0old#AT#$s: $state;
      call0old#AT#$s := $s;
      havoc $s;
      assume $f_closed($s) == $f_closed(call0old#AT#$s)
   && $f_owner($s) == $f_owner(call0old#AT#$s)
   && $roots($s) == $roots(call0old#AT#$s)
   && $heap($s) == $heap(call0old#AT#$s);
      assume $f_timestamp($s)
   == $f_timestamp(call0old#AT#$s)[$null := $current_timestamp($s)];
      assume $current_timestamp(call0old#AT#$s) < $current_timestamp($s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^168.28, $s);
    loopState#1 := $s;
    assume #wrTime$1^168.28 == $current_timestamp($s);
    assume $def_writes($s, 
  #wrTime$1^168.28, 
  (lambda #p: $ptr :: 
    $set_in(#p, 
        $set_difference($owns($s, $phys_ptr_cast(P#t, ^Tree)), 
          $set_singleton($phys_ptr_cast(P#x, ^Node))))
       || #p == $dot($phys_ptr_cast(P#t, ^Tree), Tree.R)));
    assert (forall #loopWrites^$1^168.28: $ptr :: 
  { $dont_instantiate(#loopWrites^$1^168.28) } 
  $listed_in_writes($s, #wrTime$1^168.28, #loopWrites^$1^168.28)
     ==> $top_writable($s, #wrTime$1^134.1, #loopWrites^$1^168.28));
    while (true)
      invariant (forall Q#p$1^169.32#tc3: $ptr :: 
  {:weight 10} { $set_in(Q#p$1^169.32#tc3, $owns($s, $phys_ptr_cast(P#t, ^Tree))) } 
    { sk_hack($set_in(Q#p$1^169.32#tc3, $owns($s, $phys_ptr_cast(P#t, ^Tree)))) } 
  $set_in(Q#p$1^169.32#tc3, $owns($s, $phys_ptr_cast(P#t, ^Tree)))
     ==> Q#p$1^169.32#tc3 == $phys_ptr_cast(P#x, ^Node)
       || $wrapped($s, Q#p$1^169.32#tc3, $typ(Q#p$1^169.32#tc3)));
      invariant $mutable($s, $phys_ptr_cast(P#x, ^Node));
      invariant $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(loopState#1, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $rd_phys_ptr(loopState#1, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
  $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)));
      invariant $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(loopState#1, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $phys_ptr_cast($null, ^Node)), 
  $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $phys_ptr_cast($null, ^Node)));
      invariant $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(loopState#1, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $phys_ptr_cast(P#x, ^Node)), 
  $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $phys_ptr_cast(P#x, ^Node)));
      invariant !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
  $phys_ptr_cast($null, ^Node));
      invariant $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node))
   ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
      $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
    $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
      invariant $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node))
   ==> $is_null($rd_phys_ptr($s, 
      Node.parent, 
      $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node), 
      ^Node));
      invariant (forall Q#m$1^171.31#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast($null, ^Node)), 
      $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)) } 
  !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
      $phys_ptr_cast($null, ^Node)), 
    $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)));
      invariant (forall Q#n$1^171.31#dt1: $ptr, Q#m$1^171.31#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node))
     ==> 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node))
     ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node))
       < $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)));
      invariant (forall Q#n$1^171.31#dt1: $ptr, Q#m$1^171.31#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node))
     ==> 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node))
     ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node))
       > $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)));
      invariant (forall Q#m$1^171.31#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)) } 
    { F#mark2($phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)) } 
    { sk_hack(F#mark2($phys_ptr_cast(Q#m$1^171.31#dt1, ^Node))) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node))
     <==> $set_in($phys_ptr_cast(Q#m$1^171.31#dt1, ^Node), $owns($s, $phys_ptr_cast(P#t, ^Tree))));
      invariant (forall Q#n$1^171.31#dt1: $ptr, Q#m$1^171.31#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)));
      invariant (forall Q#n$1^171.31#dt1: $ptr, Q#m$1^171.31#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)));
      invariant (forall Q#n$1^171.31#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), 
      $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node), ^Node)));
      invariant (forall Q#n$1^171.31#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $rd_phys_ptr($s, 
        Node.parent, 
        $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node), ^Node), 
        ^Node)
       == $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node));
      invariant (forall Q#n$1^171.31#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), 
      $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node), ^Node)));
      invariant (forall Q#n$1^171.31#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $rd_phys_ptr($s, 
        Node.parent, 
        $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node), ^Node), 
        ^Node)
       == $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node));
      invariant (forall Q#n$1^171.31#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.parent, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node), ^Node)));
      invariant (forall Q#n$1^171.31#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.parent, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $rd_phys_ptr($s, 
          Node.left, 
          $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node), ^Node), 
          ^Node)
         == $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)
       || $rd_phys_ptr($s, 
          Node.right, 
          $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node), ^Node), 
          ^Node)
         == $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node));
      invariant (forall Q#n$1^171.31#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), 
      $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)));
      invariant true;
      invariant (forall Q#m$1^172.31#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
      $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^172.31#dt1, ^Node))) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^172.31#dt1, ^Node))
     ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^172.31#dt1, ^Node)))
       == $rd_inv($s, Node.value, $phys_ptr_cast(Q#m$1^172.31#dt1, ^Node)));
      invariant (forall Q#k$1^172.31#tc2: int :: 
  {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
      Q#k$1^172.31#tc2) } 
  $in_range_i4(Q#k$1^172.31#tc2)
     ==> 
    (forall Q#m$1^172.31#dt1: $ptr :: 
      {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#m$1^172.31#dt1, ^Node)) } 
      $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#m$1^172.31#dt1, ^Node))
         ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^172.31#dt1, ^Node))
           != Q#k$1^172.31#tc2)
     ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
        Q#k$1^172.31#tc2)
       == 0);
      invariant (forall Q#n$1^173.31#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^173.31#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^173.31#dt1, ^Node))
       && $is_null($rd_phys_ptr($s, 
          Node.parent, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^173.31#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $phys_ptr_cast(Q#n$1^173.31#dt1, ^Node) == $phys_ptr_cast(P#x, ^Node)
       || $phys_ptr_cast(Q#n$1^173.31#dt1, ^Node)
         == $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
      invariant (forall Q#n$1^173.31#dt1: $ptr, Q#m$1^173.31#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^173.31#dt1, ^Node)), ^Node)), 
      $phys_ptr_cast(Q#m$1^173.31#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^173.31#dt1, ^Node)), ^Node)), 
      $phys_ptr_cast(Q#m$1^173.31#dt1, ^Node))
     <==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^173.31#dt1, ^Node))
       && (
        ($phys_ptr_cast(Q#n$1^173.31#dt1, ^Node) == $phys_ptr_cast(L#p, ^Node)
           && $phys_ptr_cast(Q#m$1^173.31#dt1, ^Node) == $phys_ptr_cast(P#x, ^Node))
         || $phys_ptr_cast(Q#m$1^173.31#dt1, ^Node)
           == $phys_ptr_cast(Q#n$1^173.31#dt1, ^Node)
         || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^173.31#dt1, ^Node), ^Node)), 
          $phys_ptr_cast(Q#m$1^173.31#dt1, ^Node))
         || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^173.31#dt1, ^Node), ^Node)), 
          $phys_ptr_cast(Q#m$1^173.31#dt1, ^Node))));
      invariant $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
  $phys_ptr_cast(L#p, ^Node));
      invariant $phys_ptr_cast(L#p, ^Node) != $phys_ptr_cast(P#x, ^Node);
      invariant !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#p, ^Node), ^Node)), 
  $phys_ptr_cast(P#x, ^Node));
      invariant !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#p, ^Node), ^Node)), 
  $phys_ptr_cast(P#x, ^Node));
      invariant (forall Q#n$1^176.31#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^176.31#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^176.31#dt1, ^Node))
     ==> $phys_ptr_cast(Q#n$1^176.31#dt1, ^Node) == $phys_ptr_cast(P#x, ^Node)
       || $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^176.31#dt1, ^Node))
         != $rd_inv($s, Node.key, $phys_ptr_cast(P#x, ^Node)));
    {
      anon35:
        assume $modifies(loopState#1, 
  $s, 
  (lambda #p: $ptr :: 
    $set_in(#p, 
        $set_difference($owns(loopState#1, $phys_ptr_cast(P#t, ^Tree)), 
          $set_singleton($phys_ptr_cast(P#x, ^Node))))
       || #p == $dot($phys_ptr_cast(P#t, ^Tree), Tree.R)));
        assume $timestamp_post(loopState#1, $s);
        assume $full_stop_ext(#tok$1^167.3, $s);
        assume $local_value_is($s, 
  #tok$1^167.3, 
  #loc.res_lambda#6#19, 
  $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#6#19), 
  $map_t($ptr_to(^Node), ^^bool));
        assume $local_value_is($s, #tok$1^167.3, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
        assume $local_value_is($s, #tok$1^167.3, #loc.owns#26, $ptrset_to_int(owns#26), ^$#ptrset);
        assume $local_value_is($s, 
  #tok$1^167.3, 
  #loc.staticWrapState#25, 
  $state_to_int(staticWrapState#25), 
  ^$#state_t);
        assume $local_value_is($s, #tok$1^167.3, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
        assume $local_value_is($s, 
  #tok$1^167.3, 
  #loc.res_lambda#5#18, 
  $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#5#18), 
  $map_t($ptr_to(^Node), ^^bool));
        assume $local_value_is($s, 
  #tok$1^167.3, 
  #loc.res_lambda#4#17, 
  $map_t..^^i4.^^i4_to_int(res_lambda#4#17), 
  $map_t(^^i4, ^^i4));
        assume $local_value_is($s, #tok$1^167.3, #loc.assign#13, $ptr_to_int(assign#13), $ptr_to(^Node));
        assume $local_value_is($s, #tok$1^167.3, #loc.assign#12, $ptr_to_int(assign#12), $ptr_to(^Node));
        assume $local_value_is($s, #tok$1^167.3, #loc.prestate#24, $state_to_int(prestate#24), ^$#state_t);
        assume $local_value_is($s, #tok$1^167.3, #loc.n, $ptr_to_int(L#n), $ptr_to(^Node));
        assume $local_value_is($s, #tok$1^167.3, #loc.x, $ptr_to_int(P#x), $ptr_to(^Node));
        assume true;
        if (true)
        {
          anon32:
            assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
            assert $thread_local($s, $phys_ptr_cast(L#p, ^Node));
            assume true;
            if ($rd_inv($s, Node.key, $phys_ptr_cast(P#x, ^Node))
   < $rd_inv($s, Node.key, $phys_ptr_cast(L#p, ^Node)))
            {
              anon26:
                assert $thread_local($s, $phys_ptr_cast(L#p, ^Node));
                L#n := $rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#p, ^Node), ^Node);
                assume $local_value_is($s, #tok$1^179.7, #loc.n, $ptr_to_int(L#n), $ptr_to(^Node));
                assume true;
                if ($is_null($phys_ptr_cast(L#n, ^Node)))
                {
                  anon24:
                    assume $local_value_is($s, #tok$2^0.0, #loc.owns#30, $ptrset_to_int(owns#30), ^$#ptrset);
                    owns#30 := $set_empty();
                    assume $local_value_is($s, #tok$2^0.0, #loc.owns#30, $ptrset_to_int(owns#30), ^$#ptrset);
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#29, $state_to_int(prestate#29), ^$#state_t);
                    prestate#29 := $current_state($s);
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#29, $state_to_int(prestate#29), ^$#state_t);
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#31, $state_to_int(prestate#31), ^$#state_t);
                    prestate#31 := $current_state($s);
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#31, $state_to_int(prestate#31), ^$#state_t);
                    assert $wrapped($s, $phys_ptr_cast(L#p, ^Node), ^Node);
                    assert $top_writable($s, #wrTime$1^168.28, $phys_ptr_cast(L#p, ^Node));
                    assume $inv($s, $phys_ptr_cast(L#p, ^Node), ^Node);
                    assume owns#30 == $owns($s, $phys_ptr_cast(L#p, ^Node));
                    assume $pre_static_unwrap($s);
                    call $static_unwrap($phys_ptr_cast(L#p, ^Node), prestate#31);
                    /*** desugaring:
                    {
                      var call0formal#AT#o: $ptr;
                      var call1formal#AT#S: $state;
                      var call2old#AT#$s: $state;
                      call0formal#AT#o := $phys_ptr_cast(L#p, ^Node);
                      call1formal#AT#S := prestate#31;
                      assert !$is_claimable($typ(call0formal#AT#o)) || $ref_cnt($s, call0formal#AT#o) == 0;
                      assert $pre_static_unwrap($s);
                      call2old#AT#$s := $s;
                      havoc $s;
                      assume $is_unwrapped(call2old#AT#$s, $s, call0formal#AT#o);
                      assume $f_owner($s) == $f_owner(call1formal#AT#S);
                      assume $f_timestamp($s)
   == $f_timestamp(call1formal#AT#S)[call0formal#AT#o := $current_timestamp(call2old#AT#$s)];
                    }
                    **** end desugaring */
                    assume $good_state_ext(#tok$1^181.36, $s);
                    assume $full_stop($s);
                    assert $writable_prim($s, #wrTime$1^168.28, $dot($phys_ptr_cast(L#p, ^Node), Node.left));
                    call $write_int(Node.left, $phys_ptr_cast(L#p, ^Node), $ptr_to_int($phys_ptr_cast(P#x, ^Node)));
                    /*** desugaring:
                    {
                      var call0formal#AT#f: $field;
                      var call1formal#AT#p: $ptr;
                      var call2formal#AT#v: int;
                      var call3old#AT#$s: $state;
                      call0formal#AT#f := Node.left;
                      call1formal#AT#p := $phys_ptr_cast(L#p, ^Node);
                      call2formal#AT#v := $ptr_to_int($phys_ptr_cast(P#x, ^Node));
                      call3old#AT#$s := $s;
                      havoc $s;
                      assume $specials_eq(call3old#AT#$s, $s);
                      assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
                      assume $timestamp_post_strict(call3old#AT#$s, $s);
                    }
                    **** end desugaring */
                    assume $full_stop_ext(#tok$1^181.41, $s);
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#34, $state_to_int(prestate#34), ^$#state_t);
                    prestate#34 := $current_state($s);
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#34, $state_to_int(prestate#34), ^$#state_t);
                    assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#32, 
  $state_to_int(staticWrapState#32), 
  ^$#state_t);
                    staticWrapState#32 := $current_state($s);
                    assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#32, 
  $state_to_int(staticWrapState#32), 
  ^$#state_t);
                    assume $local_value_is($s, #tok$2^0.0, #loc.owns#33, $ptrset_to_int(owns#33), ^$#ptrset);
                    owns#33 := $set_empty();
                    assume $local_value_is($s, #tok$2^0.0, #loc.owns#33, $ptrset_to_int(owns#33), ^$#ptrset);
                    assert $top_writable($s, #wrTime$1^168.28, $phys_ptr_cast(L#p, ^Node));
                    assume $pre_static_wrap($s);
                    call $static_wrap($phys_ptr_cast(L#p, ^Node), staticWrapState#32, owns#33);
                    /*** desugaring:
                    {
                      var call0formal#AT#o: $ptr;
                      var call1formal#AT#S: $state;
                      var call2formal#AT#owns: $ptrset;
                      var call3old#AT#$s: $state;
                      call0formal#AT#o := $phys_ptr_cast(L#p, ^Node);
                      call1formal#AT#S := staticWrapState#32;
                      call2formal#AT#owns := owns#33;
                      assert $pre_static_wrap($s);
                      assert $is_non_primitive($typ(call0formal#AT#o));
                      assert $mutable($s, call0formal#AT#o);
                      call3old#AT#$s := $s;
                      havoc $s;
                      assume $is_wrapped(call3old#AT#$s, $s, call0formal#AT#o, call2formal#AT#owns);
                      assume $heap($s)
   == $update($heap(call3old#AT#$s), 
    call0formal#AT#o, 
    $f_owns($typ(call0formal#AT#o)), 
    $ptrset_to_int(call2formal#AT#owns));
                      assume $f_owner($s) == $f_owner(call1formal#AT#S);
                    }
                    **** end desugaring */
                    assume $good_state_ext(#tok$1^181.36, $s);
                    assert $set_eq($owns($s, $phys_ptr_cast(L#p, ^Node)), $set_empty());
                    assume $full_stop($s);
                    goto #break_11;
                }
                else
                {
                  anon25:
                }
            }
            else
            {
              anon31:
                assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
                assert $thread_local($s, $phys_ptr_cast(L#p, ^Node));
                assume true;
                if ($rd_inv($s, Node.key, $phys_ptr_cast(P#x, ^Node))
   > $rd_inv($s, Node.key, $phys_ptr_cast(L#p, ^Node)))
                {
                  anon29:
                    assert $thread_local($s, $phys_ptr_cast(L#p, ^Node));
                    L#n := $rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#p, ^Node), ^Node);
                    assume $local_value_is($s, #tok$1^185.7, #loc.n, $ptr_to_int(L#n), $ptr_to(^Node));
                    assume true;
                    if ($is_null($phys_ptr_cast(L#n, ^Node)))
                    {
                      anon27:
                        assume $local_value_is($s, #tok$2^0.0, #loc.owns#36, $ptrset_to_int(owns#36), ^$#ptrset);
                        owns#36 := $set_empty();
                        assume $local_value_is($s, #tok$2^0.0, #loc.owns#36, $ptrset_to_int(owns#36), ^$#ptrset);
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#35, $state_to_int(prestate#35), ^$#state_t);
                        prestate#35 := $current_state($s);
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#35, $state_to_int(prestate#35), ^$#state_t);
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#37, $state_to_int(prestate#37), ^$#state_t);
                        prestate#37 := $current_state($s);
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#37, $state_to_int(prestate#37), ^$#state_t);
                        assert $wrapped($s, $phys_ptr_cast(L#p, ^Node), ^Node);
                        assert $top_writable($s, #wrTime$1^168.28, $phys_ptr_cast(L#p, ^Node));
                        assume $inv($s, $phys_ptr_cast(L#p, ^Node), ^Node);
                        assume owns#36 == $owns($s, $phys_ptr_cast(L#p, ^Node));
                        assume $pre_static_unwrap($s);
                        call $static_unwrap($phys_ptr_cast(L#p, ^Node), prestate#37);
                        /*** desugaring:
                        {
                          var call0formal#AT#o: $ptr;
                          var call1formal#AT#S: $state;
                          var call2old#AT#$s: $state;
                          call0formal#AT#o := $phys_ptr_cast(L#p, ^Node);
                          call1formal#AT#S := prestate#37;
                          assert !$is_claimable($typ(call0formal#AT#o)) || $ref_cnt($s, call0formal#AT#o) == 0;
                          assert $pre_static_unwrap($s);
                          call2old#AT#$s := $s;
                          havoc $s;
                          assume $is_unwrapped(call2old#AT#$s, $s, call0formal#AT#o);
                          assume $f_owner($s) == $f_owner(call1formal#AT#S);
                          assume $f_timestamp($s)
   == $f_timestamp(call1formal#AT#S)[call0formal#AT#o := $current_timestamp(call2old#AT#$s)];
                        }
                        **** end desugaring */
                        assume $good_state_ext(#tok$1^187.36, $s);
                        assume $full_stop($s);
                        assert $writable_prim($s, #wrTime$1^168.28, $dot($phys_ptr_cast(L#p, ^Node), Node.right));
                        call $write_int(Node.right, $phys_ptr_cast(L#p, ^Node), $ptr_to_int($phys_ptr_cast(P#x, ^Node)));
                        /*** desugaring:
                        {
                          var call0formal#AT#f: $field;
                          var call1formal#AT#p: $ptr;
                          var call2formal#AT#v: int;
                          var call3old#AT#$s: $state;
                          call0formal#AT#f := Node.right;
                          call1formal#AT#p := $phys_ptr_cast(L#p, ^Node);
                          call2formal#AT#v := $ptr_to_int($phys_ptr_cast(P#x, ^Node));
                          call3old#AT#$s := $s;
                          havoc $s;
                          assume $specials_eq(call3old#AT#$s, $s);
                          assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
                          assume $timestamp_post_strict(call3old#AT#$s, $s);
                        }
                        **** end desugaring */
                        assume $full_stop_ext(#tok$1^187.41, $s);
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#40, $state_to_int(prestate#40), ^$#state_t);
                        prestate#40 := $current_state($s);
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#40, $state_to_int(prestate#40), ^$#state_t);
                        assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#38, 
  $state_to_int(staticWrapState#38), 
  ^$#state_t);
                        staticWrapState#38 := $current_state($s);
                        assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#38, 
  $state_to_int(staticWrapState#38), 
  ^$#state_t);
                        assume $local_value_is($s, #tok$2^0.0, #loc.owns#39, $ptrset_to_int(owns#39), ^$#ptrset);
                        owns#39 := $set_empty();
                        assume $local_value_is($s, #tok$2^0.0, #loc.owns#39, $ptrset_to_int(owns#39), ^$#ptrset);
                        assert $top_writable($s, #wrTime$1^168.28, $phys_ptr_cast(L#p, ^Node));
                        assume $pre_static_wrap($s);
                        call $static_wrap($phys_ptr_cast(L#p, ^Node), staticWrapState#38, owns#39);
                        /*** desugaring:
                        {
                          var call0formal#AT#o: $ptr;
                          var call1formal#AT#S: $state;
                          var call2formal#AT#owns: $ptrset;
                          var call3old#AT#$s: $state;
                          call0formal#AT#o := $phys_ptr_cast(L#p, ^Node);
                          call1formal#AT#S := staticWrapState#38;
                          call2formal#AT#owns := owns#39;
                          assert $pre_static_wrap($s);
                          assert $is_non_primitive($typ(call0formal#AT#o));
                          assert $mutable($s, call0formal#AT#o);
                          call3old#AT#$s := $s;
                          havoc $s;
                          assume $is_wrapped(call3old#AT#$s, $s, call0formal#AT#o, call2formal#AT#owns);
                          assume $heap($s)
   == $update($heap(call3old#AT#$s), 
    call0formal#AT#o, 
    $f_owns($typ(call0formal#AT#o)), 
    $ptrset_to_int(call2formal#AT#owns));
                          assume $f_owner($s) == $f_owner(call1formal#AT#S);
                        }
                        **** end desugaring */
                        assume $good_state_ext(#tok$1^187.36, $s);
                        assert $set_eq($owns($s, $phys_ptr_cast(L#p, ^Node)), $set_empty());
                        assume $full_stop($s);
                        goto #break_11;
                    }
                    else
                    {
                      anon28:
                    }
                }
                else
                {
                  anon30:
                    assert false;
                    assume false;
                }
            }

          anon33:
            assert F#doMark($phys_ptr_cast(L#p, ^Node));
            assert F#doMark($phys_ptr_cast(L#n, ^Node));
            assume F#doMark($phys_ptr_cast(L#p, ^Node)) && F#doMark($phys_ptr_cast(L#n, ^Node));
            assume $local_value_is($s, 
  #tok$1^194.37, 
  #loc.res_lambda#7#20, 
  $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#7#20), 
  $map_t($ptr_to(^Node), ^^bool));
            assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
            call res_lambda#7#20 := lambda#7($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
  $phys_ptr_cast(L#n, ^Node)), $phys_ptr_cast(P#x, ^Node));
            /*** desugaring:
            {
              var call0formal#AT##l1: $map_t..$ptr_to..^Node.^^bool;
              var call1formal#AT##l0: $ptr;
              var call2formal#AT#$result: $map_t..$ptr_to..^Node.^^bool;
              call0formal#AT##l1 := $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
  $phys_ptr_cast(L#n, ^Node));
              call1formal#AT##l0 := $phys_ptr_cast(P#x, ^Node);
              havoc call2formal#AT#$result;
              assume call2formal#AT#$result == F#lambda#7(call0formal#AT##l1, call1formal#AT##l0);
              assume $call_transition($s, $s);
              res_lambda#7#20 := call2formal#AT#$result;
            }
            **** end desugaring */
            assume $full_stop_ext(#tok$1^194.37, $s);
            assume $local_value_is($s, 
  #tok$1^194.37, 
  #loc.res_lambda#7#20, 
  $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#7#20), 
  $map_t($ptr_to(^Node), ^^bool));
            assert $writable_prim($s, #wrTime$1^168.28, $dot($phys_ptr_cast(P#t, ^Tree), Tree.R));
            assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
            call $write_int(Tree.R, $phys_ptr_cast(P#t, ^Tree), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $phys_ptr_cast(L#n, ^Node), 
    res_lambda#7#20)));
            /*** desugaring:
            {
              var call0formal#AT#f: $field;
              var call1formal#AT#p: $ptr;
              var call2formal#AT#v: int;
              var call3old#AT#$s: $state;
              call0formal#AT#f := Tree.R;
              call1formal#AT#p := $phys_ptr_cast(P#t, ^Tree);
              call2formal#AT#v := $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $phys_ptr_cast(L#n, ^Node), 
    res_lambda#7#20));
              call3old#AT#$s := $s;
              havoc $s;
              assume $specials_eq(call3old#AT#$s, $s);
              assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
              assume $timestamp_post_strict(call3old#AT#$s, $s);
            }
            **** end desugaring */
            assume $full_stop_ext(#tok$1^194.27, $s);
            L#p := $phys_ptr_cast(L#n, ^Node);
            assume $local_value_is($s, #tok$1^195.5, #loc.p, $ptr_to_int(L#p), $ptr_to(^Node));
        }
        else
        {
          anon34:
            goto #break_11;
        }

      #continue_11:
        assume true;
    }

  anon38:
    assume $full_stop_ext(#tok$1^167.3, $s);

  #break_11:
    assert $writable_prim($s, #wrTime$1^134.1, $dot($phys_ptr_cast(P#x, ^Node), Node.parent));
    call $write_int(Node.parent, $phys_ptr_cast(P#x, ^Node), $ptr_to_int($phys_ptr_cast(L#p, ^Node)));
    /*** desugaring:
    {
      var call0formal#AT#f: $field;
      var call1formal#AT#p: $ptr;
      var call2formal#AT#v: int;
      var call3old#AT#$s: $state;
      call0formal#AT#f := Node.parent;
      call1formal#AT#p := $phys_ptr_cast(P#x, ^Node);
      call2formal#AT#v := $ptr_to_int($phys_ptr_cast(L#p, ^Node));
      call3old#AT#$s := $s;
      havoc $s;
      assume $specials_eq(call3old#AT#$s, $s);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
      assume $timestamp_post_strict(call3old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^198.3, $s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#43, $state_to_int(prestate#43), ^$#state_t);
    prestate#43 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#43, $state_to_int(prestate#43), ^$#state_t);
    assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#41, 
  $state_to_int(staticWrapState#41), 
  ^$#state_t);
    staticWrapState#41 := $current_state($s);
    assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#41, 
  $state_to_int(staticWrapState#41), 
  ^$#state_t);
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#42, $ptrset_to_int(owns#42), ^$#ptrset);
    owns#42 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#42, $ptrset_to_int(owns#42), ^$#ptrset);
    assert $top_writable($s, #wrTime$1^134.1, $phys_ptr_cast(P#x, ^Node));
    assume $pre_static_wrap($s);
    call $static_wrap($phys_ptr_cast(P#x, ^Node), staticWrapState#41, owns#42);
    /*** desugaring:
    {
      var call0formal#AT#o: $ptr;
      var call1formal#AT#S: $state;
      var call2formal#AT#owns: $ptrset;
      var call3old#AT#$s: $state;
      call0formal#AT#o := $phys_ptr_cast(P#x, ^Node);
      call1formal#AT#S := staticWrapState#41;
      call2formal#AT#owns := owns#42;
      assert $pre_static_wrap($s);
      assert $is_non_primitive($typ(call0formal#AT#o));
      assert $mutable($s, call0formal#AT#o);
      call3old#AT#$s := $s;
      havoc $s;
      assume $is_wrapped(call3old#AT#$s, $s, call0formal#AT#o, call2formal#AT#owns);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), 
    call0formal#AT#o, 
    $f_owns($typ(call0formal#AT#o)), 
    $ptrset_to_int(call2formal#AT#owns));
      assume $f_owner($s) == $f_owner(call1formal#AT#S);
    }
    **** end desugaring */
    assume $good_state_ext(#tok$1^199.19, $s);
    assert $set_eq($owns($s, $phys_ptr_cast(P#x, ^Node)), $set_empty());
    assume $full_stop($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#44, $state_to_int(prestate#44), ^$#state_t);
    prestate#44 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#44, $state_to_int(prestate#44), ^$#state_t);
    assume $pre_wrap($s);
    assert $top_writable($s, #wrTime$1^134.1, $phys_ptr_cast(P#t, ^Tree));
    assert (forall #writes$1^200.19: $ptr :: 
  { $dont_instantiate(#writes$1^200.19) } 
  $set_in(#writes$1^200.19, $owns($s, $phys_ptr_cast(P#t, ^Tree)))
     ==> $top_writable($s, #wrTime$1^134.1, #writes$1^200.19));
    call $wrap($phys_ptr_cast(P#t, ^Tree), ^Tree);
    /*** desugaring:
    {
      var call0formal#AT#o: $ptr;
      var call1formal#AT#T: $ctype;
      var call2old#AT#$s: $state;
      call0formal#AT#o := $phys_ptr_cast(P#t, ^Tree);
      call1formal#AT#T := ^Tree;
      assert $pre_wrap($s);
      assert $is_non_primitive($typ(call0formal#AT#o));
      assert $mutable($s, call0formal#AT#o);
      assert (forall p: $ptr :: 
  { $dont_instantiate(p) } 
  $set_in0(p, $owns($s, call0formal#AT#o)) ==> $wrapped($s, p, $typ(p)));
      call2old#AT#$s := $s;
      havoc $s;
      assume $is_wrapped_dynamic(call2old#AT#$s, $s, call0formal#AT#o);
    }
    **** end desugaring */
    assume $good_state_ext(#tok$1^200.19, $s);
    assert !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
  $phys_ptr_cast($null, ^Node));
    assert $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node))
   ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
      $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
    $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
    assert $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node))
   ==> $is_null($rd_phys_ptr($s, 
      Node.parent, 
      $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node), 
      ^Node));
    assert (forall Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast($null, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
      $phys_ptr_cast($null, ^Node)), 
    $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
     ==> 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
       < $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
     ==> 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
       > $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    assert (forall Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
    { F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
    { sk_hack(F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     <==> $set_in($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node), $owns($s, $phys_ptr_cast(P#t, ^Tree))));
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $rd_phys_ptr($s, 
        Node.parent, 
        $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
        ^Node)
       == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $rd_phys_ptr($s, 
        Node.parent, 
        $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
        ^Node)
       == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.parent, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.parent, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $rd_phys_ptr($s, 
          Node.left, 
          $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
          ^Node)
         == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)
       || $rd_phys_ptr($s, 
          Node.right, 
          $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
          ^Node)
         == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    assert true;
    assert (forall Q#m$1^83.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
      $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))
     ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)))
       == $rd_inv($s, Node.value, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)));
    assert (forall Q#k$1^83.29#tc2: int :: 
  {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
      Q#k$1^83.29#tc2) } 
  $in_range_i4(Q#k$1^83.29#tc2)
     ==> 
    (forall Q#m$1^83.29#dt1: $ptr :: 
      {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) } 
      $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))
         ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) != Q#k$1^83.29#tc2)
     ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
        Q#k$1^83.29#tc2)
       == 0);
    assert (forall Q#n$1^84.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node))
       && $is_null($rd_phys_ptr($s, 
          Node.parent, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)
       || $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)
         == $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
    assert (forall Q#n$1^84.29#dt1: $ptr, Q#m$1^84.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), 
      $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), 
      $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node))
     <==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node))
       && (
        ($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)
           && $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node))
         || $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)
         || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), 
          $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node))
         || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), 
          $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node))));
    assume $full_stop($s);
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure left_rotate(P#t: $ptr, P#x: $ptr);
  requires $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
  $phys_ptr_cast(P#x, ^Node));
  requires $non_null($rd_phys_ptr($s, Node.right, $phys_ptr_cast(P#x, ^Node), ^Node));
  requires $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
  modifies $s, $cev_pc;
  ensures $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(old($s), Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
      $rd_phys_ptr(old($s), Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
    $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
      $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)))
   && $eq.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv(old($s), Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
    $int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))));
  ensures $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#t, ^Tree)));
  free ensures $call_transition(old($s), $s);



implementation left_rotate(P#t: $ptr, P#x: $ptr)
{
  var prestate#70: $state;
  var res_lambda#8#21: $map_t..$ptr_to..^Node.^^bool;
  var owns#68: $ptrset;
  var staticWrapState#67: $state;
  var prestate#69: $state;
  var owns#65: $ptrset;
  var staticWrapState#64: $state;
  var prestate#66: $state;
  var owns#62: $ptrset;
  var staticWrapState#61: $state;
  var prestate#63: $state;
  var prestate#60: $state;
  var prestate#58: $state;
  var owns#59: $ptrset;
  var owns#56: $ptrset;
  var staticWrapState#55: $state;
  var prestate#57: $state;
  var prestate#54: $state;
  var prestate#52: $state;
  var owns#53: $ptrset;
  var prestate#51: $state;
  var prestate#49: $state;
  var owns#50: $ptrset;
  var prestate#48: $state;
  var prestate#46: $state;
  var owns#47: $ptrset;
  var prestate#45: $state;
  var L#y: $ptr;
  var #wrTime$1^203.1: int;
  var #stackframe: int;

  anon46:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^203.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^203.1, #loc.t, $ptr_to_int(P#t), $ptr_to(^Tree));
    assume $local_value_is($s, #tok$1^203.1, #loc.x, $ptr_to_int(P#x), $ptr_to(^Node));
    assume #wrTime$1^203.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^203.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#t, ^Tree)));
    assume $thread_owned($s, $phys_ptr_cast(P#t, ^Tree));
    assume true;
    assume true;
    assume 2147483647 == $decreases_level;
    assert $in_domain_lab($s, $phys_ptr_cast(P#t, ^Tree), $phys_ptr_cast(P#t, ^Tree), l#public);
    assume $local_value_is($s, #tok$1^209.3, #loc.y, $ptr_to_int(L#y), $ptr_to(^Node));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#45, $state_to_int(prestate#45), ^$#state_t);
    prestate#45 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#45, $state_to_int(prestate#45), ^$#state_t);
    assert $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
    assume $inv($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
    assume $pre_unwrap($s);
    assert $top_writable($s, #wrTime$1^203.1, $phys_ptr_cast(P#t, ^Tree));
    call $unwrap($phys_ptr_cast(P#t, ^Tree), ^Tree);
    /*** desugaring:
    {
      var call0formal#AT#o: $ptr;
      var call1formal#AT#T: $ctype;
      var call2old#AT#$s: $state;
      call0formal#AT#o := $phys_ptr_cast(P#t, ^Tree);
      call1formal#AT#T := ^Tree;
      assert !$is_claimable(call1formal#AT#T) || $ref_cnt($s, call0formal#AT#o) == 0;
      assert $pre_unwrap($s);
      call2old#AT#$s := $s;
      havoc $s;
      assume $is_unwrapped_dynamic(call2old#AT#$s, $s, call0formal#AT#o);
    }
    **** end desugaring */
    assume $good_state_ext(#tok$1^211.19, $s);
    assume $full_stop($s);
    assert F#doMark($phys_ptr_cast(P#x, ^Node));
    assume F#doMark($phys_ptr_cast(P#x, ^Node));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#47, $ptrset_to_int(owns#47), ^$#ptrset);
    owns#47 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#47, $ptrset_to_int(owns#47), ^$#ptrset);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#46, $state_to_int(prestate#46), ^$#state_t);
    prestate#46 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#46, $state_to_int(prestate#46), ^$#state_t);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#48, $state_to_int(prestate#48), ^$#state_t);
    prestate#48 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#48, $state_to_int(prestate#48), ^$#state_t);
    assert $wrapped($s, $phys_ptr_cast(P#x, ^Node), ^Node);
    assert $top_writable($s, #wrTime$1^203.1, $phys_ptr_cast(P#x, ^Node));
    assume $inv($s, $phys_ptr_cast(P#x, ^Node), ^Node);
    assume owns#47 == $owns($s, $phys_ptr_cast(P#x, ^Node));
    assume $pre_static_unwrap($s);
    call $static_unwrap($phys_ptr_cast(P#x, ^Node), prestate#48);
    /*** desugaring:
    {
      var call0formal#AT#o: $ptr;
      var call1formal#AT#S: $state;
      var call2old#AT#$s: $state;
      call0formal#AT#o := $phys_ptr_cast(P#x, ^Node);
      call1formal#AT#S := prestate#48;
      assert !$is_claimable($typ(call0formal#AT#o)) || $ref_cnt($s, call0formal#AT#o) == 0;
      assert $pre_static_unwrap($s);
      call2old#AT#$s := $s;
      havoc $s;
      assume $is_unwrapped(call2old#AT#$s, $s, call0formal#AT#o);
      assume $f_owner($s) == $f_owner(call1formal#AT#S);
      assume $f_timestamp($s)
   == $f_timestamp(call1formal#AT#S)[call0formal#AT#o := $current_timestamp(call2old#AT#$s)];
    }
    **** end desugaring */
    assume $good_state_ext(#tok$1^212.53, $s);
    assume $full_stop($s);
    assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
    L#y := $rd_phys_ptr($s, Node.right, $phys_ptr_cast(P#x, ^Node), ^Node);
    assume $local_value_is($s, #tok$1^213.3, #loc.y, $ptr_to_int(L#y), $ptr_to(^Node));
    assert F#doMark($phys_ptr_cast(L#y, ^Node));
    assume F#doMark($phys_ptr_cast(L#y, ^Node));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#50, $ptrset_to_int(owns#50), ^$#ptrset);
    owns#50 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#50, $ptrset_to_int(owns#50), ^$#ptrset);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#49, $state_to_int(prestate#49), ^$#state_t);
    prestate#49 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#49, $state_to_int(prestate#49), ^$#state_t);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#51, $state_to_int(prestate#51), ^$#state_t);
    prestate#51 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#51, $state_to_int(prestate#51), ^$#state_t);
    assert $wrapped($s, $phys_ptr_cast(L#y, ^Node), ^Node);
    assert $top_writable($s, #wrTime$1^203.1, $phys_ptr_cast(L#y, ^Node));
    assume $inv($s, $phys_ptr_cast(L#y, ^Node), ^Node);
    assume owns#50 == $owns($s, $phys_ptr_cast(L#y, ^Node));
    assume $pre_static_unwrap($s);
    call $static_unwrap($phys_ptr_cast(L#y, ^Node), prestate#51);
    /*** desugaring:
    {
      var call0formal#AT#o: $ptr;
      var call1formal#AT#S: $state;
      var call2old#AT#$s: $state;
      call0formal#AT#o := $phys_ptr_cast(L#y, ^Node);
      call1formal#AT#S := prestate#51;
      assert !$is_claimable($typ(call0formal#AT#o)) || $ref_cnt($s, call0formal#AT#o) == 0;
      assert $pre_static_unwrap($s);
      call2old#AT#$s := $s;
      havoc $s;
      assume $is_unwrapped(call2old#AT#$s, $s, call0formal#AT#o);
      assume $f_owner($s) == $f_owner(call1formal#AT#S);
      assume $f_timestamp($s)
   == $f_timestamp(call1formal#AT#S)[call0formal#AT#o := $current_timestamp(call2old#AT#$s)];
    }
    **** end desugaring */
    assume $good_state_ext(#tok$1^214.53, $s);
    assume $full_stop($s);
    assert $writable_prim($s, #wrTime$1^203.1, $dot($phys_ptr_cast(P#x, ^Node), Node.right));
    assert $thread_local($s, $phys_ptr_cast(L#y, ^Node));
    call $write_int(Node.right, $phys_ptr_cast(P#x, ^Node), $ptr_to_int($rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node)));
    /*** desugaring:
    {
      var call0formal#AT#f: $field;
      var call1formal#AT#p: $ptr;
      var call2formal#AT#v: int;
      var call3old#AT#$s: $state;
      call0formal#AT#f := Node.right;
      call1formal#AT#p := $phys_ptr_cast(P#x, ^Node);
      call2formal#AT#v := $ptr_to_int($rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node));
      call3old#AT#$s := $s;
      havoc $s;
      assume $specials_eq(call3old#AT#$s, $s);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
      assume $timestamp_post_strict(call3old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^216.3, $s);
    assert $thread_local($s, $phys_ptr_cast(L#y, ^Node));
    assume true;
    if ($non_null($rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node)))
    {
      anon39:
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#53, $ptrset_to_int(owns#53), ^$#ptrset);
        owns#53 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#53, $ptrset_to_int(owns#53), ^$#ptrset);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#52, $state_to_int(prestate#52), ^$#state_t);
        prestate#52 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#52, $state_to_int(prestate#52), ^$#state_t);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#54, $state_to_int(prestate#54), ^$#state_t);
        prestate#54 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#54, $state_to_int(prestate#54), ^$#state_t);
        assert $wrapped($s, $rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node), ^Node);
        assert $top_writable($s, 
  #wrTime$1^203.1, 
  $rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node));
        assume $inv($s, $rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node), ^Node);
        assume owns#53
   == $owns($s, $rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node));
        assume $pre_static_unwrap($s);
        call $static_unwrap($rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node), prestate#54);
        /*** desugaring:
        {
          var call0formal#AT#o: $ptr;
          var call1formal#AT#S: $state;
          var call2old#AT#$s: $state;
          call0formal#AT#o := $rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node);
          call1formal#AT#S := prestate#54;
          assert !$is_claimable($typ(call0formal#AT#o)) || $ref_cnt($s, call0formal#AT#o) == 0;
          assert $pre_static_unwrap($s);
          call2old#AT#$s := $s;
          havoc $s;
          assume $is_unwrapped(call2old#AT#$s, $s, call0formal#AT#o);
          assume $f_owner($s) == $f_owner(call1formal#AT#S);
          assume $f_timestamp($s)
   == $f_timestamp(call1formal#AT#S)[call0formal#AT#o := $current_timestamp(call2old#AT#$s)];
        }
        **** end desugaring */
        assume $good_state_ext(#tok$1^218.34, $s);
        assume $full_stop($s);
        assert $writable_prim($s, 
  #wrTime$1^203.1, 
  $dot($rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node), Node.parent));
        assert $thread_local($s, $phys_ptr_cast(L#y, ^Node));
        call $write_int(Node.parent, $rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node), $ptr_to_int($phys_ptr_cast(P#x, ^Node)));
        /*** desugaring:
        {
          var call0formal#AT#f: $field;
          var call1formal#AT#p: $ptr;
          var call2formal#AT#v: int;
          var call3old#AT#$s: $state;
          call0formal#AT#f := Node.parent;
          call1formal#AT#p := $rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node);
          call2formal#AT#v := $ptr_to_int($phys_ptr_cast(P#x, ^Node));
          call3old#AT#$s := $s;
          havoc $s;
          assume $specials_eq(call3old#AT#$s, $s);
          assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
          assume $timestamp_post_strict(call3old#AT#$s, $s);
        }
        **** end desugaring */
        assume $full_stop_ext(#tok$1^218.43, $s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#57, $state_to_int(prestate#57), ^$#state_t);
        prestate#57 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#57, $state_to_int(prestate#57), ^$#state_t);
        assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#55, 
  $state_to_int(staticWrapState#55), 
  ^$#state_t);
        staticWrapState#55 := $current_state($s);
        assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#55, 
  $state_to_int(staticWrapState#55), 
  ^$#state_t);
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#56, $ptrset_to_int(owns#56), ^$#ptrset);
        owns#56 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#56, $ptrset_to_int(owns#56), ^$#ptrset);
        assert $top_writable($s, 
  #wrTime$1^203.1, 
  $rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node));
        assume $pre_static_wrap($s);
        call $static_wrap($rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node), staticWrapState#55, owns#56);
        /*** desugaring:
        {
          var call0formal#AT#o: $ptr;
          var call1formal#AT#S: $state;
          var call2formal#AT#owns: $ptrset;
          var call3old#AT#$s: $state;
          call0formal#AT#o := $rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node);
          call1formal#AT#S := staticWrapState#55;
          call2formal#AT#owns := owns#56;
          assert $pre_static_wrap($s);
          assert $is_non_primitive($typ(call0formal#AT#o));
          assert $mutable($s, call0formal#AT#o);
          call3old#AT#$s := $s;
          havoc $s;
          assume $is_wrapped(call3old#AT#$s, $s, call0formal#AT#o, call2formal#AT#owns);
          assume $heap($s)
   == $update($heap(call3old#AT#$s), 
    call0formal#AT#o, 
    $f_owns($typ(call0formal#AT#o)), 
    $ptrset_to_int(call2formal#AT#owns));
          assume $f_owner($s) == $f_owner(call1formal#AT#S);
        }
        **** end desugaring */
        assume $good_state_ext(#tok$1^218.34, $s);
        assert $set_eq($owns($s, $rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node)), 
  $set_empty());
        assume $full_stop($s);
    }
    else
    {
      anon40:
    }

  anon47:
    assert $writable_prim($s, #wrTime$1^203.1, $dot($phys_ptr_cast(L#y, ^Node), Node.parent));
    assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
    call $write_int(Node.parent, $phys_ptr_cast(L#y, ^Node), $ptr_to_int($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node)));
    /*** desugaring:
    {
      var call0formal#AT#f: $field;
      var call1formal#AT#p: $ptr;
      var call2formal#AT#v: int;
      var call3old#AT#$s: $state;
      call0formal#AT#f := Node.parent;
      call1formal#AT#p := $phys_ptr_cast(L#y, ^Node);
      call2formal#AT#v := $ptr_to_int($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node));
      call3old#AT#$s := $s;
      havoc $s;
      assume $specials_eq(call3old#AT#$s, $s);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
      assume $timestamp_post_strict(call3old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^219.3, $s);
    assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
    assume true;
    if ($is_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node)))
    {
      anon41:
        assert $writable_prim($s, #wrTime$1^203.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.root));
        call $write_int(Tree.root, $phys_ptr_cast(P#t, ^Tree), $ptr_to_int($phys_ptr_cast(L#y, ^Node)));
        /*** desugaring:
        {
          var call0formal#AT#f: $field;
          var call1formal#AT#p: $ptr;
          var call2formal#AT#v: int;
          var call3old#AT#$s: $state;
          call0formal#AT#f := Tree.root;
          call1formal#AT#p := $phys_ptr_cast(P#t, ^Tree);
          call2formal#AT#v := $ptr_to_int($phys_ptr_cast(L#y, ^Node));
          call3old#AT#$s := $s;
          havoc $s;
          assume $specials_eq(call3old#AT#$s, $s);
          assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
          assume $timestamp_post_strict(call3old#AT#$s, $s);
        }
        **** end desugaring */
        assume $full_stop_ext(#tok$1^221.5, $s);
    }
    else
    {
      anon44:
        assert F#doMark($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node));
        assume F#doMark($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node));
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#59, $ptrset_to_int(owns#59), ^$#ptrset);
        owns#59 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#59, $ptrset_to_int(owns#59), ^$#ptrset);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#58, $state_to_int(prestate#58), ^$#state_t);
        prestate#58 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#58, $state_to_int(prestate#58), ^$#state_t);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#60, $state_to_int(prestate#60), ^$#state_t);
        prestate#60 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#60, $state_to_int(prestate#60), ^$#state_t);
        assert $wrapped($s, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node), ^Node);
        assert $top_writable($s, 
  #wrTime$1^203.1, 
  $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node));
        assume $inv($s, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node), ^Node);
        assume owns#59
   == $owns($s, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node));
        assume $pre_static_unwrap($s);
        call $static_unwrap($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node), prestate#60);
        /*** desugaring:
        {
          var call0formal#AT#o: $ptr;
          var call1formal#AT#S: $state;
          var call2old#AT#$s: $state;
          call0formal#AT#o := $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node);
          call1formal#AT#S := prestate#60;
          assert !$is_claimable($typ(call0formal#AT#o)) || $ref_cnt($s, call0formal#AT#o) == 0;
          assert $pre_static_unwrap($s);
          call2old#AT#$s := $s;
          havoc $s;
          assume $is_unwrapped(call2old#AT#$s, $s, call0formal#AT#o);
          assume $f_owner($s) == $f_owner(call1formal#AT#S);
          assume $f_timestamp($s)
   == $f_timestamp(call1formal#AT#S)[call0formal#AT#o := $current_timestamp(call2old#AT#$s)];
        }
        **** end desugaring */
        assume $good_state_ext(#tok$1^224.32, $s);
        assume $full_stop($s);
        assert $thread_local($s, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node));
        assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
        assume true;
        if ($ptr_eq($rd_phys_ptr($s, 
    Node.left, 
    $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node), 
    ^Node), 
  $phys_ptr_cast(P#x, ^Node)))
        {
          anon42:
            assert $writable_prim($s, 
  #wrTime$1^203.1, 
  $dot($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node), Node.left));
            assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
            call $write_int(Node.left, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node), $ptr_to_int($phys_ptr_cast(L#y, ^Node)));
            /*** desugaring:
            {
              var call0formal#AT#f: $field;
              var call1formal#AT#p: $ptr;
              var call2formal#AT#v: int;
              var call3old#AT#$s: $state;
              call0formal#AT#f := Node.left;
              call1formal#AT#p := $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node);
              call2formal#AT#v := $ptr_to_int($phys_ptr_cast(L#y, ^Node));
              call3old#AT#$s := $s;
              havoc $s;
              assume $specials_eq(call3old#AT#$s, $s);
              assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
              assume $timestamp_post_strict(call3old#AT#$s, $s);
            }
            **** end desugaring */
            assume $full_stop_ext(#tok$1^226.9, $s);
        }
        else
        {
          anon43:
            assert $writable_prim($s, 
  #wrTime$1^203.1, 
  $dot($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node), Node.right));
            assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
            call $write_int(Node.right, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node), $ptr_to_int($phys_ptr_cast(L#y, ^Node)));
            /*** desugaring:
            {
              var call0formal#AT#f: $field;
              var call1formal#AT#p: $ptr;
              var call2formal#AT#v: int;
              var call3old#AT#$s: $state;
              call0formal#AT#f := Node.right;
              call1formal#AT#p := $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node);
              call2formal#AT#v := $ptr_to_int($phys_ptr_cast(L#y, ^Node));
              call3old#AT#$s := $s;
              havoc $s;
              assume $specials_eq(call3old#AT#$s, $s);
              assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
              assume $timestamp_post_strict(call3old#AT#$s, $s);
            }
            **** end desugaring */
            assume $full_stop_ext(#tok$1^228.9, $s);
        }

      anon45:
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#63, $state_to_int(prestate#63), ^$#state_t);
        prestate#63 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#63, $state_to_int(prestate#63), ^$#state_t);
        assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#61, 
  $state_to_int(staticWrapState#61), 
  ^$#state_t);
        staticWrapState#61 := $current_state($s);
        assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#61, 
  $state_to_int(staticWrapState#61), 
  ^$#state_t);
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#62, $ptrset_to_int(owns#62), ^$#ptrset);
        owns#62 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#62, $ptrset_to_int(owns#62), ^$#ptrset);
        assert $top_writable($s, 
  #wrTime$1^203.1, 
  $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node));
        assume $pre_static_wrap($s);
        call $static_wrap($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node), staticWrapState#61, owns#62);
        /*** desugaring:
        {
          var call0formal#AT#o: $ptr;
          var call1formal#AT#S: $state;
          var call2formal#AT#owns: $ptrset;
          var call3old#AT#$s: $state;
          call0formal#AT#o := $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node);
          call1formal#AT#S := staticWrapState#61;
          call2formal#AT#owns := owns#62;
          assert $pre_static_wrap($s);
          assert $is_non_primitive($typ(call0formal#AT#o));
          assert $mutable($s, call0formal#AT#o);
          call3old#AT#$s := $s;
          havoc $s;
          assume $is_wrapped(call3old#AT#$s, $s, call0formal#AT#o, call2formal#AT#owns);
          assume $heap($s)
   == $update($heap(call3old#AT#$s), 
    call0formal#AT#o, 
    $f_owns($typ(call0formal#AT#o)), 
    $ptrset_to_int(call2formal#AT#owns));
          assume $f_owner($s) == $f_owner(call1formal#AT#S);
        }
        **** end desugaring */
        assume $good_state_ext(#tok$1^224.32, $s);
        assert $set_eq($owns($s, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node)), 
  $set_empty());
        assume $full_stop($s);
    }

  anon48:
    assert $writable_prim($s, #wrTime$1^203.1, $dot($phys_ptr_cast(L#y, ^Node), Node.left));
    call $write_int(Node.left, $phys_ptr_cast(L#y, ^Node), $ptr_to_int($phys_ptr_cast(P#x, ^Node)));
    /*** desugaring:
    {
      var call0formal#AT#f: $field;
      var call1formal#AT#p: $ptr;
      var call2formal#AT#v: int;
      var call3old#AT#$s: $state;
      call0formal#AT#f := Node.left;
      call1formal#AT#p := $phys_ptr_cast(L#y, ^Node);
      call2formal#AT#v := $ptr_to_int($phys_ptr_cast(P#x, ^Node));
      call3old#AT#$s := $s;
      havoc $s;
      assume $specials_eq(call3old#AT#$s, $s);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
      assume $timestamp_post_strict(call3old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^231.3, $s);
    assert $writable_prim($s, #wrTime$1^203.1, $dot($phys_ptr_cast(P#x, ^Node), Node.parent));
    call $write_int(Node.parent, $phys_ptr_cast(P#x, ^Node), $ptr_to_int($phys_ptr_cast(L#y, ^Node)));
    /*** desugaring:
    {
      var call0formal#AT#f: $field;
      var call1formal#AT#p: $ptr;
      var call2formal#AT#v: int;
      var call3old#AT#$s: $state;
      call0formal#AT#f := Node.parent;
      call1formal#AT#p := $phys_ptr_cast(P#x, ^Node);
      call2formal#AT#v := $ptr_to_int($phys_ptr_cast(L#y, ^Node));
      call3old#AT#$s := $s;
      havoc $s;
      assume $specials_eq(call3old#AT#$s, $s);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
      assume $timestamp_post_strict(call3old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^232.3, $s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#66, $state_to_int(prestate#66), ^$#state_t);
    prestate#66 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#66, $state_to_int(prestate#66), ^$#state_t);
    assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#64, 
  $state_to_int(staticWrapState#64), 
  ^$#state_t);
    staticWrapState#64 := $current_state($s);
    assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#64, 
  $state_to_int(staticWrapState#64), 
  ^$#state_t);
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#65, $ptrset_to_int(owns#65), ^$#ptrset);
    owns#65 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#65, $ptrset_to_int(owns#65), ^$#ptrset);
    assert $top_writable($s, #wrTime$1^203.1, $phys_ptr_cast(P#x, ^Node));
    assume $pre_static_wrap($s);
    call $static_wrap($phys_ptr_cast(P#x, ^Node), staticWrapState#64, owns#65);
    /*** desugaring:
    {
      var call0formal#AT#o: $ptr;
      var call1formal#AT#S: $state;
      var call2formal#AT#owns: $ptrset;
      var call3old#AT#$s: $state;
      call0formal#AT#o := $phys_ptr_cast(P#x, ^Node);
      call1formal#AT#S := staticWrapState#64;
      call2formal#AT#owns := owns#65;
      assert $pre_static_wrap($s);
      assert $is_non_primitive($typ(call0formal#AT#o));
      assert $mutable($s, call0formal#AT#o);
      call3old#AT#$s := $s;
      havoc $s;
      assume $is_wrapped(call3old#AT#$s, $s, call0formal#AT#o, call2formal#AT#owns);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), 
    call0formal#AT#o, 
    $f_owns($typ(call0formal#AT#o)), 
    $ptrset_to_int(call2formal#AT#owns));
      assume $f_owner($s) == $f_owner(call1formal#AT#S);
    }
    **** end desugaring */
    assume $good_state_ext(#tok$1^233.19, $s);
    assert $set_eq($owns($s, $phys_ptr_cast(P#x, ^Node)), $set_empty());
    assume $full_stop($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#69, $state_to_int(prestate#69), ^$#state_t);
    prestate#69 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#69, $state_to_int(prestate#69), ^$#state_t);
    assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#67, 
  $state_to_int(staticWrapState#67), 
  ^$#state_t);
    staticWrapState#67 := $current_state($s);
    assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#67, 
  $state_to_int(staticWrapState#67), 
  ^$#state_t);
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#68, $ptrset_to_int(owns#68), ^$#ptrset);
    owns#68 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#68, $ptrset_to_int(owns#68), ^$#ptrset);
    assert $top_writable($s, #wrTime$1^203.1, $phys_ptr_cast(L#y, ^Node));
    assume $pre_static_wrap($s);
    call $static_wrap($phys_ptr_cast(L#y, ^Node), staticWrapState#67, owns#68);
    /*** desugaring:
    {
      var call0formal#AT#o: $ptr;
      var call1formal#AT#S: $state;
      var call2formal#AT#owns: $ptrset;
      var call3old#AT#$s: $state;
      call0formal#AT#o := $phys_ptr_cast(L#y, ^Node);
      call1formal#AT#S := staticWrapState#67;
      call2formal#AT#owns := owns#68;
      assert $pre_static_wrap($s);
      assert $is_non_primitive($typ(call0formal#AT#o));
      assert $mutable($s, call0formal#AT#o);
      call3old#AT#$s := $s;
      havoc $s;
      assume $is_wrapped(call3old#AT#$s, $s, call0formal#AT#o, call2formal#AT#owns);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), 
    call0formal#AT#o, 
    $f_owns($typ(call0formal#AT#o)), 
    $ptrset_to_int(call2formal#AT#owns));
      assume $f_owner($s) == $f_owner(call1formal#AT#S);
    }
    **** end desugaring */
    assume $good_state_ext(#tok$1^233.43, $s);
    assert $set_eq($owns($s, $phys_ptr_cast(L#y, ^Node)), $set_empty());
    assume $full_stop($s);
    assert F#doMark($rd_phys_ptr($s, Node.right, $phys_ptr_cast(P#x, ^Node), ^Node));
    assume F#doMark($rd_phys_ptr($s, Node.right, $phys_ptr_cast(P#x, ^Node), ^Node));
    assert (forall Q#m$1^236.26#dt1: $ptr :: 
  {:weight 10} { sk_hack($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $phys_ptr_cast(L#y, ^Node)), 
        $phys_ptr_cast(Q#m$1^236.26#dt1, ^Node))) } 
    { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Node.right, $phys_ptr_cast(P#x, ^Node), ^Node)), 
      $phys_ptr_cast(Q#m$1^236.26#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Node.right, $phys_ptr_cast(P#x, ^Node), ^Node)), 
      $phys_ptr_cast(Q#m$1^236.26#dt1, ^Node))
     ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^236.26#dt1, ^Node))
       > $rd_inv($s, Node.key, $phys_ptr_cast(P#x, ^Node)));
    assume (forall Q#m$1^236.26#dt1: $ptr :: 
  {:weight 10} { sk_hack($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $phys_ptr_cast(L#y, ^Node)), 
        $phys_ptr_cast(Q#m$1^236.26#dt1, ^Node))) } 
    { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Node.right, $phys_ptr_cast(P#x, ^Node), ^Node)), 
      $phys_ptr_cast(Q#m$1^236.26#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Node.right, $phys_ptr_cast(P#x, ^Node), ^Node)), 
      $phys_ptr_cast(Q#m$1^236.26#dt1, ^Node))
     ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^236.26#dt1, ^Node))
       > $rd_inv($s, Node.key, $phys_ptr_cast(P#x, ^Node)));
    assert $writable_prim($s, #wrTime$1^203.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.R));
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    call $write_int(Tree.R, $phys_ptr_cast(P#t, ^Tree), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $phys_ptr_cast(L#y, ^Node), 
    $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
      $phys_ptr_cast(P#x, ^Node)))));
    /*** desugaring:
    {
      var call0formal#AT#f: $field;
      var call1formal#AT#p: $ptr;
      var call2formal#AT#v: int;
      var call3old#AT#$s: $state;
      call0formal#AT#f := Tree.R;
      call1formal#AT#p := $phys_ptr_cast(P#t, ^Tree);
      call2formal#AT#v := $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $phys_ptr_cast(L#y, ^Node), 
    $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
      $phys_ptr_cast(P#x, ^Node))));
      call3old#AT#$s := $s;
      havoc $s;
      assume $specials_eq(call3old#AT#$s, $s);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
      assume $timestamp_post_strict(call3old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^239.5, $s);
    assume $local_value_is($s, 
  #tok$1^240.15, 
  #loc.res_lambda#8#21, 
  $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#8#21), 
  $map_t($ptr_to(^Node), ^^bool));
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
    call res_lambda#8#21 := lambda#8($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
  $rd_phys_ptr($s, Node.right, $phys_ptr_cast(P#x, ^Node), ^Node)), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
  $rd_phys_ptr($s, Node.left, $phys_ptr_cast(P#x, ^Node), ^Node)), $phys_ptr_cast(P#x, ^Node));
    /*** desugaring:
    {
      var call0formal#AT##l2: $map_t..$ptr_to..^Node.^^bool;
      var call1formal#AT##l1: $map_t..$ptr_to..^Node.^^bool;
      var call2formal#AT##l0: $ptr;
      var call3formal#AT#$result: $map_t..$ptr_to..^Node.^^bool;
      call0formal#AT##l2 := $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
  $rd_phys_ptr($s, Node.right, $phys_ptr_cast(P#x, ^Node), ^Node));
      call1formal#AT##l1 := $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
  $rd_phys_ptr($s, Node.left, $phys_ptr_cast(P#x, ^Node), ^Node));
      call2formal#AT##l0 := $phys_ptr_cast(P#x, ^Node);
      havoc call3formal#AT#$result;
      assume call3formal#AT#$result
   == F#lambda#8(call0formal#AT##l2, call1formal#AT##l1, call2formal#AT##l0);
      assume $call_transition($s, $s);
      res_lambda#8#21 := call3formal#AT#$result;
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^240.15, $s);
    assume $local_value_is($s, 
  #tok$1^240.15, 
  #loc.res_lambda#8#21, 
  $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#8#21), 
  $map_t($ptr_to(^Node), ^^bool));
    assert $writable_prim($s, #wrTime$1^203.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.R));
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    call $write_int(Tree.R, $phys_ptr_cast(P#t, ^Tree), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $phys_ptr_cast(P#x, ^Node), 
    res_lambda#8#21)));
    /*** desugaring:
    {
      var call0formal#AT#f: $field;
      var call1formal#AT#p: $ptr;
      var call2formal#AT#v: int;
      var call3old#AT#$s: $state;
      call0formal#AT#f := Tree.R;
      call1formal#AT#p := $phys_ptr_cast(P#t, ^Tree);
      call2formal#AT#v := $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $phys_ptr_cast(P#x, ^Node), 
    res_lambda#8#21));
      call3old#AT#$s := $s;
      havoc $s;
      assume $specials_eq(call3old#AT#$s, $s);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
      assume $timestamp_post_strict(call3old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^240.5, $s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#70, $state_to_int(prestate#70), ^$#state_t);
    prestate#70 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#70, $state_to_int(prestate#70), ^$#state_t);
    assume $pre_wrap($s);
    assert $top_writable($s, #wrTime$1^203.1, $phys_ptr_cast(P#t, ^Tree));
    assert (forall #writes$1^243.19: $ptr :: 
  { $dont_instantiate(#writes$1^243.19) } 
  $set_in(#writes$1^243.19, $owns($s, $phys_ptr_cast(P#t, ^Tree)))
     ==> $top_writable($s, #wrTime$1^203.1, #writes$1^243.19));
    call $wrap($phys_ptr_cast(P#t, ^Tree), ^Tree);
    /*** desugaring:
    {
      var call0formal#AT#o: $ptr;
      var call1formal#AT#T: $ctype;
      var call2old#AT#$s: $state;
      call0formal#AT#o := $phys_ptr_cast(P#t, ^Tree);
      call1formal#AT#T := ^Tree;
      assert $pre_wrap($s);
      assert $is_non_primitive($typ(call0formal#AT#o));
      assert $mutable($s, call0formal#AT#o);
      assert (forall p: $ptr :: 
  { $dont_instantiate(p) } 
  $set_in0(p, $owns($s, call0formal#AT#o)) ==> $wrapped($s, p, $typ(p)));
      call2old#AT#$s := $s;
      havoc $s;
      assume $is_wrapped_dynamic(call2old#AT#$s, $s, call0formal#AT#o);
    }
    **** end desugaring */
    assume $good_state_ext(#tok$1^243.19, $s);
    assert !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
  $phys_ptr_cast($null, ^Node));
    assert $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node))
   ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
      $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
    $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
    assert $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node))
   ==> $is_null($rd_phys_ptr($s, 
      Node.parent, 
      $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node), 
      ^Node));
    assert (forall Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast($null, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
      $phys_ptr_cast($null, ^Node)), 
    $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
     ==> 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
       < $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
     ==> 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
       > $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    assert (forall Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
    { F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
    { sk_hack(F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     <==> $set_in($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node), $owns($s, $phys_ptr_cast(P#t, ^Tree))));
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $rd_phys_ptr($s, 
        Node.parent, 
        $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
        ^Node)
       == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $rd_phys_ptr($s, 
        Node.parent, 
        $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
        ^Node)
       == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.parent, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.parent, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $rd_phys_ptr($s, 
          Node.left, 
          $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
          ^Node)
         == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)
       || $rd_phys_ptr($s, 
          Node.right, 
          $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
          ^Node)
         == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    assert true;
    assert (forall Q#m$1^83.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
      $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))
     ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)))
       == $rd_inv($s, Node.value, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)));
    assert (forall Q#k$1^83.29#tc2: int :: 
  {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
      Q#k$1^83.29#tc2) } 
  $in_range_i4(Q#k$1^83.29#tc2)
     ==> 
    (forall Q#m$1^83.29#dt1: $ptr :: 
      {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) } 
      $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))
         ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) != Q#k$1^83.29#tc2)
     ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
        Q#k$1^83.29#tc2)
       == 0);
    assert (forall Q#n$1^84.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node))
       && $is_null($rd_phys_ptr($s, 
          Node.parent, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)
       || $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)
         == $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
    assert (forall Q#n$1^84.29#dt1: $ptr, Q#m$1^84.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), 
      $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), 
      $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node))
     <==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node))
       && (
        ($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)
           && $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node))
         || $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)
         || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), 
          $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node))
         || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), 
          $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node))));
    assume $full_stop($s);
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure right_rotate(P#t: $ptr, P#y: $ptr);
  requires $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
  $phys_ptr_cast(P#y, ^Node));
  requires $non_null($rd_phys_ptr($s, Node.left, $phys_ptr_cast(P#y, ^Node), ^Node));
  requires $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
  modifies $s, $cev_pc;
  ensures $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(old($s), Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
      $rd_phys_ptr(old($s), Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
    $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
      $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)))
   && $eq.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv(old($s), Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
    $int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))));
  ensures $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#t, ^Tree)));
  free ensures $call_transition(old($s), $s);



implementation right_rotate(P#t: $ptr, P#y: $ptr)
{
  var prestate#96: $state;
  var res_lambda#9#22: $map_t..$ptr_to..^Node.^^bool;
  var owns#94: $ptrset;
  var staticWrapState#93: $state;
  var prestate#95: $state;
  var owns#91: $ptrset;
  var staticWrapState#90: $state;
  var prestate#92: $state;
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
  var prestate#75: $state;
  var owns#76: $ptrset;
  var prestate#74: $state;
  var prestate#72: $state;
  var owns#73: $ptrset;
  var prestate#71: $state;
  var L#x: $ptr;
  var #wrTime$1^246.1: int;
  var #stackframe: int;

  anon56:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^246.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^246.1, #loc.t, $ptr_to_int(P#t), $ptr_to(^Tree));
    assume $local_value_is($s, #tok$1^246.1, #loc.y, $ptr_to_int(P#y), $ptr_to(^Node));
    assume #wrTime$1^246.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^246.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#t, ^Tree)));
    assume $thread_owned($s, $phys_ptr_cast(P#t, ^Tree));
    assume true;
    assume true;
    assume 2147483647 == $decreases_level;
    assert $in_domain_lab($s, $phys_ptr_cast(P#t, ^Tree), $phys_ptr_cast(P#t, ^Tree), l#public);
    assume $local_value_is($s, #tok$1^252.3, #loc.x, $ptr_to_int(L#x), $ptr_to(^Node));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#71, $state_to_int(prestate#71), ^$#state_t);
    prestate#71 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#71, $state_to_int(prestate#71), ^$#state_t);
    assert $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
    assume $inv($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
    assume $pre_unwrap($s);
    assert $top_writable($s, #wrTime$1^246.1, $phys_ptr_cast(P#t, ^Tree));
    call $unwrap($phys_ptr_cast(P#t, ^Tree), ^Tree);
    /*** desugaring:
    {
      var call0formal#AT#o: $ptr;
      var call1formal#AT#T: $ctype;
      var call2old#AT#$s: $state;
      call0formal#AT#o := $phys_ptr_cast(P#t, ^Tree);
      call1formal#AT#T := ^Tree;
      assert !$is_claimable(call1formal#AT#T) || $ref_cnt($s, call0formal#AT#o) == 0;
      assert $pre_unwrap($s);
      call2old#AT#$s := $s;
      havoc $s;
      assume $is_unwrapped_dynamic(call2old#AT#$s, $s, call0formal#AT#o);
    }
    **** end desugaring */
    assume $good_state_ext(#tok$1^254.19, $s);
    assume $full_stop($s);
    assert F#doMark($phys_ptr_cast(P#y, ^Node));
    assume F#doMark($phys_ptr_cast(P#y, ^Node));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#73, $ptrset_to_int(owns#73), ^$#ptrset);
    owns#73 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#73, $ptrset_to_int(owns#73), ^$#ptrset);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#72, $state_to_int(prestate#72), ^$#state_t);
    prestate#72 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#72, $state_to_int(prestate#72), ^$#state_t);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#74, $state_to_int(prestate#74), ^$#state_t);
    prestate#74 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#74, $state_to_int(prestate#74), ^$#state_t);
    assert $wrapped($s, $phys_ptr_cast(P#y, ^Node), ^Node);
    assert $top_writable($s, #wrTime$1^246.1, $phys_ptr_cast(P#y, ^Node));
    assume $inv($s, $phys_ptr_cast(P#y, ^Node), ^Node);
    assume owns#73 == $owns($s, $phys_ptr_cast(P#y, ^Node));
    assume $pre_static_unwrap($s);
    call $static_unwrap($phys_ptr_cast(P#y, ^Node), prestate#74);
    /*** desugaring:
    {
      var call0formal#AT#o: $ptr;
      var call1formal#AT#S: $state;
      var call2old#AT#$s: $state;
      call0formal#AT#o := $phys_ptr_cast(P#y, ^Node);
      call1formal#AT#S := prestate#74;
      assert !$is_claimable($typ(call0formal#AT#o)) || $ref_cnt($s, call0formal#AT#o) == 0;
      assert $pre_static_unwrap($s);
      call2old#AT#$s := $s;
      havoc $s;
      assume $is_unwrapped(call2old#AT#$s, $s, call0formal#AT#o);
      assume $f_owner($s) == $f_owner(call1formal#AT#S);
      assume $f_timestamp($s)
   == $f_timestamp(call1formal#AT#S)[call0formal#AT#o := $current_timestamp(call2old#AT#$s)];
    }
    **** end desugaring */
    assume $good_state_ext(#tok$1^255.53, $s);
    assume $full_stop($s);
    assert $thread_local($s, $phys_ptr_cast(P#y, ^Node));
    L#x := $rd_phys_ptr($s, Node.left, $phys_ptr_cast(P#y, ^Node), ^Node);
    assume $local_value_is($s, #tok$1^256.3, #loc.x, $ptr_to_int(L#x), $ptr_to(^Node));
    assert F#doMark($phys_ptr_cast(L#x, ^Node));
    assume F#doMark($phys_ptr_cast(L#x, ^Node));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#76, $ptrset_to_int(owns#76), ^$#ptrset);
    owns#76 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#76, $ptrset_to_int(owns#76), ^$#ptrset);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#75, $state_to_int(prestate#75), ^$#state_t);
    prestate#75 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#75, $state_to_int(prestate#75), ^$#state_t);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#77, $state_to_int(prestate#77), ^$#state_t);
    prestate#77 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#77, $state_to_int(prestate#77), ^$#state_t);
    assert $wrapped($s, $phys_ptr_cast(L#x, ^Node), ^Node);
    assert $top_writable($s, #wrTime$1^246.1, $phys_ptr_cast(L#x, ^Node));
    assume $inv($s, $phys_ptr_cast(L#x, ^Node), ^Node);
    assume owns#76 == $owns($s, $phys_ptr_cast(L#x, ^Node));
    assume $pre_static_unwrap($s);
    call $static_unwrap($phys_ptr_cast(L#x, ^Node), prestate#77);
    /*** desugaring:
    {
      var call0formal#AT#o: $ptr;
      var call1formal#AT#S: $state;
      var call2old#AT#$s: $state;
      call0formal#AT#o := $phys_ptr_cast(L#x, ^Node);
      call1formal#AT#S := prestate#77;
      assert !$is_claimable($typ(call0formal#AT#o)) || $ref_cnt($s, call0formal#AT#o) == 0;
      assert $pre_static_unwrap($s);
      call2old#AT#$s := $s;
      havoc $s;
      assume $is_unwrapped(call2old#AT#$s, $s, call0formal#AT#o);
      assume $f_owner($s) == $f_owner(call1formal#AT#S);
      assume $f_timestamp($s)
   == $f_timestamp(call1formal#AT#S)[call0formal#AT#o := $current_timestamp(call2old#AT#$s)];
    }
    **** end desugaring */
    assume $good_state_ext(#tok$1^257.53, $s);
    assume $full_stop($s);
    assert $writable_prim($s, #wrTime$1^246.1, $dot($phys_ptr_cast(P#y, ^Node), Node.left));
    assert $thread_local($s, $phys_ptr_cast(L#x, ^Node));
    call $write_int(Node.left, $phys_ptr_cast(P#y, ^Node), $ptr_to_int($rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node)));
    /*** desugaring:
    {
      var call0formal#AT#f: $field;
      var call1formal#AT#p: $ptr;
      var call2formal#AT#v: int;
      var call3old#AT#$s: $state;
      call0formal#AT#f := Node.left;
      call1formal#AT#p := $phys_ptr_cast(P#y, ^Node);
      call2formal#AT#v := $ptr_to_int($rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node));
      call3old#AT#$s := $s;
      havoc $s;
      assume $specials_eq(call3old#AT#$s, $s);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
      assume $timestamp_post_strict(call3old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^259.3, $s);
    assert $thread_local($s, $phys_ptr_cast(L#x, ^Node));
    assume true;
    if ($non_null($rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node)))
    {
      anon49:
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#79, $ptrset_to_int(owns#79), ^$#ptrset);
        owns#79 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#79, $ptrset_to_int(owns#79), ^$#ptrset);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#78, $state_to_int(prestate#78), ^$#state_t);
        prestate#78 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#78, $state_to_int(prestate#78), ^$#state_t);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#80, $state_to_int(prestate#80), ^$#state_t);
        prestate#80 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#80, $state_to_int(prestate#80), ^$#state_t);
        assert $wrapped($s, $rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node), ^Node);
        assert $top_writable($s, 
  #wrTime$1^246.1, 
  $rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node));
        assume $inv($s, $rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node), ^Node);
        assume owns#79
   == $owns($s, $rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node));
        assume $pre_static_unwrap($s);
        call $static_unwrap($rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node), prestate#80);
        /*** desugaring:
        {
          var call0formal#AT#o: $ptr;
          var call1formal#AT#S: $state;
          var call2old#AT#$s: $state;
          call0formal#AT#o := $rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node);
          call1formal#AT#S := prestate#80;
          assert !$is_claimable($typ(call0formal#AT#o)) || $ref_cnt($s, call0formal#AT#o) == 0;
          assert $pre_static_unwrap($s);
          call2old#AT#$s := $s;
          havoc $s;
          assume $is_unwrapped(call2old#AT#$s, $s, call0formal#AT#o);
          assume $f_owner($s) == $f_owner(call1formal#AT#S);
          assume $f_timestamp($s)
   == $f_timestamp(call1formal#AT#S)[call0formal#AT#o := $current_timestamp(call2old#AT#$s)];
        }
        **** end desugaring */
        assume $good_state_ext(#tok$1^261.34, $s);
        assume $full_stop($s);
        assert $writable_prim($s, 
  #wrTime$1^246.1, 
  $dot($rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node), Node.parent));
        assert $thread_local($s, $phys_ptr_cast(L#x, ^Node));
        call $write_int(Node.parent, $rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node), $ptr_to_int($phys_ptr_cast(P#y, ^Node)));
        /*** desugaring:
        {
          var call0formal#AT#f: $field;
          var call1formal#AT#p: $ptr;
          var call2formal#AT#v: int;
          var call3old#AT#$s: $state;
          call0formal#AT#f := Node.parent;
          call1formal#AT#p := $rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node);
          call2formal#AT#v := $ptr_to_int($phys_ptr_cast(P#y, ^Node));
          call3old#AT#$s := $s;
          havoc $s;
          assume $specials_eq(call3old#AT#$s, $s);
          assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
          assume $timestamp_post_strict(call3old#AT#$s, $s);
        }
        **** end desugaring */
        assume $full_stop_ext(#tok$1^261.44, $s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#83, $state_to_int(prestate#83), ^$#state_t);
        prestate#83 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#83, $state_to_int(prestate#83), ^$#state_t);
        assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#81, 
  $state_to_int(staticWrapState#81), 
  ^$#state_t);
        staticWrapState#81 := $current_state($s);
        assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#81, 
  $state_to_int(staticWrapState#81), 
  ^$#state_t);
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#82, $ptrset_to_int(owns#82), ^$#ptrset);
        owns#82 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#82, $ptrset_to_int(owns#82), ^$#ptrset);
        assert $top_writable($s, 
  #wrTime$1^246.1, 
  $rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node));
        assume $pre_static_wrap($s);
        call $static_wrap($rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node), staticWrapState#81, owns#82);
        /*** desugaring:
        {
          var call0formal#AT#o: $ptr;
          var call1formal#AT#S: $state;
          var call2formal#AT#owns: $ptrset;
          var call3old#AT#$s: $state;
          call0formal#AT#o := $rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node);
          call1formal#AT#S := staticWrapState#81;
          call2formal#AT#owns := owns#82;
          assert $pre_static_wrap($s);
          assert $is_non_primitive($typ(call0formal#AT#o));
          assert $mutable($s, call0formal#AT#o);
          call3old#AT#$s := $s;
          havoc $s;
          assume $is_wrapped(call3old#AT#$s, $s, call0formal#AT#o, call2formal#AT#owns);
          assume $heap($s)
   == $update($heap(call3old#AT#$s), 
    call0formal#AT#o, 
    $f_owns($typ(call0formal#AT#o)), 
    $ptrset_to_int(call2formal#AT#owns));
          assume $f_owner($s) == $f_owner(call1formal#AT#S);
        }
        **** end desugaring */
        assume $good_state_ext(#tok$1^261.34, $s);
        assert $set_eq($owns($s, $rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node)), 
  $set_empty());
        assume $full_stop($s);
    }
    else
    {
      anon50:
    }

  anon57:
    assert $writable_prim($s, #wrTime$1^246.1, $dot($phys_ptr_cast(L#x, ^Node), Node.parent));
    assert $thread_local($s, $phys_ptr_cast(P#y, ^Node));
    call $write_int(Node.parent, $phys_ptr_cast(L#x, ^Node), $ptr_to_int($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node)));
    /*** desugaring:
    {
      var call0formal#AT#f: $field;
      var call1formal#AT#p: $ptr;
      var call2formal#AT#v: int;
      var call3old#AT#$s: $state;
      call0formal#AT#f := Node.parent;
      call1formal#AT#p := $phys_ptr_cast(L#x, ^Node);
      call2formal#AT#v := $ptr_to_int($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node));
      call3old#AT#$s := $s;
      havoc $s;
      assume $specials_eq(call3old#AT#$s, $s);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
      assume $timestamp_post_strict(call3old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^262.3, $s);
    assert $thread_local($s, $phys_ptr_cast(P#y, ^Node));
    assume true;
    if ($is_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node)))
    {
      anon51:
        assert $writable_prim($s, #wrTime$1^246.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.root));
        call $write_int(Tree.root, $phys_ptr_cast(P#t, ^Tree), $ptr_to_int($phys_ptr_cast(L#x, ^Node)));
        /*** desugaring:
        {
          var call0formal#AT#f: $field;
          var call1formal#AT#p: $ptr;
          var call2formal#AT#v: int;
          var call3old#AT#$s: $state;
          call0formal#AT#f := Tree.root;
          call1formal#AT#p := $phys_ptr_cast(P#t, ^Tree);
          call2formal#AT#v := $ptr_to_int($phys_ptr_cast(L#x, ^Node));
          call3old#AT#$s := $s;
          havoc $s;
          assume $specials_eq(call3old#AT#$s, $s);
          assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
          assume $timestamp_post_strict(call3old#AT#$s, $s);
        }
        **** end desugaring */
        assume $full_stop_ext(#tok$1^263.32, $s);
    }
    else
    {
      anon54:
        assert F#doMark($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node));
        assume F#doMark($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node));
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#85, $ptrset_to_int(owns#85), ^$#ptrset);
        owns#85 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#85, $ptrset_to_int(owns#85), ^$#ptrset);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#84, $state_to_int(prestate#84), ^$#state_t);
        prestate#84 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#84, $state_to_int(prestate#84), ^$#state_t);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#86, $state_to_int(prestate#86), ^$#state_t);
        prestate#86 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#86, $state_to_int(prestate#86), ^$#state_t);
        assert $wrapped($s, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node), ^Node);
        assert $top_writable($s, 
  #wrTime$1^246.1, 
  $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node));
        assume $inv($s, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node), ^Node);
        assume owns#85
   == $owns($s, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node));
        assume $pre_static_unwrap($s);
        call $static_unwrap($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node), prestate#86);
        /*** desugaring:
        {
          var call0formal#AT#o: $ptr;
          var call1formal#AT#S: $state;
          var call2old#AT#$s: $state;
          call0formal#AT#o := $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node);
          call1formal#AT#S := prestate#86;
          assert !$is_claimable($typ(call0formal#AT#o)) || $ref_cnt($s, call0formal#AT#o) == 0;
          assert $pre_static_unwrap($s);
          call2old#AT#$s := $s;
          havoc $s;
          assume $is_unwrapped(call2old#AT#$s, $s, call0formal#AT#o);
          assume $f_owner($s) == $f_owner(call1formal#AT#S);
          assume $f_timestamp($s)
   == $f_timestamp(call1formal#AT#S)[call0formal#AT#o := $current_timestamp(call2old#AT#$s)];
        }
        **** end desugaring */
        assume $good_state_ext(#tok$1^266.32, $s);
        assume $full_stop($s);
        assert $thread_local($s, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node));
        assert $thread_local($s, $phys_ptr_cast(P#y, ^Node));
        assume true;
        if ($ptr_eq($rd_phys_ptr($s, 
    Node.left, 
    $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node), 
    ^Node), 
  $phys_ptr_cast(P#y, ^Node)))
        {
          anon52:
            assert $writable_prim($s, 
  #wrTime$1^246.1, 
  $dot($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node), Node.left));
            assert $thread_local($s, $phys_ptr_cast(P#y, ^Node));
            call $write_int(Node.left, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node), $ptr_to_int($phys_ptr_cast(L#x, ^Node)));
            /*** desugaring:
            {
              var call0formal#AT#f: $field;
              var call1formal#AT#p: $ptr;
              var call2formal#AT#v: int;
              var call3old#AT#$s: $state;
              call0formal#AT#f := Node.left;
              call1formal#AT#p := $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node);
              call2formal#AT#v := $ptr_to_int($phys_ptr_cast(L#x, ^Node));
              call3old#AT#$s := $s;
              havoc $s;
              assume $specials_eq(call3old#AT#$s, $s);
              assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
              assume $timestamp_post_strict(call3old#AT#$s, $s);
            }
            **** end desugaring */
            assume $full_stop_ext(#tok$1^268.9, $s);
        }
        else
        {
          anon53:
            assert $writable_prim($s, 
  #wrTime$1^246.1, 
  $dot($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node), Node.right));
            assert $thread_local($s, $phys_ptr_cast(P#y, ^Node));
            call $write_int(Node.right, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node), $ptr_to_int($phys_ptr_cast(L#x, ^Node)));
            /*** desugaring:
            {
              var call0formal#AT#f: $field;
              var call1formal#AT#p: $ptr;
              var call2formal#AT#v: int;
              var call3old#AT#$s: $state;
              call0formal#AT#f := Node.right;
              call1formal#AT#p := $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node);
              call2formal#AT#v := $ptr_to_int($phys_ptr_cast(L#x, ^Node));
              call3old#AT#$s := $s;
              havoc $s;
              assume $specials_eq(call3old#AT#$s, $s);
              assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
              assume $timestamp_post_strict(call3old#AT#$s, $s);
            }
            **** end desugaring */
            assume $full_stop_ext(#tok$1^270.9, $s);
        }

      anon55:
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#89, $state_to_int(prestate#89), ^$#state_t);
        prestate#89 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#89, $state_to_int(prestate#89), ^$#state_t);
        assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#87, 
  $state_to_int(staticWrapState#87), 
  ^$#state_t);
        staticWrapState#87 := $current_state($s);
        assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#87, 
  $state_to_int(staticWrapState#87), 
  ^$#state_t);
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#88, $ptrset_to_int(owns#88), ^$#ptrset);
        owns#88 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#88, $ptrset_to_int(owns#88), ^$#ptrset);
        assert $top_writable($s, 
  #wrTime$1^246.1, 
  $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node));
        assume $pre_static_wrap($s);
        call $static_wrap($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node), staticWrapState#87, owns#88);
        /*** desugaring:
        {
          var call0formal#AT#o: $ptr;
          var call1formal#AT#S: $state;
          var call2formal#AT#owns: $ptrset;
          var call3old#AT#$s: $state;
          call0formal#AT#o := $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node);
          call1formal#AT#S := staticWrapState#87;
          call2formal#AT#owns := owns#88;
          assert $pre_static_wrap($s);
          assert $is_non_primitive($typ(call0formal#AT#o));
          assert $mutable($s, call0formal#AT#o);
          call3old#AT#$s := $s;
          havoc $s;
          assume $is_wrapped(call3old#AT#$s, $s, call0formal#AT#o, call2formal#AT#owns);
          assume $heap($s)
   == $update($heap(call3old#AT#$s), 
    call0formal#AT#o, 
    $f_owns($typ(call0formal#AT#o)), 
    $ptrset_to_int(call2formal#AT#owns));
          assume $f_owner($s) == $f_owner(call1formal#AT#S);
        }
        **** end desugaring */
        assume $good_state_ext(#tok$1^266.32, $s);
        assert $set_eq($owns($s, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node)), 
  $set_empty());
        assume $full_stop($s);
    }

  anon58:
    assert $writable_prim($s, #wrTime$1^246.1, $dot($phys_ptr_cast(L#x, ^Node), Node.right));
    call $write_int(Node.right, $phys_ptr_cast(L#x, ^Node), $ptr_to_int($phys_ptr_cast(P#y, ^Node)));
    /*** desugaring:
    {
      var call0formal#AT#f: $field;
      var call1formal#AT#p: $ptr;
      var call2formal#AT#v: int;
      var call3old#AT#$s: $state;
      call0formal#AT#f := Node.right;
      call1formal#AT#p := $phys_ptr_cast(L#x, ^Node);
      call2formal#AT#v := $ptr_to_int($phys_ptr_cast(P#y, ^Node));
      call3old#AT#$s := $s;
      havoc $s;
      assume $specials_eq(call3old#AT#$s, $s);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
      assume $timestamp_post_strict(call3old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^273.3, $s);
    assert $writable_prim($s, #wrTime$1^246.1, $dot($phys_ptr_cast(P#y, ^Node), Node.parent));
    call $write_int(Node.parent, $phys_ptr_cast(P#y, ^Node), $ptr_to_int($phys_ptr_cast(L#x, ^Node)));
    /*** desugaring:
    {
      var call0formal#AT#f: $field;
      var call1formal#AT#p: $ptr;
      var call2formal#AT#v: int;
      var call3old#AT#$s: $state;
      call0formal#AT#f := Node.parent;
      call1formal#AT#p := $phys_ptr_cast(P#y, ^Node);
      call2formal#AT#v := $ptr_to_int($phys_ptr_cast(L#x, ^Node));
      call3old#AT#$s := $s;
      havoc $s;
      assume $specials_eq(call3old#AT#$s, $s);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
      assume $timestamp_post_strict(call3old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^274.3, $s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#92, $state_to_int(prestate#92), ^$#state_t);
    prestate#92 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#92, $state_to_int(prestate#92), ^$#state_t);
    assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#90, 
  $state_to_int(staticWrapState#90), 
  ^$#state_t);
    staticWrapState#90 := $current_state($s);
    assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#90, 
  $state_to_int(staticWrapState#90), 
  ^$#state_t);
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#91, $ptrset_to_int(owns#91), ^$#ptrset);
    owns#91 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#91, $ptrset_to_int(owns#91), ^$#ptrset);
    assert $top_writable($s, #wrTime$1^246.1, $phys_ptr_cast(L#x, ^Node));
    assume $pre_static_wrap($s);
    call $static_wrap($phys_ptr_cast(L#x, ^Node), staticWrapState#90, owns#91);
    /*** desugaring:
    {
      var call0formal#AT#o: $ptr;
      var call1formal#AT#S: $state;
      var call2formal#AT#owns: $ptrset;
      var call3old#AT#$s: $state;
      call0formal#AT#o := $phys_ptr_cast(L#x, ^Node);
      call1formal#AT#S := staticWrapState#90;
      call2formal#AT#owns := owns#91;
      assert $pre_static_wrap($s);
      assert $is_non_primitive($typ(call0formal#AT#o));
      assert $mutable($s, call0formal#AT#o);
      call3old#AT#$s := $s;
      havoc $s;
      assume $is_wrapped(call3old#AT#$s, $s, call0formal#AT#o, call2formal#AT#owns);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), 
    call0formal#AT#o, 
    $f_owns($typ(call0formal#AT#o)), 
    $ptrset_to_int(call2formal#AT#owns));
      assume $f_owner($s) == $f_owner(call1formal#AT#S);
    }
    **** end desugaring */
    assume $good_state_ext(#tok$1^276.19, $s);
    assert $set_eq($owns($s, $phys_ptr_cast(L#x, ^Node)), $set_empty());
    assume $full_stop($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#95, $state_to_int(prestate#95), ^$#state_t);
    prestate#95 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#95, $state_to_int(prestate#95), ^$#state_t);
    assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#93, 
  $state_to_int(staticWrapState#93), 
  ^$#state_t);
    staticWrapState#93 := $current_state($s);
    assume $local_value_is($s, 
  #tok$2^0.0, 
  #loc.staticWrapState#93, 
  $state_to_int(staticWrapState#93), 
  ^$#state_t);
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#94, $ptrset_to_int(owns#94), ^$#ptrset);
    owns#94 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#94, $ptrset_to_int(owns#94), ^$#ptrset);
    assert $top_writable($s, #wrTime$1^246.1, $phys_ptr_cast(P#y, ^Node));
    assume $pre_static_wrap($s);
    call $static_wrap($phys_ptr_cast(P#y, ^Node), staticWrapState#93, owns#94);
    /*** desugaring:
    {
      var call0formal#AT#o: $ptr;
      var call1formal#AT#S: $state;
      var call2formal#AT#owns: $ptrset;
      var call3old#AT#$s: $state;
      call0formal#AT#o := $phys_ptr_cast(P#y, ^Node);
      call1formal#AT#S := staticWrapState#93;
      call2formal#AT#owns := owns#94;
      assert $pre_static_wrap($s);
      assert $is_non_primitive($typ(call0formal#AT#o));
      assert $mutable($s, call0formal#AT#o);
      call3old#AT#$s := $s;
      havoc $s;
      assume $is_wrapped(call3old#AT#$s, $s, call0formal#AT#o, call2formal#AT#owns);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), 
    call0formal#AT#o, 
    $f_owns($typ(call0formal#AT#o)), 
    $ptrset_to_int(call2formal#AT#owns));
      assume $f_owner($s) == $f_owner(call1formal#AT#S);
    }
    **** end desugaring */
    assume $good_state_ext(#tok$1^276.43, $s);
    assert $set_eq($owns($s, $phys_ptr_cast(P#y, ^Node)), $set_empty());
    assume $full_stop($s);
    assert F#doMark($rd_phys_ptr($s, Node.left, $phys_ptr_cast(P#y, ^Node), ^Node));
    assume F#doMark($rd_phys_ptr($s, Node.left, $phys_ptr_cast(P#y, ^Node), ^Node));
    assert (forall Q#m$1^279.26#dt1: $ptr :: 
  {:weight 10} { sk_hack($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $phys_ptr_cast(L#x, ^Node)), 
        $phys_ptr_cast(Q#m$1^279.26#dt1, ^Node))) } 
    { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Node.left, $phys_ptr_cast(P#y, ^Node), ^Node)), 
      $phys_ptr_cast(Q#m$1^279.26#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Node.left, $phys_ptr_cast(P#y, ^Node), ^Node)), 
      $phys_ptr_cast(Q#m$1^279.26#dt1, ^Node))
     ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^279.26#dt1, ^Node))
       < $rd_inv($s, Node.key, $phys_ptr_cast(P#y, ^Node)));
    assume (forall Q#m$1^279.26#dt1: $ptr :: 
  {:weight 10} { sk_hack($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $phys_ptr_cast(L#x, ^Node)), 
        $phys_ptr_cast(Q#m$1^279.26#dt1, ^Node))) } 
    { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Node.left, $phys_ptr_cast(P#y, ^Node), ^Node)), 
      $phys_ptr_cast(Q#m$1^279.26#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Node.left, $phys_ptr_cast(P#y, ^Node), ^Node)), 
      $phys_ptr_cast(Q#m$1^279.26#dt1, ^Node))
     ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^279.26#dt1, ^Node))
       < $rd_inv($s, Node.key, $phys_ptr_cast(P#y, ^Node)));
    assert $writable_prim($s, #wrTime$1^246.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.R));
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    call $write_int(Tree.R, $phys_ptr_cast(P#t, ^Tree), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $phys_ptr_cast(L#x, ^Node), 
    $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
      $phys_ptr_cast(P#y, ^Node)))));
    /*** desugaring:
    {
      var call0formal#AT#f: $field;
      var call1formal#AT#p: $ptr;
      var call2formal#AT#v: int;
      var call3old#AT#$s: $state;
      call0formal#AT#f := Tree.R;
      call1formal#AT#p := $phys_ptr_cast(P#t, ^Tree);
      call2formal#AT#v := $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $phys_ptr_cast(L#x, ^Node), 
    $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
      $phys_ptr_cast(P#y, ^Node))));
      call3old#AT#$s := $s;
      havoc $s;
      assume $specials_eq(call3old#AT#$s, $s);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
      assume $timestamp_post_strict(call3old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^282.5, $s);
    assume $local_value_is($s, 
  #tok$1^283.15, 
  #loc.res_lambda#9#22, 
  $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#9#22), 
  $map_t($ptr_to(^Node), ^^bool));
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    assert $thread_local($s, $phys_ptr_cast(P#y, ^Node));
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    assert $thread_local($s, $phys_ptr_cast(P#y, ^Node));
    call res_lambda#9#22 := lambda#9($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
  $rd_phys_ptr($s, Node.right, $phys_ptr_cast(P#y, ^Node), ^Node)), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
  $rd_phys_ptr($s, Node.left, $phys_ptr_cast(P#y, ^Node), ^Node)), $phys_ptr_cast(P#y, ^Node));
    /*** desugaring:
    {
      var call0formal#AT##l2: $map_t..$ptr_to..^Node.^^bool;
      var call1formal#AT##l1: $map_t..$ptr_to..^Node.^^bool;
      var call2formal#AT##l0: $ptr;
      var call3formal#AT#$result: $map_t..$ptr_to..^Node.^^bool;
      call0formal#AT##l2 := $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
  $rd_phys_ptr($s, Node.right, $phys_ptr_cast(P#y, ^Node), ^Node));
      call1formal#AT##l1 := $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
  $rd_phys_ptr($s, Node.left, $phys_ptr_cast(P#y, ^Node), ^Node));
      call2formal#AT##l0 := $phys_ptr_cast(P#y, ^Node);
      havoc call3formal#AT#$result;
      assume call3formal#AT#$result
   == F#lambda#9(call0formal#AT##l2, call1formal#AT##l1, call2formal#AT##l0);
      assume $call_transition($s, $s);
      res_lambda#9#22 := call3formal#AT#$result;
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^283.15, $s);
    assume $local_value_is($s, 
  #tok$1^283.15, 
  #loc.res_lambda#9#22, 
  $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#9#22), 
  $map_t($ptr_to(^Node), ^^bool));
    assert $writable_prim($s, #wrTime$1^246.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.R));
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    call $write_int(Tree.R, $phys_ptr_cast(P#t, ^Tree), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $phys_ptr_cast(P#y, ^Node), 
    res_lambda#9#22)));
    /*** desugaring:
    {
      var call0formal#AT#f: $field;
      var call1formal#AT#p: $ptr;
      var call2formal#AT#v: int;
      var call3old#AT#$s: $state;
      call0formal#AT#f := Tree.R;
      call1formal#AT#p := $phys_ptr_cast(P#t, ^Tree);
      call2formal#AT#v := $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $phys_ptr_cast(P#y, ^Node), 
    res_lambda#9#22));
      call3old#AT#$s := $s;
      havoc $s;
      assume $specials_eq(call3old#AT#$s, $s);
      assume $heap($s)
   == $update($heap(call3old#AT#$s), call1formal#AT#p, call0formal#AT#f, call2formal#AT#v);
      assume $timestamp_post_strict(call3old#AT#$s, $s);
    }
    **** end desugaring */
    assume $full_stop_ext(#tok$1^283.5, $s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#96, $state_to_int(prestate#96), ^$#state_t);
    prestate#96 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#96, $state_to_int(prestate#96), ^$#state_t);
    assume $pre_wrap($s);
    assert $top_writable($s, #wrTime$1^246.1, $phys_ptr_cast(P#t, ^Tree));
    assert (forall #writes$1^286.19: $ptr :: 
  { $dont_instantiate(#writes$1^286.19) } 
  $set_in(#writes$1^286.19, $owns($s, $phys_ptr_cast(P#t, ^Tree)))
     ==> $top_writable($s, #wrTime$1^246.1, #writes$1^286.19));
    call $wrap($phys_ptr_cast(P#t, ^Tree), ^Tree);
    /*** desugaring:
    {
      var call0formal#AT#o: $ptr;
      var call1formal#AT#T: $ctype;
      var call2old#AT#$s: $state;
      call0formal#AT#o := $phys_ptr_cast(P#t, ^Tree);
      call1formal#AT#T := ^Tree;
      assert $pre_wrap($s);
      assert $is_non_primitive($typ(call0formal#AT#o));
      assert $mutable($s, call0formal#AT#o);
      assert (forall p: $ptr :: 
  { $dont_instantiate(p) } 
  $set_in0(p, $owns($s, call0formal#AT#o)) ==> $wrapped($s, p, $typ(p)));
      call2old#AT#$s := $s;
      havoc $s;
      assume $is_wrapped_dynamic(call2old#AT#$s, $s, call0formal#AT#o);
    }
    **** end desugaring */
    assume $good_state_ext(#tok$1^286.19, $s);
    assert !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
    $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
  $phys_ptr_cast($null, ^Node));
    assert $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node))
   ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
      $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
    $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
    assert $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node))
   ==> $is_null($rd_phys_ptr($s, 
      Node.parent, 
      $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node), 
      ^Node));
    assert (forall Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast($null, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
      $phys_ptr_cast($null, ^Node)), 
    $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
     ==> 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
       < $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
     ==> 
    $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
       > $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    assert (forall Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
    { F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
    { sk_hack(F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     <==> $set_in($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node), $owns($s, $phys_ptr_cast(P#t, ^Tree))));
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.left, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $rd_phys_ptr($s, 
        Node.parent, 
        $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
        ^Node)
       == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.right, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $rd_phys_ptr($s, 
        Node.parent, 
        $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
        ^Node)
       == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.parent, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
       && $non_null($rd_phys_ptr($s, 
          Node.parent, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $rd_phys_ptr($s, 
          Node.left, 
          $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
          ^Node)
         == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)
       || $rd_phys_ptr($s, 
          Node.right, 
          $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), 
          ^Node)
         == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    assert (forall Q#n$1^82.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))
     ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), 
      $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    assert true;
    assert (forall Q#m$1^83.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
      $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
      $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))
     ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
        $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)))
       == $rd_inv($s, Node.value, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)));
    assert (forall Q#k$1^83.29#tc2: int :: 
  {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
      Q#k$1^83.29#tc2) } 
  $in_range_i4(Q#k$1^83.29#tc2)
     ==> 
    (forall Q#m$1^83.29#dt1: $ptr :: 
      {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) } 
      $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
          $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))
         ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) != Q#k$1^83.29#tc2)
     ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), 
        Q#k$1^83.29#tc2)
       == 0);
    assert (forall Q#n$1^84.29#dt1: $ptr :: 
  {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node))
       && $is_null($rd_phys_ptr($s, 
          Node.parent, 
          $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node), 
          ^Node))
     ==> $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)
       || $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)
         == $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
    assert (forall Q#n$1^84.29#dt1: $ptr, Q#m$1^84.29#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), 
      $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
        $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), 
      $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node))
     <==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
          $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), 
        $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node))
       && (
        ($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)
           && $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node))
         || $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)
         || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), 
          $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node))
         || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), 
            $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), 
          $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node))));
    assume $full_stop($s);
    assert $position_marker();
    goto #exit;

  #exit:
}



function F#lambda#9(#l2: $map_t..$ptr_to..^Node.^^bool, 
    #l1: $map_t..$ptr_to..^Node.^^bool, 
    #l0: $ptr)
   : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#9: $pure_function;

axiom $function_arg_type(cf#lambda#9, 0, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#9, 1, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#9, 2, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#9, 3, $ptr_to(^Node));

procedure lambda#9(#l2: $map_t..$ptr_to..^Node.^^bool, 
    #l1: $map_t..$ptr_to..^Node.^^bool, 
    #l0: $ptr)
   returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#9(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#m$1^283.15#dt1: $ptr, 
    #l2: $map_t..$ptr_to..^Node.^^bool, 
    #l1: $map_t..$ptr_to..^Node.^^bool, 
    #l0: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#9(#l2, #l1, $phys_ptr_cast(#l0, ^Node)), 
      $phys_ptr_cast(Q#m$1^283.15#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#9(#l2, #l1, $phys_ptr_cast(#l0, ^Node)), 
      $phys_ptr_cast(Q#m$1^283.15#dt1, ^Node))
     <==> $phys_ptr_cast(Q#m$1^283.15#dt1, ^Node) == $phys_ptr_cast(#l0, ^Node)
       || $select.$map_t..$ptr_to..^Node.^^bool(#l1, $phys_ptr_cast(Q#m$1^283.15#dt1, ^Node))
       || $select.$map_t..$ptr_to..^Node.^^bool(#l2, $phys_ptr_cast(Q#m$1^283.15#dt1, ^Node)));

function F#lambda#8(#l2: $map_t..$ptr_to..^Node.^^bool, 
    #l1: $map_t..$ptr_to..^Node.^^bool, 
    #l0: $ptr)
   : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#8: $pure_function;

axiom $function_arg_type(cf#lambda#8, 0, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#8, 1, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#8, 2, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#8, 3, $ptr_to(^Node));

procedure lambda#8(#l2: $map_t..$ptr_to..^Node.^^bool, 
    #l1: $map_t..$ptr_to..^Node.^^bool, 
    #l0: $ptr)
   returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#8(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#m$1^240.15#dt1: $ptr, 
    #l2: $map_t..$ptr_to..^Node.^^bool, 
    #l1: $map_t..$ptr_to..^Node.^^bool, 
    #l0: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#8(#l2, #l1, $phys_ptr_cast(#l0, ^Node)), 
      $phys_ptr_cast(Q#m$1^240.15#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#8(#l2, #l1, $phys_ptr_cast(#l0, ^Node)), 
      $phys_ptr_cast(Q#m$1^240.15#dt1, ^Node))
     <==> $phys_ptr_cast(Q#m$1^240.15#dt1, ^Node) == $phys_ptr_cast(#l0, ^Node)
       || $select.$map_t..$ptr_to..^Node.^^bool(#l1, $phys_ptr_cast(Q#m$1^240.15#dt1, ^Node))
       || $select.$map_t..$ptr_to..^Node.^^bool(#l2, $phys_ptr_cast(Q#m$1^240.15#dt1, ^Node)));

function F#lambda#7(#l1: $map_t..$ptr_to..^Node.^^bool, #l0: $ptr) : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#7: $pure_function;

axiom $function_arg_type(cf#lambda#7, 0, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#7, 1, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#7, 2, $ptr_to(^Node));

procedure lambda#7(#l1: $map_t..$ptr_to..^Node.^^bool, #l0: $ptr)
   returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#7(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#k$1^194.37#dt1: $ptr, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#7(#l1, $phys_ptr_cast(#l0, ^Node)), 
      $phys_ptr_cast(Q#k$1^194.37#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#7(#l1, $phys_ptr_cast(#l0, ^Node)), 
      $phys_ptr_cast(Q#k$1^194.37#dt1, ^Node))
     <==> $phys_ptr_cast(Q#k$1^194.37#dt1, ^Node) == $phys_ptr_cast(#l0, ^Node)
       || $select.$map_t..$ptr_to..^Node.^^bool(#l1, $phys_ptr_cast(Q#k$1^194.37#dt1, ^Node)));

function F#lambda#6(#l1: $map_t..$ptr_to..^Node.^^bool, #l0: $ptr) : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#6: $pure_function;

axiom $function_arg_type(cf#lambda#6, 0, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#6, 1, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#6, 2, $ptr_to(^Node));

procedure lambda#6(#l1: $map_t..$ptr_to..^Node.^^bool, #l0: $ptr)
   returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#6(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#n$1^163.41#dt1: $ptr, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#6(#l1, $phys_ptr_cast(#l0, ^Node)), 
      $phys_ptr_cast(Q#n$1^163.41#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#6(#l1, $phys_ptr_cast(#l0, ^Node)), 
      $phys_ptr_cast(Q#n$1^163.41#dt1, ^Node))
     <==> $phys_ptr_cast(Q#n$1^163.41#dt1, ^Node) == $phys_ptr_cast(#l0, ^Node)
       || $select.$map_t..$ptr_to..^Node.^^bool(#l1, $phys_ptr_cast(Q#n$1^163.41#dt1, ^Node)));

function F#lambda#5(#l0: $ptr) : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#5: $pure_function;

axiom $function_arg_type(cf#lambda#5, 0, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#5, 1, $ptr_to(^Node));

procedure lambda#5(#l0: $ptr) returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#5(#l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#n$1^153.15#dt1: $ptr, #l0: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#5($phys_ptr_cast(#l0, ^Node)), $phys_ptr_cast(Q#n$1^153.15#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#5($phys_ptr_cast(#l0, ^Node)), $phys_ptr_cast(Q#n$1^153.15#dt1, ^Node))
     <==> $phys_ptr_cast(Q#n$1^153.15#dt1, ^Node) == $phys_ptr_cast(#l0, ^Node));

function F#lambda#4(#l2: $map_t..^^i4.^^i4, #l1: int, #l0: int) : $map_t..^^i4.^^i4;

const unique cf#lambda#4: $pure_function;

axiom $function_arg_type(cf#lambda#4, 0, $map_t(^^i4, ^^i4));

axiom $function_arg_type(cf#lambda#4, 1, $map_t(^^i4, ^^i4));

axiom $function_arg_type(cf#lambda#4, 2, ^^i4);

axiom $function_arg_type(cf#lambda#4, 3, ^^i4);

procedure lambda#4(#l2: $map_t..^^i4.^^i4, #l1: int, #l0: int) returns ($result: $map_t..^^i4.^^i4);
  free ensures $result == F#lambda#4(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#k$1^151.14#tc2: int, #l2: $map_t..^^i4.^^i4, #l1: int, #l0: int :: 
  {:weight 10} { $select.$map_t..^^i4.^^i4(F#lambda#4(#l2, #l1, #l0), Q#k$1^151.14#tc2) } 
  $in_range_i4(Q#k$1^151.14#tc2) && $in_range_i4(#l1) && $in_range_i4(#l0)
     ==> $select.$map_t..^^i4.^^i4(F#lambda#4(#l2, #l1, #l0), Q#k$1^151.14#tc2)
       == (if Q#k$1^151.14#tc2 == #l0
         then #l1
         else $select.$map_t..^^i4.^^i4(#l2, Q#k$1^151.14#tc2)));

function F#lambda#3() : $map_t..^^i4.^^i4;

const unique cf#lambda#3: $pure_function;

axiom $function_arg_type(cf#lambda#3, 0, $map_t(^^i4, ^^i4));

procedure lambda#3() returns ($result: $map_t..^^i4.^^i4);
  free ensures $result == F#lambda#3();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#k$1^94.14#tc2: int :: 
  {:weight 10} { $select.$map_t..^^i4.^^i4(F#lambda#3(), Q#k$1^94.14#tc2) } 
  $in_range_i4(Q#k$1^94.14#tc2)
     ==> $select.$map_t..^^i4.^^i4(F#lambda#3(), Q#k$1^94.14#tc2) == 0);

function F#lambda#2(#l0: $map_t..$ptr_to..^Node.^^bool)
   : $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#2: $pure_function;

axiom $function_arg_type(cf#lambda#2, 0, $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));

axiom $function_arg_type(cf#lambda#2, 1, $map_t($ptr_to(^Node), ^^bool));

procedure lambda#2(#l0: $map_t..$ptr_to..^Node.^^bool)
   returns ($result: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#2(#l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#m$1^93.12#dt1: $ptr, #l0: $map_t..$ptr_to..^Node.^^bool :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(F#lambda#2(#l0), $phys_ptr_cast(Q#m$1^93.12#dt1, ^Node)) } 
  $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(F#lambda#2(#l0), $phys_ptr_cast(Q#m$1^93.12#dt1, ^Node)), 
    #l0));

function F#lambda#1() : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#1: $pure_function;

axiom $function_arg_type(cf#lambda#1, 0, $map_t($ptr_to(^Node), ^^bool));

procedure lambda#1() returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#1();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#n$1^93.12#dt1: $ptr :: 
  {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#1(), $phys_ptr_cast(Q#n$1^93.12#dt1, ^Node)) } 
  $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#1(), $phys_ptr_cast(Q#n$1^93.12#dt1, ^Node))
     <==> false);

const unique l#public: $label;

type $map_t..$ptr_to..^Node.^^bool;

function $select.$map_t..$ptr_to..^Node.^^bool(M: $map_t..$ptr_to..^Node.^^bool, p: $ptr) : bool;

function $store.$map_t..$ptr_to..^Node.^^bool(M: $map_t..$ptr_to..^Node.^^bool, p: $ptr, v: bool)
   : $map_t..$ptr_to..^Node.^^bool;

function $eq.$map_t..$ptr_to..^Node.^^bool(M1: $map_t..$ptr_to..^Node.^^bool, M2: $map_t..$ptr_to..^Node.^^bool) : bool;

const $zero.$map_t..$ptr_to..^Node.^^bool: $map_t..$ptr_to..^Node.^^bool;

axiom (forall M: $map_t..$ptr_to..^Node.^^bool, p: $ptr, v: bool :: true);

axiom (forall M: $map_t..$ptr_to..^Node.^^bool, p: $ptr, v: bool, q: $ptr :: 
  $select.$map_t..$ptr_to..^Node.^^bool($store.$map_t..$ptr_to..^Node.^^bool(M, q, v), p)
     <==> (if $phys_ptr_cast(p, ^Node) == $phys_ptr_cast(q, ^Node)
       then v
       else $select.$map_t..$ptr_to..^Node.^^bool(M, p)));

axiom (forall M1: $map_t..$ptr_to..^Node.^^bool, M2: $map_t..$ptr_to..^Node.^^bool :: 
  { $eq.$map_t..$ptr_to..^Node.^^bool(M1, M2) } 
  (forall p: $ptr :: 
      $select.$map_t..$ptr_to..^Node.^^bool(M1, $phys_ptr_cast(p, ^Node))
         <==> $select.$map_t..$ptr_to..^Node.^^bool(M2, $phys_ptr_cast(p, ^Node)))
     ==> $eq.$map_t..$ptr_to..^Node.^^bool(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^Node.^^bool, M2: $map_t..$ptr_to..^Node.^^bool :: 
  { $eq.$map_t..$ptr_to..^Node.^^bool(M1, M2) } 
  $eq.$map_t..$ptr_to..^Node.^^bool(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^Node.^^bool(0) == $zero.$map_t..$ptr_to..^Node.^^bool;

axiom (forall p: $ptr :: 
  $select.$map_t..$ptr_to..^Node.^^bool($zero.$map_t..$ptr_to..^Node.^^bool, p)
     <==> false);

axiom true;

type $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

function $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, p: $ptr)
   : $map_t..$ptr_to..^Node.^^bool;

function $store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, 
    p: $ptr, 
    v: $map_t..$ptr_to..^Node.^^bool)
   : $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

function $eq.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, 
    M2: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool)
   : bool;

const $zero.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

axiom (forall M: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, 
    p: $ptr, 
    v: $map_t..$ptr_to..^Node.^^bool :: 
  true);

axiom (forall M: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, 
    p: $ptr, 
    v: $map_t..$ptr_to..^Node.^^bool, 
    q: $ptr :: 
  $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M, q, v), p)
     == (if $phys_ptr_cast(p, ^Node) == $phys_ptr_cast(q, ^Node)
       then v
       else $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M, p)));

axiom (forall M1: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, 
    M2: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool :: 
  { $eq.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1, M2) } 
  (forall p: $ptr :: 
      $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1, $phys_ptr_cast(p, ^Node)), 
        $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M2, $phys_ptr_cast(p, ^Node))))
     ==> $eq.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, 
    M2: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool :: 
  { $eq.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1, M2) } 
  $eq.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool(0)
   == $zero.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

axiom (forall p: $ptr :: 
  $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($zero.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, p)
     == $zero.$map_t..$ptr_to..^Node.^^bool);

axiom true;

type $map_t..^^i4.^^i4;

function $select.$map_t..^^i4.^^i4(M: $map_t..^^i4.^^i4, p: int) : int;

function $store.$map_t..^^i4.^^i4(M: $map_t..^^i4.^^i4, p: int, v: int) : $map_t..^^i4.^^i4;

function $eq.$map_t..^^i4.^^i4(M1: $map_t..^^i4.^^i4, M2: $map_t..^^i4.^^i4) : bool;

const $zero.$map_t..^^i4.^^i4: $map_t..^^i4.^^i4;

axiom (forall M: $map_t..^^i4.^^i4, p: int, v: int :: true);

axiom (forall M: $map_t..^^i4.^^i4, p: int, v: int, q: int :: 
  $select.$map_t..^^i4.^^i4($store.$map_t..^^i4.^^i4(M, q, v), p)
     == (if $unchecked(^^i4, p) == $unchecked(^^i4, q)
       then $unchecked(^^i4, v)
       else $select.$map_t..^^i4.^^i4(M, p)));

axiom (forall M1: $map_t..^^i4.^^i4, M2: $map_t..^^i4.^^i4 :: 
  { $eq.$map_t..^^i4.^^i4(M1, M2) } 
  (forall p: int :: 
      $unchecked(^^i4, $select.$map_t..^^i4.^^i4(M1, $unchecked(^^i4, p)))
         == $unchecked(^^i4, $select.$map_t..^^i4.^^i4(M2, $unchecked(^^i4, p))))
     ==> $eq.$map_t..^^i4.^^i4(M1, M2));

axiom (forall M1: $map_t..^^i4.^^i4, M2: $map_t..^^i4.^^i4 :: 
  { $eq.$map_t..^^i4.^^i4(M1, M2) } 
  $eq.$map_t..^^i4.^^i4(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^i4.^^i4(0) == $zero.$map_t..^^i4.^^i4;

axiom (forall p: int :: $select.$map_t..^^i4.^^i4($zero.$map_t..^^i4.^^i4, p) == 0);

axiom true;

axiom (forall M: $map_t..^^i4.^^i4, p: int :: 
  $in_range_t(^^i4, $select.$map_t..^^i4.^^i4(M, p)));

const unique #loc.#l0: $token;

const unique #loc.#l1: $token;

const unique #loc.#l2: $token;

const unique #tok$1^286.19: $token;

const unique #loc.prestate#96: $token;

const unique #tok$1^283.5: $token;

const unique #loc.res_lambda#9#22: $token;

const unique #tok$1^283.15: $token;

const unique #tok$1^282.5: $token;

const unique #tok$1^276.43: $token;

const unique #loc.owns#94: $token;

const unique #loc.staticWrapState#93: $token;

const unique #loc.prestate#95: $token;

const unique #tok$1^276.19: $token;

const unique #loc.owns#91: $token;

const unique #loc.staticWrapState#90: $token;

const unique #loc.prestate#92: $token;

const unique #tok$1^274.3: $token;

const unique #tok$1^273.3: $token;

const unique #loc.owns#88: $token;

const unique #loc.staticWrapState#87: $token;

const unique #loc.prestate#89: $token;

const unique #tok$1^270.9: $token;

const unique #tok$1^268.9: $token;

const unique #tok$1^266.32: $token;

const unique #loc.prestate#86: $token;

const unique #loc.prestate#84: $token;

const unique #loc.owns#85: $token;

const unique #tok$1^263.32: $token;

const unique #tok$1^262.3: $token;

const unique #loc.owns#82: $token;

const unique #loc.staticWrapState#81: $token;

const unique #loc.prestate#83: $token;

const unique #tok$1^261.44: $token;

const unique #tok$1^261.34: $token;

const unique #loc.prestate#80: $token;

const unique #loc.prestate#78: $token;

const unique #loc.owns#79: $token;

const unique #tok$1^259.3: $token;

const unique #tok$1^257.53: $token;

const unique #loc.prestate#77: $token;

const unique #loc.prestate#75: $token;

const unique #loc.owns#76: $token;

const unique #tok$1^256.3: $token;

const unique #tok$1^255.53: $token;

const unique #loc.prestate#74: $token;

const unique #loc.prestate#72: $token;

const unique #loc.owns#73: $token;

const unique #tok$1^254.19: $token;

const unique #loc.prestate#71: $token;

const unique #tok$1^252.3: $token;

const unique #tok$1^246.1: $token;

const unique #tok$1^243.19: $token;

const unique #loc.prestate#70: $token;

const unique #tok$1^240.5: $token;

const unique #loc.res_lambda#8#21: $token;

const unique #tok$1^240.15: $token;

const unique #tok$1^239.5: $token;

const unique #tok$1^233.43: $token;

const unique #loc.owns#68: $token;

const unique #loc.staticWrapState#67: $token;

const unique #loc.prestate#69: $token;

const unique #tok$1^233.19: $token;

const unique #loc.owns#65: $token;

const unique #loc.staticWrapState#64: $token;

const unique #loc.prestate#66: $token;

const unique #tok$1^232.3: $token;

const unique #tok$1^231.3: $token;

const unique #loc.owns#62: $token;

const unique #loc.staticWrapState#61: $token;

const unique #loc.prestate#63: $token;

const unique #tok$1^228.9: $token;

const unique #tok$1^226.9: $token;

const unique #tok$1^224.32: $token;

const unique #loc.prestate#60: $token;

const unique #loc.prestate#58: $token;

const unique #loc.owns#59: $token;

const unique #tok$1^221.5: $token;

const unique #tok$1^219.3: $token;

const unique #loc.owns#56: $token;

const unique #loc.staticWrapState#55: $token;

const unique #loc.prestate#57: $token;

const unique #tok$1^218.43: $token;

const unique #tok$1^218.34: $token;

const unique #loc.prestate#54: $token;

const unique #loc.prestate#52: $token;

const unique #loc.owns#53: $token;

const unique #tok$1^216.3: $token;

const unique #tok$1^214.53: $token;

const unique #loc.prestate#51: $token;

const unique #loc.prestate#49: $token;

const unique #loc.owns#50: $token;

const unique #tok$1^213.3: $token;

const unique #tok$1^212.53: $token;

const unique #loc.prestate#48: $token;

const unique #loc.prestate#46: $token;

const unique #loc.owns#47: $token;

const unique #tok$1^211.19: $token;

const unique #loc.prestate#45: $token;

const unique #loc.y: $token;

const unique #tok$1^209.3: $token;

const unique #tok$1^203.1: $token;

const unique #tok$1^200.19: $token;

const unique #loc.prestate#44: $token;

const unique #tok$1^199.19: $token;

const unique #loc.owns#42: $token;

const unique #loc.staticWrapState#41: $token;

const unique #loc.prestate#43: $token;

const unique #tok$1^198.3: $token;

const unique #tok$1^195.5: $token;

const unique #tok$1^194.27: $token;

const unique #loc.res_lambda#7#20: $token;

const unique #tok$1^194.37: $token;

const unique #loc.owns#39: $token;

const unique #loc.staticWrapState#38: $token;

const unique #loc.prestate#40: $token;

const unique #tok$1^187.41: $token;

const unique #tok$1^187.36: $token;

const unique #loc.prestate#37: $token;

const unique #loc.prestate#35: $token;

const unique #loc.owns#36: $token;

const unique #tok$1^185.7: $token;

const unique #loc.owns#33: $token;

const unique #loc.staticWrapState#32: $token;

const unique #loc.prestate#34: $token;

const unique #tok$1^181.41: $token;

const unique #tok$1^181.36: $token;

const unique #loc.prestate#31: $token;

const unique #loc.prestate#29: $token;

const unique #loc.owns#30: $token;

const unique #tok$1^179.7: $token;

const unique #tok$1^167.3: $token;

axiom $type_code_is(3, ^^object);

const unique #tok$1^168.28: $token;

const unique #tok$1^163.25: $token;

const unique #loc.res_lambda#6#19: $token;

const unique #tok$1^163.41: $token;

const unique #tok$1^159.21: $token;

const unique #loc.prestate#28: $token;

const unique #tok$1^158.21: $token;

const unique #loc.owns#26: $token;

const unique #loc.staticWrapState#25: $token;

const unique #loc.prestate#27: $token;

const unique #tok$1^157.5: $token;

const unique #tok$1^153.5: $token;

const unique #loc.res_lambda#5#18: $token;

const unique #tok$1^153.15: $token;

const unique #tok$1^152.5: $token;

const unique #tok$1^151.5: $token;

const unique #loc.res_lambda#4#17: $token;

const unique #tok$1^151.14: $token;

const unique #tok$1^148.3: $token;

const unique #tok$1^146.3: $token;

const unique #tok$1^146.13: $token;

const unique #tok$1^146.24: $token;

const unique #loc.assign#13: $token;

const unique #loc.assign#12: $token;

const unique #tok$1^144.19: $token;

const unique #loc.prestate#24: $token;

const unique #loc.n: $token;

const unique #tok$1^142.3: $token;

const unique #loc.x: $token;

const unique #tok$1^134.1: $token;

const unique #tok$1^126.13: $token;

const unique #loc.r: $token;

const unique #tok$1^126.3: $token;

const unique #tok$1^122.1: $token;

const unique #tok$1^115.7: $token;

const unique #tok$1^113.7: $token;

const unique #tok$1^108.3: $token;

const unique #tok$1^107.3: $token;

const unique #tok$1^106.3: $token;

const unique #loc.key: $token;

const unique #tok$1^101.1: $token;

const unique #tok$1^97.19: $token;

function $state_to_int(x: $state) : int;

function $int_to_state(x: int) : $state;

axiom (forall #x: $state :: #x == $int_to_state($state_to_int(#x)));

const unique #loc.prestate#23: $token;

const unique #tok$2^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(2, #file^?3Cno?20file?3E);

const unique #tok$1^95.5: $token;

const unique #tok$1^94.5: $token;

const unique #loc.res_lambda#3#16: $token;

const unique #tok$1^94.14: $token;

const unique #tok$1^93.5: $token;

function $map_t..ptr_to..^Node.^^bool_to_int(x: $map_t..$ptr_to..^Node.^^bool) : int;

function $int_to_map_t..ptr_to..^Node.^^bool(x: int) : $map_t..$ptr_to..^Node.^^bool;

axiom (forall #x: $map_t..$ptr_to..^Node.^^bool :: 
  #x
     == $int_to_map_t..ptr_to..^Node.^^bool($map_t..ptr_to..^Node.^^bool_to_int(#x)));

const unique #loc.res_lambda#1#15: $token;

const unique #loc.res_lambda#2#14: $token;

const unique #tok$1^93.12: $token;

const unique #tok$1^91.3: $token;

const unique #loc.t: $token;

const unique #tok$1^87.1: $token;

const unique #tok$1^49.39: $token;

const unique #tok$1^47.39: $token;

const unique #loc.p: $token;

const unique #tok$1^46.39: $token;

const unique #distTp5: $ctype;

axiom #distTp5 == $ptr_to(^Tree);

const unique #loc._this_: $token;

const unique #tok$1^77.31: $token;

axiom $type_code_is(2, ^^i4);

function $map_t..^^i4.^^i4_to_int(x: $map_t..^^i4.^^i4) : int;

function $int_to_map_t..^^i4.^^i4(x: int) : $map_t..^^i4.^^i4;

axiom (forall #x: $map_t..^^i4.^^i4 :: 
  #x == $int_to_map_t..^^i4.^^i4($map_t..^^i4.^^i4_to_int(#x)));

const unique #distTp4: $ctype;

axiom #distTp4 == $map_t(^^i4, ^^i4);

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvacid?2D0?5CRedBlackTrees.c: $token;

axiom $file_name_is(1, 
  #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvacid?2D0?5CRedBlackTrees.c);

function $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int(x: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool) : int;

function $int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool(x: int) : $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

axiom (forall #x: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool :: 
  #x
     == $int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int(#x)));

const unique #distTp3: $ctype;

axiom #distTp3 == $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool));

const unique #distTp2: $ctype;

axiom #distTp2 == $map_t($ptr_to(^Node), ^^bool);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^Node);
