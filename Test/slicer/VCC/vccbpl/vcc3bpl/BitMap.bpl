axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

const unique ^_toto: $ctype;

axiom $is_span_sequential(^_toto);

axiom $def_struct_type(^_toto, 8, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^_toto) } $inv2(#s1, #s2, #p, ^_toto) == $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^_toto)) } $in(q, $composite_extent(s, p, ^_toto)) == (q == p));

const unique _toto.inti: $field;

axiom $def_phys_field(^_toto, _toto.inti, ^^u8, false, 0);

function F#ToBm64(SP#n: int) : $map_t..^^u8.^^bool;

const unique cf#ToBm64: $pure_function;

axiom $function_arg_type(cf#ToBm64, 0, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#ToBm64, 1, ^^u8);

procedure ToBm64(SP#n: int) returns ($result: $map_t..^^u8.^^bool);
  free ensures $result == F#ToBm64(SP#n);
  free ensures $call_transition(old($s), $s);



function F#ToBm32(SP#n: int) : $map_t..^^u8.^^bool;

const unique cf#ToBm32: $pure_function;

axiom $function_arg_type(cf#ToBm32, 0, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#ToBm32, 1, ^^u4);

procedure ToBm32(SP#n: int) returns ($result: $map_t..^^u8.^^bool);
  free ensures $result == F#ToBm32(SP#n);
  free ensures $call_transition(old($s), $s);



function F#Bm64Singleton(SP#i: int) : $map_t..^^u8.^^bool;

const unique cf#Bm64Singleton: $pure_function;

axiom (forall SP#i: int :: { F#Bm64Singleton(SP#i) } $eq.$map_t..^^u8.^^bool(F#Bm64Singleton(SP#i), F#lambda#1(SP#i)));

axiom $function_arg_type(cf#Bm64Singleton, 0, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#Bm64Singleton, 1, ^^u8);

procedure Bm64Singleton(SP#i: int) returns ($result: $map_t..^^u8.^^bool);
  ensures $eq.$map_t..^^u8.^^bool($result, F#lambda#1(SP#i));
  free ensures $result == F#Bm64Singleton(SP#i);
  free ensures $call_transition(old($s), $s);



function F#Bm32Singleton(SP#i: int) : $map_t..^^u8.^^bool;

const unique cf#Bm32Singleton: $pure_function;

axiom (forall SP#i: int :: { F#Bm32Singleton(SP#i) } $eq.$map_t..^^u8.^^bool(F#Bm32Singleton(SP#i), F#lambda#2(SP#i)));

axiom $function_arg_type(cf#Bm32Singleton, 0, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#Bm32Singleton, 1, ^^u8);

procedure Bm32Singleton(SP#i: int) returns ($result: $map_t..^^u8.^^bool);
  ensures $eq.$map_t..^^u8.^^bool($result, F#lambda#2(SP#i));
  free ensures $result == F#Bm32Singleton(SP#i);
  free ensures $call_transition(old($s), $s);



function F#Bm64Union(SP#bm1: $map_t..^^u8.^^bool, SP#bm2: $map_t..^^u8.^^bool) : $map_t..^^u8.^^bool;

const unique cf#Bm64Union: $pure_function;

axiom (forall SP#bm1: $map_t..^^u8.^^bool, SP#bm2: $map_t..^^u8.^^bool :: { F#Bm64Union(SP#bm1, SP#bm2) } $eq.$map_t..^^u8.^^bool(F#Bm64Union(SP#bm1, SP#bm2), F#lambda#3(SP#bm2, SP#bm1)));

axiom $function_arg_type(cf#Bm64Union, 0, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#Bm64Union, 1, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#Bm64Union, 2, $map_t(^^u8, ^^bool));

procedure Bm64Union(SP#bm1: $map_t..^^u8.^^bool, SP#bm2: $map_t..^^u8.^^bool) returns ($result: $map_t..^^u8.^^bool);
  ensures $eq.$map_t..^^u8.^^bool($result, F#lambda#3(SP#bm2, SP#bm1));
  free ensures $result == F#Bm64Union(SP#bm1, SP#bm2);
  free ensures $call_transition(old($s), $s);



function F#Bm32Union(SP#bm1: $map_t..^^u8.^^bool, SP#bm2: $map_t..^^u8.^^bool) : $map_t..^^u8.^^bool;

const unique cf#Bm32Union: $pure_function;

axiom (forall SP#bm1: $map_t..^^u8.^^bool, SP#bm2: $map_t..^^u8.^^bool :: { F#Bm32Union(SP#bm1, SP#bm2) } $eq.$map_t..^^u8.^^bool(F#Bm32Union(SP#bm1, SP#bm2), F#lambda#4(SP#bm2, SP#bm1)));

axiom $function_arg_type(cf#Bm32Union, 0, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#Bm32Union, 1, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#Bm32Union, 2, $map_t(^^u8, ^^bool));

procedure Bm32Union(SP#bm1: $map_t..^^u8.^^bool, SP#bm2: $map_t..^^u8.^^bool) returns ($result: $map_t..^^u8.^^bool);
  ensures $eq.$map_t..^^u8.^^bool($result, F#lambda#4(SP#bm2, SP#bm1));
  free ensures $result == F#Bm32Union(SP#bm1, SP#bm2);
  free ensures $call_transition(old($s), $s);



function F#Bm64Intersect(SP#bm1: $map_t..^^u8.^^bool, SP#bm2: $map_t..^^u8.^^bool) : $map_t..^^u8.^^bool;

const unique cf#Bm64Intersect: $pure_function;

axiom (forall SP#bm1: $map_t..^^u8.^^bool, SP#bm2: $map_t..^^u8.^^bool :: { F#Bm64Intersect(SP#bm1, SP#bm2) } $eq.$map_t..^^u8.^^bool(F#Bm64Intersect(SP#bm1, SP#bm2), F#lambda#5(SP#bm2, SP#bm1)));

axiom $function_arg_type(cf#Bm64Intersect, 0, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#Bm64Intersect, 1, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#Bm64Intersect, 2, $map_t(^^u8, ^^bool));

procedure Bm64Intersect(SP#bm1: $map_t..^^u8.^^bool, SP#bm2: $map_t..^^u8.^^bool) returns ($result: $map_t..^^u8.^^bool);
  ensures $eq.$map_t..^^u8.^^bool($result, F#lambda#5(SP#bm2, SP#bm1));
  free ensures $result == F#Bm64Intersect(SP#bm1, SP#bm2);
  free ensures $call_transition(old($s), $s);



function F#Bm32Intersect(SP#bm1: $map_t..^^u8.^^bool, SP#bm2: $map_t..^^u8.^^bool) : $map_t..^^u8.^^bool;

const unique cf#Bm32Intersect: $pure_function;

axiom (forall SP#bm1: $map_t..^^u8.^^bool, SP#bm2: $map_t..^^u8.^^bool :: { F#Bm32Intersect(SP#bm1, SP#bm2) } $eq.$map_t..^^u8.^^bool(F#Bm32Intersect(SP#bm1, SP#bm2), F#lambda#6(SP#bm2, SP#bm1)));

axiom $function_arg_type(cf#Bm32Intersect, 0, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#Bm32Intersect, 1, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#Bm32Intersect, 2, $map_t(^^u8, ^^bool));

procedure Bm32Intersect(SP#bm1: $map_t..^^u8.^^bool, SP#bm2: $map_t..^^u8.^^bool) returns ($result: $map_t..^^u8.^^bool);
  ensures $eq.$map_t..^^u8.^^bool($result, F#lambda#6(SP#bm2, SP#bm1));
  free ensures $result == F#Bm32Intersect(SP#bm1, SP#bm2);
  free ensures $call_transition(old($s), $s);



function F#Bm64SymmetricDiff(SP#bm1: $map_t..^^u8.^^bool, SP#bm2: $map_t..^^u8.^^bool) : $map_t..^^u8.^^bool;

const unique cf#Bm64SymmetricDiff: $pure_function;

axiom (forall SP#bm1: $map_t..^^u8.^^bool, SP#bm2: $map_t..^^u8.^^bool :: { F#Bm64SymmetricDiff(SP#bm1, SP#bm2) } $eq.$map_t..^^u8.^^bool(F#Bm64SymmetricDiff(SP#bm1, SP#bm2), F#lambda#7(SP#bm2, SP#bm1)));

axiom $function_arg_type(cf#Bm64SymmetricDiff, 0, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#Bm64SymmetricDiff, 1, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#Bm64SymmetricDiff, 2, $map_t(^^u8, ^^bool));

procedure Bm64SymmetricDiff(SP#bm1: $map_t..^^u8.^^bool, SP#bm2: $map_t..^^u8.^^bool) returns ($result: $map_t..^^u8.^^bool);
  ensures $eq.$map_t..^^u8.^^bool($result, F#lambda#7(SP#bm2, SP#bm1));
  free ensures $result == F#Bm64SymmetricDiff(SP#bm1, SP#bm2);
  free ensures $call_transition(old($s), $s);



function F#Bm32SymmetricDiff(SP#bm1: $map_t..^^u8.^^bool, SP#bm2: $map_t..^^u8.^^bool) : $map_t..^^u8.^^bool;

const unique cf#Bm32SymmetricDiff: $pure_function;

axiom (forall SP#bm1: $map_t..^^u8.^^bool, SP#bm2: $map_t..^^u8.^^bool :: { F#Bm32SymmetricDiff(SP#bm1, SP#bm2) } $eq.$map_t..^^u8.^^bool(F#Bm32SymmetricDiff(SP#bm1, SP#bm2), F#lambda#8(SP#bm2, SP#bm1)));

axiom $function_arg_type(cf#Bm32SymmetricDiff, 0, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#Bm32SymmetricDiff, 1, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#Bm32SymmetricDiff, 2, $map_t(^^u8, ^^bool));

procedure Bm32SymmetricDiff(SP#bm1: $map_t..^^u8.^^bool, SP#bm2: $map_t..^^u8.^^bool) returns ($result: $map_t..^^u8.^^bool);
  ensures $eq.$map_t..^^u8.^^bool($result, F#lambda#8(SP#bm2, SP#bm1));
  free ensures $result == F#Bm32SymmetricDiff(SP#bm1, SP#bm2);
  free ensures $call_transition(old($s), $s);



function F#Bm64SpecialValue(SP#bm: int) : bool;

const unique cf#Bm64SpecialValue: $pure_function;

axiom (forall SP#bm: int :: { F#Bm64SpecialValue(SP#bm) } F#Bm64SpecialValue(SP#bm) == true);

axiom $function_arg_type(cf#Bm64SpecialValue, 0, ^^bool);

axiom $function_arg_type(cf#Bm64SpecialValue, 1, ^^u8);

procedure Bm64SpecialValue(SP#bm: int) returns ($result: bool);
  ensures $result == true;
  free ensures $result == F#Bm64SpecialValue(SP#bm);
  free ensures $call_transition(old($s), $s);



function F#Bm32SpecialValue(SP#bm: int) : bool;

const unique cf#Bm32SpecialValue: $pure_function;

axiom (forall SP#bm: int :: { F#Bm32SpecialValue(SP#bm) } F#Bm32SpecialValue(SP#bm) == true);

axiom $function_arg_type(cf#Bm32SpecialValue, 0, ^^bool);

axiom $function_arg_type(cf#Bm32SpecialValue, 1, ^^u4);

procedure Bm32SpecialValue(SP#bm: int) returns ($result: bool);
  ensures $result == true;
  free ensures $result == F#Bm32SpecialValue(SP#bm);
  free ensures $call_transition(old($s), $s);



procedure Add64(P#x: int, P#n: int) returns ($result: int);
  requires P#n < 64;
  modifies $s, $cev_pc;
  free ensures $in_range_u8($result);
  ensures $select.$map_t..^^u8.^^bool(F#ToBm64($result), P#n);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Add64(P#x: int, P#n: int) returns ($result: int)
{
  var #wrTime$1^85.1: int;
  var #stackframe: int;

  anon1:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^85.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^85.1, #loc.x, P#x, ^^u8);
    assume $local_value_is($s, #tok$1^85.1, #loc.n, P#n, ^^u8);
    assume #wrTime$1^85.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^85.1, (lambda #p: $ptr :: false));
    // assume @in_range_u8(x); 
    assume $in_range_u8(P#x);
    // assume @in_range_u8(n); 
    assume $in_range_u8(P#n);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert &&(<=(0, n), <(n, 64)); 
    assert 0 <= P#n && P#n < 64;
    // return unchecked|(x, unchecked<<(1, n)); 
    $result := $_or(^^u8, P#x, $_shl(^^u8, 1, P#n));
    assert $position_marker();
    goto #exit;

  anon2:
    // empty

  #exit:
}



procedure InSet64(P#x: int, P#n: int) returns ($result: bool);
  requires P#n < 64;
  modifies $s, $cev_pc;
  ensures $result == $select.$map_t..^^u8.^^bool(F#ToBm64(P#x), P#n);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation InSet64(P#x: int, P#n: int) returns ($result: bool)
{
  var #wrTime$1^92.1: int;
  var #stackframe: int;

  anon3:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^92.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^92.1, #loc.x, P#x, ^^u8);
    assume $local_value_is($s, #tok$1^92.1, #loc.n, P#n, ^^u8);
    assume #wrTime$1^92.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^92.1, (lambda #p: $ptr :: false));
    // assume @in_range_u8(x); 
    assume $in_range_u8(P#x);
    // assume @in_range_u8(n); 
    assume $in_range_u8(P#n);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert &&(<=(0, n), <(n, 64)); 
    assert 0 <= P#n && P#n < 64;
    // return !=(unchecked&(x, unchecked<<(1, n)), 0); 
    $result := $_and(^^u8, P#x, $_shl(^^u8, 1, P#n)) != 0;
    assert $position_marker();
    goto #exit;

  anon4:
    // empty

  #exit:
}



procedure Toggle64(P#x: int, P#n: int) returns ($result: int);
  requires P#n < 64;
  modifies $s, $cev_pc;
  free ensures $in_range_u8($result);
  ensures !($select.$map_t..^^u8.^^bool(F#ToBm64($result), P#n) == $select.$map_t..^^u8.^^bool(F#ToBm64(P#x), P#n));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Toggle64(P#x: int, P#n: int) returns ($result: int)
{
  var #wrTime$1^99.1: int;
  var #stackframe: int;

  anon5:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^99.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^99.1, #loc.x, P#x, ^^u8);
    assume $local_value_is($s, #tok$1^99.1, #loc.n, P#n, ^^u8);
    assume #wrTime$1^99.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^99.1, (lambda #p: $ptr :: false));
    // assume @in_range_u8(x); 
    assume $in_range_u8(P#x);
    // assume @in_range_u8(n); 
    assume $in_range_u8(P#n);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert &&(<=(0, n), <(n, 64)); 
    assert 0 <= P#n && P#n < 64;
    // return unchecked^(x, unchecked<<(1, n)); 
    $result := $_xor(^^u8, P#x, $_shl(^^u8, 1, P#n));
    assert $position_marker();
    goto #exit;

  anon6:
    // empty

  #exit:
}



procedure Add32(P#x: int, P#n: int) returns ($result: int);
  requires P#n < 32;
  modifies $s, $cev_pc;
  free ensures $in_range_u4($result);
  ensures $select.$map_t..^^u8.^^bool(F#ToBm32($result), P#n);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Add32(P#x: int, P#n: int) returns ($result: int)
{
  var #wrTime$1^106.1: int;
  var #stackframe: int;

  anon7:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^106.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^106.1, #loc.x, P#x, ^^u4);
    assume $local_value_is($s, #tok$1^106.1, #loc.n, P#n, ^^u8);
    assume #wrTime$1^106.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^106.1, (lambda #p: $ptr :: false));
    // assume @in_range_u4(x); 
    assume $in_range_u4(P#x);
    // assume @in_range_u8(n); 
    assume $in_range_u8(P#n);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert &&(<=(0, n), <(n, 32)); 
    assert 0 <= P#n && P#n < 32;
    // return unchecked|(x, unchecked<<(1, n)); 
    $result := $_or(^^u4, P#x, $_shl(^^u4, 1, P#n));
    assert $position_marker();
    goto #exit;

  anon8:
    // empty

  #exit:
}



procedure InSet32(P#x: int, P#n: int) returns ($result: bool);
  requires P#n < 32;
  modifies $s, $cev_pc;
  ensures $result == $select.$map_t..^^u8.^^bool(F#ToBm32(P#x), P#n);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation InSet32(P#x: int, P#n: int) returns ($result: bool)
{
  var #wrTime$1^113.1: int;
  var #stackframe: int;

  anon9:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^113.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^113.1, #loc.x, P#x, ^^u4);
    assume $local_value_is($s, #tok$1^113.1, #loc.n, P#n, ^^u8);
    assume #wrTime$1^113.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^113.1, (lambda #p: $ptr :: false));
    // assume @in_range_u4(x); 
    assume $in_range_u4(P#x);
    // assume @in_range_u8(n); 
    assume $in_range_u8(P#n);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert &&(<=(0, n), <(n, 32)); 
    assert 0 <= P#n && P#n < 32;
    // return !=(unchecked&(x, unchecked<<(1, n)), 0); 
    $result := $_and(^^u4, P#x, $_shl(^^u4, 1, P#n)) != 0;
    assert $position_marker();
    goto #exit;

  anon10:
    // empty

  #exit:
}



procedure Toggle32(P#x: int, P#n: int) returns ($result: int);
  requires P#n < 32;
  modifies $s, $cev_pc;
  free ensures $in_range_u4($result);
  ensures !($select.$map_t..^^u8.^^bool(F#ToBm32($result), P#n) == $select.$map_t..^^u8.^^bool(F#ToBm32(P#x), P#n));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Toggle32(P#x: int, P#n: int) returns ($result: int)
{
  var #wrTime$1^120.1: int;
  var #stackframe: int;

  anon11:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^120.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^120.1, #loc.x, P#x, ^^u4);
    assume $local_value_is($s, #tok$1^120.1, #loc.n, P#n, ^^u8);
    assume #wrTime$1^120.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^120.1, (lambda #p: $ptr :: false));
    // assume @in_range_u4(x); 
    assume $in_range_u4(P#x);
    // assume @in_range_u8(n); 
    assume $in_range_u8(P#n);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert &&(<=(0, n), <(n, 32)); 
    assert 0 <= P#n && P#n < 32;
    // return unchecked^(x, unchecked<<(1, n)); 
    $result := $_xor(^^u4, P#x, $_shl(^^u4, 1, P#n));
    assert $position_marker();
    goto #exit;

  anon12:
    // empty

  #exit:
}



procedure SpecialValues64();
  modifies $s, $cev_pc;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation SpecialValues64()
{
  var L#zero: int where $in_range_u8(L#zero);
  var L#all: int where $in_range_u8(L#all);
  var #wrTime$1^127.1: int;
  var #stackframe: int;

  anon13:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^127.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^127.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^127.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // uint64_t all; 
    assume $local_value_is($s, #tok$1^128.3, #loc.all, L#all, ^^u8);
    // uint64_t zero; 
    assume $local_value_is($s, #tok$1^128.3, #loc.zero, L#zero, ^^u8);
    // var uint64_t zero
    // var uint64_t all
    // assume forall(uint64_t i; @in_range_u8(i); ==>(<(i, 64), @map_get(ToBm64(all), i))); 
    assume (forall Q#i$1^129.26#tc1: int :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#ToBm64(L#all), Q#i$1^129.26#tc1) } $in_range_u8(Q#i$1^129.26#tc1) ==> Q#i$1^129.26#tc1 < 64 ==> $select.$map_t..^^u8.^^bool(F#ToBm64(L#all), Q#i$1^129.26#tc1));
    // assume forall(uint64_t i; @in_range_u8(i); ==>(<(i, 64), unchecked!(@map_get(ToBm64(zero), i)))); 
    assume (forall Q#i$1^130.26#tc1: int :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#ToBm64(L#zero), Q#i$1^130.26#tc1) } $in_range_u8(Q#i$1^130.26#tc1) ==> Q#i$1^130.26#tc1 < 64 ==> !$select.$map_t..^^u8.^^bool(F#ToBm64(L#zero), Q#i$1^130.26#tc1));
    // assert Bm64SpecialValue(all); 
    assert F#Bm64SpecialValue(L#all);
    // assume Bm64SpecialValue(all); 
    assume F#Bm64SpecialValue(L#all);
    // assert ==(all, 18446744073709551615); 
    assert L#all == 18446744073709551615;
    // assume ==(all, 18446744073709551615); 
    assume L#all == 18446744073709551615;
    // assert Bm64SpecialValue(zero); 
    assert F#Bm64SpecialValue(L#zero);
    // assume Bm64SpecialValue(zero); 
    assume F#Bm64SpecialValue(L#zero);
    // assert ==(zero, 0); 
    assert L#zero == 0;
    // assume ==(zero, 0); 
    assume L#zero == 0;
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure SpecialValues32();
  modifies $s, $cev_pc;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation SpecialValues32()
{
  var L#zero: int where $in_range_u4(L#zero);
  var L#all: int where $in_range_u4(L#all);
  var #wrTime$1^137.1: int;
  var #stackframe: int;

  anon14:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^137.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^137.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^137.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // uint32_t all; 
    assume $local_value_is($s, #tok$1^138.3, #loc.all, L#all, ^^u4);
    // uint32_t zero; 
    assume $local_value_is($s, #tok$1^138.3, #loc.zero, L#zero, ^^u4);
    // var uint32_t zero
    // var uint32_t all
    // assume forall(uint64_t i; @in_range_u8(i); ==>(<(i, 32), @map_get(ToBm32(all), i))); 
    assume (forall Q#i$1^139.26#tc1: int :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#ToBm32(L#all), Q#i$1^139.26#tc1) } $in_range_u8(Q#i$1^139.26#tc1) ==> Q#i$1^139.26#tc1 < 32 ==> $select.$map_t..^^u8.^^bool(F#ToBm32(L#all), Q#i$1^139.26#tc1));
    // assume forall(uint64_t i; @in_range_u8(i); ==>(<(i, 32), unchecked!(@map_get(ToBm32(zero), i)))); 
    assume (forall Q#i$1^140.26#tc1: int :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#ToBm32(L#zero), Q#i$1^140.26#tc1) } $in_range_u8(Q#i$1^140.26#tc1) ==> Q#i$1^140.26#tc1 < 32 ==> !$select.$map_t..^^u8.^^bool(F#ToBm32(L#zero), Q#i$1^140.26#tc1));
    // assert Bm32SpecialValue(all); 
    assert F#Bm32SpecialValue(L#all);
    // assume Bm32SpecialValue(all); 
    assume F#Bm32SpecialValue(L#all);
    // assert ==(all, 4294967295); 
    assert L#all == 4294967295;
    // assume ==(all, 4294967295); 
    assume L#all == 4294967295;
    // assert Bm32SpecialValue(zero); 
    assert F#Bm32SpecialValue(L#zero);
    // assume Bm32SpecialValue(zero); 
    assume F#Bm32SpecialValue(L#zero);
    // assert ==(zero, 0); 
    assert L#zero == 0;
    // assume ==(zero, 0); 
    assume L#zero == 0;
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure FortyTwo64();
  modifies $s, $cev_pc;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation FortyTwo64()
{
  var L#one: int where $in_range_u8(L#one);
  var L#ft: int where $in_range_u8(L#ft);
  var #wrTime$1^147.1: int;
  var #stackframe: int;

  anon15:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^147.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^147.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^147.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // uint64_t ft; 
    assume $local_value_is($s, #tok$1^149.3, #loc.ft, L#ft, ^^u8);
    // uint64_t one; 
    assume $local_value_is($s, #tok$1^148.3, #loc.one, L#one, ^^u8);
    // one := 1; 
    L#one := 1;
    assume $local_value_is($s, #tok$1^148.3, #loc.one, L#one, ^^u8);
    // assert &&(<=(0, 5), <(5, 64)); 
    assert 0 <= 5 && 5 < 64;
    // assert &&(<=(0, 3), <(3, 64)); 
    assert 0 <= 3 && 3 < 64;
    // assert &&(<=(0, 1), <(1, 64)); 
    assert 0 <= 1 && 1 < 64;
    // ft := unchecked|(unchecked|(unchecked<<(one, 5), unchecked<<(one, 3)), unchecked<<(one, 1)); 
    L#ft := $_or(^^u8, $_or(^^u8, $_shl(^^u8, L#one, 5), $_shl(^^u8, L#one, 3)), $_shl(^^u8, L#one, 1));
    assume $local_value_is($s, #tok$1^149.3, #loc.ft, L#ft, ^^u8);
    // assert unchecked!(@map_get(ToBm64(ft), 0)); 
    assert !$select.$map_t..^^u8.^^bool(F#ToBm64(L#ft), 0);
    // assume unchecked!(@map_get(ToBm64(ft), 0)); 
    assume !$select.$map_t..^^u8.^^bool(F#ToBm64(L#ft), 0);
    // assert @map_get(ToBm64(ft), 1); 
    assert $select.$map_t..^^u8.^^bool(F#ToBm64(L#ft), 1);
    // assume @map_get(ToBm64(ft), 1); 
    assume $select.$map_t..^^u8.^^bool(F#ToBm64(L#ft), 1);
    // assert unchecked!(@map_get(ToBm64(ft), 2)); 
    assert !$select.$map_t..^^u8.^^bool(F#ToBm64(L#ft), 2);
    // assume unchecked!(@map_get(ToBm64(ft), 2)); 
    assume !$select.$map_t..^^u8.^^bool(F#ToBm64(L#ft), 2);
    // assert @map_get(ToBm64(ft), 3); 
    assert $select.$map_t..^^u8.^^bool(F#ToBm64(L#ft), 3);
    // assume @map_get(ToBm64(ft), 3); 
    assume $select.$map_t..^^u8.^^bool(F#ToBm64(L#ft), 3);
    // assert unchecked!(@map_get(ToBm64(ft), 4)); 
    assert !$select.$map_t..^^u8.^^bool(F#ToBm64(L#ft), 4);
    // assume unchecked!(@map_get(ToBm64(ft), 4)); 
    assume !$select.$map_t..^^u8.^^bool(F#ToBm64(L#ft), 4);
    // assert @map_get(ToBm64(ft), 5); 
    assert $select.$map_t..^^u8.^^bool(F#ToBm64(L#ft), 5);
    // assume @map_get(ToBm64(ft), 5); 
    assume $select.$map_t..^^u8.^^bool(F#ToBm64(L#ft), 5);
    // assert unchecked!(@map_get(ToBm64(ft), 6)); 
    assert !$select.$map_t..^^u8.^^bool(F#ToBm64(L#ft), 6);
    // assume unchecked!(@map_get(ToBm64(ft), 6)); 
    assume !$select.$map_t..^^u8.^^bool(F#ToBm64(L#ft), 6);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure FortyTwo32();
  modifies $s, $cev_pc;
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation FortyTwo32()
{
  var L#one: int where $in_range_u4(L#one);
  var L#ft: int where $in_range_u4(L#ft);
  var #wrTime$1^159.1: int;
  var #stackframe: int;

  anon16:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^159.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$1^159.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^159.1, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // uint32_t ft; 
    assume $local_value_is($s, #tok$1^161.3, #loc.ft, L#ft, ^^u4);
    // uint32_t one; 
    assume $local_value_is($s, #tok$1^160.3, #loc.one, L#one, ^^u4);
    // one := 1; 
    L#one := 1;
    assume $local_value_is($s, #tok$1^160.3, #loc.one, L#one, ^^u4);
    // assert &&(<=(0, 5), <(5, 32)); 
    assert 0 <= 5 && 5 < 32;
    // assert &&(<=(0, 3), <(3, 32)); 
    assert 0 <= 3 && 3 < 32;
    // assert &&(<=(0, 1), <(1, 32)); 
    assert 0 <= 1 && 1 < 32;
    // ft := unchecked|(unchecked|(unchecked<<(one, 5), unchecked<<(one, 3)), unchecked<<(one, 1)); 
    L#ft := $_or(^^u4, $_or(^^u4, $_shl(^^u4, L#one, 5), $_shl(^^u4, L#one, 3)), $_shl(^^u4, L#one, 1));
    assume $local_value_is($s, #tok$1^161.3, #loc.ft, L#ft, ^^u4);
    // assert unchecked!(@map_get(ToBm32(ft), 0)); 
    assert !$select.$map_t..^^u8.^^bool(F#ToBm32(L#ft), 0);
    // assume unchecked!(@map_get(ToBm32(ft), 0)); 
    assume !$select.$map_t..^^u8.^^bool(F#ToBm32(L#ft), 0);
    // assert @map_get(ToBm32(ft), 1); 
    assert $select.$map_t..^^u8.^^bool(F#ToBm32(L#ft), 1);
    // assume @map_get(ToBm32(ft), 1); 
    assume $select.$map_t..^^u8.^^bool(F#ToBm32(L#ft), 1);
    // assert unchecked!(@map_get(ToBm32(ft), 2)); 
    assert !$select.$map_t..^^u8.^^bool(F#ToBm32(L#ft), 2);
    // assume unchecked!(@map_get(ToBm32(ft), 2)); 
    assume !$select.$map_t..^^u8.^^bool(F#ToBm32(L#ft), 2);
    // assert @map_get(ToBm32(ft), 3); 
    assert $select.$map_t..^^u8.^^bool(F#ToBm32(L#ft), 3);
    // assume @map_get(ToBm32(ft), 3); 
    assume $select.$map_t..^^u8.^^bool(F#ToBm32(L#ft), 3);
    // assert unchecked!(@map_get(ToBm32(ft), 4)); 
    assert !$select.$map_t..^^u8.^^bool(F#ToBm32(L#ft), 4);
    // assume unchecked!(@map_get(ToBm32(ft), 4)); 
    assume !$select.$map_t..^^u8.^^bool(F#ToBm32(L#ft), 4);
    // assert @map_get(ToBm32(ft), 5); 
    assert $select.$map_t..^^u8.^^bool(F#ToBm32(L#ft), 5);
    // assume @map_get(ToBm32(ft), 5); 
    assume $select.$map_t..^^u8.^^bool(F#ToBm32(L#ft), 5);
    // assert unchecked!(@map_get(ToBm32(ft), 6)); 
    assert !$select.$map_t..^^u8.^^bool(F#ToBm32(L#ft), 6);
    // assume unchecked!(@map_get(ToBm32(ft), 6)); 
    assume !$select.$map_t..^^u8.^^bool(F#ToBm32(L#ft), 6);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure test(P#ob: $ptr) returns ($result: bool);
  requires $wrapped($s, $phys_ptr_cast(P#ob, ^_toto), ^_toto);
  requires $rd_inv($s, _toto.inti, $phys_ptr_cast(P#ob, ^_toto)) == 0;
  modifies $s, $cev_pc;
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#ob, ^_toto)));
  free ensures $call_transition(old($s), $s);



implementation test(P#ob: $ptr) returns ($result: bool)
{
  var prestate#11: $state;
  var prestate#9: $state;
  var owns#10: $ptrset;
  var #wrTime$1^175.1: int;
  var #stackframe: int;

  anon17:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^175.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^175.1, #loc.ob, $ptr_to_int(P#ob), $ptr_to(^_toto));
    assume #wrTime$1^175.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^175.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#ob, ^_toto)));
    assume $thread_owned($s, $phys_ptr_cast(P#ob, ^_toto));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, ob, ob); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#ob, ^_toto), $phys_ptr_cast(P#ob, ^_toto), l#public);
    // _math ptrset owns#10; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#10, $ptrset_to_int(owns#10), ^$#ptrset);
    // owns#10 := @_vcc_set_empty; 
    owns#10 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#10, $ptrset_to_int(owns#10), ^$#ptrset);
    // _math state_t prestate#9; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#9, $state_to_int(prestate#9), ^$#state_t);
    // prestate#9 := @_vcc_current_state(@state); 
    prestate#9 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#9, $state_to_int(prestate#9), ^$#state_t);
    // _math state_t prestate#11; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#11, $state_to_int(prestate#11), ^$#state_t);
    // prestate#11 := @_vcc_current_state(@state); 
    prestate#11 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#11, $state_to_int(prestate#11), ^$#state_t);
    // assert @_vcc_wrapped(@state, ob); 
    assert $wrapped($s, $phys_ptr_cast(P#ob, ^_toto), ^_toto);
    // assert @writes_check(ob); 
    assert $top_writable($s, #wrTime$1^175.1, $phys_ptr_cast(P#ob, ^_toto));
    // assume @_vcc_inv(@state, ob); 
    assume $inv($s, $phys_ptr_cast(P#ob, ^_toto), ^_toto);
    // assume ==(owns#10, @_vcc_owns(@state, ob)); 
    assume owns#10 == $owns($s, $phys_ptr_cast(P#ob, ^_toto));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(ob), prestate#11)
    call $static_unwrap($phys_ptr_cast(P#ob, ^_toto), prestate#11);
    assume $good_state_ext(#tok$1^181.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert ==(*((ob->inti)), 0); 
    assert $rd_inv($s, _toto.inti, $phys_ptr_cast(P#ob, ^_toto)) == 0;
    // assume ==(*((ob->inti)), 0); 
    assume $rd_inv($s, _toto.inti, $phys_ptr_cast(P#ob, ^_toto)) == 0;
    // assert @prim_writes_check((ob->inti)); 
    assert $writable_prim($s, #wrTime$1^175.1, $dot($phys_ptr_cast(P#ob, ^_toto), _toto.inti));
    // assert @reads_check_normal((ob->inti)); 
    assert $thread_local($s, $phys_ptr_cast(P#ob, ^_toto));
    // *(ob->inti) := unchecked|(*((ob->inti)), 2); 
    call $write_int(_toto.inti, $phys_ptr_cast(P#ob, ^_toto), $_or(^^u8, $rd_inv($s, _toto.inti, $phys_ptr_cast(P#ob, ^_toto)), 2));
    assume $full_stop_ext(#tok$1^183.3, $s);
    // assert @map_get(ToBm64(*((ob->inti))), 1); 
    assert $select.$map_t..^^u8.^^bool(F#ToBm64($rd_inv($s, _toto.inti, $phys_ptr_cast(P#ob, ^_toto))), 1);
    // assume @map_get(ToBm64(*((ob->inti))), 1); 
    assume $select.$map_t..^^u8.^^bool(F#ToBm64($rd_inv($s, _toto.inti, $phys_ptr_cast(P#ob, ^_toto))), 1);
    // assert !=(*((ob->inti)), 0); 
    assert $rd_inv($s, _toto.inti, $phys_ptr_cast(P#ob, ^_toto)) != 0;
    // assume !=(*((ob->inti)), 0); 
    assume $rd_inv($s, _toto.inti, $phys_ptr_cast(P#ob, ^_toto)) != 0;
    // assert ==(*((ob->inti)), 2); 
    assert $rd_inv($s, _toto.inti, $phys_ptr_cast(P#ob, ^_toto)) == 2;
    // assume ==(*((ob->inti)), 2); 
    assume $rd_inv($s, _toto.inti, $phys_ptr_cast(P#ob, ^_toto)) == 2;
    // assert @map_get(ToBm64(*((ob->inti))), 1); 
    assert $select.$map_t..^^u8.^^bool(F#ToBm64($rd_inv($s, _toto.inti, $phys_ptr_cast(P#ob, ^_toto))), 1);
    // assume @map_get(ToBm64(*((ob->inti))), 1); 
    assume $select.$map_t..^^u8.^^bool(F#ToBm64($rd_inv($s, _toto.inti, $phys_ptr_cast(P#ob, ^_toto))), 1);
    // assert forall(uint64_t i; @in_range_u8(i); ==>(&&(<(i, 64), !=(i, 1)), unchecked!(@map_get(ToBm64(*((ob->inti))), i)))); 
    assert (forall Q#i$1^188.26#tc1: int :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#ToBm64($rd_inv($s, _toto.inti, $phys_ptr_cast(P#ob, ^_toto))), Q#i$1^188.26#tc1) } $in_range_u8(Q#i$1^188.26#tc1) ==> Q#i$1^188.26#tc1 < 64 && Q#i$1^188.26#tc1 != 1 ==> !$select.$map_t..^^u8.^^bool(F#ToBm64($rd_inv($s, _toto.inti, $phys_ptr_cast(P#ob, ^_toto))), Q#i$1^188.26#tc1));
    // assume forall(uint64_t i; @in_range_u8(i); ==>(&&(<(i, 64), !=(i, 1)), unchecked!(@map_get(ToBm64(*((ob->inti))), i)))); 
    assume (forall Q#i$1^188.26#tc1: int :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#ToBm64($rd_inv($s, _toto.inti, $phys_ptr_cast(P#ob, ^_toto))), Q#i$1^188.26#tc1) } $in_range_u8(Q#i$1^188.26#tc1) ==> Q#i$1^188.26#tc1 < 64 && Q#i$1^188.26#tc1 != 1 ==> !$select.$map_t..^^u8.^^bool(F#ToBm64($rd_inv($s, _toto.inti, $phys_ptr_cast(P#ob, ^_toto))), Q#i$1^188.26#tc1));
    // return true; 
    $result := true;
    assert $position_marker();
    goto #exit;

  anon18:
    // empty

  #exit:
}



axiom (forall Q#i$1^65.23#tc1: int :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#ToBm64(0), Q#i$1^65.23#tc1) } $in_range_u8(Q#i$1^65.23#tc1) ==> Q#i$1^65.23#tc1 < 64 ==> !$select.$map_t..^^u8.^^bool(F#ToBm64(0), Q#i$1^65.23#tc1));

axiom (forall Q#i$1^66.23#tc1: int :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#ToBm64(18446744073709551615), Q#i$1^66.23#tc1) } $in_range_u8(Q#i$1^66.23#tc1) ==> Q#i$1^66.23#tc1 < 64 ==> $select.$map_t..^^u8.^^bool(F#ToBm64(18446744073709551615), Q#i$1^66.23#tc1));

axiom (forall Q#i$1^67.23#tc1: int :: {:weight 10} { F#ToBm64($_shl(^^u8, 1, Q#i$1^67.23#tc1)) } $in_range_u8(Q#i$1^67.23#tc1) ==> Q#i$1^67.23#tc1 < 64 ==> $eq.$map_t..^^u8.^^bool(F#ToBm64($_shl(^^u8, 1, Q#i$1^67.23#tc1)), F#Bm64Singleton(Q#i$1^67.23#tc1)));

axiom (forall Q#x$1^68.23#tc1: int :: {:weight 10} { F#Bm64SpecialValue(Q#x$1^68.23#tc1) } $in_range_u8(Q#x$1^68.23#tc1) ==> (forall Q#i$1^68.64#tc1: int :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#ToBm64(Q#x$1^68.23#tc1), Q#i$1^68.64#tc1) } $in_range_u8(Q#i$1^68.64#tc1) ==> Q#i$1^68.64#tc1 < 64 ==> !$select.$map_t..^^u8.^^bool(F#ToBm64(Q#x$1^68.23#tc1), Q#i$1^68.64#tc1)) ==> Q#x$1^68.23#tc1 == 0);

axiom (forall Q#x$1^69.23#tc1: int :: {:weight 10} { F#Bm64SpecialValue(Q#x$1^69.23#tc1) } $in_range_u8(Q#x$1^69.23#tc1) ==> (forall Q#i$1^69.64#tc1: int :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#ToBm64(Q#x$1^69.23#tc1), Q#i$1^69.64#tc1) } $in_range_u8(Q#i$1^69.64#tc1) ==> Q#i$1^69.64#tc1 < 64 ==> $select.$map_t..^^u8.^^bool(F#ToBm64(Q#x$1^69.23#tc1), Q#i$1^69.64#tc1)) ==> Q#x$1^69.23#tc1 == 18446744073709551615);

axiom (forall Q#x$1^70.23#tc1: int, Q#y$1^70.23#tc1: int :: {:weight 10} { F#ToBm64($_and(^^u8, Q#x$1^70.23#tc1, Q#y$1^70.23#tc1)) } $in_range_u8(Q#x$1^70.23#tc1) && $in_range_u8(Q#y$1^70.23#tc1) ==> $eq.$map_t..^^u8.^^bool(F#ToBm64($_and(^^u8, Q#x$1^70.23#tc1, Q#y$1^70.23#tc1)), F#Bm64Intersect(F#ToBm64(Q#x$1^70.23#tc1), F#ToBm64(Q#y$1^70.23#tc1))));

axiom (forall Q#x$1^71.23#tc1: int, Q#y$1^71.23#tc1: int :: {:weight 10} { F#ToBm64($_or(^^u8, Q#x$1^71.23#tc1, Q#y$1^71.23#tc1)) } $in_range_u8(Q#x$1^71.23#tc1) && $in_range_u8(Q#y$1^71.23#tc1) ==> $eq.$map_t..^^u8.^^bool(F#ToBm64($_or(^^u8, Q#x$1^71.23#tc1, Q#y$1^71.23#tc1)), F#Bm64Union(F#ToBm64(Q#x$1^71.23#tc1), F#ToBm64(Q#y$1^71.23#tc1))));

axiom (forall Q#x$1^72.23#tc1: int, Q#y$1^72.23#tc1: int :: {:weight 10} { F#ToBm64($_xor(^^u8, Q#x$1^72.23#tc1, Q#y$1^72.23#tc1)) } $in_range_u8(Q#x$1^72.23#tc1) && $in_range_u8(Q#y$1^72.23#tc1) ==> $eq.$map_t..^^u8.^^bool(F#ToBm64($_xor(^^u8, Q#x$1^72.23#tc1, Q#y$1^72.23#tc1)), F#Bm64SymmetricDiff(F#ToBm64(Q#x$1^72.23#tc1), F#ToBm64(Q#y$1^72.23#tc1))));

axiom (forall Q#x$1^73.23#tc1: int, Q#i$1^73.23#tc1: int :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#ToBm64(Q#x$1^73.23#tc1), Q#i$1^73.23#tc1) } $in_range_u8(Q#x$1^73.23#tc1) && $in_range_u8(Q#i$1^73.23#tc1) ==> (Q#i$1^73.23#tc1 < 64 ==> $select.$map_t..^^u8.^^bool(F#ToBm64(Q#x$1^73.23#tc1), Q#i$1^73.23#tc1)) == ($_and(^^u8, Q#x$1^73.23#tc1, $_shl(^^u8, 1, Q#i$1^73.23#tc1)) != 0));

axiom (forall Q#i$1^75.23#tc1: int :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#ToBm32(0), Q#i$1^75.23#tc1) } $in_range_u8(Q#i$1^75.23#tc1) ==> Q#i$1^75.23#tc1 < 32 ==> !$select.$map_t..^^u8.^^bool(F#ToBm32(0), Q#i$1^75.23#tc1));

axiom (forall Q#i$1^76.23#tc1: int :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#ToBm32(4294967295), Q#i$1^76.23#tc1) } $in_range_u8(Q#i$1^76.23#tc1) ==> Q#i$1^76.23#tc1 < 32 ==> $select.$map_t..^^u8.^^bool(F#ToBm32(4294967295), Q#i$1^76.23#tc1));

axiom (forall Q#i$1^77.23#tc1: int :: {:weight 10} { F#ToBm32($_shl(^^u4, 1, Q#i$1^77.23#tc1)) } $in_range_u8(Q#i$1^77.23#tc1) ==> Q#i$1^77.23#tc1 < 32 ==> $eq.$map_t..^^u8.^^bool(F#ToBm32($_shl(^^u4, 1, Q#i$1^77.23#tc1)), F#Bm32Singleton(Q#i$1^77.23#tc1)));

axiom (forall Q#x$1^78.23#tc2: int :: {:weight 10} { F#Bm32SpecialValue(Q#x$1^78.23#tc2) } $in_range_u4(Q#x$1^78.23#tc2) ==> (forall Q#i$1^78.64#tc2: int :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#ToBm32(Q#x$1^78.23#tc2), Q#i$1^78.64#tc2) } $in_range_u4(Q#i$1^78.64#tc2) ==> Q#i$1^78.64#tc2 < 32 ==> !$select.$map_t..^^u8.^^bool(F#ToBm32(Q#x$1^78.23#tc2), Q#i$1^78.64#tc2)) ==> Q#x$1^78.23#tc2 == 0);

axiom (forall Q#x$1^79.23#tc2: int :: {:weight 10} { F#Bm32SpecialValue(Q#x$1^79.23#tc2) } $in_range_u4(Q#x$1^79.23#tc2) ==> (forall Q#i$1^79.64#tc2: int :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#ToBm32(Q#x$1^79.23#tc2), Q#i$1^79.64#tc2) } $in_range_u4(Q#i$1^79.64#tc2) ==> Q#i$1^79.64#tc2 < 32 ==> $select.$map_t..^^u8.^^bool(F#ToBm32(Q#x$1^79.23#tc2), Q#i$1^79.64#tc2)) ==> Q#x$1^79.23#tc2 == 4294967295);

axiom (forall Q#x$1^80.23#tc2: int, Q#y$1^80.23#tc2: int :: {:weight 10} { F#ToBm32($_and(^^u4, Q#x$1^80.23#tc2, Q#y$1^80.23#tc2)) } $in_range_u4(Q#x$1^80.23#tc2) && $in_range_u4(Q#y$1^80.23#tc2) ==> $eq.$map_t..^^u8.^^bool(F#ToBm32($_and(^^u4, Q#x$1^80.23#tc2, Q#y$1^80.23#tc2)), F#Bm32Intersect(F#ToBm32(Q#x$1^80.23#tc2), F#ToBm32(Q#y$1^80.23#tc2))));

axiom (forall Q#x$1^81.23#tc2: int, Q#y$1^81.23#tc2: int :: {:weight 10} { F#ToBm32($_or(^^u4, Q#x$1^81.23#tc2, Q#y$1^81.23#tc2)) } $in_range_u4(Q#x$1^81.23#tc2) && $in_range_u4(Q#y$1^81.23#tc2) ==> $eq.$map_t..^^u8.^^bool(F#ToBm32($_or(^^u4, Q#x$1^81.23#tc2, Q#y$1^81.23#tc2)), F#Bm32Union(F#ToBm32(Q#x$1^81.23#tc2), F#ToBm32(Q#y$1^81.23#tc2))));

axiom (forall Q#x$1^82.23#tc2: int, Q#y$1^82.23#tc2: int :: {:weight 10} { F#ToBm32($_xor(^^u4, Q#x$1^82.23#tc2, Q#y$1^82.23#tc2)) } $in_range_u4(Q#x$1^82.23#tc2) && $in_range_u4(Q#y$1^82.23#tc2) ==> $eq.$map_t..^^u8.^^bool(F#ToBm32($_xor(^^u4, Q#x$1^82.23#tc2, Q#y$1^82.23#tc2)), F#Bm32SymmetricDiff(F#ToBm32(Q#x$1^82.23#tc2), F#ToBm32(Q#y$1^82.23#tc2))));

axiom (forall Q#x$1^83.23#tc2: int, Q#i$1^83.23#tc1: int :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#ToBm32(Q#x$1^83.23#tc2), Q#i$1^83.23#tc1) } $in_range_u4(Q#x$1^83.23#tc2) && $in_range_u8(Q#i$1^83.23#tc1) ==> (Q#i$1^83.23#tc1 < 32 ==> $select.$map_t..^^u8.^^bool(F#ToBm32(Q#x$1^83.23#tc2), Q#i$1^83.23#tc1)) == ($_and(^^u4, Q#x$1^83.23#tc2, $_shl(^^u4, 1, Q#i$1^83.23#tc1)) != 0));

function F#lambda#8(#l1: $map_t..^^u8.^^bool, #l0: $map_t..^^u8.^^bool) : $map_t..^^u8.^^bool;

const unique cf#lambda#8: $pure_function;

axiom $function_arg_type(cf#lambda#8, 0, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#lambda#8, 1, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#lambda#8, 2, $map_t(^^u8, ^^bool));

procedure lambda#8(#l1: $map_t..^^u8.^^bool, #l0: $map_t..^^u8.^^bool) returns ($result: $map_t..^^u8.^^bool);
  free ensures $result == F#lambda#8(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^52.38#tc1: int, #l1: $map_t..^^u8.^^bool, #l0: $map_t..^^u8.^^bool :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#lambda#8(#l1, #l0), Q#i$1^52.38#tc1) } $in_range_u8(Q#i$1^52.38#tc1) ==> $select.$map_t..^^u8.^^bool(F#lambda#8(#l1, #l0), Q#i$1^52.38#tc1) == (Q#i$1^52.38#tc1 < 32 ==> !($select.$map_t..^^u8.^^bool(#l0, Q#i$1^52.38#tc1) == $select.$map_t..^^u8.^^bool(#l1, Q#i$1^52.38#tc1))));

function F#lambda#7(#l1: $map_t..^^u8.^^bool, #l0: $map_t..^^u8.^^bool) : $map_t..^^u8.^^bool;

const unique cf#lambda#7: $pure_function;

axiom $function_arg_type(cf#lambda#7, 0, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#lambda#7, 1, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#lambda#7, 2, $map_t(^^u8, ^^bool));

procedure lambda#7(#l1: $map_t..^^u8.^^bool, #l0: $map_t..^^u8.^^bool) returns ($result: $map_t..^^u8.^^bool);
  free ensures $result == F#lambda#7(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^47.38#tc1: int, #l1: $map_t..^^u8.^^bool, #l0: $map_t..^^u8.^^bool :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#lambda#7(#l1, #l0), Q#i$1^47.38#tc1) } $in_range_u8(Q#i$1^47.38#tc1) ==> $select.$map_t..^^u8.^^bool(F#lambda#7(#l1, #l0), Q#i$1^47.38#tc1) == (Q#i$1^47.38#tc1 < 64 ==> !($select.$map_t..^^u8.^^bool(#l0, Q#i$1^47.38#tc1) == $select.$map_t..^^u8.^^bool(#l1, Q#i$1^47.38#tc1))));

function F#lambda#6(#l1: $map_t..^^u8.^^bool, #l0: $map_t..^^u8.^^bool) : $map_t..^^u8.^^bool;

const unique cf#lambda#6: $pure_function;

axiom $function_arg_type(cf#lambda#6, 0, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#lambda#6, 1, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#lambda#6, 2, $map_t(^^u8, ^^bool));

procedure lambda#6(#l1: $map_t..^^u8.^^bool, #l0: $map_t..^^u8.^^bool) returns ($result: $map_t..^^u8.^^bool);
  free ensures $result == F#lambda#6(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^42.38#tc1: int, #l1: $map_t..^^u8.^^bool, #l0: $map_t..^^u8.^^bool :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#lambda#6(#l1, #l0), Q#i$1^42.38#tc1) } $in_range_u8(Q#i$1^42.38#tc1) ==> $select.$map_t..^^u8.^^bool(F#lambda#6(#l1, #l0), Q#i$1^42.38#tc1) == (Q#i$1^42.38#tc1 < 32 ==> $select.$map_t..^^u8.^^bool(#l0, Q#i$1^42.38#tc1) && $select.$map_t..^^u8.^^bool(#l1, Q#i$1^42.38#tc1)));

function F#lambda#5(#l1: $map_t..^^u8.^^bool, #l0: $map_t..^^u8.^^bool) : $map_t..^^u8.^^bool;

const unique cf#lambda#5: $pure_function;

axiom $function_arg_type(cf#lambda#5, 0, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#lambda#5, 1, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#lambda#5, 2, $map_t(^^u8, ^^bool));

procedure lambda#5(#l1: $map_t..^^u8.^^bool, #l0: $map_t..^^u8.^^bool) returns ($result: $map_t..^^u8.^^bool);
  free ensures $result == F#lambda#5(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^37.38#tc1: int, #l1: $map_t..^^u8.^^bool, #l0: $map_t..^^u8.^^bool :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#lambda#5(#l1, #l0), Q#i$1^37.38#tc1) } $in_range_u8(Q#i$1^37.38#tc1) ==> $select.$map_t..^^u8.^^bool(F#lambda#5(#l1, #l0), Q#i$1^37.38#tc1) == (Q#i$1^37.38#tc1 < 64 ==> $select.$map_t..^^u8.^^bool(#l0, Q#i$1^37.38#tc1) && $select.$map_t..^^u8.^^bool(#l1, Q#i$1^37.38#tc1)));

function F#lambda#4(#l1: $map_t..^^u8.^^bool, #l0: $map_t..^^u8.^^bool) : $map_t..^^u8.^^bool;

const unique cf#lambda#4: $pure_function;

axiom $function_arg_type(cf#lambda#4, 0, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#lambda#4, 1, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#lambda#4, 2, $map_t(^^u8, ^^bool));

procedure lambda#4(#l1: $map_t..^^u8.^^bool, #l0: $map_t..^^u8.^^bool) returns ($result: $map_t..^^u8.^^bool);
  free ensures $result == F#lambda#4(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^32.38#tc1: int, #l1: $map_t..^^u8.^^bool, #l0: $map_t..^^u8.^^bool :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#lambda#4(#l1, #l0), Q#i$1^32.38#tc1) } $in_range_u8(Q#i$1^32.38#tc1) ==> $select.$map_t..^^u8.^^bool(F#lambda#4(#l1, #l0), Q#i$1^32.38#tc1) == (Q#i$1^32.38#tc1 < 32 ==> $select.$map_t..^^u8.^^bool(#l0, Q#i$1^32.38#tc1) || $select.$map_t..^^u8.^^bool(#l1, Q#i$1^32.38#tc1)));

function F#lambda#3(#l1: $map_t..^^u8.^^bool, #l0: $map_t..^^u8.^^bool) : $map_t..^^u8.^^bool;

const unique cf#lambda#3: $pure_function;

axiom $function_arg_type(cf#lambda#3, 0, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#lambda#3, 1, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#lambda#3, 2, $map_t(^^u8, ^^bool));

procedure lambda#3(#l1: $map_t..^^u8.^^bool, #l0: $map_t..^^u8.^^bool) returns ($result: $map_t..^^u8.^^bool);
  free ensures $result == F#lambda#3(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#i$1^27.38#tc1: int, #l1: $map_t..^^u8.^^bool, #l0: $map_t..^^u8.^^bool :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#lambda#3(#l1, #l0), Q#i$1^27.38#tc1) } $in_range_u8(Q#i$1^27.38#tc1) ==> $select.$map_t..^^u8.^^bool(F#lambda#3(#l1, #l0), Q#i$1^27.38#tc1) == (Q#i$1^27.38#tc1 < 64 ==> $select.$map_t..^^u8.^^bool(#l0, Q#i$1^27.38#tc1) || $select.$map_t..^^u8.^^bool(#l1, Q#i$1^27.38#tc1)));

function F#lambda#2(#l0: int) : $map_t..^^u8.^^bool;

const unique cf#lambda#2: $pure_function;

axiom $function_arg_type(cf#lambda#2, 0, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#lambda#2, 1, ^^u8);

procedure lambda#2(#l0: int) returns ($result: $map_t..^^u8.^^bool);
  free ensures $result == F#lambda#2(#l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#j$1^22.111#tc1: int, #l0: int :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#lambda#2(#l0), Q#j$1^22.111#tc1) } $in_range_u8(Q#j$1^22.111#tc1) && $in_range_u8(#l0) ==> $select.$map_t..^^u8.^^bool(F#lambda#2(#l0), Q#j$1^22.111#tc1) == (Q#j$1^22.111#tc1 == #l0));

function F#lambda#1(#l0: int) : $map_t..^^u8.^^bool;

const unique cf#lambda#1: $pure_function;

axiom $function_arg_type(cf#lambda#1, 0, $map_t(^^u8, ^^bool));

axiom $function_arg_type(cf#lambda#1, 1, ^^u8);

procedure lambda#1(#l0: int) returns ($result: $map_t..^^u8.^^bool);
  free ensures $result == F#lambda#1(#l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#j$1^18.111#tc1: int, #l0: int :: {:weight 10} { $select.$map_t..^^u8.^^bool(F#lambda#1(#l0), Q#j$1^18.111#tc1) } $in_range_u8(Q#j$1^18.111#tc1) && $in_range_u8(#l0) ==> $select.$map_t..^^u8.^^bool(F#lambda#1(#l0), Q#j$1^18.111#tc1) == (Q#j$1^18.111#tc1 == #l0));

const unique l#public: $label;

type $map_t..^^u8.^^bool;

function $select.$map_t..^^u8.^^bool(M: $map_t..^^u8.^^bool, p: int) : bool;

function $store.$map_t..^^u8.^^bool(M: $map_t..^^u8.^^bool, p: int, v: bool) : $map_t..^^u8.^^bool;

function $eq.$map_t..^^u8.^^bool(M1: $map_t..^^u8.^^bool, M2: $map_t..^^u8.^^bool) : bool;

const $zero.$map_t..^^u8.^^bool: $map_t..^^u8.^^bool;

axiom (forall M: $map_t..^^u8.^^bool, p: int, v: bool :: true);

axiom (forall M: $map_t..^^u8.^^bool, p: int, v: bool, q: int :: $select.$map_t..^^u8.^^bool($store.$map_t..^^u8.^^bool(M, q, v), p) == (if $unchecked(^^u8, p) == $unchecked(^^u8, q) then v else $select.$map_t..^^u8.^^bool(M, p)));

axiom (forall M1: $map_t..^^u8.^^bool, M2: $map_t..^^u8.^^bool :: { $eq.$map_t..^^u8.^^bool(M1, M2) } (forall p: int :: $select.$map_t..^^u8.^^bool(M1, $unchecked(^^u8, p)) == $select.$map_t..^^u8.^^bool(M2, $unchecked(^^u8, p))) ==> $eq.$map_t..^^u8.^^bool(M1, M2));

axiom (forall M1: $map_t..^^u8.^^bool, M2: $map_t..^^u8.^^bool :: { $eq.$map_t..^^u8.^^bool(M1, M2) } $eq.$map_t..^^u8.^^bool(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^u8.^^bool(0) == $zero.$map_t..^^u8.^^bool;

axiom (forall p: int :: $select.$map_t..^^u8.^^bool($zero.$map_t..^^u8.^^bool, p) == false);

axiom true;

const unique #tok$1^18.111: $token;

const unique #tok$1^22.111: $token;

const unique #tok$1^27.38: $token;

const unique #tok$1^32.38: $token;

const unique #tok$1^37.38: $token;

const unique #tok$1^42.38: $token;

const unique #tok$1^47.38: $token;

const unique #loc.#l0: $token;

const unique #loc.#l1: $token;

const unique #tok$1^52.38: $token;

axiom $type_code_is(2, ^^u4);

const unique #tok$1^183.3: $token;

const unique #tok$1^181.19: $token;

const unique #loc.prestate#11: $token;

function $state_to_int(x: $state) : int;

function $int_to_state(x: int) : $state;

axiom (forall #x: $state :: #x == $int_to_state($state_to_int(#x)));

const unique #loc.prestate#9: $token;

const unique #loc.owns#10: $token;

const unique #tok$2^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(2, #file^?3Cno?20file?3E);

const unique #distTp2: $ctype;

axiom #distTp2 == $ptr_to(^_toto);

const unique #loc.ob: $token;

const unique #tok$1^175.1: $token;

const unique #tok$1^160.3: $token;

const unique #tok$1^161.3: $token;

const unique #tok$1^159.1: $token;

const unique #loc.one: $token;

const unique #tok$1^148.3: $token;

const unique #loc.ft: $token;

const unique #tok$1^149.3: $token;

const unique #tok$1^147.1: $token;

const unique #tok$1^138.3: $token;

const unique #tok$1^137.1: $token;

axiom $type_code_is(1, ^^u8);

const unique #loc.zero: $token;

const unique #loc.all: $token;

const unique #tok$1^128.3: $token;

const unique #tok$1^127.1: $token;

const unique #tok$1^120.1: $token;

const unique #tok$1^113.1: $token;

const unique #tok$1^106.1: $token;

const unique #tok$1^99.1: $token;

const unique #tok$1^92.1: $token;

const unique #loc.x: $token;

const unique #tok$1^85.1: $token;

const unique #tok$1^61.39: $token;

const unique #loc.bm: $token;

const unique #tok$1^56.39: $token;

const unique #tok$1^51.39: $token;

const unique #tok$1^46.39: $token;

const unique #tok$1^41.39: $token;

const unique #tok$1^36.39: $token;

const unique #tok$1^31.39: $token;

const unique #loc.bm2: $token;

function $map_t..^^u8.^^bool_to_int(x: $map_t..^^u8.^^bool) : int;

function $int_to_map_t..^^u8.^^bool(x: int) : $map_t..^^u8.^^bool;

axiom (forall #x: $map_t..^^u8.^^bool :: #x == $int_to_map_t..^^u8.^^bool($map_t..^^u8.^^bool_to_int(#x)));

const unique #loc.bm1: $token;

const unique #tok$1^26.39: $token;

const unique #tok$1^22.39: $token;

const unique #loc.i: $token;

const unique #tok$1^18.39: $token;

const unique #tok$1^14.39: $token;

const unique #loc.n: $token;

const unique #tok$1^10.39: $token;

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CBitMap.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cexamples3?5CBitMap.c);

const unique #distTp1: $ctype;

axiom #distTp1 == $map_t(^^u8, ^^bool);
