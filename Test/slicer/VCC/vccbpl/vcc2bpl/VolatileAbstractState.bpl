axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^Protector: $ctype;

axiom $is_composite(^Protector);

axiom $ptr_level(^Protector) == 0;

axiom $sizeof(^Protector) == 1;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Protector) } $inv2(#s1, #s2, #p, ^Protector) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty())));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^Protector, #r), l#public) } $inv_lab(#s2, $ptr(^Protector, #r), l#public) == ($typed(#s2, $ptr(^Protector, #r)) && $set_eq($owns(#s2, $ptr(^Protector, #r)), $set_empty())));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^Protector, #r)) } $in_full_extent_of(#q, $ptr(^Protector, #r)) == (#q == $ptr(^Protector, #r) || #q == $dot($ptr(^Protector, #r), Protector.$owns) || #q == $dot($ptr(^Protector, #r), Protector.dummy)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Protector, #r)) } $in_extent_of(#s, #q, $ptr(^Protector, #r)) == $in_struct_extent_of(#q, $ptr(^Protector, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Protector, #r)) } $typed(#s, $ptr(^Protector, #r)) ==> $in_extent_of(#s, #q, $ptr(^Protector, #r)) == (#q == $ptr(^Protector, #r) || $emb(#s, #q) == $ptr(^Protector, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^Protector, #r)) } $in_span_of(#q, $ptr(^Protector, #r)) == (#q == $ptr(^Protector, #r) || #q == $dot($ptr(^Protector, #r), Protector.$owns) || #q == $dot($ptr(^Protector, #r), Protector.dummy)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^Protector) } $state_spans_the_same(#s1, #s2, #p, ^Protector) == ($mem_eq(#s1, #s2, $dot(#p, Protector.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Protector.dummy))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Protector) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Protector) == ($mem_eq(#s1, #s2, $dot(#p, Protector.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Protector.dummy))));

axiom $is_claimable(^Protector) == true;

axiom $has_volatile_owns_set(^Protector) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^Protector, #r)) } $extent_mutable(#s1, $ptr(^Protector, #r)) == $mutable(#s1, $ptr(^Protector, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^Protector, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^Protector, #r)) == $is_fresh(#s1, #s2, $ptr(^Protector, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^Protector, #r)) } $extent_zero(#s1, $ptr(^Protector, #r)) == ($mem(#s1, $dot($ptr(^Protector, #r), Protector.dummy)) == 0));

const unique Protector.$owns: $field;

axiom $static_field_properties(Protector.$owns, ^Protector);

axiom $is_primitive_non_volatile_field(Protector.$owns);

axiom (forall #p: $ptr :: { $dot(#p, Protector.$owns) } $is(#p, ^Protector) ==> $dot(#p, Protector.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, Protector.$owns)) && $extent_hint($dot(#p, Protector.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Protector.$owns)) } { $st(#s, $dot(#p, Protector.$owns)) } $typed2(#s, #p, ^Protector) ==> $field_properties(#s, #p, Protector.$owns, ^$#ptrset, false));

axiom $owns_set_field(^Protector) == Protector.$owns;

const unique Protector.dummy: $field;

axiom $static_field_properties(Protector.dummy, ^Protector);

axiom $is_primitive_non_volatile_field(Protector.dummy);

axiom (forall #p: $ptr :: { $dot(#p, Protector.dummy) } $is(#p, ^Protector) ==> $dot(#p, Protector.dummy) == $ptr(^^i4, $ghost_ref(#p, Protector.dummy)) && $extent_hint($dot(#p, Protector.dummy), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Protector.dummy)) } { $st(#s, $dot(#p, Protector.dummy)) } $typed2(#s, #p, ^Protector) ==> $field_properties(#s, #p, Protector.dummy, ^^i4, false));

const unique ^AbstractStruct: $ctype;

axiom $is_composite(^AbstractStruct);

axiom $ptr_level(^AbstractStruct) == 0;

axiom $sizeof(^AbstractStruct) == 1;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^AbstractStruct) } $inv2(#s1, #s2, #p, ^AbstractStruct) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty()) && ($closed(#s2, $dot(#p, AbstractStruct.protector)) ==> $mem(#s1, $dot(#p, AbstractStruct.value)) == $mem(#s2, $dot(#p, AbstractStruct.value))) && ($mem(#s2, $dot(#p, AbstractStruct.value)) == $op_mul(2, $mem(#s1, $dot(#p, AbstractStruct.value))) || $mem(#s1, $dot(#p, AbstractStruct.value)) == $mem(#s2, $dot(#p, AbstractStruct.value)))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^AbstractStruct, #r), l#public) } $inv_lab(#s2, $ptr(^AbstractStruct, #r), l#public) == ($typed(#s2, $ptr(^AbstractStruct, #r)) && $set_eq($owns(#s2, $ptr(^AbstractStruct, #r)), $set_empty()) && ($mem(#s2, $dot($ptr(^AbstractStruct, #r), AbstractStruct.value)) == $op_mul(2, $mem(#s2, $dot($ptr(^AbstractStruct, #r), AbstractStruct.value))) || true)));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^AbstractStruct, #r)) } $in_full_extent_of(#q, $ptr(^AbstractStruct, #r)) == (#q == $ptr(^AbstractStruct, #r) || #q == $dot($ptr(^AbstractStruct, #r), AbstractStruct.$owns) || #q == $dot($ptr(^AbstractStruct, #r), AbstractStruct.value) || $in_full_extent_of(#q, $dot($ptr(^AbstractStruct, #r), AbstractStruct.protector))));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^AbstractStruct, #r)) } $in_extent_of(#s, #q, $ptr(^AbstractStruct, #r)) == $in_struct_extent_of(#q, $ptr(^AbstractStruct, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^AbstractStruct, #r)) } $in_span_of(#q, $ptr(^AbstractStruct, #r)) == (#q == $ptr(^AbstractStruct, #r) || #q == $dot($ptr(^AbstractStruct, #r), AbstractStruct.$owns) || #q == $dot($ptr(^AbstractStruct, #r), AbstractStruct.value)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^AbstractStruct) } $state_spans_the_same(#s1, #s2, #p, ^AbstractStruct) == ($mem_eq(#s1, #s2, $dot(#p, AbstractStruct.$owns)) && $mem_eq(#s1, #s2, $dot(#p, AbstractStruct.value))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^AbstractStruct) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^AbstractStruct) == $mem_eq(#s1, #s2, $dot(#p, AbstractStruct.$owns)));

axiom $is_claimable(^AbstractStruct) == true;

axiom $has_volatile_owns_set(^AbstractStruct) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^AbstractStruct, #r)) } $extent_mutable(#s1, $ptr(^AbstractStruct, #r)) == ($mutable(#s1, $ptr(^AbstractStruct, #r)) && $extent_mutable(#s1, $dot($ptr(^AbstractStruct, #r), AbstractStruct.protector))));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^AbstractStruct, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^AbstractStruct, #r)) == ($is_fresh(#s1, #s2, $ptr(^AbstractStruct, #r)) && $extent_is_fresh(#s1, #s2, $dot($ptr(^AbstractStruct, #r), AbstractStruct.protector))));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^AbstractStruct, #r)) } $extent_zero(#s1, $ptr(^AbstractStruct, #r)) == ($mem(#s1, $dot($ptr(^AbstractStruct, #r), AbstractStruct.value)) == 0 && $extent_zero(#s1, $dot($ptr(^AbstractStruct, #r), AbstractStruct.protector))));

const unique AbstractStruct.$owns: $field;

axiom $static_field_properties(AbstractStruct.$owns, ^AbstractStruct);

axiom $is_primitive_non_volatile_field(AbstractStruct.$owns);

axiom (forall #p: $ptr :: { $dot(#p, AbstractStruct.$owns) } $is(#p, ^AbstractStruct) ==> $dot(#p, AbstractStruct.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, AbstractStruct.$owns)) && $extent_hint($dot(#p, AbstractStruct.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, AbstractStruct.$owns)) } { $st(#s, $dot(#p, AbstractStruct.$owns)) } $typed2(#s, #p, ^AbstractStruct) ==> $field_properties(#s, #p, AbstractStruct.$owns, ^$#ptrset, false));

axiom $owns_set_field(^AbstractStruct) == AbstractStruct.$owns;

const unique AbstractStruct.value: $field;

axiom $static_field_properties(AbstractStruct.value, ^AbstractStruct);

axiom $is_primitive_volatile_field(AbstractStruct.value);

axiom (forall #p: $ptr :: { $dot(#p, AbstractStruct.value) } $is(#p, ^AbstractStruct) ==> $dot(#p, AbstractStruct.value) == $ptr(^^i4, $ghost_ref(#p, AbstractStruct.value)) && $extent_hint($dot(#p, AbstractStruct.value), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, AbstractStruct.value)) } { $st(#s, $dot(#p, AbstractStruct.value)) } $typed2(#s, #p, ^AbstractStruct) ==> $field_properties(#s, #p, AbstractStruct.value, ^^i4, true));

const unique AbstractStruct.protector: $field;

axiom $static_field_properties(AbstractStruct.protector, ^AbstractStruct);

axiom (forall #p: $ptr :: { $dot(#p, AbstractStruct.protector) } $is(#p, ^AbstractStruct) ==> $dot(#p, AbstractStruct.protector) == $ptr(^Protector, $ghost_ref(#p, AbstractStruct.protector)) && $extent_hint($dot(#p, AbstractStruct.protector), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, AbstractStruct.protector)) } { $st(#s, $dot(#p, AbstractStruct.protector)) } $typed2(#s, #p, ^AbstractStruct) ==> $field_properties(#s, #p, AbstractStruct.protector, ^Protector, false));

procedure AbstractStruct#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $set_eq($owns($s, $ptr(^AbstractStruct, P#_this_)), $set_empty());
  ensures $is_admissibility_check() ==> $closed($s, $dot($ptr(^AbstractStruct, P#_this_), AbstractStruct.protector)) ==> $mem(old($s), $dot($ptr(^AbstractStruct, P#_this_), AbstractStruct.value)) == $mem($s, $dot($ptr(^AbstractStruct, P#_this_), AbstractStruct.value));
  ensures $is_admissibility_check() ==> $mem($s, $dot($ptr(^AbstractStruct, P#_this_), AbstractStruct.value)) == $op_mul(2, $mem(old($s), $dot($ptr(^AbstractStruct, P#_this_), AbstractStruct.value))) || $mem(old($s), $dot($ptr(^AbstractStruct, P#_this_), AbstractStruct.value)) == $mem($s, $dot($ptr(^AbstractStruct, P#_this_), AbstractStruct.value));
  ensures $is_stuttering_check() ==> $closed($s, $dot($ptr(^AbstractStruct, P#_this_), AbstractStruct.protector)) ==> $mem($s, $dot($ptr(^AbstractStruct, P#_this_), AbstractStruct.value)) == $mem($s, $dot($ptr(^AbstractStruct, P#_this_), AbstractStruct.value));
  ensures $is_stuttering_check() ==> $mem($s, $dot($ptr(^AbstractStruct, P#_this_), AbstractStruct.value)) == $op_mul(2, $mem($s, $dot($ptr(^AbstractStruct, P#_this_), AbstractStruct.value))) || $mem($s, $dot($ptr(^AbstractStruct, P#_this_), AbstractStruct.value)) == $mem($s, $dot($ptr(^AbstractStruct, P#_this_), AbstractStruct.value));
  ensures $is_unwrap_check() ==> $set_eq($owns($s, $ptr(^AbstractStruct, P#_this_)), $set_empty());
  ensures $is_unwrap_check() ==> $closed($s, $dot($ptr(^AbstractStruct, P#_this_), AbstractStruct.protector)) ==> $mem(old($s), $dot($ptr(^AbstractStruct, P#_this_), AbstractStruct.value)) == $mem($s, $dot($ptr(^AbstractStruct, P#_this_), AbstractStruct.value));
  ensures $is_unwrap_check() ==> $mem($s, $dot($ptr(^AbstractStruct, P#_this_), AbstractStruct.value)) == $op_mul(2, $mem(old($s), $dot($ptr(^AbstractStruct, P#_this_), AbstractStruct.value))) || $mem(old($s), $dot($ptr(^AbstractStruct, P#_this_), AbstractStruct.value)) == $mem($s, $dot($ptr(^AbstractStruct, P#_this_), AbstractStruct.value));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation AbstractStruct#adm(P#_this_: int)
{
  var #wrTime$1^11.52: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^11.52, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^11.52, #loc._this_, $ptr_to_int($ptr(^AbstractStruct, P#_this_)), $spec_ptr_to(^AbstractStruct)) && $local_value_is_ptr($s, #tok$1^11.52, #loc._this_, $ptr(^AbstractStruct, P#_this_), $spec_ptr_to(^AbstractStruct));
    assume #wrTime$1^11.52 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^11.52, #p) } $in_writes_at(#wrTime$1^11.52, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^AbstractStruct, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^AbstractStruct, P#_this_));
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
            assume $admissibility_pre($s, $ptr(^AbstractStruct, P#_this_));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^AbstractStruct, P#_this_));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct AbstractStruct*)@null))
        call $havoc_others($ptr(^AbstractStruct, P#_this_), ^AbstractStruct);
        assume $good_state_ext(#tok$1^11.52, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^AbstractStruct, P#_this_), ^AbstractStruct);
    }

  #exit:
}



const unique ^ConcreteStruct: $ctype;

axiom $is_composite(^ConcreteStruct);

axiom $ptr_level(^ConcreteStruct) == 0;

axiom $sizeof(^ConcreteStruct) == 4;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^ConcreteStruct) } $inv2(#s1, #s2, #p, ^ConcreteStruct) == ($typed(#s2, #p) && $read_ptr(#s1, $dot(#p, ConcreteStruct.abs), ^AbstractStruct) == $read_ptr(#s2, $dot(#p, ConcreteStruct.abs), ^AbstractStruct) && $keeps(#s2, #p, $read_ptr(#s2, $dot(#p, ConcreteStruct.abs), ^AbstractStruct)) && $dot($read_ptr(#s1, $dot(#p, ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector) == $dot($read_ptr(#s2, $dot(#p, ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector) && $keeps(#s2, #p, $dot($read_ptr(#s2, $dot(#p, ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector)) && $ref_cnt(#s2, $dot($read_ptr(#s2, $dot(#p, ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector)) == 0 && $mem(#s2, $dot(#p, ConcreteStruct.value)) == $mem(#s2, $dot($read_ptr(#s2, $dot(#p, ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.value))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^ConcreteStruct, #r), l#public) } $inv_lab(#s2, $ptr(^ConcreteStruct, #r), l#public) == ($typed(#s2, $ptr(^ConcreteStruct, #r)) && $keeps(#s2, $ptr(^ConcreteStruct, #r), $read_ptr(#s2, $dot($ptr(^ConcreteStruct, #r), ConcreteStruct.abs), ^AbstractStruct)) && $keeps(#s2, $ptr(^ConcreteStruct, #r), $dot($read_ptr(#s2, $dot($ptr(^ConcreteStruct, #r), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector)) && $ref_cnt(#s2, $dot($read_ptr(#s2, $dot($ptr(^ConcreteStruct, #r), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector)) == 0 && $mem(#s2, $dot($ptr(^ConcreteStruct, #r), ConcreteStruct.value)) == $mem(#s2, $dot($read_ptr(#s2, $dot($ptr(^ConcreteStruct, #r), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.value))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^ConcreteStruct, #r)) } $in_full_extent_of(#q, $ptr(^ConcreteStruct, #r)) == (#q == $ptr(^ConcreteStruct, #r) || #q == $dot($ptr(^ConcreteStruct, #r), ConcreteStruct.$owns) || #q == $dot($ptr(^ConcreteStruct, #r), ConcreteStruct.value) || #q == $dot($ptr(^ConcreteStruct, #r), ConcreteStruct.abs)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^ConcreteStruct, #r)) } $in_extent_of(#s, #q, $ptr(^ConcreteStruct, #r)) == $in_struct_extent_of(#q, $ptr(^ConcreteStruct, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^ConcreteStruct, #r)) } $typed(#s, $ptr(^ConcreteStruct, #r)) ==> $in_extent_of(#s, #q, $ptr(^ConcreteStruct, #r)) == (#q == $ptr(^ConcreteStruct, #r) || $emb(#s, #q) == $ptr(^ConcreteStruct, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^ConcreteStruct, #r)) } $in_span_of(#q, $ptr(^ConcreteStruct, #r)) == (#q == $ptr(^ConcreteStruct, #r) || #q == $dot($ptr(^ConcreteStruct, #r), ConcreteStruct.$owns) || #q == $dot($ptr(^ConcreteStruct, #r), ConcreteStruct.value) || #q == $dot($ptr(^ConcreteStruct, #r), ConcreteStruct.abs)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^ConcreteStruct) } $state_spans_the_same(#s1, #s2, #p, ^ConcreteStruct) == ($mem_eq(#s1, #s2, $dot(#p, ConcreteStruct.$owns)) && $mem_eq(#s1, #s2, $dot(#p, ConcreteStruct.value)) && $mem_eq(#s1, #s2, $dot(#p, ConcreteStruct.abs))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^ConcreteStruct) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^ConcreteStruct) == ($mem_eq(#s1, #s2, $dot(#p, ConcreteStruct.$owns)) && $mem_eq(#s1, #s2, $dot(#p, ConcreteStruct.value)) && $mem_eq(#s1, #s2, $dot(#p, ConcreteStruct.abs))));

axiom $is_claimable(^ConcreteStruct) == false;

axiom $has_volatile_owns_set(^ConcreteStruct) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^ConcreteStruct, #r)) } $extent_mutable(#s1, $ptr(^ConcreteStruct, #r)) == $mutable(#s1, $ptr(^ConcreteStruct, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^ConcreteStruct, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^ConcreteStruct, #r)) == $is_fresh(#s1, #s2, $ptr(^ConcreteStruct, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^ConcreteStruct, #r)) } $extent_zero(#s1, $ptr(^ConcreteStruct, #r)) == ($mem(#s1, $dot($ptr(^ConcreteStruct, #r), ConcreteStruct.value)) == 0 && $mem(#s1, $dot($ptr(^ConcreteStruct, #r), ConcreteStruct.abs)) == 0));

const unique ConcreteStruct.$owns: $field;

axiom $static_field_properties(ConcreteStruct.$owns, ^ConcreteStruct);

axiom $is_primitive_non_volatile_field(ConcreteStruct.$owns);

axiom (forall #p: $ptr :: { $dot(#p, ConcreteStruct.$owns) } $is(#p, ^ConcreteStruct) ==> $dot(#p, ConcreteStruct.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, ConcreteStruct.$owns)) && $extent_hint($dot(#p, ConcreteStruct.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, ConcreteStruct.$owns)) } { $st(#s, $dot(#p, ConcreteStruct.$owns)) } $typed2(#s, #p, ^ConcreteStruct) ==> $field_properties(#s, #p, ConcreteStruct.$owns, ^$#ptrset, false));

axiom $owns_set_field(^ConcreteStruct) == ConcreteStruct.$owns;

const unique ConcreteStruct.value: $field;

axiom $static_field_properties(ConcreteStruct.value, ^ConcreteStruct);

axiom $is_primitive_non_volatile_field(ConcreteStruct.value);

axiom $field_offset(ConcreteStruct.value) == 0;

axiom (forall #p: $ptr :: { $dot(#p, ConcreteStruct.value) } $is(#p, ^ConcreteStruct) ==> $dot(#p, ConcreteStruct.value) == $ptr(^^i4, $ref(#p) + 0) && $extent_hint($dot(#p, ConcreteStruct.value), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, ConcreteStruct.value)) } { $st(#s, $dot(#p, ConcreteStruct.value)) } $typed2(#s, #p, ^ConcreteStruct) ==> $field_properties(#s, #p, ConcreteStruct.value, ^^i4, false));

const unique ConcreteStruct.abs: $field;

axiom $static_field_properties(ConcreteStruct.abs, ^ConcreteStruct);

axiom $is_primitive_non_volatile_field(ConcreteStruct.abs);

axiom (forall #p: $ptr :: { $dot(#p, ConcreteStruct.abs) } $is(#p, ^ConcreteStruct) ==> $dot(#p, ConcreteStruct.abs) == $ptr($ptr_to(^AbstractStruct), $ghost_ref(#p, ConcreteStruct.abs)) && $extent_hint($dot(#p, ConcreteStruct.abs), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, ConcreteStruct.abs)) } { $st(#s, $dot(#p, ConcreteStruct.abs)) } $typed2(#s, #p, ^ConcreteStruct) ==> $field_properties(#s, #p, ConcreteStruct.abs, $ptr_to(^AbstractStruct), false));

procedure ConcreteStruct#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $read_ptr(old($s), $dot($ptr(^ConcreteStruct, P#_this_), ConcreteStruct.abs), ^AbstractStruct) == $read_ptr($s, $dot($ptr(^ConcreteStruct, P#_this_), ConcreteStruct.abs), ^AbstractStruct);
  ensures $is_admissibility_check() ==> $keeps($s, $ptr(^ConcreteStruct, P#_this_), $read_ptr($s, $dot($ptr(^ConcreteStruct, P#_this_), ConcreteStruct.abs), ^AbstractStruct));
  ensures $is_admissibility_check() ==> $dot($read_ptr(old($s), $dot($ptr(^ConcreteStruct, P#_this_), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector) == $dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#_this_), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector);
  ensures $is_admissibility_check() ==> $keeps($s, $ptr(^ConcreteStruct, P#_this_), $dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#_this_), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector));
  ensures $is_admissibility_check() ==> $ref_cnt($s, $dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#_this_), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector)) == 0;
  ensures $is_admissibility_check() ==> $mem($s, $dot($ptr(^ConcreteStruct, P#_this_), ConcreteStruct.value)) == $mem($s, $dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#_this_), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.value));
  ensures $is_stuttering_check() ==> $read_ptr($s, $dot($ptr(^ConcreteStruct, P#_this_), ConcreteStruct.abs), ^AbstractStruct) == $read_ptr($s, $dot($ptr(^ConcreteStruct, P#_this_), ConcreteStruct.abs), ^AbstractStruct);
  ensures $is_stuttering_check() ==> $dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#_this_), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector) == $dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#_this_), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector);
  ensures $is_unwrap_check() ==> $read_ptr(old($s), $dot($ptr(^ConcreteStruct, P#_this_), ConcreteStruct.abs), ^AbstractStruct) == $read_ptr($s, $dot($ptr(^ConcreteStruct, P#_this_), ConcreteStruct.abs), ^AbstractStruct);
  ensures $is_unwrap_check() ==> $keeps($s, $ptr(^ConcreteStruct, P#_this_), $read_ptr($s, $dot($ptr(^ConcreteStruct, P#_this_), ConcreteStruct.abs), ^AbstractStruct));
  ensures $is_unwrap_check() ==> $dot($read_ptr(old($s), $dot($ptr(^ConcreteStruct, P#_this_), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector) == $dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#_this_), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector);
  ensures $is_unwrap_check() ==> $keeps($s, $ptr(^ConcreteStruct, P#_this_), $dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#_this_), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector));
  ensures $is_unwrap_check() ==> $ref_cnt($s, $dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#_this_), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector)) == 0;
  ensures $is_unwrap_check() ==> $mem($s, $dot($ptr(^ConcreteStruct, P#_this_), ConcreteStruct.value)) == $mem($s, $dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#_this_), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.value));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation ConcreteStruct#adm(P#_this_: int)
{
  var #wrTime$1^24.1: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^24.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^24.1, #loc._this_, $ptr_to_int($ptr(^ConcreteStruct, P#_this_)), $ptr_to(^ConcreteStruct)) && $local_value_is_ptr($s, #tok$1^24.1, #loc._this_, $ptr(^ConcreteStruct, P#_this_), $ptr_to(^ConcreteStruct));
    assume #wrTime$1^24.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^24.1, #p) } $in_writes_at(#wrTime$1^24.1, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon7:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^ConcreteStruct, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^ConcreteStruct, P#_this_));
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
            assume $admissibility_pre($s, $ptr(^ConcreteStruct, P#_this_));
        }
        else
        {
          anon9:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^ConcreteStruct, P#_this_));
        }

      anon11:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct ConcreteStruct*)@null))
        call $havoc_others($ptr(^ConcreteStruct, P#_this_), ^ConcreteStruct);
        assume $good_state_ext(#tok$1^24.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^ConcreteStruct, P#_this_), ^ConcreteStruct);
    }

  #exit:
}



procedure writeStruct(P#s: int, P#v: int) returns ($result: int);
  requires P#v == $op_mul(2, $mem($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.value)));
  requires $wrapped($s, $ptr(^ConcreteStruct, P#s), ^ConcreteStruct);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  ensures $wrapped($s, $ptr(^ConcreteStruct, P#s), ^ConcreteStruct);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^ConcreteStruct, P#s) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^ConcreteStruct, P#s) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^ConcreteStruct, P#s) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation writeStruct(P#s: int, P#v: int) returns ($result: int)
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
  var SL#c: int where $in_range_spec_ptr(SL#c);
  var SL#abs: int where $in_range_phys_ptr(SL#abs);
  var #wrTime$1^35.1: int;
  var #stackframe: int;

  anon14:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^35.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^35.1, #loc.s, $ptr_to_int($ptr(^ConcreteStruct, P#s)), $ptr_to(^ConcreteStruct)) && $local_value_is_ptr($s, #tok$1^35.1, #loc.s, $ptr(^ConcreteStruct, P#s), $ptr_to(^ConcreteStruct));
    assume $local_value_is($s, #tok$1^35.1, #loc.v, P#v, ^^i4);
    assume #wrTime$1^35.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^35.1, #p) } $in_writes_at(#wrTime$1^35.1, #p) == (#p == $ptr(^ConcreteStruct, P#s)));
    assume $thread_owned($s, $ptr(^ConcreteStruct, P#s));
    // assume @in_range_phys_ptr((mathint)s); 
    assume $in_range_phys_ptr($ref($ptr(^ConcreteStruct, P#s)));
    // assume @in_range_i4(v); 
    assume $in_range_i4(P#v);
    // assert @_vcc_in_domain(@state, s, s); 
    assert $in_domain_lab($s, $ptr(^ConcreteStruct, P#s), $ptr(^ConcreteStruct, P#s), l#public);
    // struct AbstractStruct* abs; 
    assume $local_value_is($s, #tok$1^44.33, #loc.abs, $ptr_to_int($ptr(^AbstractStruct, SL#abs)), $ptr_to(^AbstractStruct)) && $local_value_is_ptr($s, #tok$1^44.33, #loc.abs, $ptr(^AbstractStruct, SL#abs), $ptr_to(^AbstractStruct));
    // claim_t^ c; 
    assume $local_value_is($s, #tok$1^40.25, #loc.c, $ptr_to_int($ptr(^^claim, SL#c)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^40.25, #loc.c, $ptr(^^claim, SL#c), $spec_ptr_to(^^claim));
    // var spec claim_t^ c
    // assert @reads_check_normal((s->abs)); 
    assert $typed2($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), $ptr_to(^AbstractStruct));
    assert $thread_local2($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), $ptr_to(^AbstractStruct));
    // abs := *((s->abs)); 
    SL#abs := $ref($read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct));
    assume $local_value_is($s, #tok$1^44.33, #loc.abs, $ptr_to_int($ptr(^AbstractStruct, SL#abs)), $ptr_to(^AbstractStruct)) && $local_value_is_ptr($s, #tok$1^44.33, #loc.abs, $ptr(^AbstractStruct, SL#abs), $ptr_to(^AbstractStruct));
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
    assert $wrapped($s, $ptr(^ConcreteStruct, P#s), ^ConcreteStruct);
    // assert @writes_check(s); 
    assert $top_writable($s, #wrTime$1^35.1, $ptr(^ConcreteStruct, P#s));
    // assume @_vcc_inv(@state, s); 
    assume $inv($s, $ptr(^ConcreteStruct, P#s), ^ConcreteStruct);
    // prestate#3 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#3, s, (*((s->abs))->protector))); 
    prestate#3 := $release($current_state($s), prestate#3, $ptr(^ConcreteStruct, P#s), $dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#3, $state_to_int(prestate#3), ^$#state_t);
    // owns#2 := pure(@_vcc_set_union(owns#2, @_vcc_set_singleton((*((s->abs))->protector)))); 
    owns#2 := $set_union(owns#2, $set_singleton($dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#2, $ptrset_to_int(owns#2), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, (*((s->abs))->protector))); 
    assume $typed($s, $dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector));
    // prestate#3 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#3, s, *((s->abs)))); 
    prestate#3 := $release($current_state($s), prestate#3, $ptr(^ConcreteStruct, P#s), $read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#3, $state_to_int(prestate#3), ^$#state_t);
    // owns#2 := pure(@_vcc_set_union(owns#2, @_vcc_set_singleton(*((s->abs))))); 
    owns#2 := $set_union(owns#2, $set_singleton($read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#2, $ptrset_to_int(owns#2), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((s->abs)))); 
    assume $typed($s, $read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct));
    // assume ==(owns#2, @_vcc_owns(@state, s)); 
    assume owns#2 == $owns($s, $ptr(^ConcreteStruct, P#s));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(s), prestate#3)
    call $static_unwrap($ptr(^ConcreteStruct, P#s), prestate#3);
    assume $good_state_ext(#tok$1^51.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // c := @claim(pure(==(*((abs->value)), pure(old(@_vcc_when_claimed, *((abs->value)))))), (abs->protector), abs); 
    assert $closed($s, $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.protector));
    assert $top_writable($s, #wrTime$1^35.1, $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.protector));
    assert $is_claimable(^Protector);
    call $write_ref_cnt($dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.protector), $ref_cnt($s, $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.protector)) + 1);
    assume $ref_cnt($s, $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.protector)) >= 0;
    assert $closed($s, $ptr(^AbstractStruct, SL#abs));
    assert $top_writable($s, #wrTime$1^35.1, $ptr(^AbstractStruct, SL#abs));
    assert $is_claimable(^AbstractStruct);
    call $write_ref_cnt($ptr(^AbstractStruct, SL#abs), $ref_cnt($s, $ptr(^AbstractStruct, SL#abs)) + 1);
    assume $ref_cnt($s, $ptr(^AbstractStruct, SL#abs)) >= 0;
    claim#0s0 := $s;
    call claim#0 := $alloc_claim();
    assume $claims_obj(claim#0, $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.protector));
    assume $claims_obj(claim#0, $ptr(^AbstractStruct, SL#abs));
    SL#c := $ref(claim#0);
    assume $local_value_is($s, #tok$1^52.29, #loc.c, $ptr_to_int($ptr(^^claim, SL#c)), $spec_ptr_to(^^claim)) && $local_value_is_ptr($s, #tok$1^52.29, #loc.c, $ptr(^^claim, SL#c), $spec_ptr_to(^^claim));
    assume $full_stop_ext(#tok$1^52.29, $s);
    assume claim#0 != $no_claim ==> $claim_initial_assumptions($s, claim#0, #tok$1^52.29);
    assert claim#0 != $no_claim ==> $mem($s, $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.value)) == $mem($s, $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.value));
    if (claim#0doAdm)
    {
      anon13:
        assume $mem(claim#0s1, $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.value)) == $mem($s, $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.value));
        assume $valid_claim_impl(claim#0s0, claim#0s2);
        assume $claim_transitivity_assumptions(claim#0s1, claim#0s2, claim#0, #tok$1^52.29);
        assert $mem(claim#0s2, $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.value)) == $mem($s, $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.value));
        assume false;
    }

  anon15:
    assume claim#0 != $no_claim ==> (forall #cs0: $state :: { $valid_claim(#cs0, claim#0) } $valid_claim(#cs0, claim#0) ==> $mem(#cs0, $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.value)) == $mem($s, $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.value)));
    // assert @_vcc_typed2(@state, (s->value)); 
    assert $typed2($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.value), ^^i4);
    // assert @prim_writes_check((s->value)); 
    assert $writable($s, #wrTime$1^35.1, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.value));
    // *(s->value) := v; 
    call $write_int($dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.value), P#v);
    assume $full_stop_ext(#tok$1^54.3, $s);
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^56.19, $s);
    atomicObj#13 := $ptr(^AbstractStruct, SL#abs);
    // assert @_vcc_valid_claim(@state, c); 
    assert $valid_claim($s, $ptr(^^claim, SL#c));
    // assume @_vcc_valid_claim(@state, c); 
    assume $valid_claim($s, $ptr(^^claim, SL#c));
    // stmt @unclaim(c, (abs->protector), abs); 
    assert $top_writable($s, #wrTime$1^35.1, $ptr(^^claim, SL#c));
    assert $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.protector) != $ptr(^AbstractStruct, SL#abs);
    call $unclaim($ptr(^^claim, SL#c));
    assert $claims_obj($ptr(^^claim, SL#c), $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.protector));
    assert $top_writable($s, #wrTime$1^35.1, $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.protector));
    assert $is_claimable(^Protector);
    call $write_ref_cnt($dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.protector), $ref_cnt($s, $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.protector)) - 1);
    assume $ref_cnt($s, $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.protector)) >= 0;
    assert $claims_obj($ptr(^^claim, SL#c), $ptr(^AbstractStruct, SL#abs));
    assert $top_writable($s, #wrTime$1^35.1, $ptr(^AbstractStruct, SL#abs));
    assert $is_claimable(^AbstractStruct);
    call $write_ref_cnt($ptr(^AbstractStruct, SL#abs), $ref_cnt($s, $ptr(^AbstractStruct, SL#abs)) - 1);
    assume $ref_cnt($s, $ptr(^AbstractStruct, SL#abs)) >= 0;
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
    assert $wrapped($s, $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.protector), ^Protector);
    // assert @writes_check((abs->protector)); 
    assert $top_writable($s, #wrTime$1^35.1, $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.protector));
    // assume @_vcc_inv(@state, (abs->protector)); 
    assume $inv($s, $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.protector), ^Protector);
    // assume ==(owns#5, @_vcc_owns(@state, (abs->protector))); 
    assume owns#5 == $owns($s, $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.protector));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure((abs->protector)), prestate#6)
    call $static_unwrap($dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.protector), prestate#6);
    assume $good_state_ext(#tok$1^70.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    assert $closed($s, atomicObj#13);
    assume $inv($s, atomicObj#13, ^AbstractStruct);
    beforeAtomicState#0 := $s;
    // assert @_vcc_typed2(@state, (*((s->abs))->value)); 
    assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.value), ^^i4);
    // assert @prim_writes_check((*((s->abs))->value)); 
    assert $set_in($dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.value), $volatile_span($s, atomicObj#13)) || $writable($s, #wrTime$1^35.1, $dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.value));
    // assert @reads_check_normal((s->abs)); 
    assert $typed2($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), $ptr_to(^AbstractStruct));
    assert $thread_local2($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), $ptr_to(^AbstractStruct)) || $ptr(^ConcreteStruct, P#s) == atomicObj#13;
    // *(*((s->abs))->value) := v; 
    call $write_int($dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.value), P#v);
    assume $good_state_ext(#tok$1^77.27, $s);
    assert $set_eq($owns($s, atomicObj#13), $set_empty());
    assert $closed($s, $dot(atomicObj#13, AbstractStruct.protector)) ==> $mem(beforeAtomicState#0, $dot(atomicObj#13, AbstractStruct.value)) == $mem($s, $dot(atomicObj#13, AbstractStruct.value));
    assert $mem($s, $dot(atomicObj#13, AbstractStruct.value)) == $op_mul(2, $mem(beforeAtomicState#0, $dot(atomicObj#13, AbstractStruct.value))) || $mem(beforeAtomicState#0, $dot(atomicObj#13, AbstractStruct.value)) == $mem($s, $dot(atomicObj#13, AbstractStruct.value));
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
    assert $top_writable($s, #wrTime$1^35.1, $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.protector));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure((abs->protector)), staticWrapState#7, owns#8)
    call $static_wrap($dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.protector), staticWrapState#7, owns#8);
    assume $good_state_ext(#tok$1^80.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, (abs->protector)), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $dot($ptr(^AbstractStruct, SL#abs), AbstractStruct.protector)), $set_empty());
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
    assert $top_writable($s, #wrTime$1^35.1, $ptr(^ConcreteStruct, P#s));
    // assert @_vcc_wrapped(@state, (*((s->abs))->protector)); 
    assert $wrapped($s, $dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector), ^Protector);
    // assert @writes_check((*((s->abs))->protector)); 
    assert $top_writable($s, #wrTime$1^35.1, $dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector));
    // owns#11 := pure(@_vcc_set_union(owns#11, @_vcc_set_singleton((*((s->abs))->protector)))); 
    owns#11 := $set_union(owns#11, $set_singleton($dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#11, $ptrset_to_int(owns#11), ^$#ptrset);
    // staticWrapState#10 := pure(@_vcc_take_over(staticWrapState#10, s, (*((s->abs))->protector))); 
    staticWrapState#10 := $take_over(staticWrapState#10, $ptr(^ConcreteStruct, P#s), $dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#10, $state_to_int(staticWrapState#10), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((s->abs))); 
    assert $wrapped($s, $read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct), ^AbstractStruct);
    // assert @writes_check(*((s->abs))); 
    assert $top_writable($s, #wrTime$1^35.1, $read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct));
    // owns#11 := pure(@_vcc_set_union(owns#11, @_vcc_set_singleton(*((s->abs))))); 
    owns#11 := $set_union(owns#11, $set_singleton($read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#11, $ptrset_to_int(owns#11), ^$#ptrset);
    // staticWrapState#10 := pure(@_vcc_take_over(staticWrapState#10, s, *((s->abs)))); 
    staticWrapState#10 := $take_over(staticWrapState#10, $ptr(^ConcreteStruct, P#s), $read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#10, $state_to_int(staticWrapState#10), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(s), staticWrapState#10, owns#11)
    call $static_wrap($ptr(^ConcreteStruct, P#s), staticWrapState#10, owns#11);
    assume $good_state_ext(#tok$1^83.19, $s);
    // assert @inv_check(@keeps_stable(old(prestate#12, *((s->abs))), *((s->abs)))); 
    assert $read_ptr(prestate#12, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct) == $read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct);
    // assert @inv_check(@keeps(s, *((s->abs)))); 
    assert $keeps($s, $ptr(^ConcreteStruct, P#s), $read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct));
    // assert @inv_check(@keeps_stable(old(prestate#12, (*((s->abs))->protector)), (*((s->abs))->protector))); 
    assert $dot($read_ptr(prestate#12, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector) == $dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector);
    // assert @inv_check(@keeps(s, (*((s->abs))->protector))); 
    assert $keeps($s, $ptr(^ConcreteStruct, P#s), $dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector));
    // assert @inv_check(==(@_vcc_ref_cnt(@state, (*((s->abs))->protector)), 0)); 
    assert $ref_cnt($s, $dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.protector)) == 0;
    // assert @inv_check(==(*((s->value)), *((*((s->abs))->value)))); 
    assert $mem($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.value)) == $mem($s, $dot($read_ptr($s, $dot($ptr(^ConcreteStruct, P#s), ConcreteStruct.abs), ^AbstractStruct), AbstractStruct.value));
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

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CVolatileAbstractState.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CVolatileAbstractState.c);
