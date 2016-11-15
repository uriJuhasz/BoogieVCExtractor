axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

const unique ^X: $ctype;

axiom $is_span_sequential(^X);

axiom $def_struct_type(^X, 4, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^X) } $inv2(#s1, #s2, #p, ^X) == $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^X)) } $in(q, $composite_extent(s, p, ^X)) == (q == p));

const unique X.y: $field;

axiom $def_phys_field(^X, X.y, ^^i4, false, 0);

const unique ^Data: $ctype;

axiom $def_struct_type(^Data, 4, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Data) } $inv2(#s1, #s2, #p, ^Data) == ($set_eq($owns(#s2, #p), $set_empty()) && ($closed(#s1, #p) && !$closed(#s2, #p) ==> (forall Q#h$1^9.47#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv(#s2, Data.handles, #p)), $phys_ptr_cast(Q#h$1^9.47#dt1, ^Handle)) } !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv(#s2, Data.handles, #p)), $phys_ptr_cast(Q#h$1^9.47#dt1, ^Handle)))) && $inv_is_owner_approved(#s1, #s2, #p, Data.handles) && (forall Q#h$1^12.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv(#s1, Data.handles, #p)), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) } { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv(#s2, Data.handles, #p)), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) } $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv(#s1, Data.handles, #p)), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) && !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv(#s2, Data.handles, #p)), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) ==> !$closed(#s2, $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)))));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^Data)) } $in(q, $composite_extent(s, p, ^Data)) == (q == p));

const unique Data.dummy: $field;

axiom $def_phys_field(^Data, Data.dummy, ^^i4, false, 0);

const unique Data.handles: $field;

axiom $def_ghost_field(^Data, Data.handles, $map_t($ptr_to(^Handle), ^^bool), true);

procedure Data#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $set_eq($owns($s, $phys_ptr_cast(P#_this_, ^Data)), $set_empty());
  ensures $is_admissibility_check() ==> $closed(old($s), $phys_ptr_cast(P#_this_, ^Data)) && !$closed($s, $phys_ptr_cast(P#_this_, ^Data)) ==> (forall Q#h$1^9.47#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $phys_ptr_cast(P#_this_, ^Data))), $phys_ptr_cast(Q#h$1^9.47#dt1, ^Handle)) } !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $phys_ptr_cast(P#_this_, ^Data))), $phys_ptr_cast(Q#h$1^9.47#dt1, ^Handle)));
  ensures $is_admissibility_check() ==> $inv_is_owner_approved(old($s), $s, $phys_ptr_cast(P#_this_, ^Data), Data.handles);
  ensures $is_admissibility_check() ==> (forall Q#h$1^12.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv(old($s), Data.handles, $phys_ptr_cast(P#_this_, ^Data))), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) } { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $phys_ptr_cast(P#_this_, ^Data))), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) } $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv(old($s), Data.handles, $phys_ptr_cast(P#_this_, ^Data))), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) && !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $phys_ptr_cast(P#_this_, ^Data))), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) ==> !$closed($s, $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)));
  ensures $is_stuttering_check() ==> $closed($s, $phys_ptr_cast(P#_this_, ^Data)) && !$closed($s, $phys_ptr_cast(P#_this_, ^Data)) ==> (forall Q#h$1^9.47#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $phys_ptr_cast(P#_this_, ^Data))), $phys_ptr_cast(Q#h$1^9.47#dt1, ^Handle)) } !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $phys_ptr_cast(P#_this_, ^Data))), $phys_ptr_cast(Q#h$1^9.47#dt1, ^Handle)));
  ensures $is_stuttering_check() ==> $inv_is_owner_approved($s, $s, $phys_ptr_cast(P#_this_, ^Data), Data.handles);
  ensures $is_stuttering_check() ==> (forall Q#h$1^12.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $phys_ptr_cast(P#_this_, ^Data))), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) } $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $phys_ptr_cast(P#_this_, ^Data))), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) && !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $phys_ptr_cast(P#_this_, ^Data))), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) ==> !$closed($s, $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)));
  ensures $is_unwrap_check() ==> $set_eq($owns($s, $phys_ptr_cast(P#_this_, ^Data)), $set_empty());
  ensures $is_unwrap_check() ==> $inv_is_owner_approved(old($s), $s, $phys_ptr_cast(P#_this_, ^Data), Data.handles);
  ensures $is_unwrap_check() ==> (forall Q#h$1^12.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv(old($s), Data.handles, $phys_ptr_cast(P#_this_, ^Data))), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) } { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $phys_ptr_cast(P#_this_, ^Data))), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) } $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv(old($s), Data.handles, $phys_ptr_cast(P#_this_, ^Data))), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) && !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $phys_ptr_cast(P#_this_, ^Data))), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) ==> !$closed($s, $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Data#adm(P#_this_: $ptr)
{
  var #wrTime$1^6.1: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^6.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^6.1, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^Data));
    assume #wrTime$1^6.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^6.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($phys_ptr_cast(P#_this_, ^Data), ^Data);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $phys_ptr_cast(P#_this_, ^Data));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($phys_ptr_cast(P#_this_, ^Data));
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
            assume $admissibility_pre($s, $phys_ptr_cast(P#_this_, ^Data));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $phys_ptr_cast(P#_this_, ^Data));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Data*)@null))
        call $havoc_others($phys_ptr_cast(P#_this_, ^Data), ^Data);
        assume $good_state_ext(#tok$1^6.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $phys_ptr_cast(P#_this_, ^Data), ^Data);
    }

  #exit:
}



axiom $is_owner_approved(^Data, Data.handles);

const unique ^Handle: $ctype;

axiom $is_span_sequential(^Handle);

axiom $def_struct_type(^Handle, 4, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Handle) } $inv2(#s1, #s2, #p, ^Handle) == ($set_eq($owns(#s2, #p), $set_empty()) && $closed(#s2, $rd_phys_ptr(#s2, Handle.data, #p, ^Data)) && $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv(#s2, Data.handles, $rd_phys_ptr(#s2, Handle.data, #p, ^Data))), #p)));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^Handle)) } $in(q, $composite_extent(s, p, ^Handle)) == (q == p));

const unique Handle.dummy: $field;

axiom $def_phys_field(^Handle, Handle.dummy, ^^i4, false, 0);

const unique Handle.data: $field;

axiom $def_ghost_field(^Handle, Handle.data, $ptr_to(^Data), false);

procedure Handle#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $set_eq($owns($s, $phys_ptr_cast(P#_this_, ^Handle)), $set_empty());
  ensures $is_admissibility_check() ==> $closed($s, $rd_phys_ptr($s, Handle.data, $phys_ptr_cast(P#_this_, ^Handle), ^Data));
  ensures $is_admissibility_check() ==> $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $rd_phys_ptr($s, Handle.data, $phys_ptr_cast(P#_this_, ^Handle), ^Data))), $phys_ptr_cast(P#_this_, ^Handle));
  ensures $is_unwrap_check() ==> $set_eq($owns($s, $phys_ptr_cast(P#_this_, ^Handle)), $set_empty());
  ensures $is_unwrap_check() ==> $closed($s, $rd_phys_ptr($s, Handle.data, $phys_ptr_cast(P#_this_, ^Handle), ^Data));
  ensures $is_unwrap_check() ==> $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $rd_phys_ptr($s, Handle.data, $phys_ptr_cast(P#_this_, ^Handle), ^Data))), $phys_ptr_cast(P#_this_, ^Handle));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Handle#adm(P#_this_: $ptr)
{
  var #wrTime$1^15.1: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^15.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^15.1, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^Handle));
    assume #wrTime$1^15.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^15.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($phys_ptr_cast(P#_this_, ^Handle), ^Handle);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon7:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $phys_ptr_cast(P#_this_, ^Handle));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($phys_ptr_cast(P#_this_, ^Handle));
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
            assume $admissibility_pre($s, $phys_ptr_cast(P#_this_, ^Handle));
        }
        else
        {
          anon9:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $phys_ptr_cast(P#_this_, ^Handle));
        }

      anon11:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Handle*)@null))
        call $havoc_others($phys_ptr_cast(P#_this_, ^Handle), ^Handle);
        assume $good_state_ext(#tok$1^15.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $phys_ptr_cast(P#_this_, ^Handle), ^Handle);
    }

  #exit:
}



const unique ^Container: $ctype;

axiom $is_span_sequential(^Container);

axiom $def_struct_type(^Container, 12, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Container) } $inv2(#s1, #s2, #p, ^Container) == ($dot(#p, Container.d) == $dot(#p, Container.d) && $keeps(#s2, #p, $dot(#p, Container.d)) && (forall Q#hh$1^69.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv(#s2, Data.handles, $dot(#p, Container.d))), $phys_ptr_cast(Q#hh$1^69.29#dt1, ^Handle)) } $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv(#s2, Data.handles, $dot(#p, Container.d))), $phys_ptr_cast(Q#hh$1^69.29#dt1, ^Handle)) ==> $phys_ptr_cast(Q#hh$1^69.29#dt1, ^Handle) == $dot(#p, Container.h) || $phys_ptr_cast(Q#hh$1^69.29#dt1, ^Handle) == $dot(#p, Container.h2))));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^Container)) } $in(q, $composite_extent(s, p, ^Container)) == (q == p || q == $dot(p, Container.d) || q == $dot(p, Container.h) || q == $dot(p, Container.h2)));

const unique Container.d: $field;

axiom $def_phys_field(^Container, Container.d, ^Data, false, 0);

const unique Container.h: $field;

axiom $def_phys_field(^Container, Container.h, ^Handle, false, 4);

const unique Container.h2: $field;

axiom $def_phys_field(^Container, Container.h2, ^Handle, false, 8);

procedure Container#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> $dot($phys_ptr_cast(P#_this_, ^Container), Container.d) == $dot($phys_ptr_cast(P#_this_, ^Container), Container.d);
  ensures $is_admissibility_check() ==> $keeps($s, $phys_ptr_cast(P#_this_, ^Container), $dot($phys_ptr_cast(P#_this_, ^Container), Container.d));
  ensures $is_admissibility_check() ==> (forall Q#hh$1^69.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $dot($phys_ptr_cast(P#_this_, ^Container), Container.d))), $phys_ptr_cast(Q#hh$1^69.29#dt1, ^Handle)) } $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $dot($phys_ptr_cast(P#_this_, ^Container), Container.d))), $phys_ptr_cast(Q#hh$1^69.29#dt1, ^Handle)) ==> $phys_ptr_cast(Q#hh$1^69.29#dt1, ^Handle) == $dot($phys_ptr_cast(P#_this_, ^Container), Container.h) || $phys_ptr_cast(Q#hh$1^69.29#dt1, ^Handle) == $dot($phys_ptr_cast(P#_this_, ^Container), Container.h2));
  ensures $is_stuttering_check() ==> $dot($phys_ptr_cast(P#_this_, ^Container), Container.d) == $dot($phys_ptr_cast(P#_this_, ^Container), Container.d);
  ensures $is_unwrap_check() ==> $dot($phys_ptr_cast(P#_this_, ^Container), Container.d) == $dot($phys_ptr_cast(P#_this_, ^Container), Container.d);
  ensures $is_unwrap_check() ==> $keeps($s, $phys_ptr_cast(P#_this_, ^Container), $dot($phys_ptr_cast(P#_this_, ^Container), Container.d));
  ensures $is_unwrap_check() ==> (forall Q#hh$1^69.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $dot($phys_ptr_cast(P#_this_, ^Container), Container.d))), $phys_ptr_cast(Q#hh$1^69.29#dt1, ^Handle)) } $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $dot($phys_ptr_cast(P#_this_, ^Container), Container.d))), $phys_ptr_cast(Q#hh$1^69.29#dt1, ^Handle)) ==> $phys_ptr_cast(Q#hh$1^69.29#dt1, ^Handle) == $dot($phys_ptr_cast(P#_this_, ^Container), Container.h) || $phys_ptr_cast(Q#hh$1^69.29#dt1, ^Handle) == $dot($phys_ptr_cast(P#_this_, ^Container), Container.h2));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Container#adm(P#_this_: $ptr)
{
  var #wrTime$1^63.1: int;
  var #stackframe: int;

  anon18:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^63.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^63.1, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^Container));
    assume #wrTime$1^63.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^63.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($phys_ptr_cast(P#_this_, ^Container), ^Container);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon13:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $phys_ptr_cast(P#_this_, ^Container));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($phys_ptr_cast(P#_this_, ^Container));
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
            assume $admissibility_pre($s, $phys_ptr_cast(P#_this_, ^Container));
        }
        else
        {
          anon15:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $phys_ptr_cast(P#_this_, ^Container));
        }

      anon17:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Container*)@null))
        call $havoc_others($phys_ptr_cast(P#_this_, ^Container), ^Container);
        assume $good_state_ext(#tok$1^63.1, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $phys_ptr_cast(P#_this_, ^Container), ^Container);
    }

  #exit:
}



procedure foo(P#x: $ptr);
  requires $mutable($s, $phys_ptr_cast(P#x, ^X));
  requires $is_object_root($s, $phys_ptr_cast(P#x, ^X));
  modifies $s, $cev_pc;
  ensures $mutable($s, $phys_ptr_cast(P#x, ^X)) && $is_object_root($s, $phys_ptr_cast(P#x, ^X));
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: $set_in(#p, $extent(old($s), $phys_ptr_cast(P#x, ^X)))));
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
  var addr.d: $ptr;
  var addr.h: $ptr;
  var addr.x: $ptr;
  var #wrTime$1^23.1: int;
  var #stackframe: int;

  anon19:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^23.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^23.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^23.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // struct X* addr.x; 
    assume $local_value_is($s, #tok$1^23.1, #loc.addr.x, $ptr_to_int(addr.x), $ptr_to(^X));
    // addr.x := _vcc_stack_alloc<struct X>(@stackframe, false); 
    call addr.x := $stack_alloc(^X, #stackframe, false);
    assume $full_stop_ext(#tok$1^23.1, $s);
    assume $local_value_is($s, #tok$1^23.1, #loc.addr.x, $ptr_to_int(addr.x), $ptr_to(^X));
    // struct Handle* addr.h; 
    assume $local_value_is($s, #tok$1^23.1, #loc.addr.h, $ptr_to_int(addr.h), $ptr_to(^Handle));
    // addr.h := _vcc_stack_alloc<struct Handle>(@stackframe, false); 
    call addr.h := $stack_alloc(^Handle, #stackframe, false);
    assume $full_stop_ext(#tok$1^23.1, $s);
    assume $local_value_is($s, #tok$1^23.1, #loc.addr.h, $ptr_to_int(addr.h), $ptr_to(^Handle));
    // struct Data* addr.d; 
    assume $local_value_is($s, #tok$1^23.1, #loc.addr.d, $ptr_to_int(addr.d), $ptr_to(^Data));
    // addr.d := _vcc_stack_alloc<struct Data>(@stackframe, false); 
    call addr.d := $stack_alloc(^Data, #stackframe, false);
    assume $full_stop_ext(#tok$1^23.1, $s);
    assume $local_value_is($s, #tok$1^23.1, #loc.addr.d, $ptr_to_int(addr.d), $ptr_to(^Data));
    // var struct Data d
    // var struct Handle h
    // var struct X x
    // (struct Handle* -> _Bool) res_lambda#1#6; 
    assume $local_value_is($s, #tok$1^31.16, #loc.res_lambda#1#6, $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#1#6), $map_t($ptr_to(^Handle), ^^bool));
    // res_lambda#1#6 := lambda#1(); 
    call res_lambda#1#6 := lambda#1();
    assume $full_stop_ext(#tok$1^31.16, $s);
    assume $local_value_is($s, #tok$1^31.16, #loc.res_lambda#1#6, $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#1#6), $map_t($ptr_to(^Handle), ^^bool));
    // assert @prim_writes_check((addr.d->handles)); 
    assert $writable_prim($s, #wrTime$1^23.1, $dot($phys_ptr_cast(addr.d, ^Data), Data.handles));
    // *(addr.d->handles) := res_lambda#1#6; 
    call $write_int(Data.handles, $phys_ptr_cast(addr.d, ^Data), $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#1#6));
    assume $full_stop_ext(#tok$1^31.3, $s);
    // assert forall(struct Handle* h; true; ==>(@_vcc_ptr_eq_pure(*((h->data)), addr.d), unchecked!(@_vcc_inv(@state, h)))); 
    assert (forall Q#h$1^32.26#dt1: $ptr :: {:weight 10} { $rd_phys_ptr($s, Handle.data, $phys_ptr_cast(Q#h$1^32.26#dt1, ^Handle), ^Data) } { $inv($s, $phys_ptr_cast(Q#h$1^32.26#dt1, ^Handle), ^Handle) } $rd_phys_ptr($s, Handle.data, $phys_ptr_cast(Q#h$1^32.26#dt1, ^Handle), ^Data) == $phys_ptr_cast(addr.d, ^Data) ==> !$inv($s, $phys_ptr_cast(Q#h$1^32.26#dt1, ^Handle), ^Handle));
    // assume forall(struct Handle* h; true; ==>(@_vcc_ptr_eq_pure(*((h->data)), addr.d), unchecked!(@_vcc_inv(@state, h)))); 
    assume (forall Q#h$1^32.26#dt1: $ptr :: {:weight 10} { $rd_phys_ptr($s, Handle.data, $phys_ptr_cast(Q#h$1^32.26#dt1, ^Handle), ^Data) } { $inv($s, $phys_ptr_cast(Q#h$1^32.26#dt1, ^Handle), ^Handle) } $rd_phys_ptr($s, Handle.data, $phys_ptr_cast(Q#h$1^32.26#dt1, ^Handle), ^Data) == $phys_ptr_cast(addr.d, ^Data) ==> !$inv($s, $phys_ptr_cast(Q#h$1^32.26#dt1, ^Handle), ^Handle));
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
    assert $top_writable($s, #wrTime$1^23.1, $phys_ptr_cast(addr.d, ^Data));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(addr.d), staticWrapState#11, owns#12)
    call $static_wrap($phys_ptr_cast(addr.d, ^Data), staticWrapState#11, owns#12);
    assume $good_state_ext(#tok$1^33.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, addr.d), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(addr.d, ^Data)), $set_empty());
    // assert @inv_check(@_vcc_inv_is_owner_approved(old(prestate#13, @state), @state, addr.d, @field(userdata(__spec volatile (struct Handle* -> _Bool) handles /* @0 */) : Field))); 
    assert $inv_is_owner_approved(prestate#13, $s, $phys_ptr_cast(addr.d, ^Data), Data.handles);
    // assert @inv_check(forall(struct Handle* h; true; ==>(&&(old(prestate#13, @map_get(*((addr.d->handles)), h)), unchecked!(@map_get(*((addr.d->handles)), h))), unchecked!(@_vcc_closed(@state, h))))); 
    assert (forall Q#h$1^12.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv(prestate#13, Data.handles, $phys_ptr_cast(addr.d, ^Data))), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) } { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $phys_ptr_cast(addr.d, ^Data))), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) } $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv(prestate#13, Data.handles, $phys_ptr_cast(addr.d, ^Data))), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) && !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $phys_ptr_cast(addr.d, ^Data))), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) ==> !$closed($s, $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @_vcc_in_domain(@state, addr.d, addr.d); 
    assert $in_domain_lab($s, $phys_ptr_cast(addr.d, ^Data), $phys_ptr_cast(addr.d, ^Data), l#public);
    // assume @_vcc_in_domain(@state, addr.d, addr.d); 
    assume $in_domain_lab($s, $phys_ptr_cast(addr.d, ^Data), $phys_ptr_cast(addr.d, ^Data), l#public);
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^36.19, $s);
    atomicObj#32 := $phys_ptr_cast(addr.d, ^Data);
    assert $closed($s, atomicObj#32);
    assume $inv($s, atomicObj#32, ^Data);
    beforeAtomicState#0 := $s;
    // (struct Handle* -> _Bool) res_lambda#2#7; 
    assume $local_value_is($s, #tok$1^37.18, #loc.res_lambda#2#7, $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#2#7), $map_t($ptr_to(^Handle), ^^bool));
    // res_lambda#2#7 := lambda#2(addr.h); 
    call res_lambda#2#7 := lambda#2($phys_ptr_cast(addr.h, ^Handle));
    assume $good_state_ext(#tok$1^37.18, $s);
    assume $local_value_is($s, #tok$1^37.18, #loc.res_lambda#2#7, $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#2#7), $map_t($ptr_to(^Handle), ^^bool));
    // assert @prim_writes_check((addr.d->handles)); 
    assert $set_in($dot($phys_ptr_cast(addr.d, ^Data), Data.handles), $volatile_span($s, atomicObj#32)) || $writable_prim($s, #wrTime$1^23.1, $dot($phys_ptr_cast(addr.d, ^Data), Data.handles));
    // *(addr.d->handles) := res_lambda#2#7; 
    call $write_int(Data.handles, $phys_ptr_cast(addr.d, ^Data), $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#2#7));
    assume $good_state_ext(#tok$1^37.5, $s);
    // assert @writes_check(addr.d); 
    assert $top_writable($s, #wrTime$1^23.1, $phys_ptr_cast(addr.d, ^Data));
    // stmt _vcc_bump_volatile_version(addr.d); 
    call $bump_volatile_version($phys_ptr_cast(addr.d, ^Data));
    assume $good_state_ext(#tok$1^38.21, $s);
    assert $set_eq($owns($s, atomicObj#32), $set_empty());
    assert $closed(beforeAtomicState#0, atomicObj#32) && !$closed($s, atomicObj#32) ==> (forall Q#h$1^9.47#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, atomicObj#32)), $phys_ptr_cast(Q#h$1^9.47#dt1, ^Handle)) } !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, atomicObj#32)), $phys_ptr_cast(Q#h$1^9.47#dt1, ^Handle)));
    assert $inv_is_owner_approved(beforeAtomicState#0, $s, atomicObj#32, Data.handles);
    assert (forall Q#h$1^12.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv(beforeAtomicState#0, Data.handles, atomicObj#32)), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) } { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, atomicObj#32)), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) } $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv(beforeAtomicState#0, Data.handles, atomicObj#32)), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) && !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, atomicObj#32)), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) ==> !$closed($s, $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)));
    assume $full_stop_ext(#tok$1^36.19, $s);
    // assert @_vcc_in_domain(@state, addr.d, addr.d); 
    assert $in_domain_lab($s, $phys_ptr_cast(addr.d, ^Data), $phys_ptr_cast(addr.d, ^Data), l#public);
    // assume @_vcc_in_domain(@state, addr.d, addr.d); 
    assume $in_domain_lab($s, $phys_ptr_cast(addr.d, ^Data), $phys_ptr_cast(addr.d, ^Data), l#public);
    // assert @prim_writes_check((addr.h->data)); 
    assert $writable_prim($s, #wrTime$1^23.1, $dot($phys_ptr_cast(addr.h, ^Handle), Handle.data));
    // *(addr.h->data) := addr.d; 
    call $write_int(Handle.data, $phys_ptr_cast(addr.h, ^Handle), $ptr_to_int($phys_ptr_cast(addr.d, ^Data)));
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
    assert $top_writable($s, #wrTime$1^23.1, $phys_ptr_cast(addr.h, ^Handle));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(addr.h), staticWrapState#14, owns#15)
    call $static_wrap($phys_ptr_cast(addr.h, ^Handle), staticWrapState#14, owns#15);
    assume $good_state_ext(#tok$1^42.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, addr.h), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(addr.h, ^Handle)), $set_empty());
    // assert @inv_check(@_vcc_closed(@state, *((addr.h->data)))); 
    assert $closed($s, $rd_phys_ptr($s, Handle.data, $phys_ptr_cast(addr.h, ^Handle), ^Data));
    // assert @inv_check(@map_get(*((*((addr.h->data))->handles)), addr.h)); 
    assert $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $rd_phys_ptr($s, Handle.data, $phys_ptr_cast(addr.h, ^Handle), ^Data))), $phys_ptr_cast(addr.h, ^Handle));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @writes_check(@_vcc_extent(@state, addr.x)); 
    assert (forall #writes$1^46.3: $ptr :: { $dont_instantiate(#writes$1^46.3) } $set_in(#writes$1^46.3, $extent($s, $phys_ptr_cast(addr.x, ^X))) ==> $top_writable($s, #wrTime$1^23.1, #writes$1^46.3));
    // stmt foo(addr.x); 
    call foo($phys_ptr_cast(addr.x, ^X));
    assume $full_stop_ext(#tok$1^46.3, $s);
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^50.19, $s);
    atomicObj#33 := $phys_ptr_cast(addr.d, ^Data);
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
    assert $wrapped($s, $phys_ptr_cast(addr.h, ^Handle), ^Handle);
    // assert @writes_check(addr.h); 
    assert $top_writable($s, #wrTime$1^23.1, $phys_ptr_cast(addr.h, ^Handle));
    // assume @_vcc_inv(@state, addr.h); 
    assume $inv($s, $phys_ptr_cast(addr.h, ^Handle), ^Handle);
    // assume ==(owns#18, @_vcc_owns(@state, addr.h)); 
    assume owns#18 == $owns($s, $phys_ptr_cast(addr.h, ^Handle));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(addr.h), prestate#19)
    call $static_unwrap($phys_ptr_cast(addr.h, ^Handle), prestate#19);
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
    // assert @prim_writes_check((addr.d->handles)); 
    assert $set_in($dot($phys_ptr_cast(addr.d, ^Data), Data.handles), $volatile_span($s, atomicObj#33)) || $writable_prim($s, #wrTime$1^23.1, $dot($phys_ptr_cast(addr.d, ^Data), Data.handles));
    // *(addr.d->handles) := res_lambda#3#8; 
    call $write_int(Data.handles, $phys_ptr_cast(addr.d, ^Data), $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#3#8));
    assume $good_state_ext(#tok$1^53.5, $s);
    // assert @writes_check(addr.d); 
    assert $top_writable($s, #wrTime$1^23.1, $phys_ptr_cast(addr.d, ^Data));
    // stmt _vcc_bump_volatile_version(addr.d); 
    call $bump_volatile_version($phys_ptr_cast(addr.d, ^Data));
    assume $good_state_ext(#tok$1^54.21, $s);
    assert $set_eq($owns($s, atomicObj#33), $set_empty());
    assert $closed(beforeAtomicState#1, atomicObj#33) && !$closed($s, atomicObj#33) ==> (forall Q#h$1^9.47#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, atomicObj#33)), $phys_ptr_cast(Q#h$1^9.47#dt1, ^Handle)) } !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, atomicObj#33)), $phys_ptr_cast(Q#h$1^9.47#dt1, ^Handle)));
    assert $inv_is_owner_approved(beforeAtomicState#1, $s, atomicObj#33, Data.handles);
    assert (forall Q#h$1^12.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv(beforeAtomicState#1, Data.handles, atomicObj#33)), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) } { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, atomicObj#33)), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) } $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv(beforeAtomicState#1, Data.handles, atomicObj#33)), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) && !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, atomicObj#33)), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) ==> !$closed($s, $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)));
    assume $full_stop_ext(#tok$1^50.19, $s);
    // assert @_vcc_in_domain(@state, addr.d, addr.d); 
    assert $in_domain_lab($s, $phys_ptr_cast(addr.d, ^Data), $phys_ptr_cast(addr.d, ^Data), l#public);
    // assume @_vcc_in_domain(@state, addr.d, addr.d); 
    assume $in_domain_lab($s, $phys_ptr_cast(addr.d, ^Data), $phys_ptr_cast(addr.d, ^Data), l#public);
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
    assert $wrapped($s, $phys_ptr_cast(addr.d, ^Data), ^Data);
    // assert @writes_check(addr.d); 
    assert $top_writable($s, #wrTime$1^23.1, $phys_ptr_cast(addr.d, ^Data));
    // assume @_vcc_inv(@state, addr.d); 
    assume $inv($s, $phys_ptr_cast(addr.d, ^Data), ^Data);
    // assume ==(owns#21, @_vcc_owns(@state, addr.d)); 
    assume owns#21 == $owns($s, $phys_ptr_cast(addr.d, ^Data));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(addr.d), prestate#22)
    call $static_unwrap($phys_ptr_cast(addr.d, ^Data), prestate#22);
    assume $good_state_ext(#tok$1^58.19, $s);
    // assert @inv_check(==>(&&(old(prestate#20, @_vcc_closed(@state, addr.d)), unchecked!(@_vcc_closed(@state, addr.d))), forall(struct Handle* h; true; unchecked!(@map_get(*((addr.d->handles)), h))))); 
    assert $closed(prestate#20, $phys_ptr_cast(addr.d, ^Data)) && !$closed($s, $phys_ptr_cast(addr.d, ^Data)) ==> (forall Q#h$1^9.47#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $phys_ptr_cast(addr.d, ^Data))), $phys_ptr_cast(Q#h$1^9.47#dt1, ^Handle)) } !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $phys_ptr_cast(addr.d, ^Data))), $phys_ptr_cast(Q#h$1^9.47#dt1, ^Handle)));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // stmt _vcc_stack_free(@stackframe, addr.d); 
    call $stack_free(#stackframe, $phys_ptr_cast(addr.d, ^Data));
    assume $full_stop_ext(#tok$1^23.1, $s);
    // stmt _vcc_stack_free(@stackframe, addr.h); 
    call $stack_free(#stackframe, $phys_ptr_cast(addr.h, ^Handle));
    assume $full_stop_ext(#tok$1^23.1, $s);
    // stmt _vcc_stack_free(@stackframe, addr.x); 
    call $stack_free(#stackframe, $phys_ptr_cast(addr.x, ^X));
    assume $full_stop_ext(#tok$1^23.1, $s);
    // return; 
    assert $position_marker();
    goto #exit;

  anon20:
    // Block cleanup
    // stmt _vcc_stack_free(@stackframe, addr.d); 
    call $stack_free(#stackframe, $phys_ptr_cast(addr.d, ^Data));
    assume $full_stop_ext(#tok$1^23.1, $s);
    // stmt _vcc_stack_free(@stackframe, addr.h); 
    call $stack_free(#stackframe, $phys_ptr_cast(addr.h, ^Handle));
    assume $full_stop_ext(#tok$1^23.1, $s);
    // stmt _vcc_stack_free(@stackframe, addr.x); 
    call $stack_free(#stackframe, $phys_ptr_cast(addr.x, ^X));
    assume $full_stop_ext(#tok$1^23.1, $s);

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
  var L#c: $ptr;
  var #wrTime$1^72.1: int;
  var #stackframe: int;

  anon23:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^72.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^72.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^72.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // struct Container* c; 
    assume $local_value_is($s, #tok$1^74.10, #loc.c, $ptr_to_int(L#c), $ptr_to(^Container));
    // c := _vcc_alloc(@_vcc_typeof((struct Container*)@null)); 
    call L#c := $alloc(^Container);
    assume $full_stop_ext(#tok$1^74.25, $s);
    assume $local_value_is($s, #tok$1^74.25, #loc.c, $ptr_to_int(L#c), $ptr_to(^Container));
    assume true;
    // if (@_vcc_ptr_neq_null(c)) ...
    if ($non_null($phys_ptr_cast(L#c, ^Container)))
    {
      anon21:
        // (struct Handle* -> _Bool) res_lambda#4#9; 
        assume $local_value_is($s, #tok$1^76.44, #loc.res_lambda#4#9, $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#4#9), $map_t($ptr_to(^Handle), ^^bool));
        // res_lambda#4#9 := lambda#4(); 
        call res_lambda#4#9 := lambda#4();
        assume $full_stop_ext(#tok$1^76.44, $s);
        assume $local_value_is($s, #tok$1^76.44, #loc.res_lambda#4#9, $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#4#9), $map_t($ptr_to(^Handle), ^^bool));
        // assert @prim_writes_check(((c->d)->handles)); 
        assert $writable_prim($s, #wrTime$1^72.1, $dot($dot($phys_ptr_cast(L#c, ^Container), Container.d), Data.handles));
        // *((c->d)->handles) := res_lambda#4#9; 
        call $write_int(Data.handles, $dot($phys_ptr_cast(L#c, ^Container), Container.d), $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#4#9));
        assume $full_stop_ext(#tok$1^76.28, $s);
        // assert forall(struct Handle* h; true; ==>(@_vcc_ptr_eq_pure(*((h->data)), (c->d)), unchecked!(@_vcc_inv(@state, h)))); 
        assert (forall Q#h$1^77.28#dt1: $ptr :: {:weight 10} { $rd_phys_ptr($s, Handle.data, $phys_ptr_cast(Q#h$1^77.28#dt1, ^Handle), ^Data) } { $inv($s, $phys_ptr_cast(Q#h$1^77.28#dt1, ^Handle), ^Handle) } $rd_phys_ptr($s, Handle.data, $phys_ptr_cast(Q#h$1^77.28#dt1, ^Handle), ^Data) == $dot($phys_ptr_cast(L#c, ^Container), Container.d) ==> !$inv($s, $phys_ptr_cast(Q#h$1^77.28#dt1, ^Handle), ^Handle));
        // assume forall(struct Handle* h; true; ==>(@_vcc_ptr_eq_pure(*((h->data)), (c->d)), unchecked!(@_vcc_inv(@state, h)))); 
        assume (forall Q#h$1^77.28#dt1: $ptr :: {:weight 10} { $rd_phys_ptr($s, Handle.data, $phys_ptr_cast(Q#h$1^77.28#dt1, ^Handle), ^Data) } { $inv($s, $phys_ptr_cast(Q#h$1^77.28#dt1, ^Handle), ^Handle) } $rd_phys_ptr($s, Handle.data, $phys_ptr_cast(Q#h$1^77.28#dt1, ^Handle), ^Data) == $dot($phys_ptr_cast(L#c, ^Container), Container.d) ==> !$inv($s, $phys_ptr_cast(Q#h$1^77.28#dt1, ^Handle), ^Handle));
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
        assert $top_writable($s, #wrTime$1^72.1, $dot($phys_ptr_cast(L#c, ^Container), Container.d));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure((c->d)), staticWrapState#23, owns#24)
        call $static_wrap($dot($phys_ptr_cast(L#c, ^Container), Container.d), staticWrapState#23, owns#24);
        assume $good_state_ext(#tok$1^78.21, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, (c->d)), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $dot($phys_ptr_cast(L#c, ^Container), Container.d)), $set_empty());
        // assert @inv_check(@_vcc_inv_is_owner_approved(old(prestate#25, @state), @state, (c->d), @field(userdata(__spec volatile (struct Handle* -> _Bool) handles /* @0 */) : Field))); 
        assert $inv_is_owner_approved(prestate#25, $s, $dot($phys_ptr_cast(L#c, ^Container), Container.d), Data.handles);
        // assert @inv_check(forall(struct Handle* h; true; ==>(&&(old(prestate#25, @map_get(*(((c->d)->handles)), h)), unchecked!(@map_get(*(((c->d)->handles)), h))), unchecked!(@_vcc_closed(@state, h))))); 
        assert (forall Q#h$1^12.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv(prestate#25, Data.handles, $dot($phys_ptr_cast(L#c, ^Container), Container.d))), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) } { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $dot($phys_ptr_cast(L#c, ^Container), Container.d))), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) } $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv(prestate#25, Data.handles, $dot($phys_ptr_cast(L#c, ^Container), Container.d))), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) && !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $dot($phys_ptr_cast(L#c, ^Container), Container.d))), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) ==> !$closed($s, $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)));
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
        assert $top_writable($s, #wrTime$1^72.1, $phys_ptr_cast(L#c, ^Container));
        // assert @_vcc_wrapped(@state, (c->d)); 
        assert $wrapped($s, $dot($phys_ptr_cast(L#c, ^Container), Container.d), ^Data);
        // assert @writes_check((c->d)); 
        assert $top_writable($s, #wrTime$1^72.1, $dot($phys_ptr_cast(L#c, ^Container), Container.d));
        // owns#27 := pure(@_vcc_set_union(owns#27, @_vcc_set_singleton((c->d)))); 
        owns#27 := $set_union(owns#27, $set_singleton($dot($phys_ptr_cast(L#c, ^Container), Container.d)));
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#27, $ptrset_to_int(owns#27), ^$#ptrset);
        // staticWrapState#26 := pure(@_vcc_take_over(staticWrapState#26, c, (c->d))); 
        staticWrapState#26 := $take_over(staticWrapState#26, $phys_ptr_cast(L#c, ^Container), $dot($phys_ptr_cast(L#c, ^Container), Container.d));
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#26, $state_to_int(staticWrapState#26), ^$#state_t);
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(c), staticWrapState#26, owns#27)
        call $static_wrap($phys_ptr_cast(L#c, ^Container), staticWrapState#26, owns#27);
        assume $good_state_ext(#tok$1^79.21, $s);
        // assert @inv_check(@keeps_stable(old(prestate#28, (c->d)), (c->d))); 
        assert $dot($phys_ptr_cast(L#c, ^Container), Container.d) == $dot($phys_ptr_cast(L#c, ^Container), Container.d);
        // assert @inv_check(@keeps(c, (c->d))); 
        assert $keeps($s, $phys_ptr_cast(L#c, ^Container), $dot($phys_ptr_cast(L#c, ^Container), Container.d));
        // assert @inv_check(forall(struct Handle* hh; true; ==>(@map_get(*(((c->d)->handles)), hh), ||(@_vcc_ptr_eq_pure(hh, (c->h)), @_vcc_ptr_eq_pure(hh, (c->h2)))))); 
        assert (forall Q#hh$1^69.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $dot($phys_ptr_cast(L#c, ^Container), Container.d))), $phys_ptr_cast(Q#hh$1^69.29#dt1, ^Handle)) } $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $dot($phys_ptr_cast(L#c, ^Container), Container.d))), $phys_ptr_cast(Q#hh$1^69.29#dt1, ^Handle)) ==> $phys_ptr_cast(Q#hh$1^69.29#dt1, ^Handle) == $dot($phys_ptr_cast(L#c, ^Container), Container.h) || $phys_ptr_cast(Q#hh$1^69.29#dt1, ^Handle) == $dot($phys_ptr_cast(L#c, ^Container), Container.h2));
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
    }
    else
    {
      anon22:
        // empty
    }

  anon24:
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure closed_use(P#c: $ptr);
  requires $wrapped($s, $phys_ptr_cast(P#c, ^Container), ^Container);
  modifies $s, $cev_pc;
  ensures $wrapped($s, $dot($phys_ptr_cast(P#c, ^Container), Container.h), ^Handle) && $rd_phys_ptr($s, Handle.data, $dot($phys_ptr_cast(P#c, ^Container), Container.h), ^Data) == $dot($phys_ptr_cast(P#c, ^Container), Container.d);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: $set_in(#p, $extent(old($s), $dot($phys_ptr_cast(P#c, ^Container), Container.h)))));
  free ensures $call_transition(old($s), $s);



implementation closed_use(P#c: $ptr)
{
  var owns#30: $ptrset;
  var staticWrapState#29: $state;
  var prestate#31: $state;
  var res_lambda#5#10: $map_t..$ptr_to..^Handle.^^bool;
  var beforeAtomicState#2: $state;
  var atomicObj#34: $ptr;
  var #wrTime$1^83.1: int;
  var #stackframe: int;

  anon25:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^83.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^83.1, #loc.c, $ptr_to_int(P#c), $ptr_to(^Container));
    assume #wrTime$1^83.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^83.1, (lambda #p: $ptr :: $set_in(#p, $extent($s, $dot($phys_ptr_cast(P#c, ^Container), Container.h)))));
    assume $extent_mutable($s, $dot($phys_ptr_cast(P#c, ^Container), Container.h));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, c, c); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#c, ^Container), $phys_ptr_cast(P#c, ^Container), l#public);
    assume true;
    call $atomic_havoc();
    assume $full_stop_ext(#tok$1^89.19, $s);
    atomicObj#34 := $dot($phys_ptr_cast(P#c, ^Container), Container.d);
    assert $closed($s, atomicObj#34);
    assume $inv($s, atomicObj#34, ^Data);
    beforeAtomicState#2 := $s;
    // assert @_vcc_inv(@state, c); 
    assert $inv($s, $phys_ptr_cast(P#c, ^Container), ^Container);
    // assume @_vcc_inv(@state, c); 
    assume $inv($s, $phys_ptr_cast(P#c, ^Container), ^Container);
    // (struct Handle* -> _Bool) res_lambda#5#10; 
    assume $local_value_is($s, #tok$1^91.21, #loc.res_lambda#5#10, $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#5#10), $map_t($ptr_to(^Handle), ^^bool));
    // assert @reads_check_normal(((c->d)->handles)); 
    assert $mutable($s, $dot($phys_ptr_cast(P#c, ^Container), Container.d)) || $dot($phys_ptr_cast(P#c, ^Container), Container.d) == atomicObj#34;
    // res_lambda#5#10 := lambda#5(*(((c->d)->handles)), (c->h)); 
    call res_lambda#5#10 := lambda#5($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $dot($phys_ptr_cast(P#c, ^Container), Container.d))), $dot($phys_ptr_cast(P#c, ^Container), Container.h));
    assume $good_state_ext(#tok$1^91.21, $s);
    assume $local_value_is($s, #tok$1^91.21, #loc.res_lambda#5#10, $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#5#10), $map_t($ptr_to(^Handle), ^^bool));
    // assert @prim_writes_check(((c->d)->handles)); 
    assert $set_in($dot($dot($phys_ptr_cast(P#c, ^Container), Container.d), Data.handles), $volatile_span($s, atomicObj#34)) || $writable_prim($s, #wrTime$1^83.1, $dot($dot($phys_ptr_cast(P#c, ^Container), Container.d), Data.handles));
    // *((c->d)->handles) := res_lambda#5#10; 
    call $write_int(Data.handles, $dot($phys_ptr_cast(P#c, ^Container), Container.d), $map_t..ptr_to..^Handle.^^bool_to_int(res_lambda#5#10));
    assume $good_state_ext(#tok$1^91.5, $s);
    assert $set_eq($owns($s, atomicObj#34), $set_empty());
    assert $closed(beforeAtomicState#2, atomicObj#34) && !$closed($s, atomicObj#34) ==> (forall Q#h$1^9.47#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, atomicObj#34)), $phys_ptr_cast(Q#h$1^9.47#dt1, ^Handle)) } !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, atomicObj#34)), $phys_ptr_cast(Q#h$1^9.47#dt1, ^Handle)));
    assert $inv_is_owner_approved(beforeAtomicState#2, $s, atomicObj#34, Data.handles);
    assert (forall Q#h$1^12.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv(beforeAtomicState#2, Data.handles, atomicObj#34)), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) } { $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, atomicObj#34)), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) } $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv(beforeAtomicState#2, Data.handles, atomicObj#34)), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) && !$select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, atomicObj#34)), $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)) ==> !$closed($s, $phys_ptr_cast(Q#h$1^12.29#dt1, ^Handle)));
    assume $full_stop_ext(#tok$1^89.19, $s);
    // assert @prim_writes_check(((c->h)->data)); 
    assert $writable_prim($s, #wrTime$1^83.1, $dot($dot($phys_ptr_cast(P#c, ^Container), Container.h), Handle.data));
    // *((c->h)->data) := (c->d); 
    call $write_int(Handle.data, $dot($phys_ptr_cast(P#c, ^Container), Container.h), $ptr_to_int($dot($phys_ptr_cast(P#c, ^Container), Container.d)));
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
    assert $top_writable($s, #wrTime$1^83.1, $dot($phys_ptr_cast(P#c, ^Container), Container.h));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure((c->h)), staticWrapState#29, owns#30)
    call $static_wrap($dot($phys_ptr_cast(P#c, ^Container), Container.h), staticWrapState#29, owns#30);
    assume $good_state_ext(#tok$1^94.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, (c->h)), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $dot($phys_ptr_cast(P#c, ^Container), Container.h)), $set_empty());
    // assert @inv_check(@_vcc_closed(@state, *(((c->h)->data)))); 
    assert $closed($s, $rd_phys_ptr($s, Handle.data, $dot($phys_ptr_cast(P#c, ^Container), Container.h), ^Data));
    // assert @inv_check(@map_get(*((*(((c->h)->data))->handles)), (c->h))); 
    assert $select.$map_t..$ptr_to..^Handle.^^bool($int_to_map_t..ptr_to..^Handle.^^bool($rd_inv($s, Data.handles, $rd_phys_ptr($s, Handle.data, $dot($phys_ptr_cast(P#c, ^Container), Container.h), ^Data))), $dot($phys_ptr_cast(P#c, ^Container), Container.h));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



function F#lambda#5(#l1: $map_t..$ptr_to..^Handle.^^bool, #l0: $ptr) : $map_t..$ptr_to..^Handle.^^bool;

const unique cf#lambda#5: $pure_function;

axiom $function_arg_type(cf#lambda#5, 0, $map_t($ptr_to(^Handle), ^^bool));

axiom $function_arg_type(cf#lambda#5, 1, $map_t($ptr_to(^Handle), ^^bool));

axiom $function_arg_type(cf#lambda#5, 2, $ptr_to(^Handle));

procedure lambda#5(#l1: $map_t..$ptr_to..^Handle.^^bool, #l0: $ptr) returns ($result: $map_t..$ptr_to..^Handle.^^bool);
  free ensures $result == F#lambda#5(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#hh$1^91.21#dt1: $ptr, #l1: $map_t..$ptr_to..^Handle.^^bool, #l0: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool(F#lambda#5(#l1, $phys_ptr_cast(#l0, ^Handle)), $phys_ptr_cast(Q#hh$1^91.21#dt1, ^Handle)) } $select.$map_t..$ptr_to..^Handle.^^bool(F#lambda#5(#l1, $phys_ptr_cast(#l0, ^Handle)), $phys_ptr_cast(Q#hh$1^91.21#dt1, ^Handle)) == ($phys_ptr_cast(Q#hh$1^91.21#dt1, ^Handle) == $phys_ptr_cast(#l0, ^Handle) || $select.$map_t..$ptr_to..^Handle.^^bool(#l1, $phys_ptr_cast(Q#hh$1^91.21#dt1, ^Handle))));

function F#lambda#4() : $map_t..$ptr_to..^Handle.^^bool;

const unique cf#lambda#4: $pure_function;

axiom $function_arg_type(cf#lambda#4, 0, $map_t($ptr_to(^Handle), ^^bool));

procedure lambda#4() returns ($result: $map_t..$ptr_to..^Handle.^^bool);
  free ensures $result == F#lambda#4();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#h$1^76.44#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool(F#lambda#4(), $phys_ptr_cast(Q#h$1^76.44#dt1, ^Handle)) } $select.$map_t..$ptr_to..^Handle.^^bool(F#lambda#4(), $phys_ptr_cast(Q#h$1^76.44#dt1, ^Handle)) == false);

function F#lambda#3() : $map_t..$ptr_to..^Handle.^^bool;

const unique cf#lambda#3: $pure_function;

axiom $function_arg_type(cf#lambda#3, 0, $map_t($ptr_to(^Handle), ^^bool));

procedure lambda#3() returns ($result: $map_t..$ptr_to..^Handle.^^bool);
  free ensures $result == F#lambda#3();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#hh$1^53.18#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool(F#lambda#3(), $phys_ptr_cast(Q#hh$1^53.18#dt1, ^Handle)) } $select.$map_t..$ptr_to..^Handle.^^bool(F#lambda#3(), $phys_ptr_cast(Q#hh$1^53.18#dt1, ^Handle)) == false);

function F#lambda#2(#l0: $ptr) : $map_t..$ptr_to..^Handle.^^bool;

const unique cf#lambda#2: $pure_function;

axiom $function_arg_type(cf#lambda#2, 0, $map_t($ptr_to(^Handle), ^^bool));

axiom $function_arg_type(cf#lambda#2, 1, $ptr_to(^Handle));

procedure lambda#2(#l0: $ptr) returns ($result: $map_t..$ptr_to..^Handle.^^bool);
  free ensures $result == F#lambda#2(#l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#hh$1^37.18#dt1: $ptr, #l0: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool(F#lambda#2($phys_ptr_cast(#l0, ^Handle)), $phys_ptr_cast(Q#hh$1^37.18#dt1, ^Handle)) } $select.$map_t..$ptr_to..^Handle.^^bool(F#lambda#2($phys_ptr_cast(#l0, ^Handle)), $phys_ptr_cast(Q#hh$1^37.18#dt1, ^Handle)) == ($phys_ptr_cast(Q#hh$1^37.18#dt1, ^Handle) == $phys_ptr_cast(#l0, ^Handle)));

function F#lambda#1() : $map_t..$ptr_to..^Handle.^^bool;

const unique cf#lambda#1: $pure_function;

axiom $function_arg_type(cf#lambda#1, 0, $map_t($ptr_to(^Handle), ^^bool));

procedure lambda#1() returns ($result: $map_t..$ptr_to..^Handle.^^bool);
  free ensures $result == F#lambda#1();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#h$1^31.16#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Handle.^^bool(F#lambda#1(), $phys_ptr_cast(Q#h$1^31.16#dt1, ^Handle)) } $select.$map_t..$ptr_to..^Handle.^^bool(F#lambda#1(), $phys_ptr_cast(Q#h$1^31.16#dt1, ^Handle)) == false);

const unique l#public: $label;

type $map_t..$ptr_to..^Handle.^^bool;

function $select.$map_t..$ptr_to..^Handle.^^bool(M: $map_t..$ptr_to..^Handle.^^bool, p: $ptr) : bool;

function $store.$map_t..$ptr_to..^Handle.^^bool(M: $map_t..$ptr_to..^Handle.^^bool, p: $ptr, v: bool) : $map_t..$ptr_to..^Handle.^^bool;

function $eq.$map_t..$ptr_to..^Handle.^^bool(M1: $map_t..$ptr_to..^Handle.^^bool, M2: $map_t..$ptr_to..^Handle.^^bool) : bool;

const $zero.$map_t..$ptr_to..^Handle.^^bool: $map_t..$ptr_to..^Handle.^^bool;

axiom (forall M: $map_t..$ptr_to..^Handle.^^bool, p: $ptr, v: bool :: true);

axiom (forall M: $map_t..$ptr_to..^Handle.^^bool, p: $ptr, v: bool, q: $ptr :: $select.$map_t..$ptr_to..^Handle.^^bool($store.$map_t..$ptr_to..^Handle.^^bool(M, q, v), p) == (if $phys_ptr_cast(p, ^Handle) == $phys_ptr_cast(q, ^Handle) then v else $select.$map_t..$ptr_to..^Handle.^^bool(M, p)));

axiom (forall M1: $map_t..$ptr_to..^Handle.^^bool, M2: $map_t..$ptr_to..^Handle.^^bool :: { $eq.$map_t..$ptr_to..^Handle.^^bool(M1, M2) } (forall p: $ptr :: $select.$map_t..$ptr_to..^Handle.^^bool(M1, $phys_ptr_cast(p, ^Handle)) == $select.$map_t..$ptr_to..^Handle.^^bool(M2, $phys_ptr_cast(p, ^Handle))) ==> $eq.$map_t..$ptr_to..^Handle.^^bool(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^Handle.^^bool, M2: $map_t..$ptr_to..^Handle.^^bool :: { $eq.$map_t..$ptr_to..^Handle.^^bool(M1, M2) } $eq.$map_t..$ptr_to..^Handle.^^bool(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^Handle.^^bool(0) == $zero.$map_t..$ptr_to..^Handle.^^bool;

axiom (forall p: $ptr :: $select.$map_t..$ptr_to..^Handle.^^bool($zero.$map_t..$ptr_to..^Handle.^^bool, p) == false);

axiom true;

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

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CHandles.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CHandles.c);

function $map_t..ptr_to..^Handle.^^bool_to_int(x: $map_t..$ptr_to..^Handle.^^bool) : int;

function $int_to_map_t..ptr_to..^Handle.^^bool(x: int) : $map_t..$ptr_to..^Handle.^^bool;

axiom (forall #x: $map_t..$ptr_to..^Handle.^^bool :: #x == $int_to_map_t..ptr_to..^Handle.^^bool($map_t..ptr_to..^Handle.^^bool_to_int(#x)));

const unique #distTp2: $ctype;

axiom #distTp2 == $map_t($ptr_to(^Handle), ^^bool);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^Handle);
