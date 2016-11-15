axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

function F#match_map(SP#board: $map_t..^^i4.^^i4) : bool;

const unique cf#match_map: $pure_function;

axiom (forall SP#board: $map_t..^^i4.^^i4 :: { F#match_map(SP#board) } F#match_map(SP#board) == true);

axiom $function_arg_type(cf#match_map, 0, ^^bool);

axiom $function_arg_type(cf#match_map, 1, $map_t(^^i4, ^^i4));

procedure match_map(SP#board: $map_t..^^i4.^^i4) returns ($result: bool);
  ensures $result == true;
  free ensures $result == F#match_map(SP#board);
  free ensures $call_transition(old($s), $s);



procedure IsConsistent(P#board: $ptr, P#pos: int, P#length: int) returns ($result: bool);
  requires 0 <= P#pos;
  requires $is_thread_local_array($s, $phys_ptr_cast(P#board, ^^i4), ^^i4, P#pos + 1);
  requires (forall Q#_j$1^33.29#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^33.29#tc1) } $in_range_i4(Q#_j$1^33.29#tc1) ==> 0 <= Q#_j$1^33.29#tc1 && Q#_j$1^33.29#tc1 < P#pos + 1 ==> 0 <= $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^33.29#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^33.29#tc1))) && $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^33.29#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^33.29#tc1))) < P#length);
  modifies $s, $cev_pc;
  ensures $result == (forall Q#_i$1^34.28#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#board, ^^i4), Q#_i$1^34.28#tc1) } $in_range_i4(Q#_i$1^34.28#tc1) ==> 0 <= Q#_i$1^34.28#tc1 && Q#_i$1^34.28#tc1 < P#pos ==> !($rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#_i$1^34.28#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#_i$1^34.28#tc1))) == $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), P#pos)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), P#pos))) || $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#_i$1^34.28#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#_i$1^34.28#tc1))) - $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), P#pos)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), P#pos))) == P#pos - Q#_i$1^34.28#tc1 || $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), P#pos)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), P#pos))) - $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#_i$1^34.28#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#_i$1^34.28#tc1))) == P#pos - Q#_i$1^34.28#tc1));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation IsConsistent(P#board: $ptr, P#pos: int, P#length: int) returns ($result: bool)
{
  var ite#2: bool;
  var ite#1: bool;
  var loopState#0: $state;
  var L#q: int where $in_range_i4(L#q);
  var #wrTime$1^30.1: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^30.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^30.1, #loc.board, $ptr_to_int(P#board), $ptr_to(^^i4));
    assume $local_value_is($s, #tok$1^30.1, #loc.pos, P#pos, ^^i4);
    assume $local_value_is($s, #tok$1^30.1, #loc.length, P#length, ^^i4);
    assume #wrTime$1^30.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^30.1, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @in_range_i4(pos); 
    assume $in_range_i4(P#pos);
    // assume @in_range_i4(length); 
    assume $in_range_i4(P#length);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // int32_t q; 
    assume $local_value_is($s, #tok$1^36.3, #loc.q, L#q, ^^i4);
    // var int32_t q
    // q := 0; 
    L#q := 0;
    assume $local_value_is($s, #tok$1^37.8, #loc.q, L#q, ^^i4);
    loopState#0 := $s;
    while (true)
      invariant (forall Q#k$1^38.31#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#board, ^^i4), Q#k$1^38.31#tc1) } $in_range_i4(Q#k$1^38.31#tc1) ==> 0 <= Q#k$1^38.31#tc1 && Q#k$1^38.31#tc1 < L#q ==> !($rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#k$1^38.31#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#k$1^38.31#tc1))) == $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), P#pos)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), P#pos))) || $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#k$1^38.31#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#k$1^38.31#tc1))) - $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), P#pos)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), P#pos))) == P#pos - Q#k$1^38.31#tc1 || $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), P#pos)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), P#pos))) - $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#k$1^38.31#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#k$1^38.31#tc1))) == P#pos - Q#k$1^38.31#tc1));
    {
      anon11:
        assume $writes_nothing(old($s), $s);
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$1^37.3, $s);
        assume $local_value_is($s, #tok$1^37.3, #loc.q, L#q, ^^i4);
        assume $local_value_is($s, #tok$1^37.3, #loc.length, P#length, ^^i4);
        assume $local_value_is($s, #tok$1^37.3, #loc.pos, P#pos, ^^i4);
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#0, $s);
        assume true;
        // if (<(q, pos)) ...
        if (L#q < P#pos)
        {
          anon7:
            // _Bool ite#1; 
            assume $local_value_is($s, #tok$1^39.10, #loc.ite#1, $bool_to_int(ite#1), ^^bool);
            // _Bool ite#2; 
            assume $local_value_is($s, #tok$1^39.10, #loc.ite#2, $bool_to_int(ite#2), ^^bool);
            // assert @reads_check_normal(board[q]); 
            assert $thread_local($s, $idx($phys_ptr_cast(P#board, ^^i4), L#q));
            // assert @reads_check_normal(board[pos]); 
            assert $thread_local($s, $idx($phys_ptr_cast(P#board, ^^i4), P#pos));
            assume true;
            // if (==(*(board[q]), *(board[pos]))) ...
            if ($rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), L#q)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), L#q))) == $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), P#pos)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), P#pos))))
            {
              anon1:
                // ite#2 := true; 
                ite#2 := true;
                assume $local_value_is($s, #tok$1^39.10, #loc.ite#2, $bool_to_int(ite#2), ^^bool);
            }
            else
            {
              anon2:
                // assert @in_range_i4(-(*(board[q]), *(board[pos]))); 
                assert $in_range_i4($rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), L#q)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), L#q))) - $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), P#pos)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), P#pos))));
                // assert @reads_check_normal(board[q]); 
                assert $thread_local($s, $idx($phys_ptr_cast(P#board, ^^i4), L#q));
                // assert @reads_check_normal(board[pos]); 
                assert $thread_local($s, $idx($phys_ptr_cast(P#board, ^^i4), P#pos));
                // assert @in_range_i4(-(pos, q)); 
                assert $in_range_i4(P#pos - L#q);
                // ite#2 := ==(-(*(board[q]), *(board[pos])), -(pos, q)); 
                ite#2 := $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), L#q)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), L#q))) - $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), P#pos)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), P#pos))) == P#pos - L#q;
                assume $local_value_is($s, #tok$1^39.10, #loc.ite#2, $bool_to_int(ite#2), ^^bool);
            }

          anon8:
            assume true;
            // if (ite#2) ...
            if (ite#2)
            {
              anon3:
                // ite#1 := true; 
                ite#1 := true;
                assume $local_value_is($s, #tok$1^39.10, #loc.ite#1, $bool_to_int(ite#1), ^^bool);
            }
            else
            {
              anon4:
                // assert @in_range_i4(-(*(board[pos]), *(board[q]))); 
                assert $in_range_i4($rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), P#pos)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), P#pos))) - $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), L#q)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), L#q))));
                // assert @reads_check_normal(board[pos]); 
                assert $thread_local($s, $idx($phys_ptr_cast(P#board, ^^i4), P#pos));
                // assert @reads_check_normal(board[q]); 
                assert $thread_local($s, $idx($phys_ptr_cast(P#board, ^^i4), L#q));
                // assert @in_range_i4(-(pos, q)); 
                assert $in_range_i4(P#pos - L#q);
                // ite#1 := ==(-(*(board[pos]), *(board[q])), -(pos, q)); 
                ite#1 := $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), P#pos)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), P#pos))) - $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), L#q)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), L#q))) == P#pos - L#q;
                assume $local_value_is($s, #tok$1^39.10, #loc.ite#1, $bool_to_int(ite#1), ^^bool);
            }

          anon9:
            assume true;
            // if (ite#1) ...
            if (ite#1)
            {
              anon5:
                // return false; 
                $result := false;
                assert $position_marker();
                goto #exit;
            }
            else
            {
              anon6:
                // empty
            }
        }
        else
        {
          anon10:
            // goto #break_5; 
            goto #break_5;
        }

      #continue_5:
        // assert @in_range_i4(+(q, 1)); 
        assert $in_range_i4(L#q + 1);
        // q := +(q, 1); 
        L#q := L#q + 1;
        assume $local_value_is($s, #tok$1^37.24, #loc.q, L#q, ^^i4);
        assume true;
    }

  anon13:
    assume $full_stop_ext(#tok$1^37.3, $s);

  #break_5:
    // return true; 
    $result := true;
    assert $position_marker();
    goto #exit;

  anon14:
    // empty

  #exit:
}



procedure Search(P#board: $ptr, P#pos: int, P#length: int) returns ($result: bool);
  requires 0 < P#length;
  requires 0 <= P#pos;
  requires P#pos < P#length;
  requires (forall Q#_j$1^47.29#tc1: int :: {:weight 10} $in_range_i4(Q#_j$1^47.29#tc1) ==> 0 <= Q#_j$1^47.29#tc1 && Q#_j$1^47.29#tc1 < P#pos ==> (forall Q#_i$1^47.72#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#board, ^^i4), Q#_i$1^47.72#tc1) } $in_range_i4(Q#_i$1^47.72#tc1) ==> 0 <= Q#_i$1^47.72#tc1 && Q#_i$1^47.72#tc1 < Q#_j$1^47.29#tc1 ==> !($rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#_i$1^47.72#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#_i$1^47.72#tc1))) == $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^47.29#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^47.29#tc1))) || $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#_i$1^47.72#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#_i$1^47.72#tc1))) - $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^47.29#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^47.29#tc1))) == Q#_j$1^47.29#tc1 - Q#_i$1^47.72#tc1 || $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^47.29#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^47.29#tc1))) - $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#_i$1^47.72#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#_i$1^47.72#tc1))) == Q#_j$1^47.29#tc1 - Q#_i$1^47.72#tc1)));
  requires (forall Q#_j$1^49.29#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^49.29#tc1) } $in_range_i4(Q#_j$1^49.29#tc1) ==> 0 <= Q#_j$1^49.29#tc1 && Q#_j$1^49.29#tc1 < P#pos ==> 0 <= $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^49.29#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^49.29#tc1))) && $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^49.29#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^49.29#tc1))) < P#length);
  requires $is_mutable_array($s, $phys_ptr_cast(P#board, ^^i4), ^^i4, P#length);
  modifies $s, $cev_pc;
  ensures (forall Q#k$1^50.27#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#board, ^^i4), Q#k$1^50.27#tc1) } $in_range_i4(Q#k$1^50.27#tc1) ==> 0 <= Q#k$1^50.27#tc1 && Q#k$1^50.27#tc1 < P#pos ==> $rd_inv(old($s), $field($idx($phys_ptr_cast(P#board, ^^i4), Q#k$1^50.27#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#k$1^50.27#tc1))) == $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#k$1^50.27#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#k$1^50.27#tc1))));
  ensures (if $result then (forall Q#_j$1^52.8#tc1: int :: {:weight 10} $in_range_i4(Q#_j$1^52.8#tc1) ==> 0 <= Q#_j$1^52.8#tc1 && Q#_j$1^52.8#tc1 < P#length ==> (forall Q#_i$1^52.54#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#board, ^^i4), Q#_i$1^52.54#tc1) } $in_range_i4(Q#_i$1^52.54#tc1) ==> 0 <= Q#_i$1^52.54#tc1 && Q#_i$1^52.54#tc1 < Q#_j$1^52.8#tc1 ==> !($rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#_i$1^52.54#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#_i$1^52.54#tc1))) == $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^52.8#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^52.8#tc1))) || $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#_i$1^52.54#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#_i$1^52.54#tc1))) - $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^52.8#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^52.8#tc1))) == Q#_j$1^52.8#tc1 - Q#_i$1^52.54#tc1 || $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^52.8#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^52.8#tc1))) - $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#_i$1^52.54#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#_i$1^52.54#tc1))) == Q#_j$1^52.8#tc1 - Q#_i$1^52.54#tc1))) else (forall Q#b$1^53.7#dt1: $map_t..^^i4.^^i4 :: {:weight 10} { F#match_map(Q#b$1^53.7#dt1) } { sk_hack(F#match_map(Q#b$1^53.7#dt1)) } (forall Q#_j$1^54.8#tc1: int :: {:weight 10} { $select.$map_t..^^i4.^^i4(Q#b$1^53.7#dt1, Q#_j$1^54.8#tc1) } $in_range_i4(Q#_j$1^54.8#tc1) ==> 0 <= Q#_j$1^54.8#tc1 && Q#_j$1^54.8#tc1 < P#length ==> 0 <= $select.$map_t..^^i4.^^i4(Q#b$1^53.7#dt1, Q#_j$1^54.8#tc1) && $select.$map_t..^^i4.^^i4(Q#b$1^53.7#dt1, Q#_j$1^54.8#tc1) < P#length) && (forall Q#_j$1^54.93#tc1: int :: {:weight 10} { $select.$map_t..^^i4.^^i4(Q#b$1^53.7#dt1, Q#_j$1^54.93#tc1) } $in_range_i4(Q#_j$1^54.93#tc1) ==> 0 <= Q#_j$1^54.93#tc1 && Q#_j$1^54.93#tc1 < P#pos ==> $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^54.93#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^54.93#tc1))) == $select.$map_t..^^i4.^^i4(Q#b$1^53.7#dt1, Q#_j$1^54.93#tc1)) ==> !(forall Q#_j$1^55.11#tc1: int :: {:weight 10} $in_range_i4(Q#_j$1^55.11#tc1) ==> 0 <= Q#_j$1^55.11#tc1 && Q#_j$1^55.11#tc1 < P#length ==> (forall Q#_i$1^55.57#tc1: int :: {:weight 10} { $select.$map_t..^^i4.^^i4(Q#b$1^53.7#dt1, Q#_i$1^55.57#tc1) } $in_range_i4(Q#_i$1^55.57#tc1) ==> 0 <= Q#_i$1^55.57#tc1 && Q#_i$1^55.57#tc1 < Q#_j$1^55.11#tc1 ==> !($select.$map_t..^^i4.^^i4(Q#b$1^53.7#dt1, Q#_i$1^55.57#tc1) == $select.$map_t..^^i4.^^i4(Q#b$1^53.7#dt1, Q#_j$1^55.11#tc1) || $select.$map_t..^^i4.^^i4(Q#b$1^53.7#dt1, Q#_i$1^55.57#tc1) - $select.$map_t..^^i4.^^i4(Q#b$1^53.7#dt1, Q#_j$1^55.11#tc1) == Q#_j$1^55.11#tc1 - Q#_i$1^55.57#tc1 || $select.$map_t..^^i4.^^i4(Q#b$1^53.7#dt1, Q#_j$1^55.11#tc1) - $select.$map_t..^^i4.^^i4(Q#b$1^53.7#dt1, Q#_i$1^55.57#tc1) == Q#_j$1^55.11#tc1 - Q#_i$1^55.57#tc1)))));
  ensures $is_mutable_array($s, $phys_ptr_cast(P#board, ^^i4), ^^i4, P#length);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: $set_in(#p, $array_range(old($s), $phys_ptr_cast(P#board, ^^i4), ^^i4, P#length))));
  free ensures $call_transition(old($s), $s);



implementation Search(P#board: $ptr, P#pos: int, P#length: int) returns ($result: bool)
{
  var ite#4: bool;
  var res_IsConsistent#7: bool;
  var ite#3: bool;
  var #wrTime$1^60.3: int;
  var loopState#1: $state;
  var L#i: int where $in_range_i4(L#i);
  var #wrTime$1^44.1: int;
  var #stackframe: int;

  anon26:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^44.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^44.1, #loc.board, $ptr_to_int(P#board), $ptr_to(^^i4));
    assume $local_value_is($s, #tok$1^44.1, #loc.pos, P#pos, ^^i4);
    assume $local_value_is($s, #tok$1^44.1, #loc.length, P#length, ^^i4);
    assume #wrTime$1^44.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^44.1, (lambda #p: $ptr :: $set_in(#p, $array_range($s, $phys_ptr_cast(P#board, ^^i4), ^^i4, P#length))));
    assume $initially_mutable_array($s, $phys_ptr_cast(P#board, ^^i4), ^^i4, P#length);
    // assume true; 
    assume true;
    // assume @in_range_i4(pos); 
    assume $in_range_i4(P#pos);
    // assume @in_range_i4(length); 
    assume $in_range_i4(P#length);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // int32_t i; 
    assume $local_value_is($s, #tok$1^58.3, #loc.i, L#i, ^^i4);
    // var int32_t i
    // i := 0; 
    L#i := 0;
    assume $local_value_is($s, #tok$1^60.8, #loc.i, L#i, ^^i4);
    call $bump_timestamp();
    assume $full_stop_ext(#tok$1^60.3, $s);
    loopState#1 := $s;
    assume #wrTime$1^60.3 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^60.3, (lambda #p: $ptr :: $set_in(#p, $array_range($s, $phys_ptr_cast(P#board, ^^i4), ^^i4, P#length))));
    assert (forall #loopWrites^$1^60.3: $ptr :: { $dont_instantiate(#loopWrites^$1^60.3) } $listed_in_writes($s, #wrTime$1^60.3, #loopWrites^$1^60.3) ==> $top_writable($s, #wrTime$1^44.1, #loopWrites^$1^60.3));
    while (true)
      invariant $is_mutable_array($s, $phys_ptr_cast(P#board, ^^i4), ^^i4, P#length);
      invariant (forall Q#k$1^62.31#tc1: int :: {:weight 10} { $idx($phys_ptr_cast(P#board, ^^i4), Q#k$1^62.31#tc1) } $in_range_i4(Q#k$1^62.31#tc1) ==> 0 <= Q#k$1^62.31#tc1 && Q#k$1^62.31#tc1 < P#pos ==> $rd_inv(loopState#1, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#k$1^62.31#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#k$1^62.31#tc1))) == $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#k$1^62.31#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#k$1^62.31#tc1))));
      invariant (forall Q#b$1^63.31#dt1: $map_t..^^i4.^^i4 :: {:weight 10} { F#match_map(Q#b$1^63.31#dt1) } { sk_hack(F#match_map(Q#b$1^63.31#dt1)) } (forall Q#_j$1^64.8#tc1: int :: {:weight 10} { $select.$map_t..^^i4.^^i4(Q#b$1^63.31#dt1, Q#_j$1^64.8#tc1) } $in_range_i4(Q#_j$1^64.8#tc1) ==> 0 <= Q#_j$1^64.8#tc1 && Q#_j$1^64.8#tc1 < P#length ==> 0 <= $select.$map_t..^^i4.^^i4(Q#b$1^63.31#dt1, Q#_j$1^64.8#tc1) && $select.$map_t..^^i4.^^i4(Q#b$1^63.31#dt1, Q#_j$1^64.8#tc1) < P#length) && (forall Q#_j$1^64.93#tc1: int :: {:weight 10} { $select.$map_t..^^i4.^^i4(Q#b$1^63.31#dt1, Q#_j$1^64.93#tc1) } $in_range_i4(Q#_j$1^64.93#tc1) ==> 0 <= Q#_j$1^64.93#tc1 && Q#_j$1^64.93#tc1 < P#pos ==> $rd_inv($s, $field($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^64.93#tc1)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), Q#_j$1^64.93#tc1))) == $select.$map_t..^^i4.^^i4(Q#b$1^63.31#dt1, Q#_j$1^64.93#tc1)) && $select.$map_t..^^i4.^^i4(Q#b$1^63.31#dt1, P#pos) < L#i ==> !(forall Q#_j$1^66.11#tc1: int :: {:weight 10} $in_range_i4(Q#_j$1^66.11#tc1) ==> 0 <= Q#_j$1^66.11#tc1 && Q#_j$1^66.11#tc1 < P#length ==> (forall Q#_i$1^66.57#tc1: int :: {:weight 10} { $select.$map_t..^^i4.^^i4(Q#b$1^63.31#dt1, Q#_i$1^66.57#tc1) } $in_range_i4(Q#_i$1^66.57#tc1) ==> 0 <= Q#_i$1^66.57#tc1 && Q#_i$1^66.57#tc1 < Q#_j$1^66.11#tc1 ==> !($select.$map_t..^^i4.^^i4(Q#b$1^63.31#dt1, Q#_i$1^66.57#tc1) == $select.$map_t..^^i4.^^i4(Q#b$1^63.31#dt1, Q#_j$1^66.11#tc1) || $select.$map_t..^^i4.^^i4(Q#b$1^63.31#dt1, Q#_i$1^66.57#tc1) - $select.$map_t..^^i4.^^i4(Q#b$1^63.31#dt1, Q#_j$1^66.11#tc1) == Q#_j$1^66.11#tc1 - Q#_i$1^66.57#tc1 || $select.$map_t..^^i4.^^i4(Q#b$1^63.31#dt1, Q#_j$1^66.11#tc1) - $select.$map_t..^^i4.^^i4(Q#b$1^63.31#dt1, Q#_i$1^66.57#tc1) == Q#_j$1^66.11#tc1 - Q#_i$1^66.57#tc1))));
    {
      anon25:
        assume $modifies(loopState#1, $s, (lambda #p: $ptr :: $set_in(#p, $array_range(loopState#1, $phys_ptr_cast(P#board, ^^i4), ^^i4, P#length))));
        assume $timestamp_post(loopState#1, $s);
        assume $full_stop_ext(#tok$1^60.3, $s);
        assume $local_value_is($s, #tok$1^60.3, #loc.i, L#i, ^^i4);
        assume true;
        // if (<(i, length)) ...
        if (L#i < P#length)
        {
          anon22:
            // assert @prim_writes_check(board[pos]); 
            assert $writable_prim($s, #wrTime$1^60.3, $idx($phys_ptr_cast(P#board, ^^i4), P#pos));
            // *board[pos] := i; 
            call $write_int($field($idx($phys_ptr_cast(P#board, ^^i4), P#pos)), $emb0($idx($phys_ptr_cast(P#board, ^^i4), P#pos)), L#i);
            assume $full_stop_ext(#tok$1^68.5, $s);
            // _Bool ite#3; 
            assume $local_value_is($s, #tok$1^70.9, #loc.ite#3, $bool_to_int(ite#3), ^^bool);
            // _Bool res_IsConsistent#7; 
            assume $local_value_is($s, #tok$1^70.9, #loc.res_IsConsistent#7, $bool_to_int(res_IsConsistent#7), ^^bool);
            // res_IsConsistent#7 := IsConsistent(board, pos, length); 
            call res_IsConsistent#7 := IsConsistent($phys_ptr_cast(P#board, ^^i4), P#pos, P#length);
            assume $full_stop_ext(#tok$1^70.9, $s);
            assume $local_value_is($s, #tok$1^70.9, #loc.res_IsConsistent#7, $bool_to_int(res_IsConsistent#7), ^^bool);
            assume true;
            // if (res_IsConsistent#7) ...
            if (res_IsConsistent#7)
            {
              anon17:
                // _Bool ite#4; 
                assume $local_value_is($s, #tok$1^71.8, #loc.ite#4, $bool_to_int(ite#4), ^^bool);
                // assert @in_range_i4(-(length, 1)); 
                assert $in_range_i4(P#length - 1);
                assume true;
                // if (==(pos, -(length, 1))) ...
                if (P#pos == P#length - 1)
                {
                  anon15:
                    // ite#4 := true; 
                    ite#4 := true;
                    assume $local_value_is($s, #tok$1^71.8, #loc.ite#4, $bool_to_int(ite#4), ^^bool);
                }
                else
                {
                  anon16:
                    // non-pure function
                    // assert @writes_check(@_vcc_array_range(@state, board, (uint64_t)(uint32_t)length)); 
                    assert (forall #writes$1^71.29: $ptr :: { $dont_instantiate(#writes$1^71.29) } $set_in(#writes$1^71.29, $array_range($s, $phys_ptr_cast(P#board, ^^i4), ^^i4, P#length)) ==> $top_writable($s, #wrTime$1^60.3, #writes$1^71.29));
                    // assert @in_range_i4(+(pos, 1)); 
                    assert $in_range_i4(P#pos + 1);
                    // ite#4 := Search(board, +(pos, 1), length); 
                    call ite#4 := Search($phys_ptr_cast(P#board, ^^i4), P#pos + 1, P#length);
                    assume $full_stop_ext(#tok$1^71.29, $s);
                    assume $local_value_is($s, #tok$1^71.29, #loc.ite#4, $bool_to_int(ite#4), ^^bool);
                }

              anon18:
                // ite#3 := ite#4; 
                ite#3 := ite#4;
                assume $local_value_is($s, #tok$1^70.9, #loc.ite#3, $bool_to_int(ite#3), ^^bool);
            }
            else
            {
              anon19:
                // ite#3 := false; 
                ite#3 := false;
                assume $local_value_is($s, #tok$1^70.9, #loc.ite#3, $bool_to_int(ite#3), ^^bool);
            }

          anon23:
            assume true;
            // if (ite#3) ...
            if (ite#3)
            {
              anon20:
                // return true; 
                $result := true;
                assert $position_marker();
                goto #exit;
            }
            else
            {
              anon21:
                // empty
            }
        }
        else
        {
          anon24:
            // goto #break_6; 
            goto #break_6;
        }

      #continue_6:
        // assert @in_range_i4(+(i, 1)); 
        assert $in_range_i4(L#i + 1);
        // i := +(i, 1); 
        L#i := L#i + 1;
        assume $local_value_is($s, #tok$1^60.27, #loc.i, L#i, ^^i4);
        assume true;
    }

  anon27:
    assume $full_stop_ext(#tok$1^60.3, $s);

  #break_6:
    // return false; 
    $result := false;
    assert $position_marker();
    goto #exit;

  anon28:
    // empty

  #exit:
}



type $map_t..^^i4.^^i4;

function $select.$map_t..^^i4.^^i4(M: $map_t..^^i4.^^i4, p: int) : int;

function $store.$map_t..^^i4.^^i4(M: $map_t..^^i4.^^i4, p: int, v: int) : $map_t..^^i4.^^i4;

function $eq.$map_t..^^i4.^^i4(M1: $map_t..^^i4.^^i4, M2: $map_t..^^i4.^^i4) : bool;

const $zero.$map_t..^^i4.^^i4: $map_t..^^i4.^^i4;

axiom (forall M: $map_t..^^i4.^^i4, p: int, v: int :: true);

axiom (forall M: $map_t..^^i4.^^i4, p: int, v: int, q: int :: $select.$map_t..^^i4.^^i4($store.$map_t..^^i4.^^i4(M, q, v), p) == (if $unchecked(^^i4, p) == $unchecked(^^i4, q) then $unchecked(^^i4, v) else $select.$map_t..^^i4.^^i4(M, p)));

axiom (forall M1: $map_t..^^i4.^^i4, M2: $map_t..^^i4.^^i4 :: { $eq.$map_t..^^i4.^^i4(M1, M2) } (forall p: int :: $unchecked(^^i4, $select.$map_t..^^i4.^^i4(M1, $unchecked(^^i4, p))) == $unchecked(^^i4, $select.$map_t..^^i4.^^i4(M2, $unchecked(^^i4, p)))) ==> $eq.$map_t..^^i4.^^i4(M1, M2));

axiom (forall M1: $map_t..^^i4.^^i4, M2: $map_t..^^i4.^^i4 :: { $eq.$map_t..^^i4.^^i4(M1, M2) } $eq.$map_t..^^i4.^^i4(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^i4.^^i4(0) == $zero.$map_t..^^i4.^^i4;

axiom (forall p: int :: $select.$map_t..^^i4.^^i4($zero.$map_t..^^i4.^^i4, p) == 0);

axiom true;

axiom (forall M: $map_t..^^i4.^^i4, p: int :: $in_range_t(^^i4, $select.$map_t..^^i4.^^i4(M, p)));

const unique #tok$1^60.27: $token;

const unique #tok$1^71.29: $token;

const unique #loc.ite#4: $token;

const unique #tok$1^71.8: $token;

const unique #loc.res_IsConsistent#7: $token;

const unique #loc.ite#3: $token;

const unique #tok$1^70.9: $token;

const unique #tok$1^68.5: $token;

const unique #tok$1^60.3: $token;

const unique #tok$1^60.8: $token;

const unique #loc.i: $token;

const unique #tok$1^58.3: $token;

const unique #tok$1^44.1: $token;

const unique #tok$1^37.24: $token;

const unique #loc.ite#2: $token;

const unique #loc.ite#1: $token;

const unique #tok$1^39.10: $token;

const unique #tok$1^37.3: $token;

const unique #tok$1^37.8: $token;

const unique #loc.q: $token;

const unique #tok$1^36.3: $token;

const unique #loc.length: $token;

const unique #loc.pos: $token;

const unique #distTp2: $ctype;

axiom #distTp2 == $ptr_to(^^i4);

const unique #tok$1^30.1: $token;

axiom $type_code_is(1, ^^i4);

function $map_t..^^i4.^^i4_to_int(x: $map_t..^^i4.^^i4) : int;

function $int_to_map_t..^^i4.^^i4(x: int) : $map_t..^^i4.^^i4;

axiom (forall #x: $map_t..^^i4.^^i4 :: #x == $int_to_map_t..^^i4.^^i4($map_t..^^i4.^^i4_to_int(#x)));

const unique #loc.board: $token;

const unique #tok$1^11.39: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvscomp2010?5Cvscomp2010_p4_v1.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvscomp2010?5Cvscomp2010_p4_v1.c);

const unique #distTp1: $ctype;

axiom #distTp1 == $map_t(^^i4, ^^i4);
