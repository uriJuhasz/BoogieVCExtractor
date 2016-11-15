axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^X: $ctype;

axiom $is_composite(^X);

axiom $ptr_level(^X) == 0;

axiom $sizeof(^X) == 4;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^X) } $inv2(#s1, #s2, #p, ^X) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty())));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^X, #r), l#public) } $inv_lab(#s2, $ptr(^X, #r), l#public) == ($typed(#s2, $ptr(^X, #r)) && $set_eq($owns(#s2, $ptr(^X, #r)), $set_empty())));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^X, #r)) } $in_full_extent_of(#q, $ptr(^X, #r)) == (#q == $ptr(^X, #r) || #q == $dot($ptr(^X, #r), X.$owns) || #q == $dot($ptr(^X, #r), X.y)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^X, #r)) } $in_extent_of(#s, #q, $ptr(^X, #r)) == $in_struct_extent_of(#q, $ptr(^X, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^X, #r)) } $typed(#s, $ptr(^X, #r)) ==> $in_extent_of(#s, #q, $ptr(^X, #r)) == (#q == $ptr(^X, #r) || $emb(#s, #q) == $ptr(^X, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^X, #r)) } $in_span_of(#q, $ptr(^X, #r)) == (#q == $ptr(^X, #r) || #q == $dot($ptr(^X, #r), X.$owns) || #q == $dot($ptr(^X, #r), X.y)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^X) } $state_spans_the_same(#s1, #s2, #p, ^X) == ($mem_eq(#s1, #s2, $dot(#p, X.$owns)) && $mem_eq(#s1, #s2, $dot(#p, X.y))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^X) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^X) == ($mem_eq(#s1, #s2, $dot(#p, X.$owns)) && $mem_eq(#s1, #s2, $dot(#p, X.y))));

axiom $is_claimable(^X) == false;

axiom $has_volatile_owns_set(^X) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^X, #r)) } $extent_mutable(#s1, $ptr(^X, #r)) == $mutable(#s1, $ptr(^X, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^X, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^X, #r)) == $is_fresh(#s1, #s2, $ptr(^X, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^X, #r)) } $extent_zero(#s1, $ptr(^X, #r)) == ($mem(#s1, $dot($ptr(^X, #r), X.y)) == 0));

const unique X.$owns: $field;

axiom $static_field_properties(X.$owns, ^X);

axiom $is_primitive_non_volatile_field(X.$owns);

axiom (forall #p: $ptr :: { $dot(#p, X.$owns) } $is(#p, ^X) ==> $dot(#p, X.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, X.$owns)) && $extent_hint($dot(#p, X.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, X.$owns)) } { $st(#s, $dot(#p, X.$owns)) } $typed2(#s, #p, ^X) ==> $field_properties(#s, #p, X.$owns, ^$#ptrset, false));

axiom $owns_set_field(^X) == X.$owns;

const unique X.y: $field;

axiom $static_field_properties(X.y, ^X);

axiom $is_primitive_non_volatile_field(X.y);

axiom $field_offset(X.y) == 0;

axiom (forall #p: $ptr :: { $dot(#p, X.y) } $is(#p, ^X) ==> $dot(#p, X.y) == $ptr(^^i4, $ref(#p) + 0) && $extent_hint($dot(#p, X.y), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, X.y)) } { $st(#s, $dot(#p, X.y)) } $typed2(#s, #p, ^X) ==> $field_properties(#s, #p, X.y, ^^i4, false));

const unique ^Data: $ctype;

axiom $is_composite(^Data);

axiom $ptr_level(^Data) == 0;

axiom $sizeof(^Data) == 4;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Data) } $inv2(#s1, #s2, #p, ^Data) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty()) && ($closed(#s1, #p) && !$closed(#s2, #p) ==> (forall Q#h$1^9.47#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^9.47#dt1))) ==> !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem(#s2, $dot(#p, Data.handles))), $ref($ptr(^Handle, Q#h$1^9.47#dt1))))) && $inv_is_owner_approved(#s1, #s2, #p, Data.handles) && (forall Q#h$1^12.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^12.29#dt1))) ==> $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem(#s1, $dot(#p, Data.handles))), $ref($ptr(^Handle, Q#h$1^12.29#dt1))) && !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem(#s2, $dot(#p, Data.handles))), $ref($ptr(^Handle, Q#h$1^12.29#dt1))) ==> !$closed(#s2, $ptr(^Handle, Q#h$1^12.29#dt1)))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^Data, #r), l#public) } $inv_lab(#s2, $ptr(^Data, #r), l#public) == ($typed(#s2, $ptr(^Data, #r)) && $set_eq($owns(#s2, $ptr(^Data, #r)), $set_empty()) && ($closed(#s2, $ptr(^Data, #r)) && !$closed(#s2, $ptr(^Data, #r)) ==> (forall Q#h$1^9.47#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^9.47#dt1))) ==> !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem(#s2, $dot($ptr(^Data, #r), Data.handles))), $ref($ptr(^Handle, Q#h$1^9.47#dt1))))) && $inv_is_owner_approved(#s2, #s2, $ptr(^Data, #r), Data.handles) && (forall Q#h$1^12.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^12.29#dt1))) ==> $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem(#s2, $dot($ptr(^Data, #r), Data.handles))), $ref($ptr(^Handle, Q#h$1^12.29#dt1))) && !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem(#s2, $dot($ptr(^Data, #r), Data.handles))), $ref($ptr(^Handle, Q#h$1^12.29#dt1))) ==> !$closed(#s2, $ptr(^Handle, Q#h$1^12.29#dt1)))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^Data, #r)) } $in_full_extent_of(#q, $ptr(^Data, #r)) == (#q == $ptr(^Data, #r) || #q == $dot($ptr(^Data, #r), Data.$owns) || #q == $dot($ptr(^Data, #r), Data.dummy) || #q == $dot($ptr(^Data, #r), Data.handles)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Data, #r)) } $in_extent_of(#s, #q, $ptr(^Data, #r)) == $in_struct_extent_of(#q, $ptr(^Data, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Data, #r)) } $typed(#s, $ptr(^Data, #r)) ==> $in_extent_of(#s, #q, $ptr(^Data, #r)) == (#q == $ptr(^Data, #r) || $emb(#s, #q) == $ptr(^Data, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^Data, #r)) } $in_span_of(#q, $ptr(^Data, #r)) == (#q == $ptr(^Data, #r) || #q == $dot($ptr(^Data, #r), Data.$owns) || #q == $dot($ptr(^Data, #r), Data.dummy) || #q == $dot($ptr(^Data, #r), Data.handles)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^Data) } $state_spans_the_same(#s1, #s2, #p, ^Data) == ($mem_eq(#s1, #s2, $dot(#p, Data.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Data.dummy)) && $mem_eq(#s1, #s2, $dot(#p, Data.handles))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Data) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Data) == ($mem_eq(#s1, #s2, $dot(#p, Data.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Data.dummy))));

axiom $is_claimable(^Data) == false;

axiom $has_volatile_owns_set(^Data) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^Data, #r)) } $extent_mutable(#s1, $ptr(^Data, #r)) == $mutable(#s1, $ptr(^Data, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^Data, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^Data, #r)) == $is_fresh(#s1, #s2, $ptr(^Data, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^Data, #r)) } $extent_zero(#s1, $ptr(^Data, #r)) == ($mem(#s1, $dot($ptr(^Data, #r), Data.dummy)) == 0 && $mem(#s1, $dot($ptr(^Data, #r), Data.handles)) == 0));

const unique Data.$owns: $field;

axiom $static_field_properties(Data.$owns, ^Data);

axiom $is_primitive_non_volatile_field(Data.$owns);

axiom (forall #p: $ptr :: { $dot(#p, Data.$owns) } $is(#p, ^Data) ==> $dot(#p, Data.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, Data.$owns)) && $extent_hint($dot(#p, Data.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Data.$owns)) } { $st(#s, $dot(#p, Data.$owns)) } $typed2(#s, #p, ^Data) ==> $field_properties(#s, #p, Data.$owns, ^$#ptrset, false));

axiom $owns_set_field(^Data) == Data.$owns;

const unique Data.dummy: $field;

axiom $static_field_properties(Data.dummy, ^Data);

axiom $is_primitive_non_volatile_field(Data.dummy);

axiom $field_offset(Data.dummy) == 0;

axiom (forall #p: $ptr :: { $dot(#p, Data.dummy) } $is(#p, ^Data) ==> $dot(#p, Data.dummy) == $ptr(^^i4, $ref(#p) + 0) && $extent_hint($dot(#p, Data.dummy), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Data.dummy)) } { $st(#s, $dot(#p, Data.dummy)) } $typed2(#s, #p, ^Data) ==> $field_properties(#s, #p, Data.dummy, ^^i4, false));

const unique Data.handles: $field;

axiom $static_field_properties(Data.handles, ^Data);

axiom $is_primitive_volatile_field(Data.handles);

axiom (forall #p: $ptr :: { $dot(#p, Data.handles) } $is(#p, ^Data) ==> $dot(#p, Data.handles) == $ptr($map_t($ptr_to(^Handle), ^^bool), $ghost_ref(#p, Data.handles)) && $extent_hint($dot(#p, Data.handles), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Data.handles)) } { $st(#s, $dot(#p, Data.handles)) } $typed2(#s, #p, ^Data) ==> $field_properties(#s, #p, Data.handles, $map_t($ptr_to(^Handle), ^^bool), true));

procedure Data#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $set_eq($owns($s, $ptr(^Data, P#_this_)), $set_empty());
  ensures $is_admissibility_check() ==> $closed(old($s), $ptr(^Data, P#_this_)) && !$closed($s, $ptr(^Data, P#_this_)) ==> (forall Q#h$1^9.47#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^9.47#dt1))) ==> !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem($s, $dot($ptr(^Data, P#_this_), Data.handles))), $ref($ptr(^Handle, Q#h$1^9.47#dt1))));
  ensures $is_admissibility_check() ==> $inv_is_owner_approved(old($s), $s, $ptr(^Data, P#_this_), Data.handles);
  ensures $is_admissibility_check() ==> (forall Q#h$1^12.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^12.29#dt1))) ==> $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem(old($s), $dot($ptr(^Data, P#_this_), Data.handles))), $ref($ptr(^Handle, Q#h$1^12.29#dt1))) && !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem($s, $dot($ptr(^Data, P#_this_), Data.handles))), $ref($ptr(^Handle, Q#h$1^12.29#dt1))) ==> !$closed($s, $ptr(^Handle, Q#h$1^12.29#dt1)));
  ensures $is_stuttering_check() ==> $closed($s, $ptr(^Data, P#_this_)) && !$closed($s, $ptr(^Data, P#_this_)) ==> (forall Q#h$1^9.47#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^9.47#dt1))) ==> !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem($s, $dot($ptr(^Data, P#_this_), Data.handles))), $ref($ptr(^Handle, Q#h$1^9.47#dt1))));
  ensures $is_stuttering_check() ==> $inv_is_owner_approved($s, $s, $ptr(^Data, P#_this_), Data.handles);
  ensures $is_stuttering_check() ==> (forall Q#h$1^12.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^12.29#dt1))) ==> $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem($s, $dot($ptr(^Data, P#_this_), Data.handles))), $ref($ptr(^Handle, Q#h$1^12.29#dt1))) && !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem($s, $dot($ptr(^Data, P#_this_), Data.handles))), $ref($ptr(^Handle, Q#h$1^12.29#dt1))) ==> !$closed($s, $ptr(^Handle, Q#h$1^12.29#dt1)));
  ensures $is_unwrap_check() ==> $set_eq($owns($s, $ptr(^Data, P#_this_)), $set_empty());
  ensures $is_unwrap_check() ==> $inv_is_owner_approved(old($s), $s, $ptr(^Data, P#_this_), Data.handles);
  ensures $is_unwrap_check() ==> (forall Q#h$1^12.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^12.29#dt1))) ==> $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem(old($s), $dot($ptr(^Data, P#_this_), Data.handles))), $ref($ptr(^Handle, Q#h$1^12.29#dt1))) && !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem($s, $dot($ptr(^Data, P#_this_), Data.handles))), $ref($ptr(^Handle, Q#h$1^12.29#dt1))) ==> !$closed($s, $ptr(^Handle, Q#h$1^12.29#dt1)));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Data#adm(P#_this_: int)
{
  var #wrTime$1^6.1: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^6.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^6.1, #loc._this_, $ptr_to_int($ptr(^Data, P#_this_)), $ptr_to(^Data)) && $local_value_is_ptr($s, #tok$1^6.1, #loc._this_, $ptr(^Data, P#_this_), $ptr_to(^Data));
    assume #wrTime$1^6.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^6.1, #p) } $in_writes_at(#wrTime$1^6.1, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^Data, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^Data, P#_this_));
        assume $good_state_ext(#tok$1^6.1, $s);
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
            assume $admissibility_pre($s, $ptr(^Data, P#_this_));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^Data, P#_this_));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Data*)@null))
        call $havoc_others($ptr(^Data, P#_this_), ^Data);
        assume $good_state_ext(#tok$1^6.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^Data, P#_this_), ^Data);
    }

  #exit:
}



axiom $is_owner_approved(^Data, Data.handles);

const unique ^Handle: $ctype;

axiom $is_composite(^Handle);

axiom $ptr_level(^Handle) == 0;

axiom $sizeof(^Handle) == 4;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Handle) } $inv2(#s1, #s2, #p, ^Handle) == ($typed(#s2, #p) && $set_eq($owns(#s2, #p), $set_empty()) && $typed2(#s2, #p, ^Handle) && !$is_ghost_ptr(#p) && $closed(#s2, $read_ptr(#s2, $dot(#p, Handle.data), ^Data)) && $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem(#s2, $dot($read_ptr(#s2, $dot(#p, Handle.data), ^Data), Data.handles))), $ref(#p))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^Handle, #r), l#public) } $inv_lab(#s2, $ptr(^Handle, #r), l#public) == ($typed(#s2, $ptr(^Handle, #r)) && $set_eq($owns(#s2, $ptr(^Handle, #r)), $set_empty()) && $typed2(#s2, $ptr(^Handle, #r), ^Handle) && !$is_ghost_ptr($ptr(^Handle, #r)) && $closed(#s2, $read_ptr(#s2, $dot($ptr(^Handle, #r), Handle.data), ^Data)) && $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem(#s2, $dot($read_ptr(#s2, $dot($ptr(^Handle, #r), Handle.data), ^Data), Data.handles))), $ref($ptr(^Handle, #r)))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^Handle, #r)) } $in_full_extent_of(#q, $ptr(^Handle, #r)) == (#q == $ptr(^Handle, #r) || #q == $dot($ptr(^Handle, #r), Handle.$owns) || #q == $dot($ptr(^Handle, #r), Handle.dummy) || #q == $dot($ptr(^Handle, #r), Handle.data)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Handle, #r)) } $in_extent_of(#s, #q, $ptr(^Handle, #r)) == $in_struct_extent_of(#q, $ptr(^Handle, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Handle, #r)) } $typed(#s, $ptr(^Handle, #r)) ==> $in_extent_of(#s, #q, $ptr(^Handle, #r)) == (#q == $ptr(^Handle, #r) || $emb(#s, #q) == $ptr(^Handle, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^Handle, #r)) } $in_span_of(#q, $ptr(^Handle, #r)) == (#q == $ptr(^Handle, #r) || #q == $dot($ptr(^Handle, #r), Handle.$owns) || #q == $dot($ptr(^Handle, #r), Handle.dummy) || #q == $dot($ptr(^Handle, #r), Handle.data)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^Handle) } $state_spans_the_same(#s1, #s2, #p, ^Handle) == ($mem_eq(#s1, #s2, $dot(#p, Handle.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Handle.dummy)) && $mem_eq(#s1, #s2, $dot(#p, Handle.data))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Handle) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Handle) == ($mem_eq(#s1, #s2, $dot(#p, Handle.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Handle.dummy)) && $mem_eq(#s1, #s2, $dot(#p, Handle.data))));

axiom $is_claimable(^Handle) == false;

axiom $has_volatile_owns_set(^Handle) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^Handle, #r)) } $extent_mutable(#s1, $ptr(^Handle, #r)) == $mutable(#s1, $ptr(^Handle, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^Handle, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^Handle, #r)) == $is_fresh(#s1, #s2, $ptr(^Handle, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^Handle, #r)) } $extent_zero(#s1, $ptr(^Handle, #r)) == ($mem(#s1, $dot($ptr(^Handle, #r), Handle.dummy)) == 0 && $mem(#s1, $dot($ptr(^Handle, #r), Handle.data)) == 0));

const unique Handle.$owns: $field;

axiom $static_field_properties(Handle.$owns, ^Handle);

axiom $is_primitive_non_volatile_field(Handle.$owns);

axiom (forall #p: $ptr :: { $dot(#p, Handle.$owns) } $is(#p, ^Handle) ==> $dot(#p, Handle.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, Handle.$owns)) && $extent_hint($dot(#p, Handle.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Handle.$owns)) } { $st(#s, $dot(#p, Handle.$owns)) } $typed2(#s, #p, ^Handle) ==> $field_properties(#s, #p, Handle.$owns, ^$#ptrset, false));

axiom $owns_set_field(^Handle) == Handle.$owns;

const unique Handle.dummy: $field;

axiom $static_field_properties(Handle.dummy, ^Handle);

axiom $is_primitive_non_volatile_field(Handle.dummy);

axiom $field_offset(Handle.dummy) == 0;

axiom (forall #p: $ptr :: { $dot(#p, Handle.dummy) } $is(#p, ^Handle) ==> $dot(#p, Handle.dummy) == $ptr(^^i4, $ref(#p) + 0) && $extent_hint($dot(#p, Handle.dummy), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Handle.dummy)) } { $st(#s, $dot(#p, Handle.dummy)) } $typed2(#s, #p, ^Handle) ==> $field_properties(#s, #p, Handle.dummy, ^^i4, false));

const unique Handle.data: $field;

axiom $static_field_properties(Handle.data, ^Handle);

axiom $is_primitive_non_volatile_field(Handle.data);

axiom (forall #p: $ptr :: { $dot(#p, Handle.data) } $is(#p, ^Handle) ==> $dot(#p, Handle.data) == $ptr($ptr_to(^Data), $ghost_ref(#p, Handle.data)) && $extent_hint($dot(#p, Handle.data), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Handle.data)) } { $st(#s, $dot(#p, Handle.data)) } $typed2(#s, #p, ^Handle) ==> $field_properties(#s, #p, Handle.data, $ptr_to(^Data), false));

procedure Handle#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $set_eq($owns($s, $ptr(^Handle, P#_this_)), $set_empty());
  ensures $is_admissibility_check() ==> $typed2($s, $ptr(^Handle, P#_this_), ^Handle);
  ensures $is_admissibility_check() ==> !$is_ghost_ptr($ptr(^Handle, P#_this_));
  ensures $is_admissibility_check() ==> $closed($s, $read_ptr($s, $dot($ptr(^Handle, P#_this_), Handle.data), ^Data));
  ensures $is_admissibility_check() ==> $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem($s, $dot($read_ptr($s, $dot($ptr(^Handle, P#_this_), Handle.data), ^Data), Data.handles))), $ref($ptr(^Handle, P#_this_)));
  ensures $is_unwrap_check() ==> $set_eq($owns($s, $ptr(^Handle, P#_this_)), $set_empty());
  ensures $is_unwrap_check() ==> $typed2($s, $ptr(^Handle, P#_this_), ^Handle);
  ensures $is_unwrap_check() ==> !$is_ghost_ptr($ptr(^Handle, P#_this_));
  ensures $is_unwrap_check() ==> $closed($s, $read_ptr($s, $dot($ptr(^Handle, P#_this_), Handle.data), ^Data));
  ensures $is_unwrap_check() ==> $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem($s, $dot($read_ptr($s, $dot($ptr(^Handle, P#_this_), Handle.data), ^Data), Data.handles))), $ref($ptr(^Handle, P#_this_)));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Handle#adm(P#_this_: int)
{
  var #wrTime$1^15.1: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^15.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^15.1, #loc._this_, $ptr_to_int($ptr(^Handle, P#_this_)), $ptr_to(^Handle)) && $local_value_is_ptr($s, #tok$1^15.1, #loc._this_, $ptr(^Handle, P#_this_), $ptr_to(^Handle));
    assume #wrTime$1^15.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^15.1, #p) } $in_writes_at(#wrTime$1^15.1, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon7:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^Handle, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^Handle, P#_this_));
        assume $good_state_ext(#tok$1^15.1, $s);
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
            assume $admissibility_pre($s, $ptr(^Handle, P#_this_));
        }
        else
        {
          anon9:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^Handle, P#_this_));
        }

      anon11:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Handle*)@null))
        call $havoc_others($ptr(^Handle, P#_this_), ^Handle);
        assume $good_state_ext(#tok$1^15.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^Handle, P#_this_), ^Handle);
    }

  #exit:
}



const unique ^Container: $ctype;

axiom $is_composite(^Container);

axiom $ptr_level(^Container) == 0;

axiom $sizeof(^Container) == 12;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Container) } $inv2(#s1, #s2, #p, ^Container) == ($typed(#s2, #p) && $dot(#p, Container.d) == $dot(#p, Container.d) && $keeps(#s2, #p, $dot(#p, Container.d)) && (forall Q#hh$1^69.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#hh$1^69.29#dt1))) ==> $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem(#s2, $dot($dot(#p, Container.d), Data.handles))), $ref($ptr(^Handle, Q#hh$1^69.29#dt1))) ==> $ptr_eq($ptr(^Handle, Q#hh$1^69.29#dt1), $dot(#p, Container.h)) || $ptr_eq($ptr(^Handle, Q#hh$1^69.29#dt1), $dot(#p, Container.h2)))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^Container, #r), l#public) } $inv_lab(#s2, $ptr(^Container, #r), l#public) == ($typed(#s2, $ptr(^Container, #r)) && $keeps(#s2, $ptr(^Container, #r), $dot($ptr(^Container, #r), Container.d)) && (forall Q#hh$1^69.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#hh$1^69.29#dt1))) ==> $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem(#s2, $dot($dot($ptr(^Container, #r), Container.d), Data.handles))), $ref($ptr(^Handle, Q#hh$1^69.29#dt1))) ==> $ptr_eq($ptr(^Handle, Q#hh$1^69.29#dt1), $dot($ptr(^Container, #r), Container.h)) || $ptr_eq($ptr(^Handle, Q#hh$1^69.29#dt1), $dot($ptr(^Container, #r), Container.h2)))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^Container, #r)) } $in_full_extent_of(#q, $ptr(^Container, #r)) == (#q == $ptr(^Container, #r) || #q == $dot($ptr(^Container, #r), Container.$owns) || $in_full_extent_of(#q, $dot($ptr(^Container, #r), Container.d)) || $in_full_extent_of(#q, $dot($ptr(^Container, #r), Container.h)) || $in_full_extent_of(#q, $dot($ptr(^Container, #r), Container.h2))));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Container, #r)) } $in_extent_of(#s, #q, $ptr(^Container, #r)) == $in_struct_extent_of(#q, $ptr(^Container, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^Container, #r)) } $in_span_of(#q, $ptr(^Container, #r)) == (#q == $ptr(^Container, #r) || #q == $dot($ptr(^Container, #r), Container.$owns)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^Container) } $state_spans_the_same(#s1, #s2, #p, ^Container) == $mem_eq(#s1, #s2, $dot(#p, Container.$owns)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Container) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Container) == $mem_eq(#s1, #s2, $dot(#p, Container.$owns)));

axiom $is_claimable(^Container) == false;

axiom $has_volatile_owns_set(^Container) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^Container, #r)) } $extent_mutable(#s1, $ptr(^Container, #r)) == ($mutable(#s1, $ptr(^Container, #r)) && $extent_mutable(#s1, $dot($ptr(^Container, #r), Container.d)) && $extent_mutable(#s1, $dot($ptr(^Container, #r), Container.h)) && $extent_mutable(#s1, $dot($ptr(^Container, #r), Container.h2))));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^Container, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^Container, #r)) == ($is_fresh(#s1, #s2, $ptr(^Container, #r)) && $extent_is_fresh(#s1, #s2, $dot($ptr(^Container, #r), Container.d)) && $extent_is_fresh(#s1, #s2, $dot($ptr(^Container, #r), Container.h)) && $extent_is_fresh(#s1, #s2, $dot($ptr(^Container, #r), Container.h2))));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^Container, #r)) } $extent_zero(#s1, $ptr(^Container, #r)) == ($extent_zero(#s1, $dot($ptr(^Container, #r), Container.d)) && $extent_zero(#s1, $dot($ptr(^Container, #r), Container.h)) && $extent_zero(#s1, $dot($ptr(^Container, #r), Container.h2))));

const unique Container.$owns: $field;

axiom $static_field_properties(Container.$owns, ^Container);

axiom $is_primitive_non_volatile_field(Container.$owns);

axiom (forall #p: $ptr :: { $dot(#p, Container.$owns) } $is(#p, ^Container) ==> $dot(#p, Container.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, Container.$owns)) && $extent_hint($dot(#p, Container.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Container.$owns)) } { $st(#s, $dot(#p, Container.$owns)) } $typed2(#s, #p, ^Container) ==> $field_properties(#s, #p, Container.$owns, ^$#ptrset, false));

axiom $owns_set_field(^Container) == Container.$owns;

const unique Container.d: $field;

axiom $static_field_properties(Container.d, ^Container);

axiom $field_offset(Container.d) == 0;

axiom (forall #p: $ptr :: { $dot(#p, Container.d) } $is(#p, ^Container) ==> $dot(#p, Container.d) == $ptr(^Data, $ref(#p) + 0) && $extent_hint($dot(#p, Container.d), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Container.d)) } { $st(#s, $dot(#p, Container.d)) } $typed2(#s, #p, ^Container) ==> $field_properties(#s, #p, Container.d, ^Data, false));

const unique Container.h: $field;

axiom $static_field_properties(Container.h, ^Container);

axiom $field_offset(Container.h) == 4;

axiom (forall #p: $ptr :: { $dot(#p, Container.h) } $is(#p, ^Container) ==> $dot(#p, Container.h) == $ptr(^Handle, $ref(#p) + 4) && $extent_hint($dot(#p, Container.h), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Container.h)) } { $st(#s, $dot(#p, Container.h)) } $typed2(#s, #p, ^Container) ==> $field_properties(#s, #p, Container.h, ^Handle, false));

const unique Container.h2: $field;

axiom $static_field_properties(Container.h2, ^Container);

axiom $field_offset(Container.h2) == 8;

axiom (forall #p: $ptr :: { $dot(#p, Container.h2) } $is(#p, ^Container) ==> $dot(#p, Container.h2) == $ptr(^Handle, $ref(#p) + 8) && $extent_hint($dot(#p, Container.h2), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Container.h2)) } { $st(#s, $dot(#p, Container.h2)) } $typed2(#s, #p, ^Container) ==> $field_properties(#s, #p, Container.h2, ^Handle, false));

procedure Container#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $dot($ptr(^Container, P#_this_), Container.d) == $dot($ptr(^Container, P#_this_), Container.d);
  ensures $is_admissibility_check() ==> $keeps($s, $ptr(^Container, P#_this_), $dot($ptr(^Container, P#_this_), Container.d));
  ensures $is_admissibility_check() ==> (forall Q#hh$1^69.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#hh$1^69.29#dt1))) ==> $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem($s, $dot($dot($ptr(^Container, P#_this_), Container.d), Data.handles))), $ref($ptr(^Handle, Q#hh$1^69.29#dt1))) ==> $ptr_eq($ptr(^Handle, Q#hh$1^69.29#dt1), $dot($ptr(^Container, P#_this_), Container.h)) || $ptr_eq($ptr(^Handle, Q#hh$1^69.29#dt1), $dot($ptr(^Container, P#_this_), Container.h2)));
  ensures $is_stuttering_check() ==> $dot($ptr(^Container, P#_this_), Container.d) == $dot($ptr(^Container, P#_this_), Container.d);
  ensures $is_unwrap_check() ==> $dot($ptr(^Container, P#_this_), Container.d) == $dot($ptr(^Container, P#_this_), Container.d);
  ensures $is_unwrap_check() ==> $keeps($s, $ptr(^Container, P#_this_), $dot($ptr(^Container, P#_this_), Container.d));
  ensures $is_unwrap_check() ==> (forall Q#hh$1^69.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#hh$1^69.29#dt1))) ==> $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem($s, $dot($dot($ptr(^Container, P#_this_), Container.d), Data.handles))), $ref($ptr(^Handle, Q#hh$1^69.29#dt1))) ==> $ptr_eq($ptr(^Handle, Q#hh$1^69.29#dt1), $dot($ptr(^Container, P#_this_), Container.h)) || $ptr_eq($ptr(^Handle, Q#hh$1^69.29#dt1), $dot($ptr(^Container, P#_this_), Container.h2)));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Container#adm(P#_this_: int)
{
  var #wrTime$1^63.1: int;
  var #stackframe: int;

  anon18:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^63.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^63.1, #loc._this_, $ptr_to_int($ptr(^Container, P#_this_)), $ptr_to(^Container)) && $local_value_is_ptr($s, #tok$1^63.1, #loc._this_, $ptr(^Container, P#_this_), $ptr_to(^Container));
    assume #wrTime$1^63.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^63.1, #p) } $in_writes_at(#wrTime$1^63.1, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon13:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^Container, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^Container, P#_this_));
        assume $good_state_ext(#tok$1^63.1, $s);
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
            assume $admissibility_pre($s, $ptr(^Container, P#_this_));
        }
        else
        {
          anon15:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^Container, P#_this_));
        }

      anon17:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Container*)@null))
        call $havoc_others($ptr(^Container, P#_this_), ^Container);
        assume $good_state_ext(#tok$1^63.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^Container, P#_this_), ^Container);
    }

  #exit:
}



procedure foo(P#x: int);
  requires $mutable($s, $ptr(^X, P#x));
  requires $is_object_root($s, $ptr(^X, P#x));
  modifies $s, $cev_pc;
  ensures $mutable($s, $ptr(^X, P#x)) && $is_object_root($s, $ptr(^X, P#x));
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $extent(old($s), $ptr(^X, P#x))) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $extent(old($s), $ptr(^X, P#x))) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $extent(old($s), $ptr(^X, P#x))) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



procedure wrapped_use();
  modifies $s, $cev_pc;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation wrapped_use()
{
  var prestate#22: $state;
  var prestate#20: $state;
  var owns#21: $ptrset;
  var res_lambda#3#8: $map_t..$ptr_to..^Handle.^^bool;
  var beforeAtomicState#1: $state;
  var prestate#19: $state;
  var prestate#17: $state;
  var owns#18: $ptrset;
  var atomicObj#33: $ptr;
  var owns#15: $ptrset;
  var staticWrapState#14: $state;
  var prestate#16: $state;
  var res_lambda#2#7: $map_t..$ptr_to..^Handle.^^bool;
  var beforeAtomicState#0: $state;
  var atomicObj#32: $ptr;
  var owns#12: $ptrset;
  var staticWrapState#11: $state;
  var prestate#13: $state;
  var res_lambda#1#6: $map_t..$ptr_to..^Handle.^^bool;
  var #callConv#2: $ptr;
  var addr.d: int where $in_range_phys_ptr(addr.d);
  var #callConv#1: $ptr;
  var addr.h: int where $in_range_phys_ptr(addr.h);
  var #callConv#0: $ptr;
  var addr.x: int where $in_range_phys_ptr(addr.x);
  var #wrTime$1^23.1: int;
  var #stackframe: int;

  anon19:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^23.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^23.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^23.1, #p) } $in_writes_at(#wrTime$1^23.1, #p) == false);
    // struct X* addr.x; 
    assume $local_value_is($s, #tok$1^23.1, #loc.addr.x, $ptr_to_int($ptr(^X, addr.x)), $ptr_to(^X)) && $local_value_is_ptr($s, #tok$1^23.1, #loc.addr.x, $ptr(^X, addr.x), $ptr_to(^X));
    // addr.x := _vcc_stack_alloc<struct X>(@stackframe, false); 
    call #callConv#0 := $stack_alloc(^X, #stackframe, false);
    assume $full_stop_ext(#tok$1^23.1, $s);
    addr.x := $ref(#callConv#0);
    assume $local_value_is($s, #tok$1^23.1, #loc.addr.x, $ptr_to_int($ptr(^X, addr.x)), $ptr_to(^X)) && $local_value_is_ptr($s, #tok$1^23.1, #loc.addr.x, $ptr(^X, addr.x), $ptr_to(^X));
    // struct Handle* addr.h; 
    assume $local_value_is($s, #tok$1^23.1, #loc.addr.h, $ptr_to_int($ptr(^Handle, addr.h)), $ptr_to(^Handle)) && $local_value_is_ptr($s, #tok$1^23.1, #loc.addr.h, $ptr(^Handle, addr.h), $ptr_to(^Handle));
    // addr.h := _vcc_stack_alloc<struct Handle>(@stackframe, false); 
    call #callConv#1 := $stack_alloc(^Handle, #stackframe, false);
    assume $full_stop_ext(#tok$1^23.1, $s);
    addr.h := $ref(#callConv#1);
    assume $local_value_is($s, #tok$1^23.1, #loc.addr.h, $ptr_to_int($ptr(^Handle, addr.h)), $ptr_to(^Handle)) && $local_value_is_ptr($s, #tok$1^23.1, #loc.addr.h, $ptr(^Handle, addr.h), $ptr_to(^Handle));
    // struct Data* addr.d; 
    assume $local_value_is($s, #tok$1^23.1, #loc.addr.d, $ptr_to_int($ptr(^Data, addr.d)), $ptr_to(^Data)) && $local_value_is_ptr($s, #tok$1^23.1, #loc.addr.d, $ptr(^Data, addr.d), $ptr_to(^Data));
    // addr.d := _vcc_stack_alloc<struct Data>(@stackframe, false); 
    call #callConv#2 := $stack_alloc(^Data, #stackframe, false);
    assume $full_stop_ext(#tok$1^23.1, $s);
    addr.d := $ref(#callConv#2);
    assume $local_value_is($s, #tok$1^23.1, #loc.addr.d, $ptr_to_int($ptr(^Data, addr.d)), $ptr_to(^Data)) && $local_value_is_ptr($s, #tok$1^23.1, #loc.addr.d, $ptr(^Data, addr.d), $ptr_to(^Data));
    // var struct Data d
    // var struct Handle h
    // var struct X x
    // (struct Handle* -> _Bool) res_lambda#1#6; 
    assume $local_value_is($s, #tok$1^31.16, #loc.res_lambda#1#6, $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#1#6), $map_t($ptr_to(^Handle), ^^bool));
    // res_lambda#1#6 := lambda#1(); 
    call res_lambda#1#6 := lambda#1();
    assume $full_stop_ext(#tok$1^31.16, $s);
    assume $local_value_is($s, #tok$1^31.16, #loc.res_lambda#1#6, $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#1#6), $map_t($ptr_to(^Handle), ^^bool));
    // assert @_vcc_typed2(@state, (addr.d->handles)); 
    assert $typed2($s, $dot($ptr(^Data, addr.d), Data.handles), $map_t($ptr_to(^Handle), ^^bool));
    // assert @prim_writes_check((addr.d->handles)); 
    assert $writable($s, #wrTime$1^23.1, $dot($ptr(^Data, addr.d), Data.handles));
    // *(addr.d->handles) := res_lambda#1#6; 
    call $write_int($dot($ptr(^Data, addr.d), Data.handles), $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#1#6));
    assume $full_stop_ext(#tok$1^31.3, $s);
    // assert forall(struct Handle* h; @in_range_phys_ptr((mathint)h); ==>(@_vcc_ptr_eq(*((h->data)), addr.d), unchecked!(@_vcc_inv(@state, h)))); 
    assert (forall Q#h$1^32.26#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^32.26#dt1))) ==> $ptr_eq($read_ptr($s, $dot($ptr(^Handle, Q#h$1^32.26#dt1), Handle.data), ^Data), $ptr(^Data, addr.d)) ==> !$inv($s, $ptr(^Handle, Q#h$1^32.26#dt1), ^Handle));
    // assume forall(struct Handle* h; @in_range_phys_ptr((mathint)h); ==>(@_vcc_ptr_eq(*((h->data)), addr.d), unchecked!(@_vcc_inv(@state, h)))); 
    assume (forall Q#h$1^32.26#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^32.26#dt1))) ==> $ptr_eq($read_ptr($s, $dot($ptr(^Handle, Q#h$1^32.26#dt1), Handle.data), ^Data), $ptr(^Data, addr.d)) ==> !$inv($s, $ptr(^Handle, Q#h$1^32.26#dt1), ^Handle));
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
    // assert @writes_check(addr.d); 
    assert $top_writable($s, #wrTime$1^23.1, $ptr(^Data, addr.d));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(addr.d), staticWrapState#11, owns#12)
    call $static_wrap($ptr(^Data, addr.d), staticWrapState#11, owns#12);
    assume $good_state_ext(#tok$1^33.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, addr.d), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^Data, addr.d)), $set_empty());
    // assert @inv_check(@_vcc_inv_is_owner_approved(old(prestate#13, @state), @state, addr.d, @field(userdata(__spec volatile (struct Handle* -> _Bool) handles /* @0 */) : Field))); 
    assert $inv_is_owner_approved(prestate#13, $s, $ptr(^Data, addr.d), Data.handles);
    // assert @inv_check(forall(struct Handle* h; @in_range_phys_ptr((mathint)h); ==>(&&(old(prestate#13, @map_get(*((addr.d->handles)), h)), unchecked!(@map_get(*((addr.d->handles)), h))), unchecked!(@_vcc_closed(@state, h))))); 
    assert (forall Q#h$1^12.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^12.29#dt1))) ==> $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem(prestate#13, $dot($ptr(^Data, addr.d), Data.handles))), $ref($ptr(^Handle, Q#h$1^12.29#dt1))) && !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem($s, $dot($ptr(^Data, addr.d), Data.handles))), $ref($ptr(^Handle, Q#h$1^12.29#dt1))) ==> !$closed($s, $ptr(^Handle, Q#h$1^12.29#dt1)));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_in_domain(@state, addr.d, addr.d); 
    assert $in_domain_lab($s, $ptr(^Data, addr.d), $ptr(^Data, addr.d), l#public);
    // assume @_vcc_in_domain(@state, addr.d, addr.d); 
    assume $in_domain_lab($s, $ptr(^Data, addr.d), $ptr(^Data, addr.d), l#public);
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^36.19, $s);
    atomicObj#32 := $ptr(^Data, addr.d);
    assert $closed($s, atomicObj#32);
    assume $inv($s, atomicObj#32, ^Data);
    beforeAtomicState#0 := $s;
    // (struct Handle* -> _Bool) res_lambda#2#7; 
    assume $local_value_is($s, #tok$1^37.18, #loc.res_lambda#2#7, $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#2#7), $map_t($ptr_to(^Handle), ^^bool));
    // res_lambda#2#7 := lambda#2(addr.h); 
    call res_lambda#2#7 := lambda#2($ref($ptr(^Handle, addr.h)));
    assume $good_state_ext(#tok$1^37.18, $s);
    assume $local_value_is($s, #tok$1^37.18, #loc.res_lambda#2#7, $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#2#7), $map_t($ptr_to(^Handle), ^^bool));
    // assert @_vcc_typed2(@state, (addr.d->handles)); 
    assert $typed2($s, $dot($ptr(^Data, addr.d), Data.handles), $map_t($ptr_to(^Handle), ^^bool));
    // assert @prim_writes_check((addr.d->handles)); 
    assert $set_in($dot($ptr(^Data, addr.d), Data.handles), $volatile_span($s, atomicObj#32)) || $writable($s, #wrTime$1^23.1, $dot($ptr(^Data, addr.d), Data.handles));
    // *(addr.d->handles) := res_lambda#2#7; 
    call $write_int($dot($ptr(^Data, addr.d), Data.handles), $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#2#7));
    assume $good_state_ext(#tok$1^37.5, $s);
    // assert @writes_check(addr.d); 
    assert $top_writable($s, #wrTime$1^23.1, $ptr(^Data, addr.d));
    // stmt _vcc_bump_volatile_version(addr.d); 
    call $bump_volatile_version($ptr(^Data, addr.d));
    assume $good_state_ext(#tok$1^38.21, $s);
    assert $set_eq($owns($s, atomicObj#32), $set_empty());
    assert $closed(beforeAtomicState#0, atomicObj#32) && !$closed($s, atomicObj#32) ==> (forall Q#h$1^9.47#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^9.47#dt1))) ==> !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem($s, $dot(atomicObj#32, Data.handles))), $ref($ptr(^Handle, Q#h$1^9.47#dt1))));
    assert $inv_is_owner_approved(beforeAtomicState#0, $s, atomicObj#32, Data.handles);
    assert (forall Q#h$1^12.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^12.29#dt1))) ==> $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem(beforeAtomicState#0, $dot(atomicObj#32, Data.handles))), $ref($ptr(^Handle, Q#h$1^12.29#dt1))) && !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem($s, $dot(atomicObj#32, Data.handles))), $ref($ptr(^Handle, Q#h$1^12.29#dt1))) ==> !$closed($s, $ptr(^Handle, Q#h$1^12.29#dt1)));
    assume $full_stop_ext(#tok$1^36.19, $s);
    // assert @_vcc_in_domain(@state, addr.d, addr.d); 
    assert $in_domain_lab($s, $ptr(^Data, addr.d), $ptr(^Data, addr.d), l#public);
    // assume @_vcc_in_domain(@state, addr.d, addr.d); 
    assume $in_domain_lab($s, $ptr(^Data, addr.d), $ptr(^Data, addr.d), l#public);
    // assert @_vcc_typed2(@state, (addr.h->data)); 
    assert $typed2($s, $dot($ptr(^Handle, addr.h), Handle.data), $ptr_to(^Data));
    // assert @prim_writes_check((addr.h->data)); 
    assert $writable($s, #wrTime$1^23.1, $dot($ptr(^Handle, addr.h), Handle.data));
    // *(addr.h->data) := addr.d; 
    call $write_int($dot($ptr(^Handle, addr.h), Handle.data), $ref($ptr(^Data, addr.d)));
    assume $full_stop_ext(#tok$1^41.3, $s);
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
    // assert @writes_check(addr.h); 
    assert $top_writable($s, #wrTime$1^23.1, $ptr(^Handle, addr.h));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(addr.h), staticWrapState#14, owns#15)
    call $static_wrap($ptr(^Handle, addr.h), staticWrapState#14, owns#15);
    assume $good_state_ext(#tok$1^42.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, addr.h), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $ptr(^Handle, addr.h)), $set_empty());
    // assert @inv_check(@_vcc_typed2(@state, addr.h)); 
    assert $typed2($s, $ptr(^Handle, addr.h), ^Handle);
    // assert @inv_check(unchecked!(@_vcc_is_ghost_ptr(addr.h))); 
    assert !$is_ghost_ptr($ptr(^Handle, addr.h));
    // assert @inv_check(@_vcc_closed(@state, *((addr.h->data)))); 
    assert $closed($s, $read_ptr($s, $dot($ptr(^Handle, addr.h), Handle.data), ^Data));
    // assert @inv_check(@map_get(*((*((addr.h->data))->handles)), addr.h)); 
    assert $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem($s, $dot($read_ptr($s, $dot($ptr(^Handle, addr.h), Handle.data), ^Data), Data.handles))), $ref($ptr(^Handle, addr.h)));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @writes_check(@_vcc_extent(@state, addr.x)); 
    assert (forall #writes$1^46.3: $ptr :: { $dont_instantiate(#writes$1^46.3) } $set_in(#writes$1^46.3, $extent($s, $ptr(^X, addr.x))) ==> $top_writable($s, #wrTime$1^23.1, #writes$1^46.3));
    // stmt foo(addr.x); 
    call foo($ref($ptr(^X, addr.x)));
    assume $full_stop_ext(#tok$1^46.3, $s);
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^50.19, $s);
    atomicObj#33 := $ptr(^Data, addr.d);
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
    // assert @_vcc_wrapped(@state, addr.h); 
    assert $wrapped($s, $ptr(^Handle, addr.h), ^Handle);
    // assert @writes_check(addr.h); 
    assert $top_writable($s, #wrTime$1^23.1, $ptr(^Handle, addr.h));
    // assume @_vcc_inv(@state, addr.h); 
    assume $inv($s, $ptr(^Handle, addr.h), ^Handle);
    // assume ==(owns#18, @_vcc_owns(@state, addr.h)); 
    assume owns#18 == $owns($s, $ptr(^Handle, addr.h));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(addr.h), prestate#19)
    call $static_unwrap($ptr(^Handle, addr.h), prestate#19);
    assume $good_state_ext(#tok$1^51.21, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    assert $closed($s, atomicObj#33);
    assume $inv($s, atomicObj#33, ^Data);
    beforeAtomicState#1 := $s;
    // (struct Handle* -> _Bool) res_lambda#3#8; 
    assume $local_value_is($s, #tok$1^53.18, #loc.res_lambda#3#8, $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#3#8), $map_t($ptr_to(^Handle), ^^bool));
    // res_lambda#3#8 := lambda#3(); 
    call res_lambda#3#8 := lambda#3();
    assume $good_state_ext(#tok$1^53.18, $s);
    assume $local_value_is($s, #tok$1^53.18, #loc.res_lambda#3#8, $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#3#8), $map_t($ptr_to(^Handle), ^^bool));
    // assert @_vcc_typed2(@state, (addr.d->handles)); 
    assert $typed2($s, $dot($ptr(^Data, addr.d), Data.handles), $map_t($ptr_to(^Handle), ^^bool));
    // assert @prim_writes_check((addr.d->handles)); 
    assert $set_in($dot($ptr(^Data, addr.d), Data.handles), $volatile_span($s, atomicObj#33)) || $writable($s, #wrTime$1^23.1, $dot($ptr(^Data, addr.d), Data.handles));
    // *(addr.d->handles) := res_lambda#3#8; 
    call $write_int($dot($ptr(^Data, addr.d), Data.handles), $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#3#8));
    assume $good_state_ext(#tok$1^53.5, $s);
    // assert @writes_check(addr.d); 
    assert $top_writable($s, #wrTime$1^23.1, $ptr(^Data, addr.d));
    // stmt _vcc_bump_volatile_version(addr.d); 
    call $bump_volatile_version($ptr(^Data, addr.d));
    assume $good_state_ext(#tok$1^54.21, $s);
    assert $set_eq($owns($s, atomicObj#33), $set_empty());
    assert $closed(beforeAtomicState#1, atomicObj#33) && !$closed($s, atomicObj#33) ==> (forall Q#h$1^9.47#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^9.47#dt1))) ==> !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem($s, $dot(atomicObj#33, Data.handles))), $ref($ptr(^Handle, Q#h$1^9.47#dt1))));
    assert $inv_is_owner_approved(beforeAtomicState#1, $s, atomicObj#33, Data.handles);
    assert (forall Q#h$1^12.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^12.29#dt1))) ==> $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem(beforeAtomicState#1, $dot(atomicObj#33, Data.handles))), $ref($ptr(^Handle, Q#h$1^12.29#dt1))) && !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem($s, $dot(atomicObj#33, Data.handles))), $ref($ptr(^Handle, Q#h$1^12.29#dt1))) ==> !$closed($s, $ptr(^Handle, Q#h$1^12.29#dt1)));
    assume $full_stop_ext(#tok$1^50.19, $s);
    // assert @_vcc_in_domain(@state, addr.d, addr.d); 
    assert $in_domain_lab($s, $ptr(^Data, addr.d), $ptr(^Data, addr.d), l#public);
    // assume @_vcc_in_domain(@state, addr.d, addr.d); 
    assume $in_domain_lab($s, $ptr(^Data, addr.d), $ptr(^Data, addr.d), l#public);
    // _math ptrset owns#21; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#21, $ptrset_to_int(owns#21), ^$#ptrset);
    // owns#21 := @_vcc_set_empty; 
    owns#21 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#21, $ptrset_to_int(owns#21), ^$#ptrset);
    // _math state_t prestate#20; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#20, $state_to_int(prestate#20), ^$#state_t);
    // prestate#20 := @_vcc_current_state(@state); 
    prestate#20 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#20, $state_to_int(prestate#20), ^$#state_t);
    // _math state_t prestate#22; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#22, $state_to_int(prestate#22), ^$#state_t);
    // prestate#22 := @_vcc_current_state(@state); 
    prestate#22 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#22, $state_to_int(prestate#22), ^$#state_t);
    // assert @_vcc_wrapped(@state, addr.d); 
    assert $wrapped($s, $ptr(^Data, addr.d), ^Data);
    // assert @writes_check(addr.d); 
    assert $top_writable($s, #wrTime$1^23.1, $ptr(^Data, addr.d));
    // assume @_vcc_inv(@state, addr.d); 
    assume $inv($s, $ptr(^Data, addr.d), ^Data);
    // assume ==(owns#21, @_vcc_owns(@state, addr.d)); 
    assume owns#21 == $owns($s, $ptr(^Data, addr.d));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(addr.d), prestate#22)
    call $static_unwrap($ptr(^Data, addr.d), prestate#22);
    assume $good_state_ext(#tok$1^58.19, $s);
    // assert @inv_check(==>(&&(old(prestate#20, @_vcc_closed(@state, addr.d)), unchecked!(@_vcc_closed(@state, addr.d))), forall(struct Handle* h; @in_range_phys_ptr((mathint)h); unchecked!(@map_get(*((addr.d->handles)), h))))); 
    assert $closed(prestate#20, $ptr(^Data, addr.d)) && !$closed($s, $ptr(^Data, addr.d)) ==> (forall Q#h$1^9.47#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^9.47#dt1))) ==> !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem($s, $dot($ptr(^Data, addr.d), Data.handles))), $ref($ptr(^Handle, Q#h$1^9.47#dt1))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // stmt _vcc_stack_free(@stackframe, addr.d); 
    call $stack_free(#stackframe, $ptr(^Data, addr.d));
    assume $full_stop_ext(#tok$1^23.1, $s);
    // stmt _vcc_stack_free(@stackframe, addr.h); 
    call $stack_free(#stackframe, $ptr(^Handle, addr.h));
    assume $full_stop_ext(#tok$1^23.1, $s);
    // stmt _vcc_stack_free(@stackframe, addr.x); 
    call $stack_free(#stackframe, $ptr(^X, addr.x));
    assume $full_stop_ext(#tok$1^23.1, $s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure init();
  modifies $s, $cev_pc;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation init()
{
  var owns#27: $ptrset;
  var staticWrapState#26: $state;
  var prestate#28: $state;
  var owns#24: $ptrset;
  var staticWrapState#23: $state;
  var prestate#25: $state;
  var res_lambda#4#9: $map_t..$ptr_to..^Handle.^^bool;
  var #callConv#3: $ptr;
  var L#c: int where $in_range_phys_ptr(L#c);
  var #wrTime$1^72.1: int;
  var #stackframe: int;

  anon22:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^72.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^72.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^72.1, #p) } $in_writes_at(#wrTime$1^72.1, #p) == false);
    // struct Container* c; 
    assume $local_value_is($s, #tok$1^74.10, #loc.c, $ptr_to_int($ptr(^Container, L#c)), $ptr_to(^Container)) && $local_value_is_ptr($s, #tok$1^74.10, #loc.c, $ptr(^Container, L#c), $ptr_to(^Container));
    // c := _vcc_alloc(@_vcc_typeof((struct Container*)@null)); 
    call #callConv#3 := $alloc(^Container);
    assume $full_stop_ext(#tok$1^74.25, $s);
    L#c := $ref(#callConv#3);
    assume $local_value_is($s, #tok$1^74.25, #loc.c, $ptr_to_int($ptr(^Container, L#c)), $ptr_to(^Container)) && $local_value_is_ptr($s, #tok$1^74.25, #loc.c, $ptr(^Container, L#c), $ptr_to(^Container));
    assume true;
    // if (@_vcc_ptr_neq(c, @null)) ...
    if ($ptr_neq($ptr(^Container, L#c), $null))
    {
      anon20:
        // (struct Handle* -> _Bool) res_lambda#4#9; 
        assume $local_value_is($s, #tok$1^76.44, #loc.res_lambda#4#9, $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#4#9), $map_t($ptr_to(^Handle), ^^bool));
        // res_lambda#4#9 := lambda#4(); 
        call res_lambda#4#9 := lambda#4();
        assume $full_stop_ext(#tok$1^76.44, $s);
        assume $local_value_is($s, #tok$1^76.44, #loc.res_lambda#4#9, $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#4#9), $map_t($ptr_to(^Handle), ^^bool));
        // assert @_vcc_typed2(@state, ((c->d)->handles)); 
        assert $typed2($s, $dot($dot($ptr(^Container, L#c), Container.d), Data.handles), $map_t($ptr_to(^Handle), ^^bool));
        // assert @prim_writes_check(((c->d)->handles)); 
        assert $writable($s, #wrTime$1^72.1, $dot($dot($ptr(^Container, L#c), Container.d), Data.handles));
        // *((c->d)->handles) := res_lambda#4#9; 
        call $write_int($dot($dot($ptr(^Container, L#c), Container.d), Data.handles), $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#4#9));
        assume $full_stop_ext(#tok$1^76.28, $s);
        // assert forall(struct Handle* h; @in_range_phys_ptr((mathint)h); ==>(@_vcc_ptr_eq(*((h->data)), (c->d)), unchecked!(@_vcc_inv(@state, h)))); 
        assert (forall Q#h$1^77.28#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^77.28#dt1))) ==> $ptr_eq($read_ptr($s, $dot($ptr(^Handle, Q#h$1^77.28#dt1), Handle.data), ^Data), $dot($ptr(^Container, L#c), Container.d)) ==> !$inv($s, $ptr(^Handle, Q#h$1^77.28#dt1), ^Handle));
        // assume forall(struct Handle* h; @in_range_phys_ptr((mathint)h); ==>(@_vcc_ptr_eq(*((h->data)), (c->d)), unchecked!(@_vcc_inv(@state, h)))); 
        assume (forall Q#h$1^77.28#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^77.28#dt1))) ==> $ptr_eq($read_ptr($s, $dot($ptr(^Handle, Q#h$1^77.28#dt1), Handle.data), ^Data), $dot($ptr(^Container, L#c), Container.d)) ==> !$inv($s, $ptr(^Handle, Q#h$1^77.28#dt1), ^Handle));
        // _math state_t prestate#25; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#25, $state_to_int(prestate#25), ^$#state_t);
        // prestate#25 := @_vcc_current_state(@state); 
        prestate#25 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#25, $state_to_int(prestate#25), ^$#state_t);
        // _math state_t staticWrapState#23; 
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#23, $state_to_int(staticWrapState#23), ^$#state_t);
        // staticWrapState#23 := @_vcc_current_state(@state); 
        staticWrapState#23 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#23, $state_to_int(staticWrapState#23), ^$#state_t);
        // _math ptrset owns#24; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#24, $ptrset_to_int(owns#24), ^$#ptrset);
        // owns#24 := @_vcc_set_empty; 
        owns#24 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#24, $ptrset_to_int(owns#24), ^$#ptrset);
        // assert @writes_check((c->d)); 
        assert $top_writable($s, #wrTime$1^72.1, $dot($ptr(^Container, L#c), Container.d));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure((c->d)), staticWrapState#23, owns#24)
        call $static_wrap($dot($ptr(^Container, L#c), Container.d), staticWrapState#23, owns#24);
        assume $good_state_ext(#tok$1^78.21, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, (c->d)), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $dot($ptr(^Container, L#c), Container.d)), $set_empty());
        // assert @inv_check(@_vcc_inv_is_owner_approved(old(prestate#25, @state), @state, (c->d), @field(userdata(__spec volatile (struct Handle* -> _Bool) handles /* @0 */) : Field))); 
        assert $inv_is_owner_approved(prestate#25, $s, $dot($ptr(^Container, L#c), Container.d), Data.handles);
        // assert @inv_check(forall(struct Handle* h; @in_range_phys_ptr((mathint)h); ==>(&&(old(prestate#25, @map_get(*(((c->d)->handles)), h)), unchecked!(@map_get(*(((c->d)->handles)), h))), unchecked!(@_vcc_closed(@state, h))))); 
        assert (forall Q#h$1^12.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^12.29#dt1))) ==> $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem(prestate#25, $dot($dot($ptr(^Container, L#c), Container.d), Data.handles))), $ref($ptr(^Handle, Q#h$1^12.29#dt1))) && !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem($s, $dot($dot($ptr(^Container, L#c), Container.d), Data.handles))), $ref($ptr(^Handle, Q#h$1^12.29#dt1))) ==> !$closed($s, $ptr(^Handle, Q#h$1^12.29#dt1)));
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // _math state_t prestate#28; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
        // prestate#28 := @_vcc_current_state(@state); 
        prestate#28 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
        // _math state_t staticWrapState#26; 
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#26, $state_to_int(staticWrapState#26), ^$#state_t);
        // staticWrapState#26 := @_vcc_current_state(@state); 
        staticWrapState#26 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#26, $state_to_int(staticWrapState#26), ^$#state_t);
        // _math ptrset owns#27; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#27, $ptrset_to_int(owns#27), ^$#ptrset);
        // owns#27 := @_vcc_set_empty; 
        owns#27 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#27, $ptrset_to_int(owns#27), ^$#ptrset);
        // assert @writes_check(c); 
        assert $top_writable($s, #wrTime$1^72.1, $ptr(^Container, L#c));
        // assert @_vcc_wrapped(@state, (c->d)); 
        assert $wrapped($s, $dot($ptr(^Container, L#c), Container.d), ^Data);
        // assert @writes_check((c->d)); 
        assert $top_writable($s, #wrTime$1^72.1, $dot($ptr(^Container, L#c), Container.d));
        // owns#27 := pure(@_vcc_set_union(owns#27, @_vcc_set_singleton((c->d)))); 
        owns#27 := $set_union(owns#27, $set_singleton($dot($ptr(^Container, L#c), Container.d)));
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#27, $ptrset_to_int(owns#27), ^$#ptrset);
        // staticWrapState#26 := pure(@_vcc_take_over(staticWrapState#26, c, (c->d))); 
        staticWrapState#26 := $take_over(staticWrapState#26, $ptr(^Container, L#c), $dot($ptr(^Container, L#c), Container.d));
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#26, $state_to_int(staticWrapState#26), ^$#state_t);
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(c), staticWrapState#26, owns#27)
        call $static_wrap($ptr(^Container, L#c), staticWrapState#26, owns#27);
        assume $good_state_ext(#tok$1^79.21, $s);
        // assert @inv_check(@keeps_stable(old(prestate#28, (c->d)), (c->d))); 
        assert $dot($ptr(^Container, L#c), Container.d) == $dot($ptr(^Container, L#c), Container.d);
        // assert @inv_check(@keeps(c, (c->d))); 
        assert $keeps($s, $ptr(^Container, L#c), $dot($ptr(^Container, L#c), Container.d));
        // assert @inv_check(forall(struct Handle* hh; @in_range_phys_ptr((mathint)hh); ==>(@map_get(*(((c->d)->handles)), hh), ||(@_vcc_ptr_eq(hh, (c->h)), @_vcc_ptr_eq(hh, (c->h2)))))); 
        assert (forall Q#hh$1^69.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#hh$1^69.29#dt1))) ==> $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem($s, $dot($dot($ptr(^Container, L#c), Container.d), Data.handles))), $ref($ptr(^Handle, Q#hh$1^69.29#dt1))) ==> $ptr_eq($ptr(^Handle, Q#hh$1^69.29#dt1), $dot($ptr(^Container, L#c), Container.h)) || $ptr_eq($ptr(^Handle, Q#hh$1^69.29#dt1), $dot($ptr(^Container, L#c), Container.h2)));
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
    }
    else
    {
      anon21:
        // empty
    }

  anon23:
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure closed_use(P#c: int);
  requires $wrapped($s, $ptr(^Container, P#c), ^Container);
  modifies $s, $cev_pc;
  ensures $wrapped($s, $dot($ptr(^Container, P#c), Container.h), ^Handle) && $ptr_eq($read_ptr($s, $dot($dot($ptr(^Container, P#c), Container.h), Handle.data), ^Data), $dot($ptr(^Container, P#c), Container.d));
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $extent(old($s), $dot($ptr(^Container, P#c), Container.h))) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $extent(old($s), $dot($ptr(^Container, P#c), Container.h))) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $extent(old($s), $dot($ptr(^Container, P#c), Container.h))) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation closed_use(P#c: int)
{
  var owns#30: $ptrset;
  var staticWrapState#29: $state;
  var prestate#31: $state;
  var res_lambda#5#10: $map_t..$ptr_to..^Handle.^^bool;
  var beforeAtomicState#2: $state;
  var atomicObj#34: $ptr;
  var #wrTime$1^83.1: int;
  var #stackframe: int;

  anon24:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^83.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^83.1, #loc.c, $ptr_to_int($ptr(^Container, P#c)), $ptr_to(^Container)) && $local_value_is_ptr($s, #tok$1^83.1, #loc.c, $ptr(^Container, P#c), $ptr_to(^Container));
    assume #wrTime$1^83.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^83.1, #p) } $in_writes_at(#wrTime$1^83.1, #p) == $set_in(#p, $extent($s, $dot($ptr(^Container, P#c), Container.h))));
    assume (forall #p: $ptr :: { $extent_hint(#p, $dot($ptr(^Container, P#c), Container.h)) } $set_in(#p, $extent($s, $dot($ptr(^Container, P#c), Container.h))) ==> $mutable($s, #p));
    // assume @in_range_phys_ptr((mathint)c); 
    assume $in_range_phys_ptr($ref($ptr(^Container, P#c)));
    // assert @_vcc_in_domain(@state, c, c); 
    assert $in_domain_lab($s, $ptr(^Container, P#c), $ptr(^Container, P#c), l#public);
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^89.19, $s);
    atomicObj#34 := $dot($ptr(^Container, P#c), Container.d);
    assert $closed($s, atomicObj#34);
    assume $inv($s, atomicObj#34, ^Data);
    beforeAtomicState#2 := $s;
    // assert @_vcc_inv(@state, c); 
    assert $inv($s, $ptr(^Container, P#c), ^Container);
    // assume @_vcc_inv(@state, c); 
    assume $inv($s, $ptr(^Container, P#c), ^Container);
    // (struct Handle* -> _Bool) res_lambda#5#10; 
    assume $local_value_is($s, #tok$1^91.21, #loc.res_lambda#5#10, $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#5#10), $map_t($ptr_to(^Handle), ^^bool));
    // assert @reads_check_normal(((c->d)->handles)); 
    assert $typed2($s, $dot($dot($ptr(^Container, P#c), Container.d), Data.handles), $map_t($ptr_to(^Handle), ^^bool));
    assert $mutable($s, $dot($ptr(^Container, P#c), Container.d)) || $dot($ptr(^Container, P#c), Container.d) == atomicObj#34;
    // res_lambda#5#10 := lambda#5(*(((c->d)->handles)), (c->h)); 
    call res_lambda#5#10 := lambda#5($int_to_map_t..ptr_to..^Handle.^^bool($mem($s, $dot($dot($ptr(^Container, P#c), Container.d), Data.handles))), $ref($dot($ptr(^Container, P#c), Container.h)));
    assume $good_state_ext(#tok$1^91.21, $s);
    assume $local_value_is($s, #tok$1^91.21, #loc.res_lambda#5#10, $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#5#10), $map_t($ptr_to(^Handle), ^^bool));
    // assert @_vcc_typed2(@state, ((c->d)->handles)); 
    assert $typed2($s, $dot($dot($ptr(^Container, P#c), Container.d), Data.handles), $map_t($ptr_to(^Handle), ^^bool));
    // assert @prim_writes_check(((c->d)->handles)); 
    assert $set_in($dot($dot($ptr(^Container, P#c), Container.d), Data.handles), $volatile_span($s, atomicObj#34)) || $writable($s, #wrTime$1^83.1, $dot($dot($ptr(^Container, P#c), Container.d), Data.handles));
    // *((c->d)->handles) := res_lambda#5#10; 
    call $write_int($dot($dot($ptr(^Container, P#c), Container.d), Data.handles), $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#5#10));
    assume $good_state_ext(#tok$1^91.5, $s);
    assert $set_eq($owns($s, atomicObj#34), $set_empty());
    assert $closed(beforeAtomicState#2, atomicObj#34) && !$closed($s, atomicObj#34) ==> (forall Q#h$1^9.47#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^9.47#dt1))) ==> !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem($s, $dot(atomicObj#34, Data.handles))), $ref($ptr(^Handle, Q#h$1^9.47#dt1))));
    assert $inv_is_owner_approved(beforeAtomicState#2, $s, atomicObj#34, Data.handles);
    assert (forall Q#h$1^12.29#dt1: int :: $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^12.29#dt1))) ==> $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem(beforeAtomicState#2, $dot(atomicObj#34, Data.handles))), $ref($ptr(^Handle, Q#h$1^12.29#dt1))) && !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem($s, $dot(atomicObj#34, Data.handles))), $ref($ptr(^Handle, Q#h$1^12.29#dt1))) ==> !$closed($s, $ptr(^Handle, Q#h$1^12.29#dt1)));
    assume $full_stop_ext(#tok$1^89.19, $s);
    // assert @_vcc_typed2(@state, ((c->h)->data)); 
    assert $typed2($s, $dot($dot($ptr(^Container, P#c), Container.h), Handle.data), $ptr_to(^Data));
    // assert @prim_writes_check(((c->h)->data)); 
    assert $writable($s, #wrTime$1^83.1, $dot($dot($ptr(^Container, P#c), Container.h), Handle.data));
    // *((c->h)->data) := (c->d); 
    call $write_int($dot($dot($ptr(^Container, P#c), Container.h), Handle.data), $ref($dot($ptr(^Container, P#c), Container.d)));
    assume $full_stop_ext(#tok$1^93.3, $s);
    // _math state_t prestate#31; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#31, $state_to_int(prestate#31), ^$#state_t);
    // prestate#31 := @_vcc_current_state(@state); 
    prestate#31 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#31, $state_to_int(prestate#31), ^$#state_t);
    // _math state_t staticWrapState#29; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#29, $state_to_int(staticWrapState#29), ^$#state_t);
    // staticWrapState#29 := @_vcc_current_state(@state); 
    staticWrapState#29 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#29, $state_to_int(staticWrapState#29), ^$#state_t);
    // _math ptrset owns#30; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#30, $ptrset_to_int(owns#30), ^$#ptrset);
    // owns#30 := @_vcc_set_empty; 
    owns#30 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#30, $ptrset_to_int(owns#30), ^$#ptrset);
    // assert @writes_check((c->h)); 
    assert $top_writable($s, #wrTime$1^83.1, $dot($ptr(^Container, P#c), Container.h));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure((c->h)), staticWrapState#29, owns#30)
    call $static_wrap($dot($ptr(^Container, P#c), Container.h), staticWrapState#29, owns#30);
    assume $good_state_ext(#tok$1^94.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, (c->h)), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $dot($ptr(^Container, P#c), Container.h)), $set_empty());
    // assert @inv_check(@_vcc_typed2(@state, (c->h))); 
    assert $typed2($s, $dot($ptr(^Container, P#c), Container.h), ^Handle);
    // assert @inv_check(unchecked!(@_vcc_is_ghost_ptr((c->h)))); 
    assert !$is_ghost_ptr($dot($ptr(^Container, P#c), Container.h));
    // assert @inv_check(@_vcc_closed(@state, *(((c->h)->data)))); 
    assert $closed($s, $read_ptr($s, $dot($dot($ptr(^Container, P#c), Container.h), Handle.data), ^Data));
    // assert @inv_check(@map_get(*((*(((c->h)->data))->handles)), (c->h))); 
    assert $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($mem($s, $dot($read_ptr($s, $dot($dot($ptr(^Container, P#c), Container.h), Handle.data), ^Data), Data.handles))), $ref($dot($ptr(^Container, P#c), Container.h)));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



function F#lambda#5(#l1: $map_t..$ptr_to..^Handle.^^bool, #l0: int) : $map_t..$ptr_to..^Handle.^^bool;

const unique cf#lambda#5: $pure_function;

axiom $function_arg_type(cf#lambda#5, 0, $map_t($ptr_to(^Handle), ^^bool));

axiom $function_arg_type(cf#lambda#5, 1, $map_t($ptr_to(^Handle), ^^bool));

axiom $function_arg_type(cf#lambda#5, 2, $ptr_to(^Handle));

procedure lambda#5(#l1: $map_t..$ptr_to..^Handle.^^bool, #l0: int) returns ($result: $map_t..$ptr_to..^Handle.^^bool);
  free ensures $result == F#lambda#5(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#hh$1^91.21#dt1: int, #l1: $map_t..$ptr_to..^Handle.^^bool, #l0: int :: { $select.$map_t..$ptr_to..^Handle.^^bool(F#lambda#5(#l1, $ref($ptr(^Handle, #l0))), $ref($ptr(^Handle, Q#hh$1^91.21#dt1))) } $in_range_phys_ptr($ref($ptr(^Handle, Q#hh$1^91.21#dt1))) && $in_range_phys_ptr($ref($ptr(^Handle, #l0))) ==> $select.$map_t..$ptr_to..^Handle.^^bool(F#lambda#5(#l1, $ref($ptr(^Handle, #l0))), $ref($ptr(^Handle, Q#hh$1^91.21#dt1))) == ($ptr_eq($ptr(^Handle, Q#hh$1^91.21#dt1), $ptr(^Handle, #l0)) || $select.$map_t..$ptr_to..^Handle.^^bool(#l1, $ref($ptr(^Handle, Q#hh$1^91.21#dt1)))));

function F#lambda#4() : $map_t..$ptr_to..^Handle.^^bool;

const unique cf#lambda#4: $pure_function;

axiom $function_arg_type(cf#lambda#4, 0, $map_t($ptr_to(^Handle), ^^bool));

procedure lambda#4() returns ($result: $map_t..$ptr_to..^Handle.^^bool);
  free ensures $result == F#lambda#4();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#h$1^76.44#dt1: int :: { $select.$map_t..$ptr_to..^Handle.^^bool(F#lambda#4(), $ref($ptr(^Handle, Q#h$1^76.44#dt1))) } $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^76.44#dt1))) ==> $select.$map_t..$ptr_to..^Handle.^^bool(F#lambda#4(), $ref($ptr(^Handle, Q#h$1^76.44#dt1))) == false);

function F#lambda#3() : $map_t..$ptr_to..^Handle.^^bool;

const unique cf#lambda#3: $pure_function;

axiom $function_arg_type(cf#lambda#3, 0, $map_t($ptr_to(^Handle), ^^bool));

procedure lambda#3() returns ($result: $map_t..$ptr_to..^Handle.^^bool);
  free ensures $result == F#lambda#3();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#hh$1^53.18#dt1: int :: { $select.$map_t..$ptr_to..^Handle.^^bool(F#lambda#3(), $ref($ptr(^Handle, Q#hh$1^53.18#dt1))) } $in_range_phys_ptr($ref($ptr(^Handle, Q#hh$1^53.18#dt1))) ==> $select.$map_t..$ptr_to..^Handle.^^bool(F#lambda#3(), $ref($ptr(^Handle, Q#hh$1^53.18#dt1))) == false);

function F#lambda#2(#l0: int) : $map_t..$ptr_to..^Handle.^^bool;

const unique cf#lambda#2: $pure_function;

axiom $function_arg_type(cf#lambda#2, 0, $map_t($ptr_to(^Handle), ^^bool));

axiom $function_arg_type(cf#lambda#2, 1, $ptr_to(^Handle));

procedure lambda#2(#l0: int) returns ($result: $map_t..$ptr_to..^Handle.^^bool);
  free ensures $result == F#lambda#2(#l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#hh$1^37.18#dt1: int, #l0: int :: { $select.$map_t..$ptr_to..^Handle.^^bool(F#lambda#2($ref($ptr(^Handle, #l0))), $ref($ptr(^Handle, Q#hh$1^37.18#dt1))) } $in_range_phys_ptr($ref($ptr(^Handle, Q#hh$1^37.18#dt1))) && $in_range_phys_ptr($ref($ptr(^Handle, #l0))) ==> $select.$map_t..$ptr_to..^Handle.^^bool(F#lambda#2($ref($ptr(^Handle, #l0))), $ref($ptr(^Handle, Q#hh$1^37.18#dt1))) == $ptr_eq($ptr(^Handle, Q#hh$1^37.18#dt1), $ptr(^Handle, #l0)));

function F#lambda#1() : $map_t..$ptr_to..^Handle.^^bool;

const unique cf#lambda#1: $pure_function;

axiom $function_arg_type(cf#lambda#1, 0, $map_t($ptr_to(^Handle), ^^bool));

procedure lambda#1() returns ($result: $map_t..$ptr_to..^Handle.^^bool);
  free ensures $result == F#lambda#1();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#h$1^31.16#dt1: int :: { $select.$map_t..$ptr_to..^Handle.^^bool(F#lambda#1(), $ref($ptr(^Handle, Q#h$1^31.16#dt1))) } $in_range_phys_ptr($ref($ptr(^Handle, Q#h$1^31.16#dt1))) ==> $select.$map_t..$ptr_to..^Handle.^^bool(F#lambda#1(), $ref($ptr(^Handle, Q#h$1^31.16#dt1))) == false);

const unique l#public: $label;

type $map_t..$ptr_to..^Handle.^^bool;

function $select.$map_t..$ptr_to..^Handle.^^bool(M: $map_t..$ptr_to..^Handle.^^bool, p: int) : bool;

function $store.$map_t..$ptr_to..^Handle.^^bool(M: $map_t..$ptr_to..^Handle.^^bool, p: int, v: bool) : $map_t..$ptr_to..^Handle.^^bool;

function $eq.$map_t..$ptr_to..^Handle.^^bool(M1: $map_t..$ptr_to..^Handle.^^bool, M2: $map_t..$ptr_to..^Handle.^^bool) : bool;

const $zero.$map_t..$ptr_to..^Handle.^^bool: $map_t..$ptr_to..^Handle.^^bool;

axiom (forall M: $map_t..$ptr_to..^Handle.^^bool, p: int, v: bool :: $select.$map_t..$ptr_to..^Handle.^^bool($store.$map_t..$ptr_to..^Handle.^^bool(M, p, v), p) == v);

axiom (forall M: $map_t..$ptr_to..^Handle.^^bool, p: int, v: bool, q: int :: p != q ==> $select.$map_t..$ptr_to..^Handle.^^bool($store.$map_t..$ptr_to..^Handle.^^bool(M, q, v), p) == $select.$map_t..$ptr_to..^Handle.^^bool(M, p));

axiom (forall M1: $map_t..$ptr_to..^Handle.^^bool, M2: $map_t..$ptr_to..^Handle.^^bool :: { $eq.$map_t..$ptr_to..^Handle.^^bool(M1, M2) } (forall p: int :: $select.$map_t..$ptr_to..^Handle.^^bool(M1, p) == $select.$map_t..$ptr_to..^Handle.^^bool(M2, p)) ==> $eq.$map_t..$ptr_to..^Handle.^^bool(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^Handle.^^bool, M2: $map_t..$ptr_to..^Handle.^^bool :: { $eq.$map_t..$ptr_to..^Handle.^^bool(M1, M2) } $eq.$map_t..$ptr_to..^Handle.^^bool(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^Handle.^^bool(0) == $zero.$map_t..$ptr_to..^Handle.^^bool;

axiom (forall p: int :: $select.$map_t..$ptr_to..^Handle.^^bool($zero.$map_t..$ptr_to..^Handle.^^bool, p) == false);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t($ptr_to(^Handle), ^^bool)) } $eq.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rec_fetch(r1, f)), $int_to_map_t..ptr_to..^Handle.^^bool($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

const unique #loc.#l0: $token;

const unique #loc.#l1: $token;

const unique #tok$1^94.19: $token;

const unique #loc.owns#30: $token;

const unique #loc.staticWrapState#29: $token;

const unique #loc.prestate#31: $token;

const unique #tok$1^93.3: $token;

const unique #tok$1^89.19: $token;

const unique #tok$1^91.5: $token;

const unique #loc.res_lambda#5#10: $token;

const unique #tok$1^91.21: $token;

const unique #tok$1^83.1: $token;

const unique #tok$1^79.21: $token;

const unique #loc.owns#27: $token;

const unique #loc.staticWrapState#26: $token;

const unique #loc.prestate#28: $token;

const unique #tok$1^78.21: $token;

const unique #loc.owns#24: $token;

const unique #loc.staticWrapState#23: $token;

const unique #loc.prestate#25: $token;

const unique #tok$1^76.28: $token;

const unique #loc.res_lambda#4#9: $token;

const unique #tok$1^76.44: $token;

const unique #tok$1^74.25: $token;

const unique #loc.c: $token;

const unique #tok$1^74.10: $token;

const unique #tok$1^72.1: $token;

const unique #tok$1^58.19: $token;

const unique #loc.prestate#22: $token;

const unique #loc.prestate#20: $token;

const unique #loc.owns#21: $token;

const unique #tok$1^50.19: $token;

const unique #tok$1^54.21: $token;

const unique #tok$1^53.5: $token;

const unique #loc.res_lambda#3#8: $token;

const unique #tok$1^53.18: $token;

const unique #tok$1^51.21: $token;

const unique #loc.prestate#19: $token;

const unique #loc.prestate#17: $token;

const unique #loc.owns#18: $token;

const unique #tok$1^46.3: $token;

const unique #tok$1^42.19: $token;

const unique #loc.owns#15: $token;

const unique #loc.staticWrapState#14: $token;

const unique #loc.prestate#16: $token;

const unique #tok$1^41.3: $token;

const unique #tok$1^36.19: $token;

const unique #tok$1^38.21: $token;

const unique #tok$1^37.5: $token;

const unique #loc.res_lambda#2#7: $token;

const unique #tok$1^37.18: $token;

const unique #tok$1^33.19: $token;

const unique #loc.owns#12: $token;

const unique #loc.staticWrapState#11: $token;

function $state_to_int(x: $state) : int;

function $int_to_state(x: int) : $state;

axiom (forall #x: $state :: #x == $int_to_state($state_to_int(#x)));

const unique #loc.prestate#13: $token;

const unique #tok$2^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(2, #file^?3Cno?20file?3E);

const unique #tok$1^31.3: $token;

const unique #loc.res_lambda#1#6: $token;

const unique #tok$1^31.16: $token;

const unique #loc.addr.d: $token;

const unique #loc.addr.h: $token;

const unique #loc.addr.x: $token;

const unique #tok$1^23.1: $token;

const unique #distTp5: $ctype;

axiom #distTp5 == $ptr_to(^X);

const unique #loc.x: $token;

const unique #tok$1^21.1: $token;

const unique #distTp4: $ctype;

axiom #distTp4 == $ptr_to(^Container);

const unique #tok$1^63.1: $token;

const unique #tok$1^15.1: $token;

const unique #distTp3: $ctype;

axiom #distTp3 == $ptr_to(^Data);

const unique #loc._this_: $token;

const unique #tok$1^6.1: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CHandles.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CHandles.c);

function $map_t..ptr_to..^Handle.^^bool_to_int(x: $map_t..$ptr_to..^Handle.^^bool) : int;

function $int_to_map_t..ptr_to..^Handle.^^bool(x: int) : $map_t..$ptr_to..^Handle.^^bool;

axiom (forall #x: $map_t..$ptr_to..^Handle.^^bool :: #x == $int_to_map_t..ptr_to..^Handle.^^bool($map_t..ptr_to..^Handle.^^bool_to_int(#x)));

const unique #distTp2: $ctype;

axiom #distTp2 == $map_t($ptr_to(^Handle), ^^bool);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^Handle);
