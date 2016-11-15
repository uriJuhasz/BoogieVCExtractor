axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

procedure sum_max(P#a: $ptr, P#N: int, P#maxout: $ptr) returns ($result: int, OP#S: $map_t..^^u4.^^u4);
  requires $wrapped($s, $as_array($phys_ptr_cast(P#a, ^^u4), ^^u4, P#N), $array(^^u4, P#N));
  modifies $s, $cev_pc;
  free ensures $in_range_u4($result);
  ensures (forall Q#k$1^8.27#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^8.27#tc1) } $in_range_u4(Q#k$1^8.27#tc1) ==> Q#k$1^8.27#tc1 < P#N ==> $select.$map_t..^^u4.^^u4(OP#S, Q#k$1^8.27#tc1 + 1) == $select.$map_t..^^u4.^^u4(OP#S, Q#k$1^8.27#tc1) + $rd_inv($s, $field($idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^8.27#tc1)), $emb0($idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^8.27#tc1))));
  ensures $result == $select.$map_t..^^u4.^^u4(OP#S, P#N);
  ensures (forall Q#k$1^10.27#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^10.27#tc1) } $in_range_u4(Q#k$1^10.27#tc1) ==> Q#k$1^10.27#tc1 < P#N ==> $rd_inv($s, $field($idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^10.27#tc1)), $emb0($idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^10.27#tc1))) <= $rd_inv($s, $field($phys_ptr_cast(P#maxout, ^^u4)), $emb0($phys_ptr_cast(P#maxout, ^^u4))));
  ensures $result <= $op_mul(P#N, $rd_inv($s, $field($phys_ptr_cast(P#maxout, ^^u4)), $emb0($phys_ptr_cast(P#maxout, ^^u4))));
  ensures $mutable($s, $phys_ptr_cast(P#maxout, ^^u4));
  ensures $emb($s, $phys_ptr_cast(P#maxout, ^^u4)) == $emb(old($s), $phys_ptr_cast(P#maxout, ^^u4));
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#maxout, ^^u4)));
  free ensures $call_transition(old($s), $s);



implementation sum_max(P#a: $ptr, P#N: int, P#maxout: $ptr) returns ($result: int, OP#S: $map_t..^^u4.^^u4)
{
  var #wrTime$1^19.3: int;
  var loopState#0: $state;
  var L#max: int where $in_range_u4(L#max);
  var L#sum: int where $in_range_u4(L#sum);
  var L#i: int where $in_range_u4(L#i);
  var #wrTime$1^5.1: int;
  var #stackframe: int;

  anon7:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^5.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^5.1, #loc.a, $ptr_to_int(P#a), $ptr_to(^^u4));
    assume $local_value_is($s, #tok$1^5.1, #loc.N, P#N, ^^u4);
    assume $local_value_is($s, #tok$1^5.1, #loc.maxout, $ptr_to_int(P#maxout), $ptr_to(^^u4));
    assume #wrTime$1^5.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^5.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#maxout, ^^u4)));
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
    // uint32_t i; 
    assume $local_value_is($s, #tok$1^15.3, #loc.i, L#i, ^^u4);
    // uint32_t sum; 
    assume $local_value_is($s, #tok$1^14.3, #loc.sum, L#sum, ^^u4);
    // uint32_t max; 
    assume $local_value_is($s, #tok$1^13.3, #loc.max, L#max, ^^u4);
    // max := 0; 
    L#max := 0;
    assume $local_value_is($s, #tok$1^13.3, #loc.max, L#max, ^^u4);
    // sum := 0; 
    L#sum := 0;
    assume $local_value_is($s, #tok$1^14.3, #loc.sum, L#sum, ^^u4);
    // var uint32_t i
    // S := @map_updated(S, 0, 0); 
    OP#S := $store.$map_t..^^u4.^^u4(OP#S, 0, 0);
    assume $local_value_is($s, #tok$1^17.25, #loc.S, $map_t..^^u4.^^u4_to_int(OP#S), $map_t(^^u4, ^^u4));
    // i := 0; 
    L#i := 0;
    assume $local_value_is($s, #tok$1^19.8, #loc.i, L#i, ^^u4);
    call $bump_timestamp();
    assume $full_stop_ext(#tok$1^19.3, $s);
    loopState#0 := $s;
    assume #wrTime$1^19.3 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^19.3, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#maxout, ^^u4)));
    assert (forall #loopWrites^$1^19.3: $ptr :: { $dont_instantiate(#loopWrites^$1^19.3) } $listed_in_writes($s, #wrTime$1^19.3, #loopWrites^$1^19.3) ==> $top_writable($s, #wrTime$1^5.1, #loopWrites^$1^19.3));
    while (true)
      invariant (forall Q#k$1^20.31#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^20.31#tc1) } $in_range_u4(Q#k$1^20.31#tc1) ==> Q#k$1^20.31#tc1 < L#i ==> $select.$map_t..^^u4.^^u4(OP#S, Q#k$1^20.31#tc1 + 1) == $select.$map_t..^^u4.^^u4(OP#S, Q#k$1^20.31#tc1) + $rd_inv($s, $field($idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^20.31#tc1)), $emb0($idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^20.31#tc1))));
      invariant L#sum == $select.$map_t..^^u4.^^u4(OP#S, L#i);
      invariant (forall Q#k$1^22.31#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^22.31#tc1) } $in_range_u4(Q#k$1^22.31#tc1) ==> Q#k$1^22.31#tc1 < L#i ==> $rd_inv($s, $field($idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^22.31#tc1)), $emb0($idx($phys_ptr_cast(P#a, ^^u4), Q#k$1^22.31#tc1))) <= L#max);
      invariant L#sum <= $op_mul(L#i, L#max);
      invariant L#i <= P#N;
    {
      anon6:
        assume $modifies(loopState#0, $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#maxout, ^^u4)));
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$1^19.3, $s);
        assume $local_value_is($s, #tok$1^19.3, #loc.S, $map_t..^^u4.^^u4_to_int(OP#S), $map_t(^^u4, ^^u4));
        assume $local_value_is($s, #tok$1^19.3, #loc.max, L#max, ^^u4);
        assume $local_value_is($s, #tok$1^19.3, #loc.sum, L#sum, ^^u4);
        assume $local_value_is($s, #tok$1^19.3, #loc.i, L#i, ^^u4);
        assume $local_value_is($s, #tok$1^19.3, #loc.maxout, $ptr_to_int(P#maxout), $ptr_to(^^u4));
        assume $local_value_is($s, #tok$1^19.3, #loc.N, P#N, ^^u4);
        assume $local_value_is($s, #tok$1^19.3, #loc.a, $ptr_to_int(P#a), $ptr_to(^^u4));
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#0, $s);
        assume true;
        // if (<(i, N)) ...
        if (L#i < P#N)
        {
          anon3:
            // assert forall(mathint x; true; ==>(<=(max, x), <=(sum, *(i, x)))); 
            assert (forall Q#x$1^26.28#tc2: int :: {:weight 10} { $op_mul(L#i, Q#x$1^26.28#tc2) } L#max <= Q#x$1^26.28#tc2 ==> L#sum <= $op_mul(L#i, Q#x$1^26.28#tc2));
            // assume forall(mathint x; true; ==>(<=(max, x), <=(sum, *(i, x)))); 
            assume (forall Q#x$1^26.28#tc2: int :: {:weight 10} { $op_mul(L#i, Q#x$1^26.28#tc2) } L#max <= Q#x$1^26.28#tc2 ==> L#sum <= $op_mul(L#i, Q#x$1^26.28#tc2));
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
                assume $local_value_is($s, #tok$1^28.7, #loc.max, L#max, ^^u4);
            }
            else
            {
              anon2:
                // empty
            }

          anon4:
            // assume <(+(sum, *(a[i])), 4294967295); 
            assume L#sum + $rd_inv($s, $field($idx($phys_ptr_cast(P#a, ^^u4), L#i)), $emb0($idx($phys_ptr_cast(P#a, ^^u4), L#i))) < 4294967295;
            // assert <=(sum, *(i, max)); 
            assert L#sum <= $op_mul(L#i, L#max);
            // assume <=(sum, *(i, max)); 
            assume L#sum <= $op_mul(L#i, L#max);
            // assert @in_range_u4(+(sum, *(a[i]))); 
            assert $in_range_u4(L#sum + $rd_inv($s, $field($idx($phys_ptr_cast(P#a, ^^u4), L#i)), $emb0($idx($phys_ptr_cast(P#a, ^^u4), L#i))));
            // assert @reads_check_normal(a[i]); 
            assert $thread_local($s, $idx($phys_ptr_cast(P#a, ^^u4), L#i));
            // sum := +(sum, *(a[i])); 
            L#sum := L#sum + $rd_inv($s, $field($idx($phys_ptr_cast(P#a, ^^u4), L#i)), $emb0($idx($phys_ptr_cast(P#a, ^^u4), L#i)));
            assume $local_value_is($s, #tok$1^33.5, #loc.sum, L#sum, ^^u4);
            // assert @in_range_u4(+(i, 1)); 
            assert $in_range_u4(L#i + 1);
            // assert @in_range_u4(+(@map_get(S, i), *(a[i]))); 
            assert $in_range_u4($select.$map_t..^^u4.^^u4(OP#S, L#i) + $rd_inv($s, $field($idx($phys_ptr_cast(P#a, ^^u4), L#i)), $emb0($idx($phys_ptr_cast(P#a, ^^u4), L#i))));
            // assert @reads_check_normal(a[i]); 
            assert $thread_local($s, $idx($phys_ptr_cast(P#a, ^^u4), L#i));
            // S := @map_updated(S, +(i, 1), +(@map_get(S, i), *(a[i]))); 
            OP#S := $store.$map_t..^^u4.^^u4(OP#S, L#i + 1, $select.$map_t..^^u4.^^u4(OP#S, L#i) + $rd_inv($s, $field($idx($phys_ptr_cast(P#a, ^^u4), L#i)), $emb0($idx($phys_ptr_cast(P#a, ^^u4), L#i))));
            assume $local_value_is($s, #tok$1^34.27, #loc.S, $map_t..^^u4.^^u4_to_int(OP#S), $map_t(^^u4, ^^u4));
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
        assume $local_value_is($s, #tok$1^19.22, #loc.i, L#i, ^^u4);
        assume true;
    }

  anon8:
    assume $full_stop_ext(#tok$1^19.3, $s);

  #break_1:
    // assert ==(sum, @map_get(S, N)); 
    assert L#sum == $select.$map_t..^^u4.^^u4(OP#S, P#N);
    // assume ==(sum, @map_get(S, N)); 
    assume L#sum == $select.$map_t..^^u4.^^u4(OP#S, P#N);
    // assert @prim_writes_check(maxout); 
    assert $writable_prim($s, #wrTime$1^5.1, $phys_ptr_cast(P#maxout, ^^u4));
    // *maxout := max; 
    call $write_int($field($phys_ptr_cast(P#maxout, ^^u4)), $emb0($phys_ptr_cast(P#maxout, ^^u4)), L#max);
    assume $full_stop_ext(#tok$1^38.4, $s);
    // return sum; 
    $result := L#sum;
    assert $position_marker();
    goto #exit;

  anon9:
    // empty

  #exit:
}



const unique l#public: $label;

type $map_t..^^u4.^^u4;

function $select.$map_t..^^u4.^^u4(M: $map_t..^^u4.^^u4, p: int) : int;

function $store.$map_t..^^u4.^^u4(M: $map_t..^^u4.^^u4, p: int, v: int) : $map_t..^^u4.^^u4;

function $eq.$map_t..^^u4.^^u4(M1: $map_t..^^u4.^^u4, M2: $map_t..^^u4.^^u4) : bool;

const $zero.$map_t..^^u4.^^u4: $map_t..^^u4.^^u4;

axiom (forall M: $map_t..^^u4.^^u4, p: int, v: int :: true);

axiom (forall M: $map_t..^^u4.^^u4, p: int, v: int, q: int :: $select.$map_t..^^u4.^^u4($store.$map_t..^^u4.^^u4(M, q, v), p) == (if $unchecked(^^u4, p) == $unchecked(^^u4, q) then $unchecked(^^u4, v) else $select.$map_t..^^u4.^^u4(M, p)));

axiom (forall M1: $map_t..^^u4.^^u4, M2: $map_t..^^u4.^^u4 :: { $eq.$map_t..^^u4.^^u4(M1, M2) } (forall p: int :: $unchecked(^^u4, $select.$map_t..^^u4.^^u4(M1, $unchecked(^^u4, p))) == $unchecked(^^u4, $select.$map_t..^^u4.^^u4(M2, $unchecked(^^u4, p)))) ==> $eq.$map_t..^^u4.^^u4(M1, M2));

axiom (forall M1: $map_t..^^u4.^^u4, M2: $map_t..^^u4.^^u4 :: { $eq.$map_t..^^u4.^^u4(M1, M2) } $eq.$map_t..^^u4.^^u4(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^u4.^^u4(0) == $zero.$map_t..^^u4.^^u4;

axiom (forall p: int :: $select.$map_t..^^u4.^^u4($zero.$map_t..^^u4.^^u4, p) == 0);

axiom true;

axiom (forall M: $map_t..^^u4.^^u4, p: int :: $in_range_t(^^u4, $select.$map_t..^^u4.^^u4(M, p)));

const unique #tok$1^38.4: $token;

const unique #tok$1^19.22: $token;

const unique #tok$1^34.27: $token;

const unique #tok$1^33.5: $token;

const unique #tok$1^28.7: $token;

axiom $type_code_is(2, ^^mathint);

const unique #tok$1^19.3: $token;

const unique #tok$1^19.8: $token;

function $map_t..^^u4.^^u4_to_int(x: $map_t..^^u4.^^u4) : int;

function $int_to_map_t..^^u4.^^u4(x: int) : $map_t..^^u4.^^u4;

axiom (forall #x: $map_t..^^u4.^^u4 :: #x == $int_to_map_t..^^u4.^^u4($map_t..^^u4.^^u4_to_int(#x)));

const unique #loc.S: $token;

const unique #tok$1^17.25: $token;

const unique #loc.max: $token;

const unique #tok$1^13.3: $token;

const unique #loc.sum: $token;

const unique #tok$1^14.3: $token;

const unique #loc.i: $token;

const unique #tok$1^15.3: $token;

const unique #loc.maxout: $token;

const unique #loc.N: $token;

const unique #distTp2: $ctype;

axiom #distTp2 == $ptr_to(^^u4);

const unique #loc.a: $token;

const unique #tok$1^5.1: $token;

axiom $type_code_is(1, ^^u4);

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvscomp2010?5Cvscomp2010_p1_v1.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvscomp2010?5Cvscomp2010_p1_v1.c);

const unique #distTp1: $ctype;

axiom #distTp1 == $map_t(^^u4, ^^u4);
