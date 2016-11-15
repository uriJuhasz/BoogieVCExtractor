axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^List: $ctype;

axiom $is_composite(^List);

axiom $ptr_level(^List) == 0;

axiom $sizeof(^List) == 24;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^List) } $inv2(#s1, #s2, #p, ^List) == ($typed(#s2, #p) && $eq.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($mem(#s2, $dot(#p, List.vals))), F#lambda#1($int_to_map_t..^^u4.^^i4($mem(#s2, $dot($read_ptr(#s2, $dot(#p, List.tail), ^List), List.vals))), $mem(#s2, $dot(#p, List.head)), $mem(#s2, $dot(#p, List.length)))) && ($mem(#s2, $dot(#p, List.length)) == 0 || ($keeps(#s2, #p, $read_ptr(#s2, $dot(#p, List.tail), ^List)) && $mem(#s2, $dot(#p, List.length)) == $mem(#s2, $dot($read_ptr(#s2, $dot(#p, List.tail), ^List), List.length)) + 1))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^List, #r), l#public) } $inv_lab(#s2, $ptr(^List, #r), l#public) == ($typed(#s2, $ptr(^List, #r)) && $eq.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($mem(#s2, $dot($ptr(^List, #r), List.vals))), F#lambda#1($int_to_map_t..^^u4.^^i4($mem(#s2, $dot($read_ptr(#s2, $dot($ptr(^List, #r), List.tail), ^List), List.vals))), $mem(#s2, $dot($ptr(^List, #r), List.head)), $mem(#s2, $dot($ptr(^List, #r), List.length)))) && ($mem(#s2, $dot($ptr(^List, #r), List.length)) == 0 || ($keeps(#s2, $ptr(^List, #r), $read_ptr(#s2, $dot($ptr(^List, #r), List.tail), ^List)) && $mem(#s2, $dot($ptr(^List, #r), List.length)) == $mem(#s2, $dot($read_ptr(#s2, $dot($ptr(^List, #r), List.tail), ^List), List.length)) + 1))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^List, #r)) } $in_full_extent_of(#q, $ptr(^List, #r)) == (#q == $ptr(^List, #r) || #q == $dot($ptr(^List, #r), List.$owns) || #q == $dot($ptr(^List, #r), List.head) || #q == $dot($ptr(^List, #r), List.tail) || #q == $dot($ptr(^List, #r), List.length) || #q == $dot($ptr(^List, #r), List.vals)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^List, #r)) } $in_extent_of(#s, #q, $ptr(^List, #r)) == $in_struct_extent_of(#q, $ptr(^List, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^List, #r)) } $typed(#s, $ptr(^List, #r)) ==> $in_extent_of(#s, #q, $ptr(^List, #r)) == (#q == $ptr(^List, #r) || $emb(#s, #q) == $ptr(^List, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^List, #r)) } $in_span_of(#q, $ptr(^List, #r)) == (#q == $ptr(^List, #r) || #q == $dot($ptr(^List, #r), List.$owns) || #q == $dot($ptr(^List, #r), List.head) || #q == $dot($ptr(^List, #r), List.tail) || #q == $dot($ptr(^List, #r), List.length) || #q == $dot($ptr(^List, #r), List.vals)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^List) } $state_spans_the_same(#s1, #s2, #p, ^List) == ($mem_eq(#s1, #s2, $dot(#p, List.$owns)) && $mem_eq(#s1, #s2, $dot(#p, List.head)) && $mem_eq(#s1, #s2, $dot(#p, List.tail)) && $mem_eq(#s1, #s2, $dot(#p, List.length)) && $mem_eq(#s1, #s2, $dot(#p, List.vals))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^List) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^List) == ($mem_eq(#s1, #s2, $dot(#p, List.$owns)) && $mem_eq(#s1, #s2, $dot(#p, List.head)) && $mem_eq(#s1, #s2, $dot(#p, List.tail)) && $mem_eq(#s1, #s2, $dot(#p, List.length)) && $mem_eq(#s1, #s2, $dot(#p, List.vals))));

axiom $is_claimable(^List) == false;

axiom $has_volatile_owns_set(^List) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^List, #r)) } $extent_mutable(#s1, $ptr(^List, #r)) == $mutable(#s1, $ptr(^List, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^List, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^List, #r)) == $is_fresh(#s1, #s2, $ptr(^List, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^List, #r)) } $extent_zero(#s1, $ptr(^List, #r)) == ($mem(#s1, $dot($ptr(^List, #r), List.head)) == 0 && $mem(#s1, $dot($ptr(^List, #r), List.tail)) == 0 && $mem(#s1, $dot($ptr(^List, #r), List.length)) == 0 && $mem(#s1, $dot($ptr(^List, #r), List.vals)) == 0));

const unique List.$owns: $field;

axiom $static_field_properties(List.$owns, ^List);

axiom $is_primitive_non_volatile_field(List.$owns);

axiom (forall #p: $ptr :: { $dot(#p, List.$owns) } $is(#p, ^List) ==> $dot(#p, List.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, List.$owns)) && $extent_hint($dot(#p, List.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, List.$owns)) } { $st(#s, $dot(#p, List.$owns)) } $typed2(#s, #p, ^List) ==> $field_properties(#s, #p, List.$owns, ^$#ptrset, false));

axiom $owns_set_field(^List) == List.$owns;

const unique List.head: $field;

axiom $static_field_properties(List.head, ^List);

axiom $is_primitive_non_volatile_field(List.head);

axiom $field_offset(List.head) == 0;

axiom (forall #p: $ptr :: { $dot(#p, List.head) } $is(#p, ^List) ==> $dot(#p, List.head) == $ptr(^^i4, $ref(#p) + 0) && $extent_hint($dot(#p, List.head), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, List.head)) } { $st(#s, $dot(#p, List.head)) } $typed2(#s, #p, ^List) ==> $field_properties(#s, #p, List.head, ^^i4, false));

const unique List.tail: $field;

axiom $static_field_properties(List.tail, ^List);

axiom $is_primitive_non_volatile_field(List.tail);

axiom $field_offset(List.tail) == 8;

axiom (forall #p: $ptr :: { $dot(#p, List.tail) } $is(#p, ^List) ==> $dot(#p, List.tail) == $ptr($ptr_to(^List), $ref(#p) + 8) && $extent_hint($dot(#p, List.tail), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, List.tail)) } { $st(#s, $dot(#p, List.tail)) } $typed2(#s, #p, ^List) ==> $field_properties(#s, #p, List.tail, $ptr_to(^List), false));

const unique List.length: $field;

axiom $static_field_properties(List.length, ^List);

axiom $is_primitive_non_volatile_field(List.length);

axiom $field_offset(List.length) == 16;

axiom (forall #p: $ptr :: { $dot(#p, List.length) } $is(#p, ^List) ==> $dot(#p, List.length) == $ptr(^^u4, $ref(#p) + 16) && $extent_hint($dot(#p, List.length), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, List.length)) } { $st(#s, $dot(#p, List.length)) } $typed2(#s, #p, ^List) ==> $field_properties(#s, #p, List.length, ^^u4, false));

const unique List.vals: $field;

axiom $static_field_properties(List.vals, ^List);

axiom $is_primitive_non_volatile_field(List.vals);

axiom (forall #p: $ptr :: { $dot(#p, List.vals) } $is(#p, ^List) ==> $dot(#p, List.vals) == $ptr($map_t(^^u4, ^^i4), $ghost_ref(#p, List.vals)) && $extent_hint($dot(#p, List.vals), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, List.vals)) } { $st(#s, $dot(#p, List.vals)) } $typed2(#s, #p, ^List) ==> $field_properties(#s, #p, List.vals, $map_t(^^u4, ^^i4), false));

procedure List#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $eq.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($mem($s, $dot($ptr(^List, P#_this_), List.vals))), F#lambda#1($int_to_map_t..^^u4.^^i4($mem($s, $dot($read_ptr($s, $dot($ptr(^List, P#_this_), List.tail), ^List), List.vals))), $mem($s, $dot($ptr(^List, P#_this_), List.head)), $mem($s, $dot($ptr(^List, P#_this_), List.length))));
  ensures $is_admissibility_check() ==> $mem($s, $dot($ptr(^List, P#_this_), List.length)) == 0 || ($keeps($s, $ptr(^List, P#_this_), $read_ptr($s, $dot($ptr(^List, P#_this_), List.tail), ^List)) && $mem($s, $dot($ptr(^List, P#_this_), List.length)) == $mem($s, $dot($read_ptr($s, $dot($ptr(^List, P#_this_), List.tail), ^List), List.length)) + 1);
  ensures $is_unwrap_check() ==> $eq.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($mem($s, $dot($ptr(^List, P#_this_), List.vals))), F#lambda#1($int_to_map_t..^^u4.^^i4($mem($s, $dot($read_ptr($s, $dot($ptr(^List, P#_this_), List.tail), ^List), List.vals))), $mem($s, $dot($ptr(^List, P#_this_), List.head)), $mem($s, $dot($ptr(^List, P#_this_), List.length))));
  ensures $is_unwrap_check() ==> $mem($s, $dot($ptr(^List, P#_this_), List.length)) == 0 || ($keeps($s, $ptr(^List, P#_this_), $read_ptr($s, $dot($ptr(^List, P#_this_), List.tail), ^List)) && $mem($s, $dot($ptr(^List, P#_this_), List.length)) == $mem($s, $dot($read_ptr($s, $dot($ptr(^List, P#_this_), List.tail), ^List), List.length)) + 1);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation List#adm(P#_this_: int)
{
  var #wrTime$1^4.39: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^4.39, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^4.39, #loc._this_, $ptr_to_int($ptr(^List, P#_this_)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^4.39, #loc._this_, $ptr(^List, P#_this_), $ptr_to(^List));
    assume #wrTime$1^4.39 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^4.39, #p) } $in_writes_at(#wrTime$1^4.39, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^List, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^List, P#_this_));
        assume $good_state_ext(#tok$1^4.39, $s);
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
            assume $admissibility_pre($s, $ptr(^List, P#_this_));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^List, P#_this_));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct List*)@null))
        call $havoc_others($ptr(^List, P#_this_), ^List);
        assume $good_state_ext(#tok$1^4.39, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^List, P#_this_), ^List);
    }

  #exit:
}



procedure find(P#l: int) returns ($result: int);
  requires $wrapped($s, $ptr(^List, P#l), ^List);
  modifies $s, $cev_pc;
  free ensures $in_range_u4($result);
  ensures $result <= $mem($s, $dot($ptr(^List, P#l), List.length));
  ensures $result < $mem($s, $dot($ptr(^List, P#l), List.length)) ==> $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($mem($s, $dot($ptr(^List, P#l), List.vals))), $result) == 0;
  ensures (forall Q#i$1^17.27#tc1: int :: $in_range_u4(Q#i$1^17.27#tc1) ==> Q#i$1^17.27#tc1 < $result ==> $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($mem($s, $dot($ptr(^List, P#l), List.vals))), Q#i$1^17.27#tc1) != 0);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation find(P#l: int) returns ($result: int)
{
  var loopState#0: $state;
  var L#p: int where $in_range_phys_ptr(L#p);
  var #wrTime$1^13.1: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^13.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^13.1, #loc.l, $ptr_to_int($ptr(^List, P#l)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^13.1, #loc.l, $ptr(^List, P#l), $ptr_to(^List));
    assume #wrTime$1^13.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^13.1, #p) } $in_writes_at(#wrTime$1^13.1, #p) == false);
    // assume @in_range_phys_ptr((mathint)l); 
    assume $in_range_phys_ptr($ref($ptr(^List, P#l)));
    // assert @_vcc_in_domain(@state, l, l); 
    assert $in_domain_lab($s, $ptr(^List, P#l), $ptr(^List, P#l), l#public);
    // struct List* p; 
    assume $local_value_is($s, #tok$1^19.3, #loc.p, $ptr_to_int($ptr(^List, L#p)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^19.3, #loc.p, $ptr(^List, L#p), $ptr_to(^List));
    // var struct List* p
    // p := l; 
    L#p := $ref($ptr(^List, P#l));
    assume $local_value_is($s, #tok$1^20.8, #loc.p, $ptr_to_int($ptr(^List, L#p)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^20.8, #loc.p, $ptr(^List, L#p), $ptr_to(^List));
    loopState#0 := $s;
    while (true)
      invariant $mem($s, $dot($ptr(^List, L#p), List.length)) <= $mem($s, $dot($ptr(^List, P#l), List.length));
      invariant $in_domain_lab($s, $ptr(^List, L#p), $ptr(^List, P#l), l#public);
      invariant $eq.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($mem($s, $dot($ptr(^List, L#p), List.vals))), F#lambda#2($mem($s, $dot($ptr(^List, P#l), List.length)) - $mem($s, $dot($ptr(^List, L#p), List.length)), $int_to_map_t..^^u4.^^i4($mem($s, $dot($ptr(^List, P#l), List.vals))), $mem($s, $dot($ptr(^List, L#p), List.length))));
      invariant (forall Q#j$1^24.31#tc1: int :: $in_range_u4(Q#j$1^24.31#tc1) ==> Q#j$1^24.31#tc1 < $mem($s, $dot($ptr(^List, P#l), List.length)) - $mem($s, $dot($ptr(^List, L#p), List.length)) ==> $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($mem($s, $dot($ptr(^List, P#l), List.vals))), Q#j$1^24.31#tc1) != 0);
    {
      anon11:
        assume $writes_nothing(old($s), $s);
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$1^20.3, $s);
        assume $local_value_is($s, #tok$1^20.3, #loc.p, $ptr_to_int($ptr(^List, L#p)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^20.3, #loc.p, $ptr(^List, L#p), $ptr_to(^List));
        assume $local_value_is($s, #tok$1^20.3, #loc.l, $ptr_to_int($ptr(^List, P#l)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^20.3, #loc.l, $ptr(^List, P#l), $ptr_to(^List));
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#0, $s);
        // assert @reads_check_normal((p->length)); 
        assert $typed2($s, $dot($ptr(^List, L#p), List.length), ^^u4);
        assert $thread_local2($s, $dot($ptr(^List, L#p), List.length), ^^u4);
        assume true;
        // if (!=(*((p->length)), 0)) ...
        if ($mem($s, $dot($ptr(^List, L#p), List.length)) != 0)
        {
          anon9:
            // assert forall(uint32_t j; @in_range_u4(j); ==>(<(j, *((*((p->tail))->length))), ==(@map_get(*((*((p->tail))->vals)), j), @map_get(*((p->vals)), +(j, 1))))); 
            assert (forall Q#j$1^26.28#tc1: int :: $in_range_u4(Q#j$1^26.28#tc1) ==> Q#j$1^26.28#tc1 < $mem($s, $dot($read_ptr($s, $dot($ptr(^List, L#p), List.tail), ^List), List.length)) ==> $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($mem($s, $dot($read_ptr($s, $dot($ptr(^List, L#p), List.tail), ^List), List.vals))), Q#j$1^26.28#tc1) == $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($mem($s, $dot($ptr(^List, L#p), List.vals))), Q#j$1^26.28#tc1 + 1));
            // assume forall(uint32_t j; @in_range_u4(j); ==>(<(j, *((*((p->tail))->length))), ==(@map_get(*((*((p->tail))->vals)), j), @map_get(*((p->vals)), +(j, 1))))); 
            assume (forall Q#j$1^26.28#tc1: int :: $in_range_u4(Q#j$1^26.28#tc1) ==> Q#j$1^26.28#tc1 < $mem($s, $dot($read_ptr($s, $dot($ptr(^List, L#p), List.tail), ^List), List.length)) ==> $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($mem($s, $dot($read_ptr($s, $dot($ptr(^List, L#p), List.tail), ^List), List.vals))), Q#j$1^26.28#tc1) == $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($mem($s, $dot($ptr(^List, L#p), List.vals))), Q#j$1^26.28#tc1 + 1));
            // assert ==(*((p->head)), @map_get(*((p->vals)), 0)); 
            assert $mem($s, $dot($ptr(^List, L#p), List.head)) == $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($mem($s, $dot($ptr(^List, L#p), List.vals))), 0);
            // assume ==(*((p->head)), @map_get(*((p->vals)), 0)); 
            assume $mem($s, $dot($ptr(^List, L#p), List.head)) == $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($mem($s, $dot($ptr(^List, L#p), List.vals))), 0);
            // assert @reads_check_normal((p->head)); 
            assert $typed2($s, $dot($ptr(^List, L#p), List.head), ^^i4);
            assert $thread_local2($s, $dot($ptr(^List, L#p), List.head), ^^i4);
            assume true;
            // if (==(*((p->head)), 0)) ...
            if ($mem($s, $dot($ptr(^List, L#p), List.head)) == 0)
            {
              anon7:
                // goto #break_3; 
                goto #break_3;
            }
            else
            {
              anon8:
                // empty
            }
        }
        else
        {
          anon10:
            // goto #break_3; 
            goto #break_3;
        }

      #continue_3:
        // assert @reads_check_normal((p->tail)); 
        assert $typed2($s, $dot($ptr(^List, L#p), List.tail), $ptr_to(^List));
        assert $thread_local2($s, $dot($ptr(^List, L#p), List.tail), $ptr_to(^List));
        // p := *((p->tail)); 
        L#p := $ref($read_ptr($s, $dot($ptr(^List, L#p), List.tail), ^List));
        assume $local_value_is($s, #tok$1^20.31, #loc.p, $ptr_to_int($ptr(^List, L#p)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^20.31, #loc.p, $ptr(^List, L#p), $ptr_to(^List));
        assume true;
    }

  anon13:
    assume $full_stop_ext(#tok$1^20.3, $s);

  #break_3:
    // assert @in_range_u4(-(*((l->length)), *((p->length)))); 
    assert $in_range_u4($mem($s, $dot($ptr(^List, P#l), List.length)) - $mem($s, $dot($ptr(^List, L#p), List.length)));
    // assert @reads_check_normal((l->length)); 
    assert $typed2($s, $dot($ptr(^List, P#l), List.length), ^^u4);
    assert $thread_local2($s, $dot($ptr(^List, P#l), List.length), ^^u4);
    // assert @reads_check_normal((p->length)); 
    assert $typed2($s, $dot($ptr(^List, L#p), List.length), ^^u4);
    assert $thread_local2($s, $dot($ptr(^List, L#p), List.length), ^^u4);
    // return -(*((l->length)), *((p->length))); 
    $result := $mem($s, $dot($ptr(^List, P#l), List.length)) - $mem($s, $dot($ptr(^List, L#p), List.length));
    assert $position_marker();
    goto #exit;

  anon14:
    // empty

  #exit:
}



function F#lambda#2(#l2: int, #l1: $map_t..^^u4.^^i4, #l0: int) : $map_t..^^u4.^^i4;

const unique cf#lambda#2: $pure_function;

axiom $function_arg_type(cf#lambda#2, 0, $map_t(^^u4, ^^i4));

axiom $function_arg_type(cf#lambda#2, 1, ^^u4);

axiom $function_arg_type(cf#lambda#2, 2, $map_t(^^u4, ^^i4));

axiom $function_arg_type(cf#lambda#2, 3, ^^u4);

procedure lambda#2(#l2: int, #l1: $map_t..^^u4.^^i4, #l0: int) returns ($result: $map_t..^^u4.^^i4);
  free ensures $result == F#lambda#2(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#j$1^23.42#tc1: int, #l2: int, #l1: $map_t..^^u4.^^i4, #l0: int :: { $select.$map_t..^^u4.^^i4(F#lambda#2(#l2, #l1, #l0), Q#j$1^23.42#tc1) } $in_range_u4(Q#j$1^23.42#tc1) && $in_range_u4(#l2) && $in_range_u4(#l0) ==> $select.$map_t..^^u4.^^i4(F#lambda#2(#l2, #l1, #l0), Q#j$1^23.42#tc1) == (if Q#j$1^23.42#tc1 < #l0 then $select.$map_t..^^u4.^^i4(#l1, #l2 + Q#j$1^23.42#tc1) else 0));

function F#lambda#1(#l2: $map_t..^^u4.^^i4, #l1: int, #l0: int) : $map_t..^^u4.^^i4;

const unique cf#lambda#1: $pure_function;

axiom $function_arg_type(cf#lambda#1, 0, $map_t(^^u4, ^^i4));

axiom $function_arg_type(cf#lambda#1, 1, $map_t(^^u4, ^^i4));

axiom $function_arg_type(cf#lambda#1, 2, ^^i4);

axiom $function_arg_type(cf#lambda#1, 3, ^^u4);

procedure lambda#1(#l2: $map_t..^^u4.^^i4, #l1: int, #l0: int) returns ($result: $map_t..^^u4.^^i4);
  free ensures $result == F#lambda#1(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^9.37#tc1: int, #l2: $map_t..^^u4.^^i4, #l1: int, #l0: int :: { $select.$map_t..^^u4.^^i4(F#lambda#1(#l2, #l1, #l0), Q#i$1^9.37#tc1) } $in_range_u4(Q#i$1^9.37#tc1) && $in_range_i4(#l1) && $in_range_u4(#l0) ==> $select.$map_t..^^u4.^^i4(F#lambda#1(#l2, #l1, #l0), Q#i$1^9.37#tc1) == (if Q#i$1^9.37#tc1 < #l0 then (if Q#i$1^9.37#tc1 == 0 then #l1 else $select.$map_t..^^u4.^^i4(#l2, Q#i$1^9.37#tc1 - 1)) else 0));

const unique l#public: $label;

type $map_t..^^u4.^^i4;

function $select.$map_t..^^u4.^^i4(M: $map_t..^^u4.^^i4, p: int) : int;

function $store.$map_t..^^u4.^^i4(M: $map_t..^^u4.^^i4, p: int, v: int) : $map_t..^^u4.^^i4;

function $eq.$map_t..^^u4.^^i4(M1: $map_t..^^u4.^^i4, M2: $map_t..^^u4.^^i4) : bool;

const $zero.$map_t..^^u4.^^i4: $map_t..^^u4.^^i4;

axiom (forall M: $map_t..^^u4.^^i4, p: int, v: int :: $in_range_t(^^u4, p) ==> $select.$map_t..^^u4.^^i4($store.$map_t..^^u4.^^i4(M, p, v), p) == $unchecked(^^i4, v));

axiom (forall M: $map_t..^^u4.^^i4, p: int, v: int, q: int :: p != q ==> $select.$map_t..^^u4.^^i4($store.$map_t..^^u4.^^i4(M, q, v), p) == $select.$map_t..^^u4.^^i4(M, p));

axiom (forall M1: $map_t..^^u4.^^i4, M2: $map_t..^^u4.^^i4 :: { $eq.$map_t..^^u4.^^i4(M1, M2) } (forall p: int :: $in_range_t(^^u4, p) ==> $unchecked(^^i4, $select.$map_t..^^u4.^^i4(M1, p)) == $unchecked(^^i4, $select.$map_t..^^u4.^^i4(M2, p))) ==> $eq.$map_t..^^u4.^^i4(M1, M2));

axiom (forall M1: $map_t..^^u4.^^i4, M2: $map_t..^^u4.^^i4 :: { $eq.$map_t..^^u4.^^i4(M1, M2) } $eq.$map_t..^^u4.^^i4(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^u4.^^i4(0) == $zero.$map_t..^^u4.^^i4;

axiom (forall p: int :: $select.$map_t..^^u4.^^i4($zero.$map_t..^^u4.^^i4, p) == 0);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t(^^u4, ^^i4)) } $eq.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rec_fetch(r1, f)), $int_to_map_t..^^u4.^^i4($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

axiom (forall M: $map_t..^^u4.^^i4, p: int :: $in_range_t(^^i4, $select.$map_t..^^u4.^^i4(M, p)));

const unique #tok$1^9.37: $token;

const unique #loc.#l0: $token;

const unique #loc.#l1: $token;

const unique #loc.#l2: $token;

const unique #tok$1^23.42: $token;

const unique #tok$1^20.31: $token;

const unique #tok$1^20.3: $token;

const unique #tok$1^20.8: $token;

const unique #loc.p: $token;

const unique #tok$1^19.3: $token;

const unique #loc.l: $token;

const unique #tok$1^13.1: $token;

axiom $type_code_is(1, ^^u4);

const unique #loc._this_: $token;

const unique #tok$1^4.39: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvscomp2010?5Cvscomp2010_p3_v1.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvscomp2010?5Cvscomp2010_p3_v1.c);

const unique #distTp2: $ctype;

axiom #distTp2 == $ptr_to(^List);

function $map_t..^^u4.^^i4_to_int(x: $map_t..^^u4.^^i4) : int;

function $int_to_map_t..^^u4.^^i4(x: int) : $map_t..^^u4.^^i4;

axiom (forall #x: $map_t..^^u4.^^i4 :: #x == $int_to_map_t..^^u4.^^i4($map_t..^^u4.^^i4_to_int(#x)));

const unique #distTp1: $ctype;

axiom #distTp1 == $map_t(^^u4, ^^i4);
