axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^Collection: $ctype;

axiom $is_composite(^Collection);

axiom $ptr_level(^Collection) == 0;

axiom $sizeof(^Collection) == 16;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Collection) } $inv2(#s1, #s2, #p, ^Collection) == ($typed(#s2, #p) && $dot(#p, Collection.Shadow) == $dot(#p, Collection.Shadow) && $keeps(#s2, #p, $dot(#p, Collection.Shadow)) && $ptr_eq($read_ptr($int_to_state($mem(#s2, $dot($dot(#p, Collection.Shadow), Collection##Shadow.shadow))), $dot(#p, Collection.arr), ^^i4), $read_ptr(#s2, $dot(#p, Collection.arr), ^^i4)) && $mem($int_to_state($mem(#s2, $dot($dot(#p, Collection.Shadow), Collection##Shadow.shadow))), $dot(#p, Collection.ver)) == $mem(#s2, $dot(#p, Collection.ver))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^Collection, #r), l#public) } $inv_lab(#s2, $ptr(^Collection, #r), l#public) == ($typed(#s2, $ptr(^Collection, #r)) && $keeps(#s2, $ptr(^Collection, #r), $dot($ptr(^Collection, #r), Collection.Shadow)) && $ptr_eq($read_ptr($int_to_state($mem(#s2, $dot($dot($ptr(^Collection, #r), Collection.Shadow), Collection##Shadow.shadow))), $dot($ptr(^Collection, #r), Collection.arr), ^^i4), $read_ptr(#s2, $dot($ptr(^Collection, #r), Collection.arr), ^^i4)) && $mem($int_to_state($mem(#s2, $dot($dot($ptr(^Collection, #r), Collection.Shadow), Collection##Shadow.shadow))), $dot($ptr(^Collection, #r), Collection.ver)) == $mem(#s2, $dot($ptr(^Collection, #r), Collection.ver))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^Collection, #r)) } $in_full_extent_of(#q, $ptr(^Collection, #r)) == (#q == $ptr(^Collection, #r) || #q == $dot($ptr(^Collection, #r), Collection.$owns) || #q == $dot($ptr(^Collection, #r), Collection.arr) || #q == $dot($ptr(^Collection, #r), Collection.ver) || $in_full_extent_of(#q, $dot($ptr(^Collection, #r), Collection.Shadow))));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Collection, #r)) } $in_extent_of(#s, #q, $ptr(^Collection, #r)) == $in_struct_extent_of(#q, $ptr(^Collection, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^Collection, #r)) } $in_span_of(#q, $ptr(^Collection, #r)) == (#q == $ptr(^Collection, #r) || #q == $dot($ptr(^Collection, #r), Collection.$owns) || #q == $dot($ptr(^Collection, #r), Collection.arr) || #q == $dot($ptr(^Collection, #r), Collection.ver)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^Collection) } $state_spans_the_same(#s1, #s2, #p, ^Collection) == ($mem_eq(#s1, #s2, $dot(#p, Collection.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Collection.arr)) && $mem_eq(#s1, #s2, $dot(#p, Collection.ver))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Collection) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Collection) == ($mem_eq(#s1, #s2, $dot(#p, Collection.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Collection.arr)) && $mem_eq(#s1, #s2, $dot(#p, Collection.ver))));

axiom $is_claimable(^Collection) == false;

axiom $has_volatile_owns_set(^Collection) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^Collection, #r)) } $extent_mutable(#s1, $ptr(^Collection, #r)) == ($mutable(#s1, $ptr(^Collection, #r)) && $extent_mutable(#s1, $dot($ptr(^Collection, #r), Collection.Shadow))));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^Collection, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^Collection, #r)) == ($is_fresh(#s1, #s2, $ptr(^Collection, #r)) && $extent_is_fresh(#s1, #s2, $dot($ptr(^Collection, #r), Collection.Shadow))));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^Collection, #r)) } $extent_zero(#s1, $ptr(^Collection, #r)) == ($mem(#s1, $dot($ptr(^Collection, #r), Collection.arr)) == 0 && $mem(#s1, $dot($ptr(^Collection, #r), Collection.ver)) == 0 && $extent_zero(#s1, $dot($ptr(^Collection, #r), Collection.Shadow))));

const unique Collection.$owns: $field;

axiom $static_field_properties(Collection.$owns, ^Collection);

axiom $is_primitive_non_volatile_field(Collection.$owns);

axiom (forall #p: $ptr :: { $dot(#p, Collection.$owns) } $is(#p, ^Collection) ==> $dot(#p, Collection.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, Collection.$owns)) && $extent_hint($dot(#p, Collection.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Collection.$owns)) } { $st(#s, $dot(#p, Collection.$owns)) } $typed2(#s, #p, ^Collection) ==> $field_properties(#s, #p, Collection.$owns, ^$#ptrset, false));

axiom $owns_set_field(^Collection) == Collection.$owns;

const unique Collection.arr: $field;

axiom $static_field_properties(Collection.arr, ^Collection);

axiom $is_primitive_non_volatile_field(Collection.arr);

axiom $field_offset(Collection.arr) == 0;

axiom (forall #p: $ptr :: { $dot(#p, Collection.arr) } $is(#p, ^Collection) ==> $dot(#p, Collection.arr) == $ptr($ptr_to(^^i4), $ref(#p) + 0) && $extent_hint($dot(#p, Collection.arr), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Collection.arr)) } { $st(#s, $dot(#p, Collection.arr)) } $typed2(#s, #p, ^Collection) ==> $field_properties(#s, #p, Collection.arr, $ptr_to(^^i4), false));

const unique Collection.ver: $field;

axiom $static_field_properties(Collection.ver, ^Collection);

axiom $is_primitive_non_volatile_field(Collection.ver);

axiom $field_offset(Collection.ver) == 8;

axiom (forall #p: $ptr :: { $dot(#p, Collection.ver) } $is(#p, ^Collection) ==> $dot(#p, Collection.ver) == $ptr(^^i4, $ref(#p) + 8) && $extent_hint($dot(#p, Collection.ver), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Collection.ver)) } { $st(#s, $dot(#p, Collection.ver)) } $typed2(#s, #p, ^Collection) ==> $field_properties(#s, #p, Collection.ver, ^^i4, false));

const unique Collection.Shadow: $field;

axiom $static_field_properties(Collection.Shadow, ^Collection);

axiom $field_offset(Collection.Shadow) == 0;

axiom (forall #p: $ptr :: { $dot(#p, Collection.Shadow) } $is(#p, ^Collection) ==> $dot(#p, Collection.Shadow) == $ptr(^Collection##Shadow, $ref(#p) + 0) && $extent_hint($dot(#p, Collection.Shadow), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Collection.Shadow)) } { $st(#s, $dot(#p, Collection.Shadow)) } $typed2(#s, #p, ^Collection) ==> $field_properties(#s, #p, Collection.Shadow, ^Collection##Shadow, false));

procedure Collection#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $dot($ptr(^Collection, P#_this_), Collection.Shadow) == $dot($ptr(^Collection, P#_this_), Collection.Shadow);
  ensures $is_admissibility_check() ==> $keeps($s, $ptr(^Collection, P#_this_), $dot($ptr(^Collection, P#_this_), Collection.Shadow));
  ensures $is_admissibility_check() ==> $ptr_eq($read_ptr($int_to_state($mem($s, $dot($dot($ptr(^Collection, P#_this_), Collection.Shadow), Collection##Shadow.shadow))), $dot($ptr(^Collection, P#_this_), Collection.arr), ^^i4), $read_ptr($s, $dot($ptr(^Collection, P#_this_), Collection.arr), ^^i4));
  ensures $is_admissibility_check() ==> $mem($int_to_state($mem($s, $dot($dot($ptr(^Collection, P#_this_), Collection.Shadow), Collection##Shadow.shadow))), $dot($ptr(^Collection, P#_this_), Collection.ver)) == $mem($s, $dot($ptr(^Collection, P#_this_), Collection.ver));
  ensures $is_stuttering_check() ==> $dot($ptr(^Collection, P#_this_), Collection.Shadow) == $dot($ptr(^Collection, P#_this_), Collection.Shadow);
  ensures $is_unwrap_check() ==> $dot($ptr(^Collection, P#_this_), Collection.Shadow) == $dot($ptr(^Collection, P#_this_), Collection.Shadow);
  ensures $is_unwrap_check() ==> $keeps($s, $ptr(^Collection, P#_this_), $dot($ptr(^Collection, P#_this_), Collection.Shadow));
  ensures $is_unwrap_check() ==> $ptr_eq($read_ptr($int_to_state($mem($s, $dot($dot($ptr(^Collection, P#_this_), Collection.Shadow), Collection##Shadow.shadow))), $dot($ptr(^Collection, P#_this_), Collection.arr), ^^i4), $read_ptr($s, $dot($ptr(^Collection, P#_this_), Collection.arr), ^^i4));
  ensures $is_unwrap_check() ==> $mem($int_to_state($mem($s, $dot($dot($ptr(^Collection, P#_this_), Collection.Shadow), Collection##Shadow.shadow))), $dot($ptr(^Collection, P#_this_), Collection.ver)) == $mem($s, $dot($ptr(^Collection, P#_this_), Collection.ver));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Collection#adm(P#_this_: int)
{
  var #wrTime$1^4.1: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^4.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^4.1, #loc._this_, $ptr_to_int($ptr(^Collection, P#_this_)), $ptr_to(^Collection)) && $local_value_is_ptr($s, #tok$1^4.1, #loc._this_, $ptr(^Collection, P#_this_), $ptr_to(^Collection));
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
        assume $unwrap_check_pre($s, $ptr(^Collection, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^Collection, P#_this_));
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
            assume $admissibility_pre($s, $ptr(^Collection, P#_this_));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^Collection, P#_this_));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Collection*)@null))
        call $havoc_others($ptr(^Collection, P#_this_), ^Collection);
        assume $good_state_ext(#tok$1^4.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^Collection, P#_this_), ^Collection);
    }

  #exit:
}



const unique ^Collection##Shadow: $ctype;

axiom $is_composite(^Collection##Shadow);

axiom $ptr_level(^Collection##Shadow) == 0;

axiom $sizeof(^Collection##Shadow) == 16;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Collection##Shadow) } $inv2(#s1, #s2, #p, ^Collection##Shadow) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty()) && ($mem($int_to_state($mem(#s1, $dot(#p, Collection##Shadow.shadow))), $dot($ptr_cast(#p, ^Collection), Collection.ver)) == $mem($int_to_state($mem(#s2, $dot(#p, Collection##Shadow.shadow))), $dot($ptr_cast(#p, ^Collection), Collection.ver)) ==> $ptr_eq($read_ptr($int_to_state($mem(#s1, $dot(#p, Collection##Shadow.shadow))), $dot($ptr_cast(#p, ^Collection), Collection.arr), ^^i4), $read_ptr($int_to_state($mem(#s2, $dot(#p, Collection##Shadow.shadow))), $dot($ptr_cast(#p, ^Collection), Collection.arr), ^^i4))) && $mem($int_to_state($mem(#s1, $dot(#p, Collection##Shadow.shadow))), $dot($ptr_cast(#p, ^Collection), Collection.ver)) <= $mem($int_to_state($mem(#s2, $dot(#p, Collection##Shadow.shadow))), $dot($ptr_cast(#p, ^Collection), Collection.ver)) && $inv_is_owner_approved(#s1, #s2, #p, Collection##Shadow.shadow)));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^Collection##Shadow, #r), l#public) } $inv_lab(#s2, $ptr(^Collection##Shadow, #r), l#public) == ($typed(#s2, $ptr(^Collection##Shadow, #r)) && $set_eq($owns(#s2, $ptr(^Collection##Shadow, #r)), $set_empty()) && $ptr_eq($read_ptr($int_to_state($mem(#s2, $dot($ptr(^Collection##Shadow, #r), Collection##Shadow.shadow))), $dot($ptr_cast($ptr(^Collection##Shadow, #r), ^Collection), Collection.arr), ^^i4), $read_ptr($int_to_state($mem(#s2, $dot($ptr(^Collection##Shadow, #r), Collection##Shadow.shadow))), $dot($ptr_cast($ptr(^Collection##Shadow, #r), ^Collection), Collection.arr), ^^i4)) && $mem($int_to_state($mem(#s2, $dot($ptr(^Collection##Shadow, #r), Collection##Shadow.shadow))), $dot($ptr_cast($ptr(^Collection##Shadow, #r), ^Collection), Collection.ver)) <= $mem($int_to_state($mem(#s2, $dot($ptr(^Collection##Shadow, #r), Collection##Shadow.shadow))), $dot($ptr_cast($ptr(^Collection##Shadow, #r), ^Collection), Collection.ver)) && $inv_is_owner_approved(#s2, #s2, $ptr(^Collection##Shadow, #r), Collection##Shadow.shadow)));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^Collection##Shadow, #r)) } $in_full_extent_of(#q, $ptr(^Collection##Shadow, #r)) == (#q == $ptr(^Collection##Shadow, #r) || #q == $dot($ptr(^Collection##Shadow, #r), Collection##Shadow.$owns) || #q == $dot($ptr(^Collection##Shadow, #r), Collection##Shadow.shadow)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Collection##Shadow, #r)) } $in_extent_of(#s, #q, $ptr(^Collection##Shadow, #r)) == $in_struct_extent_of(#q, $ptr(^Collection##Shadow, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Collection##Shadow, #r)) } $typed(#s, $ptr(^Collection##Shadow, #r)) ==> $in_extent_of(#s, #q, $ptr(^Collection##Shadow, #r)) == (#q == $ptr(^Collection##Shadow, #r) || $emb(#s, #q) == $ptr(^Collection##Shadow, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^Collection##Shadow, #r)) } $in_span_of(#q, $ptr(^Collection##Shadow, #r)) == (#q == $ptr(^Collection##Shadow, #r) || #q == $dot($ptr(^Collection##Shadow, #r), Collection##Shadow.$owns) || #q == $dot($ptr(^Collection##Shadow, #r), Collection##Shadow.shadow)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^Collection##Shadow) } $state_spans_the_same(#s1, #s2, #p, ^Collection##Shadow) == ($mem_eq(#s1, #s2, $dot(#p, Collection##Shadow.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Collection##Shadow.shadow))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Collection##Shadow) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Collection##Shadow) == $mem_eq(#s1, #s2, $dot(#p, Collection##Shadow.$owns)));

axiom $is_claimable(^Collection##Shadow) == true;

axiom $has_volatile_owns_set(^Collection##Shadow) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^Collection##Shadow, #r)) } $extent_mutable(#s1, $ptr(^Collection##Shadow, #r)) == $mutable(#s1, $ptr(^Collection##Shadow, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^Collection##Shadow, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^Collection##Shadow, #r)) == $is_fresh(#s1, #s2, $ptr(^Collection##Shadow, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^Collection##Shadow, #r)) } $extent_zero(#s1, $ptr(^Collection##Shadow, #r)) == ($mem(#s1, $dot($ptr(^Collection##Shadow, #r), Collection##Shadow.shadow)) == 0));

const unique Collection##Shadow.$owns: $field;

axiom $static_field_properties(Collection##Shadow.$owns, ^Collection##Shadow);

axiom $is_primitive_non_volatile_field(Collection##Shadow.$owns);

axiom (forall #p: $ptr :: { $dot(#p, Collection##Shadow.$owns) } $is(#p, ^Collection##Shadow) ==> $dot(#p, Collection##Shadow.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, Collection##Shadow.$owns)) && $extent_hint($dot(#p, Collection##Shadow.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Collection##Shadow.$owns)) } { $st(#s, $dot(#p, Collection##Shadow.$owns)) } $typed2(#s, #p, ^Collection##Shadow) ==> $field_properties(#s, #p, Collection##Shadow.$owns, ^$#ptrset, false));

axiom $owns_set_field(^Collection##Shadow) == Collection##Shadow.$owns;

const unique Collection##Shadow.shadow: $field;

axiom $static_field_properties(Collection##Shadow.shadow, ^Collection##Shadow);

axiom $is_primitive_volatile_field(Collection##Shadow.shadow);

axiom (forall #p: $ptr :: { $dot(#p, Collection##Shadow.shadow) } $is(#p, ^Collection##Shadow) ==> $dot(#p, Collection##Shadow.shadow) == $ptr(^$#state_t, $ghost_ref(#p, Collection##Shadow.shadow)) && $extent_hint($dot(#p, Collection##Shadow.shadow), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Collection##Shadow.shadow)) } { $st(#s, $dot(#p, Collection##Shadow.shadow)) } $typed2(#s, #p, ^Collection##Shadow) ==> $field_properties(#s, #p, Collection##Shadow.shadow, ^$#state_t, true));

procedure Collection##Shadow#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $set_eq($owns($s, $ptr(^Collection##Shadow, P#_this_)), $set_empty());
  ensures $is_admissibility_check() ==> $mem($int_to_state($mem(old($s), $dot($ptr(^Collection##Shadow, P#_this_), Collection##Shadow.shadow))), $dot($ptr_cast($ptr(^Collection##Shadow, P#_this_), ^Collection), Collection.ver)) == $mem($int_to_state($mem($s, $dot($ptr(^Collection##Shadow, P#_this_), Collection##Shadow.shadow))), $dot($ptr_cast($ptr(^Collection##Shadow, P#_this_), ^Collection), Collection.ver)) ==> $ptr_eq($read_ptr($int_to_state($mem(old($s), $dot($ptr(^Collection##Shadow, P#_this_), Collection##Shadow.shadow))), $dot($ptr_cast($ptr(^Collection##Shadow, P#_this_), ^Collection), Collection.arr), ^^i4), $read_ptr($int_to_state($mem($s, $dot($ptr(^Collection##Shadow, P#_this_), Collection##Shadow.shadow))), $dot($ptr_cast($ptr(^Collection##Shadow, P#_this_), ^Collection), Collection.arr), ^^i4));
  ensures $is_admissibility_check() ==> $mem($int_to_state($mem(old($s), $dot($ptr(^Collection##Shadow, P#_this_), Collection##Shadow.shadow))), $dot($ptr_cast($ptr(^Collection##Shadow, P#_this_), ^Collection), Collection.ver)) <= $mem($int_to_state($mem($s, $dot($ptr(^Collection##Shadow, P#_this_), Collection##Shadow.shadow))), $dot($ptr_cast($ptr(^Collection##Shadow, P#_this_), ^Collection), Collection.ver));
  ensures $is_admissibility_check() ==> $inv_is_owner_approved(old($s), $s, $ptr(^Collection##Shadow, P#_this_), Collection##Shadow.shadow);
  ensures $is_stuttering_check() ==> $mem($int_to_state($mem($s, $dot($ptr(^Collection##Shadow, P#_this_), Collection##Shadow.shadow))), $dot($ptr_cast($ptr(^Collection##Shadow, P#_this_), ^Collection), Collection.ver)) == $mem($int_to_state($mem($s, $dot($ptr(^Collection##Shadow, P#_this_), Collection##Shadow.shadow))), $dot($ptr_cast($ptr(^Collection##Shadow, P#_this_), ^Collection), Collection.ver)) ==> $ptr_eq($read_ptr($int_to_state($mem($s, $dot($ptr(^Collection##Shadow, P#_this_), Collection##Shadow.shadow))), $dot($ptr_cast($ptr(^Collection##Shadow, P#_this_), ^Collection), Collection.arr), ^^i4), $read_ptr($int_to_state($mem($s, $dot($ptr(^Collection##Shadow, P#_this_), Collection##Shadow.shadow))), $dot($ptr_cast($ptr(^Collection##Shadow, P#_this_), ^Collection), Collection.arr), ^^i4));
  ensures $is_stuttering_check() ==> $mem($int_to_state($mem($s, $dot($ptr(^Collection##Shadow, P#_this_), Collection##Shadow.shadow))), $dot($ptr_cast($ptr(^Collection##Shadow, P#_this_), ^Collection), Collection.ver)) <= $mem($int_to_state($mem($s, $dot($ptr(^Collection##Shadow, P#_this_), Collection##Shadow.shadow))), $dot($ptr_cast($ptr(^Collection##Shadow, P#_this_), ^Collection), Collection.ver));
  ensures $is_stuttering_check() ==> $inv_is_owner_approved($s, $s, $ptr(^Collection##Shadow, P#_this_), Collection##Shadow.shadow);
  ensures $is_unwrap_check() ==> $set_eq($owns($s, $ptr(^Collection##Shadow, P#_this_)), $set_empty());
  ensures $is_unwrap_check() ==> $mem($int_to_state($mem(old($s), $dot($ptr(^Collection##Shadow, P#_this_), Collection##Shadow.shadow))), $dot($ptr_cast($ptr(^Collection##Shadow, P#_this_), ^Collection), Collection.ver)) == $mem($int_to_state($mem($s, $dot($ptr(^Collection##Shadow, P#_this_), Collection##Shadow.shadow))), $dot($ptr_cast($ptr(^Collection##Shadow, P#_this_), ^Collection), Collection.ver)) ==> $ptr_eq($read_ptr($int_to_state($mem(old($s), $dot($ptr(^Collection##Shadow, P#_this_), Collection##Shadow.shadow))), $dot($ptr_cast($ptr(^Collection##Shadow, P#_this_), ^Collection), Collection.arr), ^^i4), $read_ptr($int_to_state($mem($s, $dot($ptr(^Collection##Shadow, P#_this_), Collection##Shadow.shadow))), $dot($ptr_cast($ptr(^Collection##Shadow, P#_this_), ^Collection), Collection.arr), ^^i4));
  ensures $is_unwrap_check() ==> $mem($int_to_state($mem(old($s), $dot($ptr(^Collection##Shadow, P#_this_), Collection##Shadow.shadow))), $dot($ptr_cast($ptr(^Collection##Shadow, P#_this_), ^Collection), Collection.ver)) <= $mem($int_to_state($mem($s, $dot($ptr(^Collection##Shadow, P#_this_), Collection##Shadow.shadow))), $dot($ptr_cast($ptr(^Collection##Shadow, P#_this_), ^Collection), Collection.ver));
  ensures $is_unwrap_check() ==> $inv_is_owner_approved(old($s), $s, $ptr(^Collection##Shadow, P#_this_), Collection##Shadow.shadow);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Collection##Shadow#adm(P#_this_: int)
{
  var #wrTime$1^8.19: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^8.19, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^8.19, #loc._this_, $ptr_to_int($ptr(^Collection##Shadow, P#_this_)), $ptr_to(^Collection##Shadow)) && $local_value_is_ptr($s, #tok$1^8.19, #loc._this_, $ptr(^Collection##Shadow, P#_this_), $ptr_to(^Collection##Shadow));
    assume #wrTime$1^8.19 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^8.19, #p) } $in_writes_at(#wrTime$1^8.19, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon7:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^Collection##Shadow, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^Collection##Shadow, P#_this_));
        assume $good_state_ext(#tok$1^8.19, $s);
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
            assume $admissibility_pre($s, $ptr(^Collection##Shadow, P#_this_));
        }
        else
        {
          anon9:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^Collection##Shadow, P#_this_));
        }

      anon11:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Collection##Shadow*)@null))
        call $havoc_others($ptr(^Collection##Shadow, P#_this_), ^Collection##Shadow);
        assume $good_state_ext(#tok$1^8.19, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^Collection##Shadow, P#_this_), ^Collection##Shadow);
    }

  #exit:
}



axiom $is_owner_approved(^Collection##Shadow, Collection##Shadow.shadow);

const unique ^Iterator: $ctype;

axiom $is_composite(^Iterator);

axiom $ptr_level(^Iterator) == 0;

axiom $sizeof(^Iterator) == 16;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Iterator) } $inv2(#s1, #s2, #p, ^Iterator) == ($typed(#s2, #p) && $read_ptr(#s1, $dot(#p, Iterator.cl), ^^claim) == $read_ptr(#s2, $dot(#p, Iterator.cl), ^^claim) && $keeps(#s2, #p, $read_ptr(#s2, $dot(#p, Iterator.cl), ^^claim)) && $claims_obj($read_ptr(#s2, $dot(#p, Iterator.cl), ^^claim), $dot($read_ptr(#s2, $dot(#p, Iterator.coll), ^Collection), Collection.Shadow)) && $mem($int_to_state($mem(#s2, $dot($dot($read_ptr(#s2, $dot(#p, Iterator.coll), ^Collection), Collection.Shadow), Collection##Shadow.shadow))), $dot($read_ptr($current_state(#s2), $dot(#p, Iterator.coll), ^Collection), Collection.ver)) >= $mem(#s2, $dot(#p, Iterator.ver)) && ($mem($int_to_state($mem(#s2, $dot($dot($read_ptr(#s2, $dot(#p, Iterator.coll), ^Collection), Collection.Shadow), Collection##Shadow.shadow))), $dot($read_ptr($current_state(#s2), $dot(#p, Iterator.coll), ^Collection), Collection.ver)) == $mem(#s2, $dot(#p, Iterator.ver)) ==> $ptr_eq($read_ptr($int_to_state($mem(#s2, $dot($dot($read_ptr(#s2, $dot(#p, Iterator.coll), ^Collection), Collection.Shadow), Collection##Shadow.shadow))), $dot($read_ptr($current_state(#s2), $dot(#p, Iterator.coll), ^Collection), Collection.arr), ^^i4), $read_ptr(#s2, $dot(#p, Iterator.arr), ^^i4)))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^Iterator, #r), l#public) } $inv_lab(#s2, $ptr(^Iterator, #r), l#public) == ($typed(#s2, $ptr(^Iterator, #r)) && $keeps(#s2, $ptr(^Iterator, #r), $read_ptr(#s2, $dot($ptr(^Iterator, #r), Iterator.cl), ^^claim)) && $claims_obj($read_ptr(#s2, $dot($ptr(^Iterator, #r), Iterator.cl), ^^claim), $dot($read_ptr(#s2, $dot($ptr(^Iterator, #r), Iterator.coll), ^Collection), Collection.Shadow)) && $mem($int_to_state($mem(#s2, $dot($dot($read_ptr(#s2, $dot($ptr(^Iterator, #r), Iterator.coll), ^Collection), Collection.Shadow), Collection##Shadow.shadow))), $dot($read_ptr($current_state(#s2), $dot($ptr(^Iterator, #r), Iterator.coll), ^Collection), Collection.ver)) >= $mem(#s2, $dot($ptr(^Iterator, #r), Iterator.ver)) && ($mem($int_to_state($mem(#s2, $dot($dot($read_ptr(#s2, $dot($ptr(^Iterator, #r), Iterator.coll), ^Collection), Collection.Shadow), Collection##Shadow.shadow))), $dot($read_ptr($current_state(#s2), $dot($ptr(^Iterator, #r), Iterator.coll), ^Collection), Collection.ver)) == $mem(#s2, $dot($ptr(^Iterator, #r), Iterator.ver)) ==> $ptr_eq($read_ptr($int_to_state($mem(#s2, $dot($dot($read_ptr(#s2, $dot($ptr(^Iterator, #r), Iterator.coll), ^Collection), Collection.Shadow), Collection##Shadow.shadow))), $dot($read_ptr($current_state(#s2), $dot($ptr(^Iterator, #r), Iterator.coll), ^Collection), Collection.arr), ^^i4), $read_ptr(#s2, $dot($ptr(^Iterator, #r), Iterator.arr), ^^i4)))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^Iterator, #r)) } $in_full_extent_of(#q, $ptr(^Iterator, #r)) == (#q == $ptr(^Iterator, #r) || #q == $dot($ptr(^Iterator, #r), Iterator.$owns) || #q == $dot($ptr(^Iterator, #r), Iterator.coll) || #q == $dot($ptr(^Iterator, #r), Iterator.ver) || #q == $dot($ptr(^Iterator, #r), Iterator.cl) || #q == $dot($ptr(^Iterator, #r), Iterator.arr)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Iterator, #r)) } $in_extent_of(#s, #q, $ptr(^Iterator, #r)) == $in_struct_extent_of(#q, $ptr(^Iterator, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Iterator, #r)) } $typed(#s, $ptr(^Iterator, #r)) ==> $in_extent_of(#s, #q, $ptr(^Iterator, #r)) == (#q == $ptr(^Iterator, #r) || $emb(#s, #q) == $ptr(^Iterator, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^Iterator, #r)) } $in_span_of(#q, $ptr(^Iterator, #r)) == (#q == $ptr(^Iterator, #r) || #q == $dot($ptr(^Iterator, #r), Iterator.$owns) || #q == $dot($ptr(^Iterator, #r), Iterator.coll) || #q == $dot($ptr(^Iterator, #r), Iterator.ver) || #q == $dot($ptr(^Iterator, #r), Iterator.cl) || #q == $dot($ptr(^Iterator, #r), Iterator.arr)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^Iterator) } $state_spans_the_same(#s1, #s2, #p, ^Iterator) == ($mem_eq(#s1, #s2, $dot(#p, Iterator.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Iterator.coll)) && $mem_eq(#s1, #s2, $dot(#p, Iterator.ver)) && $mem_eq(#s1, #s2, $dot(#p, Iterator.cl)) && $mem_eq(#s1, #s2, $dot(#p, Iterator.arr))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Iterator) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Iterator) == ($mem_eq(#s1, #s2, $dot(#p, Iterator.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Iterator.coll)) && $mem_eq(#s1, #s2, $dot(#p, Iterator.ver)) && $mem_eq(#s1, #s2, $dot(#p, Iterator.cl)) && $mem_eq(#s1, #s2, $dot(#p, Iterator.arr))));

axiom $is_claimable(^Iterator) == false;

axiom $has_volatile_owns_set(^Iterator) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^Iterator, #r)) } $extent_mutable(#s1, $ptr(^Iterator, #r)) == $mutable(#s1, $ptr(^Iterator, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^Iterator, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^Iterator, #r)) == $is_fresh(#s1, #s2, $ptr(^Iterator, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^Iterator, #r)) } $extent_zero(#s1, $ptr(^Iterator, #r)) == ($mem(#s1, $dot($ptr(^Iterator, #r), Iterator.coll)) == 0 && $mem(#s1, $dot($ptr(^Iterator, #r), Iterator.ver)) == 0 && $mem(#s1, $dot($ptr(^Iterator, #r), Iterator.cl)) == 0 && $mem(#s1, $dot($ptr(^Iterator, #r), Iterator.arr)) == 0));

const unique Iterator.$owns: $field;

axiom $static_field_properties(Iterator.$owns, ^Iterator);

axiom $is_primitive_non_volatile_field(Iterator.$owns);

axiom (forall #p: $ptr :: { $dot(#p, Iterator.$owns) } $is(#p, ^Iterator) ==> $dot(#p, Iterator.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, Iterator.$owns)) && $extent_hint($dot(#p, Iterator.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Iterator.$owns)) } { $st(#s, $dot(#p, Iterator.$owns)) } $typed2(#s, #p, ^Iterator) ==> $field_properties(#s, #p, Iterator.$owns, ^$#ptrset, false));

axiom $owns_set_field(^Iterator) == Iterator.$owns;

const unique Iterator.coll: $field;

axiom $static_field_properties(Iterator.coll, ^Iterator);

axiom $is_primitive_non_volatile_field(Iterator.coll);

axiom $field_offset(Iterator.coll) == 0;

axiom (forall #p: $ptr :: { $dot(#p, Iterator.coll) } $is(#p, ^Iterator) ==> $dot(#p, Iterator.coll) == $ptr($ptr_to(^Collection), $ref(#p) + 0) && $extent_hint($dot(#p, Iterator.coll), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Iterator.coll)) } { $st(#s, $dot(#p, Iterator.coll)) } $typed2(#s, #p, ^Iterator) ==> $field_properties(#s, #p, Iterator.coll, $ptr_to(^Collection), false));

const unique Iterator.ver: $field;

axiom $static_field_properties(Iterator.ver, ^Iterator);

axiom $is_primitive_non_volatile_field(Iterator.ver);

axiom $field_offset(Iterator.ver) == 8;

axiom (forall #p: $ptr :: { $dot(#p, Iterator.ver) } $is(#p, ^Iterator) ==> $dot(#p, Iterator.ver) == $ptr(^^i4, $ref(#p) + 8) && $extent_hint($dot(#p, Iterator.ver), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Iterator.ver)) } { $st(#s, $dot(#p, Iterator.ver)) } $typed2(#s, #p, ^Iterator) ==> $field_properties(#s, #p, Iterator.ver, ^^i4, false));

const unique Iterator.cl: $field;

axiom $static_field_properties(Iterator.cl, ^Iterator);

axiom $is_primitive_non_volatile_field(Iterator.cl);

axiom (forall #p: $ptr :: { $dot(#p, Iterator.cl) } $is(#p, ^Iterator) ==> $dot(#p, Iterator.cl) == $ptr($spec_ptr_to(^^claim), $ghost_ref(#p, Iterator.cl)) && $extent_hint($dot(#p, Iterator.cl), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Iterator.cl)) } { $st(#s, $dot(#p, Iterator.cl)) } $typed2(#s, #p, ^Iterator) ==> $field_properties(#s, #p, Iterator.cl, $spec_ptr_to(^^claim), false));

const unique Iterator.arr: $field;

axiom $static_field_properties(Iterator.arr, ^Iterator);

axiom $is_primitive_non_volatile_field(Iterator.arr);

axiom (forall #p: $ptr :: { $dot(#p, Iterator.arr) } $is(#p, ^Iterator) ==> $dot(#p, Iterator.arr) == $ptr($ptr_to(^^i4), $ghost_ref(#p, Iterator.arr)) && $extent_hint($dot(#p, Iterator.arr), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Iterator.arr)) } { $st(#s, $dot(#p, Iterator.arr)) } $typed2(#s, #p, ^Iterator) ==> $field_properties(#s, #p, Iterator.arr, $ptr_to(^^i4), false));

procedure Iterator#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $read_ptr(old($s), $dot($ptr(^Iterator, P#_this_), Iterator.cl), ^^claim) == $read_ptr($s, $dot($ptr(^Iterator, P#_this_), Iterator.cl), ^^claim);
  ensures $is_admissibility_check() ==> $keeps($s, $ptr(^Iterator, P#_this_), $read_ptr($s, $dot($ptr(^Iterator, P#_this_), Iterator.cl), ^^claim));
  ensures $is_admissibility_check() ==> $claims_obj($read_ptr($s, $dot($ptr(^Iterator, P#_this_), Iterator.cl), ^^claim), $dot($read_ptr($s, $dot($ptr(^Iterator, P#_this_), Iterator.coll), ^Collection), Collection.Shadow));
  ensures $is_admissibility_check() ==> $mem($int_to_state($mem($s, $dot($dot($read_ptr($s, $dot($ptr(^Iterator, P#_this_), Iterator.coll), ^Collection), Collection.Shadow), Collection##Shadow.shadow))), $dot($read_ptr($current_state($s), $dot($ptr(^Iterator, P#_this_), Iterator.coll), ^Collection), Collection.ver)) >= $mem($s, $dot($ptr(^Iterator, P#_this_), Iterator.ver));
  ensures $is_admissibility_check() ==> $mem($int_to_state($mem($s, $dot($dot($read_ptr($s, $dot($ptr(^Iterator, P#_this_), Iterator.coll), ^Collection), Collection.Shadow), Collection##Shadow.shadow))), $dot($read_ptr($current_state($s), $dot($ptr(^Iterator, P#_this_), Iterator.coll), ^Collection), Collection.ver)) == $mem($s, $dot($ptr(^Iterator, P#_this_), Iterator.ver)) ==> $ptr_eq($read_ptr($int_to_state($mem($s, $dot($dot($read_ptr($s, $dot($ptr(^Iterator, P#_this_), Iterator.coll), ^Collection), Collection.Shadow), Collection##Shadow.shadow))), $dot($read_ptr($current_state($s), $dot($ptr(^Iterator, P#_this_), Iterator.coll), ^Collection), Collection.arr), ^^i4), $read_ptr($s, $dot($ptr(^Iterator, P#_this_), Iterator.arr), ^^i4));
  ensures $is_stuttering_check() ==> $read_ptr($s, $dot($ptr(^Iterator, P#_this_), Iterator.cl), ^^claim) == $read_ptr($s, $dot($ptr(^Iterator, P#_this_), Iterator.cl), ^^claim);
  ensures $is_unwrap_check() ==> $read_ptr(old($s), $dot($ptr(^Iterator, P#_this_), Iterator.cl), ^^claim) == $read_ptr($s, $dot($ptr(^Iterator, P#_this_), Iterator.cl), ^^claim);
  ensures $is_unwrap_check() ==> $keeps($s, $ptr(^Iterator, P#_this_), $read_ptr($s, $dot($ptr(^Iterator, P#_this_), Iterator.cl), ^^claim));
  ensures $is_unwrap_check() ==> $claims_obj($read_ptr($s, $dot($ptr(^Iterator, P#_this_), Iterator.cl), ^^claim), $dot($read_ptr($s, $dot($ptr(^Iterator, P#_this_), Iterator.coll), ^Collection), Collection.Shadow));
  ensures $is_unwrap_check() ==> $mem($int_to_state($mem($s, $dot($dot($read_ptr($s, $dot($ptr(^Iterator, P#_this_), Iterator.coll), ^Collection), Collection.Shadow), Collection##Shadow.shadow))), $dot($read_ptr($current_state($s), $dot($ptr(^Iterator, P#_this_), Iterator.coll), ^Collection), Collection.ver)) >= $mem($s, $dot($ptr(^Iterator, P#_this_), Iterator.ver));
  ensures $is_unwrap_check() ==> $mem($int_to_state($mem($s, $dot($dot($read_ptr($s, $dot($ptr(^Iterator, P#_this_), Iterator.coll), ^Collection), Collection.Shadow), Collection##Shadow.shadow))), $dot($read_ptr($current_state($s), $dot($ptr(^Iterator, P#_this_), Iterator.coll), ^Collection), Collection.ver)) == $mem($s, $dot($ptr(^Iterator, P#_this_), Iterator.ver)) ==> $ptr_eq($read_ptr($int_to_state($mem($s, $dot($dot($read_ptr($s, $dot($ptr(^Iterator, P#_this_), Iterator.coll), ^Collection), Collection.Shadow), Collection##Shadow.shadow))), $dot($read_ptr($current_state($s), $dot($ptr(^Iterator, P#_this_), Iterator.coll), ^Collection), Collection.arr), ^^i4), $read_ptr($s, $dot($ptr(^Iterator, P#_this_), Iterator.arr), ^^i4));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Iterator#adm(P#_this_: int)
{
  var #wrTime$1^57.1: int;
  var #stackframe: int;

  anon18:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^57.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^57.1, #loc._this_, $ptr_to_int($ptr(^Iterator, P#_this_)), $ptr_to(^Iterator)) && $local_value_is_ptr($s, #tok$1^57.1, #loc._this_, $ptr(^Iterator, P#_this_), $ptr_to(^Iterator));
    assume #wrTime$1^57.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^57.1, #p) } $in_writes_at(#wrTime$1^57.1, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon13:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^Iterator, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^Iterator, P#_this_));
        assume $good_state_ext(#tok$1^57.1, $s);
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
            assume $admissibility_pre($s, $ptr(^Iterator, P#_this_));
        }
        else
        {
          anon15:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^Iterator, P#_this_));
        }

      anon17:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Iterator*)@null))
        call $havoc_others($ptr(^Iterator, P#_this_), ^Iterator);
        assume $good_state_ext(#tok$1^57.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^Iterator, P#_this_), ^Iterator);
    }

  #exit:
}



procedure init();
  modifies $s, $cev_pc;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation init()
{
  var owns#6: $ptrset;
  var staticWrapState#5: $state;
  var prestate#7: $state;
  var owns#3: $ptrset;
  var staticWrapState#2: $state;
  var prestate#4: $state;
  var #callConv#0: $ptr;
  var L#coll: int where $in_range_phys_ptr(L#coll);
  var #wrTime$1^21.1: int;
  var #stackframe: int;

  anon21:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^21.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^21.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^21.1, #p) } $in_writes_at(#wrTime$1^21.1, #p) == false);
    // struct Collection* coll; 
    assume $local_value_is($s, #tok$1^23.10, #loc.coll, $ptr_to_int($ptr(^Collection, L#coll)), $ptr_to(^Collection)) && $local_value_is_ptr($s, #tok$1^23.10, #loc.coll, $ptr(^Collection, L#coll), $ptr_to(^Collection));
    // coll := _vcc_alloc(@_vcc_typeof((struct Collection*)@null)); 
    call #callConv#0 := $alloc(^Collection);
    assume $full_stop_ext(#tok$1^23.29, $s);
    L#coll := $ref(#callConv#0);
    assume $local_value_is($s, #tok$1^23.29, #loc.coll, $ptr_to_int($ptr(^Collection, L#coll)), $ptr_to(^Collection)) && $local_value_is_ptr($s, #tok$1^23.29, #loc.coll, $ptr(^Collection, L#coll), $ptr_to(^Collection));
    assume true;
    // if (@_vcc_ptr_neq(coll, @null)) ...
    if ($ptr_neq($ptr(^Collection, L#coll), $null))
    {
      anon19:
        // assert @_vcc_typed2(@state, (coll->arr)); 
        assert $typed2($s, $dot($ptr(^Collection, L#coll), Collection.arr), $ptr_to(^^i4));
        // assert @prim_writes_check((coll->arr)); 
        assert $writable($s, #wrTime$1^21.1, $dot($ptr(^Collection, L#coll), Collection.arr));
        // *(coll->arr) := (int32_t*)@null; 
        call $write_int($dot($ptr(^Collection, L#coll), Collection.arr), $ref($ptr_cast($null, ^^i4)));
        assume $full_stop_ext(#tok$1^25.5, $s);
        // assert @_vcc_typed2(@state, (coll->ver)); 
        assert $typed2($s, $dot($ptr(^Collection, L#coll), Collection.ver), ^^i4);
        // assert @prim_writes_check((coll->ver)); 
        assert $writable($s, #wrTime$1^21.1, $dot($ptr(^Collection, L#coll), Collection.ver));
        // *(coll->ver) := 0; 
        call $write_int($dot($ptr(^Collection, L#coll), Collection.ver), 0);
        assume $full_stop_ext(#tok$1^26.5, $s);
        // assert @_vcc_typed2(@state, ((coll->Shadow)->shadow)); 
        assert $typed2($s, $dot($dot($ptr(^Collection, L#coll), Collection.Shadow), Collection##Shadow.shadow), ^$#state_t);
        // assert @prim_writes_check(((coll->Shadow)->shadow)); 
        assert $writable($s, #wrTime$1^21.1, $dot($dot($ptr(^Collection, L#coll), Collection.Shadow), Collection##Shadow.shadow));
        // *((coll->Shadow)->shadow) := @_vcc_current_state(@state); 
        call $write_int($dot($dot($ptr(^Collection, L#coll), Collection.Shadow), Collection##Shadow.shadow), $state_to_int($current_state($s)));
        assume $full_stop_ext(#tok$1^29.7, $s);
        // _math state_t prestate#4; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#4, $state_to_int(prestate#4), ^$#state_t);
        // prestate#4 := @_vcc_current_state(@state); 
        prestate#4 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#4, $state_to_int(prestate#4), ^$#state_t);
        // _math state_t staticWrapState#2; 
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#2, $state_to_int(staticWrapState#2), ^$#state_t);
        // staticWrapState#2 := @_vcc_current_state(@state); 
        staticWrapState#2 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#2, $state_to_int(staticWrapState#2), ^$#state_t);
        // _math ptrset owns#3; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#3, $ptrset_to_int(owns#3), ^$#ptrset);
        // owns#3 := @_vcc_set_empty; 
        owns#3 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#3, $ptrset_to_int(owns#3), ^$#ptrset);
        // assert @writes_check((coll->Shadow)); 
        assert $top_writable($s, #wrTime$1^21.1, $dot($ptr(^Collection, L#coll), Collection.Shadow));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure((coll->Shadow)), staticWrapState#2, owns#3)
        call $static_wrap($dot($ptr(^Collection, L#coll), Collection.Shadow), staticWrapState#2, owns#3);
        assume $good_state_ext(#tok$1^30.23, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, (coll->Shadow)), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $dot($ptr(^Collection, L#coll), Collection.Shadow)), $set_empty());
        // assert @inv_check(==>(==(old(old(prestate#4, *(((coll->Shadow)->shadow))), *(((struct Collection*)(coll->Shadow)->ver))), old(*(((coll->Shadow)->shadow)), *(((struct Collection*)(coll->Shadow)->ver)))), @_vcc_ptr_eq(old(old(prestate#4, *(((coll->Shadow)->shadow))), *(((struct Collection*)(coll->Shadow)->arr))), old(*(((coll->Shadow)->shadow)), *(((struct Collection*)(coll->Shadow)->arr)))))); 
        assert $mem($int_to_state($mem(prestate#4, $dot($dot($ptr(^Collection, L#coll), Collection.Shadow), Collection##Shadow.shadow))), $dot($ptr_cast($dot($ptr(^Collection, L#coll), Collection.Shadow), ^Collection), Collection.ver)) == $mem($int_to_state($mem($s, $dot($dot($ptr(^Collection, L#coll), Collection.Shadow), Collection##Shadow.shadow))), $dot($ptr_cast($dot($ptr(^Collection, L#coll), Collection.Shadow), ^Collection), Collection.ver)) ==> $ptr_eq($read_ptr($int_to_state($mem(prestate#4, $dot($dot($ptr(^Collection, L#coll), Collection.Shadow), Collection##Shadow.shadow))), $dot($ptr_cast($dot($ptr(^Collection, L#coll), Collection.Shadow), ^Collection), Collection.arr), ^^i4), $read_ptr($int_to_state($mem($s, $dot($dot($ptr(^Collection, L#coll), Collection.Shadow), Collection##Shadow.shadow))), $dot($ptr_cast($dot($ptr(^Collection, L#coll), Collection.Shadow), ^Collection), Collection.arr), ^^i4));
        // assert @inv_check(<=(old(old(prestate#4, *(((coll->Shadow)->shadow))), *(((struct Collection*)(coll->Shadow)->ver))), old(*(((coll->Shadow)->shadow)), *(((struct Collection*)(coll->Shadow)->ver))))); 
        assert $mem($int_to_state($mem(prestate#4, $dot($dot($ptr(^Collection, L#coll), Collection.Shadow), Collection##Shadow.shadow))), $dot($ptr_cast($dot($ptr(^Collection, L#coll), Collection.Shadow), ^Collection), Collection.ver)) <= $mem($int_to_state($mem($s, $dot($dot($ptr(^Collection, L#coll), Collection.Shadow), Collection##Shadow.shadow))), $dot($ptr_cast($dot($ptr(^Collection, L#coll), Collection.Shadow), ^Collection), Collection.ver));
        // assert @inv_check(@_vcc_inv_is_owner_approved(old(prestate#4, @state), @state, (coll->Shadow), @field(userdata(__spec volatile _math state_t shadow /* @0 */) : Field))); 
        assert $inv_is_owner_approved(prestate#4, $s, $dot($ptr(^Collection, L#coll), Collection.Shadow), Collection##Shadow.shadow);
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // _math state_t prestate#7; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#7, $state_to_int(prestate#7), ^$#state_t);
        // prestate#7 := @_vcc_current_state(@state); 
        prestate#7 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#7, $state_to_int(prestate#7), ^$#state_t);
        // _math state_t staticWrapState#5; 
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#5, $state_to_int(staticWrapState#5), ^$#state_t);
        // staticWrapState#5 := @_vcc_current_state(@state); 
        staticWrapState#5 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#5, $state_to_int(staticWrapState#5), ^$#state_t);
        // _math ptrset owns#6; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#6, $ptrset_to_int(owns#6), ^$#ptrset);
        // owns#6 := @_vcc_set_empty; 
        owns#6 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#6, $ptrset_to_int(owns#6), ^$#ptrset);
        // assert @writes_check(coll); 
        assert $top_writable($s, #wrTime$1^21.1, $ptr(^Collection, L#coll));
        // assert @_vcc_wrapped(@state, (coll->Shadow)); 
        assert $wrapped($s, $dot($ptr(^Collection, L#coll), Collection.Shadow), ^Collection##Shadow);
        // assert @writes_check((coll->Shadow)); 
        assert $top_writable($s, #wrTime$1^21.1, $dot($ptr(^Collection, L#coll), Collection.Shadow));
        // owns#6 := pure(@_vcc_set_union(owns#6, @_vcc_set_singleton((coll->Shadow)))); 
        owns#6 := $set_union(owns#6, $set_singleton($dot($ptr(^Collection, L#coll), Collection.Shadow)));
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#6, $ptrset_to_int(owns#6), ^$#ptrset);
        // staticWrapState#5 := pure(@_vcc_take_over(staticWrapState#5, coll, (coll->Shadow))); 
        staticWrapState#5 := $take_over(staticWrapState#5, $ptr(^Collection, L#coll), $dot($ptr(^Collection, L#coll), Collection.Shadow));
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#5, $state_to_int(staticWrapState#5), ^$#state_t);
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(coll), staticWrapState#5, owns#6)
        call $static_wrap($ptr(^Collection, L#coll), staticWrapState#5, owns#6);
        assume $good_state_ext(#tok$1^31.23, $s);
        // assert @inv_check(@keeps_stable(old(prestate#7, (coll->Shadow)), (coll->Shadow))); 
        assert $dot($ptr(^Collection, L#coll), Collection.Shadow) == $dot($ptr(^Collection, L#coll), Collection.Shadow);
        // assert @inv_check(@keeps(coll, (coll->Shadow))); 
        assert $keeps($s, $ptr(^Collection, L#coll), $dot($ptr(^Collection, L#coll), Collection.Shadow));
        // assert @inv_check(@_vcc_ptr_eq(old(*(((coll->Shadow)->shadow)), *((coll->arr))), *((coll->arr)))); 
        assert $ptr_eq($read_ptr($int_to_state($mem($s, $dot($dot($ptr(^Collection, L#coll), Collection.Shadow), Collection##Shadow.shadow))), $dot($ptr(^Collection, L#coll), Collection.arr), ^^i4), $read_ptr($s, $dot($ptr(^Collection, L#coll), Collection.arr), ^^i4));
        // assert @inv_check(==(old(*(((coll->Shadow)->shadow)), *((coll->ver))), *((coll->ver)))); 
        assert $mem($int_to_state($mem($s, $dot($dot($ptr(^Collection, L#coll), Collection.Shadow), Collection##Shadow.shadow))), $dot($ptr(^Collection, L#coll), Collection.ver)) == $mem($s, $dot($ptr(^Collection, L#coll), Collection.ver));
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
    }
    else
    {
      anon20:
        // empty
    }

  anon22:
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure add(P#c: int);
  requires $mem($s, $dot($ptr(^Collection, P#c), Collection.ver)) < 100000;
  requires $wrapped($s, $ptr(^Collection, P#c), ^Collection);
  modifies $s, $cev_pc;
  ensures $wrapped($s, $ptr(^Collection, P#c), ^Collection);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Collection, P#c) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Collection, P#c) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Collection, P#c) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation add(P#c: int)
{
  var owns#12: $ptrset;
  var staticWrapState#11: $state;
  var prestate#13: $state;
  var beforeAtomicState#0: $state;
  var atomicObj#23: $ptr;
  var prestate#10: $state;
  var prestate#8: $state;
  var owns#9: $ptrset;
  var #callConv#1: $ptr;
  var addr.x: int where $in_range_phys_ptr(addr.x);
  var #wrTime$1^37.1: int;
  var #stackframe: int;

  anon23:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^37.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^37.1, #loc.c, $ptr_to_int($ptr(^Collection, P#c)), $ptr_to(^Collection)) && $local_value_is_ptr($s, #tok$1^37.1, #loc.c, $ptr(^Collection, P#c), $ptr_to(^Collection));
    assume #wrTime$1^37.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^37.1, #p) } $in_writes_at(#wrTime$1^37.1, #p) == (#p == $ptr(^Collection, P#c)));
    assume $thread_owned($s, $ptr(^Collection, P#c));
    // assume @in_range_phys_ptr((mathint)c); 
    assume $in_range_phys_ptr($ref($ptr(^Collection, P#c)));
    // assert @_vcc_in_domain(@state, c, c); 
    assert $in_domain_lab($s, $ptr(^Collection, P#c), $ptr(^Collection, P#c), l#public);
    // int32_t* addr.x; 
    assume $local_value_is($s, #tok$1^37.1, #loc.addr.x, $ptr_to_int($ptr(^^i4, addr.x)), $ptr_to(^^i4)) && $local_value_is_ptr($s, #tok$1^37.1, #loc.addr.x, $ptr(^^i4, addr.x), $ptr_to(^^i4));
    // addr.x := _vcc_stack_alloc<int32_t>(@stackframe, false); 
    call #callConv#1 := $stack_alloc(^^i4, #stackframe, false);
    assume $full_stop_ext(#tok$1^37.1, $s);
    addr.x := $ref(#callConv#1);
    assume $local_value_is($s, #tok$1^37.1, #loc.addr.x, $ptr_to_int($ptr(^^i4, addr.x)), $ptr_to(^^i4)) && $local_value_is_ptr($s, #tok$1^37.1, #loc.addr.x, $ptr(^^i4, addr.x), $ptr_to(^^i4));
    // var int32_t x
    // _math ptrset owns#9; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#9, $ptrset_to_int(owns#9), ^$#ptrset);
    // owns#9 := @_vcc_set_empty; 
    owns#9 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#9, $ptrset_to_int(owns#9), ^$#ptrset);
    // _math state_t prestate#8; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#8, $state_to_int(prestate#8), ^$#state_t);
    // prestate#8 := @_vcc_current_state(@state); 
    prestate#8 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#8, $state_to_int(prestate#8), ^$#state_t);
    // _math state_t prestate#10; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#10, $state_to_int(prestate#10), ^$#state_t);
    // prestate#10 := @_vcc_current_state(@state); 
    prestate#10 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#10, $state_to_int(prestate#10), ^$#state_t);
    // assert @_vcc_wrapped(@state, c); 
    assert $wrapped($s, $ptr(^Collection, P#c), ^Collection);
    // assert @writes_check(c); 
    assert $top_writable($s, #wrTime$1^37.1, $ptr(^Collection, P#c));
    // assume @_vcc_inv(@state, c); 
    assume $inv($s, $ptr(^Collection, P#c), ^Collection);
    // prestate#10 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#10, c, (c->Shadow))); 
    prestate#10 := $release($current_state($s), prestate#10, $ptr(^Collection, P#c), $dot($ptr(^Collection, P#c), Collection.Shadow));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#10, $state_to_int(prestate#10), ^$#state_t);
    // owns#9 := pure(@_vcc_set_union(owns#9, @_vcc_set_singleton((c->Shadow)))); 
    owns#9 := $set_union(owns#9, $set_singleton($dot($ptr(^Collection, P#c), Collection.Shadow)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#9, $ptrset_to_int(owns#9), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, (c->Shadow))); 
    assume $typed($s, $dot($ptr(^Collection, P#c), Collection.Shadow));
    // assume ==(owns#9, @_vcc_owns(@state, c)); 
    assume owns#9 == $owns($s, $ptr(^Collection, P#c));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(c), prestate#10)
    call $static_unwrap($ptr(^Collection, P#c), prestate#10);
    assume $good_state_ext(#tok$1^44.30, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_inv(@state, c); 
    assert $inv($s, $ptr(^Collection, P#c), ^Collection);
    // assume @_vcc_inv(@state, c); 
    assume $inv($s, $ptr(^Collection, P#c), ^Collection);
    // assert @_vcc_typed2(@state, (c->arr)); 
    assert $typed2($s, $dot($ptr(^Collection, P#c), Collection.arr), $ptr_to(^^i4));
    // assert @prim_writes_check((c->arr)); 
    assert $writable($s, #wrTime$1^37.1, $dot($ptr(^Collection, P#c), Collection.arr));
    // *(c->arr) := addr.x; 
    call $write_int($dot($ptr(^Collection, P#c), Collection.arr), $ref($ptr(^^i4, addr.x)));
    assume $full_stop_ext(#tok$1^46.5, $s);
    // assert @_vcc_typed2(@state, (c->ver)); 
    assert $typed2($s, $dot($ptr(^Collection, P#c), Collection.ver), ^^i4);
    // assert @prim_writes_check((c->ver)); 
    assert $writable($s, #wrTime$1^37.1, $dot($ptr(^Collection, P#c), Collection.ver));
    // assert @in_range_i4(+(*((c->ver)), 1)); 
    assert $in_range_i4($mem($s, $dot($ptr(^Collection, P#c), Collection.ver)) + 1);
    // assert @reads_check_normal((c->ver)); 
    assert $typed2($s, $dot($ptr(^Collection, P#c), Collection.ver), ^^i4);
    assert $thread_local2($s, $dot($ptr(^Collection, P#c), Collection.ver), ^^i4);
    // *(c->ver) := +(*((c->ver)), 1); 
    call $write_int($dot($ptr(^Collection, P#c), Collection.ver), $mem($s, $dot($ptr(^Collection, P#c), Collection.ver)) + 1);
    assume $full_stop_ext(#tok$1^47.5, $s);
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^50.45, $s);
    atomicObj#23 := $dot($ptr(^Collection, P#c), Collection.Shadow);
    assert $closed($s, atomicObj#23);
    assume $inv($s, atomicObj#23, ^Collection##Shadow);
    beforeAtomicState#0 := $s;
    // assert @_vcc_typed2(@state, ((c->Shadow)->shadow)); 
    assert $typed2($s, $dot($dot($ptr(^Collection, P#c), Collection.Shadow), Collection##Shadow.shadow), ^$#state_t);
    // assert @prim_writes_check(((c->Shadow)->shadow)); 
    assert $set_in($dot($dot($ptr(^Collection, P#c), Collection.Shadow), Collection##Shadow.shadow), $volatile_span($s, atomicObj#23)) || $writable($s, #wrTime$1^37.1, $dot($dot($ptr(^Collection, P#c), Collection.Shadow), Collection##Shadow.shadow));
    // *((c->Shadow)->shadow) := @_vcc_current_state(@state); 
    call $write_int($dot($dot($ptr(^Collection, P#c), Collection.Shadow), Collection##Shadow.shadow), $state_to_int($current_state($s)));
    assume $good_state_ext(#tok$1^51.9, $s);
    // assert @writes_check((c->Shadow)); 
    assert $top_writable($s, #wrTime$1^37.1, $dot($ptr(^Collection, P#c), Collection.Shadow));
    // stmt _vcc_bump_volatile_version((c->Shadow)); 
    call $bump_volatile_version($dot($ptr(^Collection, P#c), Collection.Shadow));
    assume $good_state_ext(#tok$1^52.18, $s);
    assert $set_eq($owns($s, atomicObj#23), $set_empty());
    assert $mem($int_to_state($mem(beforeAtomicState#0, $dot(atomicObj#23, Collection##Shadow.shadow))), $dot($ptr_cast(atomicObj#23, ^Collection), Collection.ver)) == $mem($int_to_state($mem($s, $dot(atomicObj#23, Collection##Shadow.shadow))), $dot($ptr_cast(atomicObj#23, ^Collection), Collection.ver)) ==> $ptr_eq($read_ptr($int_to_state($mem(beforeAtomicState#0, $dot(atomicObj#23, Collection##Shadow.shadow))), $dot($ptr_cast(atomicObj#23, ^Collection), Collection.arr), ^^i4), $read_ptr($int_to_state($mem($s, $dot(atomicObj#23, Collection##Shadow.shadow))), $dot($ptr_cast(atomicObj#23, ^Collection), Collection.arr), ^^i4));
    assert $mem($int_to_state($mem(beforeAtomicState#0, $dot(atomicObj#23, Collection##Shadow.shadow))), $dot($ptr_cast(atomicObj#23, ^Collection), Collection.ver)) <= $mem($int_to_state($mem($s, $dot(atomicObj#23, Collection##Shadow.shadow))), $dot($ptr_cast(atomicObj#23, ^Collection), Collection.ver));
    assert $inv_is_owner_approved(beforeAtomicState#0, $s, atomicObj#23, Collection##Shadow.shadow);
    assume $full_stop_ext(#tok$1^50.45, $s);
    // _math state_t prestate#13; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#13, $state_to_int(prestate#13), ^$#state_t);
    // prestate#13 := @_vcc_current_state(@state); 
    prestate#13 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#13, $state_to_int(prestate#13), ^$#state_t);
    // _math state_t staticWrapState#11; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#11, $state_to_int(staticWrapState#11), ^$#state_t);
    // staticWrapState#11 := @_vcc_current_state(@state); 
    staticWrapState#11 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#11, $state_to_int(staticWrapState#11), ^$#state_t);
    // _math ptrset owns#12; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#12, $ptrset_to_int(owns#12), ^$#ptrset);
    // owns#12 := @_vcc_set_empty; 
    owns#12 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#12, $ptrset_to_int(owns#12), ^$#ptrset);
    // assert @writes_check(c); 
    assert $top_writable($s, #wrTime$1^37.1, $ptr(^Collection, P#c));
    // assert @_vcc_wrapped(@state, (c->Shadow)); 
    assert $wrapped($s, $dot($ptr(^Collection, P#c), Collection.Shadow), ^Collection##Shadow);
    // assert @writes_check((c->Shadow)); 
    assert $top_writable($s, #wrTime$1^37.1, $dot($ptr(^Collection, P#c), Collection.Shadow));
    // owns#12 := pure(@_vcc_set_union(owns#12, @_vcc_set_singleton((c->Shadow)))); 
    owns#12 := $set_union(owns#12, $set_singleton($dot($ptr(^Collection, P#c), Collection.Shadow)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#12, $ptrset_to_int(owns#12), ^$#ptrset);
    // staticWrapState#11 := pure(@_vcc_take_over(staticWrapState#11, c, (c->Shadow))); 
    staticWrapState#11 := $take_over(staticWrapState#11, $ptr(^Collection, P#c), $dot($ptr(^Collection, P#c), Collection.Shadow));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#11, $state_to_int(staticWrapState#11), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(c), staticWrapState#11, owns#12)
    call $static_wrap($ptr(^Collection, P#c), staticWrapState#11, owns#12);
    assume $good_state_ext(#tok$1^44.30, $s);
    // assert @inv_check(@keeps_stable(old(prestate#13, (c->Shadow)), (c->Shadow))); 
    assert $dot($ptr(^Collection, P#c), Collection.Shadow) == $dot($ptr(^Collection, P#c), Collection.Shadow);
    // assert @inv_check(@keeps(c, (c->Shadow))); 
    assert $keeps($s, $ptr(^Collection, P#c), $dot($ptr(^Collection, P#c), Collection.Shadow));
    // assert @inv_check(@_vcc_ptr_eq(old(*(((c->Shadow)->shadow)), *((c->arr))), *((c->arr)))); 
    assert $ptr_eq($read_ptr($int_to_state($mem($s, $dot($dot($ptr(^Collection, P#c), Collection.Shadow), Collection##Shadow.shadow))), $dot($ptr(^Collection, P#c), Collection.arr), ^^i4), $read_ptr($s, $dot($ptr(^Collection, P#c), Collection.arr), ^^i4));
    // assert @inv_check(==(old(*(((c->Shadow)->shadow)), *((c->ver))), *((c->ver)))); 
    assert $mem($int_to_state($mem($s, $dot($dot($ptr(^Collection, P#c), Collection.Shadow), Collection##Shadow.shadow))), $dot($ptr(^Collection, P#c), Collection.ver)) == $mem($s, $dot($ptr(^Collection, P#c), Collection.ver));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // stmt _vcc_stack_free(@stackframe, addr.x); 
    call $stack_free(#stackframe, $ptr(^^i4, addr.x));
    assume $full_stop_ext(#tok$1^37.1, $s);
    // return; 
    assert $position_marker();
    goto #exit;

  anon24:
    // Block cleanup
    // stmt _vcc_stack_free(@stackframe, addr.x); 
    call $stack_free(#stackframe, $ptr(^^i4, addr.x));
    assume $full_stop_ext(#tok$1^37.1, $s);

  #exit:
}



procedure get_iter(P#c: int);
  requires $wrapped($s, $ptr(^Collection, P#c), ^Collection);
  modifies $s, $cev_pc;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation get_iter(P#c: int)
{
  var owns#15: $ptrset;
  var staticWrapState#14: $state;
  var prestate#16: $state;
  var claim#0doAdm: bool;
  var claim#0s2: $state;
  var claim#0s1: $state;
  var claim#0s0: $state;
  var claim#0: $ptr;
  var res_claim#1: int where $in_range_spec_ptr(res_claim#1);
  var beforeAtomicState#1: $state;
  var atomicObj#24: $ptr;
  var #callConv#2: $ptr;
  var L#iter: int where $in_range_phys_ptr(L#iter);
  var #wrTime$1^69.1: int;
  var #stackframe: int;

  anon29:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^69.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^69.1, #loc.c, $ptr_to_int($ptr(^Collection, P#c)), $ptr_to(^Collection)) && $local_value_is_ptr($s, #tok$1^69.1, #loc.c, $ptr(^Collection, P#c), $ptr_to(^Collection));
    assume #wrTime$1^69.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^69.1, #p) } $in_writes_at(#wrTime$1^69.1, #p) == false);
    // assume @in_range_phys_ptr((mathint)c); 
    assume $in_range_phys_ptr($ref($ptr(^Collection, P#c)));
    // assert @_vcc_in_domain(@state, c, c); 
    assert $in_domain_lab($s, $ptr(^Collection, P#c), $ptr(^Collection, P#c), l#public);
    // struct Iterator* iter; 
    assume $local_value_is($s, #tok$1^72.10, #loc.iter, $ptr_to_int($ptr(^Iterator, L#iter)), $ptr_to(^Iterator)) && $local_value_is_ptr($s, #tok$1^72.10, #loc.iter, $ptr(^Iterator, L#iter), $ptr_to(^Iterator));
    // iter := _vcc_alloc(@_vcc_typeof((struct Iterator*)@null)); 
    call #callConv#2 := $alloc(^Iterator);
    assume $full_stop_ext(#tok$1^72.27, $s);
    L#iter := $ref(#callConv#2);
    assume $local_value_is($s, #tok$1^72.27, #loc.iter, $ptr_to_int($ptr(^Iterator, L#iter)), $ptr_to(^Iterator)) && $local_value_is_ptr($s, #tok$1^72.27, #loc.iter, $ptr(^Iterator, L#iter), $ptr_to(^Iterator));
    assume true;
    // if (@_vcc_ptr_neq(iter, @null)) ...
    if ($ptr_neq($ptr(^Iterator, L#iter), $null))
    {
      anon26:
        // assert @_vcc_typed2(@state, (iter->coll)); 
        assert $typed2($s, $dot($ptr(^Iterator, L#iter), Iterator.coll), $ptr_to(^Collection));
        // assert @prim_writes_check((iter->coll)); 
        assert $writable($s, #wrTime$1^69.1, $dot($ptr(^Iterator, L#iter), Iterator.coll));
        // *(iter->coll) := c; 
        call $write_int($dot($ptr(^Iterator, L#iter), Iterator.coll), $ref($ptr(^Collection, P#c)));
        assume $full_stop_ext(#tok$1^74.5, $s);
        // assert @_vcc_typed2(@state, (iter->ver)); 
        assert $typed2($s, $dot($ptr(^Iterator, L#iter), Iterator.ver), ^^i4);
        // assert @prim_writes_check((iter->ver)); 
        assert $writable($s, #wrTime$1^69.1, $dot($ptr(^Iterator, L#iter), Iterator.ver));
        // assert @reads_check_normal((c->ver)); 
        assert $typed2($s, $dot($ptr(^Collection, P#c), Collection.ver), ^^i4);
        assert $thread_local2($s, $dot($ptr(^Collection, P#c), Collection.ver), ^^i4);
        // *(iter->ver) := *((c->ver)); 
        call $write_int($dot($ptr(^Iterator, L#iter), Iterator.ver), $mem($s, $dot($ptr(^Collection, P#c), Collection.ver)));
        assume $full_stop_ext(#tok$1^75.5, $s);
        // assert @_vcc_typed2(@state, (iter->arr)); 
        assert $typed2($s, $dot($ptr(^Iterator, L#iter), Iterator.arr), $ptr_to(^^i4));
        // assert @prim_writes_check((iter->arr)); 
        assert $writable($s, #wrTime$1^69.1, $dot($ptr(^Iterator, L#iter), Iterator.arr));
        // assert @reads_check_normal((c->arr)); 
        assert $typed2($s, $dot($ptr(^Collection, P#c), Collection.arr), $ptr_to(^^i4));
        assert $thread_local2($s, $dot($ptr(^Collection, P#c), Collection.arr), $ptr_to(^^i4));
        // *(iter->arr) := *((c->arr)); 
        call $write_int($dot($ptr(^Iterator, L#iter), Iterator.arr), $ref($read_ptr($s, $dot($ptr(^Collection, P#c), Collection.arr), ^^i4)));
        assume $full_stop_ext(#tok$1^76.28, $s);
        assume true;
        call $atomic_havoc();
        assume $full_stop_ext(#tok$1^77.21, $s);
        atomicObj#24 := $ptr(^Collection, P#c);
        assert $closed($s, atomicObj#24);
        assume $inv($s, atomicObj#24, ^Collection);
        beforeAtomicState#1 := $s;
        assume claim#0 == $no_claim;
        // claim_t^ res_claim#1; 
        assume $local_value_is($s, #tok$1^78.41, #loc.res_claim#1, $ptr_to_int($ptr(^^claim, res_claim#1)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^78.41, #loc.res_claim#1, $ptr(^^claim, res_claim#1), $spec_ptr_to(^^claim));
        // res_claim#1 := @claim(pure(true), (c->Shadow)); 
        assert $closed($s, $dot($ptr(^Collection, P#c), Collection.Shadow));
        assert $top_writable($s, #wrTime$1^69.1, $dot($ptr(^Collection, P#c), Collection.Shadow)) || $owner($s, $dot($ptr(^Collection, P#c), Collection.Shadow)) == atomicObj#24;
        assert $is_claimable(^Collection##Shadow);
        call $write_ref_cnt($dot($ptr(^Collection, P#c), Collection.Shadow), $ref_cnt($s, $dot($ptr(^Collection, P#c), Collection.Shadow)) + 1);
        assume $ref_cnt($s, $dot($ptr(^Collection, P#c), Collection.Shadow)) >= 0;
        claim#0s0 := $s;
        call claim#0 := $alloc_claim();
        assume $claims_obj(claim#0, $dot($ptr(^Collection, P#c), Collection.Shadow));
        res_claim#1 := $ref(claim#0);
        assume $local_value_is($s, #tok$1^78.41, #loc.res_claim#1, $ptr_to_int($ptr(^^claim, res_claim#1)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^78.41, #loc.res_claim#1, $ptr(^^claim, res_claim#1), $spec_ptr_to(^^claim));
        assume $good_state_ext(#tok$1^78.41, $s);
        // assert @_vcc_typed2(@state, (iter->cl)); 
        assert $typed2($s, $dot($ptr(^Iterator, L#iter), Iterator.cl), $spec_ptr_to(^^claim));
        // assert @prim_writes_check((iter->cl)); 
        assert $set_in($dot($ptr(^Iterator, L#iter), Iterator.cl), $volatile_span($s, atomicObj#24)) || $writable($s, #wrTime$1^69.1, $dot($ptr(^Iterator, L#iter), Iterator.cl));
        // *(iter->cl) := res_claim#1; 
        call $write_int($dot($ptr(^Iterator, L#iter), Iterator.cl), $ref($ptr(^^claim, res_claim#1)));
        assume $good_state_ext(#tok$1^78.30, $s);
        assume claim#0 != $no_claim ==> $claim_initial_assumptions($s, claim#0, #tok$1^78.41);
        assert true;
        if (claim#0 != $no_claim && claim#0doAdm)
        {
          anon25:
            assume true;
            assume $valid_claim_impl(claim#0s0, claim#0s2);
            assume $claim_transitivity_assumptions(claim#0s1, claim#0s2, claim#0, #tok$1^78.41);
            assert true;
            assume false;
        }

      anon27:
        assume claim#0 != $no_claim ==> (forall #cs0: $state :: { $valid_claim(#cs0, claim#0) } true);
        assert $dot(atomicObj#24, Collection.Shadow) == $dot(atomicObj#24, Collection.Shadow);
        assert $keeps($s, atomicObj#24, $dot(atomicObj#24, Collection.Shadow));
        assert $ptr_eq($read_ptr($int_to_state($mem($s, $dot($dot(atomicObj#24, Collection.Shadow), Collection##Shadow.shadow))), $dot(atomicObj#24, Collection.arr), ^^i4), $read_ptr($s, $dot(atomicObj#24, Collection.arr), ^^i4));
        assert $mem($int_to_state($mem($s, $dot($dot(atomicObj#24, Collection.Shadow), Collection##Shadow.shadow))), $dot(atomicObj#24, Collection.ver)) == $mem($s, $dot(atomicObj#24, Collection.ver));
        assume $full_stop_ext(#tok$1^77.21, $s);
        // _math state_t prestate#16; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#16, $state_to_int(prestate#16), ^$#state_t);
        // prestate#16 := @_vcc_current_state(@state); 
        prestate#16 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#16, $state_to_int(prestate#16), ^$#state_t);
        // _math state_t staticWrapState#14; 
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#14, $state_to_int(staticWrapState#14), ^$#state_t);
        // staticWrapState#14 := @_vcc_current_state(@state); 
        staticWrapState#14 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#14, $state_to_int(staticWrapState#14), ^$#state_t);
        // _math ptrset owns#15; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#15, $ptrset_to_int(owns#15), ^$#ptrset);
        // owns#15 := @_vcc_set_empty; 
        owns#15 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#15, $ptrset_to_int(owns#15), ^$#ptrset);
        // assert @writes_check(iter); 
        assert $top_writable($s, #wrTime$1^69.1, $ptr(^Iterator, L#iter));
        // assert @_vcc_wrapped(@state, *((iter->cl))); 
        assert $wrapped($s, $read_ptr($s, $dot($ptr(^Iterator, L#iter), Iterator.cl), ^^claim), ^^claim);
        // assert @writes_check(*((iter->cl))); 
        assert $top_writable($s, #wrTime$1^69.1, $read_ptr($s, $dot($ptr(^Iterator, L#iter), Iterator.cl), ^^claim));
        // owns#15 := pure(@_vcc_set_union(owns#15, @_vcc_set_singleton(*((iter->cl))))); 
        owns#15 := $set_union(owns#15, $set_singleton($read_ptr($s, $dot($ptr(^Iterator, L#iter), Iterator.cl), ^^claim)));
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#15, $ptrset_to_int(owns#15), ^$#ptrset);
        // staticWrapState#14 := pure(@_vcc_take_over(staticWrapState#14, iter, *((iter->cl)))); 
        staticWrapState#14 := $take_over(staticWrapState#14, $ptr(^Iterator, L#iter), $read_ptr($s, $dot($ptr(^Iterator, L#iter), Iterator.cl), ^^claim));
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#14, $state_to_int(staticWrapState#14), ^$#state_t);
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(iter), staticWrapState#14, owns#15)
        call $static_wrap($ptr(^Iterator, L#iter), staticWrapState#14, owns#15);
        assume $good_state_ext(#tok$1^81.21, $s);
        // assert @inv_check(@keeps_stable(old(prestate#16, *((iter->cl))), *((iter->cl)))); 
        assert $read_ptr(prestate#16, $dot($ptr(^Iterator, L#iter), Iterator.cl), ^^claim) == $read_ptr($s, $dot($ptr(^Iterator, L#iter), Iterator.cl), ^^claim);
        // assert @inv_check(@keeps(iter, *((iter->cl)))); 
        assert $keeps($s, $ptr(^Iterator, L#iter), $read_ptr($s, $dot($ptr(^Iterator, L#iter), Iterator.cl), ^^claim));
        // assert @inv_check(@_vcc_claims_obj(*((iter->cl)), (*((iter->coll))->Shadow))); 
        assert $claims_obj($read_ptr($s, $dot($ptr(^Iterator, L#iter), Iterator.cl), ^^claim), $dot($read_ptr($s, $dot($ptr(^Iterator, L#iter), Iterator.coll), ^Collection), Collection.Shadow));
        // assert @inv_check(>=(old(*(((*((iter->coll))->Shadow)->shadow)), *((old(@_vcc_current_state(@state), *((iter->coll)))->ver))), *((iter->ver)))); 
        assert $mem($int_to_state($mem($s, $dot($dot($read_ptr($s, $dot($ptr(^Iterator, L#iter), Iterator.coll), ^Collection), Collection.Shadow), Collection##Shadow.shadow))), $dot($read_ptr($current_state($s), $dot($ptr(^Iterator, L#iter), Iterator.coll), ^Collection), Collection.ver)) >= $mem($s, $dot($ptr(^Iterator, L#iter), Iterator.ver));
        // assert @inv_check(==>(==(old(*(((*((iter->coll))->Shadow)->shadow)), *((old(@_vcc_current_state(@state), *((iter->coll)))->ver))), *((iter->ver))), @_vcc_ptr_eq(old(*(((*((iter->coll))->Shadow)->shadow)), *((old(@_vcc_current_state(@state), *((iter->coll)))->arr))), *((iter->arr))))); 
        assert $mem($int_to_state($mem($s, $dot($dot($read_ptr($s, $dot($ptr(^Iterator, L#iter), Iterator.coll), ^Collection), Collection.Shadow), Collection##Shadow.shadow))), $dot($read_ptr($current_state($s), $dot($ptr(^Iterator, L#iter), Iterator.coll), ^Collection), Collection.ver)) == $mem($s, $dot($ptr(^Iterator, L#iter), Iterator.ver)) ==> $ptr_eq($read_ptr($int_to_state($mem($s, $dot($dot($read_ptr($s, $dot($ptr(^Iterator, L#iter), Iterator.coll), ^Collection), Collection.Shadow), Collection##Shadow.shadow))), $dot($read_ptr($current_state($s), $dot($ptr(^Iterator, L#iter), Iterator.coll), ^Collection), Collection.arr), ^^i4), $read_ptr($s, $dot($ptr(^Iterator, L#iter), Iterator.arr), ^^i4));
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
    }
    else
    {
      anon28:
        // empty
    }

  anon30:
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure iterate(P#it: int);
  requires $wrapped($s, $read_ptr($s, $dot($ptr(^Iterator, P#it), Iterator.coll), ^Collection), ^Collection);
  requires $mem($s, $dot($ptr(^Iterator, P#it), Iterator.ver)) == $mem($s, $dot($read_ptr($s, $dot($ptr(^Iterator, P#it), Iterator.coll), ^Collection), Collection.ver));
  requires $wrapped($s, $ptr(^Iterator, P#it), ^Iterator);
  modifies $s, $cev_pc;
  ensures $wrapped($s, $ptr(^Iterator, P#it), ^Iterator);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Iterator, P#it) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Iterator, P#it) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Iterator, P#it) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation iterate(P#it: int)
{
  var owns#21: $ptrset;
  var staticWrapState#20: $state;
  var prestate#22: $state;
  var prestate#19: $state;
  var prestate#17: $state;
  var owns#18: $ptrset;
  var #wrTime$1^85.1: int;
  var #stackframe: int;

  anon31:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^85.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^85.1, #loc.it, $ptr_to_int($ptr(^Iterator, P#it)), $ptr_to(^Iterator)) && $local_value_is_ptr($s, #tok$1^85.1, #loc.it, $ptr(^Iterator, P#it), $ptr_to(^Iterator));
    assume #wrTime$1^85.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^85.1, #p) } $in_writes_at(#wrTime$1^85.1, #p) == (#p == $ptr(^Iterator, P#it)));
    assume $thread_owned($s, $ptr(^Iterator, P#it));
    // assume @in_range_phys_ptr((mathint)it); 
    assume $in_range_phys_ptr($ref($ptr(^Iterator, P#it)));
    // assert @_vcc_in_domain(@state, it, it); 
    assert $in_domain_lab($s, $ptr(^Iterator, P#it), $ptr(^Iterator, P#it), l#public);
    // assert @_vcc_in_domain(@state, *((it->coll)), *((it->coll))); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($ptr(^Iterator, P#it), Iterator.coll), ^Collection), $read_ptr($s, $dot($ptr(^Iterator, P#it), Iterator.coll), ^Collection), l#public);
    // _math ptrset owns#18; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#18, $ptrset_to_int(owns#18), ^$#ptrset);
    // owns#18 := @_vcc_set_empty; 
    owns#18 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#18, $ptrset_to_int(owns#18), ^$#ptrset);
    // _math state_t prestate#17; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#17, $state_to_int(prestate#17), ^$#state_t);
    // prestate#17 := @_vcc_current_state(@state); 
    prestate#17 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#17, $state_to_int(prestate#17), ^$#state_t);
    // _math state_t prestate#19; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#19, $state_to_int(prestate#19), ^$#state_t);
    // prestate#19 := @_vcc_current_state(@state); 
    prestate#19 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#19, $state_to_int(prestate#19), ^$#state_t);
    // assert @_vcc_wrapped(@state, it); 
    assert $wrapped($s, $ptr(^Iterator, P#it), ^Iterator);
    // assert @writes_check(it); 
    assert $top_writable($s, #wrTime$1^85.1, $ptr(^Iterator, P#it));
    // assume @_vcc_inv(@state, it); 
    assume $inv($s, $ptr(^Iterator, P#it), ^Iterator);
    // prestate#19 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#19, it, *((it->cl)))); 
    prestate#19 := $release($current_state($s), prestate#19, $ptr(^Iterator, P#it), $read_ptr($s, $dot($ptr(^Iterator, P#it), Iterator.cl), ^^claim));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#19, $state_to_int(prestate#19), ^$#state_t);
    // owns#18 := pure(@_vcc_set_union(owns#18, @_vcc_set_singleton(*((it->cl))))); 
    owns#18 := $set_union(owns#18, $set_singleton($read_ptr($s, $dot($ptr(^Iterator, P#it), Iterator.cl), ^^claim)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#18, $ptrset_to_int(owns#18), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((it->cl)))); 
    assume $typed($s, $read_ptr($s, $dot($ptr(^Iterator, P#it), Iterator.cl), ^^claim));
    // assume ==(owns#18, @_vcc_owns(@state, it)); 
    assume owns#18 == $owns($s, $ptr(^Iterator, P#it));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(it), prestate#19)
    call $static_unwrap($ptr(^Iterator, P#it), prestate#19);
    assume $good_state_ext(#tok$1^91.30, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_ptr_eq(*((it->arr)), *((*((it->coll))->arr))); 
    assert $ptr_eq($read_ptr($s, $dot($ptr(^Iterator, P#it), Iterator.arr), ^^i4), $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Iterator, P#it), Iterator.coll), ^Collection), Collection.arr), ^^i4));
    // assume @_vcc_ptr_eq(*((it->arr)), *((*((it->coll))->arr))); 
    assume $ptr_eq($read_ptr($s, $dot($ptr(^Iterator, P#it), Iterator.arr), ^^i4), $read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Iterator, P#it), Iterator.coll), ^Collection), Collection.arr), ^^i4));
    // _math state_t prestate#22; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#22, $state_to_int(prestate#22), ^$#state_t);
    // prestate#22 := @_vcc_current_state(@state); 
    prestate#22 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#22, $state_to_int(prestate#22), ^$#state_t);
    // _math state_t staticWrapState#20; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#20, $state_to_int(staticWrapState#20), ^$#state_t);
    // staticWrapState#20 := @_vcc_current_state(@state); 
    staticWrapState#20 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#20, $state_to_int(staticWrapState#20), ^$#state_t);
    // _math ptrset owns#21; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#21, $ptrset_to_int(owns#21), ^$#ptrset);
    // owns#21 := @_vcc_set_empty; 
    owns#21 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#21, $ptrset_to_int(owns#21), ^$#ptrset);
    // assert @writes_check(it); 
    assert $top_writable($s, #wrTime$1^85.1, $ptr(^Iterator, P#it));
    // assert @_vcc_wrapped(@state, *((it->cl))); 
    assert $wrapped($s, $read_ptr($s, $dot($ptr(^Iterator, P#it), Iterator.cl), ^^claim), ^^claim);
    // assert @writes_check(*((it->cl))); 
    assert $top_writable($s, #wrTime$1^85.1, $read_ptr($s, $dot($ptr(^Iterator, P#it), Iterator.cl), ^^claim));
    // owns#21 := pure(@_vcc_set_union(owns#21, @_vcc_set_singleton(*((it->cl))))); 
    owns#21 := $set_union(owns#21, $set_singleton($read_ptr($s, $dot($ptr(^Iterator, P#it), Iterator.cl), ^^claim)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#21, $ptrset_to_int(owns#21), ^$#ptrset);
    // staticWrapState#20 := pure(@_vcc_take_over(staticWrapState#20, it, *((it->cl)))); 
    staticWrapState#20 := $take_over(staticWrapState#20, $ptr(^Iterator, P#it), $read_ptr($s, $dot($ptr(^Iterator, P#it), Iterator.cl), ^^claim));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#20, $state_to_int(staticWrapState#20), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(it), staticWrapState#20, owns#21)
    call $static_wrap($ptr(^Iterator, P#it), staticWrapState#20, owns#21);
    assume $good_state_ext(#tok$1^91.30, $s);
    // assert @inv_check(@keeps_stable(old(prestate#22, *((it->cl))), *((it->cl)))); 
    assert $read_ptr(prestate#22, $dot($ptr(^Iterator, P#it), Iterator.cl), ^^claim) == $read_ptr($s, $dot($ptr(^Iterator, P#it), Iterator.cl), ^^claim);
    // assert @inv_check(@keeps(it, *((it->cl)))); 
    assert $keeps($s, $ptr(^Iterator, P#it), $read_ptr($s, $dot($ptr(^Iterator, P#it), Iterator.cl), ^^claim));
    // assert @inv_check(@_vcc_claims_obj(*((it->cl)), (*((it->coll))->Shadow))); 
    assert $claims_obj($read_ptr($s, $dot($ptr(^Iterator, P#it), Iterator.cl), ^^claim), $dot($read_ptr($s, $dot($ptr(^Iterator, P#it), Iterator.coll), ^Collection), Collection.Shadow));
    // assert @inv_check(>=(old(*(((*((it->coll))->Shadow)->shadow)), *((old(@_vcc_current_state(@state), *((it->coll)))->ver))), *((it->ver)))); 
    assert $mem($int_to_state($mem($s, $dot($dot($read_ptr($s, $dot($ptr(^Iterator, P#it), Iterator.coll), ^Collection), Collection.Shadow), Collection##Shadow.shadow))), $dot($read_ptr($current_state($s), $dot($ptr(^Iterator, P#it), Iterator.coll), ^Collection), Collection.ver)) >= $mem($s, $dot($ptr(^Iterator, P#it), Iterator.ver));
    // assert @inv_check(==>(==(old(*(((*((it->coll))->Shadow)->shadow)), *((old(@_vcc_current_state(@state), *((it->coll)))->ver))), *((it->ver))), @_vcc_ptr_eq(old(*(((*((it->coll))->Shadow)->shadow)), *((old(@_vcc_current_state(@state), *((it->coll)))->arr))), *((it->arr))))); 
    assert $mem($int_to_state($mem($s, $dot($dot($read_ptr($s, $dot($ptr(^Iterator, P#it), Iterator.coll), ^Collection), Collection.Shadow), Collection##Shadow.shadow))), $dot($read_ptr($current_state($s), $dot($ptr(^Iterator, P#it), Iterator.coll), ^Collection), Collection.ver)) == $mem($s, $dot($ptr(^Iterator, P#it), Iterator.ver)) ==> $ptr_eq($read_ptr($int_to_state($mem($s, $dot($dot($read_ptr($s, $dot($ptr(^Iterator, P#it), Iterator.coll), ^Collection), Collection.Shadow), Collection##Shadow.shadow))), $dot($read_ptr($current_state($s), $dot($ptr(^Iterator, P#it), Iterator.coll), ^Collection), Collection.arr), ^^i4), $read_ptr($s, $dot($ptr(^Iterator, P#it), Iterator.arr), ^^i4));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



axiom (forall Q#ptr$2^0.0#dt3: int :: { $ptr(^Collection##Shadow, Q#ptr$2^0.0#dt3) } $in_range_phys_ptr($ref($ptr(^Collection##Shadow, Q#ptr$2^0.0#dt3))) ==> $ptr_eq($ptr(^Collection##Shadow, Q#ptr$2^0.0#dt3), $dot($ptr(^Collection, Q#ptr$2^0.0#dt3), Collection.Shadow)));

const unique l#public: $label;

const unique #loc.owns#21: $token;

const unique #loc.staticWrapState#20: $token;

const unique #loc.prestate#22: $token;

const unique #tok$1^91.30: $token;

const unique #loc.prestate#19: $token;

const unique #loc.prestate#17: $token;

const unique #loc.owns#18: $token;

const unique #loc.it: $token;

const unique #tok$1^85.1: $token;

const unique #tok$1^81.21: $token;

const unique #loc.owns#15: $token;

const unique #loc.staticWrapState#14: $token;

const unique #loc.prestate#16: $token;

const unique #tok$1^77.21: $token;

const unique #tok$1^78.30: $token;

const unique #loc.res_claim#1: $token;

const unique #tok$1^78.41: $token;

const unique #tok$1^76.28: $token;

const unique #tok$1^75.5: $token;

const unique #tok$1^74.5: $token;

const unique #tok$1^72.27: $token;

const unique #loc.iter: $token;

const unique #tok$1^72.10: $token;

const unique #tok$1^69.1: $token;

const unique #loc.owns#12: $token;

const unique #loc.staticWrapState#11: $token;

const unique #loc.prestate#13: $token;

const unique #tok$1^50.45: $token;

const unique #tok$1^52.18: $token;

const unique #tok$1^51.9: $token;

const unique #tok$1^47.5: $token;

const unique #tok$1^46.5: $token;

const unique #tok$1^44.30: $token;

const unique #loc.prestate#10: $token;

const unique #loc.prestate#8: $token;

const unique #loc.owns#9: $token;

const unique #loc.addr.x: $token;

const unique #loc.c: $token;

const unique #tok$1^37.1: $token;

const unique #tok$1^31.23: $token;

const unique #loc.owns#6: $token;

const unique #loc.staticWrapState#5: $token;

const unique #loc.prestate#7: $token;

const unique #tok$1^30.23: $token;

const unique #loc.owns#3: $token;

const unique #loc.staticWrapState#2: $token;

const unique #loc.prestate#4: $token;

const unique #tok$2^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(2, #file^?3Cno?20file?3E);

const unique #tok$1^29.7: $token;

const unique #tok$1^26.5: $token;

const unique #tok$1^25.5: $token;

const unique #tok$1^23.29: $token;

const unique #loc.coll: $token;

const unique #tok$1^23.10: $token;

const unique #tok$1^21.1: $token;

const unique #distTp5: $ctype;

axiom #distTp5 == $ptr_to(^Iterator);

const unique #tok$1^57.1: $token;

const unique #distTp4: $ctype;

axiom #distTp4 == $spec_ptr_to(^^claim);

const unique #distTp3: $ctype;

axiom #distTp3 == $ptr_to(^Collection##Shadow);

const unique #tok$1^8.19: $token;

const unique #distTp2: $ctype;

axiom #distTp2 == $ptr_to(^Collection);

const unique #loc._this_: $token;

const unique #tok$1^4.1: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CIterator.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CIterator.c);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^^i4);

function $state_to_int(x: $state) : int;

function $int_to_state(x: int) : $state;

axiom (forall #x: $state :: #x == $int_to_state($state_to_int(#x)));
