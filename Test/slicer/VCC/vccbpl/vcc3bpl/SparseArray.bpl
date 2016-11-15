axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

const unique ^Array: $ctype;

axiom $is_span_sequential(^Array);

axiom $def_struct_type(^Array, 12004, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Array) } $inv2(#s1, #s2, #p, ^Array) == ($set_eq($owns(#s2, #p), $set_empty()) && $rd_inv(#s2, Array.sz, #p) <= 1000 && (forall Q#i$1^64.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^bool($int_to_map_t..^^u4.^^bool($rd_inv(#s2, Array.mapped, #p)), Q#i$1^64.29#tc1) } $in_range_u4(Q#i$1^64.29#tc1) ==> $select.$map_t..^^u4.^^bool($int_to_map_t..^^u4.^^bool($rd_inv(#s2, Array.mapped, #p)), Q#i$1^64.29#tc1) == (Q#i$1^64.29#tc1 < 1000 && $rd_inv(#s2, $field($idx($dot(#p, Array.idx), Q#i$1^64.29#tc1)), $emb0($idx($dot(#p, Array.idx), Q#i$1^64.29#tc1))) < $rd_inv(#s2, Array.sz, #p) && $rd_inv(#s2, $field($idx($dot(#p, Array.back), $rd_inv(#s2, $field($idx($dot(#p, Array.idx), Q#i$1^64.29#tc1)), $emb0($idx($dot(#p, Array.idx), Q#i$1^64.29#tc1))))), $emb0($idx($dot(#p, Array.back), $rd_inv(#s2, $field($idx($dot(#p, Array.idx), Q#i$1^64.29#tc1)), $emb0($idx($dot(#p, Array.idx), Q#i$1^64.29#tc1)))))) == Q#i$1^64.29#tc1)) && (forall Q#i$1^65.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv(#s2, Array.ab, #p)), Q#i$1^65.29#tc1) } { $select.$map_t..^^u4.^^bool($int_to_map_t..^^u4.^^bool($rd_inv(#s2, Array.mapped, #p)), Q#i$1^65.29#tc1) } $in_range_u4(Q#i$1^65.29#tc1) ==> Q#i$1^65.29#tc1 < 1000 ==> $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv(#s2, Array.ab, #p)), Q#i$1^65.29#tc1) == (if $select.$map_t..^^u4.^^bool($int_to_map_t..^^u4.^^bool($rd_inv(#s2, Array.mapped, #p)), Q#i$1^65.29#tc1) then $rd_inv(#s2, $field($idx($dot(#p, Array.val), Q#i$1^65.29#tc1)), $emb0($idx($dot(#p, Array.val), Q#i$1^65.29#tc1))) else 0)) && F#card($int_to_map_t..^^u4.^^bool($rd_inv(#s2, Array.mapped, #p))) == $rd_inv(#s2, Array.sz, #p)));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^Array)) } $in(q, $composite_extent(s, p, ^Array)) == (q == p));

const unique Array.val: $field;

axiom $def_phys_arr_field(^Array, Array.val, ^^i4, false, 0, 1000);

const unique Array.idx: $field;

axiom $def_phys_arr_field(^Array, Array.idx, ^^u4, false, 4000, 1000);

const unique Array.back: $field;

axiom $def_phys_arr_field(^Array, Array.back, ^^u4, false, 8000, 1000);

const unique Array.sz: $field;

axiom $def_phys_field(^Array, Array.sz, ^^u4, false, 12000);

const unique Array.ab: $field;

axiom $def_ghost_field(^Array, Array.ab, $map_t(^^u4, ^^i4), false);

const unique Array.mapped: $field;

axiom $def_ghost_field(^Array, Array.mapped, $map_t(^^u4, ^^bool), false);

procedure Array#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $set_eq($owns($s, $phys_ptr_cast(P#_this_, ^Array)), $set_empty());
  ensures $is_admissibility_check() ==> $rd_inv($s, Array.sz, $phys_ptr_cast(P#_this_, ^Array)) <= 1000;
  ensures $is_admissibility_check() ==> (forall Q#i$1^64.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^bool($int_to_map_t..^^u4.^^bool($rd_inv($s, Array.mapped, $phys_ptr_cast(P#_this_, ^Array))), Q#i$1^64.29#tc1) } $in_range_u4(Q#i$1^64.29#tc1) ==> $select.$map_t..^^u4.^^bool($int_to_map_t..^^u4.^^bool($rd_inv($s, Array.mapped, $phys_ptr_cast(P#_this_, ^Array))), Q#i$1^64.29#tc1) == (Q#i$1^64.29#tc1 < 1000 && $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#_this_, ^Array), Array.idx), Q#i$1^64.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#_this_, ^Array), Array.idx), Q#i$1^64.29#tc1))) < $rd_inv($s, Array.sz, $phys_ptr_cast(P#_this_, ^Array)) && $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#_this_, ^Array), Array.back), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#_this_, ^Array), Array.idx), Q#i$1^64.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#_this_, ^Array), Array.idx), Q#i$1^64.29#tc1))))), $emb0($idx($dot($phys_ptr_cast(P#_this_, ^Array), Array.back), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#_this_, ^Array), Array.idx), Q#i$1^64.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#_this_, ^Array), Array.idx), Q#i$1^64.29#tc1)))))) == Q#i$1^64.29#tc1));
  ensures $is_admissibility_check() ==> (forall Q#i$1^65.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, Array.ab, $phys_ptr_cast(P#_this_, ^Array))), Q#i$1^65.29#tc1) } { $select.$map_t..^^u4.^^bool($int_to_map_t..^^u4.^^bool($rd_inv($s, Array.mapped, $phys_ptr_cast(P#_this_, ^Array))), Q#i$1^65.29#tc1) } $in_range_u4(Q#i$1^65.29#tc1) ==> Q#i$1^65.29#tc1 < 1000 ==> $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, Array.ab, $phys_ptr_cast(P#_this_, ^Array))), Q#i$1^65.29#tc1) == (if $select.$map_t..^^u4.^^bool($int_to_map_t..^^u4.^^bool($rd_inv($s, Array.mapped, $phys_ptr_cast(P#_this_, ^Array))), Q#i$1^65.29#tc1) then $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#_this_, ^Array), Array.val), Q#i$1^65.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#_this_, ^Array), Array.val), Q#i$1^65.29#tc1))) else 0));
  ensures $is_admissibility_check() ==> F#card($int_to_map_t..^^u4.^^bool($rd_inv($s, Array.mapped, $phys_ptr_cast(P#_this_, ^Array)))) == $rd_inv($s, Array.sz, $phys_ptr_cast(P#_this_, ^Array));
  ensures $is_unwrap_check() ==> $set_eq($owns($s, $phys_ptr_cast(P#_this_, ^Array)), $set_empty());
  ensures $is_unwrap_check() ==> $rd_inv($s, Array.sz, $phys_ptr_cast(P#_this_, ^Array)) <= 1000;
  ensures $is_unwrap_check() ==> (forall Q#i$1^64.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^bool($int_to_map_t..^^u4.^^bool($rd_inv($s, Array.mapped, $phys_ptr_cast(P#_this_, ^Array))), Q#i$1^64.29#tc1) } $in_range_u4(Q#i$1^64.29#tc1) ==> $select.$map_t..^^u4.^^bool($int_to_map_t..^^u4.^^bool($rd_inv($s, Array.mapped, $phys_ptr_cast(P#_this_, ^Array))), Q#i$1^64.29#tc1) == (Q#i$1^64.29#tc1 < 1000 && $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#_this_, ^Array), Array.idx), Q#i$1^64.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#_this_, ^Array), Array.idx), Q#i$1^64.29#tc1))) < $rd_inv($s, Array.sz, $phys_ptr_cast(P#_this_, ^Array)) && $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#_this_, ^Array), Array.back), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#_this_, ^Array), Array.idx), Q#i$1^64.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#_this_, ^Array), Array.idx), Q#i$1^64.29#tc1))))), $emb0($idx($dot($phys_ptr_cast(P#_this_, ^Array), Array.back), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#_this_, ^Array), Array.idx), Q#i$1^64.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#_this_, ^Array), Array.idx), Q#i$1^64.29#tc1)))))) == Q#i$1^64.29#tc1));
  ensures $is_unwrap_check() ==> (forall Q#i$1^65.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, Array.ab, $phys_ptr_cast(P#_this_, ^Array))), Q#i$1^65.29#tc1) } { $select.$map_t..^^u4.^^bool($int_to_map_t..^^u4.^^bool($rd_inv($s, Array.mapped, $phys_ptr_cast(P#_this_, ^Array))), Q#i$1^65.29#tc1) } $in_range_u4(Q#i$1^65.29#tc1) ==> Q#i$1^65.29#tc1 < 1000 ==> $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, Array.ab, $phys_ptr_cast(P#_this_, ^Array))), Q#i$1^65.29#tc1) == (if $select.$map_t..^^u4.^^bool($int_to_map_t..^^u4.^^bool($rd_inv($s, Array.mapped, $phys_ptr_cast(P#_this_, ^Array))), Q#i$1^65.29#tc1) then $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#_this_, ^Array), Array.val), Q#i$1^65.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#_this_, ^Array), Array.val), Q#i$1^65.29#tc1))) else 0));
  ensures $is_unwrap_check() ==> F#card($int_to_map_t..^^u4.^^bool($rd_inv($s, Array.mapped, $phys_ptr_cast(P#_this_, ^Array)))) == $rd_inv($s, Array.sz, $phys_ptr_cast(P#_this_, ^Array));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Array#adm(P#_this_: $ptr)
{
  var #wrTime$1^54.1: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^54.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^54.1, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^Array));
    assume #wrTime$1^54.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^54.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($phys_ptr_cast(P#_this_, ^Array), ^Array);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $phys_ptr_cast(P#_this_, ^Array));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($phys_ptr_cast(P#_this_, ^Array));
        assume $good_state_ext(#tok$1^54.1, $s);
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
            assume $admissibility_pre($s, $phys_ptr_cast(P#_this_, ^Array));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $phys_ptr_cast(P#_this_, ^Array));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Array*)@null))
        call $havoc_others($phys_ptr_cast(P#_this_, ^Array), ^Array);
        assume $good_state_ext(#tok$1^54.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $phys_ptr_cast(P#_this_, ^Array), ^Array);
    }

  #exit:
}



function F#card(SP#s: $map_t..^^u4.^^bool) : int;

const unique cf#card: $pure_function;

axiom $function_arg_type(cf#card, 0, ^^mathint);

axiom $function_arg_type(cf#card, 1, $map_t(^^u4, ^^bool));

procedure card(SP#s: $map_t..^^u4.^^bool) returns ($result: int);
  free ensures $result == F#card(SP#s);
  free ensures $call_transition(old($s), $s);



function F#empty() : $map_t..^^u4.^^bool;

const unique cf#empty: $pure_function;

axiom $eq.$map_t..^^u4.^^bool(F#empty(), F#lambda#6());

axiom $function_arg_type(cf#empty, 0, $map_t(^^u4, ^^bool));

procedure empty() returns ($result: $map_t..^^u4.^^bool);
  ensures $eq.$map_t..^^u4.^^bool($result, F#lambda#6());
  free ensures $result == F#empty();
  free ensures $call_transition(old($s), $s);



function F#addone(SP#s: $map_t..^^u4.^^bool, SP#i: int) : $map_t..^^u4.^^bool;

const unique cf#addone: $pure_function;

axiom (forall SP#s: $map_t..^^u4.^^bool, SP#i: int :: { F#addone(SP#s, SP#i) } $eq.$map_t..^^u4.^^bool(F#addone(SP#s, SP#i), F#lambda#7(SP#s, SP#i)));

axiom $function_arg_type(cf#addone, 0, $map_t(^^u4, ^^bool));

axiom $function_arg_type(cf#addone, 1, $map_t(^^u4, ^^bool));

axiom $function_arg_type(cf#addone, 2, ^^u4);

procedure addone(SP#s: $map_t..^^u4.^^bool, SP#i: int) returns ($result: $map_t..^^u4.^^bool);
  ensures $eq.$map_t..^^u4.^^bool($result, F#lambda#7(SP#s, SP#i));
  free ensures $result == F#addone(SP#s, SP#i);
  free ensures $call_transition(old($s), $s);



function F#upper_card(SP#s: $map_t..^^u4.^^bool, SP#n: int) : bool;

const unique cf#upper_card: $pure_function;

axiom (forall SP#s: $map_t..^^u4.^^bool, SP#n: int :: { F#upper_card(SP#s, SP#n) } F#upper_card(SP#s, SP#n) == (forall Q#i$1^49.107#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^bool(SP#s, Q#i$1^49.107#tc1) } $in_range_u4(Q#i$1^49.107#tc1) ==> $select.$map_t..^^u4.^^bool(SP#s, Q#i$1^49.107#tc1) ==> Q#i$1^49.107#tc1 < SP#n));

axiom $function_arg_type(cf#upper_card, 0, ^^bool);

axiom $function_arg_type(cf#upper_card, 1, $map_t(^^u4, ^^bool));

axiom $function_arg_type(cf#upper_card, 2, ^^mathint);

procedure upper_card(SP#s: $map_t..^^u4.^^bool, SP#n: int) returns ($result: bool);
  ensures $result == (forall Q#i$1^49.107#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^bool(SP#s, Q#i$1^49.107#tc1) } $in_range_u4(Q#i$1^49.107#tc1) ==> $select.$map_t..^^u4.^^bool(SP#s, Q#i$1^49.107#tc1) ==> Q#i$1^49.107#tc1 < SP#n);
  free ensures $result == F#upper_card(SP#s, SP#n);
  free ensures $call_transition(old($s), $s);



procedure init(P#a: $ptr);
  modifies $s, $cev_pc;
  ensures $in_domain_lab($s, $phys_ptr_cast(P#a, ^Array), $phys_ptr_cast(P#a, ^Array), l#public) && $wrapped($s, $phys_ptr_cast(P#a, ^Array), ^Array);
  ensures (forall Q#i$1^72.27#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, Array.ab, $phys_ptr_cast(P#a, ^Array))), Q#i$1^72.27#tc1) } $in_range_u4(Q#i$1^72.27#tc1) ==> $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, Array.ab, $phys_ptr_cast(P#a, ^Array))), Q#i$1^72.27#tc1) == 0);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: $set_in(#p, $span($phys_ptr_cast(P#a, ^Array)))));
  free ensures $call_transition(old($s), $s);



implementation init(P#a: $ptr)
{
  var owns#20: $ptrset;
  var staticWrapState#19: $state;
  var prestate#21: $state;
  var res_empty#11: $map_t..^^u4.^^bool;
  var res_lambda#8#10: $map_t..^^u4.^^i4;
  var #wrTime$1^69.1: int;
  var #stackframe: int;

  anon7:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^69.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^69.1, #loc.a, $ptr_to_int(P#a), $ptr_to(^Array));
    assume #wrTime$1^69.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^69.1, (lambda #p: $ptr :: $set_in(#p, $span($phys_ptr_cast(P#a, ^Array)))));
    assume $mutable($s, $phys_ptr_cast(P#a, ^Array));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @prim_writes_check((a->sz)); 
    assert $writable_prim($s, #wrTime$1^69.1, $dot($phys_ptr_cast(P#a, ^Array), Array.sz));
    // *(a->sz) := 0; 
    call $write_int(Array.sz, $phys_ptr_cast(P#a, ^Array), 0);
    assume $full_stop_ext(#tok$1^74.3, $s);
    // (uint32_t -> int32_t) res_lambda#8#10; 
    assume $local_value_is($s, #tok$1^76.13, #loc.res_lambda#8#10, $map_t..^^u4.^^i4_to_int(res_lambda#8#10), $map_t(^^u4, ^^i4));
    // res_lambda#8#10 := lambda#8(); 
    call res_lambda#8#10 := lambda#8();
    assume $full_stop_ext(#tok$1^76.13, $s);
    assume $local_value_is($s, #tok$1^76.13, #loc.res_lambda#8#10, $map_t..^^u4.^^i4_to_int(res_lambda#8#10), $map_t(^^u4, ^^i4));
    // assert @prim_writes_check((a->ab)); 
    assert $writable_prim($s, #wrTime$1^69.1, $dot($phys_ptr_cast(P#a, ^Array), Array.ab));
    // *(a->ab) := res_lambda#8#10; 
    call $write_int(Array.ab, $phys_ptr_cast(P#a, ^Array), $map_t..^^u4.^^i4_to_int(res_lambda#8#10));
    assume $full_stop_ext(#tok$1^76.5, $s);
    // (uint32_t -> _Bool) res_empty#11; 
    assume $local_value_is($s, #tok$1^77.17, #loc.res_empty#11, $map_t..^^u4.^^bool_to_int(res_empty#11), $map_t(^^u4, ^^bool));
    // res_empty#11 := empty(); 
    call res_empty#11 := empty();
    assume $full_stop_ext(#tok$1^77.17, $s);
    assume $local_value_is($s, #tok$1^77.17, #loc.res_empty#11, $map_t..^^u4.^^bool_to_int(res_empty#11), $map_t(^^u4, ^^bool));
    // assert @prim_writes_check((a->mapped)); 
    assert $writable_prim($s, #wrTime$1^69.1, $dot($phys_ptr_cast(P#a, ^Array), Array.mapped));
    // *(a->mapped) := res_empty#11; 
    call $write_int(Array.mapped, $phys_ptr_cast(P#a, ^Array), $map_t..^^u4.^^bool_to_int(res_empty#11));
    assume $full_stop_ext(#tok$1^77.5, $s);
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
    // assert @writes_check(a); 
    assert $top_writable($s, #wrTime$1^69.1, $phys_ptr_cast(P#a, ^Array));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(a), staticWrapState#19, owns#20)
    call $static_wrap($phys_ptr_cast(P#a, ^Array), staticWrapState#19, owns#20);
    assume $good_state_ext(#tok$1^79.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, a), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(P#a, ^Array)), $set_empty());
    // assert @inv_check(<=(*((a->sz)), 1000)); 
    assert $rd_inv($s, Array.sz, $phys_ptr_cast(P#a, ^Array)) <= 1000;
    // assert @inv_check(forall(uint32_t i; @in_range_u4(i); ==(@map_get(*((a->mapped)), i), &&(&&(<(i, 1000), <(*((a->idx)[i]), *((a->sz)))), ==(*((a->back)[*((a->idx)[i])]), i))))); 
    assert (forall Q#i$1^64.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^bool($int_to_map_t..^^u4.^^bool($rd_inv($s, Array.mapped, $phys_ptr_cast(P#a, ^Array))), Q#i$1^64.29#tc1) } $in_range_u4(Q#i$1^64.29#tc1) ==> $select.$map_t..^^u4.^^bool($int_to_map_t..^^u4.^^bool($rd_inv($s, Array.mapped, $phys_ptr_cast(P#a, ^Array))), Q#i$1^64.29#tc1) == (Q#i$1^64.29#tc1 < 1000 && $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), Q#i$1^64.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), Q#i$1^64.29#tc1))) < $rd_inv($s, Array.sz, $phys_ptr_cast(P#a, ^Array)) && $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.back), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), Q#i$1^64.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), Q#i$1^64.29#tc1))))), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.back), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), Q#i$1^64.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), Q#i$1^64.29#tc1)))))) == Q#i$1^64.29#tc1));
    // assert @inv_check(forall(uint32_t i; @in_range_u4(i); ==>(<(i, 1000), ==(@map_get(*((a->ab)), i), @ite(@map_get(*((a->mapped)), i), *((a->val)[i]), 0))))); 
    assert (forall Q#i$1^65.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, Array.ab, $phys_ptr_cast(P#a, ^Array))), Q#i$1^65.29#tc1) } { $select.$map_t..^^u4.^^bool($int_to_map_t..^^u4.^^bool($rd_inv($s, Array.mapped, $phys_ptr_cast(P#a, ^Array))), Q#i$1^65.29#tc1) } $in_range_u4(Q#i$1^65.29#tc1) ==> Q#i$1^65.29#tc1 < 1000 ==> $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, Array.ab, $phys_ptr_cast(P#a, ^Array))), Q#i$1^65.29#tc1) == (if $select.$map_t..^^u4.^^bool($int_to_map_t..^^u4.^^bool($rd_inv($s, Array.mapped, $phys_ptr_cast(P#a, ^Array))), Q#i$1^65.29#tc1) then $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.val), Q#i$1^65.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.val), Q#i$1^65.29#tc1))) else 0));
    // assert @inv_check(==(card(*((a->mapped))), *((a->sz)))); 
    assert F#card($int_to_map_t..^^u4.^^bool($rd_inv($s, Array.mapped, $phys_ptr_cast(P#a, ^Array)))) == $rd_inv($s, Array.sz, $phys_ptr_cast(P#a, ^Array));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure set(P#a: $ptr, P#i: int, P#v: int);
  requires P#i < 1000;
  requires $in_domain_lab($s, $phys_ptr_cast(P#a, ^Array), $phys_ptr_cast(P#a, ^Array), l#public);
  requires $wrapped($s, $phys_ptr_cast(P#a, ^Array), ^Array);
  modifies $s, $cev_pc;
  ensures $eq.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, Array.ab, $phys_ptr_cast(P#a, ^Array))), F#lambda#9($int_to_map_t..^^u4.^^i4($rd_inv(old($s), Array.ab, $phys_ptr_cast(P#a, ^Array))), P#v, P#i));
  ensures $in_domain_lab($s, $phys_ptr_cast(P#a, ^Array), $phys_ptr_cast(P#a, ^Array), l#public) && $wrapped($s, $phys_ptr_cast(P#a, ^Array), ^Array);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#a, ^Array)));
  free ensures $call_transition(old($s), $s);



implementation set(P#a: $ptr, P#i: int, P#v: int)
{
  var owns#26: $ptrset;
  var staticWrapState#25: $state;
  var prestate#27: $state;
  var L#__temp25974: int where $in_range_u4(L#__temp25974);
  var res_addone#12: $map_t..^^u4.^^bool;
  var ite#1: bool;
  var prestate#24: $state;
  var prestate#22: $state;
  var owns#23: $ptrset;
  var #wrTime$1^82.1: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^82.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^82.1, #loc.a, $ptr_to_int(P#a), $ptr_to(^Array));
    assume $local_value_is($s, #tok$1^82.1, #loc.i, P#i, ^^u4);
    assume $local_value_is($s, #tok$1^82.1, #loc.v, P#v, ^^i4);
    assume #wrTime$1^82.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^82.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#a, ^Array)));
    assume $thread_owned($s, $phys_ptr_cast(P#a, ^Array));
    // assume true; 
    assume true;
    // assume @in_range_u4(i); 
    assume $in_range_u4(P#i);
    // assume @in_range_i4(v); 
    assume $in_range_i4(P#v);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, a, a); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#a, ^Array), $phys_ptr_cast(P#a, ^Array), l#public);
    // _math ptrset owns#23; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#23, $ptrset_to_int(owns#23), ^$#ptrset);
    // owns#23 := @_vcc_set_empty; 
    owns#23 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#23, $ptrset_to_int(owns#23), ^$#ptrset);
    // _math state_t prestate#22; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#22, $state_to_int(prestate#22), ^$#state_t);
    // prestate#22 := @_vcc_current_state(@state); 
    prestate#22 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#22, $state_to_int(prestate#22), ^$#state_t);
    // _math state_t prestate#24; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#24, $state_to_int(prestate#24), ^$#state_t);
    // prestate#24 := @_vcc_current_state(@state); 
    prestate#24 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#24, $state_to_int(prestate#24), ^$#state_t);
    // assert @_vcc_wrapped(@state, a); 
    assert $wrapped($s, $phys_ptr_cast(P#a, ^Array), ^Array);
    // assert @writes_check(a); 
    assert $top_writable($s, #wrTime$1^82.1, $phys_ptr_cast(P#a, ^Array));
    // assume @_vcc_inv(@state, a); 
    assume $inv($s, $phys_ptr_cast(P#a, ^Array), ^Array);
    // assume ==(owns#23, @_vcc_owns(@state, a)); 
    assume owns#23 == $owns($s, $phys_ptr_cast(P#a, ^Array));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(a), prestate#24)
    call $static_unwrap($phys_ptr_cast(P#a, ^Array), prestate#24);
    assume $good_state_ext(#tok$1^88.30, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((a->ab)); 
    assert $writable_prim($s, #wrTime$1^82.1, $dot($phys_ptr_cast(P#a, ^Array), Array.ab));
    // assert @reads_check_normal((a->ab)); 
    assert $thread_local($s, $phys_ptr_cast(P#a, ^Array));
    // *(a->ab) := @map_updated(*((a->ab)), i, v); 
    call $write_int(Array.ab, $phys_ptr_cast(P#a, ^Array), $map_t..^^u4.^^i4_to_int($store.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, Array.ab, $phys_ptr_cast(P#a, ^Array))), P#i, P#v)));
    assume $full_stop_ext(#tok$1^89.27, $s);
    // assert @prim_writes_check((a->val)[i]); 
    assert $writable_prim($s, #wrTime$1^82.1, $idx($dot($phys_ptr_cast(P#a, ^Array), Array.val), P#i));
    // *(a->val)[i] := v; 
    call $write_int($field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.val), P#i)), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.val), P#i)), P#v);
    assume $full_stop_ext(#tok$1^90.5, $s);
    // _Bool ite#1; 
    assume $local_value_is($s, #tok$1^91.11, #loc.ite#1, $bool_to_int(ite#1), ^^bool);
    // assert @reads_check_normal((a->idx)[i]); 
    assert $thread_local($s, $idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), P#i));
    // assert @reads_check_normal((a->sz)); 
    assert $thread_local($s, $phys_ptr_cast(P#a, ^Array));
    assume true;
    // if (<(*((a->idx)[i]), *((a->sz)))) ...
    if ($rd_inv($s, $field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), P#i)), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), P#i))) < $rd_inv($s, Array.sz, $phys_ptr_cast(P#a, ^Array)))
    {
      anon8:
        // assert @reads_check_normal((a->back)[*((a->idx)[i])]); 
        assert $thread_local($s, $idx($dot($phys_ptr_cast(P#a, ^Array), Array.back), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), P#i)), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), P#i)))));
        // assert @reads_check_normal((a->idx)[i]); 
        assert $thread_local($s, $idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), P#i));
        // ite#1 := ==(*((a->back)[*((a->idx)[i])]), i); 
        ite#1 := $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.back), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), P#i)), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), P#i))))), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.back), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), P#i)), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), P#i)))))) == P#i;
        assume $local_value_is($s, #tok$1^91.11, #loc.ite#1, $bool_to_int(ite#1), ^^bool);
    }
    else
    {
      anon9:
        // ite#1 := false; 
        ite#1 := false;
        assume $local_value_is($s, #tok$1^91.11, #loc.ite#1, $bool_to_int(ite#1), ^^bool);
    }

  anon13:
    assume true;
    // if (unchecked!(ite#1)) ...
    if (!ite#1)
    {
      anon10:
        // (uint32_t -> _Bool) res_addone#12; 
        assume $local_value_is($s, #tok$1^92.41, #loc.res_addone#12, $map_t..^^u4.^^bool_to_int(res_addone#12), $map_t(^^u4, ^^bool));
        // assert @reads_check_normal((a->mapped)); 
        assert $thread_local($s, $phys_ptr_cast(P#a, ^Array));
        // res_addone#12 := addone(*((a->mapped)), i); 
        call res_addone#12 := addone($int_to_map_t..^^u4.^^bool($rd_inv($s, Array.mapped, $phys_ptr_cast(P#a, ^Array))), P#i);
        assume $full_stop_ext(#tok$1^92.41, $s);
        assume $local_value_is($s, #tok$1^92.41, #loc.res_addone#12, $map_t..^^u4.^^bool_to_int(res_addone#12), $map_t(^^u4, ^^bool));
        // assert @prim_writes_check((a->mapped)); 
        assert $writable_prim($s, #wrTime$1^82.1, $dot($phys_ptr_cast(P#a, ^Array), Array.mapped));
        // *(a->mapped) := res_addone#12; 
        call $write_int(Array.mapped, $phys_ptr_cast(P#a, ^Array), $map_t..^^u4.^^bool_to_int(res_addone#12));
        assume $full_stop_ext(#tok$1^92.29, $s);
        // assert upper_card(*((a->mapped)), 1000); 
        assert F#upper_card($int_to_map_t..^^u4.^^bool($rd_inv($s, Array.mapped, $phys_ptr_cast(P#a, ^Array))), 1000);
        // assume upper_card(*((a->mapped)), 1000); 
        assume F#upper_card($int_to_map_t..^^u4.^^bool($rd_inv($s, Array.mapped, $phys_ptr_cast(P#a, ^Array))), 1000);
        // assert @prim_writes_check((a->idx)[i]); 
        assert $writable_prim($s, #wrTime$1^82.1, $idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), P#i));
        // assert @reads_check_normal((a->sz)); 
        assert $thread_local($s, $phys_ptr_cast(P#a, ^Array));
        // *(a->idx)[i] := *((a->sz)); 
        call $write_int($field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), P#i)), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), P#i)), $rd_inv($s, Array.sz, $phys_ptr_cast(P#a, ^Array)));
        assume $full_stop_ext(#tok$1^94.7, $s);
        // uint32_t __temp25974; 
        assume $local_value_is($s, #tok$1^95.15, #loc.__temp25974, L#__temp25974, ^^u4);
        // assert @reads_check_normal((a->sz)); 
        assert $thread_local($s, $phys_ptr_cast(P#a, ^Array));
        // __temp25974 := *((a->sz)); 
        L#__temp25974 := $rd_inv($s, Array.sz, $phys_ptr_cast(P#a, ^Array));
        assume $local_value_is($s, #tok$1^95.15, #loc.__temp25974, L#__temp25974, ^^u4);
        // assert @prim_writes_check((a->sz)); 
        assert $writable_prim($s, #wrTime$1^82.1, $dot($phys_ptr_cast(P#a, ^Array), Array.sz));
        // assert @in_range_u4(+(__temp25974, 1)); 
        assert $in_range_u4(L#__temp25974 + 1);
        // *(a->sz) := +(__temp25974, 1); 
        call $write_int(Array.sz, $phys_ptr_cast(P#a, ^Array), L#__temp25974 + 1);
        assume $full_stop_ext(#tok$1^95.15, $s);
        // assert @prim_writes_check((a->back)[__temp25974]); 
        assert $writable_prim($s, #wrTime$1^82.1, $idx($dot($phys_ptr_cast(P#a, ^Array), Array.back), L#__temp25974));
        // *(a->back)[__temp25974] := i; 
        call $write_int($field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.back), L#__temp25974)), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.back), L#__temp25974)), P#i);
        assume $full_stop_ext(#tok$1^95.7, $s);
    }
    else
    {
      anon11:
        // empty
    }

  anon14:
    // _math state_t prestate#27; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
    // prestate#27 := @_vcc_current_state(@state); 
    prestate#27 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
    // _math state_t staticWrapState#25; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#25, $state_to_int(staticWrapState#25), ^$#state_t);
    // staticWrapState#25 := @_vcc_current_state(@state); 
    staticWrapState#25 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#25, $state_to_int(staticWrapState#25), ^$#state_t);
    // _math ptrset owns#26; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#26, $ptrset_to_int(owns#26), ^$#ptrset);
    // owns#26 := @_vcc_set_empty; 
    owns#26 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#26, $ptrset_to_int(owns#26), ^$#ptrset);
    // assert @writes_check(a); 
    assert $top_writable($s, #wrTime$1^82.1, $phys_ptr_cast(P#a, ^Array));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(a), staticWrapState#25, owns#26)
    call $static_wrap($phys_ptr_cast(P#a, ^Array), staticWrapState#25, owns#26);
    assume $good_state_ext(#tok$1^88.30, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, a), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(P#a, ^Array)), $set_empty());
    // assert @inv_check(<=(*((a->sz)), 1000)); 
    assert $rd_inv($s, Array.sz, $phys_ptr_cast(P#a, ^Array)) <= 1000;
    // assert @inv_check(forall(uint32_t i; @in_range_u4(i); ==(@map_get(*((a->mapped)), i), &&(&&(<(i, 1000), <(*((a->idx)[i]), *((a->sz)))), ==(*((a->back)[*((a->idx)[i])]), i))))); 
    assert (forall Q#i$1^64.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^bool($int_to_map_t..^^u4.^^bool($rd_inv($s, Array.mapped, $phys_ptr_cast(P#a, ^Array))), Q#i$1^64.29#tc1) } $in_range_u4(Q#i$1^64.29#tc1) ==> $select.$map_t..^^u4.^^bool($int_to_map_t..^^u4.^^bool($rd_inv($s, Array.mapped, $phys_ptr_cast(P#a, ^Array))), Q#i$1^64.29#tc1) == (Q#i$1^64.29#tc1 < 1000 && $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), Q#i$1^64.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), Q#i$1^64.29#tc1))) < $rd_inv($s, Array.sz, $phys_ptr_cast(P#a, ^Array)) && $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.back), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), Q#i$1^64.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), Q#i$1^64.29#tc1))))), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.back), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), Q#i$1^64.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), Q#i$1^64.29#tc1)))))) == Q#i$1^64.29#tc1));
    // assert @inv_check(forall(uint32_t i; @in_range_u4(i); ==>(<(i, 1000), ==(@map_get(*((a->ab)), i), @ite(@map_get(*((a->mapped)), i), *((a->val)[i]), 0))))); 
    assert (forall Q#i$1^65.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, Array.ab, $phys_ptr_cast(P#a, ^Array))), Q#i$1^65.29#tc1) } { $select.$map_t..^^u4.^^bool($int_to_map_t..^^u4.^^bool($rd_inv($s, Array.mapped, $phys_ptr_cast(P#a, ^Array))), Q#i$1^65.29#tc1) } $in_range_u4(Q#i$1^65.29#tc1) ==> Q#i$1^65.29#tc1 < 1000 ==> $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, Array.ab, $phys_ptr_cast(P#a, ^Array))), Q#i$1^65.29#tc1) == (if $select.$map_t..^^u4.^^bool($int_to_map_t..^^u4.^^bool($rd_inv($s, Array.mapped, $phys_ptr_cast(P#a, ^Array))), Q#i$1^65.29#tc1) then $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.val), Q#i$1^65.29#tc1)), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.val), Q#i$1^65.29#tc1))) else 0));
    // assert @inv_check(==(card(*((a->mapped))), *((a->sz)))); 
    assert F#card($int_to_map_t..^^u4.^^bool($rd_inv($s, Array.mapped, $phys_ptr_cast(P#a, ^Array)))) == $rd_inv($s, Array.sz, $phys_ptr_cast(P#a, ^Array));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure get(P#a: $ptr, P#i: int) returns ($result: int);
  requires P#i < 1000;
  requires $wrapped($s, $phys_ptr_cast(P#a, ^Array), ^Array);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  ensures $result == $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, Array.ab, $phys_ptr_cast(P#a, ^Array))), P#i);
  ensures $wrapped($s, $phys_ptr_cast(P#a, ^Array), ^Array);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation get(P#a: $ptr, P#i: int) returns ($result: int)
{
  var ite#2: bool;
  var #wrTime$1^100.1: int;
  var #stackframe: int;

  anon19:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^100.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^100.1, #loc.a, $ptr_to_int(P#a), $ptr_to(^Array));
    assume $local_value_is($s, #tok$1^100.1, #loc.i, P#i, ^^u4);
    assume #wrTime$1^100.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^100.1, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @in_range_u4(i); 
    assume $in_range_u4(P#i);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, a, a); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#a, ^Array), $phys_ptr_cast(P#a, ^Array), l#public);
    // _Bool ite#2; 
    assume $local_value_is($s, #tok$1^105.7, #loc.ite#2, $bool_to_int(ite#2), ^^bool);
    // assert @reads_check_normal((a->idx)[i]); 
    assert $thread_local($s, $idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), P#i));
    // assert @reads_check_normal((a->sz)); 
    assert $thread_local($s, $phys_ptr_cast(P#a, ^Array));
    assume true;
    // if (<(*((a->idx)[i]), *((a->sz)))) ...
    if ($rd_inv($s, $field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), P#i)), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), P#i))) < $rd_inv($s, Array.sz, $phys_ptr_cast(P#a, ^Array)))
    {
      anon15:
        // assert @reads_check_normal((a->back)[*((a->idx)[i])]); 
        assert $thread_local($s, $idx($dot($phys_ptr_cast(P#a, ^Array), Array.back), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), P#i)), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), P#i)))));
        // assert @reads_check_normal((a->idx)[i]); 
        assert $thread_local($s, $idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), P#i));
        // ite#2 := ==(*((a->back)[*((a->idx)[i])]), i); 
        ite#2 := $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.back), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), P#i)), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), P#i))))), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.back), $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), P#i)), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.idx), P#i)))))) == P#i;
        assume $local_value_is($s, #tok$1^105.7, #loc.ite#2, $bool_to_int(ite#2), ^^bool);
    }
    else
    {
      anon16:
        // ite#2 := false; 
        ite#2 := false;
        assume $local_value_is($s, #tok$1^105.7, #loc.ite#2, $bool_to_int(ite#2), ^^bool);
    }

  anon20:
    assume true;
    // if (ite#2) ...
    if (ite#2)
    {
      anon17:
        // assert @reads_check_normal((a->val)[i]); 
        assert $thread_local($s, $idx($dot($phys_ptr_cast(P#a, ^Array), Array.val), P#i));
        // return *((a->val)[i]); 
        $result := $rd_inv($s, $field($idx($dot($phys_ptr_cast(P#a, ^Array), Array.val), P#i)), $emb0($idx($dot($phys_ptr_cast(P#a, ^Array), Array.val), P#i)));
        assert $position_marker();
        goto #exit;
    }
    else
    {
      anon18:
        // return 0; 
        $result := 0;
        assert $position_marker();
        goto #exit;
    }

  anon21:
    // empty

  #exit:
}



procedure sparseArrayTestHarness();
  modifies $s, $cev_pc;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation sparseArrayTestHarness()
{
  var prestate#33: $state;
  var prestate#31: $state;
  var owns#32: $ptrset;
  var prestate#30: $state;
  var prestate#28: $state;
  var owns#29: $ptrset;
  var res_get#18: int where $in_range_i4(res_get#18);
  var res_get#17: int where $in_range_i4(res_get#17);
  var ite#5: bool;
  var tmp#1: bool;
  var res_get#16: int where $in_range_i4(res_get#16);
  var res_get#15: int where $in_range_i4(res_get#15);
  var ite#4: bool;
  var tmp#0: bool;
  var res_get#14: int where $in_range_i4(res_get#14);
  var res_get#13: int where $in_range_i4(res_get#13);
  var ite#3: bool;
  var L#tmp: bool;
  var addr.a: $ptr;
  var addr.b: $ptr;
  var #wrTime$1^110.1: int;
  var #stackframe: int;

  anon28:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^110.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^110.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^110.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // struct Array* addr.b; 
    assume $local_value_is($s, #tok$1^110.1, #loc.addr.b, $ptr_to_int(addr.b), $ptr_to(^Array));
    // addr.b := _vcc_stack_alloc<struct Array>(@stackframe, false); 
    call addr.b := $stack_alloc(^Array, #stackframe, false);
    assume $full_stop_ext(#tok$1^110.1, $s);
    assume $local_value_is($s, #tok$1^110.1, #loc.addr.b, $ptr_to_int(addr.b), $ptr_to(^Array));
    // struct Array* addr.a; 
    assume $local_value_is($s, #tok$1^110.1, #loc.addr.a, $ptr_to_int(addr.a), $ptr_to(^Array));
    // addr.a := _vcc_stack_alloc<struct Array>(@stackframe, false); 
    call addr.a := $stack_alloc(^Array, #stackframe, false);
    assume $full_stop_ext(#tok$1^110.1, $s);
    assume $local_value_is($s, #tok$1^110.1, #loc.addr.a, $ptr_to_int(addr.a), $ptr_to(^Array));
    // var struct Array a
    // var struct Array b
    // assert @writes_check(@_vcc_span(addr.a)); 
    assert (forall #writes$1^114.3: $ptr :: { $dont_instantiate(#writes$1^114.3) } $set_in(#writes$1^114.3, $span($phys_ptr_cast(addr.a, ^Array))) ==> $top_writable($s, #wrTime$1^110.1, #writes$1^114.3));
    // stmt init(addr.a); 
    call init($phys_ptr_cast(addr.a, ^Array));
    assume $full_stop_ext(#tok$1^114.3, $s);
    // assert @writes_check(@_vcc_span(addr.b)); 
    assert (forall #writes$1^115.3: $ptr :: { $dont_instantiate(#writes$1^115.3) } $set_in(#writes$1^115.3, $span($phys_ptr_cast(addr.b, ^Array))) ==> $top_writable($s, #wrTime$1^110.1, #writes$1^115.3));
    // stmt init(addr.b); 
    call init($phys_ptr_cast(addr.b, ^Array));
    assume $full_stop_ext(#tok$1^115.3, $s);
    // _Bool tmp; 
    assume $local_value_is($s, #tok$1^116.5, #loc.tmp, $bool_to_int(L#tmp), ^^bool);
    // _Bool ite#3; 
    assume $local_value_is($s, #tok$1^116.16, #loc.ite#3, $bool_to_int(ite#3), ^^bool);
    // int32_t res_get#13; 
    assume $local_value_is($s, #tok$1^116.16, #loc.res_get#13, res_get#13, ^^i4);
    // res_get#13 := get(addr.a, 5); 
    call res_get#13 := get($phys_ptr_cast(addr.a, ^Array), 5);
    assume $full_stop_ext(#tok$1^116.16, $s);
    assume $local_value_is($s, #tok$1^116.16, #loc.res_get#13, res_get#13, ^^i4);
    assume true;
    // if (==(res_get#13, 0)) ...
    if (res_get#13 == 0)
    {
      anon22:
        // int32_t res_get#14; 
        assume $local_value_is($s, #tok$1^116.35, #loc.res_get#14, res_get#14, ^^i4);
        // res_get#14 := get(addr.b, 7); 
        call res_get#14 := get($phys_ptr_cast(addr.b, ^Array), 7);
        assume $full_stop_ext(#tok$1^116.35, $s);
        assume $local_value_is($s, #tok$1^116.35, #loc.res_get#14, res_get#14, ^^i4);
        // ite#3 := ==(res_get#14, 0); 
        ite#3 := res_get#14 == 0;
        assume $local_value_is($s, #tok$1^116.16, #loc.ite#3, $bool_to_int(ite#3), ^^bool);
    }
    else
    {
      anon23:
        // ite#3 := false; 
        ite#3 := false;
        assume $local_value_is($s, #tok$1^116.16, #loc.ite#3, $bool_to_int(ite#3), ^^bool);
    }

  anon29:
    // tmp := ite#3; 
    L#tmp := ite#3;
    assume $local_value_is($s, #tok$1^116.5, #loc.tmp, $bool_to_int(L#tmp), ^^bool);
    // assert tmp; 
    assert L#tmp;
    // assume tmp; 
    assume L#tmp;
    // empty
    // assert @writes_check(addr.a); 
    assert $top_writable($s, #wrTime$1^110.1, $phys_ptr_cast(addr.a, ^Array));
    // stmt set(addr.a, 5, 1); 
    call set($phys_ptr_cast(addr.a, ^Array), 5, 1);
    assume $full_stop_ext(#tok$1^117.3, $s);
    // assert @writes_check(addr.b); 
    assert $top_writable($s, #wrTime$1^110.1, $phys_ptr_cast(addr.b, ^Array));
    // stmt set(addr.b, 7, 2); 
    call set($phys_ptr_cast(addr.b, ^Array), 7, 2);
    assume $full_stop_ext(#tok$1^117.18, $s);
    // _Bool tmp#0; 
    assume $local_value_is($s, #tok$1^118.5, #loc.tmp#0, $bool_to_int(tmp#0), ^^bool);
    // _Bool ite#4; 
    assume $local_value_is($s, #tok$1^118.16, #loc.ite#4, $bool_to_int(ite#4), ^^bool);
    // int32_t res_get#15; 
    assume $local_value_is($s, #tok$1^118.16, #loc.res_get#15, res_get#15, ^^i4);
    // res_get#15 := get(addr.a, 5); 
    call res_get#15 := get($phys_ptr_cast(addr.a, ^Array), 5);
    assume $full_stop_ext(#tok$1^118.16, $s);
    assume $local_value_is($s, #tok$1^118.16, #loc.res_get#15, res_get#15, ^^i4);
    assume true;
    // if (==(res_get#15, 1)) ...
    if (res_get#15 == 1)
    {
      anon24:
        // int32_t res_get#16; 
        assume $local_value_is($s, #tok$1^118.35, #loc.res_get#16, res_get#16, ^^i4);
        // res_get#16 := get(addr.b, 7); 
        call res_get#16 := get($phys_ptr_cast(addr.b, ^Array), 7);
        assume $full_stop_ext(#tok$1^118.35, $s);
        assume $local_value_is($s, #tok$1^118.35, #loc.res_get#16, res_get#16, ^^i4);
        // ite#4 := ==(res_get#16, 2); 
        ite#4 := res_get#16 == 2;
        assume $local_value_is($s, #tok$1^118.16, #loc.ite#4, $bool_to_int(ite#4), ^^bool);
    }
    else
    {
      anon25:
        // ite#4 := false; 
        ite#4 := false;
        assume $local_value_is($s, #tok$1^118.16, #loc.ite#4, $bool_to_int(ite#4), ^^bool);
    }

  anon30:
    // tmp#0 := ite#4; 
    tmp#0 := ite#4;
    assume $local_value_is($s, #tok$1^118.5, #loc.tmp#0, $bool_to_int(tmp#0), ^^bool);
    // assert tmp#0; 
    assert tmp#0;
    // assume tmp#0; 
    assume tmp#0;
    // empty
    // _Bool tmp#1; 
    assume $local_value_is($s, #tok$1^119.5, #loc.tmp#1, $bool_to_int(tmp#1), ^^bool);
    // _Bool ite#5; 
    assume $local_value_is($s, #tok$1^119.16, #loc.ite#5, $bool_to_int(ite#5), ^^bool);
    // int32_t res_get#17; 
    assume $local_value_is($s, #tok$1^119.16, #loc.res_get#17, res_get#17, ^^i4);
    // res_get#17 := get(addr.a, 0); 
    call res_get#17 := get($phys_ptr_cast(addr.a, ^Array), 0);
    assume $full_stop_ext(#tok$1^119.16, $s);
    assume $local_value_is($s, #tok$1^119.16, #loc.res_get#17, res_get#17, ^^i4);
    assume true;
    // if (==(res_get#17, 0)) ...
    if (res_get#17 == 0)
    {
      anon26:
        // int32_t res_get#18; 
        assume $local_value_is($s, #tok$1^119.35, #loc.res_get#18, res_get#18, ^^i4);
        // res_get#18 := get(addr.b, 0); 
        call res_get#18 := get($phys_ptr_cast(addr.b, ^Array), 0);
        assume $full_stop_ext(#tok$1^119.35, $s);
        assume $local_value_is($s, #tok$1^119.35, #loc.res_get#18, res_get#18, ^^i4);
        // ite#5 := ==(res_get#18, 0); 
        ite#5 := res_get#18 == 0;
        assume $local_value_is($s, #tok$1^119.16, #loc.ite#5, $bool_to_int(ite#5), ^^bool);
    }
    else
    {
      anon27:
        // ite#5 := false; 
        ite#5 := false;
        assume $local_value_is($s, #tok$1^119.16, #loc.ite#5, $bool_to_int(ite#5), ^^bool);
    }

  anon31:
    // tmp#1 := ite#5; 
    tmp#1 := ite#5;
    assume $local_value_is($s, #tok$1^119.5, #loc.tmp#1, $bool_to_int(tmp#1), ^^bool);
    // assert tmp#1; 
    assert tmp#1;
    // assume tmp#1; 
    assume tmp#1;
    // empty
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
    // assert @_vcc_wrapped(@state, addr.a); 
    assert $wrapped($s, $phys_ptr_cast(addr.a, ^Array), ^Array);
    // assert @writes_check(addr.a); 
    assert $top_writable($s, #wrTime$1^110.1, $phys_ptr_cast(addr.a, ^Array));
    // assume @_vcc_inv(@state, addr.a); 
    assume $inv($s, $phys_ptr_cast(addr.a, ^Array), ^Array);
    // assume ==(owns#29, @_vcc_owns(@state, addr.a)); 
    assume owns#29 == $owns($s, $phys_ptr_cast(addr.a, ^Array));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(addr.a), prestate#30)
    call $static_unwrap($phys_ptr_cast(addr.a, ^Array), prestate#30);
    assume $good_state_ext(#tok$1^121.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
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
    // assert @_vcc_wrapped(@state, addr.b); 
    assert $wrapped($s, $phys_ptr_cast(addr.b, ^Array), ^Array);
    // assert @writes_check(addr.b); 
    assert $top_writable($s, #wrTime$1^110.1, $phys_ptr_cast(addr.b, ^Array));
    // assume @_vcc_inv(@state, addr.b); 
    assume $inv($s, $phys_ptr_cast(addr.b, ^Array), ^Array);
    // assume ==(owns#32, @_vcc_owns(@state, addr.b)); 
    assume owns#32 == $owns($s, $phys_ptr_cast(addr.b, ^Array));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(addr.b), prestate#33)
    call $static_unwrap($phys_ptr_cast(addr.b, ^Array), prestate#33);
    assume $good_state_ext(#tok$1^122.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // stmt _vcc_stack_free(@stackframe, addr.a); 
    call $stack_free(#stackframe, $phys_ptr_cast(addr.a, ^Array));
    assume $full_stop_ext(#tok$1^110.1, $s);
    // stmt _vcc_stack_free(@stackframe, addr.b); 
    call $stack_free(#stackframe, $phys_ptr_cast(addr.b, ^Array));
    assume $full_stop_ext(#tok$1^110.1, $s);
    // return; 
    assert $position_marker();
    goto #exit;

  anon32:
    // Block cleanup
    // stmt _vcc_stack_free(@stackframe, addr.a); 
    call $stack_free(#stackframe, $phys_ptr_cast(addr.a, ^Array));
    assume $full_stop_ext(#tok$1^110.1, $s);
    // stmt _vcc_stack_free(@stackframe, addr.b); 
    call $stack_free(#stackframe, $phys_ptr_cast(addr.b, ^Array));
    assume $full_stop_ext(#tok$1^110.1, $s);

  #exit:
}



axiom F#card(F#empty()) == 0;

axiom (forall Q#s$1^47.23#dt1: $map_t..^^u4.^^bool, Q#i$1^47.23#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^bool(Q#s$1^47.23#dt1, Q#i$1^47.23#tc1) } { F#addone(Q#s$1^47.23#dt1, Q#i$1^47.23#tc1) } $in_range_u4(Q#i$1^47.23#tc1) ==> F#card(Q#s$1^47.23#dt1) >= 0 && !$select.$map_t..^^u4.^^bool(Q#s$1^47.23#dt1, Q#i$1^47.23#tc1) ==> F#card(F#addone(Q#s$1^47.23#dt1, Q#i$1^47.23#tc1)) == F#card(Q#s$1^47.23#dt1) + 1);

axiom (forall Q#s$1^50.23#dt1: $map_t..^^u4.^^bool, Q#n$1^50.23#tc3: int :: {:weight 10} { F#upper_card(Q#s$1^50.23#dt1, Q#n$1^50.23#tc3) } F#upper_card(Q#s$1^50.23#dt1, Q#n$1^50.23#tc3) ==> F#card(Q#s$1^50.23#dt1) <= Q#n$1^50.23#tc3);

function F#lambda#9(#l2: $map_t..^^u4.^^i4, #l1: int, #l0: int) : $map_t..^^u4.^^i4;

const unique cf#lambda#9: $pure_function;

axiom $function_arg_type(cf#lambda#9, 0, $map_t(^^u4, ^^i4));

axiom $function_arg_type(cf#lambda#9, 1, $map_t(^^u4, ^^i4));

axiom $function_arg_type(cf#lambda#9, 2, ^^i4);

axiom $function_arg_type(cf#lambda#9, 3, ^^u4);

procedure lambda#9(#l2: $map_t..^^u4.^^i4, #l1: int, #l0: int) returns ($result: $map_t..^^u4.^^i4);
  free ensures $result == F#lambda#9(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#j$1^86.36#tc1: int, #l2: $map_t..^^u4.^^i4, #l1: int, #l0: int :: {:weight 10} { $select.$map_t..^^u4.^^i4(F#lambda#9(#l2, #l1, #l0), Q#j$1^86.36#tc1) } $in_range_u4(Q#j$1^86.36#tc1) && $in_range_i4(#l1) && $in_range_u4(#l0) ==> $select.$map_t..^^u4.^^i4(F#lambda#9(#l2, #l1, #l0), Q#j$1^86.36#tc1) == (if #l0 == Q#j$1^86.36#tc1 then #l1 else $select.$map_t..^^u4.^^i4(#l2, Q#j$1^86.36#tc1)));

function F#lambda#8() : $map_t..^^u4.^^i4;

const unique cf#lambda#8: $pure_function;

axiom $function_arg_type(cf#lambda#8, 0, $map_t(^^u4, ^^i4));

procedure lambda#8() returns ($result: $map_t..^^u4.^^i4);
  free ensures $result == F#lambda#8();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^76.13#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^i4(F#lambda#8(), Q#i$1^76.13#tc1) } $in_range_u4(Q#i$1^76.13#tc1) ==> $select.$map_t..^^u4.^^i4(F#lambda#8(), Q#i$1^76.13#tc1) == 0);

function F#lambda#7(#l1: $map_t..^^u4.^^bool, #l0: int) : $map_t..^^u4.^^bool;

const unique cf#lambda#7: $pure_function;

axiom $function_arg_type(cf#lambda#7, 0, $map_t(^^u4, ^^bool));

axiom $function_arg_type(cf#lambda#7, 1, $map_t(^^u4, ^^bool));

axiom $function_arg_type(cf#lambda#7, 2, ^^u4);

procedure lambda#7(#l1: $map_t..^^u4.^^bool, #l0: int) returns ($result: $map_t..^^u4.^^bool);
  free ensures $result == F#lambda#7(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#j$1^44.27#tc1: int, #l1: $map_t..^^u4.^^bool, #l0: int :: {:weight 10} { $select.$map_t..^^u4.^^bool(F#lambda#7(#l1, #l0), Q#j$1^44.27#tc1) } $in_range_u4(Q#j$1^44.27#tc1) && $in_range_u4(#l0) ==> $select.$map_t..^^u4.^^bool(F#lambda#7(#l1, #l0), Q#j$1^44.27#tc1) == (#l0 == Q#j$1^44.27#tc1 || $select.$map_t..^^u4.^^bool(#l1, Q#j$1^44.27#tc1)));

function F#lambda#6() : $map_t..^^u4.^^bool;

const unique cf#lambda#6: $pure_function;

axiom $function_arg_type(cf#lambda#6, 0, $map_t(^^u4, ^^bool));

procedure lambda#6() returns ($result: $map_t..^^u4.^^bool);
  free ensures $result == F#lambda#6();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^42.26#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^bool(F#lambda#6(), Q#i$1^42.26#tc1) } $in_range_u4(Q#i$1^42.26#tc1) ==> $select.$map_t..^^u4.^^bool(F#lambda#6(), Q#i$1^42.26#tc1) == false);

const unique l#public: $label;

type $map_t..^^u4.^^bool;

function $select.$map_t..^^u4.^^bool(M: $map_t..^^u4.^^bool, p: int) : bool;

function $store.$map_t..^^u4.^^bool(M: $map_t..^^u4.^^bool, p: int, v: bool) : $map_t..^^u4.^^bool;

function $eq.$map_t..^^u4.^^bool(M1: $map_t..^^u4.^^bool, M2: $map_t..^^u4.^^bool) : bool;

const $zero.$map_t..^^u4.^^bool: $map_t..^^u4.^^bool;

axiom (forall M: $map_t..^^u4.^^bool, p: int, v: bool :: true);

axiom (forall M: $map_t..^^u4.^^bool, p: int, v: bool, q: int :: $select.$map_t..^^u4.^^bool($store.$map_t..^^u4.^^bool(M, q, v), p) == (if $unchecked(^^u4, p) == $unchecked(^^u4, q) then v else $select.$map_t..^^u4.^^bool(M, p)));

axiom (forall M1: $map_t..^^u4.^^bool, M2: $map_t..^^u4.^^bool :: { $eq.$map_t..^^u4.^^bool(M1, M2) } (forall p: int :: $select.$map_t..^^u4.^^bool(M1, $unchecked(^^u4, p)) == $select.$map_t..^^u4.^^bool(M2, $unchecked(^^u4, p))) ==> $eq.$map_t..^^u4.^^bool(M1, M2));

axiom (forall M1: $map_t..^^u4.^^bool, M2: $map_t..^^u4.^^bool :: { $eq.$map_t..^^u4.^^bool(M1, M2) } $eq.$map_t..^^u4.^^bool(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^u4.^^bool(0) == $zero.$map_t..^^u4.^^bool;

axiom (forall p: int :: $select.$map_t..^^u4.^^bool($zero.$map_t..^^u4.^^bool, p) == false);

axiom true;

type $map_t..^^u4.^^i4;

function $select.$map_t..^^u4.^^i4(M: $map_t..^^u4.^^i4, p: int) : int;

function $store.$map_t..^^u4.^^i4(M: $map_t..^^u4.^^i4, p: int, v: int) : $map_t..^^u4.^^i4;

function $eq.$map_t..^^u4.^^i4(M1: $map_t..^^u4.^^i4, M2: $map_t..^^u4.^^i4) : bool;

const $zero.$map_t..^^u4.^^i4: $map_t..^^u4.^^i4;

axiom (forall M: $map_t..^^u4.^^i4, p: int, v: int :: true);

axiom (forall M: $map_t..^^u4.^^i4, p: int, v: int, q: int :: $select.$map_t..^^u4.^^i4($store.$map_t..^^u4.^^i4(M, q, v), p) == (if $unchecked(^^u4, p) == $unchecked(^^u4, q) then $unchecked(^^i4, v) else $select.$map_t..^^u4.^^i4(M, p)));

axiom (forall M1: $map_t..^^u4.^^i4, M2: $map_t..^^u4.^^i4 :: { $eq.$map_t..^^u4.^^i4(M1, M2) } (forall p: int :: $unchecked(^^i4, $select.$map_t..^^u4.^^i4(M1, $unchecked(^^u4, p))) == $unchecked(^^i4, $select.$map_t..^^u4.^^i4(M2, $unchecked(^^u4, p)))) ==> $eq.$map_t..^^u4.^^i4(M1, M2));

axiom (forall M1: $map_t..^^u4.^^i4, M2: $map_t..^^u4.^^i4 :: { $eq.$map_t..^^u4.^^i4(M1, M2) } $eq.$map_t..^^u4.^^i4(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^u4.^^i4(0) == $zero.$map_t..^^u4.^^i4;

axiom (forall p: int :: $select.$map_t..^^u4.^^i4($zero.$map_t..^^u4.^^i4, p) == 0);

axiom true;

axiom (forall M: $map_t..^^u4.^^i4, p: int :: $in_range_t(^^i4, $select.$map_t..^^u4.^^i4(M, p)));

const unique #tok$1^44.27: $token;

const unique #loc.#l0: $token;

const unique #loc.#l1: $token;

const unique #loc.#l2: $token;

const unique #tok$1^86.36: $token;

axiom $type_code_is(3, ^^mathint);

const unique #tok$1^122.19: $token;

const unique #loc.prestate#33: $token;

const unique #loc.prestate#31: $token;

const unique #loc.owns#32: $token;

const unique #tok$1^121.19: $token;

const unique #loc.prestate#30: $token;

const unique #loc.prestate#28: $token;

const unique #loc.owns#29: $token;

const unique #loc.res_get#18: $token;

const unique #tok$1^119.35: $token;

const unique #loc.res_get#17: $token;

const unique #loc.ite#5: $token;

const unique #tok$1^119.16: $token;

const unique #loc.tmp#1: $token;

const unique #tok$1^119.5: $token;

const unique #loc.res_get#16: $token;

const unique #tok$1^118.35: $token;

const unique #loc.res_get#15: $token;

const unique #loc.ite#4: $token;

const unique #tok$1^118.16: $token;

const unique #loc.tmp#0: $token;

const unique #tok$1^118.5: $token;

const unique #tok$1^117.18: $token;

const unique #tok$1^117.3: $token;

const unique #loc.res_get#14: $token;

const unique #tok$1^116.35: $token;

const unique #loc.res_get#13: $token;

const unique #loc.ite#3: $token;

const unique #tok$1^116.16: $token;

const unique #loc.tmp: $token;

const unique #tok$1^116.5: $token;

const unique #tok$1^115.3: $token;

const unique #tok$1^114.3: $token;

const unique #loc.addr.a: $token;

const unique #loc.addr.b: $token;

const unique #tok$1^110.1: $token;

const unique #loc.ite#2: $token;

const unique #tok$1^105.7: $token;

const unique #tok$1^100.1: $token;

const unique #loc.owns#26: $token;

const unique #loc.staticWrapState#25: $token;

const unique #loc.prestate#27: $token;

const unique #tok$1^95.7: $token;

const unique #loc.__temp25974: $token;

const unique #tok$1^95.15: $token;

const unique #tok$1^94.7: $token;

const unique #tok$1^92.29: $token;

const unique #loc.res_addone#12: $token;

const unique #tok$1^92.41: $token;

const unique #loc.ite#1: $token;

const unique #tok$1^91.11: $token;

const unique #tok$1^90.5: $token;

const unique #tok$1^89.27: $token;

const unique #tok$1^88.30: $token;

const unique #loc.prestate#24: $token;

const unique #loc.prestate#22: $token;

const unique #loc.owns#23: $token;

const unique #loc.v: $token;

const unique #tok$1^82.1: $token;

const unique #tok$1^79.19: $token;

const unique #loc.owns#20: $token;

const unique #loc.staticWrapState#19: $token;

function $state_to_int(x: $state) : int;

function $int_to_state(x: int) : $state;

axiom (forall #x: $state :: #x == $int_to_state($state_to_int(#x)));

const unique #loc.prestate#21: $token;

const unique #tok$2^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(2, #file^?3Cno?20file?3E);

const unique #tok$1^77.5: $token;

const unique #loc.res_empty#11: $token;

const unique #tok$1^77.17: $token;

const unique #tok$1^76.5: $token;

const unique #loc.res_lambda#8#10: $token;

const unique #tok$1^76.13: $token;

const unique #tok$1^74.3: $token;

const unique #loc.a: $token;

const unique #tok$1^69.1: $token;

const unique #loc.n: $token;

const unique #tok$1^49.39: $token;

const unique #loc.i: $token;

const unique #tok$1^43.39: $token;

const unique #loc.s: $token;

const unique #tok$1^40.39: $token;

const unique #distTp3: $ctype;

axiom #distTp3 == $ptr_to(^Array);

const unique #loc._this_: $token;

const unique #tok$1^54.1: $token;

function $map_t..^^u4.^^i4_to_int(x: $map_t..^^u4.^^i4) : int;

function $int_to_map_t..^^u4.^^i4(x: int) : $map_t..^^u4.^^i4;

axiom (forall #x: $map_t..^^u4.^^i4 :: #x == $int_to_map_t..^^u4.^^i4($map_t..^^u4.^^i4_to_int(#x)));

const unique #distTp2: $ctype;

axiom #distTp2 == $map_t(^^u4, ^^i4);

axiom $type_code_is(1, ^^u4);

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvacid?2D0?5CSparseArray.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvacid?2D0?5CSparseArray.c);

function $map_t..^^u4.^^bool_to_int(x: $map_t..^^u4.^^bool) : int;

function $int_to_map_t..^^u4.^^bool(x: int) : $map_t..^^u4.^^bool;

axiom (forall #x: $map_t..^^u4.^^bool :: #x == $int_to_map_t..^^u4.^^bool($map_t..^^u4.^^bool_to_int(#x)));

const unique #distTp1: $ctype;

axiom #distTp1 == $map_t(^^u4, ^^bool);
