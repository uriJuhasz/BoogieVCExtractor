axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

procedure invert(P#A: $ptr, P#B: $ptr, P#N: int, SP#inverse: $map_t..^^u4.^^u4);
  requires (forall Q#_j$1^17.29#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#A, ^^u4), Q#_j$1^17.29#tc1) } $in_range_u4(Q#_j$1^17.29#tc1) ==> Q#_j$1^17.29#tc1 < P#N ==> $rd_inv($s, $field($idx($phys_ptr_cast(P#A, ^^u4), Q#_j$1^17.29#tc1)), $emb0($idx($phys_ptr_cast(P#A, ^^u4), Q#_j$1^17.29#tc1))) < P#N);
  requires (forall Q#_j1$1^18.29#tc1: int, Q#_j2$1^18.29#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#A, ^^u4), Q#_j1$1^18.29#tc1), $idx($phys_ptr_cast(P#A, ^^u4), Q#_j2$1^18.29#tc1) } $in_range_u4(Q#_j1$1^18.29#tc1) && $in_range_u4(Q#_j2$1^18.29#tc1) ==> Q#_j1$1^18.29#tc1 < P#N && Q#_j2$1^18.29#tc1 < P#N && $rd_inv($s, $field($idx($phys_ptr_cast(P#A, ^^u4), Q#_j1$1^18.29#tc1)), $emb0($idx($phys_ptr_cast(P#A, ^^u4), Q#_j1$1^18.29#tc1))) == $rd_inv($s, $field($idx($phys_ptr_cast(P#A, ^^u4), Q#_j2$1^18.29#tc1)), $emb0($idx($phys_ptr_cast(P#A, ^^u4), Q#_j2$1^18.29#tc1))) ==> Q#_j1$1^18.29#tc1 == Q#_j2$1^18.29#tc1);
  requires (forall Q#_j$1^19.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^u4(SP#inverse, Q#_j$1^19.29#tc1) } $in_range_u4(Q#_j$1^19.29#tc1) ==> Q#_j$1^19.29#tc1 < P#N ==> $select.$map_t..^^u4.^^u4(SP#inverse, Q#_j$1^19.29#tc1) < P#N);
  requires (forall Q#_j$1^20.29#tc1: int :: {:weight 10} { $select.$map_t..^^u4.^^u4(SP#inverse, Q#_j$1^20.29#tc1) } $in_range_u4(Q#_j$1^20.29#tc1) ==> Q#_j$1^20.29#tc1 < P#N ==> $rd_inv($s, $field($idx($phys_ptr_cast(P#A, ^^u4), $select.$map_t..^^u4.^^u4(SP#inverse, Q#_j$1^20.29#tc1))), $emb0($idx($phys_ptr_cast(P#A, ^^u4), $select.$map_t..^^u4.^^u4(SP#inverse, Q#_j$1^20.29#tc1)))) == Q#_j$1^20.29#tc1);
  requires $wrapped($s, $as_array($phys_ptr_cast(P#A, ^^u4), ^^u4, P#N), $array(^^u4, P#N));
  requires $mutable($s, $as_array($phys_ptr_cast(P#B, ^^u4), ^^u4, P#N));
  modifies $s, $cev_pc;
  ensures (forall Q#_j$1^24.28#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#B, ^^u4), Q#_j$1^24.28#tc1) } $in_range_u4(Q#_j$1^24.28#tc1) ==> Q#_j$1^24.28#tc1 < P#N ==> $rd_inv($s, $field($idx($phys_ptr_cast(P#B, ^^u4), Q#_j$1^24.28#tc1)), $emb0($idx($phys_ptr_cast(P#B, ^^u4), Q#_j$1^24.28#tc1))) < P#N);
  ensures (forall Q#_j1$1^25.28#tc1: int, Q#_j2$1^25.28#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#B, ^^u4), Q#_j1$1^25.28#tc1), $idx($phys_ptr_cast(P#B, ^^u4), Q#_j2$1^25.28#tc1) } $in_range_u4(Q#_j1$1^25.28#tc1) && $in_range_u4(Q#_j2$1^25.28#tc1) ==> Q#_j1$1^25.28#tc1 < P#N && Q#_j2$1^25.28#tc1 < P#N && $rd_inv($s, $field($idx($phys_ptr_cast(P#B, ^^u4), Q#_j1$1^25.28#tc1)), $emb0($idx($phys_ptr_cast(P#B, ^^u4), Q#_j1$1^25.28#tc1))) == $rd_inv($s, $field($idx($phys_ptr_cast(P#B, ^^u4), Q#_j2$1^25.28#tc1)), $emb0($idx($phys_ptr_cast(P#B, ^^u4), Q#_j2$1^25.28#tc1))) ==> Q#_j1$1^25.28#tc1 == Q#_j2$1^25.28#tc1);
  ensures (forall Q#_j$1^26.28#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#A, ^^u4), Q#_j$1^26.28#tc1) } $in_range_u4(Q#_j$1^26.28#tc1) ==> Q#_j$1^26.28#tc1 < P#N ==> $rd_inv($s, $field($idx($phys_ptr_cast(P#B, ^^u4), $rd_inv($s, $field($idx($phys_ptr_cast(P#A, ^^u4), Q#_j$1^26.28#tc1)), $emb0($idx($phys_ptr_cast(P#A, ^^u4), Q#_j$1^26.28#tc1))))), $emb0($idx($phys_ptr_cast(P#B, ^^u4), $rd_inv($s, $field($idx($phys_ptr_cast(P#A, ^^u4), Q#_j$1^26.28#tc1)), $emb0($idx($phys_ptr_cast(P#A, ^^u4), Q#_j$1^26.28#tc1)))))) == Q#_j$1^26.28#tc1);
  ensures $wrapped($s, $as_array($phys_ptr_cast(P#A, ^^u4), ^^u4, P#N), $array(^^u4, P#N));
  ensures $mutable($s, $as_array($phys_ptr_cast(P#B, ^^u4), ^^u4, P#N));
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: $set_in(#p, $array_range(old($s), $phys_ptr_cast(P#B, ^^u4), ^^u4, P#N))));
  free ensures $call_transition(old($s), $s);



implementation invert(P#A: $ptr, P#B: $ptr, P#N: int, SP#inverse: $map_t..^^u4.^^u4)
{
  var #wrTime$1^30.3: int;
  var loopState#0: $state;
  var L#i: int where $in_range_u4(L#i);
  var #wrTime$1^16.1: int;
  var #stackframe: int;

  anon4:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^16.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^16.1, #loc.A, $ptr_to_int(P#A), $ptr_to(^^u4));
    assume $local_value_is($s, #tok$1^16.1, #loc.B, $ptr_to_int(P#B), $ptr_to(^^u4));
    assume $local_value_is($s, #tok$1^16.1, #loc.N, P#N, ^^u4);
    assume $local_value_is($s, #tok$1^16.1, #loc.inverse, $map_t..^^u4.^^u4_to_int(SP#inverse), $map_t(^^u4, ^^u4));
    assume #wrTime$1^16.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^16.1, (lambda #p: $ptr :: $set_in(#p, $array_range($s, $phys_ptr_cast(P#B, ^^u4), ^^u4, P#N))));
    assume $initially_mutable_array($s, $phys_ptr_cast(P#B, ^^u4), ^^u4, P#N);
    // assume true; 
    assume true;
    // assume true; 
    assume true;
    // assume @in_range_u4(N); 
    assume $in_range_u4(P#N);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, @_vcc_as_array(A, N), @_vcc_as_array(A, N)); 
    assert $in_domain_lab($s, $as_array($phys_ptr_cast(P#A, ^^u4), ^^u4, P#N), $as_array($phys_ptr_cast(P#A, ^^u4), ^^u4, P#N), l#public);
    // uint32_t i; 
    assume $local_value_is($s, #tok$1^28.3, #loc.i, L#i, ^^u4);
    // var uint32_t i
    // i := 0; 
    L#i := 0;
    assume $local_value_is($s, #tok$1^30.8, #loc.i, L#i, ^^u4);
    call $bump_timestamp();
    assume $full_stop_ext(#tok$1^30.3, $s);
    loopState#0 := $s;
    assume #wrTime$1^30.3 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^30.3, (lambda #p: $ptr :: $set_in(#p, $array_range($s, $phys_ptr_cast(P#B, ^^u4), ^^u4, P#N))));
    assert (forall #loopWrites^$1^30.3: $ptr :: { $dont_instantiate(#loopWrites^$1^30.3) } $listed_in_writes($s, #wrTime$1^30.3, #loopWrites^$1^30.3) ==> $top_writable($s, #wrTime$1^16.1, #loopWrites^$1^30.3));
    while (true)
      invariant (forall Q#j$1^31.31#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#A, ^^u4), Q#j$1^31.31#tc1) } $in_range_u4(Q#j$1^31.31#tc1) ==> Q#j$1^31.31#tc1 < L#i ==> $rd_inv($s, $field($idx($phys_ptr_cast(P#B, ^^u4), $rd_inv($s, $field($idx($phys_ptr_cast(P#A, ^^u4), Q#j$1^31.31#tc1)), $emb0($idx($phys_ptr_cast(P#A, ^^u4), Q#j$1^31.31#tc1))))), $emb0($idx($phys_ptr_cast(P#B, ^^u4), $rd_inv($s, $field($idx($phys_ptr_cast(P#A, ^^u4), Q#j$1^31.31#tc1)), $emb0($idx($phys_ptr_cast(P#A, ^^u4), Q#j$1^31.31#tc1)))))) == Q#j$1^31.31#tc1);
    {
      anon3:
        assume $modifies(loopState#0, $s, (lambda #p: $ptr :: $set_in(#p, $array_range(loopState#0, $phys_ptr_cast(P#B, ^^u4), ^^u4, P#N))));
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$1^30.3, $s);
        assume $local_value_is($s, #tok$1^30.3, #loc.i, L#i, ^^u4);
        assume $local_value_is($s, #tok$1^30.3, #loc.inverse, $map_t..^^u4.^^u4_to_int(SP#inverse), $map_t(^^u4, ^^u4));
        assume $local_value_is($s, #tok$1^30.3, #loc.N, P#N, ^^u4);
        assume $local_value_is($s, #tok$1^30.3, #loc.B, $ptr_to_int(P#B), $ptr_to(^^u4));
        assume $local_value_is($s, #tok$1^30.3, #loc.A, $ptr_to_int(P#A), $ptr_to(^^u4));
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#0, $s);
        assume true;
        // if (<(i, N)) ...
        if (L#i < P#N)
        {
          anon1:
            // assert @prim_writes_check(B[*(A[i])]); 
            assert $writable_prim($s, #wrTime$1^30.3, $idx($phys_ptr_cast(P#B, ^^u4), $rd_inv($s, $field($idx($phys_ptr_cast(P#A, ^^u4), L#i)), $emb0($idx($phys_ptr_cast(P#A, ^^u4), L#i)))));
            // assert @reads_check_normal(A[i]); 
            assert $thread_local($s, $idx($phys_ptr_cast(P#A, ^^u4), L#i));
            // *B[*(A[i])] := i; 
            call $write_int($field($idx($phys_ptr_cast(P#B, ^^u4), $rd_inv($s, $field($idx($phys_ptr_cast(P#A, ^^u4), L#i)), $emb0($idx($phys_ptr_cast(P#A, ^^u4), L#i))))), $emb0($idx($phys_ptr_cast(P#B, ^^u4), $rd_inv($s, $field($idx($phys_ptr_cast(P#A, ^^u4), L#i)), $emb0($idx($phys_ptr_cast(P#A, ^^u4), L#i))))), L#i);
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
    assert (forall Q#j$1^36.26#tc1: int :: {:weight 10} { $rd_inv($s, $field($idx($phys_ptr_cast(P#B, ^^u4), Q#j$1^36.26#tc1)), $emb0($idx($phys_ptr_cast(P#B, ^^u4), Q#j$1^36.26#tc1))) } $in_range_u4(Q#j$1^36.26#tc1) ==> Q#j$1^36.26#tc1 < P#N ==> $rd_inv($s, $field($idx($phys_ptr_cast(P#B, ^^u4), Q#j$1^36.26#tc1)), $emb0($idx($phys_ptr_cast(P#B, ^^u4), Q#j$1^36.26#tc1))) == $rd_inv($s, $field($idx($phys_ptr_cast(P#B, ^^u4), $rd_inv($s, $field($idx($phys_ptr_cast(P#A, ^^u4), $select.$map_t..^^u4.^^u4(SP#inverse, Q#j$1^36.26#tc1))), $emb0($idx($phys_ptr_cast(P#A, ^^u4), $select.$map_t..^^u4.^^u4(SP#inverse, Q#j$1^36.26#tc1)))))), $emb0($idx($phys_ptr_cast(P#B, ^^u4), $rd_inv($s, $field($idx($phys_ptr_cast(P#A, ^^u4), $select.$map_t..^^u4.^^u4(SP#inverse, Q#j$1^36.26#tc1))), $emb0($idx($phys_ptr_cast(P#A, ^^u4), $select.$map_t..^^u4.^^u4(SP#inverse, Q#j$1^36.26#tc1))))))));
    // assume forall(uint32_t j; { *(B[j]) } @in_range_u4(j); ==>(<(j, N), ==(*(B[j]), *(B[*(A[@map_get(inverse, j)])])))); 
    assume (forall Q#j$1^36.26#tc1: int :: {:weight 10} { $rd_inv($s, $field($idx($phys_ptr_cast(P#B, ^^u4), Q#j$1^36.26#tc1)), $emb0($idx($phys_ptr_cast(P#B, ^^u4), Q#j$1^36.26#tc1))) } $in_range_u4(Q#j$1^36.26#tc1) ==> Q#j$1^36.26#tc1 < P#N ==> $rd_inv($s, $field($idx($phys_ptr_cast(P#B, ^^u4), Q#j$1^36.26#tc1)), $emb0($idx($phys_ptr_cast(P#B, ^^u4), Q#j$1^36.26#tc1))) == $rd_inv($s, $field($idx($phys_ptr_cast(P#B, ^^u4), $rd_inv($s, $field($idx($phys_ptr_cast(P#A, ^^u4), $select.$map_t..^^u4.^^u4(SP#inverse, Q#j$1^36.26#tc1))), $emb0($idx($phys_ptr_cast(P#A, ^^u4), $select.$map_t..^^u4.^^u4(SP#inverse, Q#j$1^36.26#tc1)))))), $emb0($idx($phys_ptr_cast(P#B, ^^u4), $rd_inv($s, $field($idx($phys_ptr_cast(P#A, ^^u4), $select.$map_t..^^u4.^^u4(SP#inverse, Q#j$1^36.26#tc1))), $emb0($idx($phys_ptr_cast(P#A, ^^u4), $select.$map_t..^^u4.^^u4(SP#inverse, Q#j$1^36.26#tc1))))))));
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

axiom (forall M: $map_t..^^u4.^^u4, p: int, v: int :: true);

axiom (forall M: $map_t..^^u4.^^u4, p: int, v: int, q: int :: $select.$map_t..^^u4.^^u4($store.$map_t..^^u4.^^u4(M, q, v), p) == (if $unchecked(^^u4, p) == $unchecked(^^u4, q) then $unchecked(^^u4, v) else $select.$map_t..^^u4.^^u4(M, p)));

axiom (forall M1: $map_t..^^u4.^^u4, M2: $map_t..^^u4.^^u4 :: { $eq.$map_t..^^u4.^^u4(M1, M2) } (forall p: int :: $unchecked(^^u4, $select.$map_t..^^u4.^^u4(M1, $unchecked(^^u4, p))) == $unchecked(^^u4, $select.$map_t..^^u4.^^u4(M2, $unchecked(^^u4, p)))) ==> $eq.$map_t..^^u4.^^u4(M1, M2));

axiom (forall M1: $map_t..^^u4.^^u4, M2: $map_t..^^u4.^^u4 :: { $eq.$map_t..^^u4.^^u4(M1, M2) } $eq.$map_t..^^u4.^^u4(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^u4.^^u4(0) == $zero.$map_t..^^u4.^^u4;

axiom (forall p: int :: $select.$map_t..^^u4.^^u4($zero.$map_t..^^u4.^^u4, p) == 0);

axiom true;

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
