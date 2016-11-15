axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^A: $ctype;

axiom $is_composite(^A);

axiom $ptr_level(^A) == 0;

axiom $sizeof(^A) == 4;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^A) } $inv2(#s1, #s2, #p, ^A) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty()) && ($mem(#s1, $dot(#p, A.x)) == $mem(#s2, $dot(#p, A.x)) || $mem(#s1, $dot(#p, A.x)) + 1 == $mem(#s2, $dot(#p, A.x)))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^A, #r), l#public) } $inv_lab(#s2, $ptr(^A, #r), l#public) == ($typed(#s2, $ptr(^A, #r)) && $set_eq($owns(#s2, $ptr(^A, #r)), $set_empty()) && (true || $mem(#s2, $dot($ptr(^A, #r), A.x)) + 1 == $mem(#s2, $dot($ptr(^A, #r), A.x)))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^A, #r)) } $in_full_extent_of(#q, $ptr(^A, #r)) == (#q == $ptr(^A, #r) || #q == $dot($ptr(^A, #r), A.$owns) || #q == $dot($ptr(^A, #r), A.x)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^A, #r)) } $in_extent_of(#s, #q, $ptr(^A, #r)) == $in_struct_extent_of(#q, $ptr(^A, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^A, #r)) } $typed(#s, $ptr(^A, #r)) ==> $in_extent_of(#s, #q, $ptr(^A, #r)) == (#q == $ptr(^A, #r) || $emb(#s, #q) == $ptr(^A, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^A, #r)) } $in_span_of(#q, $ptr(^A, #r)) == (#q == $ptr(^A, #r) || #q == $dot($ptr(^A, #r), A.$owns) || #q == $dot($ptr(^A, #r), A.x)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^A) } $state_spans_the_same(#s1, #s2, #p, ^A) == ($mem_eq(#s1, #s2, $dot(#p, A.$owns)) && $mem_eq(#s1, #s2, $dot(#p, A.x))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^A) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^A) == $mem_eq(#s1, #s2, $dot(#p, A.$owns)));

axiom $is_claimable(^A) == true;

axiom $has_volatile_owns_set(^A) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^A, #r)) } $extent_mutable(#s1, $ptr(^A, #r)) == $mutable(#s1, $ptr(^A, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^A, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^A, #r)) == $is_fresh(#s1, #s2, $ptr(^A, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^A, #r)) } $extent_zero(#s1, $ptr(^A, #r)) == ($mem(#s1, $dot($ptr(^A, #r), A.x)) == 0));

const unique A.$owns: $field;

axiom $static_field_properties(A.$owns, ^A);

axiom $is_primitive_non_volatile_field(A.$owns);

axiom (forall #p: $ptr :: { $dot(#p, A.$owns) } $is(#p, ^A) ==> $dot(#p, A.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, A.$owns)) && $extent_hint($dot(#p, A.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, A.$owns)) } { $st(#s, $dot(#p, A.$owns)) } $typed2(#s, #p, ^A) ==> $field_properties(#s, #p, A.$owns, ^$#ptrset, false));

axiom $owns_set_field(^A) == A.$owns;

const unique A.x: $field;

axiom $static_field_properties(A.x, ^A);

axiom $is_primitive_volatile_field(A.x);

axiom $field_offset(A.x) == 0;

axiom (forall #p: $ptr :: { $dot(#p, A.x) } $is(#p, ^A) ==> $dot(#p, A.x) == $ptr(^^i4, $ref(#p) + 0) && $extent_hint($dot(#p, A.x), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, A.x)) } { $st(#s, $dot(#p, A.x)) } $typed2(#s, #p, ^A) ==> $field_properties(#s, #p, A.x, ^^i4, true));

procedure A#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $set_eq($owns($s, $ptr(^A, P#_this_)), $set_empty());
  ensures $is_admissibility_check() ==> $mem(old($s), $dot($ptr(^A, P#_this_), A.x)) == $mem($s, $dot($ptr(^A, P#_this_), A.x)) || $mem(old($s), $dot($ptr(^A, P#_this_), A.x)) + 1 == $mem($s, $dot($ptr(^A, P#_this_), A.x));
  ensures $is_stuttering_check() ==> $mem($s, $dot($ptr(^A, P#_this_), A.x)) == $mem($s, $dot($ptr(^A, P#_this_), A.x)) || $mem($s, $dot($ptr(^A, P#_this_), A.x)) + 1 == $mem($s, $dot($ptr(^A, P#_this_), A.x));
  ensures $is_unwrap_check() ==> $set_eq($owns($s, $ptr(^A, P#_this_)), $set_empty());
  ensures $is_unwrap_check() ==> $mem(old($s), $dot($ptr(^A, P#_this_), A.x)) == $mem($s, $dot($ptr(^A, P#_this_), A.x)) || $mem(old($s), $dot($ptr(^A, P#_this_), A.x)) + 1 == $mem($s, $dot($ptr(^A, P#_this_), A.x));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation A#adm(P#_this_: int)
{
  var #wrTime$1^4.28: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^4.28, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^4.28, #loc._this_, $ptr_to_int($ptr(^A, P#_this_)), $ptr_to(^A)) && $local_value_is_ptr($s, #tok$1^4.28, #loc._this_, $ptr(^A, P#_this_), $ptr_to(^A));
    assume #wrTime$1^4.28 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^4.28, #p) } $in_writes_at(#wrTime$1^4.28, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^A, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^A, P#_this_));
        assume $good_state_ext(#tok$1^4.28, $s);
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
        assume $good_state_ext(#tok$1^4.28, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^A, P#_this_), ^A);
    }

  #exit:
}



procedure incr(P#a: int, P#res: int, SP#c: int) returns (OP#cres: int);
  requires true;
  requires $wrapped($s, $ptr(^^claim, SP#c), ^^claim);
  requires $valid_claim($s, $ptr(^^claim, SP#c));
  requires (forall #cs0: $state :: { $valid_claim(#cs0, $ptr(^^claim, SP#c)) } $valid_claim(#cs0, $ptr(^^claim, SP#c)) ==> $claimed_closed(#cs0, $ptr(^A, P#a)));
  modifies $s, $cev_pc;
  free ensures $in_range_spec_ptr($ref($ptr(^^claim, OP#cres)));
  ensures $ref_cnt($s, $ptr(^^claim, SP#c)) == $ref_cnt(old($s), $ptr(^^claim, SP#c)) + 1;
  ensures $claims_obj($ptr(^^claim, OP#cres), $ptr(^^claim, SP#c));
  ensures $wrapped($s, $ptr(^^claim, OP#cres), ^^claim) && $ref_cnt($s, $ptr(^^claim, OP#cres)) == 0;
  ensures (forall #cs1: $state :: { $valid_claim(#cs1, $ptr(^^claim, OP#cres)) } $valid_claim(#cs1, $ptr(^^claim, OP#cres)) ==> $mem(#cs1, $dot($ptr(^A, P#a), A.x)) >= $mem($s, $ptr(^^i4, P#res)));
  ensures $is_fresh(old($s), $s, $ptr(^^claim, OP#cres));
  ensures $mutable($s, $ptr(^^i4, P#res));
  ensures $wrapped($s, $ptr(^^claim, SP#c), ^^claim) && $valid_claim($s, $ptr(^^claim, SP#c));
  ensures $mutable($s, $ptr(^^i4, P#res));
  ensures $emb($s, $ptr(^^i4, P#res)) == $emb(old($s), $ptr(^^i4, P#res));
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^^claim, SP#c) || #p == $ptr(^^i4, P#res) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^^claim, SP#c) || #p == $ptr(^^i4, P#res) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^^claim, SP#c) || #p == $ptr(^^i4, P#res) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation incr(P#a: int, P#res: int, SP#c: int) returns (OP#cres: int)
{
  var claim#0doAdm: bool;
  var claim#0s2: $state;
  var claim#0s1: $state;
  var claim#0s0: $state;
  var claim#0: $ptr;
  var beforeAtomicState#0: $state;
  var atomicObj#7: $ptr;
  var L#val: int where $in_range_i4(L#val);
  var #wrTime$1^9.1: int;
  var #stackframe: int;

  anon8:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^9.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^9.1, #loc.a, $ptr_to_int($ptr(^A, P#a)), $ptr_to(^A)) && $local_value_is_ptr($s, #tok$1^9.1, #loc.a, $ptr(^A, P#a), $ptr_to(^A));
    assume $local_value_is($s, #tok$1^9.1, #loc.res, $ptr_to_int($ptr(^^i4, P#res)), $ptr_to(^^i4)) && $local_value_is_ptr($s, #tok$1^9.1, #loc.res, $ptr(^^i4, P#res), $ptr_to(^^i4));
    assume $local_value_is($s, #tok$1^9.1, #loc.c, $ptr_to_int($ptr(^^claim, SP#c)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^9.1, #loc.c, $ptr(^^claim, SP#c), $spec_ptr_to(^^claim));
    assume #wrTime$1^9.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^9.1, #p) } $in_writes_at(#wrTime$1^9.1, #p) == (#p == $ptr(^^claim, SP#c) || #p == $ptr(^^i4, P#res)));
    assume $thread_owned($s, $ptr(^^claim, SP#c));
    assume $mutable($s, $ptr(^^i4, P#res));
    // assume @in_range_phys_ptr((mathint)a); 
    assume $in_range_phys_ptr($ref($ptr(^A, P#a)));
    // assume @in_range_phys_ptr((mathint)res); 
    assume $in_range_phys_ptr($ref($ptr(^^i4, P#res)));
    // assume @in_range_spec_ptr((mathint)c); 
    assume $in_range_spec_ptr($ref($ptr(^^claim, SP#c)));
    // assume @in_range_spec_ptr((mathint)cres); 
    assume $in_range_spec_ptr($ref($ptr(^^claim, OP#cres)));
    // assert @_vcc_valid_claim(@state, c); 
    assert $valid_claim($s, $ptr(^^claim, SP#c));
    // assert @_vcc_in_domain(@state, c, c); 
    assert $in_domain_lab($s, $ptr(^^claim, SP#c), $ptr(^^claim, SP#c), l#public);
    // int32_t val; 
    assume $local_value_is($s, #tok$1^25.3, #loc.val, L#val, ^^i4);
    // var int32_t val
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^27.19, $s);
    atomicObj#7 := $ptr(^A, P#a);
    assert $valid_claim($s, $ptr(^^claim, SP#c));
    assert $closed($s, atomicObj#7);
    assume $inv($s, atomicObj#7, ^A);
    beforeAtomicState#0 := $s;
    // assert @reads_check_normal((a->x)); 
    assert $typed2($s, $dot($ptr(^A, P#a), A.x), ^^i4);
    assert $mutable($s, $ptr(^A, P#a)) || $ptr(^A, P#a) == atomicObj#7;
    // val := *((a->x)); 
    L#val := $mem($s, $dot($ptr(^A, P#a), A.x));
    assume $local_value_is($s, #tok$1^28.5, #loc.val, L#val, ^^i4);
    assert $set_eq($owns($s, atomicObj#7), $set_empty());
    assert $mem(beforeAtomicState#0, $dot(atomicObj#7, A.x)) == $mem($s, $dot(atomicObj#7, A.x)) || $mem(beforeAtomicState#0, $dot(atomicObj#7, A.x)) + 1 == $mem($s, $dot(atomicObj#7, A.x));
    assume $full_stop_ext(#tok$1^27.19, $s);
    // assert @_vcc_typed2(@state, res); 
    assert $typed2($s, $ptr(^^i4, P#res), ^^i4);
    // assert @prim_writes_check(res); 
    assert $writable($s, #wrTime$1^9.1, $ptr(^^i4, P#res));
    // *res := val; 
    call $write_int($ptr(^^i4, P#res), L#val);
    assume $full_stop_ext(#tok$1^31.4, $s);
    // cres := @claim(pure(<=(pure(old(@_vcc_when_claimed, *(res))), *((a->x)))), c); 
    assert $closed($s, $ptr(^^claim, SP#c));
    assert $top_writable($s, #wrTime$1^9.1, $ptr(^^claim, SP#c));
    assert $is_claimable(^^claim);
    call $write_ref_cnt($ptr(^^claim, SP#c), $ref_cnt($s, $ptr(^^claim, SP#c)) + 1);
    assume $ref_cnt($s, $ptr(^^claim, SP#c)) >= 0;
    claim#0s0 := $s;
    call claim#0 := $alloc_claim();
    assume $claims_obj(claim#0, $ptr(^^claim, SP#c));
    OP#cres := $ref(claim#0);
    assume $local_value_is($s, #tok$1^32.33, #loc.cres, $ptr_to_int($ptr(^^claim, OP#cres)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^32.33, #loc.cres, $ptr(^^claim, OP#cres), $spec_ptr_to(^^claim));
    assume $full_stop_ext(#tok$1^32.33, $s);
    assume claim#0 != $no_claim ==> $claim_initial_assumptions($s, claim#0, #tok$1^32.33);
    assert claim#0 != $no_claim ==> $mem($s, $ptr(^^i4, P#res)) <= $mem($s, $dot($ptr(^A, P#a), A.x));
    if (claim#0doAdm)
    {
      anon7:
        assume $mem($s, $ptr(^^i4, P#res)) <= $mem(claim#0s1, $dot($ptr(^A, P#a), A.x));
        assume $valid_claim_impl(claim#0s0, claim#0s2);
        assume $claim_transitivity_assumptions(claim#0s1, claim#0s2, claim#0, #tok$1^32.33);
        assert $mem($s, $ptr(^^i4, P#res)) <= $mem(claim#0s2, $dot($ptr(^A, P#a), A.x));
        assume false;
    }

  anon9:
    assume claim#0 != $no_claim ==> (forall #cs2: $state :: { $valid_claim(#cs2, claim#0) } $valid_claim(#cs2, claim#0) ==> $mem($s, $ptr(^^i4, P#res)) <= $mem(#cs2, $dot($ptr(^A, P#a), A.x)));
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure use_case();
  modifies $s, $cev_pc;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation use_case()
{
  var prestate#6: $state;
  var prestate#4: $state;
  var owns#5: $ptrset;
  var claim#1doAdm: bool;
  var claim#1s2: $state;
  var claim#1s1: $state;
  var claim#1s0: $state;
  var claim#1: $ptr;
  var owns#2: $ptrset;
  var staticWrapState#1: $state;
  var prestate#3: $state;
  var #callConv#1: $ptr;
  var L#a: int where $in_range_phys_ptr(L#a);
  var #callConv#0: $ptr;
  var addr.tmp: int where $in_range_phys_ptr(addr.tmp);
  var SL#c: int where $in_range_spec_ptr(SL#c);
  var SL#c2: int where $in_range_spec_ptr(SL#c2);
  var #wrTime$1^35.1: int;
  var #stackframe: int;

  anon11:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^35.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^35.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^35.1, #p) } $in_writes_at(#wrTime$1^35.1, #p) == false);
    // claim_t^ c2; 
    assume $local_value_is($s, #tok$1^40.26, #loc.c2, $ptr_to_int($ptr(^^claim, SL#c2)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^40.26, #loc.c2, $ptr(^^claim, SL#c2), $spec_ptr_to(^^claim));
    // claim_t^ c; 
    assume $local_value_is($s, #tok$1^39.26, #loc.c, $ptr_to_int($ptr(^^claim, SL#c)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^39.26, #loc.c, $ptr(^^claim, SL#c), $spec_ptr_to(^^claim));
    // int32_t* addr.tmp; 
    assume $local_value_is($s, #tok$1^35.1, #loc.addr.tmp, $ptr_to_int($ptr(^^i4, addr.tmp)), $ptr_to(^^i4)) && $local_value_is_ptr($s, #tok$1^35.1, #loc.addr.tmp, $ptr(^^i4, addr.tmp), $ptr_to(^^i4));
    // addr.tmp := _vcc_stack_alloc<int32_t>(@stackframe, false); 
    call #callConv#0 := $stack_alloc(^^i4, #stackframe, false);
    assume $full_stop_ext(#tok$1^35.1, $s);
    addr.tmp := $ref(#callConv#0);
    assume $local_value_is($s, #tok$1^35.1, #loc.addr.tmp, $ptr_to_int($ptr(^^i4, addr.tmp)), $ptr_to(^^i4)) && $local_value_is_ptr($s, #tok$1^35.1, #loc.addr.tmp, $ptr(^^i4, addr.tmp), $ptr_to(^^i4));
    // struct A* a; 
    assume $local_value_is($s, #tok$1^37.10, #loc.a, $ptr_to_int($ptr(^A, L#a)), $ptr_to(^A)) && $local_value_is_ptr($s, #tok$1^37.10, #loc.a, $ptr(^A, L#a), $ptr_to(^A));
    // var struct A* a
    // var int32_t tmp
    // var spec claim_t^ c
    // var spec claim_t^ c2
    // a := _vcc_alloc(@_vcc_typeof((struct A*)@null)); 
    call #callConv#1 := $alloc(^A);
    assume $full_stop_ext(#tok$1^42.7, $s);
    L#a := $ref(#callConv#1);
    assume $local_value_is($s, #tok$1^42.7, #loc.a, $ptr_to_int($ptr(^A, L#a)), $ptr_to(^A)) && $local_value_is_ptr($s, #tok$1^42.7, #loc.a, $ptr(^A, L#a), $ptr_to(^A));
    // assume @_vcc_ptr_neq(a, @null); 
    assume $ptr_neq($ptr(^A, L#a), $null);
    // assert @_vcc_typed2(@state, (a->x)); 
    assert $typed2($s, $dot($ptr(^A, L#a), A.x), ^^i4);
    // assert @prim_writes_check((a->x)); 
    assert $writable($s, #wrTime$1^35.1, $dot($ptr(^A, L#a), A.x));
    // *(a->x) := 0; 
    call $write_int($dot($ptr(^A, L#a), A.x), 0);
    assume $full_stop_ext(#tok$1^44.3, $s);
    // _math state_t prestate#3; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#3, $state_to_int(prestate#3), ^$#state_t);
    // prestate#3 := @_vcc_current_state(@state); 
    prestate#3 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#3, $state_to_int(prestate#3), ^$#state_t);
    // _math state_t staticWrapState#1; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#1, $state_to_int(staticWrapState#1), ^$#state_t);
    // staticWrapState#1 := @_vcc_current_state(@state); 
    staticWrapState#1 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#1, $state_to_int(staticWrapState#1), ^$#state_t);
    // _math ptrset owns#2; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#2, $ptrset_to_int(owns#2), ^$#ptrset);
    // owns#2 := @_vcc_set_empty; 
    owns#2 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#2, $ptrset_to_int(owns#2), ^$#ptrset);
    // assert @writes_check(a); 
    assert $top_writable($s, #wrTime$1^35.1, $ptr(^A, L#a));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(a), staticWrapState#1, owns#2)
    call $static_wrap($ptr(^A, L#a), staticWrapState#1, owns#2);
    assume $good_state_ext(#tok$1^45.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, a), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^A, L#a)), $set_empty());
    // assert @inv_check(||(==(old(prestate#3, *((a->x))), *((a->x))), ==(+(old(prestate#3, *((a->x))), 1), *((a->x))))); 
    assert $mem(prestate#3, $dot($ptr(^A, L#a), A.x)) == $mem($s, $dot($ptr(^A, L#a), A.x)) || $mem(prestate#3, $dot($ptr(^A, L#a), A.x)) + 1 == $mem($s, $dot($ptr(^A, L#a), A.x));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // c := @claim(pure(true), a); 
    assert $closed($s, $ptr(^A, L#a));
    assert $top_writable($s, #wrTime$1^35.1, $ptr(^A, L#a));
    assert $is_claimable(^A);
    call $write_ref_cnt($ptr(^A, L#a), $ref_cnt($s, $ptr(^A, L#a)) + 1);
    assume $ref_cnt($s, $ptr(^A, L#a)) >= 0;
    claim#1s0 := $s;
    call claim#1 := $alloc_claim();
    assume $claims_obj(claim#1, $ptr(^A, L#a));
    SL#c := $ref(claim#1);
    assume $local_value_is($s, #tok$1^47.30, #loc.c, $ptr_to_int($ptr(^^claim, SL#c)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^47.30, #loc.c, $ptr(^^claim, SL#c), $spec_ptr_to(^^claim));
    assume $full_stop_ext(#tok$1^47.30, $s);
    assume claim#1 != $no_claim ==> $claim_initial_assumptions($s, claim#1, #tok$1^47.30);
    assert true;
    if (claim#1doAdm)
    {
      anon10:
        assume true;
        assume $valid_claim_impl(claim#1s0, claim#1s2);
        assume $claim_transitivity_assumptions(claim#1s1, claim#1s2, claim#1, #tok$1^47.30);
        assert true;
        assume false;
    }

  anon12:
    assume claim#1 != $no_claim ==> (forall #cs3: $state :: { $valid_claim(#cs3, claim#1) } true);
    // assert @writes_check(c); 
    assert $top_writable($s, #wrTime$1^35.1, $ptr(^^claim, SL#c));
    // assert @prim_writes_check(addr.tmp); 
    assert $writable($s, #wrTime$1^35.1, $ptr(^^i4, addr.tmp));
    // c2 := incr(a, addr.tmp, c); 
    call SL#c2 := incr($ref($ptr(^A, L#a)), $ref($ptr(^^i4, addr.tmp)), $ref($ptr(^^claim, SL#c)));
    assume $full_stop_ext(#tok$1^48.3, $s);
    assume $local_value_is($s, #tok$1^48.3, #loc.c2, $ptr_to_int($ptr(^^claim, SL#c2)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^48.3, #loc.c2, $ptr(^^claim, SL#c2), $spec_ptr_to(^^claim));
    // assert @_vcc_wrapped(@state, c); 
    assert $wrapped($s, $ptr(^^claim, SL#c), ^^claim);
    // assume @_vcc_wrapped(@state, c); 
    assume $wrapped($s, $ptr(^^claim, SL#c), ^^claim);
    // assert @_vcc_valid_claim(@state, c2); 
    assert $valid_claim($s, $ptr(^^claim, SL#c2));
    // assume @_vcc_valid_claim(@state, c2); 
    assume $valid_claim($s, $ptr(^^claim, SL#c2));
    // assert <=(*(addr.tmp), *((a->x))); 
    assert $mem($s, $ptr(^^i4, addr.tmp)) <= $mem($s, $dot($ptr(^A, L#a), A.x));
    // assume <=(*(addr.tmp), *((a->x))); 
    assume $mem($s, $ptr(^^i4, addr.tmp)) <= $mem($s, $dot($ptr(^A, L#a), A.x));
    // assert @_vcc_wrapped(@state, c); 
    assert $wrapped($s, $ptr(^^claim, SL#c), ^^claim);
    // assume @_vcc_wrapped(@state, c); 
    assume $wrapped($s, $ptr(^^claim, SL#c), ^^claim);
    // stmt @unclaim(c2, c); 
    assert $top_writable($s, #wrTime$1^35.1, $ptr(^^claim, SL#c2));
    call $unclaim($ptr(^^claim, SL#c2));
    assert $claims_obj($ptr(^^claim, SL#c2), $ptr(^^claim, SL#c));
    assert $top_writable($s, #wrTime$1^35.1, $ptr(^^claim, SL#c));
    assert $is_claimable(^^claim);
    call $write_ref_cnt($ptr(^^claim, SL#c), $ref_cnt($s, $ptr(^^claim, SL#c)) - 1);
    assume $ref_cnt($s, $ptr(^^claim, SL#c)) >= 0;
    assume $full_stop_ext(#tok$1^56.25, $s);
    // empty
    // stmt @unclaim(c, a); 
    assert $top_writable($s, #wrTime$1^35.1, $ptr(^^claim, SL#c));
    call $unclaim($ptr(^^claim, SL#c));
    assert $claims_obj($ptr(^^claim, SL#c), $ptr(^A, L#a));
    assert $top_writable($s, #wrTime$1^35.1, $ptr(^A, L#a));
    assert $is_claimable(^A);
    call $write_ref_cnt($ptr(^A, L#a), $ref_cnt($s, $ptr(^A, L#a)) - 1);
    assume $ref_cnt($s, $ptr(^A, L#a)) >= 0;
    assume $full_stop_ext(#tok$1^57.25, $s);
    // empty
    // _math ptrset owns#5; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#5, $ptrset_to_int(owns#5), ^$#ptrset);
    // owns#5 := @_vcc_set_empty; 
    owns#5 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#5, $ptrset_to_int(owns#5), ^$#ptrset);
    // _math state_t prestate#4; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#4, $state_to_int(prestate#4), ^$#state_t);
    // prestate#4 := @_vcc_current_state(@state); 
    prestate#4 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#4, $state_to_int(prestate#4), ^$#state_t);
    // _math state_t prestate#6; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#6, $state_to_int(prestate#6), ^$#state_t);
    // prestate#6 := @_vcc_current_state(@state); 
    prestate#6 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#6, $state_to_int(prestate#6), ^$#state_t);
    // assert @_vcc_wrapped(@state, a); 
    assert $wrapped($s, $ptr(^A, L#a), ^A);
    // assert @writes_check(a); 
    assert $top_writable($s, #wrTime$1^35.1, $ptr(^A, L#a));
    // assume @_vcc_inv(@state, a); 
    assume $inv($s, $ptr(^A, L#a), ^A);
    // assume ==(owns#5, @_vcc_owns(@state, a)); 
    assume owns#5 == $owns($s, $ptr(^A, L#a));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(a), prestate#6)
    call $static_unwrap($ptr(^A, L#a), prestate#6);
    assume $good_state_ext(#tok$1^58.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @writes_check(a); 
    assert $top_writable($s, #wrTime$1^35.1, $ptr(^A, L#a));
    // assert @writes_check(@_vcc_extent(@state, a)); 
    assert (forall #writes$1^59.3: $ptr :: { $dont_instantiate(#writes$1^59.3) } $set_in(#writes$1^59.3, $extent($s, $ptr(^A, L#a))) ==> $top_writable($s, #wrTime$1^35.1, #writes$1^59.3));
    // stmt _vcc_free(a); 
    call $free($ptr(^A, L#a));
    assume $full_stop_ext(#tok$1^59.3, $s);
    // stmt _vcc_stack_free(@stackframe, addr.tmp); 
    call $stack_free(#stackframe, $ptr(^^i4, addr.tmp));
    assume $full_stop_ext(#tok$1^35.1, $s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



const unique l#public: $label;

const unique #tok$1^59.3: $token;

const unique #tok$1^58.19: $token;

const unique #loc.prestate#6: $token;

const unique #loc.prestate#4: $token;

const unique #loc.owns#5: $token;

const unique #tok$1^57.25: $token;

const unique #tok$1^56.25: $token;

const unique #tok$1^48.3: $token;

const unique #tok$1^47.30: $token;

const unique #tok$1^45.19: $token;

const unique #loc.owns#2: $token;

const unique #loc.staticWrapState#1: $token;

function $state_to_int(x: $state) : int;

function $int_to_state(x: int) : $state;

axiom (forall #x: $state :: #x == $int_to_state($state_to_int(#x)));

const unique #loc.prestate#3: $token;

const unique #tok$2^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(2, #file^?3Cno?20file?3E);

const unique #tok$1^44.3: $token;

const unique #tok$1^42.7: $token;

const unique #tok$1^37.10: $token;

const unique #loc.addr.tmp: $token;

const unique #tok$1^39.26: $token;

const unique #loc.c2: $token;

const unique #tok$1^40.26: $token;

const unique #tok$1^35.1: $token;

const unique #loc.cres: $token;

const unique #tok$1^32.33: $token;

const unique #tok$1^31.4: $token;

const unique #tok$1^27.19: $token;

const unique #tok$1^28.5: $token;

const unique #loc.val: $token;

const unique #tok$1^25.3: $token;

const unique #distTp3: $ctype;

axiom #distTp3 == $spec_ptr_to(^^claim);

const unique #loc.c: $token;

const unique #distTp2: $ctype;

axiom #distTp2 == $ptr_to(^^i4);

const unique #loc.res: $token;

const unique #loc.a: $token;

const unique #tok$1^9.1: $token;

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^A);

const unique #loc._this_: $token;

const unique #tok$1^4.28: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CClaimPassing.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CClaimPassing.c);
