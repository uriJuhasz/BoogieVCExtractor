
// Copyright (c) 2008, Microsoft

type Field a;
type HeapType = <a>[ref,Field a]a;
type MaskType = <a>[ref,Field a][PermissionComponent]int;
type CreditsType = [ref]int;
type ref;
const null: ref;

var Heap: HeapType;

type PermissionComponent;
const unique perm$R: PermissionComponent;
const unique perm$N: PermissionComponent;
var Mask: MaskType where IsGoodMask(Mask);
const Permission$denominator: int;
axiom Permission$denominator > 0;
const Permission$FullFraction: int;
const Permission$Zero: [PermissionComponent]int;
axiom Permission$Zero[perm$R] == 0 && Permission$Zero[perm$N] == 0;
const Permission$Full: [PermissionComponent]int;
axiom Permission$Full[perm$R] == Permission$FullFraction && Permission$Full[perm$N] == 0;
const ZeroMask: MaskType;
axiom (forall<T> o: ref, f: Field T, pc: PermissionComponent :: ZeroMask[o,f][pc] == 0);
axiom IsGoodMask(ZeroMask);
const unique joinable: Field int;
axiom NonPredicateField(joinable);
const unique token#t: TypeName;
const unique forkK: Field int;
axiom NonPredicateField(forkK);
const channelK: int;
const monitorK: int;
const predicateK: int;

function Fractions(n: int) returns (int)
{
  n * Permission$denominator
}
axiom (forall x,y: int :: 0 <= x && x <= y ==> Fractions(x) <= Fractions(y));

axiom Permission$FullFraction  == Fractions(100);
axiom 0 < channelK && 1000*channelK < Fractions(1);
axiom 0 < monitorK && 1000*monitorK < Fractions(1);
axiom 0 < predicateK && 1000*predicateK < Fractions(1);
axiom predicateK == channelK && channelK == monitorK;

var Credits: CreditsType;

function IsGoodState<T>(T) returns (bool);
function combine<T,U>(T, U) returns (T);
const nostate: HeapType;

axiom (forall<T,U> a: T, b: U :: {IsGoodState(combine(a, b))} IsGoodState(combine(a, b)) <==> IsGoodState(a) && IsGoodState(b));
axiom IsGoodState(nostate);

type ModuleName;
const CurrentModule: ModuleName;
type TypeName;
function dtype(ref) returns (TypeName);
const CanAssumeFunctionDefs: bool;

type Mu;
const unique mu: Field Mu;
axiom NonPredicateField(mu);
function MuBelow(Mu, Mu) returns (bool);  // strict partial order
axiom (forall m: Mu, n: Mu ::
  { MuBelow(m,n), MuBelow(n,m) }
  !(MuBelow(m,n) && MuBelow(n,m)));
axiom (forall m: Mu, n: Mu, o: Mu ::
  { MuBelow(m,n), MuBelow(n,o) }
  MuBelow(m,n) && MuBelow(n,o) ==> MuBelow(m,o));
const $LockBottom: Mu;
axiom (forall m, n: Mu :: MuBelow(m, n) ==> n != $LockBottom);

const unique held: Field int;
function Acquire$Heap(int) returns (HeapType);
function Acquire$Mask(int) returns (MaskType);
function Acquire$Credits(int) returns (CreditsType);
axiom NonPredicateField(held);

function LastSeen$Heap(Mu, int) returns (HeapType);
function LastSeen$Mask(Mu, int) returns (MaskType);
function LastSeen$Credits(Mu, int) returns (CreditsType);

const unique rdheld: Field bool;
axiom NonPredicateField(rdheld);
function wf(h: HeapType, m: MaskType) returns (bool);

function IsGoodInhaleState(ih: HeapType, h: HeapType,
                           m: MaskType) returns (bool)
{
  (forall<T> o: ref, f: Field T :: { ih[o, f] }  CanRead(m, o, f) ==> ih[o, f] == h[o, f]) &&
  (forall o: ref :: { ih[o, held] }  (0<ih[o, held]) == (0<h[o, held])) &&
  (forall o: ref :: { ih[o, rdheld] }  ih[o, rdheld] == h[o, rdheld]) &&
  (forall o: ref :: { h[o, held] }  (0<h[o, held]) ==> ih[o, mu] == h[o, mu]) &&
  (forall o: ref :: { h[o, rdheld] }  h[o, rdheld] ==> ih[o, mu] == h[o, mu])
}

// ---------------------------------------------------------------
// -- Permissions ------------------------------------------------
// ---------------------------------------------------------------

function {:expand false} CanRead<T>(m: MaskType, obj: ref, f: Field T) returns (bool)
{
  0 < m[obj,f][perm$R] || 0 < m[obj,f][perm$N]
}
function {:expand false} CanWrite<T>(m: MaskType, obj: ref, f: Field T) returns (bool)
{
  m[obj,f][perm$R] == Permission$FullFraction && m[obj,f][perm$N] == 0
}
function {:expand true} IsGoodMask(m: MaskType) returns (bool)
{
  (forall<T> o: ref, f: Field T ::
      0 <= m[o,f][perm$R] && 
      (NonPredicateField(f) ==> 
        (m[o,f][perm$R]<=Permission$FullFraction &&
        (0 < m[o,f][perm$N] ==> m[o,f][perm$R] < Permission$FullFraction))) &&
      (m[o,f][perm$N] < 0 ==> 0 < m[o,f][perm$R]))
}

axiom (forall h: HeapType, m: MaskType, o: ref, q: ref :: {wf(h, m), h[o, mu], h[q, mu]} wf(h, m) && o!=q && (0 < h[o, held] || h[o, rdheld]) && (0 < h[q, held] || h[q, rdheld]) ==> h[o, mu] != h[q, mu]);

function DecPerm<T>(m: MaskType, o: ref, f: Field T, howMuch: int) returns (MaskType);

axiom (forall<T,U> m: MaskType, o: ref, f: Field T, howMuch: int, q: ref, g: Field U :: {DecPerm(m, o, f, howMuch)[q, g][perm$R]}
      DecPerm(m, o, f, howMuch)[q, g][perm$R] == ite(o==q && f ==g, m[q, g][perm$R] - howMuch, m[q, g][perm$R])
);

function DecEpsilons<T>(m: MaskType, o: ref, f: Field T, howMuch: int) returns (MaskType);

axiom (forall<T,U> m: MaskType, o: ref, f: Field T, howMuch: int, q: ref, g: Field U :: {DecPerm(m, o, f, howMuch)[q, g][perm$N]}
         DecEpsilons(m, o, f, howMuch)[q, g][perm$N] == ite(o==q && f ==g, m[q, g][perm$N] - howMuch, m[q, g][perm$N])
);

function IncPerm<T>(m: MaskType, o: ref, f: Field T, howMuch: int) returns (MaskType);

axiom (forall<T,U> m: MaskType, o: ref, f: Field T, howMuch: int, q: ref, g: Field U :: {IncPerm(m, o, f, howMuch)[q, g][perm$R]}
         IncPerm(m, o, f, howMuch)[q, g][perm$R] == ite(o==q && f ==g, m[q, g][perm$R] + howMuch, m[q, g][perm$R])
);

function IncEpsilons<T>(m: MaskType, o: ref, f: Field T, howMuch: int) returns (MaskType);

axiom (forall<T,U> m: MaskType, o: ref, f: Field T, howMuch: int, q: ref, g: Field U :: {IncPerm(m, o, f, howMuch)[q, g][perm$N]}
         IncEpsilons(m, o, f, howMuch)[q, g][perm$N] == ite(o==q && f ==g, m[q, g][perm$N] + howMuch, m[q, g][perm$N])
);

function Havocing<T,U>(h: HeapType, o: ref, f: Field T, newValue: U) returns (HeapType);

axiom (forall<T,U> h: HeapType, o: ref, f: Field T, newValue: U, q: ref, g: Field U :: {Havocing(h, o, f, newValue)[q, g]}
         Havocing(h, o, f, newValue)[q, g] == ite(o==q && f ==g, newValue, h[q, g])
);

function Call$Heap(int) returns (HeapType);
function Call$Mask(int) returns (MaskType);
function Call$Credits(int) returns (CreditsType);
function Call$Args(int) returns (ArgSeq);
type ArgSeq = <T>[int]T;

function EmptyMask(m: MaskType) returns (bool);
axiom (forall m: MaskType :: {EmptyMask(m)} EmptyMask(m) <==> (forall<T> o: ref, f: Field T :: NonPredicateField(f) ==> m[o, f][perm$R]<=0 && m[o, f][perm$N]<=0));

const ZeroCredits: CreditsType;
axiom (forall o: ref :: ZeroCredits[o] == 0);
function EmptyCredits(c: CreditsType) returns (bool);
axiom (forall c: CreditsType :: {EmptyCredits(c)} EmptyCredits(c) <==> (forall o: ref :: o != null ==> c[o] == 0));

function NonPredicateField<T>(f: Field T) returns (bool);
function PredicateField<T>(f: Field T) returns (bool);
axiom (forall<T> f: Field T :: NonPredicateField(f) ==> ! PredicateField(f));
axiom (forall<T> f: Field T :: PredicateField(f) ==> ! NonPredicateField(f));

function submask(m1: MaskType, m2: MaskType) returns (bool);

axiom (forall m1: MaskType, m2: MaskType :: {submask(m1, m2)}
  submask(m1, m2) <==> (forall<T> o: ref, f: Field T :: (m1[o, f][perm$R] < m2[o, f][perm$R]) || (m1[o, f][perm$R] == m2[o, f][perm$R] && m1[o, f][perm$N] <= m2[o, f][perm$N]))
);

// ---------------------------------------------------------------
// -- If then else -----------------------------------------------
// ---------------------------------------------------------------

function ite<T>(bool, T, T) returns (T);
axiom (forall<T> con: bool, a: T, b: T :: {ite(con, a, b)} con ==> ite(con, a, b) == a);
axiom (forall<T> con: bool, a: T, b: T :: {ite(con, a, b)} ! con ==> ite(con, a, b) == b);

// ---------------------------------------------------------------
// -- Arithmetic -------------------------------------------------
// ---------------------------------------------------------------

// the connection between % and /
axiom (forall x:int, y:int :: {x % y} {x / y}  x % y == x - x / y * y);

// sign of denominator determines sign of remainder
axiom (forall x:int, y:int :: {x % y}  0 < y  ==>  0 <= x % y  &&  x % y < y);
axiom (forall x:int, y:int :: {x % y}  y < 0  ==>  y < x % y  &&  x % y <= 0);

// the following axiom has some unfortunate matching, but it does state a property about % that
// is sometime useful
axiom (forall a: int, b: int, d: int :: { a % d, b % d } 2 <= d && a % d == b % d && a < b  ==>  a + d <= b);

// ---------------------------------------------------------------
// -- Strings ----------------------------------------------------
// ---------------------------------------------------------------

type string = int;

// ---------------------------------------------------------------
// -- End of prelude ---------------------------------------------
// ---------------------------------------------------------------

const unique C#t: TypeName;
const unique module#default: ModuleName;
procedure C$monitorinvariant$checkDefinedness(this: ref where (this == null) || (dtype(this) == C#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var methodK#_7: int;
  var h0#_0: HeapType;
  var m0#_1: MaskType;
  var c0#_2: CreditsType;
  var h1#_3: HeapType;
  var m1#_4: MaskType;
  var c1#_5: CreditsType;
  var lk#_6: ref;
  assume (0 < methodK#_7) && ((1000 * methodK#_7) < Fractions(1));
  assume wf(h0#_0, m0#_1);
  assume wf(h1#_3, m1#_4);
  m1#_4 := ZeroMask;
  c1#_5 := ZeroCredits;
  Mask := ZeroMask;
  Credits := ZeroCredits;
  havoc Heap;
  assert {:msg "  1.1: Monitor invariant is not allowed to contain debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
const unique C.next: Field (ref);
axiom NonPredicateField(C.next);
const unique C.v: Field (HeapType);
axiom PredicateField(C.v);
procedure C.v$checkDefinedness(this: ref where (this == null) || (dtype(this) == C#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var predicateK#_8: int;
  var inhaleHeap#_9: HeapType;
  var starK#_10: int;
  assume (0 < predicateK#_8) && ((1000 * predicateK#_8) < Fractions(1));
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (predicate definition)
  havoc inhaleHeap#_9;
  assume IsGoodInhaleState(inhaleHeap#_9, Heap, Mask);
  assume this != null;
  Heap[this, C.next] := inhaleHeap#_9[this, C.next];
  assume wf(Heap, Mask);
  assume (Heap[this, C.next] == null) || (dtype(Heap[this, C.next]) == C#t);
  assume Fractions(100) > 0;
  Mask[this, C.next] := Mask[this, C.next][perm$R := Mask[this, C.next][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_9[this, C.next]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_9, Mask);
  assert {:msg "  6.6: Receiver might be null."} true ==> (this != null);
  assert {:msg "  6.6: Location might not be readable."} true ==> CanRead(Mask, this, C.next);
  assume !(Heap[this, C.next] == null);
  assert {:msg "  7.10: Receiver might be null."} true ==> (this != null);
  assert {:msg "  7.10: Location might not be readable."} true ==> CanRead(Mask, this, C.next);
  assume Heap[this, C.next] != null;
  Heap[Heap[this, C.next], C.v] := inhaleHeap#_9[Heap[this, C.next], C.v];
  assume wf(Heap, Mask);
  assume inhaleHeap#_9[Heap[this, C.next], C.v] == Heap;
  assume starK#_10 > 0;
  assume starK#_10 > 0;
  Mask[Heap[this, C.next], C.v] := Mask[Heap[this, C.next], C.v][perm$R := Mask[Heap[this, C.next], C.v][perm$R] + starK#_10];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_9[Heap[this, C.next], C.v]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_9, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
procedure C.f$checkDefinedness(this: ref where (this == null) || (dtype(this) == C#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var methodK#_11: int;
  var inhaleHeap#_12: HeapType;
  var inhaleHeap#_13: HeapType;
  assume (0 < methodK#_11) && ((1000 * methodK#_11) < Fractions(1));
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  assume CanAssumeFunctionDefs;
  // inhale (precondition)
  havoc inhaleHeap#_12;
  assume IsGoodInhaleState(inhaleHeap#_12, Heap, Mask);
  assume this != null;
  Heap[this, C.v] := inhaleHeap#_12[this, C.v];
  assume wf(Heap, Mask);
  assume inhaleHeap#_12[this, C.v] == Heap;
  assume methodK#_11 > 0;
  Mask[this, C.v] := Mask[this, C.v][perm$R := Mask[this, C.v][perm$R] + methodK#_11];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_12[this, C.v]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_12, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // define initial state
  assume Heap == old(Heap);
  assume Mask == old(Mask);
  assume Credits == old(Credits);
  Mask := ZeroMask;
  Credits := ZeroCredits;
  havoc Heap;
  // inhale (postcondition)
  havoc inhaleHeap#_13;
  assume IsGoodInhaleState(inhaleHeap#_13, Heap, Mask);
  assume this != null;
  Heap[this, C.v] := inhaleHeap#_13[this, C.v];
  assume wf(Heap, Mask);
  assume inhaleHeap#_13[this, C.v] == Heap;
  assume methodK#_11 > 0;
  Mask[this, C.v] := Mask[this, C.v][perm$R := Mask[this, C.v][perm$R] + methodK#_11];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_13[this, C.v]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_13, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
procedure C.f(this: ref where (this == null) || (dtype(this) == C#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var methodK#_11: int;
  var inhaleHeap#_14: HeapType;
  var unfoldK#_15: int;
  var exhaleMask#_16: MaskType;
  var inhaleHeap#_18: HeapType;
  var starK#_19: int;
  var productK#_20: int;
  var methodCallK#_24: int;
  var this#0: ref where (this#0 == null) || (dtype(this#0) == C#t);
  var callHeap#_21: HeapType;
  var callMask#_22: MaskType;
  var callCredits#_23: CreditsType;
  var exhaleMask#_25: MaskType;
  var isHeld#_27: int;
  var isRdHeld#_28: bool;
  var inhaleHeap#_29: HeapType;
  var foldK#_30: int;
  var exhaleMask#_31: MaskType;
  var starK#_34: int;
  var productK#_35: int;
  var inhaleHeap#_36: HeapType;
  var exhaleMask#_37: MaskType;
  assume (0 < methodK#_11) && ((1000 * methodK#_11) < Fractions(1));
  assume CurrentModule == module#default;
  assume CanAssumeFunctionDefs;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (precondition)
  havoc inhaleHeap#_14;
  assume IsGoodInhaleState(inhaleHeap#_14, Heap, Mask);
  assume this != null;
  Heap[this, C.v] := inhaleHeap#_14[this, C.v];
  assume wf(Heap, Mask);
  assume inhaleHeap#_14[this, C.v] == Heap;
  assume methodK#_11 > 0;
  Mask[this, C.v] := Mask[this, C.v][perm$R := Mask[this, C.v][perm$R] + methodK#_11];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_14[this, C.v]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_14, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // define initial state
  assume Heap == old(Heap);
  assume Mask == old(Mask);
  assume Credits == old(Credits);
  // unfold
  assume (0 < unfoldK#_15) && (unfoldK#_15 < Fractions(1)) && ((1000 * unfoldK#_15) < methodK#_11);
  assert {:msg "  14.3: The target of the fold statement might be null."} this != null;
  // begin exhale (unfold)
  exhaleMask#_16 := Mask;
  assert {:msg "  14.3: unfold might fail because the predicate C.v does not hold. The permission at 14.10 might not be positive."} unfoldK#_15 > 0;
  assert {:msg "  14.3: unfold might fail because the predicate C.v does not hold. Insufficient fraction at 14.10 for C.v."} exhaleMask#_16[this, C.v][perm$R] > 0;
  assume unfoldK#_15 < exhaleMask#_16[this, C.v][perm$R];
  exhaleMask#_16[this, C.v] := exhaleMask#_16[this, C.v][perm$R := exhaleMask#_16[this, C.v][perm$R] - unfoldK#_15];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_16);
  Mask := exhaleMask#_16;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (unfold)
  inhaleHeap#_18 := Heap[this, C.v];
  assume IsGoodInhaleState(inhaleHeap#_18, Heap, Mask);
  assume this != null;
  Heap[this, C.next] := inhaleHeap#_18[this, C.next];
  assume wf(Heap, Mask);
  assume (Heap[this, C.next] == null) || (dtype(Heap[this, C.next]) == C#t);
  assume unfoldK#_15 > 0;
  Mask[this, C.next] := Mask[this, C.next][perm$R := Mask[this, C.next][perm$R] + unfoldK#_15];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_18[this, C.next]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_18, Mask);
  assume !(Heap[this, C.next] == null);
  assume Heap[this, C.next] != null;
  Heap[Heap[this, C.next], C.v] := inhaleHeap#_18[Heap[this, C.next], C.v];
  assume wf(Heap, Mask);
  assume inhaleHeap#_18[Heap[this, C.next], C.v] == Heap;
  assume starK#_19 > 0;
  assume (Fractions(100) * productK#_20) == (unfoldK#_15 * starK#_19);
  assume productK#_20 > 0;
  Mask[Heap[this, C.next], C.v] := Mask[Heap[this, C.next], C.v][perm$R := Mask[Heap[this, C.next], C.v][perm$R] + productK#_20];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_18[Heap[this, C.next], C.v]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_18, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  assume (0 < methodCallK#_24) && ((1000 * methodCallK#_24) < Fractions(1)) && ((1000 * methodCallK#_24) < methodK#_11);
  // call f
  callHeap#_21 := Heap;
  callMask#_22 := Mask;
  callCredits#_23 := Credits;
  assert {:msg "  15.8: Receiver might be null."} true ==> (this != null);
  assert {:msg "  15.8: Location might not be readable."} true ==> CanRead(Mask, this, C.next);
  assert {:msg "  15.3: The target of the method call might be null."} Heap[this, C.next] != null;
  this#0 := Heap[this, C.next];
  // begin exhale (precondition)
  exhaleMask#_25 := Mask;
  assert {:msg "  15.3: The precondition at 11.12 might not hold. The permission at 11.12 might not be positive."} methodCallK#_24 > 0;
  assert {:msg "  15.3: The precondition at 11.12 might not hold. Insufficient fraction at 11.12 for C.v."} exhaleMask#_25[this#0, C.v][perm$R] > 0;
  assume methodCallK#_24 < exhaleMask#_25[this#0, C.v][perm$R];
  exhaleMask#_25[this#0, C.v] := exhaleMask#_25[this#0, C.v][perm$R := exhaleMask#_25[this#0, C.v][perm$R] - methodCallK#_24];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_25);
  Mask := exhaleMask#_25;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (postcondition)
  havoc inhaleHeap#_29;
  assume IsGoodInhaleState(inhaleHeap#_29, Heap, Mask);
  assume this#0 != null;
  Heap[this#0, C.v] := inhaleHeap#_29[this#0, C.v];
  assume wf(Heap, Mask);
  assume inhaleHeap#_29[this#0, C.v] == Heap;
  assume methodCallK#_24 > 0;
  Mask[this#0, C.v] := Mask[this#0, C.v][perm$R := Mask[this#0, C.v][perm$R] + methodCallK#_24];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_29[this#0, C.v]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_29, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // fold
  assume (0 < foldK#_30) && ((1000 * foldK#_30) < Fractions(1)) && ((1000 * foldK#_30) < methodK#_11);
  assert {:msg "  16.3: The target of the fold statement might be null."} this != null;
  // begin exhale (fold)
  exhaleMask#_31 := Mask;
  assert {:msg "  16.3: Fold might fail because the definition of C.v does not hold. The permission at 5.6 might not be positive."} foldK#_30 > 0;
  assert {:msg "  16.3: Fold might fail because the definition of C.v does not hold. Insufficient fraction at 5.6 for C.next."} exhaleMask#_31[this, C.next][perm$R] > 0;
  assume foldK#_30 < exhaleMask#_31[this, C.next][perm$R];
  exhaleMask#_31[this, C.next] := exhaleMask#_31[this, C.next][perm$R := exhaleMask#_31[this, C.next][perm$R] - foldK#_30];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_31);
  assert {:msg "  16.3: Fold might fail because the definition of C.v does not hold. The expression at 6.6 might not evaluate to true."} !(Heap[this, C.next] == null);
  assume starK#_34 > 0;
  assume (Fractions(100) * productK#_35) == (foldK#_30 * starK#_34);
  assert {:msg "  16.3: Fold might fail because the definition of C.v does not hold. The permission at 7.6 might not be positive."} productK#_35 > 0;
  assert {:msg "  16.3: Fold might fail because the definition of C.v does not hold. Insufficient fraction at 7.6 for C.v."} exhaleMask#_31[Heap[this, C.next], C.v][perm$R] > 0;
  assume productK#_35 < exhaleMask#_31[Heap[this, C.next], C.v][perm$R];
  exhaleMask#_31[Heap[this, C.next], C.v] := exhaleMask#_31[Heap[this, C.next], C.v][perm$R := exhaleMask#_31[Heap[this, C.next], C.v][perm$R] - productK#_35];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_31);
  Mask := exhaleMask#_31;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (fold)
  havoc inhaleHeap#_36;
  assume IsGoodInhaleState(inhaleHeap#_36, Heap, Mask);
  assume this != null;
  Heap[this, C.v] := inhaleHeap#_36[this, C.v];
  assume wf(Heap, Mask);
  assume inhaleHeap#_36[this, C.v] == Heap;
  assume foldK#_30 > 0;
  Mask[this, C.v] := Mask[this, C.v][perm$R := Mask[this, C.v][perm$R] + foldK#_30];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_36[this, C.v]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_36, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  Heap[this, C.v] := Heap;
  assume wf(Heap, Mask);
  // begin exhale (postcondition)
  exhaleMask#_37 := Mask;
  assert {:msg "  10.2: The postcondition at 12.12 might not hold. The permission at 12.12 might not be positive."} methodK#_11 > 0;
  assert {:msg "  10.2: The postcondition at 12.12 might not hold. Insufficient fraction at 12.12 for C.v."} (methodK#_11 <= exhaleMask#_37[this, C.v][perm$R]) && ((methodK#_11 == exhaleMask#_37[this, C.v][perm$R]) ==> (0 <= exhaleMask#_37[this, C.v][perm$N]));
  exhaleMask#_37[this, C.v] := exhaleMask#_37[this, C.v][perm$R := exhaleMask#_37[this, C.v][perm$R] - methodK#_11];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_37);
  Mask := exhaleMask#_37;
  assume wf(Heap, Mask);
  // end exhale
  assert {:msg "  10.2: Method might lock/unlock more than allowed."} (forall lk#_39: ref :: {Heap[lk#_39, held]} {Heap[lk#_39, rdheld]} (((0 < Heap[lk#_39, held]) == (0 < old(Heap)[lk#_39, held])) && (Heap[lk#_39, rdheld] == old(Heap)[lk#_39, rdheld])) || false);
  assert {:msg "  10.2: Method body is not allowed to leave any debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
