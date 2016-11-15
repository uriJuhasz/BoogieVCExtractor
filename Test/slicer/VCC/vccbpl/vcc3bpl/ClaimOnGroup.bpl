axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

const unique ^F: $ctype;

axiom $is_span_sequential(^F);

axiom $def_struct_type(^F, 8, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^F) } $inv2(#s1, #s2, #p, ^F) == ($dot(#p, F.g) == $dot(#p, F.g) && $keeps(#s2, #p, $dot(#p, F.g))));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^F)) } $in(q, $composite_extent(s, p, ^F)) == (q == p || q == $dot(p, F.g)));

const unique F.value: $field;

axiom $def_phys_field(^F, F.value, ^^i4, false, 0);

const unique F.g: $field;

axiom $def_group(^F, F.g, ^F##g);

procedure F#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $dot($phys_ptr_cast(P#_this_, ^F), F.g) == $dot($phys_ptr_cast(P#_this_, ^F), F.g);
  ensures $is_admissibility_check() ==> $keeps($s, $phys_ptr_cast(P#_this_, ^F), $dot($phys_ptr_cast(P#_this_, ^F), F.g));
  ensures $is_stuttering_check() ==> $dot($phys_ptr_cast(P#_this_, ^F), F.g) == $dot($phys_ptr_cast(P#_this_, ^F), F.g);
  ensures $is_unwrap_check() ==> $dot($phys_ptr_cast(P#_this_, ^F), F.g) == $dot($phys_ptr_cast(P#_this_, ^F), F.g);
  ensures $is_unwrap_check() ==> $keeps($s, $phys_ptr_cast(P#_this_, ^F), $dot($phys_ptr_cast(P#_this_, ^F), F.g));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation F#adm(P#_this_: $ptr)
{
  var #wrTime$1^4.1: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^4.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^4.1, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^F));
    assume #wrTime$1^4.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^4.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($phys_ptr_cast(P#_this_, ^F), ^F);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $phys_ptr_cast(P#_this_, ^F));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($phys_ptr_cast(P#_this_, ^F));
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
            assume $admissibility_pre($s, $phys_ptr_cast(P#_this_, ^F));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $phys_ptr_cast(P#_this_, ^F));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct F*)@null))
        call $havoc_others($phys_ptr_cast(P#_this_, ^F), ^F);
        assume $good_state_ext(#tok$1^4.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $phys_ptr_cast(P#_this_, ^F), ^F);
    }

  #exit:
}



const unique ^F##g: $ctype;

axiom $def_struct_type(^F##g, 8, true, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^F##g) } $inv2(#s1, #s2, #p, ^F##g) == $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^F##g)) } $in(q, $composite_extent(s, p, ^F##g)) == (q == p));

const unique F##g.vol: $field;

axiom $def_phys_field(^F##g, F##g.vol, ^^i4, true, 4);

procedure test(P#f: $ptr) returns ($result: int);
  requires $wrapped($s, $dot($phys_ptr_cast(P#f, ^F), F.g), ^F##g);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $dot($phys_ptr_cast(P#f, ^F), F.g)));
  free ensures $call_transition(old($s), $s);



implementation test(P#f: $ptr) returns ($result: int)
{
  var claim#0doAdm: bool;
  var claim#0s2: $state;
  var claim#0s1: $state;
  var claim#0s0: $state;
  var claim#0: $ptr;
  var SL#c: $ptr;
  var #wrTime$1^15.1: int;
  var #stackframe: int;

  anon8:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^15.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^15.1, #loc.f, $ptr_to_int(P#f), $ptr_to(^F));
    assume #wrTime$1^15.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^15.1, (lambda #p: $ptr :: #p == $dot($phys_ptr_cast(P#f, ^F), F.g)));
    assume $thread_owned($s, $dot($phys_ptr_cast(P#f, ^F), F.g));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, (f->g), (f->g)); 
    assert $in_domain_lab($s, $dot($phys_ptr_cast(P#f, ^F), F.g), $dot($phys_ptr_cast(P#f, ^F), F.g), l#public);
    // claim_t^ c; 
    assume $local_value_is($s, #tok$1^19.24, #loc.c, $ptr_to_int(SL#c), $spec_ptr_to(^^claim));
    // var spec claim_t^ c
    // assert @_vcc_closed(@state, (f->g)); 
    assert $closed($s, $dot($phys_ptr_cast(P#f, ^F), F.g));
    // assume @_vcc_closed(@state, (f->g)); 
    assume $closed($s, $dot($phys_ptr_cast(P#f, ^F), F.g));
    // c := @claim(pure(@_vcc_closed(@state, (f->g))), (f->g)); 
    assert $closed($s, $dot($phys_ptr_cast(P#f, ^F), F.g));
    assert $top_writable($s, #wrTime$1^15.1, $dot($phys_ptr_cast(P#f, ^F), F.g));
    assert $is_claimable(^F##g);
    call $write_ref_cnt($dot($phys_ptr_cast(P#f, ^F), F.g), $ref_cnt($s, $dot($phys_ptr_cast(P#f, ^F), F.g)) + 1);
    assume $ref_cnt($s, $dot($phys_ptr_cast(P#f, ^F), F.g)) >= 0;
    claim#0s0 := $s;
    call claim#0 := $alloc_claim();
    assume $claims_obj(claim#0, $dot($phys_ptr_cast(P#f, ^F), F.g));
    SL#c := claim#0;
    assume $local_value_is($s, #tok$1^23.28, #loc.c, $ptr_to_int(SL#c), $spec_ptr_to(^^claim));
    assume $full_stop_ext(#tok$1^23.28, $s);
    assume claim#0 != $no_claim ==> $claim_initial_assumptions($s, claim#0, #tok$1^23.28);
    assert claim#0 != $no_claim ==> $claimed_closed($s, $dot($phys_ptr_cast(P#f, ^F), F.g));
    if (claim#0doAdm)
    {
      anon7:
        assume $claimed_closed(claim#0s1, $dot($phys_ptr_cast(P#f, ^F), F.g));
        assume $valid_claim_impl(claim#0s0, claim#0s2);
        assume $claim_transitivity_assumptions(claim#0s1, claim#0s2, claim#0, #tok$1^23.28);
        assert $claimed_closed(claim#0s2, $dot($phys_ptr_cast(P#f, ^F), F.g));
        assume false;
    }

  anon9:
    assume claim#0 != $no_claim ==> (forall #cs0: $state :: { $valid_claim(#cs0, claim#0) } $valid_claim(#cs0, claim#0) ==> $claimed_closed(#cs0, $dot($phys_ptr_cast(P#f, ^F), F.g)));
    // empty

  #exit:
}



const unique l#public: $label;

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

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CClaimOnGroup.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CClaimOnGroup.c);
