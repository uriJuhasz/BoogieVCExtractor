axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

const unique ^AbsStack: $ctype;

axiom $is_span_sequential(^AbsStack);

axiom $def_struct_type(^AbsStack, 1, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^AbsStack) } $inv2(#s1, #s2, #p, ^AbsStack) == ($set_eq($owns(#s2, #p), $set_empty()) && $rd_inv(#s2, AbsStack.high_mark, #p) <= $rd_inv(#s2, AbsStack.capacity, #p) && $is_malloc_root(#s2, #p)));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^AbsStack)) } $in(q, $composite_extent(s, p, ^AbsStack)) == (q == p));

const unique AbsStack.high_mark: $field;

axiom $def_ghost_field(^AbsStack, AbsStack.high_mark, ^^u4, false);

const unique AbsStack.capacity: $field;

axiom $def_ghost_field(^AbsStack, AbsStack.capacity, ^^u4, false);

const unique AbsStack.entries: $field;

axiom $def_ghost_field(^AbsStack, AbsStack.entries, $map_t(^^u4, ^^u4), false);

procedure AbsStack#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $set_eq($owns($s, $spec_ptr_cast(P#_this_, ^AbsStack)), $set_empty());
  ensures $is_admissibility_check() ==> $rd_inv($s, AbsStack.high_mark, $spec_ptr_cast(P#_this_, ^AbsStack)) <= $rd_inv($s, AbsStack.capacity, $spec_ptr_cast(P#_this_, ^AbsStack));
  ensures $is_admissibility_check() ==> $is_malloc_root($s, $spec_ptr_cast(P#_this_, ^AbsStack));
  ensures $is_unwrap_check() ==> $set_eq($owns($s, $spec_ptr_cast(P#_this_, ^AbsStack)), $set_empty());
  ensures $is_unwrap_check() ==> $rd_inv($s, AbsStack.high_mark, $spec_ptr_cast(P#_this_, ^AbsStack)) <= $rd_inv($s, AbsStack.capacity, $spec_ptr_cast(P#_this_, ^AbsStack));
  ensures $is_unwrap_check() ==> $is_malloc_root($s, $spec_ptr_cast(P#_this_, ^AbsStack));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation AbsStack#adm(P#_this_: $ptr)
{
  var #wrTime$1^7.23: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^7.23, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^7.23, #loc._this_, $ptr_to_int(P#_this_), $spec_ptr_to(^AbsStack));
    assume #wrTime$1^7.23 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^7.23, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($spec_ptr_cast(P#_this_, ^AbsStack), ^AbsStack);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $spec_ptr_cast(P#_this_, ^AbsStack));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($spec_ptr_cast(P#_this_, ^AbsStack));
        assume $good_state_ext(#tok$1^7.23, $s);
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
            assume $admissibility_pre($s, $spec_ptr_cast(P#_this_, ^AbsStack));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $spec_ptr_cast(P#_this_, ^AbsStack));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct AbsStack*)@null))
        call $havoc_others($spec_ptr_cast(P#_this_, ^AbsStack), ^AbsStack);
        assume $good_state_ext(#tok$1^7.23, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $spec_ptr_cast(P#_this_, ^AbsStack), ^AbsStack);
    }

  #exit:
}



const unique ^Stack: $ctype;

axiom $is_span_sequential(^Stack);

axiom $def_struct_type(^Stack, 16, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Stack) } $inv2(#s1, #s2, #p, ^Stack) == ($int_to_ptr($rd_inv(#s2, Stack.elementsAsArray, #p)) == $as_array($rd_phys_ptr(#s2, Stack.elements, #p, ^^u4), ^^u4, $rd_inv(#s2, Stack.capacity, #p)) && $rd_spec_ptr(#s1, Stack.abs, #p, ^AbsStack) == $rd_spec_ptr(#s2, Stack.abs, #p, ^AbsStack) && $keeps(#s2, #p, $rd_spec_ptr(#s2, Stack.abs, #p, ^AbsStack)) && $int_to_ptr($rd_inv(#s1, Stack.elementsAsArray, #p)) == $int_to_ptr($rd_inv(#s2, Stack.elementsAsArray, #p)) && $keeps(#s2, #p, $int_to_ptr($rd_inv(#s2, Stack.elementsAsArray, #p))) && $is_malloc_root(#s2, #p) && $is_malloc_root(#s2, $int_to_ptr($rd_inv(#s2, Stack.elementsAsArray, #p))) && $rd_inv(#s2, Stack.topOfStack, #p) <= $rd_inv(#s2, Stack.capacity, #p) && F#AbstractionRelation(#s2, #p)));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^Stack)) } $in(q, $composite_extent(s, p, ^Stack)) == (q == p));

const unique Stack.topOfStack: $field;

axiom $def_phys_field(^Stack, Stack.topOfStack, ^^u4, false, 0);

const unique Stack.capacity: $field;

axiom $def_phys_field(^Stack, Stack.capacity, ^^u4, false, 4);

const unique Stack.elements: $field;

axiom $def_phys_field(^Stack, Stack.elements, $ptr_to(^^u4), false, 8);

const unique Stack.abs: $field;

axiom $def_ghost_field(^Stack, Stack.abs, $spec_ptr_to(^AbsStack), false);

const unique Stack.elementsAsArray: $field;

axiom $def_ghost_field(^Stack, Stack.elementsAsArray, ^^object, false);

procedure Stack#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#_this_, ^Stack))) == $as_array($rd_phys_ptr($s, Stack.elements, $phys_ptr_cast(P#_this_, ^Stack), ^^u4), ^^u4, $rd_inv($s, Stack.capacity, $phys_ptr_cast(P#_this_, ^Stack)));
  ensures $is_admissibility_check() ==> $rd_spec_ptr(old($s), Stack.abs, $phys_ptr_cast(P#_this_, ^Stack), ^AbsStack) == $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#_this_, ^Stack), ^AbsStack);
  ensures $is_admissibility_check() ==> $keeps($s, $phys_ptr_cast(P#_this_, ^Stack), $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#_this_, ^Stack), ^AbsStack));
  ensures $is_admissibility_check() ==> $int_to_ptr($rd_inv(old($s), Stack.elementsAsArray, $phys_ptr_cast(P#_this_, ^Stack))) == $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#_this_, ^Stack)));
  ensures $is_admissibility_check() ==> $keeps($s, $phys_ptr_cast(P#_this_, ^Stack), $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#_this_, ^Stack))));
  ensures $is_admissibility_check() ==> $is_malloc_root($s, $phys_ptr_cast(P#_this_, ^Stack));
  ensures $is_admissibility_check() ==> $is_malloc_root($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#_this_, ^Stack))));
  ensures $is_admissibility_check() ==> $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#_this_, ^Stack)) <= $rd_inv($s, Stack.capacity, $phys_ptr_cast(P#_this_, ^Stack));
  ensures $is_admissibility_check() ==> F#AbstractionRelation($s, $phys_ptr_cast(P#_this_, ^Stack));
  ensures $is_stuttering_check() ==> $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#_this_, ^Stack), ^AbsStack) == $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#_this_, ^Stack), ^AbsStack);
  ensures $is_stuttering_check() ==> $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#_this_, ^Stack))) == $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#_this_, ^Stack)));
  ensures $is_unwrap_check() ==> $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#_this_, ^Stack))) == $as_array($rd_phys_ptr($s, Stack.elements, $phys_ptr_cast(P#_this_, ^Stack), ^^u4), ^^u4, $rd_inv($s, Stack.capacity, $phys_ptr_cast(P#_this_, ^Stack)));
  ensures $is_unwrap_check() ==> $rd_spec_ptr(old($s), Stack.abs, $phys_ptr_cast(P#_this_, ^Stack), ^AbsStack) == $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#_this_, ^Stack), ^AbsStack);
  ensures $is_unwrap_check() ==> $keeps($s, $phys_ptr_cast(P#_this_, ^Stack), $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#_this_, ^Stack), ^AbsStack));
  ensures $is_unwrap_check() ==> $int_to_ptr($rd_inv(old($s), Stack.elementsAsArray, $phys_ptr_cast(P#_this_, ^Stack))) == $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#_this_, ^Stack)));
  ensures $is_unwrap_check() ==> $keeps($s, $phys_ptr_cast(P#_this_, ^Stack), $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#_this_, ^Stack))));
  ensures $is_unwrap_check() ==> $is_malloc_root($s, $phys_ptr_cast(P#_this_, ^Stack));
  ensures $is_unwrap_check() ==> $is_malloc_root($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#_this_, ^Stack))));
  ensures $is_unwrap_check() ==> $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#_this_, ^Stack)) <= $rd_inv($s, Stack.capacity, $phys_ptr_cast(P#_this_, ^Stack));
  ensures $is_unwrap_check() ==> F#AbstractionRelation($s, $phys_ptr_cast(P#_this_, ^Stack));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Stack#adm(P#_this_: $ptr)
{
  var #wrTime$1^16.1: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^16.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^16.1, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^Stack));
    assume #wrTime$1^16.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^16.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($phys_ptr_cast(P#_this_, ^Stack), ^Stack);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon7:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $phys_ptr_cast(P#_this_, ^Stack));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($phys_ptr_cast(P#_this_, ^Stack));
        assume $good_state_ext(#tok$1^16.1, $s);
        // assert true; 
        assert true;
    }
    else
    {
      anon10:
        assume true;
        // if (@_vcc_is_admissibility_check) ...
        if ($is_admissibility_check())
        {
          anon8:
            // assume @_vcc_admissibility_pre(@state, _this_); 
            assume $admissibility_pre($s, $phys_ptr_cast(P#_this_, ^Stack));
        }
        else
        {
          anon9:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $phys_ptr_cast(P#_this_, ^Stack));
        }

      anon11:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Stack*)@null))
        call $havoc_others($phys_ptr_cast(P#_this_, ^Stack), ^Stack);
        assume $good_state_ext(#tok$1^16.1, $s);
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

function F#AbstractionRelation(#s: $state, SP#stack: $ptr) : bool;

const unique cf#AbstractionRelation: $pure_function;

axiom (forall #s: $state, SP#stack: $ptr :: { F#AbstractionRelation(#s, SP#stack) } F#AbstractionRelation(#s, SP#stack) == ($rd_inv(#s, Stack.capacity, $phys_ptr_cast(SP#stack, ^Stack)) == $rd_inv(#s, AbsStack.capacity, $rd_spec_ptr(#s, Stack.abs, $phys_ptr_cast(SP#stack, ^Stack), ^AbsStack)) && $rd_inv(#s, Stack.topOfStack, $phys_ptr_cast(SP#stack, ^Stack)) == $rd_inv(#s, AbsStack.high_mark, $rd_spec_ptr(#s, Stack.abs, $phys_ptr_cast(SP#stack, ^Stack), ^AbsStack)) && (forall Q#idx$1^37.9#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rd_inv(#s, AbsStack.entries, $rd_spec_ptr(#s, Stack.abs, $phys_ptr_cast(SP#stack, ^Stack), ^AbsStack))), Q#idx$1^37.9#tc1) } $in_range_u4(Q#idx$1^37.9#tc1) ==> Q#idx$1^37.9#tc1 < $rd_inv(#s, Stack.topOfStack, $phys_ptr_cast(SP#stack, ^Stack)) ==> $rd_inv(#s, $field($idx($rd_phys_ptr(#s, Stack.elements, $phys_ptr_cast(SP#stack, ^Stack), ^^u4), Q#idx$1^37.9#tc1)), $emb0($idx($rd_phys_ptr(#s, Stack.elements, $phys_ptr_cast(SP#stack, ^Stack), ^^u4), Q#idx$1^37.9#tc1))) == $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rd_inv(#s, AbsStack.entries, $rd_spec_ptr(#s, Stack.abs, $phys_ptr_cast(SP#stack, ^Stack), ^AbsStack))), Q#idx$1^37.9#tc1))));

axiom $function_arg_type(cf#AbstractionRelation, 0, ^^bool);

axiom $function_arg_type(cf#AbstractionRelation, 1, $ptr_to(^Stack));

procedure AbstractionRelation(SP#stack: $ptr) returns ($result: bool);
  ensures $result == ($rd_inv($s, Stack.capacity, $phys_ptr_cast(SP#stack, ^Stack)) == $rd_inv($s, AbsStack.capacity, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(SP#stack, ^Stack), ^AbsStack)) && $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(SP#stack, ^Stack)) == $rd_inv($s, AbsStack.high_mark, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(SP#stack, ^Stack), ^AbsStack)) && (forall Q#idx$1^37.9#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rd_inv($s, AbsStack.entries, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(SP#stack, ^Stack), ^AbsStack))), Q#idx$1^37.9#tc1) } $in_range_u4(Q#idx$1^37.9#tc1) ==> Q#idx$1^37.9#tc1 < $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(SP#stack, ^Stack)) ==> $rd_inv($s, $field($idx($rd_phys_ptr($s, Stack.elements, $phys_ptr_cast(SP#stack, ^Stack), ^^u4), Q#idx$1^37.9#tc1)), $emb0($idx($rd_phys_ptr($s, Stack.elements, $phys_ptr_cast(SP#stack, ^Stack), ^^u4), Q#idx$1^37.9#tc1))) == $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rd_inv($s, AbsStack.entries, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(SP#stack, ^Stack), ^AbsStack))), Q#idx$1^37.9#tc1)));
  free ensures $result == F#AbstractionRelation($s, SP#stack);
  free ensures $call_transition(old($s), $s);



function F#IsEmpty(#s: $state, P#S: $ptr) : bool;

const unique cf#IsEmpty: $pure_function;

axiom (forall #s: $state, P#S: $ptr :: { F#IsEmpty(#s, P#S) } $wrapped(#s, $phys_ptr_cast(P#S, ^Stack), ^Stack) ==> F#IsEmpty(#s, P#S) == ($rd_inv(#s, AbsStack.high_mark, $rd_spec_ptr(#s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)) == 0));

function F#IsEmpty#frame($ptr, $version) : bool;

axiom (forall #s: $state, P#S: $ptr :: { F#IsEmpty(#s, P#S) } $full_stop(#s) && $can_use_frame_axiom_of(cf#IsEmpty) && $closed(#s, $phys_ptr_cast(P#S, ^Stack)) ==> F#IsEmpty(#s, P#S) == F#IsEmpty#frame(P#S, $read_version(#s, $phys_ptr_cast(P#S, ^Stack))));

axiom $function_arg_type(cf#IsEmpty, 0, ^^bool);

axiom $function_arg_type(cf#IsEmpty, 1, $ptr_to(^Stack));

procedure IsEmpty(P#S: $ptr) returns ($result: bool);
  requires $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
  ensures $result == ($rd_inv($s, AbsStack.high_mark, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)) == 0);
  free ensures $result == F#IsEmpty($s, P#S);
  free ensures $call_transition(old($s), $s);



implementation IsEmpty(P#S: $ptr) returns ($result: bool)
{
  var #wrTime$1^40.17: int;
  var #stackframe: int;

  anon13:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^40.17, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^40.17, #loc.S, $ptr_to_int(P#S), $ptr_to(^Stack));
    assume #wrTime$1^40.17 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^40.17, (lambda #p: $ptr :: false));
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

  anon14:
    // empty

  #exit:
}



function F#IsFull(#s: $state, P#S: $ptr) : bool;

const unique cf#IsFull: $pure_function;

axiom (forall #s: $state, P#S: $ptr :: { F#IsFull(#s, P#S) } $wrapped(#s, $phys_ptr_cast(P#S, ^Stack), ^Stack) ==> F#IsFull(#s, P#S) == ($rd_inv(#s, AbsStack.high_mark, $rd_spec_ptr(#s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)) == $rd_inv(#s, AbsStack.capacity, $rd_spec_ptr(#s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack))));

axiom $function_arg_type(cf#IsFull, 0, ^^bool);

axiom $function_arg_type(cf#IsFull, 1, $ptr_to(^Stack));

procedure IsFull(P#S: $ptr) returns ($result: bool);
  requires $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
  ensures $result == ($rd_inv($s, AbsStack.high_mark, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)) == $rd_inv($s, AbsStack.capacity, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)));
  free ensures $result == F#IsFull($s, P#S);
  free ensures $call_transition(old($s), $s);



implementation IsFull(P#S: $ptr) returns ($result: bool)
{
  var #wrTime$1^49.17: int;
  var #stackframe: int;

  anon15:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^49.17, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^49.17, #loc.S, $ptr_to_int(P#S), $ptr_to(^Stack));
    assume #wrTime$1^49.17 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^49.17, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#S, ^Stack), $phys_ptr_cast(P#S, ^Stack), l#public);
    // assert @reads_check_normal((S->topOfStack)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // assert @reads_check_normal((S->capacity)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // return ==(*((S->topOfStack)), *((S->capacity))); 
    $result := $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) == $rd_inv($s, Stack.capacity, $phys_ptr_cast(P#S, ^Stack));
    assert $position_marker();
    goto #exit;

  anon16:
    // empty

  #exit:
}



procedure Length(P#S: $ptr) returns ($result: int);
  requires $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
  modifies $s, $cev_pc;
  free ensures $in_range_u4($result);
  ensures $result == $rd_inv($s, AbsStack.high_mark, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Length(P#S: $ptr) returns ($result: int)
{
  var #wrTime$1^58.1: int;
  var #stackframe: int;

  anon17:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^58.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^58.1, #loc.S, $ptr_to_int(P#S), $ptr_to(^Stack));
    assume #wrTime$1^58.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^58.1, (lambda #p: $ptr :: false));
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

  anon18:
    // empty

  #exit:
}



procedure CreateStack(P#max_capacity: int) returns ($result: $ptr);
  requires P#max_capacity > 0;
  modifies $s, $cev_pc;
  free ensures true;
  ensures $is_null($phys_ptr_cast($result, ^Stack)) || ($wrapped($s, $phys_ptr_cast($result, ^Stack), ^Stack) && $is_fresh(old($s), $s, $phys_ptr_cast($result, ^Stack)) && F#IsEmpty($s, $phys_ptr_cast($result, ^Stack)) && $rd_inv($s, AbsStack.capacity, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast($result, ^Stack), ^AbsStack)) == P#max_capacity);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation CreateStack(P#max_capacity: int) returns ($result: $ptr)
{
  var owns#10: $ptrset;
  var staticWrapState#9: $state;
  var prestate#11: $state;
  var owns#7: $ptrset;
  var staticWrapState#6: $state;
  var prestate#8: $state;
  var prestate#5: $state;
  var res__vcc_spec_alloc#4: $ptr;
  var res__vcc_alloc#3: $ptr;
  var L#S: $ptr;
  var #wrTime$1^65.8: int;
  var #stackframe: int;

  anon23:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^65.8, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^65.8, #loc.max_capacity, P#max_capacity, ^^u4);
    assume #wrTime$1^65.8 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^65.8, (lambda #p: $ptr :: false));
    // assume @in_range_u4(max_capacity); 
    assume $in_range_u4(P#max_capacity);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // struct Stack* S; 
    assume $local_value_is($s, #tok$1^73.12, #loc.S, $ptr_to_int(L#S), $ptr_to(^Stack));
    // var struct Stack* S
    // S := _vcc_alloc(@_vcc_typeof((struct Stack*)@null)); 
    call L#S := $alloc(^Stack);
    assume $full_stop_ext(#tok$1^75.9, $s);
    assume $local_value_is($s, #tok$1^75.9, #loc.S, $ptr_to_int(L#S), $ptr_to(^Stack));
    assume true;
    // if (@_vcc_ptr_eq_null(S)) ...
    if ($is_null($phys_ptr_cast(L#S, ^Stack)))
    {
      anon19:
        // return (struct Stack*)@null; 
        $result := $phys_ptr_cast($null, ^Stack);
        assert $position_marker();
        goto #exit;
    }
    else
    {
      anon20:
        // empty
    }

  anon24:
    // assert @prim_writes_check((S->topOfStack)); 
    assert $writable_prim($s, #wrTime$1^65.8, $dot($phys_ptr_cast(L#S, ^Stack), Stack.topOfStack));
    // *(S->topOfStack) := 0; 
    call $write_int(Stack.topOfStack, $phys_ptr_cast(L#S, ^Stack), 0);
    assume $full_stop_ext(#tok$1^78.5, $s);
    // assert @prim_writes_check((S->capacity)); 
    assert $writable_prim($s, #wrTime$1^65.8, $dot($phys_ptr_cast(L#S, ^Stack), Stack.capacity));
    // *(S->capacity) := max_capacity; 
    call $write_int(Stack.capacity, $phys_ptr_cast(L#S, ^Stack), P#max_capacity);
    assume $full_stop_ext(#tok$1^79.5, $s);
    // obj_t res__vcc_alloc#3; 
    assume $local_value_is($s, #tok$1^80.19, #loc.res__vcc_alloc#3, $ptr_to_int(res__vcc_alloc#3), ^^object);
    // assert @reads_check_normal((S->capacity)); 
    assert $thread_local($s, $phys_ptr_cast(L#S, ^Stack));
    // res__vcc_alloc#3 := _vcc_alloc(@_vcc_array(@_vcc_typeof((uint32_t*)@null), *((S->capacity)))); 
    call res__vcc_alloc#3 := $alloc($array(^^u4, $rd_inv($s, Stack.capacity, $phys_ptr_cast(L#S, ^Stack))));
    assume $full_stop_ext(#tok$1^80.19, $s);
    assume $local_value_is($s, #tok$1^80.19, #loc.res__vcc_alloc#3, $ptr_to_int(res__vcc_alloc#3), ^^object);
    // assert @prim_writes_check((S->elements)); 
    assert $writable_prim($s, #wrTime$1^65.8, $dot($phys_ptr_cast(L#S, ^Stack), Stack.elements));
    // *(S->elements) := (uint32_t*)res__vcc_alloc#3; 
    call $write_int(Stack.elements, $phys_ptr_cast(L#S, ^Stack), $ptr_to_int($phys_ptr_cast(res__vcc_alloc#3, ^^u4)));
    assume $full_stop_ext(#tok$1^80.5, $s);
    // assert @reads_check_normal((S->elements)); 
    assert $thread_local($s, $phys_ptr_cast(L#S, ^Stack));
    assume true;
    // if (@_vcc_ptr_eq_null(*((S->elements)))) ...
    if ($is_null($rd_phys_ptr($s, Stack.elements, $phys_ptr_cast(L#S, ^Stack), ^^u4)))
    {
      anon21:
        // assert @writes_check(S); 
        assert $top_writable($s, #wrTime$1^65.8, $phys_ptr_cast(L#S, ^Stack));
        // assert @writes_check(@_vcc_extent(@state, S)); 
        assert (forall #writes$1^82.9: $ptr :: { $dont_instantiate(#writes$1^82.9) } $set_in(#writes$1^82.9, $extent($s, $phys_ptr_cast(L#S, ^Stack))) ==> $top_writable($s, #wrTime$1^65.8, #writes$1^82.9));
        // stmt _vcc_free(S); 
        call $free($phys_ptr_cast(L#S, ^Stack));
        assume $full_stop_ext(#tok$1^82.9, $s);
        // return (struct Stack*)@null; 
        $result := $phys_ptr_cast($null, ^Stack);
        assert $position_marker();
        goto #exit;
    }
    else
    {
      anon22:
        // empty
    }

  anon25:
    // assert @prim_writes_check((S->elementsAsArray)); 
    assert $writable_prim($s, #wrTime$1^65.8, $dot($phys_ptr_cast(L#S, ^Stack), Stack.elementsAsArray));
    // assert @reads_check_normal((S->elements)); 
    assert $thread_local($s, $phys_ptr_cast(L#S, ^Stack));
    // assert @reads_check_normal((S->capacity)); 
    assert $thread_local($s, $phys_ptr_cast(L#S, ^Stack));
    // *(S->elementsAsArray) := @_vcc_as_array(*((S->elements)), *((S->capacity))); 
    call $write_int(Stack.elementsAsArray, $phys_ptr_cast(L#S, ^Stack), $ptr_to_int($as_array($rd_phys_ptr($s, Stack.elements, $phys_ptr_cast(L#S, ^Stack), ^^u4), ^^u4, $rd_inv($s, Stack.capacity, $phys_ptr_cast(L#S, ^Stack)))));
    assume $full_stop_ext(#tok$1^87.9, $s);
    // struct AbsStack^ res__vcc_spec_alloc#4; 
    assume $local_value_is($s, #tok$1^88.18, #loc.res__vcc_spec_alloc#4, $ptr_to_int(res__vcc_spec_alloc#4), $spec_ptr_to(^AbsStack));
    // res__vcc_spec_alloc#4 := _vcc_spec_alloc<struct AbsStack>(); 
    call res__vcc_spec_alloc#4 := $spec_alloc(^AbsStack);
    assume $full_stop_ext(#tok$1^88.18, $s);
    assume $local_value_is($s, #tok$1^88.18, #loc.res__vcc_spec_alloc#4, $ptr_to_int(res__vcc_spec_alloc#4), $spec_ptr_to(^AbsStack));
    // assert @prim_writes_check((S->abs)); 
    assert $writable_prim($s, #wrTime$1^65.8, $dot($phys_ptr_cast(L#S, ^Stack), Stack.abs));
    // *(S->abs) := res__vcc_spec_alloc#4; 
    call $write_int(Stack.abs, $phys_ptr_cast(L#S, ^Stack), $ptr_to_int($spec_ptr_cast(res__vcc_spec_alloc#4, ^AbsStack)));
    assume $full_stop_ext(#tok$1^88.9, $s);
    // assert @prim_writes_check((*((S->abs))->high_mark)); 
    assert $writable_prim($s, #wrTime$1^65.8, $dot($rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(L#S, ^Stack), ^AbsStack), AbsStack.high_mark));
    // assert @reads_check_normal((S->abs)); 
    assert $thread_local($s, $phys_ptr_cast(L#S, ^Stack));
    // assert @reads_check_normal((S->topOfStack)); 
    assert $thread_local($s, $phys_ptr_cast(L#S, ^Stack));
    // *(*((S->abs))->high_mark) := *((S->topOfStack)); 
    call $write_int(AbsStack.high_mark, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(L#S, ^Stack), ^AbsStack), $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(L#S, ^Stack)));
    assume $full_stop_ext(#tok$1^89.9, $s);
    // assert @prim_writes_check((*((S->abs))->capacity)); 
    assert $writable_prim($s, #wrTime$1^65.8, $dot($rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(L#S, ^Stack), ^AbsStack), AbsStack.capacity));
    // assert @reads_check_normal((S->abs)); 
    assert $thread_local($s, $phys_ptr_cast(L#S, ^Stack));
    // assert @reads_check_normal((S->capacity)); 
    assert $thread_local($s, $phys_ptr_cast(L#S, ^Stack));
    // *(*((S->abs))->capacity) := *((S->capacity)); 
    call $write_int(AbsStack.capacity, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(L#S, ^Stack), ^AbsStack), $rd_inv($s, Stack.capacity, $phys_ptr_cast(L#S, ^Stack)));
    assume $full_stop_ext(#tok$1^90.9, $s);
    // _math state_t prestate#5; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#5, $state_to_int(prestate#5), ^$#state_t);
    // prestate#5 := @_vcc_current_state(@state); 
    prestate#5 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#5, $state_to_int(prestate#5), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(*((S->elementsAsArray))); 
    assert $top_writable($s, #wrTime$1^65.8, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(L#S, ^Stack))));
    // assert @writes_check(@_vcc_owns(@state, *((S->elementsAsArray)))); 
    assert (forall #writes$1^91.21: $ptr :: { $dont_instantiate(#writes$1^91.21) } $set_in(#writes$1^91.21, $owns($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(L#S, ^Stack))))) ==> $top_writable($s, #wrTime$1^65.8, #writes$1^91.21));
    // assert @reads_check_normal((S->elementsAsArray)); 
    assert $thread_local($s, $phys_ptr_cast(L#S, ^Stack));
    // stmt @_vcc_wrap(*((S->elementsAsArray)), @_vcc_typeof(*((S->elementsAsArray)))); 
    call $wrap($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(L#S, ^Stack))), $typ($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(L#S, ^Stack)))));
    assume $good_state_ext(#tok$1^91.21, $s);
    // assert @_vcc_inv2(prestate#5, @_vcc_current_state(@state), *((S->elementsAsArray))); 
    assert $inv2(prestate#5, $current_state($s), $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(L#S, ^Stack))), $typ($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(L#S, ^Stack)))));
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
    // assert @writes_check(*((S->abs))); 
    assert $top_writable($s, #wrTime$1^65.8, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(L#S, ^Stack), ^AbsStack));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(*((S->abs))), staticWrapState#6, owns#7)
    call $static_wrap($rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(L#S, ^Stack), ^AbsStack), staticWrapState#6, owns#7);
    assume $good_state_ext(#tok$1^92.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((S->abs))), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(L#S, ^Stack), ^AbsStack)), $set_empty());
    // assert @inv_check(<=(*((*((S->abs))->high_mark)), *((*((S->abs))->capacity)))); 
    assert $rd_inv($s, AbsStack.high_mark, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(L#S, ^Stack), ^AbsStack)) <= $rd_inv($s, AbsStack.capacity, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(L#S, ^Stack), ^AbsStack));
    // assert @inv_check(@_vcc_is_malloc_root(@state, *((S->abs)))); 
    assert $is_malloc_root($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(L#S, ^Stack), ^AbsStack));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#11; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#11, $state_to_int(prestate#11), ^$#state_t);
    // prestate#11 := @_vcc_current_state(@state); 
    prestate#11 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#11, $state_to_int(prestate#11), ^$#state_t);
    // _math state_t staticWrapState#9; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#9, $state_to_int(staticWrapState#9), ^$#state_t);
    // staticWrapState#9 := @_vcc_current_state(@state); 
    staticWrapState#9 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#9, $state_to_int(staticWrapState#9), ^$#state_t);
    // _math ptrset owns#10; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#10, $ptrset_to_int(owns#10), ^$#ptrset);
    // owns#10 := @_vcc_set_empty; 
    owns#10 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#10, $ptrset_to_int(owns#10), ^$#ptrset);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^65.8, $phys_ptr_cast(L#S, ^Stack));
    // assert @_vcc_wrapped(@state, *((S->elementsAsArray))); 
    assert $wrapped($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(L#S, ^Stack))), $typ($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(L#S, ^Stack)))));
    // assert @writes_check(*((S->elementsAsArray))); 
    assert $top_writable($s, #wrTime$1^65.8, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(L#S, ^Stack))));
    // owns#10 := pure(@_vcc_set_union(owns#10, @_vcc_set_singleton(*((S->elementsAsArray))))); 
    owns#10 := $set_union(owns#10, $set_singleton($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(L#S, ^Stack)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#10, $ptrset_to_int(owns#10), ^$#ptrset);
    // staticWrapState#9 := pure(@_vcc_take_over(staticWrapState#9, S, *((S->elementsAsArray)))); 
    staticWrapState#9 := $take_over(staticWrapState#9, $phys_ptr_cast(L#S, ^Stack), $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(L#S, ^Stack))));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#9, $state_to_int(staticWrapState#9), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((S->abs))); 
    assert $wrapped($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(L#S, ^Stack), ^AbsStack), ^AbsStack);
    // assert @writes_check(*((S->abs))); 
    assert $top_writable($s, #wrTime$1^65.8, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(L#S, ^Stack), ^AbsStack));
    // owns#10 := pure(@_vcc_set_union(owns#10, @_vcc_set_singleton(*((S->abs))))); 
    owns#10 := $set_union(owns#10, $set_singleton($rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(L#S, ^Stack), ^AbsStack)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#10, $ptrset_to_int(owns#10), ^$#ptrset);
    // staticWrapState#9 := pure(@_vcc_take_over(staticWrapState#9, S, *((S->abs)))); 
    staticWrapState#9 := $take_over(staticWrapState#9, $phys_ptr_cast(L#S, ^Stack), $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(L#S, ^Stack), ^AbsStack));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#9, $state_to_int(staticWrapState#9), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(S), staticWrapState#9, owns#10)
    call $static_wrap($phys_ptr_cast(L#S, ^Stack), staticWrapState#9, owns#10);
    assume $good_state_ext(#tok$1^93.21, $s);
    // assert @inv_check(==(*((S->elementsAsArray)), @_vcc_as_array(*((S->elements)), *((S->capacity))))); 
    assert $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(L#S, ^Stack))) == $as_array($rd_phys_ptr($s, Stack.elements, $phys_ptr_cast(L#S, ^Stack), ^^u4), ^^u4, $rd_inv($s, Stack.capacity, $phys_ptr_cast(L#S, ^Stack)));
    // assert @inv_check(@keeps_stable(old(prestate#11, *((S->abs))), *((S->abs)))); 
    assert $rd_spec_ptr(prestate#11, Stack.abs, $phys_ptr_cast(L#S, ^Stack), ^AbsStack) == $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(L#S, ^Stack), ^AbsStack);
    // assert @inv_check(@keeps(S, *((S->abs)))); 
    assert $keeps($s, $phys_ptr_cast(L#S, ^Stack), $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(L#S, ^Stack), ^AbsStack));
    // assert @inv_check(@keeps_stable(old(prestate#11, *((S->elementsAsArray))), *((S->elementsAsArray)))); 
    assert $int_to_ptr($rd_inv(prestate#11, Stack.elementsAsArray, $phys_ptr_cast(L#S, ^Stack))) == $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(L#S, ^Stack)));
    // assert @inv_check(@keeps(S, *((S->elementsAsArray)))); 
    assert $keeps($s, $phys_ptr_cast(L#S, ^Stack), $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(L#S, ^Stack))));
    // assert @inv_check(@_vcc_is_malloc_root(@state, S)); 
    assert $is_malloc_root($s, $phys_ptr_cast(L#S, ^Stack));
    // assert @inv_check(@_vcc_is_malloc_root(@state, *((S->elementsAsArray)))); 
    assert $is_malloc_root($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(L#S, ^Stack))));
    // assert @inv_check(<=(*((S->topOfStack)), *((S->capacity)))); 
    assert $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(L#S, ^Stack)) <= $rd_inv($s, Stack.capacity, $phys_ptr_cast(L#S, ^Stack));
    // assert @inv_check(AbstractionRelation(S)); 
    assert F#AbstractionRelation($s, $phys_ptr_cast(L#S, ^Stack));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return S; 
    $result := $phys_ptr_cast(L#S, ^Stack);
    assert $position_marker();
    goto #exit;

  anon26:
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
  var prestate#18: $state;
  var prestate#16: $state;
  var owns#17: $ptrset;
  var prestate#15: $state;
  var prestate#14: $state;
  var prestate#12: $state;
  var owns#13: $ptrset;
  var #wrTime$1^97.1: int;
  var #stackframe: int;

  anon27:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^97.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^97.1, #loc.S, $ptr_to_int(P#S), $ptr_to(^Stack));
    assume #wrTime$1^97.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^97.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#S, ^Stack)));
    assume $thread_owned($s, $phys_ptr_cast(P#S, ^Stack));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#S, ^Stack), $phys_ptr_cast(P#S, ^Stack), l#public);
    // assert @_vcc_in_domain(@state, *((S->elementsAsArray)), S); 
    assert $in_domain_lab($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))), $phys_ptr_cast(P#S, ^Stack), l#public);
    // assume @_vcc_in_domain(@state, *((S->elementsAsArray)), S); 
    assume $in_domain_lab($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))), $phys_ptr_cast(P#S, ^Stack), l#public);
    // _math ptrset owns#13; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#13, $ptrset_to_int(owns#13), ^$#ptrset);
    // owns#13 := @_vcc_set_empty; 
    owns#13 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#13, $ptrset_to_int(owns#13), ^$#ptrset);
    // _math state_t prestate#12; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#12, $state_to_int(prestate#12), ^$#state_t);
    // prestate#12 := @_vcc_current_state(@state); 
    prestate#12 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#12, $state_to_int(prestate#12), ^$#state_t);
    // _math state_t prestate#14; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#14, $state_to_int(prestate#14), ^$#state_t);
    // prestate#14 := @_vcc_current_state(@state); 
    prestate#14 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#14, $state_to_int(prestate#14), ^$#state_t);
    // assert @_vcc_wrapped(@state, S); 
    assert $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^97.1, $phys_ptr_cast(P#S, ^Stack));
    // assume @_vcc_inv(@state, S); 
    assume $inv($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // prestate#14 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#14, S, *((S->elementsAsArray)))); 
    prestate#14 := $release($current_state($s), prestate#14, $phys_ptr_cast(P#S, ^Stack), $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#14, $state_to_int(prestate#14), ^$#state_t);
    // owns#13 := pure(@_vcc_set_union(owns#13, @_vcc_set_singleton(*((S->elementsAsArray))))); 
    owns#13 := $set_union(owns#13, $set_singleton($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#13, $ptrset_to_int(owns#13), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((S->elementsAsArray)))); 
    assume $typed($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))));
    // prestate#14 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#14, S, *((S->abs)))); 
    prestate#14 := $release($current_state($s), prestate#14, $phys_ptr_cast(P#S, ^Stack), $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#14, $state_to_int(prestate#14), ^$#state_t);
    // owns#13 := pure(@_vcc_set_union(owns#13, @_vcc_set_singleton(*((S->abs))))); 
    owns#13 := $set_union(owns#13, $set_singleton($rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#13, $ptrset_to_int(owns#13), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((S->abs)))); 
    assume $typed($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assume ==(owns#13, @_vcc_owns(@state, S)); 
    assume owns#13 == $owns($s, $phys_ptr_cast(P#S, ^Stack));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(S), prestate#14)
    call $static_unwrap($phys_ptr_cast(P#S, ^Stack), prestate#14);
    assume $good_state_ext(#tok$1^102.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#15; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#15, $state_to_int(prestate#15), ^$#state_t);
    // prestate#15 := @_vcc_current_state(@state); 
    prestate#15 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#15, $state_to_int(prestate#15), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((S->elementsAsArray))); 
    assert $wrapped($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))), $typ($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack)))));
    // assume @_vcc_inv(@state, *((S->elementsAsArray))); 
    assume $inv($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))), $typ($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack)))));
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(*((S->elementsAsArray))); 
    assert $top_writable($s, #wrTime$1^97.1, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))));
    // assert @reads_check_normal((S->elementsAsArray)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // stmt @_vcc_unwrap(*((S->elementsAsArray)), @_vcc_typeof(*((S->elementsAsArray)))); 
    call $unwrap($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))), $typ($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack)))));
    assume $good_state_ext(#tok$1^103.21, $s);
    // assert @_vcc_inv2(prestate#15, @_vcc_current_state(@state), *((S->elementsAsArray))); 
    assert $inv2(prestate#15, $current_state($s), $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))), $typ($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack)))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @writes_check(@_vcc_as_array(*((S->elements)), *((S->capacity)))); 
    assert $top_writable($s, #wrTime$1^97.1, $as_array($rd_phys_ptr($s, Stack.elements, $phys_ptr_cast(P#S, ^Stack), ^^u4), ^^u4, $rd_inv($s, Stack.capacity, $phys_ptr_cast(P#S, ^Stack))));
    // assert @writes_check(@_vcc_extent(@state, @_vcc_as_array(*((S->elements)), *((S->capacity))))); 
    assert (forall #writes$1^104.5: $ptr :: { $dont_instantiate(#writes$1^104.5) } $set_in(#writes$1^104.5, $extent($s, $as_array($rd_phys_ptr($s, Stack.elements, $phys_ptr_cast(P#S, ^Stack), ^^u4), ^^u4, $rd_inv($s, Stack.capacity, $phys_ptr_cast(P#S, ^Stack))))) ==> $top_writable($s, #wrTime$1^97.1, #writes$1^104.5));
    // assert @reads_check_normal((S->elements)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // assert @reads_check_normal((S->capacity)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // stmt _vcc_free(@_vcc_as_array(*((S->elements)), *((S->capacity)))); 
    call $free($as_array($rd_phys_ptr($s, Stack.elements, $phys_ptr_cast(P#S, ^Stack), ^^u4), ^^u4, $rd_inv($s, Stack.capacity, $phys_ptr_cast(P#S, ^Stack))));
    assume $full_stop_ext(#tok$1^104.5, $s);
    // _math ptrset owns#17; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#17, $ptrset_to_int(owns#17), ^$#ptrset);
    // owns#17 := @_vcc_set_empty; 
    owns#17 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#17, $ptrset_to_int(owns#17), ^$#ptrset);
    // _math state_t prestate#16; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#16, $state_to_int(prestate#16), ^$#state_t);
    // prestate#16 := @_vcc_current_state(@state); 
    prestate#16 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#16, $state_to_int(prestate#16), ^$#state_t);
    // _math state_t prestate#18; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#18, $state_to_int(prestate#18), ^$#state_t);
    // prestate#18 := @_vcc_current_state(@state); 
    prestate#18 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#18, $state_to_int(prestate#18), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((S->abs))); 
    assert $wrapped($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), ^AbsStack);
    // assert @writes_check(*((S->abs))); 
    assert $top_writable($s, #wrTime$1^97.1, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assume @_vcc_inv(@state, *((S->abs))); 
    assume $inv($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), ^AbsStack);
    // assume ==(owns#17, @_vcc_owns(@state, *((S->abs)))); 
    assume owns#17 == $owns($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(*((S->abs))), prestate#18)
    call $static_unwrap($rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), prestate#18);
    assume $good_state_ext(#tok$1^105.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^97.1, $phys_ptr_cast(P#S, ^Stack));
    // assert @writes_check(@_vcc_extent(@state, S)); 
    assert (forall #writes$1^106.5: $ptr :: { $dont_instantiate(#writes$1^106.5) } $set_in(#writes$1^106.5, $extent($s, $phys_ptr_cast(P#S, ^Stack))) ==> $top_writable($s, #wrTime$1^97.1, #writes$1^106.5));
    // stmt _vcc_free(S); 
    call $free($phys_ptr_cast(P#S, ^Stack));
    assume $full_stop_ext(#tok$1^106.5, $s);
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
  var owns#29: $ptrset;
  var staticWrapState#28: $state;
  var prestate#30: $state;
  var owns#26: $ptrset;
  var staticWrapState#25: $state;
  var prestate#27: $state;
  var prestate#24: $state;
  var prestate#22: $state;
  var owns#23: $ptrset;
  var prestate#21: $state;
  var prestate#19: $state;
  var owns#20: $ptrset;
  var #wrTime$1^109.1: int;
  var #stackframe: int;

  anon28:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^109.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^109.1, #loc.S, $ptr_to_int(P#S), $ptr_to(^Stack));
    assume #wrTime$1^109.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^109.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#S, ^Stack)));
    assume $thread_owned($s, $phys_ptr_cast(P#S, ^Stack));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#S, ^Stack), $phys_ptr_cast(P#S, ^Stack), l#public);
    // _math ptrset owns#20; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#20, $ptrset_to_int(owns#20), ^$#ptrset);
    // owns#20 := @_vcc_set_empty; 
    owns#20 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#20, $ptrset_to_int(owns#20), ^$#ptrset);
    // _math state_t prestate#19; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#19, $state_to_int(prestate#19), ^$#state_t);
    // prestate#19 := @_vcc_current_state(@state); 
    prestate#19 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#19, $state_to_int(prestate#19), ^$#state_t);
    // _math state_t prestate#21; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#21, $state_to_int(prestate#21), ^$#state_t);
    // prestate#21 := @_vcc_current_state(@state); 
    prestate#21 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#21, $state_to_int(prestate#21), ^$#state_t);
    // assert @_vcc_wrapped(@state, S); 
    assert $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^109.1, $phys_ptr_cast(P#S, ^Stack));
    // assume @_vcc_inv(@state, S); 
    assume $inv($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // prestate#21 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#21, S, *((S->elementsAsArray)))); 
    prestate#21 := $release($current_state($s), prestate#21, $phys_ptr_cast(P#S, ^Stack), $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#21, $state_to_int(prestate#21), ^$#state_t);
    // owns#20 := pure(@_vcc_set_union(owns#20, @_vcc_set_singleton(*((S->elementsAsArray))))); 
    owns#20 := $set_union(owns#20, $set_singleton($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#20, $ptrset_to_int(owns#20), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((S->elementsAsArray)))); 
    assume $typed($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))));
    // prestate#21 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#21, S, *((S->abs)))); 
    prestate#21 := $release($current_state($s), prestate#21, $phys_ptr_cast(P#S, ^Stack), $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#21, $state_to_int(prestate#21), ^$#state_t);
    // owns#20 := pure(@_vcc_set_union(owns#20, @_vcc_set_singleton(*((S->abs))))); 
    owns#20 := $set_union(owns#20, $set_singleton($rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#20, $ptrset_to_int(owns#20), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((S->abs)))); 
    assume $typed($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assume ==(owns#20, @_vcc_owns(@state, S)); 
    assume owns#20 == $owns($s, $phys_ptr_cast(P#S, ^Stack));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(S), prestate#21)
    call $static_unwrap($phys_ptr_cast(P#S, ^Stack), prestate#21);
    assume $good_state_ext(#tok$1^114.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((S->topOfStack)); 
    assert $writable_prim($s, #wrTime$1^109.1, $dot($phys_ptr_cast(P#S, ^Stack), Stack.topOfStack));
    // *(S->topOfStack) := 0; 
    call $write_int(Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack), 0);
    assume $full_stop_ext(#tok$1^115.5, $s);
    // _math ptrset owns#23; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#23, $ptrset_to_int(owns#23), ^$#ptrset);
    // owns#23 := @_vcc_set_empty; 
    owns#23 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#23, $ptrset_to_int(owns#23), ^$#ptrset);
    // _math state_t prestate#22; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#22, $state_to_int(prestate#22), ^$#state_t);
    // prestate#22 := @_vcc_current_state(@state); 
    prestate#22 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#22, $state_to_int(prestate#22), ^$#state_t);
    // _math state_t prestate#24; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#24, $state_to_int(prestate#24), ^$#state_t);
    // prestate#24 := @_vcc_current_state(@state); 
    prestate#24 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#24, $state_to_int(prestate#24), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((S->abs))); 
    assert $wrapped($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), ^AbsStack);
    // assert @writes_check(*((S->abs))); 
    assert $top_writable($s, #wrTime$1^109.1, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assume @_vcc_inv(@state, *((S->abs))); 
    assume $inv($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), ^AbsStack);
    // assume ==(owns#23, @_vcc_owns(@state, *((S->abs)))); 
    assume owns#23 == $owns($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(*((S->abs))), prestate#24)
    call $static_unwrap($rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), prestate#24);
    assume $good_state_ext(#tok$1^116.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((*((S->abs))->high_mark)); 
    assert $writable_prim($s, #wrTime$1^109.1, $dot($rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), AbsStack.high_mark));
    // assert @reads_check_normal((S->abs)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // assert @reads_check_normal((S->topOfStack)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // *(*((S->abs))->high_mark) := *((S->topOfStack)); 
    call $write_int(AbsStack.high_mark, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)));
    assume $full_stop_ext(#tok$1^117.27, $s);
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
    // assert @writes_check(*((S->abs))); 
    assert $top_writable($s, #wrTime$1^109.1, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(*((S->abs))), staticWrapState#25, owns#26)
    call $static_wrap($rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), staticWrapState#25, owns#26);
    assume $good_state_ext(#tok$1^118.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((S->abs))), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)), $set_empty());
    // assert @inv_check(<=(*((*((S->abs))->high_mark)), *((*((S->abs))->capacity)))); 
    assert $rd_inv($s, AbsStack.high_mark, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)) <= $rd_inv($s, AbsStack.capacity, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assert @inv_check(@_vcc_is_malloc_root(@state, *((S->abs)))); 
    assert $is_malloc_root($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#30; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#30, $state_to_int(prestate#30), ^$#state_t);
    // prestate#30 := @_vcc_current_state(@state); 
    prestate#30 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#30, $state_to_int(prestate#30), ^$#state_t);
    // _math state_t staticWrapState#28; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#28, $state_to_int(staticWrapState#28), ^$#state_t);
    // staticWrapState#28 := @_vcc_current_state(@state); 
    staticWrapState#28 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#28, $state_to_int(staticWrapState#28), ^$#state_t);
    // _math ptrset owns#29; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#29, $ptrset_to_int(owns#29), ^$#ptrset);
    // owns#29 := @_vcc_set_empty; 
    owns#29 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#29, $ptrset_to_int(owns#29), ^$#ptrset);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^109.1, $phys_ptr_cast(P#S, ^Stack));
    // assert @_vcc_wrapped(@state, *((S->elementsAsArray))); 
    assert $wrapped($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))), $typ($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack)))));
    // assert @writes_check(*((S->elementsAsArray))); 
    assert $top_writable($s, #wrTime$1^109.1, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))));
    // owns#29 := pure(@_vcc_set_union(owns#29, @_vcc_set_singleton(*((S->elementsAsArray))))); 
    owns#29 := $set_union(owns#29, $set_singleton($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#29, $ptrset_to_int(owns#29), ^$#ptrset);
    // staticWrapState#28 := pure(@_vcc_take_over(staticWrapState#28, S, *((S->elementsAsArray)))); 
    staticWrapState#28 := $take_over(staticWrapState#28, $phys_ptr_cast(P#S, ^Stack), $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#28, $state_to_int(staticWrapState#28), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((S->abs))); 
    assert $wrapped($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), ^AbsStack);
    // assert @writes_check(*((S->abs))); 
    assert $top_writable($s, #wrTime$1^109.1, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // owns#29 := pure(@_vcc_set_union(owns#29, @_vcc_set_singleton(*((S->abs))))); 
    owns#29 := $set_union(owns#29, $set_singleton($rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#29, $ptrset_to_int(owns#29), ^$#ptrset);
    // staticWrapState#28 := pure(@_vcc_take_over(staticWrapState#28, S, *((S->abs)))); 
    staticWrapState#28 := $take_over(staticWrapState#28, $phys_ptr_cast(P#S, ^Stack), $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#28, $state_to_int(staticWrapState#28), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(S), staticWrapState#28, owns#29)
    call $static_wrap($phys_ptr_cast(P#S, ^Stack), staticWrapState#28, owns#29);
    assume $good_state_ext(#tok$1^119.21, $s);
    // assert @inv_check(==(*((S->elementsAsArray)), @_vcc_as_array(*((S->elements)), *((S->capacity))))); 
    assert $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))) == $as_array($rd_phys_ptr($s, Stack.elements, $phys_ptr_cast(P#S, ^Stack), ^^u4), ^^u4, $rd_inv($s, Stack.capacity, $phys_ptr_cast(P#S, ^Stack)));
    // assert @inv_check(@keeps_stable(old(prestate#30, *((S->abs))), *((S->abs)))); 
    assert $rd_spec_ptr(prestate#30, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack) == $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack);
    // assert @inv_check(@keeps(S, *((S->abs)))); 
    assert $keeps($s, $phys_ptr_cast(P#S, ^Stack), $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assert @inv_check(@keeps_stable(old(prestate#30, *((S->elementsAsArray))), *((S->elementsAsArray)))); 
    assert $int_to_ptr($rd_inv(prestate#30, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))) == $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack)));
    // assert @inv_check(@keeps(S, *((S->elementsAsArray)))); 
    assert $keeps($s, $phys_ptr_cast(P#S, ^Stack), $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))));
    // assert @inv_check(@_vcc_is_malloc_root(@state, S)); 
    assert $is_malloc_root($s, $phys_ptr_cast(P#S, ^Stack));
    // assert @inv_check(@_vcc_is_malloc_root(@state, *((S->elementsAsArray)))); 
    assert $is_malloc_root($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))));
    // assert @inv_check(<=(*((S->topOfStack)), *((S->capacity)))); 
    assert $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) <= $rd_inv($s, Stack.capacity, $phys_ptr_cast(P#S, ^Stack));
    // assert @inv_check(AbstractionRelation(S)); 
    assert F#AbstractionRelation($s, $phys_ptr_cast(P#S, ^Stack));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure Top(P#S: $ptr) returns ($result: int);
  requires $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
  requires !F#IsEmpty($s, $phys_ptr_cast(P#S, ^Stack));
  modifies $s, $cev_pc;
  free ensures $in_range_u4($result);
  ensures $result == $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rd_inv($s, AbsStack.entries, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack))), $rd_inv($s, AbsStack.high_mark, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)) - 1);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Top(P#S: $ptr) returns ($result: int)
{
  var #wrTime$1^122.1: int;
  var #stackframe: int;

  anon29:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^122.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^122.1, #loc.S, $ptr_to_int(P#S), $ptr_to(^Stack));
    assume #wrTime$1^122.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^122.1, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#S, ^Stack), $phys_ptr_cast(P#S, ^Stack), l#public);
    // assert @_vcc_in_domain(@state, *((S->elementsAsArray)), S); 
    assert $in_domain_lab($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))), $phys_ptr_cast(P#S, ^Stack), l#public);
    // assume @_vcc_in_domain(@state, *((S->elementsAsArray)), S); 
    assume $in_domain_lab($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))), $phys_ptr_cast(P#S, ^Stack), l#public);
    // assert @reads_check_normal(*((S->elements))[-(*((S->topOfStack)), 1)]); 
    assert $thread_local($s, $idx($rd_phys_ptr($s, Stack.elements, $phys_ptr_cast(P#S, ^Stack), ^^u4), $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) - 1));
    // assert @reads_check_normal((S->elements)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // assert @in_range_u4(-(*((S->topOfStack)), 1)); 
    assert $in_range_u4($rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) - 1);
    // assert @reads_check_normal((S->topOfStack)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // return *(*((S->elements))[-(*((S->topOfStack)), 1)]); 
    $result := $rd_inv($s, $field($idx($rd_phys_ptr($s, Stack.elements, $phys_ptr_cast(P#S, ^Stack), ^^u4), $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) - 1)), $emb0($idx($rd_phys_ptr($s, Stack.elements, $phys_ptr_cast(P#S, ^Stack), ^^u4), $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) - 1)));
    assert $position_marker();
    goto #exit;

  anon30:
    // empty

  #exit:
}



procedure Pop(P#S: $ptr);
  requires !F#IsEmpty($s, $phys_ptr_cast(P#S, ^Stack));
  requires $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
  modifies $s, $cev_pc;
  ensures !F#IsFull($s, $phys_ptr_cast(P#S, ^Stack));
  ensures $rd_inv($s, AbsStack.high_mark, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)) == $rd_inv(old($s), AbsStack.high_mark, $rd_spec_ptr(old($s), Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)) - 1;
  ensures (forall Q#idx$1^137.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rd_inv(old($s), AbsStack.entries, $rd_spec_ptr(old($s), Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack))), Q#idx$1^137.29#tc1) } { $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rd_inv($s, AbsStack.entries, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack))), Q#idx$1^137.29#tc1) } $in_range_u4(Q#idx$1^137.29#tc1) ==> Q#idx$1^137.29#tc1 < $rd_inv($s, AbsStack.high_mark, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)) ==> $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rd_inv(old($s), AbsStack.entries, $rd_spec_ptr(old($s), Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack))), Q#idx$1^137.29#tc1) == $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rd_inv($s, AbsStack.entries, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack))), Q#idx$1^137.29#tc1));
  ensures $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#S, ^Stack)));
  free ensures $call_transition(old($s), $s);



implementation Pop(P#S: $ptr)
{
  var owns#41: $ptrset;
  var staticWrapState#40: $state;
  var prestate#42: $state;
  var owns#38: $ptrset;
  var staticWrapState#37: $state;
  var prestate#39: $state;
  var prestate#36: $state;
  var prestate#34: $state;
  var owns#35: $ptrset;
  var prestate#33: $state;
  var prestate#31: $state;
  var owns#32: $ptrset;
  var #wrTime$1^131.1: int;
  var #stackframe: int;

  anon31:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^131.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^131.1, #loc.S, $ptr_to_int(P#S), $ptr_to(^Stack));
    assume #wrTime$1^131.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^131.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#S, ^Stack)));
    assume $thread_owned($s, $phys_ptr_cast(P#S, ^Stack));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#S, ^Stack), $phys_ptr_cast(P#S, ^Stack), l#public);
    // _math ptrset owns#32; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#32, $ptrset_to_int(owns#32), ^$#ptrset);
    // owns#32 := @_vcc_set_empty; 
    owns#32 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#32, $ptrset_to_int(owns#32), ^$#ptrset);
    // _math state_t prestate#31; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#31, $state_to_int(prestate#31), ^$#state_t);
    // prestate#31 := @_vcc_current_state(@state); 
    prestate#31 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#31, $state_to_int(prestate#31), ^$#state_t);
    // _math state_t prestate#33; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#33, $state_to_int(prestate#33), ^$#state_t);
    // prestate#33 := @_vcc_current_state(@state); 
    prestate#33 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#33, $state_to_int(prestate#33), ^$#state_t);
    // assert @_vcc_wrapped(@state, S); 
    assert $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^131.1, $phys_ptr_cast(P#S, ^Stack));
    // assume @_vcc_inv(@state, S); 
    assume $inv($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // prestate#33 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#33, S, *((S->elementsAsArray)))); 
    prestate#33 := $release($current_state($s), prestate#33, $phys_ptr_cast(P#S, ^Stack), $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#33, $state_to_int(prestate#33), ^$#state_t);
    // owns#32 := pure(@_vcc_set_union(owns#32, @_vcc_set_singleton(*((S->elementsAsArray))))); 
    owns#32 := $set_union(owns#32, $set_singleton($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#32, $ptrset_to_int(owns#32), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((S->elementsAsArray)))); 
    assume $typed($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))));
    // prestate#33 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#33, S, *((S->abs)))); 
    prestate#33 := $release($current_state($s), prestate#33, $phys_ptr_cast(P#S, ^Stack), $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#33, $state_to_int(prestate#33), ^$#state_t);
    // owns#32 := pure(@_vcc_set_union(owns#32, @_vcc_set_singleton(*((S->abs))))); 
    owns#32 := $set_union(owns#32, $set_singleton($rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#32, $ptrset_to_int(owns#32), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((S->abs)))); 
    assume $typed($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assume ==(owns#32, @_vcc_owns(@state, S)); 
    assume owns#32 == $owns($s, $phys_ptr_cast(P#S, ^Stack));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(S), prestate#33)
    call $static_unwrap($phys_ptr_cast(P#S, ^Stack), prestate#33);
    assume $good_state_ext(#tok$1^139.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((S->topOfStack)); 
    assert $writable_prim($s, #wrTime$1^131.1, $dot($phys_ptr_cast(P#S, ^Stack), Stack.topOfStack));
    // assert @in_range_u4(-(*((S->topOfStack)), 1)); 
    assert $in_range_u4($rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) - 1);
    // assert @reads_check_normal((S->topOfStack)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // *(S->topOfStack) := -(*((S->topOfStack)), 1); 
    call $write_int(Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack), $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) - 1);
    assume $full_stop_ext(#tok$1^140.5, $s);
    // _math ptrset owns#35; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#35, $ptrset_to_int(owns#35), ^$#ptrset);
    // owns#35 := @_vcc_set_empty; 
    owns#35 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#35, $ptrset_to_int(owns#35), ^$#ptrset);
    // _math state_t prestate#34; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#34, $state_to_int(prestate#34), ^$#state_t);
    // prestate#34 := @_vcc_current_state(@state); 
    prestate#34 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#34, $state_to_int(prestate#34), ^$#state_t);
    // _math state_t prestate#36; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#36, $state_to_int(prestate#36), ^$#state_t);
    // prestate#36 := @_vcc_current_state(@state); 
    prestate#36 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#36, $state_to_int(prestate#36), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((S->abs))); 
    assert $wrapped($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), ^AbsStack);
    // assert @writes_check(*((S->abs))); 
    assert $top_writable($s, #wrTime$1^131.1, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assume @_vcc_inv(@state, *((S->abs))); 
    assume $inv($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), ^AbsStack);
    // assume ==(owns#35, @_vcc_owns(@state, *((S->abs)))); 
    assume owns#35 == $owns($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(*((S->abs))), prestate#36)
    call $static_unwrap($rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), prestate#36);
    assume $good_state_ext(#tok$1^141.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((*((S->abs))->high_mark)); 
    assert $writable_prim($s, #wrTime$1^131.1, $dot($rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), AbsStack.high_mark));
    // assert @reads_check_normal((S->abs)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // assert @in_range_u4(-(*((*((S->abs))->high_mark)), 1)); 
    assert $in_range_u4($rd_inv($s, AbsStack.high_mark, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)) - 1);
    // assert @reads_check_normal((*((S->abs))->high_mark)); 
    assert $thread_local($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assert @reads_check_normal((S->abs)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // *(*((S->abs))->high_mark) := -(*((*((S->abs))->high_mark)), 1); 
    call $write_int(AbsStack.high_mark, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), $rd_inv($s, AbsStack.high_mark, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)) - 1);
    assume $full_stop_ext(#tok$1^142.27, $s);
    // _math state_t prestate#39; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#39, $state_to_int(prestate#39), ^$#state_t);
    // prestate#39 := @_vcc_current_state(@state); 
    prestate#39 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#39, $state_to_int(prestate#39), ^$#state_t);
    // _math state_t staticWrapState#37; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#37, $state_to_int(staticWrapState#37), ^$#state_t);
    // staticWrapState#37 := @_vcc_current_state(@state); 
    staticWrapState#37 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#37, $state_to_int(staticWrapState#37), ^$#state_t);
    // _math ptrset owns#38; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#38, $ptrset_to_int(owns#38), ^$#ptrset);
    // owns#38 := @_vcc_set_empty; 
    owns#38 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#38, $ptrset_to_int(owns#38), ^$#ptrset);
    // assert @writes_check(*((S->abs))); 
    assert $top_writable($s, #wrTime$1^131.1, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(*((S->abs))), staticWrapState#37, owns#38)
    call $static_wrap($rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), staticWrapState#37, owns#38);
    assume $good_state_ext(#tok$1^143.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((S->abs))), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)), $set_empty());
    // assert @inv_check(<=(*((*((S->abs))->high_mark)), *((*((S->abs))->capacity)))); 
    assert $rd_inv($s, AbsStack.high_mark, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)) <= $rd_inv($s, AbsStack.capacity, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assert @inv_check(@_vcc_is_malloc_root(@state, *((S->abs)))); 
    assert $is_malloc_root($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#42; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#42, $state_to_int(prestate#42), ^$#state_t);
    // prestate#42 := @_vcc_current_state(@state); 
    prestate#42 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#42, $state_to_int(prestate#42), ^$#state_t);
    // _math state_t staticWrapState#40; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#40, $state_to_int(staticWrapState#40), ^$#state_t);
    // staticWrapState#40 := @_vcc_current_state(@state); 
    staticWrapState#40 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#40, $state_to_int(staticWrapState#40), ^$#state_t);
    // _math ptrset owns#41; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#41, $ptrset_to_int(owns#41), ^$#ptrset);
    // owns#41 := @_vcc_set_empty; 
    owns#41 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#41, $ptrset_to_int(owns#41), ^$#ptrset);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^131.1, $phys_ptr_cast(P#S, ^Stack));
    // assert @_vcc_wrapped(@state, *((S->elementsAsArray))); 
    assert $wrapped($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))), $typ($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack)))));
    // assert @writes_check(*((S->elementsAsArray))); 
    assert $top_writable($s, #wrTime$1^131.1, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))));
    // owns#41 := pure(@_vcc_set_union(owns#41, @_vcc_set_singleton(*((S->elementsAsArray))))); 
    owns#41 := $set_union(owns#41, $set_singleton($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#41, $ptrset_to_int(owns#41), ^$#ptrset);
    // staticWrapState#40 := pure(@_vcc_take_over(staticWrapState#40, S, *((S->elementsAsArray)))); 
    staticWrapState#40 := $take_over(staticWrapState#40, $phys_ptr_cast(P#S, ^Stack), $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#40, $state_to_int(staticWrapState#40), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((S->abs))); 
    assert $wrapped($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), ^AbsStack);
    // assert @writes_check(*((S->abs))); 
    assert $top_writable($s, #wrTime$1^131.1, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // owns#41 := pure(@_vcc_set_union(owns#41, @_vcc_set_singleton(*((S->abs))))); 
    owns#41 := $set_union(owns#41, $set_singleton($rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#41, $ptrset_to_int(owns#41), ^$#ptrset);
    // staticWrapState#40 := pure(@_vcc_take_over(staticWrapState#40, S, *((S->abs)))); 
    staticWrapState#40 := $take_over(staticWrapState#40, $phys_ptr_cast(P#S, ^Stack), $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#40, $state_to_int(staticWrapState#40), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(S), staticWrapState#40, owns#41)
    call $static_wrap($phys_ptr_cast(P#S, ^Stack), staticWrapState#40, owns#41);
    assume $good_state_ext(#tok$1^144.21, $s);
    // assert @inv_check(==(*((S->elementsAsArray)), @_vcc_as_array(*((S->elements)), *((S->capacity))))); 
    assert $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))) == $as_array($rd_phys_ptr($s, Stack.elements, $phys_ptr_cast(P#S, ^Stack), ^^u4), ^^u4, $rd_inv($s, Stack.capacity, $phys_ptr_cast(P#S, ^Stack)));
    // assert @inv_check(@keeps_stable(old(prestate#42, *((S->abs))), *((S->abs)))); 
    assert $rd_spec_ptr(prestate#42, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack) == $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack);
    // assert @inv_check(@keeps(S, *((S->abs)))); 
    assert $keeps($s, $phys_ptr_cast(P#S, ^Stack), $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assert @inv_check(@keeps_stable(old(prestate#42, *((S->elementsAsArray))), *((S->elementsAsArray)))); 
    assert $int_to_ptr($rd_inv(prestate#42, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))) == $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack)));
    // assert @inv_check(@keeps(S, *((S->elementsAsArray)))); 
    assert $keeps($s, $phys_ptr_cast(P#S, ^Stack), $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))));
    // assert @inv_check(@_vcc_is_malloc_root(@state, S)); 
    assert $is_malloc_root($s, $phys_ptr_cast(P#S, ^Stack));
    // assert @inv_check(@_vcc_is_malloc_root(@state, *((S->elementsAsArray)))); 
    assert $is_malloc_root($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))));
    // assert @inv_check(<=(*((S->topOfStack)), *((S->capacity)))); 
    assert $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) <= $rd_inv($s, Stack.capacity, $phys_ptr_cast(P#S, ^Stack));
    // assert @inv_check(AbstractionRelation(S)); 
    assert F#AbstractionRelation($s, $phys_ptr_cast(P#S, ^Stack));
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
  ensures $rd_inv($s, AbsStack.high_mark, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)) == $rd_inv(old($s), AbsStack.high_mark, $rd_spec_ptr(old($s), Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)) + 1;
  ensures (forall Q#idx$1^153.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rd_inv(old($s), AbsStack.entries, $rd_spec_ptr(old($s), Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack))), Q#idx$1^153.29#tc1) } { $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rd_inv($s, AbsStack.entries, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack))), Q#idx$1^153.29#tc1) } $in_range_u4(Q#idx$1^153.29#tc1) ==> Q#idx$1^153.29#tc1 < $rd_inv(old($s), AbsStack.high_mark, $rd_spec_ptr(old($s), Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)) ==> $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rd_inv(old($s), AbsStack.entries, $rd_spec_ptr(old($s), Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack))), Q#idx$1^153.29#tc1) == $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rd_inv($s, AbsStack.entries, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack))), Q#idx$1^153.29#tc1));
  ensures $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rd_inv($s, AbsStack.entries, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack))), $rd_inv($s, AbsStack.high_mark, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)) - 1) == P#X;
  ensures $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#S, ^Stack)));
  free ensures $call_transition(old($s), $s);



implementation Push(P#S: $ptr, P#X: int)
{
  var owns#55: $ptrset;
  var staticWrapState#54: $state;
  var prestate#56: $state;
  var owns#52: $ptrset;
  var staticWrapState#51: $state;
  var prestate#53: $state;
  var assignOp#1: $ptr;
  var prestate#50: $state;
  var prestate#48: $state;
  var owns#49: $ptrset;
  var prestate#47: $state;
  var prestate#46: $state;
  var prestate#45: $state;
  var prestate#43: $state;
  var owns#44: $ptrset;
  var #wrTime$1^147.1: int;
  var #stackframe: int;

  anon32:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^147.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^147.1, #loc.S, $ptr_to_int(P#S), $ptr_to(^Stack));
    assume $local_value_is($s, #tok$1^147.1, #loc.X, P#X, ^^u4);
    assume #wrTime$1^147.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^147.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#S, ^Stack)));
    assume $thread_owned($s, $phys_ptr_cast(P#S, ^Stack));
    // assume true; 
    assume true;
    // assume @in_range_u4(X); 
    assume $in_range_u4(P#X);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#S, ^Stack), $phys_ptr_cast(P#S, ^Stack), l#public);
    // assert @_vcc_in_domain(@state, *((S->elementsAsArray)), S); 
    assert $in_domain_lab($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))), $phys_ptr_cast(P#S, ^Stack), l#public);
    // assume @_vcc_in_domain(@state, *((S->elementsAsArray)), S); 
    assume $in_domain_lab($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))), $phys_ptr_cast(P#S, ^Stack), l#public);
    // _math ptrset owns#44; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#44, $ptrset_to_int(owns#44), ^$#ptrset);
    // owns#44 := @_vcc_set_empty; 
    owns#44 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#44, $ptrset_to_int(owns#44), ^$#ptrset);
    // _math state_t prestate#43; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#43, $state_to_int(prestate#43), ^$#state_t);
    // prestate#43 := @_vcc_current_state(@state); 
    prestate#43 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#43, $state_to_int(prestate#43), ^$#state_t);
    // _math state_t prestate#45; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#45, $state_to_int(prestate#45), ^$#state_t);
    // prestate#45 := @_vcc_current_state(@state); 
    prestate#45 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#45, $state_to_int(prestate#45), ^$#state_t);
    // assert @_vcc_wrapped(@state, S); 
    assert $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^147.1, $phys_ptr_cast(P#S, ^Stack));
    // assume @_vcc_inv(@state, S); 
    assume $inv($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // prestate#45 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#45, S, *((S->elementsAsArray)))); 
    prestate#45 := $release($current_state($s), prestate#45, $phys_ptr_cast(P#S, ^Stack), $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#45, $state_to_int(prestate#45), ^$#state_t);
    // owns#44 := pure(@_vcc_set_union(owns#44, @_vcc_set_singleton(*((S->elementsAsArray))))); 
    owns#44 := $set_union(owns#44, $set_singleton($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#44, $ptrset_to_int(owns#44), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((S->elementsAsArray)))); 
    assume $typed($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))));
    // prestate#45 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#45, S, *((S->abs)))); 
    prestate#45 := $release($current_state($s), prestate#45, $phys_ptr_cast(P#S, ^Stack), $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#45, $state_to_int(prestate#45), ^$#state_t);
    // owns#44 := pure(@_vcc_set_union(owns#44, @_vcc_set_singleton(*((S->abs))))); 
    owns#44 := $set_union(owns#44, $set_singleton($rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#44, $ptrset_to_int(owns#44), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((S->abs)))); 
    assume $typed($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assume ==(owns#44, @_vcc_owns(@state, S)); 
    assume owns#44 == $owns($s, $phys_ptr_cast(P#S, ^Stack));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(S), prestate#45)
    call $static_unwrap($phys_ptr_cast(P#S, ^Stack), prestate#45);
    assume $good_state_ext(#tok$1^157.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#46; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#46, $state_to_int(prestate#46), ^$#state_t);
    // prestate#46 := @_vcc_current_state(@state); 
    prestate#46 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#46, $state_to_int(prestate#46), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((S->elementsAsArray))); 
    assert $wrapped($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))), $typ($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack)))));
    // assume @_vcc_inv(@state, *((S->elementsAsArray))); 
    assume $inv($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))), $typ($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack)))));
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(*((S->elementsAsArray))); 
    assert $top_writable($s, #wrTime$1^147.1, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))));
    // assert @reads_check_normal((S->elementsAsArray)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // stmt @_vcc_unwrap(*((S->elementsAsArray)), @_vcc_typeof(*((S->elementsAsArray)))); 
    call $unwrap($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))), $typ($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack)))));
    assume $good_state_ext(#tok$1^158.21, $s);
    // assert @_vcc_inv2(prestate#46, @_vcc_current_state(@state), *((S->elementsAsArray))); 
    assert $inv2(prestate#46, $current_state($s), $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))), $typ($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack)))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check(*((S->elements))[*((S->topOfStack))]); 
    assert $writable_prim($s, #wrTime$1^147.1, $idx($rd_phys_ptr($s, Stack.elements, $phys_ptr_cast(P#S, ^Stack), ^^u4), $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack))));
    // assert @reads_check_normal((S->elements)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // assert @reads_check_normal((S->topOfStack)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // **((S->elements))[*((S->topOfStack))] := X; 
    call $write_int($field($idx($rd_phys_ptr($s, Stack.elements, $phys_ptr_cast(P#S, ^Stack), ^^u4), $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)))), $emb0($idx($rd_phys_ptr($s, Stack.elements, $phys_ptr_cast(P#S, ^Stack), ^^u4), $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)))), P#X);
    assume $full_stop_ext(#tok$1^159.5, $s);
    // _math state_t prestate#47; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#47, $state_to_int(prestate#47), ^$#state_t);
    // prestate#47 := @_vcc_current_state(@state); 
    prestate#47 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#47, $state_to_int(prestate#47), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(*((S->elementsAsArray))); 
    assert $top_writable($s, #wrTime$1^147.1, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))));
    // assert @writes_check(@_vcc_owns(@state, *((S->elementsAsArray)))); 
    assert (forall #writes$1^160.21: $ptr :: { $dont_instantiate(#writes$1^160.21) } $set_in(#writes$1^160.21, $owns($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))))) ==> $top_writable($s, #wrTime$1^147.1, #writes$1^160.21));
    // assert @reads_check_normal((S->elementsAsArray)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // stmt @_vcc_wrap(*((S->elementsAsArray)), @_vcc_typeof(*((S->elementsAsArray)))); 
    call $wrap($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))), $typ($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack)))));
    assume $good_state_ext(#tok$1^160.21, $s);
    // assert @_vcc_inv2(prestate#47, @_vcc_current_state(@state), *((S->elementsAsArray))); 
    assert $inv2(prestate#47, $current_state($s), $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))), $typ($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack)))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((S->topOfStack)); 
    assert $writable_prim($s, #wrTime$1^147.1, $dot($phys_ptr_cast(P#S, ^Stack), Stack.topOfStack));
    // assert @in_range_u4(+(*((S->topOfStack)), 1)); 
    assert $in_range_u4($rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) + 1);
    // assert @reads_check_normal((S->topOfStack)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // *(S->topOfStack) := +(*((S->topOfStack)), 1); 
    call $write_int(Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack), $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) + 1);
    assume $full_stop_ext(#tok$1^161.5, $s);
    // _math ptrset owns#49; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#49, $ptrset_to_int(owns#49), ^$#ptrset);
    // owns#49 := @_vcc_set_empty; 
    owns#49 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#49, $ptrset_to_int(owns#49), ^$#ptrset);
    // _math state_t prestate#48; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#48, $state_to_int(prestate#48), ^$#state_t);
    // prestate#48 := @_vcc_current_state(@state); 
    prestate#48 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#48, $state_to_int(prestate#48), ^$#state_t);
    // _math state_t prestate#50; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#50, $state_to_int(prestate#50), ^$#state_t);
    // prestate#50 := @_vcc_current_state(@state); 
    prestate#50 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#50, $state_to_int(prestate#50), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((S->abs))); 
    assert $wrapped($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), ^AbsStack);
    // assert @writes_check(*((S->abs))); 
    assert $top_writable($s, #wrTime$1^147.1, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assume @_vcc_inv(@state, *((S->abs))); 
    assume $inv($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), ^AbsStack);
    // assume ==(owns#49, @_vcc_owns(@state, *((S->abs)))); 
    assume owns#49 == $owns($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(*((S->abs))), prestate#50)
    call $static_unwrap($rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), prestate#50);
    assume $good_state_ext(#tok$1^162.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // (uint32_t -> uint32_t)^ assignOp#1; 
    assume $local_value_is($s, #tok$2^0.0, #loc.assignOp#1, $ptr_to_int(assignOp#1), $spec_ptr_to($map_t(^^u4, ^^u4)));
    // assert @reads_check_normal((S->abs)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // assignOp#1 := (*((S->abs))->entries); 
    assignOp#1 := $dot($rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), AbsStack.entries);
    assume $local_value_is($s, #tok$2^0.0, #loc.assignOp#1, $ptr_to_int(assignOp#1), $spec_ptr_to($map_t(^^u4, ^^u4)));
    // assert @prim_writes_check(assignOp#1); 
    assert $writable_prim($s, #wrTime$1^147.1, $spec_ptr_cast(assignOp#1, $map_t(^^u4, ^^u4)));
    // assert @reads_check_normal(assignOp#1); 
    assert $thread_local($s, $spec_ptr_cast(assignOp#1, $map_t(^^u4, ^^u4)));
    // assert @reads_check_normal((*((S->abs))->high_mark)); 
    assert $thread_local($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assert @reads_check_normal((S->abs)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // *assignOp#1 := @map_updated(*(assignOp#1), *((*((S->abs))->high_mark)), X); 
    call $write_int($field($spec_ptr_cast(assignOp#1, $map_t(^^u4, ^^u4))), $emb0($spec_ptr_cast(assignOp#1, $map_t(^^u4, ^^u4))), $map_t..^^u4.^^u4_to_int($store.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rd_inv($s, $field($spec_ptr_cast(assignOp#1, $map_t(^^u4, ^^u4))), $emb0($spec_ptr_cast(assignOp#1, $map_t(^^u4, ^^u4))))), $rd_inv($s, AbsStack.high_mark, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)), P#X)));
    assume $full_stop_ext(#tok$1^164.9, $s);
    // assert @prim_writes_check((*((S->abs))->high_mark)); 
    assert $writable_prim($s, #wrTime$1^147.1, $dot($rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), AbsStack.high_mark));
    // assert @reads_check_normal((S->abs)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // assert @in_range_u4(+(*((*((S->abs))->high_mark)), 1)); 
    assert $in_range_u4($rd_inv($s, AbsStack.high_mark, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)) + 1);
    // assert @reads_check_normal((*((S->abs))->high_mark)); 
    assert $thread_local($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assert @reads_check_normal((S->abs)); 
    assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
    // *(*((S->abs))->high_mark) := +(*((*((S->abs))->high_mark)), 1); 
    call $write_int(AbsStack.high_mark, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), $rd_inv($s, AbsStack.high_mark, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)) + 1);
    assume $full_stop_ext(#tok$1^165.9, $s);
    // _math state_t prestate#53; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#53, $state_to_int(prestate#53), ^$#state_t);
    // prestate#53 := @_vcc_current_state(@state); 
    prestate#53 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#53, $state_to_int(prestate#53), ^$#state_t);
    // _math state_t staticWrapState#51; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#51, $state_to_int(staticWrapState#51), ^$#state_t);
    // staticWrapState#51 := @_vcc_current_state(@state); 
    staticWrapState#51 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#51, $state_to_int(staticWrapState#51), ^$#state_t);
    // _math ptrset owns#52; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#52, $ptrset_to_int(owns#52), ^$#ptrset);
    // owns#52 := @_vcc_set_empty; 
    owns#52 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#52, $ptrset_to_int(owns#52), ^$#ptrset);
    // assert @writes_check(*((S->abs))); 
    assert $top_writable($s, #wrTime$1^147.1, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(*((S->abs))), staticWrapState#51, owns#52)
    call $static_wrap($rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), staticWrapState#51, owns#52);
    assume $good_state_ext(#tok$1^167.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((S->abs))), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)), $set_empty());
    // assert @inv_check(<=(*((*((S->abs))->high_mark)), *((*((S->abs))->capacity)))); 
    assert $rd_inv($s, AbsStack.high_mark, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)) <= $rd_inv($s, AbsStack.capacity, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assert @inv_check(@_vcc_is_malloc_root(@state, *((S->abs)))); 
    assert $is_malloc_root($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#56; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#56, $state_to_int(prestate#56), ^$#state_t);
    // prestate#56 := @_vcc_current_state(@state); 
    prestate#56 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#56, $state_to_int(prestate#56), ^$#state_t);
    // _math state_t staticWrapState#54; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#54, $state_to_int(staticWrapState#54), ^$#state_t);
    // staticWrapState#54 := @_vcc_current_state(@state); 
    staticWrapState#54 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#54, $state_to_int(staticWrapState#54), ^$#state_t);
    // _math ptrset owns#55; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#55, $ptrset_to_int(owns#55), ^$#ptrset);
    // owns#55 := @_vcc_set_empty; 
    owns#55 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#55, $ptrset_to_int(owns#55), ^$#ptrset);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^147.1, $phys_ptr_cast(P#S, ^Stack));
    // assert @_vcc_wrapped(@state, *((S->elementsAsArray))); 
    assert $wrapped($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))), $typ($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack)))));
    // assert @writes_check(*((S->elementsAsArray))); 
    assert $top_writable($s, #wrTime$1^147.1, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))));
    // owns#55 := pure(@_vcc_set_union(owns#55, @_vcc_set_singleton(*((S->elementsAsArray))))); 
    owns#55 := $set_union(owns#55, $set_singleton($int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#55, $ptrset_to_int(owns#55), ^$#ptrset);
    // staticWrapState#54 := pure(@_vcc_take_over(staticWrapState#54, S, *((S->elementsAsArray)))); 
    staticWrapState#54 := $take_over(staticWrapState#54, $phys_ptr_cast(P#S, ^Stack), $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#54, $state_to_int(staticWrapState#54), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((S->abs))); 
    assert $wrapped($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), ^AbsStack);
    // assert @writes_check(*((S->abs))); 
    assert $top_writable($s, #wrTime$1^147.1, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // owns#55 := pure(@_vcc_set_union(owns#55, @_vcc_set_singleton(*((S->abs))))); 
    owns#55 := $set_union(owns#55, $set_singleton($rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#55, $ptrset_to_int(owns#55), ^$#ptrset);
    // staticWrapState#54 := pure(@_vcc_take_over(staticWrapState#54, S, *((S->abs)))); 
    staticWrapState#54 := $take_over(staticWrapState#54, $phys_ptr_cast(P#S, ^Stack), $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#54, $state_to_int(staticWrapState#54), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(S), staticWrapState#54, owns#55)
    call $static_wrap($phys_ptr_cast(P#S, ^Stack), staticWrapState#54, owns#55);
    assume $good_state_ext(#tok$1^168.21, $s);
    // assert @inv_check(==(*((S->elementsAsArray)), @_vcc_as_array(*((S->elements)), *((S->capacity))))); 
    assert $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))) == $as_array($rd_phys_ptr($s, Stack.elements, $phys_ptr_cast(P#S, ^Stack), ^^u4), ^^u4, $rd_inv($s, Stack.capacity, $phys_ptr_cast(P#S, ^Stack)));
    // assert @inv_check(@keeps_stable(old(prestate#56, *((S->abs))), *((S->abs)))); 
    assert $rd_spec_ptr(prestate#56, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack) == $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack);
    // assert @inv_check(@keeps(S, *((S->abs)))); 
    assert $keeps($s, $phys_ptr_cast(P#S, ^Stack), $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack));
    // assert @inv_check(@keeps_stable(old(prestate#56, *((S->elementsAsArray))), *((S->elementsAsArray)))); 
    assert $int_to_ptr($rd_inv(prestate#56, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))) == $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack)));
    // assert @inv_check(@keeps(S, *((S->elementsAsArray)))); 
    assert $keeps($s, $phys_ptr_cast(P#S, ^Stack), $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))));
    // assert @inv_check(@_vcc_is_malloc_root(@state, S)); 
    assert $is_malloc_root($s, $phys_ptr_cast(P#S, ^Stack));
    // assert @inv_check(@_vcc_is_malloc_root(@state, *((S->elementsAsArray)))); 
    assert $is_malloc_root($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))));
    // assert @inv_check(<=(*((S->topOfStack)), *((S->capacity)))); 
    assert $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)) <= $rd_inv($s, Stack.capacity, $phys_ptr_cast(P#S, ^Stack));
    // assert @inv_check(AbstractionRelation(S)); 
    assert F#AbstractionRelation($s, $phys_ptr_cast(P#S, ^Stack));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



function F#IsIn(#s: $state, P#S: $ptr, P#value: int) : bool;

const unique cf#IsIn: $pure_function;

axiom (forall #s: $state, P#S: $ptr, P#value: int :: { F#IsIn(#s, P#S, P#value) } $wrapped(#s, $phys_ptr_cast(P#S, ^Stack), ^Stack) ==> F#IsIn(#s, P#S, P#value) == (exists Q#v$1^175.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rd_inv(#s, AbsStack.entries, $rd_spec_ptr(#s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack))), Q#v$1^175.29#tc1) } $in_range_u4(Q#v$1^175.29#tc1) && Q#v$1^175.29#tc1 < $rd_inv(#s, AbsStack.high_mark, $rd_spec_ptr(#s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)) && $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rd_inv(#s, AbsStack.entries, $rd_spec_ptr(#s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack))), Q#v$1^175.29#tc1) == P#value));

axiom $function_arg_type(cf#IsIn, 0, ^^bool);

axiom $function_arg_type(cf#IsIn, 1, $ptr_to(^Stack));

axiom $function_arg_type(cf#IsIn, 2, ^^u4);

procedure IsIn(P#S: $ptr, P#value: int) returns ($result: bool);
  requires $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
  ensures $result == (exists Q#v$1^175.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rd_inv($s, AbsStack.entries, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack))), Q#v$1^175.29#tc1) } $in_range_u4(Q#v$1^175.29#tc1) && Q#v$1^175.29#tc1 < $rd_inv($s, AbsStack.high_mark, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack)) && $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rd_inv($s, AbsStack.entries, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack))), Q#v$1^175.29#tc1) == P#value);
  free ensures $result == F#IsIn($s, P#S, P#value);
  free ensures $call_transition(old($s), $s);



implementation IsIn(P#S: $ptr, P#value: int) returns ($result: bool)
{
  var loopState#0: $state;
  var L#index: int where $in_range_u4(L#index);
  var #wrTime$1^171.17: int;
  var #stackframe: int;

  anon38:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^171.17, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^171.17, #loc.S, $ptr_to_int(P#S), $ptr_to(^Stack));
    assume $local_value_is($s, #tok$1^171.17, #loc.value, P#value, ^^u4);
    assume #wrTime$1^171.17 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^171.17, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @in_range_u4(value); 
    assume $in_range_u4(P#value);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#S, ^Stack), $phys_ptr_cast(P#S, ^Stack), l#public);
    // uint32_t index; 
    assume $local_value_is($s, #tok$1^177.5, #loc.index, L#index, ^^u4);
    // var uint32_t index
    // assert @_vcc_in_domain(@state, *((S->elementsAsArray)), S); 
    assert $in_domain_lab($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))), $phys_ptr_cast(P#S, ^Stack), l#public);
    // assume @_vcc_in_domain(@state, *((S->elementsAsArray)), S); 
    assume $in_domain_lab($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))), $phys_ptr_cast(P#S, ^Stack), l#public);
    // assert @_vcc_in_domain(@state, *((S->abs)), S); 
    assert $in_domain_lab($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), $phys_ptr_cast(P#S, ^Stack), l#public);
    // assume @_vcc_in_domain(@state, *((S->abs)), S); 
    assume $in_domain_lab($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), $phys_ptr_cast(P#S, ^Stack), l#public);
    // index := 0; 
    L#index := 0;
    assume $local_value_is($s, #tok$1^182.10, #loc.index, L#index, ^^u4);
    loopState#0 := $s;
    while (true)
      invariant (forall Q#v$1^183.35#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rd_inv($s, AbsStack.entries, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack))), Q#v$1^183.35#tc1) } $in_range_u4(Q#v$1^183.35#tc1) ==> Q#v$1^183.35#tc1 < L#index ==> $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rd_inv($s, AbsStack.entries, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack))), Q#v$1^183.35#tc1) != P#value);
    {
      anon37:
        assume $writes_nothing(old($s), $s);
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$1^182.5, $s);
        assume $local_value_is($s, #tok$1^182.5, #loc.index, L#index, ^^u4);
        assume $local_value_is($s, #tok$1^182.5, #loc.value, P#value, ^^u4);
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#0, $s);
        // assert @reads_check_normal((S->topOfStack)); 
        assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
        assume true;
        // if (<(index, *((S->topOfStack)))) ...
        if (L#index < $rd_inv($s, Stack.topOfStack, $phys_ptr_cast(P#S, ^Stack)))
        {
          anon35:
            // assert @reads_check_normal(*((S->elements))[index]); 
            assert $thread_local($s, $idx($rd_phys_ptr($s, Stack.elements, $phys_ptr_cast(P#S, ^Stack), ^^u4), L#index));
            // assert @reads_check_normal((S->elements)); 
            assert $thread_local($s, $phys_ptr_cast(P#S, ^Stack));
            assume true;
            // if (==(*(*((S->elements))[index]), value)) ...
            if ($rd_inv($s, $field($idx($rd_phys_ptr($s, Stack.elements, $phys_ptr_cast(P#S, ^Stack), ^^u4), L#index)), $emb0($idx($rd_phys_ptr($s, Stack.elements, $phys_ptr_cast(P#S, ^Stack), ^^u4), L#index))) == P#value)
            {
              anon33:
                // assert ==(@map_get(*((*((S->abs))->entries)), index), value); 
                assert $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rd_inv($s, AbsStack.entries, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack))), L#index) == P#value;
                // assume ==(@map_get(*((*((S->abs))->entries)), index), value); 
                assume $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rd_inv($s, AbsStack.entries, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack))), L#index) == P#value;
                // return true; 
                $result := true;
                assert $position_marker();
                goto #exit;
            }
            else
            {
              anon34:
                // empty
            }
        }
        else
        {
          anon36:
            // goto #break_2; 
            goto #break_2;
        }

      #continue_2:
        // assert @in_range_u4(+(index, 1)); 
        assert $in_range_u4(L#index + 1);
        // index := +(index, 1); 
        L#index := L#index + 1;
        assume $local_value_is($s, #tok$1^182.44, #loc.index, L#index, ^^u4);
        assume true;
    }

  anon39:
    assume $full_stop_ext(#tok$1^182.5, $s);

  #break_2:
    // return false; 
    $result := false;
    assert $position_marker();
    goto #exit;

  anon40:
    // empty

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
  var #wrTime$1^49.17: int;
  var #stackframe: int;

  anon41:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^49.17, $s);
    assume $local_value_is($s, #tok$1^49.17, #loc.S, $ptr_to_int(P#S), $ptr_to(^Stack));
    assume #wrTime$1^49.17 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^49.17, (lambda #p: $ptr :: false));
    // assume @_vcc_wrapped(@state, S); 
    assume $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // assume @_vcc_in_domain(@state, S, S); 
    assume $in_domain_lab($s, $phys_ptr_cast(P#S, ^Stack), $phys_ptr_cast(P#S, ^Stack), l#public);
    // assume @_vcc_in_domain(@state, *((S->elementsAsArray)), S); 
    assume $in_domain_lab($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))), $phys_ptr_cast(P#S, ^Stack), l#public);
    // assume @_vcc_in_domain(@state, *((S->abs)), S); 
    assume $in_domain_lab($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), $phys_ptr_cast(P#S, ^Stack), l#public);
    // @_vcc_reads_havoc
    call $reads_havoc();
    assume $full_stop_ext(#tok$1^49.17, $s);
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
  var #wrTime$1^40.17: int;
  var #stackframe: int;

  anon42:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^40.17, $s);
    assume $local_value_is($s, #tok$1^40.17, #loc.S, $ptr_to_int(P#S), $ptr_to(^Stack));
    assume #wrTime$1^40.17 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^40.17, (lambda #p: $ptr :: false));
    // assume @_vcc_wrapped(@state, S); 
    assume $wrapped($s, $phys_ptr_cast(P#S, ^Stack), ^Stack);
    // assume @_vcc_in_domain(@state, S, S); 
    assume $in_domain_lab($s, $phys_ptr_cast(P#S, ^Stack), $phys_ptr_cast(P#S, ^Stack), l#public);
    // assume @_vcc_in_domain(@state, *((S->elementsAsArray)), S); 
    assume $in_domain_lab($s, $int_to_ptr($rd_inv($s, Stack.elementsAsArray, $phys_ptr_cast(P#S, ^Stack))), $phys_ptr_cast(P#S, ^Stack), l#public);
    // assume @_vcc_in_domain(@state, *((S->abs)), S); 
    assume $in_domain_lab($s, $rd_spec_ptr($s, Stack.abs, $phys_ptr_cast(P#S, ^Stack), ^AbsStack), $phys_ptr_cast(P#S, ^Stack), l#public);
    // @_vcc_reads_havoc
    call $reads_havoc();
    assume $full_stop_ext(#tok$1^40.17, $s);
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

const unique #tok$1^182.44: $token;

const unique #tok$1^182.5: $token;

const unique #tok$1^182.10: $token;

const unique #loc.index: $token;

const unique #tok$1^177.5: $token;

const unique #loc.value: $token;

const unique #tok$1^171.17: $token;

const unique #tok$1^168.21: $token;

const unique #loc.owns#55: $token;

const unique #loc.staticWrapState#54: $token;

const unique #loc.prestate#56: $token;

const unique #tok$1^167.21: $token;

const unique #loc.owns#52: $token;

const unique #loc.staticWrapState#51: $token;

const unique #loc.prestate#53: $token;

const unique #tok$1^165.9: $token;

const unique #tok$1^164.9: $token;

const unique #distTp5: $ctype;

axiom #distTp5 == $spec_ptr_to($map_t(^^u4, ^^u4));

const unique #loc.assignOp#1: $token;

const unique #tok$1^162.21: $token;

const unique #loc.prestate#50: $token;

const unique #loc.prestate#48: $token;

const unique #loc.owns#49: $token;

const unique #tok$1^161.5: $token;

const unique #tok$1^160.21: $token;

const unique #loc.prestate#47: $token;

const unique #tok$1^159.5: $token;

const unique #tok$1^158.21: $token;

const unique #loc.prestate#46: $token;

const unique #tok$1^157.21: $token;

const unique #loc.prestate#45: $token;

const unique #loc.prestate#43: $token;

const unique #loc.owns#44: $token;

const unique #loc.X: $token;

const unique #tok$1^147.1: $token;

const unique #tok$1^144.21: $token;

const unique #loc.owns#41: $token;

const unique #loc.staticWrapState#40: $token;

const unique #loc.prestate#42: $token;

const unique #tok$1^143.21: $token;

const unique #loc.owns#38: $token;

const unique #loc.staticWrapState#37: $token;

const unique #loc.prestate#39: $token;

const unique #tok$1^142.27: $token;

const unique #tok$1^141.21: $token;

const unique #loc.prestate#36: $token;

const unique #loc.prestate#34: $token;

const unique #loc.owns#35: $token;

const unique #tok$1^140.5: $token;

const unique #tok$1^139.21: $token;

const unique #loc.prestate#33: $token;

const unique #loc.prestate#31: $token;

const unique #loc.owns#32: $token;

const unique #tok$1^131.1: $token;

const unique #tok$1^122.1: $token;

const unique #tok$1^119.21: $token;

const unique #loc.owns#29: $token;

const unique #loc.staticWrapState#28: $token;

const unique #loc.prestate#30: $token;

const unique #tok$1^118.21: $token;

const unique #loc.owns#26: $token;

const unique #loc.staticWrapState#25: $token;

const unique #loc.prestate#27: $token;

const unique #tok$1^117.27: $token;

const unique #tok$1^116.21: $token;

const unique #loc.prestate#24: $token;

const unique #loc.prestate#22: $token;

const unique #loc.owns#23: $token;

const unique #tok$1^115.5: $token;

const unique #tok$1^114.21: $token;

const unique #loc.prestate#21: $token;

const unique #loc.prestate#19: $token;

const unique #loc.owns#20: $token;

const unique #tok$1^109.1: $token;

const unique #tok$1^106.5: $token;

const unique #tok$1^105.21: $token;

const unique #loc.prestate#18: $token;

const unique #loc.prestate#16: $token;

const unique #loc.owns#17: $token;

const unique #tok$1^104.5: $token;

const unique #tok$1^103.21: $token;

const unique #loc.prestate#15: $token;

const unique #tok$1^102.21: $token;

const unique #loc.prestate#14: $token;

const unique #loc.prestate#12: $token;

const unique #loc.owns#13: $token;

const unique #tok$1^97.1: $token;

const unique #tok$1^93.21: $token;

const unique #loc.owns#10: $token;

const unique #loc.staticWrapState#9: $token;

const unique #loc.prestate#11: $token;

const unique #tok$1^92.21: $token;

const unique #loc.owns#7: $token;

const unique #loc.staticWrapState#6: $token;

const unique #loc.prestate#8: $token;

const unique #tok$1^91.21: $token;

function $state_to_int(x: $state) : int;

function $int_to_state(x: int) : $state;

axiom (forall #x: $state :: #x == $int_to_state($state_to_int(#x)));

const unique #loc.prestate#5: $token;

const unique #tok$2^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(2, #file^?3Cno?20file?3E);

const unique #tok$1^90.9: $token;

const unique #tok$1^89.9: $token;

const unique #tok$1^88.9: $token;

const unique #loc.res__vcc_spec_alloc#4: $token;

const unique #tok$1^88.18: $token;

const unique #tok$1^87.9: $token;

const unique #tok$1^82.9: $token;

const unique #tok$1^80.5: $token;

const unique #loc.res__vcc_alloc#3: $token;

const unique #tok$1^80.19: $token;

const unique #tok$1^79.5: $token;

const unique #tok$1^78.5: $token;

const unique #tok$1^75.9: $token;

const unique #tok$1^73.12: $token;

const unique #loc.max_capacity: $token;

const unique #tok$1^65.8: $token;

const unique #tok$1^58.1: $token;

const unique #tok$1^49.17: $token;

const unique #loc.S: $token;

const unique #tok$1^40.17: $token;

const unique #loc.stack: $token;

const unique #tok$1^32.39: $token;

function $map_t..^^u4.^^u4_to_int(x: $map_t..^^u4.^^u4) : int;

function $int_to_map_t..^^u4.^^u4(x: int) : $map_t..^^u4.^^u4;

axiom (forall #x: $map_t..^^u4.^^u4 :: #x == $int_to_map_t..^^u4.^^u4($map_t..^^u4.^^u4_to_int(#x)));

axiom $type_code_is(1, ^^u4);

const unique #distTp4: $ctype;

axiom #distTp4 == $ptr_to(^Stack);

const unique #tok$1^16.1: $token;

const unique #distTp3: $ctype;

axiom #distTp3 == $ptr_to(^^u4);

const unique #distTp2: $ctype;

axiom #distTp2 == $spec_ptr_to(^AbsStack);

const unique #loc._this_: $token;

const unique #tok$1^7.23: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CStackAsArray.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CStackAsArray.c);

const unique #distTp1: $ctype;

axiom #distTp1 == $map_t(^^u4, ^^u4);
