axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

const unique ^_PAGE_SET: $ctype;

axiom $is_composite(^_PAGE_SET);

axiom $ptr_level(^_PAGE_SET) == 0;

axiom $sizeof(^_PAGE_SET) == 16;

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_PAGE_SET) } $inv2(#s1, #s2, #p, ^_PAGE_SET) == ($typed(#s2, #p) && $mem(#s2, $dot(#p, _PAGE_SET.PagesAllocated)) <= $mem(#s2, $dot(#p, _PAGE_SET.PageCount)) && $as_array($read_ptr(#s1, $dot(#p, _PAGE_SET.Array), ^^u8), ^^u8, $mem(#s1, $dot(#p, _PAGE_SET.PageCount))) == $as_array($read_ptr(#s2, $dot(#p, _PAGE_SET.Array), ^^u8), ^^u8, $mem(#s2, $dot(#p, _PAGE_SET.PageCount))) && $keeps(#s2, #p, $as_array($read_ptr(#s2, $dot(#p, _PAGE_SET.Array), ^^u8), ^^u8, $mem(#s2, $dot(#p, _PAGE_SET.PageCount)))) && $typed2(#s2, $as_array($read_ptr(#s2, $dot(#p, _PAGE_SET.Array), ^^u8), ^^u8, $mem(#s2, $dot(#p, _PAGE_SET.PageCount))), $array(^^u8, $mem(#s2, $dot(#p, _PAGE_SET.PageCount))))));

axiom (forall #s2: $state, #r: int :: { $inv_lab(#s2, $ptr(^_PAGE_SET, #r), l#public) } $inv_lab(#s2, $ptr(^_PAGE_SET, #r), l#public) == ($typed(#s2, $ptr(^_PAGE_SET, #r)) && $mem(#s2, $dot($ptr(^_PAGE_SET, #r), _PAGE_SET.PagesAllocated)) <= $mem(#s2, $dot($ptr(^_PAGE_SET, #r), _PAGE_SET.PageCount)) && $keeps(#s2, $ptr(^_PAGE_SET, #r), $as_array($read_ptr(#s2, $dot($ptr(^_PAGE_SET, #r), _PAGE_SET.Array), ^^u8), ^^u8, $mem(#s2, $dot($ptr(^_PAGE_SET, #r), _PAGE_SET.PageCount)))) && $typed2(#s2, $as_array($read_ptr(#s2, $dot($ptr(^_PAGE_SET, #r), _PAGE_SET.Array), ^^u8), ^^u8, $mem(#s2, $dot($ptr(^_PAGE_SET, #r), _PAGE_SET.PageCount))), $array(^^u8, $mem(#s2, $dot($ptr(^_PAGE_SET, #r), _PAGE_SET.PageCount))))));

axiom (forall #q: $ptr, #r: int :: { $in_full_extent_of(#q, $ptr(^_PAGE_SET, #r)) } $in_full_extent_of(#q, $ptr(^_PAGE_SET, #r)) == (#q == $ptr(^_PAGE_SET, #r) || #q == $dot($ptr(^_PAGE_SET, #r), _PAGE_SET.$owns) || #q == $dot($ptr(^_PAGE_SET, #r), _PAGE_SET.PageCount) || #q == $dot($ptr(^_PAGE_SET, #r), _PAGE_SET.PagesAllocated) || #q == $dot($ptr(^_PAGE_SET, #r), _PAGE_SET.Array)));

axiom (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_PAGE_SET, #r)) } $in_extent_of(#s, #q, $ptr(^_PAGE_SET, #r)) == $in_struct_extent_of(#q, $ptr(^_PAGE_SET, #r))) && (forall #s: $state, #q: $ptr, #r: int :: { $in_extent_of(#s, #q, $ptr(^_PAGE_SET, #r)) } $typed(#s, $ptr(^_PAGE_SET, #r)) ==> $in_extent_of(#s, #q, $ptr(^_PAGE_SET, #r)) == (#q == $ptr(^_PAGE_SET, #r) || $emb(#s, #q) == $ptr(^_PAGE_SET, #r)));

axiom (forall #q: $ptr, #r: int :: { $in_span_of(#q, $ptr(^_PAGE_SET, #r)) } $in_span_of(#q, $ptr(^_PAGE_SET, #r)) == (#q == $ptr(^_PAGE_SET, #r) || #q == $dot($ptr(^_PAGE_SET, #r), _PAGE_SET.$owns) || #q == $dot($ptr(^_PAGE_SET, #r), _PAGE_SET.PageCount) || #q == $dot($ptr(^_PAGE_SET, #r), _PAGE_SET.PagesAllocated) || #q == $dot($ptr(^_PAGE_SET, #r), _PAGE_SET.Array)));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_spans_the_same(#s1, #s2, #p, ^_PAGE_SET) } $state_spans_the_same(#s1, #s2, #p, ^_PAGE_SET) == ($mem_eq(#s1, #s2, $dot(#p, _PAGE_SET.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _PAGE_SET.PageCount)) && $mem_eq(#s1, #s2, $dot(#p, _PAGE_SET.PagesAllocated)) && $mem_eq(#s1, #s2, $dot(#p, _PAGE_SET.Array))));

axiom (forall #p: $ptr, #s1: $state, #s2: $state :: { $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_PAGE_SET) } $state_nonvolatile_spans_the_same(#s1, #s2, #p, ^_PAGE_SET) == ($mem_eq(#s1, #s2, $dot(#p, _PAGE_SET.$owns)) && $mem_eq(#s1, #s2, $dot(#p, _PAGE_SET.PageCount)) && $mem_eq(#s1, #s2, $dot(#p, _PAGE_SET.PagesAllocated)) && $mem_eq(#s1, #s2, $dot(#p, _PAGE_SET.Array))));

axiom $is_claimable(^_PAGE_SET) == false;

axiom $has_volatile_owns_set(^_PAGE_SET) == false;

axiom (forall #s1: $state, #r: int :: { $extent_mutable(#s1, $ptr(^_PAGE_SET, #r)) } $extent_mutable(#s1, $ptr(^_PAGE_SET, #r)) == $mutable(#s1, $ptr(^_PAGE_SET, #r)));

axiom (forall #s1: $state, #s2: $state, #r: int :: { $extent_is_fresh(#s1, #s2, $ptr(^_PAGE_SET, #r)) } $extent_is_fresh(#s1, #s2, $ptr(^_PAGE_SET, #r)) == $is_fresh(#s1, #s2, $ptr(^_PAGE_SET, #r)));

axiom (forall #s1: $state, #r: int :: { $extent_zero(#s1, $ptr(^_PAGE_SET, #r)) } $extent_zero(#s1, $ptr(^_PAGE_SET, #r)) == ($mem(#s1, $dot($ptr(^_PAGE_SET, #r), _PAGE_SET.PageCount)) == 0 && $mem(#s1, $dot($ptr(^_PAGE_SET, #r), _PAGE_SET.PagesAllocated)) == 0 && $mem(#s1, $dot($ptr(^_PAGE_SET, #r), _PAGE_SET.Array)) == 0));

const unique _PAGE_SET.$owns: $field;

axiom $static_field_properties(_PAGE_SET.$owns, ^_PAGE_SET);

axiom $is_primitive_non_volatile_field(_PAGE_SET.$owns);

axiom (forall #p: $ptr :: { $dot(#p, _PAGE_SET.$owns) } $is(#p, ^_PAGE_SET) ==> $dot(#p, _PAGE_SET.$owns) == $ptr(^$#ptrset, $ghost_ref(#p, _PAGE_SET.$owns)) && $extent_hint($dot(#p, _PAGE_SET.$owns), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _PAGE_SET.$owns)) } { $st(#s, $dot(#p, _PAGE_SET.$owns)) } $typed2(#s, #p, ^_PAGE_SET) ==> $field_properties(#s, #p, _PAGE_SET.$owns, ^$#ptrset, false));

axiom $owns_set_field(^_PAGE_SET) == _PAGE_SET.$owns;

const unique _PAGE_SET.PageCount: $field;

axiom $static_field_properties(_PAGE_SET.PageCount, ^_PAGE_SET);

axiom $is_primitive_non_volatile_field(_PAGE_SET.PageCount);

axiom $field_offset(_PAGE_SET.PageCount) == 0;

axiom (forall #p: $ptr :: { $dot(#p, _PAGE_SET.PageCount) } $is(#p, ^_PAGE_SET) ==> $dot(#p, _PAGE_SET.PageCount) == $ptr(^^u4, $ref(#p) + 0) && $extent_hint($dot(#p, _PAGE_SET.PageCount), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _PAGE_SET.PageCount)) } { $st(#s, $dot(#p, _PAGE_SET.PageCount)) } $typed2(#s, #p, ^_PAGE_SET) ==> $field_properties(#s, #p, _PAGE_SET.PageCount, ^^u4, false));

const unique _PAGE_SET.PagesAllocated: $field;

axiom $static_field_properties(_PAGE_SET.PagesAllocated, ^_PAGE_SET);

axiom $is_primitive_non_volatile_field(_PAGE_SET.PagesAllocated);

axiom $field_offset(_PAGE_SET.PagesAllocated) == 4;

axiom (forall #p: $ptr :: { $dot(#p, _PAGE_SET.PagesAllocated) } $is(#p, ^_PAGE_SET) ==> $dot(#p, _PAGE_SET.PagesAllocated) == $ptr(^^u4, $ref(#p) + 4) && $extent_hint($dot(#p, _PAGE_SET.PagesAllocated), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _PAGE_SET.PagesAllocated)) } { $st(#s, $dot(#p, _PAGE_SET.PagesAllocated)) } $typed2(#s, #p, ^_PAGE_SET) ==> $field_properties(#s, #p, _PAGE_SET.PagesAllocated, ^^u4, false));

const unique _PAGE_SET.Array: $field;

axiom $static_field_properties(_PAGE_SET.Array, ^_PAGE_SET);

axiom $is_primitive_non_volatile_field(_PAGE_SET.Array);

axiom $field_offset(_PAGE_SET.Array) == 8;

axiom (forall #p: $ptr :: { $dot(#p, _PAGE_SET.Array) } $is(#p, ^_PAGE_SET) ==> $dot(#p, _PAGE_SET.Array) == $ptr($ptr_to(^^u8), $ref(#p) + 8) && $extent_hint($dot(#p, _PAGE_SET.Array), #p));

axiom (forall #p: $ptr, #s: $state :: { $ts(#s, $dot(#p, _PAGE_SET.Array)) } { $st(#s, $dot(#p, _PAGE_SET.Array)) } $typed2(#s, #p, ^_PAGE_SET) ==> $field_properties(#s, #p, _PAGE_SET.Array, $ptr_to(^^u8), false));

procedure _PAGE_SET#adm(P#_this_: int);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $mem($s, $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.PagesAllocated)) <= $mem($s, $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.PageCount));
  ensures $is_admissibility_check() ==> $as_array($read_ptr(old($s), $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.Array), ^^u8), ^^u8, $mem(old($s), $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.PageCount))) == $as_array($read_ptr($s, $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.Array), ^^u8), ^^u8, $mem($s, $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.PageCount)));
  ensures $is_admissibility_check() ==> $keeps($s, $ptr(^_PAGE_SET, P#_this_), $as_array($read_ptr($s, $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.Array), ^^u8), ^^u8, $mem($s, $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.PageCount))));
  ensures $is_admissibility_check() ==> $typed2($s, $as_array($read_ptr($s, $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.Array), ^^u8), ^^u8, $mem($s, $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.PageCount))), $array(^^u8, $mem($s, $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.PageCount))));
  ensures $is_stuttering_check() ==> $as_array($read_ptr($s, $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.Array), ^^u8), ^^u8, $mem($s, $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.PageCount))) == $as_array($read_ptr($s, $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.Array), ^^u8), ^^u8, $mem($s, $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.PageCount)));
  ensures $is_unwrap_check() ==> $mem($s, $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.PagesAllocated)) <= $mem($s, $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.PageCount));
  ensures $is_unwrap_check() ==> $as_array($read_ptr(old($s), $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.Array), ^^u8), ^^u8, $mem(old($s), $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.PageCount))) == $as_array($read_ptr($s, $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.Array), ^^u8), ^^u8, $mem($s, $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.PageCount)));
  ensures $is_unwrap_check() ==> $keeps($s, $ptr(^_PAGE_SET, P#_this_), $as_array($read_ptr($s, $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.Array), ^^u8), ^^u8, $mem($s, $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.PageCount))));
  ensures $is_unwrap_check() ==> $typed2($s, $as_array($read_ptr($s, $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.Array), ^^u8), ^^u8, $mem($s, $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.PageCount))), $array(^^u8, $mem($s, $dot($ptr(^_PAGE_SET, P#_this_), _PAGE_SET.PageCount))));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation _PAGE_SET#adm(P#_this_: int)
{
  var #wrTime$1^9.9: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^9.9, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^9.9, #loc._this_, $ptr_to_int($ptr(^_PAGE_SET, P#_this_)), $ptr_to(^_PAGE_SET)) && $local_value_is_ptr($s, #tok$1^9.9, #loc._this_, $ptr(^_PAGE_SET, P#_this_), $ptr_to(^_PAGE_SET));
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
        assume $unwrap_check_pre($s, $ptr(^_PAGE_SET, P#_this_));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($ptr(^_PAGE_SET, P#_this_));
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
            assume $admissibility_pre($s, $ptr(^_PAGE_SET, P#_this_));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $ptr(^_PAGE_SET, P#_this_));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct _PAGE_SET*)@null))
        call $havoc_others($ptr(^_PAGE_SET, P#_this_), ^_PAGE_SET);
        assume $good_state_ext(#tok$1^9.9, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $ptr(^_PAGE_SET, P#_this_), ^_PAGE_SET);
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

procedure Init(P#PageSet: int, P#PageCount: int, P#Array: int);
  requires $wrapped($s, $as_array($ptr(^^u8, P#Array), ^^u8, P#PageCount), $array(^^u8, P#PageCount));
  modifies $s, $cev_pc;
  ensures $mem($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.PageCount)) == P#PageCount;
  ensures $mem($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.PagesAllocated)) == 0;
  ensures $ptr_eq($read_ptr($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.Array), ^^u8), $ptr(^^u8, P#Array));
  ensures $wrapped($s, $ptr(^_PAGE_SET, P#PageSet), ^_PAGE_SET);
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $extent(old($s), $ptr(^_PAGE_SET, P#PageSet))) || #p == $as_array($ptr(^^u8, P#Array), ^^u8, P#PageCount) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $extent(old($s), $ptr(^_PAGE_SET, P#PageSet))) || #p == $as_array($ptr(^^u8, P#Array), ^^u8, P#PageCount) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $extent(old($s), $ptr(^_PAGE_SET, P#PageSet))) || #p == $as_array($ptr(^^u8, P#Array), ^^u8, P#PageCount) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Init(P#PageSet: int, P#PageCount: int, P#Array: int)
{
  var owns#4: $ptrset;
  var staticWrapState#3: $state;
  var prestate#5: $state;
  var #wrTime$1^21.1: int;
  var #stackframe: int;

  anon7:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^21.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^21.1, #loc.PageSet, $ptr_to_int($ptr(^_PAGE_SET, P#PageSet)), $ptr_to(^_PAGE_SET)) && $local_value_is_ptr($s, #tok$1^21.1, #loc.PageSet, $ptr(^_PAGE_SET, P#PageSet), $ptr_to(^_PAGE_SET));
    assume $local_value_is($s, #tok$1^21.1, #loc.PageCount, P#PageCount, ^^u4);
    assume $local_value_is($s, #tok$1^21.1, #loc.Array, $ptr_to_int($ptr(^^u8, P#Array)), $ptr_to(^^u8)) && $local_value_is_ptr($s, #tok$1^21.1, #loc.Array, $ptr(^^u8, P#Array), $ptr_to(^^u8));
    assume #wrTime$1^21.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^21.1, #p) } $in_writes_at(#wrTime$1^21.1, #p) == ($set_in(#p, $extent($s, $ptr(^_PAGE_SET, P#PageSet))) || #p == $as_array($ptr(^^u8, P#Array), ^^u8, P#PageCount)));
    assume (forall #p: $ptr :: { $extent_hint(#p, $ptr(^_PAGE_SET, P#PageSet)) } $set_in(#p, $extent($s, $ptr(^_PAGE_SET, P#PageSet))) ==> $mutable($s, #p));
    assume $thread_owned_or_even_mutable($s, $as_array($ptr(^^u8, P#Array), ^^u8, P#PageCount));
    // assume @in_range_phys_ptr((mathint)PageSet); 
    assume $in_range_phys_ptr($ref($ptr(^_PAGE_SET, P#PageSet)));
    // assume @in_range_u4(PageCount); 
    assume $in_range_u4(P#PageCount);
    // assume @in_range_phys_ptr((mathint)Array); 
    assume $in_range_phys_ptr($ref($ptr(^^u8, P#Array)));
    // assert @_vcc_in_domain(@state, @_vcc_as_array(Array, PageCount), @_vcc_as_array(Array, PageCount)); 
    assert $in_domain_lab($s, $as_array($ptr(^^u8, P#Array), ^^u8, P#PageCount), $as_array($ptr(^^u8, P#Array), ^^u8, P#PageCount), l#public);
    // assert @_vcc_typed2(@state, (PageSet->Array)); 
    assert $typed2($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.Array), $ptr_to(^^u8));
    // assert @prim_writes_check((PageSet->Array)); 
    assert $writable($s, #wrTime$1^21.1, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.Array));
    // *(PageSet->Array) := Array; 
    call $write_int($dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.Array), $ref($ptr(^^u8, P#Array)));
    assume $full_stop_ext(#tok$1^33.5, $s);
    // assert @_vcc_typed2(@state, (PageSet->PageCount)); 
    assert $typed2($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.PageCount), ^^u4);
    // assert @prim_writes_check((PageSet->PageCount)); 
    assert $writable($s, #wrTime$1^21.1, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.PageCount));
    // *(PageSet->PageCount) := PageCount; 
    call $write_int($dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.PageCount), P#PageCount);
    assume $full_stop_ext(#tok$1^34.5, $s);
    // assert @_vcc_typed2(@state, (PageSet->PagesAllocated)); 
    assert $typed2($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.PagesAllocated), ^^u4);
    // assert @prim_writes_check((PageSet->PagesAllocated)); 
    assert $writable($s, #wrTime$1^21.1, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.PagesAllocated));
    // *(PageSet->PagesAllocated) := 0; 
    call $write_int($dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.PagesAllocated), 0);
    assume $full_stop_ext(#tok$1^35.5, $s);
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
    assert $top_writable($s, #wrTime$1^21.1, $ptr(^_PAGE_SET, P#PageSet));
    // assert @_vcc_wrapped(@state, @_vcc_as_array(*((PageSet->Array)), *((PageSet->PageCount)))); 
    assert $wrapped($s, $as_array($read_ptr($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.Array), ^^u8), ^^u8, $mem($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.PageCount))), $array(^^u8, $mem($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.PageCount))));
    // assert @writes_check(@_vcc_as_array(*((PageSet->Array)), *((PageSet->PageCount)))); 
    assert $top_writable($s, #wrTime$1^21.1, $as_array($read_ptr($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.Array), ^^u8), ^^u8, $mem($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.PageCount))));
    // owns#4 := pure(@_vcc_set_union(owns#4, @_vcc_set_singleton(@_vcc_as_array(*((PageSet->Array)), *((PageSet->PageCount)))))); 
    owns#4 := $set_union(owns#4, $set_singleton($as_array($read_ptr($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.Array), ^^u8), ^^u8, $mem($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.PageCount)))));
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#4, $ptrset_to_int(owns#4), ^$#ptrset);
    // staticWrapState#3 := pure(@_vcc_take_over(staticWrapState#3, PageSet, @_vcc_as_array(*((PageSet->Array)), *((PageSet->PageCount))))); 
    staticWrapState#3 := $take_over(staticWrapState#3, $ptr(^_PAGE_SET, P#PageSet), $as_array($read_ptr($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.Array), ^^u8), ^^u8, $mem($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.PageCount))));
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#3, $state_to_int(staticWrapState#3), ^$#state_t);
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(PageSet), staticWrapState#3, owns#4)
    call $static_wrap($ptr(^_PAGE_SET, P#PageSet), staticWrapState#3, owns#4);
    assume $good_state_ext(#tok$1^36.21, $s);
    // assert @inv_check(<=(*((PageSet->PagesAllocated)), *((PageSet->PageCount)))); 
    assert $mem($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.PagesAllocated)) <= $mem($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.PageCount));
    // assert @inv_check(@keeps_stable(old(prestate#5, @_vcc_as_array(*((PageSet->Array)), *((PageSet->PageCount)))), @_vcc_as_array(*((PageSet->Array)), *((PageSet->PageCount))))); 
    assert $as_array($read_ptr(prestate#5, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.Array), ^^u8), ^^u8, $mem(prestate#5, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.PageCount))) == $as_array($read_ptr($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.Array), ^^u8), ^^u8, $mem($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.PageCount)));
    // assert @inv_check(@keeps(PageSet, @_vcc_as_array(*((PageSet->Array)), *((PageSet->PageCount))))); 
    assert $keeps($s, $ptr(^_PAGE_SET, P#PageSet), $as_array($read_ptr($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.Array), ^^u8), ^^u8, $mem($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.PageCount))));
    // assert @inv_check(@_vcc_typed2(@state, @_vcc_as_array(*((PageSet->Array)), *((PageSet->PageCount))))); 
    assert $typed2($s, $as_array($read_ptr($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.Array), ^^u8), ^^u8, $mem($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.PageCount))), $array(^^u8, $mem($s, $dot($ptr(^_PAGE_SET, P#PageSet), _PAGE_SET.PageCount))));
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
  var #callConv#0: $ptr;
  var L#ps: int where $in_range_phys_ptr(L#ps);
  var L#arr: int where $in_range_phys_ptr(L#arr);
  var #wrTime$1^39.1: int;
  var #stackframe: int;

  anon10:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^39.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^39.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^39.1, #p) } $in_writes_at(#wrTime$1^39.1, #p) == false);
    // uint64_t* arr; 
    assume $local_value_is($s, #tok$1^41.3, #loc.arr, $ptr_to_int($ptr(^^u8, L#arr)), $ptr_to(^^u8)) && $local_value_is_ptr($s, #tok$1^41.3, #loc.arr, $ptr(^^u8, L#arr), $ptr_to(^^u8));
    // struct _PAGE_SET* ps; 
    assume $local_value_is($s, #tok$1^40.3, #loc.ps, $ptr_to_int($ptr(^_PAGE_SET, L#ps)), $ptr_to(^_PAGE_SET)) && $local_value_is_ptr($s, #tok$1^40.3, #loc.ps, $ptr(^_PAGE_SET, L#ps), $ptr_to(^_PAGE_SET));
    // ps := _vcc_alloc(@_vcc_typeof((struct _PAGE_SET*)@null)); 
    call #callConv#0 := $alloc(^_PAGE_SET);
    assume $full_stop_ext(#tok$1^40.18, $s);
    L#ps := $ref(#callConv#0);
    assume $local_value_is($s, #tok$1^40.18, #loc.ps, $ptr_to_int($ptr(^_PAGE_SET, L#ps)), $ptr_to(^_PAGE_SET)) && $local_value_is_ptr($s, #tok$1^40.18, #loc.ps, $ptr(^_PAGE_SET, L#ps), $ptr_to(^_PAGE_SET));
    // obj_t res__vcc_alloc#2; 
    assume $local_value_is($s, #tok$1^41.17, #loc.res__vcc_alloc#2, $ptr_to_int(res__vcc_alloc#2), $ptr_to(^^void));
    // res__vcc_alloc#2 := _vcc_alloc(@_vcc_array(@_vcc_typeof((uint64_t*)@null), 100)); 
    call res__vcc_alloc#2 := $alloc($array(^^u8, 100));
    assume $full_stop_ext(#tok$1^41.17, $s);
    assume $local_value_is($s, #tok$1^41.17, #loc.res__vcc_alloc#2, $ptr_to_int(res__vcc_alloc#2), $ptr_to(^^void));
    // arr := (uint64_t*)res__vcc_alloc#2; 
    L#arr := $ref($ptr_cast(res__vcc_alloc#2, ^^u8));
    assume $local_value_is($s, #tok$1^41.3, #loc.arr, $ptr_to_int($ptr(^^u8, L#arr)), $ptr_to(^^u8)) && $local_value_is_ptr($s, #tok$1^41.3, #loc.arr, $ptr(^^u8, L#arr), $ptr_to(^^u8));
    // _Bool ite#1; 
    assume $local_value_is($s, #tok$1^42.7, #loc.ite#1, $bool_to_int(ite#1), ^^bool);
    // ite#1 := &&(@_vcc_ptr_neq(ps, @null), @_vcc_ptr_neq(arr, @null)); 
    ite#1 := $ptr_neq($ptr(^_PAGE_SET, L#ps), $null) && $ptr_neq($ptr(^^u8, L#arr), $null);
    assume $local_value_is($s, #tok$1^42.7, #loc.ite#1, $bool_to_int(ite#1), ^^bool);
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
        assert $top_writable($s, #wrTime$1^39.1, $as_array($ptr(^^u8, L#arr), ^^u8, 100));
        // assert @writes_check(@_vcc_owns(@state, @_vcc_as_array(arr, 100))); 
        assert (forall #writes$1^43.21: $ptr :: { $dont_instantiate(#writes$1^43.21) } $set_in(#writes$1^43.21, $owns($s, $as_array($ptr(^^u8, L#arr), ^^u8, 100))) ==> $top_writable($s, #wrTime$1^39.1, #writes$1^43.21));
        // stmt @_vcc_wrap(@_vcc_as_array(arr, 100), @_vcc_typeof(@_vcc_as_array(arr, 100))); 
        call $wrap($as_array($ptr(^^u8, L#arr), ^^u8, 100), $array(^^u8, 100));
        assume $good_state_ext(#tok$1^43.21, $s);
        // assert @_vcc_inv2(prestate#6, @_vcc_current_state(@state), @_vcc_as_array(arr, 100)); 
        assert $inv2(prestate#6, $current_state($s), $as_array($ptr(^^u8, L#arr), ^^u8, 100), $array(^^u8, 100));
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // assert @writes_check(@_vcc_extent(@state, ps)); 
        assert (forall #writes$1^44.5: $ptr :: { $dont_instantiate(#writes$1^44.5) } $set_in(#writes$1^44.5, $extent($s, $ptr(^_PAGE_SET, L#ps))) ==> $top_writable($s, #wrTime$1^39.1, #writes$1^44.5));
        // assert @writes_check(@_vcc_as_array(arr, 100)); 
        assert $top_writable($s, #wrTime$1^39.1, $as_array($ptr(^^u8, L#arr), ^^u8, 100));
        // stmt Init(ps, 100, arr); 
        call Init($ref($ptr(^_PAGE_SET, L#ps)), 100, $ref($ptr(^^u8, L#arr)));
        assume $full_stop_ext(#tok$1^44.5, $s);
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

const unique #tok$1^44.5: $token;

const unique #tok$1^43.21: $token;

const unique #loc.prestate#6: $token;

const unique #loc.ite#1: $token;

const unique #tok$1^42.7: $token;

const unique #distTp3: $ctype;

axiom #distTp3 == $ptr_to(^^void);

const unique #loc.res__vcc_alloc#2: $token;

const unique #tok$1^41.17: $token;

const unique #tok$1^40.18: $token;

const unique #loc.ps: $token;

const unique #tok$1^40.3: $token;

const unique #loc.arr: $token;

const unique #tok$1^41.3: $token;

const unique #tok$1^39.1: $token;

const unique #tok$1^36.21: $token;

const unique #loc.owns#4: $token;

const unique #loc.staticWrapState#3: $token;

function $state_to_int(x: $state) : int;

function $int_to_state(x: int) : $state;

axiom (forall #x: $state :: #x == $int_to_state($state_to_int(#x)));

const unique #loc.prestate#5: $token;

const unique #tok$2^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(2, #file^?3Cno?20file?3E);

const unique #tok$1^35.5: $token;

const unique #tok$1^34.5: $token;

const unique #tok$1^33.5: $token;

const unique #loc.Array: $token;

const unique #loc.PageCount: $token;

const unique #loc.PageSet: $token;

const unique #tok$1^21.1: $token;

const unique #distTp2: $ctype;

axiom #distTp2 == $ptr_to(^_PAGE_SET);

const unique #loc._this_: $token;

const unique #tok$1^9.9: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CPageSet.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples?5CPageSet.c);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^^u8);
