axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

const unique ^List: $ctype;

axiom $is_span_sequential(^List);

axiom $def_struct_type(^List, 24, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^List) } $inv2(#s1, #s2, #p, ^List) == ($eq.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv(#s2, List.vals, #p)), F#lambda#1($int_to_map_t..^^u4.^^i4($rd_inv(#s2, List.vals, $rd_phys_ptr(#s2, List.tail, #p, ^List))), $rd_inv(#s2, List.head, #p), $rd_inv(#s2, List.length, #p))) && ($rd_inv(#s2, List.length, #p) == 0 || ($keeps(#s2, #p, $rd_phys_ptr(#s2, List.tail, #p, ^List)) && $rd_inv(#s2, List.length, #p) == $rd_inv(#s2, List.length, $rd_phys_ptr(#s2, List.tail, #p, ^List)) + 1))));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^List)) } $in(q, $composite_extent(s, p, ^List)) == (q == p));

const unique List.head: $field;

axiom $def_phys_field(^List, List.head, ^^i4, false, 0);

const unique List.tail: $field;

axiom $def_phys_field(^List, List.tail, $ptr_to(^List), false, 8);

const unique List.length: $field;

axiom $def_phys_field(^List, List.length, ^^u4, false, 16);

const unique List.vals: $field;

axiom $def_ghost_field(^List, List.vals, $map_t(^^u4, ^^i4), false);

procedure List#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $eq.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, List.vals, $phys_ptr_cast(P#_this_, ^List))), F#lambda#1($int_to_map_t..^^u4.^^i4($rd_inv($s, List.vals, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#_this_, ^List), ^List))), $rd_inv($s, List.head, $phys_ptr_cast(P#_this_, ^List)), $rd_inv($s, List.length, $phys_ptr_cast(P#_this_, ^List))));
  ensures $is_admissibility_check() ==> $rd_inv($s, List.length, $phys_ptr_cast(P#_this_, ^List)) == 0 || ($keeps($s, $phys_ptr_cast(P#_this_, ^List), $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#_this_, ^List), ^List)) && $rd_inv($s, List.length, $phys_ptr_cast(P#_this_, ^List)) == $rd_inv($s, List.length, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#_this_, ^List), ^List)) + 1);
  ensures $is_unwrap_check() ==> $eq.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, List.vals, $phys_ptr_cast(P#_this_, ^List))), F#lambda#1($int_to_map_t..^^u4.^^i4($rd_inv($s, List.vals, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#_this_, ^List), ^List))), $rd_inv($s, List.head, $phys_ptr_cast(P#_this_, ^List)), $rd_inv($s, List.length, $phys_ptr_cast(P#_this_, ^List))));
  ensures $is_unwrap_check() ==> $rd_inv($s, List.length, $phys_ptr_cast(P#_this_, ^List)) == 0 || ($keeps($s, $phys_ptr_cast(P#_this_, ^List), $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#_this_, ^List), ^List)) && $rd_inv($s, List.length, $phys_ptr_cast(P#_this_, ^List)) == $rd_inv($s, List.length, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(P#_this_, ^List), ^List)) + 1);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation List#adm(P#_this_: $ptr)
{
  var #wrTime$1^4.39: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^4.39, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^4.39, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^List));
    assume #wrTime$1^4.39 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^4.39, (lambda #p: $ptr :: false));
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
        assume $good_state_ext(#tok$1^4.39, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $phys_ptr_cast(P#_this_, ^List), ^List);
    }

  #exit:
}



procedure find(P#l: $ptr) returns ($result: int);
  requires $wrapped($s, $phys_ptr_cast(P#l, ^List), ^List);
  modifies $s, $cev_pc;
  free ensures $in_range_u4($result);
  ensures $result <= $rd_inv($s, List.length, $phys_ptr_cast(P#l, ^List));
  ensures $result < $rd_inv($s, List.length, $phys_ptr_cast(P#l, ^List)) ==> $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, List.vals, $phys_ptr_cast(P#l, ^List))), $result) == 0;
  ensures (forall Q#i$1^17.27#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, List.vals, $phys_ptr_cast(P#l, ^List))), Q#i$1^17.27#tc1) } $in_range_u4(Q#i$1^17.27#tc1) ==> Q#i$1^17.27#tc1 < $result ==> $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, List.vals, $phys_ptr_cast(P#l, ^List))), Q#i$1^17.27#tc1) != 0);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation find(P#l: $ptr) returns ($result: int)
{
  var loopState#0: $state;
  var L#p: $ptr;
  var #wrTime$1^13.1: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^13.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^13.1, #loc.l, $ptr_to_int(P#l), $ptr_to(^List));
    assume #wrTime$1^13.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^13.1, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, l, l); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#l, ^List), $phys_ptr_cast(P#l, ^List), l#public);
    // struct List* p; 
    assume $local_value_is($s, #tok$1^19.3, #loc.p, $ptr_to_int(L#p), $ptr_to(^List));
    // var struct List* p
    // p := l; 
    L#p := $phys_ptr_cast(P#l, ^List);
    assume $local_value_is($s, #tok$1^20.8, #loc.p, $ptr_to_int(L#p), $ptr_to(^List));
    loopState#0 := $s;
    while (true)
      invariant $rd_inv($s, List.length, $phys_ptr_cast(L#p, ^List)) <= $rd_inv($s, List.length, $phys_ptr_cast(P#l, ^List));
      invariant $in_domain_lab($s, $phys_ptr_cast(L#p, ^List), $phys_ptr_cast(P#l, ^List), l#public);
      invariant $eq.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, List.vals, $phys_ptr_cast(L#p, ^List))), F#lambda#2($rd_inv($s, List.length, $phys_ptr_cast(P#l, ^List)) - $rd_inv($s, List.length, $phys_ptr_cast(L#p, ^List)), $int_to_map_t..^^u4.^^i4($rd_inv($s, List.vals, $phys_ptr_cast(P#l, ^List))), $rd_inv($s, List.length, $phys_ptr_cast(L#p, ^List))));
      invariant (forall Q#j$1^24.31#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, List.vals, $phys_ptr_cast(P#l, ^List))), Q#j$1^24.31#tc1) } $in_range_u4(Q#j$1^24.31#tc1) ==> Q#j$1^24.31#tc1 < $rd_inv($s, List.length, $phys_ptr_cast(P#l, ^List)) - $rd_inv($s, List.length, $phys_ptr_cast(L#p, ^List)) ==> $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, List.vals, $phys_ptr_cast(P#l, ^List))), Q#j$1^24.31#tc1) != 0);
    {
      anon11:
        assume $writes_nothing(old($s), $s);
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$1^20.3, $s);
        assume $local_value_is($s, #tok$1^20.3, #loc.p, $ptr_to_int(L#p), $ptr_to(^List));
        assume $local_value_is($s, #tok$1^20.3, #loc.l, $ptr_to_int(P#l), $ptr_to(^List));
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#0, $s);
        // assert @reads_check_normal((p->length)); 
        assert $thread_local($s, $phys_ptr_cast(L#p, ^List));
        assume true;
        // if (!=(*((p->length)), 0)) ...
        if ($rd_inv($s, List.length, $phys_ptr_cast(L#p, ^List)) != 0)
        {
          anon9:
            // assert forall(uint32_t j; @in_range_u4(j); ==>(<(j, *((*((p->tail))->length))), ==(@map_get(*((*((p->tail))->vals)), j), @map_get(*((p->vals)), +(j, 1))))); 
            assert (forall Q#j$1^26.28#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, List.vals, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(L#p, ^List), ^List))), Q#j$1^26.28#tc1) } $in_range_u4(Q#j$1^26.28#tc1) ==> Q#j$1^26.28#tc1 < $rd_inv($s, List.length, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(L#p, ^List), ^List)) ==> $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, List.vals, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(L#p, ^List), ^List))), Q#j$1^26.28#tc1) == $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, List.vals, $phys_ptr_cast(L#p, ^List))), Q#j$1^26.28#tc1 + 1));
            // assume forall(uint32_t j; @in_range_u4(j); ==>(<(j, *((*((p->tail))->length))), ==(@map_get(*((*((p->tail))->vals)), j), @map_get(*((p->vals)), +(j, 1))))); 
            assume (forall Q#j$1^26.28#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, List.vals, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(L#p, ^List), ^List))), Q#j$1^26.28#tc1) } $in_range_u4(Q#j$1^26.28#tc1) ==> Q#j$1^26.28#tc1 < $rd_inv($s, List.length, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(L#p, ^List), ^List)) ==> $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, List.vals, $rd_phys_ptr($s, List.tail, $phys_ptr_cast(L#p, ^List), ^List))), Q#j$1^26.28#tc1) == $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, List.vals, $phys_ptr_cast(L#p, ^List))), Q#j$1^26.28#tc1 + 1));
            // assert ==(*((p->head)), @map_get(*((p->vals)), 0)); 
            assert $rd_inv($s, List.head, $phys_ptr_cast(L#p, ^List)) == $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, List.vals, $phys_ptr_cast(L#p, ^List))), 0);
            // assume ==(*((p->head)), @map_get(*((p->vals)), 0)); 
            assume $rd_inv($s, List.head, $phys_ptr_cast(L#p, ^List)) == $select.$map_t..^^u4.^^i4($int_to_map_t..^^u4.^^i4($rd_inv($s, List.vals, $phys_ptr_cast(L#p, ^List))), 0);
            // assert @reads_check_normal((p->head)); 
            assert $thread_local($s, $phys_ptr_cast(L#p, ^List));
            assume true;
            // if (==(*((p->head)), 0)) ...
            if ($rd_inv($s, List.head, $phys_ptr_cast(L#p, ^List)) == 0)
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
        assert $thread_local($s, $phys_ptr_cast(L#p, ^List));
        // p := *((p->tail)); 
        L#p := $rd_phys_ptr($s, List.tail, $phys_ptr_cast(L#p, ^List), ^List);
        assume $local_value_is($s, #tok$1^20.31, #loc.p, $ptr_to_int(L#p), $ptr_to(^List));
        assume true;
    }

  anon13:
    assume $full_stop_ext(#tok$1^20.3, $s);

  #break_3:
    // assert @in_range_u4(-(*((l->length)), *((p->length)))); 
    assert $in_range_u4($rd_inv($s, List.length, $phys_ptr_cast(P#l, ^List)) - $rd_inv($s, List.length, $phys_ptr_cast(L#p, ^List)));
    // assert @reads_check_normal((l->length)); 
    assert $thread_local($s, $phys_ptr_cast(P#l, ^List));
    // assert @reads_check_normal((p->length)); 
    assert $thread_local($s, $phys_ptr_cast(L#p, ^List));
    // return -(*((l->length)), *((p->length))); 
    $result := $rd_inv($s, List.length, $phys_ptr_cast(P#l, ^List)) - $rd_inv($s, List.length, $phys_ptr_cast(L#p, ^List));
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



axiom (forall Q#j$1^23.42#tc1: int, #l2: int, #l1: $map_t..^^u4.^^i4, #l0: int :: {:weight 10} { $select.$map_t..^^u4.^^i4(F#lambda#2(#l2, #l1, #l0), Q#j$1^23.42#tc1) } $in_range_u4(Q#j$1^23.42#tc1) && $in_range_u4(#l2) && $in_range_u4(#l0) ==> $select.$map_t..^^u4.^^i4(F#lambda#2(#l2, #l1, #l0), Q#j$1^23.42#tc1) == (if Q#j$1^23.42#tc1 < #l0 then $select.$map_t..^^u4.^^i4(#l1, #l2 + Q#j$1^23.42#tc1) else 0));

function F#lambda#1(#l2: $map_t..^^u4.^^i4, #l1: int, #l0: int) : $map_t..^^u4.^^i4;

const unique cf#lambda#1: $pure_function;

axiom $function_arg_type(cf#lambda#1, 0, $map_t(^^u4, ^^i4));

axiom $function_arg_type(cf#lambda#1, 1, $map_t(^^u4, ^^i4));

axiom $function_arg_type(cf#lambda#1, 2, ^^i4);

axiom $function_arg_type(cf#lambda#1, 3, ^^u4);

procedure lambda#1(#l2: $map_t..^^u4.^^i4, #l1: int, #l0: int) returns ($result: $map_t..^^u4.^^i4);
  free ensures $result == F#lambda#1(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^9.37#tc1: int, #l2: $map_t..^^u4.^^i4, #l1: int, #l0: int :: {:weight 10} { $select.$map_t..^^u4.^^i4(F#lambda#1(#l2, #l1, #l0), Q#i$1^9.37#tc1) } $in_range_u4(Q#i$1^9.37#tc1) && $in_range_i4(#l1) && $in_range_u4(#l0) ==> $select.$map_t..^^u4.^^i4(F#lambda#1(#l2, #l1, #l0), Q#i$1^9.37#tc1) == (if Q#i$1^9.37#tc1 < #l0 then (if Q#i$1^9.37#tc1 == 0 then #l1 else $select.$map_t..^^u4.^^i4(#l2, Q#i$1^9.37#tc1 - 1)) else 0));

const unique l#public: $label;

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
