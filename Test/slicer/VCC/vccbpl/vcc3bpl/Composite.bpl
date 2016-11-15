axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

const unique ^Node: $ctype;

axiom $def_struct_type(^Node, 32, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Node) } $inv2(#s1, #s2, #p, ^Node) == ($set_eq($owns(#s2, #p), $set_empty()) && $closed(#s2, $rd_spec_ptr(#s2, Node.m, #p, ^Mgr)) && ($non_null($rd_phys_ptr(#s2, Node.l, #p, ^Node)) ==> $rd_phys_ptr(#s2, Node.l, #p, ^Node) != #p) && ($non_null($rd_phys_ptr(#s2, Node.l, #p, ^Node)) ==> $rd_phys_ptr(#s2, Node.p, $rd_phys_ptr(#s2, Node.l, #p, ^Node), ^Node) == #p) && ($non_null($rd_phys_ptr(#s2, Node.l, #p, ^Node)) ==> $rd_spec_ptr(#s2, Node.m, $rd_phys_ptr(#s2, Node.l, #p, ^Node), ^Mgr) == $rd_spec_ptr(#s2, Node.m, #p, ^Mgr)) && ($non_null($rd_phys_ptr(#s2, Node.l, #p, ^Node)) ==> $closed(#s2, $rd_phys_ptr(#s2, Node.l, #p, ^Node))) && ($non_null($rd_phys_ptr(#s2, Node.r, #p, ^Node)) ==> $rd_phys_ptr(#s2, Node.r, #p, ^Node) != #p) && ($non_null($rd_phys_ptr(#s2, Node.r, #p, ^Node)) ==> $rd_phys_ptr(#s2, Node.p, $rd_phys_ptr(#s2, Node.r, #p, ^Node), ^Node) == #p) && ($non_null($rd_phys_ptr(#s2, Node.r, #p, ^Node)) ==> $rd_spec_ptr(#s2, Node.m, $rd_phys_ptr(#s2, Node.r, #p, ^Node), ^Mgr) == $rd_spec_ptr(#s2, Node.m, #p, ^Mgr)) && ($non_null($rd_phys_ptr(#s2, Node.r, #p, ^Node)) ==> $closed(#s2, $rd_phys_ptr(#s2, Node.r, #p, ^Node))) && (#p == $rd_phys_ptr(#s2, Mgr.except, $rd_spec_ptr(#s2, Node.m, #p, ^Mgr), ^Node) || $rd_inv(#s2, Node.sum, #p) == $unchk_add(^^i4, $unchk_add(^^i4, $rd_inv(#s2, Node.val, #p), (if $is_null($rd_phys_ptr(#s2, Node.l, #p, ^Node)) then 0 else $rd_inv(#s2, Node.sum, $rd_phys_ptr(#s2, Node.l, #p, ^Node)))), (if $is_null($rd_phys_ptr(#s2, Node.r, #p, ^Node)) then 0 else $rd_inv(#s2, Node.sum, $rd_phys_ptr(#s2, Node.r, #p, ^Node))))) && ($rd_inv(#s1, Node.sum, #p) == $rd_inv(#s2, Node.sum, #p) || $inv(#s2, $rd_phys_ptr(#s2, Node.p, #p, ^Node), ^Node) || $is_null($rd_phys_ptr(#s2, Node.p, #p, ^Node))) && ($closed(#s1, #p) && !$closed(#s2, #p) ==> false)));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^Node)) } $in(q, $composite_extent(s, p, ^Node)) == (q == p));

const unique Node.l: $field;

axiom $def_phys_field(^Node, Node.l, $ptr_to(^Node), false, 0);

const unique Node.r: $field;

axiom $def_phys_field(^Node, Node.r, $ptr_to(^Node), false, 8);

const unique Node.p: $field;

axiom $def_phys_field(^Node, Node.p, $ptr_to(^Node), false, 16);

const unique Node.val: $field;

axiom $def_phys_field(^Node, Node.val, ^^i4, true, 24);

const unique Node.sum: $field;

axiom $def_phys_field(^Node, Node.sum, ^^i4, true, 28);

const unique Node.m: $field;

axiom $def_ghost_field(^Node, Node.m, $spec_ptr_to(^Mgr), false);

procedure Node#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $set_eq($owns($s, $phys_ptr_cast(P#_this_, ^Node)), $set_empty());
  ensures $is_admissibility_check() ==> $closed($s, $rd_spec_ptr($s, Node.m, $phys_ptr_cast(P#_this_, ^Node), ^Mgr));
  ensures $is_admissibility_check() ==> $non_null($rd_phys_ptr($s, Node.l, $phys_ptr_cast(P#_this_, ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.l, $phys_ptr_cast(P#_this_, ^Node), ^Node) != $phys_ptr_cast(P#_this_, ^Node);
  ensures $is_admissibility_check() ==> $non_null($rd_phys_ptr($s, Node.l, $phys_ptr_cast(P#_this_, ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.p, $rd_phys_ptr($s, Node.l, $phys_ptr_cast(P#_this_, ^Node), ^Node), ^Node) == $phys_ptr_cast(P#_this_, ^Node);
  ensures $is_admissibility_check() ==> $non_null($rd_phys_ptr($s, Node.l, $phys_ptr_cast(P#_this_, ^Node), ^Node)) ==> $rd_spec_ptr($s, Node.m, $rd_phys_ptr($s, Node.l, $phys_ptr_cast(P#_this_, ^Node), ^Node), ^Mgr) == $rd_spec_ptr($s, Node.m, $phys_ptr_cast(P#_this_, ^Node), ^Mgr);
  ensures $is_admissibility_check() ==> $non_null($rd_phys_ptr($s, Node.l, $phys_ptr_cast(P#_this_, ^Node), ^Node)) ==> $closed($s, $rd_phys_ptr($s, Node.l, $phys_ptr_cast(P#_this_, ^Node), ^Node));
  ensures $is_admissibility_check() ==> $non_null($rd_phys_ptr($s, Node.r, $phys_ptr_cast(P#_this_, ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.r, $phys_ptr_cast(P#_this_, ^Node), ^Node) != $phys_ptr_cast(P#_this_, ^Node);
  ensures $is_admissibility_check() ==> $non_null($rd_phys_ptr($s, Node.r, $phys_ptr_cast(P#_this_, ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.p, $rd_phys_ptr($s, Node.r, $phys_ptr_cast(P#_this_, ^Node), ^Node), ^Node) == $phys_ptr_cast(P#_this_, ^Node);
  ensures $is_admissibility_check() ==> $non_null($rd_phys_ptr($s, Node.r, $phys_ptr_cast(P#_this_, ^Node), ^Node)) ==> $rd_spec_ptr($s, Node.m, $rd_phys_ptr($s, Node.r, $phys_ptr_cast(P#_this_, ^Node), ^Node), ^Mgr) == $rd_spec_ptr($s, Node.m, $phys_ptr_cast(P#_this_, ^Node), ^Mgr);
  ensures $is_admissibility_check() ==> $non_null($rd_phys_ptr($s, Node.r, $phys_ptr_cast(P#_this_, ^Node), ^Node)) ==> $closed($s, $rd_phys_ptr($s, Node.r, $phys_ptr_cast(P#_this_, ^Node), ^Node));
  ensures $is_admissibility_check() ==> $phys_ptr_cast(P#_this_, ^Node) == $rd_phys_ptr($s, Mgr.except, $rd_spec_ptr($s, Node.m, $phys_ptr_cast(P#_this_, ^Node), ^Mgr), ^Node) || $rd_inv($s, Node.sum, $phys_ptr_cast(P#_this_, ^Node)) == $unchk_add(^^i4, $unchk_add(^^i4, $rd_inv($s, Node.val, $phys_ptr_cast(P#_this_, ^Node)), (if $is_null($rd_phys_ptr($s, Node.l, $phys_ptr_cast(P#_this_, ^Node), ^Node)) then 0 else $rd_inv($s, Node.sum, $rd_phys_ptr($s, Node.l, $phys_ptr_cast(P#_this_, ^Node), ^Node)))), (if $is_null($rd_phys_ptr($s, Node.r, $phys_ptr_cast(P#_this_, ^Node), ^Node)) then 0 else $rd_inv($s, Node.sum, $rd_phys_ptr($s, Node.r, $phys_ptr_cast(P#_this_, ^Node), ^Node))));
  ensures $is_admissibility_check() ==> $rd_inv(old($s), Node.sum, $phys_ptr_cast(P#_this_, ^Node)) == $rd_inv($s, Node.sum, $phys_ptr_cast(P#_this_, ^Node)) || $inv($s, $rd_phys_ptr($s, Node.p, $phys_ptr_cast(P#_this_, ^Node), ^Node), ^Node) || $is_null($rd_phys_ptr($s, Node.p, $phys_ptr_cast(P#_this_, ^Node), ^Node));
  ensures $is_admissibility_check() ==> $closed(old($s), $phys_ptr_cast(P#_this_, ^Node)) && !$closed($s, $phys_ptr_cast(P#_this_, ^Node)) ==> false;
  ensures $is_stuttering_check() ==> $rd_inv($s, Node.sum, $phys_ptr_cast(P#_this_, ^Node)) == $rd_inv($s, Node.sum, $phys_ptr_cast(P#_this_, ^Node)) || $inv($s, $rd_phys_ptr($s, Node.p, $phys_ptr_cast(P#_this_, ^Node), ^Node), ^Node) || $is_null($rd_phys_ptr($s, Node.p, $phys_ptr_cast(P#_this_, ^Node), ^Node));
  ensures $is_stuttering_check() ==> $closed($s, $phys_ptr_cast(P#_this_, ^Node)) && !$closed($s, $phys_ptr_cast(P#_this_, ^Node)) ==> false;
  ensures $is_unwrap_check() ==> $set_eq($owns($s, $phys_ptr_cast(P#_this_, ^Node)), $set_empty());
  ensures $is_unwrap_check() ==> $closed($s, $rd_spec_ptr($s, Node.m, $phys_ptr_cast(P#_this_, ^Node), ^Mgr));
  ensures $is_unwrap_check() ==> $non_null($rd_phys_ptr($s, Node.l, $phys_ptr_cast(P#_this_, ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.l, $phys_ptr_cast(P#_this_, ^Node), ^Node) != $phys_ptr_cast(P#_this_, ^Node);
  ensures $is_unwrap_check() ==> $non_null($rd_phys_ptr($s, Node.l, $phys_ptr_cast(P#_this_, ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.p, $rd_phys_ptr($s, Node.l, $phys_ptr_cast(P#_this_, ^Node), ^Node), ^Node) == $phys_ptr_cast(P#_this_, ^Node);
  ensures $is_unwrap_check() ==> $non_null($rd_phys_ptr($s, Node.l, $phys_ptr_cast(P#_this_, ^Node), ^Node)) ==> $rd_spec_ptr($s, Node.m, $rd_phys_ptr($s, Node.l, $phys_ptr_cast(P#_this_, ^Node), ^Node), ^Mgr) == $rd_spec_ptr($s, Node.m, $phys_ptr_cast(P#_this_, ^Node), ^Mgr);
  ensures $is_unwrap_check() ==> $non_null($rd_phys_ptr($s, Node.l, $phys_ptr_cast(P#_this_, ^Node), ^Node)) ==> $closed($s, $rd_phys_ptr($s, Node.l, $phys_ptr_cast(P#_this_, ^Node), ^Node));
  ensures $is_unwrap_check() ==> $non_null($rd_phys_ptr($s, Node.r, $phys_ptr_cast(P#_this_, ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.r, $phys_ptr_cast(P#_this_, ^Node), ^Node) != $phys_ptr_cast(P#_this_, ^Node);
  ensures $is_unwrap_check() ==> $non_null($rd_phys_ptr($s, Node.r, $phys_ptr_cast(P#_this_, ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.p, $rd_phys_ptr($s, Node.r, $phys_ptr_cast(P#_this_, ^Node), ^Node), ^Node) == $phys_ptr_cast(P#_this_, ^Node);
  ensures $is_unwrap_check() ==> $non_null($rd_phys_ptr($s, Node.r, $phys_ptr_cast(P#_this_, ^Node), ^Node)) ==> $rd_spec_ptr($s, Node.m, $rd_phys_ptr($s, Node.r, $phys_ptr_cast(P#_this_, ^Node), ^Node), ^Mgr) == $rd_spec_ptr($s, Node.m, $phys_ptr_cast(P#_this_, ^Node), ^Mgr);
  ensures $is_unwrap_check() ==> $non_null($rd_phys_ptr($s, Node.r, $phys_ptr_cast(P#_this_, ^Node), ^Node)) ==> $closed($s, $rd_phys_ptr($s, Node.r, $phys_ptr_cast(P#_this_, ^Node), ^Node));
  ensures $is_unwrap_check() ==> $phys_ptr_cast(P#_this_, ^Node) == $rd_phys_ptr($s, Mgr.except, $rd_spec_ptr($s, Node.m, $phys_ptr_cast(P#_this_, ^Node), ^Mgr), ^Node) || $rd_inv($s, Node.sum, $phys_ptr_cast(P#_this_, ^Node)) == $unchk_add(^^i4, $unchk_add(^^i4, $rd_inv($s, Node.val, $phys_ptr_cast(P#_this_, ^Node)), (if $is_null($rd_phys_ptr($s, Node.l, $phys_ptr_cast(P#_this_, ^Node), ^Node)) then 0 else $rd_inv($s, Node.sum, $rd_phys_ptr($s, Node.l, $phys_ptr_cast(P#_this_, ^Node), ^Node)))), (if $is_null($rd_phys_ptr($s, Node.r, $phys_ptr_cast(P#_this_, ^Node), ^Node)) then 0 else $rd_inv($s, Node.sum, $rd_phys_ptr($s, Node.r, $phys_ptr_cast(P#_this_, ^Node), ^Node))));
  ensures $is_unwrap_check() ==> $rd_inv(old($s), Node.sum, $phys_ptr_cast(P#_this_, ^Node)) == $rd_inv($s, Node.sum, $phys_ptr_cast(P#_this_, ^Node)) || $inv($s, $rd_phys_ptr($s, Node.p, $phys_ptr_cast(P#_this_, ^Node), ^Node), ^Node) || $is_null($rd_phys_ptr($s, Node.p, $phys_ptr_cast(P#_this_, ^Node), ^Node));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Node#adm(P#_this_: $ptr)
{
  var #wrTime$1^38.1: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^38.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^38.1, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^Node));
    assume #wrTime$1^38.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^38.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($phys_ptr_cast(P#_this_, ^Node), ^Node);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $phys_ptr_cast(P#_this_, ^Node));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($phys_ptr_cast(P#_this_, ^Node));
        assume $good_state_ext(#tok$1^38.1, $s);
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
            assume $admissibility_pre($s, $phys_ptr_cast(P#_this_, ^Node));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $phys_ptr_cast(P#_this_, ^Node));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Node*)@null))
        call $havoc_others($phys_ptr_cast(P#_this_, ^Node), ^Node);
        assume $good_state_ext(#tok$1^38.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $phys_ptr_cast(P#_this_, ^Node), ^Node);
    }

  #exit:
}



const unique ^Mgr: $ctype;

axiom $def_struct_type(^Mgr, 1, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Mgr) } $inv2(#s1, #s2, #p, ^Mgr) == (($rd_phys_ptr(#s1, Mgr.except, #p, ^Node) == $rd_phys_ptr(#s2, Mgr.except, #p, ^Node) || $is_null($rd_phys_ptr(#s1, Mgr.except, #p, ^Node)) || $inv(#s2, $rd_phys_ptr(#s1, Mgr.except, #p, ^Node), ^Node)) && $inv_is_owner_approved(#s1, #s2, #p, Mgr.except) && (forall Q#n$1^56.29#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#n$1^56.29#dt1, ^Node), $owns(#s2, #p)) } { sk_hack($set_in($phys_ptr_cast(Q#n$1^56.29#dt1, ^Node), $owns(#s2, #p))) } $set_in($phys_ptr_cast(Q#n$1^56.29#dt1, ^Node), $owns(#s2, #p)) ==> $rd_spec_ptr(#s2, Node.m, $phys_ptr_cast(Q#n$1^56.29#dt1, ^Node), ^Mgr) == #p) && (forall Q#n$1^57.30#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr(#s2, Node.p, $phys_ptr_cast(Q#n$1^57.30#dt1, ^Node), ^Node), $owns(#s2, #p)) } $set_in($phys_ptr_cast(Q#n$1^57.30#dt1, ^Node), $owns(#s2, #p)) ==> $is_null($rd_phys_ptr(#s2, Node.p, $phys_ptr_cast(Q#n$1^57.30#dt1, ^Node), ^Node)) || $set_in($rd_phys_ptr(#s2, Node.p, $phys_ptr_cast(Q#n$1^57.30#dt1, ^Node), ^Node), $owns(#s2, #p))) && (forall Q#n$1^58.30#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr(#s2, Node.l, $phys_ptr_cast(Q#n$1^58.30#dt1, ^Node), ^Node), $owns(#s2, #p)) } $set_in($phys_ptr_cast(Q#n$1^58.30#dt1, ^Node), $owns(#s2, #p)) ==> $is_null($rd_phys_ptr(#s2, Node.l, $phys_ptr_cast(Q#n$1^58.30#dt1, ^Node), ^Node)) || $set_in($rd_phys_ptr(#s2, Node.l, $phys_ptr_cast(Q#n$1^58.30#dt1, ^Node), ^Node), $owns(#s2, #p))) && (forall Q#n$1^59.30#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr(#s2, Node.r, $phys_ptr_cast(Q#n$1^59.30#dt1, ^Node), ^Node), $owns(#s2, #p)) } $set_in($phys_ptr_cast(Q#n$1^59.30#dt1, ^Node), $owns(#s2, #p)) ==> $is_null($rd_phys_ptr(#s2, Node.r, $phys_ptr_cast(Q#n$1^59.30#dt1, ^Node), ^Node)) || $set_in($rd_phys_ptr(#s2, Node.r, $phys_ptr_cast(Q#n$1^59.30#dt1, ^Node), ^Node), $owns(#s2, #p))) && ($closed(#s1, #p) && !$closed(#s2, #p) ==> false)));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^Mgr)) } $in(q, $composite_extent(s, p, ^Mgr)) == (q == p));

const unique Mgr.except: $field;

axiom $def_ghost_field(^Mgr, Mgr.except, $ptr_to(^Node), true);

procedure Mgr#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $rd_phys_ptr(old($s), Mgr.except, $spec_ptr_cast(P#_this_, ^Mgr), ^Node) == $rd_phys_ptr($s, Mgr.except, $spec_ptr_cast(P#_this_, ^Mgr), ^Node) || $is_null($rd_phys_ptr(old($s), Mgr.except, $spec_ptr_cast(P#_this_, ^Mgr), ^Node)) || $inv($s, $rd_phys_ptr(old($s), Mgr.except, $spec_ptr_cast(P#_this_, ^Mgr), ^Node), ^Node);
  ensures $is_admissibility_check() ==> $inv_is_owner_approved(old($s), $s, $spec_ptr_cast(P#_this_, ^Mgr), Mgr.except);
  ensures $is_admissibility_check() ==> (forall Q#n$1^56.29#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#n$1^56.29#dt1, ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr))) } { sk_hack($set_in($phys_ptr_cast(Q#n$1^56.29#dt1, ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr)))) } $set_in($phys_ptr_cast(Q#n$1^56.29#dt1, ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr))) ==> $rd_spec_ptr($s, Node.m, $phys_ptr_cast(Q#n$1^56.29#dt1, ^Node), ^Mgr) == $spec_ptr_cast(P#_this_, ^Mgr));
  ensures $is_admissibility_check() ==> (forall Q#n$1^57.30#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr($s, Node.p, $phys_ptr_cast(Q#n$1^57.30#dt1, ^Node), ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr))) } $set_in($phys_ptr_cast(Q#n$1^57.30#dt1, ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr))) ==> $is_null($rd_phys_ptr($s, Node.p, $phys_ptr_cast(Q#n$1^57.30#dt1, ^Node), ^Node)) || $set_in($rd_phys_ptr($s, Node.p, $phys_ptr_cast(Q#n$1^57.30#dt1, ^Node), ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr))));
  ensures $is_admissibility_check() ==> (forall Q#n$1^58.30#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr($s, Node.l, $phys_ptr_cast(Q#n$1^58.30#dt1, ^Node), ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr))) } $set_in($phys_ptr_cast(Q#n$1^58.30#dt1, ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr))) ==> $is_null($rd_phys_ptr($s, Node.l, $phys_ptr_cast(Q#n$1^58.30#dt1, ^Node), ^Node)) || $set_in($rd_phys_ptr($s, Node.l, $phys_ptr_cast(Q#n$1^58.30#dt1, ^Node), ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr))));
  ensures $is_admissibility_check() ==> (forall Q#n$1^59.30#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr($s, Node.r, $phys_ptr_cast(Q#n$1^59.30#dt1, ^Node), ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr))) } $set_in($phys_ptr_cast(Q#n$1^59.30#dt1, ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr))) ==> $is_null($rd_phys_ptr($s, Node.r, $phys_ptr_cast(Q#n$1^59.30#dt1, ^Node), ^Node)) || $set_in($rd_phys_ptr($s, Node.r, $phys_ptr_cast(Q#n$1^59.30#dt1, ^Node), ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr))));
  ensures $is_admissibility_check() ==> $closed(old($s), $spec_ptr_cast(P#_this_, ^Mgr)) && !$closed($s, $spec_ptr_cast(P#_this_, ^Mgr)) ==> false;
  ensures $is_stuttering_check() ==> $rd_phys_ptr($s, Mgr.except, $spec_ptr_cast(P#_this_, ^Mgr), ^Node) == $rd_phys_ptr($s, Mgr.except, $spec_ptr_cast(P#_this_, ^Mgr), ^Node) || $is_null($rd_phys_ptr($s, Mgr.except, $spec_ptr_cast(P#_this_, ^Mgr), ^Node)) || $inv($s, $rd_phys_ptr($s, Mgr.except, $spec_ptr_cast(P#_this_, ^Mgr), ^Node), ^Node);
  ensures $is_stuttering_check() ==> $inv_is_owner_approved($s, $s, $spec_ptr_cast(P#_this_, ^Mgr), Mgr.except);
  ensures $is_stuttering_check() ==> $closed($s, $spec_ptr_cast(P#_this_, ^Mgr)) && !$closed($s, $spec_ptr_cast(P#_this_, ^Mgr)) ==> false;
  ensures $is_unwrap_check() ==> $rd_phys_ptr(old($s), Mgr.except, $spec_ptr_cast(P#_this_, ^Mgr), ^Node) == $rd_phys_ptr($s, Mgr.except, $spec_ptr_cast(P#_this_, ^Mgr), ^Node) || $is_null($rd_phys_ptr(old($s), Mgr.except, $spec_ptr_cast(P#_this_, ^Mgr), ^Node)) || $inv($s, $rd_phys_ptr(old($s), Mgr.except, $spec_ptr_cast(P#_this_, ^Mgr), ^Node), ^Node);
  ensures $is_unwrap_check() ==> $inv_is_owner_approved(old($s), $s, $spec_ptr_cast(P#_this_, ^Mgr), Mgr.except);
  ensures $is_unwrap_check() ==> (forall Q#n$1^56.29#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#n$1^56.29#dt1, ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr))) } { sk_hack($set_in($phys_ptr_cast(Q#n$1^56.29#dt1, ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr)))) } $set_in($phys_ptr_cast(Q#n$1^56.29#dt1, ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr))) ==> $rd_spec_ptr($s, Node.m, $phys_ptr_cast(Q#n$1^56.29#dt1, ^Node), ^Mgr) == $spec_ptr_cast(P#_this_, ^Mgr));
  ensures $is_unwrap_check() ==> (forall Q#n$1^57.30#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr($s, Node.p, $phys_ptr_cast(Q#n$1^57.30#dt1, ^Node), ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr))) } $set_in($phys_ptr_cast(Q#n$1^57.30#dt1, ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr))) ==> $is_null($rd_phys_ptr($s, Node.p, $phys_ptr_cast(Q#n$1^57.30#dt1, ^Node), ^Node)) || $set_in($rd_phys_ptr($s, Node.p, $phys_ptr_cast(Q#n$1^57.30#dt1, ^Node), ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr))));
  ensures $is_unwrap_check() ==> (forall Q#n$1^58.30#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr($s, Node.l, $phys_ptr_cast(Q#n$1^58.30#dt1, ^Node), ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr))) } $set_in($phys_ptr_cast(Q#n$1^58.30#dt1, ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr))) ==> $is_null($rd_phys_ptr($s, Node.l, $phys_ptr_cast(Q#n$1^58.30#dt1, ^Node), ^Node)) || $set_in($rd_phys_ptr($s, Node.l, $phys_ptr_cast(Q#n$1^58.30#dt1, ^Node), ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr))));
  ensures $is_unwrap_check() ==> (forall Q#n$1^59.30#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr($s, Node.r, $phys_ptr_cast(Q#n$1^59.30#dt1, ^Node), ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr))) } $set_in($phys_ptr_cast(Q#n$1^59.30#dt1, ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr))) ==> $is_null($rd_phys_ptr($s, Node.r, $phys_ptr_cast(Q#n$1^59.30#dt1, ^Node), ^Node)) || $set_in($rd_phys_ptr($s, Node.r, $phys_ptr_cast(Q#n$1^59.30#dt1, ^Node), ^Node), $owns($s, $spec_ptr_cast(P#_this_, ^Mgr))));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Mgr#adm(P#_this_: $ptr)
{
  var #wrTime$1^52.53: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^52.53, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^52.53, #loc._this_, $ptr_to_int(P#_this_), $spec_ptr_to(^Mgr));
    assume #wrTime$1^52.53 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^52.53, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($spec_ptr_cast(P#_this_, ^Mgr), ^Mgr);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon7:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $spec_ptr_cast(P#_this_, ^Mgr));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($spec_ptr_cast(P#_this_, ^Mgr));
        assume $good_state_ext(#tok$1^52.53, $s);
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
            assume $admissibility_pre($s, $spec_ptr_cast(P#_this_, ^Mgr));
        }
        else
        {
          anon9:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $spec_ptr_cast(P#_this_, ^Mgr));
        }

      anon11:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Mgr*)@null))
        call $havoc_others($spec_ptr_cast(P#_this_, ^Mgr), ^Mgr);
        assume $good_state_ext(#tok$1^52.53, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $spec_ptr_cast(P#_this_, ^Mgr), ^Mgr);
    }

  #exit:
}



axiom $is_owner_approved(^Mgr, Mgr.except);

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

procedure update(P#n: $ptr, P#v: int, SP#m: $ptr);
  requires $set_in($phys_ptr_cast(P#n, ^Node), $owns($s, $spec_ptr_cast(SP#m, ^Mgr)));
  requires $wrapped($s, $spec_ptr_cast(SP#m, ^Mgr), ^Mgr);
  requires $is_null($rd_phys_ptr($s, Mgr.except, $spec_ptr_cast(SP#m, ^Mgr), ^Node));
  modifies $s, $cev_pc;
  ensures $wrapped($s, $spec_ptr_cast(SP#m, ^Mgr), ^Mgr) && $is_null($rd_phys_ptr($s, Mgr.except, $spec_ptr_cast(SP#m, ^Mgr), ^Node));
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $spec_ptr_cast(SP#m, ^Mgr)));
  free ensures $call_transition(old($s), $s);



implementation update(P#n: $ptr, P#v: int, SP#m: $ptr)
{
  var ite#2: int where $in_range_i4(ite#2);
  var ite#1: int where $in_range_i4(ite#1);
  var beforeAtomicState#2: $state;
  var atomicObj#6: $ptr;
  var atomicObj#7: $ptr;
  var L#a: int where $in_range_i4(L#a);
  var L#b: int where $in_range_i4(L#b);
  var #wrTime$1^81.28: int;
  var loopState#1: $state;
  var beforeAtomicState#0: $state;
  var atomicObj#4: $ptr;
  var atomicObj#5: $ptr;
  var local.n: $ptr;
  var #wrTime$1^64.1: int;
  var #stackframe: int;

  anon16:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^64.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^64.1, #loc.n, $ptr_to_int(P#n), $ptr_to(^Node));
    assume $local_value_is($s, #tok$1^64.1, #loc.v, P#v, ^^i4);
    assume $local_value_is($s, #tok$1^64.1, #loc.m, $ptr_to_int(SP#m), $spec_ptr_to(^Mgr));
    assume #wrTime$1^64.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^64.1, (lambda #p: $ptr :: #p == $spec_ptr_cast(SP#m, ^Mgr)));
    assume $thread_owned($s, $spec_ptr_cast(SP#m, ^Mgr));
    // assume true; 
    assume true;
    // assume @in_range_i4(v); 
    assume $in_range_i4(P#v);
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // struct Node* local.n; 
    assume $local_value_is($s, #tok$2^0.0, #loc.local.n, $ptr_to_int(local.n), $ptr_to(^Node));
    // local.n := n; 
    local.n := $phys_ptr_cast(P#n, ^Node);
    assume $local_value_is($s, #tok$2^0.0, #loc.local.n, $ptr_to_int(local.n), $ptr_to(^Node));
    // assert @_vcc_in_domain(@state, m, m); 
    assert $in_domain_lab($s, $spec_ptr_cast(SP#m, ^Mgr), $spec_ptr_cast(SP#m, ^Mgr), l#public);
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^69.19, $s);
    atomicObj#5 := $spec_ptr_cast(SP#m, ^Mgr);
    atomicObj#4 := $phys_ptr_cast(local.n, ^Node);
    assert $closed($s, atomicObj#4);
    assume $inv($s, atomicObj#4, ^Node);
    assert $closed($s, atomicObj#5);
    assume $inv($s, atomicObj#5, ^Mgr);
    beforeAtomicState#0 := $s;
    // assert @prim_writes_check((local.n->val)); 
    assert $set_in($dot($phys_ptr_cast(local.n, ^Node), Node.val), $volatile_span($s, atomicObj#4)) || $set_in($dot($phys_ptr_cast(local.n, ^Node), Node.val), $volatile_span($s, atomicObj#5)) || $writable_prim($s, #wrTime$1^64.1, $dot($phys_ptr_cast(local.n, ^Node), Node.val));
    // *(local.n->val) := v; 
    call $write_int(Node.val, $phys_ptr_cast(local.n, ^Node), P#v);
    assume $good_state_ext(#tok$1^70.5, $s);
    // assert @prim_writes_check((m->except)); 
    assert $set_in($dot($spec_ptr_cast(SP#m, ^Mgr), Mgr.except), $volatile_span($s, atomicObj#4)) || $set_in($dot($spec_ptr_cast(SP#m, ^Mgr), Mgr.except), $volatile_span($s, atomicObj#5)) || $writable_prim($s, #wrTime$1^64.1, $dot($spec_ptr_cast(SP#m, ^Mgr), Mgr.except));
    // *(m->except) := local.n; 
    call $write_int(Mgr.except, $spec_ptr_cast(SP#m, ^Mgr), $ptr_to_int($phys_ptr_cast(local.n, ^Node)));
    assume $good_state_ext(#tok$1^72.7, $s);
    // assert @writes_check(m); 
    assert $top_writable($s, #wrTime$1^64.1, $spec_ptr_cast(SP#m, ^Mgr));
    // stmt _vcc_bump_volatile_version(m); 
    call $bump_volatile_version($spec_ptr_cast(SP#m, ^Mgr));
    assume $good_state_ext(#tok$1^73.23, $s);
    assert $set_eq($owns($s, atomicObj#4), $set_empty());
    assert $closed($s, $rd_spec_ptr($s, Node.m, atomicObj#4, ^Mgr));
    assert $non_null($rd_phys_ptr($s, Node.l, atomicObj#4, ^Node)) ==> $rd_phys_ptr($s, Node.l, atomicObj#4, ^Node) != atomicObj#4;
    assert $non_null($rd_phys_ptr($s, Node.l, atomicObj#4, ^Node)) ==> $rd_phys_ptr($s, Node.p, $rd_phys_ptr($s, Node.l, atomicObj#4, ^Node), ^Node) == atomicObj#4;
    assert $non_null($rd_phys_ptr($s, Node.l, atomicObj#4, ^Node)) ==> $rd_spec_ptr($s, Node.m, $rd_phys_ptr($s, Node.l, atomicObj#4, ^Node), ^Mgr) == $rd_spec_ptr($s, Node.m, atomicObj#4, ^Mgr);
    assert $non_null($rd_phys_ptr($s, Node.l, atomicObj#4, ^Node)) ==> $closed($s, $rd_phys_ptr($s, Node.l, atomicObj#4, ^Node));
    assert $non_null($rd_phys_ptr($s, Node.r, atomicObj#4, ^Node)) ==> $rd_phys_ptr($s, Node.r, atomicObj#4, ^Node) != atomicObj#4;
    assert $non_null($rd_phys_ptr($s, Node.r, atomicObj#4, ^Node)) ==> $rd_phys_ptr($s, Node.p, $rd_phys_ptr($s, Node.r, atomicObj#4, ^Node), ^Node) == atomicObj#4;
    assert $non_null($rd_phys_ptr($s, Node.r, atomicObj#4, ^Node)) ==> $rd_spec_ptr($s, Node.m, $rd_phys_ptr($s, Node.r, atomicObj#4, ^Node), ^Mgr) == $rd_spec_ptr($s, Node.m, atomicObj#4, ^Mgr);
    assert $non_null($rd_phys_ptr($s, Node.r, atomicObj#4, ^Node)) ==> $closed($s, $rd_phys_ptr($s, Node.r, atomicObj#4, ^Node));
    assert atomicObj#4 == $rd_phys_ptr($s, Mgr.except, $rd_spec_ptr($s, Node.m, atomicObj#4, ^Mgr), ^Node) || $rd_inv($s, Node.sum, atomicObj#4) == $unchk_add(^^i4, $unchk_add(^^i4, $rd_inv($s, Node.val, atomicObj#4), (if $is_null($rd_phys_ptr($s, Node.l, atomicObj#4, ^Node)) then 0 else $rd_inv($s, Node.sum, $rd_phys_ptr($s, Node.l, atomicObj#4, ^Node)))), (if $is_null($rd_phys_ptr($s, Node.r, atomicObj#4, ^Node)) then 0 else $rd_inv($s, Node.sum, $rd_phys_ptr($s, Node.r, atomicObj#4, ^Node))));
    assert $rd_inv(beforeAtomicState#0, Node.sum, atomicObj#4) == $rd_inv($s, Node.sum, atomicObj#4) || $inv($s, $rd_phys_ptr($s, Node.p, atomicObj#4, ^Node), ^Node) || $is_null($rd_phys_ptr($s, Node.p, atomicObj#4, ^Node));
    assert $closed(beforeAtomicState#0, atomicObj#4) && !$closed($s, atomicObj#4) ==> false;
    assert $rd_phys_ptr(beforeAtomicState#0, Mgr.except, atomicObj#5, ^Node) == $rd_phys_ptr($s, Mgr.except, atomicObj#5, ^Node) || $is_null($rd_phys_ptr(beforeAtomicState#0, Mgr.except, atomicObj#5, ^Node)) || $inv($s, $rd_phys_ptr(beforeAtomicState#0, Mgr.except, atomicObj#5, ^Node), ^Node);
    assert $inv_is_owner_approved(beforeAtomicState#0, $s, atomicObj#5, Mgr.except);
    assert (forall Q#n$1^56.29#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#n$1^56.29#dt1, ^Node), $owns($s, atomicObj#5)) } { sk_hack($set_in($phys_ptr_cast(Q#n$1^56.29#dt1, ^Node), $owns($s, atomicObj#5))) } $set_in($phys_ptr_cast(Q#n$1^56.29#dt1, ^Node), $owns($s, atomicObj#5)) ==> $rd_spec_ptr($s, Node.m, $phys_ptr_cast(Q#n$1^56.29#dt1, ^Node), ^Mgr) == atomicObj#5);
    assert (forall Q#n$1^57.30#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr($s, Node.p, $phys_ptr_cast(Q#n$1^57.30#dt1, ^Node), ^Node), $owns($s, atomicObj#5)) } $set_in($phys_ptr_cast(Q#n$1^57.30#dt1, ^Node), $owns($s, atomicObj#5)) ==> $is_null($rd_phys_ptr($s, Node.p, $phys_ptr_cast(Q#n$1^57.30#dt1, ^Node), ^Node)) || $set_in($rd_phys_ptr($s, Node.p, $phys_ptr_cast(Q#n$1^57.30#dt1, ^Node), ^Node), $owns($s, atomicObj#5)));
    assert (forall Q#n$1^58.30#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr($s, Node.l, $phys_ptr_cast(Q#n$1^58.30#dt1, ^Node), ^Node), $owns($s, atomicObj#5)) } $set_in($phys_ptr_cast(Q#n$1^58.30#dt1, ^Node), $owns($s, atomicObj#5)) ==> $is_null($rd_phys_ptr($s, Node.l, $phys_ptr_cast(Q#n$1^58.30#dt1, ^Node), ^Node)) || $set_in($rd_phys_ptr($s, Node.l, $phys_ptr_cast(Q#n$1^58.30#dt1, ^Node), ^Node), $owns($s, atomicObj#5)));
    assert (forall Q#n$1^59.30#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr($s, Node.r, $phys_ptr_cast(Q#n$1^59.30#dt1, ^Node), ^Node), $owns($s, atomicObj#5)) } $set_in($phys_ptr_cast(Q#n$1^59.30#dt1, ^Node), $owns($s, atomicObj#5)) ==> $is_null($rd_phys_ptr($s, Node.r, $phys_ptr_cast(Q#n$1^59.30#dt1, ^Node), ^Node)) || $set_in($rd_phys_ptr($s, Node.r, $phys_ptr_cast(Q#n$1^59.30#dt1, ^Node), ^Node), $owns($s, atomicObj#5)));
    assert $closed(beforeAtomicState#0, atomicObj#5) && !$closed($s, atomicObj#5) ==> false;
    assume $full_stop_ext(#tok$1^69.19, $s);
    call $bump_timestamp();
    assume $full_stop_ext(#tok$1^81.28, $s);
    loopState#1 := $s;
    assume #wrTime$1^81.28 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^81.28, (lambda #p: $ptr :: #p == $spec_ptr_cast(SP#m, ^Mgr)));
    assert (forall #loopWrites^$1^81.28: $ptr :: { $dont_instantiate(#loopWrites^$1^81.28) } $listed_in_writes($s, #wrTime$1^81.28, #loopWrites^$1^81.28) ==> $top_writable($s, #wrTime$1^64.1, #loopWrites^$1^81.28));
    while (true)
      invariant $rd_phys_ptr($s, Mgr.except, $spec_ptr_cast(SP#m, ^Mgr), ^Node) == $phys_ptr_cast(local.n, ^Node);
      invariant $wrapped($s, $spec_ptr_cast(SP#m, ^Mgr), ^Mgr);
      invariant $is_null($phys_ptr_cast(local.n, ^Node)) || $set_in($phys_ptr_cast(local.n, ^Node), $owns($s, $spec_ptr_cast(SP#m, ^Mgr)));
    {
      anon15:
        assume $modifies(loopState#1, $s, (lambda #p: $ptr :: #p == $spec_ptr_cast(SP#m, ^Mgr)));
        assume $timestamp_post(loopState#1, $s);
        assume $full_stop_ext(#tok$1^77.3, $s);
        assume $local_value_is($s, #tok$1^77.3, #loc.local.n, $ptr_to_int(local.n), $ptr_to(^Node));
        assume $local_value_is($s, #tok$1^77.3, #loc.m, $ptr_to_int(SP#m), $spec_ptr_to(^Mgr));
        assume $local_value_is($s, #tok$1^77.3, #loc.v, P#v, ^^i4);
        assume $local_value_is($s, #tok$1^77.3, #loc.n, $ptr_to_int(P#n), $ptr_to(^Node));
        assume true;
        // if (@_vcc_ptr_neq_null(local.n)) ...
        if ($non_null($phys_ptr_cast(local.n, ^Node)))
        {
          anon13:
            // int32_t b; 
            assume $local_value_is($s, #tok$1^83.5, #loc.b, L#b, ^^i4);
            // int32_t a; 
            assume $local_value_is($s, #tok$1^83.5, #loc.a, L#a, ^^i4);
            // var int32_t a
            // var int32_t b
            // assert @_vcc_in_domain(@state, m, m); 
            assert $in_domain_lab($s, $spec_ptr_cast(SP#m, ^Mgr), $spec_ptr_cast(SP#m, ^Mgr), l#public);
            // assume @_vcc_in_domain(@state, m, m); 
            assume $in_domain_lab($s, $spec_ptr_cast(SP#m, ^Mgr), $spec_ptr_cast(SP#m, ^Mgr), l#public);
            // assert @_vcc_in_domain(@state, local.n, m); 
            assert $in_domain_lab($s, $phys_ptr_cast(local.n, ^Node), $spec_ptr_cast(SP#m, ^Mgr), l#public);
            // assume @_vcc_in_domain(@state, local.n, m); 
            assume $in_domain_lab($s, $phys_ptr_cast(local.n, ^Node), $spec_ptr_cast(SP#m, ^Mgr), l#public);
            assume true;
            call $atomic_havoc();
            assume $full_stop_ext(#tok$1^87.21, $s);
            atomicObj#7 := $spec_ptr_cast(SP#m, ^Mgr);
            atomicObj#6 := $phys_ptr_cast(local.n, ^Node);
            assert $closed($s, atomicObj#6);
            assume $inv($s, atomicObj#6, ^Node);
            assert $closed($s, atomicObj#7);
            assume $inv($s, atomicObj#7, ^Mgr);
            beforeAtomicState#2 := $s;
            // assert ||(@_vcc_ptr_eq_null(*((local.n->p))), @_vcc_in_domain(@state, *((local.n->p)), m)); 
            assert $is_null($rd_phys_ptr($s, Node.p, $phys_ptr_cast(local.n, ^Node), ^Node)) || $in_domain_lab($s, $rd_phys_ptr($s, Node.p, $phys_ptr_cast(local.n, ^Node), ^Node), $spec_ptr_cast(SP#m, ^Mgr), l#public);
            // assume ||(@_vcc_ptr_eq_null(*((local.n->p))), @_vcc_in_domain(@state, *((local.n->p)), m)); 
            assume $is_null($rd_phys_ptr($s, Node.p, $phys_ptr_cast(local.n, ^Node), ^Node)) || $in_domain_lab($s, $rd_phys_ptr($s, Node.p, $phys_ptr_cast(local.n, ^Node), ^Node), $spec_ptr_cast(SP#m, ^Mgr), l#public);
            // assume &&(==(a, *((*((local.n->l))->sum))), ==(b, *((*((local.n->r))->sum)))); 
            assume L#a == $rd_inv($s, Node.sum, $rd_phys_ptr($s, Node.l, $phys_ptr_cast(local.n, ^Node), ^Node)) && L#b == $rd_inv($s, Node.sum, $rd_phys_ptr($s, Node.r, $phys_ptr_cast(local.n, ^Node), ^Node));
            // int32_t ite#1; 
            assume $local_value_is($s, #tok$1^90.54, #loc.ite#1, ite#1, ^^i4);
            // assert @reads_check_normal((local.n->l)); 
            assert $thread_local($s, $phys_ptr_cast(local.n, ^Node)) || $phys_ptr_cast(local.n, ^Node) == atomicObj#6 || $phys_ptr_cast(local.n, ^Node) == atomicObj#7;
            // ite#1 := @ite(@_vcc_ptr_eq_null(*((local.n->l))), 0, a); 
            ite#1 := (if $is_null($rd_phys_ptr($s, Node.l, $phys_ptr_cast(local.n, ^Node), ^Node)) then 0 else L#a);
            assume $local_value_is($s, #tok$1^90.54, #loc.ite#1, ite#1, ^^i4);
            // int32_t ite#2; 
            assume $local_value_is($s, #tok$1^90.86, #loc.ite#2, ite#2, ^^i4);
            // assert @reads_check_normal((local.n->r)); 
            assert $thread_local($s, $phys_ptr_cast(local.n, ^Node)) || $phys_ptr_cast(local.n, ^Node) == atomicObj#6 || $phys_ptr_cast(local.n, ^Node) == atomicObj#7;
            // ite#2 := @ite(@_vcc_ptr_eq_null(*((local.n->r))), 0, b); 
            ite#2 := (if $is_null($rd_phys_ptr($s, Node.r, $phys_ptr_cast(local.n, ^Node), ^Node)) then 0 else L#b);
            assume $local_value_is($s, #tok$1^90.86, #loc.ite#2, ite#2, ^^i4);
            // assert @prim_writes_check((local.n->sum)); 
            assert $set_in($dot($phys_ptr_cast(local.n, ^Node), Node.sum), $volatile_span($s, atomicObj#6)) || $set_in($dot($phys_ptr_cast(local.n, ^Node), Node.sum), $volatile_span($s, atomicObj#7)) || $writable_prim($s, #wrTime$1^81.28, $dot($phys_ptr_cast(local.n, ^Node), Node.sum));
            // assert @reads_check_normal((local.n->val)); 
            assert $mutable($s, $phys_ptr_cast(local.n, ^Node)) || $phys_ptr_cast(local.n, ^Node) == atomicObj#6 || $phys_ptr_cast(local.n, ^Node) == atomicObj#7;
            // *(local.n->sum) := unchecked+(unchecked+(*((local.n->val)), ite#1), ite#2); 
            call $write_int(Node.sum, $phys_ptr_cast(local.n, ^Node), $unchk_add(^^i4, $unchk_add(^^i4, $rd_inv($s, Node.val, $phys_ptr_cast(local.n, ^Node)), ite#1), ite#2));
            assume $good_state_ext(#tok$1^90.7, $s);
            // assert @prim_writes_check((m->except)); 
            assert $set_in($dot($spec_ptr_cast(SP#m, ^Mgr), Mgr.except), $volatile_span($s, atomicObj#6)) || $set_in($dot($spec_ptr_cast(SP#m, ^Mgr), Mgr.except), $volatile_span($s, atomicObj#7)) || $writable_prim($s, #wrTime$1^81.28, $dot($spec_ptr_cast(SP#m, ^Mgr), Mgr.except));
            // assert @reads_check_normal((local.n->p)); 
            assert $thread_local($s, $phys_ptr_cast(local.n, ^Node)) || $phys_ptr_cast(local.n, ^Node) == atomicObj#6 || $phys_ptr_cast(local.n, ^Node) == atomicObj#7;
            // *(m->except) := *((local.n->p)); 
            call $write_int(Mgr.except, $spec_ptr_cast(SP#m, ^Mgr), $ptr_to_int($rd_phys_ptr($s, Node.p, $phys_ptr_cast(local.n, ^Node), ^Node)));
            assume $good_state_ext(#tok$1^92.8, $s);
            // assert @writes_check(m); 
            assert $top_writable($s, #wrTime$1^81.28, $spec_ptr_cast(SP#m, ^Mgr));
            // stmt _vcc_bump_volatile_version(m); 
            call $bump_volatile_version($spec_ptr_cast(SP#m, ^Mgr));
            assume $good_state_ext(#tok$1^93.24, $s);
            assert $set_eq($owns($s, atomicObj#6), $set_empty());
            assert $closed($s, $rd_spec_ptr($s, Node.m, atomicObj#6, ^Mgr));
            assert $non_null($rd_phys_ptr($s, Node.l, atomicObj#6, ^Node)) ==> $rd_phys_ptr($s, Node.l, atomicObj#6, ^Node) != atomicObj#6;
            assert $non_null($rd_phys_ptr($s, Node.l, atomicObj#6, ^Node)) ==> $rd_phys_ptr($s, Node.p, $rd_phys_ptr($s, Node.l, atomicObj#6, ^Node), ^Node) == atomicObj#6;
            assert $non_null($rd_phys_ptr($s, Node.l, atomicObj#6, ^Node)) ==> $rd_spec_ptr($s, Node.m, $rd_phys_ptr($s, Node.l, atomicObj#6, ^Node), ^Mgr) == $rd_spec_ptr($s, Node.m, atomicObj#6, ^Mgr);
            assert $non_null($rd_phys_ptr($s, Node.l, atomicObj#6, ^Node)) ==> $closed($s, $rd_phys_ptr($s, Node.l, atomicObj#6, ^Node));
            assert $non_null($rd_phys_ptr($s, Node.r, atomicObj#6, ^Node)) ==> $rd_phys_ptr($s, Node.r, atomicObj#6, ^Node) != atomicObj#6;
            assert $non_null($rd_phys_ptr($s, Node.r, atomicObj#6, ^Node)) ==> $rd_phys_ptr($s, Node.p, $rd_phys_ptr($s, Node.r, atomicObj#6, ^Node), ^Node) == atomicObj#6;
            assert $non_null($rd_phys_ptr($s, Node.r, atomicObj#6, ^Node)) ==> $rd_spec_ptr($s, Node.m, $rd_phys_ptr($s, Node.r, atomicObj#6, ^Node), ^Mgr) == $rd_spec_ptr($s, Node.m, atomicObj#6, ^Mgr);
            assert $non_null($rd_phys_ptr($s, Node.r, atomicObj#6, ^Node)) ==> $closed($s, $rd_phys_ptr($s, Node.r, atomicObj#6, ^Node));
            assert atomicObj#6 == $rd_phys_ptr($s, Mgr.except, $rd_spec_ptr($s, Node.m, atomicObj#6, ^Mgr), ^Node) || $rd_inv($s, Node.sum, atomicObj#6) == $unchk_add(^^i4, $unchk_add(^^i4, $rd_inv($s, Node.val, atomicObj#6), (if $is_null($rd_phys_ptr($s, Node.l, atomicObj#6, ^Node)) then 0 else $rd_inv($s, Node.sum, $rd_phys_ptr($s, Node.l, atomicObj#6, ^Node)))), (if $is_null($rd_phys_ptr($s, Node.r, atomicObj#6, ^Node)) then 0 else $rd_inv($s, Node.sum, $rd_phys_ptr($s, Node.r, atomicObj#6, ^Node))));
            assert $rd_inv(beforeAtomicState#2, Node.sum, atomicObj#6) == $rd_inv($s, Node.sum, atomicObj#6) || $inv($s, $rd_phys_ptr($s, Node.p, atomicObj#6, ^Node), ^Node) || $is_null($rd_phys_ptr($s, Node.p, atomicObj#6, ^Node));
            assert $closed(beforeAtomicState#2, atomicObj#6) && !$closed($s, atomicObj#6) ==> false;
            assert $rd_phys_ptr(beforeAtomicState#2, Mgr.except, atomicObj#7, ^Node) == $rd_phys_ptr($s, Mgr.except, atomicObj#7, ^Node) || $is_null($rd_phys_ptr(beforeAtomicState#2, Mgr.except, atomicObj#7, ^Node)) || $inv($s, $rd_phys_ptr(beforeAtomicState#2, Mgr.except, atomicObj#7, ^Node), ^Node);
            assert $inv_is_owner_approved(beforeAtomicState#2, $s, atomicObj#7, Mgr.except);
            assert (forall Q#n$1^56.29#dt1: $ptr :: {:weight 10} { $set_in($phys_ptr_cast(Q#n$1^56.29#dt1, ^Node), $owns($s, atomicObj#7)) } { sk_hack($set_in($phys_ptr_cast(Q#n$1^56.29#dt1, ^Node), $owns($s, atomicObj#7))) } $set_in($phys_ptr_cast(Q#n$1^56.29#dt1, ^Node), $owns($s, atomicObj#7)) ==> $rd_spec_ptr($s, Node.m, $phys_ptr_cast(Q#n$1^56.29#dt1, ^Node), ^Mgr) == atomicObj#7);
            assert (forall Q#n$1^57.30#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr($s, Node.p, $phys_ptr_cast(Q#n$1^57.30#dt1, ^Node), ^Node), $owns($s, atomicObj#7)) } $set_in($phys_ptr_cast(Q#n$1^57.30#dt1, ^Node), $owns($s, atomicObj#7)) ==> $is_null($rd_phys_ptr($s, Node.p, $phys_ptr_cast(Q#n$1^57.30#dt1, ^Node), ^Node)) || $set_in($rd_phys_ptr($s, Node.p, $phys_ptr_cast(Q#n$1^57.30#dt1, ^Node), ^Node), $owns($s, atomicObj#7)));
            assert (forall Q#n$1^58.30#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr($s, Node.l, $phys_ptr_cast(Q#n$1^58.30#dt1, ^Node), ^Node), $owns($s, atomicObj#7)) } $set_in($phys_ptr_cast(Q#n$1^58.30#dt1, ^Node), $owns($s, atomicObj#7)) ==> $is_null($rd_phys_ptr($s, Node.l, $phys_ptr_cast(Q#n$1^58.30#dt1, ^Node), ^Node)) || $set_in($rd_phys_ptr($s, Node.l, $phys_ptr_cast(Q#n$1^58.30#dt1, ^Node), ^Node), $owns($s, atomicObj#7)));
            assert (forall Q#n$1^59.30#dt1: $ptr :: {:weight 10} { $set_in($rd_phys_ptr($s, Node.r, $phys_ptr_cast(Q#n$1^59.30#dt1, ^Node), ^Node), $owns($s, atomicObj#7)) } $set_in($phys_ptr_cast(Q#n$1^59.30#dt1, ^Node), $owns($s, atomicObj#7)) ==> $is_null($rd_phys_ptr($s, Node.r, $phys_ptr_cast(Q#n$1^59.30#dt1, ^Node), ^Node)) || $set_in($rd_phys_ptr($s, Node.r, $phys_ptr_cast(Q#n$1^59.30#dt1, ^Node), ^Node), $owns($s, atomicObj#7)));
            assert $closed(beforeAtomicState#2, atomicObj#7) && !$closed($s, atomicObj#7) ==> false;
            assume $full_stop_ext(#tok$1^87.21, $s);
            // assert @reads_check_normal((local.n->p)); 
            assert $thread_local($s, $phys_ptr_cast(local.n, ^Node));
            // local.n := *((local.n->p)); 
            local.n := $rd_phys_ptr($s, Node.p, $phys_ptr_cast(local.n, ^Node), ^Node);
            assume $local_value_is($s, #tok$1^96.5, #loc.local.n, $ptr_to_int(local.n), $ptr_to(^Node));
        }
        else
        {
          anon14:
            // goto #break_3; 
            goto #break_3;
        }

      #continue_3:
        assume true;
    }

  anon17:
    assume $full_stop_ext(#tok$1^77.3, $s);

  #break_3:
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



const unique l#public: $label;

const unique #tok$1^96.5: $token;

const unique #tok$1^87.21: $token;

const unique #tok$1^93.24: $token;

const unique #tok$1^92.8: $token;

const unique #tok$1^90.7: $token;

const unique #loc.ite#2: $token;

const unique #tok$1^90.86: $token;

const unique #loc.ite#1: $token;

const unique #tok$1^90.54: $token;

const unique #loc.a: $token;

const unique #loc.b: $token;

const unique #tok$1^83.5: $token;

const unique #tok$1^77.3: $token;

const unique #tok$1^81.28: $token;

const unique #tok$1^69.19: $token;

const unique #tok$1^73.23: $token;

const unique #tok$1^72.7: $token;

const unique #tok$1^70.5: $token;

const unique #loc.local.n: $token;

const unique #tok$2^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(2, #file^?3Cno?20file?3E);

const unique #loc.m: $token;

const unique #loc.v: $token;

const unique #loc.n: $token;

const unique #tok$1^64.1: $token;

const unique #tok$1^52.53: $token;

const unique #loc._this_: $token;

const unique #tok$1^38.1: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvacid?2D0?5CComposite.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvacid?2D0?5CComposite.c);

const unique #distTp2: $ctype;

axiom #distTp2 == $spec_ptr_to(^Mgr);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^Node);
