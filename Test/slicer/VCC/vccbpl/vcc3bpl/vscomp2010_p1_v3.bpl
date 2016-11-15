axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

function F#match_integer(vscomp2010_p1_v3.c..27832: int) : bool;

const unique cf#match_integer: $pure_function;

axiom (forall vscomp2010_p1_v3.c..27832: int :: { F#match_integer(vscomp2010_p1_v3.c..27832) } F#match_integer(vscomp2010_p1_v3.c..27832) == true);

axiom $function_arg_type(cf#match_integer, 0, ^^bool);

axiom $function_arg_type(cf#match_integer, 1, ^^mathint);

procedure match_integer(vscomp2010_p1_v3.c..27832: int) returns ($result: bool);
  ensures $result == true;
  free ensures $result == F#match_integer(vscomp2010_p1_v3.c..27832);
  free ensures $call_transition(old($s), $s);



procedure sum_max(P#a: $ptr, P#N: int, P#maxout: $ptr) returns ($result: int);
  requires $wrapped($s, $as_array($phys_ptr_cast(P#a, ^^u4), ^^u4, P#N), $array(^^u4, P#N));
  requires 0 < P#N;
  modifies $s, $cev_pc;
  free ensures $in_range_u4($result);
  ensures (exists Q#S$1^13.27#dt1: $map_t..^^mathint.^^mathint :: {:weight 10} { $select.$map_t..^^mathint.^^mathint(Q#S$1^13.27#dt1, P#N) } (forall Q#k$1^14.6#tc1: int :: {:weight 10} { sk_hack(F#match_integer($select.$map_t..^^mathint.^^mathint(Q#S$1^13.27#dt1, Q#k$1^14.6#tc1 + 1))) } { $idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^14.6#tc1) } $in_range_u4(Q#k$1^14.6#tc1) ==> Q#k$1^14.6#tc1 < P#N ==> $select.$map_t..^^mathint.^^mathint(Q#S$1^13.27#dt1, Q#k$1^14.6#tc1 + 1) == $select.$map_t..^^mathint.^^mathint(Q#S$1^13.27#dt1, Q#k$1^14.6#tc1) + $rd_inv($s, $field($idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^14.6#tc1)), $emb0($idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^14.6#tc1)))) && ($select.$map_t..^^mathint.^^mathint(Q#S$1^13.27#dt1, P#N) < 4294967295 ==> $result == $select.$map_t..^^mathint.^^mathint(Q#S$1^13.27#dt1, P#N)));
  ensures (forall Q#k$1^17.27#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^17.27#tc1) } $in_range_u4(Q#k$1^17.27#tc1) ==> Q#k$1^17.27#tc1 < P#N ==> $rd_inv($s, $field($idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^17.27#tc1)), $emb0($idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^17.27#tc1))) <= $rd_inv($s, $field($phys_ptr_cast(P#maxout, ^^u4)), $emb0($phys_ptr_cast(P#maxout, ^^u4))));
  ensures $result <= $op_mul(P#N, $rd_inv($s, $field($phys_ptr_cast(P#maxout, ^^u4)), $emb0($phys_ptr_cast(P#maxout, ^^u4))));
  ensures (exists Q#i$1^19.27#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#a, ^^u4), Q#i$1^19.27#tc1) } $in_range_u4(Q#i$1^19.27#tc1) && Q#i$1^19.27#tc1 < P#N && $rd_inv($s, $field($idx($phys_ptr_cast(P#a, ^^u4), Q#i$1^19.27#tc1)), $emb0($idx($phys_ptr_cast(P#a, ^^u4), Q#i$1^19.27#tc1))) == $rd_inv($s, $field($phys_ptr_cast(P#maxout, ^^u4)), $emb0($phys_ptr_cast(P#maxout, ^^u4))));
  ensures $mutable($s, $phys_ptr_cast(P#maxout, ^^u4));
  ensures $emb($s, $phys_ptr_cast(P#maxout, ^^u4)) == $emb(old($s), $phys_ptr_cast(P#maxout, ^^u4));
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#maxout, ^^u4)));
  free ensures $call_transition(old($s), $s);



implementation sum_max(P#a: $ptr, P#N: int, P#maxout: $ptr) returns ($result: int)
{
  var #wrTime$1^27.3: int;
  var loopState#0: $state;
  var L#max: int where $in_range_u4(L#max);
  var L#sum: int where $in_range_u4(L#sum);
  var L#i: int where $in_range_u4(L#i);
  var SL#S: $map_t..^^mathint.^^mathint;
  var #wrTime$1^9.1: int;
  var #stackframe: int;

  anon7:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^9.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^9.1, #loc.a, $ptr_to_int(P#a), $ptr_to(^^u4));
    assume $local_value_is($s, #tok$1^9.1, #loc.N, P#N, ^^u4);
    assume $local_value_is($s, #tok$1^9.1, #loc.maxout, $ptr_to_int(P#maxout), $ptr_to(^^u4));
    assume #wrTime$1^9.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^9.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#maxout, ^^u4)));
    assume $mutable($s, $phys_ptr_cast(P#maxout, ^^u4));
    // assume true; 
    assume true;
    // assume @in_range_u4(N); 
    assume $in_range_u4(P#N);
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, @_vcc_as_array(a, N), @_vcc_as_array(a, N)); 
    assert $in_domain_lab($s, $as_array($phys_ptr_cast(P#a, ^^u4), ^^u4, P#N), $as_array($phys_ptr_cast(P#a, ^^u4), ^^u4, P#N), l#public);
    // (mathint -> mathint) S; 
    assume $local_value_is($s, #tok$1^24.25, #loc.S, $map_t..^^mathint.^^mathint_to_int(SL#S), $map_t(^^mathint, ^^mathint));
    // uint32_t i; 
    assume $local_value_is($s, #tok$1^23.3, #loc.i, L#i, ^^u4);
    // uint32_t sum; 
    assume $local_value_is($s, #tok$1^22.3, #loc.sum, L#sum, ^^u4);
    // uint32_t max; 
    assume $local_value_is($s, #tok$1^21.3, #loc.max, L#max, ^^u4);
    // assert @reads_check_normal(a[0]); 
    assert $thread_local($s, $idx($phys_ptr_cast(P#a, ^^u4), 0));
    // max := *(a[0]); 
    L#max := $rd_inv($s, $field($idx($phys_ptr_cast(P#a, ^^u4), 0)), $emb0($idx($phys_ptr_cast(P#a, ^^u4), 0)));
    assume $local_value_is($s, #tok$1^21.3, #loc.max, L#max, ^^u4);
    // sum := 0; 
    L#sum := 0;
    assume $local_value_is($s, #tok$1^22.3, #loc.sum, L#sum, ^^u4);
    // var uint32_t i
    // var spec (mathint -> mathint) S
    // S := @map_updated(S, 0, 0); 
    SL#S := $store.$map_t..^^mathint.^^mathint(SL#S, 0, 0);
    assume $local_value_is($s, #tok$1^25.25, #loc.S, $map_t..^^mathint.^^mathint_to_int(SL#S), $map_t(^^mathint, ^^mathint));
    // i := 0; 
    L#i := 0;
    assume $local_value_is($s, #tok$1^27.8, #loc.i, L#i, ^^u4);
    call $bump_timestamp();
    assume $full_stop_ext(#tok$1^27.3, $s);
    loopState#0 := $s;
    assume #wrTime$1^27.3 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^27.3, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#maxout, ^^u4)));
    assert (forall #loopWrites^$1^27.3: $ptr :: { $dont_instantiate(#loopWrites^$1^27.3) } $listed_in_writes($s, #wrTime$1^27.3, #loopWrites^$1^27.3) ==> $top_writable($s, #wrTime$1^9.1, #loopWrites^$1^27.3));
    while (true)
      invariant (forall Q#k$1^28.31#tc1: int :: {:weight 10} { F#match_integer($select.$map_t..^^mathint.^^mathint(SL#S, Q#k$1^28.31#tc1 + 1)) } { sk_hack(F#match_integer($select.$map_t..^^mathint.^^mathint(SL#S, Q#k$1^28.31#tc1 + 1))) } $in_range_u4(Q#k$1^28.31#tc1) ==> Q#k$1^28.31#tc1 < L#i ==> $select.$map_t..^^mathint.^^mathint(SL#S, Q#k$1^28.31#tc1 + 1) == $select.$map_t..^^mathint.^^mathint(SL#S, Q#k$1^28.31#tc1) + $rd_inv($s, $field($idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^28.31#tc1)), $emb0($idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^28.31#tc1))));
      invariant $select.$map_t..^^mathint.^^mathint(SL#S, L#i) < 4294967295 ==> L#sum == $select.$map_t..^^mathint.^^mathint(SL#S, L#i);
      invariant (forall Q#k$1^31.31#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^31.31#tc1) } $in_range_u4(Q#k$1^31.31#tc1) ==> Q#k$1^31.31#tc1 < L#i ==> $rd_inv($s, $field($idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^31.31#tc1)), $emb0($idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^31.31#tc1))) <= L#max);
      invariant L#sum <= $op_mul(L#i, L#max);
      invariant L#i <= P#N;
      invariant (exists Q#k$1^34.31#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^34.31#tc1) } $in_range_u4(Q#k$1^34.31#tc1) && Q#k$1^34.31#tc1 < P#N && $rd_inv($s, $field($idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^34.31#tc1)), $emb0($idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^34.31#tc1))) == L#max);
    {
      anon6:
        assume $modifies(loopState#0, $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#maxout, ^^u4)));
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$1^27.3, $s);
        assume $local_value_is($s, #tok$1^27.3, #loc.max, L#max, ^^u4);
        assume $local_value_is($s, #tok$1^27.3, #loc.sum, L#sum, ^^u4);
        assume $local_value_is($s, #tok$1^27.3, #loc.i, L#i, ^^u4);
        assume $local_value_is($s, #tok$1^27.3, #loc.S, $map_t..^^mathint.^^mathint_to_int(SL#S), $map_t(^^mathint, ^^mathint));
        assume $local_value_is($s, #tok$1^27.3, #loc.maxout, $ptr_to_int(P#maxout), $ptr_to(^^u4));
        assume $local_value_is($s, #tok$1^27.3, #loc.N, P#N, ^^u4);
        assume $local_value_is($s, #tok$1^27.3, #loc.a, $ptr_to_int(P#a), $ptr_to(^^u4));
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#0, $s);
        assume true;
        // if (<(i, N)) ...
        if (L#i < P#N)
        {
          anon3:
            // assert forall(mathint x; true; ==>(<=(max, x), <=(sum, *(i, x)))); 
            assert (forall Q#x$1^36.28#tc3: int :: {:weight 10} { $op_mul(L#i, Q#x$1^36.28#tc3) } L#max <= Q#x$1^36.28#tc3 ==> L#sum <= $op_mul(L#i, Q#x$1^36.28#tc3));
            // assume forall(mathint x; true; ==>(<=(max, x), <=(sum, *(i, x)))); 
            assume (forall Q#x$1^36.28#tc3: int :: {:weight 10} { $op_mul(L#i, Q#x$1^36.28#tc3) } L#max <= Q#x$1^36.28#tc3 ==> L#sum <= $op_mul(L#i, Q#x$1^36.28#tc3));
            // assert @reads_check_normal(a[i]); 
            assert $thread_local($s, $idx($phys_ptr_cast(P#a, ^^u4), L#i));
            assume true;
            // if (<(max, *(a[i]))) ...
            if (L#max < $rd_inv($s, $field($idx($phys_ptr_cast(P#a, ^^u4), L#i)), $emb0($idx($phys_ptr_cast(P#a, ^^u4), L#i))))
            {
              anon1:
                // assert @reads_check_normal(a[i]); 
                assert $thread_local($s, $idx($phys_ptr_cast(P#a, ^^u4), L#i));
                // max := *(a[i]); 
                L#max := $rd_inv($s, $field($idx($phys_ptr_cast(P#a, ^^u4), L#i)), $emb0($idx($phys_ptr_cast(P#a, ^^u4), L#i)));
                assume $local_value_is($s, #tok$1^38.7, #loc.max, L#max, ^^u4);
            }
            else
            {
              anon2:
                // empty
            }

          anon4:
            // assert <=(sum, *(i, max)); 
            assert L#sum <= $op_mul(L#i, L#max);
            // assume <=(sum, *(i, max)); 
            assume L#sum <= $op_mul(L#i, L#max);
            // assert @reads_check_normal(a[i]); 
            assert $thread_local($s, $idx($phys_ptr_cast(P#a, ^^u4), L#i));
            // sum := unchecked+(sum, *(a[i])); 
            L#sum := $unchk_add(^^u4, L#sum, $rd_inv($s, $field($idx($phys_ptr_cast(P#a, ^^u4), L#i)), $emb0($idx($phys_ptr_cast(P#a, ^^u4), L#i))));
            assume $local_value_is($s, #tok$1^42.32, #loc.sum, L#sum, ^^u4);
            // empty
            // assert @in_range_u4(+(i, 1)); 
            assert $in_range_u4(L#i + 1);
            // assert @reads_check_normal(a[i]); 
            assert $thread_local($s, $idx($phys_ptr_cast(P#a, ^^u4), L#i));
            // S := @map_updated(S, +(i, 1), +(@map_get(S, i), *(a[i]))); 
            SL#S := $store.$map_t..^^mathint.^^mathint(SL#S, L#i + 1, $select.$map_t..^^mathint.^^mathint(SL#S, L#i) + $rd_inv($s, $field($idx($phys_ptr_cast(P#a, ^^u4), L#i)), $emb0($idx($phys_ptr_cast(P#a, ^^u4), L#i))));
            assume $local_value_is($s, #tok$1^43.27, #loc.S, $map_t..^^mathint.^^mathint_to_int(SL#S), $map_t(^^mathint, ^^mathint));
        }
        else
        {
          anon5:
            // goto #break_1; 
            goto #break_1;
        }

      #continue_1:
        // assert @in_range_u4(+(i, 1)); 
        assert $in_range_u4(L#i + 1);
        // i := +(i, 1); 
        L#i := L#i + 1;
        assume $local_value_is($s, #tok$1^27.22, #loc.i, L#i, ^^u4);
        assume true;
    }

  anon8:
    assume $full_stop_ext(#tok$1^27.3, $s);

  #break_1:
    // assert @prim_writes_check(maxout); 
    assert $writable_prim($s, #wrTime$1^9.1, $phys_ptr_cast(P#maxout, ^^u4));
    // *maxout := max; 
    call $write_int($field($phys_ptr_cast(P#maxout, ^^u4)), $emb0($phys_ptr_cast(P#maxout, ^^u4)), L#max);
    assume $full_stop_ext(#tok$1^46.4, $s);
    // return sum; 
    $result := L#sum;
    assert $position_marker();
    goto #exit;

  anon9:
    // empty

  #exit:
}



const unique l#public: $label;

type $map_t..^^mathint.^^mathint;

function $select.$map_t..^^mathint.^^mathint(M: $map_t..^^mathint.^^mathint, p: int) : int;

function $store.$map_t..^^mathint.^^mathint(M: $map_t..^^mathint.^^mathint, p: int, v: int) : $map_t..^^mathint.^^mathint;

function $eq.$map_t..^^mathint.^^mathint(M1: $map_t..^^mathint.^^mathint, M2: $map_t..^^mathint.^^mathint) : bool;

const $zero.$map_t..^^mathint.^^mathint: $map_t..^^mathint.^^mathint;

axiom (forall M: $map_t..^^mathint.^^mathint, p: int, v: int :: true);

axiom (forall M: $map_t..^^mathint.^^mathint, p: int, v: int, q: int :: $select.$map_t..^^mathint.^^mathint($store.$map_t..^^mathint.^^mathint(M, q, v), p) == (if p == q then v else $select.$map_t..^^mathint.^^mathint(M, p)));

axiom (forall M1: $map_t..^^mathint.^^mathint, M2: $map_t..^^mathint.^^mathint :: { $eq.$map_t..^^mathint.^^mathint(M1, M2) } (forall p: int :: $select.$map_t..^^mathint.^^mathint(M1, p) == $select.$map_t..^^mathint.^^mathint(M2, p)) ==> $eq.$map_t..^^mathint.^^mathint(M1, M2));

axiom (forall M1: $map_t..^^mathint.^^mathint, M2: $map_t..^^mathint.^^mathint :: { $eq.$map_t..^^mathint.^^mathint(M1, M2) } $eq.$map_t..^^mathint.^^mathint(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^mathint.^^mathint(0) == $zero.$map_t..^^mathint.^^mathint;

axiom (forall p: int :: $select.$map_t..^^mathint.^^mathint($zero.$map_t..^^mathint.^^mathint, p) == 0);

axiom true;

const unique #tok$1^46.4: $token;

const unique #tok$1^27.22: $token;

const unique #tok$1^43.27: $token;

const unique #tok$1^42.32: $token;

const unique #tok$1^38.7: $token;

axiom $type_code_is(3, ^^mathint);

const unique #tok$1^27.3: $token;

const unique #tok$1^27.8: $token;

const unique #tok$1^25.25: $token;

const unique #loc.max: $token;

const unique #tok$1^21.3: $token;

const unique #loc.sum: $token;

const unique #tok$1^22.3: $token;

const unique #loc.i: $token;

const unique #tok$1^23.3: $token;

function $map_t..^^mathint.^^mathint_to_int(x: $map_t..^^mathint.^^mathint) : int;

function $int_to_map_t..^^mathint.^^mathint(x: int) : $map_t..^^mathint.^^mathint;

axiom (forall #x: $map_t..^^mathint.^^mathint :: #x == $int_to_map_t..^^mathint.^^mathint($map_t..^^mathint.^^mathint_to_int(#x)));

const unique #loc.S: $token;

const unique #tok$1^24.25: $token;

const unique #loc.maxout: $token;

const unique #loc.N: $token;

const unique #distTp2: $ctype;

axiom #distTp2 == $ptr_to(^^u4);

const unique #loc.a: $token;

const unique #tok$1^9.1: $token;

const unique #distTp1: $ctype;

axiom #distTp1 == $map_t(^^mathint, ^^mathint);

axiom $type_code_is(1, ^^u4);

const unique #loc.vscomp2010_p1_v3.c..27832: $token;

const unique #tok$1^7.39: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvscomp2010?5Cvscomp2010_p1_v3.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvscomp2010?5Cvscomp2010_p1_v3.c);
