axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

const unique ^_LOCK: $ctype;

axiom $def_struct_type(^_LOCK, 4, true, true);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_LOCK) } $inv2(#s1, #s2, #p, ^_LOCK) == ($rd_inv(#s2, _LOCK.locked, #p) == 0 ==> $keeps(#s2, #p, $int_to_ptr($rd_inv(#s2, _LOCK.protected_obj, #p)))));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^_LOCK)) } $in(q, $composite_extent(s, p, ^_LOCK)) == (q == p));

const unique _LOCK.locked: $field;

axiom $def_phys_field(^_LOCK, _LOCK.locked, ^^i4, true, 0);

const unique _LOCK.protected_obj: $field;

axiom $def_ghost_field(^_LOCK, _LOCK.protected_obj, ^^object, false);

procedure _LOCK#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $rd_inv($s, _LOCK.locked, $phys_ptr_cast(P#_this_, ^_LOCK)) == 0 ==> $keeps($s, $phys_ptr_cast(P#_this_, ^_LOCK), $int_to_ptr($rd_inv($s, _LOCK.protected_obj, $phys_ptr_cast(P#_this_, ^_LOCK))));
  ensures $is_unwrap_check() ==> $rd_inv($s, _LOCK.locked, $phys_ptr_cast(P#_this_, ^_LOCK)) == 0 ==> $keeps($s, $phys_ptr_cast(P#_this_, ^_LOCK), $int_to_ptr($rd_inv($s, _LOCK.protected_obj, $phys_ptr_cast(P#_this_, ^_LOCK))));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _LOCK#adm(P#_this_: $ptr)
{
  var #wrTime$1^4.67: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^4.67, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^4.67, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^_LOCK));
    assume #wrTime$1^4.67 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^4.67, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($phys_ptr_cast(P#_this_, ^_LOCK), ^_LOCK);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $phys_ptr_cast(P#_this_, ^_LOCK));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($phys_ptr_cast(P#_this_, ^_LOCK));
        assume $good_state_ext(#tok$1^4.67, $s);
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
            assume $admissibility_pre($s, $phys_ptr_cast(P#_this_, ^_LOCK));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $phys_ptr_cast(P#_this_, ^_LOCK));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct _LOCK*)@null))
        call $havoc_others($phys_ptr_cast(P#_this_, ^_LOCK), ^_LOCK);
        assume $good_state_ext(#tok$1^4.67, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $phys_ptr_cast(P#_this_, ^_LOCK), ^_LOCK);
    }

  #exit:
}



const unique ^_DATA: $ctype;

axiom $is_span_sequential(^_DATA);

axiom $def_struct_type(^_DATA, 8, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_DATA) } $inv2(#s1, #s2, #p, ^_DATA) == ($set_eq($owns(#s2, #p), $set_empty()) && $rd_inv(#s2, _DATA.a, #p) + $rd_inv(#s2, _DATA.b, #p) > 0));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^_DATA)) } $in(q, $composite_extent(s, p, ^_DATA)) == (q == p));

const unique _DATA.a: $field;

axiom $def_phys_field(^_DATA, _DATA.a, ^^i4, false, 0);

const unique _DATA.b: $field;

axiom $def_phys_field(^_DATA, _DATA.b, ^^i4, false, 4);

procedure _DATA#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $set_eq($owns($s, $phys_ptr_cast(P#_this_, ^_DATA)), $set_empty());
  ensures $is_admissibility_check() ==> $rd_inv($s, _DATA.a, $phys_ptr_cast(P#_this_, ^_DATA)) + $rd_inv($s, _DATA.b, $phys_ptr_cast(P#_this_, ^_DATA)) > 0;
  ensures $is_unwrap_check() ==> $set_eq($owns($s, $phys_ptr_cast(P#_this_, ^_DATA)), $set_empty());
  ensures $is_unwrap_check() ==> $rd_inv($s, _DATA.a, $phys_ptr_cast(P#_this_, ^_DATA)) + $rd_inv($s, _DATA.b, $phys_ptr_cast(P#_this_, ^_DATA)) > 0;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _DATA#adm(P#_this_: $ptr)
{
  var #wrTime$1^60.9: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^60.9, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^60.9, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^_DATA));
    assume #wrTime$1^60.9 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^60.9, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($phys_ptr_cast(P#_this_, ^_DATA), ^_DATA);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon7:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $phys_ptr_cast(P#_this_, ^_DATA));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($phys_ptr_cast(P#_this_, ^_DATA));
        assume $good_state_ext(#tok$1^60.9, $s);
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
            assume $admissibility_pre($s, $phys_ptr_cast(P#_this_, ^_DATA));
        }
        else
        {
          anon9:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $phys_ptr_cast(P#_this_, ^_DATA));
        }

      anon11:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct _DATA*)@null))
        call $havoc_others($phys_ptr_cast(P#_this_, ^_DATA), ^_DATA);
        assume $good_state_ext(#tok$1^60.9, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $phys_ptr_cast(P#_this_, ^_DATA), ^_DATA);
    }

  #exit:
}



const unique ^_DATA_CONTAINER: $ctype;

axiom $is_span_sequential(^_DATA_CONTAINER);

axiom $def_struct_type(^_DATA_CONTAINER, 1, true, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_DATA_CONTAINER) } $inv2(#s1, #s2, #p, ^_DATA_CONTAINER) == ($phys_ptr_cast(G#DataLock#dt1, ^_LOCK) == $phys_ptr_cast(G#DataLock#dt1, ^_LOCK) && $keeps(#s2, #p, $phys_ptr_cast(G#DataLock#dt1, ^_LOCK)) && $int_to_ptr($rd_inv(#s2, _LOCK.protected_obj, $phys_ptr_cast(G#DataLock#dt1, ^_LOCK))) == $phys_ptr_cast(G#Data#dt2, ^_DATA)));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^_DATA_CONTAINER)) } $in(q, $composite_extent(s, p, ^_DATA_CONTAINER)) == (q == p));

const unique _DATA_CONTAINER.dummy: $field;

axiom $def_ghost_field(^_DATA_CONTAINER, _DATA_CONTAINER.dummy, ^^i4, false);

procedure _DATA_CONTAINER#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $phys_ptr_cast(G#DataLock#dt1, ^_LOCK) == $phys_ptr_cast(G#DataLock#dt1, ^_LOCK);
  ensures $is_admissibility_check() ==> $keeps($s, $spec_ptr_cast(P#_this_, ^_DATA_CONTAINER), $phys_ptr_cast(G#DataLock#dt1, ^_LOCK));
  ensures $is_admissibility_check() ==> $int_to_ptr($rd_inv($s, _LOCK.protected_obj, $phys_ptr_cast(G#DataLock#dt1, ^_LOCK))) == $phys_ptr_cast(G#Data#dt2, ^_DATA);
  ensures $is_stuttering_check() ==> $phys_ptr_cast(G#DataLock#dt1, ^_LOCK) == $phys_ptr_cast(G#DataLock#dt1, ^_LOCK);
  ensures $is_unwrap_check() ==> $phys_ptr_cast(G#DataLock#dt1, ^_LOCK) == $phys_ptr_cast(G#DataLock#dt1, ^_LOCK);
  ensures $is_unwrap_check() ==> $keeps($s, $spec_ptr_cast(P#_this_, ^_DATA_CONTAINER), $phys_ptr_cast(G#DataLock#dt1, ^_LOCK));
  ensures $is_unwrap_check() ==> $int_to_ptr($rd_inv($s, _LOCK.protected_obj, $phys_ptr_cast(G#DataLock#dt1, ^_LOCK))) == $phys_ptr_cast(G#Data#dt2, ^_DATA);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _DATA_CONTAINER#adm(P#_this_: $ptr)
{
  var #wrTime$1^67.50: int;
  var #stackframe: int;

  anon18:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^67.50, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^67.50, #loc._this_, $ptr_to_int(P#_this_), $spec_ptr_to(^_DATA_CONTAINER));
    assume #wrTime$1^67.50 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^67.50, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($spec_ptr_cast(P#_this_, ^_DATA_CONTAINER), ^_DATA_CONTAINER);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon13:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $spec_ptr_cast(P#_this_, ^_DATA_CONTAINER));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($spec_ptr_cast(P#_this_, ^_DATA_CONTAINER));
        assume $good_state_ext(#tok$1^67.50, $s);
        // assert true; 
        assert true;
    }
    else
    {
      anon16:
        assume true;
        // if (@_vcc_is_admissibility_check) ...
        if ($is_admissibility_check())
        {
          anon14:
            // assume @_vcc_admissibility_pre(@state, _this_); 
            assume $admissibility_pre($s, $spec_ptr_cast(P#_this_, ^_DATA_CONTAINER));
        }
        else
        {
          anon15:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $spec_ptr_cast(P#_this_, ^_DATA_CONTAINER));
        }

      anon17:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct _DATA_CONTAINER*)@null))
        call $havoc_others($spec_ptr_cast(P#_this_, ^_DATA_CONTAINER), ^_DATA_CONTAINER);
        assume $good_state_ext(#tok$1^67.50, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $spec_ptr_cast(P#_this_, ^_DATA_CONTAINER), ^_DATA_CONTAINER);
    }

  #exit:
}



procedure InitializeLock(P#l: $ptr, SP#obj: $ptr);
  requires $wrapped($s, SP#obj, $typ(SP#obj));
  modifies $s, $cev_pc;
  ensures $wrapped($s, $phys_ptr_cast(P#l, ^_LOCK), ^_LOCK) && $int_to_ptr($rd_inv($s, _LOCK.protected_obj, $phys_ptr_cast(P#l, ^_LOCK))) == SP#obj;
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: $set_in(#p, $span($phys_ptr_cast(P#l, ^_LOCK))) || #p == SP#obj));
  free ensures $call_transition(old($s), $s);



implementation InitializeLock(P#l: $ptr, SP#obj: $ptr)
{
  var prestate#8: $state;
  var #wrTime$1^12.1: int;
  var #stackframe: int;

  anon19:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^12.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^12.1, #loc.l, $ptr_to_int(P#l), $ptr_to(^_LOCK));
    assume $local_value_is($s, #tok$1^12.1, #loc.obj, $ptr_to_int(SP#obj), ^^object);
    assume #wrTime$1^12.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^12.1, (lambda #p: $ptr :: $set_in(#p, $span($phys_ptr_cast(P#l, ^_LOCK))) || #p == SP#obj));
    assume $mutable($s, $phys_ptr_cast(P#l, ^_LOCK));
    assume $thread_owned_or_even_mutable($s, SP#obj);
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, obj, obj); 
    assert $in_domain_lab($s, SP#obj, SP#obj, l#public);
    // assert @prim_writes_check((l->locked)); 
    assert $writable_prim($s, #wrTime$1^12.1, $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.locked));
    // *(l->locked) := 0; 
    call $write_int(_LOCK.locked, $phys_ptr_cast(P#l, ^_LOCK), 0);
    assume $full_stop_ext(#tok$1^17.3, $s);
    // assert @prim_writes_check((l->protected_obj)); 
    assert $writable_prim($s, #wrTime$1^12.1, $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.protected_obj));
    // *(l->protected_obj) := obj; 
    call $write_int(_LOCK.protected_obj, $phys_ptr_cast(P#l, ^_LOCK), $ptr_to_int(SP#obj));
    assume $full_stop_ext(#tok$1^19.5, $s);
    // assert @writes_check(@_vcc_span(l)); 
    assert (forall #writes$1^20.27: $ptr :: { $dont_instantiate(#writes$1^20.27) } $set_in(#writes$1^20.27, $span($phys_ptr_cast(P#l, ^_LOCK))) ==> $top_writable($s, #wrTime$1^12.1, #writes$1^20.27));
    // stmt _vcc_set_owns(l, @_vcc_set_singleton(obj)); 
    call $set_owns($phys_ptr_cast(P#l, ^_LOCK), $set_singleton(SP#obj));
    assume $full_stop_ext(#tok$1^20.27, $s);
    // empty
    // _math state_t prestate#8; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#8, $state_to_int(prestate#8), ^$#state_t);
    // prestate#8 := @_vcc_current_state(@state); 
    prestate#8 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#8, $state_to_int(prestate#8), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(l); 
    assert $top_writable($s, #wrTime$1^12.1, $phys_ptr_cast(P#l, ^_LOCK));
    // assert @writes_check(@_vcc_owns(@state, l)); 
    assert (forall #writes$1^21.21: $ptr :: { $dont_instantiate(#writes$1^21.21) } $set_in(#writes$1^21.21, $owns($s, $phys_ptr_cast(P#l, ^_LOCK))) ==> $top_writable($s, #wrTime$1^12.1, #writes$1^21.21));
    // stmt @_vcc_wrap(l, @_vcc_typeof(l)); 
    call $wrap($phys_ptr_cast(P#l, ^_LOCK), ^_LOCK);
    assume $good_state_ext(#tok$1^21.21, $s);
    // assert @inv_check(==>(==(*((l->locked)), 0), @keeps(l, *((l->protected_obj))))); 
    assert $rd_inv($s, _LOCK.locked, $phys_ptr_cast(P#l, ^_LOCK)) == 0 ==> $keeps($s, $phys_ptr_cast(P#l, ^_LOCK), $int_to_ptr($rd_inv($s, _LOCK.protected_obj, $phys_ptr_cast(P#l, ^_LOCK))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure Acquire(P#l: $ptr, SP#c: $ptr);
  requires true;
  requires $wrapped($s, $spec_ptr_cast(SP#c, ^^claim), ^^claim);
  requires $valid_claim($s, $spec_ptr_cast(SP#c, ^^claim));
  requires (forall #cs0: $state :: { $valid_claim(#cs0, $spec_ptr_cast(SP#c, ^^claim)) } $valid_claim(#cs0, $spec_ptr_cast(SP#c, ^^claim)) ==> $claimed_closed(#cs0, $phys_ptr_cast(P#l, ^_LOCK)));
  modifies $s, $cev_pc;
  ensures $wrapped($s, $int_to_ptr($rd_inv($s, $field($by_claim($s, $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(P#l, ^_LOCK), $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.protected_obj))), $emb0($by_claim($s, $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(P#l, ^_LOCK), $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.protected_obj))))), $typ($int_to_ptr($rd_inv($s, $field($by_claim($s, $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(P#l, ^_LOCK), $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.protected_obj))), $emb0($by_claim($s, $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(P#l, ^_LOCK), $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.protected_obj))))))) && $is_fresh(old($s), $s, $int_to_ptr($rd_inv($s, $field($by_claim($s, $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(P#l, ^_LOCK), $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.protected_obj))), $emb0($by_claim($s, $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(P#l, ^_LOCK), $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.protected_obj))))));
  ensures $wrapped($s, $spec_ptr_cast(SP#c, ^^claim), ^^claim) && $valid_claim($s, $spec_ptr_cast(SP#c, ^^claim));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Acquire(P#l: $ptr, SP#c: $ptr)
{
  var ite#6: bool;
  var ite#5: bool;
  var res#4: int where $in_range_i4(res#4);
  var Comparand#3: int where $in_range_i4(Comparand#3);
  var Exchange#2: int where $in_range_i4(Exchange#2);
  var Destination#1: $ptr;
  var beforeAtomicState#1: $state;
  var atomicObj#21: $ptr;
  var loopState#0: $state;
  var L#stop: int where $in_range_i4(L#stop);
  var #wrTime$1^34.1: int;
  var #stackframe: int;

  anon29:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^34.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^34.1, #loc.l, $ptr_to_int(P#l), $ptr_to(^_LOCK));
    assume $local_value_is($s, #tok$1^34.1, #loc.c, $ptr_to_int(SP#c), $spec_ptr_to(^^claim));
    assume #wrTime$1^34.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^34.1, (lambda #p: $ptr :: false));
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
    // int32_t stop; 
    assume $local_value_is($s, #tok$1^38.3, #loc.stop, L#stop, ^^i4);
    // stop := 0; 
    L#stop := 0;
    assume $local_value_is($s, #tok$1^38.3, #loc.stop, L#stop, ^^i4);
    loopState#0 := $s;
    while (true)
    {
      anon25:
        assume $writes_nothing(old($s), $s);
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$1^40.3, $s);
        assume $local_value_is($s, #tok$1^40.3, #loc.stop, L#stop, ^^i4);
        assume $local_value_is($s, #tok$1^40.3, #loc.c, $ptr_to_int(SP#c), $spec_ptr_to(^^claim));
        // assume @_vcc_mutable_increases(old(@prestate, @state), @state); 
        assume $mutable_increases(loopState#0, $s);
        assume true;
        call $atomic_havoc();
        assume $full_stop_ext(#tok$1^41.21, $s);
        atomicObj#21 := $phys_ptr_cast(P#l, ^_LOCK);
        assert $valid_claim($s, $spec_ptr_cast(SP#c, ^^claim));
        assert $closed($s, atomicObj#21);
        assume $inv($s, atomicObj#21, ^_LOCK);
        beforeAtomicState#1 := $s;
        // int32_t* Destination#1; 
        assume $local_value_is($s, #tok$1^42.41, #loc.Destination#1, $ptr_to_int(Destination#1), $ptr_to(^^i4));
        // Destination#1 := (l->locked); 
        Destination#1 := $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.locked);
        assume $local_value_is($s, #tok$1^42.41, #loc.Destination#1, $ptr_to_int(Destination#1), $ptr_to(^^i4));
        // int32_t Exchange#2; 
        assume $local_value_is($s, #tok$1^42.53, #loc.Exchange#2, Exchange#2, ^^i4);
        // Exchange#2 := 1; 
        Exchange#2 := 1;
        assume $local_value_is($s, #tok$1^42.53, #loc.Exchange#2, Exchange#2, ^^i4);
        // int32_t Comparand#3; 
        assume $local_value_is($s, #tok$1^42.56, #loc.Comparand#3, Comparand#3, ^^i4);
        // Comparand#3 := 0; 
        Comparand#3 := 0;
        assume $local_value_is($s, #tok$1^42.56, #loc.Comparand#3, Comparand#3, ^^i4);
        // int32_t res#4; 
        assume $local_value_is($s, #tok$1^42.14, #loc.res#4, res#4, ^^i4);
        // assert @reads_check_normal(Destination#1); 
        assert $thread_local($s, $phys_ptr_cast(Destination#1, ^^i4)) || $set_in($phys_ptr_cast(Destination#1, ^^i4), $span(atomicObj#21));
        assume true;
        // if (==(*(Destination#1), Comparand#3)) ...
        if ($rd_inv($s, $field($phys_ptr_cast(Destination#1, ^^i4)), $emb0($phys_ptr_cast(Destination#1, ^^i4))) == Comparand#3)
        {
          anon20:
            // assert @prim_writes_check(Destination#1); 
            assert $set_in($phys_ptr_cast(Destination#1, ^^i4), $volatile_span($s, atomicObj#21)) || $writable_prim($s, #wrTime$1^34.1, $phys_ptr_cast(Destination#1, ^^i4));
            // *Destination#1 := Exchange#2; 
            call $write_int($field($phys_ptr_cast(Destination#1, ^^i4)), $emb0($phys_ptr_cast(Destination#1, ^^i4)), Exchange#2);
            assume $good_state_ext(#tok$1^42.41, $s);
            // res#4 := Comparand#3; 
            res#4 := Comparand#3;
            assume $local_value_is($s, #tok$1^28.5, #loc.res#4, res#4, ^^i4);
        }
        else
        {
          anon21:
            // assert @reads_check_normal(Destination#1); 
            assert $thread_local($s, $phys_ptr_cast(Destination#1, ^^i4)) || $set_in($phys_ptr_cast(Destination#1, ^^i4), $span(atomicObj#21));
            // res#4 := *(Destination#1); 
            res#4 := $rd_inv($s, $field($phys_ptr_cast(Destination#1, ^^i4)), $emb0($phys_ptr_cast(Destination#1, ^^i4)));
            assume $local_value_is($s, #tok$1^30.5, #loc.res#4, res#4, ^^i4);
        }

      anon26:
        // empty
        // stop := (int32_t)==(res#4, 0); 
        L#stop := $bool_to_int(res#4 == 0);
        assume $local_value_is($s, #tok$1^42.7, #loc.stop, L#stop, ^^i4);
        // _Bool ite#5; 
        assume $local_value_is($s, #tok$1^43.33, #loc.ite#5, $bool_to_int(ite#5), ^^bool);
        // ite#5 := (_Bool)stop; 
        ite#5 := $int_to_bool(L#stop);
        assume $local_value_is($s, #tok$1^43.33, #loc.ite#5, $bool_to_int(ite#5), ^^bool);
        assume true;
        // if (ite#5) ...
        if (ite#5)
        {
          anon22:
            // assert @is_atomic_obj(l); 
            assert $phys_ptr_cast(P#l, ^_LOCK) == atomicObj#21;
            // assert @reads_check_normal((l->protected_obj)); 
            assert $thread_local($s, $phys_ptr_cast(P#l, ^_LOCK)) || $phys_ptr_cast(P#l, ^_LOCK) == atomicObj#21;
            // stmt _vcc_giveup_closed_owner(*((l->protected_obj)), l); 
            call $giveup_closed_owner($int_to_ptr($rd_inv($s, _LOCK.protected_obj, $phys_ptr_cast(P#l, ^_LOCK))), $phys_ptr_cast(P#l, ^_LOCK));
            assume $good_state_ext(#tok$1^43.61, $s);
        }
        else
        {
          anon23:
            // empty
        }

      anon27:
        assert $rd_inv($s, _LOCK.locked, atomicObj#21) == 0 ==> $keeps($s, atomicObj#21, $int_to_ptr($rd_inv($s, _LOCK.protected_obj, atomicObj#21)));
        assume $full_stop_ext(#tok$1^41.21, $s);

      #continue_7:
        // _Bool ite#6; 
        assume $local_value_is($s, #tok$1^45.13, #loc.ite#6, $bool_to_int(ite#6), ^^bool);
        // ite#6 := (_Bool)stop; 
        ite#6 := $int_to_bool(L#stop);
        assume $local_value_is($s, #tok$1^45.13, #loc.ite#6, $bool_to_int(ite#6), ^^bool);
        assume true;
        // if (unchecked!(unchecked!(ite#6))) ...
        if (!!ite#6)
        {
          anon24:
            // goto #break_7; 
            goto #break_7;
        }

      anon28:
        assume true;
    }

  anon30:
    assume $full_stop_ext(#tok$1^40.3, $s);

  #break_7:
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure Release(P#l: $ptr, SP#c: $ptr);
  requires true;
  requires $int_to_ptr($rd_inv($s, $field($by_claim($s, $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(P#l, ^_LOCK), $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.protected_obj))), $emb0($by_claim($s, $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(P#l, ^_LOCK), $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.protected_obj))))) != $spec_ptr_cast(SP#c, ^^claim);
  requires $wrapped($s, $int_to_ptr($rd_inv($s, $field($by_claim($s, $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(P#l, ^_LOCK), $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.protected_obj))), $emb0($by_claim($s, $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(P#l, ^_LOCK), $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.protected_obj))))), $typ($int_to_ptr($rd_inv($s, $field($by_claim($s, $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(P#l, ^_LOCK), $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.protected_obj))), $emb0($by_claim($s, $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(P#l, ^_LOCK), $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.protected_obj)))))));
  requires $wrapped($s, $spec_ptr_cast(SP#c, ^^claim), ^^claim);
  requires $valid_claim($s, $spec_ptr_cast(SP#c, ^^claim));
  requires (forall #cs1: $state :: { $valid_claim(#cs1, $spec_ptr_cast(SP#c, ^^claim)) } $valid_claim(#cs1, $spec_ptr_cast(SP#c, ^^claim)) ==> $claimed_closed(#cs1, $phys_ptr_cast(P#l, ^_LOCK)));
  modifies $s, $cev_pc;
  ensures $wrapped($s, $spec_ptr_cast(SP#c, ^^claim), ^^claim) && $valid_claim($s, $spec_ptr_cast(SP#c, ^^claim));
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $int_to_ptr($rd_inv(old($s), $field($by_claim(old($s), $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(P#l, ^_LOCK), $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.protected_obj))), $emb0($by_claim(old($s), $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(P#l, ^_LOCK), $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.protected_obj)))))));
  free ensures $call_transition(old($s), $s);



implementation Release(P#l: $ptr, SP#c: $ptr)
{
  var beforeAtomicState#2: $state;
  var atomicObj#22: $ptr;
  var #wrTime$1^48.1: int;
  var #stackframe: int;

  anon31:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^48.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^48.1, #loc.l, $ptr_to_int(P#l), $ptr_to(^_LOCK));
    assume $local_value_is($s, #tok$1^48.1, #loc.c, $ptr_to_int(SP#c), $spec_ptr_to(^^claim));
    assume #wrTime$1^48.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^48.1, (lambda #p: $ptr :: #p == $int_to_ptr($rd_inv($s, $field($by_claim($s, $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(P#l, ^_LOCK), $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.protected_obj))), $emb0($by_claim($s, $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(P#l, ^_LOCK), $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.protected_obj)))))));
    assume $thread_owned_or_even_mutable($s, $int_to_ptr($rd_inv($s, $field($by_claim($s, $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(P#l, ^_LOCK), $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.protected_obj))), $emb0($by_claim($s, $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(P#l, ^_LOCK), $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.protected_obj))))));
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
    // assert @_vcc_in_domain(@state, @by_claim(c, l, (l->protected_obj)), @by_claim(c, l, (l->protected_obj))); 
    assert $in_domain_lab($s, $int_to_ptr($rd_inv($s, $field($by_claim($s, $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(P#l, ^_LOCK), $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.protected_obj))), $emb0($by_claim($s, $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(P#l, ^_LOCK), $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.protected_obj))))), $int_to_ptr($rd_inv($s, $field($by_claim($s, $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(P#l, ^_LOCK), $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.protected_obj))), $emb0($by_claim($s, $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(P#l, ^_LOCK), $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.protected_obj))))), l#public);
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^54.19, $s);
    atomicObj#22 := $phys_ptr_cast(P#l, ^_LOCK);
    assert $valid_claim($s, $spec_ptr_cast(SP#c, ^^claim));
    assert $closed($s, atomicObj#22);
    assume $inv($s, atomicObj#22, ^_LOCK);
    beforeAtomicState#2 := $s;
    // assert @is_atomic_obj(l); 
    assert $phys_ptr_cast(P#l, ^_LOCK) == atomicObj#22;
    // assert @writes_check(*((l->protected_obj))); 
    assert $top_writable($s, #wrTime$1^48.1, $int_to_ptr($rd_inv($s, _LOCK.protected_obj, $phys_ptr_cast(P#l, ^_LOCK))));
    // assert @reads_check_normal((l->protected_obj)); 
    assert $thread_local($s, $phys_ptr_cast(P#l, ^_LOCK)) || $phys_ptr_cast(P#l, ^_LOCK) == atomicObj#22;
    // stmt _vcc_set_closed_owner(*((l->protected_obj)), l); 
    call $set_closed_owner($int_to_ptr($rd_inv($s, _LOCK.protected_obj, $phys_ptr_cast(P#l, ^_LOCK))), $phys_ptr_cast(P#l, ^_LOCK));
    assume $good_state_ext(#tok$1^55.27, $s);
    // empty
    // assert @prim_writes_check((l->locked)); 
    assert $set_in($dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.locked), $volatile_span($s, atomicObj#22)) || $writable_prim($s, #wrTime$1^48.1, $dot($phys_ptr_cast(P#l, ^_LOCK), _LOCK.locked));
    // *(l->locked) := 0; 
    call $write_int(_LOCK.locked, $phys_ptr_cast(P#l, ^_LOCK), 0);
    assume $good_state_ext(#tok$1^56.5, $s);
    assert $rd_inv($s, _LOCK.locked, atomicObj#22) == 0 ==> $keeps($s, atomicObj#22, $int_to_ptr($rd_inv($s, _LOCK.protected_obj, atomicObj#22)));
    assume $full_stop_ext(#tok$1^54.19, $s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



const unique G#DataLock#dt1: $ptr;

axiom $def_global(G#DataLock#dt1, ^_LOCK);

axiom $is_global($phys_ptr_cast(G#DataLock#dt1, ^_LOCK), ^_LOCK);

const unique G#Data#dt2: $ptr;

axiom $def_global(G#Data#dt2, ^_DATA);

axiom $is_global($phys_ptr_cast(G#Data#dt2, ^_DATA), ^_DATA);

procedure testit(SP#c: $ptr);
  requires true;
  requires $wrapped($s, $spec_ptr_cast(SP#c, ^^claim), ^^claim);
  requires $valid_claim($s, $spec_ptr_cast(SP#c, ^^claim));
  requires (forall #cs2: $state :: { $valid_claim(#cs2, $spec_ptr_cast(SP#c, ^^claim)) } $valid_claim(#cs2, $spec_ptr_cast(SP#c, ^^claim)) ==> $claimed_closed(#cs2, $spec_ptr_cast(G#DataContainer#dt3, ^_DATA_CONTAINER)));
  modifies $s, $cev_pc;
  ensures $wrapped($s, $spec_ptr_cast(SP#c, ^^claim), ^^claim) && $valid_claim($s, $spec_ptr_cast(SP#c, ^^claim));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation testit(SP#c: $ptr)
{
  var owns#13: $ptrset;
  var staticWrapState#12: $state;
  var prestate#14: $state;
  var prestate#11: $state;
  var prestate#9: $state;
  var owns#10: $ptrset;
  var #wrTime$1^77.1: int;
  var #stackframe: int;

  anon32:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^77.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^77.1, #loc.c, $ptr_to_int(SP#c), $spec_ptr_to(^^claim));
    assume #wrTime$1^77.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^77.1, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_valid_claim(@state, c); 
    assert $valid_claim($s, $spec_ptr_cast(SP#c, ^^claim));
    // assert @_vcc_in_domain(@state, c, c); 
    assert $in_domain_lab($s, $spec_ptr_cast(SP#c, ^^claim), $spec_ptr_cast(SP#c, ^^claim), l#public);
    // stmt Acquire(DataLock, c); 
    call Acquire($phys_ptr_cast(G#DataLock#dt1, ^_LOCK), $spec_ptr_cast(SP#c, ^^claim));
    assume $full_stop_ext(#tok$1^80.3, $s);
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
    // assert @_vcc_wrapped(@state, Data); 
    assert $wrapped($s, $phys_ptr_cast(G#Data#dt2, ^_DATA), ^_DATA);
    // assert @writes_check(Data); 
    assert $top_writable($s, #wrTime$1^77.1, $phys_ptr_cast(G#Data#dt2, ^_DATA));
    // assume @_vcc_inv(@state, Data); 
    assume $inv($s, $phys_ptr_cast(G#Data#dt2, ^_DATA), ^_DATA);
    // assume ==(owns#10, @_vcc_owns(@state, Data)); 
    assume owns#10 == $owns($s, $phys_ptr_cast(G#Data#dt2, ^_DATA));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(Data), prestate#11)
    call $static_unwrap($phys_ptr_cast(G#Data#dt2, ^_DATA), prestate#11);
    assume $good_state_ext(#tok$1^81.32, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((Data->a)); 
    assert $writable_prim($s, #wrTime$1^77.1, $dot($phys_ptr_cast(G#Data#dt2, ^_DATA), _DATA.a));
    // *(Data->a) := 5; 
    call $write_int(_DATA.a, $phys_ptr_cast(G#Data#dt2, ^_DATA), 5);
    assume $full_stop_ext(#tok$1^82.7, $s);
    // assert @prim_writes_check((Data->b)); 
    assert $writable_prim($s, #wrTime$1^77.1, $dot($phys_ptr_cast(G#Data#dt2, ^_DATA), _DATA.b));
    // *(Data->b) := 7; 
    call $write_int(_DATA.b, $phys_ptr_cast(G#Data#dt2, ^_DATA), 7);
    assume $full_stop_ext(#tok$1^83.7, $s);
    // _math state_t prestate#14; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#14, $state_to_int(prestate#14), ^$#state_t);
    // prestate#14 := @_vcc_current_state(@state); 
    prestate#14 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#14, $state_to_int(prestate#14), ^$#state_t);
    // _math state_t staticWrapState#12; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#12, $state_to_int(staticWrapState#12), ^$#state_t);
    // staticWrapState#12 := @_vcc_current_state(@state); 
    staticWrapState#12 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#12, $state_to_int(staticWrapState#12), ^$#state_t);
    // _math ptrset owns#13; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#13, $ptrset_to_int(owns#13), ^$#ptrset);
    // owns#13 := @_vcc_set_empty; 
    owns#13 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#13, $ptrset_to_int(owns#13), ^$#ptrset);
    // assert @writes_check(Data); 
    assert $top_writable($s, #wrTime$1^77.1, $phys_ptr_cast(G#Data#dt2, ^_DATA));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(Data), staticWrapState#12, owns#13)
    call $static_wrap($phys_ptr_cast(G#Data#dt2, ^_DATA), staticWrapState#12, owns#13);
    assume $good_state_ext(#tok$1^81.32, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, Data), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(G#Data#dt2, ^_DATA)), $set_empty());
    // assert @inv_check(>(+(*((Data->a)), *((Data->b))), 0)); 
    assert $rd_inv($s, _DATA.a, $phys_ptr_cast(G#Data#dt2, ^_DATA)) + $rd_inv($s, _DATA.b, $phys_ptr_cast(G#Data#dt2, ^_DATA)) > 0;
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @writes_check(@by_claim(c, DataLock, (DataLock->protected_obj))); 
    assert $top_writable($s, #wrTime$1^77.1, $int_to_ptr($rd_inv($s, $field($by_claim($s, $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(G#DataLock#dt1, ^_LOCK), $dot($phys_ptr_cast(G#DataLock#dt1, ^_LOCK), _LOCK.protected_obj))), $emb0($by_claim($s, $spec_ptr_cast(SP#c, ^^claim), $phys_ptr_cast(G#DataLock#dt1, ^_LOCK), $dot($phys_ptr_cast(G#DataLock#dt1, ^_LOCK), _LOCK.protected_obj))))));
    // stmt Release(DataLock, c); 
    call Release($phys_ptr_cast(G#DataLock#dt1, ^_LOCK), $spec_ptr_cast(SP#c, ^^claim));
    assume $full_stop_ext(#tok$1^85.3, $s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



const unique G#DataContainer#dt3: $ptr;

axiom $def_global(G#DataContainer#dt3, ^_DATA_CONTAINER);

axiom $is_global($spec_ptr_cast(G#DataContainer#dt3, ^_DATA_CONTAINER), ^_DATA_CONTAINER);

procedure boot();
  requires $program_entry_point($s);
  modifies $s, $cev_pc;
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: $set_in(#p, $set_universe())));
  free ensures $call_transition(old($s), $s);



implementation boot()
{
  var claim#0doAdm: bool;
  var claim#0s2: $state;
  var claim#0s1: $state;
  var claim#0s0: $state;
  var claim#0: $ptr;
  var owns#19: $ptrset;
  var staticWrapState#18: $state;
  var prestate#20: $state;
  var owns#16: $ptrset;
  var staticWrapState#15: $state;
  var prestate#17: $state;
  var SL#c: $ptr;
  var #wrTime$1^88.1: int;
  var #stackframe: int;

  anon34:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^88.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^88.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^88.1, (lambda #p: $ptr :: $set_in(#p, $set_universe())));
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // claim_t^ c; 
    assume $local_value_is($s, #tok$1^92.25, #loc.c, $ptr_to_int(SL#c), $spec_ptr_to(^^claim));
    // var spec claim_t^ c
    // assert @prim_writes_check((Data->a)); 
    assert $writable_prim($s, #wrTime$1^88.1, $dot($phys_ptr_cast(G#Data#dt2, ^_DATA), _DATA.a));
    // *(Data->a) := 42; 
    call $write_int(_DATA.a, $phys_ptr_cast(G#Data#dt2, ^_DATA), 42);
    assume $full_stop_ext(#tok$1^94.3, $s);
    // assert @prim_writes_check((Data->b)); 
    assert $writable_prim($s, #wrTime$1^88.1, $dot($phys_ptr_cast(G#Data#dt2, ^_DATA), _DATA.b));
    // *(Data->b) := 17; 
    call $write_int(_DATA.b, $phys_ptr_cast(G#Data#dt2, ^_DATA), 17);
    assume $full_stop_ext(#tok$1^95.3, $s);
    // _math state_t prestate#17; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#17, $state_to_int(prestate#17), ^$#state_t);
    // prestate#17 := @_vcc_current_state(@state); 
    prestate#17 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#17, $state_to_int(prestate#17), ^$#state_t);
    // _math state_t staticWrapState#15; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#15, $state_to_int(staticWrapState#15), ^$#state_t);
    // staticWrapState#15 := @_vcc_current_state(@state); 
    staticWrapState#15 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#15, $state_to_int(staticWrapState#15), ^$#state_t);
    // _math ptrset owns#16; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#16, $ptrset_to_int(owns#16), ^$#ptrset);
    // owns#16 := @_vcc_set_empty; 
    owns#16 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#16, $ptrset_to_int(owns#16), ^$#ptrset);
    // assert @writes_check(Data); 
    assert $top_writable($s, #wrTime$1^88.1, $phys_ptr_cast(G#Data#dt2, ^_DATA));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(Data), staticWrapState#15, owns#16)
    call $static_wrap($phys_ptr_cast(G#Data#dt2, ^_DATA), staticWrapState#15, owns#16);
    assume $good_state_ext(#tok$1^96.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, Data), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(G#Data#dt2, ^_DATA)), $set_empty());
    // assert @inv_check(>(+(*((Data->a)), *((Data->b))), 0)); 
    assert $rd_inv($s, _DATA.a, $phys_ptr_cast(G#Data#dt2, ^_DATA)) + $rd_inv($s, _DATA.b, $phys_ptr_cast(G#Data#dt2, ^_DATA)) > 0;
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @writes_check(@_vcc_span(DataLock)); 
    assert (forall #writes$1^97.3: $ptr :: { $dont_instantiate(#writes$1^97.3) } $set_in(#writes$1^97.3, $span($phys_ptr_cast(G#DataLock#dt1, ^_LOCK))) ==> $top_writable($s, #wrTime$1^88.1, #writes$1^97.3));
    // assert @writes_check(Data); 
    assert $top_writable($s, #wrTime$1^88.1, $phys_ptr_cast(G#Data#dt2, ^_DATA));
    // stmt InitializeLock(DataLock, Data); 
    call InitializeLock($phys_ptr_cast(G#DataLock#dt1, ^_LOCK), $phys_ptr_cast(G#Data#dt2, ^_DATA));
    assume $full_stop_ext(#tok$1^97.3, $s);
    // assert @writes_check(@_vcc_span(DataContainer)); 
    assert (forall #writes$1^98.25: $ptr :: { $dont_instantiate(#writes$1^98.25) } $set_in(#writes$1^98.25, $span($spec_ptr_cast(G#DataContainer#dt3, ^_DATA_CONTAINER))) ==> $top_writable($s, #wrTime$1^88.1, #writes$1^98.25));
    // stmt _vcc_set_owns(DataContainer, @_vcc_set_add_element(@_vcc_owns(@state, DataContainer), DataLock)); 
    call $set_owns($spec_ptr_cast(G#DataContainer#dt3, ^_DATA_CONTAINER), $set_add_element($owns($s, $spec_ptr_cast(G#DataContainer#dt3, ^_DATA_CONTAINER)), $phys_ptr_cast(G#DataLock#dt1, ^_LOCK)));
    assume $full_stop_ext(#tok$1^98.25, $s);
    // empty
    // _math state_t prestate#20; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#20, $state_to_int(prestate#20), ^$#state_t);
    // prestate#20 := @_vcc_current_state(@state); 
    prestate#20 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#20, $state_to_int(prestate#20), ^$#state_t);
    // _math state_t staticWrapState#18; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#18, $state_to_int(staticWrapState#18), ^$#state_t);
    // staticWrapState#18 := @_vcc_current_state(@state); 
    staticWrapState#18 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#18, $state_to_int(staticWrapState#18), ^$#state_t);
    // _math ptrset owns#19; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#19, $ptrset_to_int(owns#19), ^$#ptrset);
    // owns#19 := @_vcc_set_empty; 
    owns#19 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#19, $ptrset_to_int(owns#19), ^$#ptrset);
    // assert @writes_check(DataContainer); 
    assert $top_writable($s, #wrTime$1^88.1, $spec_ptr_cast(G#DataContainer#dt3, ^_DATA_CONTAINER));
    // assert @_vcc_wrapped(@state, DataLock); 
    assert $wrapped($s, $phys_ptr_cast(G#DataLock#dt1, ^_LOCK), ^_LOCK);
    // assert @writes_check(DataLock); 
    assert $top_writable($s, #wrTime$1^88.1, $phys_ptr_cast(G#DataLock#dt1, ^_LOCK));
    // owns#19 := pure(@_vcc_set_union(owns#19, @_vcc_set_singleton(DataLock))); 
    owns#19 := $set_union(owns#19, $set_singleton($phys_ptr_cast(G#DataLock#dt1, ^_LOCK)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#19, $ptrset_to_int(owns#19), ^$#ptrset);
    // staticWrapState#18 := pure(@_vcc_take_over(staticWrapState#18, DataContainer, DataLock)); 
    staticWrapState#18 := $take_over(staticWrapState#18, $spec_ptr_cast(G#DataContainer#dt3, ^_DATA_CONTAINER), $phys_ptr_cast(G#DataLock#dt1, ^_LOCK));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#18, $state_to_int(staticWrapState#18), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(DataContainer), staticWrapState#18, owns#19)
    call $static_wrap($spec_ptr_cast(G#DataContainer#dt3, ^_DATA_CONTAINER), staticWrapState#18, owns#19);
    assume $good_state_ext(#tok$1^99.19, $s);
    // assert @inv_check(@keeps_stable(old(prestate#20, DataLock), DataLock)); 
    assert $phys_ptr_cast(G#DataLock#dt1, ^_LOCK) == $phys_ptr_cast(G#DataLock#dt1, ^_LOCK);
    // assert @inv_check(@keeps(DataContainer, DataLock)); 
    assert $keeps($s, $spec_ptr_cast(G#DataContainer#dt3, ^_DATA_CONTAINER), $phys_ptr_cast(G#DataLock#dt1, ^_LOCK));
    // assert @inv_check(==(*((DataLock->protected_obj)), Data)); 
    assert $int_to_ptr($rd_inv($s, _LOCK.protected_obj, $phys_ptr_cast(G#DataLock#dt1, ^_LOCK))) == $phys_ptr_cast(G#Data#dt2, ^_DATA);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // c := @claim(pure(@_vcc_closed(@state, DataContainer)), DataContainer); 
    assert $closed($s, $spec_ptr_cast(G#DataContainer#dt3, ^_DATA_CONTAINER));
    assert $top_writable($s, #wrTime$1^88.1, $spec_ptr_cast(G#DataContainer#dt3, ^_DATA_CONTAINER));
    assert $is_claimable(^_DATA_CONTAINER);
    call $write_ref_cnt($spec_ptr_cast(G#DataContainer#dt3, ^_DATA_CONTAINER), $ref_cnt($s, $spec_ptr_cast(G#DataContainer#dt3, ^_DATA_CONTAINER)) + 1);
    assume $ref_cnt($s, $spec_ptr_cast(G#DataContainer#dt3, ^_DATA_CONTAINER)) >= 0;
    claim#0s0 := $s;
    call claim#0 := $alloc_claim();
    assume $claims_obj(claim#0, $spec_ptr_cast(G#DataContainer#dt3, ^_DATA_CONTAINER));
    SL#c := claim#0;
    assume $local_value_is($s, #tok$1^101.29, #loc.c, $ptr_to_int(SL#c), $spec_ptr_to(^^claim));
    assume $full_stop_ext(#tok$1^101.29, $s);
    assume claim#0 != $no_claim ==> $claim_initial_assumptions($s, claim#0, #tok$1^101.29);
    assert claim#0 != $no_claim ==> $claimed_closed($s, $spec_ptr_cast(G#DataContainer#dt3, ^_DATA_CONTAINER));
    if (claim#0doAdm)
    {
      anon33:
        assume $claimed_closed(claim#0s1, $spec_ptr_cast(G#DataContainer#dt3, ^_DATA_CONTAINER));
        assume $valid_claim_impl(claim#0s0, claim#0s2);
        assume $claim_transitivity_assumptions(claim#0s1, claim#0s2, claim#0, #tok$1^101.29);
        assert $claimed_closed(claim#0s2, $spec_ptr_cast(G#DataContainer#dt3, ^_DATA_CONTAINER));
        assume false;
    }

  anon35:
    assume claim#0 != $no_claim ==> (forall #cs3: $state :: { $valid_claim(#cs3, claim#0) } $valid_claim(#cs3, claim#0) ==> $claimed_closed(#cs3, $spec_ptr_cast(G#DataContainer#dt3, ^_DATA_CONTAINER)));
    // stmt testit(c); 
    call testit($spec_ptr_cast(SL#c, ^^claim));
    assume $full_stop_ext(#tok$1^102.3, $s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



const unique l#public: $label;

const unique #tok$1^102.3: $token;

const unique #tok$1^101.29: $token;

const unique #tok$1^99.19: $token;

const unique #loc.owns#19: $token;

const unique #loc.staticWrapState#18: $token;

const unique #loc.prestate#20: $token;

const unique #tok$1^98.25: $token;

const unique #tok$1^97.3: $token;

const unique #tok$1^96.19: $token;

const unique #loc.owns#16: $token;

const unique #loc.staticWrapState#15: $token;

const unique #loc.prestate#17: $token;

const unique #tok$1^95.3: $token;

const unique #tok$1^94.3: $token;

const unique #tok$1^92.25: $token;

const unique #tok$1^88.1: $token;

const unique #tok$1^85.3: $token;

const unique #loc.owns#13: $token;

const unique #loc.staticWrapState#12: $token;

const unique #loc.prestate#14: $token;

const unique #tok$1^83.7: $token;

const unique #tok$1^82.7: $token;

const unique #tok$1^81.32: $token;

const unique #loc.prestate#11: $token;

const unique #loc.prestate#9: $token;

const unique #loc.owns#10: $token;

const unique #tok$1^80.3: $token;

const unique #tok$1^77.1: $token;

const unique #tok$1^54.19: $token;

const unique #tok$1^56.5: $token;

const unique #tok$1^55.27: $token;

const unique #tok$1^48.1: $token;

const unique #loc.ite#6: $token;

const unique #tok$1^45.13: $token;

const unique #tok$1^41.21: $token;

const unique #tok$1^43.61: $token;

const unique #loc.ite#5: $token;

const unique #tok$1^43.33: $token;

const unique #tok$1^42.7: $token;

const unique #tok$1^30.5: $token;

const unique #tok$1^28.5: $token;

const unique #loc.res#4: $token;

const unique #tok$1^42.14: $token;

const unique #loc.Comparand#3: $token;

const unique #tok$1^42.56: $token;

const unique #loc.Exchange#2: $token;

const unique #tok$1^42.53: $token;

const unique #distTp5: $ctype;

axiom #distTp5 == $ptr_to(^^i4);

const unique #loc.Destination#1: $token;

const unique #tok$1^42.41: $token;

const unique #tok$1^40.3: $token;

const unique #loc.stop: $token;

const unique #tok$1^38.3: $token;

const unique #distTp4: $ctype;

axiom #distTp4 == $spec_ptr_to(^^claim);

const unique #loc.c: $token;

const unique #tok$1^34.1: $token;

const unique #tok$1^21.21: $token;

function $state_to_int(x: $state) : int;

function $int_to_state(x: int) : $state;

axiom (forall #x: $state :: #x == $int_to_state($state_to_int(#x)));

const unique #loc.prestate#8: $token;

const unique #tok$2^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(2, #file^?3Cno?20file?3E);

const unique #tok$1^20.27: $token;

const unique #tok$1^19.5: $token;

const unique #tok$1^17.3: $token;

const unique #loc.obj: $token;

const unique #loc.l: $token;

const unique #tok$1^12.1: $token;

const unique #distTp3: $ctype;

axiom #distTp3 == $spec_ptr_to(^_DATA_CONTAINER);

const unique #tok$1^67.50: $token;

const unique #distTp2: $ctype;

axiom #distTp2 == $ptr_to(^_DATA);

const unique #tok$1^60.9: $token;

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^_LOCK);

const unique #loc._this_: $token;

const unique #tok$1^4.67: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CLock.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CLock.c);
