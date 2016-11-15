axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^Stack: $ctype;

axiom $is_composite(^Stack);

axiom $ptr_level(^Stack) == 0;

axiom $sizeof(^Stack) == 404;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Stack) } $inv2(#s1, #s2, #p, ^Stack) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty()) && $is_malloc_root(#s2, #p) && $mem(#s2, $dot(#p, Stack.topOfStack)) <= 100));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^Stack, #r), l#public) } $inv_lab(#s2, $ptr(^Stack, #r), l#public) == ($typed(#s2, $ptr(^Stack, #r)) && $set_eq($owns(#s2, $ptr(^Stack, #r)), $set_empty()) && $is_malloc_root(#s2, $ptr(^Stack, #r)) && $mem(#s2, $dot($ptr(^Stack, #r), Stack.topOfStack)) <= 100));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^Stack, #r)) } $in_full_extent_of(#q, $ptr(^Stack, #r)) == (#q == $ptr(^Stack, #r) || #q == $dot($ptr(^Stack, #r), Stack.$owns) || #q == $dot($ptr(^Stack, #r), Stack.topOfStack) || $in_array(#q, $dot($ptr(^Stack, #r), Stack.array), ^^i4, 100)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Stack, #r)) } $in_extent_of(#s, #q, $ptr(^Stack, #r)) == $in_struct_extent_of(#q, $ptr(^Stack, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Stack, #r)) } $typed(#s, $ptr(^Stack, #r)) ==> $in_extent_of(#s, #q, $ptr(^Stack, #r)) == (#q == $ptr(^Stack, #r) || $emb(#s, #q) == $ptr(^Stack, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^Stack, #r)) } $in_span_of(#q, $ptr(^Stack, #r)) == (#q == $ptr(^Stack, #r) || #q == $dot($ptr(^Stack, #r), Stack.$owns) || #q == $dot($ptr(^Stack, #r), Stack.topOfStack) || $in_array(#q, $dot($ptr(^Stack, #r), Stack.array), ^^i4, 100)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^Stack) } $state_spans_the_same(#s1, #s2, #p, ^Stack) == ($mem_eq(#s1, #s2, $dot(#p, Stack.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Stack.topOfStack)) && (forall #i: int :: { $idx($dot(#p, Stack.array), #i, ^^i4) } $in_range(0, #i, 99) ==> $mem_eq(#s1, #s2, $idx($dot(#p, Stack.array), #i, ^^i4)))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Stack) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Stack) == ($mem_eq(#s1, #s2, $dot(#p, Stack.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Stack.topOfStack)) && (forall #i: int :: { $idx($dot(#p, Stack.array), #i, ^^i4) } $in_range(0, #i, 99) ==> $mem_eq(#s1, #s2, $idx($dot(#p, Stack.array), #i, ^^i4)))));

axiom $is_claimable(^Stack) == false;

axiom $has_volatile_owns_set(^Stack) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^Stack, #r)) } $extent_mutable(#s1, $ptr(^Stack, #r)) == ($mutable(#s1, $ptr(^Stack, #r)) && (forall #i: int :: { $idx($dot($ptr(^Stack, #r), Stack.array), #i, ^^i4) } true)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^Stack, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^Stack, #r)) == ($is_fresh(#s1, #s2, $ptr(^Stack, #r)) && (forall #i: int :: { $idx($dot($ptr(^Stack, #r), Stack.array), #i, ^^i4) } true)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^Stack, #r)) } $extent_zero(#s1, $ptr(^Stack, #r)) == ($mem(#s1, $dot($ptr(^Stack, #r), Stack.topOfStack)) == 0 && (forall #i: int :: { $idx($dot($ptr(^Stack, #r), Stack.array), #i, ^^i4) } $in_range(0, #i, 99) ==> $mem(#s1, $idx($dot($ptr(^Stack, #r), Stack.array), #i, ^^i4)) == 0)));

const unique Stack.$owns: $field;

axiom $static_field_properties(Stack.$owns, ^Stack);

axiom $is_primitive_non_volatile_field(Stack.$owns);

axiom (forall #p: $ptr :: { $dot(#p, Stack.$owns) } $is(#p, ^Stack) ==> $dot(#p, Stack.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, Stack.$owns)) && $extent_hint($dot(#p, Stack.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Stack.$owns)) } { $st(#s, $dot(#p, Stack.$owns)) } $typed2(#s, #p, ^Stack) ==> $field_properties(#s, #p, Stack.$owns, ^$#ptrset, false));

axiom $owns_set_field(^Stack) == Stack.$owns;

const unique Stack.topOfStack: $field;

axiom $static_field_properties(Stack.topOfStack, ^Stack);

axiom $is_primitive_non_volatile_field(Stack.topOfStack);

axiom $field_offset(Stack.topOfStack) == 0;

axiom (forall #p: $ptr :: { $dot(#p, Stack.topOfStack) } $is(#p, ^Stack) ==> $dot(#p, Stack.topOfStack) == $ptr(^^u4, $ref(#p) + 0) && $extent_hint($dot(#p, Stack.topOfStack), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Stack.topOfStack)) } { $st(#s, $dot(#p, Stack.topOfStack)) } $typed2(#s, #p, ^Stack) ==> $field_properties(#s, #p, Stack.topOfStack, ^^u4, false));

const unique Stack.array: $field;

axiom $static_field_properties(Stack.array, ^Stack);

axiom $is_primitive_embedded_array(Stack.array, 100);

axiom $embedded_array_size(Stack.array, ^^i4) == 100;

axiom $field_offset(Stack.array) == 4;

axiom (forall #p: $ptr :: { $dot(#p, Stack.array) } $is(#p, ^Stack) ==> $dot(#p, Stack.array) == $ptr(^^i4, $ref(#p) + 4) && $extent_hint($dot(#p, Stack.array), #p));

axiom $array_field_properties(Stack.array, ^^i4, 100, false, false);

procedure Stack#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $set_eq($owns($s, $ptr(^Stack, P#_this_)), $set_empty());
  ensures $is_admissibility_check() ==> $is_malloc_root($s, $ptr(^Stack, P#_this_));
  ensures $is_admissibility_check() ==> $mem($s, $dot($ptr(^Stack, P#_this_), Stack.topOfStack)) <= 100;
  ensures $is_unwrap_check() ==> $set_eq($owns($s, $ptr(^Stack, P#_this_)), $set_empty());
  ensures $is_unwrap_check() ==> $is_malloc_root($s, $ptr(^Stack, P#_this_));
  ensures $is_unwrap_check() ==> $mem($s, $dot($ptr(^Stack, P#_this_), Stack.topOfStack)) <= 100;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Stack#adm(P#_this_: int)
{
  var #wrTime$1^7.1: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^7.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^7.1, #loc._this_, $ptr_to_int($ptr(^Stack, P#_this_)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^7.1, #loc._this_, $ptr(^Stack, P#_this_), $ptr_to(^Stack));
    assume #wrTime$1^7.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^7.1, #p) } $in_writes_at(#wrTime$1^7.1, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^Stack, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^Stack, P#_this_));
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
            assume $admissibility_pre($s, $ptr(^Stack, P#_this_));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^Stack, P#_this_));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Stack*)@null))
        call $havoc_others($ptr(^Stack, P#_this_), ^Stack);
        assume $good_state_ext(#tok$1^7.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^Stack, P#_this_), ^Stack);
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

function F#IsEmpty(#s: $state, P#S: int) : bool;

const unique cf#IsEmpty: $pure_function;

axiom (forall #s: $state, P#S: int :: { F#IsEmpty(#s, P#S) } $wrapped(#s, $ptr(^Stack, P#S), ^Stack) ==> F#IsEmpty(#s, P#S) == ($mem(#s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) == 0));

function F#IsEmpty#frame(int, $version) : bool;

axiom (forall #s: $state, P#S: int :: { F#IsEmpty(#s, P#S) } $full_stop(#s) && $can_use_frame_axiom_of(cf#IsEmpty) && $closed(#s, $ptr(^Stack, P#S)) ==> F#IsEmpty(#s, P#S) == F#IsEmpty#frame(P#S, $read_version(#s, $ptr(^Stack, P#S))));

axiom $function_arg_type(cf#IsEmpty, 0, ^^bool);

axiom $function_arg_type(cf#IsEmpty, 1, $ptr_to(^Stack));

procedure IsEmpty(P#S: int) returns ($result: bool);
  requires $wrapped($s, $ptr(^Stack, P#S), ^Stack);
  ensures $result == ($mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) == 0);
  free ensures $result == F#IsEmpty($s, P#S);
  free ensures $call_transition(old($s), $s);



implementation IsEmpty(P#S: int) returns ($result: bool)
{
  var #wrTime$1^13.17: int;
  var #stackframe: int;

  anon7:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^13.17, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^13.17, #loc.S, $ptr_to_int($ptr(^Stack, P#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^13.17, #loc.S, $ptr(^Stack, P#S), $ptr_to(^Stack));
    assume #wrTime$1^13.17 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^13.17, #p) } $in_writes_at(#wrTime$1^13.17, #p) == false);
    // assume @in_range_phys_ptr((mathint)S); 
    assume $in_range_phys_ptr($ref($ptr(^Stack, P#S)));
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $ptr(^Stack, P#S), $ptr(^Stack, P#S), l#public);
    // assert @reads_check_normal((S->topOfStack)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    // return ==(*((S->topOfStack)), 0); 
    $result := $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) == 0;
    assert $position_marker();
    goto #exit;

  anon8:
    // empty

  #exit:
}



function F#IsFull(#s: $state, P#S: int) : bool;

const unique cf#IsFull: $pure_function;

axiom (forall #s: $state, P#S: int :: { F#IsFull(#s, P#S) } $wrapped(#s, $ptr(^Stack, P#S), ^Stack) ==> F#IsFull(#s, P#S) == ($mem(#s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) == 100));

axiom $function_arg_type(cf#IsFull, 0, ^^bool);

axiom $function_arg_type(cf#IsFull, 1, $ptr_to(^Stack));

procedure IsFull(P#S: int) returns ($result: bool);
  requires $wrapped($s, $ptr(^Stack, P#S), ^Stack);
  ensures $result == ($mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) == 100);
  free ensures $result == F#IsFull($s, P#S);
  free ensures $call_transition(old($s), $s);



implementation IsFull(P#S: int) returns ($result: bool)
{
  var #wrTime$1^22.17: int;
  var #stackframe: int;

  anon9:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^22.17, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^22.17, #loc.S, $ptr_to_int($ptr(^Stack, P#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^22.17, #loc.S, $ptr(^Stack, P#S), $ptr_to(^Stack));
    assume #wrTime$1^22.17 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^22.17, #p) } $in_writes_at(#wrTime$1^22.17, #p) == false);
    // assume @in_range_phys_ptr((mathint)S); 
    assume $in_range_phys_ptr($ref($ptr(^Stack, P#S)));
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $ptr(^Stack, P#S), $ptr(^Stack, P#S), l#public);
    // assert @reads_check_normal((S->topOfStack)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    // return ==(*((S->topOfStack)), 100); 
    $result := $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) == 100;
    assert $position_marker();
    goto #exit;

  anon10:
    // empty

  #exit:
}



function F#Length(#s: $state, P#S: int) : int;

const unique cf#Length: $pure_function;

axiom (forall #s: $state, P#S: int :: { F#Length(#s, P#S) } $wrapped(#s, $ptr(^Stack, P#S), ^Stack) ==> $in_range_u4(F#Length(#s, P#S)) && F#Length(#s, P#S) == $mem(#s, $dot($ptr(^Stack, P#S), Stack.topOfStack)));

axiom $function_arg_type(cf#Length, 0, ^^u4);

axiom $function_arg_type(cf#Length, 1, $ptr_to(^Stack));

procedure Length(P#S: int) returns ($result: int);
  requires $wrapped($s, $ptr(^Stack, P#S), ^Stack);
  free ensures $in_range_u4($result);
  ensures $result == $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack));
  free ensures $result == F#Length($s, P#S);
  free ensures $call_transition(old($s), $s);



implementation Length(P#S: int) returns ($result: int)
{
  var #wrTime$1^31.17: int;
  var #stackframe: int;

  anon11:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^31.17, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^31.17, #loc.S, $ptr_to_int($ptr(^Stack, P#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^31.17, #loc.S, $ptr(^Stack, P#S), $ptr_to(^Stack));
    assume #wrTime$1^31.17 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^31.17, #p) } $in_writes_at(#wrTime$1^31.17, #p) == false);
    // assume @in_range_phys_ptr((mathint)S); 
    assume $in_range_phys_ptr($ref($ptr(^Stack, P#S)));
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $ptr(^Stack, P#S), $ptr(^Stack, P#S), l#public);
    // assert @reads_check_normal((S->topOfStack)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    // return *((S->topOfStack)); 
    $result := $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack));
    assert $position_marker();
    goto #exit;

  anon12:
    // empty

  #exit:
}



procedure CreateStack() returns ($result: int);
  modifies $s, $cev_pc;
  free ensures $in_range_phys_ptr($ref($ptr(^Stack, $result)));
  ensures $ptr_eq($ptr(^Stack, $result), $null) || ($wrapped($s, $ptr(^Stack, $result), ^Stack) && $is_fresh(old($s), $s, $ptr(^Stack, $result)) && F#IsEmpty($s, $ref($ptr(^Stack, $result))));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation CreateStack() returns ($result: int)
{
  var owns#4: $ptrset;
  var staticWrapState#3: $state;
  var prestate#5: $state;
  var #callConv#0: $ptr;
  var L#S: int where $in_range_phys_ptr(L#S);
  var #wrTime$1^40.8: int;
  var #stackframe: int;

  anon15:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^40.8, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^40.8 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^40.8, #p) } $in_writes_at(#wrTime$1^40.8, #p) == false);
    // struct Stack* S; 
    assume $local_value_is($s, #tok$1^44.12, #loc.S, $ptr_to_int($ptr(^Stack, L#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^44.12, #loc.S, $ptr(^Stack, L#S), $ptr_to(^Stack));
    // var struct Stack* S
    // S := _vcc_alloc(@_vcc_typeof((struct Stack*)@null)); 
    call #callConv#0 := $alloc(^Stack);
    assume $full_stop_ext(#tok$1^46.9, $s);
    L#S := $ref(#callConv#0);
    assume $local_value_is($s, #tok$1^46.9, #loc.S, $ptr_to_int($ptr(^Stack, L#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^46.9, #loc.S, $ptr(^Stack, L#S), $ptr_to(^Stack));
    assume true;
    // if (@_vcc_ptr_neq(S, @null)) ...
    if ($ptr_neq($ptr(^Stack, L#S), $null))
    {
      anon13:
        // assert @_vcc_typed2(@state, (S->topOfStack)); 
        assert $typed2($s, $dot($ptr(^Stack, L#S), Stack.topOfStack), ^^u4);
        // assert @prim_writes_check((S->topOfStack)); 
        assert $writable($s, #wrTime$1^40.8, $dot($ptr(^Stack, L#S), Stack.topOfStack));
        // *(S->topOfStack) := 0; 
        call $write_int($dot($ptr(^Stack, L#S), Stack.topOfStack), 0);
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
        assert $top_writable($s, #wrTime$1^40.8, $ptr(^Stack, L#S));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(S), staticWrapState#3, owns#4)
        call $static_wrap($ptr(^Stack, L#S), staticWrapState#3, owns#4);
        assume $good_state_ext(#tok$1^49.25, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, S), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $ptr(^Stack, L#S)), $set_empty());
        // assert @inv_check(@_vcc_is_malloc_root(@state, S)); 
        assert $is_malloc_root($s, $ptr(^Stack, L#S));
        // assert @inv_check(<=(*((S->topOfStack)), 100)); 
        assert $mem($s, $dot($ptr(^Stack, L#S), Stack.topOfStack)) <= 100;
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
    $result := $ref($ptr(^Stack, L#S));
    assert $position_marker();
    goto #exit;

  anon17:
    // empty

  #exit:
}



procedure DisposeStack(P#S: int);
  requires $wrapped($s, $ptr(^Stack, P#S), ^Stack);
  modifies $s, $cev_pc;
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Stack, P#S) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Stack, P#S) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Stack, P#S) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation DisposeStack(P#S: int)
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
    assume $local_value_is($s, #tok$1^54.1, #loc.S, $ptr_to_int($ptr(^Stack, P#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^54.1, #loc.S, $ptr(^Stack, P#S), $ptr_to(^Stack));
    assume #wrTime$1^54.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^54.1, #p) } $in_writes_at(#wrTime$1^54.1, #p) == (#p == $ptr(^Stack, P#S)));
    assume $thread_owned($s, $ptr(^Stack, P#S));
    // assume @in_range_phys_ptr((mathint)S); 
    assume $in_range_phys_ptr($ref($ptr(^Stack, P#S)));
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $ptr(^Stack, P#S), $ptr(^Stack, P#S), l#public);
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
    assert $wrapped($s, $ptr(^Stack, P#S), ^Stack);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^54.1, $ptr(^Stack, P#S));
    // assume @_vcc_inv(@state, S); 
    assume $inv($s, $ptr(^Stack, P#S), ^Stack);
    // assume ==(owns#7, @_vcc_owns(@state, S)); 
    assume owns#7 == $owns($s, $ptr(^Stack, P#S));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(S), prestate#8)
    call $static_unwrap($ptr(^Stack, P#S), prestate#8);
    assume $good_state_ext(#tok$1^58.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^54.1, $ptr(^Stack, P#S));
    // assert @writes_check(@_vcc_extent(@state, S)); 
    assert (forall #writes$1^59.5: $ptr :: { $dont_instantiate(#writes$1^59.5) } $set_in(#writes$1^59.5, $extent($s, $ptr(^Stack, P#S))) ==> $top_writable($s, #wrTime$1^54.1, #writes$1^59.5));
    // stmt _vcc_free(S); 
    call $free($ptr(^Stack, P#S));
    assume $full_stop_ext(#tok$1^59.5, $s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure MakeEmpty(P#S: int);
  requires $wrapped($s, $ptr(^Stack, P#S), ^Stack);
  modifies $s, $cev_pc;
  ensures F#IsEmpty($s, $ref($ptr(^Stack, P#S)));
  ensures $wrapped($s, $ptr(^Stack, P#S), ^Stack);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Stack, P#S) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Stack, P#S) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Stack, P#S) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation MakeEmpty(P#S: int)
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
    assume $local_value_is($s, #tok$1^62.1, #loc.S, $ptr_to_int($ptr(^Stack, P#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^62.1, #loc.S, $ptr(^Stack, P#S), $ptr_to(^Stack));
    assume #wrTime$1^62.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^62.1, #p) } $in_writes_at(#wrTime$1^62.1, #p) == (#p == $ptr(^Stack, P#S)));
    assume $thread_owned($s, $ptr(^Stack, P#S));
    // assume @in_range_phys_ptr((mathint)S); 
    assume $in_range_phys_ptr($ref($ptr(^Stack, P#S)));
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $ptr(^Stack, P#S), $ptr(^Stack, P#S), l#public);
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
    assert $wrapped($s, $ptr(^Stack, P#S), ^Stack);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^62.1, $ptr(^Stack, P#S));
    // assume @_vcc_inv(@state, S); 
    assume $inv($s, $ptr(^Stack, P#S), ^Stack);
    // assume ==(owns#10, @_vcc_owns(@state, S)); 
    assume owns#10 == $owns($s, $ptr(^Stack, P#S));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(S), prestate#11)
    call $static_unwrap($ptr(^Stack, P#S), prestate#11);
    assume $good_state_ext(#tok$1^67.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (S->topOfStack)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    // assert @prim_writes_check((S->topOfStack)); 
    assert $writable($s, #wrTime$1^62.1, $dot($ptr(^Stack, P#S), Stack.topOfStack));
    // *(S->topOfStack) := 0; 
    call $write_int($dot($ptr(^Stack, P#S), Stack.topOfStack), 0);
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
    assert $top_writable($s, #wrTime$1^62.1, $ptr(^Stack, P#S));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(S), staticWrapState#12, owns#13)
    call $static_wrap($ptr(^Stack, P#S), staticWrapState#12, owns#13);
    assume $good_state_ext(#tok$1^69.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, S), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^Stack, P#S)), $set_empty());
    // assert @inv_check(@_vcc_is_malloc_root(@state, S)); 
    assert $is_malloc_root($s, $ptr(^Stack, P#S));
    // assert @inv_check(<=(*((S->topOfStack)), 100)); 
    assert $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) <= 100;
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure Push(P#S: int, P#X: int);
  requires !F#IsFull($s, $ref($ptr(^Stack, P#S)));
  requires $wrapped($s, $ptr(^Stack, P#S), ^Stack);
  modifies $s, $cev_pc;
  ensures !F#IsEmpty($s, $ref($ptr(^Stack, P#S)));
  ensures $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) == $mem(old($s), $dot($ptr(^Stack, P#S), Stack.topOfStack)) + 1;
  ensures $wrapped($s, $ptr(^Stack, P#S), ^Stack);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Stack, P#S) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Stack, P#S) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Stack, P#S) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Push(P#S: int, P#X: int)
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
    assume $local_value_is($s, #tok$1^72.1, #loc.S, $ptr_to_int($ptr(^Stack, P#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^72.1, #loc.S, $ptr(^Stack, P#S), $ptr_to(^Stack));
    assume $local_value_is($s, #tok$1^72.1, #loc.X, P#X, ^^i4);
    assume #wrTime$1^72.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^72.1, #p) } $in_writes_at(#wrTime$1^72.1, #p) == (#p == $ptr(^Stack, P#S)));
    assume $thread_owned($s, $ptr(^Stack, P#S));
    // assume @in_range_phys_ptr((mathint)S); 
    assume $in_range_phys_ptr($ref($ptr(^Stack, P#S)));
    // assume @in_range_i4(X); 
    assume $in_range_i4(P#X);
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $ptr(^Stack, P#S), $ptr(^Stack, P#S), l#public);
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
    assert $wrapped($s, $ptr(^Stack, P#S), ^Stack);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^72.1, $ptr(^Stack, P#S));
    // assume @_vcc_inv(@state, S); 
    assume $inv($s, $ptr(^Stack, P#S), ^Stack);
    // assume ==(owns#16, @_vcc_owns(@state, S)); 
    assume owns#16 == $owns($s, $ptr(^Stack, P#S));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(S), prestate#17)
    call $static_unwrap($ptr(^Stack, P#S), prestate#17);
    assume $good_state_ext(#tok$1^79.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // uint32_t __temp62123; 
    assume $local_value_is($s, #tok$1^80.14, #loc.__temp62123, L#__temp62123, ^^u4);
    // assert @reads_check_normal((S->topOfStack)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    // __temp62123 := *((S->topOfStack)); 
    L#__temp62123 := $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack));
    assume $local_value_is($s, #tok$1^80.14, #loc.__temp62123, L#__temp62123, ^^u4);
    // assert @_vcc_typed2(@state, (S->topOfStack)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    // assert @prim_writes_check((S->topOfStack)); 
    assert $writable($s, #wrTime$1^72.1, $dot($ptr(^Stack, P#S), Stack.topOfStack));
    // assert @in_range_u4(+(__temp62123, 1)); 
    assert $in_range_u4(L#__temp62123 + 1);
    // *(S->topOfStack) := +(__temp62123, 1); 
    call $write_int($dot($ptr(^Stack, P#S), Stack.topOfStack), L#__temp62123 + 1);
    assume $full_stop_ext(#tok$1^80.14, $s);
    // assert @_vcc_typed2(@state, (S->array)[__temp62123]); 
    assert $typed2($s, $idx($dot($ptr(^Stack, P#S), Stack.array), L#__temp62123, ^^i4), ^^i4);
    // assert @prim_writes_check((S->array)[__temp62123]); 
    assert $writable($s, #wrTime$1^72.1, $idx($dot($ptr(^Stack, P#S), Stack.array), L#__temp62123, ^^i4));
    // *(S->array)[__temp62123] := X; 
    call $write_int($idx($dot($ptr(^Stack, P#S), Stack.array), L#__temp62123, ^^i4), P#X);
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
    assert $top_writable($s, #wrTime$1^72.1, $ptr(^Stack, P#S));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(S), staticWrapState#18, owns#19)
    call $static_wrap($ptr(^Stack, P#S), staticWrapState#18, owns#19);
    assume $good_state_ext(#tok$1^81.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, S), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^Stack, P#S)), $set_empty());
    // assert @inv_check(@_vcc_is_malloc_root(@state, S)); 
    assert $is_malloc_root($s, $ptr(^Stack, P#S));
    // assert @inv_check(<=(*((S->topOfStack)), 100)); 
    assert $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) <= 100;
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure Top(P#S: int) returns ($result: int);
  requires !F#IsEmpty($s, $ref($ptr(^Stack, P#S)));
  requires $wrapped($s, $ptr(^Stack, P#S), ^Stack);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  ensures $result == $mem($s, $idx($dot($ptr(^Stack, P#S), Stack.array), $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) - 1, ^^i4));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Top(P#S: int) returns ($result: int)
{
  var #wrTime$1^84.1: int;
  var #stackframe: int;

  anon21:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^84.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^84.1, #loc.S, $ptr_to_int($ptr(^Stack, P#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^84.1, #loc.S, $ptr(^Stack, P#S), $ptr_to(^Stack));
    assume #wrTime$1^84.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^84.1, #p) } $in_writes_at(#wrTime$1^84.1, #p) == false);
    // assume @in_range_phys_ptr((mathint)S); 
    assume $in_range_phys_ptr($ref($ptr(^Stack, P#S)));
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $ptr(^Stack, P#S), $ptr(^Stack, P#S), l#public);
    // assert @reads_check_normal((S->array)[-(*((S->topOfStack)), 1)]); 
    assert $typed2($s, $idx($dot($ptr(^Stack, P#S), Stack.array), $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) - 1, ^^i4), ^^i4);
    assert $thread_local2($s, $idx($dot($ptr(^Stack, P#S), Stack.array), $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) - 1, ^^i4), ^^i4);
    // assert @in_range_u4(-(*((S->topOfStack)), 1)); 
    assert $in_range_u4($mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) - 1);
    // assert @reads_check_normal((S->topOfStack)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    // return *((S->array)[-(*((S->topOfStack)), 1)]); 
    $result := $mem($s, $idx($dot($ptr(^Stack, P#S), Stack.array), $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) - 1, ^^i4));
    assert $position_marker();
    goto #exit;

  anon22:
    // empty

  #exit:
}



procedure Pop(P#S: int);
  requires !F#IsEmpty($s, $ref($ptr(^Stack, P#S)));
  requires $wrapped($s, $ptr(^Stack, P#S), ^Stack);
  modifies $s, $cev_pc;
  ensures !F#IsFull($s, $ref($ptr(^Stack, P#S)));
  ensures $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) == $mem(old($s), $dot($ptr(^Stack, P#S), Stack.topOfStack)) - 1;
  ensures $wrapped($s, $ptr(^Stack, P#S), ^Stack);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Stack, P#S) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Stack, P#S) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Stack, P#S) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Pop(P#S: int)
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
    assume $local_value_is($s, #tok$1^92.1, #loc.S, $ptr_to_int($ptr(^Stack, P#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^92.1, #loc.S, $ptr(^Stack, P#S), $ptr_to(^Stack));
    assume #wrTime$1^92.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^92.1, #p) } $in_writes_at(#wrTime$1^92.1, #p) == (#p == $ptr(^Stack, P#S)));
    assume $thread_owned($s, $ptr(^Stack, P#S));
    // assume @in_range_phys_ptr((mathint)S); 
    assume $in_range_phys_ptr($ref($ptr(^Stack, P#S)));
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $ptr(^Stack, P#S), $ptr(^Stack, P#S), l#public);
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
    assert $wrapped($s, $ptr(^Stack, P#S), ^Stack);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^92.1, $ptr(^Stack, P#S));
    // assume @_vcc_inv(@state, S); 
    assume $inv($s, $ptr(^Stack, P#S), ^Stack);
    // assume ==(owns#22, @_vcc_owns(@state, S)); 
    assume owns#22 == $owns($s, $ptr(^Stack, P#S));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(S), prestate#23)
    call $static_unwrap($ptr(^Stack, P#S), prestate#23);
    assume $good_state_ext(#tok$1^99.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (S->topOfStack)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    // assert @prim_writes_check((S->topOfStack)); 
    assert $writable($s, #wrTime$1^92.1, $dot($ptr(^Stack, P#S), Stack.topOfStack));
    // assert @in_range_u4(-(*((S->topOfStack)), 1)); 
    assert $in_range_u4($mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) - 1);
    // assert @reads_check_normal((S->topOfStack)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    // *(S->topOfStack) := -(*((S->topOfStack)), 1); 
    call $write_int($dot($ptr(^Stack, P#S), Stack.topOfStack), $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) - 1);
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
    assert $top_writable($s, #wrTime$1^92.1, $ptr(^Stack, P#S));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(S), staticWrapState#24, owns#25)
    call $static_wrap($ptr(^Stack, P#S), staticWrapState#24, owns#25);
    assume $good_state_ext(#tok$1^101.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, S), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^Stack, P#S)), $set_empty());
    // assert @inv_check(@_vcc_is_malloc_root(@state, S)); 
    assert $is_malloc_root($s, $ptr(^Stack, P#S));
    // assert @inv_check(<=(*((S->topOfStack)), 100)); 
    assert $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) <= 100;
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
  var loopState#1: $state;
  var loopState#0: $state;
  var L#S: int where $in_range_phys_ptr(L#S);
  var L#i: int where $in_range_u4(L#i);
  var L#j: int where $in_range_i4(L#j);
  var #wrTime$1^104.1: int;
  var #stackframe: int;

  anon34:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^104.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^104.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^104.1, #p) } $in_writes_at(#wrTime$1^104.1, #p) == false);
    // int32_t j; 
    assume $local_value_is($s, #tok$1^108.5, #loc.j, L#j, ^^i4);
    // uint32_t i; 
    assume $local_value_is($s, #tok$1^107.5, #loc.i, L#i, ^^u4);
    // struct Stack* S; 
    assume $local_value_is($s, #tok$1^106.12, #loc.S, $ptr_to_int($ptr(^Stack, L#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^106.12, #loc.S, $ptr(^Stack, L#S), $ptr_to(^Stack));
    // var struct Stack* S
    // var uint32_t i
    // var int32_t j
    // non-pure function
    // S := CreateStack(); 
    call L#S := CreateStack();
    assume $full_stop_ext(#tok$1^110.9, $s);
    assume $local_value_is($s, #tok$1^110.9, #loc.S, $ptr_to_int($ptr(^Stack, L#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^110.9, #loc.S, $ptr(^Stack, L#S), $ptr_to(^Stack));
    assume true;
    // if (@_vcc_ptr_neq(S, @null)) ...
    if ($ptr_neq($ptr(^Stack, L#S), $null))
    {
      anon30:
        // assert IsEmpty(S); 
        assert F#IsEmpty($s, $ref($ptr(^Stack, L#S)));
        // assume IsEmpty(S); 
        assume F#IsEmpty($s, $ref($ptr(^Stack, L#S)));
        // i := 0; 
        L#i := 0;
        assume $local_value_is($s, #tok$1^114.9, #loc.i, L#i, ^^u4);
        loopState#0 := $s;
        while (true)
          invariant $wrapped($s, $ptr(^Stack, L#S), ^Stack);
          invariant L#i == F#Length($s, $ref($ptr(^Stack, L#S)));
        {
          anon26:
            assume $writes_nothing(old($s), $s);
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
                assert $top_writable($s, #wrTime$1^104.1, $ptr(^Stack, L#S));
                // stmt Push(S, @unchecked_i4((int32_t)i)); 
                call Push($ref($ptr(^Stack, L#S)), $unchecked(^^i4, L#i));
                assume $full_stop_ext(#tok$1^119.13, $s);
                // assert @in_range_u4(+(i, 1)); 
                assert $in_range_u4(L#i + 1);
                // i := +(i, 1); 
                L#i := L#i + 1;
                assume $local_value_is($s, #tok$1^120.13, #loc.i, L#i, ^^u4);
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
        loopState#1 := $s;
        while (true)
          invariant $wrapped($s, $ptr(^Stack, L#S), ^Stack);
          invariant L#i == F#Length($s, $ref($ptr(^Stack, L#S)));
        {
          anon29:
            assume $writes_nothing(old($s), $s);
            assume $timestamp_post(loopState#1, $s);
            assume $full_stop_ext(#tok$1^123.9, $s);
            assume $local_value_is($s, #tok$1^123.9, #loc.i, L#i, ^^u4);
            assume $local_value_is($s, #tok$1^123.9, #loc.j, L#j, ^^i4);
            assume true;
            // if (>(i, 0)) ...
            if (L#i > 0)
            {
              anon27:
                // non-pure function
                // j := Top(S); 
                call L#j := Top($ref($ptr(^Stack, L#S)));
                assume $full_stop_ext(#tok$1^127.17, $s);
                assume $local_value_is($s, #tok$1^127.17, #loc.j, L#j, ^^i4);
                // assert @writes_check(S); 
                assert $top_writable($s, #wrTime$1^104.1, $ptr(^Stack, L#S));
                // stmt Pop(S); 
                call Pop($ref($ptr(^Stack, L#S)));
                assume $full_stop_ext(#tok$1^128.13, $s);
                // assert @in_range_u4(-(i, 1)); 
                assert $in_range_u4(L#i - 1);
                // i := -(i, 1); 
                L#i := L#i - 1;
                assume $local_value_is($s, #tok$1^129.13, #loc.i, L#i, ^^u4);
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
        assume $full_stop_ext(#tok$1^123.9, $s);

      #break_2:
        // assert @writes_check(S); 
        assert $top_writable($s, #wrTime$1^104.1, $ptr(^Stack, L#S));
        // stmt DisposeStack(S); 
        call DisposeStack($ref($ptr(^Stack, L#S)));
        assume $full_stop_ext(#tok$1^132.9, $s);
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



procedure Length#reads(P#S: int);
  requires $reads_check_pre($s);
  modifies $s, $cev_pc;
  ensures F#Length(old($s), $ref($ptr(^Stack, P#S))) == F#Length($s, $ref($ptr(^Stack, P#S)));
  ensures $reads_check_post($s);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Length#reads(P#S: int)
{
  var #wrTime$1^31.17: int;
  var #stackframe: int;

  anon36:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^31.17, $s);
    assume $local_value_is($s, #tok$1^31.17, #loc.S, $ptr_to_int($ptr(^Stack, P#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^31.17, #loc.S, $ptr(^Stack, P#S), $ptr_to(^Stack));
    assume #wrTime$1^31.17 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^31.17, #p) } $in_writes_at(#wrTime$1^31.17, #p) == false);
    // assume @_vcc_wrapped(@state, S); 
    assume $wrapped($s, $ptr(^Stack, P#S), ^Stack);
    // assume @_vcc_in_domain(@state, S, S); 
    assume $in_domain_lab($s, $ptr(^Stack, P#S), $ptr(^Stack, P#S), l#public);
    // @_vcc_reads_havoc
    call $reads_havoc();
    assume $full_stop_ext(#tok$1^31.17, $s);
    // assume @reads_same(S); 
    assume $mem($s, $ptr(^Stack, P#S)) == old($mem($s, $ptr(^Stack, P#S)));
    // assume @_vcc_wrapped(@state, S); 
    assume $wrapped($s, $ptr(^Stack, P#S), ^Stack);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure IsFull#reads(P#S: int);
  requires $reads_check_pre($s);
  modifies $s, $cev_pc;
  ensures F#IsFull(old($s), $ref($ptr(^Stack, P#S))) == F#IsFull($s, $ref($ptr(^Stack, P#S)));
  ensures $reads_check_post($s);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation IsFull#reads(P#S: int)
{
  var #wrTime$1^22.17: int;
  var #stackframe: int;

  anon37:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^22.17, $s);
    assume $local_value_is($s, #tok$1^22.17, #loc.S, $ptr_to_int($ptr(^Stack, P#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^22.17, #loc.S, $ptr(^Stack, P#S), $ptr_to(^Stack));
    assume #wrTime$1^22.17 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^22.17, #p) } $in_writes_at(#wrTime$1^22.17, #p) == false);
    // assume @_vcc_wrapped(@state, S); 
    assume $wrapped($s, $ptr(^Stack, P#S), ^Stack);
    // assume @_vcc_in_domain(@state, S, S); 
    assume $in_domain_lab($s, $ptr(^Stack, P#S), $ptr(^Stack, P#S), l#public);
    // @_vcc_reads_havoc
    call $reads_havoc();
    assume $full_stop_ext(#tok$1^22.17, $s);
    // assume @reads_same(S); 
    assume $mem($s, $ptr(^Stack, P#S)) == old($mem($s, $ptr(^Stack, P#S)));
    // assume @_vcc_wrapped(@state, S); 
    assume $wrapped($s, $ptr(^Stack, P#S), ^Stack);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure IsEmpty#reads(P#S: int);
  requires $reads_check_pre($s);
  modifies $s, $cev_pc;
  ensures F#IsEmpty(old($s), $ref($ptr(^Stack, P#S))) == F#IsEmpty($s, $ref($ptr(^Stack, P#S)));
  ensures $reads_check_post($s);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation IsEmpty#reads(P#S: int)
{
  var #wrTime$1^13.17: int;
  var #stackframe: int;

  anon38:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^13.17, $s);
    assume $local_value_is($s, #tok$1^13.17, #loc.S, $ptr_to_int($ptr(^Stack, P#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^13.17, #loc.S, $ptr(^Stack, P#S), $ptr_to(^Stack));
    assume #wrTime$1^13.17 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^13.17, #p) } $in_writes_at(#wrTime$1^13.17, #p) == false);
    // assume @_vcc_wrapped(@state, S); 
    assume $wrapped($s, $ptr(^Stack, P#S), ^Stack);
    // assume @_vcc_in_domain(@state, S, S); 
    assume $in_domain_lab($s, $ptr(^Stack, P#S), $ptr(^Stack, P#S), l#public);
    // @_vcc_reads_havoc
    call $reads_havoc();
    assume $full_stop_ext(#tok$1^13.17, $s);
    // assume @reads_same(S); 
    assume $mem($s, $ptr(^Stack, P#S)) == old($mem($s, $ptr(^Stack, P#S)));
    // assume @_vcc_wrapped(@state, S); 
    assume $wrapped($s, $ptr(^Stack, P#S), ^Stack);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



const unique l#public: $label;

const unique #tok$1^132.9: $token;

const unique #tok$1^129.13: $token;

const unique #tok$1^128.13: $token;

const unique #tok$1^127.17: $token;

const unique #tok$1^123.9: $token;

const unique #tok$1^120.13: $token;

const unique #tok$1^119.13: $token;

const unique #tok$1^115.9: $token;

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

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CStackArray.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CStackArray.c);
