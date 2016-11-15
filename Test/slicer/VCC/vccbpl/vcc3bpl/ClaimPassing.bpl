axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

const unique ^A: $ctype;

axiom $def_struct_type(^A, 4, true, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^A) } $inv2(#s1, #s2, #p, ^A) == ($set_eq($owns(#s2, #p), $set_empty()) && ($rd_inv(#s1, A.x, #p) == $rd_inv(#s2, A.x, #p) || $rd_inv(#s1, A.x, #p) + 1 == $rd_inv(#s2, A.x, #p))));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^A)) } $in(q, $composite_extent(s, p, ^A)) == (q == p));

const unique A.x: $field;

axiom $def_phys_field(^A, A.x, ^^i4, true, 0);

procedure A#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $set_eq($owns($s, $phys_ptr_cast(P#_this_, ^A)), $set_empty());
  ensures $is_admissibility_check() ==> $rd_inv(old($s), A.x, $phys_ptr_cast(P#_this_, ^A)) == $rd_inv($s, A.x, $phys_ptr_cast(P#_this_, ^A)) || $rd_inv(old($s), A.x, $phys_ptr_cast(P#_this_, ^A)) + 1 == $rd_inv($s, A.x, $phys_ptr_cast(P#_this_, ^A));
  ensures $is_stuttering_check() ==> $rd_inv($s, A.x, $phys_ptr_cast(P#_this_, ^A)) == $rd_inv($s, A.x, $phys_ptr_cast(P#_this_, ^A)) || $rd_inv($s, A.x, $phys_ptr_cast(P#_this_, ^A)) + 1 == $rd_inv($s, A.x, $phys_ptr_cast(P#_this_, ^A));
  ensures $is_unwrap_check() ==> $set_eq($owns($s, $phys_ptr_cast(P#_this_, ^A)), $set_empty());
  ensures $is_unwrap_check() ==> $rd_inv(old($s), A.x, $phys_ptr_cast(P#_this_, ^A)) == $rd_inv($s, A.x, $phys_ptr_cast(P#_this_, ^A)) || $rd_inv(old($s), A.x, $phys_ptr_cast(P#_this_, ^A)) + 1 == $rd_inv($s, A.x, $phys_ptr_cast(P#_this_, ^A));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation A#adm(P#_this_: $ptr)
{
  var #wrTime$1^4.28: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^4.28, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^4.28, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^A));
    assume #wrTime$1^4.28 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^4.28, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($phys_ptr_cast(P#_this_, ^A), ^A);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $phys_ptr_cast(P#_this_, ^A));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($phys_ptr_cast(P#_this_, ^A));
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
            assume $admissibility_pre($s, $phys_ptr_cast(P#_this_, ^A));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $phys_ptr_cast(P#_this_, ^A));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct A*)@null))
        call $havoc_others($phys_ptr_cast(P#_this_, ^A), ^A);
        assume $good_state_ext(#tok$1^4.28, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $phys_ptr_cast(P#_this_, ^A), ^A);
    }

  #exit:
}



procedure incr(P#a: $ptr, P#res: $ptr, SP#c: $ptr) returns (OP#cres: $ptr);
  requires true;
  requires $wrapped($s, $spec_ptr_cast(SP#c, ^^claim), ^^claim);
  requires $valid_claim($s, $spec_ptr_cast(SP#c, ^^claim));
  requires (forall #cs0: $state :: { $valid_claim(#cs0, $spec_ptr_cast(SP#c, ^^claim)) } $valid_claim(#cs0, $spec_ptr_cast(SP#c, ^^claim)) ==> $claimed_closed(#cs0, $phys_ptr_cast(P#a, ^A)));
  modifies $s, $cev_pc;
  free ensures true;
  ensures $ref_cnt($s, $spec_ptr_cast(SP#c, ^^claim)) == $ref_cnt(old($s), $spec_ptr_cast(SP#c, ^^claim)) + 1;
  ensures $claims_obj($spec_ptr_cast(OP#cres, ^^claim), $spec_ptr_cast(SP#c, ^^claim));
  ensures $wrapped($s, $spec_ptr_cast(OP#cres, ^^claim), ^^claim) && $ref_cnt($s, $spec_ptr_cast(OP#cres, ^^claim)) == 0;
  ensures (forall #cs1: $state :: { $valid_claim(#cs1, $spec_ptr_cast(OP#cres, ^^claim)) } $valid_claim(#cs1, $spec_ptr_cast(OP#cres, ^^claim)) ==> $rd_inv(#cs1, A.x, $phys_ptr_cast(P#a, ^A)) >= $rd_inv($s, $field($phys_ptr_cast(P#res, ^^i4)), $emb0($phys_ptr_cast(P#res, ^^i4))));
  ensures $is_fresh(old($s), $s, $spec_ptr_cast(OP#cres, ^^claim));
  ensures $mutable($s, $phys_ptr_cast(P#res, ^^i4));
  ensures $wrapped($s, $spec_ptr_cast(SP#c, ^^claim), ^^claim) && $valid_claim($s, $spec_ptr_cast(SP#c, ^^claim));
  ensures $mutable($s, $phys_ptr_cast(P#res, ^^i4));
  ensures $emb($s, $phys_ptr_cast(P#res, ^^i4)) == $emb(old($s), $phys_ptr_cast(P#res, ^^i4));
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $spec_ptr_cast(SP#c, ^^claim) || #p == $phys_ptr_cast(P#res, ^^i4)));
  free ensures $call_transition(old($s), $s);



implementation incr(P#a: $ptr, P#res: $ptr, SP#c: $ptr) returns (OP#cres: $ptr)
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
    assume $local_value_is($s, #tok$1^9.1, #loc.a, $ptr_to_int(P#a), $ptr_to(^A));
    assume $local_value_is($s, #tok$1^9.1, #loc.res, $ptr_to_int(P#res), $ptr_to(^^i4));
    assume $local_value_is($s, #tok$1^9.1, #loc.c, $ptr_to_int(SP#c), $spec_ptr_to(^^claim));
    assume #wrTime$1^9.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^9.1, (lambda #p: $ptr :: #p == $spec_ptr_cast(SP#c, ^^claim) || #p == $phys_ptr_cast(P#res, ^^i4)));
    assume $thread_owned($s, $spec_ptr_cast(SP#c, ^^claim));
    assume $mutable($s, $phys_ptr_cast(P#res, ^^i4));
    // assume true; 
    assume true;
    // assume true; 
    assume true;
    // assume true; 
    assume true;
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_valid_claim(@state, c); 
    assert $valid_claim($s, $spec_ptr_cast(SP#c, ^^claim));
    // assert @_vcc_in_domain(@state, c, c); 
    assert $in_domain_lab($s, $spec_ptr_cast(SP#c, ^^claim), $spec_ptr_cast(SP#c, ^^claim), l#public);
    // int32_t val; 
    assume $local_value_is($s, #tok$1^25.3, #loc.val, L#val, ^^i4);
    // var int32_t val
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^27.19, $s);
    atomicObj#7 := $phys_ptr_cast(P#a, ^A);
    assert $valid_claim($s, $spec_ptr_cast(SP#c, ^^claim));
    assert $closed($s, atomicObj#7);
    assume $inv($s, atomicObj#7, ^A);
    beforeAtomicState#0 := $s;
    // assert @reads_check_normal((a->x)); 
    assert $mutable($s, $phys_ptr_cast(P#a, ^A)) || $phys_ptr_cast(P#a, ^A) == atomicObj#7;
    // val := *((a->x)); 
    L#val := $rd_inv($s, A.x, $phys_ptr_cast(P#a, ^A));
    assume $local_value_is($s, #tok$1^28.5, #loc.val, L#val, ^^i4);
    assert $set_eq($owns($s, atomicObj#7), $set_empty());
    assert $rd_inv(beforeAtomicState#0, A.x, atomicObj#7) == $rd_inv($s, A.x, atomicObj#7) || $rd_inv(beforeAtomicState#0, A.x, atomicObj#7) + 1 == $rd_inv($s, A.x, atomicObj#7);
    assume $full_stop_ext(#tok$1^27.19, $s);
    // assert @prim_writes_check(res); 
    assert $writable_prim($s, #wrTime$1^9.1, $phys_ptr_cast(P#res, ^^i4));
    // *res := val; 
    call $write_int($field($phys_ptr_cast(P#res, ^^i4)), $emb0($phys_ptr_cast(P#res, ^^i4)), L#val);
    assume $full_stop_ext(#tok$1^31.4, $s);
    // cres := @claim(pure(<=(pure(old(@_vcc_when_claimed, *(res))), *((a->x)))), c); 
    assert $closed($s, $spec_ptr_cast(SP#c, ^^claim));
    assert $top_writable($s, #wrTime$1^9.1, $spec_ptr_cast(SP#c, ^^claim));
    assert $is_claimable(^^claim);
    call $write_ref_cnt($spec_ptr_cast(SP#c, ^^claim), $ref_cnt($s, $spec_ptr_cast(SP#c, ^^claim)) + 1);
    assume $ref_cnt($s, $spec_ptr_cast(SP#c, ^^claim)) >= 0;
    claim#0s0 := $s;
    call claim#0 := $alloc_claim();
    assume $claims_obj(claim#0, $spec_ptr_cast(SP#c, ^^claim));
    OP#cres := claim#0;
    assume $local_value_is($s, #tok$1^32.33, #loc.cres, $ptr_to_int(OP#cres), $spec_ptr_to(^^claim));
    assume $full_stop_ext(#tok$1^32.33, $s);
    assume claim#0 != $no_claim ==> $claim_initial_assumptions($s, claim#0, #tok$1^32.33);
    assert claim#0 != $no_claim ==> $rd_inv($s, $field($phys_ptr_cast(P#res, ^^i4)), $emb0($phys_ptr_cast(P#res, ^^i4))) <= $rd_inv($s, A.x, $phys_ptr_cast(P#a, ^A));
    if (claim#0doAdm)
    {
      anon7:
        assume $rd_inv($s, $field($phys_ptr_cast(P#res, ^^i4)), $emb0($phys_ptr_cast(P#res, ^^i4))) <= $rd_inv(claim#0s1, A.x, $phys_ptr_cast(P#a, ^A));
        assume $valid_claim_impl(claim#0s0, claim#0s2);
        assume $claim_transitivity_assumptions(claim#0s1, claim#0s2, claim#0, #tok$1^32.33);
        assert $rd_inv($s, $field($phys_ptr_cast(P#res, ^^i4)), $emb0($phys_ptr_cast(P#res, ^^i4))) <= $rd_inv(claim#0s2, A.x, $phys_ptr_cast(P#a, ^A));
        assume false;
    }

  anon9:
    assume claim#0 != $no_claim ==> (forall #cs2: $state :: { $valid_claim(#cs2, claim#0) } $valid_claim(#cs2, claim#0) ==> $rd_inv($s, $field($phys_ptr_cast(P#res, ^^i4)), $emb0($phys_ptr_cast(P#res, ^^i4))) <= $rd_inv(#cs2, A.x, $phys_ptr_cast(P#a, ^A)));
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
  var L#a: $ptr;
  var addr.tmp: $ptr;
  var SL#c: $ptr;
  var SL#c2: $ptr;
  var #wrTime$1^35.1: int;
  var #stackframe: int;

  anon11:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^35.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^35.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^35.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // claim_t^ c2; 
    assume $local_value_is($s, #tok$1^40.26, #loc.c2, $ptr_to_int(SL#c2), $spec_ptr_to(^^claim));
    // claim_t^ c; 
    assume $local_value_is($s, #tok$1^39.26, #loc.c, $ptr_to_int(SL#c), $spec_ptr_to(^^claim));
    // int32_t* addr.tmp; 
    assume $local_value_is($s, #tok$1^35.1, #loc.addr.tmp, $ptr_to_int(addr.tmp), $ptr_to(^^i4));
    // addr.tmp := _vcc_stack_alloc<int32_t>(@stackframe, false); 
    call addr.tmp := $stack_alloc(^^i4, #stackframe, false);
    assume $full_stop_ext(#tok$1^35.1, $s);
    assume $local_value_is($s, #tok$1^35.1, #loc.addr.tmp, $ptr_to_int(addr.tmp), $ptr_to(^^i4));
    // struct A* a; 
    assume $local_value_is($s, #tok$1^37.10, #loc.a, $ptr_to_int(L#a), $ptr_to(^A));
    // var struct A* a
    // var int32_t tmp
    // var spec claim_t^ c
    // var spec claim_t^ c2
    // a := _vcc_alloc(@_vcc_typeof((struct A*)@null)); 
    call L#a := $alloc(^A);
    assume $full_stop_ext(#tok$1^42.7, $s);
    assume $local_value_is($s, #tok$1^42.7, #loc.a, $ptr_to_int(L#a), $ptr_to(^A));
    // assume @_vcc_ptr_neq_null(a); 
    assume $non_null($phys_ptr_cast(L#a, ^A));
    // assert @prim_writes_check((a->x)); 
    assert $writable_prim($s, #wrTime$1^35.1, $dot($phys_ptr_cast(L#a, ^A), A.x));
    // *(a->x) := 0; 
    call $write_int(A.x, $phys_ptr_cast(L#a, ^A), 0);
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
    assert $top_writable($s, #wrTime$1^35.1, $phys_ptr_cast(L#a, ^A));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(a), staticWrapState#1, owns#2)
    call $static_wrap($phys_ptr_cast(L#a, ^A), staticWrapState#1, owns#2);
    assume $good_state_ext(#tok$1^45.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, a), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(L#a, ^A)), $set_empty());
    // assert @inv_check(||(==(old(prestate#3, *((a->x))), *((a->x))), ==(+(old(prestate#3, *((a->x))), 1), *((a->x))))); 
    assert $rd_inv(prestate#3, A.x, $phys_ptr_cast(L#a, ^A)) == $rd_inv($s, A.x, $phys_ptr_cast(L#a, ^A)) || $rd_inv(prestate#3, A.x, $phys_ptr_cast(L#a, ^A)) + 1 == $rd_inv($s, A.x, $phys_ptr_cast(L#a, ^A));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // c := @claim(pure(true), a); 
    assert $closed($s, $phys_ptr_cast(L#a, ^A));
    assert $top_writable($s, #wrTime$1^35.1, $phys_ptr_cast(L#a, ^A));
    assert $is_claimable(^A);
    call $write_ref_cnt($phys_ptr_cast(L#a, ^A), $ref_cnt($s, $phys_ptr_cast(L#a, ^A)) + 1);
    assume $ref_cnt($s, $phys_ptr_cast(L#a, ^A)) >= 0;
    claim#1s0 := $s;
    call claim#1 := $alloc_claim();
    assume $claims_obj(claim#1, $phys_ptr_cast(L#a, ^A));
    SL#c := claim#1;
    assume $local_value_is($s, #tok$1^47.30, #loc.c, $ptr_to_int(SL#c), $spec_ptr_to(^^claim));
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
    assert $top_writable($s, #wrTime$1^35.1, $spec_ptr_cast(SL#c, ^^claim));
    // assert @prim_writes_check(addr.tmp); 
    assert $writable_prim($s, #wrTime$1^35.1, $phys_ptr_cast(addr.tmp, ^^i4));
    // c2 := incr(a, addr.tmp, c); 
    call SL#c2 := incr($phys_ptr_cast(L#a, ^A), $phys_ptr_cast(addr.tmp, ^^i4), $spec_ptr_cast(SL#c, ^^claim));
    assume $full_stop_ext(#tok$1^48.3, $s);
    assume $local_value_is($s, #tok$1^48.3, #loc.c2, $ptr_to_int(SL#c2), $spec_ptr_to(^^claim));
    // assert @_vcc_wrapped(@state, c); 
    assert $wrapped($s, $spec_ptr_cast(SL#c, ^^claim), ^^claim);
    // assume @_vcc_wrapped(@state, c); 
    assume $wrapped($s, $spec_ptr_cast(SL#c, ^^claim), ^^claim);
    // assert @_vcc_valid_claim(@state, c2); 
    assert $valid_claim($s, $spec_ptr_cast(SL#c2, ^^claim));
    // assume @_vcc_valid_claim(@state, c2); 
    assume $valid_claim($s, $spec_ptr_cast(SL#c2, ^^claim));
    // assert <=(*(addr.tmp), *((a->x))); 
    assert $rd_inv($s, $field($phys_ptr_cast(addr.tmp, ^^i4)), $emb0($phys_ptr_cast(addr.tmp, ^^i4))) <= $rd_inv($s, A.x, $phys_ptr_cast(L#a, ^A));
    // assume <=(*(addr.tmp), *((a->x))); 
    assume $rd_inv($s, $field($phys_ptr_cast(addr.tmp, ^^i4)), $emb0($phys_ptr_cast(addr.tmp, ^^i4))) <= $rd_inv($s, A.x, $phys_ptr_cast(L#a, ^A));
    // assert @_vcc_wrapped(@state, c); 
    assert $wrapped($s, $spec_ptr_cast(SL#c, ^^claim), ^^claim);
    // assume @_vcc_wrapped(@state, c); 
    assume $wrapped($s, $spec_ptr_cast(SL#c, ^^claim), ^^claim);
    // stmt @unclaim(c2, c); 
    assert $top_writable($s, #wrTime$1^35.1, $spec_ptr_cast(SL#c2, ^^claim));
    call $unclaim($spec_ptr_cast(SL#c2, ^^claim));
    assert $claims_obj($spec_ptr_cast(SL#c2, ^^claim), $spec_ptr_cast(SL#c, ^^claim));
    assert $top_writable($s, #wrTime$1^35.1, $spec_ptr_cast(SL#c, ^^claim));
    assert $is_claimable(^^claim);
    call $write_ref_cnt($spec_ptr_cast(SL#c, ^^claim), $ref_cnt($s, $spec_ptr_cast(SL#c, ^^claim)) - 1);
    assume $ref_cnt($s, $spec_ptr_cast(SL#c, ^^claim)) >= 0;
    assume $full_stop_ext(#tok$1^56.25, $s);
    // empty
    // stmt @unclaim(c, a); 
    assert $top_writable($s, #wrTime$1^35.1, $spec_ptr_cast(SL#c, ^^claim));
    call $unclaim($spec_ptr_cast(SL#c, ^^claim));
    assert $claims_obj($spec_ptr_cast(SL#c, ^^claim), $phys_ptr_cast(L#a, ^A));
    assert $top_writable($s, #wrTime$1^35.1, $phys_ptr_cast(L#a, ^A));
    assert $is_claimable(^A);
    call $write_ref_cnt($phys_ptr_cast(L#a, ^A), $ref_cnt($s, $phys_ptr_cast(L#a, ^A)) - 1);
    assume $ref_cnt($s, $phys_ptr_cast(L#a, ^A)) >= 0;
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
    assert $wrapped($s, $phys_ptr_cast(L#a, ^A), ^A);
    // assert @writes_check(a); 
    assert $top_writable($s, #wrTime$1^35.1, $phys_ptr_cast(L#a, ^A));
    // assume @_vcc_inv(@state, a); 
    assume $inv($s, $phys_ptr_cast(L#a, ^A), ^A);
    // assume ==(owns#5, @_vcc_owns(@state, a)); 
    assume owns#5 == $owns($s, $phys_ptr_cast(L#a, ^A));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(a), prestate#6)
    call $static_unwrap($phys_ptr_cast(L#a, ^A), prestate#6);
    assume $good_state_ext(#tok$1^58.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @writes_check(a); 
    assert $top_writable($s, #wrTime$1^35.1, $phys_ptr_cast(L#a, ^A));
    // assert @writes_check(@_vcc_extent(@state, a)); 
    assert (forall #writes$1^59.3: $ptr :: { $dont_instantiate(#writes$1^59.3) } $set_in(#writes$1^59.3, $extent($s, $phys_ptr_cast(L#a, ^A))) ==> $top_writable($s, #wrTime$1^35.1, #writes$1^59.3));
    // stmt _vcc_free(a); 
    call $free($phys_ptr_cast(L#a, ^A));
    assume $full_stop_ext(#tok$1^59.3, $s);
    // stmt _vcc_stack_free(@stackframe, addr.tmp); 
    call $stack_free(#stackframe, $phys_ptr_cast(addr.tmp, ^^i4));
    assume $full_stop_ext(#tok$1^35.1, $s);
    // return; 
    assert $position_marker();
    goto #exit;

  anon13:
    // Block cleanup
    // stmt _vcc_stack_free(@stackframe, addr.tmp); 
    call $stack_free(#stackframe, $phys_ptr_cast(addr.tmp, ^^i4));
    assume $full_stop_ext(#tok$1^35.1, $s);

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

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CClaimPassing.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CClaimPassing.c);
