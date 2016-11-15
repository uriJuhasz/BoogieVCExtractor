axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^AbsStack: $ctype;

axiom $is_composite(^AbsStack);

axiom $ptr_level(^AbsStack) == 0;

axiom $sizeof(^AbsStack) == 1;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^AbsStack) } $inv2(#s1, #s2, #p, ^AbsStack) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty()) && $mem(#s2, $dot(#p, AbsStack.high_mark)) <= $mem(#s2, $dot(#p, AbsStack.capacity)) && $is_malloc_root(#s2, #p)));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^AbsStack, #r), l#public) } $inv_lab(#s2, $ptr(^AbsStack, #r), l#public) == ($typed(#s2, $ptr(^AbsStack, #r)) && $set_eq($owns(#s2, $ptr(^AbsStack, #r)), $set_empty()) && $mem(#s2, $dot($ptr(^AbsStack, #r), AbsStack.high_mark)) <= $mem(#s2, $dot($ptr(^AbsStack, #r), AbsStack.capacity)) && $is_malloc_root(#s2, $ptr(^AbsStack, #r))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^AbsStack, #r)) } $in_full_extent_of(#q, $ptr(^AbsStack, #r)) == (#q == $ptr(^AbsStack, #r) || #q == $dot($ptr(^AbsStack, #r), AbsStack.$owns) || #q == $dot($ptr(^AbsStack, #r), AbsStack.high_mark) || #q == $dot($ptr(^AbsStack, #r), AbsStack.capacity) || #q == $dot($ptr(^AbsStack, #r), AbsStack.entries)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^AbsStack, #r)) } $in_extent_of(#s, #q, $ptr(^AbsStack, #r)) == $in_struct_extent_of(#q, $ptr(^AbsStack, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^AbsStack, #r)) } $typed(#s, $ptr(^AbsStack, #r)) ==> $in_extent_of(#s, #q, $ptr(^AbsStack, #r)) == (#q == $ptr(^AbsStack, #r) || $emb(#s, #q) == $ptr(^AbsStack, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^AbsStack, #r)) } $in_span_of(#q, $ptr(^AbsStack, #r)) == (#q == $ptr(^AbsStack, #r) || #q == $dot($ptr(^AbsStack, #r), AbsStack.$owns) || #q == $dot($ptr(^AbsStack, #r), AbsStack.high_mark) || #q == $dot($ptr(^AbsStack, #r), AbsStack.capacity) || #q == $dot($ptr(^AbsStack, #r), AbsStack.entries)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^AbsStack) } $state_spans_the_same(#s1, #s2, #p, ^AbsStack) == ($mem_eq(#s1, #s2, $dot(#p, AbsStack.$owns)) && $mem_eq(#s1, #s2, $dot(#p, AbsStack.high_mark)) && $mem_eq(#s1, #s2, $dot(#p, AbsStack.capacity)) && $mem_eq(#s1, #s2, $dot(#p, AbsStack.entries))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^AbsStack) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^AbsStack) == ($mem_eq(#s1, #s2, $dot(#p, AbsStack.$owns)) && $mem_eq(#s1, #s2, $dot(#p, AbsStack.high_mark)) && $mem_eq(#s1, #s2, $dot(#p, AbsStack.capacity)) && $mem_eq(#s1, #s2, $dot(#p, AbsStack.entries))));

axiom $is_claimable(^AbsStack) == false;

axiom $has_volatile_owns_set(^AbsStack) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^AbsStack, #r)) } $extent_mutable(#s1, $ptr(^AbsStack, #r)) == $mutable(#s1, $ptr(^AbsStack, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^AbsStack, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^AbsStack, #r)) == $is_fresh(#s1, #s2, $ptr(^AbsStack, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^AbsStack, #r)) } $extent_zero(#s1, $ptr(^AbsStack, #r)) == ($mem(#s1, $dot($ptr(^AbsStack, #r), AbsStack.high_mark)) == 0 && $mem(#s1, $dot($ptr(^AbsStack, #r), AbsStack.capacity)) == 0 && $mem(#s1, $dot($ptr(^AbsStack, #r), AbsStack.entries)) == 0));

const unique AbsStack.$owns: $field;

axiom $static_field_properties(AbsStack.$owns, ^AbsStack);

axiom $is_primitive_non_volatile_field(AbsStack.$owns);

axiom (forall #p: $ptr :: { $dot(#p, AbsStack.$owns) } $is(#p, ^AbsStack) ==> $dot(#p, AbsStack.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, AbsStack.$owns)) && $extent_hint($dot(#p, AbsStack.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, AbsStack.$owns)) } { $st(#s, $dot(#p, AbsStack.$owns)) } $typed2(#s, #p, ^AbsStack) ==> $field_properties(#s, #p, AbsStack.$owns, ^$#ptrset, false));

axiom $owns_set_field(^AbsStack) == AbsStack.$owns;

const unique AbsStack.high_mark: $field;

axiom $static_field_properties(AbsStack.high_mark, ^AbsStack);

axiom $is_primitive_non_volatile_field(AbsStack.high_mark);

axiom (forall #p: $ptr :: { $dot(#p, AbsStack.high_mark) } $is(#p, ^AbsStack) ==> $dot(#p, AbsStack.high_mark) == $ptr(^^u4, $ghost_ref(#p, AbsStack.high_mark)) && $extent_hint($dot(#p, AbsStack.high_mark), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, AbsStack.high_mark)) } { $st(#s, $dot(#p, AbsStack.high_mark)) } $typed2(#s, #p, ^AbsStack) ==> $field_properties(#s, #p, AbsStack.high_mark, ^^u4, false));

const unique AbsStack.capacity: $field;

axiom $static_field_properties(AbsStack.capacity, ^AbsStack);

axiom $is_primitive_non_volatile_field(AbsStack.capacity);

axiom (forall #p: $ptr :: { $dot(#p, AbsStack.capacity) } $is(#p, ^AbsStack) ==> $dot(#p, AbsStack.capacity) == $ptr(^^u4, $ghost_ref(#p, AbsStack.capacity)) && $extent_hint($dot(#p, AbsStack.capacity), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, AbsStack.capacity)) } { $st(#s, $dot(#p, AbsStack.capacity)) } $typed2(#s, #p, ^AbsStack) ==> $field_properties(#s, #p, AbsStack.capacity, ^^u4, false));

const unique AbsStack.entries: $field;

axiom $static_field_properties(AbsStack.entries, ^AbsStack);

axiom $is_primitive_non_volatile_field(AbsStack.entries);

axiom (forall #p: $ptr :: { $dot(#p, AbsStack.entries) } $is(#p, ^AbsStack) ==> $dot(#p, AbsStack.entries) == $ptr($map_t(^^u4, ^^u4), $ghost_ref(#p, AbsStack.entries)) && $extent_hint($dot(#p, AbsStack.entries), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, AbsStack.entries)) } { $st(#s, $dot(#p, AbsStack.entries)) } $typed2(#s, #p, ^AbsStack) ==> $field_properties(#s, #p, AbsStack.entries, $map_t(^^u4, ^^u4), false));

procedure AbsStack#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $set_eq($owns($s, $ptr(^AbsStack, P#_this_)), $set_empty());
  ensures $is_admissibility_check() ==> $mem($s, $dot($ptr(^AbsStack, P#_this_), AbsStack.high_mark)) <= $mem($s, $dot($ptr(^AbsStack, P#_this_), AbsStack.capacity));
  ensures $is_admissibility_check() ==> $is_malloc_root($s, $ptr(^AbsStack, P#_this_));
  ensures $is_unwrap_check() ==> $set_eq($owns($s, $ptr(^AbsStack, P#_this_)), $set_empty());
  ensures $is_unwrap_check() ==> $mem($s, $dot($ptr(^AbsStack, P#_this_), AbsStack.high_mark)) <= $mem($s, $dot($ptr(^AbsStack, P#_this_), AbsStack.capacity));
  ensures $is_unwrap_check() ==> $is_malloc_root($s, $ptr(^AbsStack, P#_this_));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation AbsStack#adm(P#_this_: int)
{
  var #wrTime$1^7.23: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^7.23, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^7.23, #loc._this_, $ptr_to_int($ptr(^AbsStack, P#_this_)), $spec_ptr_to(^AbsStack)) && $local_value_is_ptr($s, #tok$1^7.23, #loc._this_, $ptr(^AbsStack, P#_this_), $spec_ptr_to(^AbsStack));
    assume #wrTime$1^7.23 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^7.23, #p) } $in_writes_at(#wrTime$1^7.23, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^AbsStack, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^AbsStack, P#_this_));
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
            assume $admissibility_pre($s, $ptr(^AbsStack, P#_this_));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^AbsStack, P#_this_));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct AbsStack*)@null))
        call $havoc_others($ptr(^AbsStack, P#_this_), ^AbsStack);
        assume $good_state_ext(#tok$1^7.23, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^AbsStack, P#_this_), ^AbsStack);
    }

  #exit:
}



const unique ^Stack: $ctype;

axiom $is_composite(^Stack);

axiom $ptr_level(^Stack) == 0;

axiom $sizeof(^Stack) == 16;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Stack) } $inv2(#s1, #s2, #p, ^Stack) == ($typed(#s2, #p) && $int_to_ptr($mem(#s2, $dot(#p, Stack.elementsAsArray))) == $as_array($read_ptr(#s2, $dot(#p, Stack.elements), ^^u4), ^^u4, $mem(#s2, $dot(#p, Stack.capacity))) && $read_ptr(#s1, $dot(#p, Stack.abs), ^AbsStack) == $read_ptr(#s2, $dot(#p, Stack.abs), ^AbsStack) && $keeps(#s2, #p, $read_ptr(#s2, $dot(#p, Stack.abs), ^AbsStack)) && $int_to_ptr($mem(#s1, $dot(#p, Stack.elementsAsArray))) == $int_to_ptr($mem(#s2, $dot(#p, Stack.elementsAsArray))) && $keeps(#s2, #p, $int_to_ptr($mem(#s2, $dot(#p, Stack.elementsAsArray)))) && $is_malloc_root(#s2, #p) && $is_malloc_root(#s2, $int_to_ptr($mem(#s2, $dot(#p, Stack.elementsAsArray)))) && $mem(#s2, $dot(#p, Stack.topOfStack)) <= $mem(#s2, $dot(#p, Stack.capacity)) && F#AbstractionRelation(#s2, $ref(#p))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^Stack, #r), l#public) } $inv_lab(#s2, $ptr(^Stack, #r), l#public) == ($typed(#s2, $ptr(^Stack, #r)) && $int_to_ptr($mem(#s2, $dot($ptr(^Stack, #r), Stack.elementsAsArray))) == $as_array($read_ptr(#s2, $dot($ptr(^Stack, #r), Stack.elements), ^^u4), ^^u4, $mem(#s2, $dot($ptr(^Stack, #r), Stack.capacity))) && $keeps(#s2, $ptr(^Stack, #r), $read_ptr(#s2, $dot($ptr(^Stack, #r), Stack.abs), ^AbsStack)) && $keeps(#s2, $ptr(^Stack, #r), $int_to_ptr($mem(#s2, $dot($ptr(^Stack, #r), Stack.elementsAsArray)))) && $is_malloc_root(#s2, $ptr(^Stack, #r)) && $is_malloc_root(#s2, $int_to_ptr($mem(#s2, $dot($ptr(^Stack, #r), Stack.elementsAsArray)))) && $mem(#s2, $dot($ptr(^Stack, #r), Stack.topOfStack)) <= $mem(#s2, $dot($ptr(^Stack, #r), Stack.capacity)) && F#AbstractionRelation(#s2, $ref($ptr(^Stack, #r)))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^Stack, #r)) } $in_full_extent_of(#q, $ptr(^Stack, #r)) == (#q == $ptr(^Stack, #r) || #q == $dot($ptr(^Stack, #r), Stack.$owns) || #q == $dot($ptr(^Stack, #r), Stack.topOfStack) || #q == $dot($ptr(^Stack, #r), Stack.capacity) || #q == $dot($ptr(^Stack, #r), Stack.elements) || #q == $dot($ptr(^Stack, #r), Stack.abs) || #q == $dot($ptr(^Stack, #r), Stack.elementsAsArray)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Stack, #r)) } $in_extent_of(#s, #q, $ptr(^Stack, #r)) == $in_struct_extent_of(#q, $ptr(^Stack, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Stack, #r)) } $typed(#s, $ptr(^Stack, #r)) ==> $in_extent_of(#s, #q, $ptr(^Stack, #r)) == (#q == $ptr(^Stack, #r) || $emb(#s, #q) == $ptr(^Stack, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^Stack, #r)) } $in_span_of(#q, $ptr(^Stack, #r)) == (#q == $ptr(^Stack, #r) || #q == $dot($ptr(^Stack, #r), Stack.$owns) || #q == $dot($ptr(^Stack, #r), Stack.topOfStack) || #q == $dot($ptr(^Stack, #r), Stack.capacity) || #q == $dot($ptr(^Stack, #r), Stack.elements) || #q == $dot($ptr(^Stack, #r), Stack.abs) || #q == $dot($ptr(^Stack, #r), Stack.elementsAsArray)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^Stack) } $state_spans_the_same(#s1, #s2, #p, ^Stack) == ($mem_eq(#s1, #s2, $dot(#p, Stack.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Stack.topOfStack)) && $mem_eq(#s1, #s2, $dot(#p, Stack.capacity)) && $mem_eq(#s1, #s2, $dot(#p, Stack.elements)) && $mem_eq(#s1, #s2, $dot(#p, Stack.abs)) && $mem_eq(#s1, #s2, $dot(#p, Stack.elementsAsArray))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Stack) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Stack) == ($mem_eq(#s1, #s2, $dot(#p, Stack.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Stack.topOfStack)) && $mem_eq(#s1, #s2, $dot(#p, Stack.capacity)) && $mem_eq(#s1, #s2, $dot(#p, Stack.elements)) && $mem_eq(#s1, #s2, $dot(#p, Stack.abs)) && $mem_eq(#s1, #s2, $dot(#p, Stack.elementsAsArray))));

axiom $is_claimable(^Stack) == false;

axiom $has_volatile_owns_set(^Stack) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^Stack, #r)) } $extent_mutable(#s1, $ptr(^Stack, #r)) == $mutable(#s1, $ptr(^Stack, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^Stack, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^Stack, #r)) == $is_fresh(#s1, #s2, $ptr(^Stack, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^Stack, #r)) } $extent_zero(#s1, $ptr(^Stack, #r)) == ($mem(#s1, $dot($ptr(^Stack, #r), Stack.topOfStack)) == 0 && $mem(#s1, $dot($ptr(^Stack, #r), Stack.capacity)) == 0 && $mem(#s1, $dot($ptr(^Stack, #r), Stack.elements)) == 0 && $mem(#s1, $dot($ptr(^Stack, #r), Stack.abs)) == 0 && $mem(#s1, $dot($ptr(^Stack, #r), Stack.elementsAsArray)) == 0));

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

const unique Stack.capacity: $field;

axiom $static_field_properties(Stack.capacity, ^Stack);

axiom $is_primitive_non_volatile_field(Stack.capacity);

axiom $field_offset(Stack.capacity) == 4;

axiom (forall #p: $ptr :: { $dot(#p, Stack.capacity) } $is(#p, ^Stack) ==> $dot(#p, Stack.capacity) == $ptr(^^u4, $ref(#p) + 4) && $extent_hint($dot(#p, Stack.capacity), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Stack.capacity)) } { $st(#s, $dot(#p, Stack.capacity)) } $typed2(#s, #p, ^Stack) ==> $field_properties(#s, #p, Stack.capacity, ^^u4, false));

const unique Stack.elements: $field;

axiom $static_field_properties(Stack.elements, ^Stack);

axiom $is_primitive_non_volatile_field(Stack.elements);

axiom $field_offset(Stack.elements) == 8;

axiom (forall #p: $ptr :: { $dot(#p, Stack.elements) } $is(#p, ^Stack) ==> $dot(#p, Stack.elements) == $ptr($ptr_to(^^u4), $ref(#p) + 8) && $extent_hint($dot(#p, Stack.elements), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Stack.elements)) } { $st(#s, $dot(#p, Stack.elements)) } $typed2(#s, #p, ^Stack) ==> $field_properties(#s, #p, Stack.elements, $ptr_to(^^u4), false));

const unique Stack.abs: $field;

axiom $static_field_properties(Stack.abs, ^Stack);

axiom $is_primitive_non_volatile_field(Stack.abs);

axiom (forall #p: $ptr :: { $dot(#p, Stack.abs) } $is(#p, ^Stack) ==> $dot(#p, Stack.abs) == $ptr($spec_ptr_to(^AbsStack), $ghost_ref(#p, Stack.abs)) && $extent_hint($dot(#p, Stack.abs), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Stack.abs)) } { $st(#s, $dot(#p, Stack.abs)) } $typed2(#s, #p, ^Stack) ==> $field_properties(#s, #p, Stack.abs, $spec_ptr_to(^AbsStack), false));

const unique Stack.elementsAsArray: $field;

axiom $static_field_properties(Stack.elementsAsArray, ^Stack);

axiom $is_primitive_non_volatile_field(Stack.elementsAsArray);

axiom (forall #p: $ptr :: { $dot(#p, Stack.elementsAsArray) } $is(#p, ^Stack) ==> $dot(#p, Stack.elementsAsArray) == $ptr($ptr_to(^^void), $ghost_ref(#p, Stack.elementsAsArray)) && $extent_hint($dot(#p, Stack.elementsAsArray), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Stack.elementsAsArray)) } { $st(#s, $dot(#p, Stack.elementsAsArray)) } $typed2(#s, #p, ^Stack) ==> $field_properties(#s, #p, Stack.elementsAsArray, $ptr_to(^^void), false));

procedure Stack#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $int_to_ptr($mem($s, $dot($ptr(^Stack, P#_this_), Stack.elementsAsArray))) == $as_array($read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.elements), ^^u4), ^^u4, $mem($s, $dot($ptr(^Stack, P#_this_), Stack.capacity)));
  ensures $is_admissibility_check() ==> $read_ptr(old($s), $dot($ptr(^Stack, P#_this_), Stack.abs), ^AbsStack) == $read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.abs), ^AbsStack);
  ensures $is_admissibility_check() ==> $keeps($s, $ptr(^Stack, P#_this_), $read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.abs), ^AbsStack));
  ensures $is_admissibility_check() ==> $int_to_ptr($mem(old($s), $dot($ptr(^Stack, P#_this_), Stack.elementsAsArray))) == $int_to_ptr($mem($s, $dot($ptr(^Stack, P#_this_), Stack.elementsAsArray)));
  ensures $is_admissibility_check() ==> $keeps($s, $ptr(^Stack, P#_this_), $int_to_ptr($mem($s, $dot($ptr(^Stack, P#_this_), Stack.elementsAsArray))));
  ensures $is_admissibility_check() ==> $is_malloc_root($s, $ptr(^Stack, P#_this_));
  ensures $is_admissibility_check() ==> $is_malloc_root($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#_this_), Stack.elementsAsArray))));
  ensures $is_admissibility_check() ==> $mem($s, $dot($ptr(^Stack, P#_this_), Stack.topOfStack)) <= $mem($s, $dot($ptr(^Stack, P#_this_), Stack.capacity));
  ensures $is_admissibility_check() ==> F#AbstractionRelation($s, $ref($ptr(^Stack, P#_this_)));
  ensures $is_stuttering_check() ==> $read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.abs), ^AbsStack) == $read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.abs), ^AbsStack);
  ensures $is_stuttering_check() ==> $int_to_ptr($mem($s, $dot($ptr(^Stack, P#_this_), Stack.elementsAsArray))) == $int_to_ptr($mem($s, $dot($ptr(^Stack, P#_this_), Stack.elementsAsArray)));
  ensures $is_unwrap_check() ==> $int_to_ptr($mem($s, $dot($ptr(^Stack, P#_this_), Stack.elementsAsArray))) == $as_array($read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.elements), ^^u4), ^^u4, $mem($s, $dot($ptr(^Stack, P#_this_), Stack.capacity)));
  ensures $is_unwrap_check() ==> $read_ptr(old($s), $dot($ptr(^Stack, P#_this_), Stack.abs), ^AbsStack) == $read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.abs), ^AbsStack);
  ensures $is_unwrap_check() ==> $keeps($s, $ptr(^Stack, P#_this_), $read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.abs), ^AbsStack));
  ensures $is_unwrap_check() ==> $int_to_ptr($mem(old($s), $dot($ptr(^Stack, P#_this_), Stack.elementsAsArray))) == $int_to_ptr($mem($s, $dot($ptr(^Stack, P#_this_), Stack.elementsAsArray)));
  ensures $is_unwrap_check() ==> $keeps($s, $ptr(^Stack, P#_this_), $int_to_ptr($mem($s, $dot($ptr(^Stack, P#_this_), Stack.elementsAsArray))));
  ensures $is_unwrap_check() ==> $is_malloc_root($s, $ptr(^Stack, P#_this_));
  ensures $is_unwrap_check() ==> $is_malloc_root($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#_this_), Stack.elementsAsArray))));
  ensures $is_unwrap_check() ==> $mem($s, $dot($ptr(^Stack, P#_this_), Stack.topOfStack)) <= $mem($s, $dot($ptr(^Stack, P#_this_), Stack.capacity));
  ensures $is_unwrap_check() ==> F#AbstractionRelation($s, $ref($ptr(^Stack, P#_this_)));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Stack#adm(P#_this_: int)
{
  var #wrTime$1^16.1: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^16.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^16.1, #loc._this_, $ptr_to_int($ptr(^Stack, P#_this_)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^16.1, #loc._this_, $ptr(^Stack, P#_this_), $ptr_to(^Stack));
    assume #wrTime$1^16.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^16.1, #p) } $in_writes_at(#wrTime$1^16.1, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon7:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^Stack, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^Stack, P#_this_));
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
            assume $admissibility_pre($s, $ptr(^Stack, P#_this_));
        }
        else
        {
          anon9:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^Stack, P#_this_));
        }

      anon11:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Stack*)@null))
        call $havoc_others($ptr(^Stack, P#_this_), ^Stack);
        assume $good_state_ext(#tok$1^16.1, $s);
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

function F#AbstractionRelation(#s: $state, SP#stack: int) : bool;

const unique cf#AbstractionRelation: $pure_function;

axiom (forall #s: $state, SP#stack: int :: { F#AbstractionRelation(#s, SP#stack) } F#AbstractionRelation(#s, SP#stack) == ($mem(#s, $dot($ptr(^Stack, SP#stack), Stack.capacity)) == $mem(#s, $dot($read_ptr(#s, $dot($ptr(^Stack, SP#stack), Stack.abs), ^AbsStack), AbsStack.capacity)) && $mem(#s, $dot($ptr(^Stack, SP#stack), Stack.topOfStack)) == $mem(#s, $dot($read_ptr(#s, $dot($ptr(^Stack, SP#stack), Stack.abs), ^AbsStack), AbsStack.high_mark)) && (forall Q#idx$1^37.9#tc1: int :: $in_range_u4(Q#idx$1^37.9#tc1) ==> Q#idx$1^37.9#tc1 < $mem(#s, $dot($ptr(^Stack, SP#stack), Stack.topOfStack)) ==> $mem(#s, $idx($read_ptr(#s, $dot($ptr(^Stack, SP#stack), Stack.elements), ^^u4), Q#idx$1^37.9#tc1, ^^u4)) == $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($mem(#s, $dot($read_ptr(#s, $dot($ptr(^Stack, SP#stack), Stack.abs), ^AbsStack), AbsStack.entries))), Q#idx$1^37.9#tc1))));

axiom $function_arg_type(cf#AbstractionRelation, 0, ^^bool);

axiom $function_arg_type(cf#AbstractionRelation, 1, $ptr_to(^Stack));

procedure AbstractionRelation(SP#stack: int) returns ($result: bool);
  ensures $result == ($mem($s, $dot($ptr(^Stack, SP#stack), Stack.capacity)) == $mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, SP#stack), Stack.abs), ^AbsStack), AbsStack.capacity)) && $mem($s, $dot($ptr(^Stack, SP#stack), Stack.topOfStack)) == $mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, SP#stack), Stack.abs), ^AbsStack), AbsStack.high_mark)) && (forall Q#idx$1^37.9#tc1: int :: $in_range_u4(Q#idx$1^37.9#tc1) ==> Q#idx$1^37.9#tc1 < $mem($s, $dot($ptr(^Stack, SP#stack), Stack.topOfStack)) ==> $mem($s, $idx($read_ptr($s, $dot($ptr(^Stack, SP#stack), Stack.elements), ^^u4), Q#idx$1^37.9#tc1, ^^u4)) == $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, SP#stack), Stack.abs), ^AbsStack), AbsStack.entries))), Q#idx$1^37.9#tc1)));
  free ensures $result == F#AbstractionRelation($s, SP#stack);
  free ensures $call_transition(old($s), $s);



function F#IsEmpty(#s: $state, P#S: int) : bool;

const unique cf#IsEmpty: $pure_function;

axiom (forall #s: $state, P#S: int :: { F#IsEmpty(#s, P#S) } $wrapped(#s, $ptr(^Stack, P#S), ^Stack) ==> F#IsEmpty(#s, P#S) == ($mem(#s, $dot($read_ptr(#s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark)) == 0));

function F#IsEmpty#frame(int, $version) : bool;

axiom (forall #s: $state, P#S: int :: { F#IsEmpty(#s, P#S) } $full_stop(#s) && $can_use_frame_axiom_of(cf#IsEmpty) && $closed(#s, $ptr(^Stack, P#S)) ==> F#IsEmpty(#s, P#S) == F#IsEmpty#frame(P#S, $read_version(#s, $ptr(^Stack, P#S))));

axiom $function_arg_type(cf#IsEmpty, 0, ^^bool);

axiom $function_arg_type(cf#IsEmpty, 1, $ptr_to(^Stack));

procedure IsEmpty(P#S: int) returns ($result: bool);
  requires $wrapped($s, $ptr(^Stack, P#S), ^Stack);
  ensures $result == ($mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark)) == 0);
  free ensures $result == F#IsEmpty($s, P#S);
  free ensures $call_transition(old($s), $s);



implementation IsEmpty(P#S: int) returns ($result: bool)
{
  var #wrTime$1^40.17: int;
  var #stackframe: int;

  anon13:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^40.17, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^40.17, #loc.S, $ptr_to_int($ptr(^Stack, P#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^40.17, #loc.S, $ptr(^Stack, P#S), $ptr_to(^Stack));
    assume #wrTime$1^40.17 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^40.17, #p) } $in_writes_at(#wrTime$1^40.17, #p) == false);
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

  anon14:
    // empty

  #exit:
}



function F#IsFull(#s: $state, P#S: int) : bool;

const unique cf#IsFull: $pure_function;

axiom (forall #s: $state, P#S: int :: { F#IsFull(#s, P#S) } $wrapped(#s, $ptr(^Stack, P#S), ^Stack) ==> F#IsFull(#s, P#S) == ($mem(#s, $dot($read_ptr(#s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark)) == $mem(#s, $dot($read_ptr(#s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.capacity))));

axiom $function_arg_type(cf#IsFull, 0, ^^bool);

axiom $function_arg_type(cf#IsFull, 1, $ptr_to(^Stack));

procedure IsFull(P#S: int) returns ($result: bool);
  requires $wrapped($s, $ptr(^Stack, P#S), ^Stack);
  ensures $result == ($mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark)) == $mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.capacity)));
  free ensures $result == F#IsFull($s, P#S);
  free ensures $call_transition(old($s), $s);



implementation IsFull(P#S: int) returns ($result: bool)
{
  var #wrTime$1^49.17: int;
  var #stackframe: int;

  anon15:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^49.17, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^49.17, #loc.S, $ptr_to_int($ptr(^Stack, P#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^49.17, #loc.S, $ptr(^Stack, P#S), $ptr_to(^Stack));
    assume #wrTime$1^49.17 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^49.17, #p) } $in_writes_at(#wrTime$1^49.17, #p) == false);
    // assume @in_range_phys_ptr((mathint)S); 
    assume $in_range_phys_ptr($ref($ptr(^Stack, P#S)));
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $ptr(^Stack, P#S), $ptr(^Stack, P#S), l#public);
    // assert @reads_check_normal((S->topOfStack)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    // assert @reads_check_normal((S->capacity)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.capacity), ^^u4);
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.capacity), ^^u4);
    // return ==(*((S->topOfStack)), *((S->capacity))); 
    $result := $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) == $mem($s, $dot($ptr(^Stack, P#S), Stack.capacity));
    assert $position_marker();
    goto #exit;

  anon16:
    // empty

  #exit:
}



procedure Length(P#S: int) returns ($result: int);
  requires $wrapped($s, $ptr(^Stack, P#S), ^Stack);
  modifies $s, $cev_pc;
  free ensures $in_range_u4($result);
  ensures $result == $mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Length(P#S: int) returns ($result: int)
{
  var #wrTime$1^58.1: int;
  var #stackframe: int;

  anon17:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^58.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^58.1, #loc.S, $ptr_to_int($ptr(^Stack, P#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^58.1, #loc.S, $ptr(^Stack, P#S), $ptr_to(^Stack));
    assume #wrTime$1^58.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^58.1, #p) } $in_writes_at(#wrTime$1^58.1, #p) == false);
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

  anon18:
    // empty

  #exit:
}



procedure CreateStack(P#max_capacity: int) returns ($result: int);
  requires P#max_capacity > 0;
  modifies $s, $cev_pc;
  free ensures $in_range_phys_ptr($ref($ptr(^Stack, $result)));
  ensures $ptr_eq($ptr(^Stack, $result), $null) || ($wrapped($s, $ptr(^Stack, $result), ^Stack) && $is_fresh(old($s), $s, $ptr(^Stack, $result)) && F#IsEmpty($s, $ref($ptr(^Stack, $result))) && $mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, $result), Stack.abs), ^AbsStack), AbsStack.capacity)) == P#max_capacity);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation CreateStack(P#max_capacity: int) returns ($result: int)
{
  var owns#10: $ptrset;
  var staticWrapState#9: $state;
  var prestate#11: $state;
  var owns#7: $ptrset;
  var staticWrapState#6: $state;
  var prestate#8: $state;
  var prestate#5: $state;
  var #callConv#1: $ptr;
  var res__vcc_spec_alloc#4: int where $in_range_spec_ptr(res__vcc_spec_alloc#4);
  var res__vcc_alloc#3: $ptr;
  var #callConv#0: $ptr;
  var L#S: int where $in_range_phys_ptr(L#S);
  var #wrTime$1^65.8: int;
  var #stackframe: int;

  anon23:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^65.8, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^65.8, #loc.max_capacity, P#max_capacity, ^^u4);
    assume #wrTime$1^65.8 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^65.8, #p) } $in_writes_at(#wrTime$1^65.8, #p) == false);
    // assume @in_range_u4(max_capacity); 
    assume $in_range_u4(P#max_capacity);
    // struct Stack* S; 
    assume $local_value_is($s, #tok$1^73.12, #loc.S, $ptr_to_int($ptr(^Stack, L#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^73.12, #loc.S, $ptr(^Stack, L#S), $ptr_to(^Stack));
    // var struct Stack* S
    // S := _vcc_alloc(@_vcc_typeof((struct Stack*)@null)); 
    call #callConv#0 := $alloc(^Stack);
    assume $full_stop_ext(#tok$1^75.9, $s);
    L#S := $ref(#callConv#0);
    assume $local_value_is($s, #tok$1^75.9, #loc.S, $ptr_to_int($ptr(^Stack, L#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^75.9, #loc.S, $ptr(^Stack, L#S), $ptr_to(^Stack));
    assume true;
    // if (@_vcc_ptr_eq(S, @null)) ...
    if ($ptr_eq($ptr(^Stack, L#S), $null))
    {
      anon19:
        // return (struct Stack*)@null; 
        $result := $ref($ptr_cast($null, ^Stack));
        assert $position_marker();
        goto #exit;
    }
    else
    {
      anon20:
        // empty
    }

  anon24:
    // assert @_vcc_typed2(@state, (S->topOfStack)); 
    assert $typed2($s, $dot($ptr(^Stack, L#S), Stack.topOfStack), ^^u4);
    // assert @prim_writes_check((S->topOfStack)); 
    assert $writable($s, #wrTime$1^65.8, $dot($ptr(^Stack, L#S), Stack.topOfStack));
    // *(S->topOfStack) := 0; 
    call $write_int($dot($ptr(^Stack, L#S), Stack.topOfStack), 0);
    assume $full_stop_ext(#tok$1^78.5, $s);
    // assert @_vcc_typed2(@state, (S->capacity)); 
    assert $typed2($s, $dot($ptr(^Stack, L#S), Stack.capacity), ^^u4);
    // assert @prim_writes_check((S->capacity)); 
    assert $writable($s, #wrTime$1^65.8, $dot($ptr(^Stack, L#S), Stack.capacity));
    // *(S->capacity) := max_capacity; 
    call $write_int($dot($ptr(^Stack, L#S), Stack.capacity), P#max_capacity);
    assume $full_stop_ext(#tok$1^79.5, $s);
    // obj_t res__vcc_alloc#3; 
    assume $local_value_is($s, #tok$1^80.19, #loc.res__vcc_alloc#3, $ptr_to_int(res__vcc_alloc#3), $ptr_to(^^void));
    // assert @reads_check_normal((S->capacity)); 
    assert $typed2($s, $dot($ptr(^Stack, L#S), Stack.capacity), ^^u4);
    assert $thread_local2($s, $dot($ptr(^Stack, L#S), Stack.capacity), ^^u4);
    // res__vcc_alloc#3 := _vcc_alloc(@_vcc_array(@_vcc_typeof((uint32_t*)@null), *((S->capacity)))); 
    call res__vcc_alloc#3 := $alloc($array(^^u4, $mem($s, $dot($ptr(^Stack, L#S), Stack.capacity))));
    assume $full_stop_ext(#tok$1^80.19, $s);
    assume $local_value_is($s, #tok$1^80.19, #loc.res__vcc_alloc#3, $ptr_to_int(res__vcc_alloc#3), $ptr_to(^^void));
    // assert @_vcc_typed2(@state, (S->elements)); 
    assert $typed2($s, $dot($ptr(^Stack, L#S), Stack.elements), $ptr_to(^^u4));
    // assert @prim_writes_check((S->elements)); 
    assert $writable($s, #wrTime$1^65.8, $dot($ptr(^Stack, L#S), Stack.elements));
    // *(S->elements) := (uint32_t*)res__vcc_alloc#3; 
    call $write_int($dot($ptr(^Stack, L#S), Stack.elements), $ref($ptr_cast(res__vcc_alloc#3, ^^u4)));
    assume $full_stop_ext(#tok$1^80.5, $s);
    // assert @reads_check_normal((S->elements)); 
    assert $typed2($s, $dot($ptr(^Stack, L#S), Stack.elements), $ptr_to(^^u4));
    assert $thread_local2($s, $dot($ptr(^Stack, L#S), Stack.elements), $ptr_to(^^u4));
    assume true;
    // if (@_vcc_ptr_eq(*((S->elements)), @null)) ...
    if ($ptr_eq($read_ptr($s, $dot($ptr(^Stack, L#S), Stack.elements), ^^u4), $null))
    {
      anon21:
        // assert @writes_check(S); 
        assert $top_writable($s, #wrTime$1^65.8, $ptr(^Stack, L#S));
        // assert @writes_check(@_vcc_extent(@state, S)); 
        assert (forall #writes$1^82.9: $ptr :: { $dont_instantiate(#writes$1^82.9) } $set_in(#writes$1^82.9, $extent($s, $ptr(^Stack, L#S))) ==> $top_writable($s, #wrTime$1^65.8, #writes$1^82.9));
        // stmt _vcc_free(S); 
        call $free($ptr(^Stack, L#S));
        assume $full_stop_ext(#tok$1^82.9, $s);
        // return (struct Stack*)@null; 
        $result := $ref($ptr_cast($null, ^Stack));
        assert $position_marker();
        goto #exit;
    }
    else
    {
      anon22:
        // empty
    }

  anon25:
    // assert @_vcc_typed2(@state, (S->elementsAsArray)); 
    assert $typed2($s, $dot($ptr(^Stack, L#S), Stack.elementsAsArray), $ptr_to(^^void));
    // assert @prim_writes_check((S->elementsAsArray)); 
    assert $writable($s, #wrTime$1^65.8, $dot($ptr(^Stack, L#S), Stack.elementsAsArray));
    // assert @reads_check_normal((S->elements)); 
    assert $typed2($s, $dot($ptr(^Stack, L#S), Stack.elements), $ptr_to(^^u4));
    assert $thread_local2($s, $dot($ptr(^Stack, L#S), Stack.elements), $ptr_to(^^u4));
    // assert @reads_check_normal((S->capacity)); 
    assert $typed2($s, $dot($ptr(^Stack, L#S), Stack.capacity), ^^u4);
    assert $thread_local2($s, $dot($ptr(^Stack, L#S), Stack.capacity), ^^u4);
    // *(S->elementsAsArray) := @_vcc_as_array(*((S->elements)), *((S->capacity))); 
    call $write_int($dot($ptr(^Stack, L#S), Stack.elementsAsArray), $ptr_to_int($as_array($read_ptr($s, $dot($ptr(^Stack, L#S), Stack.elements), ^^u4), ^^u4, $mem($s, $dot($ptr(^Stack, L#S), Stack.capacity)))));
    assume $full_stop_ext(#tok$1^87.9, $s);
    // struct AbsStack^ res__vcc_spec_alloc#4; 
    assume $local_value_is($s, #tok$1^88.18, #loc.res__vcc_spec_alloc#4, $ptr_to_int($ptr(^AbsStack, res__vcc_spec_alloc#4)), $spec_ptr_to(^AbsStack)) && $local_value_is_ptr($s, #tok$1^88.18, #loc.res__vcc_spec_alloc#4, $ptr(^AbsStack, res__vcc_spec_alloc#4), $spec_ptr_to(^AbsStack));
    // res__vcc_spec_alloc#4 := _vcc_spec_alloc<struct AbsStack>(); 
    call #callConv#1 := $spec_alloc(^AbsStack);
    assume $full_stop_ext(#tok$1^88.18, $s);
    res__vcc_spec_alloc#4 := $ref(#callConv#1);
    assume $local_value_is($s, #tok$1^88.18, #loc.res__vcc_spec_alloc#4, $ptr_to_int($ptr(^AbsStack, res__vcc_spec_alloc#4)), $spec_ptr_to(^AbsStack)) && $local_value_is_ptr($s, #tok$1^88.18, #loc.res__vcc_spec_alloc#4, $ptr(^AbsStack, res__vcc_spec_alloc#4), $spec_ptr_to(^AbsStack));
    // assert @_vcc_typed2(@state, (S->abs)); 
    assert $typed2($s, $dot($ptr(^Stack, L#S), Stack.abs), $spec_ptr_to(^AbsStack));
    // assert @prim_writes_check((S->abs)); 
    assert $writable($s, #wrTime$1^65.8, $dot($ptr(^Stack, L#S), Stack.abs));
    // *(S->abs) := res__vcc_spec_alloc#4; 
    call $write_int($dot($ptr(^Stack, L#S), Stack.abs), $ref($ptr(^AbsStack, res__vcc_spec_alloc#4)));
    assume $full_stop_ext(#tok$1^88.9, $s);
    // assert @_vcc_typed2(@state, (*((S->abs))->high_mark)); 
    assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Stack, L#S), Stack.abs), ^AbsStack), AbsStack.high_mark), ^^u4);
    // assert @prim_writes_check((*((S->abs))->high_mark)); 
    assert $writable($s, #wrTime$1^65.8, $dot($read_ptr($s, $dot($ptr(^Stack, L#S), Stack.abs), ^AbsStack), AbsStack.high_mark));
    // assert @reads_check_normal((S->abs)); 
    assert $typed2($s, $dot($ptr(^Stack, L#S), Stack.abs), $spec_ptr_to(^AbsStack));
    assert $thread_local2($s, $dot($ptr(^Stack, L#S), Stack.abs), $spec_ptr_to(^AbsStack));
    // assert @reads_check_normal((S->topOfStack)); 
    assert $typed2($s, $dot($ptr(^Stack, L#S), Stack.topOfStack), ^^u4);
    assert $thread_local2($s, $dot($ptr(^Stack, L#S), Stack.topOfStack), ^^u4);
    // *(*((S->abs))->high_mark) := *((S->topOfStack)); 
    call $write_int($dot($read_ptr($s, $dot($ptr(^Stack, L#S), Stack.abs), ^AbsStack), AbsStack.high_mark), $mem($s, $dot($ptr(^Stack, L#S), Stack.topOfStack)));
    assume $full_stop_ext(#tok$1^89.9, $s);
    // assert @_vcc_typed2(@state, (*((S->abs))->capacity)); 
    assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Stack, L#S), Stack.abs), ^AbsStack), AbsStack.capacity), ^^u4);
    // assert @prim_writes_check((*((S->abs))->capacity)); 
    assert $writable($s, #wrTime$1^65.8, $dot($read_ptr($s, $dot($ptr(^Stack, L#S), Stack.abs), ^AbsStack), AbsStack.capacity));
    // assert @reads_check_normal((S->abs)); 
    assert $typed2($s, $dot($ptr(^Stack, L#S), Stack.abs), $spec_ptr_to(^AbsStack));
    assert $thread_local2($s, $dot($ptr(^Stack, L#S), Stack.abs), $spec_ptr_to(^AbsStack));
    // assert @reads_check_normal((S->capacity)); 
    assert $typed2($s, $dot($ptr(^Stack, L#S), Stack.capacity), ^^u4);
    assert $thread_local2($s, $dot($ptr(^Stack, L#S), Stack.capacity), ^^u4);
    // *(*((S->abs))->capacity) := *((S->capacity)); 
    call $write_int($dot($read_ptr($s, $dot($ptr(^Stack, L#S), Stack.abs), ^AbsStack), AbsStack.capacity), $mem($s, $dot($ptr(^Stack, L#S), Stack.capacity)));
    assume $full_stop_ext(#tok$1^90.9, $s);
    // _math state_t prestate#5; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#5, $state_to_int(prestate#5), ^$#state_t);
    // prestate#5 := @_vcc_current_state(@state); 
    prestate#5 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#5, $state_to_int(prestate#5), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(*((S->elementsAsArray))); 
    assert $top_writable($s, #wrTime$1^65.8, $int_to_ptr($mem($s, $dot($ptr(^Stack, L#S), Stack.elementsAsArray))));
    // assert @writes_check(@_vcc_owns(@state, *((S->elementsAsArray)))); 
    assert (forall #writes$1^91.21: $ptr :: { $dont_instantiate(#writes$1^91.21) } $set_in(#writes$1^91.21, $owns($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, L#S), Stack.elementsAsArray))))) ==> $top_writable($s, #wrTime$1^65.8, #writes$1^91.21));
    // assert @reads_check_normal((S->elementsAsArray)); 
    assert $typed2($s, $dot($ptr(^Stack, L#S), Stack.elementsAsArray), $ptr_to(^^void));
    assert $thread_local2($s, $dot($ptr(^Stack, L#S), Stack.elementsAsArray), $ptr_to(^^void));
    // stmt @_vcc_wrap(*((S->elementsAsArray)), @_vcc_typeof(*((S->elementsAsArray)))); 
    call $wrap($int_to_ptr($mem($s, $dot($ptr(^Stack, L#S), Stack.elementsAsArray))), $typ($int_to_ptr($mem($s, $dot($ptr(^Stack, L#S), Stack.elementsAsArray)))));
    assume $good_state_ext(#tok$1^91.21, $s);
    // assert @_vcc_inv2(prestate#5, @_vcc_current_state(@state), *((S->elementsAsArray))); 
    assert $inv2(prestate#5, $current_state($s), $int_to_ptr($mem($s, $dot($ptr(^Stack, L#S), Stack.elementsAsArray))), $typ($int_to_ptr($mem($s, $dot($ptr(^Stack, L#S), Stack.elementsAsArray)))));
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
    assert $top_writable($s, #wrTime$1^65.8, $read_ptr($s, $dot($ptr(^Stack, L#S), Stack.abs), ^AbsStack));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(*((S->abs))), staticWrapState#6, owns#7)
    call $static_wrap($read_ptr($s, $dot($ptr(^Stack, L#S), Stack.abs), ^AbsStack), staticWrapState#6, owns#7);
    assume $good_state_ext(#tok$1^92.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((S->abs))), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $read_ptr($s, $dot($ptr(^Stack, L#S), Stack.abs), ^AbsStack)), $set_empty());
    // assert @inv_check(<=(*((*((S->abs))->high_mark)), *((*((S->abs))->capacity)))); 
    assert $mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, L#S), Stack.abs), ^AbsStack), AbsStack.high_mark)) <= $mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, L#S), Stack.abs), ^AbsStack), AbsStack.capacity));
    // assert @inv_check(@_vcc_is_malloc_root(@state, *((S->abs)))); 
    assert $is_malloc_root($s, $read_ptr($s, $dot($ptr(^Stack, L#S), Stack.abs), ^AbsStack));
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
    assert $top_writable($s, #wrTime$1^65.8, $ptr(^Stack, L#S));
    // assert @_vcc_wrapped(@state, *((S->elementsAsArray))); 
    assert $wrapped($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, L#S), Stack.elementsAsArray))), $typ($int_to_ptr($mem($s, $dot($ptr(^Stack, L#S), Stack.elementsAsArray)))));
    // assert @writes_check(*((S->elementsAsArray))); 
    assert $top_writable($s, #wrTime$1^65.8, $int_to_ptr($mem($s, $dot($ptr(^Stack, L#S), Stack.elementsAsArray))));
    // owns#10 := pure(@_vcc_set_union(owns#10, @_vcc_set_singleton(*((S->elementsAsArray))))); 
    owns#10 := $set_union(owns#10, $set_singleton($int_to_ptr($mem($s, $dot($ptr(^Stack, L#S), Stack.elementsAsArray)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#10, $ptrset_to_int(owns#10), ^$#ptrset);
    // staticWrapState#9 := pure(@_vcc_take_over(staticWrapState#9, S, *((S->elementsAsArray)))); 
    staticWrapState#9 := $take_over(staticWrapState#9, $ptr(^Stack, L#S), $int_to_ptr($mem($s, $dot($ptr(^Stack, L#S), Stack.elementsAsArray))));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#9, $state_to_int(staticWrapState#9), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((S->abs))); 
    assert $wrapped($s, $read_ptr($s, $dot($ptr(^Stack, L#S), Stack.abs), ^AbsStack), ^AbsStack);
    // assert @writes_check(*((S->abs))); 
    assert $top_writable($s, #wrTime$1^65.8, $read_ptr($s, $dot($ptr(^Stack, L#S), Stack.abs), ^AbsStack));
    // owns#10 := pure(@_vcc_set_union(owns#10, @_vcc_set_singleton(*((S->abs))))); 
    owns#10 := $set_union(owns#10, $set_singleton($read_ptr($s, $dot($ptr(^Stack, L#S), Stack.abs), ^AbsStack)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#10, $ptrset_to_int(owns#10), ^$#ptrset);
    // staticWrapState#9 := pure(@_vcc_take_over(staticWrapState#9, S, *((S->abs)))); 
    staticWrapState#9 := $take_over(staticWrapState#9, $ptr(^Stack, L#S), $read_ptr($s, $dot($ptr(^Stack, L#S), Stack.abs), ^AbsStack));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#9, $state_to_int(staticWrapState#9), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(S), staticWrapState#9, owns#10)
    call $static_wrap($ptr(^Stack, L#S), staticWrapState#9, owns#10);
    assume $good_state_ext(#tok$1^93.21, $s);
    // assert @inv_check(==(*((S->elementsAsArray)), @_vcc_as_array(*((S->elements)), *((S->capacity))))); 
    assert $int_to_ptr($mem($s, $dot($ptr(^Stack, L#S), Stack.elementsAsArray))) == $as_array($read_ptr($s, $dot($ptr(^Stack, L#S), Stack.elements), ^^u4), ^^u4, $mem($s, $dot($ptr(^Stack, L#S), Stack.capacity)));
    // assert @inv_check(@keeps_stable(old(prestate#11, *((S->abs))), *((S->abs)))); 
    assert $read_ptr(prestate#11, $dot($ptr(^Stack, L#S), Stack.abs), ^AbsStack) == $read_ptr($s, $dot($ptr(^Stack, L#S), Stack.abs), ^AbsStack);
    // assert @inv_check(@keeps(S, *((S->abs)))); 
    assert $keeps($s, $ptr(^Stack, L#S), $read_ptr($s, $dot($ptr(^Stack, L#S), Stack.abs), ^AbsStack));
    // assert @inv_check(@keeps_stable(old(prestate#11, *((S->elementsAsArray))), *((S->elementsAsArray)))); 
    assert $int_to_ptr($mem(prestate#11, $dot($ptr(^Stack, L#S), Stack.elementsAsArray))) == $int_to_ptr($mem($s, $dot($ptr(^Stack, L#S), Stack.elementsAsArray)));
    // assert @inv_check(@keeps(S, *((S->elementsAsArray)))); 
    assert $keeps($s, $ptr(^Stack, L#S), $int_to_ptr($mem($s, $dot($ptr(^Stack, L#S), Stack.elementsAsArray))));
    // assert @inv_check(@_vcc_is_malloc_root(@state, S)); 
    assert $is_malloc_root($s, $ptr(^Stack, L#S));
    // assert @inv_check(@_vcc_is_malloc_root(@state, *((S->elementsAsArray)))); 
    assert $is_malloc_root($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, L#S), Stack.elementsAsArray))));
    // assert @inv_check(<=(*((S->topOfStack)), *((S->capacity)))); 
    assert $mem($s, $dot($ptr(^Stack, L#S), Stack.topOfStack)) <= $mem($s, $dot($ptr(^Stack, L#S), Stack.capacity));
    // assert @inv_check(AbstractionRelation(S)); 
    assert F#AbstractionRelation($s, $ref($ptr(^Stack, L#S)));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return S; 
    $result := $ref($ptr(^Stack, L#S));
    assert $position_marker();
    goto #exit;

  anon26:
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
    assume $local_value_is($s, #tok$1^97.1, #loc.S, $ptr_to_int($ptr(^Stack, P#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^97.1, #loc.S, $ptr(^Stack, P#S), $ptr_to(^Stack));
    assume #wrTime$1^97.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^97.1, #p) } $in_writes_at(#wrTime$1^97.1, #p) == (#p == $ptr(^Stack, P#S)));
    assume $thread_owned($s, $ptr(^Stack, P#S));
    // assume @in_range_phys_ptr((mathint)S); 
    assume $in_range_phys_ptr($ref($ptr(^Stack, P#S)));
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $ptr(^Stack, P#S), $ptr(^Stack, P#S), l#public);
    // assert @_vcc_in_domain(@state, *((S->elementsAsArray)), S); 
    assert $in_domain_lab($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))), $ptr(^Stack, P#S), l#public);
    // assume @_vcc_in_domain(@state, *((S->elementsAsArray)), S); 
    assume $in_domain_lab($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))), $ptr(^Stack, P#S), l#public);
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
    assert $wrapped($s, $ptr(^Stack, P#S), ^Stack);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^97.1, $ptr(^Stack, P#S));
    // assume @_vcc_inv(@state, S); 
    assume $inv($s, $ptr(^Stack, P#S), ^Stack);
    // prestate#14 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#14, S, *((S->elementsAsArray)))); 
    prestate#14 := $release($current_state($s), prestate#14, $ptr(^Stack, P#S), $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#14, $state_to_int(prestate#14), ^$#state_t);
    // owns#13 := pure(@_vcc_set_union(owns#13, @_vcc_set_singleton(*((S->elementsAsArray))))); 
    owns#13 := $set_union(owns#13, $set_singleton($int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#13, $ptrset_to_int(owns#13), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((S->elementsAsArray)))); 
    assume $typed($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))));
    // prestate#14 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#14, S, *((S->abs)))); 
    prestate#14 := $release($current_state($s), prestate#14, $ptr(^Stack, P#S), $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#14, $state_to_int(prestate#14), ^$#state_t);
    // owns#13 := pure(@_vcc_set_union(owns#13, @_vcc_set_singleton(*((S->abs))))); 
    owns#13 := $set_union(owns#13, $set_singleton($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#13, $ptrset_to_int(owns#13), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((S->abs)))); 
    assume $typed($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    // assume ==(owns#13, @_vcc_owns(@state, S)); 
    assume owns#13 == $owns($s, $ptr(^Stack, P#S));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(S), prestate#14)
    call $static_unwrap($ptr(^Stack, P#S), prestate#14);
    assume $good_state_ext(#tok$1^102.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#15; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#15, $state_to_int(prestate#15), ^$#state_t);
    // prestate#15 := @_vcc_current_state(@state); 
    prestate#15 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#15, $state_to_int(prestate#15), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((S->elementsAsArray))); 
    assert $wrapped($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))), $typ($int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray)))));
    // assume @_vcc_inv(@state, *((S->elementsAsArray))); 
    assume $inv($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))), $typ($int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray)))));
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(*((S->elementsAsArray))); 
    assert $top_writable($s, #wrTime$1^97.1, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))));
    // assert @reads_check_normal((S->elementsAsArray)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray), $ptr_to(^^void));
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray), $ptr_to(^^void));
    // stmt @_vcc_unwrap(*((S->elementsAsArray)), @_vcc_typeof(*((S->elementsAsArray)))); 
    call $unwrap($int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))), $typ($int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray)))));
    assume $good_state_ext(#tok$1^103.21, $s);
    // assert @_vcc_inv2(prestate#15, @_vcc_current_state(@state), *((S->elementsAsArray))); 
    assert $inv2(prestate#15, $current_state($s), $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))), $typ($int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray)))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @writes_check(@_vcc_as_array(*((S->elements)), *((S->capacity)))); 
    assert $top_writable($s, #wrTime$1^97.1, $as_array($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.elements), ^^u4), ^^u4, $mem($s, $dot($ptr(^Stack, P#S), Stack.capacity))));
    // assert @writes_check(@_vcc_extent(@state, @_vcc_as_array(*((S->elements)), *((S->capacity))))); 
    assert (forall #writes$1^104.5: $ptr :: { $dont_instantiate(#writes$1^104.5) } $set_in(#writes$1^104.5, $extent($s, $as_array($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.elements), ^^u4), ^^u4, $mem($s, $dot($ptr(^Stack, P#S), Stack.capacity))))) ==> $top_writable($s, #wrTime$1^97.1, #writes$1^104.5));
    // assert @reads_check_normal((S->elements)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.elements), $ptr_to(^^u4));
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.elements), $ptr_to(^^u4));
    // assert @reads_check_normal((S->capacity)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.capacity), ^^u4);
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.capacity), ^^u4);
    // stmt _vcc_free(@_vcc_as_array(*((S->elements)), *((S->capacity)))); 
    call $free($as_array($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.elements), ^^u4), ^^u4, $mem($s, $dot($ptr(^Stack, P#S), Stack.capacity))));
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
    assert $wrapped($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), ^AbsStack);
    // assert @writes_check(*((S->abs))); 
    assert $top_writable($s, #wrTime$1^97.1, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    // assume @_vcc_inv(@state, *((S->abs))); 
    assume $inv($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), ^AbsStack);
    // assume ==(owns#17, @_vcc_owns(@state, *((S->abs)))); 
    assume owns#17 == $owns($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(*((S->abs))), prestate#18)
    call $static_unwrap($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), prestate#18);
    assume $good_state_ext(#tok$1^105.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^97.1, $ptr(^Stack, P#S));
    // assert @writes_check(@_vcc_extent(@state, S)); 
    assert (forall #writes$1^106.5: $ptr :: { $dont_instantiate(#writes$1^106.5) } $set_in(#writes$1^106.5, $extent($s, $ptr(^Stack, P#S))) ==> $top_writable($s, #wrTime$1^97.1, #writes$1^106.5));
    // stmt _vcc_free(S); 
    call $free($ptr(^Stack, P#S));
    assume $full_stop_ext(#tok$1^106.5, $s);
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
    assume $local_value_is($s, #tok$1^109.1, #loc.S, $ptr_to_int($ptr(^Stack, P#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^109.1, #loc.S, $ptr(^Stack, P#S), $ptr_to(^Stack));
    assume #wrTime$1^109.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^109.1, #p) } $in_writes_at(#wrTime$1^109.1, #p) == (#p == $ptr(^Stack, P#S)));
    assume $thread_owned($s, $ptr(^Stack, P#S));
    // assume @in_range_phys_ptr((mathint)S); 
    assume $in_range_phys_ptr($ref($ptr(^Stack, P#S)));
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $ptr(^Stack, P#S), $ptr(^Stack, P#S), l#public);
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
    assert $wrapped($s, $ptr(^Stack, P#S), ^Stack);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^109.1, $ptr(^Stack, P#S));
    // assume @_vcc_inv(@state, S); 
    assume $inv($s, $ptr(^Stack, P#S), ^Stack);
    // prestate#21 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#21, S, *((S->elementsAsArray)))); 
    prestate#21 := $release($current_state($s), prestate#21, $ptr(^Stack, P#S), $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#21, $state_to_int(prestate#21), ^$#state_t);
    // owns#20 := pure(@_vcc_set_union(owns#20, @_vcc_set_singleton(*((S->elementsAsArray))))); 
    owns#20 := $set_union(owns#20, $set_singleton($int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#20, $ptrset_to_int(owns#20), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((S->elementsAsArray)))); 
    assume $typed($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))));
    // prestate#21 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#21, S, *((S->abs)))); 
    prestate#21 := $release($current_state($s), prestate#21, $ptr(^Stack, P#S), $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#21, $state_to_int(prestate#21), ^$#state_t);
    // owns#20 := pure(@_vcc_set_union(owns#20, @_vcc_set_singleton(*((S->abs))))); 
    owns#20 := $set_union(owns#20, $set_singleton($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#20, $ptrset_to_int(owns#20), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((S->abs)))); 
    assume $typed($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    // assume ==(owns#20, @_vcc_owns(@state, S)); 
    assume owns#20 == $owns($s, $ptr(^Stack, P#S));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(S), prestate#21)
    call $static_unwrap($ptr(^Stack, P#S), prestate#21);
    assume $good_state_ext(#tok$1^114.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (S->topOfStack)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    // assert @prim_writes_check((S->topOfStack)); 
    assert $writable($s, #wrTime$1^109.1, $dot($ptr(^Stack, P#S), Stack.topOfStack));
    // *(S->topOfStack) := 0; 
    call $write_int($dot($ptr(^Stack, P#S), Stack.topOfStack), 0);
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
    assert $wrapped($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), ^AbsStack);
    // assert @writes_check(*((S->abs))); 
    assert $top_writable($s, #wrTime$1^109.1, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    // assume @_vcc_inv(@state, *((S->abs))); 
    assume $inv($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), ^AbsStack);
    // assume ==(owns#23, @_vcc_owns(@state, *((S->abs)))); 
    assume owns#23 == $owns($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(*((S->abs))), prestate#24)
    call $static_unwrap($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), prestate#24);
    assume $good_state_ext(#tok$1^116.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (*((S->abs))->high_mark)); 
    assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark), ^^u4);
    // assert @prim_writes_check((*((S->abs))->high_mark)); 
    assert $writable($s, #wrTime$1^109.1, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark));
    // assert @reads_check_normal((S->abs)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.abs), $spec_ptr_to(^AbsStack));
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.abs), $spec_ptr_to(^AbsStack));
    // assert @reads_check_normal((S->topOfStack)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    // *(*((S->abs))->high_mark) := *((S->topOfStack)); 
    call $write_int($dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark), $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)));
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
    assert $top_writable($s, #wrTime$1^109.1, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(*((S->abs))), staticWrapState#25, owns#26)
    call $static_wrap($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), staticWrapState#25, owns#26);
    assume $good_state_ext(#tok$1^118.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((S->abs))), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack)), $set_empty());
    // assert @inv_check(<=(*((*((S->abs))->high_mark)), *((*((S->abs))->capacity)))); 
    assert $mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark)) <= $mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.capacity));
    // assert @inv_check(@_vcc_is_malloc_root(@state, *((S->abs)))); 
    assert $is_malloc_root($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
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
    assert $top_writable($s, #wrTime$1^109.1, $ptr(^Stack, P#S));
    // assert @_vcc_wrapped(@state, *((S->elementsAsArray))); 
    assert $wrapped($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))), $typ($int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray)))));
    // assert @writes_check(*((S->elementsAsArray))); 
    assert $top_writable($s, #wrTime$1^109.1, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))));
    // owns#29 := pure(@_vcc_set_union(owns#29, @_vcc_set_singleton(*((S->elementsAsArray))))); 
    owns#29 := $set_union(owns#29, $set_singleton($int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#29, $ptrset_to_int(owns#29), ^$#ptrset);
    // staticWrapState#28 := pure(@_vcc_take_over(staticWrapState#28, S, *((S->elementsAsArray)))); 
    staticWrapState#28 := $take_over(staticWrapState#28, $ptr(^Stack, P#S), $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#28, $state_to_int(staticWrapState#28), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((S->abs))); 
    assert $wrapped($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), ^AbsStack);
    // assert @writes_check(*((S->abs))); 
    assert $top_writable($s, #wrTime$1^109.1, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    // owns#29 := pure(@_vcc_set_union(owns#29, @_vcc_set_singleton(*((S->abs))))); 
    owns#29 := $set_union(owns#29, $set_singleton($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#29, $ptrset_to_int(owns#29), ^$#ptrset);
    // staticWrapState#28 := pure(@_vcc_take_over(staticWrapState#28, S, *((S->abs)))); 
    staticWrapState#28 := $take_over(staticWrapState#28, $ptr(^Stack, P#S), $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#28, $state_to_int(staticWrapState#28), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(S), staticWrapState#28, owns#29)
    call $static_wrap($ptr(^Stack, P#S), staticWrapState#28, owns#29);
    assume $good_state_ext(#tok$1^119.21, $s);
    // assert @inv_check(==(*((S->elementsAsArray)), @_vcc_as_array(*((S->elements)), *((S->capacity))))); 
    assert $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))) == $as_array($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.elements), ^^u4), ^^u4, $mem($s, $dot($ptr(^Stack, P#S), Stack.capacity)));
    // assert @inv_check(@keeps_stable(old(prestate#30, *((S->abs))), *((S->abs)))); 
    assert $read_ptr(prestate#30, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack) == $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack);
    // assert @inv_check(@keeps(S, *((S->abs)))); 
    assert $keeps($s, $ptr(^Stack, P#S), $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    // assert @inv_check(@keeps_stable(old(prestate#30, *((S->elementsAsArray))), *((S->elementsAsArray)))); 
    assert $int_to_ptr($mem(prestate#30, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))) == $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray)));
    // assert @inv_check(@keeps(S, *((S->elementsAsArray)))); 
    assert $keeps($s, $ptr(^Stack, P#S), $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))));
    // assert @inv_check(@_vcc_is_malloc_root(@state, S)); 
    assert $is_malloc_root($s, $ptr(^Stack, P#S));
    // assert @inv_check(@_vcc_is_malloc_root(@state, *((S->elementsAsArray)))); 
    assert $is_malloc_root($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))));
    // assert @inv_check(<=(*((S->topOfStack)), *((S->capacity)))); 
    assert $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) <= $mem($s, $dot($ptr(^Stack, P#S), Stack.capacity));
    // assert @inv_check(AbstractionRelation(S)); 
    assert F#AbstractionRelation($s, $ref($ptr(^Stack, P#S)));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure Top(P#S: int) returns ($result: int);
  requires $wrapped($s, $ptr(^Stack, P#S), ^Stack);
  requires !F#IsEmpty($s, $ref($ptr(^Stack, P#S)));
  modifies $s, $cev_pc;
  free ensures $in_range_u4($result);
  ensures $result == $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.entries))), $mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark)) - 1);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Top(P#S: int) returns ($result: int)
{
  var #wrTime$1^122.1: int;
  var #stackframe: int;

  anon29:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^122.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^122.1, #loc.S, $ptr_to_int($ptr(^Stack, P#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^122.1, #loc.S, $ptr(^Stack, P#S), $ptr_to(^Stack));
    assume #wrTime$1^122.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^122.1, #p) } $in_writes_at(#wrTime$1^122.1, #p) == false);
    // assume @in_range_phys_ptr((mathint)S); 
    assume $in_range_phys_ptr($ref($ptr(^Stack, P#S)));
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $ptr(^Stack, P#S), $ptr(^Stack, P#S), l#public);
    // assert @_vcc_in_domain(@state, *((S->elementsAsArray)), S); 
    assert $in_domain_lab($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))), $ptr(^Stack, P#S), l#public);
    // assume @_vcc_in_domain(@state, *((S->elementsAsArray)), S); 
    assume $in_domain_lab($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))), $ptr(^Stack, P#S), l#public);
    // assert @reads_check_normal(*((S->elements))[-(*((S->topOfStack)), 1)]); 
    assert $typed2($s, $idx($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.elements), ^^u4), $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) - 1, ^^u4), ^^u4);
    assert $thread_local2($s, $idx($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.elements), ^^u4), $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) - 1, ^^u4), ^^u4);
    // assert @reads_check_normal((S->elements)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.elements), $ptr_to(^^u4));
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.elements), $ptr_to(^^u4));
    // assert @in_range_u4(-(*((S->topOfStack)), 1)); 
    assert $in_range_u4($mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) - 1);
    // assert @reads_check_normal((S->topOfStack)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    // return *(*((S->elements))[-(*((S->topOfStack)), 1)]); 
    $result := $mem($s, $idx($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.elements), ^^u4), $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) - 1, ^^u4));
    assert $position_marker();
    goto #exit;

  anon30:
    // empty

  #exit:
}



procedure Pop(P#S: int);
  requires !F#IsEmpty($s, $ref($ptr(^Stack, P#S)));
  requires $wrapped($s, $ptr(^Stack, P#S), ^Stack);
  modifies $s, $cev_pc;
  ensures !F#IsFull($s, $ref($ptr(^Stack, P#S)));
  ensures $mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark)) == $mem(old($s), $dot($read_ptr(old($s), $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark)) - 1;
  ensures (forall Q#idx$1^137.29#tc1: int :: $in_range_u4(Q#idx$1^137.29#tc1) ==> Q#idx$1^137.29#tc1 < $mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark)) ==> $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($mem(old($s), $dot($read_ptr(old($s), $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.entries))), Q#idx$1^137.29#tc1) == $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.entries))), Q#idx$1^137.29#tc1));
  ensures $wrapped($s, $ptr(^Stack, P#S), ^Stack);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Stack, P#S) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Stack, P#S) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Stack, P#S) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Pop(P#S: int)
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
    assume $local_value_is($s, #tok$1^131.1, #loc.S, $ptr_to_int($ptr(^Stack, P#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^131.1, #loc.S, $ptr(^Stack, P#S), $ptr_to(^Stack));
    assume #wrTime$1^131.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^131.1, #p) } $in_writes_at(#wrTime$1^131.1, #p) == (#p == $ptr(^Stack, P#S)));
    assume $thread_owned($s, $ptr(^Stack, P#S));
    // assume @in_range_phys_ptr((mathint)S); 
    assume $in_range_phys_ptr($ref($ptr(^Stack, P#S)));
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $ptr(^Stack, P#S), $ptr(^Stack, P#S), l#public);
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
    assert $wrapped($s, $ptr(^Stack, P#S), ^Stack);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^131.1, $ptr(^Stack, P#S));
    // assume @_vcc_inv(@state, S); 
    assume $inv($s, $ptr(^Stack, P#S), ^Stack);
    // prestate#33 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#33, S, *((S->elementsAsArray)))); 
    prestate#33 := $release($current_state($s), prestate#33, $ptr(^Stack, P#S), $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#33, $state_to_int(prestate#33), ^$#state_t);
    // owns#32 := pure(@_vcc_set_union(owns#32, @_vcc_set_singleton(*((S->elementsAsArray))))); 
    owns#32 := $set_union(owns#32, $set_singleton($int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#32, $ptrset_to_int(owns#32), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((S->elementsAsArray)))); 
    assume $typed($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))));
    // prestate#33 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#33, S, *((S->abs)))); 
    prestate#33 := $release($current_state($s), prestate#33, $ptr(^Stack, P#S), $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#33, $state_to_int(prestate#33), ^$#state_t);
    // owns#32 := pure(@_vcc_set_union(owns#32, @_vcc_set_singleton(*((S->abs))))); 
    owns#32 := $set_union(owns#32, $set_singleton($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#32, $ptrset_to_int(owns#32), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((S->abs)))); 
    assume $typed($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    // assume ==(owns#32, @_vcc_owns(@state, S)); 
    assume owns#32 == $owns($s, $ptr(^Stack, P#S));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(S), prestate#33)
    call $static_unwrap($ptr(^Stack, P#S), prestate#33);
    assume $good_state_ext(#tok$1^139.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (S->topOfStack)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    // assert @prim_writes_check((S->topOfStack)); 
    assert $writable($s, #wrTime$1^131.1, $dot($ptr(^Stack, P#S), Stack.topOfStack));
    // assert @in_range_u4(-(*((S->topOfStack)), 1)); 
    assert $in_range_u4($mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) - 1);
    // assert @reads_check_normal((S->topOfStack)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    // *(S->topOfStack) := -(*((S->topOfStack)), 1); 
    call $write_int($dot($ptr(^Stack, P#S), Stack.topOfStack), $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) - 1);
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
    assert $wrapped($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), ^AbsStack);
    // assert @writes_check(*((S->abs))); 
    assert $top_writable($s, #wrTime$1^131.1, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    // assume @_vcc_inv(@state, *((S->abs))); 
    assume $inv($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), ^AbsStack);
    // assume ==(owns#35, @_vcc_owns(@state, *((S->abs)))); 
    assume owns#35 == $owns($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(*((S->abs))), prestate#36)
    call $static_unwrap($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), prestate#36);
    assume $good_state_ext(#tok$1^141.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (*((S->abs))->high_mark)); 
    assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark), ^^u4);
    // assert @prim_writes_check((*((S->abs))->high_mark)); 
    assert $writable($s, #wrTime$1^131.1, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark));
    // assert @reads_check_normal((S->abs)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.abs), $spec_ptr_to(^AbsStack));
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.abs), $spec_ptr_to(^AbsStack));
    // assert @in_range_u4(-(*((*((S->abs))->high_mark)), 1)); 
    assert $in_range_u4($mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark)) - 1);
    // assert @reads_check_normal((*((S->abs))->high_mark)); 
    assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark), ^^u4);
    assert $thread_local2($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark), ^^u4);
    // assert @reads_check_normal((S->abs)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.abs), $spec_ptr_to(^AbsStack));
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.abs), $spec_ptr_to(^AbsStack));
    // *(*((S->abs))->high_mark) := -(*((*((S->abs))->high_mark)), 1); 
    call $write_int($dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark), $mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark)) - 1);
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
    assert $top_writable($s, #wrTime$1^131.1, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(*((S->abs))), staticWrapState#37, owns#38)
    call $static_wrap($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), staticWrapState#37, owns#38);
    assume $good_state_ext(#tok$1^143.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((S->abs))), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack)), $set_empty());
    // assert @inv_check(<=(*((*((S->abs))->high_mark)), *((*((S->abs))->capacity)))); 
    assert $mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark)) <= $mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.capacity));
    // assert @inv_check(@_vcc_is_malloc_root(@state, *((S->abs)))); 
    assert $is_malloc_root($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
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
    assert $top_writable($s, #wrTime$1^131.1, $ptr(^Stack, P#S));
    // assert @_vcc_wrapped(@state, *((S->elementsAsArray))); 
    assert $wrapped($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))), $typ($int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray)))));
    // assert @writes_check(*((S->elementsAsArray))); 
    assert $top_writable($s, #wrTime$1^131.1, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))));
    // owns#41 := pure(@_vcc_set_union(owns#41, @_vcc_set_singleton(*((S->elementsAsArray))))); 
    owns#41 := $set_union(owns#41, $set_singleton($int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#41, $ptrset_to_int(owns#41), ^$#ptrset);
    // staticWrapState#40 := pure(@_vcc_take_over(staticWrapState#40, S, *((S->elementsAsArray)))); 
    staticWrapState#40 := $take_over(staticWrapState#40, $ptr(^Stack, P#S), $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#40, $state_to_int(staticWrapState#40), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((S->abs))); 
    assert $wrapped($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), ^AbsStack);
    // assert @writes_check(*((S->abs))); 
    assert $top_writable($s, #wrTime$1^131.1, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    // owns#41 := pure(@_vcc_set_union(owns#41, @_vcc_set_singleton(*((S->abs))))); 
    owns#41 := $set_union(owns#41, $set_singleton($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#41, $ptrset_to_int(owns#41), ^$#ptrset);
    // staticWrapState#40 := pure(@_vcc_take_over(staticWrapState#40, S, *((S->abs)))); 
    staticWrapState#40 := $take_over(staticWrapState#40, $ptr(^Stack, P#S), $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#40, $state_to_int(staticWrapState#40), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(S), staticWrapState#40, owns#41)
    call $static_wrap($ptr(^Stack, P#S), staticWrapState#40, owns#41);
    assume $good_state_ext(#tok$1^144.21, $s);
    // assert @inv_check(==(*((S->elementsAsArray)), @_vcc_as_array(*((S->elements)), *((S->capacity))))); 
    assert $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))) == $as_array($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.elements), ^^u4), ^^u4, $mem($s, $dot($ptr(^Stack, P#S), Stack.capacity)));
    // assert @inv_check(@keeps_stable(old(prestate#42, *((S->abs))), *((S->abs)))); 
    assert $read_ptr(prestate#42, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack) == $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack);
    // assert @inv_check(@keeps(S, *((S->abs)))); 
    assert $keeps($s, $ptr(^Stack, P#S), $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    // assert @inv_check(@keeps_stable(old(prestate#42, *((S->elementsAsArray))), *((S->elementsAsArray)))); 
    assert $int_to_ptr($mem(prestate#42, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))) == $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray)));
    // assert @inv_check(@keeps(S, *((S->elementsAsArray)))); 
    assert $keeps($s, $ptr(^Stack, P#S), $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))));
    // assert @inv_check(@_vcc_is_malloc_root(@state, S)); 
    assert $is_malloc_root($s, $ptr(^Stack, P#S));
    // assert @inv_check(@_vcc_is_malloc_root(@state, *((S->elementsAsArray)))); 
    assert $is_malloc_root($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))));
    // assert @inv_check(<=(*((S->topOfStack)), *((S->capacity)))); 
    assert $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) <= $mem($s, $dot($ptr(^Stack, P#S), Stack.capacity));
    // assert @inv_check(AbstractionRelation(S)); 
    assert F#AbstractionRelation($s, $ref($ptr(^Stack, P#S)));
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
  ensures $mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark)) == $mem(old($s), $dot($read_ptr(old($s), $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark)) + 1;
  ensures (forall Q#idx$1^153.29#tc1: int :: $in_range_u4(Q#idx$1^153.29#tc1) ==> Q#idx$1^153.29#tc1 < $mem(old($s), $dot($read_ptr(old($s), $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark)) ==> $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($mem(old($s), $dot($read_ptr(old($s), $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.entries))), Q#idx$1^153.29#tc1) == $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.entries))), Q#idx$1^153.29#tc1));
  ensures $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.entries))), $mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark)) - 1) == P#X;
  ensures $wrapped($s, $ptr(^Stack, P#S), ^Stack);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Stack, P#S) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Stack, P#S) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Stack, P#S) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Push(P#S: int, P#X: int)
{
  var owns#55: $ptrset;
  var staticWrapState#54: $state;
  var prestate#56: $state;
  var owns#52: $ptrset;
  var staticWrapState#51: $state;
  var prestate#53: $state;
  var assignOp#1: int where $in_range_spec_ptr(assignOp#1);
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
    assume $local_value_is($s, #tok$1^147.1, #loc.S, $ptr_to_int($ptr(^Stack, P#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^147.1, #loc.S, $ptr(^Stack, P#S), $ptr_to(^Stack));
    assume $local_value_is($s, #tok$1^147.1, #loc.X, P#X, ^^u4);
    assume #wrTime$1^147.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^147.1, #p) } $in_writes_at(#wrTime$1^147.1, #p) == (#p == $ptr(^Stack, P#S)));
    assume $thread_owned($s, $ptr(^Stack, P#S));
    // assume @in_range_phys_ptr((mathint)S); 
    assume $in_range_phys_ptr($ref($ptr(^Stack, P#S)));
    // assume @in_range_u4(X); 
    assume $in_range_u4(P#X);
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $ptr(^Stack, P#S), $ptr(^Stack, P#S), l#public);
    // assert @_vcc_in_domain(@state, *((S->elementsAsArray)), S); 
    assert $in_domain_lab($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))), $ptr(^Stack, P#S), l#public);
    // assume @_vcc_in_domain(@state, *((S->elementsAsArray)), S); 
    assume $in_domain_lab($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))), $ptr(^Stack, P#S), l#public);
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
    assert $wrapped($s, $ptr(^Stack, P#S), ^Stack);
    // assert @writes_check(S); 
    assert $top_writable($s, #wrTime$1^147.1, $ptr(^Stack, P#S));
    // assume @_vcc_inv(@state, S); 
    assume $inv($s, $ptr(^Stack, P#S), ^Stack);
    // prestate#45 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#45, S, *((S->elementsAsArray)))); 
    prestate#45 := $release($current_state($s), prestate#45, $ptr(^Stack, P#S), $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#45, $state_to_int(prestate#45), ^$#state_t);
    // owns#44 := pure(@_vcc_set_union(owns#44, @_vcc_set_singleton(*((S->elementsAsArray))))); 
    owns#44 := $set_union(owns#44, $set_singleton($int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#44, $ptrset_to_int(owns#44), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((S->elementsAsArray)))); 
    assume $typed($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))));
    // prestate#45 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#45, S, *((S->abs)))); 
    prestate#45 := $release($current_state($s), prestate#45, $ptr(^Stack, P#S), $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#45, $state_to_int(prestate#45), ^$#state_t);
    // owns#44 := pure(@_vcc_set_union(owns#44, @_vcc_set_singleton(*((S->abs))))); 
    owns#44 := $set_union(owns#44, $set_singleton($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#44, $ptrset_to_int(owns#44), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((S->abs)))); 
    assume $typed($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    // assume ==(owns#44, @_vcc_owns(@state, S)); 
    assume owns#44 == $owns($s, $ptr(^Stack, P#S));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(S), prestate#45)
    call $static_unwrap($ptr(^Stack, P#S), prestate#45);
    assume $good_state_ext(#tok$1^157.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#46; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#46, $state_to_int(prestate#46), ^$#state_t);
    // prestate#46 := @_vcc_current_state(@state); 
    prestate#46 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#46, $state_to_int(prestate#46), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((S->elementsAsArray))); 
    assert $wrapped($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))), $typ($int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray)))));
    // assume @_vcc_inv(@state, *((S->elementsAsArray))); 
    assume $inv($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))), $typ($int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray)))));
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(*((S->elementsAsArray))); 
    assert $top_writable($s, #wrTime$1^147.1, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))));
    // assert @reads_check_normal((S->elementsAsArray)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray), $ptr_to(^^void));
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray), $ptr_to(^^void));
    // stmt @_vcc_unwrap(*((S->elementsAsArray)), @_vcc_typeof(*((S->elementsAsArray)))); 
    call $unwrap($int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))), $typ($int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray)))));
    assume $good_state_ext(#tok$1^158.21, $s);
    // assert @_vcc_inv2(prestate#46, @_vcc_current_state(@state), *((S->elementsAsArray))); 
    assert $inv2(prestate#46, $current_state($s), $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))), $typ($int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray)))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, *((S->elements))[*((S->topOfStack))]); 
    assert $typed2($s, $idx($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.elements), ^^u4), $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)), ^^u4), ^^u4);
    // assert @prim_writes_check(*((S->elements))[*((S->topOfStack))]); 
    assert $writable($s, #wrTime$1^147.1, $idx($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.elements), ^^u4), $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)), ^^u4));
    // assert @reads_check_normal((S->elements)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.elements), $ptr_to(^^u4));
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.elements), $ptr_to(^^u4));
    // assert @reads_check_normal((S->topOfStack)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    // **((S->elements))[*((S->topOfStack))] := X; 
    call $write_int($idx($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.elements), ^^u4), $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)), ^^u4), P#X);
    assume $full_stop_ext(#tok$1^159.5, $s);
    // _math state_t prestate#47; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#47, $state_to_int(prestate#47), ^$#state_t);
    // prestate#47 := @_vcc_current_state(@state); 
    prestate#47 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#47, $state_to_int(prestate#47), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(*((S->elementsAsArray))); 
    assert $top_writable($s, #wrTime$1^147.1, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))));
    // assert @writes_check(@_vcc_owns(@state, *((S->elementsAsArray)))); 
    assert (forall #writes$1^160.21: $ptr :: { $dont_instantiate(#writes$1^160.21) } $set_in(#writes$1^160.21, $owns($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))))) ==> $top_writable($s, #wrTime$1^147.1, #writes$1^160.21));
    // assert @reads_check_normal((S->elementsAsArray)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray), $ptr_to(^^void));
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray), $ptr_to(^^void));
    // stmt @_vcc_wrap(*((S->elementsAsArray)), @_vcc_typeof(*((S->elementsAsArray)))); 
    call $wrap($int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))), $typ($int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray)))));
    assume $good_state_ext(#tok$1^160.21, $s);
    // assert @_vcc_inv2(prestate#47, @_vcc_current_state(@state), *((S->elementsAsArray))); 
    assert $inv2(prestate#47, $current_state($s), $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))), $typ($int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray)))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (S->topOfStack)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    // assert @prim_writes_check((S->topOfStack)); 
    assert $writable($s, #wrTime$1^147.1, $dot($ptr(^Stack, P#S), Stack.topOfStack));
    // assert @in_range_u4(+(*((S->topOfStack)), 1)); 
    assert $in_range_u4($mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) + 1);
    // assert @reads_check_normal((S->topOfStack)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
    // *(S->topOfStack) := +(*((S->topOfStack)), 1); 
    call $write_int($dot($ptr(^Stack, P#S), Stack.topOfStack), $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) + 1);
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
    assert $wrapped($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), ^AbsStack);
    // assert @writes_check(*((S->abs))); 
    assert $top_writable($s, #wrTime$1^147.1, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    // assume @_vcc_inv(@state, *((S->abs))); 
    assume $inv($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), ^AbsStack);
    // assume ==(owns#49, @_vcc_owns(@state, *((S->abs)))); 
    assume owns#49 == $owns($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(*((S->abs))), prestate#50)
    call $static_unwrap($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), prestate#50);
    assume $good_state_ext(#tok$1^162.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // (uint32_t -> uint32_t)^ assignOp#1; 
    assume $local_value_is($s, #tok$2^0.0, #loc.assignOp#1, $ptr_to_int($ptr($map_t(^^u4, ^^u4), assignOp#1)), $spec_ptr_to($map_t(^^u4, ^^u4))) && $local_value_is_ptr($s, #tok$2^0.0, #loc.assignOp#1, $ptr($map_t(^^u4, ^^u4), assignOp#1), $spec_ptr_to($map_t(^^u4, ^^u4)));
    // assert @reads_check_normal((S->abs)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.abs), $spec_ptr_to(^AbsStack));
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.abs), $spec_ptr_to(^AbsStack));
    // assignOp#1 := (*((S->abs))->entries); 
    assignOp#1 := $ref($dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.entries));
    assume $local_value_is($s, #tok$2^0.0, #loc.assignOp#1, $ptr_to_int($ptr($map_t(^^u4, ^^u4), assignOp#1)), $spec_ptr_to($map_t(^^u4, ^^u4))) && $local_value_is_ptr($s, #tok$2^0.0, #loc.assignOp#1, $ptr($map_t(^^u4, ^^u4), assignOp#1), $spec_ptr_to($map_t(^^u4, ^^u4)));
    // assert @_vcc_typed2(@state, assignOp#1); 
    assert $typed2($s, $ptr($map_t(^^u4, ^^u4), assignOp#1), $map_t(^^u4, ^^u4));
    // assert @prim_writes_check(assignOp#1); 
    assert $writable($s, #wrTime$1^147.1, $ptr($map_t(^^u4, ^^u4), assignOp#1));
    // assert @reads_check_normal(assignOp#1); 
    assert $typed2($s, $ptr($map_t(^^u4, ^^u4), assignOp#1), $map_t(^^u4, ^^u4));
    assert $thread_local2($s, $ptr($map_t(^^u4, ^^u4), assignOp#1), $map_t(^^u4, ^^u4));
    // assert @reads_check_normal((*((S->abs))->high_mark)); 
    assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark), ^^u4);
    assert $thread_local2($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark), ^^u4);
    // assert @reads_check_normal((S->abs)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.abs), $spec_ptr_to(^AbsStack));
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.abs), $spec_ptr_to(^AbsStack));
    // *assignOp#1 := @map_updated(*(assignOp#1), *((*((S->abs))->high_mark)), X); 
    call $write_int($ptr($map_t(^^u4, ^^u4), assignOp#1), $map_t..^^u4.^^u4_to_int($store.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($mem($s, $ptr($map_t(^^u4, ^^u4), assignOp#1))), $mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark)), P#X)));
    assume $full_stop_ext(#tok$1^164.9, $s);
    // assert @_vcc_typed2(@state, (*((S->abs))->high_mark)); 
    assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark), ^^u4);
    // assert @prim_writes_check((*((S->abs))->high_mark)); 
    assert $writable($s, #wrTime$1^147.1, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark));
    // assert @reads_check_normal((S->abs)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.abs), $spec_ptr_to(^AbsStack));
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.abs), $spec_ptr_to(^AbsStack));
    // assert @in_range_u4(+(*((*((S->abs))->high_mark)), 1)); 
    assert $in_range_u4($mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark)) + 1);
    // assert @reads_check_normal((*((S->abs))->high_mark)); 
    assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark), ^^u4);
    assert $thread_local2($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark), ^^u4);
    // assert @reads_check_normal((S->abs)); 
    assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.abs), $spec_ptr_to(^AbsStack));
    assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.abs), $spec_ptr_to(^AbsStack));
    // *(*((S->abs))->high_mark) := +(*((*((S->abs))->high_mark)), 1); 
    call $write_int($dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark), $mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark)) + 1);
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
    assert $top_writable($s, #wrTime$1^147.1, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(*((S->abs))), staticWrapState#51, owns#52)
    call $static_wrap($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), staticWrapState#51, owns#52);
    assume $good_state_ext(#tok$1^167.21, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((S->abs))), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack)), $set_empty());
    // assert @inv_check(<=(*((*((S->abs))->high_mark)), *((*((S->abs))->capacity)))); 
    assert $mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark)) <= $mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.capacity));
    // assert @inv_check(@_vcc_is_malloc_root(@state, *((S->abs)))); 
    assert $is_malloc_root($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
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
    assert $top_writable($s, #wrTime$1^147.1, $ptr(^Stack, P#S));
    // assert @_vcc_wrapped(@state, *((S->elementsAsArray))); 
    assert $wrapped($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))), $typ($int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray)))));
    // assert @writes_check(*((S->elementsAsArray))); 
    assert $top_writable($s, #wrTime$1^147.1, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))));
    // owns#55 := pure(@_vcc_set_union(owns#55, @_vcc_set_singleton(*((S->elementsAsArray))))); 
    owns#55 := $set_union(owns#55, $set_singleton($int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#55, $ptrset_to_int(owns#55), ^$#ptrset);
    // staticWrapState#54 := pure(@_vcc_take_over(staticWrapState#54, S, *((S->elementsAsArray)))); 
    staticWrapState#54 := $take_over(staticWrapState#54, $ptr(^Stack, P#S), $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#54, $state_to_int(staticWrapState#54), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((S->abs))); 
    assert $wrapped($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), ^AbsStack);
    // assert @writes_check(*((S->abs))); 
    assert $top_writable($s, #wrTime$1^147.1, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    // owns#55 := pure(@_vcc_set_union(owns#55, @_vcc_set_singleton(*((S->abs))))); 
    owns#55 := $set_union(owns#55, $set_singleton($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#55, $ptrset_to_int(owns#55), ^$#ptrset);
    // staticWrapState#54 := pure(@_vcc_take_over(staticWrapState#54, S, *((S->abs)))); 
    staticWrapState#54 := $take_over(staticWrapState#54, $ptr(^Stack, P#S), $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#54, $state_to_int(staticWrapState#54), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(S), staticWrapState#54, owns#55)
    call $static_wrap($ptr(^Stack, P#S), staticWrapState#54, owns#55);
    assume $good_state_ext(#tok$1^168.21, $s);
    // assert @inv_check(==(*((S->elementsAsArray)), @_vcc_as_array(*((S->elements)), *((S->capacity))))); 
    assert $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))) == $as_array($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.elements), ^^u4), ^^u4, $mem($s, $dot($ptr(^Stack, P#S), Stack.capacity)));
    // assert @inv_check(@keeps_stable(old(prestate#56, *((S->abs))), *((S->abs)))); 
    assert $read_ptr(prestate#56, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack) == $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack);
    // assert @inv_check(@keeps(S, *((S->abs)))); 
    assert $keeps($s, $ptr(^Stack, P#S), $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack));
    // assert @inv_check(@keeps_stable(old(prestate#56, *((S->elementsAsArray))), *((S->elementsAsArray)))); 
    assert $int_to_ptr($mem(prestate#56, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))) == $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray)));
    // assert @inv_check(@keeps(S, *((S->elementsAsArray)))); 
    assert $keeps($s, $ptr(^Stack, P#S), $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))));
    // assert @inv_check(@_vcc_is_malloc_root(@state, S)); 
    assert $is_malloc_root($s, $ptr(^Stack, P#S));
    // assert @inv_check(@_vcc_is_malloc_root(@state, *((S->elementsAsArray)))); 
    assert $is_malloc_root($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))));
    // assert @inv_check(<=(*((S->topOfStack)), *((S->capacity)))); 
    assert $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)) <= $mem($s, $dot($ptr(^Stack, P#S), Stack.capacity));
    // assert @inv_check(AbstractionRelation(S)); 
    assert F#AbstractionRelation($s, $ref($ptr(^Stack, P#S)));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



function F#IsIn(#s: $state, P#S: int, P#value: int) : bool;

const unique cf#IsIn: $pure_function;

axiom (forall #s: $state, P#S: int, P#value: int :: { F#IsIn(#s, P#S, P#value) } $wrapped(#s, $ptr(^Stack, P#S), ^Stack) ==> F#IsIn(#s, P#S, P#value) == (exists Q#v$1^175.29#tc1: int :: $in_range_u4(Q#v$1^175.29#tc1) && Q#v$1^175.29#tc1 < $mem(#s, $dot($read_ptr(#s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark)) && $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($mem(#s, $dot($read_ptr(#s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.entries))), Q#v$1^175.29#tc1) == P#value));

axiom $function_arg_type(cf#IsIn, 0, ^^bool);

axiom $function_arg_type(cf#IsIn, 1, $ptr_to(^Stack));

axiom $function_arg_type(cf#IsIn, 2, ^^u4);

procedure IsIn(P#S: int, P#value: int) returns ($result: bool);
  requires $wrapped($s, $ptr(^Stack, P#S), ^Stack);
  ensures $result == (exists Q#v$1^175.29#tc1: int :: $in_range_u4(Q#v$1^175.29#tc1) && Q#v$1^175.29#tc1 < $mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.high_mark)) && $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.entries))), Q#v$1^175.29#tc1) == P#value);
  free ensures $result == F#IsIn($s, P#S, P#value);
  free ensures $call_transition(old($s), $s);



implementation IsIn(P#S: int, P#value: int) returns ($result: bool)
{
  var loopState#0: $state;
  var L#index: int where $in_range_u4(L#index);
  var #wrTime$1^171.17: int;
  var #stackframe: int;

  anon38:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^171.17, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^171.17, #loc.S, $ptr_to_int($ptr(^Stack, P#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^171.17, #loc.S, $ptr(^Stack, P#S), $ptr_to(^Stack));
    assume $local_value_is($s, #tok$1^171.17, #loc.value, P#value, ^^u4);
    assume #wrTime$1^171.17 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^171.17, #p) } $in_writes_at(#wrTime$1^171.17, #p) == false);
    // assume @in_range_phys_ptr((mathint)S); 
    assume $in_range_phys_ptr($ref($ptr(^Stack, P#S)));
    // assume @in_range_u4(value); 
    assume $in_range_u4(P#value);
    // assert @_vcc_in_domain(@state, S, S); 
    assert $in_domain_lab($s, $ptr(^Stack, P#S), $ptr(^Stack, P#S), l#public);
    // uint32_t index; 
    assume $local_value_is($s, #tok$1^177.5, #loc.index, L#index, ^^u4);
    // var uint32_t index
    // assert @_vcc_in_domain(@state, *((S->elementsAsArray)), S); 
    assert $in_domain_lab($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))), $ptr(^Stack, P#S), l#public);
    // assume @_vcc_in_domain(@state, *((S->elementsAsArray)), S); 
    assume $in_domain_lab($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))), $ptr(^Stack, P#S), l#public);
    // assert @_vcc_in_domain(@state, *((S->abs)), S); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), $ptr(^Stack, P#S), l#public);
    // assume @_vcc_in_domain(@state, *((S->abs)), S); 
    assume $in_domain_lab($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), $ptr(^Stack, P#S), l#public);
    // index := 0; 
    L#index := 0;
    assume $local_value_is($s, #tok$1^182.10, #loc.index, L#index, ^^u4);
    loopState#0 := $s;
    while (true)
      invariant (forall Q#v$1^183.35#tc1: int :: $in_range_u4(Q#v$1^183.35#tc1) ==> Q#v$1^183.35#tc1 < L#index ==> $select.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($mem($s, $dot($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), AbsStack.entries))), Q#v$1^183.35#tc1) != P#value);
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
        assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
        assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.topOfStack), ^^u4);
        assume true;
        // if (<(index, *((S->topOfStack)))) ...
        if (L#index < $mem($s, $dot($ptr(^Stack, P#S), Stack.topOfStack)))
        {
          anon35:
            // assert @reads_check_normal(*((S->elements))[index]); 
            assert $typed2($s, $idx($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.elements), ^^u4), L#index, ^^u4), ^^u4);
            assert $thread_local2($s, $idx($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.elements), ^^u4), L#index, ^^u4), ^^u4);
            // assert @reads_check_normal((S->elements)); 
            assert $typed2($s, $dot($ptr(^Stack, P#S), Stack.elements), $ptr_to(^^u4));
            assert $thread_local2($s, $dot($ptr(^Stack, P#S), Stack.elements), $ptr_to(^^u4));
            assume true;
            // if (==(*(*((S->elements))[index]), value)) ...
            if ($mem($s, $idx($read_ptr($s, $dot($ptr(^Stack, P#S), Stack.elements), ^^u4), L#index, ^^u4)) == P#value)
            {
              anon33:
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



procedure IsFull#reads(P#S: int);
  requires $reads_check_pre($s);
  modifies $s, $cev_pc;
  ensures F#IsFull(old($s), $ref($ptr(^Stack, P#S))) == F#IsFull($s, $ref($ptr(^Stack, P#S)));
  ensures $reads_check_post($s);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation IsFull#reads(P#S: int)
{
  var #wrTime$1^49.17: int;
  var #stackframe: int;

  anon41:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^49.17, $s);
    assume $local_value_is($s, #tok$1^49.17, #loc.S, $ptr_to_int($ptr(^Stack, P#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^49.17, #loc.S, $ptr(^Stack, P#S), $ptr_to(^Stack));
    assume #wrTime$1^49.17 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^49.17, #p) } $in_writes_at(#wrTime$1^49.17, #p) == false);
    // assume @_vcc_wrapped(@state, S); 
    assume $wrapped($s, $ptr(^Stack, P#S), ^Stack);
    // assume @_vcc_in_domain(@state, S, S); 
    assume $in_domain_lab($s, $ptr(^Stack, P#S), $ptr(^Stack, P#S), l#public);
    // assume @_vcc_in_domain(@state, *((S->elementsAsArray)), S); 
    assume $in_domain_lab($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))), $ptr(^Stack, P#S), l#public);
    // assume @_vcc_in_domain(@state, *((S->abs)), S); 
    assume $in_domain_lab($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), $ptr(^Stack, P#S), l#public);
    // @_vcc_reads_havoc
    call $reads_havoc();
    assume $full_stop_ext(#tok$1^49.17, $s);
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
  var #wrTime$1^40.17: int;
  var #stackframe: int;

  anon42:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^40.17, $s);
    assume $local_value_is($s, #tok$1^40.17, #loc.S, $ptr_to_int($ptr(^Stack, P#S)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^40.17, #loc.S, $ptr(^Stack, P#S), $ptr_to(^Stack));
    assume #wrTime$1^40.17 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^40.17, #p) } $in_writes_at(#wrTime$1^40.17, #p) == false);
    // assume @_vcc_wrapped(@state, S); 
    assume $wrapped($s, $ptr(^Stack, P#S), ^Stack);
    // assume @_vcc_in_domain(@state, S, S); 
    assume $in_domain_lab($s, $ptr(^Stack, P#S), $ptr(^Stack, P#S), l#public);
    // assume @_vcc_in_domain(@state, *((S->elementsAsArray)), S); 
    assume $in_domain_lab($s, $int_to_ptr($mem($s, $dot($ptr(^Stack, P#S), Stack.elementsAsArray))), $ptr(^Stack, P#S), l#public);
    // assume @_vcc_in_domain(@state, *((S->abs)), S); 
    assume $in_domain_lab($s, $read_ptr($s, $dot($ptr(^Stack, P#S), Stack.abs), ^AbsStack), $ptr(^Stack, P#S), l#public);
    // @_vcc_reads_havoc
    call $reads_havoc();
    assume $full_stop_ext(#tok$1^40.17, $s);
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

const unique #distTp6: $ctype;

axiom #distTp6 == $spec_ptr_to($map_t(^^u4, ^^u4));

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

const unique #distTp5: $ctype;

axiom #distTp5 == $ptr_to(^Stack);

const unique #tok$1^16.1: $token;

const unique #distTp4: $ctype;

axiom #distTp4 == $ptr_to(^^void);

const unique #distTp3: $ctype;

axiom #distTp3 == $ptr_to(^^u4);

const unique #distTp2: $ctype;

axiom #distTp2 == $spec_ptr_to(^AbsStack);

const unique #loc._this_: $token;

const unique #tok$1^7.23: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CStackAsArray.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CStackAsArray.c);

const unique #distTp1: $ctype;

axiom #distTp1 == $map_t(^^u4, ^^u4);
