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
// for types for which $in_range_t(...) is defined
function $as_in_range_t($ctype) returns($ctype);


// -- sizeof bool, void, mathint uninterpreted

const unique ^$#thread_id_t: $ctype;
const unique ^$#ptrset : $ctype;
const unique ^$#state_t : $ctype;
const unique ^$#struct : $ctype;


// inverse functions here (unptr_to, map_domain, map_range) are for the prover
// so it knows that int*!=short*, i.e. * is injective

// pointers to types
function $ptr_to($ctype) returns($ctype);
function $spec_ptr_to($ctype) returns ($ctype);
function $unptr_to($ctype) returns($ctype);
function $ptr_level($ctype) returns(int);

const $arch_ptr_size : int; // arch-specific; to be defined by a compiler-generated axiom

function $map_t($ctype, $ctype) returns($ctype);
function $map_domain($ctype) returns($ctype);
function $map_range($ctype) returns($ctype);


// {:weight 0} makes it possible to trigger on $is_primitive(...)
// $is_primitive(t) should be only used when it is known that t is really
// primitive, i.e. not in a precondition or in a premise of an implication
// (unless guarded by a trigger). If it is unknown, use $is_primitive_ch(...).
// The same applies to $is_composite(...) and $is_arraytype(...).

function {:weight 0} $is_primitive(t:$ctype) returns(bool)
  { $kind_of(t) == $kind_primitive }

function {:inline true} $is_primitive_ch(t:$ctype) returns(bool)
  { $kind_of(t) == $kind_primitive }

function {:weight 0} $is_composite(t:$ctype) returns(bool);
//  { $kind_of(t) == $kind_composite }

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

function {:inline true} $is_non_primitive_ch(t:$ctype) returns(bool)
  { $kind_of(t) != $kind_primitive }

function {:inline true} $is_non_primitive_ptr(p:$ptr) returns(bool)
  { $is_non_primitive($typ(p)) }


const $me_ref : int;
function $me() returns($ptr);

function {:inline true} $current_state(s:$state) returns($state) { s }

type $memory_t;
function $select.mem($memory_t, $ptr) returns(int);
function $store.mem($memory_t, $ptr, int) returns($memory_t);
function $select_range.mem($memory_t, $ptr, int) returns(int);

type $typemap_t;
function $select.tm($typemap_t, $ptr) returns($type_state);
function $store.tm($typemap_t, $ptr, $type_state) returns($typemap_t);

type $statusmap_t;
function $select.sm($statusmap_t, $ptr) returns($status);
function $store.sm($statusmap_t, $ptr, $status) returns($statusmap_t);
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

// ----------------------------------------------------------------------------
// nesting of structs
// ----------------------------------------------------------------------------
function $extent_hint(p:$ptr, q:$ptr) returns(bool);

function $nesting_level($ctype) returns(int);
function $is_nested($ctype, $ctype) returns(bool);

function $nesting_min($ctype, $ctype) returns(int);
function $nesting_max($ctype, $ctype) returns(int);
function $is_nested_range(t:$ctype, s:$ctype, min:int, max:int) returns(bool)
  { $is_nested(t, s) && $nesting_min(t, s) == min && $nesting_max(t, s) == max }


// ----------------------------------------------------------------------------
// typed pointers
// ----------------------------------------------------------------------------

function $typ($ptr)returns($ctype);
function $ref($ptr)returns(int);
function $ptr($ctype,int)returns($ptr);
axiom (forall #t:$ctype, #b:int :: {:weight 0} $typ($ptr(#t,#b))==#t);
axiom (forall #t:$ctype, #b:int :: {:weight 0} $ref($ptr(#t,#b))==#b);

// Use for computing references for ghost fields, instead of saying p+$field_offset(f) we use
// $ghost_ref(p,f). This has an added bonus that the embedding and path can be the same reagrdless
// of the current $meta
function $ghost_ref($ptr, $field) returns(int);
function $ghost_emb(int) returns($ptr);
function $ghost_path(int) returns($field);

function $physical_ref(p:$ptr, f:$field) returns(int);

function $array_path(basefield:$field, off:int) returns($field);

function $is_base_field($field) returns(bool);

function $array_path_1($field) returns($field);
function $array_path_2($field) returns(int);

const $null:$ptr;
axiom $null == $ptr(^^void, 0);

//function {:inline true} $is(p:$ptr, t:$ctype) returns (bool)
//  { $typ(p)==t }

//typed pointer test
function $is($ptr,$ctype) returns (bool);
//axiom (forall #p:$ptr, #t:$ctype :: {:weight 0} $is(#p,#t)== ($typ(#p)==#t));
// create $ptr(...) function symbol, so later we have something to trigger on
//axiom (forall #p:$ptr, #t:$ctype :: {$is(#p, #t)} $is(#p, #t) ==> #p == $ptr(#t, $ref(#p)));

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

function $simple_emb(p:$ptr) returns($ptr);


// it has no further embedding (not embedded inside another struct)
function {:inline true} $is_object_root(S:$state, p:$ptr) returns(bool)
  { $emb(S, p) == $ptr(^^root_emb, $ref(p)) }

function {:inline true} $is_volatile(S:$state, p:$ptr) returns(bool)
  { $ts_is_volatile($ts(S, p)) }

// just tmp
function {:inline true} $is_malloc_root(S:$state, p:$ptr) returns(bool)
  { $is_object_root(S, p) }


function $current_timestamp(S:$state) returns(int);

function {:inline true} $is_fresh(M1:$state, M2:$state, p:$ptr) returns(bool)
  { $current_timestamp(M1) < $timestamp(M2, p) && $timestamp(M2, p) <= $current_timestamp(M2) }

function $in_writes_at(time:int, p:$ptr) returns(bool);

function {:inline true} $writable(S:$state, begin_time:int, p:$ptr) returns(bool)
  { ($in_writes_at(begin_time, p) || $timestamp(S, p) >= begin_time) && $mutable(S, p) }

function {:inline true} $top_writable(S:$state, begin_time:int, p:$ptr) returns(bool)
  { ($in_writes_at(begin_time, p) || $timestamp(S, p) >= begin_time)
    && $thread_owned_or_even_mutable(S, p) }


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

function $st_owner($status) returns($ptr);
function $st_closed($status) returns(bool);
function $st_timestamp($status) returns(int);
function $st_ref_cnt(s:$status) returns(int);

function $owner(S:$state, p:$ptr) returns($ptr);
function $closed(S:$state, p:$ptr) returns(bool);
function $timestamp(S:$state, p:$ptr) returns(int);

function $position_marker() returns(bool);
axiom $position_marker();

//axiom (forall s:$status :: {$st_owner(s)} $kind_of($typ($st_owner(s))) != $kind_primitive && $is_non_primitive($typ($st_owner(s))));

function {:inline true} $st(S:$state, p:$ptr) returns($status)
  { $select.sm($statusmap(S), p) }

function {:inline true} $ts(S:$state, p:$ptr) returns($type_state)
  { $select.tm($typemap(S), p) }

function {:weight 0} $owns(S:$state, #p:$ptr)returns($ptrset);
//  { $int_to_ptrset($mem(S, $dot(#p, $owns_set_field($typ(#p))))) }

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

function {:inline} $is_ghost_ptr(p:$ptr) returns(bool)
  { $in_range_spec_ptr($ref(p)) }

function $in_range_phys_ptr(#r:int) returns(bool)
  { $in_range(0, #r, $arch_spec_ptr_start) }
function $in_range_spec_ptr(#r:int) returns(bool)
  { 0 == #r || #r > $arch_spec_ptr_start }
const $arch_spec_ptr_start : int; // arch-specific; to be defined by a compiler-generated axiom

function {:inline true} $typed2(S:$state, #p:$ptr, #t:$ctype) returns(bool)
  { $is(#p, #t) && $typed(S, #p) }

function {:inline true} $typed2_phys(S:$state, #p:$ptr, #t:$ctype) returns (bool)
  { $typed2(S, #p, #t) && ($typed2(S, #p, #t) ==> $in_range_phys_ptr($ref(#p))) }

function {:inline true} $typed2_spec(S:$state, #p:$ptr, #t:$ctype) returns (bool)
  { $typed2(S, #p, #t) && ($typed2(S, #p, #t) ==> $in_range_spec_ptr($ref(#p))) }

function {:inline true} $ptr_eq(p1:$ptr,p2:$ptr) returns(bool)
  { $ref(p1) == $ref(p2) }

function {:inline true} $ptr_neq(p1:$ptr,p2:$ptr) returns(bool)
  { $ref(p1) != $ref(p2) }

function {:inline true} $is_primitive_field_of(S:$state, #f:$ptr, #o:$ptr) returns(bool)
  { $is_primitive_ch($typ(#f)) && $emb(S, #f) == #o }



function $instantiate_st(s:$status) returns(bool);

// for model reading
function $is_domain_root(S:$state, p:$ptr) returns(bool)
  { true }

function $in_wrapped_domain(S:$state, p:$ptr) returns(bool);

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


function {:inline true} $forall_inv2_when_closed(#s1:$state, #s2:$state) returns (bool);

function $function_entry($state) returns(bool);

function $full_stop($state) returns(bool);
function {:inline true} $full_stop_ext(t:$token, S:$state) returns(bool)
  { $good_state_ext(t, S) && $full_stop(S) }

function $file_name_is(id:int, tok:$token) returns(bool);

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
//axiom (forall id:$token, S:$state :: {$good_state_ext(id, S)}
//  $good_state_ext(id, S) ==> $good_state(S));

// ----------------------------------------------------------------------------
// model-viewer support
// ----------------------------------------------------------------------------

function $local_value_is(S1:$state, pos:$token, local_name:$token, val:int, t:$ctype) returns(bool);
function $local_value_is_ptr(S1:$state, pos:$token, local_name:$token, val:$ptr, t:$ctype) returns(bool);
function $read_ptr_m(S:$state, p:$ptr, t:$ctype) returns($ptr);


function $type_code_is(x:int, tp:$ctype) returns(bool);
// idx==0 - return type
function $function_arg_type(fnname:$pure_function, idx:int, tp:$ctype) returns(bool);

// -------------------------------------------------------------------------------------
// the domain thing
// -------------------------------------------------------------------------------------

type $version;
function $ver_domain($version) returns($ptrset);

function {:weight 0} $read_version(S:$state, p:$ptr) returns($version);
//  { $int_to_version($mem(S, p)) }

function {:weight 0} $domain(S:$state, p:$ptr) returns($ptrset)
  { $ver_domain($read_version(S, p)) }

function $in_domain(S:$state, p:$ptr, q:$ptr) returns(bool);
function $in_vdomain(S:$state, p:$ptr, q:$ptr) returns(bool);

function $in_domain_lab(S:$state, p:$ptr, q:$ptr, l:$label) returns(bool);
function $in_vdomain_lab(S:$state, p:$ptr, q:$ptr, l:$label) returns(bool);
function $inv_lab(S:$state, p:$ptr, l:$label) returns(bool);

function {:inline true} $dom_thread_local(S:$state, #p:$ptr) returns(bool)
  { $typed(S, #p) && !$is_volatile(S, #p) }


function $fetch_from_domain(v:$version, p:$ptr) returns(int);

function $in_claim_domain(p:$ptr, c:$ptr) returns(bool);

function {:weight 0} $by_claim(S:$state, c:$ptr, obj:$ptr, ptr:$ptr) returns($ptr)
  { ptr }

function $claim_version($ptr) returns($version);

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

function {:inline true} $inv_is_owner_approved(S1:$state, S2:$state, this:$ptr, subject:$field) returns(bool)
{
  $inv_is_approved_by_ptr(S1, S2, this, $owner(S1, this), subject)
}


function $good_for_admissibility(S:$state) returns(bool);
function $good_for_post_admissibility(S:$state) returns(bool);

function {:inline true} $stuttering_pre(S:$state, p:$ptr) returns(bool);

function {:inline true} $admissibility_pre(S:$state, p:$ptr) returns(bool)
  { $closed(S, p) && $inv(S, p, $typ(p)) && $stuttering_pre(S, p) }


// inferred as free invariant for loops that call only functions that don't write anything
function {:inline true} $mutable_increases(s1:$state, s2:$state) returns(bool);
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
  
  ensures $spans_the_same(old($s), $s, #l, $typ(#l));


// ----------------------------------------------------------------------------
// Procedures
// ----------------------------------------------------------------------------

function $update_int(S:$state, p:$ptr, v:int) returns ($state);

function {:inline true} $timestamp_is_now(S:$state, p:$ptr) returns(bool)
  { $timestamp(S, p) == $current_timestamp(S) }

function {:inline true} $now_writable(S:$state, p:$ptr) returns(bool)
  { $timestamp_is_now(S, p) && $mutable(S, p) }

function {:inline true} $timestamp_post(M1:$state, M2:$state) returns(bool);

function {:inline true} $timestamp_post_strict(M1:$state, M2:$state) returns(bool);

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


function $released(S:$state, #l:$ptr, #p:$ptr) returns($status);
function $release(S0:$state, S:$state, #l:$ptr, #p:$ptr) returns($state);

function $post_unwrap(S1:$state, S2:$state) returns(bool);

function {:inline true} $new_ownees(S:$state, o:$ptr, owns:$ptrset) returns($ptrset)
  { $set_difference(owns, $owns(S, o)) }

// -----------------------------------------------------------------------
// Allocation
// -----------------------------------------------------------------------

function $get_memory_allocator() returns($ptr);
function $is_in_stackframe(#sf:int, p:$ptr) returns(bool);
const unique $memory_allocator_type : $ctype;
const $memory_allocator_ref : int;
axiom $get_memory_allocator() == $ptr($memory_allocator_type, $memory_allocator_ref);
axiom $ptr_level($memory_allocator_type) == 0;



function $program_entry_point(s:$state) returns(bool);
function $program_entry_point_ch(s:$state) returns(bool);


function {:inline true} $is_global(p:$ptr, t:$ctype) returns(bool);
  
function {:inline true} $is_global_array(p:$ptr, T:$ctype, sz:int) returns(bool);
  
// typedness and writes check are handled by the assignment translation

// -----------------------------------------------------------------------
// Unions
// -----------------------------------------------------------------------

function {:inline true} $active_option(S:$state, u:$ptr) returns($field)
  { $ts_active_option($ts(S, u)) }

function $ts_active_option($type_state) returns($field);

function {:inline true} $union_active(S:$state, u:$ptr, f:$field) returns(bool)
  { $active_option(S, u) == f }


function $is_union_field($ctype, $field) returns(bool); // generated by the translation
function {:inline true} $union_havoced(#s1:$state, #s2:$state, #x:$ptr) returns(bool);
  
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


// -----------------------------------------------------------------------
// Sets of pointers
// -----------------------------------------------------------------------

type $ptrset;

function $set_in($ptr,$ptrset) returns(bool);

function $set_empty() returns($ptrset);

function $set_singleton($ptr) returns ($ptrset);

function $non_null_set_singleton($ptr) returns ($ptrset);

function $set_union($ptrset, $ptrset) returns ($ptrset);

function $set_difference($ptrset, $ptrset) returns ($ptrset);

function $set_intersection($ptrset, $ptrset) returns ($ptrset);
  
function $set_subset($ptrset, $ptrset) returns (bool);

function {:inline true} $set_add_element(S:$ptrset, e:$ptr) : $ptrset
  { $set_union(S, $set_singleton(e)) }

function {:inline true} $set_remove_element(S:$ptrset, e:$ptr) : $ptrset
  { $set_difference(S, $set_singleton(e)) }

// to be used only positively
function $set_eq($ptrset, $ptrset) returns (bool);

function $set_cardinality($ptrset) returns(int);

function $set_universe() returns($ptrset);

function $set_disjoint(s1:$ptrset, s2:$ptrset) returns(bool);
function $id_set_disjoint(p:$ptr, s1:$ptrset, s2:$ptrset) returns(int);

function $set_in3($ptr, $ptrset) returns(bool);
function $set_in2($ptr, $ptrset) returns(bool);

function $in_some_owns($ptr) returns(bool);

function $set_in0($ptr, $ptrset) returns(bool);

function sk_hack(bool) returns(bool);


function {:inline true} $writes_nothing(S1:$state, S2:$state) returns(bool);

// --------------------------------------------------------------------------------
// Arrays
// --------------------------------------------------------------------------------

// to be used when you allocate just the array itself
function $array($ctype, int) returns($ctype);
function $element_type($ctype) returns($ctype);
function $array_length($ctype) returns(int);

function {:weight 0} $inlined_array(p:$ptr, T:$ctype) returns ($ptr)
  { p }

function $idx($ptr,int,$ctype) returns($ptr);

function {:inline true} {:expand true} $add.mul(x:int,y:int,z:int) returns(int)
  { x + y*z }

function {:inline true} {:expand true} $add(x:int,y:int) returns(int)
  { x + y }

function {:weight 0} $is_array_vol_or_nonvol(S:$state, p:$ptr, T:$ctype, sz:int, vol:bool) returns(bool);

function {:weight 0} $is_array(S:$state, p:$ptr, T:$ctype, sz:int) returns(bool);


function {:inline true} $is_thread_local_array(S:$state, p:$ptr, T:$ctype, sz:int) returns(bool);
function {:inline true} $is_mutable_array(S:$state, p:$ptr, T:$ctype, sz:int) returns(bool);

function {:inline true} $is_array_emb(S:$state, p:$ptr, T:$ctype, sz:int, emb:$ptr) returns(bool);

function {:inline true} $is_array_emb_path(S:$state, p:$ptr, T:$ctype, sz:int, emb:$ptr, f:$field, isvol:bool) returns(bool);

function {:inline true} $array_field_properties(f:$field, T:$ctype, sz:int, union:bool, vol:bool) returns(bool);

function {:inline true} $no_inline_array_field_properties(f:$field, T:$ctype, sz:int, union:bool, vol:bool) returns(bool);


function {:inline true} $array_elt_emb(S:$state, p:$ptr, emb:$ptr) returns(bool)
    { $emb(S, p) == emb && !$is_volatile(S, p) && $typed(S, p) }


function $array_members(p:$ptr, T:$ctype, sz:int) returns($ptrset);


function $array_range_no_state(p:$ptr, T:$ctype, sz:int) returns($ptrset);
function $array_range(S:$state, p:$ptr, T:$ctype, sz:int) returns($ptrset)
  { $array_range_no_state(p, T, sz) }


function $non_null_array_range(p:$ptr, T:$ctype, sz:int) returns($ptrset);

function $non_null_extent(S:$state, p:$ptr) returns($ptrset);

function {:inline true} $as_array(p:$ptr, T:$ctype, sz:int) returns($ptr)
  { $ptr($array(T, sz), $ref(p)) }

function {:inline true} $array_eq(s1:$state, s2:$state, arr:$ptr, T:$ctype, sz:int) returns(bool);

// $index_within(p, arr) = ($ref(p) - $ref(arr)) div $sizeof($typ(arr))
// To avoid using division, we define a category of simple indices. 
//   $simple_index(p, arr) iff p == arr[k].f1.f2.f3...fN, where N >= 0.
// We're only interested in simple indices for verification.
function $index_within(p:$ptr, arr:$ptr) returns(int);
function $simple_index(p:$ptr, arr:$ptr) returns(bool);

function {:inline true} $in_array(q:$ptr, arr:$ptr, T:$ctype, sz:int) returns(bool)
  { $in_range(0, $index_within(q, arr), sz - 1) && q == $idx(arr, $index_within(q, arr), T) }

function {:inline true} $in_array_full_extent_of(q:$ptr, arr:$ptr, T:$ctype, sz:int) returns(bool)
  { $in_range(0, $index_within(q, arr), sz - 1) && $in_full_extent_of(q, $idx(arr, $index_within(q, arr), T)) }

function {:inline true} $in_array_extent_of(S:$state, q:$ptr, arr:$ptr, T:$ctype, sz:int) returns(bool)
  { $in_range(0, $index_within(q, arr), sz - 1) && $in_extent_of(S, q, $idx(arr, $index_within(q, arr), T)) }



// --------------------------------------------------------------------------------
// Arithmetic
// --------------------------------------------------------------------------------

function {:inline true} $in_range(min:int, val:int, max:int) returns(bool)
  { min <= val && val <= max }





function $unchecked(t:$ctype, val:int) returns(int);
function $in_range_t(t:$ctype, x:int) returns(bool);


// --------------------------------------------------------------------------------
// Function pointers
// --------------------------------------------------------------------------------

function $get_fnptr(no:int, t:$ctype) returns($ptr)
  { $ptr(t, $get_fnptr_ref(no)) }


function $get_fnptr_ref(no:int) returns(int);
function $get_fnptr_inv(rf:int) returns(int);


function $is_fnptr_type(t:$ctype) returns(bool);
function $is_math_type(t:$ctype) returns(bool);



// --------------------------------------------------------------------------------
// Claims
// --------------------------------------------------------------------------------

function $claims_obj(claim:$ptr, obj:$ptr) returns(bool);
function $valid_claim(S:$state, claim:$ptr) returns(bool);

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

function {:inline true} $valid_claim_impl(S0:$state, S1:$state) returns(bool);
  
function $claims_claim(c1:$ptr, c2:$ptr) returns(bool);

function {:weight 0} $not_shared(S:$state, p:$ptr) returns(bool)
  { $wrapped(S, p, $typ(p)) && (!$is_claimable($typ(p)) || $ref_cnt(S, p) == 0) }

function {:weight 0} $claimed_closed(s:$state, p:$ptr) returns(bool)
  { $closed(s, p) }


// called at the beginning of an atomic block to simulate other threads

const unique $no_claim : $ptr;
axiom $no_claim == $ptr(^^claim, 0);


function $claims_upgrade(the_new:$ptr, the_old:$ptr) returns(bool);

function {:weight 0} $ref_cnt(S:$state, p:$ptr) returns(int)
  { $st_ref_cnt($st(S, p)) }

function $is_claimable($ctype) returns(bool);

function $account_claim(S:$state, c:$ptr, o:$ptr) returns(bool)
  { $good_state(S) && $closed(S, c) && $claims_obj(c, o) }

function $claim_no(S:$state, o:$ptr, idx:int) returns($ptr);
function $claim_idx(o:$ptr, c:$ptr) returns(int);


// --------------------------------------------------------------------------------
// Frame axiom ordering
// --------------------------------------------------------------------------------

function $frame_level($pure_function) returns(int);
const $current_frame_level : int;

// assumed at the beginning of all ``normal'' functions (i.e., not frame axiom read checks)
// the $state is there only as a placeholder
function {:inline true} $can_use_all_frame_axioms(s:$state) returns(bool);

function {:inline true} $can_use_frame_axiom_of(f:$pure_function) returns(bool)
  { $frame_level(f) < $current_frame_level }

// and the same for pure function postcondition checking

function $pure_post_level($pure_function) returns(int);
const $current_pure_post_level : int;

function {:inline true} $can_use_all_pure_post_axioms(s:$state) returns(bool);

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

function $version_to_int($version) returns(int);
function $int_to_version(int) returns($version);

function $vol_version_to_int($vol_version) returns(int);
function $int_to_vol_version(int) returns($vol_version);

function $ptr_to_int($ptr) returns(int);
function $int_to_ptr(int) returns($ptr);

// --------------------------------------------------------------------------------
// Skinny writes
// --------------------------------------------------------------------------------

function $precise_test($ptr) returns(bool);

function $updated_only_values(S1:$state, S2:$state, W:$ptrset) returns(bool);
function $updated_only_domains(S1:$state, S2:$state, W:$ptrset) returns(bool);

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
  const $lblset.bot: $labelset;

  function {:inline true} $lblset.leq(l1:$labelset, l2:$labelset) returns(bool);

  function $lblset.meet($labelset, $labelset) returns($labelset);

  function $lblset.join($labelset, $labelset) returns($labelset);

  // Labels and meta-labels of memory locations (we want them in $memory so they get havoc()-ed at the same time as the memory locations they correspond to)
  type $flowdata;

  function $select.flow.label($flowdata) returns($labelset);
  function $store.flow.label($flowdata, $labelset) returns($flowdata);
  function $select.flow.meta($flowdata) returns($labelset);
  function $store.flow.meta($flowdata, $labelset) returns($flowdata);

  
  function $select.flow.data($memory_t, $ptr) returns($flowdata);
  function $store.flow.data($memory_t, $ptr, $flowdata) returns($memory_t);

  // Program Context (is a top-level state member)
  function $select.sec.pc($state) returns($labelset);

// Test classifiers
  // Default classifier
  type $map_t..$ptr_to..^^void.^^bool;

  function $select.$map_t..$ptr_to..^^void.^^bool(M: $map_t..$ptr_to..^^void.^^bool, p: $ptr) : bool;
  function $store.$map_t..$ptr_to..^^void.^^bool(M: $map_t..$ptr_to..^^void.^^bool, p: $ptr, v: bool) : $map_t..$ptr_to..^^void.^^bool;
  function $eq.$map_t..$ptr_to..^^void.^^bool(M1: $map_t..$ptr_to..^^void.^^bool, M2: $map_t..$ptr_to..^^void.^^bool) : bool;

  const $zero.$map_t..$ptr_to..^^void.^^bool: $map_t..$ptr_to..^^void.^^bool;

  function $map_t..ptr_to..^^void.^^bool_to_int(x: $map_t..$ptr_to..^^void.^^bool) : int;
  function $int_to_map_t..ptr_to..^^void.^^bool(x: int) : $map_t..$ptr_to..^^void.^^bool;

  function #classifier#default() : $map_t..$ptr_to..^^void.^^bool;

  const unique cf#classifier#default: $pure_function;

  procedure classifier#default() returns ($result: $map_t..$ptr_to..^^void.^^bool);
    ensures $result == #classifier#default();
    free ensures $call_transition(old($s), $s);

// Pointer clubs
  // Generic type and operations
  type $ptrclub;
  const $ptrclub.empty: [$ptr] bool;

  function is_active_ptrclub(c: $ptrclub) returns(bool);

  function $ptrclub.construct(c: [$ptr] bool, l: $labelset) returns($ptrclub);
  function $ptrclub.members(c: $ptrclub) returns([$ptr] bool);
  function $ptrclub.bound(c: $ptrclub) returns($labelset);
  function $ptrclub.addMember(p: $ptr, c: $ptrclub) returns($ptrclub);
  function {:inline true} $ptrclub.isMember(p: $ptr, c: $ptrclub) returns(bool)
    { $ptrclub.members(c)[p] }

  function $ptrclub.compare($ptr, $ptr) returns($labelset);

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

//axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^A: $ctype;

axiom $is_composite(^A);

axiom $ptr_level(^A) == 0;

axiom $sizeof(^A) == 4;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^A) } $inv2(#s1, #s2, #p, ^A) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty()) && ($mem(#s1, $dot(#p, A.x)) == $mem(#s2, $dot(#p, A.x)) || $mem(#s1, $dot(#p, A.x)) + 1 == $mem(#s2, $dot(#p, A.x)))));
axiom $is_claimable(^A) == false;

axiom $has_volatile_owns_set(^A) == false;


const unique A.$owns: $field;

axiom $static_field_properties(A.$owns, ^A);

axiom $is_primitive_non_volatile_field(A.$owns);

axiom $owns_set_field(^A) == A.$owns;

const unique A.x: $field;

axiom $static_field_properties(A.x, ^A);

axiom $is_primitive_volatile_field(A.x);

axiom $field_offset(A.x) == 0;

const unique l#public: $label;

const unique #tok$1^49.25: $token;

const unique #tok$1^48.25: $token;

const unique #tok$1^42.19: $token;

const unique #tok$1^43.5: $token;

const unique #tok$1^37.19: $token;

const unique #tok$1^39.33: $token;

const unique #tok$1^38.5: $token;

const unique #tok$1^9.5: $token;

const unique #tok$1^7.5: $token;

const unique #loc.res#3: $token;

const unique #tok$1^38.9: $token;

const unique #loc.Exchange#2: $token;

const unique #tok$1^38.43: $token;

const unique #distTp3: $ctype;

axiom #distTp3 == $ptr_to(^^i4);

const unique #loc.Destination#1: $token;

const unique #tok$1^38.36: $token;

const unique #tok$1^33.27: $token;

const unique #tok$1^27.19: $token;

const unique #tok$1^29.33: $token;

const unique #tok$1^28.5: $token;

const unique #loc.y: $token;

const unique #tok$1^23.3: $token;

const unique #loc.z: $token;

const unique #tok$1^24.3: $token;

const unique #loc.c1: $token;

const unique #loc.c2: $token;

const unique #tok$1^25.26: $token;

const unique #distTp2: $ctype;

axiom #distTp2 == $spec_ptr_to(^^claim);

const unique #loc.c: $token;

const unique #loc.a: $token;

const unique #tok$1^18.1: $token;

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^A);

const unique #loc._this_: $token;

const unique #tok$1^13.1: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CLockFreeIncr.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CLockFreeIncr.c);


procedure f(P#_this_: int);
  modifies $s, $cev_pc;
//  ensures $is_admissibility_check() ==> $set_eq($owns($s, $ptr(^A, P#_this_)), $set_empty());
//  ensures $is_admissibility_check() ==> $mem(old($s), $dot($ptr(^A, P#_this_), A.x)) == $mem($s, $dot($ptr(^A, P#_this_), A.x)) || $mem(old($s), $dot($ptr(^A, P#_this_), A.x)) + 1 == $mem($s, $dot($ptr(^A, P#_this_), A.x));
  //ensures $is_stuttering_check() ==> $mem($s, $dot($ptr(^A, P#_this_), A.x)) == $mem($s, $dot($ptr(^A, P#_this_), A.x)) || $mem($s, $dot($ptr(^A, P#_this_), A.x)) + 1 == $mem($s, $dot($ptr(^A, P#_this_), A.x));
  ensures $is_unwrap_check() ==> $set_eq($owns($s, $ptr(^A, P#_this_)), $set_empty());
//  ensures $is_unwrap_check() ==> $mem(old($s), $dot($ptr(^A, P#_this_), A.x)) == $mem($s, $dot($ptr(^A, P#_this_), A.x)) || $mem(old($s), $dot($ptr(^A, P#_this_), A.x)) + 1 == $mem($s, $dot($ptr(^A, P#_this_), A.x));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation f(P#_this_: int)
{
  var #wrTime$1^13.1: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^13.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^13.1, #loc._this_, $ptr_to_int($ptr(^A, P#_this_)), $ptr_to(^A)) && $local_value_is_ptr($s, #tok$1^13.1, #loc._this_, $ptr(^A, P#_this_), $ptr_to(^A));
    assume #wrTime$1^13.1 == $current_timestamp($s);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    assume $is_unwrap_check();
//	if ($is_unwrap_check())
//    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^A, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^A, P#_this_));
        assume $good_state_ext(#tok$1^13.1, $s);
        // assert true; 
//        assert true;
/*    }
    else
    {
	assume false;
      anon4:
        assume true;
        // if (@_vcc_is_admissibility_check) ...
        if ($is_admissibility_check())
        {
          anon2:
            // assume @_vcc_admissibility_pre(@state, _this_); 
            assume $admissibility_pre($s, $ptr(^A, P#_this_));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^A, P#_this_));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct A*)@null))
        call $havoc_others($ptr(^A, P#_this_), ^A);
        assume $good_state_ext(#tok$1^13.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
    }*/

  #exit:
}


