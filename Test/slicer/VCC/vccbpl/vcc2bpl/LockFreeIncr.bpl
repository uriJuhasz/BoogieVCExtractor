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

axiom $is_claimable(^A) == false;

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
  var #wrTime$1^13.1: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^13.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^13.1, #loc._this_, $ptr_to_int($ptr(^A, P#_this_)), $ptr_to(^A)) && $local_value_is_ptr($s, #tok$1^13.1, #loc._this_, $ptr(^A, P#_this_), $ptr_to(^A));
    assume #wrTime$1^13.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^13.1, #p) } $in_writes_at(#wrTime$1^13.1, #p) == false);
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
        assume $good_state_ext(#tok$1^13.1, $s);
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
        assume $good_state_ext(#tok$1^13.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^A, P#_this_), ^A);
    }

  #exit:
}



procedure LockFreeIncr(P#a: int, SP#c: int);
  requires true;
  requires $wrapped($s, $ptr(^^claim, SP#c), ^^claim);
  requires $valid_claim($s, $ptr(^^claim, SP#c));
  requires (forall #cs0: $state :: { $valid_claim(#cs0, $ptr(^^claim, SP#c)) } $valid_claim(#cs0, $ptr(^^claim, SP#c)) ==> $claimed_closed(#cs0, $ptr(^A, P#a)));
  modifies $s, $cev_pc;
  ensures $ref_cnt($s, $ptr(^^claim, SP#c)) == $ref_cnt(old($s), $ptr(^^claim, SP#c));
  ensures $wrapped($s, $ptr(^^claim, SP#c), ^^claim) && $valid_claim($s, $ptr(^^claim, SP#c));
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^^claim, SP#c) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^^claim, SP#c) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^^claim, SP#c) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation LockFreeIncr(P#a: int, SP#c: int)
{
  var beforeAtomicState#2: $state;
  var atomicObj#6: $ptr;
  var claim#1doAdm: bool;
  var claim#1s2: $state;
  var claim#1s1: $state;
  var claim#1s0: $state;
  var claim#1: $ptr;
  var res#3: int where $in_range_i4(res#3);
  var Exchange#2: int where $in_range_i4(Exchange#2);
  var Destination#1: int where $in_range_phys_ptr(Destination#1);
  var beforeAtomicState#1: $state;
  var atomicObj#5: $ptr;
  var claim#0doAdm: bool;
  var claim#0s2: $state;
  var claim#0s1: $state;
  var claim#0s0: $state;
  var claim#0: $ptr;
  var beforeAtomicState#0: $state;
  var atomicObj#4: $ptr;
  var L#y: int where $in_range_i4(L#y);
  var L#z: int where $in_range_i4(L#z);
  var SL#c1: int where $in_range_spec_ptr(SL#c1);
  var SL#c2: int where $in_range_spec_ptr(SL#c2);
  var #wrTime$1^18.1: int;
  var #stackframe: int;

  anon13:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^18.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^18.1, #loc.a, $ptr_to_int($ptr(^A, P#a)), $ptr_to(^A)) && $local_value_is_ptr($s, #tok$1^18.1, #loc.a, $ptr(^A, P#a), $ptr_to(^A));
    assume $local_value_is($s, #tok$1^18.1, #loc.c, $ptr_to_int($ptr(^^claim, SP#c)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^18.1, #loc.c, $ptr(^^claim, SP#c), $spec_ptr_to(^^claim));
    assume #wrTime$1^18.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^18.1, #p) } $in_writes_at(#wrTime$1^18.1, #p) == (#p == $ptr(^^claim, SP#c)));
    assume $thread_owned($s, $ptr(^^claim, SP#c));
    // assume @in_range_phys_ptr((mathint)a); 
    assume $in_range_phys_ptr($ref($ptr(^A, P#a)));
    // assume @in_range_spec_ptr((mathint)c); 
    assume $in_range_spec_ptr($ref($ptr(^^claim, SP#c)));
    // assert @_vcc_valid_claim(@state, c); 
    assert $valid_claim($s, $ptr(^^claim, SP#c));
    // assert @_vcc_in_domain(@state, c, c); 
    assert $in_domain_lab($s, $ptr(^^claim, SP#c), $ptr(^^claim, SP#c), l#public);
    // claim_t^ c2; 
    assume $local_value_is($s, #tok$1^25.26, #loc.c2, $ptr_to_int($ptr(^^claim, SL#c2)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^25.26, #loc.c2, $ptr(^^claim, SL#c2), $spec_ptr_to(^^claim));
    // claim_t^ c1; 
    assume $local_value_is($s, #tok$1^25.26, #loc.c1, $ptr_to_int($ptr(^^claim, SL#c1)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^25.26, #loc.c1, $ptr(^^claim, SL#c1), $spec_ptr_to(^^claim));
    // int32_t z; 
    assume $local_value_is($s, #tok$1^24.3, #loc.z, L#z, ^^i4);
    // int32_t y; 
    assume $local_value_is($s, #tok$1^23.3, #loc.y, L#y, ^^i4);
    // var int32_t y
    // var int32_t z
    // var spec claim_t^ c1
    // var spec claim_t^ c2
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^27.19, $s);
    atomicObj#4 := $ptr(^A, P#a);
    assert $valid_claim($s, $ptr(^^claim, SP#c));
    assert $closed($s, atomicObj#4);
    assume $inv($s, atomicObj#4, ^A);
    beforeAtomicState#0 := $s;
    assume claim#0 == $no_claim;
    // assert @reads_check_normal((a->x)); 
    assert $typed2($s, $dot($ptr(^A, P#a), A.x), ^^i4);
    assert $mutable($s, $ptr(^A, P#a)) || $ptr(^A, P#a) == atomicObj#4;
    // y := *((a->x)); 
    L#y := $mem($s, $dot($ptr(^A, P#a), A.x));
    assume $local_value_is($s, #tok$1^28.5, #loc.y, L#y, ^^i4);
    // c1 := @claim(pure(<=(y, *((a->x)))), c); 
    assert $closed($s, $ptr(^^claim, SP#c));
    assert $top_writable($s, #wrTime$1^18.1, $ptr(^^claim, SP#c)) || $owner($s, $ptr(^^claim, SP#c)) == atomicObj#4;
    assert $is_claimable(^^claim);
    call $write_ref_cnt($ptr(^^claim, SP#c), $ref_cnt($s, $ptr(^^claim, SP#c)) + 1);
    assume $ref_cnt($s, $ptr(^^claim, SP#c)) >= 0;
    claim#0s0 := $s;
    call claim#0 := $alloc_claim();
    assume $claims_obj(claim#0, $ptr(^^claim, SP#c));
    SL#c1 := $ref(claim#0);
    assume $local_value_is($s, #tok$1^29.33, #loc.c1, $ptr_to_int($ptr(^^claim, SL#c1)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^29.33, #loc.c1, $ptr(^^claim, SL#c1), $spec_ptr_to(^^claim));
    assume $good_state_ext(#tok$1^29.33, $s);
    assume claim#0 != $no_claim ==> $claim_initial_assumptions($s, claim#0, #tok$1^29.33);
    assert claim#0 != $no_claim ==> L#y <= $mem($s, $dot($ptr(^A, P#a), A.x));
    if (claim#0 != $no_claim && claim#0doAdm)
    {
      anon7:
        assume L#y <= $mem(claim#0s1, $dot($ptr(^A, P#a), A.x));
        assume $valid_claim_impl(claim#0s0, claim#0s2);
        assume $claim_transitivity_assumptions(claim#0s1, claim#0s2, claim#0, #tok$1^29.33);
        assert L#y <= $mem(claim#0s2, $dot($ptr(^A, P#a), A.x));
        assume false;
    }

  anon14:
    assume claim#0 != $no_claim ==> (forall #cs1: $state :: { $valid_claim(#cs1, claim#0) } $valid_claim(#cs1, claim#0) ==> L#y <= $mem(#cs1, $dot($ptr(^A, P#a), A.x)));
    assert $set_eq($owns($s, atomicObj#4), $set_empty());
    assert $mem(beforeAtomicState#0, $dot(atomicObj#4, A.x)) == $mem($s, $dot(atomicObj#4, A.x)) || $mem(beforeAtomicState#0, $dot(atomicObj#4, A.x)) + 1 == $mem($s, $dot(atomicObj#4, A.x));
    assume $full_stop_ext(#tok$1^27.19, $s);
    assume true;
    // if (>=(y, 2147483647)) ...
    if (L#y >= 2147483647)
    {
      anon8:
        // stmt @unclaim(c1, c); 
        assert $top_writable($s, #wrTime$1^18.1, $ptr(^^claim, SL#c1));
        call $unclaim($ptr(^^claim, SL#c1));
        assert $claims_obj($ptr(^^claim, SL#c1), $ptr(^^claim, SP#c));
        assert $top_writable($s, #wrTime$1^18.1, $ptr(^^claim, SP#c));
        assert $is_claimable(^^claim);
        call $write_ref_cnt($ptr(^^claim, SP#c), $ref_cnt($s, $ptr(^^claim, SP#c)) - 1);
        assume $ref_cnt($s, $ptr(^^claim, SP#c)) >= 0;
        assume $full_stop_ext(#tok$1^33.27, $s);
        // empty
        // return; 
        assert $position_marker();
        goto #exit;
    }
    else
    {
      anon9:
        // empty
    }

  anon15:
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^37.19, $s);
    atomicObj#5 := $ptr(^A, P#a);
    assert $valid_claim($s, $ptr(^^claim, SP#c));
    assert $valid_claim($s, $ptr(^^claim, SL#c1));
    assert $closed($s, atomicObj#5);
    assume $inv($s, atomicObj#5, ^A);
    beforeAtomicState#1 := $s;
    assume claim#1 == $no_claim;
    // int32_t* Destination#1; 
    assume $local_value_is($s, #tok$1^38.36, #loc.Destination#1, $ptr_to_int($ptr(^^i4, Destination#1)), $ptr_to(^^i4)) && $local_value_is_ptr($s, #tok$1^38.36, #loc.Destination#1, $ptr(^^i4, Destination#1), $ptr_to(^^i4));
    // Destination#1 := (a->x); 
    Destination#1 := $ref($dot($ptr(^A, P#a), A.x));
    assume $local_value_is($s, #tok$1^38.36, #loc.Destination#1, $ptr_to_int($ptr(^^i4, Destination#1)), $ptr_to(^^i4)) && $local_value_is_ptr($s, #tok$1^38.36, #loc.Destination#1, $ptr(^^i4, Destination#1), $ptr_to(^^i4));
    // int32_t Exchange#2; 
    assume $local_value_is($s, #tok$1^38.43, #loc.Exchange#2, Exchange#2, ^^i4);
    // assert @in_range_i4(+(y, 1)); 
    assert $in_range_i4(L#y + 1);
    // Exchange#2 := +(y, 1); 
    Exchange#2 := L#y + 1;
    assume $local_value_is($s, #tok$1^38.43, #loc.Exchange#2, Exchange#2, ^^i4);
    // int32_t res#3; 
    assume $local_value_is($s, #tok$1^38.9, #loc.res#3, res#3, ^^i4);
    // assert @reads_check_normal(Destination#1); 
    assert $typed2($s, $ptr(^^i4, Destination#1), ^^i4);
    assert $thread_local2($s, $ptr(^^i4, Destination#1), ^^i4) || $set_in($ptr(^^i4, Destination#1), $span(atomicObj#5));
    assume true;
    // if (==(*(Destination#1), y)) ...
    if ($mem($s, $ptr(^^i4, Destination#1)) == L#y)
    {
      anon10:
        // assert @_vcc_typed2(@state, Destination#1); 
        assert $typed2($s, $ptr(^^i4, Destination#1), ^^i4);
        // assert @prim_writes_check(Destination#1); 
        assert $set_in($ptr(^^i4, Destination#1), $volatile_span($s, atomicObj#5)) || $writable($s, #wrTime$1^18.1, $ptr(^^i4, Destination#1));
        // *Destination#1 := Exchange#2; 
        call $write_int($ptr(^^i4, Destination#1), Exchange#2);
        assume $good_state_ext(#tok$1^38.36, $s);
        // res#3 := y; 
        res#3 := L#y;
        assume $local_value_is($s, #tok$1^7.5, #loc.res#3, res#3, ^^i4);
    }
    else
    {
      anon11:
        // assert @reads_check_normal(Destination#1); 
        assert $typed2($s, $ptr(^^i4, Destination#1), ^^i4);
        assert $thread_local2($s, $ptr(^^i4, Destination#1), ^^i4) || $set_in($ptr(^^i4, Destination#1), $span(atomicObj#5));
        // res#3 := *(Destination#1); 
        res#3 := $mem($s, $ptr(^^i4, Destination#1));
        assume $local_value_is($s, #tok$1^9.5, #loc.res#3, res#3, ^^i4);
    }

  anon16:
    // empty
    // z := res#3; 
    L#z := res#3;
    assume $local_value_is($s, #tok$1^38.5, #loc.z, L#z, ^^i4);
    // c2 := @claim(pure(<(y, *((a->x)))), c); 
    assert $closed($s, $ptr(^^claim, SP#c));
    assert $top_writable($s, #wrTime$1^18.1, $ptr(^^claim, SP#c)) || $owner($s, $ptr(^^claim, SP#c)) == atomicObj#5;
    assert $is_claimable(^^claim);
    call $write_ref_cnt($ptr(^^claim, SP#c), $ref_cnt($s, $ptr(^^claim, SP#c)) + 1);
    assume $ref_cnt($s, $ptr(^^claim, SP#c)) >= 0;
    claim#1s0 := $s;
    call claim#1 := $alloc_claim();
    assume $claims_obj(claim#1, $ptr(^^claim, SP#c));
    SL#c2 := $ref(claim#1);
    assume $local_value_is($s, #tok$1^39.33, #loc.c2, $ptr_to_int($ptr(^^claim, SL#c2)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^39.33, #loc.c2, $ptr(^^claim, SL#c2), $spec_ptr_to(^^claim));
    assume $good_state_ext(#tok$1^39.33, $s);
    assume claim#1 != $no_claim ==> $claim_initial_assumptions($s, claim#1, #tok$1^39.33);
    assert claim#1 != $no_claim ==> L#y < $mem($s, $dot($ptr(^A, P#a), A.x));
    if (claim#1 != $no_claim && claim#1doAdm)
    {
      anon12:
        assume L#y < $mem(claim#1s1, $dot($ptr(^A, P#a), A.x));
        assume $valid_claim_impl(claim#1s0, claim#1s2);
        assume $claim_transitivity_assumptions(claim#1s1, claim#1s2, claim#1, #tok$1^39.33);
        assert L#y < $mem(claim#1s2, $dot($ptr(^A, P#a), A.x));
        assume false;
    }

  anon17:
    assume claim#1 != $no_claim ==> (forall #cs2: $state :: { $valid_claim(#cs2, claim#1) } $valid_claim(#cs2, claim#1) ==> L#y < $mem(#cs2, $dot($ptr(^A, P#a), A.x)));
    assert $set_eq($owns($s, atomicObj#5), $set_empty());
    assert $mem(beforeAtomicState#1, $dot(atomicObj#5, A.x)) == $mem($s, $dot(atomicObj#5, A.x)) || $mem(beforeAtomicState#1, $dot(atomicObj#5, A.x)) + 1 == $mem($s, $dot(atomicObj#5, A.x));
    assume $full_stop_ext(#tok$1^37.19, $s);
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^42.19, $s);
    atomicObj#6 := $ptr(^A, P#a);
    assert $valid_claim($s, $ptr(^^claim, SP#c));
    assert $valid_claim($s, $ptr(^^claim, SL#c2));
    assert $closed($s, atomicObj#6);
    assume $inv($s, atomicObj#6, ^A);
    beforeAtomicState#2 := $s;
    // assert @reads_check_normal((a->x)); 
    assert $typed2($s, $dot($ptr(^A, P#a), A.x), ^^i4);
    assert $mutable($s, $ptr(^A, P#a)) || $ptr(^A, P#a) == atomicObj#6;
    // z := *((a->x)); 
    L#z := $mem($s, $dot($ptr(^A, P#a), A.x));
    assume $local_value_is($s, #tok$1^43.5, #loc.z, L#z, ^^i4);
    assert $set_eq($owns($s, atomicObj#6), $set_empty());
    assert $mem(beforeAtomicState#2, $dot(atomicObj#6, A.x)) == $mem($s, $dot(atomicObj#6, A.x)) || $mem(beforeAtomicState#2, $dot(atomicObj#6, A.x)) + 1 == $mem($s, $dot(atomicObj#6, A.x));
    assume $full_stop_ext(#tok$1^42.19, $s);
    // assert <(y, z); 
    assert L#y < L#z;
    // assume <(y, z); 
    assume L#y < L#z;
    // stmt @unclaim(c1, c); 
    assert $top_writable($s, #wrTime$1^18.1, $ptr(^^claim, SL#c1));
    call $unclaim($ptr(^^claim, SL#c1));
    assert $claims_obj($ptr(^^claim, SL#c1), $ptr(^^claim, SP#c));
    assert $top_writable($s, #wrTime$1^18.1, $ptr(^^claim, SP#c));
    assert $is_claimable(^^claim);
    call $write_ref_cnt($ptr(^^claim, SP#c), $ref_cnt($s, $ptr(^^claim, SP#c)) - 1);
    assume $ref_cnt($s, $ptr(^^claim, SP#c)) >= 0;
    assume $full_stop_ext(#tok$1^48.25, $s);
    // empty
    // stmt @unclaim(c2, c); 
    assert $top_writable($s, #wrTime$1^18.1, $ptr(^^claim, SL#c2));
    call $unclaim($ptr(^^claim, SL#c2));
    assert $claims_obj($ptr(^^claim, SL#c2), $ptr(^^claim, SP#c));
    assert $top_writable($s, #wrTime$1^18.1, $ptr(^^claim, SP#c));
    assert $is_claimable(^^claim);
    call $write_ref_cnt($ptr(^^claim, SP#c), $ref_cnt($s, $ptr(^^claim, SP#c)) - 1);
    assume $ref_cnt($s, $ptr(^^claim, SP#c)) >= 0;
    assume $full_stop_ext(#tok$1^49.25, $s);
    // empty
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



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
