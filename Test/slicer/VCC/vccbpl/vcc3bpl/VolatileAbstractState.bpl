axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

const unique ^Protector: $ctype;

axiom $is_span_sequential(^Protector);

axiom $def_struct_type(^Protector, 1, true, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Protector) } $inv2(#s1, #s2, #p, ^Protector) == $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^Protector)) } $in(q, $composite_extent(s, p, ^Protector)) == (q == p));

const unique Protector.dummy: $field;

axiom $def_ghost_field(^Protector, Protector.dummy, ^^i4, false);

const unique ^AbstractStruct: $ctype;

axiom $def_struct_type(^AbstractStruct, 1, true, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^AbstractStruct) } $inv2(#s1, #s2, #p, ^AbstractStruct) == ($set_eq($owns(#s2, #p), $set_empty()) && ($closed(#s2, $dot(#p, AbstractStruct.protector)) ==> $rd_inv(#s1, AbstractStruct.value, #p) == $rd_inv(#s2, AbstractStruct.value, #p)) && ($rd_inv(#s2, AbstractStruct.value, #p) == $op_mul(2, $rd_inv(#s1, AbstractStruct.value, #p)) || $rd_inv(#s1, AbstractStruct.value, #p) == $rd_inv(#s2, AbstractStruct.value, #p))));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^AbstractStruct)) } $in(q, $composite_extent(s, p, ^AbstractStruct)) == (q == p || q == $dot(p, AbstractStruct.protector)));

const unique AbstractStruct.value: $field;

axiom $def_ghost_field(^AbstractStruct, AbstractStruct.value, ^^i4, true);

const unique AbstractStruct.protector: $field;

axiom $def_ghost_field(^AbstractStruct, AbstractStruct.protector, ^Protector, false);

procedure AbstractStruct#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $set_eq($owns($s, $spec_ptr_cast(P#_this_, ^AbstractStruct)), $set_empty());
  ensures $is_admissibility_check() ==> $closed($s, $dot($spec_ptr_cast(P#_this_, ^AbstractStruct), AbstractStruct.protector)) ==> $rd_inv(old($s), AbstractStruct.value, $spec_ptr_cast(P#_this_, ^AbstractStruct)) == $rd_inv($s, AbstractStruct.value, $spec_ptr_cast(P#_this_, ^AbstractStruct));
  ensures $is_admissibility_check() ==> $rd_inv($s, AbstractStruct.value, $spec_ptr_cast(P#_this_, ^AbstractStruct)) == $op_mul(2, $rd_inv(old($s), AbstractStruct.value, $spec_ptr_cast(P#_this_, ^AbstractStruct))) || $rd_inv(old($s), AbstractStruct.value, $spec_ptr_cast(P#_this_, ^AbstractStruct)) == $rd_inv($s, AbstractStruct.value, $spec_ptr_cast(P#_this_, ^AbstractStruct));
  ensures $is_stuttering_check() ==> $closed($s, $dot($spec_ptr_cast(P#_this_, ^AbstractStruct), AbstractStruct.protector)) ==> $rd_inv($s, AbstractStruct.value, $spec_ptr_cast(P#_this_, ^AbstractStruct)) == $rd_inv($s, AbstractStruct.value, $spec_ptr_cast(P#_this_, ^AbstractStruct));
  ensures $is_stuttering_check() ==> $rd_inv($s, AbstractStruct.value, $spec_ptr_cast(P#_this_, ^AbstractStruct)) == $op_mul(2, $rd_inv($s, AbstractStruct.value, $spec_ptr_cast(P#_this_, ^AbstractStruct))) || $rd_inv($s, AbstractStruct.value, $spec_ptr_cast(P#_this_, ^AbstractStruct)) == $rd_inv($s, AbstractStruct.value, $spec_ptr_cast(P#_this_, ^AbstractStruct));
  ensures $is_unwrap_check() ==> $set_eq($owns($s, $spec_ptr_cast(P#_this_, ^AbstractStruct)), $set_empty());
  ensures $is_unwrap_check() ==> $closed($s, $dot($spec_ptr_cast(P#_this_, ^AbstractStruct), AbstractStruct.protector)) ==> $rd_inv(old($s), AbstractStruct.value, $spec_ptr_cast(P#_this_, ^AbstractStruct)) == $rd_inv($s, AbstractStruct.value, $spec_ptr_cast(P#_this_, ^AbstractStruct));
  ensures $is_unwrap_check() ==> $rd_inv($s, AbstractStruct.value, $spec_ptr_cast(P#_this_, ^AbstractStruct)) == $op_mul(2, $rd_inv(old($s), AbstractStruct.value, $spec_ptr_cast(P#_this_, ^AbstractStruct))) || $rd_inv(old($s), AbstractStruct.value, $spec_ptr_cast(P#_this_, ^AbstractStruct)) == $rd_inv($s, AbstractStruct.value, $spec_ptr_cast(P#_this_, ^AbstractStruct));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation AbstractStruct#adm(P#_this_: $ptr)
{
  var #wrTime$1^11.52: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^11.52, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^11.52, #loc._this_, $ptr_to_int(P#_this_), $spec_ptr_to(^AbstractStruct));
    assume #wrTime$1^11.52 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^11.52, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($spec_ptr_cast(P#_this_, ^AbstractStruct), ^AbstractStruct);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $spec_ptr_cast(P#_this_, ^AbstractStruct));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($spec_ptr_cast(P#_this_, ^AbstractStruct));
        assume $good_state_ext(#tok$1^11.52, $s);
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
            assume $admissibility_pre($s, $spec_ptr_cast(P#_this_, ^AbstractStruct));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $spec_ptr_cast(P#_this_, ^AbstractStruct));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct AbstractStruct*)@null))
        call $havoc_others($spec_ptr_cast(P#_this_, ^AbstractStruct), ^AbstractStruct);
        assume $good_state_ext(#tok$1^11.52, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $spec_ptr_cast(P#_this_, ^AbstractStruct), ^AbstractStruct);
    }

  #exit:
}



const unique ^ConcreteStruct: $ctype;

axiom $is_span_sequential(^ConcreteStruct);

axiom $def_struct_type(^ConcreteStruct, 4, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^ConcreteStruct) } $inv2(#s1, #s2, #p, ^ConcreteStruct) == ($rd_phys_ptr(#s1, ConcreteStruct.abs, #p, ^AbstractStruct) == $rd_phys_ptr(#s2, ConcreteStruct.abs, #p, ^AbstractStruct) && $keeps(#s2, #p, $rd_phys_ptr(#s2, ConcreteStruct.abs, #p, ^AbstractStruct)) && $dot($rd_phys_ptr(#s1, ConcreteStruct.abs, #p, ^AbstractStruct), AbstractStruct.protector) == $dot($rd_phys_ptr(#s2, ConcreteStruct.abs, #p, ^AbstractStruct), AbstractStruct.protector) && $keeps(#s2, #p, $dot($rd_phys_ptr(#s2, ConcreteStruct.abs, #p, ^AbstractStruct), AbstractStruct.protector)) && $ref_cnt(#s2, $dot($rd_phys_ptr(#s2, ConcreteStruct.abs, #p, ^AbstractStruct), AbstractStruct.protector)) == 0 && $rd_inv(#s2, ConcreteStruct.value, #p) == $rd_inv(#s2, AbstractStruct.value, $rd_phys_ptr(#s2, ConcreteStruct.abs, #p, ^AbstractStruct))));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^ConcreteStruct)) } $in(q, $composite_extent(s, p, ^ConcreteStruct)) == (q == p));

const unique ConcreteStruct.value: $field;

axiom $def_phys_field(^ConcreteStruct, ConcreteStruct.value, ^^i4, false, 0);

const unique ConcreteStruct.abs: $field;

axiom $def_ghost_field(^ConcreteStruct, ConcreteStruct.abs, $ptr_to(^AbstractStruct), false);

procedure ConcreteStruct#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $rd_phys_ptr(old($s), ConcreteStruct.abs, $phys_ptr_cast(P#_this_, ^ConcreteStruct), ^AbstractStruct) == $rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#_this_, ^ConcreteStruct), ^AbstractStruct);
  ensures $is_admissibility_check() ==> $keeps($s, $phys_ptr_cast(P#_this_, ^ConcreteStruct), $rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#_this_, ^ConcreteStruct), ^AbstractStruct));
  ensures $is_admissibility_check() ==> $dot($rd_phys_ptr(old($s), ConcreteStruct.abs, $phys_ptr_cast(P#_this_, ^ConcreteStruct), ^AbstractStruct), AbstractStruct.protector) == $dot($rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#_this_, ^ConcreteStruct), ^AbstractStruct), AbstractStruct.protector);
  ensures $is_admissibility_check() ==> $keeps($s, $phys_ptr_cast(P#_this_, ^ConcreteStruct), $dot($rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#_this_, ^ConcreteStruct), ^AbstractStruct), AbstractStruct.protector));
  ensures $is_admissibility_check() ==> $ref_cnt($s, $dot($rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#_this_, ^ConcreteStruct), ^AbstractStruct), AbstractStruct.protector)) == 0;
  ensures $is_admissibility_check() ==> $rd_inv($s, ConcreteStruct.value, $phys_ptr_cast(P#_this_, ^ConcreteStruct)) == $rd_inv($s, AbstractStruct.value, $rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#_this_, ^ConcreteStruct), ^AbstractStruct));
  ensures $is_stuttering_check() ==> $rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#_this_, ^ConcreteStruct), ^AbstractStruct) == $rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#_this_, ^ConcreteStruct), ^AbstractStruct);
  ensures $is_stuttering_check() ==> $dot($rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#_this_, ^ConcreteStruct), ^AbstractStruct), AbstractStruct.protector) == $dot($rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#_this_, ^ConcreteStruct), ^AbstractStruct), AbstractStruct.protector);
  ensures $is_unwrap_check() ==> $rd_phys_ptr(old($s), ConcreteStruct.abs, $phys_ptr_cast(P#_this_, ^ConcreteStruct), ^AbstractStruct) == $rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#_this_, ^ConcreteStruct), ^AbstractStruct);
  ensures $is_unwrap_check() ==> $keeps($s, $phys_ptr_cast(P#_this_, ^ConcreteStruct), $rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#_this_, ^ConcreteStruct), ^AbstractStruct));
  ensures $is_unwrap_check() ==> $dot($rd_phys_ptr(old($s), ConcreteStruct.abs, $phys_ptr_cast(P#_this_, ^ConcreteStruct), ^AbstractStruct), AbstractStruct.protector) == $dot($rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#_this_, ^ConcreteStruct), ^AbstractStruct), AbstractStruct.protector);
  ensures $is_unwrap_check() ==> $keeps($s, $phys_ptr_cast(P#_this_, ^ConcreteStruct), $dot($rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#_this_, ^ConcreteStruct), ^AbstractStruct), AbstractStruct.protector));
  ensures $is_unwrap_check() ==> $ref_cnt($s, $dot($rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#_this_, ^ConcreteStruct), ^AbstractStruct), AbstractStruct.protector)) == 0;
  ensures $is_unwrap_check() ==> $rd_inv($s, ConcreteStruct.value, $phys_ptr_cast(P#_this_, ^ConcreteStruct)) == $rd_inv($s, AbstractStruct.value, $rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#_this_, ^ConcreteStruct), ^AbstractStruct));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation ConcreteStruct#adm(P#_this_: $ptr)
{
  var #wrTime$1^24.1: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^24.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^24.1, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^ConcreteStruct));
    assume #wrTime$1^24.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^24.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($phys_ptr_cast(P#_this_, ^ConcreteStruct), ^ConcreteStruct);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon7:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $phys_ptr_cast(P#_this_, ^ConcreteStruct));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($phys_ptr_cast(P#_this_, ^ConcreteStruct));
        assume $good_state_ext(#tok$1^24.1, $s);
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
            assume $admissibility_pre($s, $phys_ptr_cast(P#_this_, ^ConcreteStruct));
        }
        else
        {
          anon9:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $phys_ptr_cast(P#_this_, ^ConcreteStruct));
        }

      anon11:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct ConcreteStruct*)@null))
        call $havoc_others($phys_ptr_cast(P#_this_, ^ConcreteStruct), ^ConcreteStruct);
        assume $good_state_ext(#tok$1^24.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $phys_ptr_cast(P#_this_, ^ConcreteStruct), ^ConcreteStruct);
    }

  #exit:
}



procedure writeStruct(P#s: $ptr, P#v: int) returns ($result: int);
  requires P#v == $op_mul(2, $rd_inv($s, ConcreteStruct.value, $phys_ptr_cast(P#s, ^ConcreteStruct)));
  requires $wrapped($s, $phys_ptr_cast(P#s, ^ConcreteStruct), ^ConcreteStruct);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  ensures $wrapped($s, $phys_ptr_cast(P#s, ^ConcreteStruct), ^ConcreteStruct);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#s, ^ConcreteStruct)));
  free ensures $call_transition(old($s), $s);



implementation writeStruct(P#s: $ptr, P#v: int) returns ($result: int)
{
  var owns#11: $ptrset;
  var staticWrapState#10: $state;
  var prestate#12: $state;
  var owns#8: $ptrset;
  var staticWrapState#7: $state;
  var prestate#9: $state;
  var beforeAtomicState#0: $state;
  var prestate#6: $state;
  var prestate#4: $state;
  var owns#5: $ptrset;
  var atomicObj#13: $ptr;
  var claim#0doAdm: bool;
  var claim#0s2: $state;
  var claim#0s1: $state;
  var claim#0s0: $state;
  var claim#0: $ptr;
  var prestate#3: $state;
  var prestate#1: $state;
  var owns#2: $ptrset;
  var SL#c: $ptr;
  var SL#abs: $ptr;
  var #wrTime$1^35.1: int;
  var #stackframe: int;

  anon14:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^35.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^35.1, #loc.s, $ptr_to_int(P#s), $ptr_to(^ConcreteStruct));
    assume $local_value_is($s, #tok$1^35.1, #loc.v, P#v, ^^i4);
    assume #wrTime$1^35.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^35.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#s, ^ConcreteStruct)));
    assume $thread_owned($s, $phys_ptr_cast(P#s, ^ConcreteStruct));
    // assume true; 
    assume true;
    // assume @in_range_i4(v); 
    assume $in_range_i4(P#v);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, s, s); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#s, ^ConcreteStruct), $phys_ptr_cast(P#s, ^ConcreteStruct), l#public);
    // struct AbstractStruct* abs; 
    assume $local_value_is($s, #tok$1^44.33, #loc.abs, $ptr_to_int(SL#abs), $ptr_to(^AbstractStruct));
    // claim_t^ c; 
    assume $local_value_is($s, #tok$1^40.25, #loc.c, $ptr_to_int(SL#c), $spec_ptr_to(^^claim));
    // var spec claim_t^ c
    // assert @reads_check_normal((s->abs)); 
    assert $thread_local($s, $phys_ptr_cast(P#s, ^ConcreteStruct));
    // abs := *((s->abs)); 
    SL#abs := $rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct);
    assume $local_value_is($s, #tok$1^44.33, #loc.abs, $ptr_to_int(SL#abs), $ptr_to(^AbstractStruct));
    // _math ptrset owns#2; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#2, $ptrset_to_int(owns#2), ^$#ptrset);
    // owns#2 := @_vcc_set_empty; 
    owns#2 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#2, $ptrset_to_int(owns#2), ^$#ptrset);
    // _math state_t prestate#1; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#1, $state_to_int(prestate#1), ^$#state_t);
    // prestate#1 := @_vcc_current_state(@state); 
    prestate#1 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#1, $state_to_int(prestate#1), ^$#state_t);
    // _math state_t prestate#3; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#3, $state_to_int(prestate#3), ^$#state_t);
    // prestate#3 := @_vcc_current_state(@state); 
    prestate#3 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#3, $state_to_int(prestate#3), ^$#state_t);
    // assert @_vcc_wrapped(@state, s); 
    assert $wrapped($s, $phys_ptr_cast(P#s, ^ConcreteStruct), ^ConcreteStruct);
    // assert @writes_check(s); 
    assert $top_writable($s, #wrTime$1^35.1, $phys_ptr_cast(P#s, ^ConcreteStruct));
    // assume @_vcc_inv(@state, s); 
    assume $inv($s, $phys_ptr_cast(P#s, ^ConcreteStruct), ^ConcreteStruct);
    // prestate#3 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#3, s, (*((s->abs))->protector))); 
    prestate#3 := $release($current_state($s), prestate#3, $phys_ptr_cast(P#s, ^ConcreteStruct), $dot($rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct), AbstractStruct.protector));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#3, $state_to_int(prestate#3), ^$#state_t);
    // owns#2 := pure(@_vcc_set_union(owns#2, @_vcc_set_singleton((*((s->abs))->protector)))); 
    owns#2 := $set_union(owns#2, $set_singleton($dot($rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct), AbstractStruct.protector)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#2, $ptrset_to_int(owns#2), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, (*((s->abs))->protector))); 
    assume $typed($s, $dot($rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct), AbstractStruct.protector));
    // prestate#3 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#3, s, *((s->abs)))); 
    prestate#3 := $release($current_state($s), prestate#3, $phys_ptr_cast(P#s, ^ConcreteStruct), $rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#3, $state_to_int(prestate#3), ^$#state_t);
    // owns#2 := pure(@_vcc_set_union(owns#2, @_vcc_set_singleton(*((s->abs))))); 
    owns#2 := $set_union(owns#2, $set_singleton($rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#2, $ptrset_to_int(owns#2), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((s->abs)))); 
    assume $typed($s, $rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct));
    // assume ==(owns#2, @_vcc_owns(@state, s)); 
    assume owns#2 == $owns($s, $phys_ptr_cast(P#s, ^ConcreteStruct));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(s), prestate#3)
    call $static_unwrap($phys_ptr_cast(P#s, ^ConcreteStruct), prestate#3);
    assume $good_state_ext(#tok$1^51.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // c := @claim(pure(==(*((abs->value)), pure(old(@_vcc_when_claimed, *((abs->value)))))), (abs->protector), abs); 
    assert $closed($s, $dot($phys_ptr_cast(SL#abs, ^AbstractStruct), AbstractStruct.protector));
    assert $top_writable($s, #wrTime$1^35.1, $dot($phys_ptr_cast(SL#abs, ^AbstractStruct), AbstractStruct.protector));
    assert $is_claimable(^Protector);
    call $write_ref_cnt($dot($phys_ptr_cast(SL#abs, ^AbstractStruct), AbstractStruct.protector), $ref_cnt($s, $dot($phys_ptr_cast(SL#abs, ^AbstractStruct), AbstractStruct.protector)) + 1);
    assume $ref_cnt($s, $dot($phys_ptr_cast(SL#abs, ^AbstractStruct), AbstractStruct.protector)) >= 0;
    assert $closed($s, $phys_ptr_cast(SL#abs, ^AbstractStruct));
    assert $top_writable($s, #wrTime$1^35.1, $phys_ptr_cast(SL#abs, ^AbstractStruct));
    assert $is_claimable(^AbstractStruct);
    call $write_ref_cnt($phys_ptr_cast(SL#abs, ^AbstractStruct), $ref_cnt($s, $phys_ptr_cast(SL#abs, ^AbstractStruct)) + 1);
    assume $ref_cnt($s, $phys_ptr_cast(SL#abs, ^AbstractStruct)) >= 0;
    claim#0s0 := $s;
    call claim#0 := $alloc_claim();
    assume $claims_obj(claim#0, $dot($phys_ptr_cast(SL#abs, ^AbstractStruct), AbstractStruct.protector));
    assume $claims_obj(claim#0, $phys_ptr_cast(SL#abs, ^AbstractStruct));
    SL#c := claim#0;
    assume $local_value_is($s, #tok$1^52.29, #loc.c, $ptr_to_int(SL#c), $spec_ptr_to(^^claim));
    assume $full_stop_ext(#tok$1^52.29, $s);
    assume claim#0 != $no_claim ==> $claim_initial_assumptions($s, claim#0, #tok$1^52.29);
    assert claim#0 != $no_claim ==> $rd_inv($s, AbstractStruct.value, $phys_ptr_cast(SL#abs, ^AbstractStruct)) == $rd_inv($s, AbstractStruct.value, $phys_ptr_cast(SL#abs, ^AbstractStruct));
    if (claim#0doAdm)
    {
      anon13:
        assume $rd_inv(claim#0s1, AbstractStruct.value, $phys_ptr_cast(SL#abs, ^AbstractStruct)) == $rd_inv($s, AbstractStruct.value, $phys_ptr_cast(SL#abs, ^AbstractStruct));
        assume $valid_claim_impl(claim#0s0, claim#0s2);
        assume $claim_transitivity_assumptions(claim#0s1, claim#0s2, claim#0, #tok$1^52.29);
        assert $rd_inv(claim#0s2, AbstractStruct.value, $phys_ptr_cast(SL#abs, ^AbstractStruct)) == $rd_inv($s, AbstractStruct.value, $phys_ptr_cast(SL#abs, ^AbstractStruct));
        assume false;
    }

  anon15:
    assume claim#0 != $no_claim ==> (forall #cs0: $state :: { $valid_claim(#cs0, claim#0) } $valid_claim(#cs0, claim#0) ==> $rd_inv(#cs0, AbstractStruct.value, $phys_ptr_cast(SL#abs, ^AbstractStruct)) == $rd_inv($s, AbstractStruct.value, $phys_ptr_cast(SL#abs, ^AbstractStruct)));
    // assert @prim_writes_check((s->value)); 
    assert $writable_prim($s, #wrTime$1^35.1, $dot($phys_ptr_cast(P#s, ^ConcreteStruct), ConcreteStruct.value));
    // *(s->value) := v; 
    call $write_int(ConcreteStruct.value, $phys_ptr_cast(P#s, ^ConcreteStruct), P#v);
    assume $full_stop_ext(#tok$1^54.3, $s);
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^56.19, $s);
    atomicObj#13 := $phys_ptr_cast(SL#abs, ^AbstractStruct);
    // assert @_vcc_valid_claim(@state, c); 
    assert $valid_claim($s, $spec_ptr_cast(SL#c, ^^claim));
    // assume @_vcc_valid_claim(@state, c); 
    assume $valid_claim($s, $spec_ptr_cast(SL#c, ^^claim));
    // stmt @unclaim(c, (abs->protector), abs); 
    assert $top_writable($s, #wrTime$1^35.1, $spec_ptr_cast(SL#c, ^^claim));
    assert $dot($phys_ptr_cast(SL#abs, ^AbstractStruct), AbstractStruct.protector) != $phys_ptr_cast(SL#abs, ^AbstractStruct);
    call $unclaim($spec_ptr_cast(SL#c, ^^claim));
    assert $claims_obj($spec_ptr_cast(SL#c, ^^claim), $dot($phys_ptr_cast(SL#abs, ^AbstractStruct), AbstractStruct.protector));
    assert $top_writable($s, #wrTime$1^35.1, $dot($phys_ptr_cast(SL#abs, ^AbstractStruct), AbstractStruct.protector));
    assert $is_claimable(^Protector);
    call $write_ref_cnt($dot($phys_ptr_cast(SL#abs, ^AbstractStruct), AbstractStruct.protector), $ref_cnt($s, $dot($phys_ptr_cast(SL#abs, ^AbstractStruct), AbstractStruct.protector)) - 1);
    assume $ref_cnt($s, $dot($phys_ptr_cast(SL#abs, ^AbstractStruct), AbstractStruct.protector)) >= 0;
    assert $claims_obj($spec_ptr_cast(SL#c, ^^claim), $phys_ptr_cast(SL#abs, ^AbstractStruct));
    assert $top_writable($s, #wrTime$1^35.1, $phys_ptr_cast(SL#abs, ^AbstractStruct));
    assert $is_claimable(^AbstractStruct);
    call $write_ref_cnt($phys_ptr_cast(SL#abs, ^AbstractStruct), $ref_cnt($s, $phys_ptr_cast(SL#abs, ^AbstractStruct)) - 1);
    assume $ref_cnt($s, $phys_ptr_cast(SL#abs, ^AbstractStruct)) >= 0;
    assume $full_stop_ext(#tok$1^68.27, $s);
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
    // assert @_vcc_wrapped(@state, (abs->protector)); 
    assert $wrapped($s, $dot($phys_ptr_cast(SL#abs, ^AbstractStruct), AbstractStruct.protector), ^Protector);
    // assert @writes_check((abs->protector)); 
    assert $top_writable($s, #wrTime$1^35.1, $dot($phys_ptr_cast(SL#abs, ^AbstractStruct), AbstractStruct.protector));
    // assume @_vcc_inv(@state, (abs->protector)); 
    assume $inv($s, $dot($phys_ptr_cast(SL#abs, ^AbstractStruct), AbstractStruct.protector), ^Protector);
    // assume ==(owns#5, @_vcc_owns(@state, (abs->protector))); 
    assume owns#5 == $owns($s, $dot($phys_ptr_cast(SL#abs, ^AbstractStruct), AbstractStruct.protector));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure((abs->protector)), prestate#6)
    call $static_unwrap($dot($phys_ptr_cast(SL#abs, ^AbstractStruct), AbstractStruct.protector), prestate#6);
    assume $good_state_ext(#tok$1^70.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    assert $closed($s, atomicObj#13);
    assume $inv($s, atomicObj#13, ^AbstractStruct);
    beforeAtomicState#0 := $s;
    // assert @prim_writes_check((*((s->abs))->value)); 
    assert $set_in($dot($rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct), AbstractStruct.value), $volatile_span($s, atomicObj#13)) || $writable_prim($s, #wrTime$1^35.1, $dot($rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct), AbstractStruct.value));
    // assert @reads_check_normal((s->abs)); 
    assert $thread_local($s, $phys_ptr_cast(P#s, ^ConcreteStruct)) || $phys_ptr_cast(P#s, ^ConcreteStruct) == atomicObj#13;
    // *(*((s->abs))->value) := v; 
    call $write_int(AbstractStruct.value, $rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct), P#v);
    assume $good_state_ext(#tok$1^77.27, $s);
    assert $set_eq($owns($s, atomicObj#13), $set_empty());
    assert $closed($s, $dot(atomicObj#13, AbstractStruct.protector)) ==> $rd_inv(beforeAtomicState#0, AbstractStruct.value, atomicObj#13) == $rd_inv($s, AbstractStruct.value, atomicObj#13);
    assert $rd_inv($s, AbstractStruct.value, atomicObj#13) == $op_mul(2, $rd_inv(beforeAtomicState#0, AbstractStruct.value, atomicObj#13)) || $rd_inv(beforeAtomicState#0, AbstractStruct.value, atomicObj#13) == $rd_inv($s, AbstractStruct.value, atomicObj#13);
    assume $full_stop_ext(#tok$1^56.19, $s);
    // _math state_t prestate#9; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#9, $state_to_int(prestate#9), ^$#state_t);
    // prestate#9 := @_vcc_current_state(@state); 
    prestate#9 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#9, $state_to_int(prestate#9), ^$#state_t);
    // _math state_t staticWrapState#7; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#7, $state_to_int(staticWrapState#7), ^$#state_t);
    // staticWrapState#7 := @_vcc_current_state(@state); 
    staticWrapState#7 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#7, $state_to_int(staticWrapState#7), ^$#state_t);
    // _math ptrset owns#8; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#8, $ptrset_to_int(owns#8), ^$#ptrset);
    // owns#8 := @_vcc_set_empty; 
    owns#8 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#8, $ptrset_to_int(owns#8), ^$#ptrset);
    // assert @writes_check((abs->protector)); 
    assert $top_writable($s, #wrTime$1^35.1, $dot($phys_ptr_cast(SL#abs, ^AbstractStruct), AbstractStruct.protector));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure((abs->protector)), staticWrapState#7, owns#8)
    call $static_wrap($dot($phys_ptr_cast(SL#abs, ^AbstractStruct), AbstractStruct.protector), staticWrapState#7, owns#8);
    assume $good_state_ext(#tok$1^80.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, (abs->protector)), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $dot($phys_ptr_cast(SL#abs, ^AbstractStruct), AbstractStruct.protector)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#12; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#12, $state_to_int(prestate#12), ^$#state_t);
    // prestate#12 := @_vcc_current_state(@state); 
    prestate#12 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#12, $state_to_int(prestate#12), ^$#state_t);
    // _math state_t staticWrapState#10; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#10, $state_to_int(staticWrapState#10), ^$#state_t);
    // staticWrapState#10 := @_vcc_current_state(@state); 
    staticWrapState#10 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#10, $state_to_int(staticWrapState#10), ^$#state_t);
    // _math ptrset owns#11; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#11, $ptrset_to_int(owns#11), ^$#ptrset);
    // owns#11 := @_vcc_set_empty; 
    owns#11 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#11, $ptrset_to_int(owns#11), ^$#ptrset);
    // assert @writes_check(s); 
    assert $top_writable($s, #wrTime$1^35.1, $phys_ptr_cast(P#s, ^ConcreteStruct));
    // assert @_vcc_wrapped(@state, (*((s->abs))->protector)); 
    assert $wrapped($s, $dot($rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct), AbstractStruct.protector), ^Protector);
    // assert @writes_check((*((s->abs))->protector)); 
    assert $top_writable($s, #wrTime$1^35.1, $dot($rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct), AbstractStruct.protector));
    // owns#11 := pure(@_vcc_set_union(owns#11, @_vcc_set_singleton((*((s->abs))->protector)))); 
    owns#11 := $set_union(owns#11, $set_singleton($dot($rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct), AbstractStruct.protector)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#11, $ptrset_to_int(owns#11), ^$#ptrset);
    // staticWrapState#10 := pure(@_vcc_take_over(staticWrapState#10, s, (*((s->abs))->protector))); 
    staticWrapState#10 := $take_over(staticWrapState#10, $phys_ptr_cast(P#s, ^ConcreteStruct), $dot($rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct), AbstractStruct.protector));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#10, $state_to_int(staticWrapState#10), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((s->abs))); 
    assert $wrapped($s, $rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct), ^AbstractStruct);
    // assert @writes_check(*((s->abs))); 
    assert $top_writable($s, #wrTime$1^35.1, $rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct));
    // owns#11 := pure(@_vcc_set_union(owns#11, @_vcc_set_singleton(*((s->abs))))); 
    owns#11 := $set_union(owns#11, $set_singleton($rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#11, $ptrset_to_int(owns#11), ^$#ptrset);
    // staticWrapState#10 := pure(@_vcc_take_over(staticWrapState#10, s, *((s->abs)))); 
    staticWrapState#10 := $take_over(staticWrapState#10, $phys_ptr_cast(P#s, ^ConcreteStruct), $rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#10, $state_to_int(staticWrapState#10), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(s), staticWrapState#10, owns#11)
    call $static_wrap($phys_ptr_cast(P#s, ^ConcreteStruct), staticWrapState#10, owns#11);
    assume $good_state_ext(#tok$1^83.19, $s);
    // assert @inv_check(@keeps_stable(old(prestate#12, *((s->abs))), *((s->abs)))); 
    assert $rd_phys_ptr(prestate#12, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct) == $rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct);
    // assert @inv_check(@keeps(s, *((s->abs)))); 
    assert $keeps($s, $phys_ptr_cast(P#s, ^ConcreteStruct), $rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct));
    // assert @inv_check(@keeps_stable(old(prestate#12, (*((s->abs))->protector)), (*((s->abs))->protector))); 
    assert $dot($rd_phys_ptr(prestate#12, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct), AbstractStruct.protector) == $dot($rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct), AbstractStruct.protector);
    // assert @inv_check(@keeps(s, (*((s->abs))->protector))); 
    assert $keeps($s, $phys_ptr_cast(P#s, ^ConcreteStruct), $dot($rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct), AbstractStruct.protector));
    // assert @inv_check(==(@_vcc_ref_cnt(@state, (*((s->abs))->protector)), 0)); 
    assert $ref_cnt($s, $dot($rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct), AbstractStruct.protector)) == 0;
    // assert @inv_check(==(*((s->value)), *((*((s->abs))->value)))); 
    assert $rd_inv($s, ConcreteStruct.value, $phys_ptr_cast(P#s, ^ConcreteStruct)) == $rd_inv($s, AbstractStruct.value, $rd_phys_ptr($s, ConcreteStruct.abs, $phys_ptr_cast(P#s, ^ConcreteStruct), ^AbstractStruct));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // empty

  #exit:
}



const unique l#public: $label;

const unique #tok$1^83.19: $token;

const unique #loc.owns#11: $token;

const unique #loc.staticWrapState#10: $token;

const unique #loc.prestate#12: $token;

const unique #tok$1^80.19: $token;

const unique #loc.owns#8: $token;

const unique #loc.staticWrapState#7: $token;

const unique #loc.prestate#9: $token;

const unique #tok$1^56.19: $token;

const unique #tok$1^77.27: $token;

const unique #tok$1^70.21: $token;

const unique #loc.prestate#6: $token;

const unique #loc.prestate#4: $token;

const unique #loc.owns#5: $token;

const unique #tok$1^68.27: $token;

const unique #tok$1^54.3: $token;

const unique #tok$1^52.29: $token;

const unique #tok$1^51.19: $token;

const unique #loc.prestate#3: $token;

function $state_to_int(x: $state) : int;

function $int_to_state(x: int) : $state;

axiom (forall #x: $state :: #x == $int_to_state($state_to_int(#x)));

const unique #loc.prestate#1: $token;

const unique #loc.owns#2: $token;

const unique #tok$2^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(2, #file^?3Cno?20file?3E);

const unique #distTp4: $ctype;

axiom #distTp4 == $spec_ptr_to(^^claim);

const unique #loc.c: $token;

const unique #tok$1^40.25: $token;

const unique #loc.abs: $token;

const unique #tok$1^44.33: $token;

const unique #loc.v: $token;

const unique #loc.s: $token;

const unique #tok$1^35.1: $token;

const unique #distTp3: $ctype;

axiom #distTp3 == $ptr_to(^ConcreteStruct);

const unique #tok$1^24.1: $token;

const unique #distTp2: $ctype;

axiom #distTp2 == $ptr_to(^AbstractStruct);

const unique #distTp1: $ctype;

axiom #distTp1 == $spec_ptr_to(^AbstractStruct);

const unique #loc._this_: $token;

const unique #tok$1^11.52: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CVolatileAbstractState.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CVolatileAbstractState.c);
