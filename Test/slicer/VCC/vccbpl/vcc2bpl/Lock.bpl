axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^_LOCK: $ctype;

axiom $is_composite(^_LOCK);

axiom $ptr_level(^_LOCK) == 0;

axiom $sizeof(^_LOCK) == 4;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_LOCK) } $inv2(#s1, #s2, #p, ^_LOCK) == ($typed(#s2, #p) && ($mem(#s2, $dot(#p, _LOCK.locked)) == 0 ==> $keeps(#s2, #p, $int_to_ptr($mem(#s2, $dot(#p, _LOCK.protected_obj)))))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^_LOCK, #r), l#public) } $inv_lab(#s2, $ptr(^_LOCK, #r), l#public) == ($typed(#s2, $ptr(^_LOCK, #r)) && ($mem(#s2, $dot($ptr(^_LOCK, #r), _LOCK.locked)) == 0 ==> $keeps(#s2, $ptr(^_LOCK, #r), $int_to_ptr($mem(#s2, $dot($ptr(^_LOCK, #r), _LOCK.protected_obj)))))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^_LOCK, #r)) } $in_full_extent_of(#q, $ptr(^_LOCK, #r)) == (#q == $ptr(^_LOCK, #r) || #q == $dot($ptr(^_LOCK, #r), _LOCK.$owns) || #q == $dot($ptr(^_LOCK, #r), _LOCK.locked) || #q == $dot($ptr(^_LOCK, #r), _LOCK.protected_obj)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_LOCK, #r)) } $in_extent_of(#s, #q, $ptr(^_LOCK, #r)) == $in_struct_extent_of(#q, $ptr(^_LOCK, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_LOCK, #r)) } $typed(#s, $ptr(^_LOCK, #r)) ==> $in_extent_of(#s, #q, $ptr(^_LOCK, #r)) == (#q == $ptr(^_LOCK, #r) || $emb(#s, #q) == $ptr(^_LOCK, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^_LOCK, #r)) } $in_span_of(#q, $ptr(^_LOCK, #r)) == (#q == $ptr(^_LOCK, #r) || #q == $dot($ptr(^_LOCK, #r), _LOCK.$owns) || #q == $dot($ptr(^_LOCK, #r), _LOCK.locked) || #q == $dot($ptr(^_LOCK, #r), _LOCK.protected_obj)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^_LOCK) } $state_spans_the_same(#s1, #s2, #p, ^_LOCK) == ($mem_eq(#s1, #s2, $dot(#p, _LOCK.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _LOCK.locked)) && $mem_eq(#s1, #s2, $dot(#p, _LOCK.protected_obj))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_LOCK) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_LOCK) == $mem_eq(#s1, #s2, $dot(#p, _LOCK.protected_obj)));

axiom $is_claimable(^_LOCK) == true;

axiom $has_volatile_owns_set(^_LOCK) == true;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^_LOCK, #r)) } $extent_mutable(#s1, $ptr(^_LOCK, #r)) == $mutable(#s1, $ptr(^_LOCK, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^_LOCK, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^_LOCK, #r)) == $is_fresh(#s1, #s2, $ptr(^_LOCK, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^_LOCK, #r)) } $extent_zero(#s1, $ptr(^_LOCK, #r)) == ($mem(#s1, $dot($ptr(^_LOCK, #r), _LOCK.locked)) == 0 && $mem(#s1, $dot($ptr(^_LOCK, #r), _LOCK.protected_obj)) == 0));

const unique _LOCK.$owns: $field;

axiom $static_field_properties(_LOCK.$owns, ^_LOCK);

axiom $is_primitive_volatile_field(_LOCK.$owns);

axiom (forall #p: $ptr :: { $dot(#p, _LOCK.$owns) } $is(#p, ^_LOCK) ==> $dot(#p, _LOCK.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, _LOCK.$owns)) && $extent_hint($dot(#p, _LOCK.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _LOCK.$owns)) } { $st(#s, $dot(#p, _LOCK.$owns)) } $typed2(#s, #p, ^_LOCK) ==> $field_properties(#s, #p, _LOCK.$owns, ^$#ptrset, true));

axiom $owns_set_field(^_LOCK) == _LOCK.$owns;

const unique _LOCK.locked: $field;

axiom $static_field_properties(_LOCK.locked, ^_LOCK);

axiom $is_primitive_volatile_field(_LOCK.locked);

axiom $field_offset(_LOCK.locked) == 0;

axiom (forall #p: $ptr :: { $dot(#p, _LOCK.locked) } $is(#p, ^_LOCK) ==> $dot(#p, _LOCK.locked) == $ptr(^^i4, $ref(#p) + 0) && $extent_hint($dot(#p, _LOCK.locked), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _LOCK.locked)) } { $st(#s, $dot(#p, _LOCK.locked)) } $typed2(#s, #p, ^_LOCK) ==> $field_properties(#s, #p, _LOCK.locked, ^^i4, true));

const unique _LOCK.protected_obj: $field;

axiom $static_field_properties(_LOCK.protected_obj, ^_LOCK);

axiom $is_primitive_non_volatile_field(_LOCK.protected_obj);

axiom (forall #p: $ptr :: { $dot(#p, _LOCK.protected_obj) } $is(#p, ^_LOCK) ==> $dot(#p, _LOCK.protected_obj) == $ptr($ptr_to(^^void), $ghost_ref(#p, _LOCK.protected_obj)) && $extent_hint($dot(#p, _LOCK.protected_obj), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _LOCK.protected_obj)) } { $st(#s, $dot(#p, _LOCK.protected_obj)) } $typed2(#s, #p, ^_LOCK) ==> $field_properties(#s, #p, _LOCK.protected_obj, $ptr_to(^^void), false));

procedure _LOCK#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $mem($s, $dot($ptr(^_LOCK, P#_this_), _LOCK.locked)) == 0 ==> $keeps($s, $ptr(^_LOCK, P#_this_), $int_to_ptr($mem($s, $dot($ptr(^_LOCK, P#_this_), _LOCK.protected_obj))));
  ensures $is_unwrap_check() ==> $mem($s, $dot($ptr(^_LOCK, P#_this_), _LOCK.locked)) == 0 ==> $keeps($s, $ptr(^_LOCK, P#_this_), $int_to_ptr($mem($s, $dot($ptr(^_LOCK, P#_this_), _LOCK.protected_obj))));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _LOCK#adm(P#_this_: int)
{
  var #wrTime$1^4.67: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^4.67, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^4.67, #loc._this_, $ptr_to_int($ptr(^_LOCK, P#_this_)), $ptr_to(^_LOCK)) && $local_value_is_ptr($s, #tok$1^4.67, #loc._this_, $ptr(^_LOCK, P#_this_), $ptr_to(^_LOCK));
    assume #wrTime$1^4.67 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^4.67, #p) } $in_writes_at(#wrTime$1^4.67, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^_LOCK, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^_LOCK, P#_this_));
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
            assume $admissibility_pre($s, $ptr(^_LOCK, P#_this_));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^_LOCK, P#_this_));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct _LOCK*)@null))
        call $havoc_others($ptr(^_LOCK, P#_this_), ^_LOCK);
        assume $good_state_ext(#tok$1^4.67, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^_LOCK, P#_this_), ^_LOCK);
    }

  #exit:
}



const unique ^_DATA: $ctype;

axiom $is_composite(^_DATA);

axiom $ptr_level(^_DATA) == 0;

axiom $sizeof(^_DATA) == 8;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_DATA) } $inv2(#s1, #s2, #p, ^_DATA) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty()) && $mem(#s2, $dot(#p, _DATA.a)) + $mem(#s2, $dot(#p, _DATA.b)) > 0));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^_DATA, #r), l#public) } $inv_lab(#s2, $ptr(^_DATA, #r), l#public) == ($typed(#s2, $ptr(^_DATA, #r)) && $set_eq($owns(#s2, $ptr(^_DATA, #r)), $set_empty()) && $mem(#s2, $dot($ptr(^_DATA, #r), _DATA.a)) + $mem(#s2, $dot($ptr(^_DATA, #r), _DATA.b)) > 0));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^_DATA, #r)) } $in_full_extent_of(#q, $ptr(^_DATA, #r)) == (#q == $ptr(^_DATA, #r) || #q == $dot($ptr(^_DATA, #r), _DATA.$owns) || #q == $dot($ptr(^_DATA, #r), _DATA.a) || #q == $dot($ptr(^_DATA, #r), _DATA.b)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_DATA, #r)) } $in_extent_of(#s, #q, $ptr(^_DATA, #r)) == $in_struct_extent_of(#q, $ptr(^_DATA, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_DATA, #r)) } $typed(#s, $ptr(^_DATA, #r)) ==> $in_extent_of(#s, #q, $ptr(^_DATA, #r)) == (#q == $ptr(^_DATA, #r) || $emb(#s, #q) == $ptr(^_DATA, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^_DATA, #r)) } $in_span_of(#q, $ptr(^_DATA, #r)) == (#q == $ptr(^_DATA, #r) || #q == $dot($ptr(^_DATA, #r), _DATA.$owns) || #q == $dot($ptr(^_DATA, #r), _DATA.a) || #q == $dot($ptr(^_DATA, #r), _DATA.b)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^_DATA) } $state_spans_the_same(#s1, #s2, #p, ^_DATA) == ($mem_eq(#s1, #s2, $dot(#p, _DATA.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _DATA.a)) && $mem_eq(#s1, #s2, $dot(#p, _DATA.b))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_DATA) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_DATA) == ($mem_eq(#s1, #s2, $dot(#p, _DATA.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _DATA.a)) && $mem_eq(#s1, #s2, $dot(#p, _DATA.b))));

axiom $is_claimable(^_DATA) == false;

axiom $has_volatile_owns_set(^_DATA) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^_DATA, #r)) } $extent_mutable(#s1, $ptr(^_DATA, #r)) == $mutable(#s1, $ptr(^_DATA, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^_DATA, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^_DATA, #r)) == $is_fresh(#s1, #s2, $ptr(^_DATA, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^_DATA, #r)) } $extent_zero(#s1, $ptr(^_DATA, #r)) == ($mem(#s1, $dot($ptr(^_DATA, #r), _DATA.a)) == 0 && $mem(#s1, $dot($ptr(^_DATA, #r), _DATA.b)) == 0));

const unique _DATA.$owns: $field;

axiom $static_field_properties(_DATA.$owns, ^_DATA);

axiom $is_primitive_non_volatile_field(_DATA.$owns);

axiom (forall #p: $ptr :: { $dot(#p, _DATA.$owns) } $is(#p, ^_DATA) ==> $dot(#p, _DATA.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, _DATA.$owns)) && $extent_hint($dot(#p, _DATA.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _DATA.$owns)) } { $st(#s, $dot(#p, _DATA.$owns)) } $typed2(#s, #p, ^_DATA) ==> $field_properties(#s, #p, _DATA.$owns, ^$#ptrset, false));

axiom $owns_set_field(^_DATA) == _DATA.$owns;

const unique _DATA.a: $field;

axiom $static_field_properties(_DATA.a, ^_DATA);

axiom $is_primitive_non_volatile_field(_DATA.a);

axiom $field_offset(_DATA.a) == 0;

axiom (forall #p: $ptr :: { $dot(#p, _DATA.a) } $is(#p, ^_DATA) ==> $dot(#p, _DATA.a) == $ptr(^^i4, $ref(#p) + 0) && $extent_hint($dot(#p, _DATA.a), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _DATA.a)) } { $st(#s, $dot(#p, _DATA.a)) } $typed2(#s, #p, ^_DATA) ==> $field_properties(#s, #p, _DATA.a, ^^i4, false));

const unique _DATA.b: $field;

axiom $static_field_properties(_DATA.b, ^_DATA);

axiom $is_primitive_non_volatile_field(_DATA.b);

axiom $field_offset(_DATA.b) == 4;

axiom (forall #p: $ptr :: { $dot(#p, _DATA.b) } $is(#p, ^_DATA) ==> $dot(#p, _DATA.b) == $ptr(^^i4, $ref(#p) + 4) && $extent_hint($dot(#p, _DATA.b), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _DATA.b)) } { $st(#s, $dot(#p, _DATA.b)) } $typed2(#s, #p, ^_DATA) ==> $field_properties(#s, #p, _DATA.b, ^^i4, false));

procedure _DATA#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $set_eq($owns($s, $ptr(^_DATA, P#_this_)), $set_empty());
  ensures $is_admissibility_check() ==> $mem($s, $dot($ptr(^_DATA, P#_this_), _DATA.a)) + $mem($s, $dot($ptr(^_DATA, P#_this_), _DATA.b)) > 0;
  ensures $is_unwrap_check() ==> $set_eq($owns($s, $ptr(^_DATA, P#_this_)), $set_empty());
  ensures $is_unwrap_check() ==> $mem($s, $dot($ptr(^_DATA, P#_this_), _DATA.a)) + $mem($s, $dot($ptr(^_DATA, P#_this_), _DATA.b)) > 0;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _DATA#adm(P#_this_: int)
{
  var #wrTime$1^60.9: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^60.9, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^60.9, #loc._this_, $ptr_to_int($ptr(^_DATA, P#_this_)), $ptr_to(^_DATA)) && $local_value_is_ptr($s, #tok$1^60.9, #loc._this_, $ptr(^_DATA, P#_this_), $ptr_to(^_DATA));
    assume #wrTime$1^60.9 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^60.9, #p) } $in_writes_at(#wrTime$1^60.9, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon7:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^_DATA, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^_DATA, P#_this_));
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
            assume $admissibility_pre($s, $ptr(^_DATA, P#_this_));
        }
        else
        {
          anon9:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^_DATA, P#_this_));
        }

      anon11:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct _DATA*)@null))
        call $havoc_others($ptr(^_DATA, P#_this_), ^_DATA);
        assume $good_state_ext(#tok$1^60.9, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^_DATA, P#_this_), ^_DATA);
    }

  #exit:
}



const unique ^_DATA_CONTAINER: $ctype;

axiom $is_composite(^_DATA_CONTAINER);

axiom $ptr_level(^_DATA_CONTAINER) == 0;

axiom $sizeof(^_DATA_CONTAINER) == 1;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_DATA_CONTAINER) } $inv2(#s1, #s2, #p, ^_DATA_CONTAINER) == ($typed(#s2, #p) && $ptr(^_LOCK, G#DataLock#dt2) == $ptr(^_LOCK, G#DataLock#dt2) && $keeps(#s2, #p, $ptr(^_LOCK, G#DataLock#dt2)) && $int_to_ptr($mem(#s2, $dot($ptr(^_LOCK, G#DataLock#dt2), _LOCK.protected_obj))) == $ptr(^_DATA, G#Data#dt3)));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^_DATA_CONTAINER, #r), l#public) } $inv_lab(#s2, $ptr(^_DATA_CONTAINER, #r), l#public) == ($typed(#s2, $ptr(^_DATA_CONTAINER, #r)) && $keeps(#s2, $ptr(^_DATA_CONTAINER, #r), $ptr(^_LOCK, G#DataLock#dt2)) && $int_to_ptr($mem(#s2, $dot($ptr(^_LOCK, G#DataLock#dt2), _LOCK.protected_obj))) == $ptr(^_DATA, G#Data#dt3)));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^_DATA_CONTAINER, #r)) } $in_full_extent_of(#q, $ptr(^_DATA_CONTAINER, #r)) == (#q == $ptr(^_DATA_CONTAINER, #r) || #q == $dot($ptr(^_DATA_CONTAINER, #r), _DATA_CONTAINER.$owns) || #q == $dot($ptr(^_DATA_CONTAINER, #r), _DATA_CONTAINER.dummy)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_DATA_CONTAINER, #r)) } $in_extent_of(#s, #q, $ptr(^_DATA_CONTAINER, #r)) == $in_struct_extent_of(#q, $ptr(^_DATA_CONTAINER, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_DATA_CONTAINER, #r)) } $typed(#s, $ptr(^_DATA_CONTAINER, #r)) ==> $in_extent_of(#s, #q, $ptr(^_DATA_CONTAINER, #r)) == (#q == $ptr(^_DATA_CONTAINER, #r) || $emb(#s, #q) == $ptr(^_DATA_CONTAINER, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^_DATA_CONTAINER, #r)) } $in_span_of(#q, $ptr(^_DATA_CONTAINER, #r)) == (#q == $ptr(^_DATA_CONTAINER, #r) || #q == $dot($ptr(^_DATA_CONTAINER, #r), _DATA_CONTAINER.$owns) || #q == $dot($ptr(^_DATA_CONTAINER, #r), _DATA_CONTAINER.dummy)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^_DATA_CONTAINER) } $state_spans_the_same(#s1, #s2, #p, ^_DATA_CONTAINER) == ($mem_eq(#s1, #s2, $dot(#p, _DATA_CONTAINER.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _DATA_CONTAINER.dummy))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_DATA_CONTAINER) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_DATA_CONTAINER) == ($mem_eq(#s1, #s2, $dot(#p, _DATA_CONTAINER.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _DATA_CONTAINER.dummy))));

axiom $is_claimable(^_DATA_CONTAINER) == true;

axiom $has_volatile_owns_set(^_DATA_CONTAINER) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^_DATA_CONTAINER, #r)) } $extent_mutable(#s1, $ptr(^_DATA_CONTAINER, #r)) == $mutable(#s1, $ptr(^_DATA_CONTAINER, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^_DATA_CONTAINER, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^_DATA_CONTAINER, #r)) == $is_fresh(#s1, #s2, $ptr(^_DATA_CONTAINER, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^_DATA_CONTAINER, #r)) } $extent_zero(#s1, $ptr(^_DATA_CONTAINER, #r)) == ($mem(#s1, $dot($ptr(^_DATA_CONTAINER, #r), _DATA_CONTAINER.dummy)) == 0));

const unique _DATA_CONTAINER.$owns: $field;

axiom $static_field_properties(_DATA_CONTAINER.$owns, ^_DATA_CONTAINER);

axiom $is_primitive_non_volatile_field(_DATA_CONTAINER.$owns);

axiom (forall #p: $ptr :: { $dot(#p, _DATA_CONTAINER.$owns) } $is(#p, ^_DATA_CONTAINER) ==> $dot(#p, _DATA_CONTAINER.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, _DATA_CONTAINER.$owns)) && $extent_hint($dot(#p, _DATA_CONTAINER.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _DATA_CONTAINER.$owns)) } { $st(#s, $dot(#p, _DATA_CONTAINER.$owns)) } $typed2(#s, #p, ^_DATA_CONTAINER) ==> $field_properties(#s, #p, _DATA_CONTAINER.$owns, ^$#ptrset, false));

axiom $owns_set_field(^_DATA_CONTAINER) == _DATA_CONTAINER.$owns;

const unique _DATA_CONTAINER.dummy: $field;

axiom $static_field_properties(_DATA_CONTAINER.dummy, ^_DATA_CONTAINER);

axiom $is_primitive_non_volatile_field(_DATA_CONTAINER.dummy);

axiom (forall #p: $ptr :: { $dot(#p, _DATA_CONTAINER.dummy) } $is(#p, ^_DATA_CONTAINER) ==> $dot(#p, _DATA_CONTAINER.dummy) == $ptr(^^i4, $ghost_ref(#p, _DATA_CONTAINER.dummy)) && $extent_hint($dot(#p, _DATA_CONTAINER.dummy), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _DATA_CONTAINER.dummy)) } { $st(#s, $dot(#p, _DATA_CONTAINER.dummy)) } $typed2(#s, #p, ^_DATA_CONTAINER) ==> $field_properties(#s, #p, _DATA_CONTAINER.dummy, ^^i4, false));

procedure _DATA_CONTAINER#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $ptr(^_LOCK, G#DataLock#dt2) == $ptr(^_LOCK, G#DataLock#dt2);
  ensures $is_admissibility_check() ==> $keeps($s, $ptr(^_DATA_CONTAINER, P#_this_), $ptr(^_LOCK, G#DataLock#dt2));
  ensures $is_admissibility_check() ==> $int_to_ptr($mem($s, $dot($ptr(^_LOCK, G#DataLock#dt2), _LOCK.protected_obj))) == $ptr(^_DATA, G#Data#dt3);
  ensures $is_stuttering_check() ==> $ptr(^_LOCK, G#DataLock#dt2) == $ptr(^_LOCK, G#DataLock#dt2);
  ensures $is_unwrap_check() ==> $ptr(^_LOCK, G#DataLock#dt2) == $ptr(^_LOCK, G#DataLock#dt2);
  ensures $is_unwrap_check() ==> $keeps($s, $ptr(^_DATA_CONTAINER, P#_this_), $ptr(^_LOCK, G#DataLock#dt2));
  ensures $is_unwrap_check() ==> $int_to_ptr($mem($s, $dot($ptr(^_LOCK, G#DataLock#dt2), _LOCK.protected_obj))) == $ptr(^_DATA, G#Data#dt3);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _DATA_CONTAINER#adm(P#_this_: int)
{
  var #wrTime$1^67.50: int;
  var #stackframe: int;

  anon18:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^67.50, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^67.50, #loc._this_, $ptr_to_int($ptr(^_DATA_CONTAINER, P#_this_)), $spec_ptr_to(^_DATA_CONTAINER)) && $local_value_is_ptr($s, #tok$1^67.50, #loc._this_, $ptr(^_DATA_CONTAINER, P#_this_), $spec_ptr_to(^_DATA_CONTAINER));
    assume #wrTime$1^67.50 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^67.50, #p) } $in_writes_at(#wrTime$1^67.50, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon13:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^_DATA_CONTAINER, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^_DATA_CONTAINER, P#_this_));
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
            assume $admissibility_pre($s, $ptr(^_DATA_CONTAINER, P#_this_));
        }
        else
        {
          anon15:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^_DATA_CONTAINER, P#_this_));
        }

      anon17:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct _DATA_CONTAINER*)@null))
        call $havoc_others($ptr(^_DATA_CONTAINER, P#_this_), ^_DATA_CONTAINER);
        assume $good_state_ext(#tok$1^67.50, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^_DATA_CONTAINER, P#_this_), ^_DATA_CONTAINER);
    }

  #exit:
}



procedure InitializeLock(P#l: int, SP#obj: $ptr);
  requires $wrapped($s, SP#obj, $typ(SP#obj));
  modifies $s, $cev_pc;
  ensures $wrapped($s, $ptr(^_LOCK, P#l), ^_LOCK) && $int_to_ptr($mem($s, $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj))) == SP#obj;
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $span($ptr(^_LOCK, P#l))) || #p == SP#obj || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $span($ptr(^_LOCK, P#l))) || #p == SP#obj || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $span($ptr(^_LOCK, P#l))) || #p == SP#obj || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation InitializeLock(P#l: int, SP#obj: $ptr)
{
  var prestate#8: $state;
  var #wrTime$1^12.1: int;
  var #stackframe: int;

  anon19:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^12.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^12.1, #loc.l, $ptr_to_int($ptr(^_LOCK, P#l)), $ptr_to(^_LOCK)) && $local_value_is_ptr($s, #tok$1^12.1, #loc.l, $ptr(^_LOCK, P#l), $ptr_to(^_LOCK));
    assume $local_value_is($s, #tok$1^12.1, #loc.obj, $ptr_to_int(SP#obj), $ptr_to(^^void));
    assume #wrTime$1^12.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^12.1, #p) } $in_writes_at(#wrTime$1^12.1, #p) == ($set_in(#p, $span($ptr(^_LOCK, P#l))) || #p == SP#obj));
    assume (forall #p: $ptr :: { $extent_hint(#p, $ptr(^_LOCK, P#l)) } $set_in(#p, $span($ptr(^_LOCK, P#l))) ==> $mutable($s, #p));
    assume $thread_owned_or_even_mutable($s, SP#obj);
    // assume @in_range_phys_ptr((mathint)l); 
    assume $in_range_phys_ptr($ref($ptr(^_LOCK, P#l)));
    // assert @_vcc_in_domain(@state, obj, obj); 
    assert $in_domain_lab($s, SP#obj, SP#obj, l#public);
    // assert @_vcc_typed2(@state, (l->locked)); 
    assert $typed2($s, $dot($ptr(^_LOCK, P#l), _LOCK.locked), ^^i4);
    // assert @prim_writes_check((l->locked)); 
    assert $writable($s, #wrTime$1^12.1, $dot($ptr(^_LOCK, P#l), _LOCK.locked));
    // *(l->locked) := 0; 
    call $write_int($dot($ptr(^_LOCK, P#l), _LOCK.locked), 0);
    assume $full_stop_ext(#tok$1^17.3, $s);
    // assert @_vcc_typed2(@state, (l->protected_obj)); 
    assert $typed2($s, $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj), $ptr_to(^^void));
    // assert @prim_writes_check((l->protected_obj)); 
    assert $writable($s, #wrTime$1^12.1, $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj));
    // *(l->protected_obj) := obj; 
    call $write_int($dot($ptr(^_LOCK, P#l), _LOCK.protected_obj), $ptr_to_int(SP#obj));
    assume $full_stop_ext(#tok$1^19.5, $s);
    // assert @writes_check(@_vcc_span(l)); 
    assert (forall #writes$1^20.27: $ptr :: { $dont_instantiate(#writes$1^20.27) } $set_in(#writes$1^20.27, $span($ptr(^_LOCK, P#l))) ==> $top_writable($s, #wrTime$1^12.1, #writes$1^20.27));
    // stmt _vcc_set_owns(l, @_vcc_set_singleton(obj)); 
    call $set_owns($ptr(^_LOCK, P#l), $set_singleton(SP#obj));
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
    assert $top_writable($s, #wrTime$1^12.1, $ptr(^_LOCK, P#l));
    // assert @writes_check(@_vcc_owns(@state, l)); 
    assert (forall #writes$1^21.21: $ptr :: { $dont_instantiate(#writes$1^21.21) } $set_in(#writes$1^21.21, $owns($s, $ptr(^_LOCK, P#l))) ==> $top_writable($s, #wrTime$1^12.1, #writes$1^21.21));
    // stmt @_vcc_wrap(l, @_vcc_typeof(l)); 
    call $wrap($ptr(^_LOCK, P#l), ^_LOCK);
    assume $good_state_ext(#tok$1^21.21, $s);
    // assert @inv_check(==>(==(*((l->locked)), 0), @keeps(l, *((l->protected_obj))))); 
    assert $mem($s, $dot($ptr(^_LOCK, P#l), _LOCK.locked)) == 0 ==> $keeps($s, $ptr(^_LOCK, P#l), $int_to_ptr($mem($s, $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure Acquire(P#l: int, SP#c: int);
  requires true;
  requires $wrapped($s, $ptr(^^claim, SP#c), ^^claim);
  requires $valid_claim($s, $ptr(^^claim, SP#c));
  requires (forall #cs0: $state :: { $valid_claim(#cs0, $ptr(^^claim, SP#c)) } $valid_claim(#cs0, $ptr(^^claim, SP#c)) ==> $claimed_closed(#cs0, $ptr(^_LOCK, P#l)));
  modifies $s, $cev_pc;
  ensures $wrapped($s, $int_to_ptr($mem($s, $by_claim($s, $ptr(^^claim, SP#c), $ptr(^_LOCK, P#l), $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj)))), $typ($int_to_ptr($mem($s, $by_claim($s, $ptr(^^claim, SP#c), $ptr(^_LOCK, P#l), $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj)))))) && $is_fresh(old($s), $s, $int_to_ptr($mem($s, $by_claim($s, $ptr(^^claim, SP#c), $ptr(^_LOCK, P#l), $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj)))));
  ensures $wrapped($s, $ptr(^^claim, SP#c), ^^claim) && $valid_claim($s, $ptr(^^claim, SP#c));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Acquire(P#l: int, SP#c: int)
{
  var ite#6: bool;
  var ite#5: bool;
  var res#4: int where $in_range_i4(res#4);
  var Comparand#3: int where $in_range_i4(Comparand#3);
  var Exchange#2: int where $in_range_i4(Exchange#2);
  var Destination#1: int where $in_range_phys_ptr(Destination#1);
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
    assume $local_value_is($s, #tok$1^34.1, #loc.l, $ptr_to_int($ptr(^_LOCK, P#l)), $ptr_to(^_LOCK)) && $local_value_is_ptr($s, #tok$1^34.1, #loc.l, $ptr(^_LOCK, P#l), $ptr_to(^_LOCK));
    assume $local_value_is($s, #tok$1^34.1, #loc.c, $ptr_to_int($ptr(^^claim, SP#c)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^34.1, #loc.c, $ptr(^^claim, SP#c), $spec_ptr_to(^^claim));
    assume #wrTime$1^34.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^34.1, #p) } $in_writes_at(#wrTime$1^34.1, #p) == false);
    // assume @in_range_phys_ptr((mathint)l); 
    assume $in_range_phys_ptr($ref($ptr(^_LOCK, P#l)));
    // assume @in_range_spec_ptr((mathint)c); 
    assume $in_range_spec_ptr($ref($ptr(^^claim, SP#c)));
    // assert @_vcc_valid_claim(@state, c); 
    assert $valid_claim($s, $ptr(^^claim, SP#c));
    // assert @_vcc_in_domain(@state, c, c); 
    assert $in_domain_lab($s, $ptr(^^claim, SP#c), $ptr(^^claim, SP#c), l#public);
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
        assume $local_value_is($s, #tok$1^40.3, #loc.c, $ptr_to_int($ptr(^^claim, SP#c)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^40.3, #loc.c, $ptr(^^claim, SP#c), $spec_ptr_to(^^claim));
        // assume @_vcc_mutable_increases(old(@prestate, @state), @state); 
        assume $mutable_increases(loopState#0, $s);
        assume true;
        call $atomic_havoc();
        assume $full_stop_ext(#tok$1^41.21, $s);
        atomicObj#21 := $ptr(^_LOCK, P#l);
        assert $valid_claim($s, $ptr(^^claim, SP#c));
        assert $closed($s, atomicObj#21);
        assume $inv($s, atomicObj#21, ^_LOCK);
        beforeAtomicState#1 := $s;
        // int32_t* Destination#1; 
        assume $local_value_is($s, #tok$1^42.41, #loc.Destination#1, $ptr_to_int($ptr(^^i4, Destination#1)), $ptr_to(^^i4)) && $local_value_is_ptr($s, #tok$1^42.41, #loc.Destination#1, $ptr(^^i4, Destination#1), $ptr_to(^^i4));
        // Destination#1 := (l->locked); 
        Destination#1 := $ref($dot($ptr(^_LOCK, P#l), _LOCK.locked));
        assume $local_value_is($s, #tok$1^42.41, #loc.Destination#1, $ptr_to_int($ptr(^^i4, Destination#1)), $ptr_to(^^i4)) && $local_value_is_ptr($s, #tok$1^42.41, #loc.Destination#1, $ptr(^^i4, Destination#1), $ptr_to(^^i4));
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
        assert $typed2($s, $ptr(^^i4, Destination#1), ^^i4);
        assert $thread_local2($s, $ptr(^^i4, Destination#1), ^^i4) || $set_in($ptr(^^i4, Destination#1), $span(atomicObj#21));
        assume true;
        // if (==(*(Destination#1), Comparand#3)) ...
        if ($mem($s, $ptr(^^i4, Destination#1)) == Comparand#3)
        {
          anon20:
            // assert @_vcc_typed2(@state, Destination#1); 
            assert $typed2($s, $ptr(^^i4, Destination#1), ^^i4);
            // assert @prim_writes_check(Destination#1); 
            assert $set_in($ptr(^^i4, Destination#1), $volatile_span($s, atomicObj#21)) || $writable($s, #wrTime$1^34.1, $ptr(^^i4, Destination#1));
            // *Destination#1 := Exchange#2; 
            call $write_int($ptr(^^i4, Destination#1), Exchange#2);
            assume $good_state_ext(#tok$1^42.41, $s);
            // res#4 := Comparand#3; 
            res#4 := Comparand#3;
            assume $local_value_is($s, #tok$1^28.5, #loc.res#4, res#4, ^^i4);
        }
        else
        {
          anon21:
            // assert @reads_check_normal(Destination#1); 
            assert $typed2($s, $ptr(^^i4, Destination#1), ^^i4);
            assert $thread_local2($s, $ptr(^^i4, Destination#1), ^^i4) || $set_in($ptr(^^i4, Destination#1), $span(atomicObj#21));
            // res#4 := *(Destination#1); 
            res#4 := $mem($s, $ptr(^^i4, Destination#1));
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
            assert $ptr(^_LOCK, P#l) == atomicObj#21;
            // assert @reads_check_normal((l->protected_obj)); 
            assert $typed2($s, $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj), $ptr_to(^^void));
            assert $thread_local2($s, $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj), $ptr_to(^^void)) || $ptr(^_LOCK, P#l) == atomicObj#21;
            // stmt _vcc_giveup_closed_owner(*((l->protected_obj)), l); 
            call $giveup_closed_owner($int_to_ptr($mem($s, $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj))), $ptr(^_LOCK, P#l));
            assume $good_state_ext(#tok$1^43.61, $s);
        }
        else
        {
          anon23:
            // empty
        }

      anon27:
        assert $mem($s, $dot(atomicObj#21, _LOCK.locked)) == 0 ==> $keeps($s, atomicObj#21, $int_to_ptr($mem($s, $dot(atomicObj#21, _LOCK.protected_obj))));
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



procedure Release(P#l: int, SP#c: int);
  requires true;
  requires $int_to_ptr($mem($s, $by_claim($s, $ptr(^^claim, SP#c), $ptr(^_LOCK, P#l), $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj)))) != $ptr(^^claim, SP#c);
  requires $wrapped($s, $int_to_ptr($mem($s, $by_claim($s, $ptr(^^claim, SP#c), $ptr(^_LOCK, P#l), $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj)))), $typ($int_to_ptr($mem($s, $by_claim($s, $ptr(^^claim, SP#c), $ptr(^_LOCK, P#l), $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj))))));
  requires $wrapped($s, $ptr(^^claim, SP#c), ^^claim);
  requires $valid_claim($s, $ptr(^^claim, SP#c));
  requires (forall #cs1: $state :: { $valid_claim(#cs1, $ptr(^^claim, SP#c)) } $valid_claim(#cs1, $ptr(^^claim, SP#c)) ==> $claimed_closed(#cs1, $ptr(^_LOCK, P#l)));
  modifies $s, $cev_pc;
  ensures $wrapped($s, $ptr(^^claim, SP#c), ^^claim) && $valid_claim($s, $ptr(^^claim, SP#c));
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $int_to_ptr($mem(old($s), $by_claim(old($s), $ptr(^^claim, SP#c), $ptr(^_LOCK, P#l), $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj)))) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $int_to_ptr($mem(old($s), $by_claim(old($s), $ptr(^^claim, SP#c), $ptr(^_LOCK, P#l), $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj)))) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $int_to_ptr($mem(old($s), $by_claim(old($s), $ptr(^^claim, SP#c), $ptr(^_LOCK, P#l), $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj)))) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Release(P#l: int, SP#c: int)
{
  var beforeAtomicState#2: $state;
  var atomicObj#22: $ptr;
  var #wrTime$1^48.1: int;
  var #stackframe: int;

  anon31:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^48.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^48.1, #loc.l, $ptr_to_int($ptr(^_LOCK, P#l)), $ptr_to(^_LOCK)) && $local_value_is_ptr($s, #tok$1^48.1, #loc.l, $ptr(^_LOCK, P#l), $ptr_to(^_LOCK));
    assume $local_value_is($s, #tok$1^48.1, #loc.c, $ptr_to_int($ptr(^^claim, SP#c)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^48.1, #loc.c, $ptr(^^claim, SP#c), $spec_ptr_to(^^claim));
    assume #wrTime$1^48.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^48.1, #p) } $in_writes_at(#wrTime$1^48.1, #p) == (#p == $int_to_ptr($mem($s, $by_claim($s, $ptr(^^claim, SP#c), $ptr(^_LOCK, P#l), $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj))))));
    assume $thread_owned_or_even_mutable($s, $int_to_ptr($mem($s, $by_claim($s, $ptr(^^claim, SP#c), $ptr(^_LOCK, P#l), $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj)))));
    // assume @in_range_phys_ptr((mathint)l); 
    assume $in_range_phys_ptr($ref($ptr(^_LOCK, P#l)));
    // assume @in_range_spec_ptr((mathint)c); 
    assume $in_range_spec_ptr($ref($ptr(^^claim, SP#c)));
    // assert @_vcc_valid_claim(@state, c); 
    assert $valid_claim($s, $ptr(^^claim, SP#c));
    // assert @_vcc_in_domain(@state, c, c); 
    assert $in_domain_lab($s, $ptr(^^claim, SP#c), $ptr(^^claim, SP#c), l#public);
    // assert @_vcc_in_domain(@state, @by_claim(c, l, (l->protected_obj)), @by_claim(c, l, (l->protected_obj))); 
    assert $in_domain_lab($s, $int_to_ptr($mem($s, $by_claim($s, $ptr(^^claim, SP#c), $ptr(^_LOCK, P#l), $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj)))), $int_to_ptr($mem($s, $by_claim($s, $ptr(^^claim, SP#c), $ptr(^_LOCK, P#l), $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj)))), l#public);
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^54.19, $s);
    atomicObj#22 := $ptr(^_LOCK, P#l);
    assert $valid_claim($s, $ptr(^^claim, SP#c));
    assert $closed($s, atomicObj#22);
    assume $inv($s, atomicObj#22, ^_LOCK);
    beforeAtomicState#2 := $s;
    // assert @is_atomic_obj(l); 
    assert $ptr(^_LOCK, P#l) == atomicObj#22;
    // assert @writes_check(*((l->protected_obj))); 
    assert $top_writable($s, #wrTime$1^48.1, $int_to_ptr($mem($s, $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj))));
    // assert @reads_check_normal((l->protected_obj)); 
    assert $typed2($s, $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj), $ptr_to(^^void));
    assert $thread_local2($s, $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj), $ptr_to(^^void)) || $ptr(^_LOCK, P#l) == atomicObj#22;
    // stmt _vcc_set_closed_owner(*((l->protected_obj)), l); 
    call $set_closed_owner($int_to_ptr($mem($s, $dot($ptr(^_LOCK, P#l), _LOCK.protected_obj))), $ptr(^_LOCK, P#l));
    assume $good_state_ext(#tok$1^55.27, $s);
    // empty
    // assert @_vcc_typed2(@state, (l->locked)); 
    assert $typed2($s, $dot($ptr(^_LOCK, P#l), _LOCK.locked), ^^i4);
    // assert @prim_writes_check((l->locked)); 
    assert $set_in($dot($ptr(^_LOCK, P#l), _LOCK.locked), $volatile_span($s, atomicObj#22)) || $writable($s, #wrTime$1^48.1, $dot($ptr(^_LOCK, P#l), _LOCK.locked));
    // *(l->locked) := 0; 
    call $write_int($dot($ptr(^_LOCK, P#l), _LOCK.locked), 0);
    assume $good_state_ext(#tok$1^56.5, $s);
    assert $mem($s, $dot(atomicObj#22, _LOCK.locked)) == 0 ==> $keeps($s, atomicObj#22, $int_to_ptr($mem($s, $dot(atomicObj#22, _LOCK.protected_obj))));
    assume $full_stop_ext(#tok$1^54.19, $s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



const unique G#DataLock#dt2: int;

axiom $is_global($ptr(^_LOCK, G#DataLock#dt2), ^_LOCK);

const unique G#Data#dt3: int;

axiom $is_global($ptr(^_DATA, G#Data#dt3), ^_DATA);

procedure testit(SP#c: int);
  requires true;
  requires $wrapped($s, $ptr(^^claim, SP#c), ^^claim);
  requires $valid_claim($s, $ptr(^^claim, SP#c));
  requires (forall #cs2: $state :: { $valid_claim(#cs2, $ptr(^^claim, SP#c)) } $valid_claim(#cs2, $ptr(^^claim, SP#c)) ==> $claimed_closed(#cs2, $ptr(^_DATA_CONTAINER, G#DataContainer#dt4)));
  modifies $s, $cev_pc;
  ensures $wrapped($s, $ptr(^^claim, SP#c), ^^claim) && $valid_claim($s, $ptr(^^claim, SP#c));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation testit(SP#c: int)
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
    assume $local_value_is($s, #tok$1^77.1, #loc.c, $ptr_to_int($ptr(^^claim, SP#c)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^77.1, #loc.c, $ptr(^^claim, SP#c), $spec_ptr_to(^^claim));
    assume #wrTime$1^77.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^77.1, #p) } $in_writes_at(#wrTime$1^77.1, #p) == false);
    // assume @in_range_spec_ptr((mathint)c); 
    assume $in_range_spec_ptr($ref($ptr(^^claim, SP#c)));
    // assert @_vcc_valid_claim(@state, c); 
    assert $valid_claim($s, $ptr(^^claim, SP#c));
    // assert @_vcc_in_domain(@state, c, c); 
    assert $in_domain_lab($s, $ptr(^^claim, SP#c), $ptr(^^claim, SP#c), l#public);
    // stmt Acquire(DataLock, c); 
    call Acquire($ref($ptr(^_LOCK, G#DataLock#dt2)), $ref($ptr(^^claim, SP#c)));
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
    assert $wrapped($s, $ptr(^_DATA, G#Data#dt3), ^_DATA);
    // assert @writes_check(Data); 
    assert $top_writable($s, #wrTime$1^77.1, $ptr(^_DATA, G#Data#dt3));
    // assume @_vcc_inv(@state, Data); 
    assume $inv($s, $ptr(^_DATA, G#Data#dt3), ^_DATA);
    // assume ==(owns#10, @_vcc_owns(@state, Data)); 
    assume owns#10 == $owns($s, $ptr(^_DATA, G#Data#dt3));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(Data), prestate#11)
    call $static_unwrap($ptr(^_DATA, G#Data#dt3), prestate#11);
    assume $good_state_ext(#tok$1^81.32, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_typed2(@state, (Data->a)); 
    assert $typed2($s, $dot($ptr(^_DATA, G#Data#dt3), _DATA.a), ^^i4);
    // assert @prim_writes_check((Data->a)); 
    assert $writable($s, #wrTime$1^77.1, $dot($ptr(^_DATA, G#Data#dt3), _DATA.a));
    // *(Data->a) := 5; 
    call $write_int($dot($ptr(^_DATA, G#Data#dt3), _DATA.a), 5);
    assume $full_stop_ext(#tok$1^82.7, $s);
    // assert @_vcc_typed2(@state, (Data->b)); 
    assert $typed2($s, $dot($ptr(^_DATA, G#Data#dt3), _DATA.b), ^^i4);
    // assert @prim_writes_check((Data->b)); 
    assert $writable($s, #wrTime$1^77.1, $dot($ptr(^_DATA, G#Data#dt3), _DATA.b));
    // *(Data->b) := 7; 
    call $write_int($dot($ptr(^_DATA, G#Data#dt3), _DATA.b), 7);
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
    assert $top_writable($s, #wrTime$1^77.1, $ptr(^_DATA, G#Data#dt3));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(Data), staticWrapState#12, owns#13)
    call $static_wrap($ptr(^_DATA, G#Data#dt3), staticWrapState#12, owns#13);
    assume $good_state_ext(#tok$1^81.32, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, Data), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^_DATA, G#Data#dt3)), $set_empty());
    // assert @inv_check(>(+(*((Data->a)), *((Data->b))), 0)); 
    assert $mem($s, $dot($ptr(^_DATA, G#Data#dt3), _DATA.a)) + $mem($s, $dot($ptr(^_DATA, G#Data#dt3), _DATA.b)) > 0;
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @writes_check(@by_claim(c, DataLock, (DataLock->protected_obj))); 
    assert $top_writable($s, #wrTime$1^77.1, $int_to_ptr($mem($s, $by_claim($s, $ptr(^^claim, SP#c), $ptr(^_LOCK, G#DataLock#dt2), $dot($ptr(^_LOCK, G#DataLock#dt2), _LOCK.protected_obj)))));
    // stmt Release(DataLock, c); 
    call Release($ref($ptr(^_LOCK, G#DataLock#dt2)), $ref($ptr(^^claim, SP#c)));
    assume $full_stop_ext(#tok$1^85.3, $s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



const unique G#DataContainer#dt4: int;

axiom $is_global($ptr(^_DATA_CONTAINER, G#DataContainer#dt4), ^_DATA_CONTAINER);

procedure boot();
  requires $program_entry_point($s);
  modifies $s, $cev_pc;
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $set_universe()) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $set_universe()) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $set_universe()) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
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
  var SL#c: int where $in_range_spec_ptr(SL#c);
  var #wrTime$1^88.1: int;
  var #stackframe: int;

  anon34:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^88.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^88.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^88.1, #p) } $in_writes_at(#wrTime$1^88.1, #p) == $set_in(#p, $set_universe()));
    assume true;
    // claim_t^ c; 
    assume $local_value_is($s, #tok$1^92.25, #loc.c, $ptr_to_int($ptr(^^claim, SL#c)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^92.25, #loc.c, $ptr(^^claim, SL#c), $spec_ptr_to(^^claim));
    // var spec claim_t^ c
    // assert @_vcc_typed2(@state, (Data->a)); 
    assert $typed2($s, $dot($ptr(^_DATA, G#Data#dt3), _DATA.a), ^^i4);
    // assert @prim_writes_check((Data->a)); 
    assert $writable($s, #wrTime$1^88.1, $dot($ptr(^_DATA, G#Data#dt3), _DATA.a));
    // *(Data->a) := 42; 
    call $write_int($dot($ptr(^_DATA, G#Data#dt3), _DATA.a), 42);
    assume $full_stop_ext(#tok$1^94.3, $s);
    // assert @_vcc_typed2(@state, (Data->b)); 
    assert $typed2($s, $dot($ptr(^_DATA, G#Data#dt3), _DATA.b), ^^i4);
    // assert @prim_writes_check((Data->b)); 
    assert $writable($s, #wrTime$1^88.1, $dot($ptr(^_DATA, G#Data#dt3), _DATA.b));
    // *(Data->b) := 17; 
    call $write_int($dot($ptr(^_DATA, G#Data#dt3), _DATA.b), 17);
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
    assert $top_writable($s, #wrTime$1^88.1, $ptr(^_DATA, G#Data#dt3));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(Data), staticWrapState#15, owns#16)
    call $static_wrap($ptr(^_DATA, G#Data#dt3), staticWrapState#15, owns#16);
    assume $good_state_ext(#tok$1^96.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, Data), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^_DATA, G#Data#dt3)), $set_empty());
    // assert @inv_check(>(+(*((Data->a)), *((Data->b))), 0)); 
    assert $mem($s, $dot($ptr(^_DATA, G#Data#dt3), _DATA.a)) + $mem($s, $dot($ptr(^_DATA, G#Data#dt3), _DATA.b)) > 0;
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @writes_check(@_vcc_span(DataLock)); 
    assert (forall #writes$1^97.3: $ptr :: { $dont_instantiate(#writes$1^97.3) } $set_in(#writes$1^97.3, $span($ptr(^_LOCK, G#DataLock#dt2))) ==> $top_writable($s, #wrTime$1^88.1, #writes$1^97.3));
    // assert @writes_check(Data); 
    assert $top_writable($s, #wrTime$1^88.1, $ptr(^_DATA, G#Data#dt3));
    // stmt InitializeLock(DataLock, Data); 
    call InitializeLock($ref($ptr(^_LOCK, G#DataLock#dt2)), $ptr(^_DATA, G#Data#dt3));
    assume $full_stop_ext(#tok$1^97.3, $s);
    // assert @writes_check(@_vcc_span(DataContainer)); 
    assert (forall #writes$1^98.25: $ptr :: { $dont_instantiate(#writes$1^98.25) } $set_in(#writes$1^98.25, $span($ptr(^_DATA_CONTAINER, G#DataContainer#dt4))) ==> $top_writable($s, #wrTime$1^88.1, #writes$1^98.25));
    // stmt _vcc_set_owns(DataContainer, @_vcc_set_add_element(@_vcc_owns(@state, DataContainer), DataLock)); 
    call $set_owns($ptr(^_DATA_CONTAINER, G#DataContainer#dt4), $set_add_element($owns($s, $ptr(^_DATA_CONTAINER, G#DataContainer#dt4)), $ptr(^_LOCK, G#DataLock#dt2)));
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
    assert $top_writable($s, #wrTime$1^88.1, $ptr(^_DATA_CONTAINER, G#DataContainer#dt4));
    // assert @_vcc_wrapped(@state, DataLock); 
    assert $wrapped($s, $ptr(^_LOCK, G#DataLock#dt2), ^_LOCK);
    // assert @writes_check(DataLock); 
    assert $top_writable($s, #wrTime$1^88.1, $ptr(^_LOCK, G#DataLock#dt2));
    // owns#19 := pure(@_vcc_set_union(owns#19, @_vcc_set_singleton(DataLock))); 
    owns#19 := $set_union(owns#19, $set_singleton($ptr(^_LOCK, G#DataLock#dt2)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#19, $ptrset_to_int(owns#19), ^$#ptrset);
    // staticWrapState#18 := pure(@_vcc_take_over(staticWrapState#18, DataContainer, DataLock)); 
    staticWrapState#18 := $take_over(staticWrapState#18, $ptr(^_DATA_CONTAINER, G#DataContainer#dt4), $ptr(^_LOCK, G#DataLock#dt2));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#18, $state_to_int(staticWrapState#18), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(DataContainer), staticWrapState#18, owns#19)
    call $static_wrap($ptr(^_DATA_CONTAINER, G#DataContainer#dt4), staticWrapState#18, owns#19);
    assume $good_state_ext(#tok$1^99.19, $s);
    // assert @inv_check(@keeps_stable(old(prestate#20, DataLock), DataLock)); 
    assert $ptr(^_LOCK, G#DataLock#dt2) == $ptr(^_LOCK, G#DataLock#dt2);
    // assert @inv_check(@keeps(DataContainer, DataLock)); 
    assert $keeps($s, $ptr(^_DATA_CONTAINER, G#DataContainer#dt4), $ptr(^_LOCK, G#DataLock#dt2));
    // assert @inv_check(==(*((DataLock->protected_obj)), Data)); 
    assert $int_to_ptr($mem($s, $dot($ptr(^_LOCK, G#DataLock#dt2), _LOCK.protected_obj))) == $ptr(^_DATA, G#Data#dt3);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // c := @claim(pure(@_vcc_closed(@state, DataContainer)), DataContainer); 
    assert $closed($s, $ptr(^_DATA_CONTAINER, G#DataContainer#dt4));
    assert $top_writable($s, #wrTime$1^88.1, $ptr(^_DATA_CONTAINER, G#DataContainer#dt4));
    assert $is_claimable(^_DATA_CONTAINER);
    call $write_ref_cnt($ptr(^_DATA_CONTAINER, G#DataContainer#dt4), $ref_cnt($s, $ptr(^_DATA_CONTAINER, G#DataContainer#dt4)) + 1);
    assume $ref_cnt($s, $ptr(^_DATA_CONTAINER, G#DataContainer#dt4)) >= 0;
    claim#0s0 := $s;
    call claim#0 := $alloc_claim();
    assume $claims_obj(claim#0, $ptr(^_DATA_CONTAINER, G#DataContainer#dt4));
    SL#c := $ref(claim#0);
    assume $local_value_is($s, #tok$1^101.29, #loc.c, $ptr_to_int($ptr(^^claim, SL#c)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^101.29, #loc.c, $ptr(^^claim, SL#c), $spec_ptr_to(^^claim));
    assume $full_stop_ext(#tok$1^101.29, $s);
    assume claim#0 != $no_claim ==> $claim_initial_assumptions($s, claim#0, #tok$1^101.29);
    assert claim#0 != $no_claim ==> $claimed_closed($s, $ptr(^_DATA_CONTAINER, G#DataContainer#dt4));
    if (claim#0doAdm)
    {
      anon33:
        assume $claimed_closed(claim#0s1, $ptr(^_DATA_CONTAINER, G#DataContainer#dt4));
        assume $valid_claim_impl(claim#0s0, claim#0s2);
        assume $claim_transitivity_assumptions(claim#0s1, claim#0s2, claim#0, #tok$1^101.29);
        assert $claimed_closed(claim#0s2, $ptr(^_DATA_CONTAINER, G#DataContainer#dt4));
        assume false;
    }

  anon35:
    assume claim#0 != $no_claim ==> (forall #cs3: $state :: { $valid_claim(#cs3, claim#0) } $valid_claim(#cs3, claim#0) ==> $claimed_closed(#cs3, $ptr(^_DATA_CONTAINER, G#DataContainer#dt4)));
    // stmt testit(c); 
    call testit($ref($ptr(^^claim, SL#c)));
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

const unique #distTp6: $ctype;

axiom #distTp6 == $ptr_to(^^i4);

const unique #loc.Destination#1: $token;

const unique #tok$1^42.41: $token;

const unique #tok$1^40.3: $token;

const unique #loc.stop: $token;

const unique #tok$1^38.3: $token;

const unique #distTp5: $ctype;

axiom #distTp5 == $spec_ptr_to(^^claim);

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

const unique #distTp4: $ctype;

axiom #distTp4 == $spec_ptr_to(^_DATA_CONTAINER);

const unique #tok$1^67.50: $token;

const unique #distTp3: $ctype;

axiom #distTp3 == $ptr_to(^_DATA);

const unique #tok$1^60.9: $token;

const unique #distTp2: $ctype;

axiom #distTp2 == $ptr_to(^_LOCK);

const unique #loc._this_: $token;

const unique #tok$1^4.67: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CLock.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CLock.c);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^^void);
