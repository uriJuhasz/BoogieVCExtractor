axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^ArrayList: $ctype;

axiom $is_composite(^ArrayList);

axiom $ptr_level(^ArrayList) == 0;

axiom $sizeof(^ArrayList) == 16;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^ArrayList) } $inv2(#s1, #s2, #p, ^ArrayList) == ($typed(#s2, #p) && $is_malloc_root(#s2, #p) && $mem(#s2, $dot(#p, ArrayList.length)) <= $mem(#s2, $dot(#p, ArrayList.capacity)) && $as_array($read_ptr(#s1, $dot(#p, ArrayList.array), ^^i4), ^^i4, $mem(#s1, $dot(#p, ArrayList.capacity))) == $as_array($read_ptr(#s2, $dot(#p, ArrayList.array), ^^i4), ^^i4, $mem(#s2, $dot(#p, ArrayList.capacity))) && $keeps(#s2, #p, $as_array($read_ptr(#s2, $dot(#p, ArrayList.array), ^^i4), ^^i4, $mem(#s2, $dot(#p, ArrayList.capacity)))) && $is_malloc_root(#s2, $as_array($read_ptr(#s2, $dot(#p, ArrayList.array), ^^i4), ^^i4, $mem(#s2, $dot(#p, ArrayList.capacity))))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^ArrayList, #r), l#public) } $inv_lab(#s2, $ptr(^ArrayList, #r), l#public) == ($typed(#s2, $ptr(^ArrayList, #r)) && $is_malloc_root(#s2, $ptr(^ArrayList, #r)) && $mem(#s2, $dot($ptr(^ArrayList, #r), ArrayList.length)) <= $mem(#s2, $dot($ptr(^ArrayList, #r), ArrayList.capacity)) && $keeps(#s2, $ptr(^ArrayList, #r), $as_array($read_ptr(#s2, $dot($ptr(^ArrayList, #r), ArrayList.array), ^^i4), ^^i4, $mem(#s2, $dot($ptr(^ArrayList, #r), ArrayList.capacity)))) && $is_malloc_root(#s2, $as_array($read_ptr(#s2, $dot($ptr(^ArrayList, #r), ArrayList.array), ^^i4), ^^i4, $mem(#s2, $dot($ptr(^ArrayList, #r), ArrayList.capacity))))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^ArrayList, #r)) } $in_full_extent_of(#q, $ptr(^ArrayList, #r)) == (#q == $ptr(^ArrayList, #r) || #q == $dot($ptr(^ArrayList, #r), ArrayList.$owns) || #q == $dot($ptr(^ArrayList, #r), ArrayList.capacity) || #q == $dot($ptr(^ArrayList, #r), ArrayList.length) || #q == $dot($ptr(^ArrayList, #r), ArrayList.array)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^ArrayList, #r)) } $in_extent_of(#s, #q, $ptr(^ArrayList, #r)) == $in_struct_extent_of(#q, $ptr(^ArrayList, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^ArrayList, #r)) } $typed(#s, $ptr(^ArrayList, #r)) ==> $in_extent_of(#s, #q, $ptr(^ArrayList, #r)) == (#q == $ptr(^ArrayList, #r) || $emb(#s, #q) == $ptr(^ArrayList, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^ArrayList, #r)) } $in_span_of(#q, $ptr(^ArrayList, #r)) == (#q == $ptr(^ArrayList, #r) || #q == $dot($ptr(^ArrayList, #r), ArrayList.$owns) || #q == $dot($ptr(^ArrayList, #r), ArrayList.capacity) || #q == $dot($ptr(^ArrayList, #r), ArrayList.length) || #q == $dot($ptr(^ArrayList, #r), ArrayList.array)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^ArrayList) } $state_spans_the_same(#s1, #s2, #p, ^ArrayList) == ($mem_eq(#s1, #s2, $dot(#p, ArrayList.$owns)) && $mem_eq(#s1, #s2, $dot(#p, ArrayList.capacity)) && $mem_eq(#s1, #s2, $dot(#p, ArrayList.length)) && $mem_eq(#s1, #s2, $dot(#p, ArrayList.array))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^ArrayList) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^ArrayList) == ($mem_eq(#s1, #s2, $dot(#p, ArrayList.$owns)) && $mem_eq(#s1, #s2, $dot(#p, ArrayList.capacity)) && $mem_eq(#s1, #s2, $dot(#p, ArrayList.length)) && $mem_eq(#s1, #s2, $dot(#p, ArrayList.array))));

axiom $is_claimable(^ArrayList) == false;

axiom $has_volatile_owns_set(^ArrayList) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^ArrayList, #r)) } $extent_mutable(#s1, $ptr(^ArrayList, #r)) == $mutable(#s1, $ptr(^ArrayList, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^ArrayList, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^ArrayList, #r)) == $is_fresh(#s1, #s2, $ptr(^ArrayList, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^ArrayList, #r)) } $extent_zero(#s1, $ptr(^ArrayList, #r)) == ($mem(#s1, $dot($ptr(^ArrayList, #r), ArrayList.capacity)) == 0 && $mem(#s1, $dot($ptr(^ArrayList, #r), ArrayList.length)) == 0 && $mem(#s1, $dot($ptr(^ArrayList, #r), ArrayList.array)) == 0));

const unique ArrayList.$owns: $field;

axiom $static_field_properties(ArrayList.$owns, ^ArrayList);

axiom $is_primitive_non_volatile_field(ArrayList.$owns);

axiom (forall #p: $ptr :: { $dot(#p, ArrayList.$owns) } $is(#p, ^ArrayList) ==> $dot(#p, ArrayList.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, ArrayList.$owns)) && $extent_hint($dot(#p, ArrayList.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, ArrayList.$owns)) } { $st(#s, $dot(#p, ArrayList.$owns)) } $typed2(#s, #p, ^ArrayList) ==> $field_properties(#s, #p, ArrayList.$owns, ^$#ptrset, false));

axiom $owns_set_field(^ArrayList) == ArrayList.$owns;

const unique ArrayList.capacity: $field;

axiom $static_field_properties(ArrayList.capacity, ^ArrayList);

axiom $is_primitive_non_volatile_field(ArrayList.capacity);

axiom $field_offset(ArrayList.capacity) == 0;

axiom (forall #p: $ptr :: { $dot(#p, ArrayList.capacity) } $is(#p, ^ArrayList) ==> $dot(#p, ArrayList.capacity) == $ptr(^^u4, $ref(#p) + 0) && $extent_hint($dot(#p, ArrayList.capacity), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, ArrayList.capacity)) } { $st(#s, $dot(#p, ArrayList.capacity)) } $typed2(#s, #p, ^ArrayList) ==> $field_properties(#s, #p, ArrayList.capacity, ^^u4, false));

const unique ArrayList.length: $field;

axiom $static_field_properties(ArrayList.length, ^ArrayList);

axiom $is_primitive_non_volatile_field(ArrayList.length);

axiom $field_offset(ArrayList.length) == 4;

axiom (forall #p: $ptr :: { $dot(#p, ArrayList.length) } $is(#p, ^ArrayList) ==> $dot(#p, ArrayList.length) == $ptr(^^u4, $ref(#p) + 4) && $extent_hint($dot(#p, ArrayList.length), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, ArrayList.length)) } { $st(#s, $dot(#p, ArrayList.length)) } $typed2(#s, #p, ^ArrayList) ==> $field_properties(#s, #p, ArrayList.length, ^^u4, false));

const unique ArrayList.array: $field;

axiom $static_field_properties(ArrayList.array, ^ArrayList);

axiom $is_primitive_non_volatile_field(ArrayList.array);

axiom $field_offset(ArrayList.array) == 8;

axiom (forall #p: $ptr :: { $dot(#p, ArrayList.array) } $is(#p, ^ArrayList) ==> $dot(#p, ArrayList.array) == $ptr($ptr_to(^^i4), $ref(#p) + 8) && $extent_hint($dot(#p, ArrayList.array), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, ArrayList.array)) } { $st(#s, $dot(#p, ArrayList.array)) } $typed2(#s, #p, ^ArrayList) ==> $field_properties(#s, #p, ArrayList.array, $ptr_to(^^i4), false));

procedure ArrayList#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $is_malloc_root($s, $ptr(^ArrayList, P#_this_));
  ensures $is_admissibility_check() ==> $mem($s, $dot($ptr(^ArrayList, P#_this_), ArrayList.length)) <= $mem($s, $dot($ptr(^ArrayList, P#_this_), ArrayList.capacity));
  ensures $is_admissibility_check() ==> $as_array($read_ptr(old($s), $dot($ptr(^ArrayList, P#_this_), ArrayList.array), ^^i4), ^^i4, $mem(old($s), $dot($ptr(^ArrayList, P#_this_), ArrayList.capacity))) == $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#_this_), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#_this_), ArrayList.capacity)));
  ensures $is_admissibility_check() ==> $keeps($s, $ptr(^ArrayList, P#_this_), $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#_this_), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#_this_), ArrayList.capacity))));
  ensures $is_admissibility_check() ==> $is_malloc_root($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#_this_), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#_this_), ArrayList.capacity))));
  ensures $is_stuttering_check() ==> $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#_this_), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#_this_), ArrayList.capacity))) == $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#_this_), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#_this_), ArrayList.capacity)));
  ensures $is_unwrap_check() ==> $is_malloc_root($s, $ptr(^ArrayList, P#_this_));
  ensures $is_unwrap_check() ==> $mem($s, $dot($ptr(^ArrayList, P#_this_), ArrayList.length)) <= $mem($s, $dot($ptr(^ArrayList, P#_this_), ArrayList.capacity));
  ensures $is_unwrap_check() ==> $as_array($read_ptr(old($s), $dot($ptr(^ArrayList, P#_this_), ArrayList.array), ^^i4), ^^i4, $mem(old($s), $dot($ptr(^ArrayList, P#_this_), ArrayList.capacity))) == $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#_this_), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#_this_), ArrayList.capacity)));
  ensures $is_unwrap_check() ==> $keeps($s, $ptr(^ArrayList, P#_this_), $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#_this_), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#_this_), ArrayList.capacity))));
  ensures $is_unwrap_check() ==> $is_malloc_root($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#_this_), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#_this_), ArrayList.capacity))));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation ArrayList#adm(P#_this_: int)
{
  var #wrTime$1^16.1: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^16.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^16.1, #loc._this_, $ptr_to_int($ptr(^ArrayList, P#_this_)), $ptr_to(^ArrayList)) && $local_value_is_ptr($s, #tok$1^16.1, #loc._this_, $ptr(^ArrayList, P#_this_), $ptr_to(^ArrayList));
    assume #wrTime$1^16.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^16.1, #p) } $in_writes_at(#wrTime$1^16.1, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^ArrayList, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^ArrayList, P#_this_));
        assume $good_state_ext(#tok$1^16.1, $s);
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
            assume $admissibility_pre($s, $ptr(^ArrayList, P#_this_));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^ArrayList, P#_this_));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct ArrayList*)@null))
        call $havoc_others($ptr(^ArrayList, P#_this_), ^ArrayList);
        assume $good_state_ext(#tok$1^16.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^ArrayList, P#_this_), ^ArrayList);
    }

  #exit:
}



const unique ^$#fnptr#1: $ctype;

axiom $is_fnptr_type(^$#fnptr#1);

type $#fnptr#1;

const unique ^$#fnptr#2: $ctype;

axiom $is_fnptr_type(^$#fnptr#2);

type $#fnptr#2;

const unique ^$#fnptr#3: $ctype;

axiom $is_fnptr_type(^$#fnptr#3);

type $#fnptr#3;

const unique ^$#fnptr#4: $ctype;

axiom $is_fnptr_type(^$#fnptr#4);

type $#fnptr#4;

const unique ^$#fnptr#5: $ctype;

axiom $is_fnptr_type(^$#fnptr#5);

type $#fnptr#5;

const unique ^$#fnptr#6: $ctype;

axiom $is_fnptr_type(^$#fnptr#6);

type $#fnptr#6;

const unique ^$#fnptr#7: $ctype;

axiom $is_fnptr_type(^$#fnptr#7);

type $#fnptr#7;

const unique ^$#fnptr#8: $ctype;

axiom $is_fnptr_type(^$#fnptr#8);

type $#fnptr#8;

function F#Length(#s: $state, P#A: int) : int;

const unique cf#Length: $pure_function;

axiom (forall #s: $state, P#A: int :: { F#Length(#s, P#A) } $wrapped(#s, $ptr(^ArrayList, P#A), ^ArrayList) ==> $in_range_u4(F#Length(#s, P#A)) && F#Length(#s, P#A) == $mem(#s, $dot($ptr(^ArrayList, P#A), ArrayList.length)));

axiom $function_arg_type(cf#Length, 0, ^^u4);

axiom $function_arg_type(cf#Length, 1, $ptr_to(^ArrayList));

procedure Length(P#A: int) returns ($result: int);
  requires $wrapped($s, $ptr(^ArrayList, P#A), ^ArrayList);
  free ensures $in_range_u4($result);
  ensures $result == $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.length));
  free ensures $result == F#Length($s, P#A);
  free ensures $call_transition(old($s), $s);



implementation Length(P#A: int) returns ($result: int)
{
  var #wrTime$1^27.17: int;
  var #stackframe: int;

  anon7:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^27.17, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^27.17, #loc.A, $ptr_to_int($ptr(^ArrayList, P#A)), $ptr_to(^ArrayList)) && $local_value_is_ptr($s, #tok$1^27.17, #loc.A, $ptr(^ArrayList, P#A), $ptr_to(^ArrayList));
    assume #wrTime$1^27.17 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^27.17, #p) } $in_writes_at(#wrTime$1^27.17, #p) == false);
    // assume @in_range_phys_ptr((mathint)A); 
    assume $in_range_phys_ptr($ref($ptr(^ArrayList, P#A)));
    // assert @_vcc_in_domain(@state, A, A); 
    assert $in_domain_lab($s, $ptr(^ArrayList, P#A), $ptr(^ArrayList, P#A), l#public);
    // assert @reads_check_normal((A->length)); 
    assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.length), ^^u4);
    assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.length), ^^u4);
    // return *((A->length)); 
    $result := $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.length));
    assert $position_marker();
    goto #exit;

  anon8:
    // empty

  #exit:
}



procedure CreateArrayList(P#InitialCapacity: int) returns ($result: int);
  requires 0 < P#InitialCapacity;
  modifies $s, $cev_pc;
  free ensures $in_range_phys_ptr($ref($ptr(^ArrayList, $result)));
  ensures $wrapped($s, $ptr(^ArrayList, $result), ^ArrayList);
  ensures $is_fresh(old($s), $s, $ptr(^ArrayList, $result));
  ensures F#Length($s, $ref($ptr(^ArrayList, $result))) == 0;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation CreateArrayList(P#InitialCapacity: int) returns ($result: int)
{
  var owns#7: $ptrset;
  var staticWrapState#6: $state;
  var prestate#8: $state;
  var prestate#5: $state;
  var res__vcc_alloc#3: $ptr;
  var #callConv#0: $ptr;
  var L#A: int where $in_range_phys_ptr(L#A);
  var #wrTime$1^36.8: int;
  var #stackframe: int;

  anon9:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^36.8, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^36.8, #loc.InitialCapacity, P#InitialCapacity, ^^u4);
    assume #wrTime$1^36.8 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^36.8, #p) } $in_writes_at(#wrTime$1^36.8, #p) == false);
    // assume @in_range_u4(InitialCapacity); 
    assume $in_range_u4(P#InitialCapacity);
    // struct ArrayList* A; 
    assume $local_value_is($s, #tok$1^42.12, #loc.A, $ptr_to_int($ptr(^ArrayList, L#A)), $ptr_to(^ArrayList)) && $local_value_is_ptr($s, #tok$1^42.12, #loc.A, $ptr(^ArrayList, L#A), $ptr_to(^ArrayList));
    // var struct ArrayList* A
    // A := _vcc_alloc(@_vcc_typeof((struct ArrayList*)@null)); 
    call #callConv#0 := $alloc(^ArrayList);
    assume $full_stop_ext(#tok$1^44.9, $s);
    L#A := $ref(#callConv#0);
    assume $local_value_is($s, #tok$1^44.9, #loc.A, $ptr_to_int($ptr(^ArrayList, L#A)), $ptr_to(^ArrayList)) && $local_value_is_ptr($s, #tok$1^44.9, #loc.A, $ptr(^ArrayList, L#A), $ptr_to(^ArrayList));
    // assume @_vcc_ptr_neq(A, @null); 
    assume $ptr_neq($ptr(^ArrayList, L#A), $null);
    // assert @_vcc_typed2(@state, (A->capacity)); 
    assert $typed2($s, $dot($ptr(^ArrayList, L#A), ArrayList.capacity), ^^u4);
    // assert @prim_writes_check((A->capacity)); 
    assert $writable($s, #wrTime$1^36.8, $dot($ptr(^ArrayList, L#A), ArrayList.capacity));
    // *(A->capacity) := InitialCapacity; 
    call $write_int($dot($ptr(^ArrayList, L#A), ArrayList.capacity), P#InitialCapacity);
    assume $full_stop_ext(#tok$1^47.5, $s);
    // assert @_vcc_typed2(@state, (A->length)); 
    assert $typed2($s, $dot($ptr(^ArrayList, L#A), ArrayList.length), ^^u4);
    // assert @prim_writes_check((A->length)); 
    assert $writable($s, #wrTime$1^36.8, $dot($ptr(^ArrayList, L#A), ArrayList.length));
    // *(A->length) := 0; 
    call $write_int($dot($ptr(^ArrayList, L#A), ArrayList.length), 0);
    assume $full_stop_ext(#tok$1^48.5, $s);
    // obj_t res__vcc_alloc#3; 
    assume $local_value_is($s, #tok$1^49.16, #loc.res__vcc_alloc#3, $ptr_to_int(res__vcc_alloc#3), $ptr_to(^^void));
    // res__vcc_alloc#3 := _vcc_alloc(@_vcc_array(@_vcc_typeof((int32_t*)@null), InitialCapacity)); 
    call res__vcc_alloc#3 := $alloc($array(^^i4, P#InitialCapacity));
    assume $full_stop_ext(#tok$1^49.16, $s);
    assume $local_value_is($s, #tok$1^49.16, #loc.res__vcc_alloc#3, $ptr_to_int(res__vcc_alloc#3), $ptr_to(^^void));
    // assert @_vcc_typed2(@state, (A->array)); 
    assert $typed2($s, $dot($ptr(^ArrayList, L#A), ArrayList.array), $ptr_to(^^i4));
    // assert @prim_writes_check((A->array)); 
    assert $writable($s, #wrTime$1^36.8, $dot($ptr(^ArrayList, L#A), ArrayList.array));
    // *(A->array) := (int32_t*)res__vcc_alloc#3; 
    call $write_int($dot($ptr(^ArrayList, L#A), ArrayList.array), $ref($ptr_cast(res__vcc_alloc#3, ^^i4)));
    assume $full_stop_ext(#tok$1^49.5, $s);
    // assume @_vcc_ptr_neq(*((A->array)), @null); 
    assume $ptr_neq($read_ptr($s, $dot($ptr(^ArrayList, L#A), ArrayList.array), ^^i4), $null);
    // _math state_t prestate#5; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#5, $state_to_int(prestate#5), ^$#state_t);
    // prestate#5 := @_vcc_current_state(@state); 
    prestate#5 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#5, $state_to_int(prestate#5), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(@_vcc_as_array(*((A->array)), InitialCapacity)); 
    assert $top_writable($s, #wrTime$1^36.8, $as_array($read_ptr($s, $dot($ptr(^ArrayList, L#A), ArrayList.array), ^^i4), ^^i4, P#InitialCapacity));
    // assert @writes_check(@_vcc_owns(@state, @_vcc_as_array(*((A->array)), InitialCapacity))); 
    assert (forall #writes$1^52.21: $ptr :: { $dont_instantiate(#writes$1^52.21) } $set_in(#writes$1^52.21, $owns($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, L#A), ArrayList.array), ^^i4), ^^i4, P#InitialCapacity))) ==> $top_writable($s, #wrTime$1^36.8, #writes$1^52.21));
    // assert @reads_check_normal((A->array)); 
    assert $typed2($s, $dot($ptr(^ArrayList, L#A), ArrayList.array), $ptr_to(^^i4));
    assert $thread_local2($s, $dot($ptr(^ArrayList, L#A), ArrayList.array), $ptr_to(^^i4));
    // stmt @_vcc_wrap(@_vcc_as_array(*((A->array)), InitialCapacity), @_vcc_typeof(@_vcc_as_array(*((A->array)), InitialCapacity))); 
    call $wrap($as_array($read_ptr($s, $dot($ptr(^ArrayList, L#A), ArrayList.array), ^^i4), ^^i4, P#InitialCapacity), $array(^^i4, P#InitialCapacity));
    assume $good_state_ext(#tok$1^52.21, $s);
    // assert @_vcc_inv2(prestate#5, @_vcc_current_state(@state), @_vcc_as_array(*((A->array)), InitialCapacity)); 
    assert $inv2(prestate#5, $current_state($s), $as_array($read_ptr($s, $dot($ptr(^ArrayList, L#A), ArrayList.array), ^^i4), ^^i4, P#InitialCapacity), $array(^^i4, P#InitialCapacity));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#8; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#8, $state_to_int(prestate#8), ^$#state_t);
    // prestate#8 := @_vcc_current_state(@state); 
    prestate#8 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#8, $state_to_int(prestate#8), ^$#state_t);
    // _math state_t staticWrapState#6; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#6, $state_to_int(staticWrapState#6), ^$#state_t);
    // staticWrapState#6 := @_vcc_current_state(@state); 
    staticWrapState#6 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#6, $state_to_int(staticWrapState#6), ^$#state_t);
    // _math ptrset owns#7; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#7, $ptrset_to_int(owns#7), ^$#ptrset);
    // owns#7 := @_vcc_set_empty; 
    owns#7 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#7, $ptrset_to_int(owns#7), ^$#ptrset);
    // assert @writes_check(A); 
    assert $top_writable($s, #wrTime$1^36.8, $ptr(^ArrayList, L#A));
    // assert @_vcc_wrapped(@state, @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $wrapped($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, L#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, L#A), ArrayList.capacity))), $array(^^i4, $mem($s, $dot($ptr(^ArrayList, L#A), ArrayList.capacity))));
    // assert @writes_check(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $top_writable($s, #wrTime$1^36.8, $as_array($read_ptr($s, $dot($ptr(^ArrayList, L#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, L#A), ArrayList.capacity))));
    // owns#7 := pure(@_vcc_set_union(owns#7, @_vcc_set_singleton(@_vcc_as_array(*((A->array)), *((A->capacity)))))); 
    owns#7 := $set_union(owns#7, $set_singleton($as_array($read_ptr($s, $dot($ptr(^ArrayList, L#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, L#A), ArrayList.capacity)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#7, $ptrset_to_int(owns#7), ^$#ptrset);
    // staticWrapState#6 := pure(@_vcc_take_over(staticWrapState#6, A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    staticWrapState#6 := $take_over(staticWrapState#6, $ptr(^ArrayList, L#A), $as_array($read_ptr($s, $dot($ptr(^ArrayList, L#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, L#A), ArrayList.capacity))));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#6, $state_to_int(staticWrapState#6), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(A), staticWrapState#6, owns#7)
    call $static_wrap($ptr(^ArrayList, L#A), staticWrapState#6, owns#7);
    assume $good_state_ext(#tok$1^53.21, $s);
    // assert @inv_check(@_vcc_is_malloc_root(@state, A)); 
    assert $is_malloc_root($s, $ptr(^ArrayList, L#A));
    // assert @inv_check(<=(*((A->length)), *((A->capacity)))); 
    assert $mem($s, $dot($ptr(^ArrayList, L#A), ArrayList.length)) <= $mem($s, $dot($ptr(^ArrayList, L#A), ArrayList.capacity));
    // assert @inv_check(@keeps_stable(old(prestate#8, @_vcc_as_array(*((A->array)), *((A->capacity)))), @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $as_array($read_ptr(prestate#8, $dot($ptr(^ArrayList, L#A), ArrayList.array), ^^i4), ^^i4, $mem(prestate#8, $dot($ptr(^ArrayList, L#A), ArrayList.capacity))) == $as_array($read_ptr($s, $dot($ptr(^ArrayList, L#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, L#A), ArrayList.capacity)));
    // assert @inv_check(@keeps(A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $keeps($s, $ptr(^ArrayList, L#A), $as_array($read_ptr($s, $dot($ptr(^ArrayList, L#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, L#A), ArrayList.capacity))));
    // assert @inv_check(@_vcc_is_malloc_root(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $is_malloc_root($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, L#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, L#A), ArrayList.capacity))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return A; 
    $result := $ref($ptr(^ArrayList, L#A));
    assert $position_marker();
    goto #exit;

  anon10:
    // empty

  #exit:
}



procedure MakeEmpty(P#A: int);
  requires $wrapped($s, $ptr(^ArrayList, P#A), ^ArrayList);
  modifies $s, $cev_pc;
  ensures F#Length($s, $ref($ptr(^ArrayList, P#A))) == 0;
  ensures $wrapped($s, $ptr(^ArrayList, P#A), ^ArrayList);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^ArrayList, P#A) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^ArrayList, P#A) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^ArrayList, P#A) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation MakeEmpty(P#A: int)
{
  var owns#13: $ptrset;
  var staticWrapState#12: $state;
  var prestate#14: $state;
  var prestate#11: $state;
  var prestate#9: $state;
  var owns#10: $ptrset;
  var #wrTime$1^57.1: int;
  var #stackframe: int;

  anon11:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^57.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^57.1, #loc.A, $ptr_to_int($ptr(^ArrayList, P#A)), $ptr_to(^ArrayList)) && $local_value_is_ptr($s, #tok$1^57.1, #loc.A, $ptr(^ArrayList, P#A), $ptr_to(^ArrayList));
    assume #wrTime$1^57.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^57.1, #p) } $in_writes_at(#wrTime$1^57.1, #p) == (#p == $ptr(^ArrayList, P#A)));
    assume $thread_owned($s, $ptr(^ArrayList, P#A));
    // assume @in_range_phys_ptr((mathint)A); 
    assume $in_range_phys_ptr($ref($ptr(^ArrayList, P#A)));
    // assert @_vcc_in_domain(@state, A, A); 
    assert $in_domain_lab($s, $ptr(^ArrayList, P#A), $ptr(^ArrayList, P#A), l#public);
    // _math ptrset owns#10; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#10, $ptrset_to_int(owns#10), ^$#ptrset);
    // owns#10 := @_vcc_set_empty; 
    owns#10 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#10, $ptrset_to_int(owns#10), ^$#ptrset);
    // _math state_t prestate#9; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#9, $state_to_int(prestate#9), ^$#state_t);
    // prestate#9 := @_vcc_current_state(@state); 
    prestate#9 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#9, $state_to_int(prestate#9), ^$#state_t);
    // _math state_t prestate#11; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#11, $state_to_int(prestate#11), ^$#state_t);
    // prestate#11 := @_vcc_current_state(@state); 
    prestate#11 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#11, $state_to_int(prestate#11), ^$#state_t);
    // assert @_vcc_wrapped(@state, A); 
    assert $wrapped($s, $ptr(^ArrayList, P#A), ^ArrayList);
    // assert @writes_check(A); 
    assert $top_writable($s, #wrTime$1^57.1, $ptr(^ArrayList, P#A));
    // assume @_vcc_inv(@state, A); 
    assume $inv($s, $ptr(^ArrayList, P#A), ^ArrayList);
    // prestate#11 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#11, A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    prestate#11 := $release($current_state($s), prestate#11, $ptr(^ArrayList, P#A), $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#11, $state_to_int(prestate#11), ^$#state_t);
    // owns#10 := pure(@_vcc_set_union(owns#10, @_vcc_set_singleton(@_vcc_as_array(*((A->array)), *((A->capacity)))))); 
    owns#10 := $set_union(owns#10, $set_singleton($as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#10, $ptrset_to_int(owns#10), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assume $typed($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assume ==(owns#10, @_vcc_owns(@state, A)); 
    assume owns#10 == $owns($s, $ptr(^ArrayList, P#A));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(A), prestate#11)
    call $static_unwrap($ptr(^ArrayList, P#A), prestate#11);
    assume $good_state_ext(#tok$1^62.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (A->length)); 
    assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.length), ^^u4);
    // assert @prim_writes_check((A->length)); 
    assert $writable($s, #wrTime$1^57.1, $dot($ptr(^ArrayList, P#A), ArrayList.length));
    // *(A->length) := 0; 
    call $write_int($dot($ptr(^ArrayList, P#A), ArrayList.length), 0);
    assume $full_stop_ext(#tok$1^63.5, $s);
    // _math state_t prestate#14; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#14, $state_to_int(prestate#14), ^$#state_t);
    // prestate#14 := @_vcc_current_state(@state); 
    prestate#14 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#14, $state_to_int(prestate#14), ^$#state_t);
    // _math state_t staticWrapState#12; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#12, $state_to_int(staticWrapState#12), ^$#state_t);
    // staticWrapState#12 := @_vcc_current_state(@state); 
    staticWrapState#12 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#12, $state_to_int(staticWrapState#12), ^$#state_t);
    // _math ptrset owns#13; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#13, $ptrset_to_int(owns#13), ^$#ptrset);
    // owns#13 := @_vcc_set_empty; 
    owns#13 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#13, $ptrset_to_int(owns#13), ^$#ptrset);
    // assert @writes_check(A); 
    assert $top_writable($s, #wrTime$1^57.1, $ptr(^ArrayList, P#A));
    // assert @_vcc_wrapped(@state, @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $wrapped($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))), $array(^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assert @writes_check(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $top_writable($s, #wrTime$1^57.1, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // owns#13 := pure(@_vcc_set_union(owns#13, @_vcc_set_singleton(@_vcc_as_array(*((A->array)), *((A->capacity)))))); 
    owns#13 := $set_union(owns#13, $set_singleton($as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#13, $ptrset_to_int(owns#13), ^$#ptrset);
    // staticWrapState#12 := pure(@_vcc_take_over(staticWrapState#12, A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    staticWrapState#12 := $take_over(staticWrapState#12, $ptr(^ArrayList, P#A), $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#12, $state_to_int(staticWrapState#12), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(A), staticWrapState#12, owns#13)
    call $static_wrap($ptr(^ArrayList, P#A), staticWrapState#12, owns#13);
    assume $good_state_ext(#tok$1^64.21, $s);
    // assert @inv_check(@_vcc_is_malloc_root(@state, A)); 
    assert $is_malloc_root($s, $ptr(^ArrayList, P#A));
    // assert @inv_check(<=(*((A->length)), *((A->capacity)))); 
    assert $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.length)) <= $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity));
    // assert @inv_check(@keeps_stable(old(prestate#14, @_vcc_as_array(*((A->array)), *((A->capacity)))), @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $as_array($read_ptr(prestate#14, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem(prestate#14, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))) == $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity)));
    // assert @inv_check(@keeps(A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $keeps($s, $ptr(^ArrayList, P#A), $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assert @inv_check(@_vcc_is_malloc_root(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $is_malloc_root($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



function F#Select(#s: $state, P#A: int, P#i: int) : int;

const unique cf#Select: $pure_function;

axiom (forall #s: $state, P#A: int, P#i: int :: { F#Select(#s, P#A, P#i) } P#i < F#Length(#s, $ref($ptr(^ArrayList, P#A))) && $wrapped(#s, $ptr(^ArrayList, P#A), ^ArrayList) ==> $in_range_i4(F#Select(#s, P#A, P#i)) && F#Select(#s, P#A, P#i) == $mem(#s, $idx($read_ptr(#s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), P#i, ^^i4)));

axiom $function_arg_type(cf#Select, 0, ^^i4);

axiom $function_arg_type(cf#Select, 1, $ptr_to(^ArrayList));

axiom $function_arg_type(cf#Select, 2, ^^u4);

procedure Select(P#A: int, P#i: int) returns ($result: int);
  requires P#i < F#Length($s, $ref($ptr(^ArrayList, P#A)));
  requires $wrapped($s, $ptr(^ArrayList, P#A), ^ArrayList);
  free ensures $in_range_i4($result);
  ensures $result == $mem($s, $idx($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), P#i, ^^i4));
  free ensures $result == F#Select($s, P#A, P#i);
  free ensures $call_transition(old($s), $s);



implementation Select(P#A: int, P#i: int) returns ($result: int)
{
  var #wrTime$1^67.17: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^67.17, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^67.17, #loc.A, $ptr_to_int($ptr(^ArrayList, P#A)), $ptr_to(^ArrayList)) && $local_value_is_ptr($s, #tok$1^67.17, #loc.A, $ptr(^ArrayList, P#A), $ptr_to(^ArrayList));
    assume $local_value_is($s, #tok$1^67.17, #loc.i, P#i, ^^u4);
    assume #wrTime$1^67.17 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^67.17, #p) } $in_writes_at(#wrTime$1^67.17, #p) == false);
    // assume @in_range_phys_ptr((mathint)A); 
    assume $in_range_phys_ptr($ref($ptr(^ArrayList, P#A)));
    // assume @in_range_u4(i); 
    assume $in_range_u4(P#i);
    // assert @_vcc_in_domain(@state, A, A); 
    assert $in_domain_lab($s, $ptr(^ArrayList, P#A), $ptr(^ArrayList, P#A), l#public);
    // assert @reads_check_normal(*((A->array))[i]); 
    assert $typed2($s, $idx($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), P#i, ^^i4), ^^i4);
    assert $thread_local2($s, $idx($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), P#i, ^^i4), ^^i4);
    // assert @reads_check_normal((A->array)); 
    assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), $ptr_to(^^i4));
    assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), $ptr_to(^^i4));
    // return *(*((A->array))[i]); 
    $result := $mem($s, $idx($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), P#i, ^^i4));
    assert $position_marker();
    goto #exit;

  anon13:
    // empty

  #exit:
}



procedure Update(P#A: int, P#i: int, P#v: int);
  requires P#i < F#Length($s, $ref($ptr(^ArrayList, P#A)));
  requires $wrapped($s, $ptr(^ArrayList, P#A), ^ArrayList);
  modifies $s, $cev_pc;
  ensures (forall Q#j$1^81.29#tc1: int :: $in_range_u4(Q#j$1^81.29#tc1) ==> Q#j$1^81.29#tc1 < F#Length($s, $ref($ptr(^ArrayList, P#A))) ==> F#Select($s, $ref($ptr(^ArrayList, P#A)), Q#j$1^81.29#tc1) == (if Q#j$1^81.29#tc1 == P#i then P#v else $mem(old($s), $idx($read_ptr(old($s), $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), Q#j$1^81.29#tc1, ^^i4))));
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^ArrayList, P#A) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^ArrayList, P#A) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^ArrayList, P#A) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Update(P#A: int, P#i: int, P#v: int)
{
  var owns#21: $ptrset;
  var staticWrapState#20: $state;
  var prestate#22: $state;
  var prestate#19: $state;
  var prestate#18: $state;
  var prestate#17: $state;
  var prestate#15: $state;
  var owns#16: $ptrset;
  var #wrTime$1^77.1: int;
  var #stackframe: int;

  anon14:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^77.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^77.1, #loc.A, $ptr_to_int($ptr(^ArrayList, P#A)), $ptr_to(^ArrayList)) && $local_value_is_ptr($s, #tok$1^77.1, #loc.A, $ptr(^ArrayList, P#A), $ptr_to(^ArrayList));
    assume $local_value_is($s, #tok$1^77.1, #loc.i, P#i, ^^u4);
    assume $local_value_is($s, #tok$1^77.1, #loc.v, P#v, ^^i4);
    assume #wrTime$1^77.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^77.1, #p) } $in_writes_at(#wrTime$1^77.1, #p) == (#p == $ptr(^ArrayList, P#A)));
    assume $thread_owned($s, $ptr(^ArrayList, P#A));
    // assume @in_range_phys_ptr((mathint)A); 
    assume $in_range_phys_ptr($ref($ptr(^ArrayList, P#A)));
    // assume @in_range_u4(i); 
    assume $in_range_u4(P#i);
    // assume @in_range_i4(v); 
    assume $in_range_i4(P#v);
    // assert @_vcc_in_domain(@state, A, A); 
    assert $in_domain_lab($s, $ptr(^ArrayList, P#A), $ptr(^ArrayList, P#A), l#public);
    // _math ptrset owns#16; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#16, $ptrset_to_int(owns#16), ^$#ptrset);
    // owns#16 := @_vcc_set_empty; 
    owns#16 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#16, $ptrset_to_int(owns#16), ^$#ptrset);
    // _math state_t prestate#15; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#15, $state_to_int(prestate#15), ^$#state_t);
    // prestate#15 := @_vcc_current_state(@state); 
    prestate#15 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#15, $state_to_int(prestate#15), ^$#state_t);
    // _math state_t prestate#17; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#17, $state_to_int(prestate#17), ^$#state_t);
    // prestate#17 := @_vcc_current_state(@state); 
    prestate#17 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#17, $state_to_int(prestate#17), ^$#state_t);
    // assert @_vcc_wrapped(@state, A); 
    assert $wrapped($s, $ptr(^ArrayList, P#A), ^ArrayList);
    // assert @writes_check(A); 
    assert $top_writable($s, #wrTime$1^77.1, $ptr(^ArrayList, P#A));
    // assume @_vcc_inv(@state, A); 
    assume $inv($s, $ptr(^ArrayList, P#A), ^ArrayList);
    // prestate#17 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#17, A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    prestate#17 := $release($current_state($s), prestate#17, $ptr(^ArrayList, P#A), $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#17, $state_to_int(prestate#17), ^$#state_t);
    // owns#16 := pure(@_vcc_set_union(owns#16, @_vcc_set_singleton(@_vcc_as_array(*((A->array)), *((A->capacity)))))); 
    owns#16 := $set_union(owns#16, $set_singleton($as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#16, $ptrset_to_int(owns#16), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assume $typed($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assume ==(owns#16, @_vcc_owns(@state, A)); 
    assume owns#16 == $owns($s, $ptr(^ArrayList, P#A));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(A), prestate#17)
    call $static_unwrap($ptr(^ArrayList, P#A), prestate#17);
    assume $good_state_ext(#tok$1^84.32, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#18; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#18, $state_to_int(prestate#18), ^$#state_t);
    // prestate#18 := @_vcc_current_state(@state); 
    prestate#18 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#18, $state_to_int(prestate#18), ^$#state_t);
    // assert @_vcc_wrapped(@state, @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $wrapped($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))), $array(^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assume @_vcc_inv(@state, @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assume $inv($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))), $array(^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $top_writable($s, #wrTime$1^77.1, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assert @reads_check_normal((A->array)); 
    assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), $ptr_to(^^i4));
    assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), $ptr_to(^^i4));
    // assert @reads_check_normal((A->capacity)); 
    assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity), ^^u4);
    assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity), ^^u4);
    // stmt @_vcc_unwrap(@_vcc_as_array(*((A->array)), *((A->capacity))), @_vcc_typeof(@_vcc_as_array(*((A->array)), *((A->capacity))))); 
    call $unwrap($as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))), $array(^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    assume $good_state_ext(#tok$1^84.35, $s);
    // assert @_vcc_inv2(prestate#18, @_vcc_current_state(@state), @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $inv2(prestate#18, $current_state($s), $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))), $array(^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, *((A->array))[i]); 
    assert $typed2($s, $idx($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), P#i, ^^i4), ^^i4);
    // assert @prim_writes_check(*((A->array))[i]); 
    assert $writable($s, #wrTime$1^77.1, $idx($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), P#i, ^^i4));
    // assert @reads_check_normal((A->array)); 
    assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), $ptr_to(^^i4));
    assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), $ptr_to(^^i4));
    // **((A->array))[i] := v; 
    call $write_int($idx($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), P#i, ^^i4), P#v);
    assume $full_stop_ext(#tok$1^85.9, $s);
    // _math state_t prestate#19; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#19, $state_to_int(prestate#19), ^$#state_t);
    // prestate#19 := @_vcc_current_state(@state); 
    prestate#19 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#19, $state_to_int(prestate#19), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $top_writable($s, #wrTime$1^77.1, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assert @writes_check(@_vcc_owns(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert (forall #writes$1^84.35: $ptr :: { $dont_instantiate(#writes$1^84.35) } $set_in(#writes$1^84.35, $owns($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))))) ==> $top_writable($s, #wrTime$1^77.1, #writes$1^84.35));
    // assert @reads_check_normal((A->array)); 
    assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), $ptr_to(^^i4));
    assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), $ptr_to(^^i4));
    // assert @reads_check_normal((A->capacity)); 
    assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity), ^^u4);
    assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity), ^^u4);
    // stmt @_vcc_wrap(@_vcc_as_array(*((A->array)), *((A->capacity))), @_vcc_typeof(@_vcc_as_array(*((A->array)), *((A->capacity))))); 
    call $wrap($as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))), $array(^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    assume $good_state_ext(#tok$1^84.35, $s);
    // assert @_vcc_inv2(prestate#19, @_vcc_current_state(@state), @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $inv2(prestate#19, $current_state($s), $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))), $array(^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#22; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#22, $state_to_int(prestate#22), ^$#state_t);
    // prestate#22 := @_vcc_current_state(@state); 
    prestate#22 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#22, $state_to_int(prestate#22), ^$#state_t);
    // _math state_t staticWrapState#20; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#20, $state_to_int(staticWrapState#20), ^$#state_t);
    // staticWrapState#20 := @_vcc_current_state(@state); 
    staticWrapState#20 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#20, $state_to_int(staticWrapState#20), ^$#state_t);
    // _math ptrset owns#21; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#21, $ptrset_to_int(owns#21), ^$#ptrset);
    // owns#21 := @_vcc_set_empty; 
    owns#21 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#21, $ptrset_to_int(owns#21), ^$#ptrset);
    // assert @writes_check(A); 
    assert $top_writable($s, #wrTime$1^77.1, $ptr(^ArrayList, P#A));
    // assert @_vcc_wrapped(@state, @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $wrapped($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))), $array(^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assert @writes_check(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $top_writable($s, #wrTime$1^77.1, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // owns#21 := pure(@_vcc_set_union(owns#21, @_vcc_set_singleton(@_vcc_as_array(*((A->array)), *((A->capacity)))))); 
    owns#21 := $set_union(owns#21, $set_singleton($as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#21, $ptrset_to_int(owns#21), ^$#ptrset);
    // staticWrapState#20 := pure(@_vcc_take_over(staticWrapState#20, A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    staticWrapState#20 := $take_over(staticWrapState#20, $ptr(^ArrayList, P#A), $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#20, $state_to_int(staticWrapState#20), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(A), staticWrapState#20, owns#21)
    call $static_wrap($ptr(^ArrayList, P#A), staticWrapState#20, owns#21);
    assume $good_state_ext(#tok$1^84.32, $s);
    // assert @inv_check(@_vcc_is_malloc_root(@state, A)); 
    assert $is_malloc_root($s, $ptr(^ArrayList, P#A));
    // assert @inv_check(<=(*((A->length)), *((A->capacity)))); 
    assert $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.length)) <= $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity));
    // assert @inv_check(@keeps_stable(old(prestate#22, @_vcc_as_array(*((A->array)), *((A->capacity)))), @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $as_array($read_ptr(prestate#22, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem(prestate#22, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))) == $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity)));
    // assert @inv_check(@keeps(A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $keeps($s, $ptr(^ArrayList, P#A), $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assert @inv_check(@_vcc_is_malloc_root(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $is_malloc_root($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure DisposeArrayList(P#A: int);
  requires $wrapped($s, $ptr(^ArrayList, P#A), ^ArrayList);
  modifies $s, $cev_pc;
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^ArrayList, P#A) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^ArrayList, P#A) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^ArrayList, P#A) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation DisposeArrayList(P#A: int)
{
  var prestate#26: $state;
  var prestate#25: $state;
  var prestate#23: $state;
  var owns#24: $ptrset;
  var #wrTime$1^88.1: int;
  var #stackframe: int;

  anon15:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^88.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^88.1, #loc.A, $ptr_to_int($ptr(^ArrayList, P#A)), $ptr_to(^ArrayList)) && $local_value_is_ptr($s, #tok$1^88.1, #loc.A, $ptr(^ArrayList, P#A), $ptr_to(^ArrayList));
    assume #wrTime$1^88.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^88.1, #p) } $in_writes_at(#wrTime$1^88.1, #p) == (#p == $ptr(^ArrayList, P#A)));
    assume $thread_owned($s, $ptr(^ArrayList, P#A));
    // assume @in_range_phys_ptr((mathint)A); 
    assume $in_range_phys_ptr($ref($ptr(^ArrayList, P#A)));
    // assert @_vcc_in_domain(@state, A, A); 
    assert $in_domain_lab($s, $ptr(^ArrayList, P#A), $ptr(^ArrayList, P#A), l#public);
    // _math ptrset owns#24; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#24, $ptrset_to_int(owns#24), ^$#ptrset);
    // owns#24 := @_vcc_set_empty; 
    owns#24 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#24, $ptrset_to_int(owns#24), ^$#ptrset);
    // _math state_t prestate#23; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#23, $state_to_int(prestate#23), ^$#state_t);
    // prestate#23 := @_vcc_current_state(@state); 
    prestate#23 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#23, $state_to_int(prestate#23), ^$#state_t);
    // _math state_t prestate#25; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#25, $state_to_int(prestate#25), ^$#state_t);
    // prestate#25 := @_vcc_current_state(@state); 
    prestate#25 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#25, $state_to_int(prestate#25), ^$#state_t);
    // assert @_vcc_wrapped(@state, A); 
    assert $wrapped($s, $ptr(^ArrayList, P#A), ^ArrayList);
    // assert @writes_check(A); 
    assert $top_writable($s, #wrTime$1^88.1, $ptr(^ArrayList, P#A));
    // assume @_vcc_inv(@state, A); 
    assume $inv($s, $ptr(^ArrayList, P#A), ^ArrayList);
    // prestate#25 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#25, A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    prestate#25 := $release($current_state($s), prestate#25, $ptr(^ArrayList, P#A), $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#25, $state_to_int(prestate#25), ^$#state_t);
    // owns#24 := pure(@_vcc_set_union(owns#24, @_vcc_set_singleton(@_vcc_as_array(*((A->array)), *((A->capacity)))))); 
    owns#24 := $set_union(owns#24, $set_singleton($as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#24, $ptrset_to_int(owns#24), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assume $typed($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assume ==(owns#24, @_vcc_owns(@state, A)); 
    assume owns#24 == $owns($s, $ptr(^ArrayList, P#A));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(A), prestate#25)
    call $static_unwrap($ptr(^ArrayList, P#A), prestate#25);
    assume $good_state_ext(#tok$1^92.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#26; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#26, $state_to_int(prestate#26), ^$#state_t);
    // prestate#26 := @_vcc_current_state(@state); 
    prestate#26 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#26, $state_to_int(prestate#26), ^$#state_t);
    // assert @_vcc_wrapped(@state, @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $wrapped($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))), $array(^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assume @_vcc_inv(@state, @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assume $inv($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))), $array(^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $top_writable($s, #wrTime$1^88.1, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assert @reads_check_normal((A->array)); 
    assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), $ptr_to(^^i4));
    assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), $ptr_to(^^i4));
    // assert @reads_check_normal((A->capacity)); 
    assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity), ^^u4);
    assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity), ^^u4);
    // stmt @_vcc_unwrap(@_vcc_as_array(*((A->array)), *((A->capacity))), @_vcc_typeof(@_vcc_as_array(*((A->array)), *((A->capacity))))); 
    call $unwrap($as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))), $array(^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    assume $good_state_ext(#tok$1^93.21, $s);
    // assert @_vcc_inv2(prestate#26, @_vcc_current_state(@state), @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $inv2(prestate#26, $current_state($s), $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))), $array(^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @writes_check(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $top_writable($s, #wrTime$1^88.1, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assert @writes_check(@_vcc_extent(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert (forall #writes$1^94.5: $ptr :: { $dont_instantiate(#writes$1^94.5) } $set_in(#writes$1^94.5, $extent($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))))) ==> $top_writable($s, #wrTime$1^88.1, #writes$1^94.5));
    // assert @reads_check_normal((A->array)); 
    assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), $ptr_to(^^i4));
    assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), $ptr_to(^^i4));
    // assert @reads_check_normal((A->capacity)); 
    assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity), ^^u4);
    assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity), ^^u4);
    // stmt _vcc_free(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
    call $free($as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    assume $full_stop_ext(#tok$1^94.5, $s);
    // assert @writes_check(A); 
    assert $top_writable($s, #wrTime$1^88.1, $ptr(^ArrayList, P#A));
    // assert @writes_check(@_vcc_extent(@state, A)); 
    assert (forall #writes$1^95.5: $ptr :: { $dont_instantiate(#writes$1^95.5) } $set_in(#writes$1^95.5, $extent($s, $ptr(^ArrayList, P#A))) ==> $top_writable($s, #wrTime$1^88.1, #writes$1^95.5));
    // stmt _vcc_free(A); 
    call $free($ptr(^ArrayList, P#A));
    assume $full_stop_ext(#tok$1^95.5, $s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure Add(P#A: int, P#v: int);
  requires F#Length($s, $ref($ptr(^ArrayList, P#A))) < 100000;
  requires $wrapped($s, $ptr(^ArrayList, P#A), ^ArrayList);
  modifies $s, $cev_pc;
  ensures F#Length($s, $ref($ptr(^ArrayList, P#A))) == F#Length(old($s), $ref($ptr(^ArrayList, P#A))) + 1;
  ensures (forall Q#j$1^103.29#tc1: int :: $in_range_u4(Q#j$1^103.29#tc1) ==> Q#j$1^103.29#tc1 < F#Length(old($s), $ref($ptr(^ArrayList, P#A))) ==> F#Select($s, $ref($ptr(^ArrayList, P#A)), Q#j$1^103.29#tc1) == F#Select(old($s), $ref($ptr(^ArrayList, P#A)), Q#j$1^103.29#tc1));
  ensures F#Select($s, $ref($ptr(^ArrayList, P#A)), F#Length($s, $ref($ptr(^ArrayList, P#A))) - 1) == P#v;
  ensures $wrapped($s, $ptr(^ArrayList, P#A), ^ArrayList);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^ArrayList, P#A) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^ArrayList, P#A) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^ArrayList, P#A) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Add(P#A: int, P#v: int)
{
  var owns#33: $ptrset;
  var staticWrapState#32: $state;
  var prestate#34: $state;
  var prestate#31: $state;
  var #wrTime$1^121.40: int;
  var loopState#0: $state;
  var res__vcc_alloc#4: $ptr;
  var L#i: int where $in_range_u4(L#i);
  var L#tmp: int where $in_range_phys_ptr(L#tmp);
  var L#newCapacity: int where $in_range_u4(L#newCapacity);
  var prestate#30: $state;
  var prestate#29: $state;
  var prestate#27: $state;
  var owns#28: $ptrset;
  var #wrTime$1^98.1: int;
  var #stackframe: int;

  anon22:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^98.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^98.1, #loc.A, $ptr_to_int($ptr(^ArrayList, P#A)), $ptr_to(^ArrayList)) && $local_value_is_ptr($s, #tok$1^98.1, #loc.A, $ptr(^ArrayList, P#A), $ptr_to(^ArrayList));
    assume $local_value_is($s, #tok$1^98.1, #loc.v, P#v, ^^i4);
    assume #wrTime$1^98.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^98.1, #p) } $in_writes_at(#wrTime$1^98.1, #p) == (#p == $ptr(^ArrayList, P#A)));
    assume $thread_owned($s, $ptr(^ArrayList, P#A));
    // assume @in_range_phys_ptr((mathint)A); 
    assume $in_range_phys_ptr($ref($ptr(^ArrayList, P#A)));
    // assume @in_range_i4(v); 
    assume $in_range_i4(P#v);
    // assert @_vcc_in_domain(@state, A, A); 
    assert $in_domain_lab($s, $ptr(^ArrayList, P#A), $ptr(^ArrayList, P#A), l#public);
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
    // assert @_vcc_wrapped(@state, A); 
    assert $wrapped($s, $ptr(^ArrayList, P#A), ^ArrayList);
    // assert @writes_check(A); 
    assert $top_writable($s, #wrTime$1^98.1, $ptr(^ArrayList, P#A));
    // assume @_vcc_inv(@state, A); 
    assume $inv($s, $ptr(^ArrayList, P#A), ^ArrayList);
    // prestate#29 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#29, A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    prestate#29 := $release($current_state($s), prestate#29, $ptr(^ArrayList, P#A), $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#29, $state_to_int(prestate#29), ^$#state_t);
    // owns#28 := pure(@_vcc_set_union(owns#28, @_vcc_set_singleton(@_vcc_as_array(*((A->array)), *((A->capacity)))))); 
    owns#28 := $set_union(owns#28, $set_singleton($as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#28, $ptrset_to_int(owns#28), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assume $typed($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assume ==(owns#28, @_vcc_owns(@state, A)); 
    assume owns#28 == $owns($s, $ptr(^ArrayList, P#A));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(A), prestate#29)
    call $static_unwrap($ptr(^ArrayList, P#A), prestate#29);
    assume $good_state_ext(#tok$1^107.32, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#30; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#30, $state_to_int(prestate#30), ^$#state_t);
    // prestate#30 := @_vcc_current_state(@state); 
    prestate#30 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#30, $state_to_int(prestate#30), ^$#state_t);
    // assert @_vcc_wrapped(@state, @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $wrapped($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))), $array(^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assume @_vcc_inv(@state, @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assume $inv($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))), $array(^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $top_writable($s, #wrTime$1^98.1, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assert @reads_check_normal((A->array)); 
    assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), $ptr_to(^^i4));
    assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), $ptr_to(^^i4));
    // assert @reads_check_normal((A->capacity)); 
    assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity), ^^u4);
    assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity), ^^u4);
    // stmt @_vcc_unwrap(@_vcc_as_array(*((A->array)), *((A->capacity))), @_vcc_typeof(@_vcc_as_array(*((A->array)), *((A->capacity))))); 
    call $unwrap($as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))), $array(^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    assume $good_state_ext(#tok$1^107.35, $s);
    // assert @_vcc_inv2(prestate#30, @_vcc_current_state(@state), @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $inv2(prestate#30, $current_state($s), $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))), $array(^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @reads_check_normal((A->capacity)); 
    assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity), ^^u4);
    assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity), ^^u4);
    // assert @reads_check_normal((A->length)); 
    assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.length), ^^u4);
    assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.length), ^^u4);
    assume true;
    // if (==(*((A->capacity)), *((A->length)))) ...
    if ($mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity)) == $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.length)))
    {
      anon19:
        // uint32_t newCapacity; 
        assume $local_value_is($s, #tok$1^111.13, #loc.newCapacity, L#newCapacity, ^^u4);
        // int32_t* tmp; 
        assume $local_value_is($s, #tok$1^110.13, #loc.tmp, $ptr_to_int($ptr(^^i4, L#tmp)), $ptr_to(^^i4)) && $local_value_is_ptr($s, #tok$1^110.13, #loc.tmp, $ptr(^^i4, L#tmp), $ptr_to(^^i4));
        // uint32_t i; 
        assume $local_value_is($s, #tok$1^109.13, #loc.i, L#i, ^^u4);
        // var uint32_t i
        // var int32_t* tmp
        // var uint32_t newCapacity
        // assert @in_range_u4(+(*(*((A->capacity)), 2), 1)); 
        assert $in_range_u4($op_mul($mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity)), 2) + 1);
        // assert @in_range_u4(*(*((A->capacity)), 2)); 
        assert $in_range_u4($op_mul($mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity)), 2));
        // assert @reads_check_normal((A->capacity)); 
        assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity), ^^u4);
        assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity), ^^u4);
        // newCapacity := +(*(*((A->capacity)), 2), 1); 
        L#newCapacity := $op_mul($mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity)), 2) + 1;
        assume $local_value_is($s, #tok$1^113.13, #loc.newCapacity, L#newCapacity, ^^u4);
        // obj_t res__vcc_alloc#4; 
        assume $local_value_is($s, #tok$1^115.19, #loc.res__vcc_alloc#4, $ptr_to_int(res__vcc_alloc#4), $ptr_to(^^void));
        // res__vcc_alloc#4 := _vcc_alloc(@_vcc_array(@_vcc_typeof((int32_t*)@null), newCapacity)); 
        call res__vcc_alloc#4 := $alloc($array(^^i4, L#newCapacity));
        assume $full_stop_ext(#tok$1^115.19, $s);
        assume $local_value_is($s, #tok$1^115.19, #loc.res__vcc_alloc#4, $ptr_to_int(res__vcc_alloc#4), $ptr_to(^^void));
        // tmp := (int32_t*)res__vcc_alloc#4; 
        L#tmp := $ref($ptr_cast(res__vcc_alloc#4, ^^i4));
        assume $local_value_is($s, #tok$1^115.13, #loc.tmp, $ptr_to_int($ptr(^^i4, L#tmp)), $ptr_to(^^i4)) && $local_value_is_ptr($s, #tok$1^115.13, #loc.tmp, $ptr(^^i4, L#tmp), $ptr_to(^^i4));
        // assume @_vcc_ptr_neq(tmp, @null); 
        assume $ptr_neq($ptr(^^i4, L#tmp), $null);
        // i := 0; 
        L#i := 0;
        assume $local_value_is($s, #tok$1^118.13, #loc.i, L#i, ^^u4);
        call $bump_timestamp();
        assume $full_stop_ext(#tok$1^121.40, $s);
        loopState#0 := $s;
        assume #wrTime$1^121.40 == $current_timestamp($s);
        assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^121.40, #p) } $in_writes_at(#wrTime$1^121.40, #p) == $set_in(#p, $array_range($s, $ptr(^^i4, L#tmp), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.length)))));
        assert (forall #loopWrites^$1^121.40: $ptr :: { $dont_instantiate(#loopWrites^$1^121.40) } $top_writable($s, #wrTime$1^121.40, #loopWrites^$1^121.40) ==> $top_writable($s, #wrTime$1^98.1, #loopWrites^$1^121.40));
        while (true)
          invariant (forall Q#j$1^120.43#tc1: int :: $in_range_u4(Q#j$1^120.43#tc1) ==> Q#j$1^120.43#tc1 < L#i ==> $mem($s, $idx($ptr(^^i4, L#tmp), Q#j$1^120.43#tc1, ^^i4)) == $mem(loopState#0, $idx($read_ptr(loopState#0, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), Q#j$1^120.43#tc1, ^^i4)));
        {
          anon18:
            assume (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(loopState#0, #p) || $set_in(#p, $array_range(loopState#0, $ptr(^^i4, L#tmp), ^^i4, $mem(loopState#0, $dot($ptr(^ArrayList, P#A), ArrayList.length)))) || $mem_eq(loopState#0, $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(loopState#0, #p) || $set_in(#p, $array_range(loopState#0, $ptr(^^i4, L#tmp), ^^i4, $mem(loopState#0, $dot($ptr(^ArrayList, P#A), ArrayList.length)))) || $st_eq(loopState#0, $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(loopState#0, #p) || $set_in(#p, $array_range(loopState#0, $ptr(^^i4, L#tmp), ^^i4, $mem(loopState#0, $dot($ptr(^ArrayList, P#A), ArrayList.length)))) || $ts_eq(loopState#0, $s, #p)) && $timestamp_post(loopState#0, $s);
            assume $timestamp_post(loopState#0, $s);
            assume $full_stop_ext(#tok$1^119.13, $s);
            assume $local_value_is($s, #tok$1^119.13, #loc.res__vcc_alloc#4, $ptr_to_int(res__vcc_alloc#4), $ptr_to(^^void));
            assume $local_value_is($s, #tok$1^119.13, #loc.tmp, $ptr_to_int($ptr(^^i4, L#tmp)), $ptr_to(^^i4)) && $local_value_is_ptr($s, #tok$1^119.13, #loc.tmp, $ptr(^^i4, L#tmp), $ptr_to(^^i4));
            assume $local_value_is($s, #tok$1^119.13, #loc.newCapacity, L#newCapacity, ^^u4);
            assume $local_value_is($s, #tok$1^119.13, #loc.prestate#30, $state_to_int(prestate#30), ^$#state_t);
            assume $local_value_is($s, #tok$1^119.13, #loc.prestate#29, $state_to_int(prestate#29), ^$#state_t);
            assume $local_value_is($s, #tok$1^119.13, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
            assume $local_value_is($s, #tok$1^119.13, #loc.owns#28, $ptrset_to_int(owns#28), ^$#ptrset);
            // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
            assume $meta_eq(loopState#0, $s);
            // assert @reads_check_normal((A->length)); 
            assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.length), ^^u4);
            assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.length), ^^u4);
            assume true;
            // if (<(i, *((A->length)))) ...
            if (L#i < $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.length)))
            {
              anon16:
                // assert @_vcc_typed2(@state, tmp[i]); 
                assert $typed2($s, $idx($ptr(^^i4, L#tmp), L#i, ^^i4), ^^i4);
                // assert @prim_writes_check(tmp[i]); 
                assert $writable($s, #wrTime$1^121.40, $idx($ptr(^^i4, L#tmp), L#i, ^^i4));
                // assert @reads_check_normal(*((A->array))[i]); 
                assert $typed2($s, $idx($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), L#i, ^^i4), ^^i4);
                assert $thread_local2($s, $idx($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), L#i, ^^i4), ^^i4);
                // assert @reads_check_normal((A->array)); 
                assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), $ptr_to(^^i4));
                assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), $ptr_to(^^i4));
                // *tmp[i] := *(*((A->array))[i]); 
                call $write_int($idx($ptr(^^i4, L#tmp), L#i, ^^i4), $mem($s, $idx($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), L#i, ^^i4)));
                assume $full_stop_ext(#tok$1^123.17, $s);
                // assert @in_range_u4(+(i, 1)); 
                assert $in_range_u4(L#i + 1);
                // i := +(i, 1); 
                L#i := L#i + 1;
                assume $local_value_is($s, #tok$1^124.17, #loc.i, L#i, ^^u4);
            }
            else
            {
              anon17:
                // goto #break_1; 
                goto #break_1;
            }

          #continue_1:
            assume true;
        }

      anon20:
        assume $full_stop_ext(#tok$1^119.13, $s);

      #break_1:
        // assert @writes_check(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
        assert $top_writable($s, #wrTime$1^98.1, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
        // assert @writes_check(@_vcc_extent(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
        assert (forall #writes$1^126.13: $ptr :: { $dont_instantiate(#writes$1^126.13) } $set_in(#writes$1^126.13, $extent($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))))) ==> $top_writable($s, #wrTime$1^98.1, #writes$1^126.13));
        // assert @reads_check_normal((A->array)); 
        assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), $ptr_to(^^i4));
        assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), $ptr_to(^^i4));
        // assert @reads_check_normal((A->capacity)); 
        assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity), ^^u4);
        assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity), ^^u4);
        // stmt _vcc_free(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
        call $free($as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
        assume $full_stop_ext(#tok$1^126.13, $s);
        // assert @_vcc_typed2(@state, (A->capacity)); 
        assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity), ^^u4);
        // assert @prim_writes_check((A->capacity)); 
        assert $writable($s, #wrTime$1^98.1, $dot($ptr(^ArrayList, P#A), ArrayList.capacity));
        // *(A->capacity) := newCapacity; 
        call $write_int($dot($ptr(^ArrayList, P#A), ArrayList.capacity), L#newCapacity);
        assume $full_stop_ext(#tok$1^127.13, $s);
        // assert @_vcc_typed2(@state, (A->array)); 
        assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), $ptr_to(^^i4));
        // assert @prim_writes_check((A->array)); 
        assert $writable($s, #wrTime$1^98.1, $dot($ptr(^ArrayList, P#A), ArrayList.array));
        // *(A->array) := tmp; 
        call $write_int($dot($ptr(^ArrayList, P#A), ArrayList.array), $ref($ptr(^^i4, L#tmp)));
        assume $full_stop_ext(#tok$1^128.13, $s);
    }
    else
    {
      anon21:
        // empty
    }

  anon23:
    // assert @_vcc_typed2(@state, *((A->array))[*((A->length))]); 
    assert $typed2($s, $idx($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.length)), ^^i4), ^^i4);
    // assert @prim_writes_check(*((A->array))[*((A->length))]); 
    assert $writable($s, #wrTime$1^98.1, $idx($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.length)), ^^i4));
    // assert @reads_check_normal((A->array)); 
    assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), $ptr_to(^^i4));
    assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), $ptr_to(^^i4));
    // assert @reads_check_normal((A->length)); 
    assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.length), ^^u4);
    assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.length), ^^u4);
    // **((A->array))[*((A->length))] := v; 
    call $write_int($idx($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.length)), ^^i4), P#v);
    assume $full_stop_ext(#tok$1^130.9, $s);
    // assert @_vcc_typed2(@state, (A->length)); 
    assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.length), ^^u4);
    // assert @prim_writes_check((A->length)); 
    assert $writable($s, #wrTime$1^98.1, $dot($ptr(^ArrayList, P#A), ArrayList.length));
    // assert @in_range_u4(+(*((A->length)), 1)); 
    assert $in_range_u4($mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.length)) + 1);
    // assert @reads_check_normal((A->length)); 
    assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.length), ^^u4);
    assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.length), ^^u4);
    // *(A->length) := +(*((A->length)), 1); 
    call $write_int($dot($ptr(^ArrayList, P#A), ArrayList.length), $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.length)) + 1);
    assume $full_stop_ext(#tok$1^131.9, $s);
    // _math state_t prestate#31; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#31, $state_to_int(prestate#31), ^$#state_t);
    // prestate#31 := @_vcc_current_state(@state); 
    prestate#31 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#31, $state_to_int(prestate#31), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $top_writable($s, #wrTime$1^98.1, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assert @writes_check(@_vcc_owns(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert (forall #writes$1^107.35: $ptr :: { $dont_instantiate(#writes$1^107.35) } $set_in(#writes$1^107.35, $owns($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))))) ==> $top_writable($s, #wrTime$1^98.1, #writes$1^107.35));
    // assert @reads_check_normal((A->array)); 
    assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), $ptr_to(^^i4));
    assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), $ptr_to(^^i4));
    // assert @reads_check_normal((A->capacity)); 
    assert $typed2($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity), ^^u4);
    assert $thread_local2($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity), ^^u4);
    // stmt @_vcc_wrap(@_vcc_as_array(*((A->array)), *((A->capacity))), @_vcc_typeof(@_vcc_as_array(*((A->array)), *((A->capacity))))); 
    call $wrap($as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))), $array(^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    assume $good_state_ext(#tok$1^107.35, $s);
    // assert @_vcc_inv2(prestate#31, @_vcc_current_state(@state), @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $inv2(prestate#31, $current_state($s), $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))), $array(^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
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
    // assert @writes_check(A); 
    assert $top_writable($s, #wrTime$1^98.1, $ptr(^ArrayList, P#A));
    // assert @_vcc_wrapped(@state, @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $wrapped($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))), $array(^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assert @writes_check(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $top_writable($s, #wrTime$1^98.1, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // owns#33 := pure(@_vcc_set_union(owns#33, @_vcc_set_singleton(@_vcc_as_array(*((A->array)), *((A->capacity)))))); 
    owns#33 := $set_union(owns#33, $set_singleton($as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#33, $ptrset_to_int(owns#33), ^$#ptrset);
    // staticWrapState#32 := pure(@_vcc_take_over(staticWrapState#32, A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    staticWrapState#32 := $take_over(staticWrapState#32, $ptr(^ArrayList, P#A), $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#32, $state_to_int(staticWrapState#32), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(A), staticWrapState#32, owns#33)
    call $static_wrap($ptr(^ArrayList, P#A), staticWrapState#32, owns#33);
    assume $good_state_ext(#tok$1^107.32, $s);
    // assert @inv_check(@_vcc_is_malloc_root(@state, A)); 
    assert $is_malloc_root($s, $ptr(^ArrayList, P#A));
    // assert @inv_check(<=(*((A->length)), *((A->capacity)))); 
    assert $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.length)) <= $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity));
    // assert @inv_check(@keeps_stable(old(prestate#34, @_vcc_as_array(*((A->array)), *((A->capacity)))), @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $as_array($read_ptr(prestate#34, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem(prestate#34, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))) == $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity)));
    // assert @inv_check(@keeps(A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $keeps($s, $ptr(^ArrayList, P#A), $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assert @inv_check(@_vcc_is_malloc_root(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $is_malloc_root($s, $as_array($read_ptr($s, $dot($ptr(^ArrayList, P#A), ArrayList.array), ^^i4), ^^i4, $mem($s, $dot($ptr(^ArrayList, P#A), ArrayList.capacity))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure main_test() returns ($result: int);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation main_test() returns ($result: int)
{
  var loopState#1: $state;
  var L#N: int where $in_range_u4(L#N);
  var L#A: int where $in_range_phys_ptr(L#A);
  var L#i: int where $in_range_u4(L#i);
  var #wrTime$1^135.1: int;
  var #stackframe: int;

  anon27:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^135.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^135.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^135.1, #p) } $in_writes_at(#wrTime$1^135.1, #p) == false);
    // uint32_t i; 
    assume $local_value_is($s, #tok$1^139.5, #loc.i, L#i, ^^u4);
    // struct ArrayList* A; 
    assume $local_value_is($s, #tok$1^138.12, #loc.A, $ptr_to_int($ptr(^ArrayList, L#A)), $ptr_to(^ArrayList)) && $local_value_is_ptr($s, #tok$1^138.12, #loc.A, $ptr(^ArrayList, L#A), $ptr_to(^ArrayList));
    // uint32_t N; 
    assume $local_value_is($s, #tok$1^137.5, #loc.N, L#N, ^^u4);
    // N := 42; 
    L#N := 42;
    assume $local_value_is($s, #tok$1^137.5, #loc.N, L#N, ^^u4);
    // non-pure function
    // A := CreateArrayList(N); 
    call L#A := CreateArrayList(L#N);
    assume $full_stop_ext(#tok$1^138.27, $s);
    assume $local_value_is($s, #tok$1^138.27, #loc.A, $ptr_to_int($ptr(^ArrayList, L#A)), $ptr_to(^ArrayList)) && $local_value_is_ptr($s, #tok$1^138.27, #loc.A, $ptr(^ArrayList, L#A), $ptr_to(^ArrayList));
    // i := 0; 
    L#i := 0;
    assume $local_value_is($s, #tok$1^139.5, #loc.i, L#i, ^^u4);
    loopState#1 := $s;
    while (true)
      invariant $wrapped($s, $ptr(^ArrayList, L#A), ^ArrayList);
      invariant F#Length($s, $ref($ptr(^ArrayList, L#A))) == L#i;
      invariant (forall Q#j$1^144.35#tc1: int :: $in_range_u4(Q#j$1^144.35#tc1) ==> Q#j$1^144.35#tc1 < L#i ==> F#Select($s, $ref($ptr(^ArrayList, L#A)), Q#j$1^144.35#tc1) == Q#j$1^144.35#tc1);
    {
      anon26:
        assume $writes_nothing(old($s), $s);
        assume $timestamp_post(loopState#1, $s);
        assume $full_stop_ext(#tok$1^141.5, $s);
        assume $local_value_is($s, #tok$1^141.5, #loc.N, L#N, ^^u4);
        assume true;
        // if (<(i, N)) ...
        if (L#i < L#N)
        {
          anon24:
            // assert @writes_check(A); 
            assert $top_writable($s, #wrTime$1^135.1, $ptr(^ArrayList, L#A));
            // assert @in_range_i4((int32_t)i); 
            assert $in_range_i4(L#i);
            // stmt Add(A, (int32_t)i); 
            call Add($ref($ptr(^ArrayList, L#A)), L#i);
            assume $full_stop_ext(#tok$1^146.9, $s);
            // assert @in_range_u4(+(i, 1)); 
            assert $in_range_u4(L#i + 1);
            // i := +(i, 1); 
            L#i := L#i + 1;
            assume $local_value_is($s, #tok$1^147.9, #loc.i, L#i, ^^u4);
        }
        else
        {
          anon25:
            // goto #break_2; 
            goto #break_2;
        }

      #continue_2:
        assume true;
    }

  anon28:
    assume $full_stop_ext(#tok$1^141.5, $s);

  #break_2:
    // assert @writes_check(A); 
    assert $top_writable($s, #wrTime$1^135.1, $ptr(^ArrayList, L#A));
    // stmt DisposeArrayList(A); 
    call DisposeArrayList($ref($ptr(^ArrayList, L#A)));
    assume $full_stop_ext(#tok$1^149.5, $s);
    // return 0; 
    $result := 0;
    assert $position_marker();
    goto #exit;

  anon29:
    // empty

  #exit:
}



const unique l#public: $label;

const unique #tok$1^149.5: $token;

const unique #tok$1^147.9: $token;

const unique #tok$1^146.9: $token;

const unique #tok$1^141.5: $token;

const unique #tok$1^138.27: $token;

const unique #loc.N: $token;

const unique #tok$1^137.5: $token;

const unique #tok$1^138.12: $token;

const unique #tok$1^139.5: $token;

const unique #tok$1^135.1: $token;

const unique #loc.owns#33: $token;

const unique #loc.staticWrapState#32: $token;

const unique #loc.prestate#34: $token;

const unique #loc.prestate#31: $token;

const unique #tok$1^131.9: $token;

const unique #tok$1^130.9: $token;

const unique #tok$1^128.13: $token;

const unique #tok$1^127.13: $token;

const unique #tok$1^126.13: $token;

const unique #tok$1^124.17: $token;

const unique #tok$1^123.17: $token;

const unique #tok$1^119.13: $token;

const unique #tok$1^121.40: $token;

const unique #tok$1^118.13: $token;

const unique #tok$1^115.13: $token;

const unique #loc.res__vcc_alloc#4: $token;

const unique #tok$1^115.19: $token;

const unique #tok$1^113.13: $token;

const unique #tok$1^109.13: $token;

const unique #loc.tmp: $token;

const unique #tok$1^110.13: $token;

const unique #loc.newCapacity: $token;

const unique #tok$1^111.13: $token;

const unique #tok$1^107.35: $token;

const unique #loc.prestate#30: $token;

const unique #tok$1^107.32: $token;

const unique #loc.prestate#29: $token;

const unique #loc.prestate#27: $token;

const unique #loc.owns#28: $token;

const unique #tok$1^98.1: $token;

const unique #tok$1^95.5: $token;

const unique #tok$1^94.5: $token;

const unique #tok$1^93.21: $token;

const unique #loc.prestate#26: $token;

const unique #tok$1^92.21: $token;

const unique #loc.prestate#25: $token;

const unique #loc.prestate#23: $token;

const unique #loc.owns#24: $token;

const unique #tok$1^88.1: $token;

const unique #loc.owns#21: $token;

const unique #loc.staticWrapState#20: $token;

const unique #loc.prestate#22: $token;

const unique #loc.prestate#19: $token;

const unique #tok$1^85.9: $token;

const unique #tok$1^84.35: $token;

const unique #loc.prestate#18: $token;

const unique #tok$1^84.32: $token;

const unique #loc.prestate#17: $token;

const unique #loc.prestate#15: $token;

const unique #loc.owns#16: $token;

const unique #loc.v: $token;

const unique #tok$1^77.1: $token;

axiom $type_code_is(1, ^^u4);

const unique #loc.i: $token;

const unique #tok$1^67.17: $token;

const unique #tok$1^64.21: $token;

const unique #loc.owns#13: $token;

const unique #loc.staticWrapState#12: $token;

const unique #loc.prestate#14: $token;

const unique #tok$1^63.5: $token;

const unique #tok$1^62.21: $token;

const unique #loc.prestate#11: $token;

const unique #loc.prestate#9: $token;

const unique #loc.owns#10: $token;

const unique #tok$1^57.1: $token;

const unique #tok$1^53.21: $token;

const unique #loc.owns#7: $token;

const unique #loc.staticWrapState#6: $token;

const unique #loc.prestate#8: $token;

const unique #tok$1^52.21: $token;

function $state_to_int(x: $state) : int;

function $int_to_state(x: int) : $state;

axiom (forall #x: $state :: #x == $int_to_state($state_to_int(#x)));

const unique #loc.prestate#5: $token;

const unique #tok$2^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(2, #file^?3Cno?20file?3E);

const unique #tok$1^49.5: $token;

const unique #distTp3: $ctype;

axiom #distTp3 == $ptr_to(^^void);

const unique #loc.res__vcc_alloc#3: $token;

const unique #tok$1^49.16: $token;

const unique #tok$1^48.5: $token;

const unique #tok$1^47.5: $token;

const unique #tok$1^44.9: $token;

const unique #tok$1^42.12: $token;

const unique #loc.InitialCapacity: $token;

const unique #tok$1^36.8: $token;

const unique #loc.A: $token;

const unique #tok$1^27.17: $token;

const unique #distTp2: $ctype;

axiom #distTp2 == $ptr_to(^ArrayList);

const unique #loc._this_: $token;

const unique #tok$1^16.1: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CArrayList.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CArrayList.c);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^^i4);
