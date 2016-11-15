axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^List: $ctype;

axiom $is_composite(^List);

axiom $ptr_level(^List) == 0;

axiom $sizeof(^List) == 24;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^List) } $inv2(#s1, #s2, #p, ^List) == ($typed(#s2, #p) && $is_malloc_root(#s2, #p) && $eq.$map_t..^^mathint.$ptr_to..^^void($int_to_map_t..^^mathint.ptr_to..^^void($mem(#s2, $dot(#p, List.val))), F#lambda#1($int_to_map_t..^^mathint.ptr_to..^^void($mem(#s2, $dot($read_ptr(#s2, $dot(#p, List.tail), ^List), List.val))), $ref($read_ptr(#s2, $dot(#p, List.head), ^^void)), $mem(#s2, $dot(#p, List.length)))) && ($mem(#s2, $dot(#p, List.length)) == 0 || $mem(#s2, $dot(#p, List.length)) == $mem(#s2, $dot($read_ptr(#s2, $dot(#p, List.tail), ^List), List.length)) + 1) && ($mem(#s2, $dot(#p, List.length)) != 0) == ($read_ptr(#s1, $dot(#p, List.tail), ^List) == $read_ptr(#s2, $dot(#p, List.tail), ^List) && $keeps(#s2, #p, $read_ptr(#s2, $dot(#p, List.tail), ^List)))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^List, #r), l#public) } $inv_lab(#s2, $ptr(^List, #r), l#public) == ($typed(#s2, $ptr(^List, #r)) && $is_malloc_root(#s2, $ptr(^List, #r)) && $eq.$map_t..^^mathint.$ptr_to..^^void($int_to_map_t..^^mathint.ptr_to..^^void($mem(#s2, $dot($ptr(^List, #r), List.val))), F#lambda#1($int_to_map_t..^^mathint.ptr_to..^^void($mem(#s2, $dot($read_ptr(#s2, $dot($ptr(^List, #r), List.tail), ^List), List.val))), $ref($read_ptr(#s2, $dot($ptr(^List, #r), List.head), ^^void)), $mem(#s2, $dot($ptr(^List, #r), List.length)))) && ($mem(#s2, $dot($ptr(^List, #r), List.length)) == 0 || $mem(#s2, $dot($ptr(^List, #r), List.length)) == $mem(#s2, $dot($read_ptr(#s2, $dot($ptr(^List, #r), List.tail), ^List), List.length)) + 1) && ($mem(#s2, $dot($ptr(^List, #r), List.length)) != 0) == $keeps(#s2, $ptr(^List, #r), $read_ptr(#s2, $dot($ptr(^List, #r), List.tail), ^List))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^List, #r)) } $in_full_extent_of(#q, $ptr(^List, #r)) == (#q == $ptr(^List, #r) || #q == $dot($ptr(^List, #r), List.$owns) || #q == $dot($ptr(^List, #r), List.head) || #q == $dot($ptr(^List, #r), List.tail) || #q == $dot($ptr(^List, #r), List.length) || #q == $dot($ptr(^List, #r), List.val)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^List, #r)) } $in_extent_of(#s, #q, $ptr(^List, #r)) == $in_struct_extent_of(#q, $ptr(^List, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^List, #r)) } $typed(#s, $ptr(^List, #r)) ==> $in_extent_of(#s, #q, $ptr(^List, #r)) == (#q == $ptr(^List, #r) || $emb(#s, #q) == $ptr(^List, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^List, #r)) } $in_span_of(#q, $ptr(^List, #r)) == (#q == $ptr(^List, #r) || #q == $dot($ptr(^List, #r), List.$owns) || #q == $dot($ptr(^List, #r), List.head) || #q == $dot($ptr(^List, #r), List.tail) || #q == $dot($ptr(^List, #r), List.length) || #q == $dot($ptr(^List, #r), List.val)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^List) } $state_spans_the_same(#s1, #s2, #p, ^List) == ($mem_eq(#s1, #s2, $dot(#p, List.$owns)) && $mem_eq(#s1, #s2, $dot(#p, List.head)) && $mem_eq(#s1, #s2, $dot(#p, List.tail)) && $mem_eq(#s1, #s2, $dot(#p, List.length)) && $mem_eq(#s1, #s2, $dot(#p, List.val))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^List) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^List) == ($mem_eq(#s1, #s2, $dot(#p, List.$owns)) && $mem_eq(#s1, #s2, $dot(#p, List.head)) && $mem_eq(#s1, #s2, $dot(#p, List.tail)) && $mem_eq(#s1, #s2, $dot(#p, List.length)) && $mem_eq(#s1, #s2, $dot(#p, List.val))));

axiom $is_claimable(^List) == false;

axiom $has_volatile_owns_set(^List) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^List, #r)) } $extent_mutable(#s1, $ptr(^List, #r)) == $mutable(#s1, $ptr(^List, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^List, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^List, #r)) == $is_fresh(#s1, #s2, $ptr(^List, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^List, #r)) } $extent_zero(#s1, $ptr(^List, #r)) == ($mem(#s1, $dot($ptr(^List, #r), List.head)) == 0 && $mem(#s1, $dot($ptr(^List, #r), List.tail)) == 0 && $mem(#s1, $dot($ptr(^List, #r), List.length)) == 0 && $mem(#s1, $dot($ptr(^List, #r), List.val)) == 0));

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

axiom (forall #p: $ptr :: { $dot(#p, List.head) } $is(#p, ^List) ==> $dot(#p, List.head) == $ptr($ptr_to(^^void), $ref(#p) + 0) && $extent_hint($dot(#p, List.head), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, List.head)) } { $st(#s, $dot(#p, List.head)) } $typed2(#s, #p, ^List) ==> $field_properties(#s, #p, List.head, $ptr_to(^^void), false));

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

const unique List.val: $field;

axiom $static_field_properties(List.val, ^List);

axiom $is_primitive_non_volatile_field(List.val);

axiom (forall #p: $ptr :: { $dot(#p, List.val) } $is(#p, ^List) ==> $dot(#p, List.val) == $ptr($map_t(^^mathint, $ptr_to(^^void)), $ghost_ref(#p, List.val)) && $extent_hint($dot(#p, List.val), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, List.val)) } { $st(#s, $dot(#p, List.val)) } $typed2(#s, #p, ^List) ==> $field_properties(#s, #p, List.val, $map_t(^^mathint, $ptr_to(^^void)), false));

procedure List#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $is_malloc_root($s, $ptr(^List, P#_this_));
  ensures $is_admissibility_check() ==> $eq.$map_t..^^mathint.$ptr_to..^^void($int_to_map_t..^^mathint.ptr_to..^^void($mem($s, $dot($ptr(^List, P#_this_), List.val))), F#lambda#1($int_to_map_t..^^mathint.ptr_to..^^void($mem($s, $dot($read_ptr($s, $dot($ptr(^List, P#_this_), List.tail), ^List), List.val))), $ref($read_ptr($s, $dot($ptr(^List, P#_this_), List.head), ^^void)), $mem($s, $dot($ptr(^List, P#_this_), List.length))));
  ensures $is_admissibility_check() ==> $mem($s, $dot($ptr(^List, P#_this_), List.length)) == 0 || $mem($s, $dot($ptr(^List, P#_this_), List.length)) == $mem($s, $dot($read_ptr($s, $dot($ptr(^List, P#_this_), List.tail), ^List), List.length)) + 1;
  ensures $is_admissibility_check() ==> ($mem($s, $dot($ptr(^List, P#_this_), List.length)) != 0) == ($read_ptr(old($s), $dot($ptr(^List, P#_this_), List.tail), ^List) == $read_ptr($s, $dot($ptr(^List, P#_this_), List.tail), ^List) && $keeps($s, $ptr(^List, P#_this_), $read_ptr($s, $dot($ptr(^List, P#_this_), List.tail), ^List)));
  ensures $is_stuttering_check() ==> ($mem($s, $dot($ptr(^List, P#_this_), List.length)) != 0) == ($read_ptr($s, $dot($ptr(^List, P#_this_), List.tail), ^List) == $read_ptr($s, $dot($ptr(^List, P#_this_), List.tail), ^List) && $keeps($s, $ptr(^List, P#_this_), $read_ptr($s, $dot($ptr(^List, P#_this_), List.tail), ^List)));
  ensures $is_unwrap_check() ==> $is_malloc_root($s, $ptr(^List, P#_this_));
  ensures $is_unwrap_check() ==> $eq.$map_t..^^mathint.$ptr_to..^^void($int_to_map_t..^^mathint.ptr_to..^^void($mem($s, $dot($ptr(^List, P#_this_), List.val))), F#lambda#1($int_to_map_t..^^mathint.ptr_to..^^void($mem($s, $dot($read_ptr($s, $dot($ptr(^List, P#_this_), List.tail), ^List), List.val))), $ref($read_ptr($s, $dot($ptr(^List, P#_this_), List.head), ^^void)), $mem($s, $dot($ptr(^List, P#_this_), List.length))));
  ensures $is_unwrap_check() ==> $mem($s, $dot($ptr(^List, P#_this_), List.length)) == 0 || $mem($s, $dot($ptr(^List, P#_this_), List.length)) == $mem($s, $dot($read_ptr($s, $dot($ptr(^List, P#_this_), List.tail), ^List), List.length)) + 1;
  ensures $is_unwrap_check() ==> ($mem($s, $dot($ptr(^List, P#_this_), List.length)) != 0) == ($read_ptr(old($s), $dot($ptr(^List, P#_this_), List.tail), ^List) == $read_ptr($s, $dot($ptr(^List, P#_this_), List.tail), ^List) && $keeps($s, $ptr(^List, P#_this_), $read_ptr($s, $dot($ptr(^List, P#_this_), List.tail), ^List)));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation List#adm(P#_this_: int)
{
  var #wrTime$1^9.9: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^9.9, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^9.9, #loc._this_, $ptr_to_int($ptr(^List, P#_this_)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^9.9, #loc._this_, $ptr(^List, P#_this_), $ptr_to(^List));
    assume #wrTime$1^9.9 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^9.9, #p) } $in_writes_at(#wrTime$1^9.9, #p) == false);
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
        assume $good_state_ext(#tok$1^9.9, $s);
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
        assume $good_state_ext(#tok$1^9.9, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^List, P#_this_), ^List);
    }

  #exit:
}



const unique ^Queue: $ctype;

axiom $is_composite(^Queue);

axiom $ptr_level(^Queue) == 0;

axiom $sizeof(^Queue) == 16;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Queue) } $inv2(#s1, #s2, #p, ^Queue) == ($typed(#s2, #p) && $is_malloc_root(#s2, #p) && $ptr_neq($read_ptr(#s2, $dot(#p, Queue.front), ^List), $read_ptr(#s2, $dot(#p, Queue.rear), ^List)) && $read_ptr(#s1, $dot(#p, Queue.front), ^List) == $read_ptr(#s2, $dot(#p, Queue.front), ^List) && $keeps(#s2, #p, $read_ptr(#s2, $dot(#p, Queue.front), ^List)) && $read_ptr(#s1, $dot(#p, Queue.rear), ^List) == $read_ptr(#s2, $dot(#p, Queue.rear), ^List) && $keeps(#s2, #p, $read_ptr(#s2, $dot(#p, Queue.rear), ^List)) && $mem(#s2, $dot($read_ptr(#s2, $dot(#p, Queue.rear), ^List), List.length)) <= $mem(#s2, $dot($read_ptr(#s2, $dot(#p, Queue.front), ^List), List.length)) && $mem(#s2, $dot($read_ptr(#s2, $dot(#p, Queue.front), ^List), List.length)) + $mem(#s2, $dot($read_ptr(#s2, $dot(#p, Queue.rear), ^List), List.length)) <= 4294967295));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^Queue, #r), l#public) } $inv_lab(#s2, $ptr(^Queue, #r), l#public) == ($typed(#s2, $ptr(^Queue, #r)) && $is_malloc_root(#s2, $ptr(^Queue, #r)) && $ptr_neq($read_ptr(#s2, $dot($ptr(^Queue, #r), Queue.front), ^List), $read_ptr(#s2, $dot($ptr(^Queue, #r), Queue.rear), ^List)) && $keeps(#s2, $ptr(^Queue, #r), $read_ptr(#s2, $dot($ptr(^Queue, #r), Queue.front), ^List)) && $keeps(#s2, $ptr(^Queue, #r), $read_ptr(#s2, $dot($ptr(^Queue, #r), Queue.rear), ^List)) && $mem(#s2, $dot($read_ptr(#s2, $dot($ptr(^Queue, #r), Queue.rear), ^List), List.length)) <= $mem(#s2, $dot($read_ptr(#s2, $dot($ptr(^Queue, #r), Queue.front), ^List), List.length)) && $mem(#s2, $dot($read_ptr(#s2, $dot($ptr(^Queue, #r), Queue.front), ^List), List.length)) + $mem(#s2, $dot($read_ptr(#s2, $dot($ptr(^Queue, #r), Queue.rear), ^List), List.length)) <= 4294967295));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^Queue, #r)) } $in_full_extent_of(#q, $ptr(^Queue, #r)) == (#q == $ptr(^Queue, #r) || #q == $dot($ptr(^Queue, #r), Queue.$owns) || #q == $dot($ptr(^Queue, #r), Queue.front) || #q == $dot($ptr(^Queue, #r), Queue.rear)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Queue, #r)) } $in_extent_of(#s, #q, $ptr(^Queue, #r)) == $in_struct_extent_of(#q, $ptr(^Queue, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^Queue, #r)) } $typed(#s, $ptr(^Queue, #r)) ==> $in_extent_of(#s, #q, $ptr(^Queue, #r)) == (#q == $ptr(^Queue, #r) || $emb(#s, #q) == $ptr(^Queue, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^Queue, #r)) } $in_span_of(#q, $ptr(^Queue, #r)) == (#q == $ptr(^Queue, #r) || #q == $dot($ptr(^Queue, #r), Queue.$owns) || #q == $dot($ptr(^Queue, #r), Queue.front) || #q == $dot($ptr(^Queue, #r), Queue.rear)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^Queue) } $state_spans_the_same(#s1, #s2, #p, ^Queue) == ($mem_eq(#s1, #s2, $dot(#p, Queue.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Queue.front)) && $mem_eq(#s1, #s2, $dot(#p, Queue.rear))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Queue) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^Queue) == ($mem_eq(#s1, #s2, $dot(#p, Queue.$owns)) && $mem_eq(#s1, #s2, $dot(#p, Queue.front)) && $mem_eq(#s1, #s2, $dot(#p, Queue.rear))));

axiom $is_claimable(^Queue) == false;

axiom $has_volatile_owns_set(^Queue) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^Queue, #r)) } $extent_mutable(#s1, $ptr(^Queue, #r)) == $mutable(#s1, $ptr(^Queue, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^Queue, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^Queue, #r)) == $is_fresh(#s1, #s2, $ptr(^Queue, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^Queue, #r)) } $extent_zero(#s1, $ptr(^Queue, #r)) == ($mem(#s1, $dot($ptr(^Queue, #r), Queue.front)) == 0 && $mem(#s1, $dot($ptr(^Queue, #r), Queue.rear)) == 0));

const unique Queue.$owns: $field;

axiom $static_field_properties(Queue.$owns, ^Queue);

axiom $is_primitive_non_volatile_field(Queue.$owns);

axiom (forall #p: $ptr :: { $dot(#p, Queue.$owns) } $is(#p, ^Queue) ==> $dot(#p, Queue.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, Queue.$owns)) && $extent_hint($dot(#p, Queue.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Queue.$owns)) } { $st(#s, $dot(#p, Queue.$owns)) } $typed2(#s, #p, ^Queue) ==> $field_properties(#s, #p, Queue.$owns, ^$#ptrset, false));

axiom $owns_set_field(^Queue) == Queue.$owns;

const unique Queue.front: $field;

axiom $static_field_properties(Queue.front, ^Queue);

axiom $is_primitive_non_volatile_field(Queue.front);

axiom $field_offset(Queue.front) == 0;

axiom (forall #p: $ptr :: { $dot(#p, Queue.front) } $is(#p, ^Queue) ==> $dot(#p, Queue.front) == $ptr($ptr_to(^List), $ref(#p) + 0) && $extent_hint($dot(#p, Queue.front), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Queue.front)) } { $st(#s, $dot(#p, Queue.front)) } $typed2(#s, #p, ^Queue) ==> $field_properties(#s, #p, Queue.front, $ptr_to(^List), false));

const unique Queue.rear: $field;

axiom $static_field_properties(Queue.rear, ^Queue);

axiom $is_primitive_non_volatile_field(Queue.rear);

axiom $field_offset(Queue.rear) == 8;

axiom (forall #p: $ptr :: { $dot(#p, Queue.rear) } $is(#p, ^Queue) ==> $dot(#p, Queue.rear) == $ptr($ptr_to(^List), $ref(#p) + 8) && $extent_hint($dot(#p, Queue.rear), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, Queue.rear)) } { $st(#s, $dot(#p, Queue.rear)) } $typed2(#s, #p, ^Queue) ==> $field_properties(#s, #p, Queue.rear, $ptr_to(^List), false));

procedure Queue#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $is_malloc_root($s, $ptr(^Queue, P#_this_));
  ensures $is_admissibility_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.front), ^List), $read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.rear), ^List));
  ensures $is_admissibility_check() ==> $read_ptr(old($s), $dot($ptr(^Queue, P#_this_), Queue.front), ^List) == $read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.front), ^List);
  ensures $is_admissibility_check() ==> $keeps($s, $ptr(^Queue, P#_this_), $read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.front), ^List));
  ensures $is_admissibility_check() ==> $read_ptr(old($s), $dot($ptr(^Queue, P#_this_), Queue.rear), ^List) == $read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.rear), ^List);
  ensures $is_admissibility_check() ==> $keeps($s, $ptr(^Queue, P#_this_), $read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.rear), ^List));
  ensures $is_admissibility_check() ==> $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.rear), ^List), List.length)) <= $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.front), ^List), List.length));
  ensures $is_admissibility_check() ==> $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.front), ^List), List.length)) + $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.rear), ^List), List.length)) <= 4294967295;
  ensures $is_stuttering_check() ==> $read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.front), ^List) == $read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.front), ^List);
  ensures $is_stuttering_check() ==> $read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.rear), ^List) == $read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.rear), ^List);
  ensures $is_unwrap_check() ==> $is_malloc_root($s, $ptr(^Queue, P#_this_));
  ensures $is_unwrap_check() ==> $ptr_neq($read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.front), ^List), $read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.rear), ^List));
  ensures $is_unwrap_check() ==> $read_ptr(old($s), $dot($ptr(^Queue, P#_this_), Queue.front), ^List) == $read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.front), ^List);
  ensures $is_unwrap_check() ==> $keeps($s, $ptr(^Queue, P#_this_), $read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.front), ^List));
  ensures $is_unwrap_check() ==> $read_ptr(old($s), $dot($ptr(^Queue, P#_this_), Queue.rear), ^List) == $read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.rear), ^List);
  ensures $is_unwrap_check() ==> $keeps($s, $ptr(^Queue, P#_this_), $read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.rear), ^List));
  ensures $is_unwrap_check() ==> $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.rear), ^List), List.length)) <= $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.front), ^List), List.length));
  ensures $is_unwrap_check() ==> $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.front), ^List), List.length)) + $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, P#_this_), Queue.rear), ^List), List.length)) <= 4294967295;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Queue#adm(P#_this_: int)
{
  var #wrTime$1^105.9: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^105.9, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^105.9, #loc._this_, $ptr_to_int($ptr(^Queue, P#_this_)), $ptr_to(^Queue)) && $local_value_is_ptr($s, #tok$1^105.9, #loc._this_, $ptr(^Queue, P#_this_), $ptr_to(^Queue));
    assume #wrTime$1^105.9 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^105.9, #p) } $in_writes_at(#wrTime$1^105.9, #p) == false);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon7:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $ptr(^Queue, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^Queue, P#_this_));
        assume $good_state_ext(#tok$1^105.9, $s);
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
            assume $admissibility_pre($s, $ptr(^Queue, P#_this_));
        }
        else
        {
          anon9:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^Queue, P#_this_));
        }

      anon11:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Queue*)@null))
        call $havoc_others($ptr(^Queue, P#_this_), ^Queue);
        assume $good_state_ext(#tok$1^105.9, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^Queue, P#_this_), ^Queue);
    }

  #exit:
}



const unique ^$#fnptr#1: $ctype;

axiom $is_fnptr_type(^$#fnptr#1);

type $#fnptr#1;

const unique ^$#fnptr#2: $ctype;

axiom $is_fnptr_type(^$#fnptr#2);

type $#fnptr#2;

const unique ^$#fnptr#3: $ctype;

axiom $is_fnptr_type(^$#fnptr#3);

type $#fnptr#3;

const unique ^$#fnptr#4: $ctype;

axiom $is_fnptr_type(^$#fnptr#4);

type $#fnptr#4;

const unique ^$#fnptr#5: $ctype;

axiom $is_fnptr_type(^$#fnptr#5);

type $#fnptr#5;

const unique ^$#fnptr#6: $ctype;

axiom $is_fnptr_type(^$#fnptr#6);

type $#fnptr#6;

const unique ^$#fnptr#7: $ctype;

axiom $is_fnptr_type(^$#fnptr#7);

type $#fnptr#7;

const unique ^$#fnptr#8: $ctype;

axiom $is_fnptr_type(^$#fnptr#8);

type $#fnptr#8;

procedure ListNew() returns ($result: int);
  modifies $s, $cev_pc;
  free ensures $in_range_phys_ptr($ref($ptr(^List, $result)));
  ensures $wrapped($s, $ptr(^List, $result), ^List) && $in_domain_lab($s, $ptr(^List, $result), $ptr(^List, $result), l#public) && $is_fresh(old($s), $s, $ptr(^List, $result));
  ensures $mem($s, $dot($ptr(^List, $result), List.length)) == 0;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation ListNew() returns ($result: int)
{
  var owns#20: $ptrset;
  var staticWrapState#19: $state;
  var prestate#21: $state;
  var res_lambda#2#12: $map_t..^^mathint.$ptr_to..^^void;
  var #callConv#0: $ptr;
  var L#l: int where $in_range_phys_ptr(L#l);
  var #wrTime$1^20.1: int;
  var #stackframe: int;

  anon15:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^20.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^20.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^20.1, #p) } $in_writes_at(#wrTime$1^20.1, #p) == false);
    // struct List* l; 
    assume $local_value_is($s, #tok$1^24.3, #loc.l, $ptr_to_int($ptr(^List, L#l)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^24.3, #loc.l, $ptr(^List, L#l), $ptr_to(^List));
    // l := _vcc_alloc(@_vcc_typeof((struct List*)@null)); 
    call #callConv#0 := $alloc(^List);
    assume $full_stop_ext(#tok$1^24.13, $s);
    L#l := $ref(#callConv#0);
    assume $local_value_is($s, #tok$1^24.13, #loc.l, $ptr_to_int($ptr(^List, L#l)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^24.13, #loc.l, $ptr(^List, L#l), $ptr_to(^List));
    // assume (_Bool)l; 
    assume $ptr_neq($ptr(^List, L#l), $null);
    // assert @_vcc_typed2(@state, (l->tail)); 
    assert $typed2($s, $dot($ptr(^List, L#l), List.tail), $ptr_to(^List));
    // assert @prim_writes_check((l->tail)); 
    assert $writable($s, #wrTime$1^20.1, $dot($ptr(^List, L#l), List.tail));
    // *(l->tail) := (struct List*)@null; 
    call $write_int($dot($ptr(^List, L#l), List.tail), $ref($ptr_cast($null, ^List)));
    assume $full_stop_ext(#tok$1^26.3, $s);
    // assert @_vcc_typed2(@state, (l->length)); 
    assert $typed2($s, $dot($ptr(^List, L#l), List.length), ^^u4);
    // assert @prim_writes_check((l->length)); 
    assert $writable($s, #wrTime$1^20.1, $dot($ptr(^List, L#l), List.length));
    // *(l->length) := 0; 
    call $write_int($dot($ptr(^List, L#l), List.length), 0);
    assume $full_stop_ext(#tok$1^27.3, $s);
    // (mathint -> void*) res_lambda#2#12; 
    assume $local_value_is($s, #tok$1^28.34, #loc.res_lambda#2#12, $map_t..^^mathint.ptr_to..^^void_to_int(res_lambda#2#12), $map_t(^^mathint, $ptr_to(^^void)));
    // res_lambda#2#12 := lambda#2(); 
    call res_lambda#2#12 := lambda#2();
    assume $full_stop_ext(#tok$1^28.34, $s);
    assume $local_value_is($s, #tok$1^28.34, #loc.res_lambda#2#12, $map_t..^^mathint.ptr_to..^^void_to_int(res_lambda#2#12), $map_t(^^mathint, $ptr_to(^^void)));
    // assert @_vcc_typed2(@state, (l->val)); 
    assert $typed2($s, $dot($ptr(^List, L#l), List.val), $map_t(^^mathint, $ptr_to(^^void)));
    // assert @prim_writes_check((l->val)); 
    assert $writable($s, #wrTime$1^20.1, $dot($ptr(^List, L#l), List.val));
    // *(l->val) := res_lambda#2#12; 
    call $write_int($dot($ptr(^List, L#l), List.val), $map_t..^^mathint.ptr_to..^^void_to_int(res_lambda#2#12));
    assume $full_stop_ext(#tok$1^28.25, $s);
    // _math state_t prestate#21; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#21, $state_to_int(prestate#21), ^$#state_t);
    // prestate#21 := @_vcc_current_state(@state); 
    prestate#21 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#21, $state_to_int(prestate#21), ^$#state_t);
    // _math state_t staticWrapState#19; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#19, $state_to_int(staticWrapState#19), ^$#state_t);
    // staticWrapState#19 := @_vcc_current_state(@state); 
    staticWrapState#19 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#19, $state_to_int(staticWrapState#19), ^$#state_t);
    // _math ptrset owns#20; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#20, $ptrset_to_int(owns#20), ^$#ptrset);
    // owns#20 := @_vcc_set_empty; 
    owns#20 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#20, $ptrset_to_int(owns#20), ^$#ptrset);
    // assert @writes_check(l); 
    assert $top_writable($s, #wrTime$1^20.1, $ptr(^List, L#l));
    assume true;
    // if (pure(!=(*((l->length)), 0))) ...
    if ($mem($s, $dot($ptr(^List, L#l), List.length)) != 0)
    {
      anon13:
        // assert @_vcc_wrapped(@state, *((l->tail))); 
        assert $wrapped($s, $read_ptr($s, $dot($ptr(^List, L#l), List.tail), ^List), ^List);
        // assert @writes_check(*((l->tail))); 
        assert $top_writable($s, #wrTime$1^20.1, $read_ptr($s, $dot($ptr(^List, L#l), List.tail), ^List));
        // owns#20 := pure(@_vcc_set_union(owns#20, @_vcc_set_singleton(*((l->tail))))); 
        owns#20 := $set_union(owns#20, $set_singleton($read_ptr($s, $dot($ptr(^List, L#l), List.tail), ^List)));
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#20, $ptrset_to_int(owns#20), ^$#ptrset);
        // staticWrapState#19 := pure(@_vcc_take_over(staticWrapState#19, l, *((l->tail)))); 
        staticWrapState#19 := $take_over(staticWrapState#19, $ptr(^List, L#l), $read_ptr($s, $dot($ptr(^List, L#l), List.tail), ^List));
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#19, $state_to_int(staticWrapState#19), ^$#state_t);
        // assume @_vcc_expect_unreachable; 
        assume $expect_unreachable();
    }
    else
    {
      anon14:
        // assume @_vcc_expect_unreachable; 
        assume $expect_unreachable();
    }

  anon16:
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(l), staticWrapState#19, owns#20)
    call $static_wrap($ptr(^List, L#l), staticWrapState#19, owns#20);
    assume $good_state_ext(#tok$1^29.19, $s);
    // assert @inv_check(@_vcc_is_malloc_root(@state, l)); 
    assert $is_malloc_root($s, $ptr(^List, L#l));
    // assert @inv_check(@map_eq(*((l->val)), lambda#1(*((*((l->tail))->val)), *((l->head)), *((l->length))))); 
    assert $eq.$map_t..^^mathint.$ptr_to..^^void($int_to_map_t..^^mathint.ptr_to..^^void($mem($s, $dot($ptr(^List, L#l), List.val))), F#lambda#1($int_to_map_t..^^mathint.ptr_to..^^void($mem($s, $dot($read_ptr($s, $dot($ptr(^List, L#l), List.tail), ^List), List.val))), $ref($read_ptr($s, $dot($ptr(^List, L#l), List.head), ^^void)), $mem($s, $dot($ptr(^List, L#l), List.length))));
    // assert @inv_check(||(==(*((l->length)), 0), ==(*((l->length)), +(*((*((l->tail))->length)), 1)))); 
    assert $mem($s, $dot($ptr(^List, L#l), List.length)) == 0 || $mem($s, $dot($ptr(^List, L#l), List.length)) == $mem($s, $dot($read_ptr($s, $dot($ptr(^List, L#l), List.tail), ^List), List.length)) + 1;
    // assert @inv_check(==(!=(*((l->length)), 0), &&(@keeps_stable(old(prestate#21, *((l->tail))), *((l->tail))), @keeps(l, *((l->tail)))))); 
    assert ($mem($s, $dot($ptr(^List, L#l), List.length)) != 0) == ($read_ptr(prestate#21, $dot($ptr(^List, L#l), List.tail), ^List) == $read_ptr($s, $dot($ptr(^List, L#l), List.tail), ^List) && $keeps($s, $ptr(^List, L#l), $read_ptr($s, $dot($ptr(^List, L#l), List.tail), ^List)));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return l; 
    $result := $ref($ptr(^List, L#l));
    assert $position_marker();
    goto #exit;

  anon17:
    // empty

  #exit:
}



procedure Cons(P#l: int, P#d: int) returns ($result: int);
  requires $wrapped($s, $ptr(^List, P#l), ^List);
  requires $mem($s, $dot($ptr(^List, P#l), List.length)) < 4294967295;
  modifies $s, $cev_pc;
  free ensures $in_range_phys_ptr($ref($ptr(^List, $result)));
  ensures $wrapped($s, $ptr(^List, $result), ^List) && $is_fresh(old($s), $s, $ptr(^List, $result));
  ensures $mem($s, $dot($ptr(^List, $result), List.length)) == $mem(old($s), $dot($ptr(^List, P#l), List.length)) + 1;
  ensures $eq.$map_t..^^mathint.$ptr_to..^^void($int_to_map_t..^^mathint.ptr_to..^^void($mem($s, $dot($ptr(^List, $result), List.val))), F#lambda#4($int_to_map_t..^^mathint.ptr_to..^^void($mem(old($s), $dot($ptr(^List, P#l), List.val))), $ref($ptr(^^void, P#d))));
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^List, P#l) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^List, P#l) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^List, P#l) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Cons(P#l: int, P#d: int) returns ($result: int)
{
  var owns#23: $ptrset;
  var staticWrapState#22: $state;
  var prestate#24: $state;
  var res_lambda#3#13: $map_t..^^mathint.$ptr_to..^^void;
  var #callConv#1: $ptr;
  var L#r: int where $in_range_phys_ptr(L#r);
  var #wrTime$1^33.1: int;
  var #stackframe: int;

  anon20:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^33.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^33.1, #loc.l, $ptr_to_int($ptr(^List, P#l)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^33.1, #loc.l, $ptr(^List, P#l), $ptr_to(^List));
    assume $local_value_is($s, #tok$1^33.1, #loc.d, $ptr_to_int($ptr(^^void, P#d)), $ptr_to(^^void)) && $local_value_is_ptr($s, #tok$1^33.1, #loc.d, $ptr(^^void, P#d), $ptr_to(^^void));
    assume #wrTime$1^33.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^33.1, #p) } $in_writes_at(#wrTime$1^33.1, #p) == (#p == $ptr(^List, P#l)));
    assume $thread_owned($s, $ptr(^List, P#l));
    // assume @in_range_phys_ptr((mathint)l); 
    assume $in_range_phys_ptr($ref($ptr(^List, P#l)));
    // assume @in_range_phys_ptr((mathint)d); 
    assume $in_range_phys_ptr($ref($ptr(^^void, P#d)));
    // assert @_vcc_in_domain(@state, l, l); 
    assert $in_domain_lab($s, $ptr(^List, P#l), $ptr(^List, P#l), l#public);
    // struct List* r; 
    assume $local_value_is($s, #tok$1^41.3, #loc.r, $ptr_to_int($ptr(^List, L#r)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^41.3, #loc.r, $ptr(^List, L#r), $ptr_to(^List));
    // r := _vcc_alloc(@_vcc_typeof((struct List*)@null)); 
    call #callConv#1 := $alloc(^List);
    assume $full_stop_ext(#tok$1^41.13, $s);
    L#r := $ref(#callConv#1);
    assume $local_value_is($s, #tok$1^41.13, #loc.r, $ptr_to_int($ptr(^List, L#r)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^41.13, #loc.r, $ptr(^List, L#r), $ptr_to(^List));
    // assume (_Bool)r; 
    assume $ptr_neq($ptr(^List, L#r), $null);
    // assert @_vcc_typed2(@state, (r->head)); 
    assert $typed2($s, $dot($ptr(^List, L#r), List.head), $ptr_to(^^void));
    // assert @prim_writes_check((r->head)); 
    assert $writable($s, #wrTime$1^33.1, $dot($ptr(^List, L#r), List.head));
    // *(r->head) := d; 
    call $write_int($dot($ptr(^List, L#r), List.head), $ref($ptr(^^void, P#d)));
    assume $full_stop_ext(#tok$1^43.3, $s);
    // assert @_vcc_typed2(@state, (r->tail)); 
    assert $typed2($s, $dot($ptr(^List, L#r), List.tail), $ptr_to(^List));
    // assert @prim_writes_check((r->tail)); 
    assert $writable($s, #wrTime$1^33.1, $dot($ptr(^List, L#r), List.tail));
    // *(r->tail) := l; 
    call $write_int($dot($ptr(^List, L#r), List.tail), $ref($ptr(^List, P#l)));
    assume $full_stop_ext(#tok$1^44.3, $s);
    // assert @_vcc_typed2(@state, (r->length)); 
    assert $typed2($s, $dot($ptr(^List, L#r), List.length), ^^u4);
    // assert @prim_writes_check((r->length)); 
    assert $writable($s, #wrTime$1^33.1, $dot($ptr(^List, L#r), List.length));
    // assert @in_range_u4(+(*((l->length)), 1)); 
    assert $in_range_u4($mem($s, $dot($ptr(^List, P#l), List.length)) + 1);
    // assert @reads_check_normal((l->length)); 
    assert $typed2($s, $dot($ptr(^List, P#l), List.length), ^^u4);
    assert $thread_local2($s, $dot($ptr(^List, P#l), List.length), ^^u4);
    // *(r->length) := +(*((l->length)), 1); 
    call $write_int($dot($ptr(^List, L#r), List.length), $mem($s, $dot($ptr(^List, P#l), List.length)) + 1);
    assume $full_stop_ext(#tok$1^45.3, $s);
    // (mathint -> void*) res_lambda#3#13; 
    assume $local_value_is($s, #tok$1^46.34, #loc.res_lambda#3#13, $map_t..^^mathint.ptr_to..^^void_to_int(res_lambda#3#13), $map_t(^^mathint, $ptr_to(^^void)));
    // assert @reads_check_normal((l->val)); 
    assert $typed2($s, $dot($ptr(^List, P#l), List.val), $map_t(^^mathint, $ptr_to(^^void)));
    assert $thread_local2($s, $dot($ptr(^List, P#l), List.val), $map_t(^^mathint, $ptr_to(^^void)));
    // res_lambda#3#13 := lambda#3(*((l->val)), d); 
    call res_lambda#3#13 := lambda#3($int_to_map_t..^^mathint.ptr_to..^^void($mem($s, $dot($ptr(^List, P#l), List.val))), $ref($ptr(^^void, P#d)));
    assume $full_stop_ext(#tok$1^46.34, $s);
    assume $local_value_is($s, #tok$1^46.34, #loc.res_lambda#3#13, $map_t..^^mathint.ptr_to..^^void_to_int(res_lambda#3#13), $map_t(^^mathint, $ptr_to(^^void)));
    // assert @_vcc_typed2(@state, (r->val)); 
    assert $typed2($s, $dot($ptr(^List, L#r), List.val), $map_t(^^mathint, $ptr_to(^^void)));
    // assert @prim_writes_check((r->val)); 
    assert $writable($s, #wrTime$1^33.1, $dot($ptr(^List, L#r), List.val));
    // *(r->val) := res_lambda#3#13; 
    call $write_int($dot($ptr(^List, L#r), List.val), $map_t..^^mathint.ptr_to..^^void_to_int(res_lambda#3#13));
    assume $full_stop_ext(#tok$1^46.25, $s);
    // _math state_t prestate#24; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#24, $state_to_int(prestate#24), ^$#state_t);
    // prestate#24 := @_vcc_current_state(@state); 
    prestate#24 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#24, $state_to_int(prestate#24), ^$#state_t);
    // _math state_t staticWrapState#22; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#22, $state_to_int(staticWrapState#22), ^$#state_t);
    // staticWrapState#22 := @_vcc_current_state(@state); 
    staticWrapState#22 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#22, $state_to_int(staticWrapState#22), ^$#state_t);
    // _math ptrset owns#23; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#23, $ptrset_to_int(owns#23), ^$#ptrset);
    // owns#23 := @_vcc_set_empty; 
    owns#23 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#23, $ptrset_to_int(owns#23), ^$#ptrset);
    // assert @writes_check(r); 
    assert $top_writable($s, #wrTime$1^33.1, $ptr(^List, L#r));
    assume true;
    // if (pure(!=(*((r->length)), 0))) ...
    if ($mem($s, $dot($ptr(^List, L#r), List.length)) != 0)
    {
      anon18:
        // assert @_vcc_wrapped(@state, *((r->tail))); 
        assert $wrapped($s, $read_ptr($s, $dot($ptr(^List, L#r), List.tail), ^List), ^List);
        // assert @writes_check(*((r->tail))); 
        assert $top_writable($s, #wrTime$1^33.1, $read_ptr($s, $dot($ptr(^List, L#r), List.tail), ^List));
        // owns#23 := pure(@_vcc_set_union(owns#23, @_vcc_set_singleton(*((r->tail))))); 
        owns#23 := $set_union(owns#23, $set_singleton($read_ptr($s, $dot($ptr(^List, L#r), List.tail), ^List)));
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#23, $ptrset_to_int(owns#23), ^$#ptrset);
        // staticWrapState#22 := pure(@_vcc_take_over(staticWrapState#22, r, *((r->tail)))); 
        staticWrapState#22 := $take_over(staticWrapState#22, $ptr(^List, L#r), $read_ptr($s, $dot($ptr(^List, L#r), List.tail), ^List));
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#22, $state_to_int(staticWrapState#22), ^$#state_t);
        // assume @_vcc_expect_unreachable; 
        assume $expect_unreachable();
    }
    else
    {
      anon19:
        // assume @_vcc_expect_unreachable; 
        assume $expect_unreachable();
    }

  anon21:
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(r), staticWrapState#22, owns#23)
    call $static_wrap($ptr(^List, L#r), staticWrapState#22, owns#23);
    assume $good_state_ext(#tok$1^47.19, $s);
    // assert @inv_check(@_vcc_is_malloc_root(@state, r)); 
    assert $is_malloc_root($s, $ptr(^List, L#r));
    // assert @inv_check(@map_eq(*((r->val)), lambda#1(*((*((r->tail))->val)), *((r->head)), *((r->length))))); 
    assert $eq.$map_t..^^mathint.$ptr_to..^^void($int_to_map_t..^^mathint.ptr_to..^^void($mem($s, $dot($ptr(^List, L#r), List.val))), F#lambda#1($int_to_map_t..^^mathint.ptr_to..^^void($mem($s, $dot($read_ptr($s, $dot($ptr(^List, L#r), List.tail), ^List), List.val))), $ref($read_ptr($s, $dot($ptr(^List, L#r), List.head), ^^void)), $mem($s, $dot($ptr(^List, L#r), List.length))));
    // assert @inv_check(||(==(*((r->length)), 0), ==(*((r->length)), +(*((*((r->tail))->length)), 1)))); 
    assert $mem($s, $dot($ptr(^List, L#r), List.length)) == 0 || $mem($s, $dot($ptr(^List, L#r), List.length)) == $mem($s, $dot($read_ptr($s, $dot($ptr(^List, L#r), List.tail), ^List), List.length)) + 1;
    // assert @inv_check(==(!=(*((r->length)), 0), &&(@keeps_stable(old(prestate#24, *((r->tail))), *((r->tail))), @keeps(r, *((r->tail)))))); 
    assert ($mem($s, $dot($ptr(^List, L#r), List.length)) != 0) == ($read_ptr(prestate#24, $dot($ptr(^List, L#r), List.tail), ^List) == $read_ptr($s, $dot($ptr(^List, L#r), List.tail), ^List) && $keeps($s, $ptr(^List, L#r), $read_ptr($s, $dot($ptr(^List, L#r), List.tail), ^List)));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return r; 
    $result := $ref($ptr(^List, L#r));
    assert $position_marker();
    goto #exit;

  anon22:
    // empty

  #exit:
}



procedure Concat(P#l: int, P#end: int) returns ($result: int);
  requires $wrapped($s, $ptr(^List, P#l), ^List);
  requires $wrapped($s, $ptr(^List, P#end), ^List);
  requires $ptr_neq($ptr(^List, P#l), $ptr(^List, P#end));
  requires $mem($s, $dot($ptr(^List, P#l), List.length)) + $mem($s, $dot($ptr(^List, P#end), List.length)) <= 4294967295;
  modifies $s, $cev_pc;
  free ensures $in_range_phys_ptr($ref($ptr(^List, $result)));
  ensures $wrapped($s, $ptr(^List, $result), ^List) && $in_domain_lab($s, $ptr(^List, $result), $ptr(^List, $result), l#public) && ($is_fresh(old($s), $s, $ptr(^List, $result)) || ($mem(old($s), $dot($ptr(^List, P#l), List.length)) == 0 && $ptr_eq($ptr(^List, $result), $ptr(^List, P#end))));
  ensures $mem($s, $dot($ptr(^List, $result), List.length)) == $mem(old($s), $dot($ptr(^List, P#l), List.length)) + $mem(old($s), $dot($ptr(^List, P#end), List.length));
  ensures $eq.$map_t..^^mathint.$ptr_to..^^void($int_to_map_t..^^mathint.ptr_to..^^void($mem($s, $dot($ptr(^List, $result), List.val))), F#lambda#5($mem(old($s), $dot($ptr(^List, P#l), List.length)), $int_to_map_t..^^mathint.ptr_to..^^void($mem(old($s), $dot($ptr(^List, P#end), List.val))), $int_to_map_t..^^mathint.ptr_to..^^void($mem(old($s), $dot($ptr(^List, P#l), List.val))), $mem(old($s), $dot($ptr(^List, P#l), List.length))));
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^List, P#l) || #p == $ptr(^List, P#end) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^List, P#l) || #p == $ptr(^List, P#end) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^List, P#l) || #p == $ptr(^List, P#end) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Concat(P#l: int, P#end: int) returns ($result: int)
{
  var L#c: int where $in_range_phys_ptr(L#c);
  var prestate#27: $state;
  var prestate#25: $state;
  var owns#26: $ptrset;
  var #wrTime$1^51.1: int;
  var #stackframe: int;

  anon27:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^51.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^51.1, #loc.l, $ptr_to_int($ptr(^List, P#l)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^51.1, #loc.l, $ptr(^List, P#l), $ptr_to(^List));
    assume $local_value_is($s, #tok$1^51.1, #loc.end, $ptr_to_int($ptr(^List, P#end)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^51.1, #loc.end, $ptr(^List, P#end), $ptr_to(^List));
    assume #wrTime$1^51.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^51.1, #p) } $in_writes_at(#wrTime$1^51.1, #p) == (#p == $ptr(^List, P#l) || #p == $ptr(^List, P#end)));
    assume $thread_owned($s, $ptr(^List, P#l));
    assume $thread_owned($s, $ptr(^List, P#end));
    // assume @in_range_phys_ptr((mathint)l); 
    assume $in_range_phys_ptr($ref($ptr(^List, P#l)));
    // assume @in_range_phys_ptr((mathint)end); 
    assume $in_range_phys_ptr($ref($ptr(^List, P#end)));
    // assert @_vcc_in_domain(@state, end, end); 
    assert $in_domain_lab($s, $ptr(^List, P#end), $ptr(^List, P#end), l#public);
    // assert @_vcc_in_domain(@state, l, l); 
    assert $in_domain_lab($s, $ptr(^List, P#l), $ptr(^List, P#l), l#public);
    // _math ptrset owns#26; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#26, $ptrset_to_int(owns#26), ^$#ptrset);
    // owns#26 := @_vcc_set_empty; 
    owns#26 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#26, $ptrset_to_int(owns#26), ^$#ptrset);
    // _math state_t prestate#25; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#25, $state_to_int(prestate#25), ^$#state_t);
    // prestate#25 := @_vcc_current_state(@state); 
    prestate#25 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#25, $state_to_int(prestate#25), ^$#state_t);
    // _math state_t prestate#27; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
    // prestate#27 := @_vcc_current_state(@state); 
    prestate#27 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
    // assert @_vcc_wrapped(@state, l); 
    assert $wrapped($s, $ptr(^List, P#l), ^List);
    // assert @writes_check(l); 
    assert $top_writable($s, #wrTime$1^51.1, $ptr(^List, P#l));
    // assume @_vcc_inv(@state, l); 
    assume $inv($s, $ptr(^List, P#l), ^List);
    assume true;
    // if (pure(!=(*((l->length)), 0))) ...
    if ($mem($s, $dot($ptr(^List, P#l), List.length)) != 0)
    {
      anon23:
        // prestate#27 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#27, l, *((l->tail)))); 
        prestate#27 := $release($current_state($s), prestate#27, $ptr(^List, P#l), $read_ptr($s, $dot($ptr(^List, P#l), List.tail), ^List));
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
        // owns#26 := pure(@_vcc_set_union(owns#26, @_vcc_set_singleton(*((l->tail))))); 
        owns#26 := $set_union(owns#26, $set_singleton($read_ptr($s, $dot($ptr(^List, P#l), List.tail), ^List)));
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#26, $ptrset_to_int(owns#26), ^$#ptrset);
        // assume pure(@_vcc_typed(@state, *((l->tail)))); 
        assume $typed($s, $read_ptr($s, $dot($ptr(^List, P#l), List.tail), ^List));
        // assume @_vcc_expect_unreachable; 
        assume $expect_unreachable();
    }
    else
    {
      anon24:
        // assume @_vcc_expect_unreachable; 
        assume $expect_unreachable();
    }

  anon28:
    // assume ==(owns#26, @_vcc_owns(@state, l)); 
    assume owns#26 == $owns($s, $ptr(^List, P#l));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(l), prestate#27)
    call $static_unwrap($ptr(^List, P#l), prestate#27);
    assume $good_state_ext(#tok$1^59.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @reads_check_normal((l->length)); 
    assert $typed2($s, $dot($ptr(^List, P#l), List.length), ^^u4);
    assert $thread_local2($s, $dot($ptr(^List, P#l), List.length), ^^u4);
    assume true;
    // if (==(*((l->length)), 0)) ...
    if ($mem($s, $dot($ptr(^List, P#l), List.length)) == 0)
    {
      anon25:
        // assert @writes_check(l); 
        assert $top_writable($s, #wrTime$1^51.1, $ptr(^List, P#l));
        // assert @writes_check(@_vcc_extent(@state, l)); 
        assert (forall #writes$1^61.5: $ptr :: { $dont_instantiate(#writes$1^61.5) } $set_in(#writes$1^61.5, $extent($s, $ptr(^List, P#l))) ==> $top_writable($s, #wrTime$1^51.1, #writes$1^61.5));
        // stmt _vcc_free(l); 
        call $free($ptr(^List, P#l));
        assume $full_stop_ext(#tok$1^61.5, $s);
        // return end; 
        $result := $ref($ptr(^List, P#end));
        assert $position_marker();
        goto #exit;
    }
    else
    {
      anon26:
        // struct List* c; 
        assume $local_value_is($s, #tok$1^64.5, #loc.c, $ptr_to_int($ptr(^List, L#c)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^64.5, #loc.c, $ptr(^List, L#c), $ptr_to(^List));
        // non-pure function
        // assert @writes_check(*((l->tail))); 
        assert $top_writable($s, #wrTime$1^51.1, $read_ptr($s, $dot($ptr(^List, P#l), List.tail), ^List));
        // assert @writes_check(end); 
        assert $top_writable($s, #wrTime$1^51.1, $ptr(^List, P#end));
        // assert @reads_check_normal((l->tail)); 
        assert $typed2($s, $dot($ptr(^List, P#l), List.tail), $ptr_to(^List));
        assert $thread_local2($s, $dot($ptr(^List, P#l), List.tail), $ptr_to(^List));
        // c := Concat(*((l->tail)), end); 
        call L#c := Concat($ref($read_ptr($s, $dot($ptr(^List, P#l), List.tail), ^List)), $ref($ptr(^List, P#end)));
        assume $full_stop_ext(#tok$1^64.15, $s);
        assume $local_value_is($s, #tok$1^64.15, #loc.c, $ptr_to_int($ptr(^List, L#c)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^64.15, #loc.c, $ptr(^List, L#c), $ptr_to(^List));
        // non-pure function
        // assert @writes_check(c); 
        assert $top_writable($s, #wrTime$1^51.1, $ptr(^List, L#c));
        // assert @reads_check_normal((l->head)); 
        assert $typed2($s, $dot($ptr(^List, P#l), List.head), $ptr_to(^^void));
        assert $thread_local2($s, $dot($ptr(^List, P#l), List.head), $ptr_to(^^void));
        // c := Cons(c, *((l->head))); 
        call L#c := Cons($ref($ptr(^List, L#c)), $ref($read_ptr($s, $dot($ptr(^List, P#l), List.head), ^^void)));
        assume $full_stop_ext(#tok$1^65.9, $s);
        assume $local_value_is($s, #tok$1^65.9, #loc.c, $ptr_to_int($ptr(^List, L#c)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^65.9, #loc.c, $ptr(^List, L#c), $ptr_to(^List));
        // assert @writes_check(l); 
        assert $top_writable($s, #wrTime$1^51.1, $ptr(^List, P#l));
        // assert @writes_check(@_vcc_extent(@state, l)); 
        assert (forall #writes$1^66.5: $ptr :: { $dont_instantiate(#writes$1^66.5) } $set_in(#writes$1^66.5, $extent($s, $ptr(^List, P#l))) ==> $top_writable($s, #wrTime$1^51.1, #writes$1^66.5));
        // stmt _vcc_free(l); 
        call $free($ptr(^List, P#l));
        assume $full_stop_ext(#tok$1^66.5, $s);
        // return c; 
        $result := $ref($ptr(^List, L#c));
        assert $position_marker();
        goto #exit;
    }

  anon29:
    // empty

  #exit:
}



procedure Reverse(P#l: int) returns ($result: int);
  requires $wrapped($s, $ptr(^List, P#l), ^List);
  modifies $s, $cev_pc;
  free ensures $in_range_phys_ptr($ref($ptr(^List, $result)));
  ensures $wrapped($s, $ptr(^List, $result), ^List) && $in_domain_lab($s, $ptr(^List, $result), $ptr(^List, $result), l#public) && ($is_fresh(old($s), $s, $ptr(^List, $result)) || ($ptr_eq($ptr(^List, $result), $ptr(^List, P#l)) && $in_domain_lab(old($s), $ptr(^List, $result), $ptr(^List, P#l), l#public)));
  ensures $eq.$map_t..^^mathint.$ptr_to..^^void($int_to_map_t..^^mathint.ptr_to..^^void($mem($s, $dot($ptr(^List, $result), List.val))), F#lambda#6($mem(old($s), $dot($ptr(^List, P#l), List.length)) - 1, $int_to_map_t..^^mathint.ptr_to..^^void($mem(old($s), $dot($ptr(^List, P#l), List.val)))));
  ensures $mem($s, $dot($ptr(^List, $result), List.length)) == $mem(old($s), $dot($ptr(^List, P#l), List.length));
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^List, P#l) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^List, P#l) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^List, P#l) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Reverse(P#l: int) returns ($result: int)
{
  var prestate#30: $state;
  var prestate#28: $state;
  var owns#29: $ptrset;
  var L#e: int where $in_range_phys_ptr(L#e);
  var L#f: int where $in_range_phys_ptr(L#f);
  var L#r: int where $in_range_phys_ptr(L#r);
  var #wrTime$1^71.1: int;
  var #stackframe: int;

  anon35:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^71.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^71.1, #loc.l, $ptr_to_int($ptr(^List, P#l)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^71.1, #loc.l, $ptr(^List, P#l), $ptr_to(^List));
    assume #wrTime$1^71.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^71.1, #p) } $in_writes_at(#wrTime$1^71.1, #p) == (#p == $ptr(^List, P#l)));
    assume $thread_owned($s, $ptr(^List, P#l));
    // assume @in_range_phys_ptr((mathint)l); 
    assume $in_range_phys_ptr($ref($ptr(^List, P#l)));
    // assert @_vcc_in_domain(@state, l, l); 
    assert $in_domain_lab($s, $ptr(^List, P#l), $ptr(^List, P#l), l#public);
    // struct List* r; 
    assume $local_value_is($s, #tok$1^78.3, #loc.r, $ptr_to_int($ptr(^List, L#r)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^78.3, #loc.r, $ptr(^List, L#r), $ptr_to(^List));
    // var struct List* r
    // assert @reads_check_normal((l->length)); 
    assert $typed2($s, $dot($ptr(^List, P#l), List.length), ^^u4);
    assert $thread_local2($s, $dot($ptr(^List, P#l), List.length), ^^u4);
    assume true;
    // if (==(*((l->length)), 0)) ...
    if ($mem($s, $dot($ptr(^List, P#l), List.length)) == 0)
    {
      anon30:
        // return l; 
        $result := $ref($ptr(^List, P#l));
        assert $position_marker();
        goto #exit;
    }
    else
    {
      anon33:
        // struct List* f; 
        assume $local_value_is($s, #tok$1^86.5, #loc.f, $ptr_to_int($ptr(^List, L#f)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^86.5, #loc.f, $ptr(^List, L#f), $ptr_to(^List));
        // struct List* e; 
        assume $local_value_is($s, #tok$1^82.5, #loc.e, $ptr_to_int($ptr(^List, L#e)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^82.5, #loc.e, $ptr(^List, L#e), $ptr_to(^List));
        // var struct List* e
        // _math ptrset owns#29; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#29, $ptrset_to_int(owns#29), ^$#ptrset);
        // owns#29 := @_vcc_set_empty; 
        owns#29 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#29, $ptrset_to_int(owns#29), ^$#ptrset);
        // _math state_t prestate#28; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
        // prestate#28 := @_vcc_current_state(@state); 
        prestate#28 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
        // _math state_t prestate#30; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#30, $state_to_int(prestate#30), ^$#state_t);
        // prestate#30 := @_vcc_current_state(@state); 
        prestate#30 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#30, $state_to_int(prestate#30), ^$#state_t);
        // assert @_vcc_wrapped(@state, l); 
        assert $wrapped($s, $ptr(^List, P#l), ^List);
        // assert @writes_check(l); 
        assert $top_writable($s, #wrTime$1^71.1, $ptr(^List, P#l));
        // assume @_vcc_inv(@state, l); 
        assume $inv($s, $ptr(^List, P#l), ^List);
        assume true;
        // if (pure(!=(*((l->length)), 0))) ...
        if ($mem($s, $dot($ptr(^List, P#l), List.length)) != 0)
        {
          anon31:
            // prestate#30 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#30, l, *((l->tail)))); 
            prestate#30 := $release($current_state($s), prestate#30, $ptr(^List, P#l), $read_ptr($s, $dot($ptr(^List, P#l), List.tail), ^List));
            assume $local_value_is($s, #tok$2^0.0, #loc.prestate#30, $state_to_int(prestate#30), ^$#state_t);
            // owns#29 := pure(@_vcc_set_union(owns#29, @_vcc_set_singleton(*((l->tail))))); 
            owns#29 := $set_union(owns#29, $set_singleton($read_ptr($s, $dot($ptr(^List, P#l), List.tail), ^List)));
            assume $local_value_is($s, #tok$2^0.0, #loc.owns#29, $ptrset_to_int(owns#29), ^$#ptrset);
            // assume pure(@_vcc_typed(@state, *((l->tail)))); 
            assume $typed($s, $read_ptr($s, $dot($ptr(^List, P#l), List.tail), ^List));
            // assume @_vcc_expect_unreachable; 
            assume $expect_unreachable();
        }
        else
        {
          anon32:
            // assume @_vcc_expect_unreachable; 
            assume $expect_unreachable();
        }

      anon34:
        // assume ==(owns#29, @_vcc_owns(@state, l)); 
        assume owns#29 == $owns($s, $ptr(^List, P#l));
        // assume @_vcc_pre_static_unwrap(@state); 
        assume $pre_static_unwrap($s);
        // @_vcc_static_unwrap(pure(l), prestate#30)
        call $static_unwrap($ptr(^List, P#l), prestate#30);
        assume $good_state_ext(#tok$1^83.21, $s);
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // non-pure function
        // assert @writes_check(*((l->tail))); 
        assert $top_writable($s, #wrTime$1^71.1, $read_ptr($s, $dot($ptr(^List, P#l), List.tail), ^List));
        // assert @reads_check_normal((l->tail)); 
        assert $typed2($s, $dot($ptr(^List, P#l), List.tail), $ptr_to(^List));
        assert $thread_local2($s, $dot($ptr(^List, P#l), List.tail), $ptr_to(^List));
        // r := Reverse(*((l->tail))); 
        call L#r := Reverse($ref($read_ptr($s, $dot($ptr(^List, P#l), List.tail), ^List)));
        assume $full_stop_ext(#tok$1^84.9, $s);
        assume $local_value_is($s, #tok$1^84.9, #loc.r, $ptr_to_int($ptr(^List, L#r)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^84.9, #loc.r, $ptr(^List, L#r), $ptr_to(^List));
        // non-pure function
        // e := ListNew(); 
        call L#e := ListNew();
        assume $full_stop_ext(#tok$1^85.9, $s);
        assume $local_value_is($s, #tok$1^85.9, #loc.e, $ptr_to_int($ptr(^List, L#e)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^85.9, #loc.e, $ptr(^List, L#e), $ptr_to(^List));
        // non-pure function
        // assert @writes_check(e); 
        assert $top_writable($s, #wrTime$1^71.1, $ptr(^List, L#e));
        // assert @reads_check_normal((l->head)); 
        assert $typed2($s, $dot($ptr(^List, P#l), List.head), $ptr_to(^^void));
        assert $thread_local2($s, $dot($ptr(^List, P#l), List.head), $ptr_to(^^void));
        // f := Cons(e, *((l->head))); 
        call L#f := Cons($ref($ptr(^List, L#e)), $ref($read_ptr($s, $dot($ptr(^List, P#l), List.head), ^^void)));
        assume $full_stop_ext(#tok$1^86.15, $s);
        assume $local_value_is($s, #tok$1^86.15, #loc.f, $ptr_to_int($ptr(^List, L#f)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^86.15, #loc.f, $ptr(^List, L#f), $ptr_to(^List));
        // non-pure function
        // assert @writes_check(r); 
        assert $top_writable($s, #wrTime$1^71.1, $ptr(^List, L#r));
        // assert @writes_check(f); 
        assert $top_writable($s, #wrTime$1^71.1, $ptr(^List, L#f));
        // r := Concat(r, f); 
        call L#r := Concat($ref($ptr(^List, L#r)), $ref($ptr(^List, L#f)));
        assume $full_stop_ext(#tok$1^87.9, $s);
        assume $local_value_is($s, #tok$1^87.9, #loc.r, $ptr_to_int($ptr(^List, L#r)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^87.9, #loc.r, $ptr(^List, L#r), $ptr_to(^List));
        // return r; 
        $result := $ref($ptr(^List, L#r));
        assert $position_marker();
        goto #exit;
    }

  anon36:
    // empty

  #exit:
}



procedure Tail(P#l: int) returns ($result: int);
  requires $wrapped($s, $ptr(^List, P#l), ^List);
  requires $mem($s, $dot($ptr(^List, P#l), List.length)) != 0;
  modifies $s, $cev_pc;
  free ensures $in_range_phys_ptr($ref($ptr(^List, $result)));
  ensures $wrapped($s, $ptr(^List, $result), ^List) && $is_fresh(old($s), $s, $ptr(^List, $result)) && $in_domain_lab(old($s), $ptr(^List, $result), $ptr(^List, P#l), l#public);
  ensures $mem($s, $dot($ptr(^List, $result), List.length)) == $mem(old($s), $dot($ptr(^List, P#l), List.length)) - 1;
  ensures $eq.$map_t..^^mathint.$ptr_to..^^void($int_to_map_t..^^mathint.ptr_to..^^void($mem($s, $dot($ptr(^List, $result), List.val))), F#lambda#7($int_to_map_t..^^mathint.ptr_to..^^void($mem(old($s), $dot($ptr(^List, P#l), List.val)))));
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^List, P#l) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^List, P#l) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^List, P#l) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Tail(P#l: int) returns ($result: int)
{
  var prestate#33: $state;
  var prestate#31: $state;
  var owns#32: $ptrset;
  var L#r: int where $in_range_phys_ptr(L#r);
  var #wrTime$1^92.1: int;
  var #stackframe: int;

  anon39:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^92.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^92.1, #loc.l, $ptr_to_int($ptr(^List, P#l)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^92.1, #loc.l, $ptr(^List, P#l), $ptr_to(^List));
    assume #wrTime$1^92.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^92.1, #p) } $in_writes_at(#wrTime$1^92.1, #p) == (#p == $ptr(^List, P#l)));
    assume $thread_owned($s, $ptr(^List, P#l));
    // assume @in_range_phys_ptr((mathint)l); 
    assume $in_range_phys_ptr($ref($ptr(^List, P#l)));
    // assert @_vcc_in_domain(@state, l, l); 
    assert $in_domain_lab($s, $ptr(^List, P#l), $ptr(^List, P#l), l#public);
    // struct List* r; 
    assume $local_value_is($s, #tok$1^100.3, #loc.r, $ptr_to_int($ptr(^List, L#r)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^100.3, #loc.r, $ptr(^List, L#r), $ptr_to(^List));
    // _math ptrset owns#32; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#32, $ptrset_to_int(owns#32), ^$#ptrset);
    // owns#32 := @_vcc_set_empty; 
    owns#32 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#32, $ptrset_to_int(owns#32), ^$#ptrset);
    // _math state_t prestate#31; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#31, $state_to_int(prestate#31), ^$#state_t);
    // prestate#31 := @_vcc_current_state(@state); 
    prestate#31 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#31, $state_to_int(prestate#31), ^$#state_t);
    // _math state_t prestate#33; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#33, $state_to_int(prestate#33), ^$#state_t);
    // prestate#33 := @_vcc_current_state(@state); 
    prestate#33 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#33, $state_to_int(prestate#33), ^$#state_t);
    // assert @_vcc_wrapped(@state, l); 
    assert $wrapped($s, $ptr(^List, P#l), ^List);
    // assert @writes_check(l); 
    assert $top_writable($s, #wrTime$1^92.1, $ptr(^List, P#l));
    // assume @_vcc_inv(@state, l); 
    assume $inv($s, $ptr(^List, P#l), ^List);
    assume true;
    // if (pure(!=(*((l->length)), 0))) ...
    if ($mem($s, $dot($ptr(^List, P#l), List.length)) != 0)
    {
      anon37:
        // prestate#33 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#33, l, *((l->tail)))); 
        prestate#33 := $release($current_state($s), prestate#33, $ptr(^List, P#l), $read_ptr($s, $dot($ptr(^List, P#l), List.tail), ^List));
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#33, $state_to_int(prestate#33), ^$#state_t);
        // owns#32 := pure(@_vcc_set_union(owns#32, @_vcc_set_singleton(*((l->tail))))); 
        owns#32 := $set_union(owns#32, $set_singleton($read_ptr($s, $dot($ptr(^List, P#l), List.tail), ^List)));
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#32, $ptrset_to_int(owns#32), ^$#ptrset);
        // assume pure(@_vcc_typed(@state, *((l->tail)))); 
        assume $typed($s, $read_ptr($s, $dot($ptr(^List, P#l), List.tail), ^List));
        // assume @_vcc_expect_unreachable; 
        assume $expect_unreachable();
    }
    else
    {
      anon38:
        // assume @_vcc_expect_unreachable; 
        assume $expect_unreachable();
    }

  anon40:
    // assume ==(owns#32, @_vcc_owns(@state, l)); 
    assume owns#32 == $owns($s, $ptr(^List, P#l));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(l), prestate#33)
    call $static_unwrap($ptr(^List, P#l), prestate#33);
    assume $good_state_ext(#tok$1^99.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @reads_check_normal((l->tail)); 
    assert $typed2($s, $dot($ptr(^List, P#l), List.tail), $ptr_to(^List));
    assert $thread_local2($s, $dot($ptr(^List, P#l), List.tail), $ptr_to(^List));
    // r := *((l->tail)); 
    L#r := $ref($read_ptr($s, $dot($ptr(^List, P#l), List.tail), ^List));
    assume $local_value_is($s, #tok$1^100.3, #loc.r, $ptr_to_int($ptr(^List, L#r)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^100.3, #loc.r, $ptr(^List, L#r), $ptr_to(^List));
    // assert @writes_check(l); 
    assert $top_writable($s, #wrTime$1^92.1, $ptr(^List, P#l));
    // assert @writes_check(@_vcc_extent(@state, l)); 
    assert (forall #writes$1^101.3: $ptr :: { $dont_instantiate(#writes$1^101.3) } $set_in(#writes$1^101.3, $extent($s, $ptr(^List, P#l))) ==> $top_writable($s, #wrTime$1^92.1, #writes$1^101.3));
    // stmt _vcc_free(l); 
    call $free($ptr(^List, P#l));
    assume $full_stop_ext(#tok$1^101.3, $s);
    // return r; 
    $result := $ref($ptr(^List, L#r));
    assert $position_marker();
    goto #exit;

  anon41:
    // empty

  #exit:
}



function F#qv(#s: $state, SP#front: int, SP#rear: int) : $map_t..^^mathint.$ptr_to..^^void;

const unique cf#qv: $pure_function;

axiom (forall #s: $state, SP#front: int, SP#rear: int :: { F#qv(#s, SP#front, SP#rear) } $eq.$map_t..^^mathint.$ptr_to..^^void(F#qv(#s, SP#front, SP#rear), F#lambda#8($mem(#s, $dot($ptr(^List, SP#rear), List.length)) + $mem(#s, $dot($ptr(^List, SP#front), List.length)) - 1, $int_to_map_t..^^mathint.ptr_to..^^void($mem(#s, $dot($ptr(^List, SP#rear), List.val))), $int_to_map_t..^^mathint.ptr_to..^^void($mem(#s, $dot($ptr(^List, SP#front), List.val))), $mem(#s, $dot($ptr(^List, SP#front), List.length)))));

axiom $function_arg_type(cf#qv, 0, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#qv, 1, $ptr_to(^List));

axiom $function_arg_type(cf#qv, 2, $ptr_to(^List));

procedure qv(SP#front: int, SP#rear: int) returns ($result: $map_t..^^mathint.$ptr_to..^^void);
  ensures $eq.$map_t..^^mathint.$ptr_to..^^void($result, F#lambda#8($mem($s, $dot($ptr(^List, SP#rear), List.length)) + $mem($s, $dot($ptr(^List, SP#front), List.length)) - 1, $int_to_map_t..^^mathint.ptr_to..^^void($mem($s, $dot($ptr(^List, SP#rear), List.val))), $int_to_map_t..^^mathint.ptr_to..^^void($mem($s, $dot($ptr(^List, SP#front), List.val))), $mem($s, $dot($ptr(^List, SP#front), List.length))));
  free ensures $result == F#qv($s, SP#front, SP#rear);
  free ensures $call_transition(old($s), $s);



procedure QueueNew() returns ($result: int);
  modifies $s, $cev_pc;
  free ensures $in_range_phys_ptr($ref($ptr(^Queue, $result)));
  ensures $is_fresh(old($s), $s, $ptr(^Queue, $result)) && $wrapped($s, $ptr(^Queue, $result), ^Queue);
  ensures $eq.$map_t..^^mathint.$ptr_to..^^void(F#qv($s, $ref($read_ptr($s, $dot($ptr(^Queue, $result), Queue.front), ^List)), $ref($read_ptr($s, $dot($ptr(^Queue, $result), Queue.rear), ^List))), F#lambda#9());
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation QueueNew() returns ($result: int)
{
  var owns#35: $ptrset;
  var staticWrapState#34: $state;
  var prestate#36: $state;
  var res_ListNew#15: int where $in_range_phys_ptr(res_ListNew#15);
  var res_ListNew#14: int where $in_range_phys_ptr(res_ListNew#14);
  var #callConv#2: $ptr;
  var L#r: int where $in_range_phys_ptr(L#r);
  var #wrTime$1^121.1: int;
  var #stackframe: int;

  anon42:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^121.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^121.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^121.1, #p) } $in_writes_at(#wrTime$1^121.1, #p) == false);
    // struct Queue* r; 
    assume $local_value_is($s, #tok$1^125.3, #loc.r, $ptr_to_int($ptr(^Queue, L#r)), $ptr_to(^Queue)) && $local_value_is_ptr($s, #tok$1^125.3, #loc.r, $ptr(^Queue, L#r), $ptr_to(^Queue));
    // r := _vcc_alloc(@_vcc_typeof((struct Queue*)@null)); 
    call #callConv#2 := $alloc(^Queue);
    assume $full_stop_ext(#tok$1^125.14, $s);
    L#r := $ref(#callConv#2);
    assume $local_value_is($s, #tok$1^125.14, #loc.r, $ptr_to_int($ptr(^Queue, L#r)), $ptr_to(^Queue)) && $local_value_is_ptr($s, #tok$1^125.14, #loc.r, $ptr(^Queue, L#r), $ptr_to(^Queue));
    // assume (_Bool)r; 
    assume $ptr_neq($ptr(^Queue, L#r), $null);
    // struct List* res_ListNew#14; 
    assume $local_value_is($s, #tok$1^127.14, #loc.res_ListNew#14, $ptr_to_int($ptr(^List, res_ListNew#14)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^127.14, #loc.res_ListNew#14, $ptr(^List, res_ListNew#14), $ptr_to(^List));
    // res_ListNew#14 := ListNew(); 
    call res_ListNew#14 := ListNew();
    assume $full_stop_ext(#tok$1^127.14, $s);
    assume $local_value_is($s, #tok$1^127.14, #loc.res_ListNew#14, $ptr_to_int($ptr(^List, res_ListNew#14)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^127.14, #loc.res_ListNew#14, $ptr(^List, res_ListNew#14), $ptr_to(^List));
    // assert @_vcc_typed2(@state, (r->front)); 
    assert $typed2($s, $dot($ptr(^Queue, L#r), Queue.front), $ptr_to(^List));
    // assert @prim_writes_check((r->front)); 
    assert $writable($s, #wrTime$1^121.1, $dot($ptr(^Queue, L#r), Queue.front));
    // *(r->front) := res_ListNew#14; 
    call $write_int($dot($ptr(^Queue, L#r), Queue.front), $ref($ptr(^List, res_ListNew#14)));
    assume $full_stop_ext(#tok$1^127.3, $s);
    // struct List* res_ListNew#15; 
    assume $local_value_is($s, #tok$1^128.13, #loc.res_ListNew#15, $ptr_to_int($ptr(^List, res_ListNew#15)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^128.13, #loc.res_ListNew#15, $ptr(^List, res_ListNew#15), $ptr_to(^List));
    // res_ListNew#15 := ListNew(); 
    call res_ListNew#15 := ListNew();
    assume $full_stop_ext(#tok$1^128.13, $s);
    assume $local_value_is($s, #tok$1^128.13, #loc.res_ListNew#15, $ptr_to_int($ptr(^List, res_ListNew#15)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^128.13, #loc.res_ListNew#15, $ptr(^List, res_ListNew#15), $ptr_to(^List));
    // assert @_vcc_typed2(@state, (r->rear)); 
    assert $typed2($s, $dot($ptr(^Queue, L#r), Queue.rear), $ptr_to(^List));
    // assert @prim_writes_check((r->rear)); 
    assert $writable($s, #wrTime$1^121.1, $dot($ptr(^Queue, L#r), Queue.rear));
    // *(r->rear) := res_ListNew#15; 
    call $write_int($dot($ptr(^Queue, L#r), Queue.rear), $ref($ptr(^List, res_ListNew#15)));
    assume $full_stop_ext(#tok$1^128.3, $s);
    // _math state_t prestate#36; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#36, $state_to_int(prestate#36), ^$#state_t);
    // prestate#36 := @_vcc_current_state(@state); 
    prestate#36 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#36, $state_to_int(prestate#36), ^$#state_t);
    // _math state_t staticWrapState#34; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#34, $state_to_int(staticWrapState#34), ^$#state_t);
    // staticWrapState#34 := @_vcc_current_state(@state); 
    staticWrapState#34 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#34, $state_to_int(staticWrapState#34), ^$#state_t);
    // _math ptrset owns#35; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#35, $ptrset_to_int(owns#35), ^$#ptrset);
    // owns#35 := @_vcc_set_empty; 
    owns#35 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#35, $ptrset_to_int(owns#35), ^$#ptrset);
    // assert @writes_check(r); 
    assert $top_writable($s, #wrTime$1^121.1, $ptr(^Queue, L#r));
    // assert @_vcc_wrapped(@state, *((r->rear))); 
    assert $wrapped($s, $read_ptr($s, $dot($ptr(^Queue, L#r), Queue.rear), ^List), ^List);
    // assert @writes_check(*((r->rear))); 
    assert $top_writable($s, #wrTime$1^121.1, $read_ptr($s, $dot($ptr(^Queue, L#r), Queue.rear), ^List));
    // owns#35 := pure(@_vcc_set_union(owns#35, @_vcc_set_singleton(*((r->rear))))); 
    owns#35 := $set_union(owns#35, $set_singleton($read_ptr($s, $dot($ptr(^Queue, L#r), Queue.rear), ^List)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#35, $ptrset_to_int(owns#35), ^$#ptrset);
    // staticWrapState#34 := pure(@_vcc_take_over(staticWrapState#34, r, *((r->rear)))); 
    staticWrapState#34 := $take_over(staticWrapState#34, $ptr(^Queue, L#r), $read_ptr($s, $dot($ptr(^Queue, L#r), Queue.rear), ^List));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#34, $state_to_int(staticWrapState#34), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((r->front))); 
    assert $wrapped($s, $read_ptr($s, $dot($ptr(^Queue, L#r), Queue.front), ^List), ^List);
    // assert @writes_check(*((r->front))); 
    assert $top_writable($s, #wrTime$1^121.1, $read_ptr($s, $dot($ptr(^Queue, L#r), Queue.front), ^List));
    // owns#35 := pure(@_vcc_set_union(owns#35, @_vcc_set_singleton(*((r->front))))); 
    owns#35 := $set_union(owns#35, $set_singleton($read_ptr($s, $dot($ptr(^Queue, L#r), Queue.front), ^List)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#35, $ptrset_to_int(owns#35), ^$#ptrset);
    // staticWrapState#34 := pure(@_vcc_take_over(staticWrapState#34, r, *((r->front)))); 
    staticWrapState#34 := $take_over(staticWrapState#34, $ptr(^Queue, L#r), $read_ptr($s, $dot($ptr(^Queue, L#r), Queue.front), ^List));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#34, $state_to_int(staticWrapState#34), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(r), staticWrapState#34, owns#35)
    call $static_wrap($ptr(^Queue, L#r), staticWrapState#34, owns#35);
    assume $good_state_ext(#tok$1^129.19, $s);
    // assert @inv_check(@_vcc_is_malloc_root(@state, r)); 
    assert $is_malloc_root($s, $ptr(^Queue, L#r));
    // assert @inv_check(@_vcc_ptr_neq(*((r->front)), *((r->rear)))); 
    assert $ptr_neq($read_ptr($s, $dot($ptr(^Queue, L#r), Queue.front), ^List), $read_ptr($s, $dot($ptr(^Queue, L#r), Queue.rear), ^List));
    // assert @inv_check(@keeps_stable(old(prestate#36, *((r->front))), *((r->front)))); 
    assert $read_ptr(prestate#36, $dot($ptr(^Queue, L#r), Queue.front), ^List) == $read_ptr($s, $dot($ptr(^Queue, L#r), Queue.front), ^List);
    // assert @inv_check(@keeps(r, *((r->front)))); 
    assert $keeps($s, $ptr(^Queue, L#r), $read_ptr($s, $dot($ptr(^Queue, L#r), Queue.front), ^List));
    // assert @inv_check(@keeps_stable(old(prestate#36, *((r->rear))), *((r->rear)))); 
    assert $read_ptr(prestate#36, $dot($ptr(^Queue, L#r), Queue.rear), ^List) == $read_ptr($s, $dot($ptr(^Queue, L#r), Queue.rear), ^List);
    // assert @inv_check(@keeps(r, *((r->rear)))); 
    assert $keeps($s, $ptr(^Queue, L#r), $read_ptr($s, $dot($ptr(^Queue, L#r), Queue.rear), ^List));
    // assert @inv_check(<=(*((*((r->rear))->length)), *((*((r->front))->length)))); 
    assert $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, L#r), Queue.rear), ^List), List.length)) <= $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, L#r), Queue.front), ^List), List.length));
    // assert @inv_check(<=(+(*((*((r->front))->length)), *((*((r->rear))->length))), 4294967295)); 
    assert $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, L#r), Queue.front), ^List), List.length)) + $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, L#r), Queue.rear), ^List), List.length)) <= 4294967295;
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return r; 
    $result := $ref($ptr(^Queue, L#r));
    assert $position_marker();
    goto #exit;

  anon43:
    // empty

  #exit:
}



procedure QueueBuild(P#front: int, P#rear: int) returns ($result: int);
  requires $mem($s, $dot($ptr(^List, P#front), List.length)) + $mem($s, $dot($ptr(^List, P#rear), List.length)) <= 4294967295;
  requires $wrapped($s, $ptr(^List, P#front), ^List);
  requires $wrapped($s, $ptr(^List, P#rear), ^List);
  requires $ptr_neq($ptr(^List, P#front), $ptr(^List, P#rear));
  modifies $s, $cev_pc;
  free ensures $in_range_phys_ptr($ref($ptr(^Queue, $result)));
  ensures $wrapped($s, $ptr(^Queue, $result), ^Queue) && $in_domain_lab($s, $ptr(^Queue, $result), $ptr(^Queue, $result), l#public) && $is_fresh(old($s), $s, $ptr(^Queue, $result));
  ensures $unchk_add(^^u4, $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, $result), Queue.front), ^List), List.length)), $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, $result), Queue.rear), ^List), List.length))) == $mem(old($s), $dot($ptr(^List, P#front), List.length)) + $mem(old($s), $dot($ptr(^List, P#rear), List.length));
  ensures $eq.$map_t..^^mathint.$ptr_to..^^void(F#qv($s, $ref($read_ptr($s, $dot($ptr(^Queue, $result), Queue.front), ^List)), $ref($read_ptr($s, $dot($ptr(^Queue, $result), Queue.rear), ^List))), F#qv(old($s), $ref($ptr(^List, P#front)), $ref($ptr(^List, P#rear))));
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^List, P#front) || #p == $ptr(^List, P#rear) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^List, P#front) || #p == $ptr(^List, P#rear) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^List, P#front) || #p == $ptr(^List, P#rear) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation QueueBuild(P#front: int, P#rear: int) returns ($result: int)
{
  var owns#38: $ptrset;
  var staticWrapState#37: $state;
  var prestate#39: $state;
  var res_ListNew#17: int where $in_range_phys_ptr(res_ListNew#17);
  var res_Concat#16: int where $in_range_phys_ptr(res_Concat#16);
  var L#f: int where $in_range_phys_ptr(L#f);
  var #callConv#3: $ptr;
  var L#r: int where $in_range_phys_ptr(L#r);
  var #wrTime$1^133.1: int;
  var #stackframe: int;

  anon46:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^133.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^133.1, #loc.front, $ptr_to_int($ptr(^List, P#front)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^133.1, #loc.front, $ptr(^List, P#front), $ptr_to(^List));
    assume $local_value_is($s, #tok$1^133.1, #loc.rear, $ptr_to_int($ptr(^List, P#rear)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^133.1, #loc.rear, $ptr(^List, P#rear), $ptr_to(^List));
    assume #wrTime$1^133.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^133.1, #p) } $in_writes_at(#wrTime$1^133.1, #p) == (#p == $ptr(^List, P#front) || #p == $ptr(^List, P#rear)));
    assume $thread_owned($s, $ptr(^List, P#front));
    assume $thread_owned($s, $ptr(^List, P#rear));
    // assume @in_range_phys_ptr((mathint)front); 
    assume $in_range_phys_ptr($ref($ptr(^List, P#front)));
    // assume @in_range_phys_ptr((mathint)rear); 
    assume $in_range_phys_ptr($ref($ptr(^List, P#rear)));
    // assert @_vcc_in_domain(@state, rear, rear); 
    assert $in_domain_lab($s, $ptr(^List, P#rear), $ptr(^List, P#rear), l#public);
    // assert @_vcc_in_domain(@state, front, front); 
    assert $in_domain_lab($s, $ptr(^List, P#front), $ptr(^List, P#front), l#public);
    // struct Queue* r; 
    assume $local_value_is($s, #tok$1^141.3, #loc.r, $ptr_to_int($ptr(^Queue, L#r)), $ptr_to(^Queue)) && $local_value_is_ptr($s, #tok$1^141.3, #loc.r, $ptr(^Queue, L#r), $ptr_to(^Queue));
    // r := _vcc_alloc(@_vcc_typeof((struct Queue*)@null)); 
    call #callConv#3 := $alloc(^Queue);
    assume $full_stop_ext(#tok$1^141.14, $s);
    L#r := $ref(#callConv#3);
    assume $local_value_is($s, #tok$1^141.14, #loc.r, $ptr_to_int($ptr(^Queue, L#r)), $ptr_to(^Queue)) && $local_value_is_ptr($s, #tok$1^141.14, #loc.r, $ptr(^Queue, L#r), $ptr_to(^Queue));
    // assume (_Bool)r; 
    assume $ptr_neq($ptr(^Queue, L#r), $null);
    // assert @reads_check_normal((rear->length)); 
    assert $typed2($s, $dot($ptr(^List, P#rear), List.length), ^^u4);
    assert $thread_local2($s, $dot($ptr(^List, P#rear), List.length), ^^u4);
    // assert @reads_check_normal((front->length)); 
    assert $typed2($s, $dot($ptr(^List, P#front), List.length), ^^u4);
    assert $thread_local2($s, $dot($ptr(^List, P#front), List.length), ^^u4);
    assume true;
    // if (<=(*((rear->length)), *((front->length)))) ...
    if ($mem($s, $dot($ptr(^List, P#rear), List.length)) <= $mem($s, $dot($ptr(^List, P#front), List.length)))
    {
      anon44:
        // assert @_vcc_typed2(@state, (r->front)); 
        assert $typed2($s, $dot($ptr(^Queue, L#r), Queue.front), $ptr_to(^List));
        // assert @prim_writes_check((r->front)); 
        assert $writable($s, #wrTime$1^133.1, $dot($ptr(^Queue, L#r), Queue.front));
        // *(r->front) := front; 
        call $write_int($dot($ptr(^Queue, L#r), Queue.front), $ref($ptr(^List, P#front)));
        assume $full_stop_ext(#tok$1^144.5, $s);
        // assert @_vcc_typed2(@state, (r->rear)); 
        assert $typed2($s, $dot($ptr(^Queue, L#r), Queue.rear), $ptr_to(^List));
        // assert @prim_writes_check((r->rear)); 
        assert $writable($s, #wrTime$1^133.1, $dot($ptr(^Queue, L#r), Queue.rear));
        // *(r->rear) := rear; 
        call $write_int($dot($ptr(^Queue, L#r), Queue.rear), $ref($ptr(^List, P#rear)));
        assume $full_stop_ext(#tok$1^145.5, $s);
    }
    else
    {
      anon45:
        // struct List* f; 
        assume $local_value_is($s, #tok$1^147.5, #loc.f, $ptr_to_int($ptr(^List, L#f)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^147.5, #loc.f, $ptr(^List, L#f), $ptr_to(^List));
        // var struct List* f
        // non-pure function
        // assert @writes_check(rear); 
        assert $top_writable($s, #wrTime$1^133.1, $ptr(^List, P#rear));
        // f := Reverse(rear); 
        call L#f := Reverse($ref($ptr(^List, P#rear)));
        assume $full_stop_ext(#tok$1^148.9, $s);
        assume $local_value_is($s, #tok$1^148.9, #loc.f, $ptr_to_int($ptr(^List, L#f)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^148.9, #loc.f, $ptr(^List, L#f), $ptr_to(^List));
        // struct List* res_Concat#16; 
        assume $local_value_is($s, #tok$1^149.16, #loc.res_Concat#16, $ptr_to_int($ptr(^List, res_Concat#16)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^149.16, #loc.res_Concat#16, $ptr(^List, res_Concat#16), $ptr_to(^List));
        // assert @writes_check(front); 
        assert $top_writable($s, #wrTime$1^133.1, $ptr(^List, P#front));
        // assert @writes_check(f); 
        assert $top_writable($s, #wrTime$1^133.1, $ptr(^List, L#f));
        // res_Concat#16 := Concat(front, f); 
        call res_Concat#16 := Concat($ref($ptr(^List, P#front)), $ref($ptr(^List, L#f)));
        assume $full_stop_ext(#tok$1^149.16, $s);
        assume $local_value_is($s, #tok$1^149.16, #loc.res_Concat#16, $ptr_to_int($ptr(^List, res_Concat#16)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^149.16, #loc.res_Concat#16, $ptr(^List, res_Concat#16), $ptr_to(^List));
        // assert @_vcc_typed2(@state, (r->front)); 
        assert $typed2($s, $dot($ptr(^Queue, L#r), Queue.front), $ptr_to(^List));
        // assert @prim_writes_check((r->front)); 
        assert $writable($s, #wrTime$1^133.1, $dot($ptr(^Queue, L#r), Queue.front));
        // *(r->front) := res_Concat#16; 
        call $write_int($dot($ptr(^Queue, L#r), Queue.front), $ref($ptr(^List, res_Concat#16)));
        assume $full_stop_ext(#tok$1^149.5, $s);
        // struct List* res_ListNew#17; 
        assume $local_value_is($s, #tok$1^150.15, #loc.res_ListNew#17, $ptr_to_int($ptr(^List, res_ListNew#17)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^150.15, #loc.res_ListNew#17, $ptr(^List, res_ListNew#17), $ptr_to(^List));
        // res_ListNew#17 := ListNew(); 
        call res_ListNew#17 := ListNew();
        assume $full_stop_ext(#tok$1^150.15, $s);
        assume $local_value_is($s, #tok$1^150.15, #loc.res_ListNew#17, $ptr_to_int($ptr(^List, res_ListNew#17)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^150.15, #loc.res_ListNew#17, $ptr(^List, res_ListNew#17), $ptr_to(^List));
        // assert @_vcc_typed2(@state, (r->rear)); 
        assert $typed2($s, $dot($ptr(^Queue, L#r), Queue.rear), $ptr_to(^List));
        // assert @prim_writes_check((r->rear)); 
        assert $writable($s, #wrTime$1^133.1, $dot($ptr(^Queue, L#r), Queue.rear));
        // *(r->rear) := res_ListNew#17; 
        call $write_int($dot($ptr(^Queue, L#r), Queue.rear), $ref($ptr(^List, res_ListNew#17)));
        assume $full_stop_ext(#tok$1^150.5, $s);
    }

  anon47:
    // _math state_t prestate#39; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#39, $state_to_int(prestate#39), ^$#state_t);
    // prestate#39 := @_vcc_current_state(@state); 
    prestate#39 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#39, $state_to_int(prestate#39), ^$#state_t);
    // _math state_t staticWrapState#37; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#37, $state_to_int(staticWrapState#37), ^$#state_t);
    // staticWrapState#37 := @_vcc_current_state(@state); 
    staticWrapState#37 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#37, $state_to_int(staticWrapState#37), ^$#state_t);
    // _math ptrset owns#38; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#38, $ptrset_to_int(owns#38), ^$#ptrset);
    // owns#38 := @_vcc_set_empty; 
    owns#38 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#38, $ptrset_to_int(owns#38), ^$#ptrset);
    // assert @writes_check(r); 
    assert $top_writable($s, #wrTime$1^133.1, $ptr(^Queue, L#r));
    // assert @_vcc_wrapped(@state, *((r->rear))); 
    assert $wrapped($s, $read_ptr($s, $dot($ptr(^Queue, L#r), Queue.rear), ^List), ^List);
    // assert @writes_check(*((r->rear))); 
    assert $top_writable($s, #wrTime$1^133.1, $read_ptr($s, $dot($ptr(^Queue, L#r), Queue.rear), ^List));
    // owns#38 := pure(@_vcc_set_union(owns#38, @_vcc_set_singleton(*((r->rear))))); 
    owns#38 := $set_union(owns#38, $set_singleton($read_ptr($s, $dot($ptr(^Queue, L#r), Queue.rear), ^List)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#38, $ptrset_to_int(owns#38), ^$#ptrset);
    // staticWrapState#37 := pure(@_vcc_take_over(staticWrapState#37, r, *((r->rear)))); 
    staticWrapState#37 := $take_over(staticWrapState#37, $ptr(^Queue, L#r), $read_ptr($s, $dot($ptr(^Queue, L#r), Queue.rear), ^List));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#37, $state_to_int(staticWrapState#37), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((r->front))); 
    assert $wrapped($s, $read_ptr($s, $dot($ptr(^Queue, L#r), Queue.front), ^List), ^List);
    // assert @writes_check(*((r->front))); 
    assert $top_writable($s, #wrTime$1^133.1, $read_ptr($s, $dot($ptr(^Queue, L#r), Queue.front), ^List));
    // owns#38 := pure(@_vcc_set_union(owns#38, @_vcc_set_singleton(*((r->front))))); 
    owns#38 := $set_union(owns#38, $set_singleton($read_ptr($s, $dot($ptr(^Queue, L#r), Queue.front), ^List)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#38, $ptrset_to_int(owns#38), ^$#ptrset);
    // staticWrapState#37 := pure(@_vcc_take_over(staticWrapState#37, r, *((r->front)))); 
    staticWrapState#37 := $take_over(staticWrapState#37, $ptr(^Queue, L#r), $read_ptr($s, $dot($ptr(^Queue, L#r), Queue.front), ^List));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#37, $state_to_int(staticWrapState#37), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(r), staticWrapState#37, owns#38)
    call $static_wrap($ptr(^Queue, L#r), staticWrapState#37, owns#38);
    assume $good_state_ext(#tok$1^152.19, $s);
    // assert @inv_check(@_vcc_is_malloc_root(@state, r)); 
    assert $is_malloc_root($s, $ptr(^Queue, L#r));
    // assert @inv_check(@_vcc_ptr_neq(*((r->front)), *((r->rear)))); 
    assert $ptr_neq($read_ptr($s, $dot($ptr(^Queue, L#r), Queue.front), ^List), $read_ptr($s, $dot($ptr(^Queue, L#r), Queue.rear), ^List));
    // assert @inv_check(@keeps_stable(old(prestate#39, *((r->front))), *((r->front)))); 
    assert $read_ptr(prestate#39, $dot($ptr(^Queue, L#r), Queue.front), ^List) == $read_ptr($s, $dot($ptr(^Queue, L#r), Queue.front), ^List);
    // assert @inv_check(@keeps(r, *((r->front)))); 
    assert $keeps($s, $ptr(^Queue, L#r), $read_ptr($s, $dot($ptr(^Queue, L#r), Queue.front), ^List));
    // assert @inv_check(@keeps_stable(old(prestate#39, *((r->rear))), *((r->rear)))); 
    assert $read_ptr(prestate#39, $dot($ptr(^Queue, L#r), Queue.rear), ^List) == $read_ptr($s, $dot($ptr(^Queue, L#r), Queue.rear), ^List);
    // assert @inv_check(@keeps(r, *((r->rear)))); 
    assert $keeps($s, $ptr(^Queue, L#r), $read_ptr($s, $dot($ptr(^Queue, L#r), Queue.rear), ^List));
    // assert @inv_check(<=(*((*((r->rear))->length)), *((*((r->front))->length)))); 
    assert $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, L#r), Queue.rear), ^List), List.length)) <= $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, L#r), Queue.front), ^List), List.length));
    // assert @inv_check(<=(+(*((*((r->front))->length)), *((*((r->rear))->length))), 4294967295)); 
    assert $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, L#r), Queue.front), ^List), List.length)) + $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, L#r), Queue.rear), ^List), List.length)) <= 4294967295;
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return r; 
    $result := $ref($ptr(^Queue, L#r));
    assert $position_marker();
    goto #exit;

  anon48:
    // empty

  #exit:
}



procedure QueueFront(P#q: int) returns ($result: int);
  requires $wrapped($s, $ptr(^Queue, P#q), ^Queue);
  requires $unchk_add(^^u4, $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List), List.length)), $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List), List.length))) > 0;
  modifies $s, $cev_pc;
  free ensures $in_range_phys_ptr($ref($ptr(^^void, $result)));
  ensures $ptr_eq($ptr(^^void, $result), $ptr(^^void, $select.$map_t..^^mathint.$ptr_to..^^void(F#qv($s, $ref($read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List)), $ref($read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List))), 0)));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation QueueFront(P#q: int) returns ($result: int)
{
  var #wrTime$1^156.1: int;
  var #stackframe: int;

  anon49:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^156.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^156.1, #loc.q, $ptr_to_int($ptr(^Queue, P#q)), $ptr_to(^Queue)) && $local_value_is_ptr($s, #tok$1^156.1, #loc.q, $ptr(^Queue, P#q), $ptr_to(^Queue));
    assume #wrTime$1^156.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^156.1, #p) } $in_writes_at(#wrTime$1^156.1, #p) == false);
    // assume @in_range_phys_ptr((mathint)q); 
    assume $in_range_phys_ptr($ref($ptr(^Queue, P#q)));
    // assert @_vcc_in_domain(@state, q, q); 
    assert $in_domain_lab($s, $ptr(^Queue, P#q), $ptr(^Queue, P#q), l#public);
    // assert @_vcc_in_domain(@state, *((q->front)), q); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List), $ptr(^Queue, P#q), l#public);
    // assume @_vcc_in_domain(@state, *((q->front)), q); 
    assume $in_domain_lab($s, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List), $ptr(^Queue, P#q), l#public);
    // assert @reads_check_normal((*((q->front))->head)); 
    assert $typed2($s, $dot($read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List), List.head), $ptr_to(^^void));
    assert $thread_local2($s, $dot($read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List), List.head), $ptr_to(^^void));
    // assert @reads_check_normal((q->front)); 
    assert $typed2($s, $dot($ptr(^Queue, P#q), Queue.front), $ptr_to(^List));
    assert $thread_local2($s, $dot($ptr(^Queue, P#q), Queue.front), $ptr_to(^List));
    // return *((*((q->front))->head)); 
    $result := $ref($read_ptr($s, $dot($read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List), List.head), ^^void));
    assert $position_marker();
    goto #exit;

  anon50:
    // empty

  #exit:
}



procedure QueueTail(P#q: int) returns ($result: int);
  requires $wrapped($s, $ptr(^Queue, P#q), ^Queue);
  requires $unchk_add(^^u4, $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List), List.length)), $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List), List.length))) > 0;
  modifies $s, $cev_pc;
  free ensures $in_range_phys_ptr($ref($ptr(^Queue, $result)));
  ensures $is_fresh(old($s), $s, $ptr(^Queue, $result)) && $wrapped($s, $ptr(^Queue, $result), ^Queue);
  ensures $unchk_add(^^u4, $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, $result), Queue.front), ^List), List.length)), $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, $result), Queue.rear), ^List), List.length))) == $unchk_add(^^u4, $mem(old($s), $dot($read_ptr(old($s), $dot($ptr(^Queue, P#q), Queue.front), ^List), List.length)), $mem(old($s), $dot($read_ptr(old($s), $dot($ptr(^Queue, P#q), Queue.rear), ^List), List.length))) - 1;
  ensures $eq.$map_t..^^mathint.$ptr_to..^^void(F#qv($s, $ref($read_ptr($s, $dot($ptr(^Queue, $result), Queue.front), ^List)), $ref($read_ptr($s, $dot($ptr(^Queue, $result), Queue.rear), ^List))), F#lambda#10(F#qv(old($s), $ref($read_ptr(old($s), $dot($ptr(^Queue, P#q), Queue.front), ^List)), $ref($read_ptr(old($s), $dot($ptr(^Queue, P#q), Queue.rear), ^List)))));
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Queue, P#q) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Queue, P#q) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Queue, P#q) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation QueueTail(P#q: int) returns ($result: int)
{
  var prestate#42: $state;
  var prestate#40: $state;
  var owns#41: $ptrset;
  var L#t: int where $in_range_phys_ptr(L#t);
  var L#r: int where $in_range_phys_ptr(L#r);
  var #wrTime$1^164.1: int;
  var #stackframe: int;

  anon51:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^164.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^164.1, #loc.q, $ptr_to_int($ptr(^Queue, P#q)), $ptr_to(^Queue)) && $local_value_is_ptr($s, #tok$1^164.1, #loc.q, $ptr(^Queue, P#q), $ptr_to(^Queue));
    assume #wrTime$1^164.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^164.1, #p) } $in_writes_at(#wrTime$1^164.1, #p) == (#p == $ptr(^Queue, P#q)));
    assume $thread_owned($s, $ptr(^Queue, P#q));
    // assume @in_range_phys_ptr((mathint)q); 
    assume $in_range_phys_ptr($ref($ptr(^Queue, P#q)));
    // assert @_vcc_in_domain(@state, q, q); 
    assert $in_domain_lab($s, $ptr(^Queue, P#q), $ptr(^Queue, P#q), l#public);
    // struct Queue* r; 
    assume $local_value_is($s, #tok$1^174.3, #loc.r, $ptr_to_int($ptr(^Queue, L#r)), $ptr_to(^Queue)) && $local_value_is_ptr($s, #tok$1^174.3, #loc.r, $ptr(^Queue, L#r), $ptr_to(^Queue));
    // struct List* t; 
    assume $local_value_is($s, #tok$1^173.3, #loc.t, $ptr_to_int($ptr(^List, L#t)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^173.3, #loc.t, $ptr(^List, L#t), $ptr_to(^List));
    // _math ptrset owns#41; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#41, $ptrset_to_int(owns#41), ^$#ptrset);
    // owns#41 := @_vcc_set_empty; 
    owns#41 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#41, $ptrset_to_int(owns#41), ^$#ptrset);
    // _math state_t prestate#40; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#40, $state_to_int(prestate#40), ^$#state_t);
    // prestate#40 := @_vcc_current_state(@state); 
    prestate#40 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#40, $state_to_int(prestate#40), ^$#state_t);
    // _math state_t prestate#42; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#42, $state_to_int(prestate#42), ^$#state_t);
    // prestate#42 := @_vcc_current_state(@state); 
    prestate#42 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#42, $state_to_int(prestate#42), ^$#state_t);
    // assert @_vcc_wrapped(@state, q); 
    assert $wrapped($s, $ptr(^Queue, P#q), ^Queue);
    // assert @writes_check(q); 
    assert $top_writable($s, #wrTime$1^164.1, $ptr(^Queue, P#q));
    // assume @_vcc_inv(@state, q); 
    assume $inv($s, $ptr(^Queue, P#q), ^Queue);
    // prestate#42 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#42, q, *((q->rear)))); 
    prestate#42 := $release($current_state($s), prestate#42, $ptr(^Queue, P#q), $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#42, $state_to_int(prestate#42), ^$#state_t);
    // owns#41 := pure(@_vcc_set_union(owns#41, @_vcc_set_singleton(*((q->rear))))); 
    owns#41 := $set_union(owns#41, $set_singleton($read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#41, $ptrset_to_int(owns#41), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((q->rear)))); 
    assume $typed($s, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List));
    // prestate#42 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#42, q, *((q->front)))); 
    prestate#42 := $release($current_state($s), prestate#42, $ptr(^Queue, P#q), $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#42, $state_to_int(prestate#42), ^$#state_t);
    // owns#41 := pure(@_vcc_set_union(owns#41, @_vcc_set_singleton(*((q->front))))); 
    owns#41 := $set_union(owns#41, $set_singleton($read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#41, $ptrset_to_int(owns#41), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((q->front)))); 
    assume $typed($s, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List));
    // assume ==(owns#41, @_vcc_owns(@state, q)); 
    assume owns#41 == $owns($s, $ptr(^Queue, P#q));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(q), prestate#42)
    call $static_unwrap($ptr(^Queue, P#q), prestate#42);
    assume $good_state_ext(#tok$1^171.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_wrapped(@state, *((q->front))); 
    assert $wrapped($s, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List), ^List);
    // assert @_vcc_in_domain(@state, *((q->front)), *((q->front))); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List), $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List), l#public);
    // assert @_vcc_wrapped(@state, *((q->rear))); 
    assert $wrapped($s, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List), ^List);
    // assert @_vcc_in_domain(@state, *((q->rear)), *((q->rear))); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List), $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List), l#public);
    // assume &&(&&(@_vcc_wrapped(@state, *((q->front))), @_vcc_in_domain(@state, *((q->front)), *((q->front)))), &&(@_vcc_wrapped(@state, *((q->rear))), @_vcc_in_domain(@state, *((q->rear)), *((q->rear))))); 
    assume $wrapped($s, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List), ^List) && $in_domain_lab($s, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List), $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List), l#public) && $wrapped($s, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List), ^List) && $in_domain_lab($s, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List), $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List), l#public);
    // non-pure function
    // assert @writes_check(*((q->front))); 
    assert $top_writable($s, #wrTime$1^164.1, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List));
    // assert @reads_check_normal((q->front)); 
    assert $typed2($s, $dot($ptr(^Queue, P#q), Queue.front), $ptr_to(^List));
    assert $thread_local2($s, $dot($ptr(^Queue, P#q), Queue.front), $ptr_to(^List));
    // t := Tail(*((q->front))); 
    call L#t := Tail($ref($read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List)));
    assume $full_stop_ext(#tok$1^173.13, $s);
    assume $local_value_is($s, #tok$1^173.13, #loc.t, $ptr_to_int($ptr(^List, L#t)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^173.13, #loc.t, $ptr(^List, L#t), $ptr_to(^List));
    // non-pure function
    // assert @writes_check(t); 
    assert $top_writable($s, #wrTime$1^164.1, $ptr(^List, L#t));
    // assert @writes_check(*((q->rear))); 
    assert $top_writable($s, #wrTime$1^164.1, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List));
    // assert @reads_check_normal((q->rear)); 
    assert $typed2($s, $dot($ptr(^Queue, P#q), Queue.rear), $ptr_to(^List));
    assert $thread_local2($s, $dot($ptr(^Queue, P#q), Queue.rear), $ptr_to(^List));
    // r := QueueBuild(t, *((q->rear))); 
    call L#r := QueueBuild($ref($ptr(^List, L#t)), $ref($read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List)));
    assume $full_stop_ext(#tok$1^174.14, $s);
    assume $local_value_is($s, #tok$1^174.14, #loc.r, $ptr_to_int($ptr(^Queue, L#r)), $ptr_to(^Queue)) && $local_value_is_ptr($s, #tok$1^174.14, #loc.r, $ptr(^Queue, L#r), $ptr_to(^Queue));
    // assert @writes_check(q); 
    assert $top_writable($s, #wrTime$1^164.1, $ptr(^Queue, P#q));
    // assert @writes_check(@_vcc_extent(@state, q)); 
    assert (forall #writes$1^175.3: $ptr :: { $dont_instantiate(#writes$1^175.3) } $set_in(#writes$1^175.3, $extent($s, $ptr(^Queue, P#q))) ==> $top_writable($s, #wrTime$1^164.1, #writes$1^175.3));
    // stmt _vcc_free(q); 
    call $free($ptr(^Queue, P#q));
    assume $full_stop_ext(#tok$1^175.3, $s);
    // return r; 
    $result := $ref($ptr(^Queue, L#r));
    assert $position_marker();
    goto #exit;

  anon52:
    // empty

  #exit:
}



procedure Enqueue(P#q: int, P#item: int) returns ($result: int);
  requires $wrapped($s, $ptr(^Queue, P#q), ^Queue);
  requires $unchk_add(^^u4, $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List), List.length)), $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List), List.length))) + 1 <= 4294967295;
  modifies $s, $cev_pc;
  free ensures $in_range_phys_ptr($ref($ptr(^Queue, $result)));
  ensures $is_fresh(old($s), $s, $ptr(^Queue, $result)) && $wrapped($s, $ptr(^Queue, $result), ^Queue);
  ensures $unchk_add(^^u4, $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, $result), Queue.front), ^List), List.length)), $mem($s, $dot($read_ptr($s, $dot($ptr(^Queue, $result), Queue.rear), ^List), List.length))) == $unchk_add(^^u4, $mem(old($s), $dot($read_ptr(old($s), $dot($ptr(^Queue, P#q), Queue.front), ^List), List.length)), $mem(old($s), $dot($read_ptr(old($s), $dot($ptr(^Queue, P#q), Queue.rear), ^List), List.length))) + 1;
  ensures $eq.$map_t..^^mathint.$ptr_to..^^void(F#qv($s, $ref($read_ptr($s, $dot($ptr(^Queue, $result), Queue.front), ^List)), $ref($read_ptr($s, $dot($ptr(^Queue, $result), Queue.rear), ^List))), F#lambda#11(F#qv(old($s), $ref($read_ptr(old($s), $dot($ptr(^Queue, P#q), Queue.front), ^List)), $ref($read_ptr(old($s), $dot($ptr(^Queue, P#q), Queue.rear), ^List))), $ref($ptr(^^void, P#item)), $unchk_add(^^u4, $mem(old($s), $dot($read_ptr(old($s), $dot($ptr(^Queue, P#q), Queue.front), ^List), List.length)), $mem(old($s), $dot($read_ptr(old($s), $dot($ptr(^Queue, P#q), Queue.rear), ^List), List.length)))));
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Queue, P#q) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Queue, P#q) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^Queue, P#q) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Enqueue(P#q: int, P#item: int) returns ($result: int)
{
  var res_Cons#18: int where $in_range_phys_ptr(res_Cons#18);
  var prestate#45: $state;
  var prestate#43: $state;
  var owns#44: $ptrset;
  var L#r: int where $in_range_phys_ptr(L#r);
  var #wrTime$1^179.1: int;
  var #stackframe: int;

  anon53:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^179.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^179.1, #loc.q, $ptr_to_int($ptr(^Queue, P#q)), $ptr_to(^Queue)) && $local_value_is_ptr($s, #tok$1^179.1, #loc.q, $ptr(^Queue, P#q), $ptr_to(^Queue));
    assume $local_value_is($s, #tok$1^179.1, #loc.item, $ptr_to_int($ptr(^^void, P#item)), $ptr_to(^^void)) && $local_value_is_ptr($s, #tok$1^179.1, #loc.item, $ptr(^^void, P#item), $ptr_to(^^void));
    assume #wrTime$1^179.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^179.1, #p) } $in_writes_at(#wrTime$1^179.1, #p) == (#p == $ptr(^Queue, P#q)));
    assume $thread_owned($s, $ptr(^Queue, P#q));
    // assume @in_range_phys_ptr((mathint)q); 
    assume $in_range_phys_ptr($ref($ptr(^Queue, P#q)));
    // assume @in_range_phys_ptr((mathint)item); 
    assume $in_range_phys_ptr($ref($ptr(^^void, P#item)));
    // assert @_vcc_in_domain(@state, q, q); 
    assert $in_domain_lab($s, $ptr(^Queue, P#q), $ptr(^Queue, P#q), l#public);
    // struct Queue* r; 
    assume $local_value_is($s, #tok$1^190.3, #loc.r, $ptr_to_int($ptr(^Queue, L#r)), $ptr_to(^Queue)) && $local_value_is_ptr($s, #tok$1^190.3, #loc.r, $ptr(^Queue, L#r), $ptr_to(^Queue));
    // _math ptrset owns#44; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#44, $ptrset_to_int(owns#44), ^$#ptrset);
    // owns#44 := @_vcc_set_empty; 
    owns#44 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#44, $ptrset_to_int(owns#44), ^$#ptrset);
    // _math state_t prestate#43; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#43, $state_to_int(prestate#43), ^$#state_t);
    // prestate#43 := @_vcc_current_state(@state); 
    prestate#43 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#43, $state_to_int(prestate#43), ^$#state_t);
    // _math state_t prestate#45; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#45, $state_to_int(prestate#45), ^$#state_t);
    // prestate#45 := @_vcc_current_state(@state); 
    prestate#45 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#45, $state_to_int(prestate#45), ^$#state_t);
    // assert @_vcc_wrapped(@state, q); 
    assert $wrapped($s, $ptr(^Queue, P#q), ^Queue);
    // assert @writes_check(q); 
    assert $top_writable($s, #wrTime$1^179.1, $ptr(^Queue, P#q));
    // assume @_vcc_inv(@state, q); 
    assume $inv($s, $ptr(^Queue, P#q), ^Queue);
    // prestate#45 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#45, q, *((q->rear)))); 
    prestate#45 := $release($current_state($s), prestate#45, $ptr(^Queue, P#q), $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#45, $state_to_int(prestate#45), ^$#state_t);
    // owns#44 := pure(@_vcc_set_union(owns#44, @_vcc_set_singleton(*((q->rear))))); 
    owns#44 := $set_union(owns#44, $set_singleton($read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#44, $ptrset_to_int(owns#44), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((q->rear)))); 
    assume $typed($s, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List));
    // prestate#45 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#45, q, *((q->front)))); 
    prestate#45 := $release($current_state($s), prestate#45, $ptr(^Queue, P#q), $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#45, $state_to_int(prestate#45), ^$#state_t);
    // owns#44 := pure(@_vcc_set_union(owns#44, @_vcc_set_singleton(*((q->front))))); 
    owns#44 := $set_union(owns#44, $set_singleton($read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#44, $ptrset_to_int(owns#44), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((q->front)))); 
    assume $typed($s, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List));
    // assume ==(owns#44, @_vcc_owns(@state, q)); 
    assume owns#44 == $owns($s, $ptr(^Queue, P#q));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(q), prestate#45)
    call $static_unwrap($ptr(^Queue, P#q), prestate#45);
    assume $good_state_ext(#tok$1^187.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_wrapped(@state, *((q->front))); 
    assert $wrapped($s, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List), ^List);
    // assert @_vcc_in_domain(@state, *((q->front)), *((q->front))); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List), $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List), l#public);
    // assert @_vcc_wrapped(@state, *((q->rear))); 
    assert $wrapped($s, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List), ^List);
    // assert @_vcc_in_domain(@state, *((q->rear)), *((q->rear))); 
    assert $in_domain_lab($s, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List), $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List), l#public);
    // assume &&(&&(@_vcc_wrapped(@state, *((q->front))), @_vcc_in_domain(@state, *((q->front)), *((q->front)))), &&(@_vcc_wrapped(@state, *((q->rear))), @_vcc_in_domain(@state, *((q->rear)), *((q->rear))))); 
    assume $wrapped($s, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List), ^List) && $in_domain_lab($s, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List), $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List), l#public) && $wrapped($s, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List), ^List) && $in_domain_lab($s, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List), $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List), l#public);
    // struct List* res_Cons#18; 
    assume $local_value_is($s, #tok$1^189.13, #loc.res_Cons#18, $ptr_to_int($ptr(^List, res_Cons#18)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^189.13, #loc.res_Cons#18, $ptr(^List, res_Cons#18), $ptr_to(^List));
    // assert @writes_check(*((q->rear))); 
    assert $top_writable($s, #wrTime$1^179.1, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List));
    // assert @reads_check_normal((q->rear)); 
    assert $typed2($s, $dot($ptr(^Queue, P#q), Queue.rear), $ptr_to(^List));
    assert $thread_local2($s, $dot($ptr(^Queue, P#q), Queue.rear), $ptr_to(^List));
    // res_Cons#18 := Cons(*((q->rear)), item); 
    call res_Cons#18 := Cons($ref($read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List)), $ref($ptr(^^void, P#item)));
    assume $full_stop_ext(#tok$1^189.13, $s);
    assume $local_value_is($s, #tok$1^189.13, #loc.res_Cons#18, $ptr_to_int($ptr(^List, res_Cons#18)), $ptr_to(^List)) && $local_value_is_ptr($s, #tok$1^189.13, #loc.res_Cons#18, $ptr(^List, res_Cons#18), $ptr_to(^List));
    // assert @_vcc_typed2(@state, (q->rear)); 
    assert $typed2($s, $dot($ptr(^Queue, P#q), Queue.rear), $ptr_to(^List));
    // assert @prim_writes_check((q->rear)); 
    assert $writable($s, #wrTime$1^179.1, $dot($ptr(^Queue, P#q), Queue.rear));
    // *(q->rear) := res_Cons#18; 
    call $write_int($dot($ptr(^Queue, P#q), Queue.rear), $ref($ptr(^List, res_Cons#18)));
    assume $full_stop_ext(#tok$1^189.3, $s);
    // non-pure function
    // assert @writes_check(*((q->front))); 
    assert $top_writable($s, #wrTime$1^179.1, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List));
    // assert @writes_check(*((q->rear))); 
    assert $top_writable($s, #wrTime$1^179.1, $read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List));
    // assert @reads_check_normal((q->front)); 
    assert $typed2($s, $dot($ptr(^Queue, P#q), Queue.front), $ptr_to(^List));
    assert $thread_local2($s, $dot($ptr(^Queue, P#q), Queue.front), $ptr_to(^List));
    // assert @reads_check_normal((q->rear)); 
    assert $typed2($s, $dot($ptr(^Queue, P#q), Queue.rear), $ptr_to(^List));
    assert $thread_local2($s, $dot($ptr(^Queue, P#q), Queue.rear), $ptr_to(^List));
    // r := QueueBuild(*((q->front)), *((q->rear))); 
    call L#r := QueueBuild($ref($read_ptr($s, $dot($ptr(^Queue, P#q), Queue.front), ^List)), $ref($read_ptr($s, $dot($ptr(^Queue, P#q), Queue.rear), ^List)));
    assume $full_stop_ext(#tok$1^190.14, $s);
    assume $local_value_is($s, #tok$1^190.14, #loc.r, $ptr_to_int($ptr(^Queue, L#r)), $ptr_to(^Queue)) && $local_value_is_ptr($s, #tok$1^190.14, #loc.r, $ptr(^Queue, L#r), $ptr_to(^Queue));
    // return r; 
    $result := $ref($ptr(^Queue, L#r));
    assert $position_marker();
    goto #exit;

  anon54:
    // empty

  #exit:
}



function F#lambda#11(#l2: $map_t..^^mathint.$ptr_to..^^void, #l1: int, #l0: int) : $map_t..^^mathint.$ptr_to..^^void;

const unique cf#lambda#11: $pure_function;

axiom $function_arg_type(cf#lambda#11, 0, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#11, 1, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#11, 2, $ptr_to(^^void));

axiom $function_arg_type(cf#lambda#11, 3, ^^u4);

procedure lambda#11(#l2: $map_t..^^mathint.$ptr_to..^^void, #l1: int, #l0: int) returns ($result: $map_t..^^mathint.$ptr_to..^^void);
  free ensures $result == F#lambda#11(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^185.49#tc1: int, #l2: $map_t..^^mathint.$ptr_to..^^void, #l1: int, #l0: int :: { $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#11(#l2, $ref($ptr(^^void, #l1)), #l0), Q#i$1^185.49#tc1) } $in_range_phys_ptr($ref($ptr(^^void, #l1))) && $in_range_u4(#l0) ==> $ptr_eq($ptr(^^void, $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#11(#l2, $ref($ptr(^^void, #l1)), #l0), Q#i$1^185.49#tc1)), (if Q#i$1^185.49#tc1 == #l0 then $ptr(^^void, #l1) else $ptr(^^void, $select.$map_t..^^mathint.$ptr_to..^^void(#l2, Q#i$1^185.49#tc1)))));

function F#lambda#10(#l0: $map_t..^^mathint.$ptr_to..^^void) : $map_t..^^mathint.$ptr_to..^^void;

const unique cf#lambda#10: $pure_function;

axiom $function_arg_type(cf#lambda#10, 0, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#10, 1, $map_t(^^mathint, $ptr_to(^^void)));

procedure lambda#10(#l0: $map_t..^^mathint.$ptr_to..^^void) returns ($result: $map_t..^^mathint.$ptr_to..^^void);
  free ensures $result == F#lambda#10(#l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^169.49#tc1: int, #l0: $map_t..^^mathint.$ptr_to..^^void :: { $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#10(#l0), Q#i$1^169.49#tc1) } $ptr_eq($ptr(^^void, $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#10(#l0), Q#i$1^169.49#tc1)), (if Q#i$1^169.49#tc1 == -1 then $null else $ptr(^^void, $select.$map_t..^^mathint.$ptr_to..^^void(#l0, Q#i$1^169.49#tc1 + 1)))));

function F#lambda#9() : $map_t..^^mathint.$ptr_to..^^void;

const unique cf#lambda#9: $pure_function;

axiom $function_arg_type(cf#lambda#9, 0, $map_t(^^mathint, $ptr_to(^^void)));

procedure lambda#9() returns ($result: $map_t..^^mathint.$ptr_to..^^void);
  free ensures $result == F#lambda#9();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^123.44#tc1: int :: { $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#9(), Q#i$1^123.44#tc1) } $ptr_eq($ptr(^^void, $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#9(), Q#i$1^123.44#tc1)), $null));

function F#lambda#8(#l3: int, #l2: $map_t..^^mathint.$ptr_to..^^void, #l1: $map_t..^^mathint.$ptr_to..^^void, #l0: int) : $map_t..^^mathint.$ptr_to..^^void;

const unique cf#lambda#8: $pure_function;

axiom $function_arg_type(cf#lambda#8, 0, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#8, 1, ^^mathint);

axiom $function_arg_type(cf#lambda#8, 2, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#8, 3, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#8, 4, ^^u4);

procedure lambda#8(#l3: int, #l2: $map_t..^^mathint.$ptr_to..^^void, #l1: $map_t..^^mathint.$ptr_to..^^void, #l0: int) returns ($result: $map_t..^^mathint.$ptr_to..^^void);
  free ensures $result == F#lambda#8(#l3, #l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^116.27#tc1: int, #l3: int, #l2: $map_t..^^mathint.$ptr_to..^^void, #l1: $map_t..^^mathint.$ptr_to..^^void, #l0: int :: { $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#8(#l3, #l2, #l1, #l0), Q#i$1^116.27#tc1) } $in_range_u4(#l0) ==> $ptr_eq($ptr(^^void, $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#8(#l3, #l2, #l1, #l0), Q#i$1^116.27#tc1)), (if Q#i$1^116.27#tc1 < #l0 then $ptr(^^void, $select.$map_t..^^mathint.$ptr_to..^^void(#l1, Q#i$1^116.27#tc1)) else $ptr(^^void, $select.$map_t..^^mathint.$ptr_to..^^void(#l2, #l3 - Q#i$1^116.27#tc1)))));

function F#lambda#7(#l0: $map_t..^^mathint.$ptr_to..^^void) : $map_t..^^mathint.$ptr_to..^^void;

const unique cf#lambda#7: $pure_function;

axiom $function_arg_type(cf#lambda#7, 0, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#7, 1, $map_t(^^mathint, $ptr_to(^^void)));

procedure lambda#7(#l0: $map_t..^^mathint.$ptr_to..^^void) returns ($result: $map_t..^^mathint.$ptr_to..^^void);
  free ensures $result == F#lambda#7(#l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^97.48#tc1: int, #l0: $map_t..^^mathint.$ptr_to..^^void :: { $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#7(#l0), Q#i$1^97.48#tc1) } $ptr_eq($ptr(^^void, $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#7(#l0), Q#i$1^97.48#tc1)), (if Q#i$1^97.48#tc1 == -1 then $null else $ptr(^^void, $select.$map_t..^^mathint.$ptr_to..^^void(#l0, Q#i$1^97.48#tc1 + 1)))));

function F#lambda#6(#l1: int, #l0: $map_t..^^mathint.$ptr_to..^^void) : $map_t..^^mathint.$ptr_to..^^void;

const unique cf#lambda#6: $pure_function;

axiom $function_arg_type(cf#lambda#6, 0, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#6, 1, ^^mathint);

axiom $function_arg_type(cf#lambda#6, 2, $map_t(^^mathint, $ptr_to(^^void)));

procedure lambda#6(#l1: int, #l0: $map_t..^^mathint.$ptr_to..^^void) returns ($result: $map_t..^^mathint.$ptr_to..^^void);
  free ensures $result == F#lambda#6(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^75.48#tc1: int, #l1: int, #l0: $map_t..^^mathint.$ptr_to..^^void :: { $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#6(#l1, #l0), Q#i$1^75.48#tc1) } $ptr_eq($ptr(^^void, $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#6(#l1, #l0), Q#i$1^75.48#tc1)), $ptr(^^void, $select.$map_t..^^mathint.$ptr_to..^^void(#l0, #l1 - Q#i$1^75.48#tc1))));

function F#lambda#5(#l3: int, #l2: $map_t..^^mathint.$ptr_to..^^void, #l1: $map_t..^^mathint.$ptr_to..^^void, #l0: int) : $map_t..^^mathint.$ptr_to..^^void;

const unique cf#lambda#5: $pure_function;

axiom $function_arg_type(cf#lambda#5, 0, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#5, 1, ^^u4);

axiom $function_arg_type(cf#lambda#5, 2, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#5, 3, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#5, 4, ^^u4);

procedure lambda#5(#l3: int, #l2: $map_t..^^mathint.$ptr_to..^^void, #l1: $map_t..^^mathint.$ptr_to..^^void, #l0: int) returns ($result: $map_t..^^mathint.$ptr_to..^^void);
  free ensures $result == F#lambda#5(#l3, #l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^57.48#tc1: int, #l3: int, #l2: $map_t..^^mathint.$ptr_to..^^void, #l1: $map_t..^^mathint.$ptr_to..^^void, #l0: int :: { $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#5(#l3, #l2, #l1, #l0), Q#i$1^57.48#tc1) } $in_range_u4(#l3) && $in_range_u4(#l0) ==> $ptr_eq($ptr(^^void, $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#5(#l3, #l2, #l1, #l0), Q#i$1^57.48#tc1)), (if Q#i$1^57.48#tc1 < #l0 then $ptr(^^void, $select.$map_t..^^mathint.$ptr_to..^^void(#l1, Q#i$1^57.48#tc1)) else $ptr(^^void, $select.$map_t..^^mathint.$ptr_to..^^void(#l2, Q#i$1^57.48#tc1 - #l3)))));

function F#lambda#4(#l1: $map_t..^^mathint.$ptr_to..^^void, #l0: int) : $map_t..^^mathint.$ptr_to..^^void;

const unique cf#lambda#4: $pure_function;

axiom $function_arg_type(cf#lambda#4, 0, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#4, 1, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#4, 2, $ptr_to(^^void));

procedure lambda#4(#l1: $map_t..^^mathint.$ptr_to..^^void, #l0: int) returns ($result: $map_t..^^mathint.$ptr_to..^^void);
  free ensures $result == F#lambda#4(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^39.48#tc1: int, #l1: $map_t..^^mathint.$ptr_to..^^void, #l0: int :: { $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#4(#l1, $ref($ptr(^^void, #l0))), Q#i$1^39.48#tc1) } $in_range_phys_ptr($ref($ptr(^^void, #l0))) ==> $ptr_eq($ptr(^^void, $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#4(#l1, $ref($ptr(^^void, #l0))), Q#i$1^39.48#tc1)), (if Q#i$1^39.48#tc1 == 0 then $ptr(^^void, #l0) else $ptr(^^void, $select.$map_t..^^mathint.$ptr_to..^^void(#l1, Q#i$1^39.48#tc1 - 1)))));

function F#lambda#3(#l1: $map_t..^^mathint.$ptr_to..^^void, #l0: int) : $map_t..^^mathint.$ptr_to..^^void;

const unique cf#lambda#3: $pure_function;

axiom $function_arg_type(cf#lambda#3, 0, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#3, 1, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#3, 2, $ptr_to(^^void));

procedure lambda#3(#l1: $map_t..^^mathint.$ptr_to..^^void, #l0: int) returns ($result: $map_t..^^mathint.$ptr_to..^^void);
  free ensures $result == F#lambda#3(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^46.34#tc1: int, #l1: $map_t..^^mathint.$ptr_to..^^void, #l0: int :: { $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#3(#l1, $ref($ptr(^^void, #l0))), Q#i$1^46.34#tc1) } $in_range_phys_ptr($ref($ptr(^^void, #l0))) ==> $ptr_eq($ptr(^^void, $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#3(#l1, $ref($ptr(^^void, #l0))), Q#i$1^46.34#tc1)), (if Q#i$1^46.34#tc1 == 0 then $ptr(^^void, #l0) else $ptr(^^void, $select.$map_t..^^mathint.$ptr_to..^^void(#l1, Q#i$1^46.34#tc1 - 1)))));

function F#lambda#2() : $map_t..^^mathint.$ptr_to..^^void;

const unique cf#lambda#2: $pure_function;

axiom $function_arg_type(cf#lambda#2, 0, $map_t(^^mathint, $ptr_to(^^void)));

procedure lambda#2() returns ($result: $map_t..^^mathint.$ptr_to..^^void);
  free ensures $result == F#lambda#2();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^28.34#tc1: int :: { $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#2(), Q#i$1^28.34#tc1) } $ptr_eq($ptr(^^void, $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#2(), Q#i$1^28.34#tc1)), $null));

function F#lambda#1(#l2: $map_t..^^mathint.$ptr_to..^^void, #l1: int, #l0: int) : $map_t..^^mathint.$ptr_to..^^void;

const unique cf#lambda#1: $pure_function;

axiom $function_arg_type(cf#lambda#1, 0, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#1, 1, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#1, 2, $ptr_to(^^void));

axiom $function_arg_type(cf#lambda#1, 3, ^^u4);

procedure lambda#1(#l2: $map_t..^^mathint.$ptr_to..^^void, #l1: int, #l0: int) returns ($result: $map_t..^^mathint.$ptr_to..^^void);
  free ensures $result == F#lambda#1(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^15.36#tc1: int, #l2: $map_t..^^mathint.$ptr_to..^^void, #l1: int, #l0: int :: { $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#1(#l2, $ref($ptr(^^void, #l1)), #l0), Q#i$1^15.36#tc1) } $in_range_phys_ptr($ref($ptr(^^void, #l1))) && $in_range_u4(#l0) ==> $ptr_eq($ptr(^^void, $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#1(#l2, $ref($ptr(^^void, #l1)), #l0), Q#i$1^15.36#tc1)), (if 0 <= Q#i$1^15.36#tc1 && Q#i$1^15.36#tc1 < #l0 then (if Q#i$1^15.36#tc1 == 0 then $ptr(^^void, #l1) else $ptr(^^void, $select.$map_t..^^mathint.$ptr_to..^^void(#l2, Q#i$1^15.36#tc1 - 1))) else $null)));

const unique l#public: $label;

type $map_t..^^mathint.$ptr_to..^^void;

function $select.$map_t..^^mathint.$ptr_to..^^void(M: $map_t..^^mathint.$ptr_to..^^void, p: int) : int;

function $store.$map_t..^^mathint.$ptr_to..^^void(M: $map_t..^^mathint.$ptr_to..^^void, p: int, v: int) : $map_t..^^mathint.$ptr_to..^^void;

function $eq.$map_t..^^mathint.$ptr_to..^^void(M1: $map_t..^^mathint.$ptr_to..^^void, M2: $map_t..^^mathint.$ptr_to..^^void) : bool;

const $zero.$map_t..^^mathint.$ptr_to..^^void: $map_t..^^mathint.$ptr_to..^^void;

axiom (forall M: $map_t..^^mathint.$ptr_to..^^void, p: int, v: int :: $select.$map_t..^^mathint.$ptr_to..^^void($store.$map_t..^^mathint.$ptr_to..^^void(M, p, v), p) == v);

axiom (forall M: $map_t..^^mathint.$ptr_to..^^void, p: int, v: int, q: int :: p != q ==> $select.$map_t..^^mathint.$ptr_to..^^void($store.$map_t..^^mathint.$ptr_to..^^void(M, q, v), p) == $select.$map_t..^^mathint.$ptr_to..^^void(M, p));

axiom (forall M1: $map_t..^^mathint.$ptr_to..^^void, M2: $map_t..^^mathint.$ptr_to..^^void :: { $eq.$map_t..^^mathint.$ptr_to..^^void(M1, M2) } (forall p: int :: $select.$map_t..^^mathint.$ptr_to..^^void(M1, p) == $select.$map_t..^^mathint.$ptr_to..^^void(M2, p)) ==> $eq.$map_t..^^mathint.$ptr_to..^^void(M1, M2));

axiom (forall M1: $map_t..^^mathint.$ptr_to..^^void, M2: $map_t..^^mathint.$ptr_to..^^void :: { $eq.$map_t..^^mathint.$ptr_to..^^void(M1, M2) } $eq.$map_t..^^mathint.$ptr_to..^^void(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^mathint.ptr_to..^^void(0) == $zero.$map_t..^^mathint.$ptr_to..^^void;

axiom (forall p: int :: $select.$map_t..^^mathint.$ptr_to..^^void($zero.$map_t..^^mathint.$ptr_to..^^void, p) == 0);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t(^^mathint, $ptr_to(^^void))) } $eq.$map_t..^^mathint.$ptr_to..^^void($int_to_map_t..^^mathint.ptr_to..^^void($rec_fetch(r1, f)), $int_to_map_t..^^mathint.ptr_to..^^void($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

axiom (forall M: $map_t..^^mathint.$ptr_to..^^void, p: int :: $in_range_phys_ptr($select.$map_t..^^mathint.$ptr_to..^^void(M, p)));

const unique #tok$1^15.36: $token;

const unique #tok$1^39.48: $token;

const unique #tok$1^57.48: $token;

const unique #tok$1^75.48: $token;

const unique #tok$1^97.48: $token;

const unique #loc.#l3: $token;

const unique #tok$1^116.27: $token;

const unique #tok$1^169.49: $token;

axiom $type_code_is(1, ^^mathint);

const unique #loc.#l0: $token;

const unique #loc.#l1: $token;

const unique #loc.#l2: $token;

const unique #tok$1^185.49: $token;

const unique #tok$1^190.14: $token;

const unique #tok$1^189.3: $token;

const unique #loc.res_Cons#18: $token;

const unique #tok$1^189.13: $token;

const unique #tok$1^187.19: $token;

const unique #loc.prestate#45: $token;

const unique #loc.prestate#43: $token;

const unique #loc.owns#44: $token;

const unique #tok$1^190.3: $token;

const unique #loc.item: $token;

const unique #tok$1^179.1: $token;

const unique #tok$1^175.3: $token;

const unique #tok$1^174.14: $token;

const unique #tok$1^173.13: $token;

const unique #tok$1^171.19: $token;

const unique #loc.prestate#42: $token;

const unique #loc.prestate#40: $token;

const unique #loc.owns#41: $token;

const unique #loc.t: $token;

const unique #tok$1^173.3: $token;

const unique #tok$1^174.3: $token;

const unique #tok$1^164.1: $token;

const unique #loc.q: $token;

const unique #tok$1^156.1: $token;

const unique #tok$1^152.19: $token;

const unique #loc.owns#38: $token;

const unique #loc.staticWrapState#37: $token;

const unique #loc.prestate#39: $token;

const unique #tok$1^150.5: $token;

const unique #loc.res_ListNew#17: $token;

const unique #tok$1^150.15: $token;

const unique #tok$1^149.5: $token;

const unique #loc.res_Concat#16: $token;

const unique #tok$1^149.16: $token;

const unique #tok$1^148.9: $token;

const unique #tok$1^147.5: $token;

const unique #tok$1^145.5: $token;

const unique #tok$1^144.5: $token;

const unique #tok$1^141.14: $token;

const unique #tok$1^141.3: $token;

const unique #tok$1^133.1: $token;

const unique #tok$1^129.19: $token;

const unique #loc.owns#35: $token;

const unique #loc.staticWrapState#34: $token;

const unique #loc.prestate#36: $token;

const unique #tok$1^128.3: $token;

const unique #loc.res_ListNew#15: $token;

const unique #tok$1^128.13: $token;

const unique #tok$1^127.3: $token;

const unique #loc.res_ListNew#14: $token;

const unique #tok$1^127.14: $token;

const unique #tok$1^125.14: $token;

const unique #tok$1^125.3: $token;

const unique #tok$1^121.1: $token;

const unique #loc.rear: $token;

const unique #loc.front: $token;

const unique #tok$1^114.39: $token;

const unique #tok$1^101.3: $token;

const unique #tok$1^99.19: $token;

const unique #loc.prestate#33: $token;

const unique #loc.prestate#31: $token;

const unique #loc.owns#32: $token;

const unique #tok$1^100.3: $token;

const unique #tok$1^92.1: $token;

const unique #tok$1^87.9: $token;

const unique #tok$1^86.15: $token;

const unique #tok$1^85.9: $token;

const unique #tok$1^84.9: $token;

const unique #tok$1^83.21: $token;

const unique #loc.prestate#30: $token;

const unique #loc.prestate#28: $token;

const unique #loc.owns#29: $token;

const unique #loc.e: $token;

const unique #tok$1^82.5: $token;

const unique #loc.f: $token;

const unique #tok$1^86.5: $token;

const unique #tok$1^78.3: $token;

const unique #tok$1^71.1: $token;

const unique #tok$1^66.5: $token;

const unique #tok$1^65.9: $token;

const unique #tok$1^64.15: $token;

const unique #loc.c: $token;

const unique #tok$1^64.5: $token;

const unique #tok$1^61.5: $token;

const unique #tok$1^59.19: $token;

const unique #loc.prestate#27: $token;

const unique #loc.prestate#25: $token;

const unique #loc.owns#26: $token;

const unique #loc.end: $token;

const unique #tok$1^51.1: $token;

const unique #tok$1^47.19: $token;

const unique #loc.owns#23: $token;

const unique #loc.staticWrapState#22: $token;

const unique #loc.prestate#24: $token;

const unique #tok$1^46.25: $token;

const unique #loc.res_lambda#3#13: $token;

const unique #tok$1^46.34: $token;

const unique #tok$1^45.3: $token;

const unique #tok$1^44.3: $token;

const unique #tok$1^43.3: $token;

const unique #tok$1^41.13: $token;

const unique #loc.r: $token;

const unique #tok$1^41.3: $token;

const unique #loc.d: $token;

const unique #tok$1^33.1: $token;

const unique #tok$1^29.19: $token;

const unique #loc.owns#20: $token;

const unique #loc.staticWrapState#19: $token;

function $state_to_int(x: $state) : int;

function $int_to_state(x: int) : $state;

axiom (forall #x: $state :: #x == $int_to_state($state_to_int(#x)));

const unique #loc.prestate#21: $token;

const unique #tok$2^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(2, #file^?3Cno?20file?3E);

const unique #tok$1^28.25: $token;

const unique #loc.res_lambda#2#12: $token;

const unique #tok$1^28.34: $token;

const unique #tok$1^27.3: $token;

const unique #tok$1^26.3: $token;

const unique #tok$1^24.13: $token;

const unique #loc.l: $token;

const unique #tok$1^24.3: $token;

const unique #tok$1^20.1: $token;

const unique #distTp4: $ctype;

axiom #distTp4 == $ptr_to(^Queue);

const unique #tok$1^105.9: $token;

const unique #loc._this_: $token;

const unique #tok$1^9.9: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvscomp2010?5Cvscomp2010_p5_v1.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvscomp2010?5Cvscomp2010_p5_v1.c);

const unique #distTp3: $ctype;

axiom #distTp3 == $ptr_to(^List);

function $map_t..^^mathint.ptr_to..^^void_to_int(x: $map_t..^^mathint.$ptr_to..^^void) : int;

function $int_to_map_t..^^mathint.ptr_to..^^void(x: int) : $map_t..^^mathint.$ptr_to..^^void;

axiom (forall #x: $map_t..^^mathint.$ptr_to..^^void :: #x == $int_to_map_t..^^mathint.ptr_to..^^void($map_t..^^mathint.ptr_to..^^void_to_int(#x)));

const unique #distTp2: $ctype;

axiom #distTp2 == $map_t(^^mathint, $ptr_to(^^void));

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^^void);
