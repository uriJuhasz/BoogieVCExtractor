axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

const unique ^List: $ctype;

axiom $is_span_sequential(^List);

axiom $def_struct_type(^List, 24, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^List) } $inv2(#s1, #s2, #p, ^List) == ($is_malloc_root(#s2, #p) && $eq.$map_t..^^mathint.$ptr_to..^^void($int_to_map_t..^^mathint.ptr_to..^^void($rd_inv(#s2, List.val, #p)), F#lambda#1($int_to_map_t..^^mathint.ptr_to..^^void($rd_inv(#s2, List.val, $rd_phys_ptr(#s2, List.tail, #p, ^List))), $rd_phys_ptr(#s2, List.head, #p, ^^void), $rd_inv(#s2, List.length, #p))) && ($rd_inv(#s2, List.length, #p) == 0 || $rd_inv(#s2, List.length, #p) == $rd_inv(#s2, List.length, $rd_phys_ptr(#s2, List.tail, #p, ^List)) + 1) && ($rd_inv(#s2, List.length, #p) != 0) == ($rd_phys_ptr(#s1, List.tail, #p, ^List) == $rd_phys_ptr(#s2, List.tail, #p, ^List) && $keeps(#s2, #p, $rd_phys_ptr(#s2, List.tail, #p, ^List)))));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^List)) } $in(q, $composite_extent(s, p, ^List)) == (q == p));

const unique List.head: $field;

axiom $def_phys_field(^List, List.head, $ptr_to(^^void), false, 0);

const unique List.tail: $field;

axiom $def_phys_field(^List, List.tail, $ptr_to(^List), false, 8);

const unique List.length: $field;

axiom $def_phys_field(^List, List.length, ^^u4, false, 16);

const unique List.val: $field;

axiom $def_ghost_field(^List, List.val, $map_t(^^mathint, $ptr_to(^^void)), false);

procedure List#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $is_malloc_root($s, $phys_ptr_cast(P#_this_, ^List));
  ensures $is_admissibility_check() ==> $eq.$map_t..^^mathint.$ptr_to..^^void($int_to_map_t..^^mathint.ptr_to..^^void($rd_inv($s, List.val, $phys_ptr_cast(P#_this_, ^List))), F#lambda#1($int_to_map_t..^^mathint.ptr_to..^^void($rd_inv($s, List.val, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#_this_, ^List), ^List))), $rd_phys_ptr($s, List.head, $phys_ptr_cast(P#_this_, ^List), ^^void), $rd_inv($s, List.length, $phys_ptr_cast(P#_this_, ^List))));
  ensures $is_admissibility_check() ==> $rd_inv($s, List.length, $phys_ptr_cast(P#_this_, ^List)) == 0 || $rd_inv($s, List.length, $phys_ptr_cast(P#_this_, ^List)) == $rd_inv($s, List.length, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#_this_, ^List), ^List)) + 1;
  ensures $is_admissibility_check() ==> ($rd_inv($s, List.length, $phys_ptr_cast(P#_this_, ^List)) != 0) == ($rd_phys_ptr(old($s), List.tail, $phys_ptr_cast(P#_this_, ^List), ^List) == $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#_this_, ^List), ^List) && $keeps($s, $phys_ptr_cast(P#_this_, ^List), $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#_this_, ^List), ^List)));
  ensures $is_stuttering_check() ==> ($rd_inv($s, List.length, $phys_ptr_cast(P#_this_, ^List)) != 0) == ($rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#_this_, ^List), ^List) == $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#_this_, ^List), ^List) && $keeps($s, $phys_ptr_cast(P#_this_, ^List), $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#_this_, ^List), ^List)));
  ensures $is_unwrap_check() ==> $is_malloc_root($s, $phys_ptr_cast(P#_this_, ^List));
  ensures $is_unwrap_check() ==> $eq.$map_t..^^mathint.$ptr_to..^^void($int_to_map_t..^^mathint.ptr_to..^^void($rd_inv($s, List.val, $phys_ptr_cast(P#_this_, ^List))), F#lambda#1($int_to_map_t..^^mathint.ptr_to..^^void($rd_inv($s, List.val, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#_this_, ^List), ^List))), $rd_phys_ptr($s, List.head, $phys_ptr_cast(P#_this_, ^List), ^^void), $rd_inv($s, List.length, $phys_ptr_cast(P#_this_, ^List))));
  ensures $is_unwrap_check() ==> $rd_inv($s, List.length, $phys_ptr_cast(P#_this_, ^List)) == 0 || $rd_inv($s, List.length, $phys_ptr_cast(P#_this_, ^List)) == $rd_inv($s, List.length, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#_this_, ^List), ^List)) + 1;
  ensures $is_unwrap_check() ==> ($rd_inv($s, List.length, $phys_ptr_cast(P#_this_, ^List)) != 0) == ($rd_phys_ptr(old($s), List.tail, $phys_ptr_cast(P#_this_, ^List), ^List) == $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#_this_, ^List), ^List) && $keeps($s, $phys_ptr_cast(P#_this_, ^List), $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#_this_, ^List), ^List)));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation List#adm(P#_this_: $ptr)
{
  var #wrTime$1^9.9: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^9.9, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^9.9, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^List));
    assume #wrTime$1^9.9 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^9.9, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($phys_ptr_cast(P#_this_, ^List), ^List);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $phys_ptr_cast(P#_this_, ^List));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($phys_ptr_cast(P#_this_, ^List));
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
            assume $admissibility_pre($s, $phys_ptr_cast(P#_this_, ^List));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $phys_ptr_cast(P#_this_, ^List));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct List*)@null))
        call $havoc_others($phys_ptr_cast(P#_this_, ^List), ^List);
        assume $good_state_ext(#tok$1^9.9, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $phys_ptr_cast(P#_this_, ^List), ^List);
    }

  #exit:
}



const unique ^Queue: $ctype;

axiom $is_span_sequential(^Queue);

axiom $def_struct_type(^Queue, 16, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Queue) } $inv2(#s1, #s2, #p, ^Queue) == ($is_malloc_root(#s2, #p) && $rd_phys_ptr(#s2, Queue.front, #p, ^List) != $rd_phys_ptr(#s2, Queue.rear, #p, ^List) && $rd_phys_ptr(#s1, Queue.front, #p, ^List) == $rd_phys_ptr(#s2, Queue.front, #p, ^List) && $keeps(#s2, #p, $rd_phys_ptr(#s2, Queue.front, #p, ^List)) && $rd_phys_ptr(#s1, Queue.rear, #p, ^List) == $rd_phys_ptr(#s2, Queue.rear, #p, ^List) && $keeps(#s2, #p, $rd_phys_ptr(#s2, Queue.rear, #p, ^List)) && $rd_inv(#s2, List.length, $rd_phys_ptr(#s2, Queue.rear, #p, ^List)) <= $rd_inv(#s2, List.length, $rd_phys_ptr(#s2, Queue.front, #p, ^List)) && $rd_inv(#s2, List.length, $rd_phys_ptr(#s2, Queue.front, #p, ^List)) + $rd_inv(#s2, List.length, $rd_phys_ptr(#s2, Queue.rear, #p, ^List)) <= 4294967295));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^Queue)) } $in(q, $composite_extent(s, p, ^Queue)) == (q == p));

const unique Queue.front: $field;

axiom $def_phys_field(^Queue, Queue.front, $ptr_to(^List), false, 0);

const unique Queue.rear: $field;

axiom $def_phys_field(^Queue, Queue.rear, $ptr_to(^List), false, 8);

procedure Queue#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $is_malloc_root($s, $phys_ptr_cast(P#_this_, ^Queue));
  ensures $is_admissibility_check() ==> $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#_this_, ^Queue), ^List) != $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#_this_, ^Queue), ^List);
  ensures $is_admissibility_check() ==> $rd_phys_ptr(old($s), Queue.front, $phys_ptr_cast(P#_this_, ^Queue), ^List) == $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#_this_, ^Queue), ^List);
  ensures $is_admissibility_check() ==> $keeps($s, $phys_ptr_cast(P#_this_, ^Queue), $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#_this_, ^Queue), ^List));
  ensures $is_admissibility_check() ==> $rd_phys_ptr(old($s), Queue.rear, $phys_ptr_cast(P#_this_, ^Queue), ^List) == $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#_this_, ^Queue), ^List);
  ensures $is_admissibility_check() ==> $keeps($s, $phys_ptr_cast(P#_this_, ^Queue), $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#_this_, ^Queue), ^List));
  ensures $is_admissibility_check() ==> $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#_this_, ^Queue), ^List)) <= $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#_this_, ^Queue), ^List));
  ensures $is_admissibility_check() ==> $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#_this_, ^Queue), ^List)) + $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#_this_, ^Queue), ^List)) <= 4294967295;
  ensures $is_stuttering_check() ==> $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#_this_, ^Queue), ^List) == $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#_this_, ^Queue), ^List);
  ensures $is_stuttering_check() ==> $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#_this_, ^Queue), ^List) == $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#_this_, ^Queue), ^List);
  ensures $is_unwrap_check() ==> $is_malloc_root($s, $phys_ptr_cast(P#_this_, ^Queue));
  ensures $is_unwrap_check() ==> $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#_this_, ^Queue), ^List) != $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#_this_, ^Queue), ^List);
  ensures $is_unwrap_check() ==> $rd_phys_ptr(old($s), Queue.front, $phys_ptr_cast(P#_this_, ^Queue), ^List) == $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#_this_, ^Queue), ^List);
  ensures $is_unwrap_check() ==> $keeps($s, $phys_ptr_cast(P#_this_, ^Queue), $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#_this_, ^Queue), ^List));
  ensures $is_unwrap_check() ==> $rd_phys_ptr(old($s), Queue.rear, $phys_ptr_cast(P#_this_, ^Queue), ^List) == $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#_this_, ^Queue), ^List);
  ensures $is_unwrap_check() ==> $keeps($s, $phys_ptr_cast(P#_this_, ^Queue), $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#_this_, ^Queue), ^List));
  ensures $is_unwrap_check() ==> $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#_this_, ^Queue), ^List)) <= $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#_this_, ^Queue), ^List));
  ensures $is_unwrap_check() ==> $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#_this_, ^Queue), ^List)) + $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#_this_, ^Queue), ^List)) <= 4294967295;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Queue#adm(P#_this_: $ptr)
{
  var #wrTime$1^105.9: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^105.9, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^105.9, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^Queue));
    assume #wrTime$1^105.9 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^105.9, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($phys_ptr_cast(P#_this_, ^Queue), ^Queue);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon7:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $phys_ptr_cast(P#_this_, ^Queue));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($phys_ptr_cast(P#_this_, ^Queue));
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
            assume $admissibility_pre($s, $phys_ptr_cast(P#_this_, ^Queue));
        }
        else
        {
          anon9:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $phys_ptr_cast(P#_this_, ^Queue));
        }

      anon11:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Queue*)@null))
        call $havoc_others($phys_ptr_cast(P#_this_, ^Queue), ^Queue);
        assume $good_state_ext(#tok$1^105.9, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $phys_ptr_cast(P#_this_, ^Queue), ^Queue);
    }

  #exit:
}



const unique ^$#fnptr#1: $ctype;

axiom $def_fnptr_type(^$#fnptr#1);

type $#fnptr#1;

const unique ^$#fnptr#2: $ctype;

axiom $def_fnptr_type(^$#fnptr#2);

type $#fnptr#2;

const unique ^$#fnptr#3: $ctype;

axiom $def_fnptr_type(^$#fnptr#3);

type $#fnptr#3;

const unique ^$#fnptr#4: $ctype;

axiom $def_fnptr_type(^$#fnptr#4);

type $#fnptr#4;

const unique ^$#fnptr#5: $ctype;

axiom $def_fnptr_type(^$#fnptr#5);

type $#fnptr#5;

const unique ^$#fnptr#6: $ctype;

axiom $def_fnptr_type(^$#fnptr#6);

type $#fnptr#6;

const unique ^$#fnptr#7: $ctype;

axiom $def_fnptr_type(^$#fnptr#7);

type $#fnptr#7;

const unique ^$#fnptr#8: $ctype;

axiom $def_fnptr_type(^$#fnptr#8);

type $#fnptr#8;

procedure ListNew() returns ($result: $ptr);
  modifies $s, $cev_pc;
  free ensures true;
  ensures $wrapped($s, $phys_ptr_cast($result, ^List), ^List) && $in_domain_lab($s, $phys_ptr_cast($result, ^List), $phys_ptr_cast($result, ^List), l#public) && $is_fresh(old($s), $s, $phys_ptr_cast($result, ^List));
  ensures $rd_inv($s, List.length, $phys_ptr_cast($result, ^List)) == 0;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation ListNew() returns ($result: $ptr)
{
  var owns#20: $ptrset;
  var staticWrapState#19: $state;
  var prestate#21: $state;
  var res_lambda#2#12: $map_t..^^mathint.$ptr_to..^^void;
  var L#l: $ptr;
  var #wrTime$1^20.1: int;
  var #stackframe: int;

  anon15:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^20.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^20.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^20.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // struct List* l; 
    assume $local_value_is($s, #tok$1^24.3, #loc.l, $ptr_to_int(L#l), $ptr_to(^List));
    // l := _vcc_alloc(@_vcc_typeof((struct List*)@null)); 
    call L#l := $alloc(^List);
    assume $full_stop_ext(#tok$1^24.13, $s);
    assume $local_value_is($s, #tok$1^24.13, #loc.l, $ptr_to_int(L#l), $ptr_to(^List));
    // assume @_vcc_ptr_neq_null(l); 
    assume $non_null($phys_ptr_cast(L#l, ^List));
    // assert @prim_writes_check((l->tail)); 
    assert $writable_prim($s, #wrTime$1^20.1, $dot($phys_ptr_cast(L#l, ^List), List.tail));
    // *(l->tail) := (struct List*)@null; 
    call $write_int(List.tail, $phys_ptr_cast(L#l, ^List), $ptr_to_int($phys_ptr_cast($null, ^List)));
    assume $full_stop_ext(#tok$1^26.3, $s);
    // assert @prim_writes_check((l->length)); 
    assert $writable_prim($s, #wrTime$1^20.1, $dot($phys_ptr_cast(L#l, ^List), List.length));
    // *(l->length) := 0; 
    call $write_int(List.length, $phys_ptr_cast(L#l, ^List), 0);
    assume $full_stop_ext(#tok$1^27.3, $s);
    // (mathint -> void*) res_lambda#2#12; 
    assume $local_value_is($s, #tok$1^28.34, #loc.res_lambda#2#12, $map_t..^^mathint.ptr_to..^^void_to_int(res_lambda#2#12), $map_t(^^mathint, $ptr_to(^^void)));
    // res_lambda#2#12 := lambda#2(); 
    call res_lambda#2#12 := lambda#2();
    assume $full_stop_ext(#tok$1^28.34, $s);
    assume $local_value_is($s, #tok$1^28.34, #loc.res_lambda#2#12, $map_t..^^mathint.ptr_to..^^void_to_int(res_lambda#2#12), $map_t(^^mathint, $ptr_to(^^void)));
    // assert @prim_writes_check((l->val)); 
    assert $writable_prim($s, #wrTime$1^20.1, $dot($phys_ptr_cast(L#l, ^List), List.val));
    // *(l->val) := res_lambda#2#12; 
    call $write_int(List.val, $phys_ptr_cast(L#l, ^List), $map_t..^^mathint.ptr_to..^^void_to_int(res_lambda#2#12));
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
    assert $top_writable($s, #wrTime$1^20.1, $phys_ptr_cast(L#l, ^List));
    assume true;
    // if (pure(!=(*((l->length)), 0))) ...
    if ($rd_inv($s, List.length, $phys_ptr_cast(L#l, ^List)) != 0)
    {
      anon13:
        // assert @_vcc_wrapped(@state, *((l->tail))); 
        assert $wrapped($s, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(L#l, ^List), ^List), ^List);
        // assert @writes_check(*((l->tail))); 
        assert $top_writable($s, #wrTime$1^20.1, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(L#l, ^List), ^List));
        // owns#20 := pure(@_vcc_set_union(owns#20, @_vcc_set_singleton(*((l->tail))))); 
        owns#20 := $set_union(owns#20, $set_singleton($rd_phys_ptr($s, List.tail, $phys_ptr_cast(L#l, ^List), ^List)));
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#20, $ptrset_to_int(owns#20), ^$#ptrset);
        // staticWrapState#19 := pure(@_vcc_take_over(staticWrapState#19, l, *((l->tail)))); 
        staticWrapState#19 := $take_over(staticWrapState#19, $phys_ptr_cast(L#l, ^List), $rd_phys_ptr($s, List.tail, $phys_ptr_cast(L#l, ^List), ^List));
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
    call $static_wrap($phys_ptr_cast(L#l, ^List), staticWrapState#19, owns#20);
    assume $good_state_ext(#tok$1^29.19, $s);
    // assert @inv_check(@_vcc_is_malloc_root(@state, l)); 
    assert $is_malloc_root($s, $phys_ptr_cast(L#l, ^List));
    // assert @inv_check(@map_eq(*((l->val)), lambda#1(*((*((l->tail))->val)), *((l->head)), *((l->length))))); 
    assert $eq.$map_t..^^mathint.$ptr_to..^^void($int_to_map_t..^^mathint.ptr_to..^^void($rd_inv($s, List.val, $phys_ptr_cast(L#l, ^List))), F#lambda#1($int_to_map_t..^^mathint.ptr_to..^^void($rd_inv($s, List.val, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(L#l, ^List), ^List))), $rd_phys_ptr($s, List.head, $phys_ptr_cast(L#l, ^List), ^^void), $rd_inv($s, List.length, $phys_ptr_cast(L#l, ^List))));
    // assert @inv_check(||(==(*((l->length)), 0), ==(*((l->length)), +(*((*((l->tail))->length)), 1)))); 
    assert $rd_inv($s, List.length, $phys_ptr_cast(L#l, ^List)) == 0 || $rd_inv($s, List.length, $phys_ptr_cast(L#l, ^List)) == $rd_inv($s, List.length, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(L#l, ^List), ^List)) + 1;
    // assert @inv_check(==(!=(*((l->length)), 0), &&(@keeps_stable(old(prestate#21, *((l->tail))), *((l->tail))), @keeps(l, *((l->tail)))))); 
    assert ($rd_inv($s, List.length, $phys_ptr_cast(L#l, ^List)) != 0) == ($rd_phys_ptr(prestate#21, List.tail, $phys_ptr_cast(L#l, ^List), ^List) == $rd_phys_ptr($s, List.tail, $phys_ptr_cast(L#l, ^List), ^List) && $keeps($s, $phys_ptr_cast(L#l, ^List), $rd_phys_ptr($s, List.tail, $phys_ptr_cast(L#l, ^List), ^List)));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return l; 
    $result := $phys_ptr_cast(L#l, ^List);
    assert $position_marker();
    goto #exit;

  anon17:
    // empty

  #exit:
}



procedure Cons(P#l: $ptr, P#d: $ptr) returns ($result: $ptr);
  requires $wrapped($s, $phys_ptr_cast(P#l, ^List), ^List);
  requires $rd_inv($s, List.length, $phys_ptr_cast(P#l, ^List)) < 4294967295;
  modifies $s, $cev_pc;
  free ensures true;
  ensures $wrapped($s, $phys_ptr_cast($result, ^List), ^List) && $is_fresh(old($s), $s, $phys_ptr_cast($result, ^List));
  ensures $rd_inv($s, List.length, $phys_ptr_cast($result, ^List)) == $rd_inv(old($s), List.length, $phys_ptr_cast(P#l, ^List)) + 1;
  ensures $eq.$map_t..^^mathint.$ptr_to..^^void($int_to_map_t..^^mathint.ptr_to..^^void($rd_inv($s, List.val, $phys_ptr_cast($result, ^List))), F#lambda#4($int_to_map_t..^^mathint.ptr_to..^^void($rd_inv(old($s), List.val, $phys_ptr_cast(P#l, ^List))), $phys_ptr_cast(P#d, ^^void)));
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#l, ^List)));
  free ensures $call_transition(old($s), $s);



implementation Cons(P#l: $ptr, P#d: $ptr) returns ($result: $ptr)
{
  var owns#23: $ptrset;
  var staticWrapState#22: $state;
  var prestate#24: $state;
  var res_lambda#3#13: $map_t..^^mathint.$ptr_to..^^void;
  var L#r: $ptr;
  var #wrTime$1^33.1: int;
  var #stackframe: int;

  anon20:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^33.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^33.1, #loc.l, $ptr_to_int(P#l), $ptr_to(^List));
    assume $local_value_is($s, #tok$1^33.1, #loc.d, $ptr_to_int(P#d), $ptr_to(^^void));
    assume #wrTime$1^33.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^33.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#l, ^List)));
    assume $thread_owned($s, $phys_ptr_cast(P#l, ^List));
    // assume true; 
    assume true;
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, l, l); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#l, ^List), $phys_ptr_cast(P#l, ^List), l#public);
    // struct List* r; 
    assume $local_value_is($s, #tok$1^41.3, #loc.r, $ptr_to_int(L#r), $ptr_to(^List));
    // r := _vcc_alloc(@_vcc_typeof((struct List*)@null)); 
    call L#r := $alloc(^List);
    assume $full_stop_ext(#tok$1^41.13, $s);
    assume $local_value_is($s, #tok$1^41.13, #loc.r, $ptr_to_int(L#r), $ptr_to(^List));
    // assume @_vcc_ptr_neq_null(r); 
    assume $non_null($phys_ptr_cast(L#r, ^List));
    // assert @prim_writes_check((r->head)); 
    assert $writable_prim($s, #wrTime$1^33.1, $dot($phys_ptr_cast(L#r, ^List), List.head));
    // *(r->head) := d; 
    call $write_int(List.head, $phys_ptr_cast(L#r, ^List), $ptr_to_int($phys_ptr_cast(P#d, ^^void)));
    assume $full_stop_ext(#tok$1^43.3, $s);
    // assert @prim_writes_check((r->tail)); 
    assert $writable_prim($s, #wrTime$1^33.1, $dot($phys_ptr_cast(L#r, ^List), List.tail));
    // *(r->tail) := l; 
    call $write_int(List.tail, $phys_ptr_cast(L#r, ^List), $ptr_to_int($phys_ptr_cast(P#l, ^List)));
    assume $full_stop_ext(#tok$1^44.3, $s);
    // assert @prim_writes_check((r->length)); 
    assert $writable_prim($s, #wrTime$1^33.1, $dot($phys_ptr_cast(L#r, ^List), List.length));
    // assert @in_range_u4(+(*((l->length)), 1)); 
    assert $in_range_u4($rd_inv($s, List.length, $phys_ptr_cast(P#l, ^List)) + 1);
    // assert @reads_check_normal((l->length)); 
    assert $thread_local($s, $phys_ptr_cast(P#l, ^List));
    // *(r->length) := +(*((l->length)), 1); 
    call $write_int(List.length, $phys_ptr_cast(L#r, ^List), $rd_inv($s, List.length, $phys_ptr_cast(P#l, ^List)) + 1);
    assume $full_stop_ext(#tok$1^45.3, $s);
    // (mathint -> void*) res_lambda#3#13; 
    assume $local_value_is($s, #tok$1^46.34, #loc.res_lambda#3#13, $map_t..^^mathint.ptr_to..^^void_to_int(res_lambda#3#13), $map_t(^^mathint, $ptr_to(^^void)));
    // assert @reads_check_normal((l->val)); 
    assert $thread_local($s, $phys_ptr_cast(P#l, ^List));
    // res_lambda#3#13 := lambda#3(*((l->val)), d); 
    call res_lambda#3#13 := lambda#3($int_to_map_t..^^mathint.ptr_to..^^void($rd_inv($s, List.val, $phys_ptr_cast(P#l, ^List))), $phys_ptr_cast(P#d, ^^void));
    assume $full_stop_ext(#tok$1^46.34, $s);
    assume $local_value_is($s, #tok$1^46.34, #loc.res_lambda#3#13, $map_t..^^mathint.ptr_to..^^void_to_int(res_lambda#3#13), $map_t(^^mathint, $ptr_to(^^void)));
    // assert @prim_writes_check((r->val)); 
    assert $writable_prim($s, #wrTime$1^33.1, $dot($phys_ptr_cast(L#r, ^List), List.val));
    // *(r->val) := res_lambda#3#13; 
    call $write_int(List.val, $phys_ptr_cast(L#r, ^List), $map_t..^^mathint.ptr_to..^^void_to_int(res_lambda#3#13));
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
    assert $top_writable($s, #wrTime$1^33.1, $phys_ptr_cast(L#r, ^List));
    assume true;
    // if (pure(!=(*((r->length)), 0))) ...
    if ($rd_inv($s, List.length, $phys_ptr_cast(L#r, ^List)) != 0)
    {
      anon18:
        // assert @_vcc_wrapped(@state, *((r->tail))); 
        assert $wrapped($s, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(L#r, ^List), ^List), ^List);
        // assert @writes_check(*((r->tail))); 
        assert $top_writable($s, #wrTime$1^33.1, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(L#r, ^List), ^List));
        // owns#23 := pure(@_vcc_set_union(owns#23, @_vcc_set_singleton(*((r->tail))))); 
        owns#23 := $set_union(owns#23, $set_singleton($rd_phys_ptr($s, List.tail, $phys_ptr_cast(L#r, ^List), ^List)));
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#23, $ptrset_to_int(owns#23), ^$#ptrset);
        // staticWrapState#22 := pure(@_vcc_take_over(staticWrapState#22, r, *((r->tail)))); 
        staticWrapState#22 := $take_over(staticWrapState#22, $phys_ptr_cast(L#r, ^List), $rd_phys_ptr($s, List.tail, $phys_ptr_cast(L#r, ^List), ^List));
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
    call $static_wrap($phys_ptr_cast(L#r, ^List), staticWrapState#22, owns#23);
    assume $good_state_ext(#tok$1^47.19, $s);
    // assert @inv_check(@_vcc_is_malloc_root(@state, r)); 
    assert $is_malloc_root($s, $phys_ptr_cast(L#r, ^List));
    // assert @inv_check(@map_eq(*((r->val)), lambda#1(*((*((r->tail))->val)), *((r->head)), *((r->length))))); 
    assert $eq.$map_t..^^mathint.$ptr_to..^^void($int_to_map_t..^^mathint.ptr_to..^^void($rd_inv($s, List.val, $phys_ptr_cast(L#r, ^List))), F#lambda#1($int_to_map_t..^^mathint.ptr_to..^^void($rd_inv($s, List.val, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(L#r, ^List), ^List))), $rd_phys_ptr($s, List.head, $phys_ptr_cast(L#r, ^List), ^^void), $rd_inv($s, List.length, $phys_ptr_cast(L#r, ^List))));
    // assert @inv_check(||(==(*((r->length)), 0), ==(*((r->length)), +(*((*((r->tail))->length)), 1)))); 
    assert $rd_inv($s, List.length, $phys_ptr_cast(L#r, ^List)) == 0 || $rd_inv($s, List.length, $phys_ptr_cast(L#r, ^List)) == $rd_inv($s, List.length, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(L#r, ^List), ^List)) + 1;
    // assert @inv_check(==(!=(*((r->length)), 0), &&(@keeps_stable(old(prestate#24, *((r->tail))), *((r->tail))), @keeps(r, *((r->tail)))))); 
    assert ($rd_inv($s, List.length, $phys_ptr_cast(L#r, ^List)) != 0) == ($rd_phys_ptr(prestate#24, List.tail, $phys_ptr_cast(L#r, ^List), ^List) == $rd_phys_ptr($s, List.tail, $phys_ptr_cast(L#r, ^List), ^List) && $keeps($s, $phys_ptr_cast(L#r, ^List), $rd_phys_ptr($s, List.tail, $phys_ptr_cast(L#r, ^List), ^List)));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return r; 
    $result := $phys_ptr_cast(L#r, ^List);
    assert $position_marker();
    goto #exit;

  anon22:
    // empty

  #exit:
}



procedure Concat(P#l: $ptr, P#end: $ptr) returns ($result: $ptr);
  requires $wrapped($s, $phys_ptr_cast(P#l, ^List), ^List);
  requires $wrapped($s, $phys_ptr_cast(P#end, ^List), ^List);
  requires $phys_ptr_cast(P#l, ^List) != $phys_ptr_cast(P#end, ^List);
  requires $rd_inv($s, List.length, $phys_ptr_cast(P#l, ^List)) + $rd_inv($s, List.length, $phys_ptr_cast(P#end, ^List)) <= 4294967295;
  modifies $s, $cev_pc;
  free ensures true;
  ensures $wrapped($s, $phys_ptr_cast($result, ^List), ^List) && $in_domain_lab($s, $phys_ptr_cast($result, ^List), $phys_ptr_cast($result, ^List), l#public) && ($is_fresh(old($s), $s, $phys_ptr_cast($result, ^List)) || ($rd_inv(old($s), List.length, $phys_ptr_cast(P#l, ^List)) == 0 && $phys_ptr_cast($result, ^List) == $phys_ptr_cast(P#end, ^List)));
  ensures $rd_inv($s, List.length, $phys_ptr_cast($result, ^List)) == $rd_inv(old($s), List.length, $phys_ptr_cast(P#l, ^List)) + $rd_inv(old($s), List.length, $phys_ptr_cast(P#end, ^List));
  ensures $eq.$map_t..^^mathint.$ptr_to..^^void($int_to_map_t..^^mathint.ptr_to..^^void($rd_inv($s, List.val, $phys_ptr_cast($result, ^List))), F#lambda#5($rd_inv(old($s), List.length, $phys_ptr_cast(P#l, ^List)), $int_to_map_t..^^mathint.ptr_to..^^void($rd_inv(old($s), List.val, $phys_ptr_cast(P#end, ^List))), $int_to_map_t..^^mathint.ptr_to..^^void($rd_inv(old($s), List.val, $phys_ptr_cast(P#l, ^List))), $rd_inv(old($s), List.length, $phys_ptr_cast(P#l, ^List))));
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#l, ^List) || #p == $phys_ptr_cast(P#end, ^List)));
  free ensures $call_transition(old($s), $s);



implementation Concat(P#l: $ptr, P#end: $ptr) returns ($result: $ptr)
{
  var L#c: $ptr;
  var prestate#27: $state;
  var prestate#25: $state;
  var owns#26: $ptrset;
  var #wrTime$1^51.1: int;
  var #stackframe: int;

  anon27:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^51.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^51.1, #loc.l, $ptr_to_int(P#l), $ptr_to(^List));
    assume $local_value_is($s, #tok$1^51.1, #loc.end, $ptr_to_int(P#end), $ptr_to(^List));
    assume #wrTime$1^51.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^51.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#l, ^List) || #p == $phys_ptr_cast(P#end, ^List)));
    assume $thread_owned($s, $phys_ptr_cast(P#l, ^List));
    assume $thread_owned($s, $phys_ptr_cast(P#end, ^List));
    // assume true; 
    assume true;
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, end, end); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#end, ^List), $phys_ptr_cast(P#end, ^List), l#public);
    // assert @_vcc_in_domain(@state, l, l); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#l, ^List), $phys_ptr_cast(P#l, ^List), l#public);
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
    assert $wrapped($s, $phys_ptr_cast(P#l, ^List), ^List);
    // assert @writes_check(l); 
    assert $top_writable($s, #wrTime$1^51.1, $phys_ptr_cast(P#l, ^List));
    // assume @_vcc_inv(@state, l); 
    assume $inv($s, $phys_ptr_cast(P#l, ^List), ^List);
    assume true;
    // if (pure(!=(*((l->length)), 0))) ...
    if ($rd_inv($s, List.length, $phys_ptr_cast(P#l, ^List)) != 0)
    {
      anon23:
        // prestate#27 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#27, l, *((l->tail)))); 
        prestate#27 := $release($current_state($s), prestate#27, $phys_ptr_cast(P#l, ^List), $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#l, ^List), ^List));
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
        // owns#26 := pure(@_vcc_set_union(owns#26, @_vcc_set_singleton(*((l->tail))))); 
        owns#26 := $set_union(owns#26, $set_singleton($rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#l, ^List), ^List)));
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#26, $ptrset_to_int(owns#26), ^$#ptrset);
        // assume pure(@_vcc_typed(@state, *((l->tail)))); 
        assume $typed($s, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#l, ^List), ^List));
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
    assume owns#26 == $owns($s, $phys_ptr_cast(P#l, ^List));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(l), prestate#27)
    call $static_unwrap($phys_ptr_cast(P#l, ^List), prestate#27);
    assume $good_state_ext(#tok$1^59.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @reads_check_normal((l->length)); 
    assert $thread_local($s, $phys_ptr_cast(P#l, ^List));
    assume true;
    // if (==(*((l->length)), 0)) ...
    if ($rd_inv($s, List.length, $phys_ptr_cast(P#l, ^List)) == 0)
    {
      anon25:
        // assert @writes_check(l); 
        assert $top_writable($s, #wrTime$1^51.1, $phys_ptr_cast(P#l, ^List));
        // assert @writes_check(@_vcc_extent(@state, l)); 
        assert (forall #writes$1^61.5: $ptr :: { $dont_instantiate(#writes$1^61.5) } $set_in(#writes$1^61.5, $extent($s, $phys_ptr_cast(P#l, ^List))) ==> $top_writable($s, #wrTime$1^51.1, #writes$1^61.5));
        // stmt _vcc_free(l); 
        call $free($phys_ptr_cast(P#l, ^List));
        assume $full_stop_ext(#tok$1^61.5, $s);
        // return end; 
        $result := $phys_ptr_cast(P#end, ^List);
        assert $position_marker();
        goto #exit;
    }
    else
    {
      anon26:
        // struct List* c; 
        assume $local_value_is($s, #tok$1^64.5, #loc.c, $ptr_to_int(L#c), $ptr_to(^List));
        // non-pure function
        // assert @writes_check(*((l->tail))); 
        assert $top_writable($s, #wrTime$1^51.1, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#l, ^List), ^List));
        // assert @writes_check(end); 
        assert $top_writable($s, #wrTime$1^51.1, $phys_ptr_cast(P#end, ^List));
        // assert @reads_check_normal((l->tail)); 
        assert $thread_local($s, $phys_ptr_cast(P#l, ^List));
        // c := Concat(*((l->tail)), end); 
        call L#c := Concat($rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#l, ^List), ^List), $phys_ptr_cast(P#end, ^List));
        assume $full_stop_ext(#tok$1^64.15, $s);
        assume $local_value_is($s, #tok$1^64.15, #loc.c, $ptr_to_int(L#c), $ptr_to(^List));
        // non-pure function
        // assert @writes_check(c); 
        assert $top_writable($s, #wrTime$1^51.1, $phys_ptr_cast(L#c, ^List));
        // assert @reads_check_normal((l->head)); 
        assert $thread_local($s, $phys_ptr_cast(P#l, ^List));
        // c := Cons(c, *((l->head))); 
        call L#c := Cons($phys_ptr_cast(L#c, ^List), $rd_phys_ptr($s, List.head, $phys_ptr_cast(P#l, ^List), ^^void));
        assume $full_stop_ext(#tok$1^65.9, $s);
        assume $local_value_is($s, #tok$1^65.9, #loc.c, $ptr_to_int(L#c), $ptr_to(^List));
        // assert @writes_check(l); 
        assert $top_writable($s, #wrTime$1^51.1, $phys_ptr_cast(P#l, ^List));
        // assert @writes_check(@_vcc_extent(@state, l)); 
        assert (forall #writes$1^66.5: $ptr :: { $dont_instantiate(#writes$1^66.5) } $set_in(#writes$1^66.5, $extent($s, $phys_ptr_cast(P#l, ^List))) ==> $top_writable($s, #wrTime$1^51.1, #writes$1^66.5));
        // stmt _vcc_free(l); 
        call $free($phys_ptr_cast(P#l, ^List));
        assume $full_stop_ext(#tok$1^66.5, $s);
        // return c; 
        $result := $phys_ptr_cast(L#c, ^List);
        assert $position_marker();
        goto #exit;
    }

  anon29:
    // empty

  #exit:
}



procedure Reverse(P#l: $ptr) returns ($result: $ptr);
  requires $wrapped($s, $phys_ptr_cast(P#l, ^List), ^List);
  modifies $s, $cev_pc;
  free ensures true;
  ensures $wrapped($s, $phys_ptr_cast($result, ^List), ^List) && $in_domain_lab($s, $phys_ptr_cast($result, ^List), $phys_ptr_cast($result, ^List), l#public) && ($is_fresh(old($s), $s, $phys_ptr_cast($result, ^List)) || ($phys_ptr_cast($result, ^List) == $phys_ptr_cast(P#l, ^List) && $in_domain_lab(old($s), $phys_ptr_cast($result, ^List), $phys_ptr_cast(P#l, ^List), l#public)));
  ensures $eq.$map_t..^^mathint.$ptr_to..^^void($int_to_map_t..^^mathint.ptr_to..^^void($rd_inv($s, List.val, $phys_ptr_cast($result, ^List))), F#lambda#6($rd_inv(old($s), List.length, $phys_ptr_cast(P#l, ^List)) - 1, $int_to_map_t..^^mathint.ptr_to..^^void($rd_inv(old($s), List.val, $phys_ptr_cast(P#l, ^List)))));
  ensures $rd_inv($s, List.length, $phys_ptr_cast($result, ^List)) == $rd_inv(old($s), List.length, $phys_ptr_cast(P#l, ^List));
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#l, ^List)));
  free ensures $call_transition(old($s), $s);



implementation Reverse(P#l: $ptr) returns ($result: $ptr)
{
  var prestate#30: $state;
  var prestate#28: $state;
  var owns#29: $ptrset;
  var L#e: $ptr;
  var L#f: $ptr;
  var L#r: $ptr;
  var #wrTime$1^71.1: int;
  var #stackframe: int;

  anon35:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^71.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^71.1, #loc.l, $ptr_to_int(P#l), $ptr_to(^List));
    assume #wrTime$1^71.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^71.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#l, ^List)));
    assume $thread_owned($s, $phys_ptr_cast(P#l, ^List));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, l, l); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#l, ^List), $phys_ptr_cast(P#l, ^List), l#public);
    // struct List* r; 
    assume $local_value_is($s, #tok$1^78.3, #loc.r, $ptr_to_int(L#r), $ptr_to(^List));
    // var struct List* r
    // assert @reads_check_normal((l->length)); 
    assert $thread_local($s, $phys_ptr_cast(P#l, ^List));
    assume true;
    // if (==(*((l->length)), 0)) ...
    if ($rd_inv($s, List.length, $phys_ptr_cast(P#l, ^List)) == 0)
    {
      anon30:
        // return l; 
        $result := $phys_ptr_cast(P#l, ^List);
        assert $position_marker();
        goto #exit;
    }
    else
    {
      anon33:
        // struct List* f; 
        assume $local_value_is($s, #tok$1^86.5, #loc.f, $ptr_to_int(L#f), $ptr_to(^List));
        // struct List* e; 
        assume $local_value_is($s, #tok$1^82.5, #loc.e, $ptr_to_int(L#e), $ptr_to(^List));
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
        assert $wrapped($s, $phys_ptr_cast(P#l, ^List), ^List);
        // assert @writes_check(l); 
        assert $top_writable($s, #wrTime$1^71.1, $phys_ptr_cast(P#l, ^List));
        // assume @_vcc_inv(@state, l); 
        assume $inv($s, $phys_ptr_cast(P#l, ^List), ^List);
        assume true;
        // if (pure(!=(*((l->length)), 0))) ...
        if ($rd_inv($s, List.length, $phys_ptr_cast(P#l, ^List)) != 0)
        {
          anon31:
            // prestate#30 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#30, l, *((l->tail)))); 
            prestate#30 := $release($current_state($s), prestate#30, $phys_ptr_cast(P#l, ^List), $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#l, ^List), ^List));
            assume $local_value_is($s, #tok$2^0.0, #loc.prestate#30, $state_to_int(prestate#30), ^$#state_t);
            // owns#29 := pure(@_vcc_set_union(owns#29, @_vcc_set_singleton(*((l->tail))))); 
            owns#29 := $set_union(owns#29, $set_singleton($rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#l, ^List), ^List)));
            assume $local_value_is($s, #tok$2^0.0, #loc.owns#29, $ptrset_to_int(owns#29), ^$#ptrset);
            // assume pure(@_vcc_typed(@state, *((l->tail)))); 
            assume $typed($s, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#l, ^List), ^List));
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
        assume owns#29 == $owns($s, $phys_ptr_cast(P#l, ^List));
        // assume @_vcc_pre_static_unwrap(@state); 
        assume $pre_static_unwrap($s);
        // @_vcc_static_unwrap(pure(l), prestate#30)
        call $static_unwrap($phys_ptr_cast(P#l, ^List), prestate#30);
        assume $good_state_ext(#tok$1^83.21, $s);
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // non-pure function
        // assert @writes_check(*((l->tail))); 
        assert $top_writable($s, #wrTime$1^71.1, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#l, ^List), ^List));
        // assert @reads_check_normal((l->tail)); 
        assert $thread_local($s, $phys_ptr_cast(P#l, ^List));
        // r := Reverse(*((l->tail))); 
        call L#r := Reverse($rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#l, ^List), ^List));
        assume $full_stop_ext(#tok$1^84.9, $s);
        assume $local_value_is($s, #tok$1^84.9, #loc.r, $ptr_to_int(L#r), $ptr_to(^List));
        // non-pure function
        // e := ListNew(); 
        call L#e := ListNew();
        assume $full_stop_ext(#tok$1^85.9, $s);
        assume $local_value_is($s, #tok$1^85.9, #loc.e, $ptr_to_int(L#e), $ptr_to(^List));
        // non-pure function
        // assert @writes_check(e); 
        assert $top_writable($s, #wrTime$1^71.1, $phys_ptr_cast(L#e, ^List));
        // assert @reads_check_normal((l->head)); 
        assert $thread_local($s, $phys_ptr_cast(P#l, ^List));
        // f := Cons(e, *((l->head))); 
        call L#f := Cons($phys_ptr_cast(L#e, ^List), $rd_phys_ptr($s, List.head, $phys_ptr_cast(P#l, ^List), ^^void));
        assume $full_stop_ext(#tok$1^86.15, $s);
        assume $local_value_is($s, #tok$1^86.15, #loc.f, $ptr_to_int(L#f), $ptr_to(^List));
        // non-pure function
        // assert @writes_check(r); 
        assert $top_writable($s, #wrTime$1^71.1, $phys_ptr_cast(L#r, ^List));
        // assert @writes_check(f); 
        assert $top_writable($s, #wrTime$1^71.1, $phys_ptr_cast(L#f, ^List));
        // r := Concat(r, f); 
        call L#r := Concat($phys_ptr_cast(L#r, ^List), $phys_ptr_cast(L#f, ^List));
        assume $full_stop_ext(#tok$1^87.9, $s);
        assume $local_value_is($s, #tok$1^87.9, #loc.r, $ptr_to_int(L#r), $ptr_to(^List));
        // return r; 
        $result := $phys_ptr_cast(L#r, ^List);
        assert $position_marker();
        goto #exit;
    }

  anon36:
    // empty

  #exit:
}



procedure Tail(P#l: $ptr) returns ($result: $ptr);
  requires $wrapped($s, $phys_ptr_cast(P#l, ^List), ^List);
  requires $rd_inv($s, List.length, $phys_ptr_cast(P#l, ^List)) != 0;
  modifies $s, $cev_pc;
  free ensures true;
  ensures $wrapped($s, $phys_ptr_cast($result, ^List), ^List) && $is_fresh(old($s), $s, $phys_ptr_cast($result, ^List)) && $in_domain_lab(old($s), $phys_ptr_cast($result, ^List), $phys_ptr_cast(P#l, ^List), l#public);
  ensures $rd_inv($s, List.length, $phys_ptr_cast($result, ^List)) == $rd_inv(old($s), List.length, $phys_ptr_cast(P#l, ^List)) - 1;
  ensures $eq.$map_t..^^mathint.$ptr_to..^^void($int_to_map_t..^^mathint.ptr_to..^^void($rd_inv($s, List.val, $phys_ptr_cast($result, ^List))), F#lambda#7($int_to_map_t..^^mathint.ptr_to..^^void($rd_inv(old($s), List.val, $phys_ptr_cast(P#l, ^List)))));
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#l, ^List)));
  free ensures $call_transition(old($s), $s);



implementation Tail(P#l: $ptr) returns ($result: $ptr)
{
  var prestate#33: $state;
  var prestate#31: $state;
  var owns#32: $ptrset;
  var L#r: $ptr;
  var #wrTime$1^92.1: int;
  var #stackframe: int;

  anon39:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^92.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^92.1, #loc.l, $ptr_to_int(P#l), $ptr_to(^List));
    assume #wrTime$1^92.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^92.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#l, ^List)));
    assume $thread_owned($s, $phys_ptr_cast(P#l, ^List));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, l, l); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#l, ^List), $phys_ptr_cast(P#l, ^List), l#public);
    // struct List* r; 
    assume $local_value_is($s, #tok$1^100.3, #loc.r, $ptr_to_int(L#r), $ptr_to(^List));
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
    assert $wrapped($s, $phys_ptr_cast(P#l, ^List), ^List);
    // assert @writes_check(l); 
    assert $top_writable($s, #wrTime$1^92.1, $phys_ptr_cast(P#l, ^List));
    // assume @_vcc_inv(@state, l); 
    assume $inv($s, $phys_ptr_cast(P#l, ^List), ^List);
    assume true;
    // if (pure(!=(*((l->length)), 0))) ...
    if ($rd_inv($s, List.length, $phys_ptr_cast(P#l, ^List)) != 0)
    {
      anon37:
        // prestate#33 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#33, l, *((l->tail)))); 
        prestate#33 := $release($current_state($s), prestate#33, $phys_ptr_cast(P#l, ^List), $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#l, ^List), ^List));
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#33, $state_to_int(prestate#33), ^$#state_t);
        // owns#32 := pure(@_vcc_set_union(owns#32, @_vcc_set_singleton(*((l->tail))))); 
        owns#32 := $set_union(owns#32, $set_singleton($rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#l, ^List), ^List)));
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#32, $ptrset_to_int(owns#32), ^$#ptrset);
        // assume pure(@_vcc_typed(@state, *((l->tail)))); 
        assume $typed($s, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#l, ^List), ^List));
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
    assume owns#32 == $owns($s, $phys_ptr_cast(P#l, ^List));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(l), prestate#33)
    call $static_unwrap($phys_ptr_cast(P#l, ^List), prestate#33);
    assume $good_state_ext(#tok$1^99.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @reads_check_normal((l->tail)); 
    assert $thread_local($s, $phys_ptr_cast(P#l, ^List));
    // r := *((l->tail)); 
    L#r := $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#l, ^List), ^List);
    assume $local_value_is($s, #tok$1^100.3, #loc.r, $ptr_to_int(L#r), $ptr_to(^List));
    // assert @writes_check(l); 
    assert $top_writable($s, #wrTime$1^92.1, $phys_ptr_cast(P#l, ^List));
    // assert @writes_check(@_vcc_extent(@state, l)); 
    assert (forall #writes$1^101.3: $ptr :: { $dont_instantiate(#writes$1^101.3) } $set_in(#writes$1^101.3, $extent($s, $phys_ptr_cast(P#l, ^List))) ==> $top_writable($s, #wrTime$1^92.1, #writes$1^101.3));
    // stmt _vcc_free(l); 
    call $free($phys_ptr_cast(P#l, ^List));
    assume $full_stop_ext(#tok$1^101.3, $s);
    // return r; 
    $result := $phys_ptr_cast(L#r, ^List);
    assert $position_marker();
    goto #exit;

  anon41:
    // empty

  #exit:
}



function F#qv(#s: $state, SP#front: $ptr, SP#rear: $ptr) : $map_t..^^mathint.$ptr_to..^^void;

const unique cf#qv: $pure_function;

axiom (forall #s: $state, SP#front: $ptr, SP#rear: $ptr :: { F#qv(#s, SP#front, SP#rear) } $eq.$map_t..^^mathint.$ptr_to..^^void(F#qv(#s, SP#front, SP#rear), F#lambda#8($rd_inv(#s, List.length, $phys_ptr_cast(SP#rear, ^List)) + $rd_inv(#s, List.length, $phys_ptr_cast(SP#front, ^List)) - 1, $int_to_map_t..^^mathint.ptr_to..^^void($rd_inv(#s, List.val, $phys_ptr_cast(SP#rear, ^List))), $int_to_map_t..^^mathint.ptr_to..^^void($rd_inv(#s, List.val, $phys_ptr_cast(SP#front, ^List))), $rd_inv(#s, List.length, $phys_ptr_cast(SP#front, ^List)))));

axiom (forall #s0: $state, #s1: $state, SP#front: $ptr, SP#rear: $ptr :: {:weight 5} { $trans_call_transition(#s0, #s1), F#qv(#s0, SP#front, SP#rear), F#qv(#s1, SP#front, SP#rear) } $eq.$map_t..^^mathint.$ptr_to..^^void(F#qv(#s0, SP#front, SP#rear), F#qv(#s1, SP#front, SP#rear)) ==> F#qv(#s0, SP#front, SP#rear) == F#qv(#s1, SP#front, SP#rear));

axiom $function_arg_type(cf#qv, 0, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#qv, 1, $ptr_to(^List));

axiom $function_arg_type(cf#qv, 2, $ptr_to(^List));

procedure qv(SP#front: $ptr, SP#rear: $ptr) returns ($result: $map_t..^^mathint.$ptr_to..^^void);
  ensures $eq.$map_t..^^mathint.$ptr_to..^^void($result, F#lambda#8($rd_inv($s, List.length, $phys_ptr_cast(SP#rear, ^List)) + $rd_inv($s, List.length, $phys_ptr_cast(SP#front, ^List)) - 1, $int_to_map_t..^^mathint.ptr_to..^^void($rd_inv($s, List.val, $phys_ptr_cast(SP#rear, ^List))), $int_to_map_t..^^mathint.ptr_to..^^void($rd_inv($s, List.val, $phys_ptr_cast(SP#front, ^List))), $rd_inv($s, List.length, $phys_ptr_cast(SP#front, ^List))));
  free ensures $result == F#qv($s, SP#front, SP#rear);
  free ensures $call_transition(old($s), $s);



procedure QueueNew() returns ($result: $ptr);
  modifies $s, $cev_pc;
  free ensures true;
  ensures $is_fresh(old($s), $s, $phys_ptr_cast($result, ^Queue)) && $wrapped($s, $phys_ptr_cast($result, ^Queue), ^Queue);
  ensures $eq.$map_t..^^mathint.$ptr_to..^^void(F#qv($s, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast($result, ^Queue), ^List), $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast($result, ^Queue), ^List)), F#lambda#9());
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation QueueNew() returns ($result: $ptr)
{
  var owns#35: $ptrset;
  var staticWrapState#34: $state;
  var prestate#36: $state;
  var res_ListNew#15: $ptr;
  var res_ListNew#14: $ptr;
  var L#r: $ptr;
  var #wrTime$1^121.1: int;
  var #stackframe: int;

  anon42:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^121.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^121.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^121.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // struct Queue* r; 
    assume $local_value_is($s, #tok$1^125.3, #loc.r, $ptr_to_int(L#r), $ptr_to(^Queue));
    // r := _vcc_alloc(@_vcc_typeof((struct Queue*)@null)); 
    call L#r := $alloc(^Queue);
    assume $full_stop_ext(#tok$1^125.14, $s);
    assume $local_value_is($s, #tok$1^125.14, #loc.r, $ptr_to_int(L#r), $ptr_to(^Queue));
    // assume @_vcc_ptr_neq_null(r); 
    assume $non_null($phys_ptr_cast(L#r, ^Queue));
    // struct List* res_ListNew#14; 
    assume $local_value_is($s, #tok$1^127.14, #loc.res_ListNew#14, $ptr_to_int(res_ListNew#14), $ptr_to(^List));
    // res_ListNew#14 := ListNew(); 
    call res_ListNew#14 := ListNew();
    assume $full_stop_ext(#tok$1^127.14, $s);
    assume $local_value_is($s, #tok$1^127.14, #loc.res_ListNew#14, $ptr_to_int(res_ListNew#14), $ptr_to(^List));
    // assert @prim_writes_check((r->front)); 
    assert $writable_prim($s, #wrTime$1^121.1, $dot($phys_ptr_cast(L#r, ^Queue), Queue.front));
    // *(r->front) := res_ListNew#14; 
    call $write_int(Queue.front, $phys_ptr_cast(L#r, ^Queue), $ptr_to_int($phys_ptr_cast(res_ListNew#14, ^List)));
    assume $full_stop_ext(#tok$1^127.3, $s);
    // struct List* res_ListNew#15; 
    assume $local_value_is($s, #tok$1^128.13, #loc.res_ListNew#15, $ptr_to_int(res_ListNew#15), $ptr_to(^List));
    // res_ListNew#15 := ListNew(); 
    call res_ListNew#15 := ListNew();
    assume $full_stop_ext(#tok$1^128.13, $s);
    assume $local_value_is($s, #tok$1^128.13, #loc.res_ListNew#15, $ptr_to_int(res_ListNew#15), $ptr_to(^List));
    // assert @prim_writes_check((r->rear)); 
    assert $writable_prim($s, #wrTime$1^121.1, $dot($phys_ptr_cast(L#r, ^Queue), Queue.rear));
    // *(r->rear) := res_ListNew#15; 
    call $write_int(Queue.rear, $phys_ptr_cast(L#r, ^Queue), $ptr_to_int($phys_ptr_cast(res_ListNew#15, ^List)));
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
    assert $top_writable($s, #wrTime$1^121.1, $phys_ptr_cast(L#r, ^Queue));
    // assert @_vcc_wrapped(@state, *((r->rear))); 
    assert $wrapped($s, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(L#r, ^Queue), ^List), ^List);
    // assert @writes_check(*((r->rear))); 
    assert $top_writable($s, #wrTime$1^121.1, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(L#r, ^Queue), ^List));
    // owns#35 := pure(@_vcc_set_union(owns#35, @_vcc_set_singleton(*((r->rear))))); 
    owns#35 := $set_union(owns#35, $set_singleton($rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(L#r, ^Queue), ^List)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#35, $ptrset_to_int(owns#35), ^$#ptrset);
    // staticWrapState#34 := pure(@_vcc_take_over(staticWrapState#34, r, *((r->rear)))); 
    staticWrapState#34 := $take_over(staticWrapState#34, $phys_ptr_cast(L#r, ^Queue), $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(L#r, ^Queue), ^List));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#34, $state_to_int(staticWrapState#34), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((r->front))); 
    assert $wrapped($s, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(L#r, ^Queue), ^List), ^List);
    // assert @writes_check(*((r->front))); 
    assert $top_writable($s, #wrTime$1^121.1, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(L#r, ^Queue), ^List));
    // owns#35 := pure(@_vcc_set_union(owns#35, @_vcc_set_singleton(*((r->front))))); 
    owns#35 := $set_union(owns#35, $set_singleton($rd_phys_ptr($s, Queue.front, $phys_ptr_cast(L#r, ^Queue), ^List)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#35, $ptrset_to_int(owns#35), ^$#ptrset);
    // staticWrapState#34 := pure(@_vcc_take_over(staticWrapState#34, r, *((r->front)))); 
    staticWrapState#34 := $take_over(staticWrapState#34, $phys_ptr_cast(L#r, ^Queue), $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(L#r, ^Queue), ^List));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#34, $state_to_int(staticWrapState#34), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(r), staticWrapState#34, owns#35)
    call $static_wrap($phys_ptr_cast(L#r, ^Queue), staticWrapState#34, owns#35);
    assume $good_state_ext(#tok$1^129.19, $s);
    // assert @inv_check(@_vcc_is_malloc_root(@state, r)); 
    assert $is_malloc_root($s, $phys_ptr_cast(L#r, ^Queue));
    // assert @inv_check(@_vcc_ptr_neq_pure(*((r->front)), *((r->rear)))); 
    assert $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(L#r, ^Queue), ^List) != $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(L#r, ^Queue), ^List);
    // assert @inv_check(@keeps_stable(old(prestate#36, *((r->front))), *((r->front)))); 
    assert $rd_phys_ptr(prestate#36, Queue.front, $phys_ptr_cast(L#r, ^Queue), ^List) == $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(L#r, ^Queue), ^List);
    // assert @inv_check(@keeps(r, *((r->front)))); 
    assert $keeps($s, $phys_ptr_cast(L#r, ^Queue), $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(L#r, ^Queue), ^List));
    // assert @inv_check(@keeps_stable(old(prestate#36, *((r->rear))), *((r->rear)))); 
    assert $rd_phys_ptr(prestate#36, Queue.rear, $phys_ptr_cast(L#r, ^Queue), ^List) == $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(L#r, ^Queue), ^List);
    // assert @inv_check(@keeps(r, *((r->rear)))); 
    assert $keeps($s, $phys_ptr_cast(L#r, ^Queue), $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(L#r, ^Queue), ^List));
    // assert @inv_check(<=(*((*((r->rear))->length)), *((*((r->front))->length)))); 
    assert $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(L#r, ^Queue), ^List)) <= $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(L#r, ^Queue), ^List));
    // assert @inv_check(<=(+(*((*((r->front))->length)), *((*((r->rear))->length))), 4294967295)); 
    assert $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(L#r, ^Queue), ^List)) + $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(L#r, ^Queue), ^List)) <= 4294967295;
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return r; 
    $result := $phys_ptr_cast(L#r, ^Queue);
    assert $position_marker();
    goto #exit;

  anon43:
    // empty

  #exit:
}



procedure QueueBuild(P#front: $ptr, P#rear: $ptr) returns ($result: $ptr);
  requires $rd_inv($s, List.length, $phys_ptr_cast(P#front, ^List)) + $rd_inv($s, List.length, $phys_ptr_cast(P#rear, ^List)) <= 4294967295;
  requires $wrapped($s, $phys_ptr_cast(P#front, ^List), ^List);
  requires $wrapped($s, $phys_ptr_cast(P#rear, ^List), ^List);
  requires $phys_ptr_cast(P#front, ^List) != $phys_ptr_cast(P#rear, ^List);
  modifies $s, $cev_pc;
  free ensures true;
  ensures $wrapped($s, $phys_ptr_cast($result, ^Queue), ^Queue) && $in_domain_lab($s, $phys_ptr_cast($result, ^Queue), $phys_ptr_cast($result, ^Queue), l#public) && $is_fresh(old($s), $s, $phys_ptr_cast($result, ^Queue));
  ensures $unchk_add(^^u4, $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast($result, ^Queue), ^List)), $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast($result, ^Queue), ^List))) == $rd_inv(old($s), List.length, $phys_ptr_cast(P#front, ^List)) + $rd_inv(old($s), List.length, $phys_ptr_cast(P#rear, ^List));
  ensures $eq.$map_t..^^mathint.$ptr_to..^^void(F#qv($s, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast($result, ^Queue), ^List), $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast($result, ^Queue), ^List)), F#qv(old($s), $phys_ptr_cast(P#front, ^List), $phys_ptr_cast(P#rear, ^List)));
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#front, ^List) || #p == $phys_ptr_cast(P#rear, ^List)));
  free ensures $call_transition(old($s), $s);



implementation QueueBuild(P#front: $ptr, P#rear: $ptr) returns ($result: $ptr)
{
  var owns#38: $ptrset;
  var staticWrapState#37: $state;
  var prestate#39: $state;
  var res_ListNew#17: $ptr;
  var res_Concat#16: $ptr;
  var L#f: $ptr;
  var L#r: $ptr;
  var #wrTime$1^133.1: int;
  var #stackframe: int;

  anon46:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^133.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^133.1, #loc.front, $ptr_to_int(P#front), $ptr_to(^List));
    assume $local_value_is($s, #tok$1^133.1, #loc.rear, $ptr_to_int(P#rear), $ptr_to(^List));
    assume #wrTime$1^133.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^133.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#front, ^List) || #p == $phys_ptr_cast(P#rear, ^List)));
    assume $thread_owned($s, $phys_ptr_cast(P#front, ^List));
    assume $thread_owned($s, $phys_ptr_cast(P#rear, ^List));
    // assume true; 
    assume true;
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, rear, rear); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#rear, ^List), $phys_ptr_cast(P#rear, ^List), l#public);
    // assert @_vcc_in_domain(@state, front, front); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#front, ^List), $phys_ptr_cast(P#front, ^List), l#public);
    // struct Queue* r; 
    assume $local_value_is($s, #tok$1^141.3, #loc.r, $ptr_to_int(L#r), $ptr_to(^Queue));
    // r := _vcc_alloc(@_vcc_typeof((struct Queue*)@null)); 
    call L#r := $alloc(^Queue);
    assume $full_stop_ext(#tok$1^141.14, $s);
    assume $local_value_is($s, #tok$1^141.14, #loc.r, $ptr_to_int(L#r), $ptr_to(^Queue));
    // assume @_vcc_ptr_neq_null(r); 
    assume $non_null($phys_ptr_cast(L#r, ^Queue));
    // assert @reads_check_normal((rear->length)); 
    assert $thread_local($s, $phys_ptr_cast(P#rear, ^List));
    // assert @reads_check_normal((front->length)); 
    assert $thread_local($s, $phys_ptr_cast(P#front, ^List));
    assume true;
    // if (<=(*((rear->length)), *((front->length)))) ...
    if ($rd_inv($s, List.length, $phys_ptr_cast(P#rear, ^List)) <= $rd_inv($s, List.length, $phys_ptr_cast(P#front, ^List)))
    {
      anon44:
        // assert @prim_writes_check((r->front)); 
        assert $writable_prim($s, #wrTime$1^133.1, $dot($phys_ptr_cast(L#r, ^Queue), Queue.front));
        // *(r->front) := front; 
        call $write_int(Queue.front, $phys_ptr_cast(L#r, ^Queue), $ptr_to_int($phys_ptr_cast(P#front, ^List)));
        assume $full_stop_ext(#tok$1^144.5, $s);
        // assert @prim_writes_check((r->rear)); 
        assert $writable_prim($s, #wrTime$1^133.1, $dot($phys_ptr_cast(L#r, ^Queue), Queue.rear));
        // *(r->rear) := rear; 
        call $write_int(Queue.rear, $phys_ptr_cast(L#r, ^Queue), $ptr_to_int($phys_ptr_cast(P#rear, ^List)));
        assume $full_stop_ext(#tok$1^145.5, $s);
    }
    else
    {
      anon45:
        // struct List* f; 
        assume $local_value_is($s, #tok$1^147.5, #loc.f, $ptr_to_int(L#f), $ptr_to(^List));
        // var struct List* f
        // non-pure function
        // assert @writes_check(rear); 
        assert $top_writable($s, #wrTime$1^133.1, $phys_ptr_cast(P#rear, ^List));
        // f := Reverse(rear); 
        call L#f := Reverse($phys_ptr_cast(P#rear, ^List));
        assume $full_stop_ext(#tok$1^148.9, $s);
        assume $local_value_is($s, #tok$1^148.9, #loc.f, $ptr_to_int(L#f), $ptr_to(^List));
        // struct List* res_Concat#16; 
        assume $local_value_is($s, #tok$1^149.16, #loc.res_Concat#16, $ptr_to_int(res_Concat#16), $ptr_to(^List));
        // assert @writes_check(front); 
        assert $top_writable($s, #wrTime$1^133.1, $phys_ptr_cast(P#front, ^List));
        // assert @writes_check(f); 
        assert $top_writable($s, #wrTime$1^133.1, $phys_ptr_cast(L#f, ^List));
        // res_Concat#16 := Concat(front, f); 
        call res_Concat#16 := Concat($phys_ptr_cast(P#front, ^List), $phys_ptr_cast(L#f, ^List));
        assume $full_stop_ext(#tok$1^149.16, $s);
        assume $local_value_is($s, #tok$1^149.16, #loc.res_Concat#16, $ptr_to_int(res_Concat#16), $ptr_to(^List));
        // assert @prim_writes_check((r->front)); 
        assert $writable_prim($s, #wrTime$1^133.1, $dot($phys_ptr_cast(L#r, ^Queue), Queue.front));
        // *(r->front) := res_Concat#16; 
        call $write_int(Queue.front, $phys_ptr_cast(L#r, ^Queue), $ptr_to_int($phys_ptr_cast(res_Concat#16, ^List)));
        assume $full_stop_ext(#tok$1^149.5, $s);
        // struct List* res_ListNew#17; 
        assume $local_value_is($s, #tok$1^150.15, #loc.res_ListNew#17, $ptr_to_int(res_ListNew#17), $ptr_to(^List));
        // res_ListNew#17 := ListNew(); 
        call res_ListNew#17 := ListNew();
        assume $full_stop_ext(#tok$1^150.15, $s);
        assume $local_value_is($s, #tok$1^150.15, #loc.res_ListNew#17, $ptr_to_int(res_ListNew#17), $ptr_to(^List));
        // assert @prim_writes_check((r->rear)); 
        assert $writable_prim($s, #wrTime$1^133.1, $dot($phys_ptr_cast(L#r, ^Queue), Queue.rear));
        // *(r->rear) := res_ListNew#17; 
        call $write_int(Queue.rear, $phys_ptr_cast(L#r, ^Queue), $ptr_to_int($phys_ptr_cast(res_ListNew#17, ^List)));
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
    assert $top_writable($s, #wrTime$1^133.1, $phys_ptr_cast(L#r, ^Queue));
    // assert @_vcc_wrapped(@state, *((r->rear))); 
    assert $wrapped($s, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(L#r, ^Queue), ^List), ^List);
    // assert @writes_check(*((r->rear))); 
    assert $top_writable($s, #wrTime$1^133.1, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(L#r, ^Queue), ^List));
    // owns#38 := pure(@_vcc_set_union(owns#38, @_vcc_set_singleton(*((r->rear))))); 
    owns#38 := $set_union(owns#38, $set_singleton($rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(L#r, ^Queue), ^List)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#38, $ptrset_to_int(owns#38), ^$#ptrset);
    // staticWrapState#37 := pure(@_vcc_take_over(staticWrapState#37, r, *((r->rear)))); 
    staticWrapState#37 := $take_over(staticWrapState#37, $phys_ptr_cast(L#r, ^Queue), $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(L#r, ^Queue), ^List));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#37, $state_to_int(staticWrapState#37), ^$#state_t);
    // assert @_vcc_wrapped(@state, *((r->front))); 
    assert $wrapped($s, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(L#r, ^Queue), ^List), ^List);
    // assert @writes_check(*((r->front))); 
    assert $top_writable($s, #wrTime$1^133.1, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(L#r, ^Queue), ^List));
    // owns#38 := pure(@_vcc_set_union(owns#38, @_vcc_set_singleton(*((r->front))))); 
    owns#38 := $set_union(owns#38, $set_singleton($rd_phys_ptr($s, Queue.front, $phys_ptr_cast(L#r, ^Queue), ^List)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#38, $ptrset_to_int(owns#38), ^$#ptrset);
    // staticWrapState#37 := pure(@_vcc_take_over(staticWrapState#37, r, *((r->front)))); 
    staticWrapState#37 := $take_over(staticWrapState#37, $phys_ptr_cast(L#r, ^Queue), $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(L#r, ^Queue), ^List));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#37, $state_to_int(staticWrapState#37), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(r), staticWrapState#37, owns#38)
    call $static_wrap($phys_ptr_cast(L#r, ^Queue), staticWrapState#37, owns#38);
    assume $good_state_ext(#tok$1^152.19, $s);
    // assert @inv_check(@_vcc_is_malloc_root(@state, r)); 
    assert $is_malloc_root($s, $phys_ptr_cast(L#r, ^Queue));
    // assert @inv_check(@_vcc_ptr_neq_pure(*((r->front)), *((r->rear)))); 
    assert $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(L#r, ^Queue), ^List) != $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(L#r, ^Queue), ^List);
    // assert @inv_check(@keeps_stable(old(prestate#39, *((r->front))), *((r->front)))); 
    assert $rd_phys_ptr(prestate#39, Queue.front, $phys_ptr_cast(L#r, ^Queue), ^List) == $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(L#r, ^Queue), ^List);
    // assert @inv_check(@keeps(r, *((r->front)))); 
    assert $keeps($s, $phys_ptr_cast(L#r, ^Queue), $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(L#r, ^Queue), ^List));
    // assert @inv_check(@keeps_stable(old(prestate#39, *((r->rear))), *((r->rear)))); 
    assert $rd_phys_ptr(prestate#39, Queue.rear, $phys_ptr_cast(L#r, ^Queue), ^List) == $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(L#r, ^Queue), ^List);
    // assert @inv_check(@keeps(r, *((r->rear)))); 
    assert $keeps($s, $phys_ptr_cast(L#r, ^Queue), $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(L#r, ^Queue), ^List));
    // assert @inv_check(<=(*((*((r->rear))->length)), *((*((r->front))->length)))); 
    assert $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(L#r, ^Queue), ^List)) <= $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(L#r, ^Queue), ^List));
    // assert @inv_check(<=(+(*((*((r->front))->length)), *((*((r->rear))->length))), 4294967295)); 
    assert $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(L#r, ^Queue), ^List)) + $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(L#r, ^Queue), ^List)) <= 4294967295;
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return r; 
    $result := $phys_ptr_cast(L#r, ^Queue);
    assert $position_marker();
    goto #exit;

  anon48:
    // empty

  #exit:
}



procedure QueueFront(P#q: $ptr) returns ($result: $ptr);
  requires $wrapped($s, $phys_ptr_cast(P#q, ^Queue), ^Queue);
  requires $unchk_add(^^u4, $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List)), $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List))) > 0;
  modifies $s, $cev_pc;
  free ensures true;
  ensures $phys_ptr_cast($result, ^^void) == $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(F#qv($s, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List), $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List)), 0), ^^void);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation QueueFront(P#q: $ptr) returns ($result: $ptr)
{
  var #wrTime$1^156.1: int;
  var #stackframe: int;

  anon49:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^156.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^156.1, #loc.q, $ptr_to_int(P#q), $ptr_to(^Queue));
    assume #wrTime$1^156.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^156.1, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, q, q); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#q, ^Queue), $phys_ptr_cast(P#q, ^Queue), l#public);
    // assert @_vcc_in_domain(@state, *((q->front)), q); 
    assert $in_domain_lab($s, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List), $phys_ptr_cast(P#q, ^Queue), l#public);
    // assume @_vcc_in_domain(@state, *((q->front)), q); 
    assume $in_domain_lab($s, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List), $phys_ptr_cast(P#q, ^Queue), l#public);
    // assert @reads_check_normal((*((q->front))->head)); 
    assert $thread_local($s, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List));
    // assert @reads_check_normal((q->front)); 
    assert $thread_local($s, $phys_ptr_cast(P#q, ^Queue));
    // return *((*((q->front))->head)); 
    $result := $rd_phys_ptr($s, List.head, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List), ^^void);
    assert $position_marker();
    goto #exit;

  anon50:
    // empty

  #exit:
}



procedure QueueTail(P#q: $ptr) returns ($result: $ptr);
  requires $wrapped($s, $phys_ptr_cast(P#q, ^Queue), ^Queue);
  requires $unchk_add(^^u4, $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List)), $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List))) > 0;
  modifies $s, $cev_pc;
  free ensures true;
  ensures $is_fresh(old($s), $s, $phys_ptr_cast($result, ^Queue)) && $wrapped($s, $phys_ptr_cast($result, ^Queue), ^Queue);
  ensures $unchk_add(^^u4, $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast($result, ^Queue), ^List)), $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast($result, ^Queue), ^List))) == $unchk_add(^^u4, $rd_inv(old($s), List.length, $rd_phys_ptr(old($s), Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List)), $rd_inv(old($s), List.length, $rd_phys_ptr(old($s), Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List))) - 1;
  ensures $eq.$map_t..^^mathint.$ptr_to..^^void(F#qv($s, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast($result, ^Queue), ^List), $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast($result, ^Queue), ^List)), F#lambda#10(F#qv(old($s), $rd_phys_ptr(old($s), Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List), $rd_phys_ptr(old($s), Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List))));
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#q, ^Queue)));
  free ensures $call_transition(old($s), $s);



implementation QueueTail(P#q: $ptr) returns ($result: $ptr)
{
  var prestate#42: $state;
  var prestate#40: $state;
  var owns#41: $ptrset;
  var L#t: $ptr;
  var L#r: $ptr;
  var #wrTime$1^164.1: int;
  var #stackframe: int;

  anon51:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^164.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^164.1, #loc.q, $ptr_to_int(P#q), $ptr_to(^Queue));
    assume #wrTime$1^164.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^164.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#q, ^Queue)));
    assume $thread_owned($s, $phys_ptr_cast(P#q, ^Queue));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, q, q); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#q, ^Queue), $phys_ptr_cast(P#q, ^Queue), l#public);
    // struct Queue* r; 
    assume $local_value_is($s, #tok$1^174.3, #loc.r, $ptr_to_int(L#r), $ptr_to(^Queue));
    // struct List* t; 
    assume $local_value_is($s, #tok$1^173.3, #loc.t, $ptr_to_int(L#t), $ptr_to(^List));
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
    assert $wrapped($s, $phys_ptr_cast(P#q, ^Queue), ^Queue);
    // assert @writes_check(q); 
    assert $top_writable($s, #wrTime$1^164.1, $phys_ptr_cast(P#q, ^Queue));
    // assume @_vcc_inv(@state, q); 
    assume $inv($s, $phys_ptr_cast(P#q, ^Queue), ^Queue);
    // prestate#42 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#42, q, *((q->rear)))); 
    prestate#42 := $release($current_state($s), prestate#42, $phys_ptr_cast(P#q, ^Queue), $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#42, $state_to_int(prestate#42), ^$#state_t);
    // owns#41 := pure(@_vcc_set_union(owns#41, @_vcc_set_singleton(*((q->rear))))); 
    owns#41 := $set_union(owns#41, $set_singleton($rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#41, $ptrset_to_int(owns#41), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((q->rear)))); 
    assume $typed($s, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List));
    // prestate#42 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#42, q, *((q->front)))); 
    prestate#42 := $release($current_state($s), prestate#42, $phys_ptr_cast(P#q, ^Queue), $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#42, $state_to_int(prestate#42), ^$#state_t);
    // owns#41 := pure(@_vcc_set_union(owns#41, @_vcc_set_singleton(*((q->front))))); 
    owns#41 := $set_union(owns#41, $set_singleton($rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#41, $ptrset_to_int(owns#41), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((q->front)))); 
    assume $typed($s, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List));
    // assume ==(owns#41, @_vcc_owns(@state, q)); 
    assume owns#41 == $owns($s, $phys_ptr_cast(P#q, ^Queue));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(q), prestate#42)
    call $static_unwrap($phys_ptr_cast(P#q, ^Queue), prestate#42);
    assume $good_state_ext(#tok$1^171.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_wrapped(@state, *((q->front))); 
    assert $wrapped($s, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List), ^List);
    // assert @_vcc_in_domain(@state, *((q->front)), *((q->front))); 
    assert $in_domain_lab($s, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List), $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List), l#public);
    // assert @_vcc_wrapped(@state, *((q->rear))); 
    assert $wrapped($s, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List), ^List);
    // assert @_vcc_in_domain(@state, *((q->rear)), *((q->rear))); 
    assert $in_domain_lab($s, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List), $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List), l#public);
    // assume &&(&&(@_vcc_wrapped(@state, *((q->front))), @_vcc_in_domain(@state, *((q->front)), *((q->front)))), &&(@_vcc_wrapped(@state, *((q->rear))), @_vcc_in_domain(@state, *((q->rear)), *((q->rear))))); 
    assume $wrapped($s, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List), ^List) && $in_domain_lab($s, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List), $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List), l#public) && $wrapped($s, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List), ^List) && $in_domain_lab($s, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List), $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List), l#public);
    // non-pure function
    // assert @writes_check(*((q->front))); 
    assert $top_writable($s, #wrTime$1^164.1, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List));
    // assert @reads_check_normal((q->front)); 
    assert $thread_local($s, $phys_ptr_cast(P#q, ^Queue));
    // t := Tail(*((q->front))); 
    call L#t := Tail($rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List));
    assume $full_stop_ext(#tok$1^173.13, $s);
    assume $local_value_is($s, #tok$1^173.13, #loc.t, $ptr_to_int(L#t), $ptr_to(^List));
    // non-pure function
    // assert @writes_check(t); 
    assert $top_writable($s, #wrTime$1^164.1, $phys_ptr_cast(L#t, ^List));
    // assert @writes_check(*((q->rear))); 
    assert $top_writable($s, #wrTime$1^164.1, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List));
    // assert @reads_check_normal((q->rear)); 
    assert $thread_local($s, $phys_ptr_cast(P#q, ^Queue));
    // r := QueueBuild(t, *((q->rear))); 
    call L#r := QueueBuild($phys_ptr_cast(L#t, ^List), $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List));
    assume $full_stop_ext(#tok$1^174.14, $s);
    assume $local_value_is($s, #tok$1^174.14, #loc.r, $ptr_to_int(L#r), $ptr_to(^Queue));
    // assert @writes_check(q); 
    assert $top_writable($s, #wrTime$1^164.1, $phys_ptr_cast(P#q, ^Queue));
    // assert @writes_check(@_vcc_extent(@state, q)); 
    assert (forall #writes$1^175.3: $ptr :: { $dont_instantiate(#writes$1^175.3) } $set_in(#writes$1^175.3, $extent($s, $phys_ptr_cast(P#q, ^Queue))) ==> $top_writable($s, #wrTime$1^164.1, #writes$1^175.3));
    // stmt _vcc_free(q); 
    call $free($phys_ptr_cast(P#q, ^Queue));
    assume $full_stop_ext(#tok$1^175.3, $s);
    // return r; 
    $result := $phys_ptr_cast(L#r, ^Queue);
    assert $position_marker();
    goto #exit;

  anon52:
    // empty

  #exit:
}



procedure Enqueue(P#q: $ptr, P#item: $ptr) returns ($result: $ptr);
  requires $wrapped($s, $phys_ptr_cast(P#q, ^Queue), ^Queue);
  requires $unchk_add(^^u4, $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List)), $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List))) + 1 <= 4294967295;
  modifies $s, $cev_pc;
  free ensures true;
  ensures $is_fresh(old($s), $s, $phys_ptr_cast($result, ^Queue)) && $wrapped($s, $phys_ptr_cast($result, ^Queue), ^Queue);
  ensures $unchk_add(^^u4, $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast($result, ^Queue), ^List)), $rd_inv($s, List.length, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast($result, ^Queue), ^List))) == $unchk_add(^^u4, $rd_inv(old($s), List.length, $rd_phys_ptr(old($s), Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List)), $rd_inv(old($s), List.length, $rd_phys_ptr(old($s), Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List))) + 1;
  ensures $eq.$map_t..^^mathint.$ptr_to..^^void(F#qv($s, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast($result, ^Queue), ^List), $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast($result, ^Queue), ^List)), F#lambda#11(F#qv(old($s), $rd_phys_ptr(old($s), Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List), $rd_phys_ptr(old($s), Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List)), $phys_ptr_cast(P#item, ^^void), $unchk_add(^^u4, $rd_inv(old($s), List.length, $rd_phys_ptr(old($s), Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List)), $rd_inv(old($s), List.length, $rd_phys_ptr(old($s), Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List)))));
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#q, ^Queue)));
  free ensures $call_transition(old($s), $s);



implementation Enqueue(P#q: $ptr, P#item: $ptr) returns ($result: $ptr)
{
  var res_Cons#18: $ptr;
  var prestate#45: $state;
  var prestate#43: $state;
  var owns#44: $ptrset;
  var L#r: $ptr;
  var #wrTime$1^179.1: int;
  var #stackframe: int;

  anon53:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^179.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^179.1, #loc.q, $ptr_to_int(P#q), $ptr_to(^Queue));
    assume $local_value_is($s, #tok$1^179.1, #loc.item, $ptr_to_int(P#item), $ptr_to(^^void));
    assume #wrTime$1^179.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^179.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#q, ^Queue)));
    assume $thread_owned($s, $phys_ptr_cast(P#q, ^Queue));
    // assume true; 
    assume true;
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, q, q); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#q, ^Queue), $phys_ptr_cast(P#q, ^Queue), l#public);
    // struct Queue* r; 
    assume $local_value_is($s, #tok$1^190.3, #loc.r, $ptr_to_int(L#r), $ptr_to(^Queue));
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
    assert $wrapped($s, $phys_ptr_cast(P#q, ^Queue), ^Queue);
    // assert @writes_check(q); 
    assert $top_writable($s, #wrTime$1^179.1, $phys_ptr_cast(P#q, ^Queue));
    // assume @_vcc_inv(@state, q); 
    assume $inv($s, $phys_ptr_cast(P#q, ^Queue), ^Queue);
    // prestate#45 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#45, q, *((q->rear)))); 
    prestate#45 := $release($current_state($s), prestate#45, $phys_ptr_cast(P#q, ^Queue), $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#45, $state_to_int(prestate#45), ^$#state_t);
    // owns#44 := pure(@_vcc_set_union(owns#44, @_vcc_set_singleton(*((q->rear))))); 
    owns#44 := $set_union(owns#44, $set_singleton($rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#44, $ptrset_to_int(owns#44), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((q->rear)))); 
    assume $typed($s, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List));
    // prestate#45 := pure(@_vcc_release(@_vcc_current_state(@state), prestate#45, q, *((q->front)))); 
    prestate#45 := $release($current_state($s), prestate#45, $phys_ptr_cast(P#q, ^Queue), $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List));
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#45, $state_to_int(prestate#45), ^$#state_t);
    // owns#44 := pure(@_vcc_set_union(owns#44, @_vcc_set_singleton(*((q->front))))); 
    owns#44 := $set_union(owns#44, $set_singleton($rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List)));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#44, $ptrset_to_int(owns#44), ^$#ptrset);
    // assume pure(@_vcc_typed(@state, *((q->front)))); 
    assume $typed($s, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List));
    // assume ==(owns#44, @_vcc_owns(@state, q)); 
    assume owns#44 == $owns($s, $phys_ptr_cast(P#q, ^Queue));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(q), prestate#45)
    call $static_unwrap($phys_ptr_cast(P#q, ^Queue), prestate#45);
    assume $good_state_ext(#tok$1^187.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_wrapped(@state, *((q->front))); 
    assert $wrapped($s, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List), ^List);
    // assert @_vcc_in_domain(@state, *((q->front)), *((q->front))); 
    assert $in_domain_lab($s, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List), $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List), l#public);
    // assert @_vcc_wrapped(@state, *((q->rear))); 
    assert $wrapped($s, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List), ^List);
    // assert @_vcc_in_domain(@state, *((q->rear)), *((q->rear))); 
    assert $in_domain_lab($s, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List), $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List), l#public);
    // assume &&(&&(@_vcc_wrapped(@state, *((q->front))), @_vcc_in_domain(@state, *((q->front)), *((q->front)))), &&(@_vcc_wrapped(@state, *((q->rear))), @_vcc_in_domain(@state, *((q->rear)), *((q->rear))))); 
    assume $wrapped($s, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List), ^List) && $in_domain_lab($s, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List), $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List), l#public) && $wrapped($s, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List), ^List) && $in_domain_lab($s, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List), $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List), l#public);
    // struct List* res_Cons#18; 
    assume $local_value_is($s, #tok$1^189.13, #loc.res_Cons#18, $ptr_to_int(res_Cons#18), $ptr_to(^List));
    // assert @writes_check(*((q->rear))); 
    assert $top_writable($s, #wrTime$1^179.1, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List));
    // assert @reads_check_normal((q->rear)); 
    assert $thread_local($s, $phys_ptr_cast(P#q, ^Queue));
    // res_Cons#18 := Cons(*((q->rear)), item); 
    call res_Cons#18 := Cons($rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List), $phys_ptr_cast(P#item, ^^void));
    assume $full_stop_ext(#tok$1^189.13, $s);
    assume $local_value_is($s, #tok$1^189.13, #loc.res_Cons#18, $ptr_to_int(res_Cons#18), $ptr_to(^List));
    // assert @prim_writes_check((q->rear)); 
    assert $writable_prim($s, #wrTime$1^179.1, $dot($phys_ptr_cast(P#q, ^Queue), Queue.rear));
    // *(q->rear) := res_Cons#18; 
    call $write_int(Queue.rear, $phys_ptr_cast(P#q, ^Queue), $ptr_to_int($phys_ptr_cast(res_Cons#18, ^List)));
    assume $full_stop_ext(#tok$1^189.3, $s);
    // non-pure function
    // assert @writes_check(*((q->front))); 
    assert $top_writable($s, #wrTime$1^179.1, $rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List));
    // assert @writes_check(*((q->rear))); 
    assert $top_writable($s, #wrTime$1^179.1, $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List));
    // assert @reads_check_normal((q->front)); 
    assert $thread_local($s, $phys_ptr_cast(P#q, ^Queue));
    // assert @reads_check_normal((q->rear)); 
    assert $thread_local($s, $phys_ptr_cast(P#q, ^Queue));
    // r := QueueBuild(*((q->front)), *((q->rear))); 
    call L#r := QueueBuild($rd_phys_ptr($s, Queue.front, $phys_ptr_cast(P#q, ^Queue), ^List), $rd_phys_ptr($s, Queue.rear, $phys_ptr_cast(P#q, ^Queue), ^List));
    assume $full_stop_ext(#tok$1^190.14, $s);
    assume $local_value_is($s, #tok$1^190.14, #loc.r, $ptr_to_int(L#r), $ptr_to(^Queue));
    // return r; 
    $result := $phys_ptr_cast(L#r, ^Queue);
    assert $position_marker();
    goto #exit;

  anon54:
    // empty

  #exit:
}



function F#lambda#11(#l2: $map_t..^^mathint.$ptr_to..^^void, #l1: $ptr, #l0: int) : $map_t..^^mathint.$ptr_to..^^void;

const unique cf#lambda#11: $pure_function;

axiom $function_arg_type(cf#lambda#11, 0, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#11, 1, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#11, 2, $ptr_to(^^void));

axiom $function_arg_type(cf#lambda#11, 3, ^^u4);

procedure lambda#11(#l2: $map_t..^^mathint.$ptr_to..^^void, #l1: $ptr, #l0: int) returns ($result: $map_t..^^mathint.$ptr_to..^^void);
  free ensures $result == F#lambda#11(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^185.49#tc1: int, #l2: $map_t..^^mathint.$ptr_to..^^void, #l1: $ptr, #l0: int :: {:weight 10} { $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#11(#l2, $phys_ptr_cast(#l1, ^^void), #l0), Q#i$1^185.49#tc1) } true && $in_range_u4(#l0) ==> $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#11(#l2, $phys_ptr_cast(#l1, ^^void), #l0), Q#i$1^185.49#tc1), ^^void) == (if Q#i$1^185.49#tc1 == #l0 then $phys_ptr_cast(#l1, ^^void) else $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(#l2, Q#i$1^185.49#tc1), ^^void)));

function F#lambda#10(#l0: $map_t..^^mathint.$ptr_to..^^void) : $map_t..^^mathint.$ptr_to..^^void;

const unique cf#lambda#10: $pure_function;

axiom $function_arg_type(cf#lambda#10, 0, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#10, 1, $map_t(^^mathint, $ptr_to(^^void)));

procedure lambda#10(#l0: $map_t..^^mathint.$ptr_to..^^void) returns ($result: $map_t..^^mathint.$ptr_to..^^void);
  free ensures $result == F#lambda#10(#l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^169.49#tc1: int, #l0: $map_t..^^mathint.$ptr_to..^^void :: {:weight 10} { $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#10(#l0), Q#i$1^169.49#tc1) } $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#10(#l0), Q#i$1^169.49#tc1), ^^void) == (if Q#i$1^169.49#tc1 == -1 then $null else $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(#l0, Q#i$1^169.49#tc1 + 1), ^^void)));

function F#lambda#9() : $map_t..^^mathint.$ptr_to..^^void;

const unique cf#lambda#9: $pure_function;

axiom $function_arg_type(cf#lambda#9, 0, $map_t(^^mathint, $ptr_to(^^void)));

procedure lambda#9() returns ($result: $map_t..^^mathint.$ptr_to..^^void);
  free ensures $result == F#lambda#9();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^123.44#tc1: int :: {:weight 10} { $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#9(), Q#i$1^123.44#tc1) } $is_null($phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#9(), Q#i$1^123.44#tc1), ^^void)));

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



axiom (forall Q#i$1^116.27#tc1: int, #l3: int, #l2: $map_t..^^mathint.$ptr_to..^^void, #l1: $map_t..^^mathint.$ptr_to..^^void, #l0: int :: {:weight 10} { $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#8(#l3, #l2, #l1, #l0), Q#i$1^116.27#tc1) } $in_range_u4(#l0) ==> $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#8(#l3, #l2, #l1, #l0), Q#i$1^116.27#tc1), ^^void) == (if Q#i$1^116.27#tc1 < #l0 then $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(#l1, Q#i$1^116.27#tc1), ^^void) else $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(#l2, #l3 - Q#i$1^116.27#tc1), ^^void)));

function F#lambda#7(#l0: $map_t..^^mathint.$ptr_to..^^void) : $map_t..^^mathint.$ptr_to..^^void;

const unique cf#lambda#7: $pure_function;

axiom $function_arg_type(cf#lambda#7, 0, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#7, 1, $map_t(^^mathint, $ptr_to(^^void)));

procedure lambda#7(#l0: $map_t..^^mathint.$ptr_to..^^void) returns ($result: $map_t..^^mathint.$ptr_to..^^void);
  free ensures $result == F#lambda#7(#l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^97.48#tc1: int, #l0: $map_t..^^mathint.$ptr_to..^^void :: {:weight 10} { $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#7(#l0), Q#i$1^97.48#tc1) } $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#7(#l0), Q#i$1^97.48#tc1), ^^void) == (if Q#i$1^97.48#tc1 == -1 then $null else $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(#l0, Q#i$1^97.48#tc1 + 1), ^^void)));

function F#lambda#6(#l1: int, #l0: $map_t..^^mathint.$ptr_to..^^void) : $map_t..^^mathint.$ptr_to..^^void;

const unique cf#lambda#6: $pure_function;

axiom $function_arg_type(cf#lambda#6, 0, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#6, 1, ^^mathint);

axiom $function_arg_type(cf#lambda#6, 2, $map_t(^^mathint, $ptr_to(^^void)));

procedure lambda#6(#l1: int, #l0: $map_t..^^mathint.$ptr_to..^^void) returns ($result: $map_t..^^mathint.$ptr_to..^^void);
  free ensures $result == F#lambda#6(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^75.48#tc1: int, #l1: int, #l0: $map_t..^^mathint.$ptr_to..^^void :: {:weight 10} { $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#6(#l1, #l0), Q#i$1^75.48#tc1) } $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#6(#l1, #l0), Q#i$1^75.48#tc1), ^^void) == $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(#l0, #l1 - Q#i$1^75.48#tc1), ^^void));

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



axiom (forall Q#i$1^57.48#tc1: int, #l3: int, #l2: $map_t..^^mathint.$ptr_to..^^void, #l1: $map_t..^^mathint.$ptr_to..^^void, #l0: int :: {:weight 10} { $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#5(#l3, #l2, #l1, #l0), Q#i$1^57.48#tc1) } $in_range_u4(#l3) && $in_range_u4(#l0) ==> $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#5(#l3, #l2, #l1, #l0), Q#i$1^57.48#tc1), ^^void) == (if Q#i$1^57.48#tc1 < #l0 then $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(#l1, Q#i$1^57.48#tc1), ^^void) else $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(#l2, Q#i$1^57.48#tc1 - #l3), ^^void)));

function F#lambda#4(#l1: $map_t..^^mathint.$ptr_to..^^void, #l0: $ptr) : $map_t..^^mathint.$ptr_to..^^void;

const unique cf#lambda#4: $pure_function;

axiom $function_arg_type(cf#lambda#4, 0, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#4, 1, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#4, 2, $ptr_to(^^void));

procedure lambda#4(#l1: $map_t..^^mathint.$ptr_to..^^void, #l0: $ptr) returns ($result: $map_t..^^mathint.$ptr_to..^^void);
  free ensures $result == F#lambda#4(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^39.48#tc1: int, #l1: $map_t..^^mathint.$ptr_to..^^void, #l0: $ptr :: {:weight 10} { $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#4(#l1, $phys_ptr_cast(#l0, ^^void)), Q#i$1^39.48#tc1) } $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#4(#l1, $phys_ptr_cast(#l0, ^^void)), Q#i$1^39.48#tc1), ^^void) == (if Q#i$1^39.48#tc1 == 0 then $phys_ptr_cast(#l0, ^^void) else $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(#l1, Q#i$1^39.48#tc1 - 1), ^^void)));

function F#lambda#3(#l1: $map_t..^^mathint.$ptr_to..^^void, #l0: $ptr) : $map_t..^^mathint.$ptr_to..^^void;

const unique cf#lambda#3: $pure_function;

axiom $function_arg_type(cf#lambda#3, 0, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#3, 1, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#3, 2, $ptr_to(^^void));

procedure lambda#3(#l1: $map_t..^^mathint.$ptr_to..^^void, #l0: $ptr) returns ($result: $map_t..^^mathint.$ptr_to..^^void);
  free ensures $result == F#lambda#3(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^46.34#tc1: int, #l1: $map_t..^^mathint.$ptr_to..^^void, #l0: $ptr :: {:weight 10} { $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#3(#l1, $phys_ptr_cast(#l0, ^^void)), Q#i$1^46.34#tc1) } $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#3(#l1, $phys_ptr_cast(#l0, ^^void)), Q#i$1^46.34#tc1), ^^void) == (if Q#i$1^46.34#tc1 == 0 then $phys_ptr_cast(#l0, ^^void) else $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(#l1, Q#i$1^46.34#tc1 - 1), ^^void)));

function F#lambda#2() : $map_t..^^mathint.$ptr_to..^^void;

const unique cf#lambda#2: $pure_function;

axiom $function_arg_type(cf#lambda#2, 0, $map_t(^^mathint, $ptr_to(^^void)));

procedure lambda#2() returns ($result: $map_t..^^mathint.$ptr_to..^^void);
  free ensures $result == F#lambda#2();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^28.34#tc1: int :: {:weight 10} { $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#2(), Q#i$1^28.34#tc1) } $is_null($phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#2(), Q#i$1^28.34#tc1), ^^void)));

function F#lambda#1(#l2: $map_t..^^mathint.$ptr_to..^^void, #l1: $ptr, #l0: int) : $map_t..^^mathint.$ptr_to..^^void;

const unique cf#lambda#1: $pure_function;

axiom $function_arg_type(cf#lambda#1, 0, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#1, 1, $map_t(^^mathint, $ptr_to(^^void)));

axiom $function_arg_type(cf#lambda#1, 2, $ptr_to(^^void));

axiom $function_arg_type(cf#lambda#1, 3, ^^u4);

procedure lambda#1(#l2: $map_t..^^mathint.$ptr_to..^^void, #l1: $ptr, #l0: int) returns ($result: $map_t..^^mathint.$ptr_to..^^void);
  free ensures $result == F#lambda#1(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^15.36#tc1: int, #l2: $map_t..^^mathint.$ptr_to..^^void, #l1: $ptr, #l0: int :: {:weight 10} { $select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#1(#l2, $phys_ptr_cast(#l1, ^^void), #l0), Q#i$1^15.36#tc1) } true && $in_range_u4(#l0) ==> $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(F#lambda#1(#l2, $phys_ptr_cast(#l1, ^^void), #l0), Q#i$1^15.36#tc1), ^^void) == (if 0 <= Q#i$1^15.36#tc1 && Q#i$1^15.36#tc1 < #l0 then (if Q#i$1^15.36#tc1 == 0 then $phys_ptr_cast(#l1, ^^void) else $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(#l2, Q#i$1^15.36#tc1 - 1), ^^void)) else $null));

const unique l#public: $label;

type $map_t..^^mathint.$ptr_to..^^void;

function $select.$map_t..^^mathint.$ptr_to..^^void(M: $map_t..^^mathint.$ptr_to..^^void, p: int) : $ptr;

function $store.$map_t..^^mathint.$ptr_to..^^void(M: $map_t..^^mathint.$ptr_to..^^void, p: int, v: $ptr) : $map_t..^^mathint.$ptr_to..^^void;

function $eq.$map_t..^^mathint.$ptr_to..^^void(M1: $map_t..^^mathint.$ptr_to..^^void, M2: $map_t..^^mathint.$ptr_to..^^void) : bool;

const $zero.$map_t..^^mathint.$ptr_to..^^void: $map_t..^^mathint.$ptr_to..^^void;

axiom (forall M: $map_t..^^mathint.$ptr_to..^^void, p: int, v: $ptr :: true);

axiom (forall M: $map_t..^^mathint.$ptr_to..^^void, p: int, v: $ptr, q: int :: $select.$map_t..^^mathint.$ptr_to..^^void($store.$map_t..^^mathint.$ptr_to..^^void(M, q, v), p) == (if p == q then $phys_ptr_cast(v, ^^void) else $select.$map_t..^^mathint.$ptr_to..^^void(M, p)));

axiom (forall M1: $map_t..^^mathint.$ptr_to..^^void, M2: $map_t..^^mathint.$ptr_to..^^void :: { $eq.$map_t..^^mathint.$ptr_to..^^void(M1, M2) } (forall p: int :: $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(M1, p), ^^void) == $phys_ptr_cast($select.$map_t..^^mathint.$ptr_to..^^void(M2, p), ^^void)) ==> $eq.$map_t..^^mathint.$ptr_to..^^void(M1, M2));

axiom (forall M1: $map_t..^^mathint.$ptr_to..^^void, M2: $map_t..^^mathint.$ptr_to..^^void :: { $eq.$map_t..^^mathint.$ptr_to..^^void(M1, M2) } $eq.$map_t..^^mathint.$ptr_to..^^void(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^mathint.ptr_to..^^void(0) == $zero.$map_t..^^mathint.$ptr_to..^^void;

axiom (forall p: int :: $select.$map_t..^^mathint.$ptr_to..^^void($zero.$map_t..^^mathint.$ptr_to..^^void, p) == $phys_ptr_cast($null, ^^void));

axiom true;

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
