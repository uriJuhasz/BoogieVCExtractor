axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

const unique ^ArrayList: $ctype;

axiom $is_span_sequential(^ArrayList);

axiom $def_struct_type(^ArrayList, 16, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^ArrayList) } $inv2(#s1, #s2, #p, ^ArrayList) == ($is_malloc_root(#s2, #p) && $rd_inv(#s2, ArrayList.length, #p) <= $rd_inv(#s2, ArrayList.capacity, #p) && $as_array($rd_phys_ptr(#s1, ArrayList.array, #p, ^^i4), ^^i4, $rd_inv(#s1, ArrayList.capacity, #p)) == $as_array($rd_phys_ptr(#s2, ArrayList.array, #p, ^^i4), ^^i4, $rd_inv(#s2, ArrayList.capacity, #p)) && $keeps(#s2, #p, $as_array($rd_phys_ptr(#s2, ArrayList.array, #p, ^^i4), ^^i4, $rd_inv(#s2, ArrayList.capacity, #p))) && $is_malloc_root(#s2, $as_array($rd_phys_ptr(#s2, ArrayList.array, #p, ^^i4), ^^i4, $rd_inv(#s2, ArrayList.capacity, #p)))));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^ArrayList)) } $in(q, $composite_extent(s, p, ^ArrayList)) == (q == p));

const unique ArrayList.capacity: $field;

axiom $def_phys_field(^ArrayList, ArrayList.capacity, ^^u4, false, 0);

const unique ArrayList.length: $field;

axiom $def_phys_field(^ArrayList, ArrayList.length, ^^u4, false, 4);

const unique ArrayList.array: $field;

axiom $def_phys_field(^ArrayList, ArrayList.array, $ptr_to(^^i4), false, 8);

procedure ArrayList#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $is_malloc_root($s, $phys_ptr_cast(P#_this_, ^ArrayList));
  ensures $is_admissibility_check() ==> $rd_inv($s, ArrayList.length, $phys_ptr_cast(P#_this_, ^ArrayList)) <= $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#_this_, ^ArrayList));
  ensures $is_admissibility_check() ==> $as_array($rd_phys_ptr(old($s), ArrayList.array, $phys_ptr_cast(P#_this_, ^ArrayList), ^^i4), ^^i4, $rd_inv(old($s), ArrayList.capacity, $phys_ptr_cast(P#_this_, ^ArrayList))) == $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#_this_, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#_this_, ^ArrayList)));
  ensures $is_admissibility_check() ==> $keeps($s, $phys_ptr_cast(P#_this_, ^ArrayList), $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#_this_, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#_this_, ^ArrayList))));
  ensures $is_admissibility_check() ==> $is_malloc_root($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#_this_, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#_this_, ^ArrayList))));
  ensures $is_stuttering_check() ==> $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#_this_, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#_this_, ^ArrayList))) == $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#_this_, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#_this_, ^ArrayList)));
  ensures $is_unwrap_check() ==> $is_malloc_root($s, $phys_ptr_cast(P#_this_, ^ArrayList));
  ensures $is_unwrap_check() ==> $rd_inv($s, ArrayList.length, $phys_ptr_cast(P#_this_, ^ArrayList)) <= $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#_this_, ^ArrayList));
  ensures $is_unwrap_check() ==> $as_array($rd_phys_ptr(old($s), ArrayList.array, $phys_ptr_cast(P#_this_, ^ArrayList), ^^i4), ^^i4, $rd_inv(old($s), ArrayList.capacity, $phys_ptr_cast(P#_this_, ^ArrayList))) == $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#_this_, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#_this_, ^ArrayList)));
  ensures $is_unwrap_check() ==> $keeps($s, $phys_ptr_cast(P#_this_, ^ArrayList), $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#_this_, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#_this_, ^ArrayList))));
  ensures $is_unwrap_check() ==> $is_malloc_root($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#_this_, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#_this_, ^ArrayList))));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation ArrayList#adm(P#_this_: $ptr)
{
  var #wrTime$1^16.1: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^16.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^16.1, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^ArrayList));
    assume #wrTime$1^16.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^16.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($phys_ptr_cast(P#_this_, ^ArrayList), ^ArrayList);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $phys_ptr_cast(P#_this_, ^ArrayList));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($phys_ptr_cast(P#_this_, ^ArrayList));
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
            assume $admissibility_pre($s, $phys_ptr_cast(P#_this_, ^ArrayList));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $phys_ptr_cast(P#_this_, ^ArrayList));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct ArrayList*)@null))
        call $havoc_others($phys_ptr_cast(P#_this_, ^ArrayList), ^ArrayList);
        assume $good_state_ext(#tok$1^16.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $phys_ptr_cast(P#_this_, ^ArrayList), ^ArrayList);
    }

  #exit:
}



const unique ^$#fnptr#1: $ctype;

axiom $def_fnptr_type(^$#fnptr#1);

type $#fnptr#1;

const unique ^$#fnptr#2: $ctype;

axiom $def_fnptr_type(^$#fnptr#2);

type $#fnptr#2;

const unique ^$#fnptr#3: $ctype;

axiom $def_fnptr_type(^$#fnptr#3);

type $#fnptr#3;

const unique ^$#fnptr#4: $ctype;

axiom $def_fnptr_type(^$#fnptr#4);

type $#fnptr#4;

const unique ^$#fnptr#5: $ctype;

axiom $def_fnptr_type(^$#fnptr#5);

type $#fnptr#5;

const unique ^$#fnptr#6: $ctype;

axiom $def_fnptr_type(^$#fnptr#6);

type $#fnptr#6;

const unique ^$#fnptr#7: $ctype;

axiom $def_fnptr_type(^$#fnptr#7);

type $#fnptr#7;

const unique ^$#fnptr#8: $ctype;

axiom $def_fnptr_type(^$#fnptr#8);

type $#fnptr#8;

function F#Length(#s: $state, P#A: $ptr) : int;

const unique cf#Length: $pure_function;

axiom (forall #s: $state, P#A: $ptr :: { F#Length(#s, P#A) } $wrapped(#s, $phys_ptr_cast(P#A, ^ArrayList), ^ArrayList) ==> $in_range_u4(F#Length(#s, P#A)) && F#Length(#s, P#A) == $rd_inv(#s, ArrayList.length, $phys_ptr_cast(P#A, ^ArrayList)));

axiom $function_arg_type(cf#Length, 0, ^^u4);

axiom $function_arg_type(cf#Length, 1, $ptr_to(^ArrayList));

procedure Length(P#A: $ptr) returns ($result: int);
  requires $wrapped($s, $phys_ptr_cast(P#A, ^ArrayList), ^ArrayList);
  free ensures $in_range_u4($result);
  ensures $result == $rd_inv($s, ArrayList.length, $phys_ptr_cast(P#A, ^ArrayList));
  free ensures $result == F#Length($s, P#A);
  free ensures $call_transition(old($s), $s);



implementation Length(P#A: $ptr) returns ($result: int)
{
  var #wrTime$1^27.17: int;
  var #stackframe: int;

  anon7:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^27.17, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^27.17, #loc.A, $ptr_to_int(P#A), $ptr_to(^ArrayList));
    assume #wrTime$1^27.17 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^27.17, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, A, A); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#A, ^ArrayList), $phys_ptr_cast(P#A, ^ArrayList), l#public);
    // assert @reads_check_normal((A->length)); 
    assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
    // return *((A->length)); 
    $result := $rd_inv($s, ArrayList.length, $phys_ptr_cast(P#A, ^ArrayList));
    assert $position_marker();
    goto #exit;

  anon8:
    // empty

  #exit:
}



procedure CreateArrayList(P#InitialCapacity: int) returns ($result: $ptr);
  requires 0 < P#InitialCapacity;
  modifies $s, $cev_pc;
  free ensures true;
  ensures $wrapped($s, $phys_ptr_cast($result, ^ArrayList), ^ArrayList);
  ensures $is_fresh(old($s), $s, $phys_ptr_cast($result, ^ArrayList));
  ensures F#Length($s, $phys_ptr_cast($result, ^ArrayList)) == 0;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation CreateArrayList(P#InitialCapacity: int) returns ($result: $ptr)
{
  var owns#7: $ptrset;
  var staticWrapState#6: $state;
  var prestate#8: $state;
  var prestate#5: $state;
  var res__vcc_alloc#3: $ptr;
  var L#A: $ptr;
  var #wrTime$1^36.8: int;
  var #stackframe: int;

  anon9:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^36.8, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^36.8, #loc.InitialCapacity, P#InitialCapacity, ^^u4);
    assume #wrTime$1^36.8 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^36.8, (lambda #p: $ptr :: false));
    // assume @in_range_u4(InitialCapacity); 
    assume $in_range_u4(P#InitialCapacity);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // struct ArrayList* A; 
    assume $local_value_is($s, #tok$1^42.12, #loc.A, $ptr_to_int(L#A), $ptr_to(^ArrayList));
    // var struct ArrayList* A
    // A := _vcc_alloc(@_vcc_typeof((struct ArrayList*)@null)); 
    call L#A := $alloc(^ArrayList);
    assume $full_stop_ext(#tok$1^44.9, $s);
    assume $local_value_is($s, #tok$1^44.9, #loc.A, $ptr_to_int(L#A), $ptr_to(^ArrayList));
    // assume @_vcc_ptr_neq_null(A); 
    assume $non_null($phys_ptr_cast(L#A, ^ArrayList));
    // assert @prim_writes_check((A->capacity)); 
    assert $writable_prim($s, #wrTime$1^36.8, $dot($phys_ptr_cast(L#A, ^ArrayList), ArrayList.capacity));
    // *(A->capacity) := InitialCapacity; 
    call $write_int(ArrayList.capacity, $phys_ptr_cast(L#A, ^ArrayList), P#InitialCapacity);
    assume $full_stop_ext(#tok$1^47.5, $s);
    // assert @prim_writes_check((A->length)); 
    assert $writable_prim($s, #wrTime$1^36.8, $dot($phys_ptr_cast(L#A, ^ArrayList), ArrayList.length));
    // *(A->length) := 0; 
    call $write_int(ArrayList.length, $phys_ptr_cast(L#A, ^ArrayList), 0);
    assume $full_stop_ext(#tok$1^48.5, $s);
    // obj_t res__vcc_alloc#3; 
    assume $local_value_is($s, #tok$1^49.16, #loc.res__vcc_alloc#3, $ptr_to_int(res__vcc_alloc#3), ^^object);
    // res__vcc_alloc#3 := _vcc_alloc(@_vcc_array(@_vcc_typeof((int32_t*)@null), InitialCapacity)); 
    call res__vcc_alloc#3 := $alloc($array(^^i4, P#InitialCapacity));
    assume $full_stop_ext(#tok$1^49.16, $s);
    assume $local_value_is($s, #tok$1^49.16, #loc.res__vcc_alloc#3, $ptr_to_int(res__vcc_alloc#3), ^^object);
    // assert @prim_writes_check((A->array)); 
    assert $writable_prim($s, #wrTime$1^36.8, $dot($phys_ptr_cast(L#A, ^ArrayList), ArrayList.array));
    // *(A->array) := (int32_t*)res__vcc_alloc#3; 
    call $write_int(ArrayList.array, $phys_ptr_cast(L#A, ^ArrayList), $ptr_to_int($phys_ptr_cast(res__vcc_alloc#3, ^^i4)));
    assume $full_stop_ext(#tok$1^49.5, $s);
    // assume @_vcc_ptr_neq_null(*((A->array))); 
    assume $non_null($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(L#A, ^ArrayList), ^^i4));
    // _math state_t prestate#5; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#5, $state_to_int(prestate#5), ^$#state_t);
    // prestate#5 := @_vcc_current_state(@state); 
    prestate#5 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#5, $state_to_int(prestate#5), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(@_vcc_as_array(*((A->array)), InitialCapacity)); 
    assert $top_writable($s, #wrTime$1^36.8, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(L#A, ^ArrayList), ^^i4), ^^i4, P#InitialCapacity));
    // assert @writes_check(@_vcc_owns(@state, @_vcc_as_array(*((A->array)), InitialCapacity))); 
    assert (forall #writes$1^52.21: $ptr :: { $dont_instantiate(#writes$1^52.21) } $set_in(#writes$1^52.21, $owns($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(L#A, ^ArrayList), ^^i4), ^^i4, P#InitialCapacity))) ==> $top_writable($s, #wrTime$1^36.8, #writes$1^52.21));
    // assert @reads_check_normal((A->array)); 
    assert $thread_local($s, $phys_ptr_cast(L#A, ^ArrayList));
    // stmt @_vcc_wrap(@_vcc_as_array(*((A->array)), InitialCapacity), @_vcc_typeof(@_vcc_as_array(*((A->array)), InitialCapacity))); 
    call $wrap($as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(L#A, ^ArrayList), ^^i4), ^^i4, P#InitialCapacity), $array(^^i4, P#InitialCapacity));
    assume $good_state_ext(#tok$1^52.21, $s);
    // assert @_vcc_inv2(prestate#5, @_vcc_current_state(@state), @_vcc_as_array(*((A->array)), InitialCapacity)); 
    assert $inv2(prestate#5, $current_state($s), $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(L#A, ^ArrayList), ^^i4), ^^i4, P#InitialCapacity), $array(^^i4, P#InitialCapacity));
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
    assert $top_writable($s, #wrTime$1^36.8, $phys_ptr_cast(L#A, ^ArrayList));
    // assert @_vcc_wrapped(@state, @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $wrapped($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(L#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(L#A, ^ArrayList))), $array(^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(L#A, ^ArrayList))));
    // assert @writes_check(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $top_writable($s, #wrTime$1^36.8, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(L#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(L#A, ^ArrayList))));
    // owns#7 := pure(@_vcc_set_union(owns#7, @_vcc_set_singleton(@_vcc_as_array(*((A->array)), *((A->capacity)))))); 
    owns#7 := $set_union(owns#7, $set_singleton($as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(L#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(L#A, ^ArrayList)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#7, $ptrset_to_int(owns#7), ^$#ptrset);
    // staticWrapState#6 := pure(@_vcc_take_over(staticWrapState#6, A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    staticWrapState#6 := $take_over(staticWrapState#6, $phys_ptr_cast(L#A, ^ArrayList), $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(L#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(L#A, ^ArrayList))));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#6, $state_to_int(staticWrapState#6), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(A), staticWrapState#6, owns#7)
    call $static_wrap($phys_ptr_cast(L#A, ^ArrayList), staticWrapState#6, owns#7);
    assume $good_state_ext(#tok$1^53.21, $s);
    // assert @inv_check(@_vcc_is_malloc_root(@state, A)); 
    assert $is_malloc_root($s, $phys_ptr_cast(L#A, ^ArrayList));
    // assert @inv_check(<=(*((A->length)), *((A->capacity)))); 
    assert $rd_inv($s, ArrayList.length, $phys_ptr_cast(L#A, ^ArrayList)) <= $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(L#A, ^ArrayList));
    // assert @inv_check(@keeps_stable(old(prestate#8, @_vcc_as_array(*((A->array)), *((A->capacity)))), @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $as_array($rd_phys_ptr(prestate#8, ArrayList.array, $phys_ptr_cast(L#A, ^ArrayList), ^^i4), ^^i4, $rd_inv(prestate#8, ArrayList.capacity, $phys_ptr_cast(L#A, ^ArrayList))) == $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(L#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(L#A, ^ArrayList)));
    // assert @inv_check(@keeps(A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $keeps($s, $phys_ptr_cast(L#A, ^ArrayList), $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(L#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(L#A, ^ArrayList))));
    // assert @inv_check(@_vcc_is_malloc_root(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $is_malloc_root($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(L#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(L#A, ^ArrayList))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return A; 
    $result := $phys_ptr_cast(L#A, ^ArrayList);
    assert $position_marker();
    goto #exit;

  anon10:
    // empty

  #exit:
}



procedure MakeEmpty(P#A: $ptr);
  requires $wrapped($s, $phys_ptr_cast(P#A, ^ArrayList), ^ArrayList);
  modifies $s, $cev_pc;
  ensures F#Length($s, $phys_ptr_cast(P#A, ^ArrayList)) == 0;
  ensures $wrapped($s, $phys_ptr_cast(P#A, ^ArrayList), ^ArrayList);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#A, ^ArrayList)));
  free ensures $call_transition(old($s), $s);



implementation MakeEmpty(P#A: $ptr)
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
    assume $local_value_is($s, #tok$1^57.1, #loc.A, $ptr_to_int(P#A), $ptr_to(^ArrayList));
    assume #wrTime$1^57.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^57.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#A, ^ArrayList)));
    assume $thread_owned($s, $phys_ptr_cast(P#A, ^ArrayList));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, A, A); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#A, ^ArrayList), $phys_ptr_cast(P#A, ^ArrayList), l#public);
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
    assert $wrapped($s, $phys_ptr_cast(P#A, ^ArrayList), ^ArrayList);
    // assert @writes_check(A); 
    assert $top_writable($s, #wrTime$1^57.1, $phys_ptr_cast(P#A, ^ArrayList));
    // assume @_vcc_inv(@state, A); 
    assume $inv($s, $phys_ptr_cast(P#A, ^ArrayList), ^ArrayList);
    // prestate#11 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#11, A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    prestate#11 := $release($current_state($s), prestate#11, $phys_ptr_cast(P#A, ^ArrayList), $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#11, $state_to_int(prestate#11), ^$#state_t);
    // owns#10 := pure(@_vcc_set_union(owns#10, @_vcc_set_singleton(@_vcc_as_array(*((A->array)), *((A->capacity)))))); 
    owns#10 := $set_union(owns#10, $set_singleton($as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#10, $ptrset_to_int(owns#10), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assume $typed($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assume ==(owns#10, @_vcc_owns(@state, A)); 
    assume owns#10 == $owns($s, $phys_ptr_cast(P#A, ^ArrayList));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(A), prestate#11)
    call $static_unwrap($phys_ptr_cast(P#A, ^ArrayList), prestate#11);
    assume $good_state_ext(#tok$1^62.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((A->length)); 
    assert $writable_prim($s, #wrTime$1^57.1, $dot($phys_ptr_cast(P#A, ^ArrayList), ArrayList.length));
    // *(A->length) := 0; 
    call $write_int(ArrayList.length, $phys_ptr_cast(P#A, ^ArrayList), 0);
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
    assert $top_writable($s, #wrTime$1^57.1, $phys_ptr_cast(P#A, ^ArrayList));
    // assert @_vcc_wrapped(@state, @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $wrapped($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))), $array(^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assert @writes_check(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $top_writable($s, #wrTime$1^57.1, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // owns#13 := pure(@_vcc_set_union(owns#13, @_vcc_set_singleton(@_vcc_as_array(*((A->array)), *((A->capacity)))))); 
    owns#13 := $set_union(owns#13, $set_singleton($as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#13, $ptrset_to_int(owns#13), ^$#ptrset);
    // staticWrapState#12 := pure(@_vcc_take_over(staticWrapState#12, A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    staticWrapState#12 := $take_over(staticWrapState#12, $phys_ptr_cast(P#A, ^ArrayList), $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#12, $state_to_int(staticWrapState#12), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(A), staticWrapState#12, owns#13)
    call $static_wrap($phys_ptr_cast(P#A, ^ArrayList), staticWrapState#12, owns#13);
    assume $good_state_ext(#tok$1^64.21, $s);
    // assert @inv_check(@_vcc_is_malloc_root(@state, A)); 
    assert $is_malloc_root($s, $phys_ptr_cast(P#A, ^ArrayList));
    // assert @inv_check(<=(*((A->length)), *((A->capacity)))); 
    assert $rd_inv($s, ArrayList.length, $phys_ptr_cast(P#A, ^ArrayList)) <= $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList));
    // assert @inv_check(@keeps_stable(old(prestate#14, @_vcc_as_array(*((A->array)), *((A->capacity)))), @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $as_array($rd_phys_ptr(prestate#14, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv(prestate#14, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))) == $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList)));
    // assert @inv_check(@keeps(A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $keeps($s, $phys_ptr_cast(P#A, ^ArrayList), $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assert @inv_check(@_vcc_is_malloc_root(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $is_malloc_root($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



function F#Select(#s: $state, P#A: $ptr, P#i: int) : int;

const unique cf#Select: $pure_function;

axiom (forall #s: $state, P#A: $ptr, P#i: int :: { F#Select(#s, P#A, P#i) } P#i < F#Length(#s, $phys_ptr_cast(P#A, ^ArrayList)) && $wrapped(#s, $phys_ptr_cast(P#A, ^ArrayList), ^ArrayList) ==> $in_range_i4(F#Select(#s, P#A, P#i)) && F#Select(#s, P#A, P#i) == $rd_inv(#s, $field($idx($rd_phys_ptr(#s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), P#i)), $emb0($idx($rd_phys_ptr(#s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), P#i))));

axiom $function_arg_type(cf#Select, 0, ^^i4);

axiom $function_arg_type(cf#Select, 1, $ptr_to(^ArrayList));

axiom $function_arg_type(cf#Select, 2, ^^u4);

procedure Select(P#A: $ptr, P#i: int) returns ($result: int);
  requires P#i < F#Length($s, $phys_ptr_cast(P#A, ^ArrayList));
  requires $wrapped($s, $phys_ptr_cast(P#A, ^ArrayList), ^ArrayList);
  free ensures $in_range_i4($result);
  ensures $result == $rd_inv($s, $field($idx($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), P#i)), $emb0($idx($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), P#i)));
  free ensures $result == F#Select($s, P#A, P#i);
  free ensures $call_transition(old($s), $s);



implementation Select(P#A: $ptr, P#i: int) returns ($result: int)
{
  var #wrTime$1^67.17: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^67.17, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^67.17, #loc.A, $ptr_to_int(P#A), $ptr_to(^ArrayList));
    assume $local_value_is($s, #tok$1^67.17, #loc.i, P#i, ^^u4);
    assume #wrTime$1^67.17 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^67.17, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @in_range_u4(i); 
    assume $in_range_u4(P#i);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, A, A); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#A, ^ArrayList), $phys_ptr_cast(P#A, ^ArrayList), l#public);
    // assert @reads_check_normal(*((A->array))[i]); 
    assert $thread_local($s, $idx($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), P#i));
    // assert @reads_check_normal((A->array)); 
    assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
    // return *(*((A->array))[i]); 
    $result := $rd_inv($s, $field($idx($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), P#i)), $emb0($idx($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), P#i)));
    assert $position_marker();
    goto #exit;

  anon13:
    // empty

  #exit:
}



procedure Update(P#A: $ptr, P#i: int, P#v: int);
  requires P#i < F#Length($s, $phys_ptr_cast(P#A, ^ArrayList));
  requires $wrapped($s, $phys_ptr_cast(P#A, ^ArrayList), ^ArrayList);
  modifies $s, $cev_pc;
  ensures (forall Q#j$1^81.29#tc1: int :: {:weight 10} { F#Select($s, $phys_ptr_cast(P#A, ^ArrayList), Q#j$1^81.29#tc1) } $in_range_u4(Q#j$1^81.29#tc1) ==> Q#j$1^81.29#tc1 < F#Length($s, $phys_ptr_cast(P#A, ^ArrayList)) ==> F#Select($s, $phys_ptr_cast(P#A, ^ArrayList), Q#j$1^81.29#tc1) == (if Q#j$1^81.29#tc1 == P#i then P#v else $rd_inv(old($s), $field($idx($rd_phys_ptr(old($s), ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), Q#j$1^81.29#tc1)), $emb0($idx($rd_phys_ptr(old($s), ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), Q#j$1^81.29#tc1)))));
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#A, ^ArrayList)));
  free ensures $call_transition(old($s), $s);



implementation Update(P#A: $ptr, P#i: int, P#v: int)
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
    assume $local_value_is($s, #tok$1^77.1, #loc.A, $ptr_to_int(P#A), $ptr_to(^ArrayList));
    assume $local_value_is($s, #tok$1^77.1, #loc.i, P#i, ^^u4);
    assume $local_value_is($s, #tok$1^77.1, #loc.v, P#v, ^^i4);
    assume #wrTime$1^77.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^77.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#A, ^ArrayList)));
    assume $thread_owned($s, $phys_ptr_cast(P#A, ^ArrayList));
    // assume true; 
    assume true;
    // assume @in_range_u4(i); 
    assume $in_range_u4(P#i);
    // assume @in_range_i4(v); 
    assume $in_range_i4(P#v);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, A, A); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#A, ^ArrayList), $phys_ptr_cast(P#A, ^ArrayList), l#public);
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
    assert $wrapped($s, $phys_ptr_cast(P#A, ^ArrayList), ^ArrayList);
    // assert @writes_check(A); 
    assert $top_writable($s, #wrTime$1^77.1, $phys_ptr_cast(P#A, ^ArrayList));
    // assume @_vcc_inv(@state, A); 
    assume $inv($s, $phys_ptr_cast(P#A, ^ArrayList), ^ArrayList);
    // prestate#17 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#17, A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    prestate#17 := $release($current_state($s), prestate#17, $phys_ptr_cast(P#A, ^ArrayList), $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#17, $state_to_int(prestate#17), ^$#state_t);
    // owns#16 := pure(@_vcc_set_union(owns#16, @_vcc_set_singleton(@_vcc_as_array(*((A->array)), *((A->capacity)))))); 
    owns#16 := $set_union(owns#16, $set_singleton($as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#16, $ptrset_to_int(owns#16), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assume $typed($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assume ==(owns#16, @_vcc_owns(@state, A)); 
    assume owns#16 == $owns($s, $phys_ptr_cast(P#A, ^ArrayList));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(A), prestate#17)
    call $static_unwrap($phys_ptr_cast(P#A, ^ArrayList), prestate#17);
    assume $good_state_ext(#tok$1^84.32, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#18; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#18, $state_to_int(prestate#18), ^$#state_t);
    // prestate#18 := @_vcc_current_state(@state); 
    prestate#18 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#18, $state_to_int(prestate#18), ^$#state_t);
    // assert @_vcc_wrapped(@state, @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $wrapped($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))), $array(^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assume @_vcc_inv(@state, @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assume $inv($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))), $array(^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $top_writable($s, #wrTime$1^77.1, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assert @reads_check_normal((A->array)); 
    assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
    // assert @reads_check_normal((A->capacity)); 
    assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
    // stmt @_vcc_unwrap(@_vcc_as_array(*((A->array)), *((A->capacity))), @_vcc_typeof(@_vcc_as_array(*((A->array)), *((A->capacity))))); 
    call $unwrap($as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))), $array(^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    assume $good_state_ext(#tok$1^84.35, $s);
    // assert @_vcc_inv2(prestate#18, @_vcc_current_state(@state), @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $inv2(prestate#18, $current_state($s), $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))), $array(^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check(*((A->array))[i]); 
    assert $writable_prim($s, #wrTime$1^77.1, $idx($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), P#i));
    // assert @reads_check_normal((A->array)); 
    assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
    // **((A->array))[i] := v; 
    call $write_int($field($idx($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), P#i)), $emb0($idx($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), P#i)), P#v);
    assume $full_stop_ext(#tok$1^85.9, $s);
    // _math state_t prestate#19; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#19, $state_to_int(prestate#19), ^$#state_t);
    // prestate#19 := @_vcc_current_state(@state); 
    prestate#19 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#19, $state_to_int(prestate#19), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $top_writable($s, #wrTime$1^77.1, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assert @writes_check(@_vcc_owns(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert (forall #writes$1^84.35: $ptr :: { $dont_instantiate(#writes$1^84.35) } $set_in(#writes$1^84.35, $owns($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))))) ==> $top_writable($s, #wrTime$1^77.1, #writes$1^84.35));
    // assert @reads_check_normal((A->array)); 
    assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
    // assert @reads_check_normal((A->capacity)); 
    assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
    // stmt @_vcc_wrap(@_vcc_as_array(*((A->array)), *((A->capacity))), @_vcc_typeof(@_vcc_as_array(*((A->array)), *((A->capacity))))); 
    call $wrap($as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))), $array(^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    assume $good_state_ext(#tok$1^84.35, $s);
    // assert @_vcc_inv2(prestate#19, @_vcc_current_state(@state), @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $inv2(prestate#19, $current_state($s), $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))), $array(^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
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
    assert $top_writable($s, #wrTime$1^77.1, $phys_ptr_cast(P#A, ^ArrayList));
    // assert @_vcc_wrapped(@state, @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $wrapped($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))), $array(^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assert @writes_check(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $top_writable($s, #wrTime$1^77.1, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // owns#21 := pure(@_vcc_set_union(owns#21, @_vcc_set_singleton(@_vcc_as_array(*((A->array)), *((A->capacity)))))); 
    owns#21 := $set_union(owns#21, $set_singleton($as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#21, $ptrset_to_int(owns#21), ^$#ptrset);
    // staticWrapState#20 := pure(@_vcc_take_over(staticWrapState#20, A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    staticWrapState#20 := $take_over(staticWrapState#20, $phys_ptr_cast(P#A, ^ArrayList), $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#20, $state_to_int(staticWrapState#20), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(A), staticWrapState#20, owns#21)
    call $static_wrap($phys_ptr_cast(P#A, ^ArrayList), staticWrapState#20, owns#21);
    assume $good_state_ext(#tok$1^84.32, $s);
    // assert @inv_check(@_vcc_is_malloc_root(@state, A)); 
    assert $is_malloc_root($s, $phys_ptr_cast(P#A, ^ArrayList));
    // assert @inv_check(<=(*((A->length)), *((A->capacity)))); 
    assert $rd_inv($s, ArrayList.length, $phys_ptr_cast(P#A, ^ArrayList)) <= $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList));
    // assert @inv_check(@keeps_stable(old(prestate#22, @_vcc_as_array(*((A->array)), *((A->capacity)))), @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $as_array($rd_phys_ptr(prestate#22, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv(prestate#22, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))) == $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList)));
    // assert @inv_check(@keeps(A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $keeps($s, $phys_ptr_cast(P#A, ^ArrayList), $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assert @inv_check(@_vcc_is_malloc_root(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $is_malloc_root($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure DisposeArrayList(P#A: $ptr);
  requires $wrapped($s, $phys_ptr_cast(P#A, ^ArrayList), ^ArrayList);
  modifies $s, $cev_pc;
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#A, ^ArrayList)));
  free ensures $call_transition(old($s), $s);



implementation DisposeArrayList(P#A: $ptr)
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
    assume $local_value_is($s, #tok$1^88.1, #loc.A, $ptr_to_int(P#A), $ptr_to(^ArrayList));
    assume #wrTime$1^88.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^88.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#A, ^ArrayList)));
    assume $thread_owned($s, $phys_ptr_cast(P#A, ^ArrayList));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, A, A); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#A, ^ArrayList), $phys_ptr_cast(P#A, ^ArrayList), l#public);
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
    assert $wrapped($s, $phys_ptr_cast(P#A, ^ArrayList), ^ArrayList);
    // assert @writes_check(A); 
    assert $top_writable($s, #wrTime$1^88.1, $phys_ptr_cast(P#A, ^ArrayList));
    // assume @_vcc_inv(@state, A); 
    assume $inv($s, $phys_ptr_cast(P#A, ^ArrayList), ^ArrayList);
    // prestate#25 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#25, A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    prestate#25 := $release($current_state($s), prestate#25, $phys_ptr_cast(P#A, ^ArrayList), $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#25, $state_to_int(prestate#25), ^$#state_t);
    // owns#24 := pure(@_vcc_set_union(owns#24, @_vcc_set_singleton(@_vcc_as_array(*((A->array)), *((A->capacity)))))); 
    owns#24 := $set_union(owns#24, $set_singleton($as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#24, $ptrset_to_int(owns#24), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assume $typed($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assume ==(owns#24, @_vcc_owns(@state, A)); 
    assume owns#24 == $owns($s, $phys_ptr_cast(P#A, ^ArrayList));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(A), prestate#25)
    call $static_unwrap($phys_ptr_cast(P#A, ^ArrayList), prestate#25);
    assume $good_state_ext(#tok$1^92.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#26; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#26, $state_to_int(prestate#26), ^$#state_t);
    // prestate#26 := @_vcc_current_state(@state); 
    prestate#26 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#26, $state_to_int(prestate#26), ^$#state_t);
    // assert @_vcc_wrapped(@state, @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $wrapped($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))), $array(^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assume @_vcc_inv(@state, @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assume $inv($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))), $array(^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $top_writable($s, #wrTime$1^88.1, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assert @reads_check_normal((A->array)); 
    assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
    // assert @reads_check_normal((A->capacity)); 
    assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
    // stmt @_vcc_unwrap(@_vcc_as_array(*((A->array)), *((A->capacity))), @_vcc_typeof(@_vcc_as_array(*((A->array)), *((A->capacity))))); 
    call $unwrap($as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))), $array(^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    assume $good_state_ext(#tok$1^93.21, $s);
    // assert @_vcc_inv2(prestate#26, @_vcc_current_state(@state), @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $inv2(prestate#26, $current_state($s), $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))), $array(^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @writes_check(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $top_writable($s, #wrTime$1^88.1, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assert @writes_check(@_vcc_extent(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert (forall #writes$1^94.5: $ptr :: { $dont_instantiate(#writes$1^94.5) } $set_in(#writes$1^94.5, $extent($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))))) ==> $top_writable($s, #wrTime$1^88.1, #writes$1^94.5));
    // assert @reads_check_normal((A->array)); 
    assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
    // assert @reads_check_normal((A->capacity)); 
    assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
    // stmt _vcc_free(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
    call $free($as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    assume $full_stop_ext(#tok$1^94.5, $s);
    // assert @writes_check(A); 
    assert $top_writable($s, #wrTime$1^88.1, $phys_ptr_cast(P#A, ^ArrayList));
    // assert @writes_check(@_vcc_extent(@state, A)); 
    assert (forall #writes$1^95.5: $ptr :: { $dont_instantiate(#writes$1^95.5) } $set_in(#writes$1^95.5, $extent($s, $phys_ptr_cast(P#A, ^ArrayList))) ==> $top_writable($s, #wrTime$1^88.1, #writes$1^95.5));
    // stmt _vcc_free(A); 
    call $free($phys_ptr_cast(P#A, ^ArrayList));
    assume $full_stop_ext(#tok$1^95.5, $s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure Add(P#A: $ptr, P#v: int);
  requires F#Length($s, $phys_ptr_cast(P#A, ^ArrayList)) < 100000;
  requires $wrapped($s, $phys_ptr_cast(P#A, ^ArrayList), ^ArrayList);
  modifies $s, $cev_pc;
  ensures F#Length($s, $phys_ptr_cast(P#A, ^ArrayList)) == F#Length(old($s), $phys_ptr_cast(P#A, ^ArrayList)) + 1;
  ensures (forall Q#j$1^103.29#tc1: int :: {:weight 10} { F#Select($s, $phys_ptr_cast(P#A, ^ArrayList), Q#j$1^103.29#tc1) } $in_range_u4(Q#j$1^103.29#tc1) ==> Q#j$1^103.29#tc1 < F#Length(old($s), $phys_ptr_cast(P#A, ^ArrayList)) ==> F#Select($s, $phys_ptr_cast(P#A, ^ArrayList), Q#j$1^103.29#tc1) == F#Select(old($s), $phys_ptr_cast(P#A, ^ArrayList), Q#j$1^103.29#tc1));
  ensures F#Select($s, $phys_ptr_cast(P#A, ^ArrayList), F#Length($s, $phys_ptr_cast(P#A, ^ArrayList)) - 1) == P#v;
  ensures $wrapped($s, $phys_ptr_cast(P#A, ^ArrayList), ^ArrayList);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#A, ^ArrayList)));
  free ensures $call_transition(old($s), $s);



implementation Add(P#A: $ptr, P#v: int)
{
  var owns#33: $ptrset;
  var staticWrapState#32: $state;
  var prestate#34: $state;
  var prestate#31: $state;
  var #wrTime$1^121.40: int;
  var loopState#0: $state;
  var res__vcc_alloc#4: $ptr;
  var L#i: int where $in_range_u4(L#i);
  var L#tmp: $ptr;
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
    assume $local_value_is($s, #tok$1^98.1, #loc.A, $ptr_to_int(P#A), $ptr_to(^ArrayList));
    assume $local_value_is($s, #tok$1^98.1, #loc.v, P#v, ^^i4);
    assume #wrTime$1^98.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^98.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#A, ^ArrayList)));
    assume $thread_owned($s, $phys_ptr_cast(P#A, ^ArrayList));
    // assume true; 
    assume true;
    // assume @in_range_i4(v); 
    assume $in_range_i4(P#v);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, A, A); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#A, ^ArrayList), $phys_ptr_cast(P#A, ^ArrayList), l#public);
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
    assert $wrapped($s, $phys_ptr_cast(P#A, ^ArrayList), ^ArrayList);
    // assert @writes_check(A); 
    assert $top_writable($s, #wrTime$1^98.1, $phys_ptr_cast(P#A, ^ArrayList));
    // assume @_vcc_inv(@state, A); 
    assume $inv($s, $phys_ptr_cast(P#A, ^ArrayList), ^ArrayList);
    // prestate#29 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#29, A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    prestate#29 := $release($current_state($s), prestate#29, $phys_ptr_cast(P#A, ^ArrayList), $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#29, $state_to_int(prestate#29), ^$#state_t);
    // owns#28 := pure(@_vcc_set_union(owns#28, @_vcc_set_singleton(@_vcc_as_array(*((A->array)), *((A->capacity)))))); 
    owns#28 := $set_union(owns#28, $set_singleton($as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#28, $ptrset_to_int(owns#28), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assume $typed($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assume ==(owns#28, @_vcc_owns(@state, A)); 
    assume owns#28 == $owns($s, $phys_ptr_cast(P#A, ^ArrayList));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(A), prestate#29)
    call $static_unwrap($phys_ptr_cast(P#A, ^ArrayList), prestate#29);
    assume $good_state_ext(#tok$1^107.32, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#30; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#30, $state_to_int(prestate#30), ^$#state_t);
    // prestate#30 := @_vcc_current_state(@state); 
    prestate#30 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#30, $state_to_int(prestate#30), ^$#state_t);
    // assert @_vcc_wrapped(@state, @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $wrapped($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))), $array(^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assume @_vcc_inv(@state, @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assume $inv($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))), $array(^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $top_writable($s, #wrTime$1^98.1, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assert @reads_check_normal((A->array)); 
    assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
    // assert @reads_check_normal((A->capacity)); 
    assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
    // stmt @_vcc_unwrap(@_vcc_as_array(*((A->array)), *((A->capacity))), @_vcc_typeof(@_vcc_as_array(*((A->array)), *((A->capacity))))); 
    call $unwrap($as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))), $array(^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    assume $good_state_ext(#tok$1^107.35, $s);
    // assert @_vcc_inv2(prestate#30, @_vcc_current_state(@state), @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $inv2(prestate#30, $current_state($s), $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))), $array(^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @reads_check_normal((A->capacity)); 
    assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
    // assert @reads_check_normal((A->length)); 
    assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
    assume true;
    // if (==(*((A->capacity)), *((A->length)))) ...
    if ($rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList)) == $rd_inv($s, ArrayList.length, $phys_ptr_cast(P#A, ^ArrayList)))
    {
      anon19:
        // uint32_t newCapacity; 
        assume $local_value_is($s, #tok$1^111.13, #loc.newCapacity, L#newCapacity, ^^u4);
        // int32_t* tmp; 
        assume $local_value_is($s, #tok$1^110.13, #loc.tmp, $ptr_to_int(L#tmp), $ptr_to(^^i4));
        // uint32_t i; 
        assume $local_value_is($s, #tok$1^109.13, #loc.i, L#i, ^^u4);
        // var uint32_t i
        // var int32_t* tmp
        // var uint32_t newCapacity
        // assert @in_range_u4(+(*(*((A->capacity)), 2), 1)); 
        assert $in_range_u4($op_mul($rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList)), 2) + 1);
        // assert @in_range_u4(*(*((A->capacity)), 2)); 
        assert $in_range_u4($op_mul($rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList)), 2));
        // assert @reads_check_normal((A->capacity)); 
        assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
        // newCapacity := +(*(*((A->capacity)), 2), 1); 
        L#newCapacity := $op_mul($rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList)), 2) + 1;
        assume $local_value_is($s, #tok$1^113.13, #loc.newCapacity, L#newCapacity, ^^u4);
        // obj_t res__vcc_alloc#4; 
        assume $local_value_is($s, #tok$1^115.19, #loc.res__vcc_alloc#4, $ptr_to_int(res__vcc_alloc#4), ^^object);
        // res__vcc_alloc#4 := _vcc_alloc(@_vcc_array(@_vcc_typeof((int32_t*)@null), newCapacity)); 
        call res__vcc_alloc#4 := $alloc($array(^^i4, L#newCapacity));
        assume $full_stop_ext(#tok$1^115.19, $s);
        assume $local_value_is($s, #tok$1^115.19, #loc.res__vcc_alloc#4, $ptr_to_int(res__vcc_alloc#4), ^^object);
        // tmp := (int32_t*)res__vcc_alloc#4; 
        L#tmp := $phys_ptr_cast(res__vcc_alloc#4, ^^i4);
        assume $local_value_is($s, #tok$1^115.13, #loc.tmp, $ptr_to_int(L#tmp), $ptr_to(^^i4));
        // assume @_vcc_ptr_neq_null(tmp); 
        assume $non_null($phys_ptr_cast(L#tmp, ^^i4));
        // i := 0; 
        L#i := 0;
        assume $local_value_is($s, #tok$1^118.13, #loc.i, L#i, ^^u4);
        call $bump_timestamp();
        assume $full_stop_ext(#tok$1^121.40, $s);
        loopState#0 := $s;
        assume #wrTime$1^121.40 == $current_timestamp($s);
        assume $def_writes($s, #wrTime$1^121.40, (lambda #p: $ptr :: $set_in(#p, $array_range($s, $phys_ptr_cast(L#tmp, ^^i4), ^^i4, $rd_inv($s, ArrayList.length, $phys_ptr_cast(P#A, ^ArrayList))))));
        assert (forall #loopWrites^$1^121.40: $ptr :: { $dont_instantiate(#loopWrites^$1^121.40) } $listed_in_writes($s, #wrTime$1^121.40, #loopWrites^$1^121.40) ==> $top_writable($s, #wrTime$1^98.1, #loopWrites^$1^121.40));
        while (true)
          invariant (forall Q#j$1^120.43#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(L#tmp, ^^i4), Q#j$1^120.43#tc1) } { $idx($rd_phys_ptr(loopState#0, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), Q#j$1^120.43#tc1) } $in_range_u4(Q#j$1^120.43#tc1) ==> Q#j$1^120.43#tc1 < L#i ==> $rd_inv($s, $field($idx($phys_ptr_cast(L#tmp, ^^i4), Q#j$1^120.43#tc1)), $emb0($idx($phys_ptr_cast(L#tmp, ^^i4), Q#j$1^120.43#tc1))) == $rd_inv(loopState#0, $field($idx($rd_phys_ptr(loopState#0, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), Q#j$1^120.43#tc1)), $emb0($idx($rd_phys_ptr(loopState#0, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), Q#j$1^120.43#tc1))));
        {
          anon18:
            assume $modifies(loopState#0, $s, (lambda #p: $ptr :: $set_in(#p, $array_range(loopState#0, $phys_ptr_cast(L#tmp, ^^i4), ^^i4, $rd_inv(loopState#0, ArrayList.length, $phys_ptr_cast(P#A, ^ArrayList))))));
            assume $timestamp_post(loopState#0, $s);
            assume $full_stop_ext(#tok$1^119.13, $s);
            assume $local_value_is($s, #tok$1^119.13, #loc.res__vcc_alloc#4, $ptr_to_int(res__vcc_alloc#4), ^^object);
            assume $local_value_is($s, #tok$1^119.13, #loc.tmp, $ptr_to_int(L#tmp), $ptr_to(^^i4));
            assume $local_value_is($s, #tok$1^119.13, #loc.newCapacity, L#newCapacity, ^^u4);
            assume $local_value_is($s, #tok$1^119.13, #loc.prestate#30, $state_to_int(prestate#30), ^$#state_t);
            assume $local_value_is($s, #tok$1^119.13, #loc.prestate#29, $state_to_int(prestate#29), ^$#state_t);
            assume $local_value_is($s, #tok$1^119.13, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
            assume $local_value_is($s, #tok$1^119.13, #loc.owns#28, $ptrset_to_int(owns#28), ^$#ptrset);
            // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
            assume $meta_eq(loopState#0, $s);
            // assert @reads_check_normal((A->length)); 
            assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
            assume true;
            // if (<(i, *((A->length)))) ...
            if (L#i < $rd_inv($s, ArrayList.length, $phys_ptr_cast(P#A, ^ArrayList)))
            {
              anon16:
                // assert @prim_writes_check(tmp[i]); 
                assert $writable_prim($s, #wrTime$1^121.40, $idx($phys_ptr_cast(L#tmp, ^^i4), L#i));
                // assert @reads_check_normal(*((A->array))[i]); 
                assert $thread_local($s, $idx($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), L#i));
                // assert @reads_check_normal((A->array)); 
                assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
                // *tmp[i] := *(*((A->array))[i]); 
                call $write_int($field($idx($phys_ptr_cast(L#tmp, ^^i4), L#i)), $emb0($idx($phys_ptr_cast(L#tmp, ^^i4), L#i)), $rd_inv($s, $field($idx($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), L#i)), $emb0($idx($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), L#i))));
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
        assert $top_writable($s, #wrTime$1^98.1, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
        // assert @writes_check(@_vcc_extent(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
        assert (forall #writes$1^126.13: $ptr :: { $dont_instantiate(#writes$1^126.13) } $set_in(#writes$1^126.13, $extent($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))))) ==> $top_writable($s, #wrTime$1^98.1, #writes$1^126.13));
        // assert @reads_check_normal((A->array)); 
        assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
        // assert @reads_check_normal((A->capacity)); 
        assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
        // stmt _vcc_free(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
        call $free($as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
        assume $full_stop_ext(#tok$1^126.13, $s);
        // assert @prim_writes_check((A->capacity)); 
        assert $writable_prim($s, #wrTime$1^98.1, $dot($phys_ptr_cast(P#A, ^ArrayList), ArrayList.capacity));
        // *(A->capacity) := newCapacity; 
        call $write_int(ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList), L#newCapacity);
        assume $full_stop_ext(#tok$1^127.13, $s);
        // assert @prim_writes_check((A->array)); 
        assert $writable_prim($s, #wrTime$1^98.1, $dot($phys_ptr_cast(P#A, ^ArrayList), ArrayList.array));
        // *(A->array) := tmp; 
        call $write_int(ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), $ptr_to_int($phys_ptr_cast(L#tmp, ^^i4)));
        assume $full_stop_ext(#tok$1^128.13, $s);
    }
    else
    {
      anon21:
        // empty
    }

  anon23:
    // assert @prim_writes_check(*((A->array))[*((A->length))]); 
    assert $writable_prim($s, #wrTime$1^98.1, $idx($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), $rd_inv($s, ArrayList.length, $phys_ptr_cast(P#A, ^ArrayList))));
    // assert @reads_check_normal((A->array)); 
    assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
    // assert @reads_check_normal((A->length)); 
    assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
    // **((A->array))[*((A->length))] := v; 
    call $write_int($field($idx($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), $rd_inv($s, ArrayList.length, $phys_ptr_cast(P#A, ^ArrayList)))), $emb0($idx($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), $rd_inv($s, ArrayList.length, $phys_ptr_cast(P#A, ^ArrayList)))), P#v);
    assume $full_stop_ext(#tok$1^130.9, $s);
    // assert @prim_writes_check((A->length)); 
    assert $writable_prim($s, #wrTime$1^98.1, $dot($phys_ptr_cast(P#A, ^ArrayList), ArrayList.length));
    // assert @in_range_u4(+(*((A->length)), 1)); 
    assert $in_range_u4($rd_inv($s, ArrayList.length, $phys_ptr_cast(P#A, ^ArrayList)) + 1);
    // assert @reads_check_normal((A->length)); 
    assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
    // *(A->length) := +(*((A->length)), 1); 
    call $write_int(ArrayList.length, $phys_ptr_cast(P#A, ^ArrayList), $rd_inv($s, ArrayList.length, $phys_ptr_cast(P#A, ^ArrayList)) + 1);
    assume $full_stop_ext(#tok$1^131.9, $s);
    // _math state_t prestate#31; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#31, $state_to_int(prestate#31), ^$#state_t);
    // prestate#31 := @_vcc_current_state(@state); 
    prestate#31 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#31, $state_to_int(prestate#31), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $top_writable($s, #wrTime$1^98.1, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assert @writes_check(@_vcc_owns(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert (forall #writes$1^107.35: $ptr :: { $dont_instantiate(#writes$1^107.35) } $set_in(#writes$1^107.35, $owns($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))))) ==> $top_writable($s, #wrTime$1^98.1, #writes$1^107.35));
    // assert @reads_check_normal((A->array)); 
    assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
    // assert @reads_check_normal((A->capacity)); 
    assert $thread_local($s, $phys_ptr_cast(P#A, ^ArrayList));
    // stmt @_vcc_wrap(@_vcc_as_array(*((A->array)), *((A->capacity))), @_vcc_typeof(@_vcc_as_array(*((A->array)), *((A->capacity))))); 
    call $wrap($as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))), $array(^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    assume $good_state_ext(#tok$1^107.35, $s);
    // assert @_vcc_inv2(prestate#31, @_vcc_current_state(@state), @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $inv2(prestate#31, $current_state($s), $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))), $array(^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
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
    assert $top_writable($s, #wrTime$1^98.1, $phys_ptr_cast(P#A, ^ArrayList));
    // assert @_vcc_wrapped(@state, @_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $wrapped($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))), $array(^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assert @writes_check(@_vcc_as_array(*((A->array)), *((A->capacity)))); 
    assert $top_writable($s, #wrTime$1^98.1, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // owns#33 := pure(@_vcc_set_union(owns#33, @_vcc_set_singleton(@_vcc_as_array(*((A->array)), *((A->capacity)))))); 
    owns#33 := $set_union(owns#33, $set_singleton($as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#33, $ptrset_to_int(owns#33), ^$#ptrset);
    // staticWrapState#32 := pure(@_vcc_take_over(staticWrapState#32, A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    staticWrapState#32 := $take_over(staticWrapState#32, $phys_ptr_cast(P#A, ^ArrayList), $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#32, $state_to_int(staticWrapState#32), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(A), staticWrapState#32, owns#33)
    call $static_wrap($phys_ptr_cast(P#A, ^ArrayList), staticWrapState#32, owns#33);
    assume $good_state_ext(#tok$1^107.32, $s);
    // assert @inv_check(@_vcc_is_malloc_root(@state, A)); 
    assert $is_malloc_root($s, $phys_ptr_cast(P#A, ^ArrayList));
    // assert @inv_check(<=(*((A->length)), *((A->capacity)))); 
    assert $rd_inv($s, ArrayList.length, $phys_ptr_cast(P#A, ^ArrayList)) <= $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList));
    // assert @inv_check(@keeps_stable(old(prestate#34, @_vcc_as_array(*((A->array)), *((A->capacity)))), @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $as_array($rd_phys_ptr(prestate#34, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv(prestate#34, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))) == $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList)));
    // assert @inv_check(@keeps(A, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $keeps($s, $phys_ptr_cast(P#A, ^ArrayList), $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
    // assert @inv_check(@_vcc_is_malloc_root(@state, @_vcc_as_array(*((A->array)), *((A->capacity))))); 
    assert $is_malloc_root($s, $as_array($rd_phys_ptr($s, ArrayList.array, $phys_ptr_cast(P#A, ^ArrayList), ^^i4), ^^i4, $rd_inv($s, ArrayList.capacity, $phys_ptr_cast(P#A, ^ArrayList))));
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
  var #wrTime$1^142.32: int;
  var loopState#1: $state;
  var L#N: int where $in_range_u4(L#N);
  var L#A: $ptr;
  var L#i: int where $in_range_u4(L#i);
  var #wrTime$1^135.1: int;
  var #stackframe: int;

  anon27:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^135.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^135.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^135.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // uint32_t i; 
    assume $local_value_is($s, #tok$1^139.5, #loc.i, L#i, ^^u4);
    // struct ArrayList* A; 
    assume $local_value_is($s, #tok$1^138.12, #loc.A, $ptr_to_int(L#A), $ptr_to(^ArrayList));
    // uint32_t N; 
    assume $local_value_is($s, #tok$1^137.5, #loc.N, L#N, ^^u4);
    // N := 42; 
    L#N := 42;
    assume $local_value_is($s, #tok$1^137.5, #loc.N, L#N, ^^u4);
    // non-pure function
    // A := CreateArrayList(N); 
    call L#A := CreateArrayList(L#N);
    assume $full_stop_ext(#tok$1^138.27, $s);
    assume $local_value_is($s, #tok$1^138.27, #loc.A, $ptr_to_int(L#A), $ptr_to(^ArrayList));
    // i := 0; 
    L#i := 0;
    assume $local_value_is($s, #tok$1^139.5, #loc.i, L#i, ^^u4);
    call $bump_timestamp();
    assume $full_stop_ext(#tok$1^142.32, $s);
    loopState#1 := $s;
    assume #wrTime$1^142.32 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^142.32, (lambda #p: $ptr :: #p == $phys_ptr_cast(L#A, ^ArrayList)));
    assert (forall #loopWrites^$1^142.32: $ptr :: { $dont_instantiate(#loopWrites^$1^142.32) } $listed_in_writes($s, #wrTime$1^142.32, #loopWrites^$1^142.32) ==> $top_writable($s, #wrTime$1^135.1, #loopWrites^$1^142.32));
    while (true)
      invariant $wrapped($s, $phys_ptr_cast(L#A, ^ArrayList), ^ArrayList);
      invariant F#Length($s, $phys_ptr_cast(L#A, ^ArrayList)) == L#i;
      invariant (forall Q#j$1^145.35#tc1: int :: {:weight 10} { F#Select($s, $phys_ptr_cast(L#A, ^ArrayList), Q#j$1^145.35#tc1) } $in_range_u4(Q#j$1^145.35#tc1) ==> Q#j$1^145.35#tc1 < L#i ==> F#Select($s, $phys_ptr_cast(L#A, ^ArrayList), Q#j$1^145.35#tc1) == Q#j$1^145.35#tc1);
    {
      anon26:
        assume $modifies(loopState#1, $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(L#A, ^ArrayList)));
        assume $timestamp_post(loopState#1, $s);
        assume $full_stop_ext(#tok$1^141.5, $s);
        assume $local_value_is($s, #tok$1^141.5, #loc.N, L#N, ^^u4);
        assume true;
        // if (<(i, N)) ...
        if (L#i < L#N)
        {
          anon24:
            // assert @writes_check(A); 
            assert $top_writable($s, #wrTime$1^142.32, $phys_ptr_cast(L#A, ^ArrayList));
            // assert @in_range_i4((int32_t)i); 
            assert $in_range_i4(L#i);
            // stmt Add(A, (int32_t)i); 
            call Add($phys_ptr_cast(L#A, ^ArrayList), L#i);
            assume $full_stop_ext(#tok$1^147.9, $s);
            // assert @in_range_u4(+(i, 1)); 
            assert $in_range_u4(L#i + 1);
            // i := +(i, 1); 
            L#i := L#i + 1;
            assume $local_value_is($s, #tok$1^148.9, #loc.i, L#i, ^^u4);
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
    assert $top_writable($s, #wrTime$1^135.1, $phys_ptr_cast(L#A, ^ArrayList));
    // stmt DisposeArrayList(A); 
    call DisposeArrayList($phys_ptr_cast(L#A, ^ArrayList));
    assume $full_stop_ext(#tok$1^150.5, $s);
    // return 0; 
    $result := 0;
    assert $position_marker();
    goto #exit;

  anon29:
    // empty

  #exit:
}



const unique l#public: $label;

const unique #tok$1^150.5: $token;

const unique #tok$1^148.9: $token;

const unique #tok$1^147.9: $token;

const unique #tok$1^141.5: $token;

const unique #tok$1^142.32: $token;

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

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CArrayList.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CArrayList.c);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^^i4);
