axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^Node: $ctype;

axiom $is_composite(^Node);

axiom $ptr_level(^Node) == 0;

axiom $sizeof(^Node) == 8;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Node) } $inv2(#s1, #s2, #p, ^Node) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty()) && $depends(#s1, #s2, $owner(#s2, #p), #p)));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^Node, #r), l#public) } $inv_lab(#s2, $ptr(^Node, #r), l#public) == ($typed(#s2, $ptr(^Node, #r)) && $set_eq($owns(#s2, $ptr(^Node, #r)), $set_empty()) && $depends(#s2, #s2, $owner(#s2, $ptr(^Node, #r)), $ptr(^Node, #r))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^Node, #r)) } $in_full_extent_of(#q, $ptr(^Node, #r)) == (#q == $ptr(^Node, #r) || #q == $dot($ptr(^Node, #r), Node.$owns) || #q == $dot($ptr(^Node, #r), Node.next)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Node, #r)) } $in_extent_of(#s, #q, $ptr(^Node, #r)) == $in_struct_extent_of(#q, $ptr(^Node, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Node, #r)) } $typed(#s, $ptr(^Node, #r)) ==> $in_extent_of(#s, #q, $ptr(^Node, #r)) == (#q == $ptr(^Node, #r) || $emb(#s, #q) == $ptr(^Node, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^Node, #r)) } $in_span_of(#q, $ptr(^Node, #r)) == (#q == $ptr(^Node, #r) || #q == $dot($ptr(^Node, #r), Node.$owns) || #q == $dot($ptr(^Node, #r), Node.next)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^Node) } $state_spans_the_same(#s1, #s2, #p, ^Node) == ($mem_eq(#s1, #s2, $dot(#p, Node.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Node.next))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Node) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Node) == ($mem_eq(#s1, #s2, $dot(#p, Node.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Node.next))));

axiom $is_claimable(^Node) == false;

axiom $has_volatile_owns_set(^Node) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^Node, #r)) } $extent_mutable(#s1, $ptr(^Node, #r)) == $mutable(#s1, $ptr(^Node, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^Node, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^Node, #r)) == $is_fresh(#s1, #s2, $ptr(^Node, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^Node, #r)) } $extent_zero(#s1, $ptr(^Node, #r)) == ($mem(#s1, $dot($ptr(^Node, #r), Node.next)) == 0));

const unique Node.$owns: $field;

axiom $static_field_properties(Node.$owns, ^Node);

axiom $is_primitive_non_volatile_field(Node.$owns);

axiom (forall #p: $ptr :: { $dot(#p, Node.$owns) } $is(#p, ^Node) ==> $dot(#p, Node.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, Node.$owns)) && $extent_hint($dot(#p, Node.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.$owns)) } { $st(#s, $dot(#p, Node.$owns)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.$owns, ^$#ptrset, false));

axiom $owns_set_field(^Node) == Node.$owns;

const unique Node.next: $field;

axiom $static_field_properties(Node.next, ^Node);

axiom $is_primitive_non_volatile_field(Node.next);

axiom $field_offset(Node.next) == 0;

axiom (forall #p: $ptr :: { $dot(#p, Node.next) } $is(#p, ^Node) ==> $dot(#p, Node.next) == $ptr($ptr_to(^Node), $ref(#p) + 0) && $extent_hint($dot(#p, Node.next), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Node.next)) } { $st(#s, $dot(#p, Node.next)) } $typed2(#s, #p, ^Node) ==> $field_properties(#s, #p, Node.next, $ptr_to(^Node), false));

procedure Node#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $set_eq($owns($s, $ptr(^Node, P#_this_)), $set_empty());
  ensures $is_admissibility_check() ==> $depends(old($s), $s, $owner($s, $ptr(^Node, P#_this_)), $ptr(^Node, P#_this_));
  ensures $is_stuttering_check() ==> $depends($s, $s, $owner($s, $ptr(^Node, P#_this_)), $ptr(^Node, P#_this_));
  ensures $is_unwrap_check() ==> $set_eq($owns($s, $ptr(^Node, P#_this_)), $set_empty());
  ensures $is_unwrap_check() ==> $depends(old($s), $s, $owner($s, $ptr(^Node, P#_this_)), $ptr(^Node, P#_this_));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Node#adm(P#_this_: int)
{
  var #wrTime$1^12.9: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^12.9, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^12.9, #loc._this_, $ptr_to_int($ptr(^Node, P#_this_)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^12.9, #loc._this_, $ptr(^Node, P#_this_), $ptr_to(^Node));
    assume #wrTime$1^12.9 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^12.9, #p) } $in_writes_at(#wrTime$1^12.9, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^Node, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^Node, P#_this_));
        assume $good_state_ext(#tok$1^12.9, $s);
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
            assume $admissibility_pre($s, $ptr(^Node, P#_this_));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^Node, P#_this_));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Node*)@null))
        call $havoc_others($ptr(^Node, P#_this_), ^Node);
        assume $good_state_ext(#tok$1^12.9, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^Node, P#_this_), ^Node);
    }

  #exit:
}



const unique ^Stack: $ctype;

axiom $is_composite(^Stack);

axiom $ptr_level(^Stack) == 0;

axiom $sizeof(^Stack) == 8;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Stack) } $inv2(#s1, #s2, #p, ^Stack) == ($typed(#s2, #p) && $ptr_eq($read_ptr(#s2, $dot(#p, Stack.hd), ^Node), $null) == $set_eq($owns(#s2, #p), $set_empty()) && $ptr_neq($read_ptr(#s2, $dot(#p, Stack.hd), ^Node), $null) == !$set_eq($owns(#s2, #p), $set_empty()) && $ptr_neq($read_ptr(#s2, $dot(#p, Stack.hd), ^Node), $null) == $set_in($read_ptr(#s2, $dot(#p, Stack.hd), ^Node), $owns(#s2, #p)) && ($ptr_neq($read_ptr(#s2, $dot(#p, Stack.hd), ^Node), $null) ==> (forall Q#x$1^36.20#dt1: int :: { $set_in($ptr(^Node, Q#x$1^36.20#dt1), $owns(#s2, #p)) } $in_range_phys_ptr($ref($ptr(^Node, Q#x$1^36.20#dt1))) ==> $set_in($ptr(^Node, Q#x$1^36.20#dt1), $owns(#s2, #p)) ==> $typed2(#s2, $ptr(^Node, Q#x$1^36.20#dt1), ^Node) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, Q#x$1^36.20#dt1), Node.next), ^Node), $read_ptr(#s2, $dot(#p, Stack.hd), ^Node)))) && ($ptr_neq($read_ptr(#s2, $dot(#p, Stack.hd), ^Node), $null) ==> (forall Q#x$1^38.20#dt1: int :: { $set_in($read_ptr(#s2, $dot($ptr(^Node, Q#x$1^38.20#dt1), Node.next), ^Node), $owns(#s2, #p)) } $in_range_phys_ptr($ref($ptr(^Node, Q#x$1^38.20#dt1))) ==> $set_in($ptr(^Node, Q#x$1^38.20#dt1), $owns(#s2, #p)) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, Q#x$1^38.20#dt1), Node.next), ^Node), $null) ==> $set_in($read_ptr(#s2, $dot($ptr(^Node, Q#x$1^38.20#dt1), Node.next), ^Node), $owns(#s2, #p)))) && ($ptr_neq($read_ptr(#s2, $dot(#p, Stack.hd), ^Node), $null) ==> (forall Q#x$1^40.19#dt1: int, Q#y$1^40.19#dt1: int :: { $read_ptr(#s2, $dot($ptr(^Node, Q#x$1^40.19#dt1), Node.next), ^Node), $read_ptr(#s2, $dot($ptr(^Node, Q#y$1^40.19#dt1), Node.next), ^Node) } $in_range_phys_ptr($ref($ptr(^Node, Q#x$1^40.19#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#y$1^40.19#dt1))) ==> $set_in($ptr(^Node, Q#x$1^40.19#dt1), $owns(#s2, #p)) && $set_in($ptr(^Node, Q#y$1^40.19#dt1), $owns(#s2, #p)) && $ptr_eq($read_ptr(#s2, $dot($ptr(^Node, Q#x$1^40.19#dt1), Node.next), ^Node), $read_ptr(#s2, $dot($ptr(^Node, Q#y$1^40.19#dt1), Node.next), ^Node)) ==> $ptr_eq($ptr(^Node, Q#x$1^40.19#dt1), $ptr(^Node, Q#y$1^40.19#dt1))))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^Stack, #r), l#public) } $inv_lab(#s2, $ptr(^Stack, #r), l#public) == ($typed(#s2, $ptr(^Stack, #r)) && $ptr_eq($read_ptr(#s2, $dot($ptr(^Stack, #r), Stack.hd), ^Node), $null) == $set_eq($owns(#s2, $ptr(^Stack, #r)), $set_empty()) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Stack, #r), Stack.hd), ^Node), $null) == !$set_eq($owns(#s2, $ptr(^Stack, #r)), $set_empty()) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Stack, #r), Stack.hd), ^Node), $null) == $set_in($read_ptr(#s2, $dot($ptr(^Stack, #r), Stack.hd), ^Node), $owns(#s2, $ptr(^Stack, #r))) && ($ptr_neq($read_ptr(#s2, $dot($ptr(^Stack, #r), Stack.hd), ^Node), $null) ==> (forall Q#x$1^36.20#dt1: int :: { $set_in($ptr(^Node, Q#x$1^36.20#dt1), $owns(#s2, $ptr(^Stack, #r))) } $in_range_phys_ptr($ref($ptr(^Node, Q#x$1^36.20#dt1))) ==> $set_in($ptr(^Node, Q#x$1^36.20#dt1), $owns(#s2, $ptr(^Stack, #r))) ==> $typed2(#s2, $ptr(^Node, Q#x$1^36.20#dt1), ^Node) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, Q#x$1^36.20#dt1), Node.next), ^Node), $read_ptr(#s2, $dot($ptr(^Stack, #r), Stack.hd), ^Node)))) && ($ptr_neq($read_ptr(#s2, $dot($ptr(^Stack, #r), Stack.hd), ^Node), $null) ==> (forall Q#x$1^38.20#dt1: int :: { $set_in($read_ptr(#s2, $dot($ptr(^Node, Q#x$1^38.20#dt1), Node.next), ^Node), $owns(#s2, $ptr(^Stack, #r))) } $in_range_phys_ptr($ref($ptr(^Node, Q#x$1^38.20#dt1))) ==> $set_in($ptr(^Node, Q#x$1^38.20#dt1), $owns(#s2, $ptr(^Stack, #r))) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Node, Q#x$1^38.20#dt1), Node.next), ^Node), $null) ==> $set_in($read_ptr(#s2, $dot($ptr(^Node, Q#x$1^38.20#dt1), Node.next), ^Node), $owns(#s2, $ptr(^Stack, #r))))) && ($ptr_neq($read_ptr(#s2, $dot($ptr(^Stack, #r), Stack.hd), ^Node), $null) ==> (forall Q#x$1^40.19#dt1: int, Q#y$1^40.19#dt1: int :: { $read_ptr(#s2, $dot($ptr(^Node, Q#x$1^40.19#dt1), Node.next), ^Node), $read_ptr(#s2, $dot($ptr(^Node, Q#y$1^40.19#dt1), Node.next), ^Node) } $in_range_phys_ptr($ref($ptr(^Node, Q#x$1^40.19#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#y$1^40.19#dt1))) ==> $set_in($ptr(^Node, Q#x$1^40.19#dt1), $owns(#s2, $ptr(^Stack, #r))) && $set_in($ptr(^Node, Q#y$1^40.19#dt1), $owns(#s2, $ptr(^Stack, #r))) && $ptr_eq($read_ptr(#s2, $dot($ptr(^Node, Q#x$1^40.19#dt1), Node.next), ^Node), $read_ptr(#s2, $dot($ptr(^Node, Q#y$1^40.19#dt1), Node.next), ^Node)) ==> $ptr_eq($ptr(^Node, Q#x$1^40.19#dt1), $ptr(^Node, Q#y$1^40.19#dt1))))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^Stack, #r)) } $in_full_extent_of(#q, $ptr(^Stack, #r)) == (#q == $ptr(^Stack, #r) || #q == $dot($ptr(^Stack, #r), Stack.$owns) || #q == $dot($ptr(^Stack, #r), Stack.hd)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Stack, #r)) } $in_extent_of(#s, #q, $ptr(^Stack, #r)) == $in_struct_extent_of(#q, $ptr(^Stack, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Stack, #r)) } $typed(#s, $ptr(^Stack, #r)) ==> $in_extent_of(#s, #q, $ptr(^Stack, #r)) == (#q == $ptr(^Stack, #r) || $emb(#s, #q) == $ptr(^Stack, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^Stack, #r)) } $in_span_of(#q, $ptr(^Stack, #r)) == (#q == $ptr(^Stack, #r) || #q == $dot($ptr(^Stack, #r), Stack.$owns) || #q == $dot($ptr(^Stack, #r), Stack.hd)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^Stack) } $state_spans_the_same(#s1, #s2, #p, ^Stack) == ($mem_eq(#s1, #s2, $dot(#p, Stack.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Stack.hd))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Stack) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Stack) == true);

axiom $is_claimable(^Stack) == false;

axiom $has_volatile_owns_set(^Stack) == true;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^Stack, #r)) } $extent_mutable(#s1, $ptr(^Stack, #r)) == $mutable(#s1, $ptr(^Stack, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^Stack, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^Stack, #r)) == $is_fresh(#s1, #s2, $ptr(^Stack, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^Stack, #r)) } $extent_zero(#s1, $ptr(^Stack, #r)) == ($mem(#s1, $dot($ptr(^Stack, #r), Stack.hd)) == 0));

const unique Stack.$owns: $field;

axiom $static_field_properties(Stack.$owns, ^Stack);

axiom $is_primitive_volatile_field(Stack.$owns);

axiom (forall #p: $ptr :: { $dot(#p, Stack.$owns) } $is(#p, ^Stack) ==> $dot(#p, Stack.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, Stack.$owns)) && $extent_hint($dot(#p, Stack.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Stack.$owns)) } { $st(#s, $dot(#p, Stack.$owns)) } $typed2(#s, #p, ^Stack) ==> $field_properties(#s, #p, Stack.$owns, ^$#ptrset, true));

axiom $owns_set_field(^Stack) == Stack.$owns;

const unique Stack.hd: $field;

axiom $static_field_properties(Stack.hd, ^Stack);

axiom $is_primitive_volatile_field(Stack.hd);

axiom $field_offset(Stack.hd) == 0;

axiom (forall #p: $ptr :: { $dot(#p, Stack.hd) } $is(#p, ^Stack) ==> $dot(#p, Stack.hd) == $ptr($ptr_to(^Node), $ref(#p) + 0) && $extent_hint($dot(#p, Stack.hd), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Stack.hd)) } { $st(#s, $dot(#p, Stack.hd)) } $typed2(#s, #p, ^Stack) ==> $field_properties(#s, #p, Stack.hd, $ptr_to(^Node), true));

procedure Stack#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $ptr_eq($read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.hd), ^Node), $null) == $set_eq($owns($s, $ptr(^Stack, P#_this_)), $set_empty());
  ensures $is_admissibility_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.hd), ^Node), $null) == !$set_eq($owns($s, $ptr(^Stack, P#_this_)), $set_empty());
  ensures $is_admissibility_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.hd), ^Node), $null) == $set_in($read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.hd), ^Node), $owns($s, $ptr(^Stack, P#_this_)));
  ensures $is_admissibility_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.hd), ^Node), $null) ==> (forall Q#x$1^36.20#dt1: int :: { $set_in($ptr(^Node, Q#x$1^36.20#dt1), $owns($s, $ptr(^Stack, P#_this_))) } $in_range_phys_ptr($ref($ptr(^Node, Q#x$1^36.20#dt1))) ==> $set_in($ptr(^Node, Q#x$1^36.20#dt1), $owns($s, $ptr(^Stack, P#_this_))) ==> $typed2($s, $ptr(^Node, Q#x$1^36.20#dt1), ^Node) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, Q#x$1^36.20#dt1), Node.next), ^Node), $read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.hd), ^Node)));
  ensures $is_admissibility_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.hd), ^Node), $null) ==> (forall Q#x$1^38.20#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^Node, Q#x$1^38.20#dt1), Node.next), ^Node), $owns($s, $ptr(^Stack, P#_this_))) } $in_range_phys_ptr($ref($ptr(^Node, Q#x$1^38.20#dt1))) ==> $set_in($ptr(^Node, Q#x$1^38.20#dt1), $owns($s, $ptr(^Stack, P#_this_))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, Q#x$1^38.20#dt1), Node.next), ^Node), $null) ==> $set_in($read_ptr($s, $dot($ptr(^Node, Q#x$1^38.20#dt1), Node.next), ^Node), $owns($s, $ptr(^Stack, P#_this_))));
  ensures $is_admissibility_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.hd), ^Node), $null) ==> (forall Q#x$1^40.19#dt1: int, Q#y$1^40.19#dt1: int :: { $read_ptr($s, $dot($ptr(^Node, Q#x$1^40.19#dt1), Node.next), ^Node), $read_ptr($s, $dot($ptr(^Node, Q#y$1^40.19#dt1), Node.next), ^Node) } $in_range_phys_ptr($ref($ptr(^Node, Q#x$1^40.19#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#y$1^40.19#dt1))) ==> $set_in($ptr(^Node, Q#x$1^40.19#dt1), $owns($s, $ptr(^Stack, P#_this_))) && $set_in($ptr(^Node, Q#y$1^40.19#dt1), $owns($s, $ptr(^Stack, P#_this_))) && $ptr_eq($read_ptr($s, $dot($ptr(^Node, Q#x$1^40.19#dt1), Node.next), ^Node), $read_ptr($s, $dot($ptr(^Node, Q#y$1^40.19#dt1), Node.next), ^Node)) ==> $ptr_eq($ptr(^Node, Q#x$1^40.19#dt1), $ptr(^Node, Q#y$1^40.19#dt1)));
  ensures $is_unwrap_check() ==> $ptr_eq($read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.hd), ^Node), $null) == $set_eq($owns($s, $ptr(^Stack, P#_this_)), $set_empty());
  ensures $is_unwrap_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.hd), ^Node), $null) == !$set_eq($owns($s, $ptr(^Stack, P#_this_)), $set_empty());
  ensures $is_unwrap_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.hd), ^Node), $null) == $set_in($read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.hd), ^Node), $owns($s, $ptr(^Stack, P#_this_)));
  ensures $is_unwrap_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.hd), ^Node), $null) ==> (forall Q#x$1^36.20#dt1: int :: { $set_in($ptr(^Node, Q#x$1^36.20#dt1), $owns($s, $ptr(^Stack, P#_this_))) } $in_range_phys_ptr($ref($ptr(^Node, Q#x$1^36.20#dt1))) ==> $set_in($ptr(^Node, Q#x$1^36.20#dt1), $owns($s, $ptr(^Stack, P#_this_))) ==> $typed2($s, $ptr(^Node, Q#x$1^36.20#dt1), ^Node) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, Q#x$1^36.20#dt1), Node.next), ^Node), $read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.hd), ^Node)));
  ensures $is_unwrap_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.hd), ^Node), $null) ==> (forall Q#x$1^38.20#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^Node, Q#x$1^38.20#dt1), Node.next), ^Node), $owns($s, $ptr(^Stack, P#_this_))) } $in_range_phys_ptr($ref($ptr(^Node, Q#x$1^38.20#dt1))) ==> $set_in($ptr(^Node, Q#x$1^38.20#dt1), $owns($s, $ptr(^Stack, P#_this_))) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, Q#x$1^38.20#dt1), Node.next), ^Node), $null) ==> $set_in($read_ptr($s, $dot($ptr(^Node, Q#x$1^38.20#dt1), Node.next), ^Node), $owns($s, $ptr(^Stack, P#_this_))));
  ensures $is_unwrap_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Stack, P#_this_), Stack.hd), ^Node), $null) ==> (forall Q#x$1^40.19#dt1: int, Q#y$1^40.19#dt1: int :: { $read_ptr($s, $dot($ptr(^Node, Q#x$1^40.19#dt1), Node.next), ^Node), $read_ptr($s, $dot($ptr(^Node, Q#y$1^40.19#dt1), Node.next), ^Node) } $in_range_phys_ptr($ref($ptr(^Node, Q#x$1^40.19#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#y$1^40.19#dt1))) ==> $set_in($ptr(^Node, Q#x$1^40.19#dt1), $owns($s, $ptr(^Stack, P#_this_))) && $set_in($ptr(^Node, Q#y$1^40.19#dt1), $owns($s, $ptr(^Stack, P#_this_))) && $ptr_eq($read_ptr($s, $dot($ptr(^Node, Q#x$1^40.19#dt1), Node.next), ^Node), $read_ptr($s, $dot($ptr(^Node, Q#y$1^40.19#dt1), Node.next), ^Node)) ==> $ptr_eq($ptr(^Node, Q#x$1^40.19#dt1), $ptr(^Node, Q#y$1^40.19#dt1)));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Stack#adm(P#_this_: int)
{
  var #wrTime$1^29.32: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^29.32, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^29.32, #loc._this_, $ptr_to_int($ptr(^Stack, P#_this_)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^29.32, #loc._this_, $ptr(^Stack, P#_this_), $ptr_to(^Stack));
    assume #wrTime$1^29.32 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^29.32, #p) } $in_writes_at(#wrTime$1^29.32, #p) == false);
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
        assume $good_state_ext(#tok$1^29.32, $s);
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
        assume $good_state_ext(#tok$1^29.32, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^Stack, P#_this_), ^Stack);
    }

  #exit:
}



procedure push(P#n: int, P#s: int, SP#c: int) returns ($result: int);
  requires true;
  requires $set_eq($owns($s, $ptr(^Node, P#n)), $set_empty());
  requires $wrapped($s, $ptr(^^claim, SP#c), ^^claim);
  requires $valid_claim($s, $ptr(^^claim, SP#c));
  requires (forall #cs0: $state :: { $valid_claim(#cs0, $ptr(^^claim, SP#c)) } $valid_claim(#cs0, $ptr(^^claim, SP#c)) ==> $claimed_closed(#cs0, $ptr(^Stack, P#s)));
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  ensures $wrapped($s, $ptr(^^claim, SP#c), ^^claim) && $valid_claim($s, $ptr(^^claim, SP#c));
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $extent(old($s), $ptr(^Node, P#n))) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $extent(old($s), $ptr(^Node, P#n))) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $extent(old($s), $ptr(^Node, P#n))) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation push(P#n: int, P#s: int, SP#c: int) returns ($result: int)
{
  var prestate#11: $state;
  var prestate#9: $state;
  var owns#10: $ptrset;
  var ite#4: bool;
  var ite#3: bool;
  var res#2: int where $in_range_phys_ptr(res#2);
  var Destination#1: int where $in_range_phys_ptr(Destination#1);
  var beforeAtomicState#2: $state;
  var owns#7: $ptrset;
  var staticWrapState#6: $state;
  var prestate#8: $state;
  var atomicObj#13: $ptr;
  var beforeAtomicState#1: $state;
  var atomicObj#12: $ptr;
  var L#h: int where $in_range_phys_ptr(L#h);
  var L#ok: int where $in_range_i4(L#ok);
  var loopState#0: $state;
  var #wrTime$1^44.1: int;
  var #stackframe: int;

  anon25:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^44.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^44.1, #loc.n, $ptr_to_int($ptr(^Node, P#n)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^44.1, #loc.n, $ptr(^Node, P#n), $ptr_to(^Node));
    assume $local_value_is($s, #tok$1^44.1, #loc.s, $ptr_to_int($ptr(^Stack, P#s)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^44.1, #loc.s, $ptr(^Stack, P#s), $ptr_to(^Stack));
    assume $local_value_is($s, #tok$1^44.1, #loc.c, $ptr_to_int($ptr(^^claim, SP#c)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^44.1, #loc.c, $ptr(^^claim, SP#c), $spec_ptr_to(^^claim));
    assume #wrTime$1^44.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^44.1, #p) } $in_writes_at(#wrTime$1^44.1, #p) == $set_in(#p, $extent($s, $ptr(^Node, P#n))));
    assume (forall #p: $ptr :: { $extent_hint(#p, $ptr(^Node, P#n)) } $set_in(#p, $extent($s, $ptr(^Node, P#n))) ==> $mutable($s, #p));
    // assume @in_range_phys_ptr((mathint)n); 
    assume $in_range_phys_ptr($ref($ptr(^Node, P#n)));
    // assume @in_range_phys_ptr((mathint)s); 
    assume $in_range_phys_ptr($ref($ptr(^Stack, P#s)));
    // assume @in_range_spec_ptr((mathint)c); 
    assume $in_range_spec_ptr($ref($ptr(^^claim, SP#c)));
    // assert @_vcc_valid_claim(@state, c); 
    assert $valid_claim($s, $ptr(^^claim, SP#c));
    // assert @_vcc_in_domain(@state, c, c); 
    assert $in_domain_lab($s, $ptr(^^claim, SP#c), $ptr(^^claim, SP#c), l#public);
    loopState#0 := $s;
    while (true)
      invariant $mutable($s, $ptr(^Node, P#n));
      invariant $set_eq($owns($s, $ptr(^Node, P#n)), $set_empty());
    {
      anon24:
        assume (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $extent(old($s), $ptr(^Node, P#n))) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $extent(old($s), $ptr(^Node, P#n))) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $extent(old($s), $ptr(^Node, P#n))) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$1^49.5, $s);
        assume $local_value_is($s, #tok$1^49.5, #loc.c, $ptr_to_int($ptr(^^claim, SP#c)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^49.5, #loc.c, $ptr(^^claim, SP#c), $spec_ptr_to(^^claim));
        assume $local_value_is($s, #tok$1^49.5, #loc.s, $ptr_to_int($ptr(^Stack, P#s)), $ptr_to(^Stack)) && $local_value_is_ptr($s, #tok$1^49.5, #loc.s, $ptr(^Stack, P#s), $ptr_to(^Stack));
        assume $local_value_is($s, #tok$1^49.5, #loc.n, $ptr_to_int($ptr(^Node, P#n)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^49.5, #loc.n, $ptr(^Node, P#n), $ptr_to(^Node));
        assume true;
        // if (true) ...
        if (true)
        {
          anon19:
            // int32_t ok; 
            assume $local_value_is($s, #tok$1^53.9, #loc.ok, L#ok, ^^i4);
            // struct Node* h; 
            assume $local_value_is($s, #tok$1^52.16, #loc.h, $ptr_to_int($ptr(^Node, L#h)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^52.16, #loc.h, $ptr(^Node, L#h), $ptr_to(^Node));
            // var struct Node* h
            // var int32_t ok
            assume true;
            call $atomic_havoc();
            assume $full_stop_ext(#tok$1^55.25, $s);
            atomicObj#12 := $ptr(^Stack, P#s);
            assert $valid_claim($s, $ptr(^^claim, SP#c));
            assert $closed($s, atomicObj#12);
            assume $inv($s, atomicObj#12, ^Stack);
            beforeAtomicState#1 := $s;
            // assert @reads_check_normal((s->hd)); 
            assert $typed2($s, $dot($ptr(^Stack, P#s), Stack.hd), $ptr_to(^Node));
            assert $mutable($s, $ptr(^Stack, P#s)) || $ptr(^Stack, P#s) == atomicObj#12;
            // h := *((s->hd)); 
            L#h := $ref($read_ptr($s, $dot($ptr(^Stack, P#s), Stack.hd), ^Node));
            assume $local_value_is($s, #tok$1^56.11, #loc.h, $ptr_to_int($ptr(^Node, L#h)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^56.11, #loc.h, $ptr(^Node, L#h), $ptr_to(^Node));
            assert $ptr_eq($read_ptr($s, $dot(atomicObj#12, Stack.hd), ^Node), $null) == $set_eq($owns($s, atomicObj#12), $set_empty());
            assert $ptr_neq($read_ptr($s, $dot(atomicObj#12, Stack.hd), ^Node), $null) == !$set_eq($owns($s, atomicObj#12), $set_empty());
            assert $ptr_neq($read_ptr($s, $dot(atomicObj#12, Stack.hd), ^Node), $null) == $set_in($read_ptr($s, $dot(atomicObj#12, Stack.hd), ^Node), $owns($s, atomicObj#12));
            assert $ptr_neq($read_ptr($s, $dot(atomicObj#12, Stack.hd), ^Node), $null) ==> (forall Q#x$1^36.20#dt1: int :: { $set_in($ptr(^Node, Q#x$1^36.20#dt1), $owns($s, atomicObj#12)) } $in_range_phys_ptr($ref($ptr(^Node, Q#x$1^36.20#dt1))) ==> $set_in($ptr(^Node, Q#x$1^36.20#dt1), $owns($s, atomicObj#12)) ==> $typed2($s, $ptr(^Node, Q#x$1^36.20#dt1), ^Node) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, Q#x$1^36.20#dt1), Node.next), ^Node), $read_ptr($s, $dot(atomicObj#12, Stack.hd), ^Node)));
            assert $ptr_neq($read_ptr($s, $dot(atomicObj#12, Stack.hd), ^Node), $null) ==> (forall Q#x$1^38.20#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^Node, Q#x$1^38.20#dt1), Node.next), ^Node), $owns($s, atomicObj#12)) } $in_range_phys_ptr($ref($ptr(^Node, Q#x$1^38.20#dt1))) ==> $set_in($ptr(^Node, Q#x$1^38.20#dt1), $owns($s, atomicObj#12)) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, Q#x$1^38.20#dt1), Node.next), ^Node), $null) ==> $set_in($read_ptr($s, $dot($ptr(^Node, Q#x$1^38.20#dt1), Node.next), ^Node), $owns($s, atomicObj#12)));
            assert $ptr_neq($read_ptr($s, $dot(atomicObj#12, Stack.hd), ^Node), $null) ==> (forall Q#x$1^40.19#dt1: int, Q#y$1^40.19#dt1: int :: { $read_ptr($s, $dot($ptr(^Node, Q#x$1^40.19#dt1), Node.next), ^Node), $read_ptr($s, $dot($ptr(^Node, Q#y$1^40.19#dt1), Node.next), ^Node) } $in_range_phys_ptr($ref($ptr(^Node, Q#x$1^40.19#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#y$1^40.19#dt1))) ==> $set_in($ptr(^Node, Q#x$1^40.19#dt1), $owns($s, atomicObj#12)) && $set_in($ptr(^Node, Q#y$1^40.19#dt1), $owns($s, atomicObj#12)) && $ptr_eq($read_ptr($s, $dot($ptr(^Node, Q#x$1^40.19#dt1), Node.next), ^Node), $read_ptr($s, $dot($ptr(^Node, Q#y$1^40.19#dt1), Node.next), ^Node)) ==> $ptr_eq($ptr(^Node, Q#x$1^40.19#dt1), $ptr(^Node, Q#y$1^40.19#dt1)));
            assume $full_stop_ext(#tok$1^55.25, $s);
            // assert @_vcc_typed2(@state, (n->next)); 
            assert $typed2($s, $dot($ptr(^Node, P#n), Node.next), $ptr_to(^Node));
            // assert @prim_writes_check((n->next)); 
            assert $writable($s, #wrTime$1^44.1, $dot($ptr(^Node, P#n), Node.next));
            // *(n->next) := h; 
            call $write_int($dot($ptr(^Node, P#n), Node.next), $ref($ptr(^Node, L#h)));
            assume $full_stop_ext(#tok$1^58.9, $s);
            // ok := 0; 
            L#ok := 0;
            assume $local_value_is($s, #tok$1^60.9, #loc.ok, L#ok, ^^i4);
            assume true;
            call $atomic_havoc();
            assume $full_stop_ext(#tok$1^61.18, $s);
            atomicObj#13 := $ptr(^Stack, P#s);
            assert $valid_claim($s, $ptr(^^claim, SP#c));
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
            // assert @writes_check(n); 
            assert $top_writable($s, #wrTime$1^44.1, $ptr(^Node, P#n));
            // assume @_vcc_pre_static_wrap(@state); 
            assume $pre_static_wrap($s);
            // @_vcc_static_wrap(pure(n), staticWrapState#6, owns#7)
            call $static_wrap($ptr(^Node, P#n), staticWrapState#6, owns#7);
            assume $good_state_ext(#tok$1^62.29, $s);
            // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, n), @_vcc_set_empty)); 
            assert $set_eq($owns($s, $ptr(^Node, P#n)), $set_empty());
            // assert @inv_check(@_vcc_depends(old(prestate#8, @state), @state, @_vcc_owner(@state, n), n)); 
            assert $depends(prestate#8, $s, $owner($s, $ptr(^Node, P#n)), $ptr(^Node, P#n));
            // assume @_vcc_full_stop(@state); 
            assume $full_stop($s);
            assert $valid_claim($s, $ptr(^^claim, SP#c));
            assert $closed($s, atomicObj#13);
            assume $inv($s, atomicObj#13, ^Stack);
            beforeAtomicState#2 := $s;
            // struct Node** Destination#1; 
            assume $local_value_is($s, #tok$1^64.49, #loc.Destination#1, $ptr_to_int($ptr($ptr_to(^Node), Destination#1)), $ptr_to($ptr_to(^Node))) && $local_value_is_ptr($s, #tok$1^64.49, #loc.Destination#1, $ptr($ptr_to(^Node), Destination#1), $ptr_to($ptr_to(^Node)));
            // Destination#1 := (s->hd); 
            Destination#1 := $ref($dot($ptr(^Stack, P#s), Stack.hd));
            assume $local_value_is($s, #tok$1^64.49, #loc.Destination#1, $ptr_to_int($ptr($ptr_to(^Node), Destination#1)), $ptr_to($ptr_to(^Node))) && $local_value_is_ptr($s, #tok$1^64.49, #loc.Destination#1, $ptr($ptr_to(^Node), Destination#1), $ptr_to($ptr_to(^Node)));
            // struct Node* res#2; 
            assume $local_value_is($s, #tok$1^64.15, #loc.res#2, $ptr_to_int($ptr(^Node, res#2)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^64.15, #loc.res#2, $ptr(^Node, res#2), $ptr_to(^Node));
            // assert @reads_check_normal(Destination#1); 
            assert $typed2($s, $ptr($ptr_to(^Node), Destination#1), $ptr_to(^Node));
            assert $thread_local2($s, $ptr($ptr_to(^Node), Destination#1), $ptr_to(^Node)) || $set_in($ptr($ptr_to(^Node), Destination#1), $span(atomicObj#13));
            assume true;
            // if (@_vcc_ptr_eq(*(Destination#1), h)) ...
            if ($ptr_eq($read_ptr($s, $ptr($ptr_to(^Node), Destination#1), ^Node), $ptr(^Node, L#h)))
            {
              anon13:
                // assert @_vcc_typed2(@state, Destination#1); 
                assert $typed2($s, $ptr($ptr_to(^Node), Destination#1), $ptr_to(^Node));
                // assert @prim_writes_check(Destination#1); 
                assert $set_in($ptr($ptr_to(^Node), Destination#1), $volatile_span($s, atomicObj#13)) || $writable($s, #wrTime$1^44.1, $ptr($ptr_to(^Node), Destination#1));
                // *Destination#1 := n; 
                call $write_int($ptr($ptr_to(^Node), Destination#1), $ref($ptr(^Node, P#n)));
                assume $good_state_ext(#tok$1^64.49, $s);
                // res#2 := h; 
                res#2 := $ref($ptr(^Node, L#h));
                assume $local_value_is($s, #tok$1^21.5, #loc.res#2, $ptr_to_int($ptr(^Node, res#2)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^21.5, #loc.res#2, $ptr(^Node, res#2), $ptr_to(^Node));
            }
            else
            {
              anon14:
                // assert @reads_check_normal(Destination#1); 
                assert $typed2($s, $ptr($ptr_to(^Node), Destination#1), $ptr_to(^Node));
                assert $thread_local2($s, $ptr($ptr_to(^Node), Destination#1), $ptr_to(^Node)) || $set_in($ptr($ptr_to(^Node), Destination#1), $span(atomicObj#13));
                // res#2 := *(Destination#1); 
                res#2 := $ref($read_ptr($s, $ptr($ptr_to(^Node), Destination#1), ^Node));
                assume $local_value_is($s, #tok$1^23.5, #loc.res#2, $ptr_to_int($ptr(^Node, res#2)), $ptr_to(^Node)) && $local_value_is_ptr($s, #tok$1^23.5, #loc.res#2, $ptr(^Node, res#2), $ptr_to(^Node));
            }

          anon20:
            // empty
            // ok := (int32_t)@_vcc_ptr_eq(res#2, h); 
            L#ok := $bool_to_int($ptr_eq($ptr(^Node, res#2), $ptr(^Node, L#h)));
            assume $local_value_is($s, #tok$1^64.9, #loc.ok, L#ok, ^^i4);
            // _Bool ite#3; 
            assume $local_value_is($s, #tok$1^65.13, #loc.ite#3, $bool_to_int(ite#3), ^^bool);
            // ite#3 := (_Bool)ok; 
            ite#3 := $int_to_bool(L#ok);
            assume $local_value_is($s, #tok$1^65.13, #loc.ite#3, $bool_to_int(ite#3), ^^bool);
            assume true;
            // if (ite#3) ...
            if (ite#3)
            {
              anon15:
                // assert unchecked!(@_vcc_set_in(n, @_vcc_owns(@state, s))); 
                assert !$set_in($ptr(^Node, P#n), $owns($s, $ptr(^Stack, P#s)));
                // assume unchecked!(@_vcc_set_in(n, @_vcc_owns(@state, s))); 
                assume !$set_in($ptr(^Node, P#n), $owns($s, $ptr(^Stack, P#s)));
                // assert @is_atomic_obj(s); 
                assert $ptr(^Stack, P#s) == atomicObj#13;
                // assert @writes_check(n); 
                assert $top_writable($s, #wrTime$1^44.1, $ptr(^Node, P#n));
                // stmt _vcc_set_closed_owner(n, s); 
                call $set_closed_owner($ptr(^Node, P#n), $ptr(^Stack, P#s));
                assume $good_state_ext(#tok$1^67.39, $s);
                // empty
            }
            else
            {
              anon16:
                // empty
            }

          anon21:
            assert $ptr_eq($read_ptr($s, $dot(atomicObj#13, Stack.hd), ^Node), $null) == $set_eq($owns($s, atomicObj#13), $set_empty());
            assert $ptr_neq($read_ptr($s, $dot(atomicObj#13, Stack.hd), ^Node), $null) == !$set_eq($owns($s, atomicObj#13), $set_empty());
            assert $ptr_neq($read_ptr($s, $dot(atomicObj#13, Stack.hd), ^Node), $null) == $set_in($read_ptr($s, $dot(atomicObj#13, Stack.hd), ^Node), $owns($s, atomicObj#13));
            assert $ptr_neq($read_ptr($s, $dot(atomicObj#13, Stack.hd), ^Node), $null) ==> (forall Q#x$1^36.20#dt1: int :: { $set_in($ptr(^Node, Q#x$1^36.20#dt1), $owns($s, atomicObj#13)) } $in_range_phys_ptr($ref($ptr(^Node, Q#x$1^36.20#dt1))) ==> $set_in($ptr(^Node, Q#x$1^36.20#dt1), $owns($s, atomicObj#13)) ==> $typed2($s, $ptr(^Node, Q#x$1^36.20#dt1), ^Node) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, Q#x$1^36.20#dt1), Node.next), ^Node), $read_ptr($s, $dot(atomicObj#13, Stack.hd), ^Node)));
            assert $ptr_neq($read_ptr($s, $dot(atomicObj#13, Stack.hd), ^Node), $null) ==> (forall Q#x$1^38.20#dt1: int :: { $set_in($read_ptr($s, $dot($ptr(^Node, Q#x$1^38.20#dt1), Node.next), ^Node), $owns($s, atomicObj#13)) } $in_range_phys_ptr($ref($ptr(^Node, Q#x$1^38.20#dt1))) ==> $set_in($ptr(^Node, Q#x$1^38.20#dt1), $owns($s, atomicObj#13)) && $ptr_neq($read_ptr($s, $dot($ptr(^Node, Q#x$1^38.20#dt1), Node.next), ^Node), $null) ==> $set_in($read_ptr($s, $dot($ptr(^Node, Q#x$1^38.20#dt1), Node.next), ^Node), $owns($s, atomicObj#13)));
            assert $ptr_neq($read_ptr($s, $dot(atomicObj#13, Stack.hd), ^Node), $null) ==> (forall Q#x$1^40.19#dt1: int, Q#y$1^40.19#dt1: int :: { $read_ptr($s, $dot($ptr(^Node, Q#x$1^40.19#dt1), Node.next), ^Node), $read_ptr($s, $dot($ptr(^Node, Q#y$1^40.19#dt1), Node.next), ^Node) } $in_range_phys_ptr($ref($ptr(^Node, Q#x$1^40.19#dt1))) && $in_range_phys_ptr($ref($ptr(^Node, Q#y$1^40.19#dt1))) ==> $set_in($ptr(^Node, Q#x$1^40.19#dt1), $owns($s, atomicObj#13)) && $set_in($ptr(^Node, Q#y$1^40.19#dt1), $owns($s, atomicObj#13)) && $ptr_eq($read_ptr($s, $dot($ptr(^Node, Q#x$1^40.19#dt1), Node.next), ^Node), $read_ptr($s, $dot($ptr(^Node, Q#y$1^40.19#dt1), Node.next), ^Node)) ==> $ptr_eq($ptr(^Node, Q#x$1^40.19#dt1), $ptr(^Node, Q#y$1^40.19#dt1)));
            assume $full_stop_ext(#tok$1^61.18, $s);
            // _Bool ite#4; 
            assume $local_value_is($s, #tok$1^71.13, #loc.ite#4, $bool_to_int(ite#4), ^^bool);
            // ite#4 := (_Bool)ok; 
            ite#4 := $int_to_bool(L#ok);
            assume $local_value_is($s, #tok$1^71.13, #loc.ite#4, $bool_to_int(ite#4), ^^bool);
            assume true;
            // if (ite#4) ...
            if (ite#4)
            {
              anon17:
                // return 1; 
                $result := 1;
                assert $position_marker();
                goto #exit;
            }
            else
            {
              anon18:
                // empty
            }

          anon22:
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
            // assert @_vcc_wrapped(@state, n); 
            assert $wrapped($s, $ptr(^Node, P#n), ^Node);
            // assert @writes_check(n); 
            assert $top_writable($s, #wrTime$1^44.1, $ptr(^Node, P#n));
            // assume @_vcc_inv(@state, n); 
            assume $inv($s, $ptr(^Node, P#n), ^Node);
            // assume ==(owns#10, @_vcc_owns(@state, n)); 
            assume owns#10 == $owns($s, $ptr(^Node, P#n));
            // assume @_vcc_pre_static_unwrap(@state); 
            assume $pre_static_unwrap($s);
            // @_vcc_static_unwrap(pure(n), prestate#11)
            call $static_unwrap($ptr(^Node, P#n), prestate#11);
            assume $good_state_ext(#tok$1^74.18, $s);
            // assume @_vcc_full_stop(@state); 
            assume $full_stop($s);
        }
        else
        {
          anon23:
            // goto #break_5; 
            goto #break_5;
        }

      #continue_5:
        assume true;
    }

  anon26:
    assume $full_stop_ext(#tok$1^49.5, $s);

  #break_5:
    // empty

  #exit:
}



const unique l#public: $label;

const unique #tok$1^74.18: $token;

const unique #loc.prestate#11: $token;

const unique #loc.prestate#9: $token;

const unique #loc.owns#10: $token;

const unique #loc.ite#4: $token;

const unique #tok$1^71.13: $token;

const unique #tok$1^61.18: $token;

const unique #tok$1^67.39: $token;

const unique #loc.ite#3: $token;

const unique #tok$1^65.13: $token;

const unique #tok$1^64.9: $token;

const unique #tok$1^23.5: $token;

const unique #tok$1^21.5: $token;

const unique #loc.res#2: $token;

const unique #tok$1^64.15: $token;

const unique #distTp4: $ctype;

axiom #distTp4 == $ptr_to($ptr_to(^Node));

const unique #loc.Destination#1: $token;

const unique #tok$1^64.49: $token;

const unique #tok$1^62.29: $token;

const unique #loc.owns#7: $token;

const unique #loc.staticWrapState#6: $token;

function $state_to_int(x: $state) : int;

function $int_to_state(x: int) : $state;

axiom (forall #x: $state :: #x == $int_to_state($state_to_int(#x)));

const unique #loc.prestate#8: $token;

const unique #tok$2^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(2, #file^?3Cno?20file?3E);

const unique #tok$1^60.9: $token;

const unique #tok$1^58.9: $token;

const unique #tok$1^55.25: $token;

const unique #tok$1^56.11: $token;

const unique #loc.h: $token;

const unique #tok$1^52.16: $token;

const unique #loc.ok: $token;

const unique #tok$1^53.9: $token;

const unique #tok$1^49.5: $token;

const unique #distTp3: $ctype;

axiom #distTp3 == $spec_ptr_to(^^claim);

const unique #loc.c: $token;

const unique #loc.s: $token;

const unique #loc.n: $token;

const unique #tok$1^44.1: $token;

const unique #distTp2: $ctype;

axiom #distTp2 == $ptr_to(^Stack);

const unique #tok$1^29.32: $token;

const unique #loc._this_: $token;

const unique #tok$1^12.9: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CLockFreeStack.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CLockFreeStack.c);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^Node);
