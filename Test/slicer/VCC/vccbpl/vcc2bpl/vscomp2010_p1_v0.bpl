axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

procedure sum_max(P#a: int, P#N: int, P#maxout: int) returns ($result: int, OP#S: $map_t..^^u4.^^u4);
  requires $wrapped($s, $as_array($ptr(^^u4, P#a), ^^u4, P#N), $array(^^u4, P#N));
  modifies $s, $cev_pc;
  free ensures $in_range_u4($result);
  ensures (forall Q#k$1^8.27#tc1: int :: $in_range_u4(Q#k$1^8.27#tc1) ==> Q#k$1^8.27#tc1 < P#N ==> $select.$map_t..^^u4.^^u4(OP#S, Q#k$1^8.27#tc1 + 1) == $select.$map_t..^^u4.^^u4(OP#S, Q#k$1^8.27#tc1) + $mem($s, $idx($ptr(^^u4, P#a), Q#k$1^8.27#tc1, ^^u4)));
  ensures $result == $select.$map_t..^^u4.^^u4(OP#S, P#N);
  ensures (forall Q#k$1^10.27#tc1: int :: $in_range_u4(Q#k$1^10.27#tc1) ==> Q#k$1^10.27#tc1 < P#N ==> $mem($s, $idx($ptr(^^u4, P#a), Q#k$1^10.27#tc1, ^^u4)) <= $mem($s, $ptr(^^u4, P#maxout)));
  ensures $result <= $op_mul(P#N, $mem($s, $ptr(^^u4, P#maxout)));
  ensures $mutable($s, $ptr(^^u4, P#maxout));
  ensures $emb($s, $ptr(^^u4, P#maxout)) == $emb(old($s), $ptr(^^u4, P#maxout));
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^^u4, P#maxout) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^^u4, P#maxout) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^^u4, P#maxout) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation sum_max(P#a: int, P#N: int, P#maxout: int) returns ($result: int, OP#S: $map_t..^^u4.^^u4)
{
  var loopState#0: $state;
  var L#max: int where $in_range_u4(L#max);
  var L#sum: int where $in_range_u4(L#sum);
  var L#i: int where $in_range_u4(L#i);
  var SL#maxsum: int where $in_range_u4(SL#maxsum);
  var #wrTime$1^5.1: int;
  var #stackframe: int;

  anon7:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^5.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^5.1, #loc.a, $ptr_to_int($ptr(^^u4, P#a)), $ptr_to(^^u4)) && $local_value_is_ptr($s, #tok$1^5.1, #loc.a, $ptr(^^u4, P#a), $ptr_to(^^u4));
    assume $local_value_is($s, #tok$1^5.1, #loc.N, P#N, ^^u4);
    assume $local_value_is($s, #tok$1^5.1, #loc.maxout, $ptr_to_int($ptr(^^u4, P#maxout)), $ptr_to(^^u4)) && $local_value_is_ptr($s, #tok$1^5.1, #loc.maxout, $ptr(^^u4, P#maxout), $ptr_to(^^u4));
    assume #wrTime$1^5.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^5.1, #p) } $in_writes_at(#wrTime$1^5.1, #p) == (#p == $ptr(^^u4, P#maxout)));
    assume $mutable($s, $ptr(^^u4, P#maxout));
    // assume @in_range_phys_ptr((mathint)a); 
    assume $in_range_phys_ptr($ref($ptr(^^u4, P#a)));
    // assume @in_range_u4(N); 
    assume $in_range_u4(P#N);
    // assume @in_range_phys_ptr((mathint)maxout); 
    assume $in_range_phys_ptr($ref($ptr(^^u4, P#maxout)));
    // assert @_vcc_in_domain(@state, @_vcc_as_array(a, N), @_vcc_as_array(a, N)); 
    assert $in_domain_lab($s, $as_array($ptr(^^u4, P#a), ^^u4, P#N), $as_array($ptr(^^u4, P#a), ^^u4, P#N), l#public);
    // uint32_t maxsum; 
    assume $local_value_is($s, #tok$1^18.25, #loc.maxsum, SL#maxsum, ^^u4);
    // uint32_t i; 
    assume $local_value_is($s, #tok$1^15.3, #loc.i, L#i, ^^u4);
    // uint32_t sum; 
    assume $local_value_is($s, #tok$1^14.3, #loc.sum, L#sum, ^^u4);
    // uint32_t max; 
    assume $local_value_is($s, #tok$1^13.3, #loc.max, L#max, ^^u4);
    // var uint32_t max
    // sum := 0; 
    L#sum := 0;
    assume $local_value_is($s, #tok$1^14.3, #loc.sum, L#sum, ^^u4);
    // var uint32_t i
    // maxsum := 0; 
    SL#maxsum := 0;
    assume $local_value_is($s, #tok$1^18.25, #loc.maxsum, SL#maxsum, ^^u4);
    // S := lambda#1(); 
    call OP#S := lambda#1();
    assume $full_stop_ext(#tok$1^20.29, $s);
    assume $local_value_is($s, #tok$1^20.29, #loc.S, $map_t..^^u4.^^u4_to_int(OP#S), $map_t(^^u4, ^^u4));
    // i := 0; 
    L#i := 0;
    assume $local_value_is($s, #tok$1^22.8, #loc.i, L#i, ^^u4);
    loopState#0 := $s;
    while (true)
      invariant (forall Q#k$1^23.31#tc1: int :: $in_range_u4(Q#k$1^23.31#tc1) ==> Q#k$1^23.31#tc1 < L#i ==> $select.$map_t..^^u4.^^u4(OP#S, Q#k$1^23.31#tc1 + 1) == $select.$map_t..^^u4.^^u4(OP#S, Q#k$1^23.31#tc1) + $mem($s, $idx($ptr(^^u4, P#a), Q#k$1^23.31#tc1, ^^u4)));
      invariant L#sum == $select.$map_t..^^u4.^^u4(OP#S, L#i);
      invariant (forall Q#k$1^25.31#tc1: int :: $in_range_u4(Q#k$1^25.31#tc1) ==> Q#k$1^25.31#tc1 < L#i ==> $mem($s, $idx($ptr(^^u4, P#a), Q#k$1^25.31#tc1, ^^u4)) <= L#max);
      invariant L#sum <= SL#maxsum;
      invariant SL#maxsum <= $op_mul(L#i, L#max);
      invariant L#sum <= $op_mul(L#i, L#max);
      invariant L#i <= P#N;
    {
      anon6:
        assume (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^^u4, P#maxout) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^^u4, P#maxout) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || #p == $ptr(^^u4, P#maxout) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$1^22.3, $s);
        assume $local_value_is($s, #tok$1^22.3, #loc.S, $map_t..^^u4.^^u4_to_int(OP#S), $map_t(^^u4, ^^u4));
        assume $local_value_is($s, #tok$1^22.3, #loc.max, L#max, ^^u4);
        assume $local_value_is($s, #tok$1^22.3, #loc.sum, L#sum, ^^u4);
        assume $local_value_is($s, #tok$1^22.3, #loc.i, L#i, ^^u4);
        assume $local_value_is($s, #tok$1^22.3, #loc.maxsum, SL#maxsum, ^^u4);
        assume $local_value_is($s, #tok$1^22.3, #loc.maxout, $ptr_to_int($ptr(^^u4, P#maxout)), $ptr_to(^^u4)) && $local_value_is_ptr($s, #tok$1^22.3, #loc.maxout, $ptr(^^u4, P#maxout), $ptr_to(^^u4));
        assume $local_value_is($s, #tok$1^22.3, #loc.N, P#N, ^^u4);
        assume $local_value_is($s, #tok$1^22.3, #loc.a, $ptr_to_int($ptr(^^u4, P#a)), $ptr_to(^^u4)) && $local_value_is_ptr($s, #tok$1^22.3, #loc.a, $ptr(^^u4, P#a), $ptr_to(^^u4));
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#0, $s);
        assume true;
        // if (<(i, N)) ...
        if (L#i < P#N)
        {
          anon3:
            // assert <(i, N); 
            assert L#i < P#N;
            // assume <(i, N); 
            assume L#i < P#N;
            // assert @reads_check_normal(a[i]); 
            assert $typed2($s, $idx($ptr(^^u4, P#a), L#i, ^^u4), ^^u4);
            assert $thread_local2($s, $idx($ptr(^^u4, P#a), L#i, ^^u4), ^^u4);
            assume true;
            // if (<(max, *(a[i]))) ...
            if (L#max < $mem($s, $idx($ptr(^^u4, P#a), L#i, ^^u4)))
            {
              anon1:
                // assert @reads_check_normal(a[i]); 
                assert $typed2($s, $idx($ptr(^^u4, P#a), L#i, ^^u4), ^^u4);
                assert $thread_local2($s, $idx($ptr(^^u4, P#a), L#i, ^^u4), ^^u4);
                // max := *(a[i]); 
                L#max := $mem($s, $idx($ptr(^^u4, P#a), L#i, ^^u4));
                assume $local_value_is($s, #tok$1^34.7, #loc.max, L#max, ^^u4);
            }
            else
            {
              anon2:
                // empty
            }

          anon4:
            // assume <(+(maxsum, max), 4294967295); 
            assume SL#maxsum + L#max < 4294967295;
            // assume <=(maxsum, *(i, max)); 
            assume SL#maxsum <= $op_mul(L#i, L#max);
            // assert @in_range_u4(+(maxsum, max)); 
            assert $in_range_u4(SL#maxsum + L#max);
            // maxsum := +(maxsum, max); 
            SL#maxsum := SL#maxsum + L#max;
            assume $local_value_is($s, #tok$1^41.27, #loc.maxsum, SL#maxsum, ^^u4);
            // assert @in_range_u4(+(sum, *(a[i]))); 
            assert $in_range_u4(L#sum + $mem($s, $idx($ptr(^^u4, P#a), L#i, ^^u4)));
            // assert @reads_check_normal(a[i]); 
            assert $typed2($s, $idx($ptr(^^u4, P#a), L#i, ^^u4), ^^u4);
            assert $thread_local2($s, $idx($ptr(^^u4, P#a), L#i, ^^u4), ^^u4);
            // sum := +(sum, *(a[i])); 
            L#sum := L#sum + $mem($s, $idx($ptr(^^u4, P#a), L#i, ^^u4));
            assume $local_value_is($s, #tok$1^42.5, #loc.sum, L#sum, ^^u4);
            // assert @in_range_u4(+(i, 1)); 
            assert $in_range_u4(L#i + 1);
            // assert @in_range_u4(+(@map_get(S, i), *(a[i]))); 
            assert $in_range_u4($select.$map_t..^^u4.^^u4(OP#S, L#i) + $mem($s, $idx($ptr(^^u4, P#a), L#i, ^^u4)));
            // assert @reads_check_normal(a[i]); 
            assert $typed2($s, $idx($ptr(^^u4, P#a), L#i, ^^u4), ^^u4);
            assert $thread_local2($s, $idx($ptr(^^u4, P#a), L#i, ^^u4), ^^u4);
            // S := @map_updated(S, +(i, 1), +(@map_get(S, i), *(a[i]))); 
            OP#S := $store.$map_t..^^u4.^^u4(OP#S, L#i + 1, $select.$map_t..^^u4.^^u4(OP#S, L#i) + $mem($s, $idx($ptr(^^u4, P#a), L#i, ^^u4)));
            assume $local_value_is($s, #tok$1^43.27, #loc.S, $map_t..^^u4.^^u4_to_int(OP#S), $map_t(^^u4, ^^u4));
        }
        else
        {
          anon5:
            // goto #break_2; 
            goto #break_2;
        }

      #continue_2:
        // assert @in_range_u4(+(i, 1)); 
        assert $in_range_u4(L#i + 1);
        // i := +(i, 1); 
        L#i := L#i + 1;
        assume $local_value_is($s, #tok$1^22.22, #loc.i, L#i, ^^u4);
        assume true;
    }

  anon8:
    assume $full_stop_ext(#tok$1^22.3, $s);

  #break_2:
    // assert ==(sum, @map_get(S, N)); 
    assert L#sum == $select.$map_t..^^u4.^^u4(OP#S, P#N);
    // assume ==(sum, @map_get(S, N)); 
    assume L#sum == $select.$map_t..^^u4.^^u4(OP#S, P#N);
    // assert @_vcc_typed2(@state, maxout); 
    assert $typed2($s, $ptr(^^u4, P#maxout), ^^u4);
    // assert @prim_writes_check(maxout); 
    assert $writable($s, #wrTime$1^5.1, $ptr(^^u4, P#maxout));
    // *maxout := max; 
    call $write_int($ptr(^^u4, P#maxout), L#max);
    assume $full_stop_ext(#tok$1^47.4, $s);
    // return sum; 
    $result := L#sum;
    assert $position_marker();
    goto #exit;

  anon9:
    // empty

  #exit:
}



function F#lambda#1() : $map_t..^^u4.^^u4;

const unique cf#lambda#1: $pure_function;

axiom $function_arg_type(cf#lambda#1, 0, $map_t(^^u4, ^^u4));

procedure lambda#1() returns ($result: $map_t..^^u4.^^u4);
  free ensures $result == F#lambda#1();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#k$1^20.29#tc1: int :: { $select.$map_t..^^u4.^^u4(F#lambda#1(), Q#k$1^20.29#tc1) } $in_range_u4(Q#k$1^20.29#tc1) ==> $select.$map_t..^^u4.^^u4(F#lambda#1(), Q#k$1^20.29#tc1) == 0);

const unique l#public: $label;

type $map_t..^^u4.^^u4;

function $select.$map_t..^^u4.^^u4(M: $map_t..^^u4.^^u4, p: int) : int;

function $store.$map_t..^^u4.^^u4(M: $map_t..^^u4.^^u4, p: int, v: int) : $map_t..^^u4.^^u4;

function $eq.$map_t..^^u4.^^u4(M1: $map_t..^^u4.^^u4, M2: $map_t..^^u4.^^u4) : bool;

const $zero.$map_t..^^u4.^^u4: $map_t..^^u4.^^u4;

axiom (forall M: $map_t..^^u4.^^u4, p: int, v: int :: $in_range_t(^^u4, p) ==> $select.$map_t..^^u4.^^u4($store.$map_t..^^u4.^^u4(M, p, v), p) == $unchecked(^^u4, v));

axiom (forall M: $map_t..^^u4.^^u4, p: int, v: int, q: int :: p != q ==> $select.$map_t..^^u4.^^u4($store.$map_t..^^u4.^^u4(M, q, v), p) == $select.$map_t..^^u4.^^u4(M, p));

axiom (forall M1: $map_t..^^u4.^^u4, M2: $map_t..^^u4.^^u4 :: { $eq.$map_t..^^u4.^^u4(M1, M2) } (forall p: int :: $in_range_t(^^u4, p) ==> $unchecked(^^u4, $select.$map_t..^^u4.^^u4(M1, p)) == $unchecked(^^u4, $select.$map_t..^^u4.^^u4(M2, p))) ==> $eq.$map_t..^^u4.^^u4(M1, M2));

axiom (forall M1: $map_t..^^u4.^^u4, M2: $map_t..^^u4.^^u4 :: { $eq.$map_t..^^u4.^^u4(M1, M2) } $eq.$map_t..^^u4.^^u4(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^u4.^^u4(0) == $zero.$map_t..^^u4.^^u4;

axiom (forall p: int :: $select.$map_t..^^u4.^^u4($zero.$map_t..^^u4.^^u4, p) == 0);

axiom (forall r1: $record, r2: $record, f: $field, R: $ctype :: { $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)), $is_record_field(R, f, $map_t(^^u4, ^^u4)) } $eq.$map_t..^^u4.^^u4($int_to_map_t..^^u4.^^u4($rec_fetch(r1, f)), $int_to_map_t..^^u4.^^u4($rec_fetch(r2, f))) ==> $rec_base_eq($rec_fetch(r1, f), $rec_fetch(r2, f)));

axiom (forall M: $map_t..^^u4.^^u4, p: int :: $in_range_t(^^u4, $select.$map_t..^^u4.^^u4(M, p)));

const unique #tok$1^47.4: $token;

const unique #tok$1^22.22: $token;

const unique #tok$1^43.27: $token;

const unique #tok$1^42.5: $token;

const unique #tok$1^41.27: $token;

const unique #tok$1^34.7: $token;

const unique #tok$1^22.3: $token;

const unique #tok$1^22.8: $token;

function $map_t..^^u4.^^u4_to_int(x: $map_t..^^u4.^^u4) : int;

function $int_to_map_t..^^u4.^^u4(x: int) : $map_t..^^u4.^^u4;

axiom (forall #x: $map_t..^^u4.^^u4 :: #x == $int_to_map_t..^^u4.^^u4($map_t..^^u4.^^u4_to_int(#x)));

const unique #loc.S: $token;

const unique #tok$1^20.29: $token;

const unique #loc.max: $token;

const unique #tok$1^13.3: $token;

const unique #loc.sum: $token;

const unique #tok$1^14.3: $token;

const unique #loc.i: $token;

const unique #tok$1^15.3: $token;

const unique #loc.maxsum: $token;

const unique #tok$1^18.25: $token;

const unique #loc.maxout: $token;

const unique #loc.N: $token;

const unique #distTp2: $ctype;

axiom #distTp2 == $ptr_to(^^u4);

const unique #loc.a: $token;

const unique #tok$1^5.1: $token;

axiom $type_code_is(1, ^^u4);

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvscomp2010?5Cvscomp2010_p1_v0.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvscomp2010?5Cvscomp2010_p1_v0.c);

const unique #distTp1: $ctype;

axiom #distTp1 == $map_t(^^u4, ^^u4);
