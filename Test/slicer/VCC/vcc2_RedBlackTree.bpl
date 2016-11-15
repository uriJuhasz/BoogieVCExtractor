//-----------------------------------------------------------------------------
//
// Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//-----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
// Boogie types
// ----------------------------------------------------------------------------

// for each C type there is a value of $ctype Boogie type
type $ctype; 

// a typed pointer -- i.e. a pair of a $ctype and an int
type $ptr;

// name of a C field -- each field of a C struct gets a constant of this type
//   like A.b for field b of struct A.
type $field; 

// describes a kind of a C type:
//  - primitive (includes mathematical types (sequences, maps, sets) and pointers)
//  - array
//  - composite
//  - thread_id_t
//  - claim
type $kind; 

// Encoding trick, we store all type-related information together, including:
//  - if the pointer if typed
//  - the embedding of the pointer
//  - the last element of a path (field name) leading to the pointer
//  - if the pointer is volatile
//  - if the pointer points to an (interior) of an array
// We store it togther as all that information changes together
type $type_state;

// Another encoding trick, here we keep:
//  - closed bit
//  - the current owner (can be thread)
type $status;

// for float and double
type $primitive;

// for structs passed by value
type $struct;

// used for constants describing position in the source code (debugging/model printing only)
type $token;

// the statue of the machine, includes what used to be called $state (now $memory(...) function)
// and $meta (now $typemap(...) and $statusmap(...))
type $state;

// A constant is generated for each pure function, used for ordering frame axioms.
type $pure_function;

// For labeled contracts.
type $label;

// ----------------------------------------------------------------------------
// built-in types
// ----------------------------------------------------------------------------

function $kind_of($ctype) returns($kind);

// these are the only possible kinds
const unique $kind_composite : $kind;
const unique $kind_primitive : $kind;
const unique $kind_array : $kind;
const unique $kind_thread : $kind;

function $sizeof($ctype)returns(int); // in bytes

//Notation: types get a ^ as prefix...
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
const unique ^^claim: $ctype;
const unique ^^root_emb: $ctype;
const unique ^^mathint: $ctype;
// struct A will get ^A :$ctype

axiom $sizeof(^^i1) == 1;
axiom $sizeof(^^i2) == 2;
axiom $sizeof(^^i4) == 4;
axiom $sizeof(^^i8) == 8;
axiom $sizeof(^^u1) == 1;
axiom $sizeof(^^u2) == 2;
axiom $sizeof(^^u4) == 4;
axiom $sizeof(^^u8) == 8;
axiom $sizeof(^^f4) == 4;
axiom $sizeof(^^f8) == 8;

// for types for which $in_range_t(...) is defined
function $as_in_range_t($ctype) returns($ctype);
axiom $as_in_range_t(^^i1) == ^^i1;
axiom $as_in_range_t(^^i2) == ^^i2;
axiom $as_in_range_t(^^i4) == ^^i4;
axiom $as_in_range_t(^^i8) == ^^i8;
axiom $as_in_range_t(^^u1) == ^^u1;
axiom $as_in_range_t(^^u2) == ^^u2;
axiom $as_in_range_t(^^u4) == ^^u4;
axiom $as_in_range_t(^^u8) == ^^u8;
axiom $as_in_range_t(^^f4) == ^^f4;
axiom $as_in_range_t(^^f8) == ^^f8;


// -- sizeof bool, void, mathint uninterpreted

const unique ^$#thread_id_t: $ctype;
const unique ^$#ptrset : $ctype;
const unique ^$#state_t : $ctype;
const unique ^$#struct : $ctype;

axiom $sizeof(^$#thread_id_t) == 1;
axiom $sizeof(^$#ptrset) == 1;

axiom $ptr_level(^^i1) == 0;
axiom $ptr_level(^^i2) == 0;
axiom $ptr_level(^^i4) == 0;
axiom $ptr_level(^^i8) == 0;
axiom $ptr_level(^^u1) == 0;
axiom $ptr_level(^^u2) == 0;
axiom $ptr_level(^^u4) == 0;
axiom $ptr_level(^^u8) == 0;
axiom $ptr_level(^^f4) == 0;
axiom $ptr_level(^^f8) == 0;

axiom $ptr_level(^^mathint) == 0;
axiom $ptr_level(^^bool) == 0;
axiom $ptr_level(^^void) == 0;
axiom $ptr_level(^^claim) == 0;
axiom $ptr_level(^^root_emb) == 0;
axiom $ptr_level(^$#ptrset) == 0;
axiom $ptr_level(^$#thread_id_t) == 0;
axiom $ptr_level(^$#state_t) == 0;
axiom $ptr_level(^$#struct) == 0;
axiom $is_composite(^^claim);
axiom $is_composite(^^root_emb);

// inverse functions here (unptr_to, map_domain, map_range) are for the prover
// so it knows that int*!=short*, i.e. * is injective

// pointers to types
function $ptr_to($ctype) returns($ctype);
function $spec_ptr_to($ctype) returns ($ctype);
function $unptr_to($ctype) returns($ctype);
function $ptr_level($ctype) returns(int);

const $arch_ptr_size : int; // arch-specific; to be defined by a compiler-generated axiom
axiom (forall #n:$ctype :: {$ptr_to(#n)} $unptr_to($ptr_to(#n)) == #n);
axiom (forall #n:$ctype :: {$spec_ptr_to(#n)} $unptr_to($spec_ptr_to(#n)) == #n);
axiom (forall #n:$ctype :: {$ptr_to(#n)} $sizeof($ptr_to(#n)) == $arch_ptr_size);
axiom (forall #n:$ctype :: {$spec_ptr_to(#n)} $sizeof($ptr_to(#n)) == $arch_ptr_size);

function $map_t($ctype, $ctype) returns($ctype);
function $map_domain($ctype) returns($ctype);
function $map_range($ctype) returns($ctype);

axiom (forall #r:$ctype, #d:$ctype :: {$map_t(#r,#d)} $map_domain($map_t(#r,#d)) == #d);
axiom (forall #r:$ctype, #d:$ctype :: {$map_t(#r,#d)} $map_range($map_t(#r,#d)) == #r);

// Make it possible to distinguish between pointers and maps with different number of stars/brackets
// The two numbers should be relatively large primes (so that they least common multiple is large
// enough so that the clash is unlikely for reasonable code).
axiom (forall #n:$ctype :: {$ptr_to(#n)} $ptr_level($ptr_to(#n)) == $ptr_level(#n) + 17);
axiom (forall #n:$ctype :: {$spec_ptr_to(#n)} $ptr_level($spec_ptr_to(#n)) == $ptr_level(#n) + 31);
axiom (forall #r:$ctype, #d:$ctype :: {$map_t(#r,#d)} $ptr_level($map_t(#r,#d)) == $ptr_level(#r) + 23);

// {:weight 0} makes it possible to trigger on $is_primitive(...)
// $is_primitive(t) should be only used when it is known that t is really
// primitive, i.e. not in a precondition or in a premise of an implication
// (unless guarded by a trigger). If it is unknown, use $is_primitive_ch(...).
// The same applies to $is_composite(...) and $is_arraytype(...).

function {:weight 0} $is_primitive(t:$ctype) returns(bool)
  { $kind_of(t) == $kind_primitive }

function {:inline true} $is_primitive_ch(t:$ctype) returns(bool)
  { $kind_of(t) == $kind_primitive }

function {:weight 0} $is_composite(t:$ctype) returns(bool)
  { $kind_of(t) == $kind_composite }

function {:inline true} $is_composite_ch(t:$ctype) returns(bool)
  { $kind_of(t) == $kind_composite }

function {:weight 0} $is_arraytype(t:$ctype) returns(bool)
  { $kind_of(t) == $kind_array }

function {:inline true} $is_arraytype_ch(t:$ctype) returns(bool)
  { $kind_of(t) == $kind_array }

function {:weight 0} $is_threadtype(t:$ctype) returns(bool)
  { $kind_of(t) == $kind_thread }

function {:inline true} $is_thread(p:$ptr) returns(bool)
  { $is_threadtype($typ(p)) }

function {:inline true} $is_ptr_to_composite(p:$ptr) returns(bool)
  { $kind_of($typ(p)) == $kind_composite }

function $field_offset($field) returns(int);
function $field_parent_type($field) returns($ctype);

function $is_non_primitive(t:$ctype) returns(bool);
axiom (forall t:$ctype :: {:weight 0} {$is_composite(t)} $is_composite(t) ==> $is_non_primitive(t));
axiom (forall t:$ctype :: {:weight 0} {$is_arraytype(t)} $is_arraytype(t) ==> $is_non_primitive(t));
axiom (forall t:$ctype :: {:weight 0} {$is_threadtype(t)} $is_threadtype(t) ==> $is_non_primitive(t));

function {:inline true} $is_non_primitive_ch(t:$ctype) returns(bool)
  { $kind_of(t) != $kind_primitive }

function {:inline true} $is_non_primitive_ptr(p:$ptr) returns(bool)
  { $is_non_primitive($typ(p)) }

axiom (forall #r:$ctype, #d:$ctype :: {$map_t(#r,#d)} $is_primitive($map_t(#r,#d)));
axiom (forall #n:$ctype :: {$ptr_to(#n)} $is_primitive($ptr_to(#n)));
axiom (forall #n:$ctype :: {$spec_ptr_to(#n)} $is_primitive($spec_ptr_to(#n)));
axiom (forall #n:$ctype :: {$is_primitive(#n)} $is_primitive(#n) ==> !$is_claimable(#n));
axiom (forall #n:$ctype :: {$is_claimable(#n)} $is_claimable(#n) ==> $is_composite(#n));
axiom $is_primitive(^^void);
axiom $is_primitive(^^bool);
axiom $is_primitive(^^mathint);
axiom $is_primitive(^$#ptrset);
axiom $is_primitive(^$#state_t);
axiom $is_threadtype(^$#thread_id_t);

axiom $is_primitive(^^i1);
axiom $is_primitive(^^i2);
axiom $is_primitive(^^i4);
axiom $is_primitive(^^i8);
axiom $is_primitive(^^u1);
axiom $is_primitive(^^u2);
axiom $is_primitive(^^u4);
axiom $is_primitive(^^u8);
axiom $is_primitive(^^f4);
axiom $is_primitive(^^f8);

const $me_ref : int;
function $me() returns($ptr);
axiom $in_range_spec_ptr($me_ref) && $me_ref != 0;
axiom $me() == $ptr(^$#thread_id_t, $me_ref);

function {:inline true} $current_state(s:$state) returns($state) { s }

type $memory_t;
function $select.mem($memory_t, $ptr) returns(int);
function $store.mem($memory_t, $ptr, int) returns($memory_t);
function $select_range.mem($memory_t, $ptr, int) returns(int);
axiom (forall M:$memory_t, p:$ptr, v:int :: {:weight 0}
  $select.mem($store.mem(M, p, v), p) == v);
axiom (forall M:$memory_t, p:$ptr, q:$ptr, v:int :: {:weight 0}
  p == q
  ||
  $select.mem($store.mem(M, p, v), q) == $select.mem(M, q)
  );
axiom (forall M:$memory_t, p:$ptr, q:$ptr, sz:int, v:int :: {:weight 0}
  ($typ(p) == $typ(q) && $ref(q) <= $ref(p) && $ref(p) < $ref($idx(q, sz, $typ(q))))
  ||
  $select_range.mem($store.mem(M, p, v), q, sz) == $select_range.mem(M, q, sz)
  );

type $typemap_t;
function $select.tm($typemap_t, $ptr) returns($type_state);
function $store.tm($typemap_t, $ptr, $type_state) returns($typemap_t);
axiom (forall M:$typemap_t, p:$ptr, v:$type_state :: {:weight 0}
  $select.tm($store.tm(M, p, v), p) == v);
axiom (forall M:$typemap_t, p:$ptr, q:$ptr, v:$type_state :: {:weight 0}
  p == q
  ||
  $select.tm($store.tm(M, p, v), q) == $select.tm(M, q)
  );

type $statusmap_t;
function $select.sm($statusmap_t, $ptr) returns($status);
function $store.sm($statusmap_t, $ptr, $status) returns($statusmap_t);
axiom (forall M:$statusmap_t, p:$ptr, v:$status :: {:weight 0}
  $select.sm($store.sm(M, p, v), p) == v);
axiom (forall M:$statusmap_t, p:$ptr, q:$ptr, v:$status :: {:weight 0}
  p == q
  ||
  $select.sm($store.sm(M, p, v), q) == $select.sm(M, q)
  );
function $memory(s:$state) returns($memory_t);
function $typemap(s:$state) returns($typemap_t);
function $statusmap(s:$state) returns($statusmap_t);

function {:inline true} $mem(s:$state, p:$ptr) returns(int)
  { $select.mem($memory(s), p) }
function {:inline true} $mem_range(s:$state, p:$ptr, sz:int) returns(int)
  { $select_range.mem($memory(s), p, sz) }
function {:inline true} $mem_eq(s1:$state, s2:$state, p:$ptr) returns(bool)
  { $mem(s1, p) == $mem(s2, p) }
function {:inline true} $st_eq(s1:$state, s2:$state, p:$ptr) returns(bool)
  { $st(s1, p) == $st(s2, p) }
function {:inline true} $ts_eq(s1:$state, s2:$state, p:$ptr) returns(bool)
  { $ts(s1, p) == $ts(s2, p) }

axiom (forall S1:$state, S2:$state, p:$ptr, sz:int :: 
  {$call_transition(S1, S2), $mem_range(S2, p, sz) }
  (forall i:int :: 0 <= i && i < sz ==> $mem(S1, $idx(p, i, $typ(p))) == $mem(S2, $idx(p, i, $typ(p)))) ==>
  $mem_range(S1,p,sz) == $mem_range(S2,p,sz));

// ----------------------------------------------------------------------------
// nesting of structs
// ----------------------------------------------------------------------------
function $extent_hint(p:$ptr, q:$ptr) returns(bool);
axiom (forall p:$ptr, q:$ptr, r:$ptr :: {$extent_hint(p, q), $extent_hint(q, r)}
  $extent_hint(p, q) && $extent_hint(q, r) ==> $extent_hint(p, r));
axiom (forall p:$ptr :: {$typ(p)} $extent_hint(p, p));

function $nesting_level($ctype) returns(int);
function $is_nested($ctype, $ctype) returns(bool);

function $nesting_min($ctype, $ctype) returns(int);
function $nesting_max($ctype, $ctype) returns(int);
function $is_nested_range(t:$ctype, s:$ctype, min:int, max:int) returns(bool)
  { $is_nested(t, s) && $nesting_min(t, s) == min && $nesting_max(t, s) == max }

/*
// emb = emb(emb(...(emb(p))..)), where the number of nested emb is lev
function $is_emb_at_lev(p:$ptr, emb:$ptr, q:$ptr, lev:int) returns(bool)
  { $is_nested($typ(p), $typ(q)) && 
    $nesting_min($typ(p), $typ(q)) <= lev && lev <= $nesting_max($typ(p), $typ(q)) &&
    emb == q }

axiom (forall p:$ptr, q:$ptr, S:$state :: {$in_extent_of(S, p, q), $is_primitive($typ(p))}
  $good_state(S) ==>
    $is_primitive($typ(p)) && $in_extent_of(S, p, q) ==> 
      p == q || $in_extent_of(S, $emb(S, p), q));

function $st_extent($status) returns($ptrset);
axiom (forall S:$state, p:$ptr :: {$extent(S, p)}
  $extent(S, p) == $st_extent($st(S, p)));
*/

// $in_extent_of(S, p, q) ==> p == q || $is_emb_at_lev(p, $emb(S, p), q, 1) || $is_emb_at_lev(p, $emb(S, $emb(S, p)), q, 2) || ... 
// $in_extent_of(S, p, q) <== p == q || $emb(S, p) == q || $emb(S, $emb(S, p)) == q || ... 

//function $no_known_nesting($ctype) returns(bool);
//function $single_known_nesting($ctype, $ctype) returns(bool);
//function $is_known_type($ctype) returns(bool);

//axiom (forall T:$ctype, S:$ctype :: {$is_nested(T, S)}
//  $is_nested(T, S) ==> $nesting_level(T) < $nesting_level(S));

// ----------------------------------------------------------------------------
// typed pointers
// ----------------------------------------------------------------------------

function $typ($ptr)returns($ctype);
function $ref($ptr)returns(int);
function $ptr($ctype,int)returns($ptr);
axiom (forall #t:$ctype, #b:int :: {:weight 0} $typ($ptr(#t,#b))==#t);
axiom (forall #t:$ctype, #b:int :: {:weight 0} $ref($ptr(#t,#b))==#b);
//axiom (forall #p:$ptr :: {$typ(#p)} {$ref(#p)} $ptr($typ(#p), $ref(#p)) == #p);

// Use for computing references for ghost fields, instead of saying p+$field_offset(f) we use
// $ghost_ref(p,f). This has an added bonus that the embedding and path can be the same reagrdless
// of the current $meta
function $ghost_ref($ptr, $field) returns(int);
function $ghost_emb(int) returns($ptr);
function $ghost_path(int) returns($field);
axiom (forall p:$ptr, f:$field :: {:weight 0} {$ghost_ref(p, f)}
  $ghost_emb($ghost_ref(p, f)) == p && $ghost_path($ghost_ref(p, f)) == f );

axiom (forall p:$ptr, f:$field :: {$ghost_ref(p, f)}
  $in_range_spec_ptr($ghost_ref(p,f)));

function $physical_ref(p:$ptr, f:$field) returns(int);
// Make the physical fields, when we do not generate offset axioms, behave like ghost fields
//  (this is unsound, but not so much).
//axiom (forall p:$ptr, f:$field :: {:weight 0} {$physical_ref(p, f)}
//  $ghost_emb($physical_ref(p, f)) == p && $ghost_path($physical_ref(p, f)) == f );

function $array_path(basefield:$field, off:int) returns($field);

function $is_base_field($field) returns(bool);

function $array_path_1($field) returns($field);
function $array_path_2($field) returns(int);
axiom (forall fld:$field, off:int :: {:weight 0} {$array_path(fld, off)}
  !$is_base_field($array_path(fld, off)) &&
  $array_path_1($array_path(fld, off)) == fld &&
  $array_path_2($array_path(fld, off)) == off);

const $null:$ptr;
axiom $null == $ptr(^^void, 0);

//function {:inline true} $is(p:$ptr, t:$ctype) returns (bool)
//  { $typ(p)==t }

//typed pointer test
function $is($ptr,$ctype) returns (bool);
axiom (forall #p:$ptr, #t:$ctype :: {:weight 0} $is(#p,#t)== ($typ(#p)==#t));
// create $ptr(...) function symbol, so later we have something to trigger on
axiom (forall #p:$ptr, #t:$ctype :: {$is(#p, #t)} $is(#p, #t) ==> #p == $ptr(#t, $ref(#p)));

function {:inline true} $ptr_cast(#p:$ptr,#t:$ctype) returns($ptr)
  { $ptr(#t, $ref(#p)) }

function {:inline true} $read_ptr(S:$state, p:$ptr, t:$ctype) returns($ptr)
  { $ptr(t, $mem(S, p)) }

//dot and (its "inverse") emb/path access
function $dot($ptr,$field) returns ($ptr);
function {:inline true} $emb(S:$state,#p:$ptr) returns ($ptr)
  { $ts_emb($ts(S, #p)) }
function {:inline true} $path(S:$state,#p:$ptr) returns($field)
  { $ts_path($ts(S, #p)) }

// assumed by the compiler in struct translation
function $is_primitive_non_volatile_field($field) returns(bool);
function $is_primitive_volatile_field($field) returns(bool);
function $is_primitive_embedded_array(f:$field, sz:int) returns(bool);
function $is_primitive_embedded_volatile_array(f:$field, sz:int, t:$ctype) returns(bool);

function $embedded_array_size(f:$field, t:$ctype) returns(int);

function {:inline true} $static_field_properties(f:$field, t:$ctype) returns(bool)
  { $is_base_field(f) && $field_parent_type(f) == t }

function {:inline true} $field_properties(S:$state, p:$ptr, f:$field, tp:$ctype, isvolatile:bool)  returns(bool)
  { $typed2(S, $dot(p, f), tp) &&
    $emb(S, $dot(p, f)) == p &&
    $path(S, $dot(p, f)) == f &&
    $is_volatile(S, $dot(p, f)) == isvolatile 
  }

function $ts_typed($type_state) returns(bool);
function $ts_emb($type_state) returns($ptr);
function $ts_path($type_state) returns($field);
function $ts_is_volatile($type_state) returns(bool);
  
axiom (forall ts:$type_state :: {$ts_emb(ts)} $kind_of($typ($ts_emb(ts))) != $kind_primitive && $is_non_primitive($typ($ts_emb(ts))) );

function $simple_emb(p:$ptr) returns($ptr);

axiom (forall p:$ptr, f:$field :: {$simple_emb($dot(p, f))} $simple_emb($dot(p, f)) == p);

//V2:
axiom (forall S:$state, p:$ptr :: {$typed(S, p), $ts(S, $emb(S, p))} $typed(S, p) ==> $typed(S, $emb(S, p)));
//axiom (forall S:$state, p:$ptr :: {$typed(S, p), $typed(S, $emb(S, p))} $typed(S, p) ==> $typed(S, $emb(S, p)));

// it has no further embedding (not embedded inside another struct)
function {:inline true} $is_object_root(S:$state, p:$ptr) returns(bool)
  { $emb(S, p) == $ptr(^^root_emb, $ref(p)) }

function {:inline true} $is_volatile(S:$state, p:$ptr) returns(bool)
  { $ts_is_volatile($ts(S, p)) }

axiom (forall S:$state, p:$ptr ::
  {$is_volatile(S, p)} $good_state(S) && $is_volatile(S, p) ==> $is_primitive_ch($typ(p)));

// just tmp
function {:inline true} $is_malloc_root(S:$state, p:$ptr) returns(bool)
  { $is_object_root(S, p) }

/*
function $prim_emb(S:$state, p:$ptr) returns($ptr);
axiom (forall S:$state, p:$ptr :: {$is_primitive($typ(p)), $prim_emb(S, p)}
  $is_primitive($typ(p)) ==> $prim_emb(S, p) == $emb(S, p));
axiom (forall S:$state, p:$ptr :: {$is_non_primitive($typ(p)), $prim_emb(S, p)}
  $is_non_primitive($typ(p)) ==> $prim_emb(S, p) == p);
*/

function $current_timestamp(S:$state) returns(int);
axiom (forall S:$state, p:$ptr :: {:weight 0} {$st(S, p)}
  $timestamp(S, p) <= $current_timestamp(S) ||
  !$ts_typed($ts(S, p))
  );

function {:inline true} $is_fresh(M1:$state, M2:$state, p:$ptr) returns(bool)
  { $current_timestamp(M1) < $timestamp(M2, p) && $timestamp(M2, p) <= $current_timestamp(M2) }

function $in_writes_at(time:int, p:$ptr) returns(bool);

function {:inline true} $writable(S:$state, begin_time:int, p:$ptr) returns(bool)
  { ($in_writes_at(begin_time, p) || $timestamp(S, p) >= begin_time) && $mutable(S, p) }

function {:inline true} $top_writable(S:$state, begin_time:int, p:$ptr) returns(bool)
  { ($in_writes_at(begin_time, p) || $timestamp(S, p) >= begin_time)
    && $thread_owned_or_even_mutable(S, p) }

// ----------------------------------------------------------------------------
// Value structs
// ----------------------------------------------------------------------------

const $struct_zero : $struct;

axiom ($good_state($vs_state($struct_zero)));

function {:inline true} $vs_base(s:$struct, t:$ctype) returns($ptr)
  { $ptr(t, $vs_base_ref(s)) }
function $vs_base_ref($struct) returns(int);

function $vs_state($struct) returns($state);
axiom (forall s:$struct :: $good_state($vs_state(s)));

function $vs_ctor(S:$state, p:$ptr) returns($struct);
axiom (forall S:$state, p:$ptr :: {$vs_ctor(S, p)}
  $good_state(S) ==>
    $vs_base_ref($vs_ctor(S, p)) == $ref(p) && $vs_state($vs_ctor(S, p)) == S);

axiom (forall f:$field, t:$ctype :: { $mem($vs_state($struct_zero), $dot($vs_base($struct_zero, t), f)) }
  $mem($vs_state($struct_zero), $dot($vs_base($struct_zero, t), f)) == 0);

// ----------------------------------------------------------------------------
// Records
// ----------------------------------------------------------------------------

type $record;
const $rec_zero : $record;
function $rec_update(r:$record, f:$field, v:int) returns($record);
function $rec_fetch(r:$record, f:$field) returns(int);

function $rec_update_bv(r:$record, f:$field, val_bitsize:int, from:int, to:int, repl:int) returns($record)
  { $rec_update(r, f, $bv_update($rec_fetch(r, f), val_bitsize, from, to, repl)) }

axiom (forall f:$field :: $rec_fetch($rec_zero, f) == 0);

axiom (forall r:$record, f:$field, v:int :: {$rec_fetch($rec_update(r, f, v), f)}
  $rec_fetch($rec_update(r, f, v), f) == $unchecked($record_field_int_kind(f), v));

axiom (forall r:$record, f:$field :: {$rec_fetch(r, f)}
  $in_range_t($record_field_int_kind(f), $rec_fetch(r, f)));

axiom (forall r:$record, f1:$field, f2:$field, v:int :: {$rec_fetch($rec_update(r, f1, v), f2)}
  $rec_fetch($rec_update(r, f1, v), f2) == $rec_fetch(r, f2) || f1 == f2);

function $is_record_type(t:$ctype) returns(bool);
function $is_record_field(parent:$ctype, field:$field, field_type:$ctype) returns(bool);

axiom (forall t:$ctype :: {$is_record_type(t)} $is_record_type(t) ==> $is_primitive(t));

function $as_record_record_field($field) returns($field);
axiom (forall p:$ctype, f:$field, ft:$ctype :: {$is_record_field(p, f, ft), $is_record_type(ft)}
  $is_record_field(p, f, ft) && $is_record_type(ft) ==> $as_record_record_field(f) == f);

function $record_field_int_kind(f:$field) returns($ctype);

function $rec_eq(r1:$record, r2:$record) returns(bool)
  { r1 == r2 }
function $rec_base_eq(x:int, y:int) returns(bool)
  { x == y }

function $int_to_record(x:int) returns($record);
function $record_to_int(r:$record) returns(int);

axiom (forall r:$record :: $int_to_record($record_to_int(r)) == r);

axiom (forall r1:$record, r2:$record :: {$rec_eq(r1, r2)}
  $rec_eq(r1, r2) <==
  (forall f:$field :: $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f))));

axiom (forall r1:$record, r2:$record, f:$field ::
 {$rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, $as_record_record_field(f)))}
 $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)) <==
   $rec_eq($int_to_record($rec_fetch(r1, f)), $int_to_record($rec_fetch(r2, f))));


// ----------------------------------------------------------------------------
// state
// ----------------------------------------------------------------------------
var $s: $state;

function $good_state($state) returns(bool);
function $invok_state($state) returns(bool);

const $state_zero : $state; // for record/map initialization

function $has_volatile_owns_set(t:$ctype) returns(bool);
axiom $has_volatile_owns_set(^^claim);

function $owns_set_field(t:$ctype) returns($field);

axiom (forall #p: $ptr, t:$ctype :: { $dot(#p, $owns_set_field(t)) } 
  $dot(#p, $owns_set_field(t)) == $ptr(^$#ptrset, $ghost_ref(#p, $owns_set_field(t))));

function $st_owner($status) returns($ptr);
function $st_closed($status) returns(bool);
function $st_timestamp($status) returns(int);
function $st_ref_cnt(s:$status) returns(int);

function $owner(S:$state, p:$ptr) returns($ptr);
function $closed(S:$state, p:$ptr) returns(bool);
function $timestamp(S:$state, p:$ptr) returns(int);

axiom (forall S:$state, p:$ptr :: {:weight 0} {$is_primitive($typ(p)), $owner(S, p)}
  $is_primitive($typ(p)) ==> $owner(S, p) == $owner(S, $emb(S, p)));
axiom (forall S:$state, p:$ptr :: {:weight 0} {$is_non_primitive($typ(p)), $owner(S, p)}
  $is_non_primitive($typ(p)) ==> $owner(S, p) == $st_owner($st(S, p)));
 
axiom (forall S:$state, p:$ptr :: {:weight 0} {$is_primitive($typ(p)), $closed(S, p)}
  $is_primitive($typ(p)) ==> $closed(S, p) == $st_closed($st(S, $emb(S, p))));
axiom (forall S:$state, p:$ptr :: {:weight 0} {$is_non_primitive($typ(p)), $closed(S, p)}
  $is_non_primitive($typ(p)) ==> $closed(S, p) == $st_closed($st(S, p)));
 
axiom (forall S:$state, p:$ptr :: {:weight 0} {$is_primitive($typ(p)), $timestamp(S, p)}
  $is_primitive($typ(p)) ==> $timestamp(S, p) == $st_timestamp($st(S, $emb(S, p))));
axiom (forall S:$state, p:$ptr :: {:weight 0} {$is_non_primitive($typ(p)), $timestamp(S, p)}
  $is_non_primitive($typ(p)) ==> $timestamp(S, p) == $st_timestamp($st(S, p)));
 
function $position_marker() returns(bool);
axiom $position_marker();

axiom (forall s:$status :: {$st_owner(s)} $kind_of($typ($st_owner(s))) != $kind_primitive && $is_non_primitive($typ($st_owner(s))));

function {:inline true} $st(S:$state, p:$ptr) returns($status)
  { $select.sm($statusmap(S), p) }

function {:inline true} $ts(S:$state, p:$ptr) returns($type_state)
  { $select.tm($typemap(S), p) }

function {:weight 0} $owns(S:$state, #p:$ptr)returns($ptrset)
  { $int_to_ptrset($mem(S, $dot(#p, $owns_set_field($typ(#p))))) }

function {:inline true} $nested(S:$state, p:$ptr) returns(bool)
  { $kind_of($typ($owner(S, p))) != $kind_thread }

function {:inline true} $nested_in(S:$state, p:$ptr, owner:$ptr) returns(bool)
  { $owner(S, p) == owner && $closed(S, p) }

function {:inline true} $wrapped(S:$state, #p:$ptr, #t:$ctype) returns(bool)
  { $closed(S, #p) && $owner(S, #p) == $me() && $typed2(S, #p, #t) && $kind_of(#t) != $kind_primitive && $is_non_primitive(#t) }

function {:inline true} $irrelevant(S:$state, p:$ptr) returns(bool)
  { $owner(S, p) != $me() || ($is_primitive_ch($typ(p)) && $closed(S, p)) }

function {:weight 0} $mutable(S:$state, p:$ptr) returns(bool)
  { $typed(S, p) && $owner(S, p) == $me() && !$closed(S, p) }

function {:inline true} $thread_owned(S:$state, p:$ptr) returns(bool)
  { $typed(S, p) && $owner(S, p) == $me() }

function {:inline true} $thread_owned_or_even_mutable(S:$state, p:$ptr) returns(bool)
  { $typed(S, p) && $owner(S, p) == $me() && ($is_primitive_ch($typ(p)) ==> !$closed(S, p)) }

function $typed(S:$state, p:$ptr) returns(bool);
axiom
  (forall S:$state, #p:$ptr :: {:weight 0} {$typed(S,#p)} $good_state(S) ==> $typed(S,#p) == $ts_typed($ts(S, #p)));
axiom
  (forall S:$state, #p:$ptr :: {$typed(S,#p)} $good_state(S) && $typed(S,#p) ==> $ref(#p) > 0);

function {:inline} $is_ghost_ptr(p:$ptr) returns(bool)
  { $in_range_spec_ptr($ref(p)) }

function $in_range_phys_ptr(#r:int) returns(bool)
  { $in_range(0, #r, $arch_spec_ptr_start) }
function $in_range_spec_ptr(#r:int) returns(bool)
  { 0 == #r || #r > $arch_spec_ptr_start }
const $arch_spec_ptr_start : int; // arch-specific; to be defined by a compiler-generated axiom

function {:inline true} $typed2(S:$state, #p:$ptr, #t:$ctype) returns(bool)
  { $is(#p, #t) && $typed(S, #p) }

axiom (forall S:$state, #r:int, #t:$ctype :: {$typed(S, $ptr(#t, #r))}
  $typed(S, $ptr(#t, #r)) && $in_range_phys_ptr(#r) ==> $in_range_phys_ptr(#r + $sizeof(#t) - 1));

function {:inline true} $typed2_phys(S:$state, #p:$ptr, #t:$ctype) returns (bool)
  { $typed2(S, #p, #t) && ($typed2(S, #p, #t) ==> $in_range_phys_ptr($ref(#p))) }

function {:inline true} $typed2_spec(S:$state, #p:$ptr, #t:$ctype) returns (bool)
  { $typed2(S, #p, #t) && ($typed2(S, #p, #t) ==> $in_range_spec_ptr($ref(#p))) }

function {:inline true} $ptr_eq(p1:$ptr,p2:$ptr) returns(bool)
  { $ref(p1) == $ref(p2) }

function {:inline true} $ptr_neq(p1:$ptr,p2:$ptr) returns(bool)
  { $ref(p1) != $ref(p2) }

//axiom (forall #p : $ptr, #f1 : $field, #f2 : $field ::
//  { $ref($dot(#p, #f1)), $ref($dot(#p, #f2)) }
//  ($ref($dot(#p, #f1)) == $ref($dot(#p, #f2))) ==> (#f1 == #f2));

// Unsound version - fast

//axiom (forall /* S: $state, */ #p1: $ptr, #p2: $ptr, #f1 : $field, #f2 : $field :: 
//  { /* $typed(S, #p1), $typed(S, #p2), */ $ref($dot(#p1, #f1)), $ref($dot(#p2, #f2)) } 
//  /* $typed(S, #p1) && $typed(S, #p2) && */ ($ref($dot(#p1, #f1)) == $ref($dot(#p2, #f2))) ==> (#p1 == #p2 && #f1 == #f2));

// Sound version - currently slow

//axiom (forall S: $state, #p1: $ptr, #p2: $ptr, #f1 : $field, #f2 : $field :: 
//  { $typed(S, #p1), $typed(S, #p2), $ref($dot(#p1, #f1)), $ref($dot(#p2, #f2)) } 
//  $typed(S, #p1) && $typed(S, #p2) && ($ref($dot(#p1, #f1)) == $ref($dot(#p2, #f2))) ==> (#p1 == #p2 && #f1 == #f2));

//axiom (forall S:$state, #p1: $ptr, #p2: $ptr, #f1: $field, #f2: $field ::
//  $typed(S, #p1) && $typed(S, #p2) && $typ(#p1) != $typ(#p2) ==> $ref($dot(#p1, #f1)) != $ref($dot(#p2, #f2)))

//function $any_nonmutable(#m1:$state, #m2:$state, #p:$ptr) returns(bool)
//  { $closed(#m1, #p) || $closed(#m2, #p) }

function {:inline true} $is_primitive_field_of(S:$state, #f:$ptr, #o:$ptr) returns(bool)
  { $is_primitive_ch($typ(#f)) && $emb(S, #f) == #o }


// ----------------------------------------------------------------------------
// thread locality
// ----------------------------------------------------------------------------

/*
// an owner that is itself owned by a thread
function $top_owner(S:$state, p:$ptr) returns($ptr);

function $fetch_top_owner(v:$version, q:$ptr) returns($ptr);

axiom (forall S:$state, p:$ptr ::
$top_owner(S, p) == $fetch_top_owner($read_version(S, $top_owner(S, p)), p));
*/

/*
function {:inline true} $thread_owner(S:$state, obj:$ptr) returns($ptr)
  { $st_thread_owner($statusmap(S), obj) }
function $st_thread_owner(S:$statusmap_t, obj:$ptr) returns($ptr);

axiom (forall S:$state, p:$ptr :: {$owner(S, p)}
   $owner(S, p) == $me() ==> $thread_owner(S, p) == $me());
axiom (forall S:$state, p:$ptr :: {$owner(S, p)}
   $thread_owner(S, p) == $thread_owner(S, $owner(S, p)));
*/

function $instantiate_st(s:$status) returns(bool);
axiom (forall S1:$state, S2:$state, p:$ptr :: {$st(S2, p), $call_transition(S1, S2)}
  $call_transition(S1, S2) ==>
  $instantiate_st($st(S1, p)));

axiom (forall S1:$state, S2:$state, p:$ptr :: {$mem(S2, p), $call_transition(S1, S2)}
  $call_transition(S1, S2) ==>
  $instantiate_int($mem(S1, p)));

/*
axiom (forall S:$state, p:$ptr :: {$thread_owner(S, p), $is_primitive($typ(p))}
  $instantiate_st($st(S, $emb(S, p))));
axiom (forall S:$state, p:$ptr :: {$thread_owner(S, p)}
  $instantiate_st($st(S, p)));
*/

/*
type $rootmap;
function $select.root($rootmap, $ptr) returns($ptr);
function $store.root($rootmap, $ptr, $ptr) returns($rootmap);
axiom (forall M:$rootmap, p:$ptr, v:$ptr :: {:weight 0}
  $select.root($store.root(M, p, v), p) == v);
axiom (forall M:$rootmap, p:$ptr, q:$ptr, v:$ptr :: {:weight 0}
  p != q ==> $select.root($store.root(M, p, v), q) == $select.root(M, q));

function $get_root(S:$state) returns($rootmap);
function {:inline true} $root(S:$state, p:$ptr) returns($ptr)
  { $select.root($get_root(S), p) }
*/

// for model reading
function $is_domain_root(S:$state, p:$ptr) returns(bool)
  { true }

function $in_wrapped_domain(S:$state, p:$ptr) returns(bool)
  { (exists q:$ptr :: {$set_in2(p, $ver_domain($read_version(S, q)))} 
            $set_in(p, $ver_domain($read_version(S, q)))
         && $wrapped(S, q, $typ(q)) 
         && $is_domain_root(S, q)
         ) }

function {:inline true} $thread_local_np(S:$state, p:$ptr) returns(bool)
  { !$is_primitive_ch($typ(p)) && 
    ($owner(S, p) == $me() || $in_wrapped_domain(S, p)) 
//     ($wrapped(S, $root(S, p), $typ($root(S, p))) && $set_in(p, $domain(S, $root(S, p)))))
  }

// required for reading
function $thread_local(S:$state, p:$ptr) returns(bool)
  { $typed(S, p) &&
    (($is_primitive_ch($typ(p)) && (!$is_volatile(S, p) || !$closed(S, $emb(S, p))) && $thread_local_np(S, $emb(S, p))) ||
     $thread_local_np(S, p)) }

function {:inline true} $thread_local2(S:$state, #p:$ptr, #t:$ctype) returns(bool)
  { $is(#p, #t) && $thread_local(S, #p) }

 

// ----------------------------------------------------------------------------
// Boogie/Z3 hacks
// ----------------------------------------------------------------------------

// Used as a trigger when we don't want the quantifier to be instantiated at all
//   (for example we just assert it or have it as a precondition)
// It could be any symbol that is not used anywhere else.
function $dont_instantiate($ptr) returns(bool);
function $dont_instantiate_int(int) returns(bool);
function $dont_instantiate_state($state) returns(bool);

// Voodoo, don't read it.
function $instantiate_int(int) returns(bool);
function $instantiate_bool(bool) returns(bool);
function $instantiate_ptr($ptr) returns(bool);
function $instantiate_ptrset($ptrset) returns(bool);
// Voodoo end.

// ----------------------------------------------------------------------------
// ownership protocol
// ----------------------------------------------------------------------------
function {:inline true} $inv(#s1:$state, #p:$ptr, typ:$ctype) returns (bool)
  { $inv2(#s1, #s1, #p, typ) }

function {:inline true} $inv2nt(S1:$state, S2:$state, p:$ptr) returns (bool)
  { $inv2(S1, S2, p, $typ(p)) }

function $imply_inv(#s1:$state, #p:$ptr, typ:$ctype) returns (bool);
axiom (forall #s1:$state, #p:$ptr, typ:$ctype :: {$inv(#s1, #p, typ)}
  $imply_inv(#s1, #p, typ) ==> $inv(#s1, #p, typ));

// We generate axioms like:
//   inv2(S1,S2,p,T) <==> invariant of T
// for each struct/union T.
function $inv2(#s1:$state, #s2:$state, #p:$ptr, typ:$ctype) returns (bool);

// used in admissibility check
function {:inline true} $inv2_when_closed(#s1:$state, #s2:$state, #p:$ptr, typ:$ctype) returns (bool)
  { (!$closed(#s1, #p) && !$closed(#s2, #p)) || ($inv2(#s1, #s2, #p, typ) && $nonvolatile_spans_the_same(#s1, #s2, #p, typ)) }

function {:weight 0} $sequential(#s1:$state, #s2:$state, #p:$ptr, #t:$ctype) returns (bool)
  { $closed(#s1, #p) && $closed(#s2, #p) ==> $spans_the_same(#s1, #s2, #p, #t) }

function {:weight 0} $depends(#s1:$state, #s2:$state, #dependant:$ptr, #this:$ptr) returns (bool)
  { $spans_the_same(#s1, #s2, #this, $typ(#this)) || 
    $inv2_when_closed(#s1, #s2, #dependant, $typ(#dependant)) ||
    $is_threadtype($typ(#dependant)) }

function {:weight 0} $spans_the_same(#s1:$state, #s2:$state, #p:$ptr, #t:$ctype) returns (bool)
  {    $read_version(#s1, #p) == $read_version(#s2, #p)
    && $owns(#s1, #p) == $owns(#s2, #p)
    && $ts(#s1, #p) == $ts(#s2, #p)
    && $state_spans_the_same(#s1, #s2, #p, #t) }

// excludes any meta state, includes only primitive fields, not embedded structs
function $state_spans_the_same(#s1:$state, #s2:$state, #p:$ptr, #t:$ctype) returns (bool);

function {:weight 0} $nonvolatile_spans_the_same(#s1:$state, #s2:$state, #p:$ptr, #t:$ctype) returns (bool)
  {    $read_version(#s1, #p) == $read_version(#s2, #p)
    && $ts(#s1, #p) == $ts(#s2, #p)
    && $state_nonvolatile_spans_the_same(#s1, #s2, #p, #t) }

// excludes any meta state, includes only non-volatile primitive fields, not embedded structs
function $state_nonvolatile_spans_the_same(#s1:$state, #s2:$state, #p:$ptr, #t:$ctype) returns (bool);

// $in_extent_of(S, p1, p2) means that p1 is a pointer nested (at any level, including 0!) in p2
// $in_full_extent_of(...) assumes it can be any of the union fields, not only the selected one
function {:inline true} $in_extent_of(S:$state, #p1:$ptr, #p2:$ptr) returns(bool)
  { $set_in(#p1, $extent(S, #p2)) }
function {:inline true} $in_full_extent_of(#p1:$ptr, #p2:$ptr) returns(bool)
  { $set_in(#p1, $full_extent(#p2)) }

function $extent_mutable(S:$state, p:$ptr) returns(bool);
function $extent_is_fresh(S1:$state, S2:$state, p:$ptr) returns(bool);
function $extent_zero(S:$state, p:$ptr) returns(bool);

axiom (forall T:$ctype :: {$is_primitive(T)}
  $is_primitive(T) ==> 
    (forall r:int, p:$ptr :: {$in_full_extent_of(p, $ptr(T, r))}
      $in_full_extent_of(p, $ptr(T, r)) <==> p == $ptr(T, r)) &&
    (forall r:int, S:$state :: {$extent_mutable(S, $ptr(T, r))}
      $extent_mutable(S, $ptr(T, r)) <==> $mutable(S, $ptr(T, r))));

axiom (forall T:$ctype :: {$is_primitive(T)}
  $is_primitive(T) ==> 
    (forall S:$state, r:int, p:$ptr :: {$in_extent_of(S, p, $ptr(T, r))}
      $in_extent_of(S, p, $ptr(T, r)) <==> p == $ptr(T, r)));
      
axiom (forall S:$state, T:$ctype, sz:int, r:int :: {$extent_mutable(S, $ptr($array(T, sz), r))}
  $extent_mutable(S, $ptr($array(T, sz), r)) <==>
    $mutable(S, $ptr($array(T, sz), r)) &&
    (forall i:int :: {$extent_mutable(S, $idx($ptr(T, r), i, T))}
       0 <= i && i < sz ==> $extent_mutable(S, $idx($ptr(T, r), i, T)))
);

axiom (forall T:$ctype :: {$is_primitive(T)}
  $is_primitive(T) ==>
      (forall S:$state, r:int :: {$extent_zero(S, $ptr(T,r))}
       $extent_zero(S, $ptr(T,r)) <==> $mem(S, $ptr(T,r)) == 0 ));

axiom (forall S:$state, T:$ctype, sz:int, r:int :: {$extent_zero(S, $ptr($array(T, sz), r))}
  $extent_zero(S, $ptr($array(T, sz), r)) <==>
    (forall i:int :: {$idx($ptr(T, r), i, T)}
       0 <= i && i < sz ==> $extent_zero(S, $idx($ptr(T, r), i, T)))
);


function {:inline true} $forall_inv2_when_closed(#s1:$state, #s2:$state) returns (bool)
 { (forall #p:$ptr :: {$closed(#s1,#p)} {$closed(#s2,#p)} $inv2_when_closed(#s1,#s2,#p,$typ(#p)))
 }

function $function_entry($state) returns(bool);

function $full_stop($state) returns(bool);
function {:inline true} $full_stop_ext(t:$token, S:$state) returns(bool)
  { $good_state_ext(t, S) && $full_stop(S) }

function $file_name_is(id:int, tok:$token) returns(bool);

axiom (forall S:$state :: {$function_entry(S)}
  $function_entry(S) ==> $full_stop(S) && $current_timestamp(S) >= 0);

axiom (forall S:$state :: {$full_stop(S)}
  $full_stop(S) ==> $good_state(S) && $invok_state(S));

axiom (forall S:$state :: {$invok_state(S)}
  $invok_state(S) ==> $good_state(S));

function {:inline true} $closed_is_transitive(S:$state) returns (bool)
  { 
    (forall #p:$ptr,#q:$ptr :: {$set_in(#p, $owns(S, #q))}
      $good_state(S) &&
      $set_in(#p, $owns(S, #q)) && $closed(S, #q) ==> $closed(S, #p)  && $ref(#p) != 0)
 } 
        
// ----------------------------------------------------------------------------
// 
// ----------------------------------------------------------------------------

function $call_transition(S1:$state, S2:$state) returns(bool);

// Assumed after each meta/state update, means that the meta corresponds to the state
// and where in the source did the update happen.
function $good_state_ext(id:$token, S:$state) returns(bool);
axiom (forall id:$token, S:$state :: {$good_state_ext(id, S)}
  $good_state_ext(id, S) ==> $good_state(S));

// ----------------------------------------------------------------------------
// model-viewer support
// ----------------------------------------------------------------------------

function $local_value_is(S1:$state, pos:$token, local_name:$token, val:int, t:$ctype) returns(bool);
function $local_value_is_ptr(S1:$state, pos:$token, local_name:$token, val:$ptr, t:$ctype) returns(bool);
function $read_ptr_m(S:$state, p:$ptr, t:$ctype) returns($ptr);

// for easier model viewing
axiom (forall S:$state, r:int, t:$ctype :: {$ptr(t, $mem(S, $ptr($ptr_to(t), r)))}
  $ptr(t, $mem(S, $ptr($ptr_to(t), r))) == $read_ptr_m(S, $ptr($ptr_to(t), r), t));

axiom (forall S:$state, r:int, t:$ctype :: {$ptr(t, $mem(S, $ptr($spec_ptr_to(t), r)))}
  $ptr(t, $mem(S, $ptr($spec_ptr_to(t), r))) == $read_ptr_m(S, $ptr($spec_ptr_to(t), r), t));

function $type_code_is(x:int, tp:$ctype) returns(bool);
// idx==0 - return type
function $function_arg_type(fnname:$pure_function, idx:int, tp:$ctype) returns(bool);

// -------------------------------------------------------------------------------------
// the domain thing
// -------------------------------------------------------------------------------------

type $version;
function $ver_domain($version) returns($ptrset);

function {:weight 0} $read_version(S:$state, p:$ptr) returns($version)
  { $int_to_version($mem(S, p)) }

function {:weight 0} $domain(S:$state, p:$ptr) returns($ptrset)
  { $ver_domain($read_version(S, p)) }

function $in_domain(S:$state, p:$ptr, q:$ptr) returns(bool);
function $in_vdomain(S:$state, p:$ptr, q:$ptr) returns(bool);

function $in_domain_lab(S:$state, p:$ptr, q:$ptr, l:$label) returns(bool);
function $in_vdomain_lab(S:$state, p:$ptr, q:$ptr, l:$label) returns(bool);
function $inv_lab(S:$state, p:$ptr, l:$label) returns(bool);

axiom (forall S:$state, p:$ptr, q:$ptr, l:$label :: {:weight 0} {$in_domain_lab(S, p, q, l)}
  $in_domain_lab(S, p, q, l) ==> $inv_lab(S, p, l));

axiom (forall S:$state, p:$ptr, q:$ptr, l:$label :: {:weight 0} {$in_domain_lab(S, p, q, l)}
  $in_domain_lab(S, p, q, l) <==> $in_domain(S, p, q));

axiom (forall S:$state, p:$ptr, q:$ptr, l:$label :: {:weight 0} {$in_vdomain_lab(S, p, q, l)}
  $in_vdomain_lab(S, p, q, l) ==> $inv_lab(S, p, l));

axiom (forall S:$state, p:$ptr, q:$ptr, l:$label :: {:weight 0} {$in_vdomain_lab(S, p, q, l)}
  $in_vdomain_lab(S, p, q, l) <==> $in_vdomain(S, p, q));

function {:inline true} $dom_thread_local(S:$state, #p:$ptr) returns(bool)
  { $typed(S, #p) && !$is_volatile(S, #p) }

axiom (forall S:$state, p:$ptr, q:$ptr :: {:weight 0} {$in_domain(S, p, q)}
  $in_domain(S, p, q) ==> 
       $set_in(p, $domain(S, q)) 
    && $closed(S, p) 
    && (forall r:$ptr :: {$set_in(r, $owns(S, p))} 
             !$has_volatile_owns_set($typ(p)) && $set_in(r, $owns(S, p)) ==> 
                        $set_in2(r, $ver_domain($read_version(S, q))))
  );

axiom (forall S:$state, p:$ptr :: {$in_domain(S, p, p)}
  $full_stop(S) && $wrapped(S, p, $typ(p)) ==> $in_domain(S, p, p));

/*
axiom (forall S:$state, p:$ptr, q:$ptr, r:$ptr ::
  { $in_domain(S, q, p), $in_domain(S, r, p) }
  $in_domain(S, q, p) && $set_in0(r, $owns(S, q)) ==> $in_domain(S, r, p) && $set_in0(r, $owns(S, q)));
*/

axiom (forall S:$state, p:$ptr, q:$ptr :: 
  {:weight 0} { $in_domain(S, q, p) }
  $full_stop(S) && $set_in(q, $domain(S, p)) ==> $in_domain(S, q, p));

axiom (forall S:$state, p:$ptr, q:$ptr, r:$ptr :: 
  {:weight 0} { $set_in(q, $domain(S, p)), $in_domain(S, r, p) }
  !$has_volatile_owns_set($typ(q)) &&
  $set_in(q, $domain(S, p)) && $set_in0(r, $owns(S, q)) ==> $in_domain(S, r, p) && $set_in0(r, $owns(S, q)));

axiom (forall S:$state, p:$ptr, q:$ptr, r:$ptr :: 
  {:weight 0} { $set_in(q, $domain(S, p)), $in_vdomain(S, r, p) }
  $has_volatile_owns_set($typ(q)) && 
  $set_in(q, $domain(S, p)) &&
  (forall S1:$state :: 
      $inv(S1, q, $typ(q)) && 
      $read_version(S1, p) == $read_version(S, p) &&
      $domain(S1, p) == $domain(S, p)
      ==> $set_in0(r, $owns(S1, q)))
    ==> $in_vdomain(S, r, p) && $set_in0(r, $owns(S, q)));

axiom (forall S:$state, p:$ptr, q:$ptr :: 
  {:weight 0} { $in_vdomain(S, p, q) } $in_vdomain(S, p, q) ==> $in_domain(S, p, q));

function $fetch_from_domain(v:$version, p:$ptr) returns(int);

axiom (forall S:$state, p:$ptr, d:$ptr, f:$field ::
  { $set_in(p, $domain(S, d)), $is_primitive_non_volatile_field(f), $mem(S, $dot(p, f)) }
  $set_in(p, $domain(S, d)) && $is_primitive_non_volatile_field(f) ==> 
    $mem(S, $dot(p, f)) == $fetch_from_domain($read_version(S, d), $dot(p, f)));

axiom (forall S:$state, p:$ptr, d:$ptr :: 
  { $full_stop(S), $set_in(p, $domain(S, d)), $st(S, p) }
  { $full_stop(S), $set_in(p, $domain(S, d)), $ts(S, p) }
  $full_stop(S) && $set_in(p, $domain(S, d)) ==> 
    $dom_thread_local(S, p));

axiom (forall S:$state, p:$ptr, d:$ptr, f:$field :: 
  { $set_in(p, $domain(S, d)), $is_primitive_non_volatile_field(f), $owner(S, $dot(p, f)) }
  { $set_in(p, $domain(S, d)), $is_primitive_non_volatile_field(f), $ts(S, $dot(p, f)) }
  $full_stop(S) && $set_in(p, $domain(S, d)) && $is_primitive_non_volatile_field(f) ==> 
    $dom_thread_local(S, $dot(p, f)));

axiom (forall S:$state, p:$ptr, d:$ptr, f:$field, sz:int, i:int, t:$ctype :: 
  { $set_in(p, $domain(S, d)), $is_primitive_embedded_array(f, sz), $mem(S, $idx($dot(p, f), i, t)) }
  $full_stop(S) && $set_in(p, $domain(S, d)) && $is_primitive_embedded_array(f, sz) && 0 <= i && i < sz ==> 
    $mem(S, $idx($dot(p, f), i, t)) == $fetch_from_domain($read_version(S, d), $idx($dot(p, f), i, t)));

axiom (forall S:$state, p:$ptr, d:$ptr, f:$field, sz:int, i:int, t:$ctype :: 
  { $set_in(p, $domain(S, d)), $is_primitive_embedded_array(f, sz), $ts(S, $idx($dot(p, f), i, t)) }
  { $set_in(p, $domain(S, d)), $is_primitive_embedded_array(f, sz), $owner(S, $idx($dot(p, f), i, t)) }
  $full_stop(S) && $set_in(p, $domain(S, d)) && $is_primitive_embedded_array(f, sz) && 0 <= i && i < sz ==> 
    $dom_thread_local(S, $idx($dot(p, f), i, t)));

axiom (forall S:$state, r:int, d:$ptr, sz:int, i:int, t:$ctype :: 
  { $set_in($ptr($array(t,sz), r), $domain(S, d)), $ts(S, $idx($ptr(t,r), i, t)), $is_primitive(t) }
  { $set_in($ptr($array(t,sz), r), $domain(S, d)), $owner(S, $idx($ptr(t,r), i, t)), $is_primitive(t) }
  $full_stop(S) && 
  $is_primitive(t) &&
  $set_in($ptr($array(t,sz), r), $domain(S, d)) &&
  0 <= i && i < sz ==> 
    $dom_thread_local(S, $idx($ptr(t,r), i, t)));

axiom (forall S:$state, r:int, d:$ptr, sz:int, i:int, t:$ctype :: 
  { $set_in($ptr($array(t,sz), r), $domain(S, d)), $mem(S, $idx($ptr(t,r), i, t)), $is_primitive(t) }
  $full_stop(S) && 
  $is_primitive(t) &&
  $set_in($ptr($array(t,sz), r), $domain(S, d)) &&
  0 <= i && i < sz ==> 
    $mem(S, $idx($ptr(t,r), i, t)) == $fetch_from_domain($read_version(S, d), $idx($ptr(t,r), i, t)));

axiom (forall S:$state, p:$ptr, f:$field, sz:int, i:int, t:$ctype ::
  {$is_primitive_embedded_volatile_array(f, sz, t), $is_volatile(S, $idx($dot(p, f), i, t))}
  $good_state(S) && $is_primitive_embedded_volatile_array(f, sz, t) && 0 <= i && i < sz ==>
    $is_volatile(S, $idx($dot(p, f), i, t)));

/*
axiom (forall S1:$state, S2:$state, p:$ptr :: 
  {$domain(S1, p), $full_stop(S2)}
    $instantiate_ptrset($domain(S1, p)) && $instantiate_ptrset($domain(S2, p)));
*/

axiom (forall p:$ptr, S1:$state, S2:$state, q:$ptr :: 
  {:weight 0} {$set_in(q, $domain(S1, p)), $call_transition(S1, S2)}
    $instantiate_bool($set_in(q, $domain(S2, p))));
    
axiom (forall p:$ptr, S1:$state, S2:$state, q:$ptr :: 
  {:weight 0} {$set_in(q, $ver_domain($read_version(S1, p))), $call_transition(S1, S2)}
    $instantiate_bool($set_in(q, $ver_domain($read_version(S2, p)))));

function $in_claim_domain(p:$ptr, c:$ptr) returns(bool);
axiom (forall p:$ptr, c:$ptr :: {$in_claim_domain(p, c)}
  (forall s:$state :: {$dont_instantiate_state(s)} $valid_claim(s, c) ==> $closed(s, p)) ==>
    $in_claim_domain(p, c));

function {:weight 0} $by_claim(S:$state, c:$ptr, obj:$ptr, ptr:$ptr) returns($ptr)
  { ptr }

function $claim_version($ptr) returns($version);

axiom (forall S:$state, p:$ptr, c:$ptr, f:$field :: 
  {$in_claim_domain(p, c), $mem(S, $dot(p, f))}
  {$by_claim(S, c, p, $dot(p, f))}
  $good_state(S) &&
  $closed(S, c) && $in_claim_domain(p, c) && $is_primitive_non_volatile_field(f) ==> 
    $in_claim_domain(p, c) &&
    $mem(S, $dot(p, f)) == $fetch_from_domain($claim_version(c), $dot(p, f))
    );

axiom (forall S:$state, p:$ptr, c:$ptr, f:$field, i:int, sz:int, t:$ctype :: 
  {$valid_claim(S, c), $in_claim_domain(p, c), $mem(S, $idx($dot(p, f), i, t)), $is_primitive_embedded_array(f, sz)}
  {$by_claim(S, c, p, $idx($dot(p, f), i, t)), $is_primitive_embedded_array(f, sz)}
  $good_state(S) &&
  $closed(S, c) && $in_claim_domain(p, c) && $is_primitive_embedded_array(f, sz) && 0 <= i && i < sz ==> 
    $mem(S, $idx($dot(p, f), i, t)) == $fetch_from_domain($claim_version(c), $idx($dot(p, f), i, t))
    );

axiom (forall S:$state, p:$ptr, c:$ptr, i:int, sz:int, t:$ctype :: 
  {$valid_claim(S, c), $in_claim_domain($as_array(p, t, sz), c), $mem(S, $idx(p, i, t)), $is_primitive(t) }
  {$by_claim(S, c, p, $idx(p, i, t)), $is_primitive(t), $is_array(S,p,t,sz) }
  $good_state(S) &&
  $closed(S, c) && $in_claim_domain($as_array(p, t, sz), c) && $is_primitive(t) && 0 <= i && i < sz ==> 
    $mem(S, $idx(p, i, t)) == $fetch_from_domain($claim_version(c), $idx(p, i, t))
    );

procedure $write_ref_cnt(p:$ptr, v:int);
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  ensures old($typemap($s)) == $typemap($s);
  ensures old($memory($s)) == $memory($s);
  ensures (forall q:$ptr :: {$st($s, q)} q == p || $st_eq(old($s), $s, q));
  ensures old($owner($s, p)) == $owner($s, p);
  ensures old($owns($s, p)) == $owns($s, p);
  ensures old($closed($s, p)) == $closed($s, p);
  ensures old($timestamp($s, p)) == $timestamp($s, p);
  ensures $ref_cnt($s, p) == v;
  ensures $timestamp_post_strict(old($s), $s);
  ensures $good_state($s);

// -------------------------------------------------------------------------------------
// the volatile domain
// -------------------------------------------------------------------------------------

type $vol_version;

function {:weight 0} $read_vol_version(S:$state, p:$ptr) returns($vol_version)
  { $int_to_vol_version($mem(S, p)) }

function $fetch_from_vv(v:$vol_version, p:$ptr) returns(int);

function {:inline true} $fetch_vol_field(S:$state, p:$ptr, f:$field) returns(int)
  { $fetch_from_vv($read_vol_version(S, p), $dot(p, f)) }

// the approver always needs to approve itself and be of obj_t type
function $is_approved_by(t:$ctype, approver:$field, subject:$field) returns(bool);

axiom (forall S:$state, r:int, t:$ctype, approver:$field, subject:$field ::
  { $is_approved_by(t, approver, subject), $mem(S, $dot($ptr(t, r), subject)) }
  $full_stop(S) &&
  $is_approved_by(t, approver, subject) &&
  $closed(S, $ptr(t, r)) &&
  ($int_to_ptr($mem(S, $dot($ptr(t, r), approver))) == $me() ||
   $int_to_ptr($fetch_vol_field(S, $ptr(t, r), approver)) == $me()) ==>
    $mem(S, $dot($ptr(t, r), subject)) == $fetch_vol_field(S, $ptr(t, r), subject)
    );

function {:inline true} $inv_is_approved_by_ptr(S1:$state, S2:$state, this:$ptr, approver:$ptr, subject:$field) returns(bool)
{
  $mem_eq(S1, S2, $dot(this, subject)) || 
  $ref(approver) == 0 ||
  (!$is_threadtype($typ(approver)) && $inv2nt(S1, S2, approver) ) ||
  ($is_threadtype($typ(approver)) && $read_vol_version(S1, this) != $read_vol_version(S2, this) )
}

function {:inline true} $inv_is_approved_by(S1:$state, S2:$state, this:$ptr, approver:$field, subject:$field) returns(bool)
{
  $inv_is_approved_by_ptr(S1, S2, this, $int_to_ptr($mem(S1, $dot(this, approver))), subject)
}

function $is_owner_approved(t:$ctype, subject:$field) returns(bool);

axiom (forall S:$state, r:int, t:$ctype, subject:$field ::
  { $is_owner_approved(t, subject), $mem(S, $dot($ptr(t, r), subject)) }
  $full_stop(S) &&
  $closed(S, $ptr(t, r)) &&
  $is_owner_approved(t, subject) &&
  $owner(S, $ptr(t, r)) == $me() ==>
    $mem(S, $dot($ptr(t, r), subject)) == $fetch_vol_field(S, $ptr(t, r), subject));

axiom (forall S1:$state, S2:$state, r:int, t:$ctype, subject:$field ::
  { $is_owner_approved(t, subject), $post_unwrap(S1, S2), $mem(S1, $dot($ptr(t, r), subject)) }
  $instantiate_int($mem(S2, $dot($ptr(t, r), subject))));

function {:inline true} $inv_is_owner_approved(S1:$state, S2:$state, this:$ptr, subject:$field) returns(bool)
{
  $inv_is_approved_by_ptr(S1, S2, this, $owner(S1, this), subject)
}

procedure $bump_volatile_version(p:$ptr);
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  ensures $typemap($s) == $typemap(old($s));
  ensures $statusmap($s) == $statusmap(old($s));
  ensures (forall q:$ptr :: {$mem($s, q)} q == p || $mem_eq(old($s), $s, q));
  ensures $read_version(old($s), p) == $read_version($s, p);
  ensures $read_vol_version(old($s), p) != $read_vol_version($s, p);
  ensures $timestamp_post_strict(old($s), $s);

// ----------------------------------------------------------------------------
// System invariants
// ----------------------------------------------------------------------------

axiom (forall S:$state, p:$ptr, q:$ptr :: {$set_in(p, $owns(S, q)), $is_non_primitive($typ(p))}
  $good_state(S) &&
  $closed(S, q) && $is_non_primitive($typ(p)) ==>
      ($set_in(p, $owns(S, q)) <==> $owner(S, p) == q));

// TODO
// this one is iffy
axiom (forall #s1:$state, #s2:$state, #p:$ptr, #t:$ctype :: 
  {$is_arraytype(#t), $inv2(#s1, #s2, #p, #t)}
  $is_arraytype(#t) && $typ(#p) == #t ==> 
    ($inv2(#s1, #s2, #p, #t) == $typed(#s2, #p) && $sequential(#s1, #s2, #p, #t)));

axiom (forall S:$state, #r:int, #t:$ctype :: {$owns(S, $ptr(#t, #r)), $is_arraytype(#t)}
  $good_state(S) ==>
    $is_arraytype(#t) ==> $owns(S, $ptr(#t, #r)) == $set_empty());

axiom (forall S:$state, #p:$ptr, #t:$ctype :: {$inv(S, #p, #t)}
  $invok_state(S) && $closed(S, #p) ==> $inv(S, #p, #t));

axiom (forall S:$state :: {$good_state(S)}
  $good_state(S) ==> $closed_is_transitive(S));

axiom (forall S:$state, #p:$ptr :: {$closed(S,#p)}
  $closed(S, #p) ==> $typed(S,#p));

// ----------------------------------------------------------------------------
// Custom admissibility checks
// ----------------------------------------------------------------------------

function $good_for_admissibility(S:$state) returns(bool);
function $good_for_post_admissibility(S:$state) returns(bool);

function {:inline true} $stuttering_pre(S:$state, p:$ptr) returns(bool)
  { (forall #q: $ptr :: {$st(S, #q)} $closed(S, #q) ==> $inv(S, #q, $typ(#q))) &&
    $good_for_admissibility(S)
  }

function {:inline true} $admissibility_pre(S:$state, p:$ptr) returns(bool)
  { $closed(S, p) && $inv(S, p, $typ(p)) && $stuttering_pre(S, p) }

procedure $havoc_others(p:$ptr, t:$ctype);
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  // TOKEN: the state was not modified
  requires $good_for_admissibility($s);
  ensures $is_stuttering_check() || $spans_the_same(old($s), $s, p, t);
  ensures $nonvolatile_spans_the_same(old($s), $s, p, t);
  ensures $closed($s, p);
  ensures $typed($s, p);
  ensures $closed_is_transitive($s);
  ensures $good_state($s);
  ensures $good_for_post_admissibility($s);
  ensures (forall #q: $ptr :: {$st(old($s), #q)} {$st($s, #q)} 
    ($closed(old($s), #q) || $closed($s, #q)) && 
    (!$spans_the_same(old($s), $s, #q, $typ(#q)) || $closed(old($s), #q) != $closed($s, #q)) 
      ==> ($inv2(old($s), $s, #q, $typ(#q)) && $nonvolatile_spans_the_same(old($s), $s, #q, $typ(#q))));
  ensures (forall #q:$ptr :: {$set_in(#q, $owns(old($s), p))}
            $set_in(#q, $owns(old($s), p)) ==>
              $ref_cnt(old($s), #q) == $ref_cnt($s, #q));
  ensures $timestamp_post(old($s), $s);

// inferred as free invariant for loops that call only functions that don't write anything
function {:inline true} $mutable_increases(s1:$state, s2:$state) returns(bool)
  { (forall p:$ptr :: {$st(s2, p)} {$ts(s2, p)}
       $mutable(s1, p) ==> $mutable(s2, p)) }
function {:inline true} $meta_eq(s1:$state, s2:$state) returns(bool)
  { $typemap(s1) == $typemap(s2) && $statusmap(s1) == $statusmap(s2) }
    

// ----------------------------------------------------------------------------
// Can-unwrap checks
// ----------------------------------------------------------------------------

function $is_stuttering_check() returns(bool);
function $is_unwrap_check() returns(bool);
function {:inline true} $is_admissibility_check() returns(bool)
  { !$is_stuttering_check() && !$is_unwrap_check() }

function $good_for_pre_can_unwrap(S:$state) returns(bool);
function $good_for_post_can_unwrap(S:$state) returns(bool);

function {:inline true} $unwrap_check_pre(S:$state, p:$ptr) returns(bool)
  { $wrapped(S, p, $typ(p)) && 
    (! $is_claimable($typ(p)) || $ref_cnt(S, p) == 0) &&
    $inv(S, p, $typ(p)) &&
    (forall #q: $ptr :: {$st(S, #q)} $closed(S, #q) ==> $inv(S, #q, $typ(#q))) &&
    $good_for_pre_can_unwrap(S)
  }

procedure $unwrap_check(#l:$ptr);
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  // TOKEN: the state was not modified
  requires $good_for_pre_can_unwrap($s);
  ensures $good_state($s);
  ensures $good_for_post_can_unwrap($s);

  // from $unwrap(...):
  ensures $mutable($s, #l);
  ensures $spans_the_same(old($s), $s, #l, $typ(#l));
  ensures (forall #p:$ptr :: {$set_in(#p, $owns(old($s), #l))}
    $set_in(#p, $owns(old($s), #l)) ==> 
      $typed(old($s), #p) &&
      $wrapped($s, #p, $typ(#p)) && $timestamp_is_now($s, #p) && $is_non_primitive($typ(#p)));
  ensures (forall #p:$ptr :: {$set_in(#p, $owns(old($s), #l)), $is_claimable($typ(#p))}
    $set_in(#p, $owns(old($s), #l)) ==> 
      ($is_claimable($typ(#p)) ==> 
         old($ref_cnt($s, #p)) == $ref_cnt($s, #p) ));
  ensures $timestamp_is_now($s, #l);
  ensures $typemap(old($s)) == $typemap($s);
  ensures (forall #p:$ptr :: {$st($s, #p)}
    #p == #l || 
    ($nested(old($s), #p) && $set_in(#p, $owns(old($s), #l))) || 
    $st($s, #p) == $st(old($s), #p));
  ensures (exists #x:int :: $memory($s) == $store.mem($memory(old($s)), #l, #x));
  ensures $timestamp_post_strict(old($s), $s);


// ----------------------------------------------------------------------------
// Procedures
// ----------------------------------------------------------------------------


procedure $write_int(p:$ptr, v:int);
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  ensures $typemap($s) == $typemap(old($s));
  ensures $statusmap($s) == $statusmap(old($s));
  ensures $memory($s) == $store.mem($memory(old($s)), p, v);
  ensures $timestamp_post_strict(old($s), $s);

function $update_int(S:$state, p:$ptr, v:int) returns ($state);
axiom (forall S:$state, p:$ptr, v:int :: {$update_int(S, p, v)}
  $typemap($update_int(S, p, v)) == $typemap(S) &&
  $statusmap($update_int(S, p, v)) == $statusmap(S) &&
  $memory($update_int(S, p, v)) == $store.mem($memory(S), p, v) &&
  $timestamp_post_strict(S, $update_int(S, p, v)));

function {:inline true} $timestamp_is_now(S:$state, p:$ptr) returns(bool)
  { $timestamp(S, p) == $current_timestamp(S) }

function {:inline true} $now_writable(S:$state, p:$ptr) returns(bool)
  { $timestamp_is_now(S, p) && $mutable(S, p) }

function {:inline true} $timestamp_post(M1:$state, M2:$state) returns(bool)
  { $current_timestamp(M1) <= $current_timestamp(M2) &&
    (forall p:$ptr :: {:weight 0} {$timestamp(M2, p)} $timestamp(M1, p) <= $timestamp(M2, p)) &&
    $call_transition(M1, M2)
  }

function {:inline true} $timestamp_post_strict(M1:$state, M2:$state) returns(bool)
  { $current_timestamp(M1) < $current_timestamp(M2) &&
    (forall p:$ptr :: {:weight 0} {$timestamp(M2, p)} $timestamp(M1, p) <= $timestamp(M2, p)) &&
    $call_transition(M1, M2)
  }

function $pre_wrap($state) returns(bool);
function $pre_unwrap($state) returns(bool);
function $pre_static_wrap($state) returns(bool);
function $pre_static_unwrap($state) returns(bool);

function {:inline true} $unwrap_post(S0:$state, S:$state, #l:$ptr, #p:$ptr) returns(bool)
  { $typed(S0, #p) &&
    $wrapped(S, #p, $typ(#p)) && 
    $timestamp_is_now(S, #p) && 
    $is_non_primitive($typ(#p)) &&
    $set_in(#p, $owns(S0, #l)) &&
    $nested_in(S0, #p, #l)
    }

function {:inline true} $unwrap_post_claimable(S0:$state, S:$state, #l:$ptr, #p:$ptr) returns(bool)
  { $unwrap_post(S0, S, #l, #p) && 
    ($is_claimable($typ(#p)) ==> $ref_cnt(S0, #p) == $ref_cnt(S, #p)) }

function {:inline true} {:expand true} $keeps(S:$state, #l:$ptr, #p:$ptr) returns(bool)
  { $set_in(#p, $owns(S, #l)) }

function $expect_unreachable() returns(bool);
function $expect_unreachable_master(id:int) returns(bool);
function $expect_unreachable_child(id:int) returns(bool);

function $taken_over(S:$state, #l:$ptr, #p:$ptr) returns($status);
function $take_over(S:$state, #l:$ptr, #p:$ptr) returns($state);
axiom (forall S:$state, l:$ptr, p:$ptr :: {$take_over(S, l, p)}
  $is_non_primitive_ch($typ(l)) ==>
// Breaking ties on memory and typemap prevents creation of additional states
// where the prover could trigger.
//  $memory($take_over(S, l, p)) == $memory(S) &&
//  $typemap($take_over(S, l, p)) == $typemap(S) &&
  $statusmap($take_over(S, l, p)) == $store.sm($statusmap(S), p, $taken_over(S, l, p)) &&
  $closed($take_over(S, l, p), p) &&
  $owner($take_over(S, l, p), p) == l &&
  $ref_cnt($take_over(S, l, p), p) == $ref_cnt(S, p) &&
  true
  );


function $released(S:$state, #l:$ptr, #p:$ptr) returns($status);
function $release(S0:$state, S:$state, #l:$ptr, #p:$ptr) returns($state);
axiom (forall S0:$state, S:$state, l:$ptr, p:$ptr :: {$release(S0, S, l, p)}
// Likewise.
//  $memory($release(S0, S, l, p)) == $memory(S) &&
//  $typemap($release(S0, S, l, p)) == $typemap(S) &&
  $statusmap($release(S0, S, l, p)) == $store.sm($statusmap(S), p, $released(S, l, p)) &&
  $closed($release(S0, S, l, p), p) &&
  $owner($release(S0, S, l, p), p) == $me() &&
  $ref_cnt($release(S0, S, l, p), p) == $ref_cnt(S, p) &&
  $timestamp($release(S0, S, l, p), p) == $current_timestamp(S0) &&
  true
  );

function $post_unwrap(S1:$state, S2:$state) returns(bool);

procedure $static_unwrap(#l:$ptr, S:$state);
  // writes #l
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  // TOKEN: the object has no outstanding claims
  requires ! $is_claimable($typ(#l)) || $ref_cnt($s, #l) == 0;
  // TOKEN: OOPS: pre_static_unwrap holds
  requires $pre_static_unwrap($s);
  ensures $mutable($s, #l);
  ensures $owns(old($s), #l) == $owns($s, #l);
  ensures (forall #p:$ptr ::
    {$st($s, #p)} {$ts($s, #p)}
    {$set_in(#p, $owns(old($s), #l))}
    //{$st(old($s), #p)} {$st($s, #p)} {$ts(meta, #p)}
    $set_in(#p, $owns(old($s), #l)) ==>
      $typed(old($s), #p) &&
      $wrapped($s, #p, $typ(#p)) && $timestamp_is_now($s, #p) && $is_non_primitive($typ(#p)));
  ensures (forall #p:$ptr :: {$set_in(#p, $owns(old($s), #l)), $is_claimable($typ(#p))}
    $set_in(#p, $owns(old($s), #l)) ==>
      ($is_claimable($typ(#p)) ==>
         old($ref_cnt($s, #p)) == $ref_cnt($s, #p) ));
  ensures (forall #p:$ptr :: {$thread_local($s, #p)}
    $thread_local(old($s), #p) ==> $thread_local($s, #p));
  ensures $timestamp_is_now($s, #l);

  ensures $typemap(old($s)) == $typemap($s);
  ensures (forall #p:$ptr :: {:weight 0} {$st($s, #p)}
    $st($s, #p) == $st(old($s), #p) ||
    ($nested(old($s), #p) && $set_in(#p, $owns(old($s), #l))) ||
    #p == #l);
  ensures (exists #x:int :: $memory($s) == $store.mem($memory(old($s)), #l, #x));
  ensures $timestamp_post_strict(old($s), $s);
  ensures $post_unwrap(old($s), $s);

procedure $static_wrap(#l:$ptr, S:$state, owns:$ptrset);
  // writes #l, $owns($s, #l)
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  // TOKEN: OOPS: pre_static_wrap must hold
  requires $pre_static_wrap($s);
  // TOKEN: the wrapped type must not be primitive
  requires $kind_of($typ(#l)) != $kind_primitive;
  // TOKEN: the object being wrapped must be typed
  requires $typed($s, #l);
  // TOKEN: the object being wrapped must not be closed
  requires !$closed($s, #l);
  // TOKEN: the object being wrapped must be owned by the current thread
  requires $owner($s, #l) == $me();
  ensures $wrapped($s, #l, $typ(#l));
  // ensures $set_in(#l, $domain($s, #l));
  ensures $is_claimable($typ(#l)) ==> old($ref_cnt($s, #l)) == 0 && $ref_cnt($s, #l) == 0;

  ensures $typemap(old($s)) == $typemap($s);
  ensures (exists #st:$status :: $statusmap($s) == $store.sm($statusmap(S), #l, #st));
  ensures (exists #x:int :: $memory($s) == $store.mem($store.mem($memory(old($s)), #l, #x), $dot(#l, $owns_set_field($typ(#l))), $ptrset_to_int(owns)));
  //ensures (forall #p:$ptr :: {$thread_local($s, #p)} $thread_local(old($s), #p) ==> $thread_local($s, #p));
  ensures $timestamp_post_strict(old($s), $s);

  /*
  ensures (forall #p:$ptr :: {$st($s, #p)}
    #p == #l || 
    ($wrapped(old($s), #p, $typ(#p)) && $set_in(#p, $owns(old($s), #l))) || 
    $st($s, #p) == $st(old($s), #p));
  */



procedure $static_wrap_non_owns(#l:$ptr, S:$state);
  // writes #l, $owns($s, #l)
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  // TOKEN: OOPS: pre_static_wrap holds
  requires $pre_static_wrap($s);
  // TOKEN: the wrapped type is non primitive
  requires $kind_of($typ(#l)) != $kind_primitive;
  // TOKEN: the object being wrapped is typed
  requires $typed($s, #l);
  // TOKEN: the object being wrapped is not closed
  requires !$closed($s, #l);
  // TOKEN: the object being wrapped is owned by the current thread
  requires $owner($s, #l) == $me();

  ensures $wrapped($s, #l, $typ(#l));
  // ensures $set_in(#l, $domain($s, #l));
  ensures $is_claimable($typ(#l)) ==> old($ref_cnt($s, #l)) == 0 && $ref_cnt($s, #l) == 0;

  ensures $typemap(old($s)) == $typemap($s);
  ensures (exists #st:$status :: $statusmap($s) == $store.sm($statusmap(S), #l, #st));
  ensures (exists #x:int :: $memory($s) == $store.mem($memory(old($s)), #l, #x));
  //ensures (forall #p:$ptr :: {$thread_local($s, #p)} $thread_local(old($s), #p) ==> $thread_local($s, #p));

  ensures $timestamp_post_strict(old($s), $s);


procedure $unwrap(#l:$ptr, T:$ctype);
  // writes #l
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  // TOKEN: the object has no outstanding claims
  requires ! $is_claimable(T) || $ref_cnt($s, #l) == 0;
  // TOKEN: OOPS: pre_unwrap holds
  requires $pre_unwrap($s);
  // we can ensure that for everything we own, as it should be program invariant
  // that when we're consistent then all our children are nested
  // we can even ensure they used to be commited!
  // otherwise we're unable to prove $s frame condition
  ensures $mutable($s, #l);
  ensures $owns(old($s), #l) == $owns($s, #l);
  ensures (forall #p:$ptr :: 
    {$st($s, #p)} {$ts($s, #p)}
    {$set_in(#p, $owns(old($s), #l))}
    //{$st(old($s), #p)} {$st($s, #p)} {$ts(meta, #p)}
    $set_in(#p, $owns(old($s), #l)) ==> 
      $typed(old($s), #p) &&
      $wrapped($s, #p, $typ(#p)) && $timestamp_is_now($s, #p) && $is_non_primitive($typ(#p)));
  ensures (forall #p:$ptr :: {$set_in(#p, $owns(old($s), #l)), $is_claimable($typ(#p))}
    $set_in(#p, $owns(old($s), #l)) ==> 
      ($is_claimable($typ(#p)) ==> 
         old($ref_cnt($s, #p)) == $ref_cnt($s, #p) ));     
  ensures (forall #p:$ptr :: {$thread_local($s, #p)}
    $thread_local(old($s), #p) ==> $thread_local($s, #p));
  ensures $timestamp_is_now($s, #l);

  ensures $typemap(old($s)) == $typemap($s);
  ensures (forall #p:$ptr :: {:weight 0} {$st($s, #p)}
    $st($s, #p) == $st(old($s), #p) ||
    ($nested(old($s), #p) && $set_in(#p, $owns(old($s), #l))) || 
    #p == #l);
  ensures (exists #x:int :: $memory($s) == $store.mem($memory(old($s)), #l, #x));
  ensures $timestamp_post_strict(old($s), $s);
  ensures $post_unwrap(old($s), $s);

procedure $wrap(#l:$ptr, T:$ctype);
  // writes #l, $owns($s, #l)
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  // TOKEN: OOPS: pre_wrap holds
  requires $pre_wrap($s);
  // TOKEN: the wrapped type is non primitive
  requires $kind_of($typ(#l)) != $kind_primitive;
  // TOKEN: the object being wrapped is typed
  requires $typed2($s, #l, T);
  // TOKEN: the object being wrapped is not closed
  requires !$closed($s, #l);
  // TOKEN: the object being wrapped is owned by the current thread
  requires $owner($s, #l) == $me();
  // TOKEN: everything in the owns set is wrapped
  requires (forall #p:$ptr :: {$dont_instantiate(#p)} $set_in0(#p, $owns($s, #l)) ==> $wrapped($s, #p, $typ(#p)));
  ensures $owns(old($s), #l) == $owns($s, #l);
  ensures (forall #p:$ptr :: {$set_in(#p, $owns($s, #l))}
    $set_in(#p, $owns($s, #l)) ==> $is_non_primitive($typ(#p)) && $nested_in($s, #p, #l));
  ensures $wrapped($s, #l, $typ(#l));
  // ensures $set_in(#l, $domain($s, #l));
  ensures $is_claimable(T) ==> old($ref_cnt($s, #l)) == 0 && $ref_cnt($s, #l) == 0;
  ensures (forall #p:$ptr :: {$set_in(#p, $owns(old($s), #l)), $is_claimable($typ(#p))}
    $set_in(#p, $owns(old($s), #l)) ==> 
      ($is_claimable($typ(#p)) ==> 
         old($ref_cnt($s, #p)) == $ref_cnt($s, #p) ));
  //ensures (forall #p:$ptr :: {$thread_local($s, #p)}
  //  $thread_local(old($s), #p) ==> $thread_local($s, #p));

  ensures $typemap(old($s)) == $typemap($s);
  ensures (forall #p:$ptr :: {:weight 0} {$st($s, #p)}
    $st($s, #p) == $st(old($s), #p) ||
    ($wrapped(old($s), #p, $typ(#p)) && $set_in(#p, $owns(old($s), #l))) || 
    #p == #l );
  ensures (exists #x:int :: $memory($s) == $store.mem($memory(old($s)), #l, #x));
  ensures $timestamp_post_strict(old($s), $s);

procedure $bump_timestamp();
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  ensures $memory($s) == $memory(old($s));
  ensures $typemap($s) == $typemap(old($s));
  ensures (exists x:$status :: $statusmap($s) == $store.sm($statusmap(old($s)), $null, x));
  ensures $current_timestamp(old($s)) < $current_timestamp($s);

// we should get rid of it
procedure $deep_unwrap(#l:$ptr, T:$ctype);
  // writes #l
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  requires $wrapped($s, #l, T);
  requires $inv($s, #l, T) ==> $set_eq($owns($s, #l), $set_empty());
  ensures $inv($s,#l,T); // do we need it?
  ensures !$closed($s, #l);
  ensures (forall #p:$ptr :: {$st($s, #p)}// {$st(old($s), #p)}
    $in_full_extent_of(#p, #l) ==>
      $timestamp_is_now($s, #p) &&
     // we imagine that all untyped memory is nested in some global object
     !$closed($s, #p) && (#p == #l || $nested(old($s), #p)));
  ensures (forall #p:$ptr :: {$st($s, #p)}
    $in_extent_of($s, #p, #l) ==> $owner($s, #p) == $me());
  ensures (forall #p:$ptr :: {$thread_local($s, #p)}
    $thread_local(old($s), #p) ==> $thread_local($s, #p));


  ensures $typemap($s) == $typemap(old($s));
  ensures (forall #p:$ptr :: {$st($s, #p)}
    !$typed(old($s), #p) || 
    $in_full_extent_of(#p, #l) ||
    $st_eq(old($s), $s, #p));
  ensures (forall #p:$ptr :: {$mem($s, #p)}
    $in_full_extent_of(#p, #l) ||
    $mem_eq(old($s), $s, #p));
  ensures $timestamp_post_strict(old($s), $s);
  ensures $post_unwrap(old($s), $s);


procedure $set_owns(#p:$ptr, owns:$ptrset);
  // writes #p
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  // TOKEN: the owner is non-primitive
  requires $is_composite_ch($typ(#p));
  // TOKEN: the owner is mutable
  requires $mutable($s, #p);
  ensures $statusmap(old($s)) == $statusmap($s);
  ensures $typemap(old($s)) == $typemap($s);
  ensures $memory($s) == $store.mem(old($memory($s)), $dot(#p, $owns_set_field($typ(#p))), $ptrset_to_int(owns));
  ensures $timestamp_post_strict(old($s), $s);

procedure $set_closed_owner(#p:$ptr, owner:$ptr);
  // writes #p, owner
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  // TOKEN: the owner is composite
  requires $is_composite_ch($typ(owner));
  // TOKEN: the object is non-primitive
  requires $kind_of($typ(#p)) != $kind_primitive;
  // TOKEN: the object is owned by the current thread
  requires $owner($s, #p) == $me();
  // TOKEN: the object is closed
  requires $closed($s, #p);
  // TOKEN: the owner is closed
  requires $closed($s, owner);
  // TOKEN: the owner has volatile owns set
  requires $has_volatile_owns_set($typ(owner));
  ensures $typemap(old($s)) == $typemap($s);
  ensures (exists st:$status :: $statusmap($s) == $store.sm(old($statusmap($s)), #p, st) && $st_owner(st) == owner && $st_closed(st));
  ensures $ref_cnt(old($s), #p) == $ref_cnt($s, #p);
  ensures $memory($s) == $store.mem(old($memory($s)), $dot(owner, $owns_set_field($typ(owner))), 
                                $ptrset_to_int($set_union($set_singleton(#p), $owns(old($s), owner))));
  ensures $timestamp_post_strict(old($s), $s);
  ensures $set_in(#p, $owns($s, owner));

function {:inline true} $new_ownees(S:$state, o:$ptr, owns:$ptrset) returns($ptrset)
  { $set_difference(owns, $owns(S, o)) }

procedure $set_closed_owns(owner:$ptr, owns:$ptrset);
  // writes owner, $new_ownees(owner, owns)
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  // TOKEN: the owner is composite
  requires $is_composite_ch($typ(owner));
  // TOKEN: all newly owned objects are wrapped
  requires (forall p:$ptr :: {$dont_instantiate(p)} {sk_hack($set_in0(p, $owns($s, owner)))}
    $set_in(p, $new_ownees($s, owner, owns)) ==> $wrapped($s, p, $typ(p)));
  // TOKEN: the owner is closed
  requires $closed($s, owner);
  // TOKEN: the owner has volatile owns set
  requires $has_volatile_owns_set($typ(owner));
  ensures $typemap(old($s)) == $typemap($s);
  ensures (forall #p:$ptr :: {$set_in(#p, $owns(old($s), owner))} $set_in(#p, $owns(old($s), owner)) ==> $is_non_primitive($typ(#p)));
  ensures (forall #p:$ptr :: {$st($s, #p)} {$ts($s, #p)}
    $ref_cnt(old($s), #p) == $ref_cnt($s, #p) &&
      if $set_in(#p, $owns(old($s), owner)) then
        if $set_in(#p, owns) then
          $st_eq(old($s), $s, #p) 
        else 
          $wrapped($s, #p, $typ(#p)) && $timestamp_is_now($s, #p)
      else
        if $set_in(#p, owns) then
          $owner($s, #p) == owner && $closed($s, #p)
        else
          $st_eq(old($s), $s, #p));
  ensures $memory($s) == $store.mem(old($memory($s)), $dot(owner, $owns_set_field($typ(owner))), $ptrset_to_int(owns));
  ensures $timestamp_post_strict(old($s), $s);


procedure $giveup_closed_owner(#p:$ptr, owner:$ptr);
  // writes owner
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  // TOKEN: the owner is composite
  requires $is_composite_ch($typ(owner));
  // TOKEN: the object is owned by the owner
  requires $set_in(#p, $owns($s, owner));
  // TOKEN: the owner is closed
  requires $closed($s, owner);
  // TOKEN: the owner has volatile owns set
  requires $has_volatile_owns_set($typ(owner));
  ensures $typed($s, #p);
  ensures $typemap(old($s)) == $typemap($s);
  ensures (exists st:$status :: $statusmap($s) == $store.sm($statusmap(old($s)), #p, st));
  ensures $wrapped($s, #p, $typ(#p));
  ensures $timestamp_is_now($s, #p);
  ensures $ref_cnt(old($s), #p) == $ref_cnt($s, #p);
  ensures $memory($s) == $store.mem(old($memory($s)), $dot(owner, $owns_set_field($typ(owner))),
                                                $ptrset_to_int($set_difference($owns(old($s), owner), $set_singleton(#p))));
  ensures $timestamp_post_strict(old($s), $s);

// -----------------------------------------------------------------------
// Allocation
// -----------------------------------------------------------------------

function $get_memory_allocator() returns($ptr);
function $is_in_stackframe(#sf:int, p:$ptr) returns(bool);
const unique $memory_allocator_type : $ctype;
const $memory_allocator_ref : int;
axiom $get_memory_allocator() == $ptr($memory_allocator_type, $memory_allocator_ref);
axiom $ptr_level($memory_allocator_type) == 0;

procedure $stack_alloc(#t:$ctype, #sf:int, #spec:bool) returns (#r:$ptr);
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  ensures $typed2($s, #r, #t);
  ensures $extent_mutable($s, #r);
  ensures $extent_is_fresh(old($s), $s, #r);
  ensures $mutable($s, $emb($s, #r));

  ensures (forall #p:$ptr :: {$ts($s, #p)} {$st($s, #p)} // {$st(old($s), #p)} 
    $in_extent_of($s, #p, #r) ==> $mutable($s, #p) 
      && $nested(old($s), #p)
      && $owns($s, #p) == $set_empty()
      && $timestamp_is_now($s, #p)
    );

  ensures (forall #p:$ptr :: {$st($s, #p)} 
    #p == $emb($s, #r) || $in_full_extent_of(#p, #r) ==> $timestamp_is_now($s, #p));

  ensures $memory(old($s)) == $memory($s);
  ensures (forall #p:$ptr :: {$st($s, #p)}
    $typed(old($s), #p) || !$nested(old($s), #p) ==> $st_eq(old($s), $s, #p));
  ensures (forall #p:$ptr :: {$ts($s, #p)}
    $typed(old($s), #p) || !$nested(old($s), #p) ==> $ts_eq(old($s), $s, #p));
  ensures (forall #p:$ptr :: {$thread_local($s, #p)}
    $thread_local(old($s), #p) ==> $thread_local($s, #p));
  ensures $timestamp_post_strict(old($s), $s);

  ensures !$typed(old($s), #r);
  ensures $is_in_stackframe(#sf, #r);
  ensures $is_object_root($s, #r);
  ensures $first_option_typed($s, #r);
  ensures #spec ==> $in_range_spec_ptr($ref(#r));
  ensures !#spec ==> $in_range_phys_ptr($ref(#r)) && $in_range_phys_ptr($ref(#r) + $sizeof(#t) - 1);


procedure $stack_free(#sf:int, #x:$ptr);
  // writes extent(#x)
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  // TOKEN: the extent of the object being reclaimed is mutable
  requires $extent_mutable($s, #x);
  // TOKEN: the pointer being reclaimed was returned by stack_alloc()
  requires $is_in_stackframe(#sf, #x);

  ensures (forall #p:$ptr :: {$st($s, #p)}
    $in_full_extent_of(#p, #x) || $st($s, #p) == $st(old($s), #p));
  ensures (forall #p:$ptr :: {$ts($s, #p)}
    $in_full_extent_of(#p, #x) || $ts($s, #p) == $ts(old($s), #p));
  ensures $memory($s) == $memory(old($s));
  ensures $timestamp_post(old($s), $s);

procedure $spec_alloc(#t:$ctype) returns(#r:$ptr);
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  ensures $typed2($s, #r, #t);
  ensures $extent_mutable($s, #r);
  ensures $extent_is_fresh(old($s), $s, #r);
  ensures $mutable($s, $emb($s, #r));

  ensures (forall #p:$ptr :: {$ts($s, #p)} {$st($s, #p)} // {$st(old($s), #p)} 
    $in_extent_of($s, #p, #r) ==> $mutable($s, #p) 
      && $nested(old($s), #p)
      && $owns($s, #p) == $set_empty()
      && $timestamp_is_now($s, #p)
    );

  ensures (forall #p:$ptr :: {$st($s, #p)} 
    #p == $emb($s, #r) || $in_full_extent_of(#p, #r) ==> $timestamp_is_now($s, #p));

  ensures $memory(old($s)) == $memory($s);
  ensures (forall #p:$ptr :: {$st($s, #p)}
    $typed(old($s), #p) || !$nested(old($s), #p) ==> $st_eq(old($s), $s, #p));
  ensures (forall #p:$ptr :: {$ts($s, #p)}
    $typed(old($s), #p) || !$nested(old($s), #p) ==> $ts_eq(old($s), $s, #p));
  ensures (forall #p:$ptr :: {$thread_local($s, #p)}
    $thread_local(old($s), #p) ==> $thread_local($s, #p));
  ensures $timestamp_post_strict(old($s), $s);

  ensures !$typed(old($s), #r);
  ensures $is_malloc_root($s, #r);
  ensures $is_object_root($s, #r);
  ensures $first_option_typed($s, #r);
  ensures $in_range_spec_ptr($ref(#r));

procedure $spec_alloc_array(#t:$ctype, sz:int) returns(#r:$ptr);
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  ensures $typed2($s, #r, $array(#t, sz));
  ensures $extent_mutable($s, #r);
  ensures $extent_is_fresh(old($s), $s, #r);
  ensures $mutable($s, $emb($s, #r));

  ensures (forall #p:$ptr :: {$ts($s, #p)} {$st($s, #p)} // {$st(old($s), #p)} 
    $in_extent_of($s, #p, #r) ==> $mutable($s, #p) 
      && $nested(old($s), #p)
      && $owns($s, #p) == $set_empty()
      && $timestamp_is_now($s, #p)
    );

  ensures (forall #p:$ptr :: {$st($s, #p)} 
    #p == $emb($s, #r) || $in_full_extent_of(#p, #r) ==> $timestamp_is_now($s, #p));

  ensures $memory(old($s)) == $memory($s);
  ensures (forall #p:$ptr :: {$st($s, #p)}
    $typed(old($s), #p) || !$nested(old($s), #p) ==> $st_eq(old($s), $s, #p));
  ensures (forall #p:$ptr :: {$ts($s, #p)}
    $typed(old($s), #p) || !$nested(old($s), #p) ==> $ts_eq(old($s), $s, #p));
  ensures (forall #p:$ptr :: {$thread_local($s, #p)}
    $thread_local(old($s), #p) ==> $thread_local($s, #p));
  ensures $timestamp_post_strict(old($s), $s);

  ensures !$typed(old($s), #r);
  ensures $is_malloc_root($s, #r);
  ensures $is_object_root($s, #r);
  ensures $first_option_typed($s, #r);
  ensures $in_range_spec_ptr($ref(#r));


procedure $alloc(#t:$ctype) returns(#r:$ptr);
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  ensures $ref(#r) == 0 || $typed2($s, #r, #t);
  ensures $ref(#r) == 0 || $extent_mutable($s, #r);
  ensures $ref(#r) == 0 || $extent_is_fresh(old($s), $s, #r);
  ensures $ref(#r) == 0 || $mutable($s, $emb($s, #r));

  ensures (forall #p:$ptr :: {$ts($s, #p)} {$st($s, #p)} // {$st(old($s), #p)} 
    $in_extent_of($s, #p, #r) ==> $mutable($s, #p) 
      && $nested(old($s), #p)
      && $owns($s, #p) == $set_empty()
      && $timestamp_is_now($s, #p)
    );

  ensures (forall #p:$ptr :: {$st($s, #p)} 
    #p == $emb($s, #r) || $in_full_extent_of(#p, #r) ==> $timestamp_is_now($s, #p));

  ensures $memory(old($s)) == $memory($s);
  ensures (forall #p:$ptr :: {$st($s, #p)}
    $typed(old($s), #p) || !$nested(old($s), #p) ==> $st_eq(old($s), $s, #p));
  ensures (forall #p:$ptr :: {$ts($s, #p)}
    $typed(old($s), #p) || !$nested(old($s), #p) ==> $ts_eq(old($s), $s, #p));
  ensures (forall #p:$ptr :: {$thread_local($s, #p)}
    $thread_local(old($s), #p) ==> $thread_local($s, #p));
  ensures $timestamp_post_strict(old($s), $s);

  ensures !$typed(old($s), #r);
  ensures $ref(#r) == 0 || $is_malloc_root($s, #r);
  ensures $ref(#r) == 0 || $is_object_root($s, #r);
  ensures $ref(#r) == 0 || $first_option_typed($s, #r);
  ensures $in_range_phys_ptr($ref(#r)) && $in_range_phys_ptr($ref(#r) + $sizeof(#t) - 1);


procedure $free(#x:$ptr);
  // writes extent(#x)
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  // TOKEN: the object being reclaimed is typed
  requires $typed($s, #x);
  // TOKEN: the pointer being reclaimed was returned by malloc()
  requires $is_malloc_root($s, #x);

  ensures (forall #p:$ptr :: {$st($s, #p)}
    $in_full_extent_of(#p, #x) || $st($s, #p) == $st(old($s), #p));
  ensures (forall #p:$ptr :: {$ts($s, #p)}
    $in_full_extent_of(#p, #x) || $ts($s, #p) == $ts(old($s), #p));
  ensures $memory($s) == $memory(old($s));
  ensures $timestamp_post(old($s), $s);


function $program_entry_point(s:$state) returns(bool);
function $program_entry_point_ch(s:$state) returns(bool);

axiom (forall S:$state :: {$program_entry_point(S)} $program_entry_point(S) ==> $program_entry_point_ch(S));

function {:inline true} $is_global(p:$ptr, t:$ctype) returns(bool)
  { (forall S:$state :: {$ts(S, p)} $good_state(S) ==> $typed(S, p) && $is_object_root(S, p)) &&
    (forall S:$state, f:$field :: {$ts(S, $dot(p, f))} $good_state(S) ==> $typed(S, p) && $is_object_root(S, p)) &&
    (forall S:$state, f:$field, i:int, tt:$ctype :: {$ts(S, $idx($dot(p, f), i, tt))} $good_state(S) ==> $typed(S, p) && $is_object_root(S, p)) &&
    (forall S:$state :: {$program_entry_point(S)} $program_entry_point(S) ==> $extent_mutable(S, p) && $owns(S, p) == $set_empty())
  }

function {:inline true} $is_global_array(p:$ptr, T:$ctype, sz:int) returns(bool)
  { 
    $is(p, T) && 
    (forall S:$state, i:int :: {$st(S, $idx(p, i, T))} {$ts(S, $idx(p, i, T))}
      $good_state(S) ==>
      0 <= i && i < sz ==> 
        !$is_volatile(S, $idx(p, i, T)) && 
        $typed(S, $idx(p, i, T)) &&
        ($program_entry_point_ch(S) ==> $mutable(S, $idx(p, i, T)))
        ) }

// typedness and writes check are handled by the assignment translation
procedure $havoc(o:$ptr, t:$ctype);
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  requires $is(o, t);
  ensures $typemap($s) == $typemap(old($s));
  ensures $statusmap($s) == $statusmap(old($s));
  ensures (forall #p:$ptr :: {$mem($s, #p)}
    $in_extent_of(old($s), #p, o) || $mem_eq(old($s), $s, #p));

// -----------------------------------------------------------------------
// Unions
// -----------------------------------------------------------------------

function {:inline true} $active_option(S:$state, u:$ptr) returns($field)
  { $ts_active_option($ts(S, u)) }

function $ts_active_option($type_state) returns($field);

function {:inline true} $union_active(S:$state, u:$ptr, f:$field) returns(bool)
  { $active_option(S, u) == f }

procedure $union_reinterpret(#x:$ptr, #off:$field);
  // writes extent(#x)
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  // TOKEN: the reinterpretation target field comes from a proper union
  requires $is_union_field($typ(#x), #off);
  // TOKEN: the reinterpretation target union is typed
  requires $typed($s, #x);
  ensures $active_option($s, #x) == #off;
  ensures $typed($s, #x);
  ensures (forall #p:$ptr :: {$st($s, #p)}
    $in_extent_of($s, #p, #x) ==> $now_writable($s, #p));
  ensures $union_havoced(old($s), $s, #x);
  ensures $is_object_root(old($s), #x) <==> $is_object_root($s, #x);

  ensures (forall #p:$ptr :: {$ts($s, #p)}
      $in_full_extent_of(#p, #x) || $ts($s, #p) == $ts(old($s), #p));
  ensures (forall #p:$ptr :: {$st($s, #p)}
      $in_full_extent_of(#p, #x) || $st($s, #p) == $st(old($s), #p));
  ensures $timestamp_post_strict(old($s), $s);

function $is_union_field($ctype, $field) returns(bool); // generated by the translation
function {:inline true} $union_havoced(#s1:$state, #s2:$state, #x:$ptr) returns(bool)
  {
      (forall #p:$ptr :: {$mem(#s2, #p)}
        #p == #x ||
        ($in_full_extent_of(#p, #x) && (!$typed(#s1, #p) || !$typed(#s2, #p))) ||
        $mem_eq(#s1, #s2, #p))
  }

function $full_extent(#p:$ptr) returns($ptrset);
function $extent(S:$state, #p:$ptr) returns($ptrset);
function $span(#p:$ptr) returns($ptrset);
function {:inline true} $in_span_of(#p:$ptr, #l:$ptr) returns(bool)
  { $set_in(#p, $span(#l)) }
function $first_option_typed(S:$state, #p:$ptr) returns(bool);

function {:inline true} $struct_extent(#p:$ptr) returns($ptrset)
  { $full_extent(#p) }
function {:inline true} $in_struct_extent_of(#p:$ptr, #l:$ptr) returns(bool)
  { $set_in(#p, $struct_extent(#l)) }

function $volatile_span(S:$state, #p:$ptr) returns($ptrset);
axiom (forall S:$state, p:$ptr, q:$ptr :: {$set_in(p, $volatile_span(S, q))}
  $set_in(p, $volatile_span(S, q)) <==> p == q || ($is_volatile(S, p) && $set_in(p, $span(q))));

// -----------------------------------------------------------------------
// Memory reinterpretation
// -----------------------------------------------------------------------

function $left_split(a:$ptr, i:int) returns($ptr)
  { $as_array(a, $element_type($typ(a)), i) }
function $right_split(a:$ptr, i:int) returns($ptr)
  { $as_array($idx($ptr($element_type($typ(a)), $ref(a)), i, $element_type($typ(a))), $element_type($typ(a)), $array_length($typ(a)) - i) }

function $joined_array(a1:$ptr, a2:$ptr) returns($ptr)
  { $ptr($array($element_type($typ(a1)), $array_length($typ(a1))+$array_length($typ(a2))), $ref(a1)) }

function {:inline true} $mutable_root(S:$state, p:$ptr) returns(bool)
  { $extent_mutable(S, p) && $is_object_root(S, p) && $timestamp_is_now(S, p) }

procedure $split_array(a:$ptr, i:int);
  // writes extent(a)
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  // TOKEN: the array is split at positive index
  requires 0 < i;
  // TOKEN: the split-point is within the array
  requires i < $array_length($typ(a));
  // TOKEN: the array to split is not embedded inside of another object
  requires $is_object_root($s, a);
  ensures $memory(old($s)) == $memory($s);
  ensures (forall p:$ptr :: {$st($s, p)}
    p == a || p == $left_split(a, i) || p == $right_split(a, i) ||
    $st_eq(old($s), $s, p));
  ensures (forall p:$ptr :: {$ts($s, p)}
    p == a || p == $left_split(a, i) || p == $right_split(a, i) ||
    $emb(old($s), p) == a ||
    $ts_eq(old($s), $s, p));
  ensures $mutable_root($s, $left_split(a, i)) && $mutable_root($s, $right_split(a, i));
  ensures $memory($s) == $memory(old($s));
  ensures $timestamp_post_strict(old($s), $s);

procedure $join_arrays(a1:$ptr, a2:$ptr);
  // writes extent(a1,a2)
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  // TOKEN: the first array to join is not embedded inside of another object
  requires $is_object_root($s, a1);
  // TOKEN: the second array to join is not embedded inside of another object
  requires $is_object_root($s, a2);
  // TOKEN: types of arrays to join agree
  requires $element_type($typ(a1)) == $element_type($typ(a2));
  // TOKEN: the first array ends, where the second array starts
  requires $ref($idx(a1, $array_length($typ(a1)), $element_type($typ(a1)))) == $ref(a2);
  ensures $memory(old($s)) == $memory($s);
  ensures (forall p:$ptr :: {$st($s, p)}
    p == $joined_array(a1, a2) || p == a1 || p == a2 ||
    $st_eq(old($s), $s, p));
  ensures (forall p:$ptr :: {$ts($s, p)}
    p == $joined_array(a1, a2) || p == a1 || p == a2 ||
    $emb(old($s), p) == a1 || $emb(old($s), p) == a2 ||
    $ts_eq(old($s), $s, p));
  ensures $mutable_root($s, $joined_array(a1, a2));
  ensures $memory($s) == $memory(old($s));
  ensures $timestamp_post_strict(old($s), $s);

procedure $to_bytes(a:$ptr);
  // writes extent(a)
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  // TOKEN: the reinterpreted object is not embedded inside of another object
  requires $is_object_root($s, a);
  ensures $mutable_root($s, $as_array(a, ^^u1, $sizeof($typ(a))));
  ensures (forall p:$ptr :: {$st($s, p)} {$st($s, p)}
    ($set_in(p, $extent($s, $as_array(a, ^^u1, $sizeof($typ(a))))) ==> $now_writable($s, p)) &&
    ($set_in(p, $full_extent(a)) ||
     $set_in(p, $extent($s, $as_array(a, ^^u1, $sizeof($typ(a))))) ||
     ($st_eq(old($s), $s, p) && $ts_eq(old($s), $s, p))));
  ensures (forall p:$ptr :: {$mem($s, p)}
    $set_in(p, $full_extent(a)) ||
    $set_in(p, $full_extent($as_array(a, ^^u1, $sizeof($typ(a))))) ||
    ($st_eq(old($s), $s, p) && $ts_eq(old($s), $s, p) && $mem_eq(old($s), $s, p)));
  ensures $timestamp_post_strict(old($s), $s);

procedure $from_bytes(a:$ptr, t:$ctype, preserve_zero:bool);
  // writes extent(a)
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  // TOKEN: the reinterpreted array is not embedded inside of another object
  requires $is_object_root($s, a);
  // TOKEN: the reinterpreted array is array of bytes
  requires $element_type($typ(a)) == ^^u1;
  // TOKEN: the reinterpreted array is large enough
  requires $sizeof(t) <= $array_length($typ(a));
  // TOKEN: extent_zero holds for the reinterpreted array
  requires preserve_zero ==> $extent_zero($s, a);
  ensures $mutable_root($s, $ptr(t, $ref(a)));
  ensures (forall p:$ptr :: {$st($s, p)} {$ts($s, p)}
    ($set_in(p, $extent($s, $ptr(t, $ref(a)))) ==> $now_writable($s, p)) &&
    ($set_in(p, $full_extent(a)) ||
     $set_in(p, $extent($s, $ptr(t, $ref(a)))) ||
     ($st_eq(old($s), $s, p) && $ts_eq(old($s), $s, p))));
  ensures (forall p:$ptr :: {$mem($s, p)}
    !$set_in(p, $full_extent(a)) &&
    !$set_in(p, $full_extent($ptr(t, $ref(a)))) ==>
        $st_eq(old($s), $s, p) && $ts_eq(old($s), $s, p) && $mem_eq(old($s), $s, p));
  ensures $timestamp_post_strict(old($s), $s);
  ensures preserve_zero ==> $extent_zero($s, $ptr(t, $ref(a)));

// -----------------------------------------------------------------------
// Sets of pointers
// -----------------------------------------------------------------------

type $ptrset;

function $set_in($ptr,$ptrset) returns(bool);

function $set_empty() returns($ptrset);
axiom (forall #o: $ptr :: {:weight 0} {$set_in(#o, $set_empty())} !$set_in(#o, $set_empty()));

function $set_singleton($ptr) returns ($ptrset);
axiom (forall #r: $ptr, #o: $ptr :: {:weight 0} {$set_in(#o, $set_singleton(#r))} $set_in(#o, $set_singleton(#r)) <==> #r == #o);

function $non_null_set_singleton($ptr) returns ($ptrset);
axiom (forall #r: $ptr, #o: $ptr :: {:weight 0} {$set_in(#o, $non_null_set_singleton(#r))} $set_in(#o, $non_null_set_singleton(#r)) <==> (#r == #o && $ptr_neq(#r, $null)));

function $set_union($ptrset, $ptrset) returns ($ptrset);
axiom (forall #a: $ptrset, #b: $ptrset, #o: $ptr :: {:weight 0} {$set_in(#o, $set_union(#a,#b))}
  $set_in(#o, $set_union(#a,#b)) <==> $set_in(#o, #a) || $set_in(#o, #b));

function $set_difference($ptrset, $ptrset) returns ($ptrset);
axiom (forall #a: $ptrset, #b: $ptrset, #o: $ptr :: {:weight 0} {$set_in(#o, $set_difference(#a,#b))}
  $set_in(#o, $set_difference(#a,#b)) <==> $set_in(#o, #a) && !$set_in(#o, #b));

function $set_intersection($ptrset, $ptrset) returns ($ptrset);
axiom (forall #a: $ptrset, #b: $ptrset, #o: $ptr :: {:weight 0} {$set_in(#o, $set_intersection(#a,#b))}
  $set_in(#o, $set_intersection(#a,#b)) <==> $set_in(#o, #a) && $set_in(#o, #b));
  
function $set_subset($ptrset, $ptrset) returns (bool);
axiom(forall #a: $ptrset, #b: $ptrset :: {:weight 0} {$set_subset(#a,#b)}
  $set_subset(#a,#b) <==> (forall #o: $ptr :: {:weight 0} {$set_in(#o, #a)} {$set_in(#o, #b)} $set_in(#o, #a) ==> $set_in(#o, #b)));

function {:inline true} $set_add_element(S:$ptrset, e:$ptr) : $ptrset
  { $set_union(S, $set_singleton(e)) }

function {:inline true} $set_remove_element(S:$ptrset, e:$ptr) : $ptrset
  { $set_difference(S, $set_singleton(e)) }

// to be used only positively
function $set_eq($ptrset, $ptrset) returns (bool);
axiom (forall #a: $ptrset, #b: $ptrset :: {:weight 0} {$set_eq(#a,#b)}
  (forall #o: $ptr :: {:weight 0} {$dont_instantiate(#o)} $set_in(#o, #a) <==> $set_in(#o, #b)) ==> $set_eq(#a, #b));
axiom (forall #a: $ptrset, #b: $ptrset :: {:weight 0} {$set_eq(#a,#b)}
  $set_eq(#a, #b) ==> #a == #b);

function $set_cardinality($ptrset) returns(int);

axiom ($set_cardinality($set_empty()) == 0);
axiom (forall p:$ptr :: {:weight 0} $set_cardinality($set_singleton(p)) == 1);

function $set_universe() returns($ptrset);
axiom (forall #o: $ptr :: {:weight 0} {$set_in(#o, $set_universe())} $set_in(#o, $set_universe()));

function $set_disjoint(s1:$ptrset, s2:$ptrset) returns(bool);
function $id_set_disjoint(p:$ptr, s1:$ptrset, s2:$ptrset) returns(int);

axiom (forall p:$ptr, s1:$ptrset, s2:$ptrset :: {:weight 0} {$set_disjoint(s1, s2), $set_in(p, s1)}
  $set_disjoint(s1, s2) && $set_in(p, s1) ==> 
    $id_set_disjoint(p, s1, s2) == 1);
axiom (forall p:$ptr, s1:$ptrset, s2:$ptrset :: {:weight 0} {$set_disjoint(s1, s2), $set_in(p, s2)}
  $set_disjoint(s1, s2) && $set_in(p, s2) ==> 
    $id_set_disjoint(p, s1, s2) == 2);

axiom (forall s1:$ptrset, s2:$ptrset :: {:weight 0} {$set_disjoint(s1, s2)}
  (forall p:$ptr :: {$dont_instantiate(p)}
     ($set_in(p, s1) ==> !$set_in(p, s2)) && ($set_in(p, s2) ==> !$set_in(p, s1))) 
  ==> $set_disjoint(s1, s2));


function $set_in3($ptr, $ptrset) returns(bool);
function $set_in2($ptr, $ptrset) returns(bool);

function $in_some_owns($ptr) returns(bool);

axiom (forall p:$ptr, S1:$state, p1:$ptr :: 
  {:weight 0} {$set_in(p, $owns(S1, p1))}
  $set_in(p, $owns(S1, p1)) ==> $in_some_owns(p));

axiom (forall p:$ptr, S1:$state, p1:$ptr :: 
  {:weight 0} {$set_in2(p, $owns(S1, p1)), $in_some_owns(p)}
  $set_in(p, $owns(S1, p1)) <==> $set_in2(p, $owns(S1, p1)));

axiom (forall p:$ptr, s:$ptrset :: {:weight 0} {$set_in(p, s)}
  $set_in(p, s) <==> $set_in2(p, s));
axiom (forall p:$ptr, s:$ptrset :: {:weight 0} {$set_in(p, s)}
  $set_in(p, s) <==> $set_in3(p, s));

function $set_in0($ptr, $ptrset) returns(bool);
axiom (forall p:$ptr, s:$ptrset :: {:weight 0} {$set_in0(p, s)}
  $set_in(p, s) <==> $set_in0(p, s));

/*
// Alternative; easier to use, but seems slower, at least for the list
function $as_in0(p:$ptr) returns($ptr) { p }
function {:inline true} $set_in0(p:$ptr, s:$ptrset) returns(bool)
  { $set_in($as_in0(p), s) }
*/

/*
axiom (forall s1:$state, s2:$state, p:$ptr, q:$ptr :: 
  { $set_in0(p, cast(s1[q],$ptrset)), $set_in(p, cast(s2[q],$ptrset)) }
  $set_in(p, cast(s2[q],$ptrset)) <==> $set_in0(p, cast(s2[q],$ptrset)));
*/

function sk_hack(bool) returns(bool);

/*
function $field_set(S:$ptrset, #t:$ctype, #f:$field) returns($ptrset);
axiom (forall S:$ptrset, #t:$ctype, #f:$field, #p:$ptr :: {$set_in(#p, $field_set(S, #t, #f))}
  $set_in(#p, $field_set(S, #t, #f)) ==> $set_in($ptr(#t, $ref(#p) - $field_offset(#f)), S));

axiom (forall S:$ptrset, #t:$ctype, #f:$field, #p:$ptr, S:$state ::
  $set_in(#p, $field_set(S, #t, #f)) ==> $set_in($emb(S, #p), s)
  $set_in($ptr(#t, $ref(#p) - $field_offset(#f)), S));
 */

/*
function $water_level($state, $ptr) returns($ptr);

axiom (forall S:$state, p:$ptr :: {$thread_local(S, p)}
  $good_state(S) ==>
    $thread_local(S, p) ==> $owner(S, $water_level(S, p)) == $me());

axiom (forall M1:$state, M2:$state, p:$ptr :: {$thread_local(M1, p), $thread_local(M2, p)}
  $thread_local(M1, p) && $st(M1, $water_level(M1, p)) == $st(M1, $water_level(M2, p)) ==>
    $thread_local(M2, p));
  */

function {:inline true} $writes_nothing(S1:$state, S2:$state) returns(bool)
  { 
    (forall p:$ptr :: {$st(S2, p)}
        $nested(S2, p) ==> $nested(S1, p)) &&
    (forall p:$ptr :: {$mem(S2, p)}
       $thread_local(S1, p) ==> $mem_eq(S1, S2, p) && $thread_local(S2, p)) &&
    (forall p:$ptr :: {$st(S2, p)}
       $thread_local(S1, p) ==> $st_eq(S1, S2, p) && $thread_local(S2, p)) &&
    (forall p:$ptr :: {$ts(S2, p)}
       $thread_local(S1, p) ==> $ts_eq(S1, S2, p) && $thread_local(S2, p)) &&
    $timestamp_post(S1, S2)
  }

// --------------------------------------------------------------------------------
// Arrays
// --------------------------------------------------------------------------------

// to be used when you allocate just the array itself
function $array($ctype, int) returns($ctype);
function $element_type($ctype) returns($ctype);
function $array_length($ctype) returns(int);
axiom (forall T:$ctype, s:int :: {$array(T, s)} $element_type($array(T, s)) == T);
axiom (forall T:$ctype, s:int :: {$array(T, s)} $array_length($array(T, s)) == s);
axiom (forall T:$ctype, s:int :: {$array(T, s)} $ptr_level($array(T, s)) == 0);
axiom (forall T:$ctype, s:int :: {$array(T, s)} $is_arraytype($array(T, s)));
axiom (forall T:$ctype, s:int :: {$array(T, s)} !$is_claimable($array(T, s)));
axiom (forall T:$ctype, s:int :: {$sizeof($array(T, s))} $sizeof($array(T, s)) == $sizeof(T) * s);

function {:weight 0} $inlined_array(p:$ptr, T:$ctype) returns ($ptr)
  { p }

function $idx($ptr,int,$ctype) returns($ptr);
axiom (forall #p:$ptr, #i:int, #t:$ctype ::
  {$idx(#p, #i, #t)} 
    $extent_hint($idx(#p, #i, #t), #p) &&
    $idx(#p, #i, #t) == $ptr(#t, $add.mul($ref(#p) , #i , $sizeof(#t))));

//function $add.mul(x:int,y:int,z:int) returns(int);


function {:inline true} {:expand true} $add.mul(x:int,y:int,z:int) returns(int)
  { x + y*z }

function {:inline true} {:expand true} $add(x:int,y:int) returns(int)
  { x + y }

axiom (forall p:$ptr, i:int, j:int, T:$ctype :: {$idx($idx(p, i, T), j, T)}
  i != 0 && j != 0 ==> // seems to prevent matching loop
    $idx($idx(p, i, T), j, T) == $idx(p, $add( i,  j ), T));

function {:weight 0} $is_array_vol_or_nonvol(S:$state, p:$ptr, T:$ctype, sz:int, vol:bool) returns(bool)
  { $is(p, T) && 
    (forall i:int :: {$st(S, $idx(p, i, T))} {$ts(S, $idx(p, i, T))} {$mem(S, $idx(p, i, T))}
      0 <= i && i < sz ==> 
        ($is_volatile(S, $idx(p, i, T)) == vol) && $typed(S, $idx(p, i, T))) }

function {:weight 0} $is_array(S:$state, p:$ptr, T:$ctype, sz:int) returns(bool)
  { $is(p, T) && 
    (forall i:int :: {$st(S, $idx(p, i, T))} {$ts(S, $idx(p, i, T))} {$mem(S, $idx(p, i, T))}
      0 <= i && i < sz ==> 
        $typed(S, $idx(p, i, T))) }

/*
axiom (forall S:$state, p:$ptr, T:$ctype, sz:int ::
    $is_array(S, p, T, sz) ==>
    (forall i:int :: {$st(S, $idx(p, i, T))} {$ts(S, $idx(p, i, T))} {$mem(S, $idx(p, i, T))}
        // TODO introduce $elements_in_biggest_emb_array(T)
      0 <= i && i < sz ==> 
        $sizeof($typ($emb(S, $idx(p, i, T)))) >= sz // * $sizeof(T)
        ));
  */        

function {:inline true} $is_thread_local_array(S:$state, p:$ptr, T:$ctype, sz:int) returns(bool)
  { (forall i:int :: {$st(S, $idx(p, i, T))}  {$ts(S, $idx(p, i, T))}
      0 <= i && i < sz ==> 
        $thread_local2(S, $idx(p, i, T), T)) }

function {:inline true} $is_mutable_array(S:$state, p:$ptr, T:$ctype, sz:int) returns(bool)
  { $is_array(S, p, T, sz) &&
    (forall i:int :: {$st(S, $idx(p, i, T))}  {$ts(S, $idx(p, i, T))}
      0 <= i && i < sz ==> $mutable(S, $idx(p, i, T))) }

function {:inline true} $is_array_emb(S:$state, p:$ptr, T:$ctype, sz:int, emb:$ptr) returns(bool)
  { $is_array_vol_or_nonvol(S, p, T, sz, false) &&
    (forall i:int :: {$ts(S, $idx(p, i, T))} 
      0 <= i && i < sz ==> $emb(S, $idx(p, i, T)) == emb) }

function {:inline true} $is_array_emb_path(S:$state, p:$ptr, T:$ctype, sz:int, emb:$ptr, f:$field, isvol:bool) returns(bool)
  { $is_array_vol_or_nonvol(S, p, T, sz, isvol) &&
    (forall i:int :: {$ts(S, $idx(p, i, T))} {$mem(S, $idx(p, i, T))}
      0 <= i && i < sz ==> $emb(S, $idx(p, i, T)) == emb && $path(S, $idx(p, i, T)) == $array_path(f, i)) }

function {:inline true} $array_field_properties(f:$field, T:$ctype, sz:int, union:bool, vol:bool) returns(bool)
  { (forall S:$state, p:$ptr, i:int ::
       {$ts(S, $idx($dot(p, f), i, T))}
       {$st(S, $idx($dot(p, f), i, T))}
       {$mem(S, $idx($dot(p, f), i, T))}
       0 <= i && i < sz &&
       (!union || $active_option(S, p) == f) &&
       $typed2(S, p, $field_parent_type(f)) ==>
         $is_volatile(S, $idx($dot(p, f), i, T)) == vol &&
         $typed(S, $idx($dot(p, f), i, T)) &&
         $emb(S, $idx($dot(p, f), i, T)) == p &&
         $path(S, $idx($dot(p, f), i, T)) == $array_path(f, i)
      ) }

function {:inline true} $no_inline_array_field_properties(f:$field, T:$ctype, sz:int, union:bool, vol:bool) returns(bool)
  { (forall S:$state, p:$ptr ::
       {$ts(S, $as_array($dot(p, f), T, sz))}
       {$st(S, $as_array($dot(p, f), T, sz))}
       {$mem(S, $as_array($dot(p, f), T, sz))}
       (!union || $active_option(S, p) == f) &&       
       $typed2(S, p, $field_parent_type(f)) ==>
         $extent_hint($as_array($dot(p, f), T, sz), p) &&
         $typed(S, $as_array($dot(p, f), T, sz)) &&
         $emb(S, $as_array($dot(p, f), T, sz)) == p &&
         $path(S, $as_array($dot(p, f), T, sz)) == f 
      )
    &&
   (forall p:$ptr, i:int :: {$idx($dot(p, f), i, T)} $instantiate_ptr($as_array($dot(p, f), T, sz)))
   }

axiom (forall p:$ptr, #r:int, T:$ctype, sz:int ::
    { $in_full_extent_of(p, $ptr($array(T, sz), #r)) }
    $in_full_extent_of(p, $ptr($array(T, sz), #r)) <==> 
      p == $ptr($array(T, sz), #r) || $in_array_full_extent_of(p, $ptr(T, #r), T, sz));

axiom (forall S:$state, p:$ptr, #r:int, T:$ctype, sz:int ::
    { $in_extent_of(S, p, $ptr($array(T, sz), #r)) }
    $in_extent_of(S, p, $ptr($array(T, sz), #r)) <==> 
      p == $ptr($array(T, sz), #r) || $in_array_extent_of(S, p, $ptr(T, #r), T, sz));

axiom (forall p:$ptr, #r:int, T:$ctype, sz:int ::
   { $in_span_of(p, $ptr($array(T, sz), #r)), $is_primitive(T)}
    $is_primitive(T) ==>
      ($in_span_of(p, $ptr($array(T, sz), #r)) <==> $in_array(p, $ptr(T, #r), T, sz)));

function {:inline true} $array_elt_emb(S:$state, p:$ptr, emb:$ptr) returns(bool)
    { $emb(S, p) == emb && !$is_volatile(S, p) && $typed(S, p) }

axiom (forall S:$state, #r:int, T:$ctype, sz:int, i:int :: 
      {$st(S, $idx($ptr(T, #r), i, T)), $ptr($array(T, sz), #r)} 
      {$ts(S, $idx($ptr(T, #r), i, T)), $ptr($array(T, sz), #r)} 
      $typed(S, $ptr($array(T, sz), #r)) ==> 
        0 <= i && i < sz ==> 
          $array_elt_emb(S, $idx($ptr($array(T, sz), #r), i, T), $ptr($array(T, sz), #r)));

function $array_members(p:$ptr, T:$ctype, sz:int) returns($ptrset);

axiom (forall p:$ptr, T:$ctype, sz:int, elem:$ptr ::
  { $set_in(elem, $array_members(p,T,sz)) }
  $set_in(elem, $array_members(p,T,sz)) <==> $in_array(elem, p, T, sz));

function $array_range_no_state(p:$ptr, T:$ctype, sz:int) returns($ptrset);
function $array_range(S:$state, p:$ptr, T:$ctype, sz:int) returns($ptrset)
  { $array_range_no_state(p, T, sz) }

axiom (forall S:$state, p:$ptr, #r:int, T:$ctype, sz:int ::
    { $set_in(p, $array_range(S, $ptr(T, #r), T, sz)) }
    $instantiate_bool($typed(S, p)) &&
    ($set_in(p, $array_range(S, $ptr(T, #r), T, sz)) <==> $in_array_full_extent_of(p, $ptr(T, #r), T, sz)));

axiom (forall p:$ptr, T:$ctype, sz:int, idx:int, S:$ptrset ::
    { $idx(p, idx, T), $set_disjoint($array_range_no_state(p, T, sz), S) }
    $set_disjoint($array_range_no_state(p, T, sz), S) ==>
    0 <= idx && idx < sz ==> $id_set_disjoint($idx(p, idx, T), $array_range_no_state(p, T, sz), S) == 1);

axiom (forall p:$ptr, T:$ctype, sz:int, idx:int, S:$ptrset ::
    { $idx(p, idx, T), $set_disjoint(S, $array_range_no_state(p, T, sz)) }
    $set_disjoint(S, $array_range_no_state(p, T, sz)) ==>
    0 <= idx && idx < sz ==> $id_set_disjoint($idx(p, idx, T), S, $array_range_no_state(p, T, sz)) == 2);

function $non_null_array_range(p:$ptr, T:$ctype, sz:int) returns($ptrset);
axiom (forall p:$ptr, #r:int, T:$ctype, sz:int ::
    { $set_in(p, $non_null_array_range($ptr(T, #r), T, sz)) }
    $set_in(p, $non_null_array_range($ptr(T, #r), T, sz)) <==> 
      #r != 0 &&
      $in_array_full_extent_of(p, $ptr(T, #r), T, sz));

function $non_null_extent(S:$state, p:$ptr) returns($ptrset);
axiom (forall q:$ptr, S:$state, p:$ptr ::
    { $set_in(q, $non_null_extent(S, p)) }
    $set_in(q, $non_null_extent(S, p)) <==>
      $ptr_neq(p, $null) && $set_in(q, $extent(S, p)));

function {:inline true} $as_array(p:$ptr, T:$ctype, sz:int) returns($ptr)
  { $ptr($array(T, sz), $ref(p)) }

function {:inline true} $array_eq(s1:$state, s2:$state, arr:$ptr, T:$ctype, sz:int) returns(bool)
  { (forall #i:int :: {$idx(arr, #i, T)} 0 <= #i && #i < sz ==> $mem_eq(s1, s2, $idx(arr, #i, T))) }

// $index_within(p, arr) = ($ref(p) - $ref(arr)) div $sizeof($typ(arr))
// To avoid using division, we define a category of simple indices. 
//   $simple_index(p, arr) iff p == arr[k].f1.f2.f3...fN, where N >= 0.
// We're only interested in simple indices for verification.
function $index_within(p:$ptr, arr:$ptr) returns(int);
function $simple_index(p:$ptr, arr:$ptr) returns(bool);

axiom (forall p:$ptr, k:int :: {$idx(p, k, $typ(p))}
  $index_within($idx(p, k, $typ(p)), p) == k && $simple_index($idx(p, k, $typ(p)), p));

axiom (forall p:$ptr, q:$ptr, f:$field :: {$simple_index($dot(p, f), q)} {$index_within($dot(p, f), q)}
  $simple_index(p, q) ==> $simple_index($dot(p, f), q) && $index_within($dot(p, f), q) == $index_within(p, q));

axiom (forall p:$ptr, q:$ptr, f:$field, i:int, t:$ctype :: 
  {$simple_index($idx($dot(p, f), i, t), q)}
  {$index_within($idx($dot(p, f), i, t), q)}
  0 <= i && i < $embedded_array_size(f, t) && 
  $simple_index(p, q) ==> 
    $simple_index($idx($dot(p, f), i, t), q) && 
    $index_within($idx($dot(p, f), i, t), q) == $index_within(p, q));

function {:inline true} $in_array(q:$ptr, arr:$ptr, T:$ctype, sz:int) returns(bool)
  { $in_range(0, $index_within(q, arr), sz - 1) && q == $idx(arr, $index_within(q, arr), T) }

function {:inline true} $in_array_full_extent_of(q:$ptr, arr:$ptr, T:$ctype, sz:int) returns(bool)
  { $in_range(0, $index_within(q, arr), sz - 1) && $in_full_extent_of(q, $idx(arr, $index_within(q, arr), T)) }

function {:inline true} $in_array_extent_of(S:$state, q:$ptr, arr:$ptr, T:$ctype, sz:int) returns(bool)
  { $in_range(0, $index_within(q, arr), sz - 1) && $in_extent_of(S, q, $idx(arr, $index_within(q, arr), T)) }

axiom (forall s1:$state, s2:$state, p:$ptr, t:$ctype, sz:int :: {$state_spans_the_same(s1, s2, p, $array(t, sz)), $is_primitive(t)}
  $is_primitive(t) ==>
    $state_spans_the_same(s1, s2, p, $array(t, sz)) ==> 
      (forall i:int :: {$mem(s2, $idx($ptr_cast(p, t), i, t))} 0 <= i && i < sz ==> 
        $mem_eq(s1, s2, $idx($ptr_cast(p, t), i, t))));

/*
function {:inline true} $in_array(q:$ptr, arr:$ptr, T:$ctype, sz:int) returns(bool)
  { (exists #i:int :: { $idx(arr, #i, T) } $in_range(0, #i, sz - 1) && q == $idx(arr, #i, T)) }

function {:inline true} $in_array_full_extent_of(q:$ptr, arr:$ptr, T:$ctype, sz:int) returns(bool)
  { (exists #i:int :: { $idx(arr, #i, T) } $in_range(0, #i, sz - 1) && $in_full_extent_of(q, $idx(arr, #i, T))) }

function {:inline true} $in_array_extent_of(S:$state, q:$ptr, arr:$ptr, T:$ctype, sz:int) returns(bool)
  { (exists #i:int :: { $idx(arr, #i, T) } $in_range(0, #i, sz - 1) && $in_extent_of(S, q, $idx(arr, #i, T))) }
*/

// --------------------------------------------------------------------------------
// Arithmetic
// --------------------------------------------------------------------------------

function {:inline true} $in_range(min:int, val:int, max:int) returns(bool)
  { min <= val && val <= max }

function {:inline true} $bool_to_int(v:bool) returns(int)
  { if v then 1 else 0 }

function {:inline true} $int_to_bool(x:int) returns(bool)
  { x != 0 }

function {:inline true} $read_bool(S:$state, p:$ptr) returns(bool)
  { $int_to_bool($mem(S, p)) }


// a hack, used when parameter to ITE is a quntified variable to prevent Z3 from crashing
function {:weight 0} $bool_id(x:bool) returns(bool) { x }

const $min.i1:int;
const $max.i1:int;
const $min.i2:int;
const $max.i2:int;
const $min.i4:int;
const $max.i4:int;
const $min.i8:int;
const $max.i8:int;
const $max.u1:int;
const $max.u2:int;
const $max.u4:int;
const $max.u8:int;

axiom ($min.i1 == -128);
axiom ($max.i1 ==  127);
axiom ($min.i2 == -32768);
axiom ($max.i2 ==  32767);
axiom ($min.i4 == -(65536*32768)  );
axiom ($max.i4 ==   65536*32768 -1);
axiom ($min.i8 == -(65536*65536*65536*32768)  );
axiom ($max.i8 ==   65536*65536*65536*32768 -1);
axiom ($max.u1 ==  255);
axiom ($max.u2 ==  65535);
axiom ($max.u4 ==  65536*65536-1);
axiom ($max.u8 ==  65536*65536*65536*65536-1);

function {:inline true} $in_range_i1(x:int) returns(bool) { $in_range($min.i1, x, $max.i1) }
function {:inline true} $in_range_i2(x:int) returns(bool) { $in_range($min.i2, x, $max.i2) }
function {:inline true} $in_range_i4(x:int) returns(bool) { $in_range($min.i4, x, $max.i4) }
function {:inline true} $in_range_i8(x:int) returns(bool) { $in_range($min.i8, x, $max.i8) }
function {:inline true} $in_range_u1(x:int) returns(bool) { $in_range(0, x, $max.u1) }
function {:inline true} $in_range_u2(x:int) returns(bool) { $in_range(0, x, $max.u2) }
function {:inline true} $in_range_u4(x:int) returns(bool) { $in_range(0, x, $max.u4) }
function {:inline true} $in_range_u8(x:int) returns(bool) { $in_range(0, x, $max.u8) }
function {:inline true} $in_range_ptr(p:$ptr) returns(bool) { $in_range_u8($ref(p)) }

function {:inline true} $in_range_div_i1(x:int, y:int) returns(bool) { y != -1 || x != $min.i1 }
function {:inline true} $in_range_div_i2(x:int, y:int) returns(bool) { y != -1 || x != $min.i2 }
function {:inline true} $in_range_div_i4(x:int, y:int) returns(bool) { y != -1 || x != $min.i4 }
function {:inline true} $in_range_div_i8(x:int, y:int) returns(bool) { y != -1 || x != $min.i8 }

function $ptr_to_u8($ptr) returns(int);
function $ptr_to_i8($ptr) returns(int);
function $ptr_to_u4($ptr) returns(int);
function $ptr_to_i4($ptr) returns(int);
function $ptr_to_u2($ptr) returns(int);
function $ptr_to_i2($ptr) returns(int);
function $ptr_to_u1($ptr) returns(int);
function $ptr_to_i1($ptr) returns(int);

axiom ($ptr_to_u8($null) == 0);
axiom ($ptr_to_i8($null) == 0);
axiom ($ptr_to_u4($null) == 0);
axiom ($ptr_to_i4($null) == 0);
axiom ($ptr_to_u2($null) == 0);
axiom ($ptr_to_i2($null) == 0);
axiom ($ptr_to_u1($null) == 0);
axiom ($ptr_to_i1($null) == 0);

function {:inline true} $u8_to_ptr(x : int) returns($ptr) { $ptr(^^void, x)  }
function {:inline true} $i8_to_ptr(x : int) returns($ptr) { $ptr(^^void, x)  }
function {:inline true} $u4_to_ptr(x : int) returns($ptr) { $ptr(^^void, x)  }
function {:inline true} $i4_to_ptr(x : int) returns($ptr) { $ptr(^^void, x)  }
function {:inline true} $u2_to_ptr(x : int) returns($ptr) { $ptr(^^void, x)  }
function {:inline true} $i2_to_ptr(x : int) returns($ptr) { $ptr(^^void, x)  }
function {:inline true} $u1_to_ptr(x : int) returns($ptr) { $ptr(^^void, x)  }
function {:inline true} $i1_to_ptr(x : int) returns($ptr) { $ptr(^^void, x)  }

axiom (forall p:$ptr :: { $ptr_to_u8(p) } $in_range_u8($ref(p)) ==> $ptr_to_u8(p) == $ref(p));
axiom (forall p:$ptr :: { $ptr_to_i8(p) } $in_range_i8($ref(p)) ==> $ptr_to_i8(p) == $ref(p));
axiom (forall p:$ptr :: { $ptr_to_u4(p) } $in_range_u4($ref(p)) ==> $ptr_to_u4(p) == $ref(p));
axiom (forall p:$ptr :: { $ptr_to_i4(p) } $in_range_i4($ref(p)) ==> $ptr_to_i4(p) == $ref(p));
axiom (forall p:$ptr :: { $ptr_to_u2(p) } $in_range_u2($ref(p)) ==> $ptr_to_u2(p) == $ref(p));
axiom (forall p:$ptr :: { $ptr_to_i2(p) } $in_range_i2($ref(p)) ==> $ptr_to_i2(p) == $ref(p));
axiom (forall p:$ptr :: { $ptr_to_u1(p) } $in_range_u1($ref(p)) ==> $ptr_to_u1(p) == $ref(p));
axiom (forall p:$ptr :: { $ptr_to_i1(p) } $in_range_i1($ref(p)) ==> $ptr_to_i1(p) == $ref(p));

function {:weight 0} $byte_ptr_subtraction(p1:$ptr, p2:$ptr) returns(int)
  { $ref(p1) - $ref(p2) }

axiom (forall S:$state, r:int, t:$ctype :: {$mem(S, $ptr($as_in_range_t(t), r))}
  $good_state(S) ==> $in_range_t(t, $mem(S, $ptr($as_in_range_t(t), r))));

axiom (forall S:$state, r:int, t:$ctype :: {$mem(S, $ptr($ptr_to(t), r))}
  $good_state(S) ==> $in_range_phys_ptr($mem(S, $ptr($ptr_to(t), r))));

axiom (forall S:$state, r:int, t:$ctype :: {$mem(S, $ptr($spec_ptr_to(t), r))}
  $good_state(S) ==> $in_range_spec_ptr($mem(S, $ptr($spec_ptr_to(t), r))));

function $_pow2(int) returns(int);
axiom 
$_pow2(0) == 1 && $_pow2(1) == 2 && $_pow2(2) == 4 && $_pow2(3) == 8 && $_pow2(4) == 16 && $_pow2(5) == 32 &&
$_pow2(6) == 64 && $_pow2(7) == 128 && $_pow2(8) == 256 && $_pow2(9) == 512 && $_pow2(10) == 1024 && $_pow2(11) ==
 2048 && $_pow2(12) == 4096 && $_pow2(13) == 8192 && $_pow2(14) == 16384 && $_pow2(15) == 32768 && $_pow2(16) ==
65536 && $_pow2(17) == 131072 && $_pow2(18) == 262144 && $_pow2(19) == 524288 && $_pow2(20) == 1048576 && $_pow2(21)
== 2097152 && $_pow2(22) == 4194304 && $_pow2(23) == 8388608 && $_pow2(24) == 16777216 && $_pow2(25) == 33554432 &&
$_pow2(26) == 67108864 && $_pow2(27) == 134217728 && $_pow2(28) == 268435456 && $_pow2(29) == 536870912 && $_pow2(30)
== 1073741824 && $_pow2(31) == 2147483648 && $_pow2(32) == 4294967296 && $_pow2(33) == 8589934592 && $_pow2(34) ==
17179869184 && $_pow2(35) == 34359738368 && $_pow2(36) == 68719476736 && $_pow2(37) == 137438953472 && $_pow2(38) ==
274877906944 && $_pow2(39) == 549755813888 && $_pow2(40) == 1099511627776 && $_pow2(41) == 2199023255552 && $_pow2(42)
== 4398046511104 && $_pow2(43) == 8796093022208 && $_pow2(44) == 17592186044416 && $_pow2(45) == 35184372088832
&& $_pow2(46) == 70368744177664 && $_pow2(47) == 140737488355328 && $_pow2(48) == 281474976710656 && $_pow2(49) ==
562949953421312 && $_pow2(50) == 1125899906842624 && $_pow2(51) == 2251799813685248 && $_pow2(52) == 4503599627370496
&& $_pow2(53) == 9007199254740992 && $_pow2(54) == 18014398509481984 && $_pow2(55) == 36028797018963968 && $_pow2(56)
== 72057594037927936 && $_pow2(57) == 144115188075855872 && $_pow2(58) == 288230376151711744 && $_pow2(59) ==
 576460752303423488 && $_pow2(60) == 1152921504606846976 && $_pow2(61) == 2305843009213693952 && $_pow2(62) ==
4611686018427387904 && $_pow2(63) == 9223372036854775808;

function $in_range_ubits(bits:int, v:int) returns(bool)
  { $in_range(0, v, $_pow2(bits) - 1) }

function $unchecked_sbits(bits:int, v:int) returns(int);
axiom (forall bits:int, v:int :: {$unchecked_sbits(bits, v)}
  $in_range_sbits(bits, $unchecked_sbits(bits, v)) &&
  ($in_range_sbits(bits, v) ==> $unchecked_sbits(bits, v) == v));

function $in_range_sbits(bits:int, v:int) returns(bool)
  { $in_range(-$_pow2(bits-1), v, $_pow2(bits-1) - 1) }

function $unchecked_ubits(bits:int, v:int) returns(int);
axiom (forall bits:int, v:int :: {$unchecked_ubits(bits, v)}
  $in_range_ubits(bits, $unchecked_ubits(bits, v)) &&
  ($in_range_ubits(bits, v) ==> $unchecked_ubits(bits, v) == v));

function $_or(t:$ctype, x:int, y:int) returns(int);
function $_xor(t:$ctype, x:int, y:int) returns(int);
function $_and(t:$ctype, x:int, y:int) returns(int);
function $_not(t:$ctype, x:int) returns(int);

function {:weight 0} $unchk_add(t:$ctype, x:int, y:int) returns(int) { $unchecked(t, x + y) }
function {:weight 0} $unchk_sub(t:$ctype, x:int, y:int) returns(int) { $unchecked(t, x - y) }
function {:weight 0} $unchk_mul(t:$ctype, x:int, y:int) returns(int) { $unchecked(t, x * y) }
function {:inline true} $unchk_div(t:$ctype, x:int, y:int) returns(int) { $unchecked(t, x div y) }
function {:inline true} $unchk_mod(t:$ctype, x:int, y:int) returns(int) { $unchecked(t, x mod y) }

axiom(forall x:int, y:int :: {$unchk_add(^^u8, x, y)} 
  $in_range_u8(x) && $in_range_u8(y) && x + y > $max.u8 ==> $unchk_add(^^u8, x, y) == x + y - $max.u8 - 1
);

axiom(forall x:int, y:int :: {$unchk_add(^^u4, x, y)} 
  $in_range_u4(x) && $in_range_u4(y) && x + y > $max.u8 ==> $unchk_add(^^u4, x, y) == x + y - $max.u4 - 1
);


function {:weight 0} $_shl(t:$ctype, x:int, y:int) returns(int)
  { $unchecked(t, x * $_pow2(y)) }
function {:weight 0} $_shr(x:int, y:int) returns(int)
  { x div $_pow2(y) }

function $bv_extract_signed(val:int, val_bitsize:int, from:int, to:int) returns(int);
function $bv_extract_unsigned(val:int, val_bitsize:int, from:int, to:int) returns(int);
function $bv_update(val:int, val_bitsize:int, from:int, to:int, repl:int) returns(int);

axiom (forall x:int, from:int, to:int, xs:int, val:int :: 
 { $bv_update(x, xs, from, to, val) }
 0 <= from && from < to && to <= xs ==>
 0 <= val && val < $_pow2(to - from) ==> 
   0 <= $bv_update(x, xs, from, to, val) && $bv_update(x, xs, from, to, val) < $_pow2(xs));

axiom (forall from:int, to:int, xs:int :: 
 { $bv_update(0, xs, from, to, 0) }
 0 <= from && from < to && to <= xs ==> $bv_update(0, xs, from, to, 0) == 0);

axiom (forall from:int, to:int, val:int, x:int, xs:int :: 
  {$bv_extract_signed($bv_update(x, xs, from, to, val), xs, from, to)}
  0 <= from && from < to && to <= xs ==>
  -$_pow2(to - from - 1) <= val && val < $_pow2(to - from - 1) ==> 
    $bv_extract_signed($bv_update(x, xs, from, to, val), xs, from, to) == val);

axiom (forall from:int, to:int, val:int, x:int, xs:int :: 
  {$bv_extract_unsigned($bv_update(x, xs, from, to, val), xs, from, to)}
  0 <= from && from < to && to <= xs ==>
  0 <= val && val < $_pow2(to - from) ==> 
    $bv_extract_unsigned($bv_update(x, xs, from, to, val), xs, from, to) == val);

axiom (forall from:int, to:int, x:int, xs:int :: 
  {$bv_extract_signed(x, xs, from, to)}
  0 <= from && from < to && to <= xs ==>
  $in_range(-$_pow2(to - from - 1), $bv_extract_signed(x, xs, from, to), $_pow2(to - from - 1) - 1));

axiom (forall from:int, to:int, x:int, xs:int :: 
  {$bv_extract_unsigned(x, xs, from, to)}
  0 <= from && from < to && to <= xs ==>
  $in_range(0, $bv_extract_unsigned(x, xs, from, to), $_pow2(to - from) - 1));

axiom (forall from:int, to:int, val:int, x:int, xs:int, from2:int, to2:int :: 
  {$bv_extract_signed($bv_update(x, xs, from, to, val), xs, from2, to2)}
  0 <= from && from < to && to <= xs ==>
  0 <= from2 && from2 < to2 && to2 <= xs ==>
  (to2 <= from || to <= from2) ==>
  $bv_extract_signed($bv_update(x, xs, from, to, val), xs, from2, to2) == $bv_extract_signed(x, xs, from2, to2));

axiom (forall from:int, to:int, val:int, x:int, xs:int, from2:int, to2:int :: 
  {$bv_extract_unsigned($bv_update(x, xs, from, to, val), xs, from2, to2)}
  0 <= from && from < to && to <= xs ==>
  0 <= from2 && from2 < to2 && to2 <= xs ==>
  (to2 <= from || to <= from2) ==>
  $bv_extract_unsigned($bv_update(x, xs, from, to, val), xs, from2, to2) == $bv_extract_unsigned(x, xs, from2, to2));

axiom (forall from:int, to:int, xs:int ::
  {$bv_extract_signed(0, xs, from, to)}
  0 <= from && from < to && to <= xs ==>
    $bv_extract_signed(0, xs, from, to) == 0);

axiom (forall from:int, to:int, xs:int ::
  {$bv_extract_unsigned(0, xs, from, to)}
  0 <= from && from < to && to <= xs ==>
    $bv_extract_unsigned(0, xs, from, to) == 0);

axiom (forall from:int, to:int, val:int, xs:int ::
  {$bv_extract_unsigned(val, xs, from, to)}
  0 <= from && from < to && to <= xs && 0 <= val ==>
    $bv_extract_unsigned(val, xs, from, to) == (val div $_pow2(from)) mod $_pow2(to - from));

axiom (forall from:int, to:int, val:int, xs:int ::
  {$bv_extract_signed(val, xs, from, to)}
  0 <= from && from < to && to <= xs && 0 <= val && ((val div $_pow2(from)) mod $_pow2(to - from) < $_pow2(to - from - 1)) ==>
    $bv_extract_signed(val, xs, from, to) == (val div $_pow2(from)) mod $_pow2(to - from));

axiom (forall from:int, to:int, val:int, xs:int ::
  {$bv_extract_signed(val, xs, from, to)}
  0 <= from && from < to && to <= xs && 0 <= val && ((val div $_pow2(from)) mod $_pow2(to - from) >= $_pow2(to - from - 1)) ==>
    $bv_extract_signed(val, xs, from, to) == $_pow2(to - from - 1) - (val div $_pow2(from)) mod $_pow2(to - from));

/*
axiom (forall from:int, to:int, val:int :: {$sign_extend(from, to, $_bv_extract(val, to, 0, from))}
  (-$_pow2(from - 1) <= val && val < $_pow2(from - 1) ==> $sign_extend(from, to, $bv_extract(val, to, 0, from)) == val));

axiom (forall from:int, to:int, val:int :: {$sign_extend(from, to, val)}
  -$_pow2(from - 1) <= $sign_extend(from, to, val) && $sign_extend(from, to, val) < $_pow2(from - 1));

axiom (forall as:int, val:int, vs:int, from:int, to:int, bs:int ::
  {$bv_concat(0, as, $bv_extract(val, vs, from, to), bs)}
  as >= 1 ==>
    $bv_concat(0, as, $bv_extract(val, vs, from, to), bs) >= 0 &&
    $bv_concat(0, as, $bv_extract(val, vs, from, to), bs) < $_pow2(to - from));
    
axiom (forall s:int, from:int, to:int :: {$bv_extract(0, s, from, to)} 
  $bv_extract(0, s, from, to) == 0);

axiom (forall s1:int, s2: int :: {$bv_concat(0, s1, 0, s2)} 
  $bv_concat(0, s1, 0, s2) == 0);
*/

function $unchecked(t:$ctype, val:int) returns(int);
function $in_range_t(t:$ctype, x:int) returns(bool);

axiom (forall val:int :: {$in_range_t(^^i1, val)} $in_range_t(^^i1, val) <==> $in_range_i1(val));
axiom (forall val:int :: {$in_range_t(^^i2, val)} $in_range_t(^^i2, val) <==> $in_range_i2(val));
axiom (forall val:int :: {$in_range_t(^^i4, val)} $in_range_t(^^i4, val) <==> $in_range_i4(val));
axiom (forall val:int :: {$in_range_t(^^i8, val)} $in_range_t(^^i8, val) <==> $in_range_i8(val));
axiom (forall val:int :: {$in_range_t(^^u1, val)} $in_range_t(^^u1, val) <==> $in_range_u1(val));
axiom (forall val:int :: {$in_range_t(^^u2, val)} $in_range_t(^^u2, val) <==> $in_range_u2(val));
axiom (forall val:int :: {$in_range_t(^^u4, val)} $in_range_t(^^u4, val) <==> $in_range_u4(val));
axiom (forall val:int :: {$in_range_t(^^u8, val)} $in_range_t(^^u8, val) <==> $in_range_u8(val));
axiom (forall val:int :: {$in_range_t(^^mathint, val)} $in_range_t(^^mathint, val));

axiom (forall t:$ctype, val:int :: {$unchecked(t, val)} $in_range_t(t, val) ==> $unchecked(t, val) == val);
axiom (forall t:$ctype, val:int :: {$unchecked(t, val)} $in_range_t(t, $unchecked(t, val)));

axiom (forall val:int :: { $unchecked(^^u1, $unchecked(^^i1, val)) } $in_range_u1(val) ==> $unchecked(^^u1, $unchecked(^^i1, val)) == val);
axiom (forall val:int :: { $unchecked(^^u2, $unchecked(^^i2, val)) } $in_range_u2(val) ==> $unchecked(^^u2, $unchecked(^^i2, val)) == val);
axiom (forall val:int :: { $unchecked(^^u4, $unchecked(^^i4, val)) } $in_range_u4(val) ==> $unchecked(^^u4, $unchecked(^^i4, val)) == val);
axiom (forall val:int :: { $unchecked(^^u8, $unchecked(^^i8, val)) } $in_range_u8(val) ==> $unchecked(^^u8, $unchecked(^^i8, val)) == val);
axiom (forall val:int :: { $unchecked(^^i1, $unchecked(^^u1, val)) } $in_range_i1(val) ==> $unchecked(^^i1, $unchecked(^^u1, val)) == val);
axiom (forall val:int :: { $unchecked(^^i2, $unchecked(^^u2, val)) } $in_range_i2(val) ==> $unchecked(^^i2, $unchecked(^^u2, val)) == val);
axiom (forall val:int :: { $unchecked(^^i4, $unchecked(^^u4, val)) } $in_range_i4(val) ==> $unchecked(^^i4, $unchecked(^^u4, val)) == val);
axiom (forall val:int :: { $unchecked(^^i8, $unchecked(^^u8, val)) } $in_range_i8(val) ==> $unchecked(^^i8, $unchecked(^^u8, val)) == val);

axiom $unchecked(^^u4, -1) == $max.u4;
axiom $unchecked(^^u4, $max.u4 + 1) == 0;
axiom $unchecked(^^u8, -1) == $max.u8;
axiom $unchecked(^^u8, $max.u8 + 1) == 0;

// The semantics of $_and/$_or/...
//   Clip the number given to the appropriate range (i.e. take the lowest N bits) and perform the operation.


axiom (forall t:$ctype, x:int, y:int, z:int :: { x mod $_pow2(y), $_and(t, x, z) } 
  $in_range_t(t, x) &&
  $in_range_t(t, $_pow2(y) - 1) &&
  x >= 0 ==>
    x mod $_pow2(y) == $_and(t, x, $_pow2(y) - 1));

axiom (forall i: int, j: int :: { i div j }  0 <= i && 0 < j ==> i div j <= i);

axiom (forall i: int, j: int :: { i div j }  i > 0 && j > 0 ==> i - j < (i div j) * j && (i div j) * j <= i);
axiom (forall i: int :: { i div i }  i != 0 ==> i div i == 1);
axiom (forall i: int :: { 0 div i }  i != 0 ==> 0 div i == 0);

// from Spec# prelude, needs review
axiom (forall x: int, y: int :: { x mod y } { x div y } x mod y == x - x div y * y);
axiom (forall x: int, y: int :: { x mod y } 0 <= x && 0 < y ==> 0 <= x mod y && x mod y < y);
axiom (forall x: int, y: int :: { x mod y } 0 <= x && y < 0 ==> 0 <= x mod y && x mod y < 0 - y);
axiom (forall x: int, y: int :: { x mod y } x <= 0 && 0 < y ==> 0 - y < x mod y && x mod y <= 0);
axiom (forall x: int, y: int :: { x mod y } x <= 0 && y < 0 ==> y < x mod y && x mod y <= 0);
// Those three use +/- in triggers, won't work in Z3
//axiom (forall x: int, y: int :: { (x + y) mod y } 0 <= x && 0 <= y ==> (x + y) mod y == x mod y);
//axiom (forall x: int, y: int :: { (y + x) mod y } 0 <= x && 0 <= y ==> (y + x) mod y == x mod y);
//axiom (forall x: int, y: int :: { (x - y) mod y } 0 <= x - y && 0 <= y ==> (x - y) mod y == x mod y);

// Too expensive
//axiom (forall a: int, b: int, d: int :: { a mod d, b mod d } 2 <= d && a mod d == b mod d && a < b ==> a + d <= b);

axiom (forall t:$ctype, x: int, y: int :: { $_and(t, x, y) } 0 <= x && $in_range_t(t, x) ==> 0 <= $_and(t, x, y) && $_and(t, x, y) <= x);
axiom (forall t:$ctype, x: int, y: int :: { $_and(t, x, y) } 0 <= x && 0 <= y && $in_range_t(t, x) && $in_range_t(t, y) ==> $_and(t, x, y) <= x && $_and(t, x, y) <= y);
axiom (forall t:$ctype, x: int, y: int :: { $_or(t, x, y) } 0 <= x && 0 <= y && $in_range_t(t, x) && $in_range_t(t, y) ==> 0 <= $_or(t, x, y) && $_or(t, x, y) <= x + y);
axiom (forall t:$ctype, x: int, y: int :: { $_or(t, x, y) } 0 <= x && 0 <= y && $in_range_t(t, x) && $in_range_t(t, y) ==> x <= $_or(t, x, y) && y <= $_or(t, x, y));
axiom (forall t:$ctype, x: int, y: int, z: int :: { $_or(t, x,y), $_pow2(z) } 
  0 <= x && 0 <= y && 0 <= z && z < 64 && x < $_pow2(z) && y < $_pow2(z) && $in_range_t(t, x) && $in_range_t(t, y) ==> $_or(t, x, y) < $_pow2(z) );

axiom (forall t:$ctype, x: int, y: int :: { $_or(t, x, y) } $in_range_u1(x) && $in_range_u1(y) ==> $in_range_u1($_or(t, x, y)));
axiom (forall t:$ctype, x: int, y: int :: { $_or(t, x, y) } $in_range_u2(x) && $in_range_u2(y) ==> $in_range_u2($_or(t, x, y)));
axiom (forall t:$ctype, x: int, y: int :: { $_or(t, x, y) } $in_range_u4(x) && $in_range_u4(y) ==> $in_range_u4($_or(t, x, y)));
axiom (forall t:$ctype, x: int, y: int :: { $_or(t, x, y) } $in_range_u8(x) && $in_range_u8(y) ==> $in_range_u8($_or(t, x, y)));

axiom (forall t:$ctype, x: int, y: int :: { $_and(t, x, y) } $in_range_u1(x) && $in_range_u1(y) ==> $in_range_u1($_and(t, x, y)));
axiom (forall t:$ctype, x: int, y: int :: { $_and(t, x, y) } $in_range_u2(x) && $in_range_u2(y) ==> $in_range_u2($_and(t, x, y)));
axiom (forall t:$ctype, x: int, y: int :: { $_and(t, x, y) } $in_range_u4(x) && $in_range_u4(y) ==> $in_range_u4($_and(t, x, y)));
axiom (forall t:$ctype, x: int, y: int :: { $_and(t, x, y) } $in_range_u8(x) && $in_range_u8(y) ==> $in_range_u8($_and(t, x, y)));

axiom (forall t:$ctype, x: int, y: int :: { $_xor(t, x, y) } $in_range_u1(x) && $in_range_u1(y) ==> $in_range_u1($_xor(t, x, y)));
axiom (forall t:$ctype, x: int, y: int :: { $_xor(t, x, y) } $in_range_u2(x) && $in_range_u2(y) ==> $in_range_u2($_xor(t, x, y)));
axiom (forall t:$ctype, x: int, y: int :: { $_xor(t, x, y) } $in_range_u4(x) && $in_range_u4(y) ==> $in_range_u4($_xor(t, x, y)));
axiom (forall t:$ctype, x: int, y: int :: { $_xor(t, x, y) } $in_range_u8(x) && $in_range_u8(y) ==> $in_range_u8($_xor(t, x, y)));

axiom (forall t:$ctype, x: int :: { $_not(t, x) }  $in_range_t(t, $_not(t, x)));

//axiom (forall t:$ctype, x: int :: { $_not(t, x) } $in_range_u4(x) ==> $in_range_u4($_not(t, x)));
//axiom (forall t:$ctype, x: int :: { $_not(t, x) } $in_range_u8(x) ==> $in_range_u8($_not(t, x)));

axiom (forall t:$ctype, x: int :: { $_or(t, x, $_not(t, x)) }  $_or(t, x, $_not(t, x)) == $_not(t, 0));
axiom (forall t:$ctype, x: int :: { $_and(t, x, $_not(t, x)) }  $_and(t, x, $_not(t, x)) == 0);
axiom (forall t:$ctype, x: int :: { $_or(t, x, 0) }  $in_range_t(t, x) ==> $_or(t, x, 0) == x);
axiom (forall t:$ctype, x: int :: { $_or(t, x, $_not(t, 0)) }  $_or(t, x, $_not(t, 0)) == $_not(t, 0));
axiom (forall t:$ctype, x: int :: { $_or(t, x, x) } $in_range_t(t, x) ==>  $_or(t, x, x) == x);
axiom (forall t:$ctype, x: int :: { $_and(t, x, 0) }  $_and(t, x, 0) == 0);
axiom (forall t:$ctype, x: int :: { $_and(t, x, $_not(t, 0)) } $in_range_t(t, x) ==>  $_and(t, x, $_not(t, 0)) == x);
axiom (forall t:$ctype, x: int :: { $_and(t, x, x) } $in_range_t(t, x) ==> $_and(t, x,x) == x);
axiom (forall t:$ctype, x: int, y: int :: { $_and(t, $_or(t, x, y), y) } $_and(t, $_or(t, x, y), y) == y);
axiom (forall t:$ctype, x: int, y: int :: { $_and(t, $_or(t, x, y), x) } $_and(t, $_or(t, x, y), x) == x);
axiom (forall t:$ctype, x: int :: { $_xor(t, x, 0) }  $in_range_t(t, x) ==> $_xor(t, x, 0) == x);
axiom (forall t:$ctype, x: int :: { $_xor(t, x, x) }  $_xor(t, x, x) == 0);
axiom (forall t:$ctype, x: int :: { $_xor(t, x, $_not(t, 0)) }  $_xor(t, x, $_not(t, 0)) == $_not(t, x));
axiom (forall t:$ctype, x: int :: { $_not(t, $_not(t, x)) }  $in_range_t(t, x) ==> $_not(t, $_not(t, x)) == x);
axiom (forall t:$ctype, x: int, y: int :: { $_or(t, x, y) } $_or(t, x, y) == $_or(t, y, x));
axiom (forall t:$ctype, x: int, y: int :: { $_xor(t, x, y) } $_xor(t, x, y) == $_xor(t, y, x));
axiom (forall t:$ctype, x: int, y: int :: { $_and(t, x, y) } $_and(t, x, y) == $_and(t, y, x));
  

// extra function symbol for multiplication to prevent z3 from applying commutativity half-heartedly
function {:weight 0} $op_mul(x:int, y:int) returns (int) { x * y }

// extra function symbols for arithmetic operations to allow triggering and congruence closure on
// arithmetic expressions - use of these in the generated Boogie has to be requeste explicitly

function {:weight 0} $op_add(t:$ctype, x:int, y:int) returns (int) { x + y }
function {:weight 0} $op_sub(t:$ctype, x:int, y:int) returns (int) { x - y }
function {:weight 0} $op_div(t:$ctype, x:int, y:int) returns (int) { x div y }
function {:weight 0} $op_lt(t:$ctype, x:int, y:int) returns (bool) { x < y }
function {:weight 0} $op_le(t:$ctype, x:int, y:int) returns (bool) { x <= y }
function {:weight 0} $op_gt(t:$ctype, x:int, y:int) returns (bool) { x > y }
function {:weight 0} $op_ge(t:$ctype, x:int, y:int) returns (bool) { x >= y }

// --------------------------------------------------------------------------------
// Strings
// --------------------------------------------------------------------------------

function $get_string_literal(id:int, length:int) returns($ptr);
axiom (forall id:int, length:int :: {$get_string_literal(id, length)} $is($get_string_literal(id, length), ^^u1));
axiom (forall id:int, length:int, S:$state :: 
  {$typed(S, $get_string_literal(id, length))}
  {$is_array(S, $get_string_literal(id, length), ^^u1, length)}
  $good_state(S) ==>
    $typed(S, $get_string_literal(id, length)) &&
    $is_thread_local_array(S, $get_string_literal(id, length), ^^u1, length));

// --------------------------------------------------------------------------------
// Function pointers
// --------------------------------------------------------------------------------

function $get_fnptr(no:int, t:$ctype) returns($ptr)
  { $ptr(t, $get_fnptr_ref(no)) }


function $get_fnptr_ref(no:int) returns(int);
function $get_fnptr_inv(rf:int) returns(int);

axiom (forall no:int :: $get_fnptr_inv($get_fnptr_ref(no)) == no);
//axiom (forall rf:int :: $get_fnptr_ref($get_fnptr_rev(rf)) == rf);

axiom (forall S:$state, no:int, t:$ctype :: 
  {$ts(S, $get_fnptr(no, t))} {$st(S, $get_fnptr(no, t))}
  $is_fnptr_type(t) &&
  $good_state(S) ==> $mutable(S, $get_fnptr(no, t)));

function $is_fnptr_type(t:$ctype) returns(bool);
function $is_math_type(t:$ctype) returns(bool);
axiom (forall t:$ctype :: {$is_math_type(t)} $is_math_type(t) ==> $is_primitive(t));
axiom (forall t:$ctype :: {$is_fnptr_type(t)} $is_fnptr_type(t) ==> $is_primitive(t));



// --------------------------------------------------------------------------------
// Claims
// --------------------------------------------------------------------------------

function $claims_obj(claim:$ptr, obj:$ptr) returns(bool);
function $valid_claim(S:$state, claim:$ptr) returns(bool);

axiom (forall S:$state, c:$ptr :: {$full_stop(S), $valid_claim(S, c)}
  $full_stop(S) && $closed(S, c) ==> $valid_claim(S, c));

axiom (forall S:$state, c:$ptr :: {$valid_claim(S, c)}
  $valid_claim(S, c) ==> $closed(S, c) && $invok_state(S));

function {:inline true} $claim_initial_assumptions(#s1:$state, c:$ptr, tok:$token) returns (bool)
  { $good_state_ext(tok, #s1) &&
    $closed_is_transitive(#s1) &&
    true
  }

function {:inline true} $claim_transitivity_assumptions(#s1:$state, #s2:$state, c:$ptr, tok:$token) returns (bool)
  { $full_stop_ext(tok, #s1) &&
    $good_state_ext(tok, #s2) &&
    $closed_is_transitive(#s1) &&
    $closed_is_transitive(#s2) &&
    $forall_inv2_when_closed(#s1, #s2) &&
    $valid_claim(#s1, c) &&
    $closed(#s2, c) &&
    true
    }

function {:inline true} $valid_claim_impl(S0:$state, S1:$state) returns(bool)
  { (forall r:int :: {$closed(S1, $ptr(^^claim, r))}
       $closed(S0, $ptr(^^claim, r)) && $closed(S1, $ptr(^^claim, r)) ==> $valid_claim(S1, $ptr(^^claim, r))) }

function $claims_claim(c1:$ptr, c2:$ptr) returns(bool);
axiom (forall c1:$ptr, c2:$ptr :: {$claims_claim(c1, c2)}
  $is(c1, ^^claim) && $is(c2, ^^claim) &&
  (forall S:$state :: $valid_claim(S, c1) ==> $closed(S, c2)) 
  ==>
  $claims_claim(c1, c2));

axiom (forall S:$state, c1:$ptr, c2:$ptr :: {$valid_claim(S, c1), $claims_claim(c1, c2)}
  $valid_claim(S, c1) && $claims_claim(c1, c2) ==> $valid_claim(S, c2));

axiom (forall S:$state, c:$ptr, o:$ptr ::
    {$closed(S, c), $claims_obj(c, o)}
    $good_state(S) ==>
      $claims_obj(c, o) && $closed(S, c) ==> $instantiate_ptrset($owns(S, o)) && $closed(S, o) && $ref_cnt(S, o) > 0);

axiom (forall S:$state, c:$ptr, o:$ptr ::
    {$valid_claim(S, c), $claims_obj(c, o)}
    $valid_claim(S, c) && $claims_obj(c, o) ==> $inv(S, o, $typ(o)));

axiom (forall S:$state, c:$ptr, r:int ::
    {$valid_claim(S, c), $claims_obj(c, $ptr(^^claim, r))}
    $valid_claim(S, c) && $claims_obj(c, $ptr(^^claim, r)) ==>
      $valid_claim(S, $ptr(^^claim, r)));

function {:weight 0} $not_shared(S:$state, p:$ptr) returns(bool)
  { $wrapped(S, p, $typ(p)) && (!$is_claimable($typ(p)) || $ref_cnt(S, p) == 0) }

function {:weight 0} $claimed_closed(s:$state, p:$ptr) returns(bool)
  { $closed(s, p) }

axiom (forall S:$state, p:$ptr :: {$invok_state(S), $claimed_closed(S, p)}
  $invok_state(S) && $claimed_closed(S, p) ==> $inv(S, p, $typ(p)));

// called at the beginning of an atomic block to simulate other threads
procedure $atomic_havoc();
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  ensures $writes_nothing(old($s), $s);

  ensures (forall p:$ptr, f:$field ::
    {$not_shared(old($s), p), $select.mem($memory($s), $dot(p, f))}
    $not_shared(old($s), p) ==> $mem_eq(old($s), $s, $dot(p, f)));
  ensures $timestamp_post_strict(old($s), $s);

const unique $no_claim : $ptr;
axiom $no_claim == $ptr(^^claim, 0);

procedure $alloc_claim() returns(#r:$ptr);
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  ensures $owns($s, #r) == $set_empty();
  ensures $memory($s) == $memory(old($s));
  ensures $typemap($s) == $typemap(old($s));
  ensures (forall p:$ptr :: {$st($s, p)}
    p == #r || $st_eq(old($s), $s, p));
  ensures $wrapped($s, #r, ^^claim);
  ensures $is_fresh(old($s), $s, #r);
  ensures $in_range_spec_ptr($ref(#r));
  ensures $ref_cnt($s, #r) == 0;
  ensures !$closed(old($s), #r) && $owner(old($s), #r) != $me();
  ensures $timestamp_post_strict(old($s), $s);
  ensures #r != $no_claim;

// FIXME should it havoc non thread local state?
procedure $unclaim(c:$ptr);
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  // TOKEN: the claim is wrapped
  requires $wrapped($s, c, ^^claim);
  // TOKEN: the claim has no outstanding references
  requires $ref_cnt($s, c) == 0;
  ensures (forall p:$ptr :: {$st($s, p)} $st_eq(old($s), $s, p) || p == c);
  ensures $typemap(old($s)) == $typemap($s);
  ensures $memory(old($s)) == $memory($s);
  ensures $timestamp_post(old($s), $s);
  ensures $good_state($s);
  ensures !$closed($s, c);

procedure $kill_claim(c:$ptr);
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  ensures (forall p:$ptr :: {$st($s, p)} $st_eq(old($s), $s, p) || p == c);
  ensures $typemap(old($s)) == $typemap($s);
  ensures $memory(old($s)) == $memory($s);
  ensures $timestamp_post(old($s), $s);
  ensures $good_state($s);
  ensures !$closed($s, c);

function $claims_upgrade(the_new:$ptr, the_old:$ptr) returns(bool)
  { (forall o:$ptr :: $claims_obj(the_old, o) ==> $claims_obj(the_new, o)) }

function {:weight 0} $ref_cnt(S:$state, p:$ptr) returns(int)
  { $st_ref_cnt($st(S, p)) }

function $is_claimable($ctype) returns(bool);
axiom $is_claimable(^^claim);

function $account_claim(S:$state, c:$ptr, o:$ptr) returns(bool)
  { $good_state(S) && $closed(S, c) && $claims_obj(c, o) }

function $claim_no(S:$state, o:$ptr, idx:int) returns($ptr);
function $claim_idx(o:$ptr, c:$ptr) returns(int);

axiom (forall S:$state, c:$ptr, o:$ptr :: {$account_claim(S, c, o)}
  $account_claim(S, c, o) ==>
    $claim_no(S, o, $claim_idx(o, c)) == c &&
    0 <= $claim_idx(o, c) && $claim_idx(o, c) < $ref_cnt(S, o));
    

// --------------------------------------------------------------------------------
// Frame axiom ordering
// --------------------------------------------------------------------------------

function $frame_level($pure_function) returns(int);
const $current_frame_level : int;

// assumed at the beginning of all ``normal'' functions (i.e., not frame axiom read checks)
// the $state is there only as a placeholder
function {:inline true} $can_use_all_frame_axioms(s:$state) returns(bool)
  { (forall f:$pure_function :: {$frame_level(f)} $frame_level(f) < $current_frame_level) }

function {:inline true} $can_use_frame_axiom_of(f:$pure_function) returns(bool)
  { $frame_level(f) < $current_frame_level }

// and the same for pure function postcondition checking

function $pure_post_level($pure_function) returns(int);
const $current_pure_post_level : int;

function {:inline true} $can_use_all_pure_post_axioms(s:$state) returns(bool)
  { (forall f:$pure_function :: {$frame_level(f)} $pure_post_level(f) < $current_frame_level) }

function {:inline true} $can_use_pure_post_axiom_of(f:$pure_function) returns(bool)
  { $pure_post_level(f) < $current_pure_post_level }


// reads checking

function $reads_check_pre(s:$state) returns(bool);
function $reads_check_post(s:$state) returns(bool);
procedure $reads_havoc();
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  // TOKEN: called nothing before reads_havoc()
  requires $reads_check_pre($s);
  ensures $reads_check_post($s);
  ensures $call_transition(old($s), $s);


function $start_here() returns(bool);

// --------------------------------------------------------------------------------
// Conversion functions
// --------------------------------------------------------------------------------

function $ptrset_to_int($ptrset) returns(int);
function $int_to_ptrset(int) returns($ptrset);
axiom (forall p:$ptrset :: $int_to_ptrset($ptrset_to_int(p)) == p);

function $version_to_int($version) returns(int);
function $int_to_version(int) returns($version);
axiom (forall p:$version :: $int_to_version($version_to_int(p)) == p);

function $vol_version_to_int($vol_version) returns(int);
function $int_to_vol_version(int) returns($vol_version);
axiom (forall p:$vol_version :: $int_to_vol_version($vol_version_to_int(p)) == p);

function $ptr_to_int($ptr) returns(int);
function $int_to_ptr(int) returns($ptr);
axiom (forall p:$ptr :: $int_to_ptr($ptr_to_int(p)) == p);

// --------------------------------------------------------------------------------
// Skinny writes
// --------------------------------------------------------------------------------

function $precise_test($ptr) returns(bool);

function $updated_only_values(S1:$state, S2:$state, W:$ptrset) returns(bool);
function $updated_only_domains(S1:$state, S2:$state, W:$ptrset) returns(bool);

axiom (forall S1:$state, S2:$state, W:$ptrset ::
  {$updated_only_values(S1, S2, W)}
  (forall p:$ptr :: {$dont_instantiate(p)}
    ($is_primitive($typ(p)) || $is_non_primitive($typ(p))) ==>
      $typed(S1, p) && !$irrelevant(S1, p) ==> $mem_eq(S1, S2, p) || $set_in(p, W))
  ==> $updated_only_values(S1, S2, W));

axiom (forall S1:$state, S2:$state, W:$ptrset ::
  {$updated_only_domains(S1, S2, W)}
  (forall p:$ptr :: {$dont_instantiate(p)}
    $set_in(p, W) && !$is_primitive_ch($typ(p)) ==>
      $mem_eq(S1, S2, p) || $domain_updated_at(S1, S2, p, W))
  ==> $updated_only_domains(S1, S2, W));

/*
function $version_store(v:$version, W:$ptrset) returns($version);
axiom (forall v:$version, p:$ptr, W:$ptrset :: {$fetch_from_domain($version_store(v, W), p)}
   $is_primitive_ch($typ(p)) && !$set_in(p, W) ==>
     $fetch_from_domain($version_store(v, W), p) == $fetch_from_domain(v, p));

axiom (forall v:$version, W1:$ptrset, W2:$ptrset :: 
  {$version_store($version_store(v, W1), W2), $version_store(v, $set_union(W1, W2)) }
  $version_store($version_store(v, W1), W2) == $version_store(v, $set_union(W1, W2)));
*/

function $domain_updated_at(S1:$state, S2:$state, p:$ptr, W:$ptrset) returns(bool)
  { (forall q:$ptr :: {$fetch_from_domain($read_version(S2, p), q)}
       $is_primitive_ch($typ(q)) && !$set_in(q, W) ==>
         $fetch_from_domain($read_version(S1, p), q) ==
         $fetch_from_domain($read_version(S2, p), q)) &&
    $domain(S1, p) == $domain(S2, p) }

// --------------------------------------------------------------------------------
// Floating point arithmetic - currently uninterpreted
// --------------------------------------------------------------------------------

function $add_f4(x:$primitive, y:$primitive) returns($primitive);
function $sub_f4(x:$primitive, y:$primitive) returns($primitive);
function $mul_f4(x:$primitive, y:$primitive) returns($primitive);
function $div_f4(x:$primitive, y:$primitive) returns($primitive);
function $neg_f4(x:$primitive) returns($primitive);
function $lt_f4(x:$primitive, y:$primitive) returns(bool);
function $leq_f4(x:$primitive, y:$primitive) returns(bool);
function $gt_f4(x:$primitive, y:$primitive) returns(bool);
function $geq_f4(x:$primitive, y:$primitive) returns(bool);
function $add_f8(x:$primitive, y:$primitive) returns($primitive);
function $sub_f8(x:$primitive, y:$primitive) returns($primitive);
function $mul_f8(x:$primitive, y:$primitive) returns($primitive);
function $div_f8(x:$primitive, y:$primitive) returns($primitive);
function $neg_f8(x:$primitive) returns($primitive);
function $lt_f8(x:$primitive, y:$primitive) returns(bool);
function $leq_f8(x:$primitive, y:$primitive) returns(bool);
function $gt_f8(x:$primitive, y:$primitive) returns(bool);
function $geq_f8(x:$primitive, y:$primitive) returns(bool);

// --------------------------------------------------------------------------------
// Information flow types and functions
// --------------------------------------------------------------------------------

// Individual labels
  // Boolean instantiation
  type $seclabel = bool;

  const $seclbl.top: $seclabel;
  axiom $seclbl.top == true;
  const $seclbl.bot: $seclabel;
  axiom $seclbl.bot == false;

  function {:inline true} $seclbl.leq(l1:$seclabel, l2:$seclabel) returns(bool)
    { l1 ==> l2 }

  function {:inline true} $seclbl.meet(l1:$seclabel, l2:$seclabel) returns($seclabel)
    { l1 && l2 }
  function {:inline true} $seclbl.join(l1:$seclabel, l2:$seclabel) returns($seclabel)
    { l1 || l2 }

// Label sets
  // Generic type and operations
  type $labelset = [$ptr] $seclabel;

  const $lblset.top: $labelset;
  axiom(forall p:$ptr :: $lblset.top[p] == $seclbl.top);
  const $lblset.bot: $labelset;
  axiom(forall p:$ptr ::$lblset.bot[p] == $seclbl.bot);

  function {:inline true} $lblset.leq(l1:$labelset, l2:$labelset) returns(bool)
    { (forall p:$ptr :: $seclbl.leq(l1[p], l2[p])) }

  function $lblset.meet($labelset, $labelset) returns($labelset);
  axiom(forall l1,l2:$labelset, p:$ptr :: $lblset.meet(l1,l2)[p] == $seclbl.meet(l1[p], l2[p]));

  function $lblset.join($labelset, $labelset) returns($labelset);
  axiom(forall l1,l2:$labelset, p:$ptr :: $lblset.join(l1,l2)[p] == $seclbl.join(l1[p], l2[p]));

  // Labels and meta-labels of memory locations (we want them in $memory so they get havoc()-ed at the same time as the memory locations they correspond to)
  type $flowdata;

  function $select.flow.label($flowdata) returns($labelset);
  function $store.flow.label($flowdata, $labelset) returns($flowdata);
  function $select.flow.meta($flowdata) returns($labelset);
  function $store.flow.meta($flowdata, $labelset) returns($flowdata);

  axiom(forall fd:$flowdata, l:$labelset :: {:weight 0}
    $select.flow.label($store.flow.label(fd, l)) == l);
  axiom(forall fd:$flowdata, l:$labelset :: {:weight 0} 
    $select.flow.meta($store.flow.meta(fd, l)) == l);
  axiom(forall fd:$flowdata, l:$labelset :: {:weight 0}
    $select.flow.label($store.flow.meta(fd, l)) == $select.flow.label(fd));
  axiom(forall fd:$flowdata, l:$labelset :: {:weight 0}
    $select.flow.meta($store.flow.label(fd, l)) == $select.flow.meta(fd));

  function $select.flow.data($memory_t, $ptr) returns($flowdata);
  function $store.flow.data($memory_t, $ptr, $flowdata) returns($memory_t);

  axiom(forall M:$memory_t, p,q:$ptr, fd:$flowdata :: {:weight 0}
    $in_full_extent_of(q, p) ==> $select.flow.data($store.flow.data(M, p, fd), q) == fd);
  axiom(forall M:$memory_t, p,q:$ptr, fd:$flowdata :: {:weight 0}
        $in_full_extent_of(q, p)
      ||
      $select.flow.data($store.flow.data(M, p, fd), q) == $select.flow.data(M, q));

  // Program Context (is a top-level state member)
  function $select.sec.pc($state) returns($labelset);

// Test classifiers
  // Default classifier
  type $map_t..$ptr_to..^^void.^^bool;

  function $select.$map_t..$ptr_to..^^void.^^bool(M: $map_t..$ptr_to..^^void.^^bool, p: $ptr) : bool;
  function $store.$map_t..$ptr_to..^^void.^^bool(M: $map_t..$ptr_to..^^void.^^bool, p: $ptr, v: bool) : $map_t..$ptr_to..^^void.^^bool;
  function $eq.$map_t..$ptr_to..^^void.^^bool(M1: $map_t..$ptr_to..^^void.^^bool, M2: $map_t..$ptr_to..^^void.^^bool) : bool;

  const $zero.$map_t..$ptr_to..^^void.^^bool: $map_t..$ptr_to..^^void.^^bool;

  axiom (forall M: $map_t..$ptr_to..^^void.^^bool, p: $ptr, v: bool :: {:weight 0} $select.$map_t..$ptr_to..^^void.^^bool($store.$map_t..$ptr_to..^^void.^^bool(M, p, v), p) == v);
  axiom (forall M: $map_t..$ptr_to..^^void.^^bool, p: $ptr, v: bool, q: $ptr :: {:weight 0} p != q ==> $select.$map_t..$ptr_to..^^void.^^bool($store.$map_t..$ptr_to..^^void.^^bool(M, q, v), p) == $select.$map_t..$ptr_to..^^void.^^bool(M, p));
  axiom (forall M1: $map_t..$ptr_to..^^void.^^bool, M2: $map_t..$ptr_to..^^void.^^bool :: {:weight 0} { $eq.$map_t..$ptr_to..^^void.^^bool(M1, M2) } (forall p: $ptr :: {:weight 0} $select.$map_t..$ptr_to..^^void.^^bool(M1, p) == $select.$map_t..$ptr_to..^^void.^^bool(M2, p)) ==> $eq.$map_t..$ptr_to..^^void.^^bool(M1, M2));
  axiom (forall M1: $map_t..$ptr_to..^^void.^^bool, M2: $map_t..$ptr_to..^^void.^^bool :: {:weight 0} { $eq.$map_t..$ptr_to..^^void.^^bool(M1, M2) } $eq.$map_t..$ptr_to..^^void.^^bool(M1, M2) ==> M1 == M2);
  axiom $int_to_map_t..ptr_to..^^void.^^bool(0) == $zero.$map_t..$ptr_to..^^void.^^bool;
  axiom (forall p: $ptr :: {:weight 0} $select.$map_t..$ptr_to..^^void.^^bool($zero.$map_t..$ptr_to..^^void.^^bool, p) == false);
  axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: {:weight 0} { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t($ptr_to(^^void), ^^bool)) } $eq.$map_t..$ptr_to..^^void.^^bool($int_to_map_t..ptr_to..^^void.^^bool($rec_fetch(r1, f)), $int_to_map_t..ptr_to..^^void.^^bool($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

  function $map_t..ptr_to..^^void.^^bool_to_int(x: $map_t..$ptr_to..^^void.^^bool) : int;
  function $int_to_map_t..ptr_to..^^void.^^bool(x: int) : $map_t..$ptr_to..^^void.^^bool;
  axiom (forall #x: $map_t..$ptr_to..^^void.^^bool :: #x == $int_to_map_t..ptr_to..^^void.^^bool($map_t..ptr_to..^^void.^^bool_to_int(#x)));

  function #classifier#default() : $map_t..$ptr_to..^^void.^^bool;

  const unique cf#classifier#default: $pure_function;
  axiom $function_arg_type(cf#classifier#default, 0, $map_t($ptr_to(^^void), ^^bool));
  axiom (forall p: $ptr :: { $select.$map_t..$ptr_to..^^void.^^bool(#classifier#default(), p) } $select.$map_t..$ptr_to..^^void.^^bool(#classifier#default(), p) == false);

  procedure classifier#default() returns ($result: $map_t..$ptr_to..^^void.^^bool);
    ensures $result == #classifier#default();
    free ensures $call_transition(old($s), $s);

// Pointer clubs
  // Generic type and operations
  type $ptrclub;
  const $ptrclub.empty: [$ptr] bool;
  axiom(forall p: $ptr :: $ptrclub.empty[p] == false);

  function is_active_ptrclub(c: $ptrclub) returns(bool);

  function $ptrclub.construct(c: [$ptr] bool, l: $labelset) returns($ptrclub);
  function $ptrclub.members(c: $ptrclub) returns([$ptr] bool);
  function $ptrclub.bound(c: $ptrclub) returns($labelset);
  function $ptrclub.addMember(p: $ptr, c: $ptrclub) returns($ptrclub);
  function {:inline true} $ptrclub.isMember(p: $ptr, c: $ptrclub) returns(bool)
    { $ptrclub.members(c)[p] }
  
  axiom(forall c: [$ptr] bool, l: $labelset :: {:weight 0}
    $ptrclub.members($ptrclub.construct(c, l)) == c);
  axiom(forall c: [$ptr] bool, l: $labelset :: {:weight 0}
    $ptrclub.bound($ptrclub.construct(c, l)) == l);

  axiom(forall c: $ptrclub, p: $ptr :: {:weight 0}
       $ptrclub.members($ptrclub.addMember(p, c))
    == $ptrclub.members(c)[p := true]);
  axiom(forall c: $ptrclub, p: $ptr :: {:weight 0}
    $ptrclub.bound($ptrclub.addMember(p,c)) == $ptrclub.bound(c));

  function $ptrclub.compare($ptr, $ptr) returns($labelset);
  axiom(forall p1,p2: $ptr :: $ptr_eq(p1, p2) ==> $lblset.leq($ptrclub.compare(p1, p2), $lblset.bot));	// If the pointers are provably equal, we don't even bother computing a lub
  axiom(forall p1,p2:$ptr, c:$ptrclub :: $ptrclub.isMember(p1, c) && $ptrclub.isMember(p2,c) && is_active_ptrclub(c)
                                               ==> $lblset.leq($ptrclub.compare(p1,p2), $ptrclub.bound(c)));	// The comparison label is a lower bound
  // And we shouldn't need the fact that the glb is the greatest lower bound

// No interaction between memory and labels, and the various kinds of labels
axiom (forall M:$memory_t, p:$ptr, q:$ptr, v:int :: {:weight 0}
  $select.flow.data($store.mem(M,q,v), p) == $select.flow.data(M, p));
axiom (forall M:$memory_t, p:$ptr, q:$ptr, fd:$flowdata :: {:weight 0}
  $select.mem($store.flow.data(M,q,fd), p) == $select.mem(M, p));

procedure $store_flow_data(p:$ptr, fd:$flowdata);
  modifies $s;
  ensures $select.sec.pc($s) == $select.sec.pc(old($s));
  ensures $typemap($s) == $typemap(old($s));
  ensures $statusmap($s) == $statusmap(old($s));
  ensures $memory($s) == $store.flow.data($memory(old($s)), p, fd);
  ensures $timestamp_post_strict(old($s), $s);

procedure $store_sec_pc(l:$labelset);
  modifies $s;
  ensures $typemap($s) == $typemap(old($s));
  ensures $statusmap($s) == $statusmap(old($s));
  ensures $memory($s) == $memory(old($s));
  ensures $select.sec.pc($s) == l;
  ensures $timestamp_post_strict(old($s), $s);

// --------------------------------------------------------------------------------
// Counter Example Visualizer things
// --------------------------------------------------------------------------------

type cf_event;
type var_locglob;

const unique conditional_moment : cf_event;
const unique took_then_branch : cf_event;
const unique took_else_branch : cf_event;

const unique loop_register : cf_event;
const unique loop_entered : cf_event;
const unique loop_exited : cf_event;

const unique cev_local : var_locglob;
const unique cev_global : var_locglob;
const unique cev_parameter : var_locglob;
const unique cev_implicit : var_locglob;

function #cev_init(n:int) returns(bool);
function #cev_save_position(n:int) returns($token);
function #cev_var_intro(n:int, locorglob:var_locglob, name:$token, val:int, typ: $ctype) returns(bool);
function #cev_var_update(n:int, locorglob:var_locglob, name:$token, val:int) returns(bool);
function #cev_control_flow_event(n:int, tag : cf_event) returns(bool);
function #cev_function_call(n:int) returns(bool);

var $cev_pc : int;

procedure $cev_step(pos: $token);
  modifies $cev_pc;
  ensures #cev_save_position(old($cev_pc)) == pos;
  ensures $cev_pc == old($cev_pc) + 1;

procedure $cev_pre_loop(pos: $token) returns (oldPC: int);
  modifies $cev_pc;
  ensures #cev_control_flow_event(old($cev_pc), conditional_moment);
  ensures #cev_save_position(old($cev_pc)) == pos;
  ensures oldPC == old($cev_pc) && $cev_pc == old($cev_pc) + 1;

// That's all folks.


axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^Node: $ctype;

axiom $is_composite(^Node);

axiom $ptr_level(^Node) == 0;

axiom $sizeof(^Node) == 40;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Node) } $inv2(#s1, #s2, #p, ^Node) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty())));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^Node, #r), l#public) } $inv_lab(#s2, $ptr(^Node, #r), l#public) == ($typed(#s2, $ptr(^Node, #r)) && $set_eq($owns(#s2, $ptr(^Node, #r)), $set_empty())));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^Node, #r)) } $in_full_extent_of(#q, $ptr(^Node, #r)) == (#q == $ptr(^Node, #r) || #q == $dot($ptr(^Node, #r), Node.$owns) || #q == $dot($ptr(^Node, #r), Node.red) || #q == $dot($ptr(^Node, #r), Node.key) || #q == $dot($ptr(^Node, #r), Node.value) || #q == $dot($ptr(^Node, #r), Node.left) || #q == $dot($ptr(^Node, #r), Node.right) || #q == $dot($ptr(^Node, #r), Node.parent)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Node, #r)) } $in_extent_of(#s, #q, $ptr(^Node, #r)) == $in_struct_extent_of(#q, $ptr(^Node, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Node, #r)) } $typed(#s, $ptr(^Node, #r)) ==> $in_extent_of(#s, #q, $ptr(^Node, #r)) == (#q == $ptr(^Node, #r) || $emb(#s, #q) == $ptr(^Node, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^Node, #r)) } $in_span_of(#q, $ptr(^Node, #r)) == (#q == $ptr(^Node, #r) || #q == $dot($ptr(^Node, #r), Node.$owns) || #q == $dot($ptr(^Node, #r), Node.red) || #q == $dot($ptr(^Node, #r), Node.key) || #q == $dot($ptr(^Node, #r), Node.value) || #q == $dot($ptr(^Node, #r), Node.left) || #q == $dot($ptr(^Node, #r), Node.right) || #q == $dot($ptr(^Node, #r), Node.parent)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^Node) } $state_spans_the_same(#s1, #s2, #p, ^Node) == ($mem_eq(#s1, #s2, $dot(#p, Node.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Node.red)) && $mem_eq(#s1, #s2, $dot(#p, Node.key)) && $mem_eq(#s1, #s2, $dot(#p, Node.value)) && $mem_eq(#s1, #s2, $dot(#p, Node.left)) && $mem_eq(#s1, #s2, $dot(#p, Node.right)) && $mem_eq(#s1, #s2, $dot(#p, Node.parent))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Node) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Node) == ($mem_eq(#s1, #s2, $dot(#p, Node.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Node.red)) && $mem_eq(#s1, #s2, $dot(#p, Node.key)) && $mem_eq(#s1, #s2, $dot(#p, Node.value)) && $mem_eq(#s1, #s2, $dot(#p, Node.left)) && $mem_eq(#s1, #s2, $dot(#p, Node.right)) && $mem_eq(#s1, #s2, $dot(#p, Node.parent))));

axiom $is_claimable(^Node) == false;

axiom $has_volatile_owns_set(^Node) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^Node, #r)) } $extent_mutable(#s1, $ptr(^Node, #r)) == $mutable(#s1, $ptr(^Node, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^Node, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^Node, #r)) == $is_fresh(#s1, #s2, $ptr(^Node, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^Node, #r)) } $extent_zero(#s1, $ptr(^Node, #r)) == ($mem(#s1, $dot($ptr(^Node, #r), Node.red)) == 0 && $mem(#s1, $dot($ptr(^Node, #r), Node.key)) == 0 && $mem(#s1, $dot($ptr(^Node, #r), Node.value)) == 0 && $mem(#s1, $dot($ptr(^Node, #r), Node.left)) == 0 && $mem(#s1, $dot($ptr(^Node, #r), Node.right)) == 0 && $mem(#s1, $dot($ptr(^Node, #r), Node.parent)) == 0));

const unique Node.$owns: $field;

axiom $static_field_properties(Node.$owns, ^Node);

axiom $is_primitive_non_volatile_field(Node.$owns);

axiom (forall #p: $ptr :: { $dot(#p, Node.$owns) } $is(#p, ^Node) ==> $dot(#p, Node.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, Node.$owns)) && $extent_hint($dot(#p, Node.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.$owns)) } { $st(#s, $dot(#p, Node.$owns)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.$owns, ^$#ptrset, false));

axiom $owns_set_field(^Node) == Node.$owns;

const unique Node.red: $field;

axiom $static_field_properties(Node.red, ^Node);

axiom $is_primitive_non_volatile_field(Node.red);

axiom $field_offset(Node.red) == 0;

axiom (forall #p: $ptr :: { $dot(#p, Node.red) } $is(#p, ^Node) ==> $dot(#p, Node.red) == $ptr(^^bool, $ref(#p) + 0) && $extent_hint($dot(#p, Node.red), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.red)) } { $st(#s, $dot(#p, Node.red)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.red, ^^bool, false));

const unique Node.key: $field;

axiom $static_field_properties(Node.key, ^Node);

axiom $is_primitive_non_volatile_field(Node.key);

axiom $field_offset(Node.key) == 4;

axiom (forall #p: $ptr :: { $dot(#p, Node.key) } $is(#p, ^Node) ==> $dot(#p, Node.key) == $ptr(^^i4, $ref(#p) + 4) && $extent_hint($dot(#p, Node.key), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.key)) } { $st(#s, $dot(#p, Node.key)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.key, ^^i4, false));

const unique Node.value: $field;

axiom $static_field_properties(Node.value, ^Node);

axiom $is_primitive_non_volatile_field(Node.value);

axiom $field_offset(Node.value) == 8;

axiom (forall #p: $ptr :: { $dot(#p, Node.value) } $is(#p, ^Node) ==> $dot(#p, Node.value) == $ptr(^^i4, $ref(#p) + 8) && $extent_hint($dot(#p, Node.value), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.value)) } { $st(#s, $dot(#p, Node.value)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.value, ^^i4, false));

const unique Node.left: $field;

axiom $static_field_properties(Node.left, ^Node);

axiom $is_primitive_non_volatile_field(Node.left);

axiom $field_offset(Node.left) == 16;

axiom (forall #p: $ptr :: { $dot(#p, Node.left) } $is(#p, ^Node) ==> $dot(#p, Node.left) == $ptr($ptr_to(^Node), $ref(#p) + 16) && $extent_hint($dot(#p, Node.left), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.left)) } { $st(#s, $dot(#p, Node.left)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.left, $ptr_to(^Node), false));

const unique Node.right: $field;

axiom $static_field_properties(Node.right, ^Node);

axiom $is_primitive_non_volatile_field(Node.right);

axiom $field_offset(Node.right) == 24;

axiom (forall #p: $ptr :: { $dot(#p, Node.right) } $is(#p, ^Node) ==> $dot(#p, Node.right) == $ptr($ptr_to(^Node), $ref(#p) + 24) && $extent_hint($dot(#p, Node.right), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.right)) } { $st(#s, $dot(#p, Node.right)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.right, $ptr_to(^Node), false));

const unique Node.parent: $field;

axiom $static_field_properties(Node.parent, ^Node);

axiom $is_primitive_non_volatile_field(Node.parent);

axiom $field_offset(Node.parent) == 32;

axiom (forall #p: $ptr :: { $dot(#p, Node.parent) } $is(#p, ^Node) ==> $dot(#p, Node.parent) == $ptr($ptr_to(^Node), $ref(#p) + 32) && $extent_hint($dot(#p, Node.parent), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.parent)) } { $st(#s, $dot(#p, Node.parent)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.parent, $ptr_to(^Node), false));

const unique ^Tree: $ctype;

axiom $is_composite(^Tree);

axiom $ptr_level(^Tree) == 0;

axiom $sizeof(^Tree) == 8;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Tree) } $inv2(#s1, #s2, #p, ^Tree) == ($typed(#s2, #p) && !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr_cast($null, ^Node))) && ($ptr_neq($read_ptr(#s2, $dot(#p, Tree.root), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node)))) && ($ptr_neq($read_ptr(#s2, $dot(#p, Tree.root), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot(#p, Tree.root), ^Node), Node.parent), ^Node), $null)) && (forall Q#m$1^82.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($ptr_cast($null, ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1)))) && (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem(#s2, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) < $mem(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key))) && (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem(#s2, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) > $mem(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key))) && (forall Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } { F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1))) } { sk_hack(F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) == $set_in($ptr(^Node, Q#m$1^82.29#dt1), $owns(#s2, #p))) && (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1)))) && (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1)))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node)))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node)))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node)))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.left), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)) || $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.right), ^Node), $ptr(^Node, Q#n$1^82.29#dt1))) && (forall Q#n$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#n$1^82.29#dt1)))) && (forall Q#m$1^83.29#dt1: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem(#s2, $dot(#p, Tree.abs))), $mem(#s2, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem(#s2, $dot(#p, Tree.abs))), $mem(#s2, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) == $mem(#s2, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.value))) && (forall Q#k$1^83.29#tc2: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem(#s2, $dot(#p, Tree.abs))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $mem(#s2, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem(#s2, $dot(#p, Tree.abs))), Q#k$1^83.29#tc2) == 0) && (forall Q#n$1^84.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && $ptr_eq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) || $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $read_ptr(#s2, $dot(#p, Tree.root), ^Node))) && (forall Q#n$1^84.29#dt1: int, Q#m$1^84.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot(#p, Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && (($ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) && $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr_cast($null, ^Node))) || $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr(^Node, Q#n$1^84.29#dt1)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot(#p, Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))))))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^Tree, #r), l#public) } $inv_lab(#s2, $ptr(^Tree, #r), l#public) == ($typed(#s2, $ptr(^Tree, #r)) && !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr_cast($null, ^Node))) && ($ptr_neq($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node)))) && ($ptr_neq($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node), Node.parent), ^Node), $null)) && (forall Q#m$1^82.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($ptr_cast($null, ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1)))) && (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem(#s2, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) < $mem(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key))) && (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem(#s2, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) > $mem(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key))) && (forall Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } { F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1))) } { sk_hack(F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) == $set_in($ptr(^Node, Q#m$1^82.29#dt1), $owns(#s2, $ptr(^Tree, #r)))) && (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1)))) && (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1)))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node)))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node)))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node)))) && (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.left), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)) || $ptr_eq($read_ptr(#s2, $dot($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.right), ^Node), $ptr(^Node, Q#n$1^82.29#dt1))) && (forall Q#n$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#n$1^82.29#dt1)))) && (forall Q#m$1^83.29#dt1: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem(#s2, $dot($ptr(^Tree, #r), Tree.abs))), $mem(#s2, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem(#s2, $dot($ptr(^Tree, #r), Tree.abs))), $mem(#s2, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) == $mem(#s2, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.value))) && (forall Q#k$1^83.29#tc2: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem(#s2, $dot($ptr(^Tree, #r), Tree.abs))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $mem(#s2, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem(#s2, $dot($ptr(^Tree, #r), Tree.abs))), Q#k$1^83.29#tc2) == 0) && (forall Q#n$1^84.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && $ptr_eq($read_ptr(#s2, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) || $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))) && (forall Q#n$1^84.29#dt1: int, Q#m$1^84.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Tree, #r), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && (($ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) && $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr_cast($null, ^Node))) || $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr(^Node, Q#n$1^84.29#dt1)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(#s2, $dot($ptr(^Tree, #r), Tree.R))), $ref($read_ptr(#s2, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))))))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^Tree, #r)) } $in_full_extent_of(#q, $ptr(^Tree, #r)) == (#q == $ptr(^Tree, #r) || #q == $dot($ptr(^Tree, #r), Tree.$owns) || #q == $dot($ptr(^Tree, #r), Tree.root) || #q == $dot($ptr(^Tree, #r), Tree.abs) || #q == $dot($ptr(^Tree, #r), Tree.R)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Tree, #r)) } $in_extent_of(#s, #q, $ptr(^Tree, #r)) == $in_struct_extent_of(#q, $ptr(^Tree, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Tree, #r)) } $typed(#s, $ptr(^Tree, #r)) ==> $in_extent_of(#s, #q, $ptr(^Tree, #r)) == (#q == $ptr(^Tree, #r) || $emb(#s, #q) == $ptr(^Tree, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^Tree, #r)) } $in_span_of(#q, $ptr(^Tree, #r)) == (#q == $ptr(^Tree, #r) || #q == $dot($ptr(^Tree, #r), Tree.$owns) || #q == $dot($ptr(^Tree, #r), Tree.root) || #q == $dot($ptr(^Tree, #r), Tree.abs) || #q == $dot($ptr(^Tree, #r), Tree.R)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^Tree) } $state_spans_the_same(#s1, #s2, #p, ^Tree) == ($mem_eq(#s1, #s2, $dot(#p, Tree.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Tree.root)) && $mem_eq(#s1, #s2, $dot(#p, Tree.abs)) && $mem_eq(#s1, #s2, $dot(#p, Tree.R))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Tree) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Tree) == ($mem_eq(#s1, #s2, $dot(#p, Tree.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Tree.root)) && $mem_eq(#s1, #s2, $dot(#p, Tree.abs)) && $mem_eq(#s1, #s2, $dot(#p, Tree.R))));

axiom $is_claimable(^Tree) == false;

axiom $has_volatile_owns_set(^Tree) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^Tree, #r)) } $extent_mutable(#s1, $ptr(^Tree, #r)) == $mutable(#s1, $ptr(^Tree, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^Tree, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^Tree, #r)) == $is_fresh(#s1, #s2, $ptr(^Tree, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^Tree, #r)) } $extent_zero(#s1, $ptr(^Tree, #r)) == ($mem(#s1, $dot($ptr(^Tree, #r), Tree.root)) == 0 && $mem(#s1, $dot($ptr(^Tree, #r), Tree.abs)) == 0 && $mem(#s1, $dot($ptr(^Tree, #r), Tree.R)) == 0));

const unique Tree.$owns: $field;

axiom $static_field_properties(Tree.$owns, ^Tree);

axiom $is_primitive_non_volatile_field(Tree.$owns);

axiom (forall #p: $ptr :: { $dot(#p, Tree.$owns) } $is(#p, ^Tree) ==> $dot(#p, Tree.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, Tree.$owns)) && $extent_hint($dot(#p, Tree.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Tree.$owns)) } { $st(#s, $dot(#p, Tree.$owns)) } $typed2(#s, #p, ^Tree) ==> $field_properties(#s, #p, Tree.$owns, ^$#ptrset, false));

axiom $owns_set_field(^Tree) == Tree.$owns;

const unique Tree.root: $field;

axiom $static_field_properties(Tree.root, ^Tree);

axiom $is_primitive_non_volatile_field(Tree.root);

axiom $field_offset(Tree.root) == 0;

axiom (forall #p: $ptr :: { $dot(#p, Tree.root) } $is(#p, ^Tree) ==> $dot(#p, Tree.root) == $ptr($ptr_to(^Node), $ref(#p) + 0) && $extent_hint($dot(#p, Tree.root), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Tree.root)) } { $st(#s, $dot(#p, Tree.root)) } $typed2(#s, #p, ^Tree) ==> $field_properties(#s, #p, Tree.root, $ptr_to(^Node), false));

const unique Tree.abs: $field;

axiom $static_field_properties(Tree.abs, ^Tree);

axiom $is_primitive_non_volatile_field(Tree.abs);

axiom (forall #p: $ptr :: { $dot(#p, Tree.abs) } $is(#p, ^Tree) ==> $dot(#p, Tree.abs) == $ptr($map_t(^^i4, ^^i4), $ghost_ref(#p, Tree.abs)) && $extent_hint($dot(#p, Tree.abs), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Tree.abs)) } { $st(#s, $dot(#p, Tree.abs)) } $typed2(#s, #p, ^Tree) ==> $field_properties(#s, #p, Tree.abs, $map_t(^^i4, ^^i4), false));

const unique Tree.R: $field;

axiom $static_field_properties(Tree.R, ^Tree);

axiom $is_primitive_non_volatile_field(Tree.R);

axiom (forall #p: $ptr :: { $dot(#p, Tree.R) } $is(#p, ^Tree) ==> $dot(#p, Tree.R) == $ptr($map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)), $ghost_ref(#p, Tree.R)) && $extent_hint($dot(#p, Tree.R), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Tree.R)) } { $st(#s, $dot(#p, Tree.R)) } $typed2(#s, #p, ^Tree) ==> $field_properties(#s, #p, Tree.R, $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)), false));

procedure Tree#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr_cast($null, ^Node)));
  ensures $is_admissibility_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node)));
  ensures $is_admissibility_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node), Node.parent), ^Node), $null);
  ensures $is_admissibility_check() ==> (forall Q#m$1^82.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr_cast($null, ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) < $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) > $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
  ensures $is_admissibility_check() ==> (forall Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } { F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1))) } { sk_hack(F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) == $set_in($ptr(^Node, Q#m$1^82.29#dt1), $owns($s, $ptr(^Tree, P#_this_))));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node))));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node))));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node))));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.left), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)) || $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.right), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
  ensures $is_admissibility_check() ==> true;
  ensures $is_admissibility_check() ==> (forall Q#m$1^83.29#dt1: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#_this_), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#_this_), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) == $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.value)));
  ensures $is_admissibility_check() ==> (forall Q#k$1^83.29#tc2: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#_this_), Tree.abs))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#_this_), Tree.abs))), Q#k$1^83.29#tc2) == 0);
  ensures $is_admissibility_check() ==> (forall Q#n$1^84.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && $ptr_eq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) || $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node)));
  ensures $is_admissibility_check() ==> (forall Q#n$1^84.29#dt1: int, Q#m$1^84.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && (($ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) && $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr_cast($null, ^Node))) || $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr(^Node, Q#n$1^84.29#dt1)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))))));
  ensures $is_unwrap_check() ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr_cast($null, ^Node)));
  ensures $is_unwrap_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node)));
  ensures $is_unwrap_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node), Node.parent), ^Node), $null);
  ensures $is_unwrap_check() ==> (forall Q#m$1^82.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr_cast($null, ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) < $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) > $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
  ensures $is_unwrap_check() ==> (forall Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } { F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1))) } { sk_hack(F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) == $set_in($ptr(^Node, Q#m$1^82.29#dt1), $owns($s, $ptr(^Tree, P#_this_))));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node))));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node))));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node))));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.left), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)) || $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.right), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
  ensures $is_unwrap_check() ==> true;
  ensures $is_unwrap_check() ==> (forall Q#m$1^83.29#dt1: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#_this_), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#_this_), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) == $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.value)));
  ensures $is_unwrap_check() ==> (forall Q#k$1^83.29#tc2: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#_this_), Tree.abs))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#_this_), Tree.abs))), Q#k$1^83.29#tc2) == 0);
  ensures $is_unwrap_check() ==> (forall Q#n$1^84.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && $ptr_eq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) || $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node)));
  ensures $is_unwrap_check() ==> (forall Q#n$1^84.29#dt1: int, Q#m$1^84.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#_this_), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && (($ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) && $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr_cast($null, ^Node))) || $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr(^Node, Q#n$1^84.29#dt1)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#_this_), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))))));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Tree#adm(P#_this_: int)
{
  var #wrTime$1^77.31: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^77.31, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^77.31, #loc._this_, $ptr_to_int($ptr(^Tree, P#_this_)), $ptr_to(^Tree)) && $local_value_is_ptr($s, #tok$1^77.31, #loc._this_, $ptr(^Tree, P#_this_), $ptr_to(^Tree));
    assume #wrTime$1^77.31 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^77.31, #p) } $in_writes_at(#wrTime$1^77.31, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^Tree, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^Tree, P#_this_));
        assume $good_state_ext(#tok$1^77.31, $s);
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
            assume $admissibility_pre($s, $ptr(^Tree, P#_this_));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^Tree, P#_this_));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Tree*)@null))
        call $havoc_others($ptr(^Tree, P#_this_), ^Tree);
        assume $good_state_ext(#tok$1^77.31, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^Tree, P#_this_), ^Tree);
    }

  #exit:
}



function F#mark(SP#p: int) : int;

const unique cf#mark: $pure_function;

axiom (forall SP#p: int :: { F#mark(SP#p) } $ptr_eq($ptr(^Node, F#mark(SP#p)), $ptr(^Node, SP#p)));

axiom $function_arg_type(cf#mark, 0, $ptr_to(^Node));

axiom $function_arg_type(cf#mark, 1, $ptr_to(^Node));

procedure mark(SP#p: int) returns ($result: int);
  free ensures $in_range_phys_ptr($ref($ptr(^Node, $result)));
  ensures $ptr_eq($ptr(^Node, $result), $ptr(^Node, SP#p));
  free ensures $result == F#mark(SP#p);
  free ensures $call_transition(old($s), $s);



function F#doMark(SP#p: int) : bool;

const unique cf#doMark: $pure_function;

axiom (forall SP#p: int :: { F#doMark(SP#p) } F#doMark(SP#p) == $ptr_eq($ptr(^Node, F#mark($ref($ptr(^Node, SP#p)))), $ptr(^Node, SP#p)));

axiom $function_arg_type(cf#doMark, 0, ^^bool);

axiom $function_arg_type(cf#doMark, 1, $ptr_to(^Node));

procedure doMark(SP#p: int) returns ($result: bool);
  ensures $result == $ptr_eq($ptr(^Node, F#mark($ref($ptr(^Node, SP#p)))), $ptr(^Node, SP#p));
  free ensures $result == F#doMark(SP#p);
  free ensures $call_transition(old($s), $s);



function F#mark2(SP#p: int) : bool;

const unique cf#mark2: $pure_function;

axiom $function_arg_type(cf#mark2, 0, ^^bool);

axiom $function_arg_type(cf#mark2, 1, $ptr_to(^Node));

procedure mark2(SP#p: int) returns ($result: bool);
  free ensures $result == F#mark2(SP#p);
  free ensures $call_transition(old($s), $s);



procedure tree_init(P#t: int);
  modifies $s, $cev_pc;
  ensures $wrapped($s, $ptr(^Tree, P#t), ^Tree);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $span($ptr(^Tree, P#t))) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $span($ptr(^Tree, P#t))) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $span($ptr(^Tree, P#t))) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation tree_init(P#t: int)
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
    assume $local_value_is($s, #tok$1^87.1, #loc.t, $ptr_to_int($ptr(^Tree, P#t)), $ptr_to(^Tree)) && $local_value_is_ptr($s, #tok$1^87.1, #loc.t, $ptr(^Tree, P#t), $ptr_to(^Tree));
    assume #wrTime$1^87.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^87.1, #p) } $in_writes_at(#wrTime$1^87.1, #p) == $set_in(#p, $span($ptr(^Tree, P#t))));
    assume (forall #p: $ptr :: { $extent_hint(#p, $ptr(^Tree, P#t)) } $set_in(#p, $span($ptr(^Tree, P#t))) ==> $mutable($s, #p));
    // assume @in_range_phys_ptr((mathint)t); 
    assume $in_range_phys_ptr($ref($ptr(^Tree, P#t)));
    // assert @_vcc_typed2(@state, (t->root)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.root), $ptr_to(^Node));
    // assert @prim_writes_check((t->root)); 
    assert $writable($s, #wrTime$1^87.1, $dot($ptr(^Tree, P#t), Tree.root));
    // *(t->root) := (struct Node*)@null; 
    call $write_int($dot($ptr(^Tree, P#t), Tree.root), $ref($ptr_cast($null, ^Node)));
    assume $full_stop_ext(#tok$1^91.3, $s);
    // (struct Node* -> (struct Node* -> _Bool)) res_lambda#2#14; 
    assume $local_value_is($s, #tok$1^93.12, #loc.res_lambda#2#14, $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int(res_lambda#2#14), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // (struct Node* -> _Bool) res_lambda#1#15; 
    assume $local_value_is($s, #tok$1^93.12, #loc.res_lambda#1#15, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#1#15), $map_t($ptr_to(^Node), ^^bool));
    // res_lambda#1#15 := lambda#1(); 
    call res_lambda#1#15 := lambda#1();
    assume $full_stop_ext(#tok$1^93.12, $s);
    assume $local_value_is($s, #tok$1^93.12, #loc.res_lambda#1#15, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#1#15), $map_t($ptr_to(^Node), ^^bool));
    // res_lambda#2#14 := lambda#2(res_lambda#1#15); 
    call res_lambda#2#14 := lambda#2(res_lambda#1#15);
    assume $full_stop_ext(#tok$1^93.12, $s);
    assume $local_value_is($s, #tok$1^93.12, #loc.res_lambda#2#14, $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int(res_lambda#2#14), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @_vcc_typed2(@state, (t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @prim_writes_check((t->R)); 
    assert $writable($s, #wrTime$1^87.1, $dot($ptr(^Tree, P#t), Tree.R));
    // *(t->R) := res_lambda#2#14; 
    call $write_int($dot($ptr(^Tree, P#t), Tree.R), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int(res_lambda#2#14));
    assume $full_stop_ext(#tok$1^93.5, $s);
    // (int32_t -> int32_t) res_lambda#3#16; 
    assume $local_value_is($s, #tok$1^94.14, #loc.res_lambda#3#16, $map_t..^^i4.^^i4_to_int(res_lambda#3#16), $map_t(^^i4, ^^i4));
    // res_lambda#3#16 := lambda#3(); 
    call res_lambda#3#16 := lambda#3();
    assume $full_stop_ext(#tok$1^94.14, $s);
    assume $local_value_is($s, #tok$1^94.14, #loc.res_lambda#3#16, $map_t..^^i4.^^i4_to_int(res_lambda#3#16), $map_t(^^i4, ^^i4));
    // assert @_vcc_typed2(@state, (t->abs)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.abs), $map_t(^^i4, ^^i4));
    // assert @prim_writes_check((t->abs)); 
    assert $writable($s, #wrTime$1^87.1, $dot($ptr(^Tree, P#t), Tree.abs));
    // *(t->abs) := res_lambda#3#16; 
    call $write_int($dot($ptr(^Tree, P#t), Tree.abs), $map_t..^^i4.^^i4_to_int(res_lambda#3#16));
    assume $full_stop_ext(#tok$1^94.5, $s);
    // assert @writes_check(@_vcc_span(t)); 
    assert (forall #writes$1^95.5: $ptr :: { $dont_instantiate(#writes$1^95.5) } $set_in(#writes$1^95.5, $span($ptr(^Tree, P#t))) ==> $top_writable($s, #wrTime$1^87.1, #writes$1^95.5));
    // stmt _vcc_set_owns(t, @_vcc_set_empty); 
    call $set_owns($ptr(^Tree, P#t), $set_empty());
    assume $full_stop_ext(#tok$1^95.5, $s);
    // _math state_t prestate#23; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#23, $state_to_int(prestate#23), ^$#state_t);
    // prestate#23 := @_vcc_current_state(@state); 
    prestate#23 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#23, $state_to_int(prestate#23), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(t); 
    assert $top_writable($s, #wrTime$1^87.1, $ptr(^Tree, P#t));
    // assert @writes_check(@_vcc_owns(@state, t)); 
    assert (forall #writes$1^97.19: $ptr :: { $dont_instantiate(#writes$1^97.19) } $set_in(#writes$1^97.19, $owns($s, $ptr(^Tree, P#t))) ==> $top_writable($s, #wrTime$1^87.1, #writes$1^97.19));
    // stmt @_vcc_wrap(t, @_vcc_typeof(t)); 
    call $wrap($ptr(^Tree, P#t), ^Tree);
    assume $good_state_ext(#tok$1^97.19, $s);
    // assert @inv_check(unchecked!(@map_get(@map_get(*((t->R)), *((t->root))), (struct Node*)@null))); 
    assert !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr_cast($null, ^Node)));
    // assert @inv_check(==>(@_vcc_ptr_neq(*((t->root)), @null), @map_get(@map_get(*((t->R)), *((t->root))), *((t->root))))); 
    assert $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
    // assert @inv_check(==>(@_vcc_ptr_neq(*((t->root)), @null), @_vcc_ptr_eq(*((*((t->root))->parent)), @null))); 
    assert $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), Node.parent), ^Node), $null);
    // assert @inv_check(forall(struct Node* m; @in_range_phys_ptr((mathint)m); unchecked!(@map_get(@map_get(*((t->R)), (struct Node*)@null), m)))); 
    assert (forall Q#m$1^82.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr_cast($null, ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->left))), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->left))), m), <(*((m->key)), *((n->key))))))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) < $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->right))), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->right))), m), >(*((m->key)), *((n->key))))))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) > $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
    // assert @inv_check(forall(struct Node* m; { @map_get(@map_get(*((t->R)), *((t->root))), m) } { mark2(m) } { @trigger_hint(mark2(m)) } @in_range_phys_ptr((mathint)m); ==(@map_get(@map_get(*((t->R)), *((t->root))), m), @_vcc_set_in(m, @_vcc_owns(@state, t))))); 
    assert (forall Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } { F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1))) } { sk_hack(F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) == $set_in($ptr(^Node, Q#m$1^82.29#dt1), $owns($s, $ptr(^Tree, P#t))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), m)))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), n)))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->left)), @null)), @map_get(@map_get(*((t->R)), n), *((n->left)))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->left)), @null)), @_vcc_ptr_eq(*((*((n->left))->parent)), n)))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->right)), @null)), @map_get(@map_get(*((t->R)), n), *((n->right)))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->right)), @null)), @_vcc_ptr_eq(*((*((n->right))->parent)), n)))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->parent)), @null)), @map_get(@map_get(*((t->R)), *((t->root))), *((n->parent)))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->parent)), @null)), ||(@_vcc_ptr_eq(*((*((n->parent))->left)), n), @_vcc_ptr_eq(*((*((n->parent))->right)), n))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.left), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)) || $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.right), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
    // assert @inv_check(forall(struct Node* n; { @map_get(@map_get(*((t->R)), *((t->root))), n) } @in_range_phys_ptr((mathint)n); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), @map_get(@map_get(*((t->R)), n), n)))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
    // assert @inv_check(true); 
    assert true;
    // assert @inv_check(forall(struct Node* m; { @map_get(*((t->abs)), *((m->key))) } @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), ==(@map_get(*((t->abs)), *((m->key))), *((m->value)))))); 
    assert (forall Q#m$1^83.29#dt1: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) == $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.value)));
    // assert @inv_check(forall(int32_t k; { @map_get(*((t->abs)), k) } @in_range_i4(k); ==>(forall(struct Node* m; @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), !=(*((m->key)), k))), ==(@map_get(*((t->abs)), k), 0)))); 
    assert (forall Q#k$1^83.29#tc2: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), Q#k$1^83.29#tc2) == 0);
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_eq(*((mark(n)->parent)), @null)), ||(@_vcc_ptr_eq(n, (struct Node*)@null), @_vcc_ptr_eq(n, *((t->root))))))); 
    assert (forall Q#n$1^84.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && $ptr_eq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) || $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), mark(n)), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==(@map_get(@map_get(*((t->R)), mark(n)), m), &&(@map_get(@map_get(*((t->R)), *((t->root))), n), ||(||(||(&&(@_vcc_ptr_eq(n, (struct Node*)@null), @_vcc_ptr_eq(m, (struct Node*)@null)), @_vcc_ptr_eq(m, n)), @map_get(@map_get(*((t->R)), *((n->left))), m)), @map_get(@map_get(*((t->R)), *((n->right))), m)))))); 
    assert (forall Q#n$1^84.29#dt1: int, Q#m$1^84.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && (($ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) && $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr_cast($null, ^Node))) || $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr(^Node, Q#n$1^84.29#dt1)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure tree_find(P#t: int, P#key: int) returns ($result: int);
  requires $wrapped($s, $ptr(^Tree, P#t), ^Tree);
  modifies $s, $cev_pc;
  free ensures $in_range_phys_ptr($ref($ptr(^Node, $result)));
  ensures $ptr_neq($ptr(^Node, $result), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, $result))) && $mem($s, $dot($ptr(^Node, $result), Node.key)) == P#key;
  ensures $ptr_eq($ptr(^Node, $result), $null) ==> (forall Q#n$1^104.53#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^104.53#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^104.53#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#n$1^104.53#dt1), Node.key)) != P#key);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation tree_find(P#t: int, P#key: int) returns ($result: int)
{
  var loopState#0: $state;
  var L#p: int where $in_range_phys_ptr(L#p);
  var #wrTime$1^101.1: int;
  var #stackframe: int;

  anon15:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^101.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^101.1, #loc.t, $ptr_to_int($ptr(^Tree, P#t)), $ptr_to(^Tree)) && $local_value_is_ptr($s, #tok$1^101.1, #loc.t, $ptr(^Tree, P#t), $ptr_to(^Tree));
    assume $local_value_is($s, #tok$1^101.1, #loc.key, P#key, ^^i4);
    assume #wrTime$1^101.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^101.1, #p) } $in_writes_at(#wrTime$1^101.1, #p) == false);
    // assume @in_range_phys_ptr((mathint)t); 
    assume $in_range_phys_ptr($ref($ptr(^Tree, P#t)));
    // assume @in_range_i4(key); 
    assume $in_range_i4(P#key);
    // assert @_vcc_in_domain(@state, t, t); 
    assert $in_domain_lab($s, $ptr(^Tree, P#t), $ptr(^Tree, P#t), l#public);
    // struct Node* p; 
    assume $local_value_is($s, #tok$1^106.3, #loc.p, $ptr_to_int($ptr(^Node, L#p)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^106.3, #loc.p, $ptr(^Node, L#p), $ptr_to(^Node));
    // var struct Node* p
    // assert @reads_check_normal((t->root)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.root), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.root), $ptr_to(^Node));
    // p := *((t->root)); 
    L#p := $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node));
    assume $local_value_is($s, #tok$1^107.3, #loc.p, $ptr_to_int($ptr(^Node, L#p)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^107.3, #loc.p, $ptr(^Node, L#p), $ptr_to(^Node));
    loopState#0 := $s;
    while (true)
      invariant $ptr_eq($ptr(^Node, L#p), $null) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, L#p))))));
      invariant (forall Q#n$1^110.31#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^110.31#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#n$1^110.31#dt1), Node.key)) == P#key && $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^110.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, L#p))), $ref($ptr(^Node, Q#n$1^110.31#dt1))));
    {
      anon14:
        assume $writes_nothing(old($s), $s);
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$1^108.3, $s);
        assume $local_value_is($s, #tok$1^108.3, #loc.key, P#key, ^^i4);
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#0, $s);
        assume true;
        // if ((_Bool)p) ...
        if ($ptr_neq($ptr(^Node, L#p), $null))
        {
          anon12:
            // assert @reads_check_normal((p->key)); 
            assert $typed2($s, $dot($ptr(^Node, L#p), Node.key), ^^i4);
            assert $thread_local2($s, $dot($ptr(^Node, L#p), Node.key), ^^i4);
            assume true;
            // if (<(key, *((p->key)))) ...
            if (P#key < $mem($s, $dot($ptr(^Node, L#p), Node.key)))
            {
              anon8:
                // assert @reads_check_normal((p->left)); 
                assert $typed2($s, $dot($ptr(^Node, L#p), Node.left), $ptr_to(^Node));
                assert $thread_local2($s, $dot($ptr(^Node, L#p), Node.left), $ptr_to(^Node));
                // p := *((p->left)); 
                L#p := $ref($read_ptr($s, $dot($ptr(^Node, L#p), Node.left), ^Node));
                assume $local_value_is($s, #tok$1^113.7, #loc.p, $ptr_to_int($ptr(^Node, L#p)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^113.7, #loc.p, $ptr(^Node, L#p), $ptr_to(^Node));
            }
            else
            {
              anon11:
                // assert @reads_check_normal((p->key)); 
                assert $typed2($s, $dot($ptr(^Node, L#p), Node.key), ^^i4);
                assert $thread_local2($s, $dot($ptr(^Node, L#p), Node.key), ^^i4);
                assume true;
                // if (>(key, *((p->key)))) ...
                if (P#key > $mem($s, $dot($ptr(^Node, L#p), Node.key)))
                {
                  anon9:
                    // assert @reads_check_normal((p->right)); 
                    assert $typed2($s, $dot($ptr(^Node, L#p), Node.right), $ptr_to(^Node));
                    assert $thread_local2($s, $dot($ptr(^Node, L#p), Node.right), $ptr_to(^Node));
                    // p := *((p->right)); 
                    L#p := $ref($read_ptr($s, $dot($ptr(^Node, L#p), Node.right), ^Node));
                    assume $local_value_is($s, #tok$1^115.7, #loc.p, $ptr_to_int($ptr(^Node, L#p)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^115.7, #loc.p, $ptr(^Node, L#p), $ptr_to(^Node));
                }
                else
                {
                  anon10:
                    // return p; 
                    $result := $ref($ptr(^Node, L#p));
                    assert $position_marker();
                    goto #exit;
                }
            }
        }
        else
        {
          anon13:
            // goto #break_10; 
            goto #break_10;
        }

      #continue_10:
        assume true;
    }

  anon16:
    assume $full_stop_ext(#tok$1^108.3, $s);

  #break_10:
    // return (struct Node*)@null; 
    $result := $ref($ptr_cast($null, ^Node));
    assert $position_marker();
    goto #exit;

  anon17:
    // empty

  #exit:
}



procedure tree_lookup(P#t: int, P#key: int) returns ($result: int);
  requires $wrapped($s, $ptr(^Tree, P#t), ^Tree);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  ensures $result == $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), P#key);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation tree_lookup(P#t: int, P#key: int) returns ($result: int)
{
  var L#r: int where $in_range_phys_ptr(L#r);
  var #wrTime$1^122.1: int;
  var #stackframe: int;

  anon20:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^122.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^122.1, #loc.t, $ptr_to_int($ptr(^Tree, P#t)), $ptr_to(^Tree)) && $local_value_is_ptr($s, #tok$1^122.1, #loc.t, $ptr(^Tree, P#t), $ptr_to(^Tree));
    assume $local_value_is($s, #tok$1^122.1, #loc.key, P#key, ^^i4);
    assume #wrTime$1^122.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^122.1, #p) } $in_writes_at(#wrTime$1^122.1, #p) == false);
    // assume @in_range_phys_ptr((mathint)t); 
    assume $in_range_phys_ptr($ref($ptr(^Tree, P#t)));
    // assume @in_range_i4(key); 
    assume $in_range_i4(P#key);
    // assert @_vcc_in_domain(@state, t, t); 
    assert $in_domain_lab($s, $ptr(^Tree, P#t), $ptr(^Tree, P#t), l#public);
    // struct Node* r; 
    assume $local_value_is($s, #tok$1^126.3, #loc.r, $ptr_to_int($ptr(^Node, L#r)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^126.3, #loc.r, $ptr(^Node, L#r), $ptr_to(^Node));
    // non-pure function
    // r := tree_find(t, key); 
    call L#r := tree_find($ref($ptr(^Tree, P#t)), P#key);
    assume $full_stop_ext(#tok$1^126.13, $s);
    assume $local_value_is($s, #tok$1^126.13, #loc.r, $ptr_to_int($ptr(^Node, L#r)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^126.13, #loc.r, $ptr(^Node, L#r), $ptr_to(^Node));
    assume true;
    // if (@_vcc_ptr_eq(r, @null)) ...
    if ($ptr_eq($ptr(^Node, L#r), $null))
    {
      anon18:
        // assert @_vcc_inv(@state, t); 
        assert $inv($s, $ptr(^Tree, P#t), ^Tree);
        // assume @_vcc_inv(@state, t); 
        assume $inv($s, $ptr(^Tree, P#t), ^Tree);
        // return 0; 
        $result := 0;
        assert $position_marker();
        goto #exit;
    }
    else
    {
      anon19:
        // assert @reads_check_normal((r->value)); 
        assert $typed2($s, $dot($ptr(^Node, L#r), Node.value), ^^i4);
        assert $thread_local2($s, $dot($ptr(^Node, L#r), Node.value), ^^i4);
        // return *((r->value)); 
        $result := $mem($s, $dot($ptr(^Node, L#r), Node.value));
        assert $position_marker();
        goto #exit;
    }

  anon21:
    // empty

  #exit:
}



procedure tree_insert(P#t: int, P#x: int);
  requires !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, P#x)));
  requires (forall Q#n$1^138.28#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^138.28#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^138.28#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#n$1^138.28#dt1), Node.key)) != $mem($s, $dot($ptr(^Node, P#x), Node.key)));
  requires $wrapped($s, $ptr(^Tree, P#t), ^Tree);
  modifies $s, $cev_pc;
  ensures (forall Q#n$1^139.27#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^139.27#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^139.27#dt1))) == ($ptr_eq($ptr(^Node, Q#n$1^139.27#dt1), $ptr(^Node, P#x)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(old($s), $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr(old($s), $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^139.27#dt1)))));
  ensures $mem(old($s), $dot($ptr(^Node, P#x), Node.key)) == $mem($s, $dot($ptr(^Node, P#x), Node.key)) && $mem(old($s), $dot($ptr(^Node, P#x), Node.value)) == $mem($s, $dot($ptr(^Node, P#x), Node.value));
  ensures $wrapped($s, $ptr(^Tree, P#t), ^Tree);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Tree, P#t) || $set_in(#p, $span($ptr(^Node, P#x))) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Tree, P#t) || $set_in(#p, $span($ptr(^Node, P#x))) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Tree, P#t) || $set_in(#p, $span($ptr(^Node, P#x))) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation tree_insert(P#t: int, P#x: int)
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
  var assign#13: int where $in_range_phys_ptr(assign#13);
  var assign#12: int where $in_range_phys_ptr(assign#12);
  var prestate#24: $state;
  var L#p: int where $in_range_phys_ptr(L#p);
  var L#n: int where $in_range_phys_ptr(L#n);
  var #wrTime$1^134.1: int;
  var #stackframe: int;

  anon36:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^134.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^134.1, #loc.t, $ptr_to_int($ptr(^Tree, P#t)), $ptr_to(^Tree)) && $local_value_is_ptr($s, #tok$1^134.1, #loc.t, $ptr(^Tree, P#t), $ptr_to(^Tree));
    assume $local_value_is($s, #tok$1^134.1, #loc.x, $ptr_to_int($ptr(^Node, P#x)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^134.1, #loc.x, $ptr(^Node, P#x), $ptr_to(^Node));
    assume #wrTime$1^134.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^134.1, #p) } $in_writes_at(#wrTime$1^134.1, #p) == (#p == $ptr(^Tree, P#t) || $set_in(#p, $span($ptr(^Node, P#x)))));
    assume $thread_owned($s, $ptr(^Tree, P#t));
    assume (forall #p: $ptr :: { $extent_hint(#p, $ptr(^Node, P#x)) } $set_in(#p, $span($ptr(^Node, P#x))) ==> $mutable($s, #p));
    // assume @in_range_phys_ptr((mathint)t); 
    assume $in_range_phys_ptr($ref($ptr(^Tree, P#t)));
    // assume @in_range_phys_ptr((mathint)x); 
    assume $in_range_phys_ptr($ref($ptr(^Node, P#x)));
    // assert @_vcc_in_domain(@state, t, t); 
    assert $in_domain_lab($s, $ptr(^Tree, P#t), $ptr(^Tree, P#t), l#public);
    // struct Node* n; 
    assume $local_value_is($s, #tok$1^142.3, #loc.n, $ptr_to_int($ptr(^Node, L#n)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^142.3, #loc.n, $ptr(^Node, L#n), $ptr_to(^Node));
    // struct Node* p; 
    assume $local_value_is($s, #tok$1^142.3, #loc.p, $ptr_to_int($ptr(^Node, L#p)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^142.3, #loc.p, $ptr(^Node, L#p), $ptr_to(^Node));
    // var struct Node* p
    // var struct Node* n
    // _math state_t prestate#24; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#24, $state_to_int(prestate#24), ^$#state_t);
    // prestate#24 := @_vcc_current_state(@state); 
    prestate#24 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#24, $state_to_int(prestate#24), ^$#state_t);
    // assert @_vcc_wrapped(@state, t); 
    assert $wrapped($s, $ptr(^Tree, P#t), ^Tree);
    // assume @_vcc_inv(@state, t); 
    assume $inv($s, $ptr(^Tree, P#t), ^Tree);
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(t); 
    assert $top_writable($s, #wrTime$1^134.1, $ptr(^Tree, P#t));
    // stmt @_vcc_unwrap(t, @_vcc_typeof(t)); 
    call $unwrap($ptr(^Tree, P#t), ^Tree);
    assume $good_state_ext(#tok$1^144.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // struct Node* assign#12; 
    assume $local_value_is($s, #tok$2^0.0, #loc.assign#12, $ptr_to_int($ptr(^Node, assign#12)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$2^0.0, #loc.assign#12, $ptr(^Node, assign#12), $ptr_to(^Node));
    // struct Node* assign#13; 
    assume $local_value_is($s, #tok$2^0.0, #loc.assign#13, $ptr_to_int($ptr(^Node, assign#13)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$2^0.0, #loc.assign#13, $ptr(^Node, assign#13), $ptr_to(^Node));
    // assign#13 := (struct Node*)@null; 
    assign#13 := $ref($ptr_cast($null, ^Node));
    assume $local_value_is($s, #tok$2^0.0, #loc.assign#13, $ptr_to_int($ptr(^Node, assign#13)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$2^0.0, #loc.assign#13, $ptr(^Node, assign#13), $ptr_to(^Node));
    // assert @_vcc_typed2(@state, (x->parent)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
    // assert @prim_writes_check((x->parent)); 
    assert $writable($s, #wrTime$1^134.1, $dot($ptr(^Node, P#x), Node.parent));
    // *(x->parent) := assign#13; 
    call $write_int($dot($ptr(^Node, P#x), Node.parent), $ref($ptr(^Node, assign#13)));
    assume $full_stop_ext(#tok$1^146.24, $s);
    // assign#12 := assign#13; 
    assign#12 := $ref($ptr(^Node, assign#13));
    assume $local_value_is($s, #tok$2^0.0, #loc.assign#12, $ptr_to_int($ptr(^Node, assign#12)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$2^0.0, #loc.assign#12, $ptr(^Node, assign#12), $ptr_to(^Node));
    // assert @_vcc_typed2(@state, (x->right)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.right), $ptr_to(^Node));
    // assert @prim_writes_check((x->right)); 
    assert $writable($s, #wrTime$1^134.1, $dot($ptr(^Node, P#x), Node.right));
    // *(x->right) := assign#12; 
    call $write_int($dot($ptr(^Node, P#x), Node.right), $ref($ptr(^Node, assign#12)));
    assume $full_stop_ext(#tok$1^146.13, $s);
    // assert @_vcc_typed2(@state, (x->left)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.left), $ptr_to(^Node));
    // assert @prim_writes_check((x->left)); 
    assert $writable($s, #wrTime$1^134.1, $dot($ptr(^Node, P#x), Node.left));
    // *(x->left) := assign#12; 
    call $write_int($dot($ptr(^Node, P#x), Node.left), $ref($ptr(^Node, assign#12)));
    assume $full_stop_ext(#tok$1^146.3, $s);
    // assert @reads_check_normal((t->root)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.root), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.root), $ptr_to(^Node));
    // p := *((t->root)); 
    L#p := $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node));
    assume $local_value_is($s, #tok$1^148.3, #loc.p, $ptr_to_int($ptr(^Node, L#p)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^148.3, #loc.p, $ptr(^Node, L#p), $ptr_to(^Node));
    // (int32_t -> int32_t) res_lambda#4#17; 
    assume $local_value_is($s, #tok$1^151.14, #loc.res_lambda#4#17, $map_t..^^i4.^^i4_to_int(res_lambda#4#17), $map_t(^^i4, ^^i4));
    // assert @reads_check_normal((t->abs)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.abs), $map_t(^^i4, ^^i4));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.abs), $map_t(^^i4, ^^i4));
    // assert @reads_check_normal((x->value)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.value), ^^i4);
    assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.value), ^^i4);
    // assert @reads_check_normal((x->key)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.key), ^^i4);
    assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.key), ^^i4);
    // res_lambda#4#17 := lambda#4(*((t->abs)), *((x->value)), *((x->key))); 
    call res_lambda#4#17 := lambda#4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, P#x), Node.value)), $mem($s, $dot($ptr(^Node, P#x), Node.key)));
    assume $full_stop_ext(#tok$1^151.14, $s);
    assume $local_value_is($s, #tok$1^151.14, #loc.res_lambda#4#17, $map_t..^^i4.^^i4_to_int(res_lambda#4#17), $map_t(^^i4, ^^i4));
    // assert @_vcc_typed2(@state, (t->abs)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.abs), $map_t(^^i4, ^^i4));
    // assert @prim_writes_check((t->abs)); 
    assert $writable($s, #wrTime$1^134.1, $dot($ptr(^Tree, P#t), Tree.abs));
    // *(t->abs) := res_lambda#4#17; 
    call $write_int($dot($ptr(^Tree, P#t), Tree.abs), $map_t..^^i4.^^i4_to_int(res_lambda#4#17));
    assume $full_stop_ext(#tok$1^151.5, $s);
    // assert @writes_check(@_vcc_span(t)); 
    assert (forall #writes$1^152.5: $ptr :: { $dont_instantiate(#writes$1^152.5) } $set_in(#writes$1^152.5, $span($ptr(^Tree, P#t))) ==> $top_writable($s, #wrTime$1^134.1, #writes$1^152.5));
    // stmt _vcc_set_owns(t, @_vcc_set_union(@_vcc_owns(@state, t), @_vcc_set_singleton(x))); 
    call $set_owns($ptr(^Tree, P#t), $set_union($owns($s, $ptr(^Tree, P#t)), $set_singleton($ptr(^Node, P#x))));
    assume $full_stop_ext(#tok$1^152.5, $s);
    // (struct Node* -> _Bool) res_lambda#5#18; 
    assume $local_value_is($s, #tok$1^153.15, #loc.res_lambda#5#18, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#5#18), $map_t($ptr_to(^Node), ^^bool));
    // res_lambda#5#18 := lambda#5(x); 
    call res_lambda#5#18 := lambda#5($ref($ptr(^Node, P#x)));
    assume $full_stop_ext(#tok$1^153.15, $s);
    assume $local_value_is($s, #tok$1^153.15, #loc.res_lambda#5#18, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#5#18), $map_t($ptr_to(^Node), ^^bool));
    // assert @_vcc_typed2(@state, (t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @prim_writes_check((t->R)); 
    assert $writable($s, #wrTime$1^134.1, $dot($ptr(^Tree, P#t), Tree.R));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // *(t->R) := @map_updated(*((t->R)), x, res_lambda#5#18); 
    call $write_int($dot($ptr(^Tree, P#t), Tree.R), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, P#x)), res_lambda#5#18)));
    assume $full_stop_ext(#tok$1^153.5, $s);
    assume true;
    // if (@_vcc_ptr_eq(p, @null)) ...
    if ($ptr_eq($ptr(^Node, L#p), $null))
    {
      anon22:
        // assert @_vcc_typed2(@state, (t->root)); 
        assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.root), $ptr_to(^Node));
        // assert @prim_writes_check((t->root)); 
        assert $writable($s, #wrTime$1^134.1, $dot($ptr(^Tree, P#t), Tree.root));
        // *(t->root) := x; 
        call $write_int($dot($ptr(^Tree, P#t), Tree.root), $ref($ptr(^Node, P#x)));
        assume $full_stop_ext(#tok$1^157.5, $s);
        // _math state_t prestate#27; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
        // prestate#27 := @_vcc_current_state(@state); 
        prestate#27 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
        // _math state_t staticWrapState#25; 
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#25, $state_to_int(staticWrapState#25), ^$#state_t);
        // staticWrapState#25 := @_vcc_current_state(@state); 
        staticWrapState#25 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#25, $state_to_int(staticWrapState#25), ^$#state_t);
        // _math ptrset owns#26; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#26, $ptrset_to_int(owns#26), ^$#ptrset);
        // owns#26 := @_vcc_set_empty; 
        owns#26 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#26, $ptrset_to_int(owns#26), ^$#ptrset);
        // assert @writes_check(x); 
        assert $top_writable($s, #wrTime$1^134.1, $ptr(^Node, P#x));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(x), staticWrapState#25, owns#26)
        call $static_wrap($ptr(^Node, P#x), staticWrapState#25, owns#26);
        assume $good_state_ext(#tok$1^158.21, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, x), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $ptr(^Node, P#x)), $set_empty());
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // _math state_t prestate#28; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
        // prestate#28 := @_vcc_current_state(@state); 
        prestate#28 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
        // assume @_vcc_pre_wrap(@state); 
        assume $pre_wrap($s);
        // assert @writes_check(t); 
        assert $top_writable($s, #wrTime$1^134.1, $ptr(^Tree, P#t));
        // assert @writes_check(@_vcc_owns(@state, t)); 
        assert (forall #writes$1^159.21: $ptr :: { $dont_instantiate(#writes$1^159.21) } $set_in(#writes$1^159.21, $owns($s, $ptr(^Tree, P#t))) ==> $top_writable($s, #wrTime$1^134.1, #writes$1^159.21));
        // stmt @_vcc_wrap(t, @_vcc_typeof(t)); 
        call $wrap($ptr(^Tree, P#t), ^Tree);
        assume $good_state_ext(#tok$1^159.21, $s);
        // assert @inv_check(unchecked!(@map_get(@map_get(*((t->R)), *((t->root))), (struct Node*)@null))); 
        assert !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr_cast($null, ^Node)));
        // assert @inv_check(==>(@_vcc_ptr_neq(*((t->root)), @null), @map_get(@map_get(*((t->R)), *((t->root))), *((t->root))))); 
        assert $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
        // assert @inv_check(==>(@_vcc_ptr_neq(*((t->root)), @null), @_vcc_ptr_eq(*((*((t->root))->parent)), @null))); 
        assert $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), Node.parent), ^Node), $null);
        // assert @inv_check(forall(struct Node* m; @in_range_phys_ptr((mathint)m); unchecked!(@map_get(@map_get(*((t->R)), (struct Node*)@null), m)))); 
        assert (forall Q#m$1^82.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr_cast($null, ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
        // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->left))), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->left))), m), <(*((m->key)), *((n->key))))))); 
        assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) < $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
        // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->right))), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->right))), m), >(*((m->key)), *((n->key))))))); 
        assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) > $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
        // assert @inv_check(forall(struct Node* m; { @map_get(@map_get(*((t->R)), *((t->root))), m) } { mark2(m) } { @trigger_hint(mark2(m)) } @in_range_phys_ptr((mathint)m); ==(@map_get(@map_get(*((t->R)), *((t->root))), m), @_vcc_set_in(m, @_vcc_owns(@state, t))))); 
        assert (forall Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } { F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1))) } { sk_hack(F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) == $set_in($ptr(^Node, Q#m$1^82.29#dt1), $owns($s, $ptr(^Tree, P#t))));
        // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), m)))); 
        assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
        // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), n)))); 
        assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
        // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->left)), @null)), @map_get(@map_get(*((t->R)), n), *((n->left)))))); 
        assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node))));
        // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->left)), @null)), @_vcc_ptr_eq(*((*((n->left))->parent)), n)))); 
        assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
        // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->right)), @null)), @map_get(@map_get(*((t->R)), n), *((n->right)))))); 
        assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node))));
        // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->right)), @null)), @_vcc_ptr_eq(*((*((n->right))->parent)), n)))); 
        assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
        // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->parent)), @null)), @map_get(@map_get(*((t->R)), *((t->root))), *((n->parent)))))); 
        assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node))));
        // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->parent)), @null)), ||(@_vcc_ptr_eq(*((*((n->parent))->left)), n), @_vcc_ptr_eq(*((*((n->parent))->right)), n))))); 
        assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.left), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)) || $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.right), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
        // assert @inv_check(forall(struct Node* n; { @map_get(@map_get(*((t->R)), *((t->root))), n) } @in_range_phys_ptr((mathint)n); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), @map_get(@map_get(*((t->R)), n), n)))); 
        assert (forall Q#n$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
        // assert @inv_check(true); 
        assert true;
        // assert @inv_check(forall(struct Node* m; { @map_get(*((t->abs)), *((m->key))) } @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), ==(@map_get(*((t->abs)), *((m->key))), *((m->value)))))); 
        assert (forall Q#m$1^83.29#dt1: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) == $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.value)));
        // assert @inv_check(forall(int32_t k; { @map_get(*((t->abs)), k) } @in_range_i4(k); ==>(forall(struct Node* m; @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), !=(*((m->key)), k))), ==(@map_get(*((t->abs)), k), 0)))); 
        assert (forall Q#k$1^83.29#tc2: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), Q#k$1^83.29#tc2) == 0);
        // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_eq(*((mark(n)->parent)), @null)), ||(@_vcc_ptr_eq(n, (struct Node*)@null), @_vcc_ptr_eq(n, *((t->root))))))); 
        assert (forall Q#n$1^84.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && $ptr_eq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) || $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
        // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), mark(n)), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==(@map_get(@map_get(*((t->R)), mark(n)), m), &&(@map_get(@map_get(*((t->R)), *((t->root))), n), ||(||(||(&&(@_vcc_ptr_eq(n, (struct Node*)@null), @_vcc_ptr_eq(m, (struct Node*)@null)), @_vcc_ptr_eq(m, n)), @map_get(@map_get(*((t->R)), *((n->left))), m)), @map_get(@map_get(*((t->R)), *((n->right))), m)))))); 
        assert (forall Q#n$1^84.29#dt1: int, Q#m$1^84.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && (($ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) && $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr_cast($null, ^Node))) || $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr(^Node, Q#n$1^84.29#dt1)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))))));
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // return; 
        assert $position_marker();
        goto #exit;
    }
    else
    {
      anon23:
        // empty
    }

  anon37:
    // (struct Node* -> _Bool) res_lambda#6#19; 
    assume $local_value_is($s, #tok$1^163.41, #loc.res_lambda#6#19, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#6#19), $map_t($ptr_to(^Node), ^^bool));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @reads_check_normal((t->root)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.root), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.root), $ptr_to(^Node));
    // res_lambda#6#19 := lambda#6(old(@prestate, @map_get(*((t->R)), *((t->root)))), x); 
    call res_lambda#6#19 := lambda#6($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(old($s), $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr(old($s), $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, P#x)));
    assume $full_stop_ext(#tok$1^163.41, $s);
    assume $local_value_is($s, #tok$1^163.41, #loc.res_lambda#6#19, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#6#19), $map_t($ptr_to(^Node), ^^bool));
    // assert @_vcc_typed2(@state, (t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @prim_writes_check((t->R)); 
    assert $writable($s, #wrTime$1^134.1, $dot($ptr(^Tree, P#t), Tree.R));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @reads_check_normal((t->root)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.root), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.root), $ptr_to(^Node));
    // *(t->R) := @map_updated(*((t->R)), *((t->root)), res_lambda#6#19); 
    call $write_int($dot($ptr(^Tree, P#t), Tree.R), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)), res_lambda#6#19)));
    assume $full_stop_ext(#tok$1^163.25, $s);
    // assert doMark(*((t->root))); 
    assert F#doMark($ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
    // assume doMark(*((t->root))); 
    assume F#doMark($ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
    // assert @map_get(@map_get(*((t->R)), *((t->root))), x); 
    assert $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, P#x)));
    // assume @map_get(@map_get(*((t->R)), *((t->root))), x); 
    assume $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, P#x)));
    call $bump_timestamp();
    assume $full_stop_ext(#tok$1^168.28, $s);
    loopState#1 := $s;
    assume #wrTime$1^168.28 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^168.28, #p) } $in_writes_at(#wrTime$1^168.28, #p) == ($set_in(#p, $set_difference($owns($s, $ptr(^Tree, P#t)), $set_singleton($ptr(^Node, P#x)))) || #p == $dot($ptr(^Tree, P#t), Tree.R)));
    assert (forall #loopWrites^$1^168.28: $ptr :: { $dont_instantiate(#loopWrites^$1^168.28) } $top_writable($s, #wrTime$1^168.28, #loopWrites^$1^168.28) ==> $top_writable($s, #wrTime$1^134.1, #loopWrites^$1^168.28));
    while (true)
      invariant (forall Q#p$1^169.32#tc3: $ptr :: $set_in(Q#p$1^169.32#tc3, $owns($s, $ptr(^Tree, P#t))) ==> Q#p$1^169.32#tc3 == $ptr(^Node, P#x) || $wrapped($s, Q#p$1^169.32#tc3, $typ(Q#p$1^169.32#tc3)));
      invariant $mutable($s, $ptr(^Node, P#x));
      invariant $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(loopState#1, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr(loopState#1, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))));
      invariant $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(loopState#1, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr_cast($null, ^Node))), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr_cast($null, ^Node))));
      invariant $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(loopState#1, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, P#x))), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, P#x))));
      invariant !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr_cast($null, ^Node)));
      invariant $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
      invariant $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), Node.parent), ^Node), $null);
      invariant (forall Q#m$1^171.31#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^171.31#dt1))) ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr_cast($null, ^Node))), $ref($ptr(^Node, Q#m$1^171.31#dt1))));
      invariant (forall Q#n$1^171.31#dt1: int, Q#m$1^171.31#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^171.31#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^171.31#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^171.31#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^171.31#dt1), Node.key)) < $mem($s, $dot($ptr(^Node, Q#n$1^171.31#dt1), Node.key)));
      invariant (forall Q#n$1^171.31#dt1: int, Q#m$1^171.31#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^171.31#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^171.31#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^171.31#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^171.31#dt1), Node.key)) > $mem($s, $dot($ptr(^Node, Q#n$1^171.31#dt1), Node.key)));
      invariant (forall Q#m$1^171.31#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^171.31#dt1))) } { F#mark2($ref($ptr(^Node, Q#m$1^171.31#dt1))) } { sk_hack(F#mark2($ref($ptr(^Node, Q#m$1^171.31#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^171.31#dt1))) == $set_in($ptr(^Node, Q#m$1^171.31#dt1), $owns($s, $ptr(^Tree, P#t))));
      invariant (forall Q#n$1^171.31#dt1: int, Q#m$1^171.31#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^171.31#dt1))), $ref($ptr(^Node, Q#m$1^171.31#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^171.31#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^171.31#dt1))), $ref($ptr(^Node, Q#m$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^171.31#dt1))));
      invariant (forall Q#n$1^171.31#dt1: int, Q#m$1^171.31#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^171.31#dt1))), $ref($ptr(^Node, Q#m$1^171.31#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^171.31#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^171.31#dt1))), $ref($ptr(^Node, Q#m$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^171.31#dt1))));
      invariant (forall Q#n$1^171.31#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^171.31#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))), Node.left), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^171.31#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^171.31#dt1), Node.left), ^Node))));
      invariant (forall Q#n$1^171.31#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^171.31#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))), Node.left), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^171.31#dt1), Node.left), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^171.31#dt1)));
      invariant (forall Q#n$1^171.31#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^171.31#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))), Node.right), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^171.31#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^171.31#dt1), Node.right), ^Node))));
      invariant (forall Q#n$1^171.31#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^171.31#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))), Node.right), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^171.31#dt1), Node.right), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^171.31#dt1)));
      invariant (forall Q#n$1^171.31#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^171.31#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))), Node.parent), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^171.31#dt1), Node.parent), ^Node))));
      invariant (forall Q#n$1^171.31#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^171.31#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^171.31#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^171.31#dt1), Node.parent), ^Node), Node.left), ^Node), $ptr(^Node, Q#n$1^171.31#dt1)) || $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^171.31#dt1), Node.parent), ^Node), Node.right), ^Node), $ptr(^Node, Q#n$1^171.31#dt1)));
      invariant (forall Q#n$1^171.31#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^171.31#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^171.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^171.31#dt1))), $ref($ptr(^Node, Q#n$1^171.31#dt1))));
      invariant true;
      invariant (forall Q#m$1^172.31#dt1: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^172.31#dt1), Node.key))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^172.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^172.31#dt1))) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^172.31#dt1), Node.key))) == $mem($s, $dot($ptr(^Node, Q#m$1^172.31#dt1), Node.value)));
      invariant (forall Q#k$1^172.31#tc2: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), Q#k$1^172.31#tc2) } $in_range_i4(Q#k$1^172.31#tc2) ==> (forall Q#m$1^172.31#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^172.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^172.31#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^172.31#dt1), Node.key)) != Q#k$1^172.31#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), Q#k$1^172.31#tc2) == 0);
      invariant (forall Q#n$1^173.31#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^173.31#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^173.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^173.31#dt1))) && $ptr_eq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^173.31#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($ptr(^Node, Q#n$1^173.31#dt1), $ptr(^Node, P#x)) || $ptr_eq($ptr(^Node, Q#n$1^173.31#dt1), $read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
      invariant (forall Q#n$1^173.31#dt1: int, Q#m$1^173.31#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^173.31#dt1)))))), $ref($ptr(^Node, Q#m$1^173.31#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^173.31#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^173.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^173.31#dt1)))))), $ref($ptr(^Node, Q#m$1^173.31#dt1))) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^173.31#dt1))) && (($ptr_eq($ptr(^Node, Q#n$1^173.31#dt1), $ptr(^Node, L#p)) && $ptr_eq($ptr(^Node, Q#m$1^173.31#dt1), $ptr(^Node, P#x))) || $ptr_eq($ptr(^Node, Q#m$1^173.31#dt1), $ptr(^Node, Q#n$1^173.31#dt1)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^173.31#dt1), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^173.31#dt1))) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^173.31#dt1), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^173.31#dt1))))));
      invariant $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, L#p)));
      invariant $ptr_neq($ptr(^Node, L#p), $ptr(^Node, P#x));
      invariant !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, L#p), Node.left), ^Node))), $ref($ptr(^Node, P#x)));
      invariant !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, L#p), Node.right), ^Node))), $ref($ptr(^Node, P#x)));
      invariant (forall Q#n$1^176.31#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^176.31#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^176.31#dt1))) ==> $ptr_eq($ptr(^Node, Q#n$1^176.31#dt1), $ptr(^Node, P#x)) || $mem($s, $dot($ptr(^Node, Q#n$1^176.31#dt1), Node.key)) != $mem($s, $dot($ptr(^Node, P#x), Node.key)));
    {
      anon35:
        assume (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(loopState#1, #p) || $set_in(#p, $set_difference($owns(loopState#1, $ptr(^Tree, P#t)), $set_singleton($ptr(^Node, P#x)))) || #p == $dot($ptr(^Tree, P#t), Tree.R) || $mem_eq(loopState#1, $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(loopState#1, #p) || $set_in(#p, $set_difference($owns(loopState#1, $ptr(^Tree, P#t)), $set_singleton($ptr(^Node, P#x)))) || #p == $dot($ptr(^Tree, P#t), Tree.R) || $st_eq(loopState#1, $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(loopState#1, #p) || $set_in(#p, $set_difference($owns(loopState#1, $ptr(^Tree, P#t)), $set_singleton($ptr(^Node, P#x)))) || #p == $dot($ptr(^Tree, P#t), Tree.R) || $ts_eq(loopState#1, $s, #p)) && $timestamp_post(loopState#1, $s);
        assume $timestamp_post(loopState#1, $s);
        assume $full_stop_ext(#tok$1^167.3, $s);
        assume $local_value_is($s, #tok$1^167.3, #loc.res_lambda#6#19, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#6#19), $map_t($ptr_to(^Node), ^^bool));
        assume $local_value_is($s, #tok$1^167.3, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
        assume $local_value_is($s, #tok$1^167.3, #loc.owns#26, $ptrset_to_int(owns#26), ^$#ptrset);
        assume $local_value_is($s, #tok$1^167.3, #loc.staticWrapState#25, $state_to_int(staticWrapState#25), ^$#state_t);
        assume $local_value_is($s, #tok$1^167.3, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
        assume $local_value_is($s, #tok$1^167.3, #loc.res_lambda#5#18, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#5#18), $map_t($ptr_to(^Node), ^^bool));
        assume $local_value_is($s, #tok$1^167.3, #loc.res_lambda#4#17, $map_t..^^i4.^^i4_to_int(res_lambda#4#17), $map_t(^^i4, ^^i4));
        assume $local_value_is($s, #tok$1^167.3, #loc.assign#13, $ptr_to_int($ptr(^Node, assign#13)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^167.3, #loc.assign#13, $ptr(^Node, assign#13), $ptr_to(^Node));
        assume $local_value_is($s, #tok$1^167.3, #loc.assign#12, $ptr_to_int($ptr(^Node, assign#12)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^167.3, #loc.assign#12, $ptr(^Node, assign#12), $ptr_to(^Node));
        assume $local_value_is($s, #tok$1^167.3, #loc.prestate#24, $state_to_int(prestate#24), ^$#state_t);
        assume $local_value_is($s, #tok$1^167.3, #loc.n, $ptr_to_int($ptr(^Node, L#n)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^167.3, #loc.n, $ptr(^Node, L#n), $ptr_to(^Node));
        assume $local_value_is($s, #tok$1^167.3, #loc.x, $ptr_to_int($ptr(^Node, P#x)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^167.3, #loc.x, $ptr(^Node, P#x), $ptr_to(^Node));
        assume true;
        // if (true) ...
        if (true)
        {
          anon32:
            // assert @reads_check_normal((x->key)); 
            assert $typed2($s, $dot($ptr(^Node, P#x), Node.key), ^^i4);
            assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.key), ^^i4);
            // assert @reads_check_normal((p->key)); 
            assert $typed2($s, $dot($ptr(^Node, L#p), Node.key), ^^i4);
            assert $thread_local2($s, $dot($ptr(^Node, L#p), Node.key), ^^i4);
            assume true;
            // if (<(*((x->key)), *((p->key)))) ...
            if ($mem($s, $dot($ptr(^Node, P#x), Node.key)) < $mem($s, $dot($ptr(^Node, L#p), Node.key)))
            {
              anon26:
                // assert @reads_check_normal((p->left)); 
                assert $typed2($s, $dot($ptr(^Node, L#p), Node.left), $ptr_to(^Node));
                assert $thread_local2($s, $dot($ptr(^Node, L#p), Node.left), $ptr_to(^Node));
                // n := *((p->left)); 
                L#n := $ref($read_ptr($s, $dot($ptr(^Node, L#p), Node.left), ^Node));
                assume $local_value_is($s, #tok$1^179.7, #loc.n, $ptr_to_int($ptr(^Node, L#n)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^179.7, #loc.n, $ptr(^Node, L#n), $ptr_to(^Node));
                assume true;
                // if (@_vcc_ptr_eq(n, @null)) ...
                if ($ptr_eq($ptr(^Node, L#n), $null))
                {
                  anon24:
                    // _math ptrset owns#30; 
                    assume $local_value_is($s, #tok$2^0.0, #loc.owns#30, $ptrset_to_int(owns#30), ^$#ptrset);
                    // owns#30 := @_vcc_set_empty; 
                    owns#30 := $set_empty();
                    assume $local_value_is($s, #tok$2^0.0, #loc.owns#30, $ptrset_to_int(owns#30), ^$#ptrset);
                    // _math state_t prestate#29; 
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#29, $state_to_int(prestate#29), ^$#state_t);
                    // prestate#29 := @_vcc_current_state(@state); 
                    prestate#29 := $current_state($s);
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#29, $state_to_int(prestate#29), ^$#state_t);
                    // _math state_t prestate#31; 
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#31, $state_to_int(prestate#31), ^$#state_t);
                    // prestate#31 := @_vcc_current_state(@state); 
                    prestate#31 := $current_state($s);
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#31, $state_to_int(prestate#31), ^$#state_t);
                    // assert @_vcc_wrapped(@state, p); 
                    assert $wrapped($s, $ptr(^Node, L#p), ^Node);
                    // assert @writes_check(p); 
                    assert $top_writable($s, #wrTime$1^168.28, $ptr(^Node, L#p));
                    // assume @_vcc_inv(@state, p); 
                    assume $inv($s, $ptr(^Node, L#p), ^Node);
                    // assume ==(owns#30, @_vcc_owns(@state, p)); 
                    assume owns#30 == $owns($s, $ptr(^Node, L#p));
                    // assume @_vcc_pre_static_unwrap(@state); 
                    assume $pre_static_unwrap($s);
                    // @_vcc_static_unwrap(pure(p), prestate#31)
                    call $static_unwrap($ptr(^Node, L#p), prestate#31);
                    assume $good_state_ext(#tok$1^181.36, $s);
                    // assume @_vcc_full_stop(@state); 
                    assume $full_stop($s);
                    // assert @_vcc_typed2(@state, (p->left)); 
                    assert $typed2($s, $dot($ptr(^Node, L#p), Node.left), $ptr_to(^Node));
                    // assert @prim_writes_check((p->left)); 
                    assert $writable($s, #wrTime$1^168.28, $dot($ptr(^Node, L#p), Node.left));
                    // *(p->left) := x; 
                    call $write_int($dot($ptr(^Node, L#p), Node.left), $ref($ptr(^Node, P#x)));
                    assume $full_stop_ext(#tok$1^181.41, $s);
                    // _math state_t prestate#34; 
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#34, $state_to_int(prestate#34), ^$#state_t);
                    // prestate#34 := @_vcc_current_state(@state); 
                    prestate#34 := $current_state($s);
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#34, $state_to_int(prestate#34), ^$#state_t);
                    // _math state_t staticWrapState#32; 
                    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#32, $state_to_int(staticWrapState#32), ^$#state_t);
                    // staticWrapState#32 := @_vcc_current_state(@state); 
                    staticWrapState#32 := $current_state($s);
                    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#32, $state_to_int(staticWrapState#32), ^$#state_t);
                    // _math ptrset owns#33; 
                    assume $local_value_is($s, #tok$2^0.0, #loc.owns#33, $ptrset_to_int(owns#33), ^$#ptrset);
                    // owns#33 := @_vcc_set_empty; 
                    owns#33 := $set_empty();
                    assume $local_value_is($s, #tok$2^0.0, #loc.owns#33, $ptrset_to_int(owns#33), ^$#ptrset);
                    // assert @writes_check(p); 
                    assert $top_writable($s, #wrTime$1^168.28, $ptr(^Node, L#p));
                    // assume @_vcc_pre_static_wrap(@state); 
                    assume $pre_static_wrap($s);
                    // @_vcc_static_wrap(pure(p), staticWrapState#32, owns#33)
                    call $static_wrap($ptr(^Node, L#p), staticWrapState#32, owns#33);
                    assume $good_state_ext(#tok$1^181.36, $s);
                    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, p), @_vcc_set_empty)); 
                    assert $set_eq($owns($s, $ptr(^Node, L#p)), $set_empty());
                    // assume @_vcc_full_stop(@state); 
                    assume $full_stop($s);
                    // goto #break_11; 
                    goto #break_11;
                }
                else
                {
                  anon25:
                    // empty
                }
            }
            else
            {
              anon31:
                // assert @reads_check_normal((x->key)); 
                assert $typed2($s, $dot($ptr(^Node, P#x), Node.key), ^^i4);
                assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.key), ^^i4);
                // assert @reads_check_normal((p->key)); 
                assert $typed2($s, $dot($ptr(^Node, L#p), Node.key), ^^i4);
                assert $thread_local2($s, $dot($ptr(^Node, L#p), Node.key), ^^i4);
                assume true;
                // if (>(*((x->key)), *((p->key)))) ...
                if ($mem($s, $dot($ptr(^Node, P#x), Node.key)) > $mem($s, $dot($ptr(^Node, L#p), Node.key)))
                {
                  anon29:
                    // assert @reads_check_normal((p->right)); 
                    assert $typed2($s, $dot($ptr(^Node, L#p), Node.right), $ptr_to(^Node));
                    assert $thread_local2($s, $dot($ptr(^Node, L#p), Node.right), $ptr_to(^Node));
                    // n := *((p->right)); 
                    L#n := $ref($read_ptr($s, $dot($ptr(^Node, L#p), Node.right), ^Node));
                    assume $local_value_is($s, #tok$1^185.7, #loc.n, $ptr_to_int($ptr(^Node, L#n)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^185.7, #loc.n, $ptr(^Node, L#n), $ptr_to(^Node));
                    assume true;
                    // if (@_vcc_ptr_eq(n, @null)) ...
                    if ($ptr_eq($ptr(^Node, L#n), $null))
                    {
                      anon27:
                        // _math ptrset owns#36; 
                        assume $local_value_is($s, #tok$2^0.0, #loc.owns#36, $ptrset_to_int(owns#36), ^$#ptrset);
                        // owns#36 := @_vcc_set_empty; 
                        owns#36 := $set_empty();
                        assume $local_value_is($s, #tok$2^0.0, #loc.owns#36, $ptrset_to_int(owns#36), ^$#ptrset);
                        // _math state_t prestate#35; 
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#35, $state_to_int(prestate#35), ^$#state_t);
                        // prestate#35 := @_vcc_current_state(@state); 
                        prestate#35 := $current_state($s);
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#35, $state_to_int(prestate#35), ^$#state_t);
                        // _math state_t prestate#37; 
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#37, $state_to_int(prestate#37), ^$#state_t);
                        // prestate#37 := @_vcc_current_state(@state); 
                        prestate#37 := $current_state($s);
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#37, $state_to_int(prestate#37), ^$#state_t);
                        // assert @_vcc_wrapped(@state, p); 
                        assert $wrapped($s, $ptr(^Node, L#p), ^Node);
                        // assert @writes_check(p); 
                        assert $top_writable($s, #wrTime$1^168.28, $ptr(^Node, L#p));
                        // assume @_vcc_inv(@state, p); 
                        assume $inv($s, $ptr(^Node, L#p), ^Node);
                        // assume ==(owns#36, @_vcc_owns(@state, p)); 
                        assume owns#36 == $owns($s, $ptr(^Node, L#p));
                        // assume @_vcc_pre_static_unwrap(@state); 
                        assume $pre_static_unwrap($s);
                        // @_vcc_static_unwrap(pure(p), prestate#37)
                        call $static_unwrap($ptr(^Node, L#p), prestate#37);
                        assume $good_state_ext(#tok$1^187.36, $s);
                        // assume @_vcc_full_stop(@state); 
                        assume $full_stop($s);
                        // assert @_vcc_typed2(@state, (p->right)); 
                        assert $typed2($s, $dot($ptr(^Node, L#p), Node.right), $ptr_to(^Node));
                        // assert @prim_writes_check((p->right)); 
                        assert $writable($s, #wrTime$1^168.28, $dot($ptr(^Node, L#p), Node.right));
                        // *(p->right) := x; 
                        call $write_int($dot($ptr(^Node, L#p), Node.right), $ref($ptr(^Node, P#x)));
                        assume $full_stop_ext(#tok$1^187.41, $s);
                        // _math state_t prestate#40; 
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#40, $state_to_int(prestate#40), ^$#state_t);
                        // prestate#40 := @_vcc_current_state(@state); 
                        prestate#40 := $current_state($s);
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#40, $state_to_int(prestate#40), ^$#state_t);
                        // _math state_t staticWrapState#38; 
                        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#38, $state_to_int(staticWrapState#38), ^$#state_t);
                        // staticWrapState#38 := @_vcc_current_state(@state); 
                        staticWrapState#38 := $current_state($s);
                        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#38, $state_to_int(staticWrapState#38), ^$#state_t);
                        // _math ptrset owns#39; 
                        assume $local_value_is($s, #tok$2^0.0, #loc.owns#39, $ptrset_to_int(owns#39), ^$#ptrset);
                        // owns#39 := @_vcc_set_empty; 
                        owns#39 := $set_empty();
                        assume $local_value_is($s, #tok$2^0.0, #loc.owns#39, $ptrset_to_int(owns#39), ^$#ptrset);
                        // assert @writes_check(p); 
                        assert $top_writable($s, #wrTime$1^168.28, $ptr(^Node, L#p));
                        // assume @_vcc_pre_static_wrap(@state); 
                        assume $pre_static_wrap($s);
                        // @_vcc_static_wrap(pure(p), staticWrapState#38, owns#39)
                        call $static_wrap($ptr(^Node, L#p), staticWrapState#38, owns#39);
                        assume $good_state_ext(#tok$1^187.36, $s);
                        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, p), @_vcc_set_empty)); 
                        assert $set_eq($owns($s, $ptr(^Node, L#p)), $set_empty());
                        // assume @_vcc_full_stop(@state); 
                        assume $full_stop($s);
                        // goto #break_11; 
                        goto #break_11;
                    }
                    else
                    {
                      anon28:
                        // empty
                    }
                }
                else
                {
                  anon30:
                    // assert false; 
                    assert false;
                    // assume false; 
                    assume false;
                }
            }

          anon33:
            // assert doMark(p); 
            assert F#doMark($ref($ptr(^Node, L#p)));
            // assert doMark(n); 
            assert F#doMark($ref($ptr(^Node, L#n)));
            // assume &&(doMark(p), doMark(n)); 
            assume F#doMark($ref($ptr(^Node, L#p))) && F#doMark($ref($ptr(^Node, L#n)));
            // (struct Node* -> _Bool) res_lambda#7#20; 
            assume $local_value_is($s, #tok$1^194.37, #loc.res_lambda#7#20, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#7#20), $map_t($ptr_to(^Node), ^^bool));
            // assert @reads_check_normal((t->R)); 
            assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
            assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
            // res_lambda#7#20 := lambda#7(@map_get(*((t->R)), n), x); 
            call res_lambda#7#20 := lambda#7($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, L#n))), $ref($ptr(^Node, P#x)));
            assume $full_stop_ext(#tok$1^194.37, $s);
            assume $local_value_is($s, #tok$1^194.37, #loc.res_lambda#7#20, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#7#20), $map_t($ptr_to(^Node), ^^bool));
            // assert @_vcc_typed2(@state, (t->R)); 
            assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
            // assert @prim_writes_check((t->R)); 
            assert $writable($s, #wrTime$1^168.28, $dot($ptr(^Tree, P#t), Tree.R));
            // assert @reads_check_normal((t->R)); 
            assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
            assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
            // *(t->R) := @map_updated(*((t->R)), n, res_lambda#7#20); 
            call $write_int($dot($ptr(^Tree, P#t), Tree.R), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, L#n)), res_lambda#7#20)));
            assume $full_stop_ext(#tok$1^194.27, $s);
            // p := n; 
            L#p := $ref($ptr(^Node, L#n));
            assume $local_value_is($s, #tok$1^195.5, #loc.p, $ptr_to_int($ptr(^Node, L#p)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^195.5, #loc.p, $ptr(^Node, L#p), $ptr_to(^Node));
        }
        else
        {
          anon34:
            // goto #break_11; 
            goto #break_11;
        }

      #continue_11:
        assume true;
    }

  anon38:
    assume $full_stop_ext(#tok$1^167.3, $s);

  #break_11:
    // assert @_vcc_typed2(@state, (x->parent)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
    // assert @prim_writes_check((x->parent)); 
    assert $writable($s, #wrTime$1^134.1, $dot($ptr(^Node, P#x), Node.parent));
    // *(x->parent) := p; 
    call $write_int($dot($ptr(^Node, P#x), Node.parent), $ref($ptr(^Node, L#p)));
    assume $full_stop_ext(#tok$1^198.3, $s);
    // _math state_t prestate#43; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#43, $state_to_int(prestate#43), ^$#state_t);
    // prestate#43 := @_vcc_current_state(@state); 
    prestate#43 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#43, $state_to_int(prestate#43), ^$#state_t);
    // _math state_t staticWrapState#41; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#41, $state_to_int(staticWrapState#41), ^$#state_t);
    // staticWrapState#41 := @_vcc_current_state(@state); 
    staticWrapState#41 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#41, $state_to_int(staticWrapState#41), ^$#state_t);
    // _math ptrset owns#42; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#42, $ptrset_to_int(owns#42), ^$#ptrset);
    // owns#42 := @_vcc_set_empty; 
    owns#42 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#42, $ptrset_to_int(owns#42), ^$#ptrset);
    // assert @writes_check(x); 
    assert $top_writable($s, #wrTime$1^134.1, $ptr(^Node, P#x));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(x), staticWrapState#41, owns#42)
    call $static_wrap($ptr(^Node, P#x), staticWrapState#41, owns#42);
    assume $good_state_ext(#tok$1^199.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, x), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^Node, P#x)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#44; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#44, $state_to_int(prestate#44), ^$#state_t);
    // prestate#44 := @_vcc_current_state(@state); 
    prestate#44 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#44, $state_to_int(prestate#44), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(t); 
    assert $top_writable($s, #wrTime$1^134.1, $ptr(^Tree, P#t));
    // assert @writes_check(@_vcc_owns(@state, t)); 
    assert (forall #writes$1^200.19: $ptr :: { $dont_instantiate(#writes$1^200.19) } $set_in(#writes$1^200.19, $owns($s, $ptr(^Tree, P#t))) ==> $top_writable($s, #wrTime$1^134.1, #writes$1^200.19));
    // stmt @_vcc_wrap(t, @_vcc_typeof(t)); 
    call $wrap($ptr(^Tree, P#t), ^Tree);
    assume $good_state_ext(#tok$1^200.19, $s);
    // assert @inv_check(unchecked!(@map_get(@map_get(*((t->R)), *((t->root))), (struct Node*)@null))); 
    assert !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr_cast($null, ^Node)));
    // assert @inv_check(==>(@_vcc_ptr_neq(*((t->root)), @null), @map_get(@map_get(*((t->R)), *((t->root))), *((t->root))))); 
    assert $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
    // assert @inv_check(==>(@_vcc_ptr_neq(*((t->root)), @null), @_vcc_ptr_eq(*((*((t->root))->parent)), @null))); 
    assert $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), Node.parent), ^Node), $null);
    // assert @inv_check(forall(struct Node* m; @in_range_phys_ptr((mathint)m); unchecked!(@map_get(@map_get(*((t->R)), (struct Node*)@null), m)))); 
    assert (forall Q#m$1^82.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr_cast($null, ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->left))), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->left))), m), <(*((m->key)), *((n->key))))))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) < $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->right))), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->right))), m), >(*((m->key)), *((n->key))))))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) > $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
    // assert @inv_check(forall(struct Node* m; { @map_get(@map_get(*((t->R)), *((t->root))), m) } { mark2(m) } { @trigger_hint(mark2(m)) } @in_range_phys_ptr((mathint)m); ==(@map_get(@map_get(*((t->R)), *((t->root))), m), @_vcc_set_in(m, @_vcc_owns(@state, t))))); 
    assert (forall Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } { F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1))) } { sk_hack(F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) == $set_in($ptr(^Node, Q#m$1^82.29#dt1), $owns($s, $ptr(^Tree, P#t))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), m)))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), n)))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->left)), @null)), @map_get(@map_get(*((t->R)), n), *((n->left)))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->left)), @null)), @_vcc_ptr_eq(*((*((n->left))->parent)), n)))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->right)), @null)), @map_get(@map_get(*((t->R)), n), *((n->right)))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->right)), @null)), @_vcc_ptr_eq(*((*((n->right))->parent)), n)))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->parent)), @null)), @map_get(@map_get(*((t->R)), *((t->root))), *((n->parent)))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->parent)), @null)), ||(@_vcc_ptr_eq(*((*((n->parent))->left)), n), @_vcc_ptr_eq(*((*((n->parent))->right)), n))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.left), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)) || $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.right), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
    // assert @inv_check(forall(struct Node* n; { @map_get(@map_get(*((t->R)), *((t->root))), n) } @in_range_phys_ptr((mathint)n); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), @map_get(@map_get(*((t->R)), n), n)))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
    // assert @inv_check(true); 
    assert true;
    // assert @inv_check(forall(struct Node* m; { @map_get(*((t->abs)), *((m->key))) } @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), ==(@map_get(*((t->abs)), *((m->key))), *((m->value)))))); 
    assert (forall Q#m$1^83.29#dt1: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) == $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.value)));
    // assert @inv_check(forall(int32_t k; { @map_get(*((t->abs)), k) } @in_range_i4(k); ==>(forall(struct Node* m; @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), !=(*((m->key)), k))), ==(@map_get(*((t->abs)), k), 0)))); 
    assert (forall Q#k$1^83.29#tc2: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), Q#k$1^83.29#tc2) == 0);
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_eq(*((mark(n)->parent)), @null)), ||(@_vcc_ptr_eq(n, (struct Node*)@null), @_vcc_ptr_eq(n, *((t->root))))))); 
    assert (forall Q#n$1^84.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && $ptr_eq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) || $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), mark(n)), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==(@map_get(@map_get(*((t->R)), mark(n)), m), &&(@map_get(@map_get(*((t->R)), *((t->root))), n), ||(||(||(&&(@_vcc_ptr_eq(n, (struct Node*)@null), @_vcc_ptr_eq(m, (struct Node*)@null)), @_vcc_ptr_eq(m, n)), @map_get(@map_get(*((t->R)), *((n->left))), m)), @map_get(@map_get(*((t->R)), *((n->right))), m)))))); 
    assert (forall Q#n$1^84.29#dt1: int, Q#m$1^84.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && (($ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) && $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr_cast($null, ^Node))) || $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr(^Node, Q#n$1^84.29#dt1)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure left_rotate(P#t: int, P#x: int);
  requires $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, P#x)));
  requires $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#x), Node.right), ^Node), $null);
  requires $wrapped($s, $ptr(^Tree, P#t), ^Tree);
  modifies $s, $cev_pc;
  ensures $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(old($s), $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr(old($s), $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)))) && $eq.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem(old($s), $dot($ptr(^Tree, P#t), Tree.abs))), $int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))));
  ensures $wrapped($s, $ptr(^Tree, P#t), ^Tree);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Tree, P#t) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Tree, P#t) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Tree, P#t) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation left_rotate(P#t: int, P#x: int)
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
  var L#y: int where $in_range_phys_ptr(L#y);
  var #wrTime$1^203.1: int;
  var #stackframe: int;

  anon46:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^203.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^203.1, #loc.t, $ptr_to_int($ptr(^Tree, P#t)), $ptr_to(^Tree)) && $local_value_is_ptr($s, #tok$1^203.1, #loc.t, $ptr(^Tree, P#t), $ptr_to(^Tree));
    assume $local_value_is($s, #tok$1^203.1, #loc.x, $ptr_to_int($ptr(^Node, P#x)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^203.1, #loc.x, $ptr(^Node, P#x), $ptr_to(^Node));
    assume #wrTime$1^203.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^203.1, #p) } $in_writes_at(#wrTime$1^203.1, #p) == (#p == $ptr(^Tree, P#t)));
    assume $thread_owned($s, $ptr(^Tree, P#t));
    // assume @in_range_phys_ptr((mathint)t); 
    assume $in_range_phys_ptr($ref($ptr(^Tree, P#t)));
    // assume @in_range_phys_ptr((mathint)x); 
    assume $in_range_phys_ptr($ref($ptr(^Node, P#x)));
    // assert @_vcc_in_domain(@state, t, t); 
    assert $in_domain_lab($s, $ptr(^Tree, P#t), $ptr(^Tree, P#t), l#public);
    // struct Node* y; 
    assume $local_value_is($s, #tok$1^209.3, #loc.y, $ptr_to_int($ptr(^Node, L#y)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^209.3, #loc.y, $ptr(^Node, L#y), $ptr_to(^Node));
    // var struct Node* y
    // _math state_t prestate#45; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#45, $state_to_int(prestate#45), ^$#state_t);
    // prestate#45 := @_vcc_current_state(@state); 
    prestate#45 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#45, $state_to_int(prestate#45), ^$#state_t);
    // assert @_vcc_wrapped(@state, t); 
    assert $wrapped($s, $ptr(^Tree, P#t), ^Tree);
    // assume @_vcc_inv(@state, t); 
    assume $inv($s, $ptr(^Tree, P#t), ^Tree);
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(t); 
    assert $top_writable($s, #wrTime$1^203.1, $ptr(^Tree, P#t));
    // stmt @_vcc_unwrap(t, @_vcc_typeof(t)); 
    call $unwrap($ptr(^Tree, P#t), ^Tree);
    assume $good_state_ext(#tok$1^211.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert doMark(x); 
    assert F#doMark($ref($ptr(^Node, P#x)));
    // assume doMark(x); 
    assume F#doMark($ref($ptr(^Node, P#x)));
    // _math ptrset owns#47; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#47, $ptrset_to_int(owns#47), ^$#ptrset);
    // owns#47 := @_vcc_set_empty; 
    owns#47 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#47, $ptrset_to_int(owns#47), ^$#ptrset);
    // _math state_t prestate#46; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#46, $state_to_int(prestate#46), ^$#state_t);
    // prestate#46 := @_vcc_current_state(@state); 
    prestate#46 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#46, $state_to_int(prestate#46), ^$#state_t);
    // _math state_t prestate#48; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#48, $state_to_int(prestate#48), ^$#state_t);
    // prestate#48 := @_vcc_current_state(@state); 
    prestate#48 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#48, $state_to_int(prestate#48), ^$#state_t);
    // assert @_vcc_wrapped(@state, x); 
    assert $wrapped($s, $ptr(^Node, P#x), ^Node);
    // assert @writes_check(x); 
    assert $top_writable($s, #wrTime$1^203.1, $ptr(^Node, P#x));
    // assume @_vcc_inv(@state, x); 
    assume $inv($s, $ptr(^Node, P#x), ^Node);
    // assume ==(owns#47, @_vcc_owns(@state, x)); 
    assume owns#47 == $owns($s, $ptr(^Node, P#x));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(x), prestate#48)
    call $static_unwrap($ptr(^Node, P#x), prestate#48);
    assume $good_state_ext(#tok$1^212.53, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @reads_check_normal((x->right)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.right), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.right), $ptr_to(^Node));
    // y := *((x->right)); 
    L#y := $ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.right), ^Node));
    assume $local_value_is($s, #tok$1^213.3, #loc.y, $ptr_to_int($ptr(^Node, L#y)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^213.3, #loc.y, $ptr(^Node, L#y), $ptr_to(^Node));
    // assert doMark(y); 
    assert F#doMark($ref($ptr(^Node, L#y)));
    // assume doMark(y); 
    assume F#doMark($ref($ptr(^Node, L#y)));
    // _math ptrset owns#50; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#50, $ptrset_to_int(owns#50), ^$#ptrset);
    // owns#50 := @_vcc_set_empty; 
    owns#50 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#50, $ptrset_to_int(owns#50), ^$#ptrset);
    // _math state_t prestate#49; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#49, $state_to_int(prestate#49), ^$#state_t);
    // prestate#49 := @_vcc_current_state(@state); 
    prestate#49 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#49, $state_to_int(prestate#49), ^$#state_t);
    // _math state_t prestate#51; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#51, $state_to_int(prestate#51), ^$#state_t);
    // prestate#51 := @_vcc_current_state(@state); 
    prestate#51 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#51, $state_to_int(prestate#51), ^$#state_t);
    // assert @_vcc_wrapped(@state, y); 
    assert $wrapped($s, $ptr(^Node, L#y), ^Node);
    // assert @writes_check(y); 
    assert $top_writable($s, #wrTime$1^203.1, $ptr(^Node, L#y));
    // assume @_vcc_inv(@state, y); 
    assume $inv($s, $ptr(^Node, L#y), ^Node);
    // assume ==(owns#50, @_vcc_owns(@state, y)); 
    assume owns#50 == $owns($s, $ptr(^Node, L#y));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(y), prestate#51)
    call $static_unwrap($ptr(^Node, L#y), prestate#51);
    assume $good_state_ext(#tok$1^214.53, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (x->right)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.right), $ptr_to(^Node));
    // assert @prim_writes_check((x->right)); 
    assert $writable($s, #wrTime$1^203.1, $dot($ptr(^Node, P#x), Node.right));
    // assert @reads_check_normal((y->left)); 
    assert $typed2($s, $dot($ptr(^Node, L#y), Node.left), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, L#y), Node.left), $ptr_to(^Node));
    // *(x->right) := *((y->left)); 
    call $write_int($dot($ptr(^Node, P#x), Node.right), $ref($read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node)));
    assume $full_stop_ext(#tok$1^216.3, $s);
    // assert @reads_check_normal((y->left)); 
    assert $typed2($s, $dot($ptr(^Node, L#y), Node.left), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, L#y), Node.left), $ptr_to(^Node));
    assume true;
    // if (@_vcc_ptr_neq(*((y->left)), @null)) ...
    if ($ptr_neq($read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node), $null))
    {
      anon39:
        // _math ptrset owns#53; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#53, $ptrset_to_int(owns#53), ^$#ptrset);
        // owns#53 := @_vcc_set_empty; 
        owns#53 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#53, $ptrset_to_int(owns#53), ^$#ptrset);
        // _math state_t prestate#52; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#52, $state_to_int(prestate#52), ^$#state_t);
        // prestate#52 := @_vcc_current_state(@state); 
        prestate#52 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#52, $state_to_int(prestate#52), ^$#state_t);
        // _math state_t prestate#54; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#54, $state_to_int(prestate#54), ^$#state_t);
        // prestate#54 := @_vcc_current_state(@state); 
        prestate#54 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#54, $state_to_int(prestate#54), ^$#state_t);
        // assert @_vcc_wrapped(@state, *((y->left))); 
        assert $wrapped($s, $read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node), ^Node);
        // assert @writes_check(*((y->left))); 
        assert $top_writable($s, #wrTime$1^203.1, $read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node));
        // assume @_vcc_inv(@state, *((y->left))); 
        assume $inv($s, $read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node), ^Node);
        // assume ==(owns#53, @_vcc_owns(@state, *((y->left)))); 
        assume owns#53 == $owns($s, $read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node));
        // assume @_vcc_pre_static_unwrap(@state); 
        assume $pre_static_unwrap($s);
        // @_vcc_static_unwrap(pure(*((y->left))), prestate#54)
        call $static_unwrap($read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node), prestate#54);
        assume $good_state_ext(#tok$1^218.34, $s);
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // assert @_vcc_typed2(@state, (*((y->left))->parent)); 
        assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node), Node.parent), $ptr_to(^Node));
        // assert @prim_writes_check((*((y->left))->parent)); 
        assert $writable($s, #wrTime$1^203.1, $dot($read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node), Node.parent));
        // assert @reads_check_normal((y->left)); 
        assert $typed2($s, $dot($ptr(^Node, L#y), Node.left), $ptr_to(^Node));
        assert $thread_local2($s, $dot($ptr(^Node, L#y), Node.left), $ptr_to(^Node));
        // *(*((y->left))->parent) := x; 
        call $write_int($dot($read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node), Node.parent), $ref($ptr(^Node, P#x)));
        assume $full_stop_ext(#tok$1^218.43, $s);
        // _math state_t prestate#57; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#57, $state_to_int(prestate#57), ^$#state_t);
        // prestate#57 := @_vcc_current_state(@state); 
        prestate#57 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#57, $state_to_int(prestate#57), ^$#state_t);
        // _math state_t staticWrapState#55; 
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#55, $state_to_int(staticWrapState#55), ^$#state_t);
        // staticWrapState#55 := @_vcc_current_state(@state); 
        staticWrapState#55 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#55, $state_to_int(staticWrapState#55), ^$#state_t);
        // _math ptrset owns#56; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#56, $ptrset_to_int(owns#56), ^$#ptrset);
        // owns#56 := @_vcc_set_empty; 
        owns#56 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#56, $ptrset_to_int(owns#56), ^$#ptrset);
        // assert @writes_check(*((y->left))); 
        assert $top_writable($s, #wrTime$1^203.1, $read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(*((y->left))), staticWrapState#55, owns#56)
        call $static_wrap($read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node), staticWrapState#55, owns#56);
        assume $good_state_ext(#tok$1^218.34, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((y->left))), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $read_ptr($s, $dot($ptr(^Node, L#y), Node.left), ^Node)), $set_empty());
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
    }
    else
    {
      anon40:
        // empty
    }

  anon47:
    // assert @_vcc_typed2(@state, (y->parent)); 
    assert $typed2($s, $dot($ptr(^Node, L#y), Node.parent), $ptr_to(^Node));
    // assert @prim_writes_check((y->parent)); 
    assert $writable($s, #wrTime$1^203.1, $dot($ptr(^Node, L#y), Node.parent));
    // assert @reads_check_normal((x->parent)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
    // *(y->parent) := *((x->parent)); 
    call $write_int($dot($ptr(^Node, L#y), Node.parent), $ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node)));
    assume $full_stop_ext(#tok$1^219.3, $s);
    // assert @reads_check_normal((x->parent)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
    assume true;
    // if (@_vcc_ptr_eq(*((x->parent)), @null)) ...
    if ($ptr_eq($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), $null))
    {
      anon41:
        // assert @_vcc_typed2(@state, (t->root)); 
        assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.root), $ptr_to(^Node));
        // assert @prim_writes_check((t->root)); 
        assert $writable($s, #wrTime$1^203.1, $dot($ptr(^Tree, P#t), Tree.root));
        // *(t->root) := y; 
        call $write_int($dot($ptr(^Tree, P#t), Tree.root), $ref($ptr(^Node, L#y)));
        assume $full_stop_ext(#tok$1^221.5, $s);
    }
    else
    {
      anon44:
        // assert doMark(*((x->parent))); 
        assert F#doMark($ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node)));
        // assume doMark(*((x->parent))); 
        assume F#doMark($ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node)));
        // _math ptrset owns#59; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#59, $ptrset_to_int(owns#59), ^$#ptrset);
        // owns#59 := @_vcc_set_empty; 
        owns#59 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#59, $ptrset_to_int(owns#59), ^$#ptrset);
        // _math state_t prestate#58; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#58, $state_to_int(prestate#58), ^$#state_t);
        // prestate#58 := @_vcc_current_state(@state); 
        prestate#58 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#58, $state_to_int(prestate#58), ^$#state_t);
        // _math state_t prestate#60; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#60, $state_to_int(prestate#60), ^$#state_t);
        // prestate#60 := @_vcc_current_state(@state); 
        prestate#60 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#60, $state_to_int(prestate#60), ^$#state_t);
        // assert @_vcc_wrapped(@state, *((x->parent))); 
        assert $wrapped($s, $read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), ^Node);
        // assert @writes_check(*((x->parent))); 
        assert $top_writable($s, #wrTime$1^203.1, $read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node));
        // assume @_vcc_inv(@state, *((x->parent))); 
        assume $inv($s, $read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), ^Node);
        // assume ==(owns#59, @_vcc_owns(@state, *((x->parent)))); 
        assume owns#59 == $owns($s, $read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node));
        // assume @_vcc_pre_static_unwrap(@state); 
        assume $pre_static_unwrap($s);
        // @_vcc_static_unwrap(pure(*((x->parent))), prestate#60)
        call $static_unwrap($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), prestate#60);
        assume $good_state_ext(#tok$1^224.32, $s);
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // assert @reads_check_normal((*((x->parent))->left)); 
        assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), Node.left), $ptr_to(^Node));
        assert $thread_local2($s, $dot($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), Node.left), $ptr_to(^Node));
        // assert @reads_check_normal((x->parent)); 
        assert $typed2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
        assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
        assume true;
        // if (@_vcc_ptr_eq(*((*((x->parent))->left)), x)) ...
        if ($ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), Node.left), ^Node), $ptr(^Node, P#x)))
        {
          anon42:
            // assert @_vcc_typed2(@state, (*((x->parent))->left)); 
            assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), Node.left), $ptr_to(^Node));
            // assert @prim_writes_check((*((x->parent))->left)); 
            assert $writable($s, #wrTime$1^203.1, $dot($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), Node.left));
            // assert @reads_check_normal((x->parent)); 
            assert $typed2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
            assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
            // *(*((x->parent))->left) := y; 
            call $write_int($dot($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), Node.left), $ref($ptr(^Node, L#y)));
            assume $full_stop_ext(#tok$1^226.9, $s);
        }
        else
        {
          anon43:
            // assert @_vcc_typed2(@state, (*((x->parent))->right)); 
            assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), Node.right), $ptr_to(^Node));
            // assert @prim_writes_check((*((x->parent))->right)); 
            assert $writable($s, #wrTime$1^203.1, $dot($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), Node.right));
            // assert @reads_check_normal((x->parent)); 
            assert $typed2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
            assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
            // *(*((x->parent))->right) := y; 
            call $write_int($dot($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), Node.right), $ref($ptr(^Node, L#y)));
            assume $full_stop_ext(#tok$1^228.9, $s);
        }

      anon45:
        // _math state_t prestate#63; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#63, $state_to_int(prestate#63), ^$#state_t);
        // prestate#63 := @_vcc_current_state(@state); 
        prestate#63 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#63, $state_to_int(prestate#63), ^$#state_t);
        // _math state_t staticWrapState#61; 
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#61, $state_to_int(staticWrapState#61), ^$#state_t);
        // staticWrapState#61 := @_vcc_current_state(@state); 
        staticWrapState#61 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#61, $state_to_int(staticWrapState#61), ^$#state_t);
        // _math ptrset owns#62; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#62, $ptrset_to_int(owns#62), ^$#ptrset);
        // owns#62 := @_vcc_set_empty; 
        owns#62 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#62, $ptrset_to_int(owns#62), ^$#ptrset);
        // assert @writes_check(*((x->parent))); 
        assert $top_writable($s, #wrTime$1^203.1, $read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(*((x->parent))), staticWrapState#61, owns#62)
        call $static_wrap($read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node), staticWrapState#61, owns#62);
        assume $good_state_ext(#tok$1^224.32, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((x->parent))), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $read_ptr($s, $dot($ptr(^Node, P#x), Node.parent), ^Node)), $set_empty());
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
    }

  anon48:
    // assert @_vcc_typed2(@state, (y->left)); 
    assert $typed2($s, $dot($ptr(^Node, L#y), Node.left), $ptr_to(^Node));
    // assert @prim_writes_check((y->left)); 
    assert $writable($s, #wrTime$1^203.1, $dot($ptr(^Node, L#y), Node.left));
    // *(y->left) := x; 
    call $write_int($dot($ptr(^Node, L#y), Node.left), $ref($ptr(^Node, P#x)));
    assume $full_stop_ext(#tok$1^231.3, $s);
    // assert @_vcc_typed2(@state, (x->parent)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.parent), $ptr_to(^Node));
    // assert @prim_writes_check((x->parent)); 
    assert $writable($s, #wrTime$1^203.1, $dot($ptr(^Node, P#x), Node.parent));
    // *(x->parent) := y; 
    call $write_int($dot($ptr(^Node, P#x), Node.parent), $ref($ptr(^Node, L#y)));
    assume $full_stop_ext(#tok$1^232.3, $s);
    // _math state_t prestate#66; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#66, $state_to_int(prestate#66), ^$#state_t);
    // prestate#66 := @_vcc_current_state(@state); 
    prestate#66 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#66, $state_to_int(prestate#66), ^$#state_t);
    // _math state_t staticWrapState#64; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#64, $state_to_int(staticWrapState#64), ^$#state_t);
    // staticWrapState#64 := @_vcc_current_state(@state); 
    staticWrapState#64 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#64, $state_to_int(staticWrapState#64), ^$#state_t);
    // _math ptrset owns#65; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#65, $ptrset_to_int(owns#65), ^$#ptrset);
    // owns#65 := @_vcc_set_empty; 
    owns#65 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#65, $ptrset_to_int(owns#65), ^$#ptrset);
    // assert @writes_check(x); 
    assert $top_writable($s, #wrTime$1^203.1, $ptr(^Node, P#x));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(x), staticWrapState#64, owns#65)
    call $static_wrap($ptr(^Node, P#x), staticWrapState#64, owns#65);
    assume $good_state_ext(#tok$1^233.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, x), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^Node, P#x)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#69; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#69, $state_to_int(prestate#69), ^$#state_t);
    // prestate#69 := @_vcc_current_state(@state); 
    prestate#69 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#69, $state_to_int(prestate#69), ^$#state_t);
    // _math state_t staticWrapState#67; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#67, $state_to_int(staticWrapState#67), ^$#state_t);
    // staticWrapState#67 := @_vcc_current_state(@state); 
    staticWrapState#67 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#67, $state_to_int(staticWrapState#67), ^$#state_t);
    // _math ptrset owns#68; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#68, $ptrset_to_int(owns#68), ^$#ptrset);
    // owns#68 := @_vcc_set_empty; 
    owns#68 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#68, $ptrset_to_int(owns#68), ^$#ptrset);
    // assert @writes_check(y); 
    assert $top_writable($s, #wrTime$1^203.1, $ptr(^Node, L#y));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(y), staticWrapState#67, owns#68)
    call $static_wrap($ptr(^Node, L#y), staticWrapState#67, owns#68);
    assume $good_state_ext(#tok$1^233.43, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, y), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^Node, L#y)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert doMark(*((x->right))); 
    assert F#doMark($ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.right), ^Node)));
    // assume doMark(*((x->right))); 
    assume F#doMark($ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.right), ^Node)));
    // assert forall(struct Node* m; { @trigger_hint(@map_get(@map_get(*((t->R)), y), m)) } { @map_get(@map_get(*((t->R)), *((x->right))), m) } @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((x->right))), m), >(*((m->key)), *((x->key))))); 
    assert (forall Q#m$1^236.26#dt1: int :: { sk_hack($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, L#y))), $ref($ptr(^Node, Q#m$1^236.26#dt1)))) } { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^236.26#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^236.26#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^236.26#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^236.26#dt1), Node.key)) > $mem($s, $dot($ptr(^Node, P#x), Node.key)));
    // assume forall(struct Node* m; { @trigger_hint(@map_get(@map_get(*((t->R)), y), m)) } { @map_get(@map_get(*((t->R)), *((x->right))), m) } @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((x->right))), m), >(*((m->key)), *((x->key))))); 
    assume (forall Q#m$1^236.26#dt1: int :: { sk_hack($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, L#y))), $ref($ptr(^Node, Q#m$1^236.26#dt1)))) } { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^236.26#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^236.26#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^236.26#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^236.26#dt1), Node.key)) > $mem($s, $dot($ptr(^Node, P#x), Node.key)));
    // assert @_vcc_typed2(@state, (t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @prim_writes_check((t->R)); 
    assert $writable($s, #wrTime$1^203.1, $dot($ptr(^Tree, P#t), Tree.R));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // *(t->R) := @map_updated(*((t->R)), y, @map_get(*((t->R)), x)); 
    call $write_int($dot($ptr(^Tree, P#t), Tree.R), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, L#y)), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, P#x))))));
    assume $full_stop_ext(#tok$1^239.5, $s);
    // (struct Node* -> _Bool) res_lambda#8#21; 
    assume $local_value_is($s, #tok$1^240.15, #loc.res_lambda#8#21, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#8#21), $map_t($ptr_to(^Node), ^^bool));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @reads_check_normal((x->right)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.right), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.right), $ptr_to(^Node));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @reads_check_normal((x->left)); 
    assert $typed2($s, $dot($ptr(^Node, P#x), Node.left), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, P#x), Node.left), $ptr_to(^Node));
    // res_lambda#8#21 := lambda#8(@map_get(*((t->R)), *((x->right))), @map_get(*((t->R)), *((x->left))), x); 
    call res_lambda#8#21 := lambda#8($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.right), ^Node))), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#x), Node.left), ^Node))), $ref($ptr(^Node, P#x)));
    assume $full_stop_ext(#tok$1^240.15, $s);
    assume $local_value_is($s, #tok$1^240.15, #loc.res_lambda#8#21, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#8#21), $map_t($ptr_to(^Node), ^^bool));
    // assert @_vcc_typed2(@state, (t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @prim_writes_check((t->R)); 
    assert $writable($s, #wrTime$1^203.1, $dot($ptr(^Tree, P#t), Tree.R));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // *(t->R) := @map_updated(*((t->R)), x, res_lambda#8#21); 
    call $write_int($dot($ptr(^Tree, P#t), Tree.R), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, P#x)), res_lambda#8#21)));
    assume $full_stop_ext(#tok$1^240.5, $s);
    // _math state_t prestate#70; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#70, $state_to_int(prestate#70), ^$#state_t);
    // prestate#70 := @_vcc_current_state(@state); 
    prestate#70 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#70, $state_to_int(prestate#70), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(t); 
    assert $top_writable($s, #wrTime$1^203.1, $ptr(^Tree, P#t));
    // assert @writes_check(@_vcc_owns(@state, t)); 
    assert (forall #writes$1^243.19: $ptr :: { $dont_instantiate(#writes$1^243.19) } $set_in(#writes$1^243.19, $owns($s, $ptr(^Tree, P#t))) ==> $top_writable($s, #wrTime$1^203.1, #writes$1^243.19));
    // stmt @_vcc_wrap(t, @_vcc_typeof(t)); 
    call $wrap($ptr(^Tree, P#t), ^Tree);
    assume $good_state_ext(#tok$1^243.19, $s);
    // assert @inv_check(unchecked!(@map_get(@map_get(*((t->R)), *((t->root))), (struct Node*)@null))); 
    assert !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr_cast($null, ^Node)));
    // assert @inv_check(==>(@_vcc_ptr_neq(*((t->root)), @null), @map_get(@map_get(*((t->R)), *((t->root))), *((t->root))))); 
    assert $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
    // assert @inv_check(==>(@_vcc_ptr_neq(*((t->root)), @null), @_vcc_ptr_eq(*((*((t->root))->parent)), @null))); 
    assert $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), Node.parent), ^Node), $null);
    // assert @inv_check(forall(struct Node* m; @in_range_phys_ptr((mathint)m); unchecked!(@map_get(@map_get(*((t->R)), (struct Node*)@null), m)))); 
    assert (forall Q#m$1^82.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr_cast($null, ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->left))), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->left))), m), <(*((m->key)), *((n->key))))))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) < $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->right))), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->right))), m), >(*((m->key)), *((n->key))))))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) > $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
    // assert @inv_check(forall(struct Node* m; { @map_get(@map_get(*((t->R)), *((t->root))), m) } { mark2(m) } { @trigger_hint(mark2(m)) } @in_range_phys_ptr((mathint)m); ==(@map_get(@map_get(*((t->R)), *((t->root))), m), @_vcc_set_in(m, @_vcc_owns(@state, t))))); 
    assert (forall Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } { F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1))) } { sk_hack(F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) == $set_in($ptr(^Node, Q#m$1^82.29#dt1), $owns($s, $ptr(^Tree, P#t))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), m)))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), n)))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->left)), @null)), @map_get(@map_get(*((t->R)), n), *((n->left)))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->left)), @null)), @_vcc_ptr_eq(*((*((n->left))->parent)), n)))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->right)), @null)), @map_get(@map_get(*((t->R)), n), *((n->right)))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->right)), @null)), @_vcc_ptr_eq(*((*((n->right))->parent)), n)))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->parent)), @null)), @map_get(@map_get(*((t->R)), *((t->root))), *((n->parent)))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->parent)), @null)), ||(@_vcc_ptr_eq(*((*((n->parent))->left)), n), @_vcc_ptr_eq(*((*((n->parent))->right)), n))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.left), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)) || $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.right), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
    // assert @inv_check(forall(struct Node* n; { @map_get(@map_get(*((t->R)), *((t->root))), n) } @in_range_phys_ptr((mathint)n); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), @map_get(@map_get(*((t->R)), n), n)))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
    // assert @inv_check(true); 
    assert true;
    // assert @inv_check(forall(struct Node* m; { @map_get(*((t->abs)), *((m->key))) } @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), ==(@map_get(*((t->abs)), *((m->key))), *((m->value)))))); 
    assert (forall Q#m$1^83.29#dt1: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) == $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.value)));
    // assert @inv_check(forall(int32_t k; { @map_get(*((t->abs)), k) } @in_range_i4(k); ==>(forall(struct Node* m; @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), !=(*((m->key)), k))), ==(@map_get(*((t->abs)), k), 0)))); 
    assert (forall Q#k$1^83.29#tc2: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), Q#k$1^83.29#tc2) == 0);
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_eq(*((mark(n)->parent)), @null)), ||(@_vcc_ptr_eq(n, (struct Node*)@null), @_vcc_ptr_eq(n, *((t->root))))))); 
    assert (forall Q#n$1^84.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && $ptr_eq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) || $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), mark(n)), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==(@map_get(@map_get(*((t->R)), mark(n)), m), &&(@map_get(@map_get(*((t->R)), *((t->root))), n), ||(||(||(&&(@_vcc_ptr_eq(n, (struct Node*)@null), @_vcc_ptr_eq(m, (struct Node*)@null)), @_vcc_ptr_eq(m, n)), @map_get(@map_get(*((t->R)), *((n->left))), m)), @map_get(@map_get(*((t->R)), *((n->right))), m)))))); 
    assert (forall Q#n$1^84.29#dt1: int, Q#m$1^84.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && (($ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) && $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr_cast($null, ^Node))) || $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr(^Node, Q#n$1^84.29#dt1)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure right_rotate(P#t: int, P#y: int);
  requires $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, P#y)));
  requires $ptr_neq($read_ptr($s, $dot($ptr(^Node, P#y), Node.left), ^Node), $null);
  requires $wrapped($s, $ptr(^Tree, P#t), ^Tree);
  modifies $s, $cev_pc;
  ensures $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem(old($s), $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr(old($s), $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)))) && $eq.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem(old($s), $dot($ptr(^Tree, P#t), Tree.abs))), $int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))));
  ensures $wrapped($s, $ptr(^Tree, P#t), ^Tree);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Tree, P#t) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Tree, P#t) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Tree, P#t) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation right_rotate(P#t: int, P#y: int)
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
  var L#x: int where $in_range_phys_ptr(L#x);
  var #wrTime$1^246.1: int;
  var #stackframe: int;

  anon56:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^246.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^246.1, #loc.t, $ptr_to_int($ptr(^Tree, P#t)), $ptr_to(^Tree)) && $local_value_is_ptr($s, #tok$1^246.1, #loc.t, $ptr(^Tree, P#t), $ptr_to(^Tree));
    assume $local_value_is($s, #tok$1^246.1, #loc.y, $ptr_to_int($ptr(^Node, P#y)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^246.1, #loc.y, $ptr(^Node, P#y), $ptr_to(^Node));
    assume #wrTime$1^246.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^246.1, #p) } $in_writes_at(#wrTime$1^246.1, #p) == (#p == $ptr(^Tree, P#t)));
    assume $thread_owned($s, $ptr(^Tree, P#t));
    // assume @in_range_phys_ptr((mathint)t); 
    assume $in_range_phys_ptr($ref($ptr(^Tree, P#t)));
    // assume @in_range_phys_ptr((mathint)y); 
    assume $in_range_phys_ptr($ref($ptr(^Node, P#y)));
    // assert @_vcc_in_domain(@state, t, t); 
    assert $in_domain_lab($s, $ptr(^Tree, P#t), $ptr(^Tree, P#t), l#public);
    // struct Node* x; 
    assume $local_value_is($s, #tok$1^252.3, #loc.x, $ptr_to_int($ptr(^Node, L#x)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^252.3, #loc.x, $ptr(^Node, L#x), $ptr_to(^Node));
    // var struct Node* x
    // _math state_t prestate#71; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#71, $state_to_int(prestate#71), ^$#state_t);
    // prestate#71 := @_vcc_current_state(@state); 
    prestate#71 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#71, $state_to_int(prestate#71), ^$#state_t);
    // assert @_vcc_wrapped(@state, t); 
    assert $wrapped($s, $ptr(^Tree, P#t), ^Tree);
    // assume @_vcc_inv(@state, t); 
    assume $inv($s, $ptr(^Tree, P#t), ^Tree);
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(t); 
    assert $top_writable($s, #wrTime$1^246.1, $ptr(^Tree, P#t));
    // stmt @_vcc_unwrap(t, @_vcc_typeof(t)); 
    call $unwrap($ptr(^Tree, P#t), ^Tree);
    assume $good_state_ext(#tok$1^254.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert doMark(y); 
    assert F#doMark($ref($ptr(^Node, P#y)));
    // assume doMark(y); 
    assume F#doMark($ref($ptr(^Node, P#y)));
    // _math ptrset owns#73; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#73, $ptrset_to_int(owns#73), ^$#ptrset);
    // owns#73 := @_vcc_set_empty; 
    owns#73 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#73, $ptrset_to_int(owns#73), ^$#ptrset);
    // _math state_t prestate#72; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#72, $state_to_int(prestate#72), ^$#state_t);
    // prestate#72 := @_vcc_current_state(@state); 
    prestate#72 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#72, $state_to_int(prestate#72), ^$#state_t);
    // _math state_t prestate#74; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#74, $state_to_int(prestate#74), ^$#state_t);
    // prestate#74 := @_vcc_current_state(@state); 
    prestate#74 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#74, $state_to_int(prestate#74), ^$#state_t);
    // assert @_vcc_wrapped(@state, y); 
    assert $wrapped($s, $ptr(^Node, P#y), ^Node);
    // assert @writes_check(y); 
    assert $top_writable($s, #wrTime$1^246.1, $ptr(^Node, P#y));
    // assume @_vcc_inv(@state, y); 
    assume $inv($s, $ptr(^Node, P#y), ^Node);
    // assume ==(owns#73, @_vcc_owns(@state, y)); 
    assume owns#73 == $owns($s, $ptr(^Node, P#y));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(y), prestate#74)
    call $static_unwrap($ptr(^Node, P#y), prestate#74);
    assume $good_state_ext(#tok$1^255.53, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @reads_check_normal((y->left)); 
    assert $typed2($s, $dot($ptr(^Node, P#y), Node.left), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, P#y), Node.left), $ptr_to(^Node));
    // x := *((y->left)); 
    L#x := $ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.left), ^Node));
    assume $local_value_is($s, #tok$1^256.3, #loc.x, $ptr_to_int($ptr(^Node, L#x)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^256.3, #loc.x, $ptr(^Node, L#x), $ptr_to(^Node));
    // assert doMark(x); 
    assert F#doMark($ref($ptr(^Node, L#x)));
    // assume doMark(x); 
    assume F#doMark($ref($ptr(^Node, L#x)));
    // _math ptrset owns#76; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#76, $ptrset_to_int(owns#76), ^$#ptrset);
    // owns#76 := @_vcc_set_empty; 
    owns#76 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#76, $ptrset_to_int(owns#76), ^$#ptrset);
    // _math state_t prestate#75; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#75, $state_to_int(prestate#75), ^$#state_t);
    // prestate#75 := @_vcc_current_state(@state); 
    prestate#75 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#75, $state_to_int(prestate#75), ^$#state_t);
    // _math state_t prestate#77; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#77, $state_to_int(prestate#77), ^$#state_t);
    // prestate#77 := @_vcc_current_state(@state); 
    prestate#77 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#77, $state_to_int(prestate#77), ^$#state_t);
    // assert @_vcc_wrapped(@state, x); 
    assert $wrapped($s, $ptr(^Node, L#x), ^Node);
    // assert @writes_check(x); 
    assert $top_writable($s, #wrTime$1^246.1, $ptr(^Node, L#x));
    // assume @_vcc_inv(@state, x); 
    assume $inv($s, $ptr(^Node, L#x), ^Node);
    // assume ==(owns#76, @_vcc_owns(@state, x)); 
    assume owns#76 == $owns($s, $ptr(^Node, L#x));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(x), prestate#77)
    call $static_unwrap($ptr(^Node, L#x), prestate#77);
    assume $good_state_ext(#tok$1^257.53, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (y->left)); 
    assert $typed2($s, $dot($ptr(^Node, P#y), Node.left), $ptr_to(^Node));
    // assert @prim_writes_check((y->left)); 
    assert $writable($s, #wrTime$1^246.1, $dot($ptr(^Node, P#y), Node.left));
    // assert @reads_check_normal((x->right)); 
    assert $typed2($s, $dot($ptr(^Node, L#x), Node.right), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, L#x), Node.right), $ptr_to(^Node));
    // *(y->left) := *((x->right)); 
    call $write_int($dot($ptr(^Node, P#y), Node.left), $ref($read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node)));
    assume $full_stop_ext(#tok$1^259.3, $s);
    // assert @reads_check_normal((x->right)); 
    assert $typed2($s, $dot($ptr(^Node, L#x), Node.right), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, L#x), Node.right), $ptr_to(^Node));
    assume true;
    // if (@_vcc_ptr_neq(*((x->right)), @null)) ...
    if ($ptr_neq($read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node), $null))
    {
      anon49:
        // _math ptrset owns#79; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#79, $ptrset_to_int(owns#79), ^$#ptrset);
        // owns#79 := @_vcc_set_empty; 
        owns#79 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#79, $ptrset_to_int(owns#79), ^$#ptrset);
        // _math state_t prestate#78; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#78, $state_to_int(prestate#78), ^$#state_t);
        // prestate#78 := @_vcc_current_state(@state); 
        prestate#78 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#78, $state_to_int(prestate#78), ^$#state_t);
        // _math state_t prestate#80; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#80, $state_to_int(prestate#80), ^$#state_t);
        // prestate#80 := @_vcc_current_state(@state); 
        prestate#80 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#80, $state_to_int(prestate#80), ^$#state_t);
        // assert @_vcc_wrapped(@state, *((x->right))); 
        assert $wrapped($s, $read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node), ^Node);
        // assert @writes_check(*((x->right))); 
        assert $top_writable($s, #wrTime$1^246.1, $read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node));
        // assume @_vcc_inv(@state, *((x->right))); 
        assume $inv($s, $read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node), ^Node);
        // assume ==(owns#79, @_vcc_owns(@state, *((x->right)))); 
        assume owns#79 == $owns($s, $read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node));
        // assume @_vcc_pre_static_unwrap(@state); 
        assume $pre_static_unwrap($s);
        // @_vcc_static_unwrap(pure(*((x->right))), prestate#80)
        call $static_unwrap($read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node), prestate#80);
        assume $good_state_ext(#tok$1^261.34, $s);
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // assert @_vcc_typed2(@state, (*((x->right))->parent)); 
        assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node), Node.parent), $ptr_to(^Node));
        // assert @prim_writes_check((*((x->right))->parent)); 
        assert $writable($s, #wrTime$1^246.1, $dot($read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node), Node.parent));
        // assert @reads_check_normal((x->right)); 
        assert $typed2($s, $dot($ptr(^Node, L#x), Node.right), $ptr_to(^Node));
        assert $thread_local2($s, $dot($ptr(^Node, L#x), Node.right), $ptr_to(^Node));
        // *(*((x->right))->parent) := y; 
        call $write_int($dot($read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node), Node.parent), $ref($ptr(^Node, P#y)));
        assume $full_stop_ext(#tok$1^261.44, $s);
        // _math state_t prestate#83; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#83, $state_to_int(prestate#83), ^$#state_t);
        // prestate#83 := @_vcc_current_state(@state); 
        prestate#83 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#83, $state_to_int(prestate#83), ^$#state_t);
        // _math state_t staticWrapState#81; 
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#81, $state_to_int(staticWrapState#81), ^$#state_t);
        // staticWrapState#81 := @_vcc_current_state(@state); 
        staticWrapState#81 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#81, $state_to_int(staticWrapState#81), ^$#state_t);
        // _math ptrset owns#82; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#82, $ptrset_to_int(owns#82), ^$#ptrset);
        // owns#82 := @_vcc_set_empty; 
        owns#82 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#82, $ptrset_to_int(owns#82), ^$#ptrset);
        // assert @writes_check(*((x->right))); 
        assert $top_writable($s, #wrTime$1^246.1, $read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(*((x->right))), staticWrapState#81, owns#82)
        call $static_wrap($read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node), staticWrapState#81, owns#82);
        assume $good_state_ext(#tok$1^261.34, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((x->right))), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $read_ptr($s, $dot($ptr(^Node, L#x), Node.right), ^Node)), $set_empty());
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
    }
    else
    {
      anon50:
        // empty
    }

  anon57:
    // assert @_vcc_typed2(@state, (x->parent)); 
    assert $typed2($s, $dot($ptr(^Node, L#x), Node.parent), $ptr_to(^Node));
    // assert @prim_writes_check((x->parent)); 
    assert $writable($s, #wrTime$1^246.1, $dot($ptr(^Node, L#x), Node.parent));
    // assert @reads_check_normal((y->parent)); 
    assert $typed2($s, $dot($ptr(^Node, P#y), Node.parent), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, P#y), Node.parent), $ptr_to(^Node));
    // *(x->parent) := *((y->parent)); 
    call $write_int($dot($ptr(^Node, L#x), Node.parent), $ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node)));
    assume $full_stop_ext(#tok$1^262.3, $s);
    // assert @reads_check_normal((y->parent)); 
    assert $typed2($s, $dot($ptr(^Node, P#y), Node.parent), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, P#y), Node.parent), $ptr_to(^Node));
    assume true;
    // if (@_vcc_ptr_eq(*((y->parent)), @null)) ...
    if ($ptr_eq($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), $null))
    {
      anon51:
        // assert @_vcc_typed2(@state, (t->root)); 
        assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.root), $ptr_to(^Node));
        // assert @prim_writes_check((t->root)); 
        assert $writable($s, #wrTime$1^246.1, $dot($ptr(^Tree, P#t), Tree.root));
        // *(t->root) := x; 
        call $write_int($dot($ptr(^Tree, P#t), Tree.root), $ref($ptr(^Node, L#x)));
        assume $full_stop_ext(#tok$1^263.32, $s);
    }
    else
    {
      anon54:
        // assert doMark(*((y->parent))); 
        assert F#doMark($ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node)));
        // assume doMark(*((y->parent))); 
        assume F#doMark($ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node)));
        // _math ptrset owns#85; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#85, $ptrset_to_int(owns#85), ^$#ptrset);
        // owns#85 := @_vcc_set_empty; 
        owns#85 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#85, $ptrset_to_int(owns#85), ^$#ptrset);
        // _math state_t prestate#84; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#84, $state_to_int(prestate#84), ^$#state_t);
        // prestate#84 := @_vcc_current_state(@state); 
        prestate#84 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#84, $state_to_int(prestate#84), ^$#state_t);
        // _math state_t prestate#86; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#86, $state_to_int(prestate#86), ^$#state_t);
        // prestate#86 := @_vcc_current_state(@state); 
        prestate#86 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#86, $state_to_int(prestate#86), ^$#state_t);
        // assert @_vcc_wrapped(@state, *((y->parent))); 
        assert $wrapped($s, $read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), ^Node);
        // assert @writes_check(*((y->parent))); 
        assert $top_writable($s, #wrTime$1^246.1, $read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node));
        // assume @_vcc_inv(@state, *((y->parent))); 
        assume $inv($s, $read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), ^Node);
        // assume ==(owns#85, @_vcc_owns(@state, *((y->parent)))); 
        assume owns#85 == $owns($s, $read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node));
        // assume @_vcc_pre_static_unwrap(@state); 
        assume $pre_static_unwrap($s);
        // @_vcc_static_unwrap(pure(*((y->parent))), prestate#86)
        call $static_unwrap($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), prestate#86);
        assume $good_state_ext(#tok$1^266.32, $s);
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // assert @reads_check_normal((*((y->parent))->left)); 
        assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), Node.left), $ptr_to(^Node));
        assert $thread_local2($s, $dot($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), Node.left), $ptr_to(^Node));
        // assert @reads_check_normal((y->parent)); 
        assert $typed2($s, $dot($ptr(^Node, P#y), Node.parent), $ptr_to(^Node));
        assert $thread_local2($s, $dot($ptr(^Node, P#y), Node.parent), $ptr_to(^Node));
        assume true;
        // if (@_vcc_ptr_eq(*((*((y->parent))->left)), y)) ...
        if ($ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), Node.left), ^Node), $ptr(^Node, P#y)))
        {
          anon52:
            // assert @_vcc_typed2(@state, (*((y->parent))->left)); 
            assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), Node.left), $ptr_to(^Node));
            // assert @prim_writes_check((*((y->parent))->left)); 
            assert $writable($s, #wrTime$1^246.1, $dot($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), Node.left));
            // assert @reads_check_normal((y->parent)); 
            assert $typed2($s, $dot($ptr(^Node, P#y), Node.parent), $ptr_to(^Node));
            assert $thread_local2($s, $dot($ptr(^Node, P#y), Node.parent), $ptr_to(^Node));
            // *(*((y->parent))->left) := x; 
            call $write_int($dot($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), Node.left), $ref($ptr(^Node, L#x)));
            assume $full_stop_ext(#tok$1^268.9, $s);
        }
        else
        {
          anon53:
            // assert @_vcc_typed2(@state, (*((y->parent))->right)); 
            assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), Node.right), $ptr_to(^Node));
            // assert @prim_writes_check((*((y->parent))->right)); 
            assert $writable($s, #wrTime$1^246.1, $dot($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), Node.right));
            // assert @reads_check_normal((y->parent)); 
            assert $typed2($s, $dot($ptr(^Node, P#y), Node.parent), $ptr_to(^Node));
            assert $thread_local2($s, $dot($ptr(^Node, P#y), Node.parent), $ptr_to(^Node));
            // *(*((y->parent))->right) := x; 
            call $write_int($dot($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), Node.right), $ref($ptr(^Node, L#x)));
            assume $full_stop_ext(#tok$1^270.9, $s);
        }

      anon55:
        // _math state_t prestate#89; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#89, $state_to_int(prestate#89), ^$#state_t);
        // prestate#89 := @_vcc_current_state(@state); 
        prestate#89 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#89, $state_to_int(prestate#89), ^$#state_t);
        // _math state_t staticWrapState#87; 
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#87, $state_to_int(staticWrapState#87), ^$#state_t);
        // staticWrapState#87 := @_vcc_current_state(@state); 
        staticWrapState#87 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#87, $state_to_int(staticWrapState#87), ^$#state_t);
        // _math ptrset owns#88; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#88, $ptrset_to_int(owns#88), ^$#ptrset);
        // owns#88 := @_vcc_set_empty; 
        owns#88 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#88, $ptrset_to_int(owns#88), ^$#ptrset);
        // assert @writes_check(*((y->parent))); 
        assert $top_writable($s, #wrTime$1^246.1, $read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(*((y->parent))), staticWrapState#87, owns#88)
        call $static_wrap($read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node), staticWrapState#87, owns#88);
        assume $good_state_ext(#tok$1^266.32, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((y->parent))), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $read_ptr($s, $dot($ptr(^Node, P#y), Node.parent), ^Node)), $set_empty());
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
    }

  anon58:
    // assert @_vcc_typed2(@state, (x->right)); 
    assert $typed2($s, $dot($ptr(^Node, L#x), Node.right), $ptr_to(^Node));
    // assert @prim_writes_check((x->right)); 
    assert $writable($s, #wrTime$1^246.1, $dot($ptr(^Node, L#x), Node.right));
    // *(x->right) := y; 
    call $write_int($dot($ptr(^Node, L#x), Node.right), $ref($ptr(^Node, P#y)));
    assume $full_stop_ext(#tok$1^273.3, $s);
    // assert @_vcc_typed2(@state, (y->parent)); 
    assert $typed2($s, $dot($ptr(^Node, P#y), Node.parent), $ptr_to(^Node));
    // assert @prim_writes_check((y->parent)); 
    assert $writable($s, #wrTime$1^246.1, $dot($ptr(^Node, P#y), Node.parent));
    // *(y->parent) := x; 
    call $write_int($dot($ptr(^Node, P#y), Node.parent), $ref($ptr(^Node, L#x)));
    assume $full_stop_ext(#tok$1^274.3, $s);
    // _math state_t prestate#92; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#92, $state_to_int(prestate#92), ^$#state_t);
    // prestate#92 := @_vcc_current_state(@state); 
    prestate#92 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#92, $state_to_int(prestate#92), ^$#state_t);
    // _math state_t staticWrapState#90; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#90, $state_to_int(staticWrapState#90), ^$#state_t);
    // staticWrapState#90 := @_vcc_current_state(@state); 
    staticWrapState#90 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#90, $state_to_int(staticWrapState#90), ^$#state_t);
    // _math ptrset owns#91; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#91, $ptrset_to_int(owns#91), ^$#ptrset);
    // owns#91 := @_vcc_set_empty; 
    owns#91 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#91, $ptrset_to_int(owns#91), ^$#ptrset);
    // assert @writes_check(x); 
    assert $top_writable($s, #wrTime$1^246.1, $ptr(^Node, L#x));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(x), staticWrapState#90, owns#91)
    call $static_wrap($ptr(^Node, L#x), staticWrapState#90, owns#91);
    assume $good_state_ext(#tok$1^276.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, x), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^Node, L#x)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#95; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#95, $state_to_int(prestate#95), ^$#state_t);
    // prestate#95 := @_vcc_current_state(@state); 
    prestate#95 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#95, $state_to_int(prestate#95), ^$#state_t);
    // _math state_t staticWrapState#93; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#93, $state_to_int(staticWrapState#93), ^$#state_t);
    // staticWrapState#93 := @_vcc_current_state(@state); 
    staticWrapState#93 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#93, $state_to_int(staticWrapState#93), ^$#state_t);
    // _math ptrset owns#94; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#94, $ptrset_to_int(owns#94), ^$#ptrset);
    // owns#94 := @_vcc_set_empty; 
    owns#94 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#94, $ptrset_to_int(owns#94), ^$#ptrset);
    // assert @writes_check(y); 
    assert $top_writable($s, #wrTime$1^246.1, $ptr(^Node, P#y));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(y), staticWrapState#93, owns#94)
    call $static_wrap($ptr(^Node, P#y), staticWrapState#93, owns#94);
    assume $good_state_ext(#tok$1^276.43, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, y), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^Node, P#y)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert doMark(*((y->left))); 
    assert F#doMark($ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.left), ^Node)));
    // assume doMark(*((y->left))); 
    assume F#doMark($ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.left), ^Node)));
    // assert forall(struct Node* m; { @trigger_hint(@map_get(@map_get(*((t->R)), x), m)) } { @map_get(@map_get(*((t->R)), *((y->left))), m) } @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((y->left))), m), <(*((m->key)), *((y->key))))); 
    assert (forall Q#m$1^279.26#dt1: int :: { sk_hack($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, L#x))), $ref($ptr(^Node, Q#m$1^279.26#dt1)))) } { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^279.26#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^279.26#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^279.26#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^279.26#dt1), Node.key)) < $mem($s, $dot($ptr(^Node, P#y), Node.key)));
    // assume forall(struct Node* m; { @trigger_hint(@map_get(@map_get(*((t->R)), x), m)) } { @map_get(@map_get(*((t->R)), *((y->left))), m) } @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((y->left))), m), <(*((m->key)), *((y->key))))); 
    assume (forall Q#m$1^279.26#dt1: int :: { sk_hack($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, L#x))), $ref($ptr(^Node, Q#m$1^279.26#dt1)))) } { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^279.26#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^279.26#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^279.26#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^279.26#dt1), Node.key)) < $mem($s, $dot($ptr(^Node, P#y), Node.key)));
    // assert @_vcc_typed2(@state, (t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @prim_writes_check((t->R)); 
    assert $writable($s, #wrTime$1^246.1, $dot($ptr(^Tree, P#t), Tree.R));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // *(t->R) := @map_updated(*((t->R)), x, @map_get(*((t->R)), y)); 
    call $write_int($dot($ptr(^Tree, P#t), Tree.R), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, L#x)), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, P#y))))));
    assume $full_stop_ext(#tok$1^282.5, $s);
    // (struct Node* -> _Bool) res_lambda#9#22; 
    assume $local_value_is($s, #tok$1^283.15, #loc.res_lambda#9#22, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#9#22), $map_t($ptr_to(^Node), ^^bool));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @reads_check_normal((y->right)); 
    assert $typed2($s, $dot($ptr(^Node, P#y), Node.right), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, P#y), Node.right), $ptr_to(^Node));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @reads_check_normal((y->left)); 
    assert $typed2($s, $dot($ptr(^Node, P#y), Node.left), $ptr_to(^Node));
    assert $thread_local2($s, $dot($ptr(^Node, P#y), Node.left), $ptr_to(^Node));
    // res_lambda#9#22 := lambda#9(@map_get(*((t->R)), *((y->right))), @map_get(*((t->R)), *((y->left))), y); 
    call res_lambda#9#22 := lambda#9($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.right), ^Node))), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, P#y), Node.left), ^Node))), $ref($ptr(^Node, P#y)));
    assume $full_stop_ext(#tok$1^283.15, $s);
    assume $local_value_is($s, #tok$1^283.15, #loc.res_lambda#9#22, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#9#22), $map_t($ptr_to(^Node), ^^bool));
    // assert @_vcc_typed2(@state, (t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @prim_writes_check((t->R)); 
    assert $writable($s, #wrTime$1^246.1, $dot($ptr(^Tree, P#t), Tree.R));
    // assert @reads_check_normal((t->R)); 
    assert $typed2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    assert $thread_local2($s, $dot($ptr(^Tree, P#t), Tree.R), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // *(t->R) := @map_updated(*((t->R)), y, res_lambda#9#22); 
    call $write_int($dot($ptr(^Tree, P#t), Tree.R), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, P#y)), res_lambda#9#22)));
    assume $full_stop_ext(#tok$1^283.5, $s);
    // _math state_t prestate#96; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#96, $state_to_int(prestate#96), ^$#state_t);
    // prestate#96 := @_vcc_current_state(@state); 
    prestate#96 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#96, $state_to_int(prestate#96), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(t); 
    assert $top_writable($s, #wrTime$1^246.1, $ptr(^Tree, P#t));
    // assert @writes_check(@_vcc_owns(@state, t)); 
    assert (forall #writes$1^286.19: $ptr :: { $dont_instantiate(#writes$1^286.19) } $set_in(#writes$1^286.19, $owns($s, $ptr(^Tree, P#t))) ==> $top_writable($s, #wrTime$1^246.1, #writes$1^286.19));
    // stmt @_vcc_wrap(t, @_vcc_typeof(t)); 
    call $wrap($ptr(^Tree, P#t), ^Tree);
    assume $good_state_ext(#tok$1^286.19, $s);
    // assert @inv_check(unchecked!(@map_get(@map_get(*((t->R)), *((t->root))), (struct Node*)@null))); 
    assert !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr_cast($null, ^Node)));
    // assert @inv_check(==>(@_vcc_ptr_neq(*((t->root)), @null), @map_get(@map_get(*((t->R)), *((t->root))), *((t->root))))); 
    assert $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
    // assert @inv_check(==>(@_vcc_ptr_neq(*((t->root)), @null), @_vcc_ptr_eq(*((*((t->root))->parent)), @null))); 
    assert $ptr_neq($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node), Node.parent), ^Node), $null);
    // assert @inv_check(forall(struct Node* m; @in_range_phys_ptr((mathint)m); unchecked!(@map_get(@map_get(*((t->R)), (struct Node*)@null), m)))); 
    assert (forall Q#m$1^82.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr_cast($null, ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->left))), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->left))), m), <(*((m->key)), *((n->key))))))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) < $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->right))), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->right))), m), >(*((m->key)), *((n->key))))))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^82.29#dt1), Node.key)) > $mem($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.key)));
    // assert @inv_check(forall(struct Node* m; { @map_get(@map_get(*((t->R)), *((t->root))), m) } { mark2(m) } { @trigger_hint(mark2(m)) } @in_range_phys_ptr((mathint)m); ==(@map_get(@map_get(*((t->R)), *((t->root))), m), @_vcc_set_in(m, @_vcc_owns(@state, t))))); 
    assert (forall Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } { F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1))) } { sk_hack(F#mark2($ref($ptr(^Node, Q#m$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) == $set_in($ptr(^Node, Q#m$1^82.29#dt1), $owns($s, $ptr(^Tree, P#t))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), m)))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^82.29#dt1))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), n)))); 
    assert (forall Q#n$1^82.29#dt1: int, Q#m$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#m$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->left)), @null)), @map_get(@map_get(*((t->R)), n), *((n->left)))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->left)), @null)), @_vcc_ptr_eq(*((*((n->left))->parent)), n)))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.left), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.left), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->right)), @null)), @map_get(@map_get(*((t->R)), n), *((n->right)))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->right)), @null)), @_vcc_ptr_eq(*((*((n->right))->parent)), n)))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.right), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.right), ^Node), Node.parent), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->parent)), @null)), @map_get(@map_get(*((t->R)), *((t->root))), *((n->parent)))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node))));
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq(*((mark(n)->parent)), @null)), ||(@_vcc_ptr_eq(*((*((n->parent))->left)), n), @_vcc_ptr_eq(*((*((n->parent))->right)), n))))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^82.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.left), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)) || $ptr_eq($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Node, Q#n$1^82.29#dt1), Node.parent), ^Node), Node.right), ^Node), $ptr(^Node, Q#n$1^82.29#dt1)));
    // assert @inv_check(forall(struct Node* n; { @map_get(@map_get(*((t->R)), *((t->root))), n) } @in_range_phys_ptr((mathint)n); ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), @map_get(@map_get(*((t->R)), n), n)))); 
    assert (forall Q#n$1^82.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^82.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, Q#n$1^82.29#dt1))), $ref($ptr(^Node, Q#n$1^82.29#dt1))));
    // assert @inv_check(true); 
    assert true;
    // assert @inv_check(forall(struct Node* m; { @map_get(*((t->abs)), *((m->key))) } @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), ==(@map_get(*((t->abs)), *((m->key))), *((m->value)))))); 
    assert (forall Q#m$1^83.29#dt1: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key))) == $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.value)));
    // assert @inv_check(forall(int32_t k; { @map_get(*((t->abs)), k) } @in_range_i4(k); ==>(forall(struct Node* m; @in_range_phys_ptr((mathint)m); ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), !=(*((m->key)), k))), ==(@map_get(*((t->abs)), k), 0)))); 
    assert (forall Q#k$1^83.29#tc2: int :: { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#m$1^83.29#dt1))) ==> $mem($s, $dot($ptr(^Node, Q#m$1^83.29#dt1), Node.key)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($mem($s, $dot($ptr(^Tree, P#t), Tree.abs))), Q#k$1^83.29#tc2) == 0);
    // assert @inv_check(forall(struct Node* n; { mark(n) } @in_range_phys_ptr((mathint)n); ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_eq(*((mark(n)->parent)), @null)), ||(@_vcc_ptr_eq(n, (struct Node*)@null), @_vcc_ptr_eq(n, *((t->root))))))); 
    assert (forall Q#n$1^84.29#dt1: int :: { $ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && $ptr_eq($read_ptr($s, $dot($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))), Node.parent), ^Node), $null) ==> $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) || $ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), mark(n)), m) } &&(@in_range_phys_ptr((mathint)n), @in_range_phys_ptr((mathint)m)); ==(@map_get(@map_get(*((t->R)), mark(n)), m), &&(@map_get(@map_get(*((t->R)), *((t->root))), n), ||(||(||(&&(@_vcc_ptr_eq(n, (struct Node*)@null), @_vcc_ptr_eq(m, (struct Node*)@null)), @_vcc_ptr_eq(m, n)), @map_get(@map_get(*((t->R)), *((n->left))), m)), @map_get(@map_get(*((t->R)), *((n->right))), m)))))); 
    assert (forall Q#n$1^84.29#dt1: int, Q#m$1^84.29#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^84.29#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^84.29#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($ptr(^Node, F#mark($ref($ptr(^Node, Q#n$1^84.29#dt1)))))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Tree, P#t), Tree.root), ^Node))), $ref($ptr(^Node, Q#n$1^84.29#dt1))) && (($ptr_eq($ptr(^Node, Q#n$1^84.29#dt1), $ptr_cast($null, ^Node)) && $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr_cast($null, ^Node))) || $ptr_eq($ptr(^Node, Q#m$1^84.29#dt1), $ptr(^Node, Q#n$1^84.29#dt1)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.left), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($mem($s, $dot($ptr(^Tree, P#t), Tree.R))), $ref($read_ptr($s, $dot($ptr(^Node, Q#n$1^84.29#dt1), Node.right), ^Node))), $ref($ptr(^Node, Q#m$1^84.29#dt1))))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



function F#lambda#9(#l2: $map_t..$ptr_to..^Node.^^bool, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: int) : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#9: $pure_function;

axiom $function_arg_type(cf#lambda#9, 0, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#9, 1, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#9, 2, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#9, 3, $ptr_to(^Node));

procedure lambda#9(#l2: $map_t..$ptr_to..^Node.^^bool, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: int) returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#9(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#m$1^283.15#dt1: int, #l2: $map_t..$ptr_to..^Node.^^bool, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: int :: { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#9(#l2, #l1, $ref($ptr(^Node, #l0))), $ref($ptr(^Node, Q#m$1^283.15#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^283.15#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, #l0))) ==> $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#9(#l2, #l1, $ref($ptr(^Node, #l0))), $ref($ptr(^Node, Q#m$1^283.15#dt1))) == ($ptr_eq($ptr(^Node, Q#m$1^283.15#dt1), $ptr(^Node, #l0)) || $select.$map_t..$ptr_to..^Node.^^bool(#l1, $ref($ptr(^Node, Q#m$1^283.15#dt1))) || $select.$map_t..$ptr_to..^Node.^^bool(#l2, $ref($ptr(^Node, Q#m$1^283.15#dt1)))));

function F#lambda#8(#l2: $map_t..$ptr_to..^Node.^^bool, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: int) : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#8: $pure_function;

axiom $function_arg_type(cf#lambda#8, 0, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#8, 1, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#8, 2, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#8, 3, $ptr_to(^Node));

procedure lambda#8(#l2: $map_t..$ptr_to..^Node.^^bool, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: int) returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#8(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#m$1^240.15#dt1: int, #l2: $map_t..$ptr_to..^Node.^^bool, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: int :: { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#8(#l2, #l1, $ref($ptr(^Node, #l0))), $ref($ptr(^Node, Q#m$1^240.15#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^240.15#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, #l0))) ==> $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#8(#l2, #l1, $ref($ptr(^Node, #l0))), $ref($ptr(^Node, Q#m$1^240.15#dt1))) == ($ptr_eq($ptr(^Node, Q#m$1^240.15#dt1), $ptr(^Node, #l0)) || $select.$map_t..$ptr_to..^Node.^^bool(#l1, $ref($ptr(^Node, Q#m$1^240.15#dt1))) || $select.$map_t..$ptr_to..^Node.^^bool(#l2, $ref($ptr(^Node, Q#m$1^240.15#dt1)))));

function F#lambda#7(#l1: $map_t..$ptr_to..^Node.^^bool, #l0: int) : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#7: $pure_function;

axiom $function_arg_type(cf#lambda#7, 0, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#7, 1, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#7, 2, $ptr_to(^Node));

procedure lambda#7(#l1: $map_t..$ptr_to..^Node.^^bool, #l0: int) returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#7(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#k$1^194.37#dt1: int, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: int :: { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#7(#l1, $ref($ptr(^Node, #l0))), $ref($ptr(^Node, Q#k$1^194.37#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#k$1^194.37#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, #l0))) ==> $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#7(#l1, $ref($ptr(^Node, #l0))), $ref($ptr(^Node, Q#k$1^194.37#dt1))) == ($ptr_eq($ptr(^Node, Q#k$1^194.37#dt1), $ptr(^Node, #l0)) || $select.$map_t..$ptr_to..^Node.^^bool(#l1, $ref($ptr(^Node, Q#k$1^194.37#dt1)))));

function F#lambda#6(#l1: $map_t..$ptr_to..^Node.^^bool, #l0: int) : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#6: $pure_function;

axiom $function_arg_type(cf#lambda#6, 0, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#6, 1, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#6, 2, $ptr_to(^Node));

procedure lambda#6(#l1: $map_t..$ptr_to..^Node.^^bool, #l0: int) returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#6(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#n$1^163.41#dt1: int, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: int :: { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#6(#l1, $ref($ptr(^Node, #l0))), $ref($ptr(^Node, Q#n$1^163.41#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^163.41#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, #l0))) ==> $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#6(#l1, $ref($ptr(^Node, #l0))), $ref($ptr(^Node, Q#n$1^163.41#dt1))) == ($ptr_eq($ptr(^Node, Q#n$1^163.41#dt1), $ptr(^Node, #l0)) || $select.$map_t..$ptr_to..^Node.^^bool(#l1, $ref($ptr(^Node, Q#n$1^163.41#dt1)))));

function F#lambda#5(#l0: int) : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#5: $pure_function;

axiom $function_arg_type(cf#lambda#5, 0, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#5, 1, $ptr_to(^Node));

procedure lambda#5(#l0: int) returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#5(#l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#n$1^153.15#dt1: int, #l0: int :: { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#5($ref($ptr(^Node, #l0))), $ref($ptr(^Node, Q#n$1^153.15#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^153.15#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, #l0))) ==> $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#5($ref($ptr(^Node, #l0))), $ref($ptr(^Node, Q#n$1^153.15#dt1))) == $ptr_eq($ptr(^Node, Q#n$1^153.15#dt1), $ptr(^Node, #l0)));

function F#lambda#4(#l2: $map_t..^^i4.^^i4, #l1: int, #l0: int) : $map_t..^^i4.^^i4;

const unique cf#lambda#4: $pure_function;

axiom $function_arg_type(cf#lambda#4, 0, $map_t(^^i4, ^^i4));

axiom $function_arg_type(cf#lambda#4, 1, $map_t(^^i4, ^^i4));

axiom $function_arg_type(cf#lambda#4, 2, ^^i4);

axiom $function_arg_type(cf#lambda#4, 3, ^^i4);

procedure lambda#4(#l2: $map_t..^^i4.^^i4, #l1: int, #l0: int) returns ($result: $map_t..^^i4.^^i4);
  free ensures $result == F#lambda#4(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#k$1^151.14#tc2: int, #l2: $map_t..^^i4.^^i4, #l1: int, #l0: int :: { $select.$map_t..^^i4.^^i4(F#lambda#4(#l2, #l1, #l0), Q#k$1^151.14#tc2) } $in_range_i4(Q#k$1^151.14#tc2) && $in_range_i4(#l1) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^i4(F#lambda#4(#l2, #l1, #l0), Q#k$1^151.14#tc2) == (if Q#k$1^151.14#tc2 == #l0 then #l1 else $select.$map_t..^^i4.^^i4(#l2, Q#k$1^151.14#tc2)));

function F#lambda#3() : $map_t..^^i4.^^i4;

const unique cf#lambda#3: $pure_function;

axiom $function_arg_type(cf#lambda#3, 0, $map_t(^^i4, ^^i4));

procedure lambda#3() returns ($result: $map_t..^^i4.^^i4);
  free ensures $result == F#lambda#3();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#k$1^94.14#tc2: int :: { $select.$map_t..^^i4.^^i4(F#lambda#3(), Q#k$1^94.14#tc2) } $in_range_i4(Q#k$1^94.14#tc2) ==> $select.$map_t..^^i4.^^i4(F#lambda#3(), Q#k$1^94.14#tc2) == 0);

function F#lambda#2(#l0: $map_t..$ptr_to..^Node.^^bool) : $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#2: $pure_function;

axiom $function_arg_type(cf#lambda#2, 0, $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));

axiom $function_arg_type(cf#lambda#2, 1, $map_t($ptr_to(^Node), ^^bool));

procedure lambda#2(#l0: $map_t..$ptr_to..^Node.^^bool) returns ($result: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#2(#l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#m$1^93.12#dt1: int, #l0: $map_t..$ptr_to..^Node.^^bool :: { $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(F#lambda#2(#l0), $ref($ptr(^Node, Q#m$1^93.12#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#m$1^93.12#dt1))) ==> $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(F#lambda#2(#l0), $ref($ptr(^Node, Q#m$1^93.12#dt1))), #l0));

function F#lambda#1() : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#1: $pure_function;

axiom $function_arg_type(cf#lambda#1, 0, $map_t($ptr_to(^Node), ^^bool));

procedure lambda#1() returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#1();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#n$1^93.12#dt1: int :: { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#1(), $ref($ptr(^Node, Q#n$1^93.12#dt1))) } $in_range_phys_ptr($ref($ptr(^Node, Q#n$1^93.12#dt1))) ==> $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#1(), $ref($ptr(^Node, Q#n$1^93.12#dt1))) == false);

const unique l#public: $label;

type $map_t..$ptr_to..^Node.^^bool;

function $select.$map_t..$ptr_to..^Node.^^bool(M: $map_t..$ptr_to..^Node.^^bool, p: int) : bool;

function $store.$map_t..$ptr_to..^Node.^^bool(M: $map_t..$ptr_to..^Node.^^bool, p: int, v: bool) : $map_t..$ptr_to..^Node.^^bool;

function $eq.$map_t..$ptr_to..^Node.^^bool(M1: $map_t..$ptr_to..^Node.^^bool, M2: $map_t..$ptr_to..^Node.^^bool) : bool;

const $zero.$map_t..$ptr_to..^Node.^^bool: $map_t..$ptr_to..^Node.^^bool;

axiom (forall M: $map_t..$ptr_to..^Node.^^bool, p: int, v: bool :: $select.$map_t..$ptr_to..^Node.^^bool($store.$map_t..$ptr_to..^Node.^^bool(M, p, v), p) == v);

axiom (forall M: $map_t..$ptr_to..^Node.^^bool, p: int, v: bool, q: int :: p != q ==> $select.$map_t..$ptr_to..^Node.^^bool($store.$map_t..$ptr_to..^Node.^^bool(M, q, v), p) == $select.$map_t..$ptr_to..^Node.^^bool(M, p));

axiom (forall M1: $map_t..$ptr_to..^Node.^^bool, M2: $map_t..$ptr_to..^Node.^^bool :: { $eq.$map_t..$ptr_to..^Node.^^bool(M1, M2) } (forall p: int :: $select.$map_t..$ptr_to..^Node.^^bool(M1, p) == $select.$map_t..$ptr_to..^Node.^^bool(M2, p)) ==> $eq.$map_t..$ptr_to..^Node.^^bool(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^Node.^^bool, M2: $map_t..$ptr_to..^Node.^^bool :: { $eq.$map_t..$ptr_to..^Node.^^bool(M1, M2) } $eq.$map_t..$ptr_to..^Node.^^bool(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^Node.^^bool(0) == $zero.$map_t..$ptr_to..^Node.^^bool;

axiom (forall p: int :: $select.$map_t..$ptr_to..^Node.^^bool($zero.$map_t..$ptr_to..^Node.^^bool, p) == false);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t($ptr_to(^Node), ^^bool)) } $eq.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.^^bool($rec_fetch(r1, f)), $int_to_map_t..ptr_to..^Node.^^bool($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

type $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

function $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, p: int) : $map_t..$ptr_to..^Node.^^bool;

function $store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, p: int, v: $map_t..$ptr_to..^Node.^^bool) : $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

function $eq.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, M2: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool) : bool;

const $zero.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

axiom (forall M: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, p: int, v: $map_t..$ptr_to..^Node.^^bool :: $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M, p, v), p) == v);

axiom (forall M: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, p: int, v: $map_t..$ptr_to..^Node.^^bool, q: int :: p != q ==> $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M, q, v), p) == $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M, p));

axiom (forall M1: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, M2: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool :: { $eq.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1, M2) } (forall p: int :: $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1, p), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M2, p))) ==> $eq.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, M2: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool :: { $eq.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1, M2) } $eq.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool(0) == $zero.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

axiom (forall p: int :: $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($zero.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, p) == $zero.$map_t..$ptr_to..^Node.^^bool);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool))) } $eq.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rec_fetch(r1, f)), $int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

type $map_t..^^i4.^^i4;

function $select.$map_t..^^i4.^^i4(M: $map_t..^^i4.^^i4, p: int) : int;

function $store.$map_t..^^i4.^^i4(M: $map_t..^^i4.^^i4, p: int, v: int) : $map_t..^^i4.^^i4;

function $eq.$map_t..^^i4.^^i4(M1: $map_t..^^i4.^^i4, M2: $map_t..^^i4.^^i4) : bool;

const $zero.$map_t..^^i4.^^i4: $map_t..^^i4.^^i4;

axiom (forall M: $map_t..^^i4.^^i4, p: int, v: int :: $in_range_t(^^i4, p) ==> $select.$map_t..^^i4.^^i4($store.$map_t..^^i4.^^i4(M, p, v), p) == $unchecked(^^i4, v));

axiom (forall M: $map_t..^^i4.^^i4, p: int, v: int, q: int :: p != q ==> $select.$map_t..^^i4.^^i4($store.$map_t..^^i4.^^i4(M, q, v), p) == $select.$map_t..^^i4.^^i4(M, p));

axiom (forall M1: $map_t..^^i4.^^i4, M2: $map_t..^^i4.^^i4 :: { $eq.$map_t..^^i4.^^i4(M1, M2) } (forall p: int :: $in_range_t(^^i4, p) ==> $unchecked(^^i4, $select.$map_t..^^i4.^^i4(M1, p)) == $unchecked(^^i4, $select.$map_t..^^i4.^^i4(M2, p))) ==> $eq.$map_t..^^i4.^^i4(M1, M2));

axiom (forall M1: $map_t..^^i4.^^i4, M2: $map_t..^^i4.^^i4 :: { $eq.$map_t..^^i4.^^i4(M1, M2) } $eq.$map_t..^^i4.^^i4(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^i4.^^i4(0) == $zero.$map_t..^^i4.^^i4;

axiom (forall p: int :: $select.$map_t..^^i4.^^i4($zero.$map_t..^^i4.^^i4, p) == 0);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t(^^i4, ^^i4)) } $eq.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rec_fetch(r1, f)), $int_to_map_t..^^i4.^^i4($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

axiom (forall M: $map_t..^^i4.^^i4, p: int :: $in_range_t(^^i4, $select.$map_t..^^i4.^^i4(M, p)));

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

axiom $type_code_is(3, $ptr_to(^^void));

const unique #distTp6: $ctype;

axiom #distTp6 == $ptr_to(^^void);

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

axiom (forall #x: $map_t..$ptr_to..^Node.^^bool :: #x == $int_to_map_t..ptr_to..^Node.^^bool($map_t..ptr_to..^Node.^^bool_to_int(#x)));

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

axiom (forall #x: $map_t..^^i4.^^i4 :: #x == $int_to_map_t..^^i4.^^i4($map_t..^^i4.^^i4_to_int(#x)));

const unique #distTp4: $ctype;

axiom #distTp4 == $map_t(^^i4, ^^i4);

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvacid?2D0?5CRedBlackTrees.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvacid?2D0?5CRedBlackTrees.c);

function $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int(x: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool) : int;

function $int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool(x: int) : $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

axiom (forall #x: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool :: #x == $int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int(#x)));

const unique #distTp3: $ctype;

axiom #distTp3 == $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool));

const unique #distTp2: $ctype;

axiom #distTp2 == $map_t($ptr_to(^Node), ^^bool);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^Node);
