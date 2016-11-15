axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

const unique ^Stack: $ctype;

axiom $is_span_sequential(^Stack);

axiom $def_struct_type(^Stack, 404, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Stack) } $inv2(#s1, #s2, #p, ^Stack) == ($set_eq($owns(#s2, #p), $set_empty()) && $is_malloc_root(#s2, #p) && $rd_inv(#s2, Stack.topOfStack, #p) <= 100));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^Stack)) } $in(q, $composite_extent(s, p, ^Stack)) == (q == p));

const unique Stack.topOfStack: $field;

axiom $def_phys_field(^Stack, Stack.topOfStack, ^^u4, false, 0);

const unique Stack.array: $field;

axiom $def_phys_arr_field(^Stack, Stack.array, ^^i4, false, 4, 100);

procedure Stack#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $set_eq($owns($s, $phys_ptr_cast(P#_this_, ^Stack)), $set_empty());
  ensures $is_admissibility_check() ==> $is_malloc_root($s, $phys_ptr_cast(P#_this_, ^Stack));
  ensures $is_admissibility_check() ==> $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#_this_, ^Stack)) <= 100;
  ensures $is_unwrap_check() ==> $set_eq($owns($s, $phys_ptr_cast(P#_this_, ^Stack)), $set_empty());
  ensures $is_unwrap_check() ==> $is_malloc_root($s, $phys_ptr_cast(P#_this_, ^Stack));
  ensures $is_unwrap_check() ==> $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#_this_, ^Stack)) <= 100;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Stack#adm(P#_this_: $ptr)
{
  var #wrTime$1^7.1: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^7.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^7.1, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^Stack));
    assume #wrTime$1^7.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^7.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($phys_ptr_cast(P#_this_, ^Stack), ^Stack);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $phys_ptr_cast(P#_this_, ^Stack));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($phys_ptr_cast(P#_this_, ^Stack));
        assume $good_state_ext(#tok$1^7.1, $s);
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
            assume $admissibility_pre($s, $phys_ptr_cast(P#_this_, ^Stack));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $phys_ptr_cast(P#_this_, ^Stack));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Stack*)@null))
        call $havoc_others($phys_ptr_cast(P#_this_, ^Stack), ^Stack);
        assume $good_state_ext(#tok$1^7.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $phys_ptr_cast(P#_this_, ^Stack), ^Stack);
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

function F#IsEmpty(#s: $state, P#S: $ptr) : bool;

const unique cf#IsEmpty: $pure_function;

axiom (forall #s: $state, P#S: $ptr :: { F#IsEmpty(#s, P#S) } $wrapped(#s, $phys_ptr_cast(P#S, ^Stack), ^Stack) ==> F#IsEmpty(#s, P#S) == ($rd_inv(#s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) == 0));

function F#IsEmpty#frame($ptr, $version) : bool;

axiom (forall #s: $state, P#S: $ptr :: { F#IsEmpty(#s, P#S) } $full_stop(#s) && $can_use_frame_axiom_of(cf#IsEmpty) && $closed(#s, $phys_ptr_cast(P#S, ^Stack)) ==> F#IsEmpty(#s, P#S) == F#IsEmpty#frame(P#S, $read_version(#s, $phys_ptr_cast(P#S, ^Stack))));

axiom $function_arg_type(cf#IsEmpty, 0, ^^bool);

axiom $function_arg_type(cf#IsEmpty, 1, $ptr_to(^Stack));

procedure IsEmpty(P#S: $ptr) returns ($result: bool);
  requires $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
  ensures $result == ($rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) == 0);
  free ensures $result == F#IsEmpty($s, P#S);
  free ensures $call_transition(old($s), $s);



implementation IsEmpty(P#S: $ptr) returns ($result: bool)
{
  var #wrTime$1^13.17: int;
  var #stackframe: int;

  anon7:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^13.17, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^13.17, #loc.S, $ptr_to_int(P#S), $ptr_to(^Stack));
    assume #wrTime$1^13.17 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^13.17, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#S, ^Stack), $phys_ptr_cast(P#S, ^Stack), l#public);
    // assert @reads_check_normal((S->topOfStack)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // return ==(*((S->topOfStack)), 0); 
    $result := $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) == 0;
    assert $position_marker();
    goto #exit;

  anon8:
    // empty

  #exit:
}



function F#IsFull(#s: $state, P#S: $ptr) : bool;

const unique cf#IsFull: $pure_function;

axiom (forall #s: $state, P#S: $ptr :: { F#IsFull(#s, P#S) } $wrapped(#s, $phys_ptr_cast(P#S, ^Stack), ^Stack) ==> F#IsFull(#s, P#S) == ($rd_inv(#s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) == 100));

axiom $function_arg_type(cf#IsFull, 0, ^^bool);

axiom $function_arg_type(cf#IsFull, 1, $ptr_to(^Stack));

procedure IsFull(P#S: $ptr) returns ($result: bool);
  requires $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
  ensures $result == ($rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) == 100);
  free ensures $result == F#IsFull($s, P#S);
  free ensures $call_transition(old($s), $s);



implementation IsFull(P#S: $ptr) returns ($result: bool)
{
  var #wrTime$1^22.17: int;
  var #stackframe: int;

  anon9:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^22.17, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^22.17, #loc.S, $ptr_to_int(P#S), $ptr_to(^Stack));
    assume #wrTime$1^22.17 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^22.17, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#S, ^Stack), $phys_ptr_cast(P#S, ^Stack), l#public);
    // assert @reads_check_normal((S->topOfStack)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // return ==(*((S->topOfStack)), 100); 
    $result := $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) == 100;
    assert $position_marker();
    goto #exit;

  anon10:
    // empty

  #exit:
}



function F#Length(#s: $state, P#S: $ptr) : int;

const unique cf#Length: $pure_function;

axiom (forall #s: $state, P#S: $ptr :: { F#Length(#s, P#S) } $wrapped(#s, $phys_ptr_cast(P#S, ^Stack), ^Stack) ==> $in_range_u4(F#Length(#s, P#S)) && F#Length(#s, P#S) == $rd_inv(#s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)));

axiom $function_arg_type(cf#Length, 0, ^^u4);

axiom $function_arg_type(cf#Length, 1, $ptr_to(^Stack));

procedure Length(P#S: $ptr) returns ($result: int);
  requires $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
  free ensures $in_range_u4($result);
  ensures $result == $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack));
  free ensures $result == F#Length($s, P#S);
  free ensures $call_transition(old($s), $s);



implementation Length(P#S: $ptr) returns ($result: int)
{
  var #wrTime$1^31.17: int;
  var #stackframe: int;

  anon11:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^31.17, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^31.17, #loc.S, $ptr_to_int(P#S), $ptr_to(^Stack));
    assume #wrTime$1^31.17 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^31.17, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#S, ^Stack), $phys_ptr_cast(P#S, ^Stack), l#public);
    // assert @reads_check_normal((S->topOfStack)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // return *((S->topOfStack)); 
    $result := $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack));
    assert $position_marker();
    goto #exit;

  anon12:
    // empty

  #exit:
}



procedure CreateStack() returns ($result: $ptr);
  modifies $s, $cev_pc;
  free ensures true;
  ensures $is_null($phys_ptr_cast($result, ^Stack)) || ($wrapped($s, $phys_ptr_cast($result, ^Stack), ^Stack) && $is_fresh(old($s), $s, $phys_ptr_cast($result, ^Stack)) && F#IsEmpty($s, $phys_ptr_cast($result, ^Stack)));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation CreateStack() returns ($result: $ptr)
{
  var owns#4: $ptrset;
  var staticWrapState#3: $state;
  var prestate#5: $state;
  var L#S: $ptr;
  var #wrTime$1^40.8: int;
  var #stackframe: int;

  anon15:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^40.8, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^40.8 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^40.8, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // struct Stack* S; 
    assume $local_value_is($s, #tok$1^44.12, #loc.S, $ptr_to_int(L#S), $ptr_to(^Stack));
    // var struct Stack* S
    // S := _vcc_alloc(@_vcc_typeof((struct Stack*)@null)); 
    call L#S := $alloc(^Stack);
    assume $full_stop_ext(#tok$1^46.9, $s);
    assume $local_value_is($s, #tok$1^46.9, #loc.S, $ptr_to_int(L#S), $ptr_to(^Stack));
    assume true;
    // if (@_vcc_ptr_neq_null(S)) ...
    if ($non_null($phys_ptr_cast(L#S, ^Stack)))
    {
      anon13:
        // assert @prim_writes_check((S->topOfStack)); 
        assert $writable_prim($s, #wrTime$1^40.8, $dot($phys_ptr_cast(L#S, ^Stack), Stack.topOfStack));
        // *(S->topOfStack) := 0; 
        call $write_int(Stack.topOfStack, $phys_ptr_cast(L#S, ^Stack), 0);
        assume $full_stop_ext(#tok$1^48.9, $s);
        // _math state_t prestate#5; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#5, $state_to_int(prestate#5), ^$#state_t);
        // prestate#5 := @_vcc_current_state(@state); 
        prestate#5 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#5, $state_to_int(prestate#5), ^$#state_t);
        // _math state_t staticWrapState#3; 
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#3, $state_to_int(staticWrapState#3), ^$#state_t);
        // staticWrapState#3 := @_vcc_current_state(@state); 
        staticWrapState#3 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#3, $state_to_int(staticWrapState#3), ^$#state_t);
        // _math ptrset owns#4; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#4, $ptrset_to_int(owns#4), ^$#ptrset);
        // owns#4 := @_vcc_set_empty; 
        owns#4 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#4, $ptrset_to_int(owns#4), ^$#ptrset);
        // assert @writes_check(S); 
        assert $top_writable($s, #wrTime$1^40.8, $phys_ptr_cast(L#S, ^Stack));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(S), staticWrapState#3, owns#4)
        call $static_wrap($phys_ptr_cast(L#S, ^Stack), staticWrapState#3, owns#4);
        assume $good_state_ext(#tok$1^49.25, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, S), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $phys_ptr_cast(L#S, ^Stack)), $set_empty());
        // assert @inv_check(@_vcc_is_malloc_root(@state, S)); 
        assert $is_malloc_root($s, $phys_ptr_cast(L#S, ^Stack));
        // assert @inv_check(<=(*((S->topOfStack)), 100)); 
        assert $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(L#S, ^Stack)) <= 100;
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
    }
    else
    {
      anon14:
        // empty
    }

  anon16:
    // return S; 
    $result := $phys_ptr_cast(L#S, ^Stack);
    assert $position_marker();
    goto #exit;

  anon17:
    // empty

  #exit:
}



procedure DisposeStack(P#S: $ptr);
  requires $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
  modifies $s, $cev_pc;
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#S, ^Stack)));
  free ensures $call_transition(old($s), $s);



implementation DisposeStack(P#S: $ptr)
{
  var prestate#8: $state;
  var prestate#6: $state;
  var owns#7: $ptrset;
  var #wrTime$1^54.1: int;
  var #stackframe: int;

  anon18:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^54.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^54.1, #loc.S, $ptr_to_int(P#S), $ptr_to(^Stack));
    assume #wrTime$1^54.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^54.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#S, ^Stack)));
    assume $thread_owned($s, $phys_ptr_cast(P#S, ^Stack));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#S, ^Stack), $phys_ptr_cast(P#S, ^Stack), l#public);
    // _math ptrset owns#7; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#7, $ptrset_to_int(owns#7), ^$#ptrset);
    // owns#7 := @_vcc_set_empty; 
    owns#7 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#7, $ptrset_to_int(owns#7), ^$#ptrset);
    // _math state_t prestate#6; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#6, $state_to_int(prestate#6), ^$#state_t);
    // prestate#6 := @_vcc_current_state(@state); 
    prestate#6 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#6, $state_to_int(prestate#6), ^$#state_t);
    // _math state_t prestate#8; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#8, $state_to_int(prestate#8), ^$#state_t);
    // prestate#8 := @_vcc_current_state(@state); 
    prestate#8 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#8, $state_to_int(prestate#8), ^$#state_t);
    // assert @_vcc_wrapped(@state, S); 
    assert $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^54.1, $phys_ptr_cast(P#S, ^Stack));
    // assume @_vcc_inv(@state, S); 
    assume $inv($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // assume ==(owns#7, @_vcc_owns(@state, S)); 
    assume owns#7 == $owns($s, $phys_ptr_cast(P#S, ^Stack));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(S), prestate#8)
    call $static_unwrap($phys_ptr_cast(P#S, ^Stack), prestate#8);
    assume $good_state_ext(#tok$1^58.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^54.1, $phys_ptr_cast(P#S, ^Stack));
    // assert @writes_check(@_vcc_extent(@state, S)); 
    assert (forall #writes$1^59.5: $ptr :: { $dont_instantiate(#writes$1^59.5) } $set_in(#writes$1^59.5, $extent($s, $phys_ptr_cast(P#S, ^Stack))) ==> $top_writable($s, #wrTime$1^54.1, #writes$1^59.5));
    // stmt _vcc_free(S); 
    call $free($phys_ptr_cast(P#S, ^Stack));
    assume $full_stop_ext(#tok$1^59.5, $s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure MakeEmpty(P#S: $ptr);
  requires $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
  modifies $s, $cev_pc;
  ensures F#IsEmpty($s, $phys_ptr_cast(P#S, ^Stack));
  ensures $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#S, ^Stack)));
  free ensures $call_transition(old($s), $s);



implementation MakeEmpty(P#S: $ptr)
{
  var owns#13: $ptrset;
  var staticWrapState#12: $state;
  var prestate#14: $state;
  var prestate#11: $state;
  var prestate#9: $state;
  var owns#10: $ptrset;
  var #wrTime$1^62.1: int;
  var #stackframe: int;

  anon19:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^62.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^62.1, #loc.S, $ptr_to_int(P#S), $ptr_to(^Stack));
    assume #wrTime$1^62.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^62.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#S, ^Stack)));
    assume $thread_owned($s, $phys_ptr_cast(P#S, ^Stack));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#S, ^Stack), $phys_ptr_cast(P#S, ^Stack), l#public);
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
    // assert @_vcc_wrapped(@state, S); 
    assert $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^62.1, $phys_ptr_cast(P#S, ^Stack));
    // assume @_vcc_inv(@state, S); 
    assume $inv($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // assume ==(owns#10, @_vcc_owns(@state, S)); 
    assume owns#10 == $owns($s, $phys_ptr_cast(P#S, ^Stack));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(S), prestate#11)
    call $static_unwrap($phys_ptr_cast(P#S, ^Stack), prestate#11);
    assume $good_state_ext(#tok$1^67.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((S->topOfStack)); 
    assert $writable_prim($s, #wrTime$1^62.1, $dot($phys_ptr_cast(P#S, ^Stack), Stack.topOfStack));
    // *(S->topOfStack) := 0; 
    call $write_int(Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack), 0);
    assume $full_stop_ext(#tok$1^68.5, $s);
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
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^62.1, $phys_ptr_cast(P#S, ^Stack));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(S), staticWrapState#12, owns#13)
    call $static_wrap($phys_ptr_cast(P#S, ^Stack), staticWrapState#12, owns#13);
    assume $good_state_ext(#tok$1^69.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, S), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(P#S, ^Stack)), $set_empty());
    // assert @inv_check(@_vcc_is_malloc_root(@state, S)); 
    assert $is_malloc_root($s, $phys_ptr_cast(P#S, ^Stack));
    // assert @inv_check(<=(*((S->topOfStack)), 100)); 
    assert $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) <= 100;
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure Push(P#S: $ptr, P#X: int);
  requires !F#IsFull($s, $phys_ptr_cast(P#S, ^Stack));
  requires $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
  modifies $s, $cev_pc;
  ensures !F#IsEmpty($s, $phys_ptr_cast(P#S, ^Stack));
  ensures $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) == $rd_inv(old($s), Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) + 1;
  ensures $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#S, ^Stack)));
  free ensures $call_transition(old($s), $s);



implementation Push(P#S: $ptr, P#X: int)
{
  var owns#19: $ptrset;
  var staticWrapState#18: $state;
  var prestate#20: $state;
  var L#__temp62123: int where $in_range_u4(L#__temp62123);
  var prestate#17: $state;
  var prestate#15: $state;
  var owns#16: $ptrset;
  var #wrTime$1^72.1: int;
  var #stackframe: int;

  anon20:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^72.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^72.1, #loc.S, $ptr_to_int(P#S), $ptr_to(^Stack));
    assume $local_value_is($s, #tok$1^72.1, #loc.X, P#X, ^^i4);
    assume #wrTime$1^72.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^72.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#S, ^Stack)));
    assume $thread_owned($s, $phys_ptr_cast(P#S, ^Stack));
    // assume true; 
    assume true;
    // assume @in_range_i4(X); 
    assume $in_range_i4(P#X);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#S, ^Stack), $phys_ptr_cast(P#S, ^Stack), l#public);
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
    // assert @_vcc_wrapped(@state, S); 
    assert $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^72.1, $phys_ptr_cast(P#S, ^Stack));
    // assume @_vcc_inv(@state, S); 
    assume $inv($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // assume ==(owns#16, @_vcc_owns(@state, S)); 
    assume owns#16 == $owns($s, $phys_ptr_cast(P#S, ^Stack));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(S), prestate#17)
    call $static_unwrap($phys_ptr_cast(P#S, ^Stack), prestate#17);
    assume $good_state_ext(#tok$1^79.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // uint32_t __temp62123; 
    assume $local_value_is($s, #tok$1^80.14, #loc.__temp62123, L#__temp62123, ^^u4);
    // assert @reads_check_normal((S->topOfStack)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // __temp62123 := *((S->topOfStack)); 
    L#__temp62123 := $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack));
    assume $local_value_is($s, #tok$1^80.14, #loc.__temp62123, L#__temp62123, ^^u4);
    // assert @prim_writes_check((S->topOfStack)); 
    assert $writable_prim($s, #wrTime$1^72.1, $dot($phys_ptr_cast(P#S, ^Stack), Stack.topOfStack));
    // assert @in_range_u4(+(__temp62123, 1)); 
    assert $in_range_u4(L#__temp62123 + 1);
    // *(S->topOfStack) := +(__temp62123, 1); 
    call $write_int(Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack), L#__temp62123 + 1);
    assume $full_stop_ext(#tok$1^80.14, $s);
    // assert @prim_writes_check((S->array)[__temp62123]); 
    assert $writable_prim($s, #wrTime$1^72.1, $idx($dot($phys_ptr_cast(P#S, ^Stack), Stack.array), L#__temp62123));
    // *(S->array)[__temp62123] := X; 
    call $write_int($field($idx($dot($phys_ptr_cast(P#S, ^Stack), Stack.array), L#__temp62123)), $emb0($idx($dot($phys_ptr_cast(P#S, ^Stack), Stack.array), L#__temp62123)), P#X);
    assume $full_stop_ext(#tok$1^80.5, $s);
    // _math state_t prestate#20; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#20, $state_to_int(prestate#20), ^$#state_t);
    // prestate#20 := @_vcc_current_state(@state); 
    prestate#20 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#20, $state_to_int(prestate#20), ^$#state_t);
    // _math state_t staticWrapState#18; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#18, $state_to_int(staticWrapState#18), ^$#state_t);
    // staticWrapState#18 := @_vcc_current_state(@state); 
    staticWrapState#18 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#18, $state_to_int(staticWrapState#18), ^$#state_t);
    // _math ptrset owns#19; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#19, $ptrset_to_int(owns#19), ^$#ptrset);
    // owns#19 := @_vcc_set_empty; 
    owns#19 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#19, $ptrset_to_int(owns#19), ^$#ptrset);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^72.1, $phys_ptr_cast(P#S, ^Stack));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(S), staticWrapState#18, owns#19)
    call $static_wrap($phys_ptr_cast(P#S, ^Stack), staticWrapState#18, owns#19);
    assume $good_state_ext(#tok$1^81.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, S), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(P#S, ^Stack)), $set_empty());
    // assert @inv_check(@_vcc_is_malloc_root(@state, S)); 
    assert $is_malloc_root($s, $phys_ptr_cast(P#S, ^Stack));
    // assert @inv_check(<=(*((S->topOfStack)), 100)); 
    assert $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) <= 100;
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure Top(P#S: $ptr) returns ($result: int);
  requires !F#IsEmpty($s, $phys_ptr_cast(P#S, ^Stack));
  requires $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  ensures $result == $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#S, ^Stack), Stack.array), $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) - 1)), $emb0($idx($dot($phys_ptr_cast(P#S, ^Stack), Stack.array), $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) - 1)));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Top(P#S: $ptr) returns ($result: int)
{
  var #wrTime$1^84.1: int;
  var #stackframe: int;

  anon21:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^84.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^84.1, #loc.S, $ptr_to_int(P#S), $ptr_to(^Stack));
    assume #wrTime$1^84.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^84.1, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#S, ^Stack), $phys_ptr_cast(P#S, ^Stack), l#public);
    // assert @reads_check_normal((S->array)[-(*((S->topOfStack)), 1)]); 
    assert $thread_local($s, $idx($dot($phys_ptr_cast(P#S, ^Stack), Stack.array), $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) - 1));
    // assert @in_range_u4(-(*((S->topOfStack)), 1)); 
    assert $in_range_u4($rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) - 1);
    // assert @reads_check_normal((S->topOfStack)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // return *((S->array)[-(*((S->topOfStack)), 1)]); 
    $result := $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#S, ^Stack), Stack.array), $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) - 1)), $emb0($idx($dot($phys_ptr_cast(P#S, ^Stack), Stack.array), $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) - 1)));
    assert $position_marker();
    goto #exit;

  anon22:
    // empty

  #exit:
}



procedure Pop(P#S: $ptr);
  requires !F#IsEmpty($s, $phys_ptr_cast(P#S, ^Stack));
  requires $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
  modifies $s, $cev_pc;
  ensures !F#IsFull($s, $phys_ptr_cast(P#S, ^Stack));
  ensures $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) == $rd_inv(old($s), Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) - 1;
  ensures $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#S, ^Stack)));
  free ensures $call_transition(old($s), $s);



implementation Pop(P#S: $ptr)
{
  var owns#25: $ptrset;
  var staticWrapState#24: $state;
  var prestate#26: $state;
  var prestate#23: $state;
  var prestate#21: $state;
  var owns#22: $ptrset;
  var #wrTime$1^92.1: int;
  var #stackframe: int;

  anon23:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^92.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^92.1, #loc.S, $ptr_to_int(P#S), $ptr_to(^Stack));
    assume #wrTime$1^92.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^92.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#S, ^Stack)));
    assume $thread_owned($s, $phys_ptr_cast(P#S, ^Stack));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#S, ^Stack), $phys_ptr_cast(P#S, ^Stack), l#public);
    // _math ptrset owns#22; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#22, $ptrset_to_int(owns#22), ^$#ptrset);
    // owns#22 := @_vcc_set_empty; 
    owns#22 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#22, $ptrset_to_int(owns#22), ^$#ptrset);
    // _math state_t prestate#21; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#21, $state_to_int(prestate#21), ^$#state_t);
    // prestate#21 := @_vcc_current_state(@state); 
    prestate#21 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#21, $state_to_int(prestate#21), ^$#state_t);
    // _math state_t prestate#23; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#23, $state_to_int(prestate#23), ^$#state_t);
    // prestate#23 := @_vcc_current_state(@state); 
    prestate#23 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#23, $state_to_int(prestate#23), ^$#state_t);
    // assert @_vcc_wrapped(@state, S); 
    assert $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^92.1, $phys_ptr_cast(P#S, ^Stack));
    // assume @_vcc_inv(@state, S); 
    assume $inv($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // assume ==(owns#22, @_vcc_owns(@state, S)); 
    assume owns#22 == $owns($s, $phys_ptr_cast(P#S, ^Stack));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(S), prestate#23)
    call $static_unwrap($phys_ptr_cast(P#S, ^Stack), prestate#23);
    assume $good_state_ext(#tok$1^99.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((S->topOfStack)); 
    assert $writable_prim($s, #wrTime$1^92.1, $dot($phys_ptr_cast(P#S, ^Stack), Stack.topOfStack));
    // assert @in_range_u4(-(*((S->topOfStack)), 1)); 
    assert $in_range_u4($rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) - 1);
    // assert @reads_check_normal((S->topOfStack)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // *(S->topOfStack) := -(*((S->topOfStack)), 1); 
    call $write_int(Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack), $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) - 1);
    assume $full_stop_ext(#tok$1^100.5, $s);
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
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^92.1, $phys_ptr_cast(P#S, ^Stack));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(S), staticWrapState#24, owns#25)
    call $static_wrap($phys_ptr_cast(P#S, ^Stack), staticWrapState#24, owns#25);
    assume $good_state_ext(#tok$1^101.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, S), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(P#S, ^Stack)), $set_empty());
    // assert @inv_check(@_vcc_is_malloc_root(@state, S)); 
    assert $is_malloc_root($s, $phys_ptr_cast(P#S, ^Stack));
    // assert @inv_check(<=(*((S->topOfStack)), 100)); 
    assert $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) <= 100;
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure test_main();
  modifies $s, $cev_pc;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation test_main()
{
  var #wrTime$1^125.36: int;
  var loopState#1: $state;
  var #wrTime$1^116.36: int;
  var loopState#0: $state;
  var L#S: $ptr;
  var L#i: int where $in_range_u4(L#i);
  var L#j: int where $in_range_i4(L#j);
  var #wrTime$1^104.1: int;
  var #stackframe: int;

  anon34:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^104.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^104.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^104.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // int32_t j; 
    assume $local_value_is($s, #tok$1^108.5, #loc.j, L#j, ^^i4);
    // uint32_t i; 
    assume $local_value_is($s, #tok$1^107.5, #loc.i, L#i, ^^u4);
    // struct Stack* S; 
    assume $local_value_is($s, #tok$1^106.12, #loc.S, $ptr_to_int(L#S), $ptr_to(^Stack));
    // var struct Stack* S
    // var uint32_t i
    // var int32_t j
    // non-pure function
    // S := CreateStack(); 
    call L#S := CreateStack();
    assume $full_stop_ext(#tok$1^110.9, $s);
    assume $local_value_is($s, #tok$1^110.9, #loc.S, $ptr_to_int(L#S), $ptr_to(^Stack));
    assume true;
    // if (@_vcc_ptr_neq_null(S)) ...
    if ($non_null($phys_ptr_cast(L#S, ^Stack)))
    {
      anon30:
        // assert IsEmpty(S); 
        assert F#IsEmpty($s, $phys_ptr_cast(L#S, ^Stack));
        // assume IsEmpty(S); 
        assume F#IsEmpty($s, $phys_ptr_cast(L#S, ^Stack));
        // i := 0; 
        L#i := 0;
        assume $local_value_is($s, #tok$1^114.9, #loc.i, L#i, ^^u4);
        call $bump_timestamp();
        assume $full_stop_ext(#tok$1^116.36, $s);
        loopState#0 := $s;
        assume #wrTime$1^116.36 == $current_timestamp($s);
        assume $def_writes($s, #wrTime$1^116.36, (lambda #p: $ptr :: #p == $phys_ptr_cast(L#S, ^Stack)));
        assert (forall #loopWrites^$1^116.36: $ptr :: { $dont_instantiate(#loopWrites^$1^116.36) } $listed_in_writes($s, #wrTime$1^116.36, #loopWrites^$1^116.36) ==> $top_writable($s, #wrTime$1^104.1, #loopWrites^$1^116.36));
        while (true)
          invariant $wrapped($s, $phys_ptr_cast(L#S, ^Stack), ^Stack);
          invariant L#i == F#Length($s, $phys_ptr_cast(L#S, ^Stack));
        {
          anon26:
            assume $modifies(loopState#0, $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(L#S, ^Stack)));
            assume $timestamp_post(loopState#0, $s);
            assume $full_stop_ext(#tok$1^115.9, $s);
            assume $local_value_is($s, #tok$1^115.9, #loc.i, L#i, ^^u4);
            assume $local_value_is($s, #tok$1^115.9, #loc.j, L#j, ^^i4);
            assume true;
            // if (<(i, 100)) ...
            if (L#i < 100)
            {
              anon24:
                // assert @writes_check(S); 
                assert $top_writable($s, #wrTime$1^116.36, $phys_ptr_cast(L#S, ^Stack));
                // stmt Push(S, @unchecked_i4((int32_t)i)); 
                call Push($phys_ptr_cast(L#S, ^Stack), $unchecked(^^i4, L#i));
                assume $full_stop_ext(#tok$1^120.13, $s);
                // assert @in_range_u4(+(i, 1)); 
                assert $in_range_u4(L#i + 1);
                // i := +(i, 1); 
                L#i := L#i + 1;
                assume $local_value_is($s, #tok$1^121.13, #loc.i, L#i, ^^u4);
            }
            else
            {
              anon25:
                // goto #break_1; 
                goto #break_1;
            }

          #continue_1:
            assume true;
        }

      anon31:
        assume $full_stop_ext(#tok$1^115.9, $s);

      #break_1:
        call $bump_timestamp();
        assume $full_stop_ext(#tok$1^125.36, $s);
        loopState#1 := $s;
        assume #wrTime$1^125.36 == $current_timestamp($s);
        assume $def_writes($s, #wrTime$1^125.36, (lambda #p: $ptr :: #p == $phys_ptr_cast(L#S, ^Stack)));
        assert (forall #loopWrites^$1^125.36: $ptr :: { $dont_instantiate(#loopWrites^$1^125.36) } $listed_in_writes($s, #wrTime$1^125.36, #loopWrites^$1^125.36) ==> $top_writable($s, #wrTime$1^104.1, #loopWrites^$1^125.36));
        while (true)
          invariant $wrapped($s, $phys_ptr_cast(L#S, ^Stack), ^Stack);
          invariant L#i == F#Length($s, $phys_ptr_cast(L#S, ^Stack));
        {
          anon29:
            assume $modifies(loopState#1, $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(L#S, ^Stack)));
            assume $timestamp_post(loopState#1, $s);
            assume $full_stop_ext(#tok$1^124.9, $s);
            assume $local_value_is($s, #tok$1^124.9, #loc.i, L#i, ^^u4);
            assume $local_value_is($s, #tok$1^124.9, #loc.j, L#j, ^^i4);
            assume true;
            // if (>(i, 0)) ...
            if (L#i > 0)
            {
              anon27:
                // non-pure function
                // j := Top(S); 
                call L#j := Top($phys_ptr_cast(L#S, ^Stack));
                assume $full_stop_ext(#tok$1^129.17, $s);
                assume $local_value_is($s, #tok$1^129.17, #loc.j, L#j, ^^i4);
                // assert @writes_check(S); 
                assert $top_writable($s, #wrTime$1^125.36, $phys_ptr_cast(L#S, ^Stack));
                // stmt Pop(S); 
                call Pop($phys_ptr_cast(L#S, ^Stack));
                assume $full_stop_ext(#tok$1^130.13, $s);
                // assert @in_range_u4(-(i, 1)); 
                assert $in_range_u4(L#i - 1);
                // i := -(i, 1); 
                L#i := L#i - 1;
                assume $local_value_is($s, #tok$1^131.13, #loc.i, L#i, ^^u4);
            }
            else
            {
              anon28:
                // goto #break_2; 
                goto #break_2;
            }

          #continue_2:
            assume true;
        }

      anon32:
        assume $full_stop_ext(#tok$1^124.9, $s);

      #break_2:
        // assert @writes_check(S); 
        assert $top_writable($s, #wrTime$1^104.1, $phys_ptr_cast(L#S, ^Stack));
        // stmt DisposeStack(S); 
        call DisposeStack($phys_ptr_cast(L#S, ^Stack));
        assume $full_stop_ext(#tok$1^134.9, $s);
    }
    else
    {
      anon33:
        // empty
    }

  anon35:
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure Length#reads(P#S: $ptr);
  requires $reads_check_pre($s);
  modifies $s, $cev_pc;
  ensures F#Length(old($s), $phys_ptr_cast(P#S, ^Stack)) == F#Length($s, $phys_ptr_cast(P#S, ^Stack));
  ensures $reads_check_post($s);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Length#reads(P#S: $ptr)
{
  var #wrTime$1^31.17: int;
  var #stackframe: int;

  anon36:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^31.17, $s);
    assume $local_value_is($s, #tok$1^31.17, #loc.S, $ptr_to_int(P#S), $ptr_to(^Stack));
    assume #wrTime$1^31.17 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^31.17, (lambda #p: $ptr :: false));
    // assume @_vcc_wrapped(@state, S); 
    assume $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // assume @_vcc_in_domain(@state, S, S); 
    assume $in_domain_lab($s, $phys_ptr_cast(P#S, ^Stack), $phys_ptr_cast(P#S, ^Stack), l#public);
    // @_vcc_reads_havoc
    call $reads_havoc();
    assume $full_stop_ext(#tok$1^31.17, $s);
    // assume @reads_same(S); 
    assume $read_version($s, $phys_ptr_cast(P#S, ^Stack)) == old($read_version($s, $phys_ptr_cast(P#S, ^Stack)));
    // assume @_vcc_wrapped(@state, S); 
    assume $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure IsFull#reads(P#S: $ptr);
  requires $reads_check_pre($s);
  modifies $s, $cev_pc;
  ensures F#IsFull(old($s), $phys_ptr_cast(P#S, ^Stack)) == F#IsFull($s, $phys_ptr_cast(P#S, ^Stack));
  ensures $reads_check_post($s);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation IsFull#reads(P#S: $ptr)
{
  var #wrTime$1^22.17: int;
  var #stackframe: int;

  anon37:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^22.17, $s);
    assume $local_value_is($s, #tok$1^22.17, #loc.S, $ptr_to_int(P#S), $ptr_to(^Stack));
    assume #wrTime$1^22.17 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^22.17, (lambda #p: $ptr :: false));
    // assume @_vcc_wrapped(@state, S); 
    assume $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // assume @_vcc_in_domain(@state, S, S); 
    assume $in_domain_lab($s, $phys_ptr_cast(P#S, ^Stack), $phys_ptr_cast(P#S, ^Stack), l#public);
    // @_vcc_reads_havoc
    call $reads_havoc();
    assume $full_stop_ext(#tok$1^22.17, $s);
    // assume @reads_same(S); 
    assume $read_version($s, $phys_ptr_cast(P#S, ^Stack)) == old($read_version($s, $phys_ptr_cast(P#S, ^Stack)));
    // assume @_vcc_wrapped(@state, S); 
    assume $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure IsEmpty#reads(P#S: $ptr);
  requires $reads_check_pre($s);
  modifies $s, $cev_pc;
  ensures F#IsEmpty(old($s), $phys_ptr_cast(P#S, ^Stack)) == F#IsEmpty($s, $phys_ptr_cast(P#S, ^Stack));
  ensures $reads_check_post($s);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation IsEmpty#reads(P#S: $ptr)
{
  var #wrTime$1^13.17: int;
  var #stackframe: int;

  anon38:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^13.17, $s);
    assume $local_value_is($s, #tok$1^13.17, #loc.S, $ptr_to_int(P#S), $ptr_to(^Stack));
    assume #wrTime$1^13.17 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^13.17, (lambda #p: $ptr :: false));
    // assume @_vcc_wrapped(@state, S); 
    assume $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // assume @_vcc_in_domain(@state, S, S); 
    assume $in_domain_lab($s, $phys_ptr_cast(P#S, ^Stack), $phys_ptr_cast(P#S, ^Stack), l#public);
    // @_vcc_reads_havoc
    call $reads_havoc();
    assume $full_stop_ext(#tok$1^13.17, $s);
    // assume @reads_same(S); 
    assume $read_version($s, $phys_ptr_cast(P#S, ^Stack)) == old($read_version($s, $phys_ptr_cast(P#S, ^Stack)));
    // assume @_vcc_wrapped(@state, S); 
    assume $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



const unique l#public: $label;

const unique #tok$1^134.9: $token;

const unique #tok$1^131.13: $token;

const unique #tok$1^130.13: $token;

const unique #tok$1^129.17: $token;

const unique #tok$1^124.9: $token;

const unique #tok$1^125.36: $token;

const unique #tok$1^121.13: $token;

const unique #tok$1^120.13: $token;

const unique #tok$1^115.9: $token;

const unique #tok$1^116.36: $token;

const unique #tok$1^114.9: $token;

const unique #tok$1^110.9: $token;

const unique #tok$1^106.12: $token;

const unique #loc.i: $token;

const unique #tok$1^107.5: $token;

const unique #loc.j: $token;

const unique #tok$1^108.5: $token;

const unique #tok$1^104.1: $token;

const unique #tok$1^101.21: $token;

const unique #loc.owns#25: $token;

const unique #loc.staticWrapState#24: $token;

const unique #loc.prestate#26: $token;

const unique #tok$1^100.5: $token;

const unique #tok$1^99.21: $token;

const unique #loc.prestate#23: $token;

const unique #loc.prestate#21: $token;

const unique #loc.owns#22: $token;

const unique #tok$1^92.1: $token;

const unique #tok$1^84.1: $token;

const unique #tok$1^81.21: $token;

const unique #loc.owns#19: $token;

const unique #loc.staticWrapState#18: $token;

const unique #loc.prestate#20: $token;

const unique #tok$1^80.5: $token;

const unique #loc.__temp62123: $token;

const unique #tok$1^80.14: $token;

const unique #tok$1^79.21: $token;

const unique #loc.prestate#17: $token;

const unique #loc.prestate#15: $token;

const unique #loc.owns#16: $token;

const unique #loc.X: $token;

const unique #tok$1^72.1: $token;

const unique #tok$1^69.21: $token;

const unique #loc.owns#13: $token;

const unique #loc.staticWrapState#12: $token;

const unique #loc.prestate#14: $token;

const unique #tok$1^68.5: $token;

const unique #tok$1^67.21: $token;

const unique #loc.prestate#11: $token;

const unique #loc.prestate#9: $token;

const unique #loc.owns#10: $token;

const unique #tok$1^62.1: $token;

const unique #tok$1^59.5: $token;

const unique #tok$1^58.21: $token;

const unique #loc.prestate#8: $token;

const unique #loc.prestate#6: $token;

const unique #loc.owns#7: $token;

const unique #tok$1^54.1: $token;

const unique #tok$1^49.25: $token;

const unique #loc.owns#4: $token;

const unique #loc.staticWrapState#3: $token;

function $state_to_int(x: $state) : int;

function $int_to_state(x: int) : $state;

axiom (forall #x: $state :: #x == $int_to_state($state_to_int(#x)));

const unique #loc.prestate#5: $token;

const unique #tok$2^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(2, #file^?3Cno?20file?3E);

const unique #tok$1^48.9: $token;

const unique #tok$1^46.9: $token;

const unique #tok$1^44.12: $token;

const unique #tok$1^40.8: $token;

const unique #tok$1^31.17: $token;

const unique #tok$1^22.17: $token;

const unique #loc.S: $token;

const unique #tok$1^13.17: $token;

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^Stack);

const unique #loc._this_: $token;

const unique #tok$1^7.1: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CStackArray.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CStackArray.c);
