axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^F: $ctype;

axiom $is_composite(^F);

axiom $ptr_level(^F) == 0;

axiom $sizeof(^F) == 8;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^F) } $inv2(#s1, #s2, #p, ^F) == ($typed(#s2, #p) && $dot(#p, F.g) == $dot(#p, F.g) && $keeps(#s2, #p, $dot(#p, F.g))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^F, #r), l#public) } $inv_lab(#s2, $ptr(^F, #r), l#public) == ($typed(#s2, $ptr(^F, #r)) && $keeps(#s2, $ptr(^F, #r), $dot($ptr(^F, #r), F.g))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^F, #r)) } $in_full_extent_of(#q, $ptr(^F, #r)) == (#q == $ptr(^F, #r) || #q == $dot($ptr(^F, #r), F.$owns) || #q == $dot($ptr(^F, #r), F.value) || $in_full_extent_of(#q, $dot($ptr(^F, #r), F.g))));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^F, #r)) } $in_extent_of(#s, #q, $ptr(^F, #r)) == $in_struct_extent_of(#q, $ptr(^F, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^F, #r)) } $in_span_of(#q, $ptr(^F, #r)) == (#q == $ptr(^F, #r) || #q == $dot($ptr(^F, #r), F.$owns) || #q == $dot($ptr(^F, #r), F.value)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^F) } $state_spans_the_same(#s1, #s2, #p, ^F) == ($mem_eq(#s1, #s2, $dot(#p, F.$owns)) && $mem_eq(#s1, #s2, $dot(#p, F.value))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^F) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^F) == ($mem_eq(#s1, #s2, $dot(#p, F.$owns)) && $mem_eq(#s1, #s2, $dot(#p, F.value))));

axiom $is_claimable(^F) == false;

axiom $has_volatile_owns_set(^F) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^F, #r)) } $extent_mutable(#s1, $ptr(^F, #r)) == ($mutable(#s1, $ptr(^F, #r)) && $extent_mutable(#s1, $dot($ptr(^F, #r), F.g))));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^F, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^F, #r)) == ($is_fresh(#s1, #s2, $ptr(^F, #r)) && $extent_is_fresh(#s1, #s2, $dot($ptr(^F, #r), F.g))));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^F, #r)) } $extent_zero(#s1, $ptr(^F, #r)) == ($mem(#s1, $dot($ptr(^F, #r), F.value)) == 0 && $extent_zero(#s1, $dot($ptr(^F, #r), F.g))));

const unique F.$owns: $field;

axiom $static_field_properties(F.$owns, ^F);

axiom $is_primitive_non_volatile_field(F.$owns);

axiom (forall #p: $ptr :: { $dot(#p, F.$owns) } $is(#p, ^F) ==> $dot(#p, F.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, F.$owns)) && $extent_hint($dot(#p, F.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, F.$owns)) } { $st(#s, $dot(#p, F.$owns)) } $typed2(#s, #p, ^F) ==> $field_properties(#s, #p, F.$owns, ^$#ptrset, false));

axiom $owns_set_field(^F) == F.$owns;

const unique F.value: $field;

axiom $static_field_properties(F.value, ^F);

axiom $is_primitive_non_volatile_field(F.value);

axiom $field_offset(F.value) == 0;

axiom (forall #p: $ptr :: { $dot(#p, F.value) } $is(#p, ^F) ==> $dot(#p, F.value) == $ptr(^^i4, $ref(#p) + 0) && $extent_hint($dot(#p, F.value), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, F.value)) } { $st(#s, $dot(#p, F.value)) } $typed2(#s, #p, ^F) ==> $field_properties(#s, #p, F.value, ^^i4, false));

const unique F.g: $field;

axiom $static_field_properties(F.g, ^F);

axiom $field_offset(F.g) == 0;

axiom (forall #p: $ptr :: { $dot(#p, F.g) } $is(#p, ^F) ==> $dot(#p, F.g) == $ptr(^F##g, $ref(#p) + 0) && $extent_hint($dot(#p, F.g), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, F.g)) } { $st(#s, $dot(#p, F.g)) } $typed2(#s, #p, ^F) ==> $field_properties(#s, #p, F.g, ^F##g, false));

procedure F#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $dot($ptr(^F, P#_this_), F.g) == $dot($ptr(^F, P#_this_), F.g);
  ensures $is_admissibility_check() ==> $keeps($s, $ptr(^F, P#_this_), $dot($ptr(^F, P#_this_), F.g));
  ensures $is_stuttering_check() ==> $dot($ptr(^F, P#_this_), F.g) == $dot($ptr(^F, P#_this_), F.g);
  ensures $is_unwrap_check() ==> $dot($ptr(^F, P#_this_), F.g) == $dot($ptr(^F, P#_this_), F.g);
  ensures $is_unwrap_check() ==> $keeps($s, $ptr(^F, P#_this_), $dot($ptr(^F, P#_this_), F.g));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation F#adm(P#_this_: int)
{
  var #wrTime$1^4.1: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^4.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^4.1, #loc._this_, $ptr_to_int($ptr(^F, P#_this_)), $ptr_to(^F)) && $local_value_is_ptr($s, #tok$1^4.1, #loc._this_, $ptr(^F, P#_this_), $ptr_to(^F));
    assume #wrTime$1^4.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^4.1, #p) } $in_writes_at(#wrTime$1^4.1, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^F, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^F, P#_this_));
        assume $good_state_ext(#tok$1^4.1, $s);
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
            assume $admissibility_pre($s, $ptr(^F, P#_this_));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^F, P#_this_));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct F*)@null))
        call $havoc_others($ptr(^F, P#_this_), ^F);
        assume $good_state_ext(#tok$1^4.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^F, P#_this_), ^F);
    }

  #exit:
}



const unique ^F##g: $ctype;

axiom $is_composite(^F##g);

axiom $ptr_level(^F##g) == 0;

axiom $sizeof(^F##g) == 8;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^F##g) } $inv2(#s1, #s2, #p, ^F##g) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty())));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^F##g, #r), l#public) } $inv_lab(#s2, $ptr(^F##g, #r), l#public) == ($typed(#s2, $ptr(^F##g, #r)) && $set_eq($owns(#s2, $ptr(^F##g, #r)), $set_empty())));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^F##g, #r)) } $in_full_extent_of(#q, $ptr(^F##g, #r)) == (#q == $ptr(^F##g, #r) || #q == $dot($ptr(^F##g, #r), F##g.$owns) || #q == $dot($ptr(^F##g, #r), F##g.vol)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^F##g, #r)) } $in_extent_of(#s, #q, $ptr(^F##g, #r)) == $in_struct_extent_of(#q, $ptr(^F##g, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^F##g, #r)) } $typed(#s, $ptr(^F##g, #r)) ==> $in_extent_of(#s, #q, $ptr(^F##g, #r)) == (#q == $ptr(^F##g, #r) || $emb(#s, #q) == $ptr(^F##g, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^F##g, #r)) } $in_span_of(#q, $ptr(^F##g, #r)) == (#q == $ptr(^F##g, #r) || #q == $dot($ptr(^F##g, #r), F##g.$owns) || #q == $dot($ptr(^F##g, #r), F##g.vol)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^F##g) } $state_spans_the_same(#s1, #s2, #p, ^F##g) == ($mem_eq(#s1, #s2, $dot(#p, F##g.$owns)) && $mem_eq(#s1, #s2, $dot(#p, F##g.vol))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^F##g) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^F##g) == $mem_eq(#s1, #s2, $dot(#p, F##g.$owns)));

axiom $is_claimable(^F##g) == true;

axiom $has_volatile_owns_set(^F##g) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^F##g, #r)) } $extent_mutable(#s1, $ptr(^F##g, #r)) == $mutable(#s1, $ptr(^F##g, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^F##g, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^F##g, #r)) == $is_fresh(#s1, #s2, $ptr(^F##g, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^F##g, #r)) } $extent_zero(#s1, $ptr(^F##g, #r)) == ($mem(#s1, $dot($ptr(^F##g, #r), F##g.vol)) == 0));

const unique F##g.$owns: $field;

axiom $static_field_properties(F##g.$owns, ^F##g);

axiom $is_primitive_non_volatile_field(F##g.$owns);

axiom (forall #p: $ptr :: { $dot(#p, F##g.$owns) } $is(#p, ^F##g) ==> $dot(#p, F##g.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, F##g.$owns)) && $extent_hint($dot(#p, F##g.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, F##g.$owns)) } { $st(#s, $dot(#p, F##g.$owns)) } $typed2(#s, #p, ^F##g) ==> $field_properties(#s, #p, F##g.$owns, ^$#ptrset, false));

axiom $owns_set_field(^F##g) == F##g.$owns;

const unique F##g.vol: $field;

axiom $static_field_properties(F##g.vol, ^F##g);

axiom $is_primitive_volatile_field(F##g.vol);

axiom $field_offset(F##g.vol) == 4;

axiom (forall #p: $ptr :: { $dot(#p, F##g.vol) } $is(#p, ^F##g) ==> $dot(#p, F##g.vol) == $ptr(^^i4, $ref(#p) + 4) && $extent_hint($dot(#p, F##g.vol), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, F##g.vol)) } { $st(#s, $dot(#p, F##g.vol)) } $typed2(#s, #p, ^F##g) ==> $field_properties(#s, #p, F##g.vol, ^^i4, true));

procedure test(P#f: int) returns ($result: int);
  requires $wrapped($s, $dot($ptr(^F, P#f), F.g), ^F##g);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $dot($ptr(^F, P#f), F.g) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $dot($ptr(^F, P#f), F.g) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $dot($ptr(^F, P#f), F.g) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation test(P#f: int) returns ($result: int)
{
  var claim#0doAdm: bool;
  var claim#0s2: $state;
  var claim#0s1: $state;
  var claim#0s0: $state;
  var claim#0: $ptr;
  var SL#c: int where $in_range_spec_ptr(SL#c);
  var #wrTime$1^15.1: int;
  var #stackframe: int;

  anon8:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^15.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^15.1, #loc.f, $ptr_to_int($ptr(^F, P#f)), $ptr_to(^F)) && $local_value_is_ptr($s, #tok$1^15.1, #loc.f, $ptr(^F, P#f), $ptr_to(^F));
    assume #wrTime$1^15.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^15.1, #p) } $in_writes_at(#wrTime$1^15.1, #p) == (#p == $dot($ptr(^F, P#f), F.g)));
    assume $thread_owned($s, $dot($ptr(^F, P#f), F.g));
    // assume @in_range_phys_ptr((mathint)f); 
    assume $in_range_phys_ptr($ref($ptr(^F, P#f)));
    // assert @_vcc_in_domain(@state, (f->g), (f->g)); 
    assert $in_domain_lab($s, $dot($ptr(^F, P#f), F.g), $dot($ptr(^F, P#f), F.g), l#public);
    // claim_t^ c; 
    assume $local_value_is($s, #tok$1^19.24, #loc.c, $ptr_to_int($ptr(^^claim, SL#c)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^19.24, #loc.c, $ptr(^^claim, SL#c), $spec_ptr_to(^^claim));
    // var spec claim_t^ c
    // assert @_vcc_closed(@state, (f->g)); 
    assert $closed($s, $dot($ptr(^F, P#f), F.g));
    // assume @_vcc_closed(@state, (f->g)); 
    assume $closed($s, $dot($ptr(^F, P#f), F.g));
    // c := @claim(pure(@_vcc_closed(@state, (f->g))), (f->g)); 
    assert $closed($s, $dot($ptr(^F, P#f), F.g));
    assert $top_writable($s, #wrTime$1^15.1, $dot($ptr(^F, P#f), F.g));
    assert $is_claimable(^F##g);
    call $write_ref_cnt($dot($ptr(^F, P#f), F.g), $ref_cnt($s, $dot($ptr(^F, P#f), F.g)) + 1);
    assume $ref_cnt($s, $dot($ptr(^F, P#f), F.g)) >= 0;
    claim#0s0 := $s;
    call claim#0 := $alloc_claim();
    assume $claims_obj(claim#0, $dot($ptr(^F, P#f), F.g));
    SL#c := $ref(claim#0);
    assume $local_value_is($s, #tok$1^23.28, #loc.c, $ptr_to_int($ptr(^^claim, SL#c)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^23.28, #loc.c, $ptr(^^claim, SL#c), $spec_ptr_to(^^claim));
    assume $full_stop_ext(#tok$1^23.28, $s);
    assume claim#0 != $no_claim ==> $claim_initial_assumptions($s, claim#0, #tok$1^23.28);
    assert claim#0 != $no_claim ==> $claimed_closed($s, $dot($ptr(^F, P#f), F.g));
    if (claim#0doAdm)
    {
      anon7:
        assume $claimed_closed(claim#0s1, $dot($ptr(^F, P#f), F.g));
        assume $valid_claim_impl(claim#0s0, claim#0s2);
        assume $claim_transitivity_assumptions(claim#0s1, claim#0s2, claim#0, #tok$1^23.28);
        assert $claimed_closed(claim#0s2, $dot($ptr(^F, P#f), F.g));
        assume false;
    }

  anon9:
    assume claim#0 != $no_claim ==> (forall #cs0: $state :: { $valid_claim(#cs0, claim#0) } $valid_claim(#cs0, claim#0) ==> $claimed_closed(#cs0, $dot($ptr(^F, P#f), F.g)));
    // empty

  #exit:
}



axiom (forall Q#ptr$2^0.0#dt3: int :: { $ptr(^F##g, Q#ptr$2^0.0#dt3) } $in_range_phys_ptr($ref($ptr(^F##g, Q#ptr$2^0.0#dt3))) ==> $ptr_eq($ptr(^F##g, Q#ptr$2^0.0#dt3), $dot($ptr(^F, Q#ptr$2^0.0#dt3), F.g)));

const unique l#public: $label;

const unique #distTp3: $ctype;

axiom #distTp3 == $ptr_to(^F##g);

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(2, #file^?3Cno?20file?3E);

const unique #tok$1^23.28: $token;

const unique #distTp2: $ctype;

axiom #distTp2 == $spec_ptr_to(^^claim);

const unique #loc.c: $token;

const unique #tok$1^19.24: $token;

const unique #loc.f: $token;

const unique #tok$1^15.1: $token;

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^F);

const unique #loc._this_: $token;

const unique #tok$1^4.1: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CClaimOnGroup.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CClaimOnGroup.c);
