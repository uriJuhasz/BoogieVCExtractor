axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

const unique ^A: $ctype;

axiom $def_struct_type(^A, 4, false, false);

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
  var #wrTime$1^13.1: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^13.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^13.1, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^A));
    assume #wrTime$1^13.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^13.1, (lambda #p: $ptr :: false));
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
        assume $good_state_ext(#tok$1^13.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $phys_ptr_cast(P#_this_, ^A), ^A);
    }

  #exit:
}



procedure LockFreeIncr(P#a: $ptr, SP#c: $ptr);
  requires true;
  requires $wrapped($s, $spec_ptr_cast(SP#c, ^^claim), ^^claim);
  requires $valid_claim($s, $spec_ptr_cast(SP#c, ^^claim));
  requires (forall #cs0: $state :: { $valid_claim(#cs0, $spec_ptr_cast(SP#c, ^^claim)) } $valid_claim(#cs0, $spec_ptr_cast(SP#c, ^^claim)) ==> $claimed_closed(#cs0, $phys_ptr_cast(P#a, ^A)));
  modifies $s, $cev_pc;
  ensures $ref_cnt($s, $spec_ptr_cast(SP#c, ^^claim)) == $ref_cnt(old($s), $spec_ptr_cast(SP#c, ^^claim));
  ensures $wrapped($s, $spec_ptr_cast(SP#c, ^^claim), ^^claim) && $valid_claim($s, $spec_ptr_cast(SP#c, ^^claim));
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $spec_ptr_cast(SP#c, ^^claim)));
  free ensures $call_transition(old($s), $s);



implementation LockFreeIncr(P#a: $ptr, SP#c: $ptr)
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
  var Destination#1: $ptr;
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
  var SL#c1: $ptr;
  var SL#c2: $ptr;
  var #wrTime$1^18.1: int;
  var #stackframe: int;

  anon13:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^18.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^18.1, #loc.a, $ptr_to_int(P#a), $ptr_to(^A));
    assume $local_value_is($s, #tok$1^18.1, #loc.c, $ptr_to_int(SP#c), $spec_ptr_to(^^claim));
    assume #wrTime$1^18.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^18.1, (lambda #p: $ptr :: #p == $spec_ptr_cast(SP#c, ^^claim)));
    assume $thread_owned($s, $spec_ptr_cast(SP#c, ^^claim));
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
    // claim_t^ c2; 
    assume $local_value_is($s, #tok$1^25.26, #loc.c2, $ptr_to_int(SL#c2), $spec_ptr_to(^^claim));
    // claim_t^ c1; 
    assume $local_value_is($s, #tok$1^25.26, #loc.c1, $ptr_to_int(SL#c1), $spec_ptr_to(^^claim));
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
    atomicObj#4 := $phys_ptr_cast(P#a, ^A);
    assert $valid_claim($s, $spec_ptr_cast(SP#c, ^^claim));
    assert $closed($s, atomicObj#4);
    assume $inv($s, atomicObj#4, ^A);
    beforeAtomicState#0 := $s;
    assume claim#0 == $no_claim;
    // assert @reads_check_normal((a->x)); 
    assert $mutable($s, $phys_ptr_cast(P#a, ^A)) || $phys_ptr_cast(P#a, ^A) == atomicObj#4;
    // y := *((a->x)); 
    L#y := $rd_inv($s, A.x, $phys_ptr_cast(P#a, ^A));
    assume $local_value_is($s, #tok$1^28.5, #loc.y, L#y, ^^i4);
    // c1 := @claim(pure(<=(y, *((a->x)))), c); 
    assert $closed($s, $spec_ptr_cast(SP#c, ^^claim));
    assert $top_writable($s, #wrTime$1^18.1, $spec_ptr_cast(SP#c, ^^claim)) || $owner($s, $spec_ptr_cast(SP#c, ^^claim)) == atomicObj#4;
    assert $is_claimable(^^claim);
    call $write_ref_cnt($spec_ptr_cast(SP#c, ^^claim), $ref_cnt($s, $spec_ptr_cast(SP#c, ^^claim)) + 1);
    assume $ref_cnt($s, $spec_ptr_cast(SP#c, ^^claim)) >= 0;
    claim#0s0 := $s;
    call claim#0 := $alloc_claim();
    assume $claims_obj(claim#0, $spec_ptr_cast(SP#c, ^^claim));
    SL#c1 := claim#0;
    assume $local_value_is($s, #tok$1^29.33, #loc.c1, $ptr_to_int(SL#c1), $spec_ptr_to(^^claim));
    assume $good_state_ext(#tok$1^29.33, $s);
    assume claim#0 != $no_claim ==> $claim_initial_assumptions($s, claim#0, #tok$1^29.33);
    assert claim#0 != $no_claim ==> L#y <= $rd_inv($s, A.x, $phys_ptr_cast(P#a, ^A));
    if (claim#0 != $no_claim && claim#0doAdm)
    {
      anon7:
        assume L#y <= $rd_inv(claim#0s1, A.x, $phys_ptr_cast(P#a, ^A));
        assume $valid_claim_impl(claim#0s0, claim#0s2);
        assume $claim_transitivity_assumptions(claim#0s1, claim#0s2, claim#0, #tok$1^29.33);
        assert L#y <= $rd_inv(claim#0s2, A.x, $phys_ptr_cast(P#a, ^A));
        assume false;
    }

  anon14:
    assume claim#0 != $no_claim ==> (forall #cs1: $state :: { $valid_claim(#cs1, claim#0) } $valid_claim(#cs1, claim#0) ==> L#y <= $rd_inv(#cs1, A.x, $phys_ptr_cast(P#a, ^A)));
    assert $set_eq($owns($s, atomicObj#4), $set_empty());
    assert $rd_inv(beforeAtomicState#0, A.x, atomicObj#4) == $rd_inv($s, A.x, atomicObj#4) || $rd_inv(beforeAtomicState#0, A.x, atomicObj#4) + 1 == $rd_inv($s, A.x, atomicObj#4);
    assume $full_stop_ext(#tok$1^27.19, $s);
    assume true;
    // if (>=(y, 2147483647)) ...
    if (L#y >= 2147483647)
    {
      anon8:
        // stmt @unclaim(c1, c); 
        assert $top_writable($s, #wrTime$1^18.1, $spec_ptr_cast(SL#c1, ^^claim));
        call $unclaim($spec_ptr_cast(SL#c1, ^^claim));
        assert $claims_obj($spec_ptr_cast(SL#c1, ^^claim), $spec_ptr_cast(SP#c, ^^claim));
        assert $top_writable($s, #wrTime$1^18.1, $spec_ptr_cast(SP#c, ^^claim));
        assert $is_claimable(^^claim);
        call $write_ref_cnt($spec_ptr_cast(SP#c, ^^claim), $ref_cnt($s, $spec_ptr_cast(SP#c, ^^claim)) - 1);
        assume $ref_cnt($s, $spec_ptr_cast(SP#c, ^^claim)) >= 0;
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
    atomicObj#5 := $phys_ptr_cast(P#a, ^A);
    assert $valid_claim($s, $spec_ptr_cast(SP#c, ^^claim));
    assert $valid_claim($s, $spec_ptr_cast(SL#c1, ^^claim));
    assert $closed($s, atomicObj#5);
    assume $inv($s, atomicObj#5, ^A);
    beforeAtomicState#1 := $s;
    assume claim#1 == $no_claim;
    // int32_t* Destination#1; 
    assume $local_value_is($s, #tok$1^38.36, #loc.Destination#1, $ptr_to_int(Destination#1), $ptr_to(^^i4));
    // Destination#1 := (a->x); 
    Destination#1 := $dot($phys_ptr_cast(P#a, ^A), A.x);
    assume $local_value_is($s, #tok$1^38.36, #loc.Destination#1, $ptr_to_int(Destination#1), $ptr_to(^^i4));
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
    assert $thread_local($s, $phys_ptr_cast(Destination#1, ^^i4)) || $set_in($phys_ptr_cast(Destination#1, ^^i4), $span(atomicObj#5));
    assume true;
    // if (==(*(Destination#1), y)) ...
    if ($rd_inv($s, $field($phys_ptr_cast(Destination#1, ^^i4)), $emb0($phys_ptr_cast(Destination#1, ^^i4))) == L#y)
    {
      anon10:
        // assert @prim_writes_check(Destination#1); 
        assert $set_in($phys_ptr_cast(Destination#1, ^^i4), $volatile_span($s, atomicObj#5)) || $writable_prim($s, #wrTime$1^18.1, $phys_ptr_cast(Destination#1, ^^i4));
        // *Destination#1 := Exchange#2; 
        call $write_int($field($phys_ptr_cast(Destination#1, ^^i4)), $emb0($phys_ptr_cast(Destination#1, ^^i4)), Exchange#2);
        assume $good_state_ext(#tok$1^38.36, $s);
        // res#3 := y; 
        res#3 := L#y;
        assume $local_value_is($s, #tok$1^7.5, #loc.res#3, res#3, ^^i4);
    }
    else
    {
      anon11:
        // assert @reads_check_normal(Destination#1); 
        assert $thread_local($s, $phys_ptr_cast(Destination#1, ^^i4)) || $set_in($phys_ptr_cast(Destination#1, ^^i4), $span(atomicObj#5));
        // res#3 := *(Destination#1); 
        res#3 := $rd_inv($s, $field($phys_ptr_cast(Destination#1, ^^i4)), $emb0($phys_ptr_cast(Destination#1, ^^i4)));
        assume $local_value_is($s, #tok$1^9.5, #loc.res#3, res#3, ^^i4);
    }

  anon16:
    // empty
    // z := res#3; 
    L#z := res#3;
    assume $local_value_is($s, #tok$1^38.5, #loc.z, L#z, ^^i4);
    // c2 := @claim(pure(<(y, *((a->x)))), c); 
    assert $closed($s, $spec_ptr_cast(SP#c, ^^claim));
    assert $top_writable($s, #wrTime$1^18.1, $spec_ptr_cast(SP#c, ^^claim)) || $owner($s, $spec_ptr_cast(SP#c, ^^claim)) == atomicObj#5;
    assert $is_claimable(^^claim);
    call $write_ref_cnt($spec_ptr_cast(SP#c, ^^claim), $ref_cnt($s, $spec_ptr_cast(SP#c, ^^claim)) + 1);
    assume $ref_cnt($s, $spec_ptr_cast(SP#c, ^^claim)) >= 0;
    claim#1s0 := $s;
    call claim#1 := $alloc_claim();
    assume $claims_obj(claim#1, $spec_ptr_cast(SP#c, ^^claim));
    SL#c2 := claim#1;
    assume $local_value_is($s, #tok$1^39.33, #loc.c2, $ptr_to_int(SL#c2), $spec_ptr_to(^^claim));
    assume $good_state_ext(#tok$1^39.33, $s);
    assume claim#1 != $no_claim ==> $claim_initial_assumptions($s, claim#1, #tok$1^39.33);
    assert claim#1 != $no_claim ==> L#y < $rd_inv($s, A.x, $phys_ptr_cast(P#a, ^A));
    if (claim#1 != $no_claim && claim#1doAdm)
    {
      anon12:
        assume L#y < $rd_inv(claim#1s1, A.x, $phys_ptr_cast(P#a, ^A));
        assume $valid_claim_impl(claim#1s0, claim#1s2);
        assume $claim_transitivity_assumptions(claim#1s1, claim#1s2, claim#1, #tok$1^39.33);
        assert L#y < $rd_inv(claim#1s2, A.x, $phys_ptr_cast(P#a, ^A));
        assume false;
    }

  anon17:
    assume claim#1 != $no_claim ==> (forall #cs2: $state :: { $valid_claim(#cs2, claim#1) } $valid_claim(#cs2, claim#1) ==> L#y < $rd_inv(#cs2, A.x, $phys_ptr_cast(P#a, ^A)));
    assert $set_eq($owns($s, atomicObj#5), $set_empty());
    assert $rd_inv(beforeAtomicState#1, A.x, atomicObj#5) == $rd_inv($s, A.x, atomicObj#5) || $rd_inv(beforeAtomicState#1, A.x, atomicObj#5) + 1 == $rd_inv($s, A.x, atomicObj#5);
    assume $full_stop_ext(#tok$1^37.19, $s);
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^42.19, $s);
    atomicObj#6 := $phys_ptr_cast(P#a, ^A);
    assert $valid_claim($s, $spec_ptr_cast(SP#c, ^^claim));
    assert $valid_claim($s, $spec_ptr_cast(SL#c2, ^^claim));
    assert $closed($s, atomicObj#6);
    assume $inv($s, atomicObj#6, ^A);
    beforeAtomicState#2 := $s;
    // assert @reads_check_normal((a->x)); 
    assert $mutable($s, $phys_ptr_cast(P#a, ^A)) || $phys_ptr_cast(P#a, ^A) == atomicObj#6;
    // z := *((a->x)); 
    L#z := $rd_inv($s, A.x, $phys_ptr_cast(P#a, ^A));
    assume $local_value_is($s, #tok$1^43.5, #loc.z, L#z, ^^i4);
    assert $set_eq($owns($s, atomicObj#6), $set_empty());
    assert $rd_inv(beforeAtomicState#2, A.x, atomicObj#6) == $rd_inv($s, A.x, atomicObj#6) || $rd_inv(beforeAtomicState#2, A.x, atomicObj#6) + 1 == $rd_inv($s, A.x, atomicObj#6);
    assume $full_stop_ext(#tok$1^42.19, $s);
    // assert <(y, z); 
    assert L#y < L#z;
    // assume <(y, z); 
    assume L#y < L#z;
    // stmt @unclaim(c1, c); 
    assert $top_writable($s, #wrTime$1^18.1, $spec_ptr_cast(SL#c1, ^^claim));
    call $unclaim($spec_ptr_cast(SL#c1, ^^claim));
    assert $claims_obj($spec_ptr_cast(SL#c1, ^^claim), $spec_ptr_cast(SP#c, ^^claim));
    assert $top_writable($s, #wrTime$1^18.1, $spec_ptr_cast(SP#c, ^^claim));
    assert $is_claimable(^^claim);
    call $write_ref_cnt($spec_ptr_cast(SP#c, ^^claim), $ref_cnt($s, $spec_ptr_cast(SP#c, ^^claim)) - 1);
    assume $ref_cnt($s, $spec_ptr_cast(SP#c, ^^claim)) >= 0;
    assume $full_stop_ext(#tok$1^48.25, $s);
    // empty
    // stmt @unclaim(c2, c); 
    assert $top_writable($s, #wrTime$1^18.1, $spec_ptr_cast(SL#c2, ^^claim));
    call $unclaim($spec_ptr_cast(SL#c2, ^^claim));
    assert $claims_obj($spec_ptr_cast(SL#c2, ^^claim), $spec_ptr_cast(SP#c, ^^claim));
    assert $top_writable($s, #wrTime$1^18.1, $spec_ptr_cast(SP#c, ^^claim));
    assert $is_claimable(^^claim);
    call $write_ref_cnt($spec_ptr_cast(SP#c, ^^claim), $ref_cnt($s, $spec_ptr_cast(SP#c, ^^claim)) - 1);
    assume $ref_cnt($s, $spec_ptr_cast(SP#c, ^^claim)) >= 0;
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

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CLockFreeIncr.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CLockFreeIncr.c);
