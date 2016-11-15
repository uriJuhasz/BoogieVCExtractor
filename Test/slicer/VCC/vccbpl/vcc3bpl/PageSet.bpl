axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

const unique ^_PAGE_SET: $ctype;

axiom $is_span_sequential(^_PAGE_SET);

axiom $def_struct_type(^_PAGE_SET, 16, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_PAGE_SET) } $inv2(#s1, #s2, #p, ^_PAGE_SET) == ($rd_inv(#s2, _PAGE_SET.PagesAllocated, #p) <= $rd_inv(#s2, _PAGE_SET.PageCount, #p) && $as_array($rd_phys_ptr(#s1, _PAGE_SET.Array, #p, ^^u8), ^^u8, $rd_inv(#s1, _PAGE_SET.PageCount, #p)) == $as_array($rd_phys_ptr(#s2, _PAGE_SET.Array, #p, ^^u8), ^^u8, $rd_inv(#s2, _PAGE_SET.PageCount, #p)) && $keeps(#s2, #p, $as_array($rd_phys_ptr(#s2, _PAGE_SET.Array, #p, ^^u8), ^^u8, $rd_inv(#s2, _PAGE_SET.PageCount, #p)))));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^_PAGE_SET)) } $in(q, $composite_extent(s, p, ^_PAGE_SET)) == (q == p));

const unique _PAGE_SET.PageCount: $field;

axiom $def_phys_field(^_PAGE_SET, _PAGE_SET.PageCount, ^^u4, false, 0);

const unique _PAGE_SET.PagesAllocated: $field;

axiom $def_phys_field(^_PAGE_SET, _PAGE_SET.PagesAllocated, ^^u4, false, 4);

const unique _PAGE_SET.Array: $field;

axiom $def_phys_field(^_PAGE_SET, _PAGE_SET.Array, $ptr_to(^^u8), false, 8);

procedure _PAGE_SET#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $rd_inv($s, _PAGE_SET.PagesAllocated, $phys_ptr_cast(P#_this_, ^_PAGE_SET)) <= $rd_inv($s, _PAGE_SET.PageCount, $phys_ptr_cast(P#_this_, ^_PAGE_SET));
  ensures $is_admissibility_check() ==> $as_array($rd_phys_ptr(old($s), _PAGE_SET.Array, $phys_ptr_cast(P#_this_, ^_PAGE_SET), ^^u8), ^^u8, $rd_inv(old($s), _PAGE_SET.PageCount, $phys_ptr_cast(P#_this_, ^_PAGE_SET))) == $as_array($rd_phys_ptr($s, _PAGE_SET.Array, $phys_ptr_cast(P#_this_, ^_PAGE_SET), ^^u8), ^^u8, $rd_inv($s, _PAGE_SET.PageCount, $phys_ptr_cast(P#_this_, ^_PAGE_SET)));
  ensures $is_admissibility_check() ==> $keeps($s, $phys_ptr_cast(P#_this_, ^_PAGE_SET), $as_array($rd_phys_ptr($s, _PAGE_SET.Array, $phys_ptr_cast(P#_this_, ^_PAGE_SET), ^^u8), ^^u8, $rd_inv($s, _PAGE_SET.PageCount, $phys_ptr_cast(P#_this_, ^_PAGE_SET))));
  ensures $is_stuttering_check() ==> $as_array($rd_phys_ptr($s, _PAGE_SET.Array, $phys_ptr_cast(P#_this_, ^_PAGE_SET), ^^u8), ^^u8, $rd_inv($s, _PAGE_SET.PageCount, $phys_ptr_cast(P#_this_, ^_PAGE_SET))) == $as_array($rd_phys_ptr($s, _PAGE_SET.Array, $phys_ptr_cast(P#_this_, ^_PAGE_SET), ^^u8), ^^u8, $rd_inv($s, _PAGE_SET.PageCount, $phys_ptr_cast(P#_this_, ^_PAGE_SET)));
  ensures $is_unwrap_check() ==> $rd_inv($s, _PAGE_SET.PagesAllocated, $phys_ptr_cast(P#_this_, ^_PAGE_SET)) <= $rd_inv($s, _PAGE_SET.PageCount, $phys_ptr_cast(P#_this_, ^_PAGE_SET));
  ensures $is_unwrap_check() ==> $as_array($rd_phys_ptr(old($s), _PAGE_SET.Array, $phys_ptr_cast(P#_this_, ^_PAGE_SET), ^^u8), ^^u8, $rd_inv(old($s), _PAGE_SET.PageCount, $phys_ptr_cast(P#_this_, ^_PAGE_SET))) == $as_array($rd_phys_ptr($s, _PAGE_SET.Array, $phys_ptr_cast(P#_this_, ^_PAGE_SET), ^^u8), ^^u8, $rd_inv($s, _PAGE_SET.PageCount, $phys_ptr_cast(P#_this_, ^_PAGE_SET)));
  ensures $is_unwrap_check() ==> $keeps($s, $phys_ptr_cast(P#_this_, ^_PAGE_SET), $as_array($rd_phys_ptr($s, _PAGE_SET.Array, $phys_ptr_cast(P#_this_, ^_PAGE_SET), ^^u8), ^^u8, $rd_inv($s, _PAGE_SET.PageCount, $phys_ptr_cast(P#_this_, ^_PAGE_SET))));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _PAGE_SET#adm(P#_this_: $ptr)
{
  var #wrTime$1^9.9: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^9.9, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^9.9, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^_PAGE_SET));
    assume #wrTime$1^9.9 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^9.9, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($phys_ptr_cast(P#_this_, ^_PAGE_SET), ^_PAGE_SET);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $phys_ptr_cast(P#_this_, ^_PAGE_SET));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($phys_ptr_cast(P#_this_, ^_PAGE_SET));
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
            assume $admissibility_pre($s, $phys_ptr_cast(P#_this_, ^_PAGE_SET));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $phys_ptr_cast(P#_this_, ^_PAGE_SET));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct _PAGE_SET*)@null))
        call $havoc_others($phys_ptr_cast(P#_this_, ^_PAGE_SET), ^_PAGE_SET);
        assume $good_state_ext(#tok$1^9.9, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $phys_ptr_cast(P#_this_, ^_PAGE_SET), ^_PAGE_SET);
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

procedure Init(P#PageSet: $ptr, P#PageCount: int, P#Array: $ptr);
  requires $wrapped($s, $as_array($phys_ptr_cast(P#Array, ^^u8), ^^u8, P#PageCount), $array(^^u8, P#PageCount));
  modifies $s, $cev_pc;
  ensures $rd_inv($s, _PAGE_SET.PageCount, $phys_ptr_cast(P#PageSet, ^_PAGE_SET)) == P#PageCount;
  ensures $rd_inv($s, _PAGE_SET.PagesAllocated, $phys_ptr_cast(P#PageSet, ^_PAGE_SET)) == 0;
  ensures $rd_phys_ptr($s, _PAGE_SET.Array, $phys_ptr_cast(P#PageSet, ^_PAGE_SET), ^^u8) == $phys_ptr_cast(P#Array, ^^u8);
  ensures $wrapped($s, $phys_ptr_cast(P#PageSet, ^_PAGE_SET), ^_PAGE_SET);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: $set_in(#p, $extent(old($s), $phys_ptr_cast(P#PageSet, ^_PAGE_SET))) || #p == $as_array($phys_ptr_cast(P#Array, ^^u8), ^^u8, P#PageCount)));
  free ensures $call_transition(old($s), $s);



implementation Init(P#PageSet: $ptr, P#PageCount: int, P#Array: $ptr)
{
  var owns#4: $ptrset;
  var staticWrapState#3: $state;
  var prestate#5: $state;
  var #wrTime$1^20.1: int;
  var #stackframe: int;

  anon7:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^20.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^20.1, #loc.PageSet, $ptr_to_int(P#PageSet), $ptr_to(^_PAGE_SET));
    assume $local_value_is($s, #tok$1^20.1, #loc.PageCount, P#PageCount, ^^u4);
    assume $local_value_is($s, #tok$1^20.1, #loc.Array, $ptr_to_int(P#Array), $ptr_to(^^u8));
    assume #wrTime$1^20.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^20.1, (lambda #p: $ptr :: $set_in(#p, $extent($s, $phys_ptr_cast(P#PageSet, ^_PAGE_SET))) || #p == $as_array($phys_ptr_cast(P#Array, ^^u8), ^^u8, P#PageCount)));
    assume $extent_mutable($s, $phys_ptr_cast(P#PageSet, ^_PAGE_SET));
    assume $thread_owned_or_even_mutable($s, $as_array($phys_ptr_cast(P#Array, ^^u8), ^^u8, P#PageCount));
    // assume true; 
    assume true;
    // assume @in_range_u4(PageCount); 
    assume $in_range_u4(P#PageCount);
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, @_vcc_as_array(Array, PageCount), @_vcc_as_array(Array, PageCount)); 
    assert $in_domain_lab($s, $as_array($phys_ptr_cast(P#Array, ^^u8), ^^u8, P#PageCount), $as_array($phys_ptr_cast(P#Array, ^^u8), ^^u8, P#PageCount), l#public);
    // assert @prim_writes_check((PageSet->Array)); 
    assert $writable_prim($s, #wrTime$1^20.1, $dot($phys_ptr_cast(P#PageSet, ^_PAGE_SET), _PAGE_SET.Array));
    // *(PageSet->Array) := Array; 
    call $write_int(_PAGE_SET.Array, $phys_ptr_cast(P#PageSet, ^_PAGE_SET), $ptr_to_int($phys_ptr_cast(P#Array, ^^u8)));
    assume $full_stop_ext(#tok$1^32.5, $s);
    // assert @prim_writes_check((PageSet->PageCount)); 
    assert $writable_prim($s, #wrTime$1^20.1, $dot($phys_ptr_cast(P#PageSet, ^_PAGE_SET), _PAGE_SET.PageCount));
    // *(PageSet->PageCount) := PageCount; 
    call $write_int(_PAGE_SET.PageCount, $phys_ptr_cast(P#PageSet, ^_PAGE_SET), P#PageCount);
    assume $full_stop_ext(#tok$1^33.5, $s);
    // assert @prim_writes_check((PageSet->PagesAllocated)); 
    assert $writable_prim($s, #wrTime$1^20.1, $dot($phys_ptr_cast(P#PageSet, ^_PAGE_SET), _PAGE_SET.PagesAllocated));
    // *(PageSet->PagesAllocated) := 0; 
    call $write_int(_PAGE_SET.PagesAllocated, $phys_ptr_cast(P#PageSet, ^_PAGE_SET), 0);
    assume $full_stop_ext(#tok$1^34.5, $s);
    // _math state_t prestate#5; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#5, $state_to_int(prestate#5), ^$#state_t);
    // prestate#5 := @_vcc_current_state(@state); 
    prestate#5 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#5, $state_to_int(prestate#5), ^$#state_t);
    // _math state_t staticWrapState#3; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#3, $state_to_int(staticWrapState#3), ^$#state_t);
    // staticWrapState#3 := @_vcc_current_state(@state); 
    staticWrapState#3 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#3, $state_to_int(staticWrapState#3), ^$#state_t);
    // _math ptrset owns#4; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#4, $ptrset_to_int(owns#4), ^$#ptrset);
    // owns#4 := @_vcc_set_empty; 
    owns#4 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#4, $ptrset_to_int(owns#4), ^$#ptrset);
    // assert @writes_check(PageSet); 
    assert $top_writable($s, #wrTime$1^20.1, $phys_ptr_cast(P#PageSet, ^_PAGE_SET));
    // assert @_vcc_wrapped(@state, @_vcc_as_array(*((PageSet->Array)), *((PageSet->PageCount)))); 
    assert $wrapped($s, $as_array($rd_phys_ptr($s, _PAGE_SET.Array, $phys_ptr_cast(P#PageSet, ^_PAGE_SET), ^^u8), ^^u8, $rd_inv($s, _PAGE_SET.PageCount, $phys_ptr_cast(P#PageSet, ^_PAGE_SET))), $array(^^u8, $rd_inv($s, _PAGE_SET.PageCount, $phys_ptr_cast(P#PageSet, ^_PAGE_SET))));
    // assert @writes_check(@_vcc_as_array(*((PageSet->Array)), *((PageSet->PageCount)))); 
    assert $top_writable($s, #wrTime$1^20.1, $as_array($rd_phys_ptr($s, _PAGE_SET.Array, $phys_ptr_cast(P#PageSet, ^_PAGE_SET), ^^u8), ^^u8, $rd_inv($s, _PAGE_SET.PageCount, $phys_ptr_cast(P#PageSet, ^_PAGE_SET))));
    // owns#4 := pure(@_vcc_set_union(owns#4, @_vcc_set_singleton(@_vcc_as_array(*((PageSet->Array)), *((PageSet->PageCount)))))); 
    owns#4 := $set_union(owns#4, $set_singleton($as_array($rd_phys_ptr($s, _PAGE_SET.Array, $phys_ptr_cast(P#PageSet, ^_PAGE_SET), ^^u8), ^^u8, $rd_inv($s, _PAGE_SET.PageCount, $phys_ptr_cast(P#PageSet, ^_PAGE_SET)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#4, $ptrset_to_int(owns#4), ^$#ptrset);
    // staticWrapState#3 := pure(@_vcc_take_over(staticWrapState#3, PageSet, @_vcc_as_array(*((PageSet->Array)), *((PageSet->PageCount))))); 
    staticWrapState#3 := $take_over(staticWrapState#3, $phys_ptr_cast(P#PageSet, ^_PAGE_SET), $as_array($rd_phys_ptr($s, _PAGE_SET.Array, $phys_ptr_cast(P#PageSet, ^_PAGE_SET), ^^u8), ^^u8, $rd_inv($s, _PAGE_SET.PageCount, $phys_ptr_cast(P#PageSet, ^_PAGE_SET))));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#3, $state_to_int(staticWrapState#3), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(PageSet), staticWrapState#3, owns#4)
    call $static_wrap($phys_ptr_cast(P#PageSet, ^_PAGE_SET), staticWrapState#3, owns#4);
    assume $good_state_ext(#tok$1^35.21, $s);
    // assert @inv_check(<=(*((PageSet->PagesAllocated)), *((PageSet->PageCount)))); 
    assert $rd_inv($s, _PAGE_SET.PagesAllocated, $phys_ptr_cast(P#PageSet, ^_PAGE_SET)) <= $rd_inv($s, _PAGE_SET.PageCount, $phys_ptr_cast(P#PageSet, ^_PAGE_SET));
    // assert @inv_check(@keeps_stable(old(prestate#5, @_vcc_as_array(*((PageSet->Array)), *((PageSet->PageCount)))), @_vcc_as_array(*((PageSet->Array)), *((PageSet->PageCount))))); 
    assert $as_array($rd_phys_ptr(prestate#5, _PAGE_SET.Array, $phys_ptr_cast(P#PageSet, ^_PAGE_SET), ^^u8), ^^u8, $rd_inv(prestate#5, _PAGE_SET.PageCount, $phys_ptr_cast(P#PageSet, ^_PAGE_SET))) == $as_array($rd_phys_ptr($s, _PAGE_SET.Array, $phys_ptr_cast(P#PageSet, ^_PAGE_SET), ^^u8), ^^u8, $rd_inv($s, _PAGE_SET.PageCount, $phys_ptr_cast(P#PageSet, ^_PAGE_SET)));
    // assert @inv_check(@keeps(PageSet, @_vcc_as_array(*((PageSet->Array)), *((PageSet->PageCount))))); 
    assert $keeps($s, $phys_ptr_cast(P#PageSet, ^_PAGE_SET), $as_array($rd_phys_ptr($s, _PAGE_SET.Array, $phys_ptr_cast(P#PageSet, ^_PAGE_SET), ^^u8), ^^u8, $rd_inv($s, _PAGE_SET.PageCount, $phys_ptr_cast(P#PageSet, ^_PAGE_SET))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure CallInit();
  modifies $s, $cev_pc;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation CallInit()
{
  var prestate#6: $state;
  var ite#1: bool;
  var res__vcc_alloc#2: $ptr;
  var L#ps: $ptr;
  var L#arr: $ptr;
  var #wrTime$1^38.1: int;
  var #stackframe: int;

  anon10:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^38.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^38.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^38.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // uint64_t* arr; 
    assume $local_value_is($s, #tok$1^40.3, #loc.arr, $ptr_to_int(L#arr), $ptr_to(^^u8));
    // struct _PAGE_SET* ps; 
    assume $local_value_is($s, #tok$1^39.3, #loc.ps, $ptr_to_int(L#ps), $ptr_to(^_PAGE_SET));
    // ps := _vcc_alloc(@_vcc_typeof((struct _PAGE_SET*)@null)); 
    call L#ps := $alloc(^_PAGE_SET);
    assume $full_stop_ext(#tok$1^39.18, $s);
    assume $local_value_is($s, #tok$1^39.18, #loc.ps, $ptr_to_int(L#ps), $ptr_to(^_PAGE_SET));
    // obj_t res__vcc_alloc#2; 
    assume $local_value_is($s, #tok$1^40.17, #loc.res__vcc_alloc#2, $ptr_to_int(res__vcc_alloc#2), ^^object);
    // res__vcc_alloc#2 := _vcc_alloc(@_vcc_array(@_vcc_typeof((uint64_t*)@null), 100)); 
    call res__vcc_alloc#2 := $alloc($array(^^u8, 100));
    assume $full_stop_ext(#tok$1^40.17, $s);
    assume $local_value_is($s, #tok$1^40.17, #loc.res__vcc_alloc#2, $ptr_to_int(res__vcc_alloc#2), ^^object);
    // arr := (uint64_t*)res__vcc_alloc#2; 
    L#arr := $phys_ptr_cast(res__vcc_alloc#2, ^^u8);
    assume $local_value_is($s, #tok$1^40.3, #loc.arr, $ptr_to_int(L#arr), $ptr_to(^^u8));
    // _Bool ite#1; 
    assume $local_value_is($s, #tok$1^41.7, #loc.ite#1, $bool_to_int(ite#1), ^^bool);
    // ite#1 := &&(@_vcc_ptr_neq_null(ps), @_vcc_ptr_neq_null(arr)); 
    ite#1 := $non_null($phys_ptr_cast(L#ps, ^_PAGE_SET)) && $non_null($phys_ptr_cast(L#arr, ^^u8));
    assume $local_value_is($s, #tok$1^41.7, #loc.ite#1, $bool_to_int(ite#1), ^^bool);
    assume true;
    // if (ite#1) ...
    if (ite#1)
    {
      anon8:
        // _math state_t prestate#6; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#6, $state_to_int(prestate#6), ^$#state_t);
        // prestate#6 := @_vcc_current_state(@state); 
        prestate#6 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#6, $state_to_int(prestate#6), ^$#state_t);
        // assume @_vcc_pre_wrap(@state); 
        assume $pre_wrap($s);
        // assert @writes_check(@_vcc_as_array(arr, 100)); 
        assert $top_writable($s, #wrTime$1^38.1, $as_array($phys_ptr_cast(L#arr, ^^u8), ^^u8, 100));
        // assert @writes_check(@_vcc_owns(@state, @_vcc_as_array(arr, 100))); 
        assert (forall #writes$1^42.21: $ptr :: { $dont_instantiate(#writes$1^42.21) } $set_in(#writes$1^42.21, $owns($s, $as_array($phys_ptr_cast(L#arr, ^^u8), ^^u8, 100))) ==> $top_writable($s, #wrTime$1^38.1, #writes$1^42.21));
        // stmt @_vcc_wrap(@_vcc_as_array(arr, 100), @_vcc_typeof(@_vcc_as_array(arr, 100))); 
        call $wrap($as_array($phys_ptr_cast(L#arr, ^^u8), ^^u8, 100), $array(^^u8, 100));
        assume $good_state_ext(#tok$1^42.21, $s);
        // assert @_vcc_inv2(prestate#6, @_vcc_current_state(@state), @_vcc_as_array(arr, 100)); 
        assert $inv2(prestate#6, $current_state($s), $as_array($phys_ptr_cast(L#arr, ^^u8), ^^u8, 100), $array(^^u8, 100));
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // assert @writes_check(@_vcc_extent(@state, ps)); 
        assert (forall #writes$1^43.5: $ptr :: { $dont_instantiate(#writes$1^43.5) } $set_in(#writes$1^43.5, $extent($s, $phys_ptr_cast(L#ps, ^_PAGE_SET))) ==> $top_writable($s, #wrTime$1^38.1, #writes$1^43.5));
        // assert @writes_check(@_vcc_as_array(arr, 100)); 
        assert $top_writable($s, #wrTime$1^38.1, $as_array($phys_ptr_cast(L#arr, ^^u8), ^^u8, 100));
        // stmt Init(ps, 100, arr); 
        call Init($phys_ptr_cast(L#ps, ^_PAGE_SET), 100, $phys_ptr_cast(L#arr, ^^u8));
        assume $full_stop_ext(#tok$1^43.5, $s);
    }
    else
    {
      anon9:
        // empty
    }

  anon11:
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



const unique l#public: $label;

const unique #tok$1^43.5: $token;

const unique #tok$1^42.21: $token;

const unique #loc.prestate#6: $token;

const unique #loc.ite#1: $token;

const unique #tok$1^41.7: $token;

const unique #loc.res__vcc_alloc#2: $token;

const unique #tok$1^40.17: $token;

const unique #tok$1^39.18: $token;

const unique #loc.ps: $token;

const unique #tok$1^39.3: $token;

const unique #loc.arr: $token;

const unique #tok$1^40.3: $token;

const unique #tok$1^38.1: $token;

const unique #tok$1^35.21: $token;

const unique #loc.owns#4: $token;

const unique #loc.staticWrapState#3: $token;

function $state_to_int(x: $state) : int;

function $int_to_state(x: int) : $state;

axiom (forall #x: $state :: #x == $int_to_state($state_to_int(#x)));

const unique #loc.prestate#5: $token;

const unique #tok$2^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(2, #file^?3Cno?20file?3E);

const unique #tok$1^34.5: $token;

const unique #tok$1^33.5: $token;

const unique #tok$1^32.5: $token;

const unique #loc.Array: $token;

const unique #loc.PageCount: $token;

const unique #loc.PageSet: $token;

const unique #tok$1^20.1: $token;

const unique #distTp2: $ctype;

axiom #distTp2 == $ptr_to(^_PAGE_SET);

const unique #loc._this_: $token;

const unique #tok$1^9.9: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CPageSet.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CPageSet.c);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^^u8);
