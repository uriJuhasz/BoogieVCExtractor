axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $is_math_type(^$#thread_id);

type $#thread_id;

procedure invert(P#A: int, P#B: int, P#N: int, SP#inverse: $map_t..^^u4.^^u4);
  requires (forall Q#_j$1^17.29#tc1: int :: $in_range_u4(Q#_j$1^17.29#tc1) ==> Q#_j$1^17.29#tc1 < P#N ==> $mem($s, $idx($ptr(^^u4, P#A), Q#_j$1^17.29#tc1, ^^u4)) < P#N);
  requires (forall Q#_j1$1^18.29#tc1: int, Q#_j2$1^18.29#tc1: int :: $in_range_u4(Q#_j1$1^18.29#tc1) && $in_range_u4(Q#_j2$1^18.29#tc1) ==> Q#_j1$1^18.29#tc1 < P#N && Q#_j2$1^18.29#tc1 < P#N && $mem($s, $idx($ptr(^^u4, P#A), Q#_j1$1^18.29#tc1, ^^u4)) == $mem($s, $idx($ptr(^^u4, P#A), Q#_j2$1^18.29#tc1, ^^u4)) ==> Q#_j1$1^18.29#tc1 == Q#_j2$1^18.29#tc1);
  requires (forall Q#_j$1^19.29#tc1: int :: $in_range_u4(Q#_j$1^19.29#tc1) ==> Q#_j$1^19.29#tc1 < P#N ==> $select.$map_t..^^u4.^^u4(SP#inverse, Q#_j$1^19.29#tc1) < P#N);
  requires (forall Q#_j$1^20.29#tc1: int :: $in_range_u4(Q#_j$1^20.29#tc1) ==> Q#_j$1^20.29#tc1 < P#N ==> $mem($s, $idx($ptr(^^u4, P#A), $select.$map_t..^^u4.^^u4(SP#inverse, Q#_j$1^20.29#tc1), ^^u4)) == Q#_j$1^20.29#tc1);
  requires $wrapped($s, $as_array($ptr(^^u4, P#A), ^^u4, P#N), $array(^^u4, P#N));
  requires $mutable($s, $as_array($ptr(^^u4, P#B), ^^u4, P#N));
  modifies $s, $cev_pc;
  ensures (forall Q#_j$1^24.28#tc1: int :: $in_range_u4(Q#_j$1^24.28#tc1) ==> Q#_j$1^24.28#tc1 < P#N ==> $mem($s, $idx($ptr(^^u4, P#B), Q#_j$1^24.28#tc1, ^^u4)) < P#N);
  ensures (forall Q#_j1$1^25.28#tc1: int, Q#_j2$1^25.28#tc1: int :: $in_range_u4(Q#_j1$1^25.28#tc1) && $in_range_u4(Q#_j2$1^25.28#tc1) ==> Q#_j1$1^25.28#tc1 < P#N && Q#_j2$1^25.28#tc1 < P#N && $mem($s, $idx($ptr(^^u4, P#B), Q#_j1$1^25.28#tc1, ^^u4)) == $mem($s, $idx($ptr(^^u4, P#B), Q#_j2$1^25.28#tc1, ^^u4)) ==> Q#_j1$1^25.28#tc1 == Q#_j2$1^25.28#tc1);
  ensures (forall Q#_j$1^26.28#tc1: int :: $in_range_u4(Q#_j$1^26.28#tc1) ==> Q#_j$1^26.28#tc1 < P#N ==> $mem($s, $idx($ptr(^^u4, P#B), $mem($s, $idx($ptr(^^u4, P#A), Q#_j$1^26.28#tc1, ^^u4)), ^^u4)) == Q#_j$1^26.28#tc1);
  ensures $wrapped($s, $as_array($ptr(^^u4, P#A), ^^u4, P#N), $array(^^u4, P#N));
  ensures $mutable($s, $as_array($ptr(^^u4, P#B), ^^u4, P#N));
  free ensures (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $array_range(old($s), $ptr(^^u4, P#B), ^^u4, P#N)) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $array_range(old($s), $ptr(^^u4, P#B), ^^u4, P#N)) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $array_range(old($s), $ptr(^^u4, P#B), ^^u4, P#N)) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation invert(P#A: int, P#B: int, P#N: int, SP#inverse: $map_t..^^u4.^^u4)
{
  var loopState#0: $state;
  var L#i: int where $in_range_u4(L#i);
  var #wrTime$1^16.1: int;
  var #stackframe: int;

  anon4:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^16.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^16.1, #loc.A, $ptr_to_int($ptr(^^u4, P#A)), $ptr_to(^^u4)) && $local_value_is_ptr($s, #tok$1^16.1, #loc.A, $ptr(^^u4, P#A), $ptr_to(^^u4));
    assume $local_value_is($s, #tok$1^16.1, #loc.B, $ptr_to_int($ptr(^^u4, P#B)), $ptr_to(^^u4)) && $local_value_is_ptr($s, #tok$1^16.1, #loc.B, $ptr(^^u4, P#B), $ptr_to(^^u4));
    assume $local_value_is($s, #tok$1^16.1, #loc.N, P#N, ^^u4);
    assume $local_value_is($s, #tok$1^16.1, #loc.inverse, $map_t..^^u4.^^u4_to_int(SP#inverse), $map_t(^^u4, ^^u4));
    assume #wrTime$1^16.1 == $current_timestamp($s);
    assume (forall #p: $ptr :: { $in_writes_at(#wrTime$1^16.1, #p) } $in_writes_at(#wrTime$1^16.1, #p) == $set_in(#p, $array_range($s, $ptr(^^u4, P#B), ^^u4, P#N)));
    assume (forall #p: $ptr :: { $st($s, #p) } { $ts($s, #p) } $set_in(#p, $array_range($s, $ptr(^^u4, P#B), ^^u4, P#N)) ==> $thread_owned_or_even_mutable($s, #p));
    // assume @in_range_phys_ptr((mathint)A); 
    assume $in_range_phys_ptr($ref($ptr(^^u4, P#A)));
    // assume @in_range_phys_ptr((mathint)B); 
    assume $in_range_phys_ptr($ref($ptr(^^u4, P#B)));
    // assume @in_range_u4(N); 
    assume $in_range_u4(P#N);
    // assert @_vcc_in_domain(@state, @_vcc_as_array(A, N), @_vcc_as_array(A, N)); 
    assert $in_domain_lab($s, $as_array($ptr(^^u4, P#A), ^^u4, P#N), $as_array($ptr(^^u4, P#A), ^^u4, P#N), l#public);
    // uint32_t i; 
    assume $local_value_is($s, #tok$1^28.3, #loc.i, L#i, ^^u4);
    // var uint32_t i
    // i := 0; 
    L#i := 0;
    assume $local_value_is($s, #tok$1^30.8, #loc.i, L#i, ^^u4);
    loopState#0 := $s;
    while (true)
      invariant (forall Q#j$1^31.31#tc1: int :: $in_range_u4(Q#j$1^31.31#tc1) ==> Q#j$1^31.31#tc1 < L#i ==> $mem($s, $idx($ptr(^^u4, P#B), $mem($s, $idx($ptr(^^u4, P#A), Q#j$1^31.31#tc1, ^^u4)), ^^u4)) == Q#j$1^31.31#tc1);
    {
      anon3:
        assume (forall #p: $ptr :: { $mem($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $array_range(old($s), $ptr(^^u4, P#B), ^^u4, P#N)) || $mem_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $st($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $array_range(old($s), $ptr(^^u4, P#B), ^^u4, P#N)) || $st_eq(old($s), $s, #p)) && (forall #p: $ptr :: { $ts($s, #p) } $irrelevant(old($s), #p) || $set_in(#p, $array_range(old($s), $ptr(^^u4, P#B), ^^u4, P#N)) || $ts_eq(old($s), $s, #p)) && $timestamp_post(old($s), $s);
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$1^30.3, $s);
        assume $local_value_is($s, #tok$1^30.3, #loc.i, L#i, ^^u4);
        assume $local_value_is($s, #tok$1^30.3, #loc.inverse, $map_t..^^u4.^^u4_to_int(SP#inverse), $map_t(^^u4, ^^u4));
        assume $local_value_is($s, #tok$1^30.3, #loc.N, P#N, ^^u4);
        assume $local_value_is($s, #tok$1^30.3, #loc.B, $ptr_to_int($ptr(^^u4, P#B)), $ptr_to(^^u4)) && $local_value_is_ptr($s, #tok$1^30.3, #loc.B, $ptr(^^u4, P#B), $ptr_to(^^u4));
        assume $local_value_is($s, #tok$1^30.3, #loc.A, $ptr_to_int($ptr(^^u4, P#A)), $ptr_to(^^u4)) && $local_value_is_ptr($s, #tok$1^30.3, #loc.A, $ptr(^^u4, P#A), $ptr_to(^^u4));
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#0, $s);
        assume true;
        // if (<(i, N)) ...
        if (L#i < P#N)
        {
          anon1:
            // assert @_vcc_typed2(@state, B[*(A[i])]); 
            assert $typed2($s, $idx($ptr(^^u4, P#B), $mem($s, $idx($ptr(^^u4, P#A), L#i, ^^u4)), ^^u4), ^^u4);
            // assert @prim_writes_check(B[*(A[i])]); 
            assert $writable($s, #wrTime$1^16.1, $idx($ptr(^^u4, P#B), $mem($s, $idx($ptr(^^u4, P#A), L#i, ^^u4)), ^^u4));
            // assert @reads_check_normal(A[i]); 
            assert $typed2($s, $idx($ptr(^^u4, P#A), L#i, ^^u4), ^^u4);
            assert $thread_local2($s, $idx($ptr(^^u4, P#A), L#i, ^^u4), ^^u4);
            // *B[*(A[i])] := i; 
            call $write_int($idx($ptr(^^u4, P#B), $mem($s, $idx($ptr(^^u4, P#A), L#i, ^^u4)), ^^u4), L#i);
            assume $full_stop_ext(#tok$1^33.5, $s);
        }
        else
        {
          anon2:
            // goto #break_1; 
            goto #break_1;
        }

      #continue_1:
        // assert @in_range_u4(+(i, 1)); 
        assert $in_range_u4(L#i + 1);
        // i := +(i, 1); 
        L#i := L#i + 1;
        assume $local_value_is($s, #tok$1^30.22, #loc.i, L#i, ^^u4);
        assume true;
    }

  anon5:
    assume $full_stop_ext(#tok$1^30.3, $s);

  #break_1:
    // assert forall(uint32_t j; { *(B[j]) } @in_range_u4(j); ==>(<(j, N), ==(*(B[j]), *(B[*(A[@map_get(inverse, j)])])))); 
    assert (forall Q#j$1^36.26#tc1: int :: { $mem($s, $idx($ptr(^^u4, P#B), Q#j$1^36.26#tc1, ^^u4)) } $in_range_u4(Q#j$1^36.26#tc1) ==> Q#j$1^36.26#tc1 < P#N ==> $mem($s, $idx($ptr(^^u4, P#B), Q#j$1^36.26#tc1, ^^u4)) == $mem($s, $idx($ptr(^^u4, P#B), $mem($s, $idx($ptr(^^u4, P#A), $select.$map_t..^^u4.^^u4(SP#inverse, Q#j$1^36.26#tc1), ^^u4)), ^^u4)));
    // assume forall(uint32_t j; { *(B[j]) } @in_range_u4(j); ==>(<(j, N), ==(*(B[j]), *(B[*(A[@map_get(inverse, j)])])))); 
    assume (forall Q#j$1^36.26#tc1: int :: { $mem($s, $idx($ptr(^^u4, P#B), Q#j$1^36.26#tc1, ^^u4)) } $in_range_u4(Q#j$1^36.26#tc1) ==> Q#j$1^36.26#tc1 < P#N ==> $mem($s, $idx($ptr(^^u4, P#B), Q#j$1^36.26#tc1, ^^u4)) == $mem($s, $idx($ptr(^^u4, P#B), $mem($s, $idx($ptr(^^u4, P#A), $select.$map_t..^^u4.^^u4(SP#inverse, Q#j$1^36.26#tc1), ^^u4)), ^^u4)));
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



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

const unique #tok$1^30.22: $token;

const unique #tok$1^33.5: $token;

const unique #tok$1^30.3: $token;

const unique #tok$1^30.8: $token;

const unique #loc.i: $token;

const unique #tok$1^28.3: $token;

function $map_t..^^u4.^^u4_to_int(x: $map_t..^^u4.^^u4) : int;

function $int_to_map_t..^^u4.^^u4(x: int) : $map_t..^^u4.^^u4;

axiom (forall #x: $map_t..^^u4.^^u4 :: #x == $int_to_map_t..^^u4.^^u4($map_t..^^u4.^^u4_to_int(#x)));

const unique #loc.inverse: $token;

const unique #loc.N: $token;

const unique #loc.B: $token;

const unique #distTp2: $ctype;

axiom #distTp2 == $ptr_to(^^u4);

const unique #loc.A: $token;

const unique #tok$1^16.1: $token;

axiom $type_code_is(1, ^^u4);

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvscomp2010?5Cvscomp2010_p2_v1.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvscomp2010?5Cvscomp2010_p2_v1.c);

const unique #distTp1: $ctype;

axiom #distTp1 == $map_t(^^u4, ^^u4);
